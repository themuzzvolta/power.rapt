function Get-ProfileType {
    <#
        .NAME
        Get-Profile
        .SYNOPSIS
        Get information about your ProfileType(s)
        .OUTPUTS
        System.Object
        .EXAMPLE
        Get-ProfileType
        .RELATED LINKS
        https://api.rapt.io/index.html
    #>
    [CmdletBinding()][OutputType('System.Management.Automation.PSObject')]
    Param (
    )
    Begin {
        # Check if connection to RAPT portal exists
        If (-not $raptObj) {
            throw "Please connect to the RAPT.io portal using the Connect-Rapt cmdlet"
        }
        $uri = "$($raptObj.baseUri)/api/ProfileTypes/GetAll"
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
            'Accept-Encoding' = 'gzip, deflate, br'
            'Authorization' = "Bearer ${token}"
        }
    }
    Process {
        try {
            $params = @{
                    uri = $uri
                    headers = $header
                    method = 'GET'
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
