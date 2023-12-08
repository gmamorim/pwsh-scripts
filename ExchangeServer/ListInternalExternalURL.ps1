# PowerShell Script to Show All Internal and External URLs for Exchange Server 2019

# Function to display URLs for a given service
function Show-ExchangeURLs {
    param (
        [string]$ServiceName,
        [string]$Identity
    )

    $service = Get-Command -Name $ServiceName
    if ($service) {
        $urls = &$ServiceName -Identity $Identity | Select-Object InternalUrl, ExternalUrl
        Write-Host "$ServiceName URLs:"
        Write-Host "Internal URL: $($urls.InternalUrl)"
        Write-Host "External URL: $($urls.ExternalUrl)"
        Write-Host ""
    } else {
        Write-Host "$ServiceName is not available on this Exchange Server."
    }
}

# Main execution
$virtualDirectories = @(
    @{Name = "Get-OwaVirtualDirectory"; Identity = "owa (Default Web Site)"},
    @{Name = "Get-EcpVirtualDirectory"; Identity = "ecp (Default Web Site)"},
    @{Name = "Get-WebServicesVirtualDirectory"; Identity = "EWS (Default Web Site)"},
    @{Name = "Get-ActiveSyncVirtualDirectory"; Identity = "Microsoft-Server-ActiveSync (Default Web Site)"},
    @{Name = "Get-OabVirtualDirectory"; Identity = "OAB (Default Web Site)"},
    @{Name = "Get-AutodiscoverVirtualDirectory"; Identity = "Autodiscover (Default Web Site)"}
)

foreach ($vd in $virtualDirectories) {
    Show-ExchangeURLs -ServiceName $vd.Name -Identity $vd.Identity
}

# Output the Autodiscover Service URL
$autodiscoverUrl = Get-ClientAccessService | Select-Object -ExpandProperty AutoDiscoverServiceInternalUri
Write-Host "Autodiscover Service URL:"
Write-Host "Internal URL: $autodiscoverUrl"
