# Get-FermentationChamber

## Synopsis

Get information about your FermentationChamber(s)

## Syntax

```powershell
Get-FermentationChamber [[-Id] <String>]
```

## Description

The `Get-FermentationChamber` function retrieves information about your FermentationChamber devices. You can get information about all FermentationChambers or specify a particular device by its ID.

## Parameters

### Id

Id of your FermentationChamber

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

Returns an object or array of objects containing FermentationChamber device information.

## Examples

### Example 1

```powershell
Get-FermentationChamber
```

This example retrieves information about all FermentationChamber devices.

### Example 2

```powershell
Get-FermentationChamber -Id $id
```

This example retrieves information about a specific FermentationChamber device.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- The access token is automatically refreshed if it expires within 2 minutes

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Get-FermentationChamberTelemetry](Get-FermentationChamberTelemetry.md)
- [Set-FermentationChamberTemp](Set-FermentationChamberTemp.md)
- [Connect-Rapt](Connect-Rapt.md)
