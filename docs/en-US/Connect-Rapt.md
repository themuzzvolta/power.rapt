# Connect-Rapt

## Synopsis

Connect to RAPT portal

## Syntax

```powershell
Connect-Rapt -Username <String> -ApiKey <String>
```

## Description

The `Connect-Rapt` function establishes a connection to the RAPT portal using your username/email and API key. This function must be called before using any other RAPT functions as it obtains and stores the authentication token required for API access.

## Parameters

### Username

Username/email used to connect to the RAPT portal

- **Type**: String
- **Parameter Sets**: (All)
- **Aliases**: None
- **Required**: True
- **Position**: Named
- **Default value**: None
- **Accept pipeline input**: False
- **Accept wildcard characters**: False

### ApiKey

Api key created via the RAPT portal

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

Returns an object containing authentication details including access token, expiration time, and base URI.

## Examples

### Example 1

```powershell
Connect-Rapt -Username $myEmail -ApiKey $myApiSecret
```

This example connects to the RAPT portal using the specified email and API key.

## Notes

- The API key can be created via the RAPT portal at: <https://app.rapt.io/account/apisecrets>
- The connection object is stored in a script-scoped variable for use by other functions
- The access token automatically expires and will be refreshed by other functions when needed

## Related Links

- [RAPT Portal API Secrets](https://app.rapt.io/account/apisecrets)
- [RAPT API Documentation](https://api.rapt.io/index.html)
