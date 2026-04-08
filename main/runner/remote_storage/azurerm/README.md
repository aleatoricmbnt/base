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


## Test Configuration

The test uses the following backend configuration:
- **Resource Group**: `tfstate`
- **Storage Account**: `tfstate12877` (update as needed)
- **Container**: `tfstate`
- **State File**: `terraform.tfstate`

Update the `backend.tf` file with your actual storage account name.
