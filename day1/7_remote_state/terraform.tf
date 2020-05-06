//module "backend" {
//    source = "./one_time_task"
//}

terraform {

    backend "s3" {
        encrypt = true
        bucket = "terraform-s3-testing-06may"
        dynamodb_table = "tflocktable"
        region = "ap-southeast-1"
        // Should not use variables here
        //    bucket = module.backend.s3_storage
        //    dynamodb_table = module.backend.dynamo_lock
        key = "test.tfstate"
    }
}