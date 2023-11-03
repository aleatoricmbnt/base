module "referenced" {
  source = var.source
  version = var.version
}

variable "source" {
  type = string
  description = "The link to your Scalr module"
}

variable "version" {
  type = string
  description = "The version of your Scalr module"
}