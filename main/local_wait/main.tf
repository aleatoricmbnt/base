resource "random_pet" "rp" {
  keepers = {
    keeper = timestamp()
  }
}
