module "main-vpc" {
  source     = "..\/..\/hello_packer\/modules\/vpc"
//  ENV        = var.ENV
  AWS_REGION = var.AWS_REGION
}

module "instances" {
  source         = "..\/..\/hello_packer\/modules\/server"
//  ENV            = var.ENV
  VPC_ID         = module.main-vpc.vpc_id
  public_subnets = module.main-vpc.public_subnets
}

