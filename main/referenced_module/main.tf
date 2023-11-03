module "referenced" {
  count = var.count
  source = var.source
  version = var.version
}

variable "count" {
  type = number
  description = "The number of modules to be created"
}

variable "source" {
  type = string
  description = "The link to your Scalr module"
}

variable "version" {
  type = string
  description = "The version of your Scalr module"
}