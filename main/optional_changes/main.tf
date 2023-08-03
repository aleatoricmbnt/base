resource "null_resource" "optional_changes" {
    triggers = {
        conditional = var.question != "yes" ? "unchanged string" : timestamp()
    }
}

variable "question" {
  type = string
  description = "Do you want your config to be applied again during re-run?"
}
