resource "null_resource" "string_trigger" {
    triggers = {
        string = var.string
    }
}

variable "string" {}