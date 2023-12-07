# Script for step 1 and 2 with CSV output

# Define the path to your CSV file
$csvPath = "C:\Scripts\domains.csv"
# Define the path for the output CSV file
$outputCsvPath = "C:\Scripts\domain_verification_records.csv"

# Import the CSV file. Ensure your CSV has a header named 'Domain'
$domains = Import-Csv -Path $csvPath

# Initialize an array to hold the domain data
$domainData = @()

# Loop through each domain in the CSV
foreach ($domain in $domains) {
    # Add the domain to the tenant
    New-MsolDomain -Name $domain.Domain

    # Retrieve the TXT record for verification
    $txtRecord = Get-MsolDomainVerificationDns -DomainName $domain.Domain -Mode DnsTxtRecord

    # Create a custom object for each domain and add it to the array
    $domainData += New-Object PSObject -Property @{
        Domain = $domain.Domain
        Type = "TXT"
        Hostname = ""  # Hostname might be blank for TXT records
        Value = $txtRecord.Text
    }
}

# Export the domain data to a CSV file
$domainData | Export-Csv -Path $outputCsvPath -NoTypeInformation -Delimiter ";"
