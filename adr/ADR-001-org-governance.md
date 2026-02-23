# ADR-001: Organization-Level Governance via AWS Organizations

## Problem Statement
Workload account owners can bypass security controls if governance is enforced only at the account level.

## Risk
- Disabling CloudTrail
- Leaving the organization
- Operating outside audit visibility
- Root account misuse

## Decision
Use AWS Organizations with centralized OU-based governance and SCPs enforced outside workload accounts.

## Alternatives Considered
- Account-level IAM only
- Relying on human process and reviews

## Trade-offs Accepted
- Centralized SCP enforcement reduces workload team autonomy and requires higher upfront coordination, as security controls are enforced outside individual accounts and cannot be overridden locally. This trade-off is accepted to guarantee auditability, prevent control bypass, and reduce long-term security incidents.


## Intentionally Not Implemented
Fine-grained OU hierarchies (e.g., dev/stage/prod) were intentionally deferred. Under organization-level governance, each OU introduces additional SCP boundaries. At early scale, this increases policy sprawl, misconfiguration risk, and operational complexity without proportional security benefit.