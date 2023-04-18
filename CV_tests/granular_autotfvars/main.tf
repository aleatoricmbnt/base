resource "null_resource" "granular" {
  triggers = {
    trigger = "${var.string}"
  }
}

variable "string" {

}

output "trigger_string_output" {
  value = var.string
}

output "expected_result" {
  value = "This configuration contains 2000 .auto.tfvars files (named defaultN.auto.tfvars, where N is it's index), each with different var.string value. They are parsed in the lexical order, so var.string value should be 999 and not the 1999"
}