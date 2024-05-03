resource "null_resource" "to_check" {
  triggers = {
    trigger = var.check
  }
}

variable "check" {
  description = "Variable used to determine if policy check will fail (0 should fail)"
}