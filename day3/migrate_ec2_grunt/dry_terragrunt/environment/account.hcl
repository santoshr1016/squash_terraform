# Set account-wide variables. These are automatically pulled in to configure the remote state bucket in the root
# terragrunt.hcl configuration.
locals {
  account_name   = "Some-Account-Name"
  aws_account_id = "111111111"
  aws_profile    = "Provide-Some-Profile"
}
