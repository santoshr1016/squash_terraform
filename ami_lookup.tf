data "aws_ami" "ubuntu"
{
  most_recent = "true"
  # Canonical is the owner 
  # https://help.ubuntu.com/community/EC2StartersGuide
  owners = ["099720109477"]
  filter
  {
  name = "name"
  values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }
 filter
 {
  name = "virtualization-type"
  values = ["hvm"]
 }
}

output "aws_ami" "ubuntu"
{
  value = "${data.aws_ami.ubuntu.id}"
}
