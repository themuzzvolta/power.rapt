function ConvertTo-RaptApiUri {
    <#
    .SYNOPSIS
        Constructs properly formatted RAPT API URIs.
    .DESCRIPTION
        Helper function to build consistent API endpoint URIs for the RAPT API.
        Handles proper encoding and parameter formatting.
    .PARAMETER Endpoint
        The API endpoint path (e.g., 'Devices/BrewZilla').
    .PARAMETER DeviceId
        Optional device ID to append to the endpoint.
    .PARAMETER QueryParameters
        Hashtable of query parameters to append.
    .OUTPUTS
        System.String. The complete API URI.
    .EXAMPLE
        ConvertTo-RaptApiUri -Endpoint 'Devices/BrewZilla'
    .EXAMPLE
        ConvertTo-RaptApiUri -Endpoint 'Devices/BrewZilla' -DeviceId '12345'
    .EXAMPLE
        ConvertTo-RaptApiUri -Endpoint 'Telemetry' -QueryParameters @{startDate = '2024-01-01'; endDate = '2024-01-02'}
    #>
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [string]$Endpoint,
        [Parameter()]
        [string]$DeviceId,
        [Parameter()]
        [hashtable]$QueryParameters
    )
    # Get base URI
    $baseUri = if (Get-Variable -Name 'RaptBaseUri' -Scope Script -ErrorAction SilentlyContinue) {
        Get-Variable -Name 'RaptBaseUri' -Scope Script -ValueOnly
    }
    else {
        'https://api.rapt.io/api'
    }
    # Start building the URI
    $uriBuilder = [System.UriBuilder]::new($baseUri)
    # Add endpoint path
    $path = $Endpoint.TrimStart('/')
    if (-not [string]::IsNullOrEmpty($DeviceId)) {
        $path = "$path/$DeviceId"
    }
    $uriBuilder.Path = "$($uriBuilder.Path.TrimEnd('/'))/$path"
    # Add query parameters
    if ($QueryParameters -and $QueryParameters.Count -GT 0) {
        $queryString = @()
        foreach ($key in $QueryParameters.Keys) {
            $value = $QueryParameters[$key]
            if ($null -NE $value) {
                $encodedKey = [System.Web.HttpUtility]::UrlEncode($key)
                $encodedValue = [System.Web.HttpUtility]::UrlEncode($value.ToString())
                $queryString + = "$encodedKey = $encodedValue"
            }
        }
        if ($queryString.Count -GT 0) {
            $uriBuilder.Query = $queryString -join '&'
        }
    }
    $finalUri = $uriBuilder.Uri.ToString()
    Write-RaptLog -Message "Constructed API URI: $finalUri" -LE vel Debug
    return $finalUri
}
