# resource "null_resource" "count_2" {
#   count = 2
# }

module "nested" {
  source = "../nested"
}
