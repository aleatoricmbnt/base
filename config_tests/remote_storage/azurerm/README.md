# Azure Backend Storage Testing

This directory contains test configurations for testing Terraform's Azure backend storage functionality.

## Prerequisites

### Azure Resources Setup

Before testing, you need to configure the required Azure resources. Follow the official Microsoft documentation:

**📖 [Store Terraform state in Azure Storage](https://learn.microsoft.com/en-us/azure/developer/terraform/store-state-in-azure-storage?tabs=azure-cli)**

The documentation provides step-by-step instructions for:
- Creating an Azure Storage Account
- Setting up a blob container for state storage
- Configuring authentication and access keys

### Authentication Setup

**⚠️ Personal Note**: Set the `ARM_ACCESS_KEY` environment variable with the storage account access key. The key is stored in the password manager.

```bash
export ARM_ACCESS_KEY="your_storage_account_access_key"
```

For PowerShell:
```powershell
$env:ARM_ACCESS_KEY="your_storage_account_access_key"
```

## Test Configuration

The test uses the following backend configuration:
- **Resource Group**: `tfstate`
- **Storage Account**: `tfstate12877` (update as needed)
- **Container**: `tfstate`
- **State File**: `terraform.tfstate`

Update the `backend.tf` file with your actual storage account name.

## Common Test Scenarios

### Core Azure Backend Tests

### 1. Basic State Storage
Test basic state file creation and storage in Azure blob storage.
```bash
terraform init
terraform plan
terraform apply
```
**Expected**: State file should be created in the Azure blob container.

### 2. State Locking
Test concurrent operations to verify state locking functionality.
```bash
# Terminal 1
terraform apply &
# Terminal 2 (run immediately)
terraform apply
```
**Expected**: Second operation should wait for the first to complete due to state locking.

### 3. State Retrieval
Test state retrieval after clearing local state.
```bash
# Remove local state
rm -rf .terraform/
rm terraform.tfstate*
# Reinitialize and verify state is retrieved from Azure
terraform init
terraform show
```
**Expected**: State should be retrieved from Azure backend and resources should be visible.

### 4. State Migration
Test migrating from local state to Azure backend.
```bash
# Start with local backend, create resources
terraform init
terraform apply
# Update backend configuration to Azure
# Migrate state
terraform init -migrate-state
```
**Expected**: Local state should be migrated to Azure backend.

### 5. Backend Configuration Changes
Test changing backend configuration parameters.
```bash
# Change key name in backend.tf (e.g., from "terraform.tfstate" to "test.tfstate")
terraform init -reconfigure
```
**Expected**: New state file should be created with the new key name.

### 6. Access Key Rotation
Test behavior when access key is rotated/changed.
```bash
# Use invalid/old access key
export ARM_ACCESS_KEY="invalid_key"
terraform plan
```
**Expected**: Should fail with authentication error.

### 7. Network Connectivity Issues
Test behavior when Azure is unreachable.
```bash
# Block Azure endpoints (if testing in controlled environment)
# Or test with invalid storage account name
terraform plan
```
**Expected**: Should fail with connectivity/authentication errors.

### 8. Large State Files
Test with configurations that create large state files.
```bash
# Use the existing configuration with large attributes
terraform apply
# Check state file size in Azure portal
```
**Expected**: Large state files should be handled properly.

### 9. State Corruption Recovery
Test recovery from corrupted state scenarios.
```bash
# Manually corrupt the state file in Azure (for testing)
# Attempt operations
terraform plan
terraform refresh
```
**Expected**: Should detect corruption and provide recovery options.

### 10. Multiple Workspaces
Test workspace functionality with Azure backend.
```bash
terraform workspace new test
terraform workspace select test
terraform apply
terraform workspace select default
```
**Expected**: Each workspace should have separate state files in Azure.

### Scalr VCS Workspace Specific Tests

### 11. VCS Integration and Auto-Triggering
Test VCS repository integration with automatic run triggering.
```bash
# Set up Scalr workspace with VCS integration
# Make a commit to the linked repository
git add .
git commit -m "test trigger"
git push origin main
```
**Expected**: Scalr should automatically queue and execute a run upon detecting the commit.

### 12. State Migration to Scalr Remote Backend
Test migrating existing Azure state to Scalr's remote backend.
```bash
# Update backend configuration from azurerm to remote (Scalr)
# Migrate state
terraform init -migrate-state
```
**Expected**: State should be successfully migrated to Scalr without data loss.

### 13. Cross-Workspace State Sharing
Test the ability to share state outputs between Scalr workspaces.
```bash
# In workspace A: Create outputs
# In workspace B: Use terraform_remote_state data source
data "terraform_remote_state" "workspace_a" {
  backend = "remote"
  config = {
    hostname     = "your-account.scalr.io"
    organization = "env-xxxxx"
    workspaces = {
      name = "workspace-a"
    }
  }
}
```
**Expected**: Workspace B should successfully read outputs from workspace A.

### 14. VCS Trigger Patterns
Test VCS trigger patterns for selective run triggering.
```bash
# Configure trigger patterns in Scalr workspace:
# *.tf
# !*.tfstate
# !test/*
# Push changes to different file types and directories
```
**Expected**: Runs should only trigger for files matching the patterns.

### 15. VCS Branch-Based Runs
Test running configurations from different VCS branches.
```bash
# Create feature branch
git checkout -b feature/test-branch
# Make changes and push
git push origin feature/test-branch
# Configure Scalr workspace to use this branch
```
**Expected**: Runs should execute using the configuration from the specified branch.

### 16. VCS Comments for Run Approval
Test approving/declining runs via VCS pull request comments.
```bash
# Create a pull request that triggers a run
# Use Scalr commands in PR comments:
# /scalr plan
# /scalr apply
# /scalr discard
```
**Expected**: Runs should be controlled via VCS comments as specified.

### 17. Working Directory Configuration
Test workspace working directory with subdirectory configurations.
```bash
# Configure Scalr workspace with working_directory = "terraform/infrastructure"
# Push changes to different directories
# Verify only changes in the working directory trigger runs
```
**Expected**: Only changes within the specified working directory should trigger runs.

### 18. Scalr Variables Integration
Test Scalr-managed variables with Azure backend.
```bash
# Set variables in Scalr UI (environment, workspace, terraform variables)
# Run terraform with Azure backend
# Verify variables are properly injected
```
**Expected**: Scalr variables should be available during Terraform execution.

### 19. Provider Configuration Integration
Test Scalr provider configurations with Azure backend.
```bash
# Configure Azure provider settings in Scalr
# Run workspace with Azure backend
# Verify provider authentication works correctly
```
**Expected**: Azure provider should authenticate using Scalr-managed credentials.

### 20. Run Triggers and Dependencies
Test upstream/downstream workspace dependencies.
```bash
# Configure run trigger: Workspace A → Workspace B
# Apply changes in Workspace A
# Verify Workspace B automatically triggers
```
**Expected**: Downstream workspace should automatically trigger after upstream completion.

### 21. Scheduled Runs with Azure Backend
Test scheduled run functionality.
```bash
# Configure run schedule in Scalr workspace
# Verify scheduled runs execute properly with Azure backend
# Check state consistency across scheduled runs
```
**Expected**: Scheduled runs should execute successfully and maintain state consistency.

### 22. State Locking in Scalr Multi-User Environment
Test state locking with multiple Scalr users.
```bash
# User 1: Start a long-running apply
# User 2: Attempt to queue another run
# Verify proper queuing and locking behavior
```
**Expected**: Runs should queue properly and execute sequentially.

### 23. Scalr Hooks Integration
Test pre-plan and post-plan hooks with Azure backend.
```bash
# Configure hooks in Scalr workspace
# Execute runs and verify hook execution
# Check hook outputs and state consistency
```
**Expected**: Hooks should execute at appropriate phases without affecting state integrity.

### 24. Cost Estimation with Azure Resources
Test Scalr cost estimation for Azure resources.
```bash
# Enable cost estimation in Scalr environment
# Run terraform plan with Azure resources
# Verify cost estimates are generated
```
**Expected**: Cost estimates should be provided for planned Azure resources.

### 25. Policy Enforcement (OPA)
Test Open Policy Agent (OPA) policy enforcement.
```bash
# Configure OPA policies in Scalr
# Run terraform plan that violates/complies with policies
# Verify policy enforcement behavior
```
**Expected**: Policies should be enforced correctly, blocking non-compliant runs.

### 26. Agent Pool Execution
Test workspace execution using Scalr agent pools.
```bash
# Configure workspace to use specific agent pool
# Execute runs and verify they run on designated agents
# Test network connectivity to Azure from agent pool
```
**Expected**: Runs should execute on specified agent pool with proper Azure connectivity.

### 27. State Backup and Versioning
Test Scalr's state versioning and backup capabilities.
```bash
# Make multiple changes to infrastructure
# Access state versions in Scalr UI
# Test state rollback functionality
```
**Expected**: Multiple state versions should be maintained with rollback capability.

### 28. Environment-Level Variables Inheritance
Test variable inheritance from environment to workspace.
```bash
# Set variables at environment level
# Create workspace without overriding variables
# Verify environment variables are inherited
```
**Expected**: Workspace should inherit and use environment-level variables.

### 29. Module Registry Integration
Test using Scalr private module registry with Azure backend.
```bash
# Publish module to Scalr registry
# Use module in workspace configuration
# Execute runs and verify module functionality
```
**Expected**: Private modules should be accessible and function correctly.

### 30. Drift Detection
Test Scalr's drift detection capabilities.
```bash
# Apply infrastructure via Scalr
# Manually modify resources outside of Terraform
# Trigger drift detection in Scalr
```
**Expected**: Drift should be detected and reported accurately.

## Verification Steps

After each test scenario:

1. **Check Azure Portal**: Verify state file exists in the blob container
2. **Inspect State Content**: Download and verify state file contents
3. **Check Locks**: Verify lock files are created/removed appropriately
4. **Monitor Logs**: Check Terraform logs for backend-related messages
5. **Validate Resources**: Ensure actual Azure resources match state

## Troubleshooting

### Common Issues

1. **Authentication Errors**
   - Verify `ARM_ACCESS_KEY` is set correctly
   - Check storage account access permissions

2. **State Lock Timeout**
   - Check for stuck lock files in Azure
   - Manually remove lock if necessary

3. **Network Issues**
   - Verify Azure connectivity
   - Check firewall/proxy settings

4. **State File Not Found**
   - Verify backend configuration parameters
   - Check container and key names

### Useful Commands

```bash
# Force unlock (use with caution)
terraform force-unlock <lock-id>

# Show backend configuration
terraform init -backend-config-file=backend.hcl

# Reconfigure backend
terraform init -reconfigure

# Debug backend operations
TF_LOG=DEBUG terraform init
```

## Notes

- Always backup state files before testing destructive scenarios
- Use separate test storage accounts to avoid affecting production state
- Monitor Azure storage costs during extensive testing
- Test with different Azure regions for geo-distributed scenarios
