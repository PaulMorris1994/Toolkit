Connect-AzAccount
$User = Read-Host "Type the full name of the user"
$UPN = (Get-AzADUser -DisplayName $User).UserPrincipalName
$Length = 10
$NonAlpha = 3
$Password = [system.web.security.membership]::GeneratePassword($Length, $NonAlpha)
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
Update-AzADUser -UserPrincipalName $UPN -Password $SecurePassword -ForceChangePasswordNextLogin:$True -verbose
$cred = Get-StoredCredential -Target admin

Invoke-Command -ComputerName CKSAZAD002 -Credential admin {
Add-Type -AssemblyName 'system.web'
$SAN = (Get-ADUser -filter "Name -like '$($Using:User)'").SamAccountName

Set-ADAccountPassword -Identity $SAN  -NewPassword $Using:SecurePassword -Reset -Verbose
Set-ADUser -Identity $SAN -PasswordNeverExpires $False -Verbose
    }

Disconnect-AzAccount
Read-Host "$User new password is $Password - Please ask them to sign in using the new password and to reset their password when prompt"