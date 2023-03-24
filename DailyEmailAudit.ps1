#Get-MailboxPermission -Identity accounts | ft Identity, User, accessrights -AutoSize

$Sday = Get-Date -Hour 00 -Minute 00 -Second 01
$Eday = get-date -Hour 23 -Minute 59 -Second 59
$Sender = Read-Host "Type users email address for list of emails or type count for the total"

If($Sender -eq "Count") {
    $Sender = Read-Host "Type users email address"
    (Get-MessageTrace -SenderAddress $Sender -StartDate $Sday -EndDate $Eday).Count
        }
Else {
    Get-MessageTrace -SenderAddress $Sender -StartDate $Sday -EndDate $Eday | FT SenderAddress, RecipientAddress, Subject, Status, Received -AutoSize             
        }