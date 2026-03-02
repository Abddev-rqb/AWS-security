# AWS Organization Security Platform (Terraform-First)

This repository models a production-oriented AWS multi-account security architecture designed for enterprise and fintech environments.

Primary focus:

- Identity-first governance
- Control-plane protection
- Blast-radius containment
- Detection resilience
- Forensic integrity under compromise

This design assumes compromise is inevitable and prioritizes limiting impact over eliminating all risk.

---

# 1. Architecture Overview

## Organizational Structure

- **Management Account** — Governance root, break-glass only
- **Security Account** — Detection, delegated administration, event aggregation
- **Log Archive Account** — Immutable audit storage
- **Workload Accounts** — Application environments

Security controls are enforced at the **organization level wherever possible**, not per-account.

Detection logic executes centrally in the **Security account**.  
Workload accounts forward control-plane activity via **Organization CloudTrail**, ensuring local tampering cannot disable centralized monitoring.

---

# 2. Threat Model & Control Mapping

---

## Threat: IAM Privilege Escalation

Example:
- Developer creates role
- Attaches `AdministratorAccess`
- Modifies trust policy for persistence

### Controls

- SCP denies:
  - `iam:CreateUser`
  - `iam:CreateAccessKey`
  - Unauthorized `iam:AttachRolePolicy`
- Permission boundaries restrict delegated IAM creation
- IAM mutation events forwarded to Security account
- Central EventBridge rule detects escalation primitives

### Outcome

- Administrator attachment blocked
- Escalation attempt logged via Org CloudTrail
- Security account alerted

### Residual Risk

- Abuse of already granted read permissions
- Data exfiltration within allowed scope

---

## Threat: Cross-Account Backdoor

Example:
- `UpdateAssumeRolePolicy` to allow external AWS account

### Controls

- SCP ceilings restrict unrestricted trust mutation
- Access Analyzer (organization mode) detects unintended external access
- IAM mutation detection alerts Security account

### Residual Risk

- Exposure possible within overly permissive but policy-compliant scopes

---

## Threat: Logging Disablement

Example:
- `StopLogging`
- `DeleteTrail`
- Disable GuardDuty
- Delete detection rules

### Controls

- SCP denies `StopLogging` and `DeleteTrail`
- Org-wide GuardDuty enabled via delegated admin
- Security Hub aggregates findings centrally
- EventBridge monitors detection rule mutations

### Residual Risk

- Management account compromise can modify SCP ceilings

---

## Threat: Management Account Compromise

Example:
- SCP relaxed
- Delegated admin removed
- Detection rules deleted

### Controls

- All control-plane activity logged via Organization CloudTrail
- Logs delivered cross-account to Log Archive
- S3 Object Lock (compliance mode) prevents tampering
- Log file validation enabled

### Outcome

- Real-time detection may degrade
- Forensic integrity preserved
- Post-incident reconstruction possible

### Residual Risk

- Data exfiltration during detection gap
- Temporary reduction in automated alerting

---

# 3. Identity Governance Model

- IAM Identity Center enabled
- Delegated administration: Security account
- No IAM users for human access
- No standing administrator permission set
- Short session durations for privileged roles
- SCP enforces privilege ceiling beyond permission set scope

Permission sets are **mutually exclusive** and granted via approval workflow to prevent accumulation of high-privilege roles (privilege creep).

### Break-Glass Access

- Hardware MFA required
- No long-lived credentials
- Usage logged and monitored
- Mandatory post-incident review

Identity strategy prioritizes eliminating unmanaged credentials and enforcing least privilege at scale.

---

# 4. Detection Architecture

Layered detection model:

1. Org-level GuardDuty (delegated admin)
2. Security Hub centralized aggregation
3. Access Analyzer (organization mode)
4. Central EventBridge bus in Security account
5. Immutable Organization CloudTrail logging

Detection rules execute in the Security account, not workload accounts.

If delegated admin is modified or detection rules are altered, Organization CloudTrail preserves evidence for forensic reconstruction.

This design separates detection logic from workload control-plane authority.

---

# 5. Logging & Evidence Integrity

- Organization CloudTrail enabled
- Logs delivered to dedicated Log Archive account
- S3 Object Lock (compliance mode)
- Versioning enabled
- Log file validation active

Even if detection infrastructure is degraded, tampering remains permanently recorded.

Audit survivability is prioritized over immediate alerting guarantees.

---

# 6. Operational Governance

## SCP Changes

- Managed via dedicated Terraform module
- Multi-approver review required
- Change-window tagging enforced
- EventBridge monitors policy updates

## Terraform State Security

- Remote state encrypted
- Versioned
- Locked via DynamoDB
- Access restricted to execution role

## Emergency Override

- Break-glass only
- Logged via Org CloudTrail
- Mandatory post-incident review

Governance integrity is treated as critical infrastructure.

---

# 7. Out of Scope

This architecture does NOT attempt to:

- Eliminate all possible risk
- Replace external SIEM tooling
- Automate every remediation
- Fully simulate AWS Control Tower landing zones

The objective is governance integrity, escalation containment, and detection resilience — not feature completeness.

---

# 8. Design Philosophy

This platform assumes:

- Credentials will be compromised
- Misconfiguration will occur under delivery pressure
- Control-plane actions are high-risk
- Detection may temporarily degrade

The goal is to:

- Reduce blast radius
- Preserve audit integrity
- Centralize governance authority
- Detect escalation primitives deterministically
- Explicitly acknowledge residual risk