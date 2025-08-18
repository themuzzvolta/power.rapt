# Get-UserInfo

## Synopsis

Get information about your RAPT user account

## Syntax

```powershell
Get-UserInfo
```

## Description

The `Get-UserInfo` function retrieves information about your RAPT user account, including account details and preferences.

## Parameters

This function has no parameters.

## Inputs

### None

This function does not accept pipeline input.

## Outputs

### System.Management.Automation.PSObject

Returns an object containing user account information.

## Examples

### Example 1

```powershell
Get-UserInfo
```

This example retrieves information about your RAPT user account.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- The access token is automatically refreshed if it expires within 2 minutes

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Connect-Rapt](Connect-Rapt.md)
