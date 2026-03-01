# ADR-006: SCP Change Control & Governance Protection

## Problem Statement

Service Control Policies (SCPs) define organization-wide permission ceilings. 
Misconfiguration can block production workloads or weaken security posture. 
Uncontrolled SCP modification creates catastrophic blast radius.

## Risk

- Production outage due to overly restrictive SCP
- Privilege escalation due to relaxed SCP
- Silent governance drift
- Emergency override abuse

## Decision

SCP modifications are isolated to a dedicated repository and change workflow.

## Change Model

1. SCP changes require:
   - Separate Terraform module
   - Two approvers (Security + Platform)
   - Change ticket reference
   - Change window tagging

2. SCP Terraform execution:
   - Runs only from Management account context
   - Uses dedicated SCPChangeRole
   - MFA required

3. EventBridge monitors:
   - organizations:UpdatePolicy
   - organizations:AttachPolicy
   - organizations:DetachPolicy

## Emergency Override

Emergency relaxation of SCP requires:
- Break-glass role
- Pager alert
- Post-change review within 24 hours

## Trade-offs

- Slower governance iteration
- Reduced agility for ad-hoc exceptions

## Residual Risk

If Management account is compromised, SCPs can be modified.
Immutable logging remains final evidence layer.