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
    [CmdletBinding(SupportsShouldProcess)][OutputType('System.Management.Automation.PSObject')]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$Id,
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [bool]$State
    )
    Begin {
        # Check if connection to RAPT portal exists
        If (-not (Get-Variable -Name raptObj -Scope Script -ErrorAction SilentlyContinue)) {
            throw "Please connect to the RAPT.io portal using the Connect-Rapt cmdlet"
        }
        $uri = "$($Script:raptObj.baseUri)/api/TemperatureControllers/SetPIDEnabled"
        # Check time left on token; if less than 2 minutes, refresh it.
        $timeLeft = New-TimeSpan $(Get-Date) $Script:raptObj.expireTime
        If ($timeLeft.Minutes -LT 2 -and $Script:raptObj) {
            Connect-Rapt -username $Script:raptObj.username -apiKey $Script:raptObj.apiKey
        }
        # Use the script-scoped token
        $token = $Script:raptObj.accessToken
        $header = @{
            'Accept' = 'application/json'
            'Accept-Encoding' = 'gzip, compress, br'
            'Authorization' = "Bearer ${token}"
        }
        If ($PSBoundParameters.ContainsKey('Name')){
            $Id = (Get-TemperatureController | Where-Object {$_.Name -EQ $Name}).Id
        }
        $body = @{
            temperatureControllerId = $Id
            state = $State
        }
    }
    Process {
        if ($PSCmdlet.ShouldProcess($Id, "Modify device settings")) {
                try {
                    $params = @{
                    uri = $uri
                    headers = $header
                    body = $body
                    method = 'POST'
            }
            $response = Invoke-RestMethod @params
        }
        catch [Exception]{
            throw $_.Exception
        }
                return $response
        }
    }
    End {
    }
}



