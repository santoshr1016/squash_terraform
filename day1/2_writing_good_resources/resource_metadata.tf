# Refer https://www.terraform.io/docs/configuration/resources.html#lifecycle-lifecycle-customizations
# Name all the resource as rs_XXXX_YYYY

provider "aws" {
  region = var.singapore
}

resource "aws_iam_role" "rs_iam_role" {
  name = "example"

  # assume_role_policy is omitted for brevity in this example. See the
  # documentation for aws_iam_role for a complete example.
  assume_role_policy = "..."
}

resource "aws_iam_instance_profile" "rs_iam_profile" {
  # Because this expression refers to the role, Terraform can infer
  # automatically that the role must be created first.
  role = aws_iam_role.rs_iam_role.name
}

resource "aws_iam_role_policy" "rs_iam_policy" {
  name   = "example"
  role   = aws_iam_role.rs_iam_role.name
  policy = jsonencode({
    "Statement" = [{
      # This policy allows software running on the EC2 instance to
      # access the S3 API.
      Action = "s3:*",
      Effect = "Allow",
    }],
  })
}

resource "aws_instance" "rs_ec2_instance" {
  ami           = "ami-XXXXX"
  instance_type = "t2.micro"

  # Terraform can infer from this that the instance profile must
  # be created before the EC2 instance.
  iam_instance_profile = aws_iam_instance_profile.rs_iam_profile

  # However, if software running in this EC2 instance needs access
  # to the S3 API in order to boot properly, there is also a "hidden"
  # dependency on the aws_iam_role_policy that Terraform cannot
  # automatically infer, so it must be declared explicitly:
  depends_on = [
    aws_iam_role_policy.rs_iam_policy,
  ]
}

output "instance_ip_addr" {
  value       = aws_instance.rs_ec2_instance.private_ip
  description = "The private IP address of the main server instance."

  depends_on = [
    # S3 policy must be created before this IP address could
    # actually be used, otherwise the services will be unreachable.
    aws_iam_role_policy.rs_iam_policy,
  ]
}
