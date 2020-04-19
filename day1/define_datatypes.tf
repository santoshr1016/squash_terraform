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

output "print_string_variable" {
  value = var.string_data_type
}
output "print_multiline_variable" {
  value = var.multiline
}
output "print_map_variable" {
  value = var.map_data_type["uswest"]
}
output "print_list_variable" {
  value = var.list_data_type
}
output "print_single_item_in_list" {
  value = var.list_data_type[2]
}
output "boolean_variable" {
  value = var.bool_data_type
}

output "taken_string_is_kept_hidden" {
  sensitive = true
  value = var.variable_taking_user_input_in_terminal
}

output "taken_string_is_not_hidden" {
  sensitive = false
  value = var.variable_taking_user_input_in_terminal
}