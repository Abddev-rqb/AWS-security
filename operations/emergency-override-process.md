# Emergency Override Process

## Trigger Conditions

- SCP blocking production deployment
- Logging disruption
- Identity lockout
- Detection infrastructure failure

## Override Steps

1. Use break-glass role (hardware MFA required)
2. Temporary SCP relaxation (scoped, time-bound)
3. Pager alert triggered automatically
4. Immutable logs preserved

## Post-Override Review

- Identify root cause
- Reapply restrictive SCP
- Document in incident tracker

## Abuse Prevention

- Break-glass role has no long-lived credentials
- All usage generates high-severity alert