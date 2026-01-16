provider "aws" {
  region = "us-east-1"
}

module "sandbox_s3_scp" {
  source = "../../modules/scp"

  policy_name        = "SandboxS3BucketCreate"
  policy_description = "Restrict S3 bucket creation in us-east-1 for sandbox accounts"
}

resource "aws_organizations_policy_attachment" "sandbox_attach" {
  policy_id = module.sandbox_s3_scp.policy_id
  target_id = var.sandbox_account_id
}
