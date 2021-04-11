variable "vpc" {
  description = "Name of the VPC"
  default = "Toki-k8s-VPC"
}

variable "cidr" {
  description = "The CIDR of the VPC."
  default     = "172.16.0.0/16"
}

variable "public_subnet_1" {
  description = "The public subnet to create."
  default     = "172.16.4.0/24"
}
variable "public_subnet_2" {
  description = "The public subnet to create."
  default     = "172.16.5.0/24"
}
variable "public_subnet_3" {
  description = "The public subnet to create."
  default     = "172.16.6.0/24"
}

variable "private_subnet_1" {
  description = "The private subnet to create."
  default     = "172.16.1.0/24"
}

variable "private_subnet_2" {
  description = "The private subnet to create."
  default     = "172.16.2.0/24"
}

variable "private_subnet_3" {
  description = "The private subnet to create."
  default     = "172.16.3.0/24"
}

data "aws_availability_zones" "available" {
}

locals {
  cluster_name = "toki-k8s"
}
