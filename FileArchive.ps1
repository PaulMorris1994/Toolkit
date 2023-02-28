$Source = Read-Host "Type in target file path"
$Destination = Read-Host "Type in destination file path"
[Int]$Date = Read-Host "Type the amount of days you wish to go back"

$Files = gci -File -Recurse -Path $Source | where { $_.LastWriteTime -lt (Get-Date).AddDays(-$date) }

foreach($F in $Files) {
    $Path = $Destination + $F.FullName.SubString($Source.Length)
    New-Item -ItemType File -Path $Path -Force
    move-Item -Path $F.FullName -Destination $Path -Force -Verbose
    }