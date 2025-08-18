# Get-Profile

## Synopsis

Get information about your Profile(s)

## Syntax

```powershell
Get-Profile [[-Id] <String>]
```

## Description

The `Get-Profile` function retrieves information about your brewing profiles. You can get information about all profiles or specify a particular profile by its ID.

## Parameters

### Id

Id of your Profile

- **Type**: String
- **Parameter Sets**: (All)
- **Aliases**: None
- **Required**: False
- **Position**: Named
- **Default value**: None
- **Accept pipeline input**: False
- **Accept wildcard characters**: False

## Inputs

### System.String

You can pipe string objects to this function.

## Outputs

### System.Management.Automation.PSObject

Returns an object or array of objects containing brewing profile information.

## Examples

### Example 1

```powershell
Get-Profile
```

This example retrieves information about all brewing profiles.

### Example 2

```powershell
Get-Profile -Id $id
```

This example retrieves information about a specific brewing profile.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- The access token is automatically refreshed if it expires within 2 minutes
- Profiles contain brewing temperature schedules and fermentation parameters

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Get-ProfileType](Get-ProfileType.md)
- [Connect-Rapt](Connect-Rapt.md)
