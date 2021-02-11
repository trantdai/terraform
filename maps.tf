#https://stackoverflow.com/questions/63500554/terraform-iterate-over-nested-map
variable "bq_iam_role_bindings" {

  default = {
    "member1" = {
      "dataset1" : ["role1", "role2", "role5"],
      "dataset2" : ["role3", "role2"],
    },
    "member2" = {
      "dataset3" : ["role1", "role4"],
      "dataset2" : ["role5"],
    }
  }
}

locals {
  transform = flatten(
    [
      for member, value in var.bq_iam_role_bindings :
      [
        for dataset, roles in value :
        [
          for role in roles :
          {
            "member"  = member
            "dataset" = dataset
            "role"    = role
          }
        ]
      ]
    ]
  )
}

output "transformmap" {
  value = {
    for item in local.transform : item.role => item
  }
}
/*
transform = [
  {
    "dataset" = "dataset1"
    "member" = "member1"
    "role" = "role1"
  },
  {
    "dataset" = "dataset1"
    "member" = "member1"
    "role" = "role2"
  },
  {
    "dataset" = "dataset1"
    "member" = "member1"
    "role" = "role5"
  },
  {
    "dataset" = "dataset2"
    "member" = "member1"
    "role" = "role3"
  },
  {
    "dataset" = "dataset2"
    "member" = "member1"
    "role" = "role2"
  },
  {
    "dataset" = "dataset2"
    "member" = "member2"
    "role" = "role5"
  },
  {
    "dataset" = "dataset3"
    "member" = "member2"
    "role" = "role1"
  },
  {
    "dataset" = "dataset3"
    "member" = "member2"
    "role" = "role4"
  },
]
*/