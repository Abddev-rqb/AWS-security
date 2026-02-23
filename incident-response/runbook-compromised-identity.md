# Incident Runbook: Compromised Identity

## Scope
This runbook applies to suspected compromise of IAM users, IAM roles, access keys, or cross-account trust relationships.

---

## Trigger Conditions
- GuardDuty finding: UnauthorizedAccess / CredentialExfiltration
- Unusual AssumeRole event
- Access key used from anomalous geography
- Unexpected IAM mutation (CreateRole, AttachRolePolicy, UpdateAssumeRolePolicy)
- Detection of long-lived IAM user in workload account

---

## Phase 1 — Immediate Containment (0–10 minutes)

1. Disable compromised access key immediately.
2. If role-based compromise, attach explicit deny-all inline policy to freeze active sessions.
3. Remove or restrict trust relationships allowing cross-account access.
4. Confirm CloudTrail organization logging is intact.
5. Do NOT delete identity until evidence collection is complete.

Objective: Stop further API activity without destroying evidence.

---

## Phase 2 — Evidence Preservation

1. Identify compromise window via CloudTrail (userIdentity, sessionContext, sourceIPAddress).
2. Export relevant CloudTrail management and data events.
3. Preserve GuardDuty findings.
4. Generate IAM credential report.
5. Secure logs in centralized logging account.

Objective: Preserve forensic traceability and establish timeline.

---

## Phase 3 — Blast Radius Assessment

1. Query all IAM mutation events during compromise window.
2. Check for:
   - New IAM users or roles
   - Policy attachments (AdministratorAccess)
   - Trust policy updates
   - Policy version changes
3. Review data-plane access:
   - S3 GetObject / ListBucket
   - KMS Decrypt
   - SecretsManager GetSecretValue
   - Snapshot export / sharing
4. Inspect resource-based policies for unauthorized sharing.

Objective: Determine identity escalation, persistence, and data exposure.

---

## Phase 4 — Persistence Elimination

1. Remove unauthorized roles, policies, and trust relationships.
2. Rotate potentially exposed secrets and credentials.
3. Validate no external account retains access.
4. Confirm SCP protections were not bypassed.

Objective: Ensure attacker cannot regain access.

---

## Phase 5 — Control Reinforcement

1. Eliminate long-lived IAM users if present.
2. Enforce permission boundary requirements.
3. Add or refine SCP guardrails if gaps identified.
4. Enable CloudTrail data events for sensitive resources if missing.
5. Document lessons learned and update detection rules.

Objective: Convert incident into structural prevention.

---

## Escalation & Communication

- Notify Security Leadership.
- Document impact scope.
- Coordinate with legal/compliance if required.
- Maintain timeline and evidence integrity.

---

## Guiding Principles

- Contain first.
- Preserve evidence.
- Quantify blast radius.
- Eliminate persistence.
- Reinforce guardrails.
