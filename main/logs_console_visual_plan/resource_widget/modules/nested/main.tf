resource "terraform_data" "nested_for_each_map" {
  for_each = {
    "service.auth"    = "auth-service"
    "service.storage" = "storage-service"
  }
  input = each.value
}

# resource "random_string" "nested_count" {
#   count   = 2
#   length  = 6
#   special = false
# }
