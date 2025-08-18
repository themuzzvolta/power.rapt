function Connect-Rapt {
    <#
        .NAME
        Connect-Rapt
        .SYNOPSIS
        Connect to RAPT portal
        .PARAMETER Username
        Username/email used to connect to the RAPT portal
        .PARAMETER ApiKey
        Api key created via the RAPT portal
        .INPUTS
        System.String
        .OUTPUTS
        System.Object
        .EXAMPLE
        Connect-Rapt -username $myEmail -apiKey $myApiSecret
        .RELATED LINKS
        https://app.rapt.io/account/apisecrets
    #>
    [CmdletBinding()][OutputType('System.Management.Automation.PSObject')]
    Param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$username,
        [Parameter(Mandatory = $true)]
        [ValidateNotNullOrEmpty()]
        [string]$apiKey
    )
    Begin {
        $uri = 'https://id.rapt.io/connect/token'
        $header = @{
            'Content-Type'    = 'application/x-www-form-urlencoded'
            'Accept-Encoding' = 'gzip, deflate, br'
        }
        $body = @{
            client_id  = 'rapt-user'
            grant_type = 'password'
            username   = $username
            password   = $apiKey
        }
    }
    Process {
        try {
            # Send it.
            $response = Invoke-RestMethod -Uri $uri -Headers $header -Body $body -Method POST
        }
        catch [Exception] {
            throw $_.Exception
        }
        # Defining Script variables to recycle in other functions
        $Script:raptObj = [psCustomObject]@{
            accessToken = $response.access_token
            expiresIn   = $response.expires_in
            expireTime  = (Get-Date).AddSeconds($response.expires_in)
            tokenType   = $response.token_type
            scope       = $response.scope
            username    = $username
            apiKey      = $apiKey
            baseUri     = 'https://api.rapt.io'
            authUri     = 'https://id.rapt.io'
        }
        return $raptObj
    }
    End {
    }
}
