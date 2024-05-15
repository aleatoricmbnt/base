module "referencing" {
  source = "git::https://github.com/aleatoricmbnt/base.git//main/git_https_target"
  custom_var = var.smth
}

variable "smth" {
  
}

output "referencing_module_id_from_output" {
  value = module.referencing.pet_name
}

