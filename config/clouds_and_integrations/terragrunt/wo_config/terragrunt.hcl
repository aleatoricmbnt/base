terraform {
  source = "../w_config" 
}

remote_state {
  backend = "gcs"
  config = {
    bucket         = "terragrunt-tofu-state"
    prefix         = "${path_relative_to_include()}"
  }
}

inputs = {
  input = "w/o config input"
}