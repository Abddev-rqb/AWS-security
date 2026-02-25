# Permission Set Strategy

## Session Duration

- SecurityAdmin: 1 hour
- PlatformAdmin: 2 hours
- Developer: 4 hours
- ReadOnly: 8 hours

Shorter sessions reduce standing privilege exposure.

## Separation of Duties

- SecurityAdmin cannot modify SCP without change process.
- PlatformAdmin cannot attach AdministratorAccess arbitrarily.
- Developers cannot create IAM roles outside approved modules.

## No Privilege Stacking

Users cannot be assigned multiple admin-equivalent permission sets simultaneously.

Permission overlap is reviewed quarterly.

## Enforcement Model

- Permission sets defined via Terraform.
- Changes require PR approval.
- EventBridge monitors permission set mutation events.
