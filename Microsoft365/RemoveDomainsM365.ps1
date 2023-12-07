# Script for removing configured domains

# Define the path to the domain verification records CSV file
$csvPath = "C:\Scripts\domains.csv"

# Import the CSV file. The CSV should have a column named 'Domain'
$domains = Import-Csv -Path $csvPath

# Loop through each domain in the CSV
foreach ($domain in $domains) {
    try {
        # Remove the domain from the tenant
        Remove-MsolDomain -DomainName $domain.Domain -Force

        # Output status
        Write-Output "Removed domain: $($domain.Domain)"
    } catch {
        # Error handling if the domain removal fails
        Write-Output "Failed to remove domain: $($domain.Domain). Error: $_"
    }
}