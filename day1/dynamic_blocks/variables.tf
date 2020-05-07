variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "internet" {
  default = "0.0.0.0/0"
}

variable "service_ports" {
  default = ["22", "9090"]
}

