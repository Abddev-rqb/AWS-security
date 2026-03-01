# Terraform State Security Model

## Backend Protection

- State stored in dedicated backend account
- S3 bucket:
  - Versioning enabled
  - Encryption (SSE-KMS)
  - No public access
- DynamoDB table for state locking

## Access Control

- Only TerraformExecutionRole can read/write state
- No console modification of state bucket
- SCP prevents deletion of state bucket

## Risk Modeled

If Terraform state is corrupted:
- Previous versions recoverable via S3 versioning
- Lock table prevents concurrent destructive apply

## Residual Risk

If TerraformExecutionRole is compromised, state can be manipulated.
SCP ceilings restrict catastrophic org-level damage.