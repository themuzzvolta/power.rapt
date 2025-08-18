# Set-BrewZillaHeatingEnabled

## Synopsis

Enable or disable heating on your BrewZilla

## Syntax

```powershell
Set-BrewZillaHeatingEnabled [[-Id] <String>] [[-Name] <String>] [-State] <Boolean>
```

## Description

The `Set-BrewZillaHeatingEnabled` function enables or disables the heating element on your BrewZilla device. You can specify the device by either ID or Name.

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

Enable or disable heating (true/false)

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

Returns the response from the RAPT API confirming the heating state change.

## Examples

### Example 1

```powershell
Set-BrewZillaHeatingEnabled -Id $id -State $true
```

This example enables heating on a specific BrewZilla device by ID.

### Example 2

```powershell
Set-BrewZillaHeatingEnabled -Name "My BrewZilla" -State $false
```

This example disables heating on a BrewZilla device by name.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- If Name is specified, the function will automatically resolve it to the device ID
- Use `$true` to enable heating and `$false` to disable heating

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Get-BrewZilla](Get-BrewZilla.md)
- [Set-BrewZillaHeatingUtilisation](Set-BrewZillaHeatingUtilisation.md)
- [Connect-Rapt](Connect-Rapt.md)
