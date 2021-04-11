module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.75.0"

  name                 = var.vpc
  cidr                 = var.cidr
  azs                  = data.aws_availability_zones.available.names
  private_subnets      = [var.private_subnet_1, var.private_subnet_2, var.private_subnet_3]
  public_subnets       = [var.public_subnet_1, var.public_subnet_2, var.public_subnet_3]
  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb"             = "1"
  }
}