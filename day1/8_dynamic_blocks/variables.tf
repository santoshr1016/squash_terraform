variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "internet" {
  default = "0.0.0.0/0"
}

# Service port is list of dictionary
variable "service_ports" {
  default = [
    {
      from_port = "22",
      to_port = "22"
    },
    {
      from_port = "8080",
      to_port = "8080"
    }
  ]
}

