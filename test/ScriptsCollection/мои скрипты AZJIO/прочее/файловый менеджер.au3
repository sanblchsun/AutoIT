#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=File_manager.exe
#AutoIt3Wrapper_Icon=File_manager.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=File_manager.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.2
#AutoIt3Wrapper_Res_Field=Build|2012.09.21
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <GUIConstantsEx.au3>
#include <GuiTreeView.au3>
#include <WindowsConstants.au3>
#include <GuiImageList.au3>
#include <File.au3>
#include <GuiListView.au3>
#include <GuiStatusBar.au3>
; #Include <Array.au3> ; тест

Opt("GUIOnEventMode", 1)

Global $PathCur, $TrWM_NOTIFY = 0

; En
$LngTitle = 'File manager'
$LngJmp = 'Go'
$LngTmAs = 'Access time :'
$LngSec = 'sec'
; $LngCpP = 'Copy path'
; $LngDel = 'Delete'

$UserIntLang = @OSLang

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	$LngTitle = 'Файловый менеджер'
	$LngJmp = 'Перейти'
	$LngTmAs = 'Время доступа :'
	$LngSec = 'сек'
	; $LngCpP = 'Копировать путь'
	; $LngDel = 'Удалить'
EndIf

$hGui = GUICreate($LngTitle, 640, 560, -1, -1, $WS_OVERLAPPEDWINDOW)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
Local $aParts[3] = [640 - 210, -1]
$hStatusBar = _GUICtrlStatusBar_Create($hGui, $aParts, '', $SBARS_TOOLTIPS + $SBARS_SIZEGRIP)

$restart = GUICtrlCreateButton("R", 640 - 20, 2, 18, 20)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_restart")

$Address = GUICtrlCreateInput('', 5, 6, 570, 24)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)
$go = GUICtrlCreateButton(">", 577, 6, 24, 24)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
GUICtrlSetOnEvent(-1, "_Jump")
GUICtrlSetTip(-1, $LngJmp)

$TreeView = GUICtrlCreateTreeView(0, 35, 216, 500, -1, $WS_EX_CLIENTEDGE)
GUICtrlSetResizing(-1, 2 + 32 + 64 + 256)
$hTreeView = GUICtrlGetHandle($TreeView)

$hImage = _GUIImageList_Create(16, 16, 5, 1)
_GUIImageList_AddIcon($hImage, @SystemDir & '\shell32.dll', -4)
_GUIImageList_AddIcon($hImage, @SystemDir & '\shell32.dll', -5)
_GUIImageList_AddIcon($hImage, @SystemDir & '\shell32.dll', 0)
_GUICtrlTreeView_SetNormalImageList($hTreeView, $hImage)

$E = ''
$i = 1
While 1
	$i += 1
	$sExt = RegEnumKey("HKCR", $i)
	If @error Or StringLeft($sExt, 1) <> '.' Then ExitLoop
	$ico1 = _FileDefaultIcon($sExt)
	If Not @error Then
		Switch UBound($ico1)
			Case 2
				If StringInStr(';.exe;.scr;.ico;.ani;.cur;', ';' & $sExt & ';') Then
					ContinueLoop
				Else
					_GUIImageList_AddIcon($hImage, $ico1[1], 0)
					If @error Then ContinueLoop
				EndIf
			Case 3
				_GUIImageList_AddIcon($hImage, $ico1[1], $ico1[2])
				If @error Then ContinueLoop
		EndSwitch
		$E &= '|' & $sExt
	EndIf
WEnd
$E = StringTrimLeft($E, 1)
$aE = StringSplit($E, '|')

$DrivesArr = DriveGetDrive("all")
For $i = 1 To $DrivesArr[0]
	If $DrivesArr[$i] = 'a:' Or DriveGetType($DrivesArr[$i] & '\') = 'CDROM' Then ContinueLoop
	$hTmp = _GUICtrlTreeView_Add($hTreeView, 0, StringUpper($DrivesArr[$i]), 0, 0)
	_GUICtrlTreeView_SetChildren($hTreeView, $hTmp) ; добавляем плюсик
Next

$ListView = GUICtrlCreateListView(' ', 220, 35, 420, 500, $LVS_NOCOLUMNHEADER + $LVS_SHOWSELALWAYS, BitOR($LVS_EX_INFOTIP, $WS_EX_CLIENTEDGE, $LVS_EX_FULLROWSELECT))
; GUICtrlSendMsg($ListView, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_TRACKSELECT, $LVS_EX_TRACKSELECT)
GUICtrlSetBkColor(-1, 0xf0f0f0) ; 0xE0DFE3
GUICtrlSetResizing(-1, 2 + 4 + 32 + 64)
$hListView = GUICtrlGetHandle($ListView)
_GUICtrlListView_SetColumnWidth($ListView, 0, 390)
_GUICtrlListView_SetImageList($hListView, $hImage, 1)

$ReLbl = GUICtrlCreateLabel('', 216, 35, 5, 500)
GUICtrlSetResizing(-1, 2 + 32 + 64 + 256)
GUICtrlSetCursor(-1, 13)
GUISetOnEvent($GUI_EVENT_PRIMARYDOWN, "_ResizeField")

$iDummy = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_ActionFocus")
Dim $AccelKeys[1][2] = [["{Enter}", $iDummy]]
GUISetAccelerators($AccelKeys)

; GUICtrlSetOnEvent(-1, "_OpenExplorer")
GUISetState()
GUIRegisterMsg($WM_NOTIFY, 'WM_NOTIFY')
GUIRegisterMsg($WM_SIZE, "WM_SIZE")
GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")

; перейти к нужной папке
; $StartPath='C:\AutoIt3\Notepad++'
; GUICtrlSetData($Address, $StartPath)
; _Jump()

While 1
	Sleep(100000)
WEnd

Func _Exit()
	Exit
EndFunc

Func _ActionFocus()
	; MsgBox(0, '', ControlGetFocus($hGui))
	Switch ControlGetFocus($hGui)
		Case 'Edit1'
			_Jump()
			; Case 'SysTreeView321'
			; _Add()
			; Case 'SysListView321'
			; _Clipboard()
	EndSwitch
EndFunc

Func _Jump()
	Local $aKey, $hItem, $i, $j, $key, $KeyChild, $sKey, $sKey2
	$sKey = GUICtrlRead($Address)
	If Not FileExists($sKey) Then Return
	$aKey = StringSplit($sKey, '\')
	$sKey = $aKey[1]
	$sKey2 = $aKey[1]

	For $i = 1 To $aKey[0]
		If $i > 1 Then
			$sKey &= '|' & $aKey[$i]
			$sKey2 &= '\' & $aKey[$i]
		EndIf
		
		ControlTreeView($hGui, "", $hTreeView, "Select", $sKey) ; выделяет раздел
		If @error Then
			If $i = 1 Then
				Return
			Else
				ExitLoop
			EndIf
		EndIf
		$hItem = _GUICtrlTreeView_GetSelection($hTreeView) ; получает дескриптор

		If _GUICtrlTreeView_GetChildren($hTreeView, $hItem) And Not _GUICtrlTreeView_ExpandedOnce($hTreeView, $hItem) Then
			$tmp = _FileListToArray($sKey2, "*", 2)
			If @error Then Return
			For $j = 1 To $tmp[0]
				$tmp1 = _GUICtrlTreeView_AddChild($hTreeView, $hItem, $tmp[$j], 0, 0)
				$search = FileFindFirstFile($sKey2 & '\' & $tmp[$j] & '\*')
				If $search <> -1 Then
					While 1
						$file = FileFindNextFile($search)
						If @error Then ExitLoop
						If @extended Then
							_GUICtrlTreeView_SetChildren($hTreeView, $tmp1) ; добавляем плюсик
							ExitLoop
						EndIf
					WEnd
				EndIf
				$tmp1 = ''
				FileClose($search)
			Next
		EndIf
		_GUICtrlTreeView_Expand($hTreeView, $hItem) ; разворачивает пункт
	Next
	_GUICtrlTreeView_ClickItem($hTreeView, $hItem, "left", False)
EndFunc

Func WM_SIZE($hWnd, $iMsg, $iwParam, $ilParam)
	_GUICtrlStatusBar_Resize($hStatusBar)
	Local $aParts[3] = [BitAND($ilParam, 0xFFFF) - 210, -1]
	_GUICtrlStatusBar_SetParts($hStatusBar, $aParts)
	Return $GUI_RUNDEFMSG
EndFunc

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $tmp, $TrWM_NOTIFY = 1

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hTreeView
			Switch $iCode
				Case $NM_CLICK
					; получение хэндла кликнутого пункта и поиск его в массиве
					Local $tMPos = _WinAPI_GetMousePos(True, $hWndFrom), $tHit = _GUICtrlTreeView_HitTestEx($hWndFrom, DllStructGetData($tMPos, 1), DllStructGetData($tMPos, 2))
					Local $hItem = DllStructGetData($tHit, "Item")
					If $hItem <> -1 And $hItem <> 0x0 Then
						$tmp = _GetPathItem($hWndFrom, $hItem)
						If $PathCur = $tmp Then
							Return
						Else
							$PathCur = $tmp
						EndIf
						GUICtrlSetData($Address, $PathCur)
						
						_GUICtrlListView_BeginUpdate($hListView)
						_GUICtrlListView_DeleteAllItems($hListView)
						$timer = TimerInit()
						
						$tmp = _FileListToArray($PathCur, "*", 2)
						If Not @error Then
							For $i = 1 To $tmp[0]
								; GUICtrlCreateListViewItem($tmp[$i],$ListView)
								_GUICtrlListView_AddItem($hListView, $tmp[$i], 0)
							Next
						EndIf
						$tmp = _FileListToArray($PathCur, "*", 1)
						If Not @error Then
							For $i = 1 To $tmp[0]
								; GUICtrlCreateListViewItem($tmp[$i],$ListView)
								$tmp3 = StringRegExpReplace($tmp[$i], '.*(\.\S+)', '\1')
								$ind = _ArraySearch($aE, $tmp3)
								If @error Then $ind = 0
								_GUICtrlListView_AddItem($hListView, $tmp[$i], $ind + 2)
							Next
						EndIf
						_GUICtrlListView_EndUpdate($hListView)
						
						If _GUICtrlTreeView_GetChildren($hWndFrom, $hItem) And Not _GUICtrlTreeView_ExpandedOnce($hWndFrom, $hItem) Then
							$tmp = _FileListToArray($PathCur, "*", 2)
							If @error Then Return
							; _GUICtrlTreeView_BeginUpdate($hWndFrom)
							For $i = 1 To $tmp[0]
								$tmp1 = _GUICtrlTreeView_AddChild($hTreeView, $hItem, $tmp[$i], 0, 0)
								$search = FileFindFirstFile($PathCur & '\' & $tmp[$i] & '\*')
								If $search <> -1 Then
									While 1
										$file = FileFindNextFile($search)
										If @error Then ExitLoop
										If @extended Then
											_GUICtrlTreeView_SetChildren($hWndFrom, $tmp1) ; добавляем плюсик
											ExitLoop
										EndIf
									WEnd
								EndIf
								$tmp1 = ''
								FileClose($search)
							Next
							; _GUICtrlTreeView_EndUpdate($hWndFrom)
						EndIf
						_GUICtrlStatusBar_SetText($hStatusBar, $PathCur)
						_GUICtrlStatusBar_SetTipText($hStatusBar, 0, $PathCur)
						_GUICtrlStatusBar_SetText($hStatusBar, $LngTmAs & ' ' & Round(TimerDiff($timer) / 1000, 2) & ' ' & $LngSec, 2)
					Else
						Return
					EndIf
					GUICtrlSendMsg($ListView, $LVM_SETCOLUMNWIDTH, 0, $LVSCW_AUTOSIZE)
					GUICtrlSendMsg($ListView, $LVM_SETCOLUMNWIDTH, 0, $LVSCW_AUTOSIZE_USEHEADER)
					; Case $TVN_SINGLEEXPAND
					; MsgBox(0, 'Message', '---')

					; Case $NM_RCLICK
					; Local $tMPos = _WinAPI_GetMousePos(True, $hWndFrom), $tHit = _GUICtrlTreeView_HitTestEx($hWndFrom, DllStructGetData($tMPos, 1), DllStructGetData($tMPos, 2))
					; Local $hItem = DllStructGetData($tHit, "Item")
					; If $hItem <> -1 And $hItem<>0x0 Then
					; MsgBox(0, 'Message', '---')
					; $x = MouseGetPos(0)
					; $y = MouseGetPos(1)
					; DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $hGui, "ptr", 0)
					; Else
					; Return
					; EndIf
			EndSwitch
		Case $hListView
			Switch $iCode
				Case $NM_DBLCLK
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					$iItem = DllStructGetData($tInfo, 'Index')
					If $iItem > -1 Then
						$tmp = $PathCur & '\' & _GUICtrlListView_GetItemText($hListView, $iItem)
						If FileExists($tmp) Then ShellExecute('"' & $tmp & '"')
					EndIf
			EndSwitch
	EndSwitch
	$TrWM_NOTIFY = 0
	Return $GUI_RUNDEFMSG
EndFunc

Func _CreateItem($hWndFrom, $h, $Path)
	$text = _GUICtrlTreeView_GetText($hWndFrom, $h)
	$tmp = _FileListToArray($Path & '\' & $text, "*", 2)
	If @error Then Return
	For $i = 1 To $tmp[0]
		_GUICtrlTreeView_AddChild($hTreeView, $h, $tmp[$i], 0, 0)
	Next
EndFunc

Func _GetPathItem($hTreeView, $hItem)
	Local $sep = Opt("GUIDataSeparatorChar", "\")
	Local $sPath = _GUICtrlTreeView_GetTree($hTreeView, $hItem)
	Opt("GUIDataSeparatorChar", $sep)
	Return $sPath
EndFunc

Func _restart()
	Local $sAutoIt_File = @TempDir & "\~Au3_ScriptRestart_TempFile.au3"
	Local $sRunLine, $sScript_Content, $hFile

	$sRunLine = @ScriptFullPath
	If Not @Compiled Then $sRunLine = @AutoItExe & ' /AutoIt3ExecuteScript ""' & $sRunLine & '""'
	If $CmdLine[0] > 0 Then $sRunLine &= ' ' & $CmdLineRaw

	$sScript_Content &= '#NoTrayIcon' & @CRLF & _
			'While ProcessExists(' & @AutoItPID & ')' & @CRLF & _
			'   Sleep(10)' & @CRLF & _
			'WEnd' & @CRLF & _
			'Run("' & $sRunLine & '")' & @CRLF & _
			'FileDelete(@ScriptFullPath)' & @CRLF

	$hFile = FileOpen($sAutoIt_File, 2)
	FileWrite($hFile, $sScript_Content)
	FileClose($hFile)

	Run(@AutoItExe & ' /AutoIt3ExecuteScript "' & $sAutoIt_File & '"', @ScriptDir, @SW_HIDE)
	Sleep(1000)
	Exit
EndFunc

Func _FileDefaultIcon($sExt)
	If $sExt = '' Or StringInStr($sExt, ':') Then Return SetError(1)

	Local $aCall = DllCall("shlwapi.dll", "int", "AssocQueryStringW", _
			"dword", 0x00000040, _ ;$ASSOCF_VERIFY
			"dword", 15, _ ;$ASSOCSTR_DEFAULTICON
			"wstr", $sExt, _
			"ptr", 0, _
			"wstr", "", _
			"dword*", 65536)

	If @error Then Return SetError(1, 0, "")

	If Not $aCall[0] Then
		$sExt = StringReplace($aCall[5], '"', '')
		$sExt = StringSplit($sExt, ',')
		Opt('ExpandEnvStrings', 1)
		$sExt[1] = $sExt[1]
		Opt('ExpandEnvStrings', 0)
		Return SetError(0, 0, $sExt)
	ElseIf $aCall[0] = 0x80070002 Then
		Return SetError(1, 0, "{unknown}")
	ElseIf $aCall[0] = 0x80004005 Then
		Return SetError(1, 0, "{fail}")
	Else
		Return SetError(2, $aCall[0], "")
	EndIf

EndFunc

Func _ResizeField()
	Local $aClientSize, $aCur_Info, $aID_Pos, $dX, $tmp
	$aCur_Info = GUIGetCursorInfo($hGui)
	If $aCur_Info[4]=$ReLbl Then
		$aID_Pos = ControlGetPos($hGui, '', $ReLbl)
		$aClientSize = WinGetClientSize($hGui)
		$aClientSize[1] -=60

		; высчитываем разницу координат
		$dX= $aID_Pos[0]-$aCur_Info[0]
		While 1
			Sleep(10)
			$aCur_Info = GUIGetCursorInfo($hGui) ; получаем новую инфу
			$aCur_Info[0]+=$dX
		   
			If Not($aCur_Info[0]<60 Or $aClientSize[0]-$aCur_Info[0]<60 Or $tmp = $aCur_Info[0]) Then
				GUICtrlSetPos($ReLbl, $aCur_Info[0], 35) ; устанавливаем новые координаты
				GUICtrlSetPos($TreeView, 0, 35, $aCur_Info[0], $aClientSize[1])
				GUICtrlSetPos($ListView, $aCur_Info[0]+4, 35, $aClientSize[0]-$aCur_Info[0]-4, $aClientSize[1])
				If Not $aCur_Info[2] Then ExitLoop ; выход если курсор отпущен
				$tmp = $aCur_Info[0]
			EndIf
		WEnd
	EndIf
EndFunc

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	If $hWnd = $hGui Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 350)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 250)
	EndIf
EndFunc