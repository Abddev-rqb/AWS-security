provider "aws" {
  region = var.aws_region
}

# Call the Organizations module
module "org_management" {
  source = "../../modules/organizations"

  ou_name           = var.ou_name
  account_name      = var.account_name
  account_email     = var.account_email
  account_role_name = var.account_role_name
}
