resource "null_resource" "count_2" {
  count = 2
}

module "nested" {
  for_each = {
    "service.auth"    = "auth-service"
    "service.storage" = "storage-service"
  }
  source = "../nested"
}
