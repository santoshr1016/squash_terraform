## Variable Region
variable "region" {
  description = "AWS-Region"
  default     = "us-east-1"
}
provider "aws" {
  region = var.region
}