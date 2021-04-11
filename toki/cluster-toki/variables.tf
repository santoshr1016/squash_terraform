data "aws_availability_zones" "available" {
}

variable "cluster_version" {
  description = "EKS CLuster Version"
  default = "1.17"
}

variable "irsa_assumed_role_name" {
  description = "EKS CLuster Version"
  default = "toki-role"
}