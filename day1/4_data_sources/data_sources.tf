provider "aws" {
  region = var.singapore
}

module "create_s3_mod" {
  var_bkt_name ="This is the bucket name"
  var_versioning = false
  source = "../3_writing_modules/s3_mod"

}

data "aws_iam_policy_document" "example" {

  statement {
    sid = "1"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }

  statement {
    actions = [
      "s3:ListBucket",
    ]

    resources = [
//      "arn:aws:s3:::${var.s3_bucket_name}",
      "arn:aws:s3:::${module.create_s3_mod.out_my_bkt_name}",
    ]

    condition {
      test     = "StringLike"
      variable = "s3:prefix"

      values = [
        "",
        "home/",
        "home/&{aws:username}/",
      ]
    }
  }

  statement {
    actions = [
      "s3:*",
    ]

    resources = [
      "arn:aws:s3:::${module.create_s3_mod.out_my_bkt_name}/home/&{aws:username}",
      "arn:aws:s3:::${module.create_s3_mod.out_my_bkt_name}/home/&{aws:username}/*",
    ]
  }
}

resource "aws_iam_policy" "example" {
  name   = "example_policy"
  path   = "/"
  policy = data.aws_iam_policy_document.example.json
}
