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
  type = "map"
  default = {
    dev = "dev-queue",
    test = "test-queue",
    prod = "prod-queue"
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