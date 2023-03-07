Connect-ExchangeOnline -ShowBanner:$False

$Mailbox = Get-EXOMailbox | select DisplayName, Identity

ForEach($M in $Mailbox) {
    $Mailbox = (Get-EXOMailboxFolderStatistics -Identity $m.DisplayName | ? { $_.Name -like "*Top of Information Store*" }).FolderAndSubfolderSize
    $Export = [Ordered] @{
    "Name"           = $m.DisplayName
    "Mailbox Size"   = $Mailbox
    }

    $Export
}

Disconnect-ExchangeOnline -Confirm:$False
