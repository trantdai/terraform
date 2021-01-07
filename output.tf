/*
output "null_variable" {
  value = var.null_variable != null ? var.null_variable : "null"
}

output "listvar" {
  value = var.blank_list != "" ? var.blank_list : []
}

output "list2map" {
  value = { for mapitem in var.maplist : mapitem.name => mapitem }
}
*/
