function Set-BrewZillaPID {

    <#
        .NAME
        Set-BrewZillaPID

        .SYNOPSIS
        Set PID parameters on your BrewZilla

        .PARAMETER Id
        Id of your BrewZilla

        .PARAMETER Name
        Name of your BrewZilla

        .PARAMETER P
        Proportional parameter

        .PARAMETER I
        Integral parameter

        .PARAMETER D
        Derivative parameter

        .INPUTS
        System.String
        System.Double

        .OUTPUTS
        System.Object

        .EXAMPLE
        Set-BrewZillaPID -Id $id -P 1.5 -I 0.5 -D 0.1

        .EXAMPLE
        Set-BrewZillaPID -Name "My BrewZilla" -P 2.0 -I 1.0 -D 0.2

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
        [double]$P,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double]$I,

        [Parameter(Mandatory=$true)]
        [ValidateNotNullOrEmpty()]
        [double]$D

    )

    Begin {

        # Check if connection to RAPT portal exists
        If(-not $raptObj){
            throw "Please connect to the RAPT.io portal using the Connect-Rapt cmdlet"
        }

        $uri = "$($raptObj.baseUri)/api/BrewZillas/SetPID"

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
            p = $P
            i = $I
            d = $D
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
