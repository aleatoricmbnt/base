data "scalr_module_version" "can_get_modver" {
  source  = var.read_module_path
  version = var.read_module_version
}

output "success_modver" {
  value = "${data.scalr_module_version.can_get_modver.id}"
}

resource "null_resource" "cat_get_users" {
  provisioner "local-exec" {
    command = "curl --request GET --url \"https:///$${SCALR_HOSTNAME}/api/iacp/v3/users\" --header 'Prefer: profile=preview' --header 'accept: application/vnd.api+json' --header \"authorization: Bearer $${SCALR_TOKEN}\" > response_users.json"
  }
}

# data "local_file" "name2" {
#   filename = "./response_users.json"
#   depends_on = [ null_resource.cat_get_users ]
# }

# output "users" {
#   value = data.local_file.name2.content
# }

data "scalr_variable" "can_read_var" {
  id         = var.read_var_id
}

output "read_var" {
  value = data.scalr_variable.can_read_var.key
}