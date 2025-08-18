#requires -Version 5.1
#requires -Module psake

<#
.SYNOPSIS
    Build script for the power.rapt PowerShell module.

.DESCRIPTION
    This script provides various build tasks for the power.rapt module including:
    - Clean: Remove build artifacts
    - Analyze: Run PSScriptAnalyzer
    - Test: Run Pester tests
    - Build: Create module package
    - Publish: Publish to PowerShell Gallery

.PARAMETER Task
    The build task to execute. Valid values: Clean, Analyze, Test, Build, Publish

.PARAMETER Configuration
    The build configuration. Valid values: Debug, Release (default)

.PARAMETER ModuleName
    The name of the module. Defaults to 'power.rapt'

.PARAMETER OutputPath
    The output path for build artifacts. Defaults to '.\Output'

.EXAMPLE
    .\build.ps1 -Task Build

.EXAMPLE
    .\build.ps1 -Task Test -Configuration Debug

.NOTES
    Requires psake module for task execution.
#>

[CmdletBinding()]
param(
    [Parameter()]
    [ValidateSet('Clean', 'Analyze', 'Test', 'Build', 'Publish', 'Default')]
    [string[]]$Task = 'Default',

    [Parameter()]
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Release',

    [Parameter()]
    [string]$ModuleName = 'power.rapt',

    [Parameter()]
    [string]$OutputPath = (Join-Path $PSScriptRoot 'Output')
)

# Import required modules
$requiredModules = @('psake', 'Pester', 'PSScriptAnalyzer', 'PowerShellGet')

foreach ($module in $requiredModules) {
    if (-not (Get-Module -Name $module -ListAvailable)) {
        Write-Warning "Required module '$module' not found. Installing..."
        try {
            Install-Module -Name $module -Scope CurrentUser -Force -AllowClobber
        }
        catch {
            throw "Failed to install required module '$module': $($_.Exception.Message)"
        }
    }
}

# Set build variables
$script:BuildVariables = @{
    ModuleName = $ModuleName
    Configuration = $Configuration
    OutputPath = $OutputPath
    SourcePath = $PSScriptRoot
    ModulePath = Join-Path $PSScriptRoot "$ModuleName.psm1"
    ManifestPath = Join-Path $PSScriptRoot "$ModuleName.psd1"
    TestPath = Join-Path $PSScriptRoot 'tests'
    DocsPath = Join-Path $PSScriptRoot 'docs'
}

# Define psake tasks
psake.psm1 -nologo -taskList @{

    Task Default -depends Test

    Task Clean {
        "Cleaning output directory: $($script:BuildVariables.OutputPath)"
        if (Test-Path $script:BuildVariables.OutputPath) {
            Remove-Item $script:BuildVariables.OutputPath -Recurse -Force
        }
        New-Item -Path $script:BuildVariables.OutputPath -ItemType Directory -Force | Out-Null
    }

    Task Analyze {
        "Running PSScriptAnalyzer..."
        
        $analyzerResults = @()
        $publicFunctions = Get-ChildItem -Path (Join-Path $script:BuildVariables.SourcePath 'Public') -Filter '*.ps1' -Recurse
        $privateFunctions = Get-ChildItem -Path (Join-Path $script:BuildVariables.SourcePath 'Private') -Filter '*.ps1' -Recurse -ErrorAction SilentlyContinue
        
        $allFiles = @($script:BuildVariables.ModulePath, $script:BuildVariables.ManifestPath) + $publicFunctions + $privateFunctions
        
        foreach ($file in $allFiles) {
            if (Test-Path $file) {
                $results = Invoke-ScriptAnalyzer -Path $file -Settings (Join-Path $script:BuildVariables.SourcePath 'ScriptAnalyzerSettings.psd1')
                $analyzerResults += $results
            }
        }
        
        if ($analyzerResults) {
            $analyzerResults | Format-Table -AutoSize
            $errorCount = ($analyzerResults | Where-Object Severity -eq 'Error').Count
            $warningCount = ($analyzerResults | Where-Object Severity -eq 'Warning').Count
            
            Write-Host "PSScriptAnalyzer found $errorCount errors and $warningCount warnings" -ForegroundColor Yellow
            
            if ($errorCount -gt 0) {
                throw "PSScriptAnalyzer found $errorCount errors that must be fixed before continuing."
            }
        } else {
            Write-Host "PSScriptAnalyzer completed with no issues found." -ForegroundColor Green
        }
    }

    Task Test -depends Analyze {
        "Running Pester tests..."
        
        if (-not (Test-Path $script:BuildVariables.TestPath)) {
            Write-Warning "Test directory not found: $($script:BuildVariables.TestPath)"
            return
        }
        
        $testResults = Invoke-Pester -Path $script:BuildVariables.TestPath -OutputFormat NUnitXml -OutputFile (Join-Path $script:BuildVariables.OutputPath 'TestResults.xml') -PassThru
        
        if ($testResults.FailedCount -gt 0) {
            throw "Pester tests failed. $($testResults.FailedCount) out of $($testResults.TotalCount) tests failed."
        }
        
        Write-Host "All $($testResults.TotalCount) tests passed!" -ForegroundColor Green
    }

    Task Build -depends Test {
        "Building module..."
        
        $moduleOutputPath = Join-Path $script:BuildVariables.OutputPath $script:BuildVariables.ModuleName
        New-Item -Path $moduleOutputPath -ItemType Directory -Force | Out-Null
        
        # Copy module files
        Copy-Item -Path $script:BuildVariables.ModulePath -Destination $moduleOutputPath
        Copy-Item -Path $script:BuildVariables.ManifestPath -Destination $moduleOutputPath
        
        # Copy Public and Private folders
        $sourcePaths = @('Public', 'Private', 'docs')
        foreach ($path in $sourcePaths) {
            $sourcePath = Join-Path $script:BuildVariables.SourcePath $path
            if (Test-Path $sourcePath) {
                $destinationPath = Join-Path $moduleOutputPath $path
                Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse -Force
            }
        }
        
        # Copy additional files
        $additionalFiles = @('README.md', 'CHANGELOG.md', 'LICENSE')
        foreach ($file in $additionalFiles) {
            $sourcePath = Join-Path $script:BuildVariables.SourcePath $file
            if (Test-Path $sourcePath) {
                Copy-Item -Path $sourcePath -Destination $moduleOutputPath
            }
        }
        
        Write-Host "Module built successfully at: $moduleOutputPath" -ForegroundColor Green
    }

    Task Publish -depends Build {
        "Publishing module to PowerShell Gallery..."
        
        $moduleOutputPath = Join-Path $script:BuildVariables.OutputPath $script:BuildVariables.ModuleName
        
        # Validate API key
        if (-not $env:POWERSHELL_GALLERY_API_KEY) {
            throw "PowerShell Gallery API key not found. Set the POWERSHELL_GALLERY_API_KEY environment variable."
        }
        
        try {
            Publish-Module -Path $moduleOutputPath -NuGetApiKey $env:POWERSHELL_GALLERY_API_KEY -Verbose
            Write-Host "Module published successfully to PowerShell Gallery!" -ForegroundColor Green
        }
        catch {
            throw "Failed to publish module: $($_.Exception.Message)"
        }
    }
}

# Execute psake with specified tasks
try {
    Invoke-psake -taskList $Task -properties $script:BuildVariables
    
    if (-not $psake.build_success) {
        throw "Build failed. See output for details."
    }
}
catch {
    Write-Error "Build script failed: $($_.Exception.Message)"
    exit 1
}

Write-Host "Build completed successfully!" -ForegroundColor Green
