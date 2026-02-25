# Break-Glass Access Model

## Purpose

Provide emergency access to Management account and Security account without creating standing privilege.

## Controls

- Hardware MFA required.
- No long-lived access keys.
- No daily operational use.
- All break-glass usage triggers:
  - Immediate SNS alert
  - Security Hub finding
  - Pager escalation

## Restrictions

- Break-glass cannot disable CloudTrail (SCP enforced).
- Break-glass cannot delete log archive buckets.
- Break-glass usage requires post-incident review.

## Risk Acknowledgment

If Management account is compromised via break-glass misuse, SCP protections can be modified.

Immutable logging in Log Archive account remains the final line of defense.
