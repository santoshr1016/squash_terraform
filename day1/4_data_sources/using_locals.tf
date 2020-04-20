locals {
  prefix = "rsk-test-first"
}

resource "aws_s3_bucket" "rsk_bucket" {
  bucket = "${local.prefix}-bucket"
}

locals {
  name = "Santosh"
}

output "name_local" {
  value = local.name
}