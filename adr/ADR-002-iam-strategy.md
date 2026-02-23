# ADR-002: Identity and Access Management Strategy

## Problem Statement
Managing human and system access across multiple AWS accounts without centralized control leads to credential sprawl, excessive permissions, and high blast radius during compromise.

## Risk
- Long-lived credentials leakage
- Unbounded administrator access
- Inconsistent access revocation
- Lateral movement across accounts

## Decision
Adopt a role-based access model using AWS Identity Center for humans, IAM roles for workloads and automation, and permission boundaries to enforce maximum privilege limits. IAM users are explicitly avoided for human access.

## Alternatives Considered
- IAM users with access keys
- Per-account IAM management by workload teams
- Trusting developers to self-govern permissions

## Trade-offs Accepted
- Higher initial setup complexity
- Reduced flexibility for ad-hoc access
- Dependence on centralized identity systems

## Intentionally Not Implemented
Fine-grained per-team IAM customization inside workload accounts, to prevent privilege drift and inconsistent security posture.
