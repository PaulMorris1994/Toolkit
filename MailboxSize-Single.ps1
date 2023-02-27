Connect-ExchangeOnline -ShowBanner:$False
$Mailbox = Read-Host "Type full name"

Get-EXOMailboxFolderStatistics -Identity $Mailbox | ? { $_.Name -like "*Top of Information Store*" } -Verbose | fl @{N="Name";E={$_.Identity}}, @{N="Mailbox Size";E={$_.FolderAndSubfolderSize}}

Disconnect-ExchangeOnline -Confirm:$False