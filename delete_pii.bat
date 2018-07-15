(
echo ^<?xml version="1.0" encoding="UTF-16"?^>
echo ^<Task version="1.4" xmlns="http://schemas.microsoft.com/windows/2004/02/mit/task"^>
echo ^<RegistrationInfo^>
echo ^<Date^>2018-06-14T17:28:14.7039432^</Date^>
echo ^<Author^>^</Author^>
echo ^<URI^>\delete_pii^</URI^>
echo ^</RegistrationInfo^>
echo ^<Triggers^>
echo ^<CalendarTrigger^>
echo ^<StartBoundary^>2018-06-14T00:00:00-07:00^</StartBoundary^>
echo ^<Enabled^>true^</Enabled^>
echo ^<ScheduleByDay^>
echo ^<DaysInterval^>1^</DaysInterval^>
echo ^</ScheduleByDay^>
echo ^</CalendarTrigger^>
echo ^</Triggers^>
echo ^<Principals^>
echo ^<Principal id="Author"^>
echo ^<UserId^>%USERNAME%^</UserId^>
echo ^<LogonType^>InteractiveToken^</LogonType^>
echo ^<RunLevel^>LeastPrivilege^</RunLevel^>
echo ^</Principal^>
echo ^</Principals^>
echo ^<Settings^>
echo ^<MultipleInstancesPolicy^>IgnoreNew^</MultipleInstancesPolicy^>
echo ^<DisallowStartIfOnBatteries^>true^</DisallowStartIfOnBatteries^>
echo ^<StopIfGoingOnBatteries^>true^</StopIfGoingOnBatteries^>
echo ^<AllowHardTerminate^>true^</AllowHardTerminate^>
echo ^<StartWhenAvailable^>true^</StartWhenAvailable^>
echo ^<RunOnlyIfNetworkAvailable^>false^</RunOnlyIfNetworkAvailable^>
echo ^<IdleSettings^>
echo ^<StopOnIdleEnd^>true^</StopOnIdleEnd^>
echo ^<RestartOnIdle^>false^</RestartOnIdle^>
echo ^</IdleSettings^>
echo ^<AllowStartOnDemand^>true^</AllowStartOnDemand^>
echo ^<Enabled^>true^</Enabled^>
echo ^<Hidden^>false^</Hidden^>
echo ^<RunOnlyIfIdle^>false^</RunOnlyIfIdle^>
echo ^<DisallowStartOnRemoteAppSession^>false^</DisallowStartOnRemoteAppSession^>
echo ^<UseUnifiedSchedulingEngine^>true^</UseUnifiedSchedulingEngine^>
echo ^<WakeToRun^>false^</WakeToRun^>
echo ^<ExecutionTimeLimit^>PT72H^</ExecutionTimeLimit^>
echo ^<Priority^>7^</Priority^>
echo ^</Settings^>
echo ^<Actions Context="Author"^>
echo ^<Exec^>
echo ^<Command^>powershell.exe^</Command^>
echo ^<Arguments^>-WindowStyle Hidden ~\delete_pii.ps1^</Arguments^>
echo ^</Exec^>
echo ^</Actions^>
echo ^</Task^>
) > %HOMEPATH%\delete_pii.xml

(
	echo $ErrorActionPreference= 'silentlycontinue'
	echo Remove-Item "~\Downloads\*" -Force -Recurse
	echo Remove-Item "~\Desktop\*" -Force -Recurse
	echo Remove-Item "~\Pictures\*" -Force -Recurse
	echo Remove-Item "~\Documents\*" -Force -Recurse
	echo Remove-Item "~\AppData\Local\Temp\*" -Force -Recurse
) > %HOMEPATH%\delete_pii.ps1

schtasks /create /xml %HOMEPATH%\delete_pii.xml /tn "delete_pii"