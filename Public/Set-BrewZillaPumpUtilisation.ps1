function Set-BrewZillaPumpUtilisation {
    <#
        .NAME
        Set-BrewZillaPumpUtilisation
        .SYNOPSIS
        Set pump utilisation on your BrewZilla
        .PARAMETER Id
        Id of your BrewZilla
        .PARAMETER Name
        Name of your BrewZilla
        .PARAMETER Utilisation
        Pump utilisation percentage
        .INPUTS
        System.String
        System.Double
        .OUTPUTS
        System.Object
        .EXAMPLE
        Set-BrewZillaPumpUtilisation -Id $id -Utilisation 75.5
        .EXAMPLE
        Set-BrewZillaPumpUtilisation -Name "My BrewZilla" -Utilisation 50
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
        [double]$Utilisation
    )
    Begin {
        # Check if connection to RAPT portal exists
        If (-not $raptObj) {
            throw "Please connect to the RAPT.io portal using the Connect-Rapt cmdlet"
        }
        $uri = "$($raptObj.baseUri)/api/BrewZillas/SetPumpUtilisation"
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
            $Id = (Get-BrewZilla | Where-Object {$_.Name -EQ $Name}).Id
        }
        $body = @{
            brewZillaId = $Id
            utilisation = $Utilisation
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
