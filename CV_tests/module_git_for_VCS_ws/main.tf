module "smth_from_git" {
  source = var.source
}

variable "source" {
  default = "github.com/user/repo"
}