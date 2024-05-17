variable "map_object" {
  type = map(object({
    cidr     = string
    zone     = string
    tags     = map(string)
    cidr_app = string
    gw_app   = string
    cidr_db  = string
    gw_db    = string
  }))
}

resource "null_resource" "map_object" {
  provisioner "local-exec" {
    command = "echo ${var.map_object.AIMS.cidr}"
  }
  triggers = var.map_object.AIMS.tags
}