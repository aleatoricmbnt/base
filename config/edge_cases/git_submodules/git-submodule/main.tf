resource "random_pet" "submodule" {
  keepers = {
    # Generate a new pet name each time
    time = timestamp()
  } 
}

output "submodule_pet" {
  value = resource.random_pet.submodule.id
}

module "nested-00" {
  source = "./git-nested-00"
}

module "nested-01" {
  source = "./git-nested-01"
}

output "nested_00_pet" {
  value = module.nested-00.nested_00_pet
}

output "nested_01_pet" {
  value = module.nested-01.nested_01_pet
}
