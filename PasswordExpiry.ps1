$users = Get-ADUser -properties "DisplayName", "EmailAddress", "msDS-UserPasswordExpiryTimeComputed", "PasswordExpired" -filter { Enabled -eq $True -and PasswordNeverExpires -eq $False } | ? { $_.PasswordExpired -like "*False*" } | Select -Property "Displayname", "EmailAddress", "PasswordExpired", @{N="ExpiryDate";E={[datetime]::FromFileTime($_."msDS-UserPasswordExpiryTimeComputed")}}

ForEach ($U in $Users) {
    
    $ErrorActionPreference = "SilentlyContinue"
    $Date = get-date
    $ExpDate = $U.ExpiryDate
    $Prevdate = $U.ExpiryDate.AddDays(-7)
    If ($Date -ge $PrevDate -and $_.ExpiryDate -lt $ExpDate) 
        {
            $UserEmail = @{

                "To"         = $U.EmailAddress
                "From"       = "TechSupport@awhsolicitors.co.uk"
                "Subject"    = "Password Expiry"
                "BodyAsHTML" = $True
                "Body"       = "Your password expires on $($U.ExpiryDate). Please select Ctrl + Alt + End to change your password. Your account will be locked on this date if you do not change your password, if this happens, tech support will have to reset your password."
                "SMTPServer" = "clex02.cl.local"

}
            Send-MailMessage @UserEmail
            $EmailBody +=  "$($U.Displayname) password expires on $($U.ExpiryDate)."

        }
}

$EBodySplit = $EmailBody.Split(".")

$Email = @{

    "To"         = "TechSupport@awhsolicitors.co.uk"
    "From"       = "P.Morris@awhsolicitors.co.uk"
    "Subject"    = "Password Expiry"
    "BodyAsHTML" = $True
    "Body"       = $($EBodySplit -join '<br>') 
    "SMTPServer" = "clex02.cl.local"

}

Send-MailMessage @Email