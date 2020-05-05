locals {
  ess_project = {
    project_id       = data.terraform_remote_state.projects.outputs.project-test-qarc-ess.project_id
    subnetwork_link  = data.terraform_remote_state.networks.outputs.qarc-test-shared-subnet-europe-west2.self_link
    dns_managed_zone = data.terraform_remote_state.networks.outputs.dns-private-zone-teste-ess-int.name
    service_account = {
      email  = data.terraform_remote_state.serviceaccounts.outputs.sa-vm-test-conn-ess.email
      scopes = ["storage-ro"]
    }
    labels = {
      team    = "infra"
      service = "frontend"
    }
  }
}

variable "az_name" {}

#compute/vm/qarc-haproxy.tf
# haproxy zone a
module "test-gcp-haproxy-euwest2a" {
  source          = "../modules/computevm"
  version         = "1.1.12"
  name            = "rc-gcp-haproxy-euwest2a"
  replicas        = 1
  tags            = ["tests"]
  zones = var.az_name
  env_settings    = merge(local.env_settings,{zone = var.az_name })
  project_settings = local.ess_project
}