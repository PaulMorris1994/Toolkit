$Path = "$home\documents"
$Installer = 'chromeinstaller.exe' 

Invoke-WebRequest -Uri 'http://dl.google.com/chrome/install/375.126/chrome_installer.exe' -OutFile $Path\$Installer
Start-Process -FilePath $Path\$Installer -ArgumentList '/silent /install' -Verb RunAs -Wait
Remove-Item $path\$Installer -Force


#$env:TEMP