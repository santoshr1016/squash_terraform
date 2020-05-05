locals {
  env_settings = {
    puppet_environment   = var.chef_environment
    puppet_master        = var.chefmaster
    region               = var.region
    env_bootstrap_script = var.script
    labels = {
      business_unit = "testing"
    }
  }
}



variable "boot_disk_image" {
 default = "https://www.googleapis.com/compute/v1/projects/ubuntu-os-cloud/global/images/ubuntu-1804-bionic-v20200317"
}

variable "chefmaster" {
  default = "qa-chef.test-internal.com"
}

variable "chef_environment" {
  default = "rc"
}


variable "region" {
  type    = string
  default = "europe-west2"
}
