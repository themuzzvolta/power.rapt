function Get-FermentationChamber {

    <#
        .NAME
        Get-FermentationChamber

        .SYNOPSIS
        Get information about your FermentationChamber(s)

        .PARAMETER Id
        Id of your FermentationChamber

        .OUTPUTS
        System.Object

        .EXAMPLE
        Get-FermentationChamber

        .EXAMPLE
        Get-FermentationChamber -Id $id

        .RELATED LINKS
        https://api.rapt.io/index.html

    #>

    [CmdletBinding()][OutputType('System.Management.Automation.PSObject')]

    Param (

        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [string]$Id

    )

    Begin {

        # Check if connection to RAPT portal exists
        If(-not $raptObj){
            throw "Please connect to the RAPT.io portal using the Connect-Rapt cmdlet"
        }

        If ($PSBoundParameters.ContainsKey('Id')){
            $uri = "$($raptObj.baseUri)/api/FermentationChambers/GetFermentationChamber"
        }
        else {
            $uri = "$($raptObj.baseUri)/api/FermentationChambers/GetFermentationChambers"
        }

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
            'Accept-Encoding' = 'gzip, deflate, br'
            'Authorization' = "Bearer ${token}"
        }

        If ($PSBoundParameters.ContainsKey('Id')){
            $body = @{
                fermentationChamberId = $Id
            }
        }

    }

    Process {

        try {

            $params = @{
                    uri     = $uri
                    headers = $header
                    method  = 'GET'
            }

            If ($PSBoundParameters.ContainsKey('Id')){
                $params.body = $body
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
