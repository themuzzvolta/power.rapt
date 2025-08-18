# Power.RAPT PowerShell Module Documentation

The Power.RAPT module provides PowerShell cmdlets for interacting with RAPT (Really Awesome Product Technology) brewing devices and the RAPT portal API.

## Getting Started

Before using any RAPT functions, you must connect to the RAPT portal:

```powershell
Connect-Rapt -Username "your-email@example.com" -ApiKey "your-api-key"
```

## Available Functions

### Connection

- [Connect-Rapt](Connect-Rapt.md) - Connect to RAPT portal

### BrewZilla Functions

#### Information & Telemetry
- [Get-BrewZilla](Get-BrewZilla.md) - Get BrewZilla device information
- [Get-BrewZillaTelemetry](Get-BrewZillaTelemetry.md) - Get BrewZilla telemetry data

#### Control Functions
- [Set-BrewZillaTemp](Set-BrewZillaTemp.md) - Set target temperature
- [Set-BrewZillaHeatingEnabled](Set-BrewZillaHeatingEnabled.md) - Enable/disable heating
- [Set-BrewZillaHeatingUtilisation](Set-BrewZillaHeatingUtilisation.md) - Set heating utilisation
- [Set-BrewZillaPumpEnabled](Set-BrewZillaPumpEnabled.md) - Enable/disable pump
- [Set-BrewZillaPumpUtilisation](Set-BrewZillaPumpUtilisation.md) - Set pump utilisation
- [Set-BrewZillaPIDEnabled](Set-BrewZillaPIDEnabled.md) - Enable/disable PID control
- [Set-BrewZillaPID](Set-BrewZillaPID.md) - Set PID parameters

### Hydrometer Functions

- [Get-Hydrometer](Get-Hydrometer.md) - Get Hydrometer device information
- [Get-HydrometerTelemetry](Get-HydrometerTelemetry.md) - Get Hydrometer telemetry data

### Temperature Controller Functions

- [Get-TemperatureController](Get-TemperatureController.md) - Get TemperatureController device information
- [Get-TemperatureControllerTelemetery](Get-TemperatureControllerTelemetery.md) - Get TemperatureController telemetry data
- [Set-TemperatureControllerTemp](Set-TemperatureControllerTemp.md) - Set target temperature
- [Set-TemperatureControllerPIDEnabled](Set-TemperatureControllerPIDEnabled.md) - Enable/disable PID control

### Fermentation Chamber Functions

- [Get-FermentationChamber](Get-FermentationChamber.md) - Get FermentationChamber device information
- [Get-FermentationChamberTelemetry](Get-FermentationChamberTelemetry.md) - Get FermentationChamber telemetry data
- [Set-FermentationChamberTemp](Set-FermentationChamberTemp.md) - Set target temperature
- [Set-FermentationChamberPIDEnabled](Set-FermentationChamberPIDEnabled.md) - Enable/disable PID control
- [Set-FermentationChamberPID](Set-FermentationChamberPID.md) - Set PID parameters

### Can Filler Functions

- [Get-CanFiller](Get-CanFiller.md) - Get CanFiller device information
- [Get-CanFillerTelemetry](Get-CanFillerTelemetry.md) - Get CanFiller telemetry data

### External Device Functions

- [Get-ExternalDevice](Get-ExternalDevice.md) - Get ExternalDevice information
- [Get-ExternalDeviceTelemetry](Get-ExternalDeviceTelemetry.md) - Get ExternalDevice telemetry data

### Profile Functions

- [Get-Profile](Get-Profile.md) - Get brewing profile information
- [Get-ProfileType](Get-ProfileType.md) - Get profile type information

### Utility Functions

- [Get-UserInfo](Get-UserInfo.md) - Get user information
- [Get-WebHooks](Get-WebHooks.md) - Get webhook information

## Common Parameters

Most functions that work with devices support the following parameter patterns:

### Device Identification
- **Id** - Specify device by unique ID
- **Name** - Specify device by name (automatically resolved to ID)

### Date Ranges
For telemetry functions:
- **StartDate** - Start date for data retrieval (ISO 8601 format recommended)
- **EndDate** - End date for data retrieval (ISO 8601 format recommended)

## Authentication

The module handles authentication automatically:
- Tokens are stored in a script-scoped variable
- Tokens are automatically refreshed when they expire within 2 minutes
- All functions check for valid authentication before making API calls

## Error Handling

All functions include comprehensive error handling:
- Connection validation before API calls
- Automatic token refresh
- Detailed exception information
- Input validation

## Examples

### Basic Usage

```powershell
# Connect to RAPT portal
Connect-Rapt -Username "your-email@example.com" -ApiKey "your-api-key"

# Get all BrewZilla devices
$brewzillas = Get-BrewZilla

# Set temperature on a specific device
Set-BrewZillaTemp -Name "My BrewZilla" -Temperature 65.0

# Get telemetry data
$telemetry = Get-BrewZillaTelemetry -Name "My BrewZilla" -StartDate "2025-08-01" -EndDate "2025-08-18"
```

### Advanced Control

```powershell
# Enable PID control and set parameters
Set-BrewZillaPIDEnabled -Name "My BrewZilla" -State $true
Set-BrewZillaPID -Name "My BrewZilla" -P 1.5 -I 0.5 -D 0.1

# Control heating and pump
Set-BrewZillaHeatingEnabled -Name "My BrewZilla" -State $true
Set-BrewZillaHeatingUtilisation -Name "My BrewZilla" -Utilisation 75
Set-BrewZillaPumpEnabled -Name "My BrewZilla" -State $true
```

## Related Links

- [RAPT Portal](https://app.rapt.io/)
- [RAPT API Documentation](https://api.rapt.io/index.html)
- [RAPT API Secrets](https://app.rapt.io/account/apisecrets)
