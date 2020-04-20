variable "get_from_sg_mod" {}
variable "ec2_key_name_provide_me_at_main" {}
variable "ec2_availability_zone_provided_default" {
  type = string
  default = "ap-southeast-1a"
}
variable "ec2_vm_name_not_using_default" {
  type = string
}

variable "ami_to_use" {
  default = "ami-22b9a343"
}

// creating a module and calling somewhere in the code
/*
module "test" {
  source = "../sg_mod"
}
*/

resource "aws_instance" "foo" {
  ami           = var.ami_to_use # us-west-2
  instance_type = "t2.micro"

  // Call the module here and use its variable
  // vpc_security_group_ids = [module.test.use_me_to_other_modules]
  vpc_security_group_ids = [var.get_from_sg_mod]
  key_name = var.ec2_key_name_provide_me_at_main
  availability_zone = var.ec2_availability_zone_provided_default

  credit_specification {
    cpu_credits = "unlimited"
  }
  tags = {
    Name = var.ec2_vm_name_not_using_default
  }
}

