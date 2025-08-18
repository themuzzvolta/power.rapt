function Get-HydrometerTelemetry {
    <#
        .NAME
        Get-HydrometerTelemetry
        .SYNOPSIS
        Get information about your Hydrometer(s)
        .PARAMETER Id
        Id of your Hydrometer
        .PARAMETER Name
        Name of your Hydrometer
        .PARAMETER StartDate
        Start date to get data from
        .PARAMETER EndDate
        End date to get data until
        .INPUTS
        System.String
        .OUTPUTS
        System.Object
        .EXAMPLE
        Get-HydrometerTelemetry -Id $id -StartDate $start -EndDate $end
        .RELATED LINKS
        https://api.rapt.io/index.html
    #>
    [CmdletBinding()][OutputType('System.Management.Automation.PSObject')]
    Param (
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$Id,
        [Parameter(Mandatory = $false)]
        [ValidateNotNullOrEmpty()]
        [string]$Name,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$StartDate,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$EndDate
    )
    Begin {
        # Check if connection to RAPT portal exists
        If (-not $raptObj) {
            throw "Please connect to the RAPT.io portal using the Connect-Rapt cmdlet"
        }
        $uri = "$($raptObj.baseUri)/api/Hydrometers/GetTelemetry"
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
            $Id = (Get-Hydrometer | Where-Object {$_.Name -EQ $Name}).Id
        }
        $body = @{
            HydrometerId = $Id
            startDate = $StartDate
            endDate = $EndDate
        }
    }
    Process {
        try {
            $params = @{
                    uri = $uri
                    headers = $header
                    body = $body
                    method = 'GET'
            }
            $response = Invoke-RestMethod @params
        }
        catch [Exception]{
            throw $_
        }
        return $response
    }
    End {
    }
}
