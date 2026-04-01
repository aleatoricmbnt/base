# Remote modules: different download paths (HTTPS git, SSH git, public registry).
module "flat_https" {
  source = "github.com/aleatoricmbnt/flat/"
}

module "flat_ssh" {
  source = "git@github.com:aleatoricmbnt/flat.git"
}

module "hashicorp_registry_label" {
  source = "cloudposse/label/null"

  enabled     = true
  namespace   = "qa"
  environment = "mshytse"
  stage       = "test"
  name        = "example"
  attributes  = ["attr1", "attr2"]
  tags = {
    "executor" = "scalr-run"
  }
}

# Local modules: one trivial resource each (no cloud), distinct providers.
module "mod_random" {
  source = "./modules/mod_random"

  string_length = var.random_string_length
  special       = var.random_special
}

module "mod_null" {
  source = "./modules/mod_null"

  trigger_seed = var.null_trigger_seed
}

module "mod_terraform_data" {
  source = "./modules/mod_terraform_data"

  input_label = var.terraform_data_label
}

module "mod_time" {
  source = "./modules/mod_time"

  rotation_days = var.time_rotation_days
}

module "mod_tls" {
  source = "./modules/mod_tls"

  rsa_bits = var.tls_rsa_bits
}
