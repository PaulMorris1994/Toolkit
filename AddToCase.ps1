$Reg = Get-ItemPropertyvalue 'HKCU:\SOFTWARE\Microsoft\Office\Outlook\Addins\sls.OutlookAddin.v2.2.122' -Name Loadbehavior

If (  $Reg -eq "2" ) {
    Set-ItemProperty 'HKCU:\SOFTWARE\Microsoft\Office\Outlook\Addins\sls.OutlookAddin.v2.2.122' -Name Loadbehavior -Value 3 -Verbose
    Read-Host "Job completed. Please open Outlook to check add-in."
    }
else { Read-Host "Please report add-in issue to itsupport@cartwrightking.co.uk." }