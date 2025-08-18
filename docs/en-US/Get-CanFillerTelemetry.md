# Get-CanFillerTelemetry

## Synopsis

Get telemetry information about your CanFiller(s)

## Syntax

```powershell
Get-CanFillerTelemetry [[-Id] <String>] [[-Name] <String>] [-StartDate] <String> [-EndDate] <String>
```

## Description

The `Get-CanFillerTelemetry` function retrieves telemetry data from your CanFiller devices within a specified date range. You can specify the device by either ID or Name.

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

### Name

Name of your CanFiller

- **Type**: String
- **Parameter Sets**: (All)
- **Aliases**: None
- **Required**: False
- **Position**: Named
- **Default value**: None
- **Accept pipeline input**: False
- **Accept wildcard characters**: False

### StartDate

Start date to get data from

- **Type**: String
- **Parameter Sets**: (All)
- **Aliases**: None
- **Required**: True
- **Position**: Named
- **Default value**: None
- **Accept pipeline input**: False
- **Accept wildcard characters**: False

### EndDate

End date to get data until

- **Type**: String
- **Parameter Sets**: (All)
- **Aliases**: None
- **Required**: True
- **Position**: Named
- **Default value**: None
- **Accept pipeline input**: False
- **Accept wildcard characters**: False

## Inputs

### System.String

You can pipe string objects to this function.

## Outputs

### System.Management.Automation.PSObject

Returns telemetry data for the specified CanFiller device and date range.

## Examples

### Example 1

```powershell
Get-CanFillerTelemetry -Id $id -StartDate $start -EndDate $end
```

This example retrieves telemetry data for a specific CanFiller device by ID.

### Example 2

```powershell
Get-CanFillerTelemetry -Name "My CanFiller" -StartDate "2025-08-01" -EndDate "2025-08-18"
```

This example retrieves telemetry data for a CanFiller device by name.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- If Name is specified, the function will automatically resolve it to the device ID
- Date format should be compatible with the RAPT API (ISO 8601 format recommended)

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Get-CanFiller](Get-CanFiller.md)
- [Connect-Rapt](Connect-Rapt.md)
