module "referencing" {
  source = "github.com/aleatoricmbnt/base.git//main/git_https_target"
}

output "referencing_module_id_from_output" {
  value = module.referencing.pet_name
}
