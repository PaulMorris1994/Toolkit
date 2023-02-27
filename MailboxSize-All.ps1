Connect-ExchangeOnline
$Mailbox = Get-EXOMailbox | select Name

ForEach($M in $Mailbox) {
    $Mailbox = (Get-EXOMailboxFolderStatistics -Identity $m.Name | ? { $_.Name -like "*Top of Information Store*" }).FolderAndSubfolderSize
    $Export = [Ordered] @{
    "Name"           = $m.Name
    "Mailbox Size"   = $Mailbox
    }

    $Export
}

Disconnect-ExchangeOnline