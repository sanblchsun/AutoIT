Opt("TrayIconHide", 1)          ;0=show, 1=hide tray icon
Opt("WinSearchChildren", 1)     ;0=no, 1=search children also
;===============================================================================
;
; Function Name:    _OutlookWarningAddress()
; Description:      Automatically click on the Yes button when trying to read contacts
; Parameter(s):     None
; Requirement(s):   None
; Return Value(s): 	None
; Author(s):        Wooltown
; Created:          2009-02-11       
; Modified:         2009-02-27
;
;===============================================================================
#Include <GuiComboBox.au3>
_OutlookWarningAddress()
Func _OutlookWarningAddress()
	For $iNum = 1 to 5
		If WinExists("Microsoft Office Outlook","A program is trying to access") Then
			While 1
				WinActivate("Microsoft Office Outlook","A program is trying to access")
				Sleep(500)
				If ControlCommand ("Microsoft Office Outlook","A program is trying to access","Button4","IsEnabled") Then
					ControlCommand("Microsoft Office Outlook","A program is trying to access","Button3","Check", "")
					Sleep (500)
					Local $hOutlook = ControlGetHandle("Microsoft Office Outlook","A program is trying to access","ComboBox1")
					_GUICtrlComboBox_SelectString($hOutlook,"10 minutes")
					Sleep (250)
					ControlFocus ("Microsoft Office Outlook","A program is trying to access","[CLASS:Button; INSTANCE:4]")
					Send ("{SPACE}")
					ExitLoop 2
				EndIf
				Sleep (250)
			Wend
		EndIf
		Sleep(1000)
	Next
EndFunc