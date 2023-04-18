resource "random_pet" "pet" {
  count = var.rp_count
  keepers = {
    # Generate a new pet name each time
    timestamp = timestamp()
  }
}

variable "rp_count" {
  type = number
  default = 100535
}

# put each pet into array
output "bd_name" {
  value = random_pet.pet.*.id
}