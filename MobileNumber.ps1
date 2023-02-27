$Num = Import-Csv "C:\Users\ckadmin\Documents\Number.csv"

ForEach ($n in $num) {
    
    $SAN = (Get-aduser -Filter " Name -like '$($N.Name)' ").SamAccountName
    If ( Get-aduser -Filter " Name -like '$($N.Name)' " )
        {
            Set-ADUser -Identity $SAN -MobilePhone $N.Number
        }
    Else {
            Write-Warning "$($N.Name) Does not exsist" 
        }

}