data "terraform_remote_state" "rs_tf-var-types" {
  backend = "remote"

  config = {
    hostname     = var.remote_state_hostname
    organization = var.remote_state_organization
    workspaces = {
      name = var.remote_state_workspace_name
    }
  }
}

locals {
  non_sensitive_list_output = data.terraform_remote_state.rs_tf-var-types.outputs.non_sensitive_list_output
  non_sensitive_list_untyped_output = data.terraform_remote_state.rs_tf-var-types.outputs.non_sensitive_list_untyped_output
  non_sensitive_map_output = data.terraform_remote_state.rs_tf-var-types.outputs.non_sensitive_map_output
  non_sensitive_map_untyped_output = data.terraform_remote_state.rs_tf-var-types.outputs.non_sensitive_map_untyped_output
  non_sensitive_object_output = data.terraform_remote_state.rs_tf-var-types.outputs.non_sensitive_object_output
  non_sensitive_object_untyped_output = data.terraform_remote_state.rs_tf-var-types.outputs.non_sensitive_object_untyped_output
  non_sensitive_set_output = data.terraform_remote_state.rs_tf-var-types.outputs.non_sensitive_set_output
  non_sensitive_set_untyped_output = data.terraform_remote_state.rs_tf-var-types.outputs.non_sensitive_set_untyped_output
  non_sensitive_simple_output = data.terraform_remote_state.rs_tf-var-types.outputs.non_sensitive_simple_output
  non_sensitive_tuple_output = data.terraform_remote_state.rs_tf-var-types.outputs.non_sensitive_tuple_output
  non_sensitive_tuple_untyped_output = data.terraform_remote_state.rs_tf-var-types.outputs.non_sensitive_tuple_untyped_output
  sensitive_output = data.terraform_remote_state.rs_tf-var-types.outputs.sensitive_output
}

resource "terraform_data" "this" {
  input = timestamp()
}

output "non_sensitive_list_output" {
  value = local.non_sensitive_list_output
}

output "non_sensitive_list_untyped_output" {
  value = local.non_sensitive_list_untyped_output
}

output "non_sensitive_map_output" {
  value = local.non_sensitive_map_output
}

output "non_sensitive_map_untyped_output" {
  value = local.non_sensitive_map_untyped_output
}

output "non_sensitive_object_output" {
  value = local.non_sensitive_object_output
}

output "non_sensitive_object_untyped_output" {
  value = local.non_sensitive_object_untyped_output
}

output "non_sensitive_set_output" {
  value = local.non_sensitive_set_output
}

output "non_sensitive_set_untyped_output" {
  value = local.non_sensitive_set_untyped_output
}

output "non_sensitive_simple_output" {
  value = local.non_sensitive_simple_output
}

output "non_sensitive_tuple_output" {
  value = local.non_sensitive_tuple_output
}

output "non_sensitive_tuple_untyped_output" {
  value = local.non_sensitive_tuple_untyped_output
}

output "sensitive_output" {
  value     = local.sensitive_output
}

