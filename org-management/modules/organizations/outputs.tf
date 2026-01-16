output "organization_id" {
  description = "AWS Organization ID"
  value       = aws_organizations_organization.this.id
}

output "ou_id" {
  description = "Organizational Unit ID"
  value       = aws_organizations_organizational_unit.this.id
}

output "account_id" {
  description = "AWS Account ID"
  value       = aws_organizations_account.this.id
}
