# ADR-003: Centralized Organization Logging

## Problem Statement
If audit logs reside within workload accounts, a compromised identity can delete or tamper with evidence.

## Risk
- Log deletion after privilege escalation
- Loss of forensic traceability
- Undetected cross-account lateral movement
- Inability to prove impact scope

## Decision
Enable organization-level CloudTrail with logs delivered to a dedicated Log Archive account owned by Security. Workload accounts have no permission to modify or delete centralized audit logs.

## Alternatives Considered
- Per-account CloudTrail trails
- Storing logs in the same account as workloads

## Trade-offs Accepted
- Additional cost for centralized storage
- Slightly more complex cross-account configuration

## Intentionally Not Implemented
Deep SIEM tooling or dashboarding, focusing instead on integrity and evidence preservation first.
