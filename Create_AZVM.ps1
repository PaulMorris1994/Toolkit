#NewVM
$RG = "RG_UKS_MTL"
$Name = Read-Host "Type new VM name"
$Location = "UKSouth"
$Gallerydefname = "Win10-Client"
$GalleryName = "ACG_MTL"
$ImageSelection = Get-AzGalleryImageVersion -ResourceGroupName $RG -GalleryName $GalleryName -GalleryImageDefinitionName $GallerydefName | select Name
$teams= new-object -Type System.Collections.Arraylist

ForEach($I in $ImageSelection){
    $Image = Get-AzGalleryImageVersion -ResourceGroupName $RG -GalleryName $GalleryName -GalleryImageDefinitionName $GallerydefName -Name $I.Name | Select *
    $ImageName = ($Image).Name
    $Date      = ($Image).PublishingProfile.PublishedDate
    $teams.Add([psCustomObject]@{
        "Image" = $ImageName;
        "Date"  = $Date})
}
$teams | select Image, Date | Sort Date -Descending | Out-Host

$ImageVersion = Read-Host "Type image name"
$Size = "Standard_B2s"
$Disk = "Delete"
$NetworkName = "VN_Clients_MTL"
$SubnetName = "Clients_MTL"
$LicenseType = "Windows_Client"
$NIC = "Delete"
$cred = Get-Credential -Message "Enter a username and password for the virtual machine."

#AzureComputeGallery
$image = Get-AzGalleryImageVersion -ResourceGroupName $RG -GalleryName $GalleryName -GalleryImageDefinitionName $GallerydefName -Name $ImageVersion

#Setting up Azure VM
New-AZVM `
-ResourceGroupName $RG `
-Name $Name `
-Location $Location `
-Image $Image.id `
-Size $Size `
-OSDiskDeleteOption $Disk `
-VirtualNetworkName $NetworkName `
-SubnetName $SubnetName `
-NetworkInterfaceDeleteOption $NIC `
-Credential $Cred `
-verbose

#VM, NIC and NSG details
$VM = Get-AZVM -Name $Name
$NicName = $vm.NetworkProfile.NetworkInterfaces.Id.Split('/')[-1]
$NSG = (Get-AzNetworkInterface -Name $NicName).NetworkSecurityGroup.Id.Split('/')[-1]
$NIC = Get-AzNetworkInterface -Name $NICName
$Nic.NetworkSecurityGroup = $null

#Remove NSG
Set-AzNetworkInterface -NetworkInterface $NIC
Remove-AzNetworkSecurityGroup -ResourceGroupName $RG -Name $nsg -Force -Confirm:$False -Verbose

#Assign license type
$VM.LicenseType = "Windows_Client"
Update-AzVM -ResourceGroupName $RG -VM $VM -Verbose