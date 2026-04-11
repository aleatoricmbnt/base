variable "from_shell_env" {
  type      = string
  sensitive = false
}

resource "terraform_data" "repro" {
  input = {
    from_shell_env = var.from_shell_env
  }
}
