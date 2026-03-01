# AWS Organization Security Platform (Terraform-First)

This repository simulates a production-grade AWS multi-account security architecture designed for enterprise and fintech environments.

Focus: identity governance, blast-radius containment, control-plane protection, and detection resilience.

The design prioritizes:

- Organizational guardrails over account-level controls
- Federated human access (no IAM users)
- Immutable centralized logging
- Detection of privilege escalation and control-plane mutation
- Explicit residual risk acknowledgment

---

# 1. Architecture Overview

## Organizational Structure

- Management Account (governance root, break-glass only)
- Security Account (detection & delegated administration)
- Log Archive Account (immutable logging)
- Workload Accounts (application environments)

Security controls are enforced at the organization level wherever possible.

---

# 2. Threat Model & Control Mapping

## Threat: IAM Privilege Escalation

Example:
- Developer creates role
- Attaches AdministratorAccess
- Modifies trust policy for persistence

### Controls

- SCP denies:
  - iam:CreateUser
  - iam:AttachRolePolicy outside approved scope
  - iam:CreateAccessKey
- Permission boundaries restrict automation roles
- IAM mutation events forwarded to Security account
- Central EventBridge rule detects escalation primitives

### Outcome

- Full admin attachment blocked
- Escalation attempt logged
- Security alerted

### Residual Risk

- Abuse of existing read permissions
- Data exfiltration within allowed scope

---

## Threat: Cross-Account Backdoor

Example:
- UpdateAssumeRolePolicy to allow external AWS account

### Controls

- SCP ceilings prevent unrestricted trust mutation
- Access Analyzer (org mode) detects unintended external access
- IAM mutation detection alerts Security account

### Residual Risk

- Exposure possible within policy boundaries if mis-scoped

---

## Threat: Logging Disablement

Example:
- Stop CloudTrail
- Delete Trail
- Disable GuardDuty

### Controls

- SCP denies StopLogging and DeleteTrail
- GuardDuty enabled org-wide
- Security Hub aggregates findings
- EventBridge monitors DeleteRule and DisableRule

### Residual Risk

- Management account compromise can modify SCP

---

## Threat: Management Account Compromise

Example:
- SCP relaxed
- Detection rules deleted
- GuardDuty disabled

### Controls

- All control-plane actions logged via Org CloudTrail
- Logs stored in separate Log Archive account
- S3 Object Lock prevents tampering

### Outcome

- Real-time detection may be delayed
- Forensic integrity preserved

### Residual Risk

- Data exfiltration during detection gap

---

# 3. Identity Governance Model

- IAM Identity Center enabled
- Delegated admin: Security account
- No IAM users for human access
- No standing admin permission set
- Short session durations for privileged roles
- SCP prevents privilege escalation beyond ceiling

Break-glass access:

- Hardware MFA required
- No long-lived credentials
- All usage logged and alerted

---

# 4. Detection Architecture

Layered model:

1. Org-level GuardDuty
2. Security Hub aggregation
3. Access Analyzer (organization mode)
4. Central EventBridge bus in Security account
5. Immutable Org CloudTrail logging

Detection logic does not reside solely in workload accounts.

---

# 5. Logging & Evidence Integrity

- Organization CloudTrail enabled
- Logs delivered to Log Archive account
- S3 Object Lock (compliance mode)
- Versioning enabled
- Log file validation active

Even if detection infrastructure is modified, tampering remains permanently recorded.

---

# 6. Operational Governance

SCP changes:

- Separate Terraform module
- Multi-approver review
- Change window tagging
- EventBridge monitoring for policy updates

Terraform state:

- Versioned
- Encrypted
- Locked via DynamoDB
- Restricted to execution role

Emergency override:

- Break-glass only
- Logged
- Post-incident review mandatory

---

# 7. What This Architecture Does NOT Attempt

- Eliminate all risk
- Replace external SIEM
- Automate every remediation
- Simulate full Control Tower landing zone

The focus is governance integrity, escalation containment, and detection resilience.

---

# 8. Design Philosophy

This platform assumes:

- Credentials will be compromised
- Developers will attempt misconfiguration under pressure
- Control-plane actions are high-risk
- Detection may fail temporarily

The goal is to:

- Reduce blast radius
- Preserve audit integrity
- Centralize governance authority
- Detect escalation primitives deterministically
- Acknowledge residual risk explicitly