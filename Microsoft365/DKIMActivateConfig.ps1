# Define the path for the domains list and output CSV file
$domainsListPath = "C:\Scripts\domains.csv"

# Read the list of domains from the CSV file
$domains = Import-Csv -Path $domainsListPath

foreach ($domain in $domains) {
    # Enable DKIM for the domain (uncomment the following line in a production environment)
     Set-DkimSigningConfig -Identity $domain.Domain -Enabled $true

}