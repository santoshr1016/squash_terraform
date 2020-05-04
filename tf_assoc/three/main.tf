//variable "map_var" {
//  type = map(string)
//  default = {
//    "key1" = "val1",
//    "key2" = "val2",
//    "key3" = "val3"
//  }
//}

variable "my_list" {
  type = list(string)
  default = ["hello", "world", "test", "string"]

}

//resource "aws_iam_user" "rs_test_user" {
//  for_each = var.map_var
//  name = each.key
//
//  tags = {
//    country = each.value
//  }
//}