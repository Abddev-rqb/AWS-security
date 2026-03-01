variable "region" {
  description = "The AWS region where resources are deployed."
  type        = string
}
variable "security_account_id" {
  description = "The AWS Account ID of the Security account."
  type        = string
}

variable "organization_id" {
  description = "The AWS Organization ID."
  type        = string
}

variable "security_event_bus_arn" {
  description = "The ARN of the security event bus."
  type        = string
}