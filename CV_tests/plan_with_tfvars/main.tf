resource "null_resource" "test" {
  triggers = {
    trigger = var.string
  }
}

variable "string" {
  type        = string
  description = "Set relative path to varfile as '..\\tfvars\\default.tfvars'"
}