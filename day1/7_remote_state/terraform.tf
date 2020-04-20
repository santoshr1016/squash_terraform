terraform {

backend "s3" {
    encrypt = true
    bucket = "terraform-s3-testing"
    dynamodb_table = "tflocktable"
    key = "test.tfstate"
    }
}