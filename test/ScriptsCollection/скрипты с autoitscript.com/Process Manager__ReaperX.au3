#include <Array.au3>
#include <GuiListView.au3>
#include <GuiMenu.au3>
#include <Process.au3>
#include <GUIConstants.au3>
#include <File.au3>
#include <StaticConstants.au3>
#include <EditConstants.au3>
#NoTrayIcon

Main()
SetPriority()

Func Main()
	GUIDelete()
	AutoItSetOption("ExpandVarStrings", 1)
	$Main = GUICreate("Process Manager", 200, 310, -1, -1)
	Global $ProcessList = GUICtrlCreateListView("", 0, 0, 200, 290)
	;File Menu
	$FileMenu = GUICtrlCreateMenu("File")
	$FileNew = GUICtrlCreateMenuItem("New Process", $FileMenu)
	$Exit = GUICtrlCreateMenuItem("Exit", $FileMenu)
	;Options Menu
	$OptionsMenu = GUICtrlCreateMenu("Options")
	$RestartExplorer = GUICtrlCreateMenuItem("Restart Explorer", $OptionsMenu)
	$OpenNotepad = GUICtrlCreateMenuItem("Open Notepad", $OptionsMenu)
	;Power Options(Sub Menu)
	$PowerOptionsSub = GUICtrlCreateMenu("Power Options", $OptionsMenu)
	$PowerShutdown = GUICtrlCreateMenuItem("Shutdown", $PowerOptionsSub)
	$PowerReboot = GUICtrlCreateMenuItem("Reboot", $PowerOptionsSub)
	$PowerLogoff = GUICtrlCreateMenuItem("Log Off", $PowerOptionsSub)
	;Help Menu
	$HelpMenu = GUICtrlCreateMenu("Help")
	$About = GUICtrlCreateMenuItem("About", $HelpMenu)
	$ContextMenu = GUICtrlCreateContextMenu($ProcessList)
	$ContextEndProcess = GUICtrlCreateMenuItem("End Process", $ContextMenu)
	$ContextSetPriority = GUICtrlCreateMenuItem("Set Priority", $ContextMenu)
	$ContextMemInfo = GUICtrlCreateMenuItem("Memory Info", $ContextMenu)
	;Display Array in ListView()
	Global $Process = ProcessList()
	_ArrayDelete($Process, 0)
	_ArrayDelete($Process, 0)
	_ArrayDelete($Process, 0)
	_GUICtrlListView_SetItemCount($ProcessList, $Process[0][0])
	_GUICtrlListView_InsertColumn($ProcessList, 0, "Process", 120, 2)
	_GUICtrlListView_InsertColumn($ProcessList, 1, "PID", 60, 2)
	_GUICtrlListView_AddArray($ProcessList, $Process)
	GUISetState()
	While 1
		Switch GUIGetMsg()
			Case -3
				Exit
			Case $ContextEndProcess
				_GUICtrlListView_BeginUpdate($ProcessList)
				$sIndex = _GUICtrlListView_GetSelectionMark($ProcessList)
				$SelectedProcess = $Process[$sIndex][0]
				ProcessClose($SelectedProcess)
				_GUICtrlListView_EndUpdate($ProcessList)
				Main()
			Case $FileNew
				$file = InputBox("New Process", "Enter a Valid File/Process to Open.")
				If $file = "" Then
					Main()
				Else
					$RunCheck = Run($file)
					WinActivate($file)
					If $RunCheck = 0 Then
						MsgBox(16, "Error!", 'Process Manager Cannot Find "$file$". Make Sure That File Exists and That You Have Type it In Correctly.')
						GUIDelete()
						Main()
					EndIf
				EndIf
			Case $ContextSetPriority
				SetPriority()
			Case $RestartExplorer
				ProcessClose("explorer.exe")
				ProcessWaitClose("explorer.exe")
				Run("explorer.exe")
				GUIDelete()
				Main()
			Case $OpenNotepad
				Run("notepad.exe")
				GUIDelete()
				Main()
			Case $PowerShutdown
				$Confirm = MsgBox(35, "Confirm Shutdown", "All Applications Will Close and The Computer Will Shutdown. Do You Want to Continue?")
				If $Confirm = 6 Then
					Shutdown(9)
					Exit
				EndIf
			Case $PowerReboot
				$Confirm = MsgBox(35, "Confirm Reboot", "All Applications Will Close and The Computer Will Reboot. Do You Want to Continue?")
				If $Confirm = 6 Then
					Shutdown(2)
					Exit
				EndIf
			Case $PowerLogoff
				$Confirm = MsgBox(35, "Confirm Log Off", "All Applications Will Close and The Current User Will be Logged Off. Do You Want to Continue?")
				If $Confirm = 6 Then
					Shutdown(0)
					Exit
				EndIf
			Case $ContextMemInfo
				MsgBox(0, "Not Finish", "Still Working on This!")
				;$sIndex = _GUICtrlListView_GetSelectionMark($ProcessList)
				;$MemInfo = ProcessGetStats($Process[$sIndex][0])
				;MsgBox(0, "Memory Info", "Process: " &$Process[$sIndex][0] & @LF & @LF & "Working Set Size: " &$MemInfo & " KB" & @LF & "Peak Working Size: " &$MemInfo & " KB")
			Case $About
				MsgBox(0, "About Process Manager", "Process Manager" & @LF & @LF & "Version: 1.0" & @LF & "Created By: ReaperX")
			Case $Exit
				Exit
		EndSwitch
	WEnd
EndFunc   ;==>Main

Func SetPriority()
	AutoItSetOption("ExpandVarStrings", 1)
	Global $ProcessList, $Process
	$wTitle = GUICreate("Set Priority", 180, 200, -1, -1)
	$sIndex = _GUICtrlListView_GetSelectionMark($ProcessList)
	$PID = $Process[$sIndex][1]
	$PNAME = $Process[$sIndex][0]
	$sPriority = _ProcessGetPriority($PID)
	If $sPriority = -1 Then
		MsgBox(16, "Error!", 'The Current Priority for "$PNAME$" Couldnt Be Detected So it Cannot Be Changed.')
		GUIDelete()
		Main()
	EndIf
	;Display Current Priority in a Label for The Selected Process
	If $sPriority = 0 Then $CurrentP = "Idle/Low"
	If $sPriority = 1 Then $CurrentP = "Below Normal"
	If $sPriority = 2 Then $CurrentP = "Normal"
	If $sPriority = 3 Then $CurrentP = "Above Normal"
	If $sPriority = 4 Then $CurrentP = "High"
	If $sPriority = 5 Then $CurrentP = "Realtime"
	$PriorityLabel = GUICtrlCreateLabel("Current Priority: " & $CurrentP, 30, 10)
	$SetTo0 = GUICtrlCreateRadio("Idle/Low", 50, 30, 150)
	If $sPriority = 0 Then GUICtrlSetState($SetTo0, $GUI_DISABLE)
	$SetTo1 = GUICtrlCreateRadio("Below Normal", 50, 50, 150)
	If $sPriority = 1 Then GUICtrlSetState($SetTo1, $GUI_DISABLE)
	$SetTo2 = GUICtrlCreateRadio("Normal", 50, 70, 150)
	If $sPriority = 2 Then GUICtrlSetState($SetTo2, $GUI_DISABLE)
	$SetTo3 = GUICtrlCreateRadio("Above Normal", 50, 90, 150)
	If $sPriority = 3 Then GUICtrlSetState($SetTo3, $GUI_DISABLE)
	$SetTo4 = GUICtrlCreateRadio("High", 50, 110, 150)
	If $sPriority = 4 Then GUICtrlSetState($SetTo4, $GUI_DISABLE)
	$SetTo5 = GUICtrlCreateRadio("Realtime", 50, 130, 150)
	If $sPriority = 5 Then GUICtrlSetState($SetTo5, $GUI_DISABLE)
	$ApplyButton = GUICtrlCreateButton("Apply", 30, 160, 50, 30)
	$CancelButton = GUICtrlCreateButton("Cancel", 90, 160, 50, 30)

	GUISetState()
	While 1
		$Msg = GUIGetMsg()
		Switch $Msg
			Case $ApplyButton
				;Check Which Radio Button Is Checked to Set the Priority Selected for
				;Selected Process
				If BitAND(GUICtrlRead($SetTo0), $GUI_CHECKED) = $GUI_CHECKED Then
					ProcessSetPriority($PID, 0)
					MsgBox(0, $PNAME, "Priority Set to Idle/Low")
					GUIDelete()
					Main()
				EndIf
				If BitAND(GUICtrlRead($SetTo1), $GUI_CHECKED) = $GUI_CHECKED Then
					ProcessSetPriority($PID, 1)
					MsgBox(0, $PNAME, "Priority Set to Below Normal")
					GUIDelete()
					Main()
				EndIf
				If BitAND(GUICtrlRead($SetTo2), $GUI_CHECKED) = $GUI_CHECKED Then
					ProcessSetPriority($PID, 2)
					MsgBox(0, $PNAME, "Priority Set to Normal")
					GUIDelete()
					Main()
				EndIf
				If BitAND(GUICtrlRead($SetTo3), $GUI_CHECKED) = $GUI_CHECKED Then
					ProcessSetPriority($PID, 3)
					MsgBox(0, $PNAME, "Priority Set to Above Normal")
					GUIDelete()
					Main()
				EndIf
				If BitAND(GUICtrlRead($SetTo4), $GUI_CHECKED) = $GUI_CHECKED Then
					ProcessSetPriority($PID, 4)
					MsgBox(0, $PNAME, "Priority Set to High")
					GUIDelete()
					Main()
				EndIf
				If BitAND(GUICtrlRead($SetTo5), $GUI_CHECKED) = $GUI_CHECKED Then
					$Confirm = MsgBox(52, "Caution!", 'Setting a Process Priority to "Realtime" May Cause System Instability. Are You Sure You Want to Continue?')
					If $Confirm = 6 Then
						ProcessSetPriority($PID, 5)
						MsgBox(0, $PNAME, "Priority Set to Realtime")
						Main()
					EndIf
					If $Confirm = 7 Then
						GUIDelete()
						Main()
					EndIf
				EndIf
			Case $CancelButton
				GUIDelete()
				Main()
		EndSwitch
	WEnd
EndFunc   ;==>SetPriority
