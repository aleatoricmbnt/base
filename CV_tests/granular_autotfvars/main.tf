terraform {
    required_version = ">= 1.2.0"
}

resource "null_resource" "string_trigger" {
    triggers = {
        string = var.string
    }
}

variable "string" {
    validation {
        condition = contains(["1999", 1999], var.string)
        error_message = "If files are parsed correctly, the value should contain 1999 number."
    }
}