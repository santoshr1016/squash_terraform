##Create S3 Bucket for remote state :

resource "aws_s3_bucket" "terraform-s3"{
    bucket = "terraform-s3-testing"
    versioning {
    enabled = true
    }

    lifecycle {
        prevent_destroy = true
    }

    tags {
        Name = "S3 Remote store"
    }
}

##Create Dynamodb table for remote state locking :

##Configure to use remote backend :