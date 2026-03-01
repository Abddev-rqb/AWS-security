# Simulation: IAM Privilege Escalation Attempt in Workload Account

## Initial State

- Developer has Identity Center "Developer" permission set.
- SCP denies:
  - iam:CreateUser
  - iam:CreateAccessKey
  - iam:AttachRolePolicy outside approved ARNs
- Permission boundaries enforced for automation roles.
- Org-level GuardDuty and Security Hub enabled.
- IAM mutation events forwarded to Security account EventBridge.

## Attack Scenario

Developer attempts privilege escalation by:

1. Creating new IAM role:
   - Action: CreateRole
2. Attaching AdministratorAccess:
   - Action: AttachRolePolicy
3. Updating trust policy to allow external account assumption:
   - Action: UpdateAssumeRolePolicy

Goal: Persist privileged backdoor role.

## Control Response

### Step 1 – SCP Enforcement

- SCP blocks:
  - iam:AttachRolePolicy for AdministratorAccess
  - iam:CreateUser
- Developer cannot attach full admin policy.

### Step 2 – Permission Ceiling

Even if Developer creates a role, permission boundary and SCP ceiling prevent:
- Full wildcard permissions
- Trust modification to external accounts

### Step 3 – Detection Triggered

EventBridge in workload account forwards IAM API calls.

Security account EventBridge rule detects:
- CreateRole
- AttachRolePolicy
- UpdateAssumeRolePolicy

SNS alert triggered.

GuardDuty may not fire (legitimate credentials used).

## Investigation Flow

Security team reviews:
- Session ARN
- Source IP
- Identity Center assignment
- Timestamps
- CloudTrail event details

Containment:
- Revoke Identity Center session
- Remove unauthorized role (if created)
- Review additional IAM mutations

## What Was Successfully Blocked

- Direct AdministratorAccess attachment
- Cross-account trust persistence
- Creation of long-lived access keys

## Residual Risk

- Developer may still:
  - Abuse overly broad read permissions
  - Access sensitive data within allowed scope
  - Perform data exfiltration via legitimate APIs

This architecture reduces privilege escalation risk but does not eliminate data-plane misuse risk.

## Improvement Opportunity

- Add anomaly detection for unusual data volume access.
- Reduce Developer permission scope further.
- Add data classification monitoring (Macie conceptually).