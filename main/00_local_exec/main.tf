data "external" "test" {
  program = ["bash", "-c", var.program_for_data_external]
}

variable "program_for_data_external" {
  type = string
  description = "Program for data external"
  default = "echo '{\"result\": \"test\"}'"
}

resource "terraform_data" "test" {
  provisioner "local-exec" {
    command = var.command_for_local_exec
  }
}

resource "terraform_data" "always_recreated" {
  triggers_replace = timestamp()
}

variable "command_for_local_exec" {
  type = string
  description = "Command for local exec (single line; no newlines inside -c string)"
  default = "echo '{\"result\": \"test\"}'"
}
