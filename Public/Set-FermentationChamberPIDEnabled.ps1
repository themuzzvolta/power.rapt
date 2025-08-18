function Set-FermentationChamberPIDEnabled {
    <#
        .NAME
        Set-FermentationChamberPIDEnabled
        .SYNOPSIS
        Enable or disable PID control on your FermentationChamber
        .PARAMETER Id
        Id of your FermentationChamber
        .PARAMETER Name
        Name of your FermentationChamber
        .PARAMETER State
        Enable or disable PID control (true/false)
        .INPUTS
        System.String
        System.Boolean
        .OUTPUTS
        System.Object
        .EXAMPLE
        Set-FermentationChamberPIDEnabled -Id $id -State $true
        .EXAMPLE
        Set-FermentationChamberPIDEnabled -Name "My FermentationChamber" -State $false
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
        If (-not $raptObj) {
            throw "Please connect to the RAPT.io portal using the Connect-Rapt cmdlet"
        }
        $uri = "$($raptObj.baseUri)/api/FermentationChambers/SetPIDEnabled"
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
