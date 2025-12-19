module "flat_from_git" {
  source = "git::https://github.com/aleatoricmbnt/flat?ref=v3.0.1"
}

module "nested_from_git" {
  source = "git::https://github.com/aleatoricmbnt/base.git//main/git_https_target?ref=zerossl/0.0.1"
  custom_var = var.required
}

variable "required" {
  default = "value"
}

# output "nested_from_git_module_id_from_output" {
#   value = module.nested_from_git.pet_name
# }
