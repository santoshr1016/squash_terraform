provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_vpc" "rs_main_vpc" {
  cidr_block = var.vpc_cidr
  enable_classiclink_dns_support = true
  enable_dns_support = true

  tags = {
    Name = "main_vpc"
  }
}

resource "aws_security_group" "rs_public_sg" {
  name = "Public SG"
  description = "to access the internet"
  vpc_id = aws_vpc.rs_main_vpc.id

  // content is executed those many times as size of iterator, which is ingress
  // iterator size is len of var.service_ports
  // for each item in var.service_ports, content block is executed

  dynamic "ingress" {
    // its like populating the iterator
    // NEVER FORGET THAT COLON
    for_each = [for item in var.service_ports: {
      from_port = item.from_port
      to_port = item.to_port
    }]
    content {
      from_port = ingress.value.from_port
      to_port = ingress.value.to_port
      protocol = "tcp"
      cidr_blocks = [var.internet]
    }
  }

}
