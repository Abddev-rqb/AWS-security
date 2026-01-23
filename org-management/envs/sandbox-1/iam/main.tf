provider "aws" {
  region  = "us-east-1"
  profile = "AWSSecCBAdmin1S"
}

module "assume_role_policy" {
  source = "../../../modules/assume-role-policy"

  policy_name          = "AR_Sandbox2_S3ReadOnly"
  destination_role_arn = var.destination_role_arn
}
