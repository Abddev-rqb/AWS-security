# Simulation: Management Account Compromise

## Initial State

- Management account:
  - Break-glass protected (hardware MFA).
  - No daily operational access.
- SCPs enforced org-wide.
- GuardDuty & Security Hub delegated to Security account.
- IAM mutation detection centralized in Security account.
- Org CloudTrail logs delivered to Log Archive account with Object Lock.

## Attack Scenario

Attacker compromises break-glass admin credentials via phishing.

Attacker performs:

1. organizations:UpdatePolicy
   - Relaxes SCP to allow broader IAM mutation.
2. events:DeleteRule
   - Deletes detection rules in Security account.
3. guardduty:UpdateDetector
   - Disables GuardDuty in Security account.
4. Performs high-volume S3 GetObject operations.

Goal:
- Suppress detection.
- Escalate privileges.
- Exfiltrate sensitive data.
- Avoid alerting.

## Control Failure Points

- SCP modification succeeds (management-plane authority).
- Detection rules in Security account deleted.
- GuardDuty temporarily disabled.
- Real-time alerting suppressed.

This represents a control-plane breach.

## What Still Holds

### 1. Immutable Logging

- Organization CloudTrail records:
  - SCP modifications
  - GuardDuty disablement
  - EventBridge rule deletions
  - Data access API calls
- Logs stored in Log Archive account.
- S3 Object Lock prevents retroactive deletion.

### 2. External Alerting (If Enabled)

If external SIEM integration exists:
- Logs forwarded before suppression.
- Partial detection possible.

### 3. Forensic Integrity

All malicious control-plane actions are permanently recorded.
Tampering cannot be erased.

## Detection Outcome

Real-time alerting delayed (~6 hours).
Post-incident investigation reconstructs full sequence.

## Containment Response

- Disable compromised credentials.
- Reapply restrictive SCP.
- Re-enable GuardDuty.
- Restore EventBridge rules.
- Rotate affected secrets.
- Review accessed data scope.

## Residual Risk

- Data exfiltration cannot be undone.
- Detection delay allowed attacker dwell time.
- Centralized governance remains a concentration risk.

## Architectural Lessons

- Management account represents highest trust boundary.
- Out-of-band monitoring reduces detection delay.
- Detection infrastructure must assume management-plane risk.

This architecture preserves audit integrity but cannot fully prevent governance-level compromise.