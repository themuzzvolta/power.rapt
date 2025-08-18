# Changelog

All notable changes to the power.rapt PowerShell module will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [1.0.0] - 2024-08-18

### Added

- Initial release of power.rapt PowerShell module
- Complete RAPT API coverage with 30 PowerShell functions
- BrewZilla device control and monitoring functions:
  - `Get-BrewZilla` - Retrieve device information
  - `Get-BrewZillaTelemetry` - Get telemetry data
  - `Set-BrewZillaTemp` - Set target temperature
  - `Set-BrewZillaHeatingEnabled` - Control heating element
  - `Set-BrewZillaHeatingUtilisation` - Set heating power percentage
  - `Set-BrewZillaPumpEnabled` - Control pump operation
  - `Set-BrewZillaPumpUtilisation` - Set pump power percentage
  - `Set-BrewZillaPIDEnabled` - Enable/disable PID controller
  - `Set-BrewZillaPID` - Configure PID parameters
- Fermentation Chamber support:
  - `Get-FermentationChamber` - Retrieve chamber information
  - `Get-FermentationChamberTelemetry` - Get telemetry data
  - `Set-FermentationChamberTemp` - Set target temperature
  - `Set-FermentationChamberPIDEnabled` - Control PID controller
  - `Set-FermentationChamberPID` - Configure PID parameters
- Hydrometer functions:
  - `Get-Hydrometer` - Retrieve hydrometer information
  - `Get-HydrometerTelemetry` - Get gravity readings and telemetry
- Temperature Controller functions:
  - `Get-TemperatureController` - Retrieve controller information
  - `Get-TemperatureControllerTelemetery` - Get telemetry data
  - `Set-TemperatureControllerTemp` - Set target temperature
  - `Set-TemperatureControllerPIDEnabled` - Control PID controller
  - `Set-TemperatureControllerPID` - Configure PID parameters
- Additional device support:
  - `Get-CanFiller` / `Get-CanFillerTelemetry` - Can filler support
  - `Get-ExternalDevice` / `Get-ExternalDeviceTelemetry` - Generic device support
- Profile and configuration functions:
  - `Get-Profile` - Retrieve brewing profiles
  - `Get-ProfileType` - Get available profile types
  - `Get-UserInfo` - Get user account information
  - `Get-WebHooks` - Manage webhook configurations
- Authentication function:
  - `Connect-Rapt` - Authenticate with RAPT portal using OAuth
- Comprehensive markdown documentation for all functions
- Professional module manifest with explicit function exports
- PowerShell Gallery compatibility
- Support for PowerShell 5.1+ and PowerShell Core
- Robust error handling and parameter validation
- Device name and ID resolution for all control functions

### Technical Details

- OAuth token-based authentication with session management
- REST API integration with proper error handling
- Parameter validation and type checking
- Comprehensive help documentation
- Cross-platform compatibility (Windows PowerShell and PowerShell Core)
- Minimum requirements: PowerShell 5.1, .NET Framework 4.7.2

### Documentation

- Complete function reference documentation
- Usage examples for all functions
- Professional README with quick start guide
- Markdown documentation following PowerShell standards

[Unreleased]: https://github.com/themuzzvolta/power.rapt/compare/v1.0.0...HEAD
[1.0.0]: https://github.com/themuzzvolta/power.rapt/releases/tag/v1.0.0
