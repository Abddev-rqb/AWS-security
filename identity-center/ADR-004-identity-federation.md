# ADR-004: Federated Human Access via IAM Identity Center

## Problem Statement

Direct IAM user access creates unmanaged credential risk, privilege drift, and inconsistent access governance across accounts.

## Risk

- Long-lived access keys
- Shadow IAM users
- Privilege escalation via direct IAM role creation
- Lack of centralized human access visibility

## Decision

Enable IAM Identity Center in the Management account and delegate operational administration to the Security account.

All human access to member accounts must flow through Identity Center permission sets. Direct IAM user creation is denied via SCP.

## Architecture Model

- Identity Center enabled in Management account (AWS requirement).
- Delegated administrator: Security account.
- Workload accounts cannot assign roles for human access.
- All permission sets are managed via Terraform from Security account.
- Management account retains break-glass only access protected by hardware MFA.

## Permission Set Strategy

- SecurityAdmin (time-bound, 1-hour session)
- PlatformAdmin (limited infrastructure admin, no SCP control)
- Developer (workload-level access only)
- ReadOnly (audit visibility)

No standing global administrator permission set.

## Privilege Containment

- SCP ceilings prevent privilege escalation beyond defined boundaries.
- Permission boundaries apply to automation roles.
- Identity Center permission sets cannot override SCP constraints.
- No permission set grants `organizations:*`.

## Trade-offs

- Increased operational overhead for permission set management.
- Reduced flexibility for ad-hoc account-level access.

## Intentionally Not Implemented

- External IdP deep integration simulation.
- Just-in-time access automation tooling.

Focus is on governance enforcement and blast-radius reduction.
