Connect-ExchangeOnline
$start = get-date -Hour 00 -Minute 00 -Second 01
$End = get-date -Hour 23 -Minute 59 -Second 59
$User = Read-Host "Type Email address of user you want to search"

Get-MessageTrace -SenderAddress $User -StartDate $start -EndDate $end | Group-Object senderaddress | select name, count | sort Count

Disconnect-ExchangeOnline