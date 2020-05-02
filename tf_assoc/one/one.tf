/*
Desired - Infrastructure should be this state, like 1 s3 bucket (What we want)
Known  - The state as in last point of execution ( what is present in the tfstate file)
Actual - Actual state in the Cloud Provider (What is present in AWS, It could have been manually changed, who knows)

When we fire again the teraform apply, the Known resource state "aws_s3_bucket.s3_02may_bkt" as per tfstate file  is
compared with AWS Actual state to see any differences. And
The state before the apply is stored in the tfstate.backup file.
The state after the apply is stored in the tf.state file.

Terraform identifiers have unique mapping with the AWS resource in the cloud


When I added versioning
Desired - This state has versioning enabled
Known - This state is the state of previous execution
Actual - This state which is present in AWS Cloud

After adding some more outputs
terraform plan -out tfplan  -refresh=false
terraform apply tfplan

terraform apply -target=aws_iam_user.iam_new_user
This will only check this resource and not any other, saving time

*/

provider "aws" {
  region = "ap-southeast-1"
  version = "~> 2.60"
}

# Internal reference of resource
resource "aws_s3_bucket" "s3_02may_bkt" {
  bucket = "s3-02may-bkt-003"

  # This is added later
  versioning {
        enabled    = true
        mfa_delete = false
    }
}

output "out_s3_01" {
  value = aws_s3_bucket.s3_02may_bkt.arn
}

output "out_s3_02" {
  value = aws_s3_bucket.s3_02may_bkt.region
}

output "out_s3_03" {
  value = aws_s3_bucket.s3_02may_bkt.bucket_domain_name
}

output "out_s3_04" {
  value = aws_s3_bucket.s3_02may_bkt.id
}

/*
terraform console
copied from terraform console

> aws_s3_bucket.s3_02may_bkt.versioning[0].enabled
true
>
*/

output "out_s3_05" {
  value = aws_s3_bucket.s3_02may_bkt.versioning[0].enabled
}


