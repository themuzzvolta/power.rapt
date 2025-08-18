# Get-BrewZilla

## Synopsis

Get information about your BrewZilla(s)

## Syntax

```powershell
Get-BrewZilla [[-Id] <String>]
```

## Description

The `Get-BrewZilla` function retrieves information about your BrewZilla devices. You can get information about all BrewZillas or specify a particular device by its ID.

## Parameters

### Id

Id of your BrewZilla

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

Returns an object or array of objects containing BrewZilla device information.

## Examples

### Example 1

```powershell
Get-BrewZilla
```

This example retrieves information about all BrewZilla devices.

### Example 2

```powershell
Get-BrewZilla -Id $id
```

This example retrieves information about a specific BrewZilla device.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- The access token is automatically refreshed if it expires within 2 minutes

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Connect-Rapt](Connect-Rapt.md)
