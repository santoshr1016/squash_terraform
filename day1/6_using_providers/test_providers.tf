# How to configure multiple providers in a single tf allowing to manage the resources across different
# regions, accounts in single project

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "us-east-2"
  alias = "california"
}

resource "aws_s3_bucket" "s3_default_bucket" {
  bucket = "default-region-bucket"
}

resource "aws_s3_bucket" "s3_california" {
  bucket = "california_bucket"
  provider = "aws.california"
}

resource "aws_instance" "foo" {
  provider = aws.california
  ami = ""
  instance_type = ""
}

resource "aws_instance" "bar" {
  provider = aws
  ami = ""
  instance_type = ""
}