# Get-Hydrometer

## Synopsis

Get information about your Hydrometer(s)

## Syntax

```powershell
Get-Hydrometer [[-Id] <String>]
```

## Description

The `Get-Hydrometer` function retrieves information about your Hydrometer devices. You can get information about all Hydrometers or specify a particular device by its ID.

## Parameters

### Id

Id of your Hydrometer

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

Returns an object or array of objects containing Hydrometer device information.

## Examples

### Example 1

```powershell
Get-Hydrometer
```

This example retrieves information about all Hydrometer devices.

### Example 2

```powershell
Get-Hydrometer -Id $id
```

This example retrieves information about a specific Hydrometer device.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- The access token is automatically refreshed if it expires within 2 minutes

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Get-HydrometerTelemetry](Get-HydrometerTelemetry.md)
- [Connect-Rapt](Connect-Rapt.md)
