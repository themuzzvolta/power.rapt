# Set-BrewZillaPIDEnabled

## Synopsis

Enable or disable PID control on your BrewZilla

## Syntax

```powershell
Set-BrewZillaPIDEnabled [[-Id] <String>] [[-Name] <String>] [-State] <Boolean>
```

## Description

The `Set-BrewZillaPIDEnabled` function enables or disables PID (Proportional-Integral-Derivative) control on your BrewZilla device. You can specify the device by either ID or Name.

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

### State

Enable or disable PID control (true/false)

- **Type**: Boolean
- **Parameter Sets**: (All)
- **Aliases**: None
- **Required**: True
- **Position**: Named
- **Default value**: None
- **Accept pipeline input**: False
- **Accept wildcard characters**: False

## Inputs

### System.String

### System.Boolean

You can pipe string and boolean objects to this function.

## Outputs

### System.Management.Automation.PSObject

Returns the response from the RAPT API confirming the PID control state change.

## Examples

### Example 1

```powershell
Set-BrewZillaPIDEnabled -Id $id -State $true
```

This example enables PID control on a specific BrewZilla device by ID.

### Example 2

```powershell
Set-BrewZillaPIDEnabled -Name "My BrewZilla" -State $false
```

This example disables PID control on a BrewZilla device by name.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- If Name is specified, the function will automatically resolve it to the device ID
- PID control provides more precise temperature regulation
- Use `$true` to enable PID control and `$false` to disable it

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Get-BrewZilla](Get-BrewZilla.md)
- [Set-BrewZillaPID](Set-BrewZillaPID.md)
- [Connect-Rapt](Connect-Rapt.md)
