# CHECK IF STRING CONTAINS A CHARACTER
# https://stackoverflow.com/questions/47243474/how-to-check-if-string-contains-a-substring-in-terraform-interpolation
# https://www.terraform.io/docs/configuration/functions/replace.html

variable "address" {
  type    = string
  default = "10.0.0.0/24"
  #default = "10.0.0.0"
}

output "isforwardslash" {
  value = replace(var.address, "/", "") != var.address
}

# https://www.terraform.io/docs/configuration/functions/split.html
# STRING TRANSFORMATION
locals {
  addressname = replace(var.address, "/", "") != var.address ? "N-${split("/", var.address)[0]}-${split("/", var.address)[1]}" : "H-${var.address}"
}

output "addressname" {
  value = local.addressname
}
