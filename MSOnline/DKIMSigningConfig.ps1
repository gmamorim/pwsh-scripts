# Define the path for the domains list and output CSV file
$domainsListPath = "C:\Scripts\domains.csv"
$outputCsvPath = "C:\Scripts\dkim_records.csv"

# Read the list of domains from the CSV file
$domains = Import-Csv -Path $domainsListPath

# Create an empty array to store the DKIM records
$dkimRecords = @()

foreach ($domain in $domains) {
    # Get the DKIM selector information
    $dkimConfig = Get-DkimSigningConfig -Identity $domain.Domain | Select-Object Domain, Selector1CNAME, Selector2CNAME

    # Construct the DKIM record for each selector and add to the records array
    $dkimRecords += [PSCustomObject]@{
        Domain = $dkimConfig.Domain
        Value = "selector1._domainkey"
        Hostname = $dkimConfig.Selector1CNAME
        Type = "CNAME"
    }
    $dkimRecords += [PSCustomObject]@{
        Domain = $dkimConfig.Domain
        Value = "selector2._domainkey"
        Hostname = $dkimConfig.Selector2CNAME
        Type = "CNAME"
    }
}

# Export the DKIM records to a CSV file
$dkimRecords | Export-Csv -Path $outputCsvPath -NoTypeInformation
