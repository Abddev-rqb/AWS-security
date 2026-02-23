resource "aws_organizations_policy" "deny_leave_org" {
  name        = "deny-leave-org"
  description = "Prevent accounts from leaving the organization"
  content     = file("${path.module}/scp/deny-leave-org.json")
  type        = "SERVICE_CONTROL_POLICY"
}

resource "aws_organizations_policy" "deny_cloudtrail_disable" {
  name        = "deny-cloudtrail-disable"
  description = "Prevent CloudTrail tampering"
  content     = file("${path.module}/scp/deny-cloudtrail-disable.json")
  type        = "SERVICE_CONTROL_POLICY"
}

resource "aws_organizations_policy" "deny_root_actions" {
  name        = "deny-root-actions"
  description = "Prevent root account usage"
  content     = file("${path.module}/scp/deny-root-actions.json")
  type        = "SERVICE_CONTROL_POLICY"
}
