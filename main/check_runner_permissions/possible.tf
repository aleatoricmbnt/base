# data "scalr_environment" "possibly_read_env" {
#   id         = var.read_env_2_id
# }

# output "possible_env" {
#   value = data.scalr_environment.possibly_read_env.cost_estimation_enabled
# }


# data "scalr_workspaces" "possibly_read_ws" {
#   name = "like:cli"
# }

# output "possible_ws" {
#   value = join(",", data.scalr_workspaces.possibly_read_ws[*].id)
# }

resource "null_resource" "possibly_get_state" {
  triggers = {
    time = timestamp()
  }
  provisioner "local-exec" {
    command = "curl --request GET --url \"https:///$SCALR_HOSTNAME/api/iacp/v3/state-versions/${var.read_state_id}\" --header 'Prefer: profile=preview' --header 'accept: application/vnd.api+json' --header \"authorization: Bearer $${SCALR_TOKEN}\" > response.json"
  }
}

data "local_file" "name" {
  filename = "./response.json"
  depends_on = [ null_resource.possibly_get_state ]
}

output "state" {
  value = data.local_file.name.content
}

data "terraform_remote_state" "vlad" {
  backend = "remote"

  config = {
    hostname = "test.mvsession.testenv.scalr.dev"
    organization = "env-v0o8t3gcnn3ffh59k"
    workspaces = {
      name = "new_state"
    }
  }
}


# data "scalr_variable" "possibly_read_var_2" {
#   id         = var.read_var_2_id
# }

# output "possibly_read_var_2" {
#   value = data.scalr_variable.possibly_read_var_2.key
# }