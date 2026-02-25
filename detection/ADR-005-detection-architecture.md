# ADR-005: Organization-Level Detection & Control-Plane Monitoring

## Problem Statement

Preventive controls (SCPs, permission boundaries) reduce risk but cannot eliminate identity compromise or control-plane abuse. Detection must identify privilege escalation, trust mutation, and logging tampering in near real time.

Detection logic must not reside solely within workload accounts, as compromised identities could disable or suppress alerts.

## Risk

- IAM privilege escalation via legitimate credentials
- Cross-account trust backdoors
- Creation of shadow identities
- CloudTrail or GuardDuty disablement
- Deletion of EventBridge rules
- Management account compromise

## Decision

Adopt layered, organization-wide detection architecture:

1. **Org-Level Services**
   - GuardDuty enabled at organization level.
   - Security Hub delegated to Security account.
   - IAM Access Analyzer enabled in organization mode.

2. **Centralized Event Routing**
   - Member accounts forward critical events to a centralized EventBridge bus in the Security account.
   - Detection logic executes in the Security account, not workload accounts.

3. **Control-Plane Mutation Monitoring**
   Detect high-risk IAM actions:
   - CreateUser
   - CreateAccessKey
   - CreateRole
   - AttachRolePolicy
   - PutRolePolicy
   - UpdateAssumeRolePolicy
   - CreatePolicyVersion
   - SetDefaultPolicyVersion
   - DeleteTrail
   - StopLogging
   - DeleteRule
   - DisableRule

4. **Root Activity Detection**
   - Root login and root API activity generate immediate high-severity alert.

## Detection Resilience Model

- Detection rules live in Security account.
- SCPs restrict deletion of detection infrastructure.
- Organization CloudTrail logs all control-plane events to Log Archive account.
- Logs are immutable via Object Lock.

Even if detection is disabled temporarily, tampering remains permanently recorded.

## Alerting Philosophy

- High severity (identity escalation, logging tampering, root usage) → Immediate page.
- Medium severity → Security queue review.
- Low severity → Logged for audit trend analysis.

Avoid alert fatigue by filtering:
- Approved CI/CD roles
- Change window tags
- Known automation identities

## Trade-offs

- Increased operational complexity.
- Risk of alert fatigue if filters are poorly tuned.
- Detection may be delayed if Management account is compromised before escalation.

## Intentionally Not Implemented

- Full SIEM deployment simulation.
- Automated IAM mutation remediation by default.
- Machine-learning anomaly detection tuning.

Focus is on deterministic escalation detection and blast-radius containment.
