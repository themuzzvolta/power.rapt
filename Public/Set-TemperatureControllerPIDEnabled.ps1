function Set-TemperatureControllerPIDEnabled {

    <#
        .NAME
        Set-TemperatureControllerPIDEnabled

        .SYNOPSIS
        Enable or disable PID control on your TemperatureController

        .PARAMETER Id
        Id of your TemperatureController

        .PARAMETER Name
        Name of your TemperatureController

        .PARAMETER State
        Enable or disable PID control (true/false)

        .INPUTS
        System.String
        System.Boolean

        .OUTPUTS
        System.Object

        .EXAMPLE
        Set-TemperatureControllerPIDEnabled -Id $id -State $true

        .EXAMPLE
        Set-TemperatureControllerPIDEnabled -Name "My TemperatureController" -State $false

        .RELATED LINKS
        https://api.rapt.io/index.html

    #>

    [CmdletBinding()][OutputType('System.Management.Automation.PSObject')]

    Param (

        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [string]$Id,

        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [bool]$State

    )

    Begin {

        # Check if connection to RAPT portal exists
        If(-not $raptObj){
            throw "Please connect to the RAPT.io portal using the Connect-Rapt cmdlet"
        }

        $uri = "$($raptObj.baseUri)/api/TemperatureControllers/SetPIDEnabled"

        # Check time left on token; if less than 2 minutes, refresh it.
        $timeLeft = New-TimeSpan $(Get-Date) $raptObj.expireTime

        If($timeLeft.Minutes -lt 2 -and $raptObj){
            Connect-Rapt -username $raptObj.username -apiKey $raptObj.apiKey
        }

        # If no token passed, use the scoped variable
        If(!$token){
            $token = $raptObj.accessToken
        }

        $header = @{
            'Accept' = 'application/json'
            'Accept-Encoding' = 'gzip, compress, br'
            'Authorization' = "Bearer ${token}"
        }

        If ($PSBoundParameters.ContainsKey('Name')){
            $Id = (Get-TemperatureController | Where-Object {$_.Name -eq $Name}).Id
        }

        $body = @{
            temperatureControllerId = $Id
            state = $State
        }

    }

    Process {

        try {

            $params = @{
                    uri     = $uri
                    headers = $header
                    body    = $body
                    method  = 'POST'
            }

            $response = Invoke-RestMethod @params

        }

        catch [Exception]{

            throw $_.Exception

        }

        return $response

    }

    End {

    }

}
