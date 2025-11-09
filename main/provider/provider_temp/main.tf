terraform {
  required_providers {
    scalr = {
      source  = "registry.main.scalr.dev/scalr/scalr"
      version= "1.0.0-rc-SCALRCORE-33574"
    }
  }
}

data "scalr_current_run" "example" {}

resource "scalr_drift_detection" "example" {
  environment_id = [data.scalr_current_run.example.environment_id]
  check_period   = ["weekly"] # or weekly
}
