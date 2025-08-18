# Set-BrewZillaPumpEnabled

## Synopsis

Enable or disable pump on your BrewZilla

## Syntax

```powershell
Set-BrewZillaPumpEnabled [[-Id] <String>] [[-Name] <String>] [-State] <Boolean>
```

## Description

The `Set-BrewZillaPumpEnabled` function enables or disables the pump on your BrewZilla device. You can specify the device by either ID or Name.

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

Enable or disable pump (true/false)

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

Returns the response from the RAPT API confirming the pump state change.

## Examples

### Example 1

```powershell
Set-BrewZillaPumpEnabled -Id $id -State $true
```

This example enables the pump on a specific BrewZilla device by ID.

### Example 2

```powershell
Set-BrewZillaPumpEnabled -Name "My BrewZilla" -State $false
```

This example disables the pump on a BrewZilla device by name.

## Notes

- This function requires an active connection to the RAPT portal via `Connect-Rapt`
- If Name is specified, the function will automatically resolve it to the device ID
- Use `$true` to enable the pump and `$false` to disable the pump

## Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)
- [Get-BrewZilla](Get-BrewZilla.md)
- [Set-BrewZillaPumpUtilisation](Set-BrewZillaPumpUtilisation.md)
- [Connect-Rapt](Connect-Rapt.md)
