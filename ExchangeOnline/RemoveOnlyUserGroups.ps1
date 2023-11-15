# Prompt for user email and distribution group names
$email = Read-Host "Enter the user email"
$groupNames = Read-Host "Enter the distribution group names (comma-separated)"

# Split the group names into an array
$groups = $groupNames -split ","

# Loop through each group and remove the user
foreach ($group in $groups) {
    # Check if the group exists
    if (Get-DistributionGroup -Identity $group -ErrorAction SilentlyContinue) {
        # Check if the user is a member of the group
        if (Get-DistributionGroupMember -Identity $group -ResultSize Unlimited | Where-Object { $_.PrimarySmtpAddress -eq $email }) {
            # Remove the user from the group
            Remove-DistributionGroupMember -Identity $group -Member $email -Confirm:$false
            Write-Host "User '$email' has been removed from the group '$group'"
        }
        else {
            Write-Host "User '$email' is not a member of the group '$group'"
        }
    }
    else {
        Write-Host "Group '$group' does not exist"
    }
}
