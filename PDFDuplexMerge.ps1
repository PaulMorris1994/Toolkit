$DocInput = gci -File -Path "S:\PDF Split" | sort -Property name
$DocOne = $DocInput[0]
$DocTwo = $DocInput[1]
$BundleName = Read-Host "Type name of bundle output"


Split-PDF -FilePath $DocOne.Fullname -OutputFolder "S:\PDF Split\Document1" -OutputName "Output-" -IgnoreProtection -Verbose
Split-PDF -FilePath $DocTwo.Fullname -OutputFolder "S:\PDF Split\Document2" -OutputName "Output-" -IgnoreProtection -Verbose


$PDFRename = gci 'S:\PDF Split\Document2\'

ForEach($P in $PDFRename) {
    $Name = $P.Name.Split('.')
    $NewName = $name[0]
    Rename-Item -Path $P.Fullname -NewName "$NewName-B.pdf" -Verbose
}

gci "S:\PDF Split\Document2" | Move-Item -Destination "S:\PDF Split\Document1" -Verbose

$ToNatural= { [regex]::Replace($_, '\d+',{$args[0].Value.Padleft(20)})}
$DocMerge = gci "S:\PDF Split\Document1" | sort $ToNatural

Merge-PDF -InputFile $DocMerge.FullName -OutputFile "S:\PDF Split\Bundle\$BundleName.pdf" -Verbose

If(test-path "S:\PDF Split\Bundle\$BundleName.pdf") {
    gci "S:\PDF Split\Document1" | Remove-Item -Force -Verbose
    gci -File -Path "S:\PDF Split" | Remove-Item -Force -Verbose
    Read-Host "Your bundle has been saved: S:\PDF Split\Bundle\$BundleName.pdf"
}
else {Read-Host "bundle has not been created"}