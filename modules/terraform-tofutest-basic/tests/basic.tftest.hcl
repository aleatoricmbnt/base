# Basic test file for terraform-tofutest-basic module
# This tests basic functionality with default values

run "verify_default_environment" {
  command = plan

  # Test that the module uses default values correctly
  assert {
    condition     = var.environment == "dev"
    error_message = "Default environment should be 'dev'"
  }

  assert {
    condition     = var.trigger_value == "initial"
    error_message = "Default trigger_value should be 'initial'"
  }
}

run "verify_outputs_exist" {
  command = apply

  # Verify that all expected outputs are present
  assert {
    condition     = output.timestamp != null
    error_message = "Timestamp output should not be null"
  }

  assert {
    condition     = output.config != null
    error_message = "Config output should not be null"
  }

  assert {
    condition     = output.computed_id != null
    error_message = "Computed ID output should not be null"
  }

  assert {
    condition     = output.environment == "dev"
    error_message = "Environment output should be 'dev'"
  }
}

run "verify_config_structure" {
  command = apply

  # Verify that config output has the expected structure
  assert {
    condition     = output.config.environment == "dev"
    error_message = "Config should contain correct environment"
  }

  assert {
    condition     = output.config.trigger == "initial"
    error_message = "Config should contain correct trigger value"
  }
}

run "verify_computed_id_format" {
  command = apply

  # Verify that computed_id follows expected format
  assert {
    condition     = length(regexall("^dev-[a-f0-9]{8}$", output.computed_id)) > 0
    error_message = "Computed ID should match pattern 'dev-XXXXXXXX' where X is hex"
  }
}
