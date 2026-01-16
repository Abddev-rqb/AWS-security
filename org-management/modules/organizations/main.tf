# Create AWS Organization
resource "aws_organizations_organization" "this" {
  feature_set = "ALL"
    
  lifecycle {
    prevent_destroy = true
  }
}

# Create Organizational Unit
resource "aws_organizations_organizational_unit" "this" {
  name      = var.ou_name

  # Convert roots (set) to list before indexing
  parent_id = tolist(
    aws_organizations_organization.this.roots
  )[0].id
}

# Create AWS Account inside the OU
resource "aws_organizations_account" "this" {
  name      = var.account_name
  email     = var.account_email
  role_name = var.account_role_name

  parent_id = aws_organizations_organizational_unit.this.id
}
