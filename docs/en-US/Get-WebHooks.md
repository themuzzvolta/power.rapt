# Get-WebHooks

## Synopsis

Get information about your configured webhooks

## Syntax

```powershell
Get-WebHooks
```

## Description

The `Get-WebHooks` function retrieves information about webhooks configured in your RAPT account. Webhooks allow external systems to receive notifications about device events and data updates.

## Parameters

This function has no parameters.

## Inputs

### None

This function does not accept pipeline input.

## Outputs

### System.Management.Automation.PSObject

Returns an object or array of objects containing webhook configuration information.

## Examples

### Example 1

```powershell
Get-WebHooks
```

This example retrieves information about all configured webhooks.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- The access token is automatically refreshed if it expires within 2 minutes
- Webhooks can be configured in the RAPT portal web interface

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [RAPT Portal](https://app.rapt.io/)
- [Connect-Rapt](Connect-Rapt.md)
