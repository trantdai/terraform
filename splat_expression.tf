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

output "splat_expression" {
    value = var.example_objects[*].cidrs[*]
}
*/
/*
splat_expression = [
  [
    {
      "cidr" = "172.25.4.0/24"
      "description" = "VLAN:MUC-LAN-2:204"
    },
  ],
  [
    {
      "cidr" = "82.150.234.91"
      "description" = "mucblpps.os.amadeus.net"
    },
    {
      "cidr" = "172.25.7.146"
      "description" = "mucmdpp10.os.amadeus.net"
    },
    {
      "cidr" = "172.25.8.52"
      "description" = "mucmdpp20.os.amadeus.net"
    },
    {
      "cidr" = "172.30.131.231"
      "description" = "dzdepot.os.amadeus.net"
    },
    {
      "cidr" = "82.150.234.8"
      "description" = "repository.adp.amadeus.net"
    },
    {
      "cidr" = "172.30.131.229"
      "description" = "obdmgt00.os.amadeus.net"
    },
    {
      "cidr" = "172.30.131.230"
      "description" = "obdmgt01.os.amadeus.net"
    },
  ],
]
*/