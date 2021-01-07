#https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http
/*
data "http" "example" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

  # Optional request headers
  request_headers = {
    Accept = "application/json"
  }
}

output "body" {
  value = data.http.example.body
}

output "response_headers" {
  value = data.http.example.response_headers
}

output "body_first_item" {
  value = jsondecode(data.http.example.body)[0]
}
*/
