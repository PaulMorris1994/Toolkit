$AdminCred = Get-StoredCredential -Target admin
$Session = New-PSSession -ComputerName CKSAZAD002 -Credential $Admincred

Invoke-Command -Session $Session { 

$Givenname = read-host "Please type users Forename"
$Surname = read-host "Please type users Surname"
$MobilePhone = read-host "Please type users work mobile number"
$OfficePhone = read-host "Please type this users landline number"
$Password = read-host "Please type users password"
$Office = read-host "Please type the office the user will be based at"
$Department = read-host "Please type the department this user will work in:  Care | Chambers | Court of Protection | Crime | Family | Fraud | HR | Immigration | Marketing | Training"
$title = read-host "Please type the users job title"
$EmployeeType = read-host "Employee or Consultant"
$Emailaddress = $Givenname + "." + $Surname +"@cartwrightking.co.uk"
$Name = "$Givenname $Surname"
$SamAccountName = "$Givenname.$Surname"

$NewUser = [Ordered]@{
    "Name"              = "$Name"
    "Displayname"       = "$Name"
    "Givenname"         = "$Givenname"
    "Surname"           = "$Surname"
    "AccountPassword"   =  ConvertTo-SecureString -String "$Password" -AsPlainText -Force
    "Office"            = "$Office"
    "Department"        = "$Department"
    "Title"             = "$Title"
    "Description"       = "$EmployeeType"
    "MobilePhone"       = "$MobilePhone"
    "EmailAddress"      = "$EmailAddress"
    "SamAccountName"    = "$Samaccountname"
    "Company"           = "Cartwright King"
    "OfficePhone"       = "$OfficePhone"
        }

If (-Not((Get-ADUser -Filter "Name -like '$($Name)'"))) {
    New-ADUser @NewUser -Enabled $True -Verbose
    Add-ADGroupMember -Members $SamAccountName -Identity "Azure" -Verbose
    Add-ADGroupMember -Members $SamAccountName -Identity "Cartwright King" -Verbose
    Add-ADGroupMember -Members $SamAccountName -Identity "AAD-Lic-MSBusPrem" -Verbose
    $DistinguishedName = (Get-ADUser -identity $SamAccountName -Properties *).DistinguishedName
    Set-ADUser -Identity $DistinguishedName -Add @{ ExtensionAttribute1=$GivenName + '.' + $Surname +"@cartwrightking.co.uk.cjsm.net" } -Verbose
    New-Item -ItemType Directory -Name $Name -Path "\\sacwkfsuks.file.core.windows.net\shareddrive" -Verbose

    $NewUserExport = [Ordered]@{
    "Name"              = "$Name"
    "Description"       = "$EmployeeType"
    "Office"            = "$Office"
    "SamAccountName"    = "$Samaccountname"
    "AccountPassword"   = "$Password"
    "EmailAddress"      = "$EmailAddress"
    "Device"            = "Laptop"
    "MobilePhone"       = "$MobilePhone"
        }

    New-Object -TypeName psobject -Property $NewUserExport | export-csv "\\sacwkfsuks.file.core.windows.net\shareddrive\IT\Asset Register\New Starter Info\$Name.csv" -NoTypeInformation -Verbose
        }

else {
    Write-warning "This name is already setup on the system. Please run the script again and use a different name.  Please select any key to continue..."
}

If ($Department -like "Crime") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Crime" -Verbose
}
ElseIf ($Department -like "Court of Protection") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.COP" -Verbose
}
ElseIf ($Department -like "Compliance") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Compliance" -Verbose
}
ElseIf ($Department -like "Chambers") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Chambers" -Verbose
}
ElseIf ($Department -like "Care") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Care" -Verbose
}
ElseIf ($Department -like "Immigration") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Immigration" -Verbose
}
ElseIf ($Department -like "HR") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.HR" -Verbose
}
ElseIf ($Department -like "Fraud") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Fraud" -Verbose
}
ElseIf ($Department -like "Chambers") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Chambers" -Verbose
}
ElseIf ($Department -like "Mental Health") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.MentalHealth" -Verbose
}
ElseIf ($Department -like "Marketing") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Marketing" -Verbose
}
ElseIf ($Department -like "Office Administrator") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.OA" -Verbose
}
else {
Write-Warning "This user hasnt been added into any Department groups as the department text entered does not match any of the groups.  Please add this user into the relevant groups manually."
}

If ($Office -like "Birmingham") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Birmingham" -Verbose
Add-ADGroupMember -Members $SamAccountName -Identity "SG_Birmingham_office" -Verbose
Set-ADUser -Identity $DistinguishedName -StreetAddress "The McLaren Building, 46 The Priory Queensway" -PostalCode "B4 7LR" -City "Birmingham" -Verbose
Move-ADObject -Identity $DistinguishedName -TargetPath "OU=Users,OU=Birmingham,DC=cknotts,DC=co,DC=uk" -Verbose
}
ElseIf ($Office -like "Bedford") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Bedford" -Verbose
Add-ADGroupMember -Members $SamAccountName -Identity "SG_Bedford_office" -Verbose
Set-ADUser -Identity $DistinguishedName -StreetAddress "Clifton House, 4a Goldington Road" -PostalCode "MK40 3NF" -City "Bedford" -Verbose
Move-ADObject -Identity $DistinguishedName -TargetPath "OU=Users,OU=Bedford,DC=cknotts,DC=co,DC=uk" -Verbose
}
ElseIf ($Office -like "Derby") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Derby" -Verbose
Add-ADGroupMember -Members $SamAccountName -Identity "SG_Derby_office" -Verbose
Set-ADUser -Identity $DistinguishedName -StreetAddress "Peat House, 5 Stuart Street" -PostalCode "DE1 2EQ" -City "Derby" -Verbose
Move-ADObject -Identity "$DistinguishedName" -TargetPath "OU=Users,OU=Derby,DC=cknotts,DC=co,DC=uk" -Verbose
}
ElseIf ($Office -like "Leeds") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Leeds" -Verbose
Add-ADGroupMember -Members $SamAccountName -Identity "SG_Leeds_office" -Verbose
Set-ADUser -Identity $DistinguishedName -StreetAddress "3rd Floor, St Paul's House, 23 Park Square South" -PostalCode "LS1 2ND" -City "Leeds" -Verbose
Move-ADObject -Identity $DistinguishedName -TargetPath "OU=Users,OU=Leeds,DC=cknotts,DC=co,DC=uk" -Verbose
}
ElseIf ($Office -like "Nottingham") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Nottingham" -Verbose
Add-ADGroupMember -Members $SamAccountName -Identity "SG_Nottingham_office" -Verbose
Set-ADUser -Identity $DistinguishedName -StreetAddress "Lock House, Wilford Street" -PostalCode "NG2 1AG" -City "Nottingham" -Verbose
Move-ADObject -Identity $DistinguishedName -TargetPath "OU=Nottingham full internet - Lawfusion,DC=cknotts,DC=co,DC=uk" -Verbose
}
ElseIf ($Office -like "Manchester") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Manchester" -Verbose
Add-ADGroupMember -Members $SamAccountName -Identity "SG_Manchester_office" -Verbose
Set-ADUser -Identity $DistinguishedName -StreetAddress "Grampian House, Deansgate" -PostalCode "M3 3EE" -City "Manchester" -Verbose
Move-ADObject -Identity $DistinguishedName -TargetPath "OU=Users,OU=Manchester,DC=cknotts,DC=co,DC=uk" -Verbose
}
ElseIf ($Office -like "London") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.London" -Verbose
Add-ADGroupMember -Members $SamAccountName -Identity "SG_London_office" -Verbose
Set-ADUser -Identity $DistinguishedName -StreetAddress "5th Floor, Eldon Chambers, 30-32 Fleet Street" -PostalCode "EC4Y 1AA" -City "London" -Verbose
Move-ADObject -Identity $DistinguishedName -TargetPath "OU=Users,OU=London,DC=cknotts,DC=co,DC=uk" -Verbose
}
ElseIf ($Office -like "Leicester") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Leicester" -Verbose
Add-ADGroupMember -Members $SamAccountName -Identity "SG_Leicester_office" -Verbose
Set-ADUser -Identity $DistinguishedName -StreetAddress "Horsefair House, 3 Horsefair Street" -PostalCode "LE1 5BP" -City "Leicester" -Verbose
Move-ADObject -Identity $DistinguishedName -TargetPath "OU=Users,OU=Leicester,DC=cknotts,DC=co,DC=uk" -Verbose
}
ElseIf ($Office -like "Sheffield") {
Add-ADGroupMember -Members $SamAccountName -Identity "All.Sheffield" -Verbose
Add-ADGroupMember -Members $SamAccountName -Identity "SG_Sheffield_office" -Verbose
Set-ADUser -Identity $DistinguishedName -StreetAddress "St. James House, Vicar Lane" -PostalCode "S1 2EX" -City "Sheffield" -Verbose
Move-ADObject -Identity $DistinguishedName -TargetPath "OU=Users,OU=Sheffield,DC=cknotts,DC=co,DC=uk" -Verbose
}
else {
Write-Warning "This user hasnt been added into any Office groups as the office text entered does not match any of the groups.  Please add this user into the relevant groups manually."
}

$User = Get-ADUser -Identity $SamAccountName -Properties * | Select Name, EmailAddress, Department, Office, Description, MobilePhone

If ($User.Description -like "Consultant") {
    $DN = (Get-ADUser -identity $SamAccountName -Properties *).DistinguishedName
    Remove-ADGroupMember -Members $SamAccountName -Identity "Cartwright King" -Confirm:$False -Verbose
    Add-ADGroupMember -Members $SamAccountName -Identity "Consultants" -Verbose
    Move-ADObject -Identity $DN -TargetPath "OU=Consultants,DC=cknotts,DC=co,DC=uk" -Verbose
}

$User

 }

 Disconnect-PSSession $Session
 Remove-PSSession $session

 Read-Host "Job Completed"