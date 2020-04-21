resource "aws_security_group" "var_bastion" {
  vpc_id      = aws_vpc.main.id
  name        = "allow-ssh"
  description = "security group that allows ssh and all egress traffic"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [var.var_host_ip]
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [aws_subnet.var_main_pri_1.cidr_block]
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [aws_subnet.var_main_pri_2.cidr_block]
  }

  ingress {
    from_port = 22
    protocol = "tcp"
    to_port = 22
    cidr_blocks = [aws_subnet.var_main_pri_3.cidr_block]
  }

  /*
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.var_host_ip]
  }
  */
  tags = {
    Name = "allow-ssh"
  }
}

