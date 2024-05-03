
module "referencing_subdir" {
  count = 3
  source = "./subdir"
  custom_var = var.subdir-var
}


variable "subdir-var" {
  default = "some_string"
}