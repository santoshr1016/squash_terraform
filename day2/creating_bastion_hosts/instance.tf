resource "aws_instance" "var_ec2_instance" {
  ami           = var.var_amis[var.var_region]
  instance_type = var.var_instance_type

  # Using count to create multiple instance
  #count = 3

  # the VPC subnet
  subnet_id = aws_subnet.var_main_pub_3.id

  # the security group
  vpc_security_group_ids = [aws_security_group.var_bastion.id]

  # the public SSH key
  key_name = var.var_ssh_key

  #user_data = file("user-data.sh")

  /* // Making this ec2 as nginx webserver
  user_data = <<-DATA
      #!/bin/bash
                  sudo apt-get update -y
                  sudo apt-get install -y nginx
                  sudo service nginx start
      DATA
  */

  lifecycle = {
    create_before_destroy = true
  }
  tags = {
    # Name = {var.var_server_name}-{count.index} :P
    # Name = "${var.var_server_name}-${count.index}"
    Name = "EC2-instance"
    Env = var.var_env
  }
}

/*

resource "aws_elb" "rs_ha_nginx" {
  name = "HA-Nginx-Web"

  # The avaiability zone of the ec2 instances
  availability_zones = [aws_instance.var_ec2_instance.*.availability_zone]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  # The instances which you want to attach to this ELB
  instances = [aws_instance.var_ec2_instance.*.id]
}

*/
