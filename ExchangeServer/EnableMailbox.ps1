# Import Exchange module
# Uncomment the line below if you're not running this in Exchange Management Shell
# Add-PSSnapin Microsoft.Exchange.Management.PowerShell.SnapIn

# Ask for the OU
$ou = Read-Host "Please enter the OU, following the example: 'OU=users,DC=domain,DC=LOCAL'"

# Check if the OU format is correct
if (-not $ou.StartsWith("OU=")) {
    Write-Host "Invalid OU format. Please ensure it starts with 'OU='"
    exit
}

try {
    # Get all users in the specified OU and its sub-OUs, and enable mailbox for each user
    Get-ADUser -Filter * -SearchBase $ou -SearchScope Subtree | ForEach-Object {
        try {
            Enable-Mailbox -Identity $_.DistinguishedName
            Write-Host "Mailbox enabled for user: $($_.Name)"
        } catch {
            Write-Host "Failed to enable mailbox for user: $($_.Name). Error: $($_.Exception.Message)"
        }
    }
} catch {
    Write-Host "Failed to process the OU. Error: $($_.Exception.Message)"
}
