data "scalr_vcs_provider" "cannot_read_vcs" {
  id = var.read_vcs_id
}

resource "scalr_module" "cannot_create_module" {
  environment_id  = var.read_env_id
  vcs_provider_id = var.read_vcs_id
  vcs_repo {
    identifier = var.module_vcs-repo_identifier
    path       = var.module_vcs-repo_path
    tag_prefix = var.module_vcs-repo_tag-prefix
  }
}

resource "scalr_vcs_provider" "cannot_create_vcs" {
  name     = "vcs_${formatdate("DDMMYYYY", timestamp())}"
  vcs_type = var.base_vcs_type
  token    = var.base_vcs_token
}

resource "scalr_variable" "cannot_create_variable" {
  key          = "my_key_name"
  value        = "my_value_name"
  category     = "terraform"
  description  = "variable description"
}

resource "scalr_environment" "cannot_create_env" {
  name                    = "some_env_${formatdate("DDMMYYYY", timestamp())}"
  cost_estimation_enabled = false
}

