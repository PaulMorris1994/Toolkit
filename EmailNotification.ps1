import-module CredentialManager -Force
$Doc = gci -Path "\\sacwkfsuks.file.core.windows.net\shareddrive\_StartersLeavers\RD-REP-Starters and Leavers Tracker Oct 2021 v1_00.xlsx" | select LastwriteTime
$Document = '"\\sacwkfsuks.file.core.windows.net\shareddrive\_StartersLeavers\RD-REP-Starters and Leavers Tracker Oct 2021 v1_00.xlsx"'
$Date = (Get-Date).AddDays(-1)
$Cred = Get-StoredCredential -Target automation

$Email = @{ 
SMTPServer = "smtp.office365.com"
To         = "starters-leavers@cartwrightking365.onmicrosoft.com"
From       = "Personnel@cartwrightking.co.uk"
Credential = $Cred
Port       = "587"
UseSSL     = $True
Subject    = "Starter & Leaver Update Notification"
Body       = "Hi All

Please follow the link below for the latest updates.
    
Document: $Document
    
Many thanks"
}

If ( $Doc.Lastwritetime -gt $date ) { 
    Send-MailMessage @Email
}

$Test = Test-Path "\\sacwkfsuks.file.core.windows.net\shareddrive\_StartersLeavers\RD-REP-Starters and Leavers Tracker Oct 2021 v1_00.xlsx"

If ($test.Equals($False)) {
        Send-MailMessage -Credential $Cred -Port 587 -UseSsl -smtpserver smtp.office365.com -To Paul.Morris@cartwrightking.co.uk -From Paul.Morris@cartwrightking.co.uk -Subject "Starter & Leaver doc" -Body "RD-REP-Starters and Leavers Tracker Oct 2021 v1_00.xlsx has moved / changed name"

}
