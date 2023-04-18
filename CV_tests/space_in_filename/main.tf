resource "random_pet" "pet" {
  keepers = {
    key = var.keeper-variable
  }
}

variable "keeper-variable" {
  
}

output "pet_name" {
  value = random_pet.pet.id
}
