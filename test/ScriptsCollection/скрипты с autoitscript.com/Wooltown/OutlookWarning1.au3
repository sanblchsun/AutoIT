Opt("TrayIconHide", 1)          ;0=show, 1=hide tray icon
Opt("WinSearchChildren", 1)     ;0=no, 1=search children also
;===============================================================================
;
; Function Name:    _OutlookWarning()
; Description:      Automatically click on the Yes button when trying to send an email via MS Outlook
 ;Parameter(s):     None
; Requirement(s):   None
; Return Value(s): 	None
; Author(s):        Wooltown
; Created:          2009-02-09       
; Modified:         2009-02-27
;
;===============================================================================
_OutlookWarning()
Func _OutlookWarning()
	For $iNum = 1 to 5
		If WinExists("Microsoft Office Outlook","A program is trying to automatically send e-mail") Then
			While 1
				WinActivate("Microsoft Office Outlook")
				Sleep(500)
				If ControlCommand ("Microsoft Office Outlook","A program is trying to automatically send e-mail","Button4","IsEnabled") Then
					Sleep (500)
					ControlFocus ("Microsoft Office Outlook","A program is trying to automatically send e-mail","[CLASS:Button; INSTANCE:4]")
					Send ("{SPACE}")
					ExitLoop 2
				EndIf
				Sleep (250)
			Wend
		EndIf
		Sleep(1000)
	Next
EndFunc