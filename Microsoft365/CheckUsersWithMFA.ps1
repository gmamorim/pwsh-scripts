Param(
    [switch]$DisabledOnly,
    [switch]$EnabledOnly,
    [switch]$EnforcedOnly,
    [string]$UserName,
    [string]$Password
)

# Initialize variables
$ExportCSV = ".\MFAReport_$((Get-Date -format 'yyyy-MMM-dd hh-mm tt')).csv"
$Results = @()

# Loop through each user and gather MFA information
Get-MsolUser -All | ForEach-Object {
    $MFAEnabled = $_.StrongAuthenticationMethods.Count -gt 0
    $MFAStatus = if($MFAEnabled) { "Enabled" } else { "Disabled" }

    $UserDetails = @{
        DisplayName = $_.DisplayName
        UserPrincipalName = $_.UserPrincipalName
        MFAStatus = $MFAStatus
    }

    # Apply filters based on command-line switches
    if(($DisabledOnly -and $MFAEnabled) -or ($EnabledOnly -and -not $MFAEnabled)) {
        return
    }

    $Results += New-Object PSObject -Property $UserDetails
}

# Export results to CSV
$Results | Export-Csv -Path $ExportCSV -NoTypeInformation
Write-Host
