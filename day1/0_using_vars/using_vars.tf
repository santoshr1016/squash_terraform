# setting in command line
# terraform apply --var env_type=dev --var queue_name=my-queue

# setting using ENV variable
# env TF_VAR_env_type=dev TF_VAR_queue_name=my-updated-queue terraform apply

# setting using file
# To be picked up by terraform automatically use
# XXXXXXXXXX.auto.tfvars
# just run terraform apply
provider "aws" {
  region = "us-east-1"
}

variable "tag_map" {
  type = map(string)
  default = {
    dev = "dev-queue",
    test = "test-queue",
    prod = "prod-queue"
  }
}

variable "zone_name" {
  default = "helsinki1"
}
variable "zones" {
    type = map(string)
    default = {
        "amsterdam" = "nl-ams1"
        "london"    = "uk-lon1"
        "frankfurt" = "de-fra1"
        "helsinki1" = "fi-hel1"
        "helsinki2" = "fi-hel2"
        "chicago"   = "us-chi1"
        "sanjose"   = "us-sjo1"
        "singapore" = "sg-sin1"
    }
}
output "zone" {
  value = var.zones["sanjose"]
}

output "zone_lookup" {
  value = lookup(var.zones, var.zone_name)
}

variable "templates" {
    type = map(string)
    default = {
        "ubuntu18" = "01000000-0000-4000-8000-000030080200"
        "centos7"  = "01000000-0000-4000-8000-000050010300"
        "debian9"  = "01000000-0000-4000-8000-000020040100"
    }
}

variable "plans" {
    type = map(string)
    default = {
        "5USD"   = "1xCPU-1GB"
        "10uSD"  = "1xCPU-2GB"
        "20USD"  = "2xCPU-4GB"
    }
}

variable "env_type" {}
variable "queue_name" {}

resource "aws_sqs_queue" "queue" {
  name = var.queue_name

  tags = {
    environment_type = lookup(var.tag_map, var.env_type)
  }
}

/*
By terraform console you can check all the variables and their interpolation
Set the environamnent variable by

export TF_VAR_queue_name=santosh
export TF_VAR_env_type=test

run terraform console
then verify
lookup(var.tag_map, var.env_type)
lookup(var.tag_map, var.env_type)
var.zones["sanjose"]
var.templates["centos7"]
lookup(var.templates, "centos7")

*/