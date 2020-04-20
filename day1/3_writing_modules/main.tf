provider "aws" {
  region = "us-east-1"
}

/*
Use the s3_mod module using dot operator "module.XXX" and hook its variables with the out variables defined in s3_mod
Now you are no longer dictated by the required/optional variables of s3_mod, Everything is defined by you
and thats why we should use module programming of IaC
*/
module "mod_create_s3" {
  source = "./s3_mod"

  var_bkt_name = module.mod_create_s3.out_my_bkt_name
  var_versioning = module.mod_create_s3.out_my_bkt_versioning
}