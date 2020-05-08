variable "dev_vpc_cidr" {
  description = "The CIDR of the VPC."
  default     = "10.1.0.0/16"
}
variable "dev_pub_sn" {
  description = "The public subnet to create."
  default     = "10.1.1.0/24"
}

variable "qa_vpc_cidr" {
  description = "The CIDR of the VPC."
  default     = "10.2.0.0/16"
}
variable "qa_pub_sn" {
  description = "The public subnet to create."
  default     = "10.2.1.0/24"
}

variable "shared_vpc_cidr" {
  description = "The CIDR of the VPC."
  default     = "10.3.0.0/16"
}
variable "shared_pub_sn" {
  description = "The public subnet to create."
  default     = "10.3.1.0/24"
}

variable "cross_zone_vpc_cidr" {
  description = "The CIDR of the VPC."
  default     = "10.4.0.0/16"
}
variable "cross_zone_pub_sn" {
  description = "The public subnet to create."
  default     = "10.4.1.0/24"
}


## Region AZ Public Subnet
variable "region_az_sn" {
  description   = "AWS-Region-AZ-Public-Subnet"
  type		= map(string)
  default       = {
    "10.1.1.0/24" = "ap-southeast-1a"
    "10.2.1.0/24" = "ap-southeast-1b"
    "10.3.1.0/24" = "ap-southeast-1c"
    "10.4.1.0/24" = "ap-southeast-1a"
  }
}

