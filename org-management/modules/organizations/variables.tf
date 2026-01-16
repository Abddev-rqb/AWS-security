variable "ou_name" {
  description = "Name of the Organizational Unit"
  type        = string
}

variable "account_name" {
  description = "Name of the AWS member account"
  type        = string
}

variable "account_email" {
  description = "Email address for the AWS member account"
  type        = string
}

variable "account_role_name" {
  description = "IAM role created in the member account for admin access"
  type        = string
}
