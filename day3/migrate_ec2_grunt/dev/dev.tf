module "main-vpc" {
  source = "../modules/vpc"
  aws_region = var.AWS_REGION
  env = var.ENV
}

module "instances" {
  source         = "../modules/server"
  ENV            = var.ENV
  public_subnets = module.main-vpc.public_subnets
  aws_region = var.AWS_REGION
  env = var.ENV
  vpc_id = module.main-vpc.vpc_id
}

