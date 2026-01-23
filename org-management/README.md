# AWS Organization & Cross-Account IAM Governance (Terraform)

## Architecture Overview
- AWS Organizations
- SCP enforcement
- Cross-account IAM role assumption

## Environments
- dev
- sandbox
- sandbox-1 (source account)
- sandbox-2 (destination account)

## Security Design
- Least privilege
- Explicit trust relationships
- No long-lived credentials

## Real-World Use Case
- FinTech / Banking multi-account model
- Central governance + workload isolation
