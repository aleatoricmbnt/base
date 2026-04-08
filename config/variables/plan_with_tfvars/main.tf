resource "null_resource" "tfvars_folder" {
  triggers = {
    trigger = var.string
  }
}

variable "string" {
  type        = string
  description = "Set relative path to varfile as '..\\tfvars\\default.tfvars'"
}

resource "null_resource" "tfvars2_folder" {
  triggers = {
    trigger = var.string2
  }
}

variable "string2" {
  type        = string
  description = "Set relative path to varfile as '..\\tfvars2\\some.tfvars'"
}