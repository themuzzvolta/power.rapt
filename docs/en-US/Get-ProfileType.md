# Get-ProfileType

## Synopsis

Get information about available ProfileTypes

## Syntax

```powershell
Get-ProfileType [[-Id] <String>]
```

## Description

The `Get-ProfileType` function retrieves information about available profile types in the RAPT system. Profile types define the categories and parameters available for brewing profiles.

## Parameters

### Id

Id of your ProfileType

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

Returns an object or array of objects containing profile type information.

## Examples

### Example 1

```powershell
Get-ProfileType
```

This example retrieves information about all available profile types.

### Example 2

```powershell
Get-ProfileType -Id $id
```

This example retrieves information about a specific profile type.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- The access token is automatically refreshed if it expires within 2 minutes
- Profile types include temperature ranges and device compatibility information

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Get-Profile](Get-Profile.md)
- [Connect-Rapt](Connect-Rapt.md)
