provider "aws" {
  region = "ap-southeast-1"
}

variable "mylist" {
  type = list(number)
  default = [1,2,3,4,5,6,7,8,9]
}

variable "places" {
  type = list(string)
  default = ["blr", "hyd", "sin", "vtz", "rio"]
}

output "op_mylist" {
  value = var.mylist
}