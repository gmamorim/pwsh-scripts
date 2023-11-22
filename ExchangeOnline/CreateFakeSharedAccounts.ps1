# Function to generate a random string
function Get-RandomString {
    param(
        [int]$length = 10
    )
    return -join ((65..90) + (97..122) | Get-Random -Count $length | % {[char]$_})
}

# Prompt for the number of fake mailboxes to create
$numberOfMailboxes = Read-Host "Enter the number of fake shared mailboxes to create"

# Loop to create the specified number of fake shared mailboxes
for ($i = 1; $i -le $numberOfMailboxes; $i++) {
    $mailboxName = "FakeMailbox" + $i
    $alias = "fakemailbox" + $i
    $userPrincipalName = $alias + "@" + (Get-RandomString -length 5) + ".com"

    # Command to create the shared mailbox
    New-Mailbox -Name $mailboxName -Alias $alias -Shared -UserPrincipalName $userPrincipalName

    Write-Host "Created shared mailbox: $mailboxName with UPN: $userPrincipalName"
}
