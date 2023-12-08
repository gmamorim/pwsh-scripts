# PowerShell Script to Configure Internal and External URLs and Show Them for Exchange Server 2019

# Ask for the domain name
$domain = Read-Host -Prompt "Please enter your domain (e.g., example.com)"

# Define the base URL based on the domain
$baseUrl = "https://mail.$domain"

# Set Internal and External URLs for the various services
$services = @("OWA", "ECP", "WebServices", "ActiveSync", "OAB")

foreach ($service in $services) {
    $internalUrl = "$baseUrl/$service"
    $externalUrl = $internalUrl # Assuming internal and external URLs are the same

    switch ($service) {
        "OWA" {
            Set-OwaVirtualDirectory -Identity "owa (Default Web Site)" -InternalUrl $internalUrl -ExternalUrl $externalUrl
        }
        "ECP" {
            Set-EcpVirtualDirectory -Identity "ecp (Default Web Site)" -InternalUrl $internalUrl -ExternalUrl $externalUrl
        }
        "WebServices" {
            Set-WebServicesVirtualDirectory -Identity "EWS (Default Web Site)" -InternalUrl $internalUrl -ExternalUrl $externalUrl
        }
        "ActiveSync" {
            Set-ActiveSyncVirtualDirectory -Identity "Microsoft-Server-ActiveSync (Default Web Site)" -InternalUrl $internalUrl -ExternalUrl $externalUrl
        }
        "OAB" {
            Set-OabVirtualDirectory -Identity "OAB (Default Web Site)" -InternalUrl $internalUrl -ExternalUrl $externalUrl
        }
    }
}

# Set the Autodiscover URL for all Client Access Servers
$autodiscoverUrl = "$baseUrl/autodiscover/autodiscover.xml"
Get-ClientAccessServer | Set-ClientAccessServer -AutoDiscoverServiceInternalUri $autodiscoverUrl

# Output to confirm completion
Write-Host "Internal and External URLs, including Autodiscover, are set successfully for domain $domain"

# Now, let's output all the URLs
Write-Host "Listing all configured Internal and External URLs..."
.\ListInternalExternalURL.ps1 # Assuming this is the name of the script that lists all URLs
