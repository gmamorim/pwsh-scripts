# Define the path of the input CSV file
$inputCsvPath = "C:\path\to\MailUsers.csv"

# Define the path of the output CSV file
$outputCsvPath = "C:\path\to\output.csv"

# Import the CSV, process each record, and select the required properties
$processedData = Import-Csv -Path $inputCsvPath | ForEach-Object {
    Get-MailUser -Identity $_.MailUser | Select-Object UserPrincipalName, ExternalEmailAddress
}

# Export the processed data to a new CSV file
$processedData | Export-Csv -Path $outputCsvPath -NoTypeInformation