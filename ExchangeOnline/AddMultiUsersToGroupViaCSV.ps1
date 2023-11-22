# CSV Format: 
# DistributionGroup, UserPrincipalName
# GroupName1, user1@example.com
# GroupName2, user2@example.com
# ...

# Read data from CSV file
$csvPath = Read-Host "Enter the path to the CSV file"
$data = Import-Csv -Path $csvPath

# Loop through each record in the CSV
foreach ($record in $data) {
    $group = $record.DistributionGroup
    $email = $record.UserPrincipalName

    # Check if the distribution group exists
    if (Get-DistributionGroup -Identity $group -ErrorAction SilentlyContinue) {
        # Check if the user is already a member of the group
        if (-not (Get-DistributionGroupMember -Identity $group -ResultSize Unlimited | Where-Object { $_.PrimarySmtpAddress -eq $email })) {
            # Add the user to the group
            Add-DistributionGroupMember -Identity $group -Member $email
            Write-Host "User '$email' has been added to the group '$group'"
        }
        else {
            Write-Host "User '$email' is already a member of the group '$group'"
        }
    }
    else {
        Write-Host "Group '$group' does not exist"
    }
}
