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
    for_each = var.service_ports
    content {
      from_port = ingress.value # it woll get  22
      to_port = ingress.value # it will get 9090, ideally should be 22, for example sake
      protocol = "tcp"
      cidr_blocks = [
        var.vpc_cidr]
    }
  }
}

/*
# aws_security_group.rs_public_sg will be created
  + resource "aws_security_group" "rs_public_sg" {
      + arn                    = (known after apply)
      + description            = "to access the internet"
      + egress                 = (known after apply)
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "10.0.0.0/16",
                ]
              + description      = ""
              + from_port        = 22
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 22
            },
          + {
              + cidr_blocks      = [
                  + "10.0.0.0/16",
                ]
              + description      = ""
              + from_port        = 9090
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 9090
            },
        ]
      + name                   = "Public SG"
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + vpc_id                 = (known after apply)
    }

*/