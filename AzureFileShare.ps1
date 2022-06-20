if(-not(get-psdrive -name s)) { $connectTestResult = Test-NetConnection -ComputerName pulmorrisltdstorage.file.core.windows.net -Port 445
    if ($connectTestResult.TcpTestSucceeded) {
        # Save the password so the drive will persist on reboot
        cmd.exe /C "cmdkey /add:`"pulmorrisltdstorage.file.core.windows.net`" /user:`"localhost\pulmorrisltdstorage`" /pass:`"Y1rsUUbzZJ5wuxs3r9P9OhoT6V1+43+Z3Z69dHOmgMIWTzJRlciuD7qah2WDJ24EeW72NTN1Xd0E+AStOaZtkQ==`""
        # Mount the drive
        New-PSDrive -Name M -PSProvider FileSystem -Root "\\pulmorrisltdstorage.file.core.windows.net\shared-storage" -Persist
    } else {
        Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
    } }