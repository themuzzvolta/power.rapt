@{
    # Use the PowerShell Script Analyzer built-in rules
    IncludeDefaultRules = $true

    # Exclude specific rules that may not be applicable
    ExcludeRules = @(
        'PSAvoidUsingWriteHost',          # Allow Write-Host for user feedback
        'PSAvoidUsingInvokeExpression',   # May be needed for dynamic calls
        'PSAvoidUsingPlainTextForPassword' # OAuth tokens are not passwords
    )

    # Include additional rules
    IncludeRules = @(
        'PSUseApprovedVerbs',
        'PSUseDeclaredVarsMoreThanAssignments',
        'PSAvoidDefaultValueSwitchParameter',
        'PSUseShouldProcessForStateChangingFunctions',
        'PSUseSingularNouns',
        'PSUseConsistentWhitespace',
        'PSUseConsistentIndentation',
        'PSAlignAssignmentStatement',
        'PSPlaceOpenBrace',
        'PSPlaceCloseBrace',
        'PSUseCorrectCasing'
    )

    # Configure specific rule settings
    Rules = @{
        PSUseConsistentIndentation = @{
            Enable = $true
            Kind = 'space'
            IndentationSize = 4
        }

        PSUseConsistentWhitespace = @{
            Enable = $true
            CheckOpenBrace = $true
            CheckOpenParen = $true
            CheckOperator = $true
            CheckSeparator = $true
        }

        PSPlaceOpenBrace = @{
            Enable = $true
            OnSameLine = $true
            NewLineAfter = $true
            IgnoreOneLineBlock = $true
        }

        PSPlaceCloseBrace = @{
            Enable = $true
            NewLineAfter = $true
            IgnoreOneLineBlock = $true
            NoEmptyLineBefore = $false
        }

        PSUseCorrectCasing = @{
            Enable = $true
        }

        PSAlignAssignmentStatement = @{
            Enable = $true
            CheckHashtable = $true
        }

        PSAvoidLongLines = @{
            Enable = $true
            MaximumLineLength = 120
        }
    }

    # Severity levels to include
    Severity = @('Error', 'Warning', 'Information')
}
