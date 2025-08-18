function Get-Profile {
    <#
        .NAME
        Get-Profile
        .SYNOPSIS
        Get information about your Profile(s)
        .PARAMETER Id
        Id of your Profile
        .OUTPUTS
        System.Object
        .EXAMPLE
        Get-Profile
        .EXAMPLE
        Get-Profile -Id $id
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
            $uri = "$($raptObj.baseUri)/api/Profiles/GetProfile"
        }
        else {
            $uri = "$($raptObj.baseUri)/api/Profiles/GetProfiles"
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
                profileId = $Id
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
