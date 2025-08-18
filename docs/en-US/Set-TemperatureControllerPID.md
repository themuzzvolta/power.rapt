# Set-TemperatureControllerPID

## Synopsis

Set PID parameters on your TemperatureController

## Syntax

```powershell
Set-TemperatureControllerPID [[-Id] <String>] [[-Name] <String>] [-P] <Double> [-I] <Double> [-D] <Double>
```

## Description

The `Set-TemperatureControllerPID` function sets the PID (Proportional-Integral-Derivative) control parameters for your TemperatureController device. You can specify the device by either ID or Name.

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

### Name

Name of your TemperatureController

- **Type**: String
- **Parameter Sets**: (All)
- **Aliases**: None
- **Required**: False
- **Position**: Named
- **Default value**: None
- **Accept pipeline input**: False
- **Accept wildcard characters**: False

### P

Proportional parameter

- **Type**: Double
- **Parameter Sets**: (All)
- **Aliases**: None
- **Required**: True
- **Position**: Named
- **Default value**: None
- **Accept pipeline input**: False
- **Accept wildcard characters**: False

### I

Integral parameter

- **Type**: Double
- **Parameter Sets**: (All)
- **Aliases**: None
- **Required**: True
- **Position**: Named
- **Default value**: None
- **Accept pipeline input**: False
- **Accept wildcard characters**: False

### D

Derivative parameter

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

Returns the response from the RAPT API confirming the PID parameter settings.

## Examples

### Example 1

```powershell
Set-TemperatureControllerPID -Id $id -P 1.5 -I 0.5 -D 0.1
```

This example sets PID parameters for a specific TemperatureController device by ID.

### Example 2

```powershell
Set-TemperatureControllerPID -Name "My Controller" -P 2.0 -I 1.0 -D 0.2
```

This example sets PID parameters for a TemperatureController device by name.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- If Name is specified, the function will automatically resolve it to the device ID
- PID parameters affect temperature control precision and response
- P (Proportional): Controls reaction to current error
- I (Integral): Controls reaction to accumulated error over time
- D (Derivative): Controls reaction to rate of error change

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Get-TemperatureController](Get-TemperatureController.md)
- [Set-TemperatureControllerPIDEnabled](Set-TemperatureControllerPIDEnabled.md)
- [Set-TemperatureControllerTemp](Set-TemperatureControllerTemp.md)
- [Connect-Rapt](Connect-Rapt.md)
