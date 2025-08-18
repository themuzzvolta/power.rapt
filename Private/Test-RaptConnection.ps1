function Test-RaptConnection {
    <#
    .SYNOPSIS
        Tests if there is an active RAPT API connection.
    .DESCRIPTION
        Validates that the user has authenticated with the RAPT API and that
        the authentication token is still valid.
    .PARAMETER ThrowOnFailure
        If specified, throws an exception instead of returning false when not connected.
    .OUTPUTS
        System.Boolean. Returns $true if connected, $false otherwise.
    .EXAMPLE
        Test-RaptConnection
    .EXAMPLE
        Test-RaptConnection -ThrowOnFailure
    .NOTES
        This function checks for the presence of the script-scoped $RaptAuthToken variable.
    #>
    [CmdletBinding()]
    [OutputType([System.Boolean])]
    param(
        [Parameter()]
        [switch]$ThrowOnFailure
    )
    $isConnected = $false
    # Check if authentication token exists
    if (Get-Variable -Name 'RaptAuthToken' -Scope Script -ErrorAction SilentlyContinue) {
        $token = Get-Variable -Name 'RaptAuthToken' -Scope Script -ValueOnly
        if (-not [string]::IsNullOrEmpty($token)) {
            $isConnected = $true
            Write-RaptLog -Message "RAPT connection validated" -Level Verbose
        }
    }
    if (-not $isConnected) {
        $errorMessage = "Not connected to RAPT API. Please run Connect-Rapt first."
        if ($ThrowOnFailure) {
            Write-RaptLog -Message $errorMessage -Level Error
            throw $errorMessage
        }
        else {
            Write-RaptLog -Message $errorMessage -Level Warning
        }
    }
    return $isConnected
}
