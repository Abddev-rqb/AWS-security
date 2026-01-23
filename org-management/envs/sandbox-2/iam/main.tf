provider "aws" {
  region  = "us-east-1"
  profile = "AWSSecCBAdmin1D"
}

module "destination_role" {
  source = "../../../modules/destination-role"

  role_name         = "SA-S3ReadOnly"
  source_account_id = var.source_account_id
}
