function Get-FermentationChamberTelemetry {
    <#
        .NAME
        Get-FermentationChamberTelemetry
        .SYNOPSIS
        Get telemetry information about your FermentationChamber(s)
        .PARAMETER Id
        Id of your FermentationChamber
        .PARAMETER Name
        Name of your FermentationChamber
        .PARAMETER StartDate
        Start date to get data from
        .PARAMETER EndDate
        End date to get data until
        .INPUTS
        System.String
        .OUTPUTS
        System.Object
        .EXAMPLE
        Get-FermentationChamberTelemetry -Id $id -StartDate $start -EndDate $end
        .EXAMPLE
        Get-FermentationChamberTelemetry -Name "My FermentationChamber" -StartDate $start -EndDate $end
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
        If (-not (Get-Variable -Name raptObj -Scope Script -ErrorAction SilentlyContinue)) {
            throw "Please connect to the RAPT.io portal using the Connect-Rapt cmdlet"
        }
        $uri = "$($Script:raptObj.baseUri)/api/FermentationChambers/GetTelemetry"
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
            $Id = (Get-FermentationChamber | Where-Object {$_.Name -EQ $Name}).Id
        }
        $body = @{
            fermentationChamberId = $Id
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



