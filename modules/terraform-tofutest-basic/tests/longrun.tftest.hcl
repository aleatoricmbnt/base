# Long-running test to verify timeout handling
# This test intentionally takes more than 5 minutes to complete

variables {
  environment   = "longrun"
  trigger_value = "timeout-test"
  # Set to 6 minutes (360 seconds) to exceed typical 5-minute timeout
  sleep_duration = "360s"
}

run "long_running_test" {
  command = apply
  
  assert {
    condition     = var.sleep_duration == "360s"
    error_message = "Sleep duration should be 360s (6 minutes)"
  }

  assert {
    condition     = output.environment == "longrun"
    error_message = "Environment should be 'longrun'"
  }

  assert {
    condition     = output.completion_info != null
    error_message = "Should complete after sleep duration"
  }

  assert {
    condition     = output.completion_info.waited_for == "360s"
    error_message = "Should have waited for configured duration"
  }
}
