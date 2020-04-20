/*
This module creates s3 bucket but it needs below variables
var_bkt_name
var_versioning
which are not provided here and we want these 2 variables to be GIVEN in some other place or module.

For that what we do is
1. Define var_bkt_name, var_versioning in variables file
(So, Whatever we want to pass dynamically, Just define them here)

2. Expose these 2 variables using outputs.tf, so they are visible outside this module

*/

resource "aws_s3_bucket" "rs_bkt" {
  bucket = var.var_bkt_name

  versioning {
    enabled = var.var_versioning
  }
}

