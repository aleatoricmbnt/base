module "referenced" {
  count = var.count-mod
  source = var.source-mod
  version = var.version-mod
}

variable "count-mod" {
  type = number
  description = "The number of modules to be created"
}

variable "source-mod" {
  type = string
  description = "The link to your Scalr module"
}

variable "version-mod" {
  type = string
  description = "The version of your Scalr module"
}