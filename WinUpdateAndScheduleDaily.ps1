Install-Module PSWindowsUpdate

Start-Sleep -Seconds 2

$CurLoc = Convert-Path .

New-Item -Path $CurLoc -Name "MyScripts" -ItemType "directory"

Start-Sleep -Seconds 2

CD $CurLoc\MyScripts

$CurLoc = Convert-Path .

New-Item -Path $CurLoc -Name "RunPSWindowsUpdate.ps1" -ItemType "file" -Value "Install-WindowsUpdate -AcceptAll"

Start-Sleep -Seconds 2

$CurLoc + "\InstallPSWindowsUpdate.ps1"

$WinUpdate = $CurLoc + "\RunPSWindowsUpdate.ps1"

$action = New-ScheduledTaskAction -Execute "Powershell.exe" -Argument $WinUpdate
$trigger = New-ScheduledTaskTrigger -Daily -At 9am
$principal = New-ScheduledTaskPrincipal -UserID "NT AUTHORITY\SYSTEM" -LogonType ServiceAccount -RunLevel Highest

Register-ScheduledTask -Action $action -Principal $principal -Trigger $trigger -TaskPath "My-Tasks" -TaskName "Update Windows" -Description "Checks and runs any updates at 9am daily"

Start-Sleep -Seconds 2

Install-WindowsUpdate