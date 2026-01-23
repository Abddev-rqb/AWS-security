output "assume_role_policy_arn" {
  description = "IAM policy ARN allowing AssumeRole into destination account"
  value       = module.source_assume_policy.policy_arn
}

output "assume_role_policy_name" {
  description = "Name of the AssumeRole policy"
  value       = module.source_assume_policy.policy_name
}
