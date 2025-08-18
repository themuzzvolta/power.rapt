# Set-BrewZillaHeatingUtilisation

## Synopsis

Set heating utilisation on your BrewZilla

## Syntax

```powershell
Set-BrewZillaHeatingUtilisation [[-Id] <String>] [[-Name] <String>] [-Utilisation] <Double>
```

## Description

The `Set-BrewZillaHeatingUtilisation` function sets the heating utilisation percentage for your BrewZilla device. You can specify the device by either ID or Name.

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

### Name

Name of your BrewZilla

- **Type**: String
- **Parameter Sets**: (All)
- **Aliases**: None
- **Required**: False
- **Position**: Named
- **Default value**: None
- **Accept pipeline input**: False
- **Accept wildcard characters**: False

### Utilisation

Heating utilisation percentage

- **Type**: Double
- **Parameter Sets**: (All)
- **Aliases**: None
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

Returns the response from the RAPT API confirming the heating utilisation setting.

## Examples

### Example 1

```powershell
Set-BrewZillaHeatingUtilisation -Id $id -Utilisation 75.5
```

This example sets the heating utilisation to 75.5% for a specific BrewZilla device by ID.

### Example 2

```powershell
Set-BrewZillaHeatingUtilisation -Name "My BrewZilla" -Utilisation 50
```

This example sets the heating utilisation to 50% for a BrewZilla device by name.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- If Name is specified, the function will automatically resolve it to the device ID
- Utilisation percentage should typically be between 0 and 100

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Get-BrewZilla](Get-BrewZilla.md)
- [Set-BrewZillaHeatingEnabled](Set-BrewZillaHeatingEnabled.md)
- [Connect-Rapt](Connect-Rapt.md)
