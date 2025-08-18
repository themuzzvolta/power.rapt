# Power.RAPT PowerShell Module

[![PowerShell Gallery](https://img.shields.io/powershellgallery/v/power.rapt.svg)](https://www.powershellgallery.com/packages/power.rapt)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)](https://github.com/PowerShell/PowerShell)

A comprehensive PowerShell module for automating RAPT (Really Awesome Product Technology) brewing devices including BrewZilla, Fermentation Chambers, Hydrometers, and Temperature Controllers.

## 🍺 About RAPT

RAPT is a leading manufacturer of brewing automation equipment that helps homebrewers and commercial brewers monitor and control their brewing processes. This PowerShell module provides a complete interface to the RAPT API, allowing you to:

- Monitor and control BrewZilla systems
- Manage fermentation chambers and temperature controllers
- Retrieve telemetry data from hydrometers
- Automate brewing workflows
- Integrate brewing data with other systems

## 🚀 Features

- **30 PowerShell Functions** covering the complete RAPT API
- **Device Control**: Start/stop heating, pumps, and PID controllers
- **Telemetry Access**: Real-time data from all connected devices
- **Profile Management**: Create and manage brewing profiles
- **Webhook Support**: Configure notifications and integrations
- **Comprehensive Documentation**: Detailed help for every function
- **Error Handling**: Robust error handling with meaningful messages
- **Authentication**: Secure OAuth token management

## 📦 Installation

### From PowerShell Gallery (Recommended)

```powershell
Install-Module -Name power.rapt -Scope CurrentUser
```

### From GitHub

```powershell
# Clone the repository
git clone https://github.com/themuzzvolta/power.rapt.git

# Import the module
Import-Module .\power.rapt\power.rapt.psd1
```

## 🏁 Quick Start

### 1. Connect to RAPT Portal

```powershell
# Connect using your RAPT portal credentials
Connect-Rapt -Username "your-email@example.com" -Password "your-password"
```

### 2. List Your Devices

```powershell
# Get all BrewZilla devices
Get-BrewZilla

# Get fermentation chambers
Get-FermentationChamber

# Get hydrometers
Get-Hydrometer
```

### 3. Control Your Devices

```powershell
# Set BrewZilla temperature
Set-BrewZillaTemp -DeviceName "My BrewZilla" -Temperature 65

# Enable heating
Set-BrewZillaHeatingEnabled -DeviceName "My BrewZilla" -Enabled $true

# Start the pump
Set-BrewZillaPumpEnabled -DeviceName "My BrewZilla" -Enabled $true
```

### 4. Monitor Telemetry

```powershell
# Get recent telemetry data
Get-BrewZillaTelemetry -DeviceName "My BrewZilla" -StartDate (Get-Date).AddHours(-1)

# Get hydrometer readings
Get-HydrometerTelemetry -DeviceName "My Hydrometer" -StartDate (Get-Date).AddDays(-1)
```

## 📚 Available Functions

### Authentication

- `Connect-Rapt` - Authenticate with RAPT portal

### BrewZilla Functions

- `Get-BrewZilla` - Retrieve BrewZilla device information
- `Get-BrewZillaTelemetry` - Get telemetry data
- `Set-BrewZillaTemp` - Set target temperature
- `Set-BrewZillaHeatingEnabled` - Control heating element
- `Set-BrewZillaHeatingUtilisation` - Set heating power percentage
- `Set-BrewZillaPumpEnabled` - Control pump operation
- `Set-BrewZillaPumpUtilisation` - Set pump power percentage
- `Set-BrewZillaPIDEnabled` - Enable/disable PID controller
- `Set-BrewZillaPID` - Configure PID parameters

### Fermentation Chamber Functions

- `Get-FermentationChamber` - Retrieve chamber information
- `Get-FermentationChamberTelemetry` - Get telemetry data
- `Set-FermentationChamberTemp` - Set target temperature
- `Set-FermentationChamberPIDEnabled` - Control PID controller
- `Set-FermentationChamberPID` - Configure PID parameters

### Hydrometer Functions

- `Get-Hydrometer` - Retrieve hydrometer information
- `Get-HydrometerTelemetry` - Get gravity readings and telemetry

### Temperature Controller Functions

- `Get-TemperatureController` - Retrieve controller information
- `Get-TemperatureControllerTelemetery` - Get telemetry data
- `Set-TemperatureControllerTemp` - Set target temperature
- `Set-TemperatureControllerPIDEnabled` - Control PID controller
- `Set-TemperatureControllerPID` - Configure PID parameters

### Additional Device Support

- `Get-CanFiller` / `Get-CanFillerTelemetry` - Can filler support
- `Get-ExternalDevice` / `Get-ExternalDeviceTelemetry` - Generic device support

### Profile and Configuration

- `Get-Profile` - Retrieve brewing profiles
- `Get-ProfileType` - Get available profile types
- `Get-UserInfo` - Get user account information
- `Get-WebHooks` - Manage webhook configurations

## 📖 Documentation

Comprehensive documentation is available for all functions:

```powershell
# Get help for any function
Get-Help Connect-Rapt -Full
Get-Help Set-BrewZillaTemp -Examples
```

All function documentation is also available in the [docs](./docs) folder.

## 🔧 Requirements

- PowerShell 5.1 or later (Windows PowerShell or PowerShell Core)
- .NET Framework 4.7.2 or later (Windows PowerShell)
- RAPT portal account with API access
- Active RAPT devices registered to your account

## 🤝 Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙋‍♂️ Support

- **Documentation**: Check the [docs](./docs) folder for detailed function help
- **Issues**: Report bugs and request features via [GitHub Issues](https://github.com/themuzzvolta/power.rapt/issues)
- **RAPT Support**: For device-specific issues, contact [RAPT Support](https://rapt.io/support)

## 🔗 Related Links

- [RAPT Official Website](https://rapt.io)
- [RAPT API Documentation](https://api.rapt.io)
- [PowerShell Gallery](https://www.powershellgallery.com/packages/power.rapt)

---

**Happy Brewing!** 🍻
