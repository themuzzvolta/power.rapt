BeforeAll {
    $ModuleRoot = Split-Path $PSScriptRoot -Parent
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
            $ModuleRoot = Split-Path $PSScriptRoot -Parent
            $ModuleName = 'power.rapt'
            $ManifestPath = Join-Path $ModuleRoot "$ModuleName.psd1"
            $ManifestData = Test-ModuleManifest -Path $ManifestPath -ErrorAction SilentlyContinue -WarningAction SilentlyContinue
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
            $ExportedFunctions = Get-Command -Module 'power.rapt' -CommandType Function
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
        $ModuleRoot = Split-Path $PSScriptRoot -Parent
        $PublicFunctions = Get-ChildItem -Path (Join-Path $ModuleRoot 'Public') -Filter '*.ps1' -Recurse
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
                    $FunctionContent = Get-Content -Path $FunctionFile.FullName -Raw
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
                    $Verb = ($FunctionFile.BaseName -split '-')[0]
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
                $ModuleRoot = Split-Path $PSScriptRoot -Parent
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
