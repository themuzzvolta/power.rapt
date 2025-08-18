function Write-RaptLog {
    <#
    .SYNOPSIS
        Writes standardized log messages for the RAPT module.
    
    .DESCRIPTION
        Provides consistent logging functionality for the power.rapt module with
        different log levels and optional file output.
    
    .PARAMETER Message
        The message to log.
    
    .PARAMETER Level
        The log level: Info, Warning, Error, Debug, Verbose.
    
    .PARAMETER WriteToHost
        Whether to write the message to the host console.
    
    .EXAMPLE
        Write-RaptLog -Message "Connected to RAPT API" -Level Info
    
    .EXAMPLE
        Write-RaptLog -Message "Authentication failed" -Level Error
    #>
    
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Message,
        
        [Parameter()]
        [ValidateSet('Info', 'Warning', 'Error', 'Debug', 'Verbose')]
        [string]$Level = 'Info',
        
        [Parameter()]
        [switch]$WriteToHost
    )
    
    $timestamp = Get-Date -Format 'yyyy-MM-dd HH:mm:ss'
    $logMessage = "[$timestamp] [$Level] $Message"
    
    switch ($Level) {
        'Error' {
            Write-Error $Message
        }
        'Warning' {
            Write-Warning $Message
        }
        'Debug' {
            Write-Debug $Message
        }
        'Verbose' {
            Write-Verbose $Message
        }
        default {
            if ($WriteToHost) {
                Write-Host $logMessage
            }
            else {
                Write-Verbose $Message
            }
        }
    }
}
