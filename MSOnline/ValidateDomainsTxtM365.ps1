# Script for validating domain TXT entries

# Define the path to your CSV file
$csvPath = "C:\Scripts\domains.csv"

# Import the CSV file. Ensure your CSV has a header named 'Domain'
$domains = Import-Csv -Path $csvPath

# Loop through each domain in the CSV
foreach ($domain in $domains) {
        # Validate the domain TXT record
        Confirm-MsolDomain -DomainName $domain.Domain
        Write-Output "Attempt done for: $($domain.Domain)"
}