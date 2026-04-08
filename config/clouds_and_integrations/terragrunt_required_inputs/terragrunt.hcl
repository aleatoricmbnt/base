remote_state {
  backend = "gcs"
  config = {
    bucket         = "terragrunt-tofu-state"
    prefix         = "${path_relative_to_include()}"
    project = "personal-playground-437910"
  }
}

terraform {
  source = "./module/"
}

inputs = {}
