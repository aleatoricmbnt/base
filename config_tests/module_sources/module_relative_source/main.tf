module "referencing_parent" {
  source = "../../../main/git_https_target"
  custom_var = var.parent-var
}

#module "referencing_subdir" {
#  source = "./subdir"
#  custom_var = var.subdir-var
#}

variable "parent-var" {

}

# variable "subdir-var" {
#  
# }

output "referencing_output_parent" {
  value = module.referencing_parent.pet_name
}

#output "referencing_output_subdir" {
#  value = module.referencing_subdir.pet_name
#
#}
