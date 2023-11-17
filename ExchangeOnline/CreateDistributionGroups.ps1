
# PowerShell script to create distribution groups from a corrected CSV file

# Path to the CSV file
$csvPath = "ExchangeOnline\AllGroups-MailAndDisplayName.csv"

# Read the CSV file
$groups = Import-Csv $csvPath

# Loop through each row in the CSV and create a distribution group
foreach ($group in $groups) {
    # Extract email address and display name
    $email = $group.Email
    $displayName = $group.DisplayName

    # Create a valid alias from the email address (part before '@')
    $alias = $email.Split('@')[0]

    # Create the distribution group
    New-DistributionGroup -Name $displayName -Alias $alias -DisplayName $displayName -PrimarySmtpAddress $email

    Write-Host "Created distribution group: $displayName with email: $email and alias: $alias"
}

Write-Host "All groups created successfully."
