#requires -Version 5.1
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
    Requires Pester and PSScriptAnalyzer modules for testing and analysis.
#>
[CmdletBinding()]
param(
    [Parameter()]
    [ValidateSet('Clean', 'Analyze', 'Test', 'Build', 'Publish', 'Default')]
    [string]$Task = 'Default',
    [Parameter()]
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Release',
    [Parameter()]
    [string]$ModuleName = 'power.rapt',
    [Parameter()]
    [string]$OutputPath = (Join-Path $PSScriptRoot 'Output')
)
# Set build variables
$BuildVariables = @{
    ModuleName    = $ModuleName
    Configuration = $Configuration
    OutputPath    = $OutputPath
    SourcePath    = $PSScriptRoot
    ModulePath    = Join-Path $PSScriptRoot "$ModuleName.psm1"
    ManifestPath  = Join-Path $PSScriptRoot "$ModuleName.psd1"
    TestPath      = Join-Path $PSScriptRoot 'tests'
    DocsPath      = Join-Path $PSScriptRoot 'docs'
    PublicPath    = Join-Path $PSScriptRoot 'Public'
    PrivatePath   = Join-Path $PSScriptRoot 'Private'
    AnalyzerPath  = Join-Path $PSScriptRoot 'ScriptAnalyzerSettings.psd1'
}
# Helper functions
function Write-BuildMessage {
    param(
        [string]$Message,
        [string]$Level = 'Info'
    )
    $timestamp = Get-Date -Format 'HH:mm:ss'
    switch ($Level) {
        'Success' { Write-Information "[$timestamp] ✅ $Message" -InformationAction Continue }
        'Warning' { Write-Warning "[$timestamp] ⚠️  $Message" }
        'Error'   { Write-Error "[$timestamp] ❌ $Message" }
        default   { Write-Information "[$timestamp] ℹ️  $Message" -InformationAction Continue }
    }
}
function Install-RequiredModule {
    Write-BuildMessage "Checking required modules..."
    $requiredModules = @('Pester', 'PSScriptAnalyzer', 'PowerShellGet')
    $missingModules = @()
    foreach ($module in $requiredModules) {
        if (-not (Get-Module -Name $module -ListAvailable)) {
            $missingModules += $module
        }
    }
    if ($missingModules.Count -gt 0) {
        Write-BuildMessage "Installing missing modules: $($missingModules -join ', ')" -Level Warning
        foreach ($module in $missingModules) {
            try {
                Install-Module -Name $module -Scope CurrentUser -Force -AllowClobber
                Write-BuildMessage "Installed $module" -Level Success
            }
            catch {
                Write-BuildMessage "Failed to install $module`: $($_.Exception.Message)" -Level Error
                throw
            }
        }
    }
    else {
        Write-BuildMessage "All required modules are available" -Level Success
    }
}
function Invoke-Clean {
    Write-BuildMessage " === = CLEAN TASK === = " -Level Info
    Write-BuildMessage "Cleaning output directory: $($BuildVariables.OutputPath)"
    if (Test-Path $BuildVariables.OutputPath) {
        Remove-Item $BuildVariables.OutputPath -Recurse -Force
        Write-BuildMessage "Removed existing output directory" -Level Success
    }
    New-Item -Path $BuildVariables.OutputPath -ItemType Directory -Force | Out-Null
    Write-BuildMessage "Created clean output directory" -Level Success
}
function Invoke-Analyze {
    Write-BuildMessage " === = ANALYZE TASK === = " -Level Info
    Write-BuildMessage "Running PSScriptAnalyzer..."
    $analyzerResults = @()
    $filesToAnalyze = @()
    # Add core module files
    if (Test-Path $BuildVariables.ModulePath) { $filesToAnalyze += $BuildVariables.ModulePath }
    if (Test-Path $BuildVariables.ManifestPath) { $filesToAnalyze += $BuildVariables.ManifestPath }
    # Add function files
    if (Test-Path $BuildVariables.PublicPath) {
        $filesToAnalyze += Get-ChildItem -Path $BuildVariables.PublicPath -Filter '*.ps1' -Recurse
    }
    if (Test-Path $BuildVariables.PrivatePath) {
        $filesToAnalyze += Get-ChildItem -Path $BuildVariables.PrivatePath -Filter '*.ps1' -Recurse
    }
    Write-BuildMessage "Analyzing $($filesToAnalyze.Count) files..."
    foreach ($file in $filesToAnalyze) {
        if (Test-Path $file) {
            Write-BuildMessage "  Analyzing: $($file.Name)" -Level Info
            $results = if (Test-Path $BuildVariables.AnalyzerPath) {
                Invoke-ScriptAnalyzer -Path $file -Settings $BuildVariables.AnalyzerPath
            } else {
                Invoke-ScriptAnalyzer -Path $file
            }
            $analyzerResults += $results
        }
    }
    if ($analyzerResults) {
        $errorCount = ($analyzerResults | Where-Object Severity -EQ 'Error').Count
        $warningCount = ($analyzerResults | Where-Object Severity -EQ 'Warning').Count
        $infoCount = ($analyzerResults | Where-Object Severity -EQ 'Information').Count
        Write-BuildMessage "PSScriptAnalyzer Results:" -Level Info
        Write-BuildMessage "  Errors: $errorCount" -Level $(if ($errorCount -gt 0) { 'Error' } else { 'Info' })
        Write-BuildMessage "  Warnings: $warningCount" -Level $(if ($warningCount -gt 0) { 'Warning' } else { 'Info' })
        Write-BuildMessage "  Information: $infoCount" -Level Info
        if ($analyzerResults.Count -gt 0) {
            $analyzerResults | Format-Table -AutoSize
        }
        if ($errorCount -gt 0) {
            Write-BuildMessage "PSScriptAnalyzer found $errorCount errors that must be fixed" -Level Error
            throw "Build failed due to PSScriptAnalyzer errors"
        }
        if ($warningCount -gt 0) {
            Write-BuildMessage "PSScriptAnalyzer found $warningCount warnings" -Level Warning
        }
    }
    else {
        Write-BuildMessage "PSScriptAnalyzer completed with no issues found" -Level Success
    }
}
function Invoke-Test {
    Write-BuildMessage " === = TEST TASK === = " -Level Info
    if (-not (Test-Path $BuildVariables.TestPath)) {
        Write-BuildMessage "Test directory not found: $($BuildVariables.TestPath)" -Level Warning
        Write-BuildMessage "Skipping tests" -Level Warning
        return
    }
    Write-BuildMessage "Running Pester tests..."
    # Ensure Output directory exists
    if (-not (Test-Path $BuildVariables.OutputPath)) {
        New-Item -Path $BuildVariables.OutputPath -ItemType Directory -Force | Out-Null
    }
    # Import the module first for testing
    try {
        Import-Module $BuildVariables.ManifestPath -Force
        Write-BuildMessage "Module imported successfully for testing" -Level Success
    }
    catch {
        Write-BuildMessage "Failed to import module for testing: $($_.Exception.Message)" -Level Error
        throw
    }
    $testOutputFile = Join-Path $BuildVariables.OutputPath 'TestResults.xml'
    # Run Pester tests with proper configuration
    $pesterConfig = @{
        Path         = $BuildVariables.TestPath
        OutputFormat = 'NUnitXml'
        OutputFile   = $testOutputFile
        PassThru     = $true
        Verbose      = $false
    }
    $testResults = Invoke-Pester @pesterConfig
    Write-BuildMessage "Test Results:" -Level Info
    Write-BuildMessage "  Total: $($testResults.TotalCount)" -Level Info
    Write-BuildMessage "  Passed: $($testResults.PassedCount)" -Level Success
    Write-BuildMessage "  Failed: $($testResults.FailedCount)" -Level $(if ($testResults.FailedCount -gt 0) { 'Error' } else { 'Success' })
    Write-BuildMessage "  Skipped: $($testResults.SkippedCount)" -Level Info
    if ($testResults.FailedCount -gt 0) {
        Write-BuildMessage "Pester tests failed: $($testResults.FailedCount) out of $($testResults.TotalCount) tests failed" -Level Error
        throw "Build failed due to test failures"
    }
    Write-BuildMessage "All tests passed successfully!" -Level Success
}
function Invoke-Build {
    Write-BuildMessage " === = BUILD TASK === = " -Level Info
    Write-BuildMessage "Building module package..."
    $moduleOutputPath = Join-Path $BuildVariables.OutputPath $BuildVariables.ModuleName
    if (Test-Path $moduleOutputPath) {
        Remove-Item $moduleOutputPath -Recurse -Force
    }
    New-Item -Path $moduleOutputPath -ItemType Directory -Force | Out-Null
    # Copy core module files
    Copy-Item -Path $BuildVariables.ModulePath -Destination $moduleOutputPath
    Copy-Item -Path $BuildVariables.ManifestPath -Destination $moduleOutputPath
    Write-BuildMessage "Copied core module files" -Level Success
    # Copy folders
    $foldersToInclude = @('Public', 'Private', 'docs')
    foreach ($folder in $foldersToInclude) {
        $sourcePath = Join-Path $BuildVariables.SourcePath $folder
        if (Test-Path $sourcePath) {
            $destinationPath = Join-Path $moduleOutputPath $folder
            Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse -Force
            Write-BuildMessage "Copied $folder folder" -Level Success
        }
    }
    # Copy additional files
    $additionalFiles = @('README.md', 'CHANGELOG.md', 'LICENSE')
    foreach ($file in $additionalFiles) {
        $sourcePath = Join-Path $BuildVariables.SourcePath $file
        if (Test-Path $sourcePath) {
            Copy-Item -Path $sourcePath -Destination $moduleOutputPath
            Write-BuildMessage "Copied $file" -Level Success
        }
    }
    Write-BuildMessage "Module built successfully at: $moduleOutputPath" -Level Success
    # Validate the built module
    try {
        $builtManifest = Test-ModuleManifest -Path (Join-Path $moduleOutputPath "$($BuildVariables.ModuleName).psd1")
        Write-BuildMessage "Built module validation passed" -Level Success
        Write-BuildMessage "  Module: $($builtManifest.Name)" -Level Info
        Write-BuildMessage "  Version: $($builtManifest.Version)" -Level Info
        Write-BuildMessage "  Functions: $($builtManifest.ExportedFunctions.Count)" -Level Info
    }
    catch {
        Write-BuildMessage "Built module validation failed: $($_.Exception.Message)" -Level Error
        throw
    }
}
function Invoke-Publish {
    Write-BuildMessage " === = PUBLISH TASK === = " -Level Info
    $moduleOutputPath = Join-Path $BuildVariables.OutputPath $BuildVariables.ModuleName
    if (-not (Test-Path $moduleOutputPath)) {
        Write-BuildMessage "Module package not found. Run Build task first." -Level Error
        throw "Module package not found at: $moduleOutputPath"
    }
    # Validate API key
    if (-not $env:POWERSHELL_GALLERY_API_KEY) {
        Write-BuildMessage "PowerShell Gallery API key not found" -Level Error
        Write-BuildMessage "Set the POWERSHELL_GALLERY_API_KEY environment variable" -Level Error
        throw "PowerShell Gallery API key not found"
    }
    Write-BuildMessage "Publishing module to PowerShell Gallery..."
    try {
        Publish-Module -Path $moduleOutputPath -NuGetApiKey $env:POWERSHELL_GALLERY_API_KEY -Verbose
        Write-BuildMessage "Module published successfully to PowerShell Gallery!" -Level Success
    }
    catch {
        Write-BuildMessage "Failed to publish module: $($_.Exception.Message)" -Level Error
        throw
    }
}
# Main execution
try {
    Write-BuildMessage "Starting build process for $($BuildVariables.ModuleName)" -Level Info
    Write-BuildMessage "Configuration: $Configuration" -Level Info
    Write-BuildMessage "Task: $Task" -Level Info
    # Install required modules first
    Install-RequiredModule
    # Execute tasks based on the requested task
    switch ($Task) {
        'Clean' {
            Invoke-Clean
        }
        'Analyze' {
            Invoke-Analyze
        }
        'Test' {
            Invoke-Analyze
            Invoke-Test
        }
        'Build' {
            Invoke-Clean
            Invoke-Analyze
            Invoke-Test
            Invoke-Build
        }
        'Publish' {
            Invoke-Clean
            Invoke-Analyze
            Invoke-Test
            Invoke-Build
            Invoke-Publish
        }
        'Default' {
            Invoke-Clean
            Invoke-Analyze
            Invoke-Test
        }
        default {
            Write-BuildMessage "Unknown task: $Task" -Level Error
            throw "Unknown task specified"
        }
    }
    Write-BuildMessage "Build completed successfully!" -Level Success
}
catch {
    Write-BuildMessage "Build failed: $($_.Exception.Message)" -Level Error
    exit 1
}
