function Set-FermentationChamberTemp {
    <#
        .NAME
        Set-FermentationChamberTemp
        .SYNOPSIS
        Set target temperature on your FermentationChamber
        .PARAMETER Id
        Id of your FermentationChamber
        .PARAMETER Name
        Name of your FermentationChamber
        .PARAMETER Temperature
        Temperature target for your FermentationChamber
        .INPUTS
        System.String
        System.Double
        .OUTPUTS
        System.Object
        .EXAMPLE
        Set-FermentationChamberTemp -Id $id -Temperature $temp
        .EXAMPLE
        Set-FermentationChamberTemp -Name "My FermentationChamber" -Temperature 20.5
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
        [Alias('Temp')]
        [ValidateNotNullOrEmpty()]
        [double]$Temperature
    )
    Begin {
        # Check if connection to RAPT portal exists
        If (-not $raptObj) {
            throw "Please connect to the RAPT.io portal using the Connect-Rapt cmdlet"
        }
        $uri = "$($raptObj.baseUri)/api/FermentationChambers/SetTargetTemperature"
        # Check time left on token; if less than 2 minutes, refresh it.
        $timeLeft = New-TimeSpan $(Get-Date) $raptObj.expireTime
        If ($timeLeft.Minutes -LT 2 -and $raptObj) {
            Connect-Rapt -username $raptObj.username -apiKey $raptObj.apiKey
        }
        # If no token passed, use the scoped variable
        If (!$token) {
            $token = $raptObj.accessToken
        }
        $header = @{
            'Accept' = 'application/json'
            'Accept-Encoding' = 'gzip, compress, br'
            'Authorization' = "Bearer ${token}"
        }
        If ($PSBoundParameters.ContainsKey('Name')){
            $Id = (Get-FermentationChamber | Where-Object {$_.Name -EQ $Name}).Id
        }
        $body = @{
            fermentationChamberId = $Id
            target = $Temperature
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
