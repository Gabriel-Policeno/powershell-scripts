
# List all computers that not a server
Get-ADComputer -Filter * -Properties Name,Enabled,LastLogonDate,LastLogon,OperatingSystem,OperatingSystemVersion | 
Where-Object {$_.LastLogonDate -lt "01/01/2020 00:00:00" -and $_.OperatingSystem -notmatch "Server"} | 
Select-Object Name,Enabled,LastLogonDate,@{n='LastLogon';e={[DateTime]::FromFileTime($_.LastLogon)}},OperatingSystem, OperatingSystemVersion | 
Sort-Object Enabled -Descending | ft -AutoSize

Get-ADComputer -Filter * -Properties Name,Enabled,LastLogonDate,LastLogon,OperatingSystem,OperatingSystemVersion | 
Where-Object {$_.Enabled -eq $true -and ($_.LastLogonDate -lt "01/01/2020 00:00:00" -and $_.OperatingSystem -notmatch "Server")} | 
measure | Select-Object Count | ft -AutoSize

# List all servers
Get-ADComputer -Filter * -Properties Name,Enabled,OperatingSystem,OperatingSystemVersion | 
Where-Object {$_.Enabled -eq $True -and $_.OperatingSystem -match "Server"} | 
Select-Object Name,OperatingSystem,OperatingSystemVersion | Sort-Object OperatingSystem -Descending | ft -AutoSize

# All computers on Active Directory
Get-ADComputer -Filter * | measure | select Count

# All computers on Active Directory with Enabled status equal to True
Get-ADComputer -Filter * -Properties Name,Enabled | Where-Object {$_.Enabled -eq $True} | measure | Select-Object Count

# All computers on Active Directory with Enabled status equal to False
Get-ADComputer -Filter * -Properties Name,Enabled | Where-Object {$_.Enabled -eq $False} | measure | Select-Object Count

# Only Desktops
Get-ADComputer -Filter * -Properties Name,Enabled,OperatingSystem,OperatingSystemVersion | 
Where-Object {$_.Enabled -eq $True -and $_.OperatingSystem -notmatch "Server"} | 
Select-Object Name,OperatingSystem,OperatingSystemVersion | Sort-Object OperatingSystem | ft -AutoSize
