provider "aws" {
  region = "us-east-1"
}

/*
Use the s3_mod using the module and hook up with the out variables defined in s3_mod
Now you are no longer dictate by the required/optional variables, Everything is defined by you
and thats why we should use module programming of IaC
*/
module "mod_create_s3" {
  source = "./s3_mod"

  var_bkt_name = module.mod_create_s3.out_my_bkt_name
  var_versioning = module.mod_create_s3.out_my_bkt_versioning
}