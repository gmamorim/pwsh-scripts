# Define the path of the input CSV file
$inputCsvPath = "C:\path\to\your\output.csv"

# Import the CSV and process each record to set the forwarding address
Import-Csv -Path $inputCsvPath | ForEach-Object {
    Set-Mailbox -Identity $_.UserPrincipalName -ForwardingSmtpAddress $_.ExternalEmailAddress
}
