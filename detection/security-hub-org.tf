# Security Hub delegated admin centralizes findings in Security account.
# Member accounts cannot suppress organization-level aggregation.
# Any disablement attempts are logged via CloudTrail.

resource "aws_securityhub_account" "management" {
  enable_default_standards = false
}

resource "aws_securityhub_organization_admin_account" "delegate" {
  admin_account_id = var.security_account_id
}

resource "aws_securityhub_organization_configuration" "org_config" {
  auto_enable = true
}

resource "aws_securityhub_account" "security" {
  enable_default_standards = false
}