# Get-CanFiller

## Synopsis

Get information about your CanFiller(s)

## Syntax

```powershell
Get-CanFiller [[-Id] <String>]
```

## Description

The `Get-CanFiller` function retrieves information about your CanFiller devices. You can get information about all CanFillers or specify a particular device by its ID.

## Parameters

### Id

Id of your CanFiller

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

Returns an object or array of objects containing CanFiller device information.

## Examples

### Example 1

```powershell
Get-CanFiller
```

This example retrieves information about all CanFiller devices.

### Example 2

```powershell
Get-CanFiller -Id $id
```

This example retrieves information about a specific CanFiller device.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- The access token is automatically refreshed if it expires within 2 minutes

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Get-CanFillerTelemetry](Get-CanFillerTelemetry.md)
- [Connect-Rapt](Connect-Rapt.md)
