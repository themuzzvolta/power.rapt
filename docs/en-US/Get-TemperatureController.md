# Get-TemperatureController

## Synopsis

Get information about your TemperatureController(s)

## Syntax

```powershell
Get-TemperatureController [[-Id] <String>]
```

## Description

The `Get-TemperatureController` function retrieves information about your TemperatureController devices. You can get information about all TemperatureControllers or specify a particular device by its ID.

## Parameters

### Id

Id of your TemperatureController

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

Returns an object or array of objects containing TemperatureController device information.

## Examples

### Example 1

```powershell
Get-TemperatureController
```

This example retrieves information about all TemperatureController devices.

### Example 2

```powershell
Get-TemperatureController -Id $id
```

This example retrieves information about a specific TemperatureController device.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- The access token is automatically refreshed if it expires within 2 minutes

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Get-TemperatureControllerTelemetery](Get-TemperatureControllerTelemetery.md)
- [Set-TemperatureControllerTemp](Set-TemperatureControllerTemp.md)
- [Connect-Rapt](Connect-Rapt.md)
