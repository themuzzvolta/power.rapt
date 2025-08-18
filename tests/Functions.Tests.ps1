BeforeAll {
    $ModuleRoot = Split-Path $PSScriptRoot -Parent
    $ModuleName = 'power.rapt'
    $ManifestPath = Join-Path $ModuleRoot "$ModuleName.psd1"
    
    if (Get-Module $ModuleName) {
        Remove-Module $ModuleName -Force
    }
    Import-Module $ManifestPath -Force
}

Describe 'Connect-Rapt Function Tests' -Tag 'Function', 'Authentication' {
    Context 'Function Definition' {
        BeforeAll {
            $Command = Get-Command -Name 'Connect-Rapt' -ErrorAction SilentlyContinue
        }
        
        It 'Should have Connect-Rapt function available' {
            $Command | Should -Not -BeNullOrEmpty
        }
        
        It 'Should have required parameters' {
            $Command.Parameters.Keys | Should -Contain 'Username'
            $Command.Parameters.Keys | Should -Contain 'ApiKey'
        }
        
        It 'Should have Username parameter as mandatory' {
            $Command.Parameters['Username'].Attributes.Mandatory | Should -Contain $true
        }
        
        It 'Should have ApiKey parameter as mandatory' {
            $Command.Parameters['ApiKey'].Attributes.Mandatory | Should -Contain $true
        }
    }
    
    Context 'Parameter Validation' {
        It 'Should fail with null Username' {
            { Connect-Rapt -Username $null -ApiKey 'test' } | Should -Throw
        }
        
        It 'Should fail with null ApiKey' {
            { Connect-Rapt -Username 'test@example.com' -ApiKey $null } | Should -Throw
        }
        
        It 'Should fail with empty Username' {
            { Connect-Rapt -Username '' -ApiKey 'test' } | Should -Throw
        }
        
        It 'Should fail with empty ApiKey' {
            { Connect-Rapt -Username 'test@example.com' -ApiKey '' } | Should -Throw
        }
    }
}

Describe 'BrewZilla Function Tests' -Tag 'Function', 'BrewZilla' {
    Context 'Get-BrewZilla Function' {
        BeforeAll {
            $Command = Get-Command -Name 'Get-BrewZilla' -ErrorAction SilentlyContinue
        }
        
        It 'Should have Get-BrewZilla function available' {
            $Command | Should -Not -BeNullOrEmpty
        }
        
        It 'Should have Id parameter' {
            $Command.Parameters.Keys | Should -Contain 'Id'
        }
        
        It 'Should have parameter sets' {
            $Command.ParameterSets.Count | Should -BeGreaterOrEqual 1
        }
    }
    
    Context 'Set-BrewZillaTemp Function' {
        BeforeAll {
            $Command = Get-Command -Name 'Set-BrewZillaTemp' -ErrorAction SilentlyContinue
        }
        
        It 'Should have Set-BrewZillaTemp function available' {
            $Command | Should -Not -BeNullOrEmpty
        }
        
        It 'Should have Temperature parameter' {
            $Command.Parameters.Keys | Should -Contain 'Temperature'
        }
        
        It 'Should have Id parameter' {
            $Command.Parameters.Keys | Should -Contain 'Id'
        }
        
        It 'Should have Name parameter' {
            $Command.Parameters.Keys | Should -Contain 'Name'
        }
        
        It 'Should have mandatory Temperature parameter' {
            $Command.Parameters['Temperature'].Attributes.Mandatory | Should -Contain $true
        }
    }
}

Describe 'Hydrometer Function Tests' -Tag 'Function', 'Hydrometer' {
    Context 'Get-Hydrometer Function' {
        BeforeAll {
            $Command = Get-Command -Name 'Get-Hydrometer' -ErrorAction SilentlyContinue
        }
        
        It 'Should have Get-Hydrometer function available' {
            $Command | Should -Not -BeNullOrEmpty
        }
        
        It 'Should have Id parameter' {
            $Command.Parameters.Keys | Should -Contain 'Id'
        }
    }
    
    Context 'Get-HydrometerTelemetry Function' {
        BeforeAll {
            $Command = Get-Command -Name 'Get-HydrometerTelemetry' -ErrorAction SilentlyContinue
        }
        
        It 'Should have Get-HydrometerTelemetry function available' {
            $Command | Should -Not -BeNullOrEmpty
        }
        
        It 'Should have StartDate parameter' {
            $Command.Parameters.Keys | Should -Contain 'StartDate'
        }
        
        It 'Should have EndDate parameter' {
            $Command.Parameters.Keys | Should -Contain 'EndDate'
        }
    }
}

Describe 'Temperature Controller Function Tests' -Tag 'Function', 'TemperatureController' {
    Context 'Get-TemperatureController Function' {
        BeforeAll {
            $Command = Get-Command -Name 'Get-TemperatureController' -ErrorAction SilentlyContinue
        }
        
        It 'Should have Get-TemperatureController function available' {
            $Command | Should -Not -BeNullOrEmpty
        }
        
        It 'Should have Id parameter' {
            $Command.Parameters.Keys | Should -Contain 'Id'
        }
    }
}

Describe 'Function Help Tests' -Tag 'Help' {
    BeforeAll {
        $ModuleRoot = Split-Path $PSScriptRoot -Parent
        $PublicFunctions = Get-ChildItem -Path (Join-Path $ModuleRoot 'Public') -Filter '*.ps1' -Recurse
        $FunctionNames = $PublicFunctions | ForEach-Object { $_.BaseName }
    }
    
    Context 'Help Content' {
        foreach ($FunctionName in $FunctionNames) {
            Context "Help for $FunctionName" {
                BeforeAll {
                    $Help = Get-Help -Name $FunctionName -ErrorAction SilentlyContinue
                }
                
                It 'Should have help content' {
                    $Help | Should -Not -BeNullOrEmpty
                }
                
                It 'Should have a synopsis' {
                    $Help.Synopsis | Should -Not -BeNullOrEmpty
                    $Help.Synopsis.Length | Should -BeGreaterThan 10
                }
                
                It 'Should have a description' {
                    $Help.Description | Should -Not -BeNullOrEmpty
                }
                
                It 'Should have parameter descriptions' {
                    if ($Help.Parameters.Parameter) {
                        foreach ($Parameter in $Help.Parameters.Parameter) {
                            if ($Parameter.Name -notin @('WhatIf', 'Confirm')) {
                                $Parameter.Description.Text | Should -Not -BeNullOrEmpty
                            }
                        }
                    }
                }
                
                It 'Should have examples' {
                    $Help.Examples.Example | Should -Not -BeNullOrEmpty
                }
            }
        }
    }
}

AfterAll {
    Remove-Module 'power.rapt' -Force -ErrorAction SilentlyContinue
}
