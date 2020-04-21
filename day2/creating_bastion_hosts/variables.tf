# Variables TF File
variable "var_region" {
  description = "AWS Region "
  default     = "ap-southeast-1"
}

# aws ec2 create-key-pair --key-name cfn-key1 --query 'KeyMaterial' --output text > cfn-key1.pem
variable "var_ssh_key" {
  description = "ssh key to login to ec2 instance"
  default = "cfn-key1"
}

variable "var_instance_type" {
  description = "Instance Typebe used for Instance "
  default     = "t2.micro"
}

variable "var_server_name" {
  description = "Application Name"
  default     = "Bastion-Host"
}

variable "var_env" {
  description = "Environment Name"
  default     = "Dev"
}

variable "var_host_ip" {
  description = "HostIP, Allowing traffic from my computer"
  default = "XX.XX.XX.XX/32"
}

//aws ec2 describe-images --query 'Images[*].[ImageId]' --owners self amazon --filters 'Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-????????' 'Name=state,Values=available' --instance-type t2.micro --output text


# To get the AMI of specific region, Amazon is the owner
# aws ec2 describe-images --query 'Images[*].[ImageId]' --owners self amazon

variable "var_amis" {
  type = map(string)
  default = {
    ap-southeast-1 = "ami-09a4a9ce71ff3f20b"
    ap-southeast-2 = "ami-02a599eb01e3b3c5b"
  }
}

/* https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html#finding-an-ami-aws-cli
aws ec2 describe-images \
    --owners 099720109477 \
    --filters 'Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-????????' 'Name=state,Values=available' \
    --query 'reverse(sort_by(Images, &CreationDate))[:1].ImageId' \
    --region ap-southeast-1 \
    --output text
*/