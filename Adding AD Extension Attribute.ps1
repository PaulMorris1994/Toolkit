$User = Get-ADUser -Filter * | where { $_.DistinguishedName -Like "*worcester*" } | Select DistinguishedName, Givenname, Surname

ForEach ($U in $User) {
Set-ADUser -Identity $U.DistinguishedName -Add @{ ExtensionAttribute1=$U.GivenName + '.' + $U.Surname +"@cartwrightking.co.uk.cjsm.net" }
    }


$User = Get-ADUser -Filter * | where { $_.DistinguishedName -Like "*nottingham*" } | Select DistinguishedName, Givenname, Surname

ForEach ($U in $User) {
Get-ADUser -Identity $U.DistinguishedName -Properties * | select name, ExtensionAttribute1
    }
