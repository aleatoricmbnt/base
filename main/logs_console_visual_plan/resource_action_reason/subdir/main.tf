resource "random_pet" "module_pet" {
  count = 2
}

module "nested" {
  source = "./nested"
}