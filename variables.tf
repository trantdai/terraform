#null value is used to define optional variable. Terraform does not complain if the value of optional variable is not provided in tfvars file
#<<EOT ... EOT is multi-line comment
variable "null_variable" {
  default     = null
  description = <<EOT
  null value is used to define optional variable
  Terraform does not complain if the value of optional variable is not provided in tfvars file
  EOT
}

variable "blank_list" {
  type        = list(string)
  default     = []
  description = <<EOT
  blank_list is list of strings with default value is blank
  EOT
}

variable "maplist" {
  type = list(map(any))
  default = [
    {
      name  = "name1"
      value = "value1"
    },
    {
      name  = "name2"
      value = "value2"
  }]
}

variable "username" {
  type    = string
  default = "hey"
}

variable "password" {
  type    = string
  default = "you"
}
