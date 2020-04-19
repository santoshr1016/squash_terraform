provider "aws" {
  region = "us-east-1"
}

variable "string_data_type" {
  type = "string"
  default = "Santosh is default value"
}

# String
variable "multiline" {
  type = "string"
  default = <<EOH
    This is a multiline string
    Check this is second
    This is thirs
    EOH
}

# maps
variable "map_data_type" {
  type = "map"
  default = {
    "useast" = "ami-1"
    "uswest" = "ami-2"
  }
}

# list
variable "list_data_type" {
  type = "list"
  default = ["one", "two", "three", "east", "west"]
}

# boolean
variable "bool_data_type" {
  default = true
}

# taking input
variable "variable_taking_user_input_in_terminal" {
  type = "string"
  default = "PROVIDE_EMPTY_STRING_IF_NOT_SETTING_DEFAULT"
}

# defining locals
locals {
  common_tags = {
    Component   = "awesome-app"
    Environment = "production"
  }
}
