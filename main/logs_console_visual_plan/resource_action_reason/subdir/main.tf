resource "random_pet" "module_pet" {
  count = 1
}

module "nested" {
  source = "./nested"
}