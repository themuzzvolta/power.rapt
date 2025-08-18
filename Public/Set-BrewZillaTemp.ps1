function Set-BrewZillaTemp {
    <#
        .NAME
        Set-BrewZillaTemp
        .SYNOPSIS
        Get information about your BrewZilla(s)
        .PARAMETER Id
        Id of your BrewZilla
        .PARAMETER Name
        Name of your BrewZilla
        .PARAMETER Temperature
        Temperature target for your BrewZilla
        .INPUTS
        System.String
        System.Double
        .OUTPUTS
        System.Object
        .EXAMPLE
        Set-BrewZillaTemp -Id $id -Temperature $temp
        .RELATED LINKS
        https://api.rapt.io/index.html
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Management.Automation.PSObject')]
    Param (
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [string]$Id,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [Parameter(Mandatory=$true)]
        [Alias('Temp')]
        [ValidateNotNullOrEmpty()]
        [double]$Temperature
    )
    Begin {
        # Check if connection to RAPT portal exists
        If(-not $raptObj){
            throw "Please connect to the RAPT.io portal using the Connect-Rapt cmdlet"
        }
        $uri = "$($raptObj.baseUri)/api/BrewZillas/SetTargetTemperature"
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
            $Id = (Get-BrewZilla | Where-Object {$_.Name -eq $Name}).Id
        }
        $body = @{
            brewZillaId = $Id
            target = $Temperature
        }
    }
    Process {
        if ($PSCmdlet.ShouldProcess("BrewZilla ID: $Id", "Set temperature to $Temperature")) {
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
    }
    End {
    }
}
