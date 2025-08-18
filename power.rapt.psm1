#requires -Version 5.1
<#
.SYNOPSIS
    Power.RAPT PowerShell Module
.DESCRIPTION
    PowerShell module for automating RAPT (Really Awesome Product Technology) brewing devices
    including BrewZilla, Fermentation Chambers, Hydrometers, and Temperature Controllers.
.NOTES
    Author: Kurt Murray
    Version: 1.0.0
    Copyright: (c) 2024 Kurt Murray. All rights reserved.
#>
# Set strict mode for better error handling
Set-StrictMode -Version Latest
# Initialize module variables
$script:ModuleRoot = $PSScriptRoot
$script:ModuleName = 'power.rapt'
$script:ModuleVersion = '1.0.0'
# Write module loading message
Write-Verbose "Loading $script:ModuleName module version $script:ModuleVersion"
# Dot source public/private functions
try {
    # Get public and private function files
    $publicPath = Join-Path -Path $script:ModuleRoot -ChildPath 'Public'
    $privatePath = Join-Path -Path $script:ModuleRoot -ChildPath 'Private'
    $public = @()
    $private = @()
    if (Test-Path $publicPath) {
        $public = @(Get-ChildItem -Path "$publicPath/*.ps1" -Recurse -ErrorAction Stop)
    }
    if (Test-Path $privatePath) {
        $private = @(Get-ChildItem -Path "$privatePath/*.ps1" -Recurse -ErrorAction SilentlyContinue)
    }
    # Dot source the files
    foreach ($import in @($public + $private)) {
        try {
            Write-Verbose "Importing function: $($import.BaseName)"
            . $import.FullName
        }
        catch {
            Write-Error "Failed to import function '$($import.BaseName)': $($_.Exception.Message)"
            throw "Unable to dot source [$($import.FullName)]"
        }
    }
    # Export public functions
    if ($public) {
        $functionsToExport = $public | ForEach-Object { $_.BaseName }
        Export-ModuleMember -Function $functionsToExport
        Write-Verbose "Exported $($functionsToExport.Count) functions: $($functionsToExport -join ', ')"
    }
    else {
        Write-Warning "No public functions found to export"
    }
}
catch {
    Write-Error "Failed to load $script:ModuleName module: $($_.Exception.Message)"
    throw
}
# Module cleanup
$MyInvocation.MyCommand.ScriptBlock.Module.OnRemove = {
    Write-Verbose "Cleaning up $script:ModuleName module"
    # Clear any module-scoped variables if needed
    Remove-Variable -Name 'RaptAuthToken' -Scope Script -Force -ErrorAction SilentlyContinue
    Remove-Variable -Name 'RaptBaseUri' -Scope Script -Force -ErrorAction SilentlyContinue
}
Write-Verbose "$script:ModuleName module loaded successfully"
