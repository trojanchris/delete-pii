# delete-pii
Because our employees just wont stop saving customer PII to their computer

This batch file creates a scheduled task to run daily at first opportunity after midnight (or when the computer is started) to remove all files from:

  * Downloads
  * Desktop
  * Pictures
  * Documents
  * and \AppData\Local\Temp just for good measure

drops delete_pii.ps1 in the HOMEPATH folder to be accessed by the scheduled task that looks like the following:
```
$ErrorActionPreference= 'silentlycontinue'
Remove-Item "~\Downloads\*" -Force -Recurse
Remove-Item "~\Desktop\*" -Force -Recurse
Remove-Item "~\Pictures\*" -Force -Recurse
Remove-Item "~\Documents\*" -Force -Recurse
Remove-Item "~\AppData\Local\Temp\*" -Force -Recurse
```
drops delete_pii.xml in the HOMEPATH folder to create the scheduled task that looks like the following:
```
<?xml version="1.0" encoding="UTF-16"?>
<Task version="1.4" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task">
<RegistrationInfo>
<Date>2018-06-14T17:28:14.7039432</Date>
<Author></Author>
<URI>\delete_pii</URI>
</RegistrationInfo>
<Triggers>
<CalendarTrigger>
<StartBoundary>2018-06-14T00:00:00-07:00</StartBoundary>
<Enabled>true</Enabled>
<ScheduleByDay>
<DaysInterval>1</DaysInterval>
</ScheduleByDay>
</CalendarTrigger>
</Triggers>
<Principals>
<Principal id="Author">
<UserId>%USERNAME%</UserId>
<LogonType>InteractiveToken</LogonType>
<RunLevel>LeastPrivilege</RunLevel>
</Principal>
</Principals>
<Settings>
<MultipleInstancesPolicy>IgnoreNew</MultipleInstancesPolicy>
<DisallowStartIfOnBatteries>true</DisallowStartIfOnBatteries>
<StopIfGoingOnBatteries>true</StopIfGoingOnBatteries>
<AllowHardTerminate>true</AllowHardTerminate>
<StartWhenAvailable>true</StartWhenAvailable>
<RunOnlyIfNetworkAvailable>false</RunOnlyIfNetworkAvailable>
<IdleSettings>
<StopOnIdleEnd>true</StopOnIdleEnd>
<RestartOnIdle>false</RestartOnIdle>
</IdleSettings>
<AllowStartOnDemand>true</AllowStartOnDemand>
<Enabled>true</Enabled>
<Hidden>false</Hidden>
<RunOnlyIfIdle>false</RunOnlyIfIdle>
<DisallowStartOnRemoteAppSession>false</DisallowStartOnRemoteAppSession>
<UseUnifiedSchedulingEngine>true</UseUnifiedSchedulingEngine>
<WakeToRun>false</WakeToRun>
<ExecutionTimeLimit>PT72H</ExecutionTimeLimit>
<Priority>7</Priority>
</Settings>
<Actions Context="Author">
<Exec>
<Command>powershell.exe</Command>
<Arguments>-WindowStyle Hidden ~\delete_pii.ps1</Arguments>
</Exec>
</Actions>
</Task>
```

The xml file can be removed after. The name of the taskname thats created is "delete_pii"
