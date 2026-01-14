# Advanced test file for terraform-tofutest-basic module
# This tests more complex scenarios including variable overrides and state changes

variables {
  environment  = "staging"
  trigger_value = "test-run-1"
  tags = {
    Project = "Testing"
    Team    = "Platform"
  }
}

run "verify_custom_environment" {
  command = plan

  # Test with custom environment
  assert {
    condition     = var.environment == "staging"
    error_message = "Environment should be 'staging'"
  }

  assert {
    condition     = output.environment == "staging"
    error_message = "Output environment should match input"
  }
}

run "verify_custom_config_with_tags" {
  command = apply

  # Verify that custom tags are passed through
  assert {
    condition     = output.config.tags["Project"] == "Testing"
    error_message = "Config should contain Project tag"
  }

  assert {
    condition     = output.config.tags["Team"] == "Platform"
    error_message = "Config should contain Team tag"
  }

  assert {
    condition     = output.config.trigger == "test-run-1"
    error_message = "Config should contain correct trigger value"
  }
}

run "verify_computed_id_changes_with_environment" {
  command = apply

  # Verify computed ID uses the custom environment
  assert {
    condition     = length(regexall("^staging-[a-f0-9]{8}$", output.computed_id)) > 0
    error_message = "Computed ID should match pattern 'staging-XXXXXXXX'"
  }
}

# Test with different trigger value in a separate run
run "verify_trigger_changes_config" {
  command = apply

  variables {
    environment   = "staging"
    trigger_value = "test-run-2"
    tags = {
      Project = "Testing"
      Team    = "Platform"
    }
  }

  # Verify that changing trigger_value updates the output
  assert {
    condition     = output.config.trigger == "test-run-2"
    error_message = "Config should reflect new trigger value"
  }
}

# Test production-like scenario
run "verify_production_config" {
  command = plan

  variables {
    environment   = "prod"
    trigger_value = "v1.0.0"
    tags = {
      Environment = "production"
      CostCenter  = "engineering"
      Compliance  = "required"
    }
  }

  assert {
    condition     = var.environment == "prod"
    error_message = "Should accept prod environment"
  }

  assert {
    condition     = length(var.tags) == 3
    error_message = "Should have 3 tags configured"
  }
}

# Test edge case: empty tags
run "verify_empty_tags" {
  command = apply

  variables {
    environment   = "dev"
    trigger_value = "empty-tags-test"
    tags          = {}
  }

  assert {
    condition     = length(output.config.tags) == 0
    error_message = "Empty tags should be handled correctly"
  }
}

# Test complex trigger value
run "verify_complex_trigger_value" {
  command = apply

  variables {
    environment   = "test"
    trigger_value = "feature/SCALR-12345-some-complex-feature-name"
    tags = {
      Branch = "feature"
      Ticket = "SCALR-12345"
    }
  }

  assert {
    condition     = output.config.trigger == "feature/SCALR-12345-some-complex-feature-name"
    error_message = "Complex trigger values should be preserved"
  }

  # Verify computed ID is still valid format even with complex trigger
  assert {
    condition     = length(regexall("^test-[a-f0-9]{8}$", output.computed_id)) > 0
    error_message = "Computed ID should still be valid with complex trigger"
  }
}
