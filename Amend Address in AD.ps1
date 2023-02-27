$StreetAddress = "Lewis Building, Bull Street,"
$PostalCode = "B4 6AF"
$City = "Birmingham"

$UserB = Get-ADUser -Filter * -Searchbase "OU=Users,OU=Birmingham,DC=cknotts,DC=co,DC=uk" | Select DistinguishedName

ForEach ($U in $UserB) {
Set-ADUser -Identity $U.DistinguishedName -StreetAddress $StreetAddress -PostalCode $PostalCode -City $City
    }

$StreetAddress = "3rd Floor, St. George's House, 6 St George's Way,"
$PostalCode = "LE1 1QZ"
$City = "Leicester"

$UserL = get-ADUser -Filter * -Searchbase "OU=Users,OU=Leicester,DC=cknotts,DC=co,DC=uk" | Select DistinguishedName

ForEach ($U in $UserL) {
Set-ADUser -Identity $U.DistinguishedName -StreetAddress $StreetAddress -PostalCode $PostalCode -City $City
    }

$StreetAddress = "6th Floor City Gate East, Toll House Hill,"
$PostalCode = "NG1 5FS"
$City = "Nottingham"

$UserN = get-ADUser -Filter * -Searchbase "OU=Nottingham full internet - Lawfusion,DC=cknotts,DC=co,DC=uk" | Select DistinguishedName

ForEach ($U in $UserN) {
Set-ADUser -Identity $U.DistinguishedName -StreetAddress $StreetAddress -PostalCode $PostalCode -City $City
    }