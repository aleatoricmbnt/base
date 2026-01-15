terraform {
  required_providers {
    scalr = {
      source = "registry.main.scalr.dev/scalr/scalr"
      version= "1.0.0-rc-release-3.12.0"
    }
  }
}

# -------------------- ENV 1 SETUP --------------------

resource "scalr_environment" "dd_env_type_filter" {
  name = "dd_env_type_filter"
}

resource "scalr_workspace" "type_testing_ws" {
  name = "type_testing_ws"
  environment_id = scalr_environment.dd_env_type_filter.id
  type = "testing"
}

resource "scalr_workspace" "type_staging_ws" {
  name = "staging_type_ws"
  environment_id = scalr_environment.dd_env_type_filter.id
  type = "staging"
}

resource "scalr_drift_detection" "weekly_dd_env_type_filter_refresh_only" {
  environment_id = scalr_environment.dd_env_type_filter.id
  check_period   = "weekly"
  workspace_filters {
    environment_types = ["testing"]
  }
  run_mode = "refresh-only"
}

# -------------------- ENV 2 SETUP --------------------

resource "scalr_environment" "dd_tag_filter" {
  name = "dd_tag_filter"
}

resource "scalr_tag" "e2e_tag_1" {
  name = "e2e_tag_1"
}

resource "scalr_tag" "e2e_tag_2" {
  name = "e2e_tag_2"
}

resource "scalr_workspace" "tag_ws_1" {
  name = "tag_ws_1"
  environment_id = scalr_environment.dd_tag_filter.id
  tag_ids = [scalr_tag.e2e_tag_1.id]
}

resource "scalr_workspace" "tag_ws_2" {
  name = "tag_ws_2"
  environment_id = scalr_environment.dd_tag_filter.id
  tag_ids = [scalr_tag.e2e_tag_2.id]
}

resource "scalr_workspace" "no_tag_ws" {
  name = "no_tag_ws"
  environment_id = scalr_environment.dd_tag_filter.id
}

resource "scalr_drift_detection" "weekly_dd_tag_filter_refresh_only" {
  environment_id = scalr_environment.dd_tag_filter.id
  check_period   = "weekly"
  workspace_filters {
    tags = [scalr_tag.e2e_tag_1.id, scalr_tag.e2e_tag_2.id]
  }
  # by default run_mode is refresh-only
}

# -------------------- ENV 3 SETUP --------------------

resource "scalr_environment" "dd_name_pattern_filter" {
  name = "dd_name_pattern_filter"
}

resource "scalr_workspace" "name_testing_ws" {
  name = "testing_ws"
  environment_id = scalr_environment.dd_name_pattern_filter.id
}

resource "scalr_workspace" "name_staging_ws" {
  name = "staging_ws"
  environment_id = scalr_environment.dd_name_pattern_filter.id
}

resource "scalr_drift_detection" "weekly_dd_name_pattern_filter_refresh_only" {
  environment_id = scalr_environment.dd_name_pattern_filter.id
  check_period   = "weekly"
  workspace_filters {
    name_patterns = ["testing_*"]
  }
  run_mode = "plan"
}
