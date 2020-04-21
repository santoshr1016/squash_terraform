resource "aws_instance" "var_ec2_instance" {
  ami           = var.var_amis[var.var_region]
  instance_type = var.var_instance_type

  # the VPC subnet
  subnet_id = aws_subnet.var_main_pub_3.id

  # the security group
  vpc_security_group_ids = [aws_security_group.var_bastion.id]

  # the public SSH key
  key_name = var.var_ssh_key

  tags = {
    Name = var.var_server_name
    Env = var.var_env
  }
}

