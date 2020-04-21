variable "dhcp_options_domain_name_servers" {
  description = "Specify a list of DNS server addresses for DHCP options set, default to AWS provided"
  type        = "list"
  default     = ["AmazonProvidedDNS"]
}

variable "cidr" {
  description = ""
  default  = "10.30.0.0/16"
}

variable "azs" {
  description = ""
  type = "list"
  default = ["us-east-1b", "us-east-1c", "us-east-1d"]
}

variable "private_subnets" {
  description = ""
  type = "list"
  default = ["10.30.1.0/24", "10.30.2.0/24", "10.30.3.0/24"]
}

variable "public_subnets" {
  description = ""
  type = "list"
  default = ["10.30.11.0/24", "10.30.12.0/24", "10.30.13.0/24"]
}

variable "database_subnets" {
  description = ""
  type = "list"
  default = ["10.30.21.0/24", "10.30.22.0/24", "10.30.23.0/24"]
}

variable "env" {
  description = "Name of the Environment"
  default = "staging"
}
