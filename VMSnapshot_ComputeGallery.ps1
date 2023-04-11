$RG = "RG_UKS_MTL"
$Gallerydefname = "Win10-Client"
$GalleryName = "ACG_MTL"
$galleryImageVersionName = get-date -format yyyy.MM.ddHHmmss
$Location = "UKSouth"
$ReplicaCount = "5"
get-azvm | ft name, id
$SourceImageName = Read-Host "Copy & Paste the Name of the VM you wish to capture"
$SourceImageID = (get-azvm -Name $SourceImageName).id
$vm = get-azvm -Name $SourceImageName -Status

If($VM.PowerState -eq "VM deallocated") {
#Setting the VM to Generalized
Set-AzVM -ResourceGroupName $RG -Name $SourceImageName -Generalized -Verbose

#Image creation
New-AzGalleryImageVersion `
-ResourceGroupName $RG `
-GalleryName $GalleryName `
-GalleryImageDefinitionName $Gallerydefname `
-Location $Location `
-SourceImageId $SourceImageID `
-Name $galleryImageVersionName `
-ReplicaCount $ReplicaCount `
-Verbose

#Deleting the VM, NIC and Disk
Remove-AzVM `
-ResourceGroupName $RG `
-Name $SourceImageName `
-Force `
-Verbose
}

else {
    Read-Host "Image VM is not deallocated"
}