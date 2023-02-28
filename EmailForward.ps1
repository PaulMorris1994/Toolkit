Connect-ExchangeOnline -ShowBanner:$False
$Sender = Read-Host "Type the name of the user that requires their emails to be on divert."
$Receiver = Read-Host "Type the name of the user that needs to recveive a copy of the emails. Type 'Return' if the user needs their divert removing."

If($Receiver -like "*Return*") {
        Set-Mailbox -Identity $Sender -ForwardingAddress $Null -Verbose
        Read-Host "$Sender email divert has been removed"
    }
Else {
        If(Get-Mailbox -Identity $Sender){
            If(Get-Mailbox -Identity $Receiver){
                $SMTP = (Get-Mailbox -Identity $Receiver).PrimarySmtpAddress
                Set-Mailbox -Identity $Sender -ForwardingAddress $SMTP -DeliverToMailboxAndForward $True -Verbose
                Read-Host "$Sender emails are now on divert to $Receiver"
                }
             Else{
                $Receiver = Read-Host "$Receiver doesn't exsist - please re-type the users name"
                $SMTP = (Get-Mailbox -Identity $Receiver).PrimarySmtpAddress
                Set-Mailbox -Identity $Sender -ForwardingAddress $SMTP -DeliverToMailboxAndForward $True -Verbose
                Read-Host "$Sender emails are now on divert to $Receiver"
                }
            }          
         Else{
             $Sender = Read-Host "$Sender doesn't exsist - please re-type the users name"
             If(Get-Mailbox -Identity $Receiver){
                $SMTP = (Get-Mailbox -Identity $Receiver).PrimarySmtpAddress
                Set-Mailbox -Identity $Sender -ForwardingAddress $SMTP -DeliverToMailboxAndForward $True -Verbose
                Read-Host "$Sender emails are now on divert to $Receiver"
                }
             Else{
                $Receiver = Read-Host "$Receiver doesn't exsist - please re-type the users name"
                $SMTP = (Get-Mailbox -Identity $Receiver).PrimarySmtpAddress
                Set-Mailbox -Identity $Sender -ForwardingAddress $SMTP -DeliverToMailboxAndForward $True -Verbose
                Read-Host "$Sender emails are now on divert to $Receiver"
                }
             }
     }

Disconnect-ExchangeOnline -Confirm:$False
