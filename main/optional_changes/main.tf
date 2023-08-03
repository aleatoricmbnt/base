resource "null_resource" "optional_changes" {
    triggers = {
        conditional = var.question != "yes" ? "unchanged string" : timestamp()
    }
}

resource "random_pet" "PR" {}

variable "question" {
  default = "no"
  type = string
  description = "Do you want your config to be applied again during re-run?"
}
