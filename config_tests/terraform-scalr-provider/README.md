# Scalr Provider Account ID Deprecation Testing

This Terraform configuration is designed to test the deprecation of the `account_id` attribute across all Scalr provider resources and data sources.

## Purpose

This test plan validates that all Scalr Terraform provider resources and data sources function correctly without the `account_id` attribute, ensuring backward compatibility during the deprecation process.

## Resources and Data Sources Tested

### Resources (29 total)
- ✅ `scalr_access_policy`
- ✅ `scalr_agent_pool`
- ✅ `scalr_agent_pool_token`
- ✅ `scalr_assume_service_account_policy`
- ✅ `scalr_environment`
- ✅ `scalr_environment_hook`
- ✅ `scalr_endpoint`
- ✅ `scalr_hook`
- ✅ `scalr_iam_team`
- ✅ `scalr_module`
- ✅ `scalr_module_namespace`
- ✅ `scalr_policy_group`
- ✅ `scalr_policy_group_linkage`
- ✅ `scalr_provider_configuration`
- ✅ `scalr_provider_configuration_default`
- ✅ `scalr_role`
- ✅ `scalr_run_schedule_rule`
- ✅ `scalr_run_trigger`
- ✅ `scalr_service_account`
- ✅ `scalr_service_account_token`
- ✅ `scalr_ssh_key`
- ✅ `scalr_storage_profile`
- ✅ `scalr_tag`
- ✅ `scalr_variable`
- ✅ `scalr_vcs_provider`
- ✅ `scalr_webhook`
- ✅ `scalr_workload_identity_provider`
- ✅ `scalr_workspace`
- ✅ `scalr_workspace_run_schedule`

### Conditional Resources (commented out - require external integrations)
- `scalr_event_bridge_integration` (requires AWS EventBridge setup)
- `scalr_integration_infracost` (requires Infracost API key)
- `scalr_slack_integration` (requires Slack bot token)

### Data Sources (25 total)
- ✅ `scalr_access_policy`
- ✅ `scalr_agent_pool`
- ✅ `scalr_assume_service_account_policy`
- ✅ `scalr_current_account`
- ✅ `scalr_current_run`
- ✅ `scalr_endpoint`
- ✅ `scalr_environment`
- ✅ `scalr_environments`
- ✅ `scalr_hook`
- ✅ `scalr_iam_team`
- ✅ `scalr_iam_user`
- ✅ `scalr_module_version`
- ✅ `scalr_module_versions`
- ✅ `scalr_policy_group`
- ✅ `scalr_provider_configuration`
- ✅ `scalr_provider_configurations`
- ✅ `scalr_role`
- ✅ `scalr_service_account`
- ✅ `scalr_ssh_key`
- ✅ `scalr_storage_profile`
- ✅ `scalr_tag`
- ✅ `scalr_variable`
- ✅ `scalr_variables`
- ✅ `scalr_vcs_provider`
- ✅ `scalr_webhook`
- ✅ `scalr_workload_identity_provider`
- ✅ `scalr_workspace`
- ✅ `scalr_workspace_ids`
- ✅ `scalr_workspaces`

## Usage

### Prerequisites

1. Set up Scalr authentication:
```bash
export SCALR_HOSTNAME="your-account.scalr.io"
export SCALR_TOKEN="your-scalr-api-token"
```

### Running the Test

1. Initialize Terraform:
```bash
terraform init
```

2. Plan the configuration:
```bash
terraform plan
```

3. Apply the configuration (if plan succeeds):
```bash
terraform apply
```

4. Verify outputs and check for any errors related to missing `account_id` attributes.

### Expected Behavior

- ✅ All resources and data sources should function without requiring `account_id`
- ✅ No deprecation warnings should appear for missing `account_id` attributes
- ✅ Resources should be created/read successfully using implicit account context
- ❌ Any errors indicating missing `account_id` should be flagged as test failures

## Test Scenarios

1. **Resource Creation**: Verify all resources can be created without `account_id`
2. **Data Source Queries**: Verify all data sources can retrieve data without `account_id`
3. **Resource Dependencies**: Verify cross-resource references work without `account_id`
4. **Provider Authentication**: Verify account context is automatically inferred

## Notes

- Some resources require external service configurations (AWS EventBridge, Infracost, Slack)
- Dummy values are used for testing where actual service integrations aren't available
- The configuration includes dependency ordering to ensure successful resource creation
- All sensitive variables are marked as such and use dummy values for testing

## Cleanup

To remove all test resources:
```bash
terraform destroy
```

## Reporting Issues

If any resource or data source fails due to missing `account_id`, document:
1. Resource/data source name
2. Error message
3. Terraform provider version
4. Expected vs. actual behavior
