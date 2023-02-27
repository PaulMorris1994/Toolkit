$Displayname = read-host "Please type users full name"
$Emailbuddy = read-host "Please type the full name of who will be monitoring $Displayname emails"

Connect-ExchangeOnline -ShowBanner:$False
Set-Mailbox -Identity $Displayname -Type Shared
Add-MailboxPermission -Identity $Displayname -User $Emailbuddy -AccessRights FullAccess -InheritanceType All
Disconnect-ExchangeOnline -Confirm:$False

$AdminCred = Get-StoredCredential -Target admin
$Session = New-PSSession -ComputerName CKSAZAD002 -Credential $Admincred

Invoke-Command -Session $Session { 

$SAN = (Get-ADUser -Filter "Name -like '$($Using:Displayname)'").SamAccountName
$DistinguishedName = (Get-ADUser -Filter "Name -like '$($Using:Displayname)'").Distinguishedname
$Date = get-date
Add-Type -AssemblyName 'system.web'
$Length = 20
$NonAlpha = 8
$Password = [system.web.security.membership]::GeneratePassword($Length, $NonAlpha)
$SecurePassword = ConvertTo-SecureString -String $Password -AsPlainText -Force
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 

If (Get-ADUser -Filter "Name -like '$($Using:Displayname)'") {
    Set-ADAccountPassword -Identity $Distinguishedname -Reset -Newpassword $Securepassword -Verbose
    $Groups = Get-ADPrincipalGroupMembership -Identity $SAN | where { $_.Name -notlike "Domain Users" } | select Name
    ForEach ($G in $Groups) {
        Remove-ADPrincipalGroupMembership -Identity $SAN -MemberOf $G.Name -Confirm:$False -Verbose
    }
    Set-ADUser -Identity $SAN -Description $Date -clear Company -Department " " -Office " " -Mobilephone " " -OfficePhone " " -Title " " -Verbose
    get-aduser -Identity $SAN -Property msExchHideFromAddressLists | Set-ADObject -Replace @{msExchHideFromAddressLists=$True} -Verbose
    Move-ADObject -Identity $DistinguishedName -TargetPath "OU=Closed Accounts,DC=cknotts,DC=co,DC=uk" -Verbose
    Move-Item -Path "\\sacwkfsuks.file.core.windows.net\shareddrive\$Using:DisplayName" -Destination "\\sacwklegacy.file.core.windows.net\largecases\IT\Archive" -Force -Verbose
    $Export = [Ordered] @{
        "Name"        = $Using:Displayname
        "Date Closed" = $date
        }
    New-Object -TypeName PSObject -Property $Export | export-csv -Path "\\sacwkfsuks.file.core.windows.net\shareddrive\IT\Asset Register\Closed Accounts\$Using:DisplayName.csv" -NoTypeInformation -Verbose
        }
    Else {
    Write-Warning "User not found - please check the spelling of $Using:Displayname. If there's a typo, please re-type the name.  Any other error, please take a screen shot then select CTRL C to cancel the script"
    $Displayname = read-host "Please type users full name"
    $SAN = (Get-ADUser -Filter "Name -like '$($Displayname)'").SamAccountName
    $DistinguishedName = (Get-ADUser -Filter "Name -like '$($Displayname)'").Distinguishedname

    Set-ADAccountPassword -Identity $Distinguishedname -Reset -Newpassword $Securepassword -Verbose
    $Groups = Get-ADPrincipalGroupMembership -Identity $SAN | where { $_.Name -notlike "Domain Users" } | select Name
    ForEach ($G in $Groups) {
        Remove-ADPrincipalGroupMembership -Identity $SAN -MemberOf $G.Name -Confirm:$False -Verbose
    }
    Set-ADUser -Identity $SAN -Description $Date -clear Company -Department " " -Office " " -Mobilephone " " -OfficePhone " " -Title " " -Verbose
    get-aduser -Identity $SAN -Property msExchHideFromAddressLists | Set-ADObject -Replace @{msExchHideFromAddressLists=$True} -Verbose
    Move-ADObject -Identity $DistinguishedName -TargetPath "OU=Closed Accounts,DC=cknotts,DC=co,DC=uk" -Verbose
    Move-Item -Path "\\sacwkfsuks.file.core.windows.net\shareddrive\$DisplayName" -Destination "\\sacwklegacy.file.core.windows.net\largecases\IT\Archive" -Force -Verbose
    $Export = [Ordered] @{
        "Name"        = $Using:Displayname
        "Date Closed" = $date
        }
    New-Object -TypeName PSObject -Property $Export | export-csv -Path "\\sacwkfsuks.file.core.windows.net\shareddrive\IT\Asset Register\Closed Accounts\$Using:DisplayName.csv" -NoTypeInformation -Verbose
        }

}

Disconnect-PSSession $Session
Remove-PSSession $session

Read-Host "Job Completed"

