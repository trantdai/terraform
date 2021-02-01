/*
variable "example_objects" {
  type    = list
  default = [
  {
    "cidrs": [
      {
        "cidr": "99.99.99.0/24",
        "description": "Host1"
      }
    ],
    "firewallGroup": "",
    "landingZone": "Zone1",
    "name": "ag-zone1",
    "owner": "",
    "uid": "a5b14329e01452da855b1d3e267fd900",
    "zoneInstance": "Global",
    "zoneType": "app"
  },
  {
    "cidrs": [
      {
        "cidr": "99.99.99.1",
        "description": "Host 1"
      },
      {
        "cidr": "99.99.99.2",
        "description": "Host 2"
      },
      {
        "cidr": "99.99.99.3",
        "description": "Host 3"
      },
      {
        "cidr": "99.99.99.4",
        "description": "Host 4"
      },
      {
        "cidr": "99.99.99.5",
        "description": "Host 5"
      },
      {
        "cidr": "99.99.99.6",
        "description": "Host 6"
      },
      {
        "cidr": "99.99.99.7",
        "description": "Host 7"
      },
    ],
    "firewallGroup": "",
    "landingZone": "Zone 2",
    "name": "ag-zone2",
    "owner": "",
    "uid": "1ffdaf0d78b458269df5e3a54f88eacb",
    "zoneInstance": "Global",
    "zoneType": "app"
  }
]
}

variable "nametag" {
  type        = string
  description = "String to be appended to the end of the standard object name like H-1.1.1.1-IAC"
  default     = "IAC"
}

#output "flatten_group" {
#    value = flatten(var.example_objects)
#}

locals {
    address_list = [
            for group in var.example_objects: {
                for address in group.cidrs: replace(address.cidr, "/", "") != address.cidr ? "N-${split("/", address.cidr)[0]}-${split("/", address.cidr)[1]}-${var.nametag}": "H-${address.cidr}-${var.nametag}" => merge(address, {"location": group.firewallGroup == "" ? "shared" : group.firewallGroup})
            }
        ]

    group_map  = {
        for group in var.example_objects: group.name => group.cidrs
    }

    temp  = [
        for group in var.example_objects: [
            for address in group.cidrs: merge(address, {"firewallGroup" = group.firewallGroup})
        ]
    ]

    temp1  = {for address in
        flatten([
        for group in var.example_objects: [
            for cidr in group.cidrs: merge(cidr, {"firewallGroup" = group.firewallGroup})
        ]
    ]): replace(address.cidr, "/", "") != address.cidr ? "N-${split("/", address.cidr)[0]}-${split("/", address.cidr)[1]}-${var.nametag}": "H-${address.cidr}-${var.nametag}" => address
    }

}
output "address_map" {
    value = local.temp1
}
*/
