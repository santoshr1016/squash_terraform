locals {
  service_name = "forum"
  owner        = "Community Team"
}

locals {
  # Ids for multiple sets of EC2 instances, merged together
  instance_ids = concat(["Santosh", "say", "K8S", "is", "Awesome"])
}

locals {
  # Common tags to be assigned to all resources
  common_tags = {
    Service = local.service_name
    Owner   = local.owner
  }
}

output "local1" {
  value = local.service_name
}

output "local2" {
  value = local.instance_ids
}
output "local3" {
  value = local.common_tags.Service
}

output "local4" {
  value = local.common_tags.Owner
}