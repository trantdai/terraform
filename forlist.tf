variable "service" {
  type = any
  default = {
    "protocol" = "UDP"
    "ports" = [
      123,
      53
    ]
  }
}

variable "nametag" {
  type        = string
  description = "String to be appended to the end of the standard service object name like TCP-1.1.1.1-IAC"
  default     = "IAC"
}

output "services" {
  #value = var.service.protocol == "*" ? [for port in serivce.ports: for protocol in ["TCP", "UDP"]] : var.service.protocol == "TCP" ? ["TCP-${port}-IAC"] : ["UDP-${port}-IAC"]
  value = var.service.protocol == "*" ? flatten([for protocol in ["TCP", "UDP"] : [for service in var.service.ports : "${upper(protocol)}-${service}-${var.nametag}"]]) : var.service.protocol == "TCP" ? [for port in var.service.ports : "TCP-${port}-IAC"] : [for port in var.service.ports : "UDP-${port}-IAC"]
}

output "setproduct" {
  value = flatten([for protocol in ["TCP", "UDP"] : [for service in ["123", "53"] : "${protocol}-${service}"]])
}
