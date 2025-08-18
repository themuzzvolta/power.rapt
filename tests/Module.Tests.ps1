BeforeAll {
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]`n        # # $ModuleRoot = Split-Path $PSScriptRoot -Parent  # TODO: Update tests  # TODO: Update tests
    $ModuleName = 'power.rapt'
    $ManifestPath = Join-Path $ModuleRoot "$ModuleName.psd1"
    if (Get-Module $ModuleName) {
        Remove-Module $ModuleName -Force
    }
    Import-Module $ManifestPath -Force
}
Describe 'Module Manifest Tests' -Tag 'Module' {
    Context 'Manifest Validation' {
        BeforeAll {
            [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]`n        # # $ModuleRoot = Split-Path $PSScriptRoot -Parent  # TODO: Update tests  # TODO: Update tests
            $ModuleName = 'power.rapt'
            $ManifestPath = Join-Path $ModuleRoot "$ModuleName.psd1"
            [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]`n        # # $ManifestData = Test-ModuleManifest -Path $ManifestPath -ErrorAction SilentlyContinue -WarningAction SilentlyContinue  # TODO: Update tests  # TODO: Update tests
        }
        It 'Should have a valid manifest' {
            $ManifestData | Should -Not -BeNullOrEmpty
        }
        It 'Should have the correct module name' {
            $ManifestData.Name | Should -Be 'power.rapt'
        }
        It 'Should have the correct author' {
            $ManifestData.Author | Should -Be 'Kurt Murray'
        }
        It 'Should have a description' {
            $ManifestData.Description | Should -Not -BeNullOrEmpty
        }
        It 'Should have a valid version' {
            $ManifestData.Version | Should -Match '^\d+\.\d+\.\d+$'
        }
        It 'Should have a valid GUID' {
            $ManifestData.Guid | Should -Match '^[a-f0-9]{8}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{4}-[a-f0-9]{12}$'
        }
        It 'Should have PowerShell version requirement' {
            $ManifestData.PowerShellVersion | Should -Be '5.1'
        }
        It 'Should have compatible PowerShell editions' {
            $ManifestData.CompatiblePSEditions | Should -Contain 'Desktop'
            $ManifestData.CompatiblePSEditions | Should -Contain 'Core'
        }
    }
    Context 'Exported Functions' {
        BeforeAll {
        }
        It 'Should export functions' {
            $ExportedFunctions | Should -Not -BeNullOrEmpty
        }
        It 'Should export Connect-Rapt function' {
            $ExportedFunctions.Name | Should -Contain 'Connect-Rapt'
        }
        It 'Should export BrewZilla functions' {
            $ExportedFunctions.Name | Should -Contain 'Get-BrewZilla'
            $ExportedFunctions.Name | Should -Contain 'Set-BrewZillaTemp'
        }
        It 'Should export all required functions' {
            $RequiredFunctions = @(
                'Connect-Rapt',
                'Get-BrewZilla',
                'Get-BrewZillaTelemetry',
                'Set-BrewZillaTemp',
                'Get-Hydrometer',
                'Get-HydrometerTelemetry',
                'Get-TemperatureController'
            )
            foreach ($Function in $RequiredFunctions) {
                $ExportedFunctions.Name | Should -Contain $Function
            }
        }
    }
}
Describe 'Function Structure Tests' -Tag 'Function' {
    BeforeAll {
        [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]`n        # # $ModuleRoot = Split-Path $PSScriptRoot -Parent  # TODO: Update tests  # TODO: Update tests
    }
    Context 'Function Files' {
        It 'Should have public functions' {
            $PublicFunctions | Should -Not -BeNullOrEmpty
        }
        It 'Should have proper file naming convention' {
            foreach ($Function in $PublicFunctions) {
                $Function.BaseName | Should -Match '^(Get|Set|New|Remove|Connect|Disconnect|Start|Stop|Enable|Disable|Add|Clear|Test|Invoke)-'
            }
        }
    }
    Context 'Function Content' {
        foreach ($FunctionFile in $PublicFunctions) {
            Context "Function: $($FunctionFile.BaseName)" {
                BeforeAll {
                    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]`n        # # $FunctionContent = Get-Content -Path $FunctionFile.FullName -Raw  # TODO: Update tests  # TODO: Update tests
                }
                It 'Should have a function definition' {
                    $FunctionContent | Should -Match 'function\s+\w+-\w+'
                }
                It 'Should have comment-based help' {
                    $FunctionContent | Should -Match '\.SYNOPSIS'
                    $FunctionContent | Should -Match '\.DESCRIPTION'
                }
                It 'Should have parameter definitions' {
                    $FunctionContent | Should -Match '\[Parameter'
                }
                It 'Should use approved verbs' {
                    $Verb = ($FunctionContent -split 'function\s+')[1] -split '-' | Select-Object -First 1
                    $ApprovedVerbs = Get-Verb | Select-Object -ExpandProperty Verb
                    $ApprovedVerbs | Should -Contain $Verb
                }
            }
        }
    }
}
Describe 'Module Import Tests' -Tag 'Import' {
    Context 'Module Loading' {
        It 'Should import without errors' {
            {
                [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]`n        # # $ModuleRoot = Split-Path $PSScriptRoot -Parent  # TODO: Update tests  # TODO: Update tests
                $ModuleName = 'power.rapt'
                $ManifestPath = Join-Path $ModuleRoot "$ModuleName.psd1"
                if (Get-Module $ModuleName) {
                    Remove-Module $ModuleName -Force
                }
                Import-Module $ManifestPath -Force
            } | Should -Not -Throw
        }
        It 'Should load all expected functions' {
            $LoadedFunctions = Get-Command -Module 'power.rapt' -CommandType Function
            $LoadedFunctions.Count | Should -BeGreaterThan 25
        }
    }
}
AfterAll {
    Remove-Module 'power.rapt' -Force -ErrorAction SilentlyContinue
}
