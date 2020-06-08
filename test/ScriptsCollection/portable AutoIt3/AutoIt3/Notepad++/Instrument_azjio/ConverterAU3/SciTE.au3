Func SciTE_Start()
	Local $SciTEPgm, $SciTE_hwnd, $SciTEState, $SciteClose
	Local $psWinSearchChildren, $psWinTitleMatchMode
	Local $aReturn[3] ; $SciTE_hwnd, $SciTEState, $SciteClose

	$SciTEPgm = RegRead("HKLM\Software\Microsoft\Windows\Currentversion\App Paths\Scite.Exe", "")

	$psWinSearchChildren = Opt("WinSearchChildren", 1)
	$psWinTitleMatchMode = Opt("WinTitleMatchMode", 4)
	$SciTE_hwnd = WinGetHandle("DirectorExtension") ; get SciTE handle and when not found start SciTE


	If @error Then
		;Start SciTE when not active
		$SciteClose = 1
		; When not found prompt for the SciTE.exe
		If $SciTEPgm = "" Or Not FileExists($SciTEPgm) Then	FileOpenDialog("Couldn't find SciTE.exe... please select it.", @ScriptDir, "SciTE (SciTE.exe)", 1)
		If FileExists($SciTEPgm) Then
			Run($SciTEPgm)
			WinWait("Classname=SciTEWindow")
		Else
			MsgBox(262144, "Cannot Find Scite.exe", "Please start SciTE manually")
			; cannot find SciTE
			Exit
		EndIf
	Else
		$SciteClose = 0
	EndIf
	; Ensure the handle is know also when Scite got started in this script.
	$SciTE_hwnd = WinGetHandle("DirectorExtension")
	; Copy the latest SciTE  properties files to your own SciTE installation
;~ 	SetSciTE_API_files()
	; Jos: Reload SciTE properties without closing SciTE first.
;~ 	SendSciTE_Command(0, $SciTE_hwnd, "reloadproperties:")
	$SciTEState = WinGetState("Classname=SciTEWindow")
	WinSetState("Classname=SciTEWindow", "", @SW_MINIMIZE)
	Opt("WinSearchChildren", $psWinSearchChildren)
	Opt("WinTitleMatchMode", $psWinTitleMatchMode)

	$aReturn[0] = $SciTE_hwnd
	$aReturn[1] = $SciTEState ; WinGetState()
	$aReturn[2] = $SciteClose ; 1 (yes) or 0 (no)
	Return $aReturn
EndFunc

;------------------------------------------------------------------------------
; Set au3.api and au3.keyword.properties to be used by ConvAu3ToHtm
; to generated the right colored examples.
; They are built by "AutoIt Extractor.au3"
;------------------------------------------------------------------------------
Func SetSciTE_API_files()
	Local $AutoItDir = RegRead("HKLM\SOFTWARE\AutoIt v3\AutoIt", "InstallDir")
	If DirCreate($AutoItDir & "\SciTE\Defs\Rest") Then
		FileCopy($AutoItDir & "\SciTE\au3.keywords.properties", $AutoItDir & "\SciTE\Defs\Rest\*.*")
	EndIf

	Local $AU3PROP = IniRead("helpbuilder.ini", "Input", "sciteprop", "ERR")
	FileCopy($AU3PROP & "au3.keywords.properties", $AutoItDir & "\SciTE\*.*", 9)
EndFunc   ;==>SetSciTE_API_files

;------------------------------------------------------------------------------
; Restore au3.api and au3.keyword.properties to be current version
;------------------------------------------------------------------------------
Func RestoreSciTE_API_files()
	Local $AutoItDir = RegRead("HKLM\SOFTWARE\AutoIt v3\AutoIt", "InstallDir")
	FileCopy($AutoItDir & "\SciTE\Defs\Rest\au3.keywords.properties", $AutoItDir & "\SciTE\*.*", 1)
	DirRemove($AutoItDir & "\SciTE\Defs\Rest", 1)
EndFunc   ;==>RestoreSciTE_API_files

; Send commands to Scite's Director interface
Func SendSciTE_Command($My_Hwnd, $SciTE_hwnd, $sCmd)
	Local $WM_COPYDATA = 74
	Local $CmdStruct = DllStructCreate('Char[' & StringLen($sCmd) + 1 & ']')
	;ConsoleWrite('-->' & $sCmd & @lf )
	DllStructSetData($CmdStruct, 1, $sCmd)
	Local $COPYDATA = DllStructCreate('Ptr;DWord;Ptr')
	DllStructSetData($COPYDATA, 1, 1)
	DllStructSetData($COPYDATA, 2, StringLen($sCmd) + 1)
	DllStructSetData($COPYDATA, 3, DllStructGetPtr($CmdStruct))
	DllCall('User32.dll', 'None', 'SendMessage', 'HWnd', $SciTE_hwnd, _
			'Int', $WM_COPYDATA, 'HWnd', $My_Hwnd, _
			'Ptr', DllStructGetPtr($COPYDATA))
EndFunc   ;==>SendSciTE_Command

Func SciTe_Convert($aData, $sFileInput, $sFileOutput) ; $SciTE_hwnd
	Local $SciTE_hwnd = $aData[0]
	SendSciTE_Command(0, $SciTE_hwnd, 'open:' & StringReplace($sFileInput, "\", "\\") & '')
	SendSciTE_Command(0, $SciTE_hwnd, 'exportashtml:' & StringReplace($sFileOutput, "\", "\\"))
	SendSciTE_Command(0, $SciTE_hwnd, 'close:')
EndFunc

Func SciTe_End($aData)
	Local $SciTE_hwnd, $SciTEState, $SciteClose
	$SciTE_hwnd = $aData[0]
	$SciTEState = $aData[1]
	$SciteClose = $aData[2]

; Close SciTE again when it wasn't running initially
	If $SciteClose Then
		SendSciTE_Command(0, $SciTE_hwnd, "quit:")
	Else
		WinSetState("Classname=SciTEWindow", "", $SciTEState)
	EndIf
;~ 	RestoreSciTE_API_files()
EndFunc