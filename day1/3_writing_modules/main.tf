provider "aws" {
  region = "ap-southeast-1"
}

/*
Use the s3_mod module using dot operator "module.XXX" and hook its variables with the out variables defined in s3_mod
Now you are no longer dictated by the required/optional variables of s3_mod, Everything is defined by you
and thats why we should use module programming of IaC
*/
module "mod_create_s3" {
  var_bkt_name = "20April-Bucket-Name"
  var_versioning = false
  source = "./s3_mod"
}

output "print_bucket_name" {
  value = module.mod_create_s3.out_my_bkt_name
}

output "print_versioning" {
  value = module.mod_create_s3.out_my_bkt_versioning
}

output "print_bkt_arn" {
  value = module.mod_create_s3.out_bkt_arn
}