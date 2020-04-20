provider "aws" {
  region = var.singapore
}

resource "aws_s3_bucket" "rs_my_bucket" {
  bucket = "rsk-test-bucket"
}

resource "aws_iam_user" "rs_santosh" {
  name = "rsk-santosh"
}

# Understand it as
# 1. Load the Policy file
# 2. Fill the placeholders / variables in the file using the "vars" snippet

data "template_file" "tf_bucket_policy" {
  template = file("policy.json")

  vars {
    bucket_arn = aws_s3_bucket.rs_my_bucket.arn
  }
}

# Loading the "data" which has got all placeholders filled using the "rendered"
resource "aws_iam_user_policy" "rs_my_policy" {
  name = "my-policy"
  user = aws_iam_user.rs_santosh.name
  policy = data.template_file.tf_bucket_policy.rendered
}

output "policy" {
  value = aws_iam_user_policy.rs_my_policy.policy
}