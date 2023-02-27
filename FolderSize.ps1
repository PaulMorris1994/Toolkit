$Cases = Import-csv "\\sacwkfsuks.file.core.windows.net\shareddrive\Paul Morris\LF Purge\Azure\ClosedCases.csv"

ForEach ($C in $Cases) {

If (Test-Path $C.Case) {
$C.Case

$Size = (gci -Recurse -Path $C.Case | Measure Length -s).Sum /1mb

$Data=[Ordered]@{
    'Name' = $C.Case
    'Size(MB)' = $Size
    }
}
Else {

$C.Case

$Data=[Ordered]@{
    'Name' = $C.Case
    'Size(MB)' = "No path found"
    }

}

$Export = New-Object -TypeName PSobject -Property $Data | export-csv "\\sacwkfsuks.file.core.windows.net\shareddrive\Paul Morris\LF Purge\Azure\ClosedCasesData.csv" -NoTypeInformation -Append -verbose

}
