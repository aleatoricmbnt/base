resource "random_pet" "referenced" {
  keepers = {
    time = timestamp()
  }
}

output "pet_name" {
  description = "The `id` of the `random_pet.referenced` resource in this module."
  value       = random_pet.referenced.id
}
