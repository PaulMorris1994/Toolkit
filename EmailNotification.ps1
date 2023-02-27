$Doc = gci -Path "\\sacwkfsuks.file.core.windows.net\shareddrive\Paul Morris\test.txt" | select LastwriteTime
$Document = '"\\sacwkfsuks.file.core.windows.net\shareddrive\Paul Morris\test.txt"'
$Date = (Get-Date).AddDays(-1)
$Cred = Get-StoredCredential -Target automation

$Email = @{ 
SMTPServer = "smtp.office365.com"
To         = "starters-leavers@cartwrightking.co.uk"
From       = "itsupport@cartwrightking.co.uk"
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