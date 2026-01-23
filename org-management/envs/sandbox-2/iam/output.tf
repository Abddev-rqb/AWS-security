output "destination_role_arn" {
  description = "ARN of the cross-account IAM role to be assumed by source account"
  value       = module.destination_role.role_arn
}

output "destination_role_name" {
  description = "Name of the cross-account IAM role"
  value       = module.destination_role.role_name
}
