module "referencing" {
  source = "github.com/aleatoricmbnt/base.git//main/git_https_target"
  custom_var = var.required
}

variable "required" {
  default = "value"
}

output "referencing_module_id_from_output" {
  value = module.referencing.pet_name
}
