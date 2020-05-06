##Create S3 Bucket for remote state :

resource "aws_s3_bucket" "terraform_s3"{
    bucket = "terraform-s3-testing-06may"
    versioning {
    enabled = true
    }

    lifecycle {
        prevent_destroy = true
    }

    tags = {
        Name = "S3 Remote store"
    }
}

output "s3_storage" {
    value = aws_s3_bucket.terraform_s3.bucket
}

##Create Dynamodb table for remote state locking :

##Configure to use remote backend :