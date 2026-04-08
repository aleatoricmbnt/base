resource "random_pet" "pet" {
  keepers = {
    key = var.keeper-variable
  }
}


variable "keeper-variable" {
  validation {
    condition     = contains(["custom_1337"], var.keeper-variable)
    error_message = "If files are parsed correctly, the value should contain 'custom_1337' text."
  }
}

output "pet_name" {
  value = random_pet.pet.id
}
