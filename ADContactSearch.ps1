$Cred = Get-StoredCredential -Target Automation
$Session = New-PSSession -ComputerName CKSAZAD002 -Credential $Cred
$User = Read-Host "Type the full name of the user. Type 'Office' to gain a full list of each user in each office. Type 'Department' to gain a full list of each user in each department"

Invoke-Command -Session $Session {

$Users = Get-ADUser -Filter * -Properties Name, Office, Department, Mobile, OfficePhone, Mail -SearchBase "OU=Users,OU=Birmingham,DC=cknotts,DC=co,DC=uk"
$Users += Get-ADUser -Filter * -Properties Name, Office, Department, Mobile, OfficePhone, Mail -SearchBase "OU=Users,OU=Bedford,DC=cknotts,DC=co,DC=uk"
$Users += Get-ADUser -Filter * -Properties Name, Office, Department, Mobile, OfficePhone, Mail -SearchBase "OU=Users,OU=Derby,DC=cknotts,DC=co,DC=uk"
$Users += Get-ADUser -Filter * -Properties Name, Office, Department, Mobile, OfficePhone, Mail -SearchBase "OU=Users,OU=Leeds,DC=cknotts,DC=co,DC=uk"
$Users += Get-ADUser -Filter * -Properties Name, Office, Department, Mobile, OfficePhone, Mail -SearchBase "OU=Users,OU=Leicester,DC=cknotts,DC=co,DC=uk"
$Users += Get-ADUser -Filter * -Properties Name, Office, Department, Mobile, OfficePhone, Mail -SearchBase "OU=Users,OU=London,DC=cknotts,DC=co,DC=uk"
$Users += Get-ADUser -Filter * -Properties Name, Office, Department, Mobile, OfficePhone, Mail -SearchBase "OU=Users,OU=Luton,DC=cknotts,DC=co,DC=uk"
$Users += Get-ADUser -Filter * -Properties Name, Office, Department, Mobile, OfficePhone, Mail -SearchBase "OU=Users,OU=Manchester,DC=cknotts,DC=co,DC=uk" 
$Users += Get-ADUser -Filter * -Properties Name, Office, Department, Mobile, OfficePhone, Mail -SearchBase "OU=Users,OU=Middlesbrough,DC=cknotts,DC=co,DC=uk"
$Users += Get-ADUser -Filter * -Properties Name, Office, Department, Mobile, OfficePhone, Mail -SearchBase "OU=Users,OU=Northampton,DC=cknotts,DC=co,DC=uk"
$Users += Get-ADUser -Filter * -Properties Name, Office, Department, Mobile, OfficePhone, Mail -SearchBase "OU=Nottingham full internet - Lawfusion,DC=cknotts,DC=co,DC=uk"
$Users += Get-ADUser -Filter * -Properties Name, Office, Department, Mobile, OfficePhone, Mail -SearchBase "OU=Users,OU=Sheffield,DC=cknotts,DC=co,DC=uk"
$Users += Get-ADUser -Filter * -Properties Name, Office, Department, Mobile, OfficePhone, Mail -SearchBase "OU=Users,OU=Worcester,DC=cknotts,DC=co,DC=uk"

If($using:user -Eq "Office") {

$users | select Name, Office, Department, Mobile, OfficePhone, Mail| sort Office, Department, name | fl -GroupBy Office
Read-Host "Job Completed"

}
ElseIf($Using:user -Eq "Department") {

$users | select Name, Office, Department, Mobile, OfficePhone, Mail| sort Department, name | fl -GroupBy Department
Read-Host "Job Completed"

}
ElseIf(Get-ADUser -Filter "Name -like '*$($Using:User)*'") {

$Contact = (Get-ADUser -Filter "Name -like '*$($Using:User)*'").Name
ForEach($C in $Contact) {
$UserExport = $users | Where { $_.Name -Like "*$C*" } | Select Name, Office, Department, Mobile, Officephone, Mail
$UserExport | fl
}
Read-Host "Job Completed"

    }
else {

$User = Read-Host "$Using:User doesnt exsist, please review the spelling and type the name again to re-run the search"
$Contact = (Get-ADUser -Filter "Name -like '*$User*'").Name
ForEach($C in $Contact) {
$UserExport = $users | Where { $_.Name -Like "*$C*" } | Select Name, Office, Department, Mobile, Officephone, Mail
$UserExport | fl
}
Read-Host "Job Completed"

    }

}
