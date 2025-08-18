# Get-ExternalDevice

## Synopsis

Get information about your ExternalDevice(s)

## Syntax

```powershell
Get-ExternalDevice [[-Id] <String>]
```

## Description

The `Get-ExternalDevice` function retrieves information about your ExternalDevice devices. You can get information about all ExternalDevices or specify a particular device by its ID.

## Parameters

### Id

Id of your ExternalDevice

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

Returns an object or array of objects containing ExternalDevice information.

## Examples

### Example 1

```powershell
Get-ExternalDevice
```

This example retrieves information about all ExternalDevice devices.

### Example 2

```powershell
Get-ExternalDevice -Id $id
```

This example retrieves information about a specific ExternalDevice.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- The access token is automatically refreshed if it expires within 2 minutes

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Get-ExternalDeviceTelemetry](Get-ExternalDeviceTelemetry.md)
- [Connect-Rapt](Connect-Rapt.md)
