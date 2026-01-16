output "sandbox_scp_policy_id" {
  description = "SCP policy ID restricting S3 bucket creation in us-east-1 for sandbox account"
  value       = module.sandbox_s3_scp.policy_id
}

output "sandbox_target_account_id" {
  description = "Sandbox AWS account ID to which the SCP is attached"
  value       = var.sandbox_account_id
}
