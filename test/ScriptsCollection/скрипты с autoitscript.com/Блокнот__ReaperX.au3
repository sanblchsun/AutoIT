#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GUIEdit.au3>
#include <Misc.au3>
#include <GUIStatusBar.au3>
#NoTrayIcon

CheckFile()
Main()
Func CheckFile()
	If FileExists("settings.ini") Then
		Main()
	Else
		IniWrite("settings.ini", "CONFIG", "fontname", "Arial")
		IniWrite("settings.ini", "CONFIG", "fontsize", "11")
		IniWrite("settings.ini", "CONFIG", "fontcolor", "0x000000")
		IniWrite("settings.ini", "CONFIG", "fontweight", "400")
		IniWrite("settings.ini", "CONFIG", "bgcolor", "0xFFFFFF")
		IniWrite("settings.ini", "CONFIG", "attributes", "0")
		IniWrite("settings.ini", "CONFIG", "file", "")
	EndIf
EndFunc   ;==>CheckFile

Func Main()
	$Main = GUICreate("Text Editor By ReaperX", 650, 280, -1, -1, BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPSIBLINGS), $WS_EX_ACCEPTFILES)
	GUISetIcon("shell32.dll", 243)
	$FileMenu = GUICtrlCreateMenu("File")
	$New = GUICtrlCreateMenuItem("New", $FileMenu)
	$Open = GUICtrlCreateMenuItem("Open", $FileMenu)
	$Save = GUICtrlCreateMenuItem("Save", $FileMenu)
	$SaveAs = GUICtrlCreateMenuItem("Save As...", $FileMenu)
	GUICtrlCreateMenuItem("", $FileMenu)
	$Exit = GUICtrlCreateMenuItem("Exit", $FileMenu)

	$ViewMenu = GUICtrlCreateMenu("View")
	$DocInfo = GUICtrlCreateMenuItem("Document Info", $ViewMenu)
	$EditMenu = GUICtrlCreateMenu("Edit")
	$Find = GUICtrlCreateMenuItem("Find...", $EditMenu)
	$Font = GUICtrlCreateMenuItem("Edit Font", $EditMenu)
	$BGColor = GUICtrlCreateMenuItem("Background Color", $EditMenu)
	$SelectAll = GUICtrlCreateMenuItem("Select All", $EditMenu)
	$TimeAndDate = GUICtrlCreateMenuItem("Insert Time/Date", $EditMenu)
	$SpeakText = GUICtrlCreateMenuItem("Speak Highlighted Text", $EditMenu)
	$HelpMenu = GUICtrlCreateMenu("Help")
	$About = GUICtrlCreateMenuItem("About", $HelpMenu)
	Global $Edit = GUICtrlCreateEdit("", 0, 0, 650, 238, BitOR($GUI_SS_DEFAULT_EDIT, $ES_AUTOVSCROLL, $ES_MULTILINE, $WS_VSCROLL))
	GUICtrlSetState(-1, $GUI_DROPACCEPTED)
	Local $Parts[1] = [70]
	Global $StatusBar = _GUICtrlStatusBar_Create($Main, $Parts, $SB_SIMPLEID)
	_GUICtrlStatusBar_SetParts($StatusBar, $Parts)
	_GUICtrlStatusBar_SetText($StatusBar, "New Document")

	If FileExists("temp") Then
		GUICtrlSetData(-1, FileRead("temp"))
		FileDelete("temp")
	EndIf
	GUICtrlSetFont(-1, IniRead("settings.ini", "CONFIG", "fontsize", "10"), IniRead("settings.ini", "CONFIG", "fontweight", "400"), IniRead("settings.ini", "CONFIG", "attributes", "0"), IniRead("settings.ini", "CONFIG", "fontname", "Arial"))
	GUICtrlSetColor(-1, IniRead("settings.ini", "CONFIG", "fontcolor", "0x000000"))
	GUICtrlSetBkColor(-1, IniRead("settings.ini", "CONFIG", "bgcolor", "0xFFFFFF"))
	GUISetState()
	GUIRegisterMsg($WM_SIZE, "WM_SIZE")
	While 1
		$Msg = GUIGetMsg()
		Switch $Msg
			Case -3
				If FileRead(IniRead("settings.ini", "CONFIG", "file", "NotFound")) = GUICtrlRead($Edit) Then
					IniDelete("settings.ini", "CONFIG", "file")
					Exit
				Else
					$Confirm = MsgBox(36, "Confirm", "Do You Want To Save Before Exiting?")
					If $Confirm = 6 Then
						If FileExists(IniRead("settings.ini", "CONFIG", "file", "NotFound")) Then
							FileDelete(IniRead("settings.ini", "CONFIG", "file", "NotFound"))
							FileWrite(IniRead("settings.ini", "CONFIG", "file", "NotFound"), GUICtrlRead($Edit))
							Exit
						EndIf
						$SaveDir = FileSaveDialog("Save File", @ScriptDir, "Text Files (*.txt)|Config Files (*.ini)|HTML Files (*.html)|XML Files (*.xml)|Batch Files (*.bat)|All Files (*.*)")
						If Not @error Then
							IniWrite("settings.ini", "CONFIG", "file", $SaveDir)
							FileDelete(IniRead("settings.ini", "CONFIG", "file", "NotFound"))
							FileWrite($SaveDir, GUICtrlRead($Edit))
							IniDelete("settings.ini", "CONFIG", "file")
							Exit
						EndIf
					Else
						IniDelete("settings.ini", "CONFIG", "file")
						Exit
					EndIf
				EndIf
			Case $New
				If GUICtrlRead($Edit) = FileRead(IniRead("settings.ini", "CONFIG", "file", "NotFound")) Then
					GUICtrlSetData($Edit, "")
					IniDelete("settings.ini", "CONFIG", "file")
					GUIDelete()
					Main()
				Else
					$Confirm = MsgBox(36, "Confirm", "Do You Want To Save Before Starting a New File?")
					If $Confirm = 6 Then
						If FileExists(IniRead("settings.ini", "CONFIG", "file", "NotFound")) Then
							FileDelete(IniRead("settings.ini", "CONFIG", "file", "NotFound"))
							FileWrite(IniRead("settings.ini", "CONFIG", "file", "NotFound"), GUICtrlRead($Edit))
							IniDelete("settings.ini", "CONFIG", "file")
							_GUICtrlStatusBar_SetText($StatusBar, "Saving...")
							Sleep(1000)
							_GUICtrlStatusBar_SetText($StatusBar, "File Saved!")
							GUICtrlSetData($Edit, "")
							GUIDelete()
							Main()
						EndIf
						$SaveDir = FileSaveDialog("Save File", @ScriptDir, "Text Files (*.txt)|Config Files (*.ini)|HTML Files (*.html)|XML Files (*.xml)|Batch Files (*.bat)|All Files (*.*)")
						If Not @error Then
							IniWrite("settings.ini", "CONFIG", "file", $SaveDir)
							FileDelete(IniRead("settings.ini", "CONFIG", "file", "NotFound"))
							FileWrite($SaveDir, GUICtrlRead($Edit))
							IniDelete("settings.ini", "CONFIG", "file")
							_GUICtrlStatusBar_SetText($StatusBar, "Saving...")
							Sleep(1000)
							_GUICtrlStatusBar_SetText($StatusBar, "File Saved!")
							GUICtrlSetData($Edit, "")
							GUIDelete()
							Main()
						EndIf
					Else
						GUICtrlSetData($Edit, "")
						IniDelete("settings.ini", "CONFIG", "file")
					EndIf
				EndIf
			Case $Open
				If GUICtrlRead($Edit) = FileRead(IniRead("settings.ini", "CONFIG", "file", "NotFound")) Then
					$File = FileOpenDialog("Choose a Readable File", @ScriptDir, "Text Files (*.txt)|Config Files (*.ini)|HTML Files (*.html)|XML Files (*.xml)|Batch Files (*.bat)|All Files (*.*)")
					If Not @error Then
						IniWrite("settings.ini", "CONFIG", "file", $File)
						GUICtrlSetData($Edit, FileRead($File))
						_GUICtrlStatusBar_SetText($StatusBar, "Current File: " & $File)
					EndIf
				Else
					$Confirm = MsgBox(36, "Confirm", "Do You Want To Save Before Opening a New File?")
					If $Confirm = 6 Then
						If FileExists(IniRead("settings.ini", "CONFIG", "file", "NotFound")) Then
							FileDelete(IniRead("settings.ini", "CONFIG", "file", "NotFound"))
							FileWrite(IniRead("settings.ini", "CONFIG", "file", "NotFound"), GUICtrlRead($Edit))
							IniDelete("settings.ini", "CONFIG", "file")
							_GUICtrlStatusBar_SetText($StatusBar, "Saving...")
							Sleep(1000)
							_GUICtrlStatusBar_SetText($StatusBar, "File Saved!")
							$File = FileOpenDialog("Choose a Readable File", @ScriptDir, "Text Files (*.txt)|Config Files (*.ini)|HTML Files (*.html)|XML Files (*.xml)|Batch Files (*.bat)|All Files (*.*)")
							If Not @error Then
								IniWrite("settings.ini", "CONFIG", "file", $File)
								GUICtrlSetData($Edit, FileRead($File))
								_GUICtrlStatusBar_SetText($StatusBar, "Current File: " & $File)
							EndIf
						Else
							$SaveDir = FileSaveDialog("Save File", @ScriptDir, "Text Files (*.txt)|Config Files (*.ini)|HTML Files (*.html)|XML Files (*.xml)|Batch Files (*.bat)|All Files (*.*)")
							If Not @error Then
								IniWrite("settings.ini", "CONFIG", "file", $SaveDir)
								FileDelete(IniRead("settings.ini", "CONFIG", "file", "NotFound"))
								FileWrite($SaveDir, GUICtrlRead($Edit))
								IniDelete("settings.ini", "CONFIG", "file")
								_GUICtrlStatusBar_SetText($StatusBar, "Saving...")
								Sleep(1000)
								_GUICtrlStatusBar_SetText($StatusBar, "File Saved!")
								Sleep(1000)
								_GUICtrlStatusBar_SetText($StatusBar, "Current File: " & $File)
							EndIf
						EndIf
					Else
						$File = FileOpenDialog("Choose a Readable File", @ScriptDir, "Text Files (*.txt)|Config Files (*.ini)|HTML Files (*.html)|XML Files (*.xml)|Batch Files (*.bat)|All Files (*.*)")
						If Not @error Then
							IniWrite("settings.ini", "CONFIG", "file", $File)
							GUICtrlSetData($Edit, FileRead($File))
							_GUICtrlStatusBar_SetText($StatusBar, "Current File: " & $File)
						EndIf
					EndIf
				EndIf
			Case $BGColor
				$NewBG = _ChooseColor(2)
				If Not @error Then
					IniWrite("settings.ini", "CONFIG", "bgcolor", $NewBG)
					GUICtrlSetBkColor($Edit, IniRead("settings.ini", "CONFIG", "bgcolor", "0xFFFFFF"))
				EndIf
			Case $Font
				$NewFont = _ChooseFont(IniRead("settings.ini", "CONFIG", "fontname", "Arial"), IniRead("settings.ini", "CONFIG", "fontsize", "10"), 0, 400, False, False, False, $Main)
				If Not @error Then
					IniWrite("settings.ini", "CONFIG", "fontsize", $NewFont[3])
					IniWrite("settings.ini", "CONFIG", "attributes", $NewFont[1])
					IniWrite("settings.ini", "CONFIG", "fontweight", $NewFont[4])
					IniWrite("settings.ini", "CONFIG", "fontcolor", $NewFont[7])
					IniWrite("settings.ini", "CONFIG", "fontname", $NewFont[2])
					GUICtrlSetFont($Edit, IniRead("settings.ini", "CONFIG", "fontsize", "10"), IniRead("settings.ini", "CONFIG", "fontweight", "400"), IniRead("settings.ini", "CONFIG", "attributes", "0"), IniRead("settings.ini", "CONFIG", "fontname", "Arial"))
					GUICtrlSetColor($Edit, IniRead("settings.ini", "CONFIG", "fontcolor", "0x000000"))
				EndIf
			Case $SaveAs
				$SaveDir = FileSaveDialog("Save File", @ScriptDir, "Text Files (*.txt)|Config Files (*.ini)|HTML Files (*.html)|XML Files (*.xml)|Batch Files (*.bat)|All Files (*.*)")
				If Not @error Then
					IniWrite("settings.ini", "CONFIG", "file", $SaveDir)
					FileDelete(IniRead("settings.ini", "CONFIG", "file", "NotFound"))
					FileWrite(IniRead("settings.ini", "CONFIG", "file", "NotFound"), GUICtrlRead($Edit))
					GUICtrlSetState($Save, $GUI_ENABLE)
					_GUICtrlStatusBar_SetText($StatusBar, "Saving...")
					Sleep(1000)
					_GUICtrlStatusBar_SetText($StatusBar, "File Saved!")
					Sleep(1000)
					_GUICtrlStatusBar_SetText($StatusBar, "Current File: " & IniRead("settings.ini", "CONFIG", "file", "Waiting..."))
				EndIf
			Case $Save
				If FileExists(IniRead("settings.ini", "CONFIG", "file", "NotFound")) Then
					FileDelete(IniRead("settings.ini", "CONFIG", "file", "NotFound"))
					FileWrite(IniRead("settings.ini", "CONFIG", "file", "NotFound"), GUICtrlRead($Edit))
					_GUICtrlStatusBar_SetText($StatusBar, "Saving...")
					Sleep(1000)
					_GUICtrlStatusBar_SetText($StatusBar, "File Saved!")
					Sleep(1000)
					_GUICtrlStatusBar_SetText($StatusBar, "Current File: " & IniRead("settings.ini", "CONFIG", "file", "Waiting..."))
				Else
					_GUICtrlStatusBar_SetText($StatusBar, "Current File: " & IniRead("settings.ini", "CONFIG", "file", "Waiting..."))
					$SaveDir = FileSaveDialog("Save File", @ScriptDir, "Text Files (*.txt)|Config Files (*.ini)|HTML Files (*.html)|XML Files (*.xml)|Batch Files (*.bat)|All Files (*.*)")
					If Not @error Then
						IniWrite("settings.ini", "CONFIG", "file", $SaveDir)
						FileDelete(IniRead("settings.ini", "CONFIG", "file", "NotFound"))
						FileWrite(IniRead("settings.ini", "CONFIG", "file", "NotFound"), GUICtrlRead($Edit))
						_GUICtrlStatusBar_SetText($StatusBar, "Saving...")
						Sleep(1000)
						_GUICtrlStatusBar_SetText($StatusBar, "File Saved!")
						Sleep(1000)
						_GUICtrlStatusBar_SetText($StatusBar, "Current File: " & IniRead("settings.ini", "CONFIG", "file", "Waiting..."))
					EndIf
				EndIf
			Case $TimeAndDate
				If @WDAY = 1 Then $Day = "Sunday"
				If @WDAY = 2 Then $Day = "Monday"
				If @WDAY = 3 Then $Day = "Tuesday"
				If @WDAY = 4 Then $Day = "Wednesday"
				If @WDAY = 5 Then $Day = "Thursday"
				If @WDAY = 6 Then $Day = "Friday"
				If @WDAY = 7 Then $Day = "Saturday"
				If @HOUR < 12 Then $i = "AM"
				If @HOUR > 12 Then $i = "PM"
				GUICtrlSetData($Edit, $Day & " - " & @MON & "/" & @MDAY & "/" & @YEAR & " - " & @HOUR & ":" & @MIN & " " & $i)
			Case $SpeakText
				Global $Voice = ObjCreate("Sapi.SpVoice")
				SpeakSelectedText(0.5, 100)
			Case $About
				MsgBox(0, "About", "Text Editor Coded in Au3" & @LF & @LF & "Created By ReaperX (C) 2011 - 2012")
			Case $Find
				_GUICtrlEdit_Find($Edit)
			Case $SelectAll
				_GUICtrlEdit_SetSel($Edit, 0, _GUICtrlEdit_GetTextLen($Edit))
			Case $DocInfo
				MsgBox(0, "Information", "Characters: " & _GUICtrlEdit_GetTextLen($Edit) & @LF & "Lines: " & _GUICtrlEdit_GetLineCount($Edit))
			Case $Exit
				If GUICtrlRead($Edit) = FileRead(IniRead("settings.ini", "CONFIG", "file", "NotFound")) Then
					IniDelete("settings.ini", "CONFIG", "file")
					Exit
				Else
					$Confirm = MsgBox(36, "Confirm", "Do You Want To Save Before Exiting?")
					If $Confirm = 6 Then
						If FileExists(IniRead("settings.ini", "CONFIG", "file", "NotFound")) Then
							FileDelete(IniRead("settings.ini", "CONFIG", "file", "NotFound"))
							FileWrite(IniRead("settings.ini", "CONFIG", "file", "NotFound"), GUICtrlRead($Edit))
							Exit
						EndIf
						$SaveDir = FileSaveDialog("Save File", @ScriptDir, "Text Files (*.txt)|Config Files (*.ini)|HTML Files (*.html)|XML Files (*.xml)|Batch Files (*.bat)|All Files (*.*)")
						If Not @error Then
							IniWrite("settings.ini", "CONFIG", "file", $SaveDir)
							FileDelete(IniRead("settings.ini", "CONFIG", "file", "NotFound"))
							FileWrite($SaveDir, GUICtrlRead($Edit))
							IniDelete("settings.ini", "CONFIG", "file")
							Exit
						Else
							IniDelete("settings.ini", "CONFIG", "file")
							Exit
						EndIf
					Else
						IniDelete("settings.ini", "CONFIG", "file")
						Exit
					EndIf
				EndIf
		EndSwitch
	WEnd
EndFunc   ;==>Main
Func SpeakSelectedText($iRate, $iVolume)
	Global $Voice
	Send("^C")
	$iText = ClipGet()
	$Voice.Rate = $iRate
	$Voice.Volume = $iVolume
	$Voice.Speak($iText)
	$iText = ClipPut("")
EndFunc   ;==>SpeakSelectedText

Func WM_SIZE($hWnd, $iMsg, $iwParam, $ilParam)
	Global $StatusBar
	_GUICtrlStatusBar_Resize($StatusBar)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SIZE
