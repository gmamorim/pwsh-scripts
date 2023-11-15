# Prompt for user email
$email = Read-Host "Enter the user email"

# Get all distribution groups
$groups = Get-DistributionGroup -ResultSize Unlimited

# Initialize an empty array to store the group names
$groupNames = @()

# Loop through each group and check if the user is a member
foreach ($group in $groups) {
    # Check if the user is a member of the group
    $members = Get-DistributionGroupMember -Identity $group.Identity -ResultSize Unlimited | Where-Object { $_.PrimarySmtpAddress -eq $email }

    # If the user is a member, add the group name to the array
    if ($members) {
        $groupNames += $group.Name
    }
}

# Check if any groups were found
if ($groupNames.Count -gt 0) {
    Write-Host "The email address '$email' is a member of the following groups:"
    $groupNames | ForEach-Object {
        Write-Host "- $_"
    }
}
else {
    Write-Host "The email address '$email' is not a member of any groups."
}
