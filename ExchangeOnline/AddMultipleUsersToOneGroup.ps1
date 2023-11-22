# Prompt for user emails and distribution group names
$userEmails = Read-Host "Enter the user emails (comma-separated)"
$groupNames = Read-Host "Enter the distribution group names (comma-separated)"

# Split the user emails and group names into arrays
$emails = $userEmails -split ","
$groups = $groupNames -split ","

# Loop through each group
foreach ($group in $groups) {
    # Check if the group exists
    if (Get-DistributionGroup -Identity $group -ErrorAction SilentlyContinue) {
        # Loop through each user email
        foreach ($email in $emails) {
            # Trim spaces from email
            $email = $email.Trim()

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
    }
    else {
        Write-Host "Group '$group' does not exist"
    }
}
