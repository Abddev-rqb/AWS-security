variable "aws_region" {
  description = "AWS region (Organizations is global, but Terraform requires a region)"
  type        = string
  default     = "us-east-1"
}

variable "ou_name" {
  description = "Name of the Organizational Unit"
  type        = string
}

variable "account_name" {
  description = "Name of the AWS account to be created"
  type        = string
}

variable "account_email" {
  description = "Email address for the AWS account"
  type        = string
}

variable "account_role_name" {
  description = "IAM role name for cross-account access"
  type        = string
}
