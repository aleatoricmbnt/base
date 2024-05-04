resource "random_pet" "head" {
  keepers = {
    # Generate a new pet name each time
    time = timestamp()
  }
}

output "head_pet" {
  value = resource.random_pet.head.id
}

module "submodule" {
  source = "./git-submodule"
}

output "nested_00_pet" {
  value = module.submodule.nested_00_pet
}

output "nested_01_pet" {
  value = module.submodule.nested_01_pet
}

output "submodule_pet" {
  value = module.submodule.submodule_pet
}