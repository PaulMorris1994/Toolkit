if(-not(get-psdrive -name M)) { cmd.exe /C "cmdkey /add:`"pulmorrisltdstorage.file.core.windows.net`" /user:`"localhost\pulmorrisltdstorage`" /pass:`"Y1rsUUbzZJ5wuxs3r9P9OhoT6V1+43+Z3Z69dHOmgMIWTzJRlciuD7qah2WDJ24EeW72NTN1Xd0E+AStOaZtkQ==`""
    # Mount the drive
    New-PSDrive -Name f -PSProvider FileSystem -Root "\\pulmorrisltdstorage.file.core.windows.net\shared-storage" -Persist 
    }
    
