provider "aws" {
  region = "ap-southeast-1"
}

variable "list1" {
  type = list(string)
  default = [11, 22, 33, 44, 55, 66, 77, 88]
}

variable "list2" {
  type = list(string)
  default = ["apple", "pear", "banana", "mango"]
}

variable "map1" {
  type = map(number)
  default = {
   "apple" = 111
   "pear" = 222
   "banana" = 333
   "mango" = 444
  }
}

variable "aws_region" {
  type    = string
  default = "ap-southeast-1"
}
variable "project_tags" {
  type          = map(string)
  default       = {
    Component   = "Frontend"
    Environment = "Production"
  }
}

resource "null_resource" "cluster" {
  availability_zone = "ap-southeast-1a"
  size              = 8

  tags = {for k, v in merge({ Name = "Myvolume" }, var.project_tags): k => lower(v)}
}

output "out" {
  value = null_resource.cluster.tags
}