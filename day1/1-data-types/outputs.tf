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

output "print_locals_variable_1" {
  value = local.common_tags.Component
}

output "print_locals_variable_2" {
  value = local.common_tags.Environment
}