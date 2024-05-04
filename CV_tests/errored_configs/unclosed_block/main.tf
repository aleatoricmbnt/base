resource "random_pet" "name" {
  keepers = {
    time = timestamp()
  }