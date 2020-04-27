### EKS-Variables
############################################################################
variable "EKS_Cluster_Name" {
  description = "EKS Cluster Name"
  default = "LR-K8S-Cluster"
  type    = "string"
}

## Output-Variables
############################################################################
variable "Public_SN_01_out_01" {
  #type = "list"
  description = "Module-vpcK8S-Public-SN-01-ID"
  default = ""
}

variable "Public_SN_02_out_02" {
  #type = "list"
  description = "Module-vpcK8S-Public-SN-02-ID"
  default = ""
}

variable "Public_SN_03_out_03" {
  #type = "list"
  description = "Module-vpcK8S-Public-SN-03-ID"
  default = ""
}

variable "Public_SG_out" {
  type = "list"
  description = "Module-vpcK8S-Public-SG-ID"
  default = []
}


variable "eks_ep_out" {
  description = "Module-EKS-EndPoint"
  default = ""
}

variable "eks_ca_data_out" {
  description = "Module-EKS-CA-Data"
  default = ""
}

variable "vpc_id_output" {
  description = "Module-vpcK8S-ID"
  default = ""
}

variable "eks_sg_out" {
  description = "Module-EKS-Security-Group-ID"
  default = ""
}

## Variable Region
variable "region" {
  description = "AWS-Region-US-east"
  default     = "us-east-1"
}

## Variable AMI
variable "ami" {
  description = "AWS-AMI's per Region"
  type        = "map"

  default = {
    us-east-1 = "ami-14c5486b"
    us-west-2 = "ami-e251209a"
  }
}