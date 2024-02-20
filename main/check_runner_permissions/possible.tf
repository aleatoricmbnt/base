data "scalr_environment" "possibly_read_env" {
  id         = var.read_env_2_id
  depends_on = [ null_resource.cat_get_users ]
}

output "possible_env" {
  value = data.scalr_environment.possibly_read_env.cost_estimation_enabled
}


data "scalr_workspaces" "possibly_read_ws" {
  name = "like:cli"
  depends_on = [ null_resource.cat_get_users ]
}

output "possible_ws" {
  value = join(",", data.scalr_workspaces.possibly_read_ws[*].id)
}

resource "null_resource" "possibly_get_state" {
  provisioner "local-exec" {
    command = "curl --request GET --url \"https:///$SCALR_HOSTNAME/api/iacp/v3/state-versions/${var.read_state_id}\" --header 'Prefer: profile=preview' --header 'accept: application/vnd.api+json' --header \"authorization: Bearer $${SCALR_TOKEN}\""
  }
  depends_on = [ null_resource.cat_get_users ]
}

data "scalr_variables" "possibly_read_vars" {
  keys             = ["key1", "key2", "key3"]
  category         = "terraform" # or shell
  environment_ids = ["${var.read_env_2_id}", "null"]
  depends_on = [ null_resource.cat_get_users ]
}

output "possible_vars" {
  value = join(",", data.scalr_variables.possibly_read_vars[*].values)
}