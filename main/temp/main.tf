resource "terraform_data" "this" {
  count = var.quantity
  input = <<EOT
<= data "aws_iam_policy_document" "kms_kubra" {
      + id   = (known after apply)
      + json = (known after apply)
      + statement {
          + actions   = [
              + "kms:*",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "Enable IAM User Permissions"
          + principals {
              + identifiers = [
                  + "arn:aws:iam::707589232221:root",
                ]
              + type        = "AWS"
            }
        }
      + statement {
          + actions   = [
              + "kms:Decrypt*",
              + "kms:Describe*",
              + "kms:Encrypt*",
              + "kms:GenerateDataKey*",
              + "kms:ReEncrypt*",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "AllowCloudWatchLogs"
          + condition {
              + test     = "ArnEquals"
              + values   = [
                  + "arn:aws:logs:us-east-1:707589232221:*",
                ]
              + variable = "kms:EncryptionContext:aws:logs:arn"
            }
          + principals {
              + identifiers = [
                  + "logs.us-east-1.amazonaws.com",
                ]
              + type        = "Service"
            }
        }
      + statement {
          + actions   = [
              + "kms:Decrypt",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "AllowSecretsManager"
          + condition {
              + test     = "StringEquals"
              + values   = [
                  + "707589232221",
                ]
              + variable = "kms:CallerAccount"
            }
          + condition {
              + test     = "StringEquals"
              + values   = [
                  + "secretsmanager.us-east-1.amazonaws.com",
                ]
              + variable = "kms:ViaService"
            }
          + principals {
              + identifiers = [
                  + "*",
                ]
              + type        = "AWS"
            }
        }
      + statement {
          + actions   = [
              + "kms:Decrypt*",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "AllowGlue"
          + condition {
              + test     = "StringEquals"
              + values   = [
                  + "707589232221",
                ]
              + variable = "kms:CallerAccount"
            }
          + condition {
              + test     = "StringEquals"
              + values   = [
                  + "glue.us-east-1.amazonaws.com",
                ]
              + variable = "kms:ViaService"
            }
          + principals {
              + identifiers = [
                  + "glue.amazonaws.com",
                ]
              + type        = "Service"
            }
        }
      + statement {
          + actions   = [
              + "kms:Decrypt*",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "AllowAthena"
          + condition {
              + test     = "StringEquals"
              + values   = [
                  + "707589232221",
                ]
              + variable = "kms:CallerAccount"
            }
          + condition {
              + test     = "StringEquals"
              + values   = [
                  + "athena.us-east-1.amazonaws.com",
                ]
              + variable = "kms:ViaService"
            }
          + principals {
              + identifiers = [
                  + "athena.amazonaws.com",
                ]
              + type        = "Service"
            }
        }
      + statement {
          + actions   = [
              + "kms:Decrypt",
              + "kms:GenerateDataKey",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "Allow_Balance_File_SFN_to_SNS"
          + condition {
              + test     = "ArnLike"
              + values   = [
                  + "arn:aws:sns:us-east-1:707589232221:kubra-balance-file-success",
                  + "arn:aws:sns:us-east-1:707589232221:kubra-balance-file-error",
                ]
              + variable = "kms:EncryptionContext:aws:sns:topicArn"
            }
          + principals {
              + identifiers = [
                  + "arn:aws:iam::707589232221:role/BalanceFileStepFunction-20240130210216215500000013",
                ]
              + type        = "AWS"
            }
        }
      + statement {
          + actions   = [
              + "kms:Decrypt",
              + "kms:GenerateDataKey",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "Allow_Invoices_SFN_to_SNS"
          + condition {
              + test     = "ArnLike"
              + values   = [
                  + "arn:aws:sns:us-east-1:707589232221:kubra-invoices-success",
                  + "arn:aws:sns:us-east-1:707589232221:kubra-invoices-error",
                ]
              + variable = "kms:EncryptionContext:aws:sns:topicArn"
            }
          + principals {
              + identifiers = [
                  + "arn:aws:iam::707589232221:role/InvoicesStepFunction-20240130205804582800000001",
                ]
              + type        = "AWS"
            }
        }
      + statement {
          + actions   = [
              + "kms:Decrypt",
              + "kms:GenerateDataKey",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "Allow_Recurring_SFN_to_SNS"
          + condition {
              + test     = "ArnLike"
              + values   = [
                  + "arn:aws:sns:us-east-1:707589232221:kubra-recurring-success",
                  + "arn:aws:sns:us-east-1:707589232221:kubra-recurring-error",
                ]
              + variable = "kms:EncryptionContext:aws:sns:topicArn"
            }
          + principals {
              + identifiers = [
                  + "arn:aws:iam::707589232221:role/RecurringStepFunction-20240423211506828300000001",
                ]
              + type        = "AWS"
            }
        }
      + statement {
          + actions   = [
              + "kms:Decrypt",
              + "kms:GenerateDataKey",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "Allow_Remittance_SFN_to_SNS"
          + condition {
              + test     = "ArnLike"
              + values   = [
                  + "arn:aws:sns:us-east-1:707589232221:kubra-remittance-success",
                  + "arn:aws:sns:us-east-1:707589232221:kubra-remittance-error",
                ]
              + variable = "kms:EncryptionContext:aws:sns:topicArn"
            }
          + principals {
              + identifiers = [
                  + "arn:aws:iam::707589232221:role/RemittanceStepFunction-20240130205804660200000002",
                ]
              + type        = "AWS"
            }
        }
      + statement {
          + actions   = [
              + "kms:Decrypt",
              + "kms:GenerateDataKey",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "Allow_Reports_SFN_to_SNS"
          + condition {
              + test     = "ArnLike"
              + values   = [
                  + "arn:aws:sns:us-east-1:707589232221:kubra-reports-success",
                  + "arn:aws:sns:us-east-1:707589232221:kubra-reports-error",
                ]
              + variable = "kms:EncryptionContext:aws:sns:topicArn"
            }
          + principals {
              + identifiers = [
                  + "arn:aws:iam::707589232221:role/ReportsStepFunction-20240412185340434700000001",
                ]
              + type        = "AWS"
            }
        }
      + statement {
          + actions   = [
              + "kms:Decrypt",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "AllowScheduler"
          + condition {
              + test     = "ArnEquals"
              + values   = [
                  + "arn:aws:iam::707589232221:role/KubraScheduler-20240130210225723200000015",
                ]
              + variable = "aws:scheduler:schedule:arn"
            }
          + principals {
              + identifiers = [
                  + "arn:aws:iam::707589232221:role/KubraScheduler-20240130210225723200000015",
                ]
              + type        = "AWS"
            }
        }
      + statement {
          + actions   = [
              + "kms:Decrypt",
              + "kms:GenerateDataKey",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "AllowSSOApplicationAdministrators"
          + condition {
              + test     = "ArnLike"
              + values   = [
                  + "arn:aws:iam::707589232221:role/aws-reserved/sso.amazonaws.com/AWSReservedSSO_ApplicationAdministrator_*",
                ]
              + variable = "aws:PrincipalArn"
            }
          + principals {
              + identifiers = [
                  + "*",
                ]
              + type        = "AWS"
            }
        }
      + statement {
          + actions   = [
              + "kms:Decrypt",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "Allow the Macie service-linked role to use the key"
          + principals {
              + identifiers = [
                  + "arn:aws:iam::707589232221:role/aws-service-role/macie.amazonaws.com/AWSServiceRoleForAmazonMacie",
                ]
              + type        = "AWS"
            }
        }
      + statement {
          + actions   = [
              + "kms:Decrypt",
              + "kms:GenerateDataKey",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "AllowS3"
          + condition {
              + test     = "ArnLike"
              + values   = [
                  + "arn:aws:s3:::kubra-dev-20230831204921682800000001",
                  + "arn:aws:s3:::ods-dev-20230816130021867500000001",
                ]
              + variable = "kms:EncryptionContext:aws:s3:arn"
            }
          + principals {
              + identifiers = [
                  + "arn:aws:iam::707589232221:role/FileOperationsLambda-20240130205815836000000010",
                  + "arn:aws:iam::707589232221:role/InvoicesStepFunction-20240130205804582800000001",
                  + "arn:aws:iam::707589232221:role/Kubra-Db-QueryLambda-20240130205816074100000011",
                  + "arn:aws:iam::707589232221:role/KubraReportsAthenaRole-20240509180548242000000002",
                  + "arn:aws:iam::707589232221:role/RecurringStepFunction-20240423211506828300000001",
                  + "arn:aws:iam::707589232221:role/RemittanceResultsFirehose-2024013020581450820000000d",
                  + "arn:aws:iam::707589232221:role/RemittanceStepFunction-20240130205804660200000002",
                  + "arn:aws:iam::707589232221:role/ReportsStepFunction-20240412185340434700000001",
                  + "arn:aws:iam::707589232221:role/SftpOperationsLambda-2024013020581472310000000e",
                  + "arn:aws:iam::707589232221:role/balance_fileResultsFirehose-2024013020581449690000000c",
                  + "arn:aws:iam::707589232221:role/invoicesResultsFirehose-2024013020581436880000000b",
                ]
              + type        = "AWS"
            }
        }
      + statement {
          + actions   = [
              + "kms:Decrypt*",
              + "kms:Describe*",
              + "kms:Encrypt*",
              + "kms:GenerateDataKey*",
              + "kms:ReEncrypt*",
            ]
          + effect    = "Allow"
          + resources = [
              + "*",
            ]
          + sid       = "AllowS3Service"
          + condition {
              + test     = "ArnLike"
              + values   = [
                  + "arn:aws:s3:::kubra-dev-20230831204921682800000001",
                ]
              + variable = "kms:EncryptionContext:aws:s3:arn"
            }
          + principals {
              + identifiers = [
                  + "s3.amazonaws.com",
                ]
              + type        = "Service"
            }
        }
    }
  EOT
  triggers_replace = terraform_data.that
  provisioner "local-exec" {
    command = "echo \"file-content-text\" >> \"file_${random_pet.file_name.id}.txt\""
  }
}

resource "random_pet" "file_name" {
  keepers = {
    time = timestamp()
  }
}

data "local_file" "generated_file" {
  filename = "./file_${random_pet.file_name.id}.txt"
  depends_on = [ terraform_data.this ]
}

data "local_file" "preloaded" {
  filename = "./plan-output_run-v0oc1o17r5vfvr4mk.txt"
  depends_on = [ random_pet.file_name ]
}

resource "terraform_data" "that" {
  count = var.quantity
  input = var.that_input
}

resource "terraform_data" "data_dependency" {
  count = var.quantity
  triggers_replace = data.local_file.preloaded
}

variable "that_input" {
  default = <<EOT
"{\
  EOT
}

variable "quantity" {
  default = 1
}

output "generated_file_output" {
  value = data.local_file.generated_file.content
}

output "preloaded_file_output" {
  value = data.local_file.preloaded.content
}