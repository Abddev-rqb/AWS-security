# GuardDuty is organization-enabled and delegated to Security account.
# Workload accounts cannot disable organization-level GuardDuty without
# management-plane control.
# CloudTrail logs record any attempt to disable GuardDuty.

resource "aws_guardduty_detector" "management" {
  enable = true

  finding_publishing_frequency = "FIFTEEN_MINUTES"
}

resource "aws_guardduty_organization_admin_account" "delegate" {
  admin_account_id = var.security_account_id
}

resource "aws_guardduty_organization_configuration" "org_config" {
  detector_id = aws_guardduty_detector.management.id

  auto_enable_organization_members = "ALL"
}

resource "aws_guardduty_detector" "security" {
  enable = true

  finding_publishing_frequency = "FIFTEEN_MINUTES"
}
