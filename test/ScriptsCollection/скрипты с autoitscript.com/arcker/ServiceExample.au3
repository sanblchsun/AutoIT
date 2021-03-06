#NoTrayIcon
#AutoIt3Wrapper_UseUpx=n

Global $MainLog = @ScriptDir & "\services_test.log"
Global $sServiceName = "AutoitTestService"

#include "Services.au3"
#include <Timers.au3> ; i used it for timers func

logPrint("script started")
If $cmdline[0] > 0 Then
	Switch $cmdline[1]
		Case "install", "-i", "/i"
			InstallService()
		Case "remove", "-u", "/u", "uninstall"
			RemoveService()
		Case Else
			ConsoleWrite(" - - - Help - - - " & @CRLF)
			ConsoleWrite("params : " & @CRLF)
			ConsoleWrite(" -i : install service" & @CRLF)
			ConsoleWrite(" -u : remove service" & @CRLF)
			ConsoleWrite(" - - - - - - - - " & @CRLF)
			Exit
			;start service.
	EndSwitch
EndIf
_Service_init($sServiceName)

Func main_init()
	logPrint("main_init. Stop event=" & $service_stop_event)
EndFunc   ;==>main_init

Func _Svc_Main()
	main_init()
	logPrint("main start")
	logPrint("main loop. evnt=" & _WinAPI_WaitForSingleObject($service_stop_event, 0))
	While $gServiceStateRunning
;~ 	While _WinAPI_WaitForSingleObject($service_stop_event, 0)
		Sleep(1000)
	WEnd
	logPrint("main outer. evnt=" & _WinAPI_WaitForSingleObject($service_stop_event, 0))
	_Service_Cleanup()
	logPrint("main stopped.")
EndFunc   ;==>main

Func logPrint($text, $nolog = 0)
	If $nolog Then
		MsgBox(0, "MyService", $text, 1)
	Else
		If Not FileExists($MainLog) Then FileWriteLine($MainLog, "Log created: " & @YEAR & "/" & @MON & "/" & @MDAY & " " & @HOUR & ":" & @MIN & ":" & @SEC)
		FileWriteLine($MainLog, @YEAR & @MON & @MDAY & " " & @HOUR & @MIN & @SEC & " [" & @AutoItPID & "] >> " & $text)
	EndIf
	Return 0
EndFunc   ;==>logPrint

Func InstallService()
	logPrint("InstallService(): Installing service, please wait")
	_Service_Create($sServiceName, "Autoit Service Test", $SERVICE_WIN32_OWN_PROCESS, $SERVICE_DEMAND_START, $SERVICE_ERROR_IGNORE,'"' & @ScriptFullPath & '"')
	If @error Then
		logPrint("InstallService(): Problem installing service, Error number is " & @error & @CRLF & " message : " & _WinAPI_GetLastErrorMessage())
	Else
		logPrint("InstallService(): Installation of service successful")
	EndIf
	Exit
EndFunc   ;==>InstallService

Func RemoveService()
	_Service_Stop($sServiceName)
	_Service_Delete($sServiceName)
	If Not @error Then logPrint("RemoveService(): service removed successfully" & @CRLF)
	Exit
EndFunc   ;==>RemoveService

#cs
	...from MSDN:
	The ServiceMain function should perform the following tasks:

	Initialize all global variables.
	Call the RegisterServiceCtrlHandler function immediately to register a Handler function to handle control requests for the service. The return value of RegisterServiceCtrlHandler is a service status handle that will be used in calls to notify the SCM of the service status.
	Perform initialization. If the execution time of the initialization code is expected to be very short (less than one second), initialization can be performed directly in ServiceMain.
	If the initialization time is expected to be longer than one second, call the SetServiceStatus function, specifying the SERVICE_START_PENDING service state and a wait hint in the SERVICE_STATUS structure.

	If your service's initialization code performs tasks that are expected to take longer than the initial wait hint value, your code must call the SetServiceStatus function periodically (possibly with a revised wait hint) to indicate that progress is being made. Be sure to call SetServiceStatus only if the initialization is making progress. Otherwise, the Service Control Manager can wait for your service to enter the SERVICE_RUNNING state assuming that your service is making progress and block other services from starting. Do not call SetServiceStatus from a separate thread unless you are sure the thread performing the initialization is truly making progress.

	When initialization is complete, call SetServiceStatus to set the service state to SERVICE_RUNNING.
	Perform the service tasks, or, if there are no pending tasks, return control to the caller. Any change in the service state warrants a call to SetServiceStatus to report new status information.
	If an error occurs while the service is initializing or running, the service should call SetServiceStatus to set the service state to SERVICE_STOP_PENDING if cleanup will be lengthy. After cleanup is complete, call SetServiceStatus to set the service state to SERVICE_STOPPED from the last thread to terminate. Be sure to set the dwServiceSpecificExitCode and dwWin32ExitCode members of the SERVICE_STATUS structure to identify the error.
#ce