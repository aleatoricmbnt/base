terraform {
  required_providers {
    scalr = {
      source  = "registry.main.scalr.dev/scalr/scalr"
      version= "1.0.0-rc-SCALRCORE-33574"
    }
  }
}

resource "scalr_drift_detection" "prod" {
  environment_id = "env-123456789"
  # check_period   = "daily" # or weekly
}
