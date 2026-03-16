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

variable "command_for_local_exec" {
  type = string
  description = "Command for local exec"
  default = "echo '{\"result\": \"test\"}'"
}
