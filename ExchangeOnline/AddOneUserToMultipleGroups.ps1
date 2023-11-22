# Prompt for user email and distribution group names
$email = Read-Host "Enter the user email"
$groupNames = Read-Host "Enter the distribution group names (comma-separated)"

# Split the group names into an array
$groups = $groupNames -split ","

# Loop through each group and check if the user is a member
foreach ($group in $groups) {
    # Check if the group exists
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
