terraform {
  required_providers {
    scalr = {
      source  = "registry.main.scalr.dev/scalr/scalr"
      version= "1.0.0-rc-SCALRCORE-33574"
    }
  }
}

data "scalr_current_run" "example" {}

resource "scalr_slack_integration" "test" {
  name         = "my-channel"
  events       = ["run_approval_required", "run_success", "run_errored"]
  run_mode     = "apply"
  channel_id   = "C04US2BVBLP" 
  environments = ["env-v0ohtvdn9bjltg2fb"]
  workspaces   = ["ws-v0p0pv1c5hg0or2hv"] 
}
