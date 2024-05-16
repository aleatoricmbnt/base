variable "locations" {
  type = map(object({
    cidr     = string
    zone     = string
    tags     = map(string)
    cidr_app = string
    gw_app   = string
    cidr_db  = string
    gw_db    = string
  }))
  default = {

  }
}

resource "null_resource" "null1" {
  provisioner "local-exec" {
    command = "echo ${var.locations.AIMS.cidr}"
  }
  triggers = {
    time = timestamp()
  }
}

resource "random_password" "password" {
  length           = var.length-hcl
  special          = var.bool-hcl
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

variable "length-hcl" {
  type = number
}

variable "bool-hcl" {
  type = bool
}

