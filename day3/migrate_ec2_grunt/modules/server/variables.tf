variable "env" {}

variable "vpc_id" {}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  type = string
  default = "cfn-key1"
}

variable "public_subnets" {
  type = list(string)
  default = []
}
