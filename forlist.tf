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

variable "policies" {
  type = list
  default = [
    {
      "ports" : [
        [
          "137-139",
          "145"
        ]
      ],
      "protocol" : "*",
    },
    {
      "ports" : [
        [
          "53"
        ]
      ],
      "protocol" : "*"
    },
    {
      "ports" : [
        [
          "1194",
          "2114"
        ]
      ],
      "protocol" : "Udp"
    },
    {
      "ports" : [
        [
          "1195",
          "2114"
        ]
      ],
      "protocol" : "Udp"
    }
  ]
}

locals {
  service_map1 = distinct([
    for policy in var.policies : {
      "names" : policy.protocol == "*" ? flatten([for protocol in ["TCP", "UDP"] : [for port in flatten(policy.ports) : "${upper(protocol)}-${port}-${var.nametag}"]]) : upper(policy.protocol) == "TCP" ? [for port in flatten(policy.ports) : "TCP-${port}-${var.nametag}"] : [for port in flatten(policy.ports) : "UDP-${port}-${var.nametag}"]
      "ports" : flatten(policy.ports)
    }
  ])
  service_list = distinct(
    flatten(
      [
        for policy in var.policies : policy.protocol == "*" ? flatten([for protocol in ["TCP", "UDP"] : [for port in flatten(policy.ports) : "${upper(protocol)}-${port}-${var.nametag}"]]) : [for port in flatten(policy.ports) : "${upper(policy.protocol)}-${port}-${var.nametag}"]
      ]
    )
  )

  service_map = {
    for name in local.service_list : name => {
      "protocol" : substr(name, 0, 3)
      "port" : substr(replace(name, "-${var.nametag}", ""), 4, length(replace(name, "-${var.nametag}", "")) - 4)
    }
  }

}

output "service_list" {
  value = local.service_list
}

#output "service_map" {
#  value = local.service_map
#}

variable "fwlist" {
  type    = list
  default = ["", "azrfwt300", "azrfwt700", "azrfwt600", "azrfwt650"]
}

locals {
  fwmap = {
    for fwname in compact(var.fwlist) : fwname => tonumber(substr(fwname, length(fwname) - 3, 3)) >= 300 && tonumber(substr(fwname, length(fwname) - 3, 3)) < 400 || tonumber(substr(fwname, length(fwname) - 3, 3)) >= 600 && tonumber(substr(fwname, length(fwname) - 3, 3)) < 700
  }

  fwlist = [
    {
      "dstgroup" = {
        "firewallGroup" : "fw300",
        "firewallVendor" : "juniper"
      },
      "srcgroup" = {
        "firewallGroup" : "fw301",
        "firewallVendor" : "checkpoint"
      }
      "midgroup" = {
        "firewallGroup" : "fw304",
        "firewallVendor" : "juniper"
      }
    },
    {
      "dstgroup" = {
        "firewallGroup" : "fw302",
        "firewallVendor" : "juniper"
      },
      "srcgroup" = {
        "firewallGroup" : "fw303",
        "firewallVendor" : "checkpoint"
      }
      "midgroup" = {
        "firewallGroup" : "fw305",
        "firewallVendor" : "juniper"
      }
    }
  ]
}

output "firewall_map" {
  value = local.fwmap
}

output "compact" {
  value = compact(["", "", ""])
}

output "firewall_list" {
  value = [
    for k, v in local.fwlist[0] : v.firewallGroup if upper(v.firewallVendor) == "JUNIPER" && (k == "dstgroup" || k == "srcgroup")
  ]
}
