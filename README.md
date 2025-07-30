# Power.RAPT Module Documentation

The Power.RAPT module provides PowerShell cmdlets for interacting with the RAPT.io brewing platform API. This module allows you to manage and monitor your brewing devices including BrewZillas, Hydrometers, and Temperature Controllers.

## Prerequisites

- PowerShell 5.1 or later
- Valid RAPT.io account with API access
- API key generated from the RAPT portal

## Installation

Import the module:

```powershell
Import-Module power.rapt
```

## Quick Start

First, connect to the RAPT portal:

```powershell
Connect-Rapt -username "your-email@example.com" -apiKey "your-api-key"
```

## Available Functions

### Connection Management

- [Connect-Rapt](#connect-rapt) - Connect to RAPT portal

### Device Information

- [Get-BrewZilla](#get-brewzilla) - Get information about your BrewZilla(s)
- [Get-Hydrometer](#get-hydrometer) - Get information about your Hydrometer(s)
- [Get-TemperatureController](#get-temperaturecontroller) - Get information about your Temperature Controller(s)

### Telemetry Data

- [Get-BrewZillaTelemetry](#get-brewzillatelemetry) - Get telemetry data from your BrewZilla(s)
- [Get-HydrometerTelemetry](#get-hydrometertelemetry) - Get telemetry data from your Hydrometer(s)
- [Get-TemperatureControllerTelemetry](#get-temperaturecontrollertelemetry) - Get telemetry data from your Temperature Controller(s)

### Device Control

- [Set-BrewZillaTemp](#set-brewzillatemp) - Set temperature target for your BrewZilla
- [Set-TemperatureControllerTemp](#set-temperaturecontrollertemp) - Set temperature target for your Temperature Controller

### Profile and Configuration

- [Get-Profile](#get-profile) - Get information about your Profile(s)
- [Get-ProfileType](#get-profiletype) - Get information about available ProfileType(s)

### Account and System

- [Get-UserInfo](#get-userinfo) - Get information about your RAPT account
- [Get-WebHooks](#get-webhooks) - Get information about your WebHook(s)

## Function Reference

### Connect-Rapt

Establishes a connection to the RAPT portal and obtains an authentication token.

#### Syntax

```powershell
Connect-Rapt -username <String> -apiKey <String>
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| username | String | Yes | Username/email used to connect to the RAPT portal |
| apiKey | String | Yes | API key created via the RAPT portal |

#### Inputs

- System.String

#### Outputs

- System.Object

#### Example

```powershell
Connect-Rapt -username $myEmail -apiKey $myApiSecret
```

#### Related Links

- [RAPT API Secrets](https://app.rapt.io/account/apisecrets)

---

### Get-BrewZilla

Retrieves information about your BrewZilla devices.

#### Syntax

```powershell
Get-BrewZilla
```

#### Parameters

None

#### Inputs

None

#### Outputs

- System.Object

#### Example

```powershell
Get-BrewZilla
```

#### Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)

---

### Get-BrewZillaTelemetry

Retrieves telemetry data from your BrewZilla devices for a specified time period.

#### Syntax

```powershell
Get-BrewZillaTelemetry [-Id <String>] [-Name <String>] -StartDate <String> -EndDate <String>
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| Id | String | No | ID of your BrewZilla |
| Name | String | No | Name of your BrewZilla |
| StartDate | String | Yes | Start date to get data from |
| EndDate | String | Yes | End date to get data until |

#### Inputs

- System.String

#### Outputs

- System.Object

#### Example

```powershell
Get-BrewZillaTelemetry -Id $id -StartDate $start -EndDate $end
```

#### Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)

---

### Get-Hydrometer

Retrieves information about your Hydrometer devices.

#### Syntax

```powershell
Get-Hydrometer
```

#### Parameters

None

#### Inputs

None

#### Outputs

- System.Object

#### Example

```powershell
Get-Hydrometer
```

#### Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)

---

### Get-HydrometerTelemetry

Retrieves telemetry data from your Hydrometer devices for a specified time period.

#### Syntax

```powershell
Get-HydrometerTelemetry [-Id <String>] [-Name <String>] -StartDate <String> -EndDate <String>
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| Id | String | No | ID of your Hydrometer |
| Name | String | No | Name of your Hydrometer |
| StartDate | String | Yes | Start date to get data from |
| EndDate | String | Yes | End date to get data until |

#### Inputs

- System.String

#### Outputs

- System.Object

#### Example

```powershell
Get-HydrometerTelemetry -Id $id -StartDate $start -EndDate $end
```

#### Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)

---

### Get-Profile

Retrieves information about your brewing profiles.

#### Syntax

```powershell
Get-Profile
```

#### Parameters

None

#### Inputs

None

#### Outputs

- System.Object

#### Example

```powershell
Get-Profile
```

#### Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)

---

### Get-ProfileType

Retrieves information about available profile types.

#### Syntax

```powershell
Get-ProfileType
```

#### Parameters

None

#### Inputs

None

#### Outputs

- System.Object

#### Example

```powershell
Get-ProfileType
```

#### Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)

---

### Get-TemperatureController

Retrieves information about your Temperature Controller devices.

#### Syntax

```powershell
Get-TemperatureController
```

#### Parameters

None

#### Inputs

None

#### Outputs

- System.Object

#### Example

```powershell
Get-TemperatureController
```

#### Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)

---

### Get-TemperatureControllerTelemetry

Retrieves telemetry data from your Temperature Controller devices for a specified time period.

#### Syntax

```powershell
Get-TemperatureControllerTelemetry [-Id <String>] [-Name <String>] -StartDate <String> -EndDate <String>
```

#### Aliases

- Get-TempControllerTelemetery

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| Id | String | No | ID of your Temperature Controller |
| Name | String | No | Name of your Temperature Controller |
| StartDate | String | Yes | Start date to get data from |
| EndDate | String | Yes | End date to get data until |

#### Inputs

- System.String

#### Outputs

- System.Object

#### Example

```powershell
Get-TemperatureControllerTelemetry -Id $id -StartDate $start -EndDate $end
```

#### Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)

---

### Get-UserInfo

Retrieves information about your RAPT account.

#### Syntax

```powershell
Get-UserInfo
```

#### Parameters

None

#### Inputs

None

#### Outputs

- System.Object

#### Example

```powershell
Get-UserInfo
```

#### Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)

---

### Get-WebHooks

Retrieves information about your configured WebHooks.

#### Syntax

```powershell
Get-WebHooks
```

#### Parameters

None

#### Inputs

None

#### Outputs

- System.Object

#### Example

```powershell
Get-WebHooks
```

#### Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)

---

### Set-BrewZillaTemp

Sets the temperature target for your BrewZilla device.

#### Syntax

```powershell
Set-BrewZillaTemp [-Id <String>] [-Name <String>] -Temperature <Double>
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| Id | String | No | ID of your BrewZilla |
| Name | String | No | Name of your BrewZilla |
| Temperature | Double | Yes | Temperature target for your BrewZilla |

#### Aliases

- Temp (for Temperature parameter)

#### Inputs

- System.String
- System.Double

#### Outputs

- System.Object

#### Example

```powershell
Set-BrewZillaTemp -Id $id -Temperature $temp
```

#### Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)

---

### Set-TemperatureControllerTemp

Sets the temperature target for your Temperature Controller device.

#### Syntax

```powershell
Set-TemperatureControllerTemp [-Id <String>] [-Name <String>] -Temperature <Double>
```

#### Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| Id | String | No | ID of your Temperature Controller |
| Name | String | No | Name of your Temperature Controller |
| Temperature | Double | Yes | Temperature target for your Temperature Controller |

#### Aliases

- Temp (for Temperature parameter)

#### Inputs

- System.String
- System.Double

#### Outputs

- System.Object

#### Example

```powershell
Set-TemperatureControllerTemp -Id $id -Temperature $temp
```

#### Related Links

- [RAPT API Documentation](https://api.rapt.io/index.html)

---

## Notes

- All functions (except `Connect-Rapt`) require an active connection to the RAPT portal
- Authentication tokens are automatically refreshed when they expire (< 2 minutes remaining)
- Functions that accept both `Id` and `Name` parameters allow you to specify devices by either identifier
- Date parameters should be provided in a format that PowerShell can parse (e.g., "2023-01-01", "01/01/2023")

## Error Handling

If you haven't connected to the RAPT portal, most functions will throw an error:

```text
Please connect to the RAPT.io portal using the Connect-Rapt cmdlet
```

Make sure to call `Connect-Rapt` first before using any other functions in the module.
