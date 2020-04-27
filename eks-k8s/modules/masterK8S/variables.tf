############################################################################
## Output-Variables
############################################################################
variable "Public_SN_01_out_01" {
  #type = "list"
  description = "Module-VPC-Public-SN-01-ID"
  default = ""
}

variable "Public_SN_02_out_02" {
  #type = "list"
  description = "Module-VPC-Public-SN-02-ID"
  default = ""
}

variable "Public_SN_03_out_03" {
  #type = "list"
  description = "Module-VPC-Public-SN-03-ID"
  default = ""
}

variable "Public_SG_out" {
  type = "list"
  description = "Module-VPC-Public-SG-ID"
  default = []
}

variable "vpc_id_output" {
  description = "Module-VPC-ID"
  default = ""
}


############################################################################
### EKS-Variables
############################################################################
variable "EKS_Cluster_Name" {
  description = "EKS Cluster Name"
  default = "LR-K8S-Cluster"
  type    = "string"
}