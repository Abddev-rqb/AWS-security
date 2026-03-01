resource "aws_organizations_delegated_administrator" "access_analyzer_delegate" {
  account_id        = var.security_account_id
  service_principal = "access-analyzer.amazonaws.com"
}

resource "aws_accessanalyzer_analyzer" "org_analyzer" {
  analyzer_name = "organization-access-analyzer"
  type          = "ORGANIZATION"
}