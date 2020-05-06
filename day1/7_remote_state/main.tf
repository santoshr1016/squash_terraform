data "aws_ami" "amazin_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*"]
  }
}

resource "aws_instance" "rs_instance" {
  ami = data.aws_ami.amazin_linux.id
  instance_type = "t2.micro"

  tags = {
    Name = "Sample instance"
  }
}