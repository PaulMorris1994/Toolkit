Set-location S:\Analysis
$CSV = gci -path "S:\Analysis" | where { $_.LastWriteTime -gt (get-date).AddDays(-1) -and $_.Extension -eq ".csv" }
$d = get-date -f "dd-MM-yyyy"

import-csv -Path $CSV | export-excel -path "S:\analysis\Week Commencing - $d.xlsx" -worksheetname $d -tablename Helpdesk `
-AutoSize

$Xlsx = "Week Commencing - $d.xlsx"

$Excel = Open-ExcelPackage -path $Xlsx
$Ticket = New-PivotTableDefinition -PivotTableName "Requester" -SourceWorkSheet "$d" -PivotRows "Requester email" -PivotColumns "Type" -PivotData @{ 'Requester Email' = 'Count' }
$Ticket += New-PivotTableDefinition -PivotTableName "Ticket Type" -SourceWorkSheet "$d" -PivotRows "Type" -PivotData @{ 'Type' = 'Count' } -IncludePivotChart `
-ChartType Pie3D -ShowCategory -ShowPercent
$Ticket += New-PivotTableDefinition -PivotTableName "Support Team" -SourceWorkSheet "$d" -PivotRows "Status","Agent" -PivotData @{ 'Status' = 'Count' } -IncludePivotChart `
-ChartType Pie3D -ShowCategory -ShowPercent
export-excel -ExcelPackage $Excel -PivotTableDefinition $Ticket