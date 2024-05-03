resource "random_pet" "subdir_referenced" {
  keepers = {
    time = timestamp()
    custom = var.custom_var
  }
}

variable "custom_var" {
  
}

output "pet_name" {
  description = "The `id` of the `random_pet.referenced` resource in this module."
  value       = random_pet.subdir_referenced.id
}

resource "random_integer" "int" {
  min = 0
  max = 255
}


