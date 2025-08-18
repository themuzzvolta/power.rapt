# Set-FermentationChamberTemp

## Synopsis

Set target temperature on your FermentationChamber

## Syntax

```powershell
Set-FermentationChamberTemp [[-Id] <String>] [[-Name] <String>] [-Temperature] <Double>
```

## Description

The `Set-FermentationChamberTemp` function sets the target temperature for your FermentationChamber device. You can specify the device by either ID or Name.

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

### Name

Name of your FermentationChamber

- **Type**: String
- **Parameter Sets**: (All)
- **Aliases**: None
- **Required**: False
- **Position**: Named
- **Default value**: None
- **Accept pipeline input**: False
- **Accept wildcard characters**: False

### Temperature

Temperature target for your FermentationChamber

- **Type**: Double
- **Parameter Sets**: (All)
- **Aliases**: Temp
- **Required**: True
- **Position**: Named
- **Default value**: None
- **Accept pipeline input**: False
- **Accept wildcard characters**: False

## Inputs

### System.String

### System.Double

You can pipe string and double objects to this function.

## Outputs

### System.Management.Automation.PSObject

Returns the response from the RAPT API confirming the temperature setting.

## Examples

### Example 1

```powershell
Set-FermentationChamberTemp -Id $id -Temperature $temp
```

This example sets the temperature for a specific FermentationChamber device by ID.

### Example 2

```powershell
Set-FermentationChamberTemp -Name "My FermentationChamber" -Temp 20.5
```

This example sets the temperature for a FermentationChamber device by name using the Temp alias.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- If Name is specified, the function will automatically resolve it to the device ID
- Temperature units depend on your RAPT portal settings (Celsius or Fahrenheit)

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Get-FermentationChamber](Get-FermentationChamber.md)
- [Set-FermentationChamberPIDEnabled](Set-FermentationChamberPIDEnabled.md)
- [Connect-Rapt](Connect-Rapt.md)
