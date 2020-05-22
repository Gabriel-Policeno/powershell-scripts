Get-ADComputer -Filter * -Properties Name,Enabled,LastLogonDate,LastLogon,OperatingSystem,OperatingSystemVersion | 
Where-Object {$_.LastLogonDate -lt "01/01/2020 00:00:00" -and $_.OperatingSystem -notmatch "Server"} | 
Select-Object Name,Enabled,LastLogonDate,@{n='LastLogon';e={[DateTime]::FromFileTime($_.LastLogon)}},OperatingSystem, OperatingSystemVersion | 
Sort-Object Enabled -Descending | ft -AutoSize
