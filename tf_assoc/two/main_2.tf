variable "team_name" {
  default = ["sg-team", "in-team", "us-team"]
}
resource "aws_iam_user" "rs_aws_iam_user" {
  #count = length(var.team_name)

  # use case 1 - static string
  #name = "iam_user_acct_${count.index}"

  # use case 2 - array index count
  #name = var.team_name[count.index]

  # use case 3 - for_each
  //for_each = var.team_name
  for_each = toset(var.team_name)
  name = each.value
}


output "op_name" {
  value = aws_iam_user.rs_aws_iam_user.*.name
}

/*
tf console
var.team_name
length(var.team_name)
reverse(var.team_name)
distinct(var.team_name)
toset(var.team_name)
sort(var.team_name)
contains(var.team_name, "santosh")
concat(var.team_name, ["new_team"])
range(10)
range(1,11)
range(1,11,3)

*/

