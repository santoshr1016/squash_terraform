provider "aws" {
  region = "ap-southeast-1"
}

variable "key_name" {
  default = "test"
}

resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

resource "null_resource" "keyname" {
  provisioner "local-exec" {
        command = "echo  ${aws_key_pair.generated_key.public_key} > keyname.txt"
    }

}

output "name" {
  value = var.key_name
}

output "kp" {
  value = aws_key_pair.generated_key.public_key
}