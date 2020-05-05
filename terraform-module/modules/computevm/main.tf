locals {
  labels             = merge(var.env_settings.labels, var.project_settings.labels, var.extra_labels)
  is_prod            = var.env_settings.chef_master == "prod-host.domain-internal.com"
  boot_disk_image    = var.boot_disk_image != "" ? var.boot_disk_image : format("projects/gcp-project-id/global/images/family/common-%s", local.is_prod ? "production" : "qa")
  startup_script_url = var.startup_script_url != "" ? var.startup_script_url : local.is_prod ? "gs://bucket_est/prod-bootstrap/startup.sh" : "gs://test_bucket/qa-bootstrap/startup.sh"
}

resource "google_compute_disk" "node" {
  count   = var.attach_disk ? var.replicas : 0
  project = var.project_settings.project_id
  name    = format("%s%02d-disk", var.name, count.index + 1)
  zone    = var.env_settings.zones
  size    = var.attached_disk_size
  type    = var.attached_disk_type
  labels  = local.labels
}

resource "google_compute_disk" "node_boot" {
  count   = var.replicas
  project = var.project_settings.project_id
  name    = format("%s%02d-boot", var.name, count.index + 1)
  zone    = element(var.env_settings.zones, count.index % length(var.env_settings.zones))
  size    = var.boot_disk_size
  image   = local.boot_disk_image
  type    = var.boot_disk_type
  labels  = local.labels
}

resource "google_compute_address" "node" {
  count   = var.add_external_ip == true ? var.replicas : 0
  project = var.project_settings.project_id
  region  = var.env_settings.region
  name    = format("%s%02d", var.name, count.index + 1)
}

resource "google_compute_instance" "node" {
  count                     = var.replicas
  project                   = var.project_settings.project_id
  name                      = format("%s%02d", var.name, count.index + 1)
  machine_type              = var.machine_type
  allow_stopping_for_update = true
  zone                      = element(var.env_settings.zones, count.index % length(var.env_settings.zones))
  tags                      = var.tags
  deletion_protection       = var.deletion_protection
  can_ip_forward = var.can_ip_forward

  lifecycle {
    ignore_changes = [boot_disk]
  }

  boot_disk {
    source = google_compute_disk.node_boot[count.index].self_link
  }

  dynamic "attached_disk" {
    iterator = disk
    // if we do not add node disks then this will be an empty list
    for_each = [for d in google_compute_disk.node.* : d if d.name == format("%s%02d-disk", var.name, count.index + 1)]
    content {
      source      = disk.value.self_link
      device_name = var.attached_disk_device_name != "" ? var.attached_disk_device_name : format("%s-opt", var.name)
    }
  }

  network_interface {
    subnetwork = var.project_settings.subnetwork_link
    dynamic "access_config" {
      iterator = ip
      for_each = [for ip in google_compute_address.node.* : ip if ip.name == format("%s%02d", var.name, count.index + 1)]
      content {
        nat_ip = ip.value.address
      }
    }
  }

  dynamic "service_account" {
    for_each = concat([var.project_settings.service_account], var.additional_service_accounts)
    iterator = service_account
    content {
      email  = lookup(service_account.value, "email", null)
      scopes = lookup(service_account.value, "scopes", null)
    }
  }

  metadata = {
    chef_master      = var.env_settings.chef_master
    chef_environment = var.env_settings.chef_environment
    startup-script-url = local.startup_script_url
    manage_disks       = var.attach_disk
    test_pod         = var.pod
  }

  labels = local.labels
}
