#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=RegistryManager.exe
#AutoIt3Wrapper_Icon=RegistryManager.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=RegistryManager.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.3
#AutoIt3Wrapper_Res_Field=Build|2012.09.24
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#NoTrayIcon
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiTreeView.au3>
#include <GuiImageList.au3>
#include <GuiListView.au3>
#include <GuiStatusBar.au3>
#include <EditConstants.au3>
#include <_RegFunc.au3> ; http://www.autoitscript.com/forum/topic/70108-custom-registry-functions-udf/
; #include <ForRegistryManager.au3>

Opt("GUIOnEventMode", 1)
Opt("GUIResizeMode", 802)

Global $PathCur, $PathClickRight, $Cur_LV_idx = -1, $ErrCount = 0

; En
$LngTitle = 'Registry Manager'
$LngJmp = 'Go'
$LngLVn = 'Name'
$LngLVt = 'Type'
$LngLVv = 'Value'
$LngDft = '(Default)'
$LngTmAs = 'Access time :'
$LngExp = 'Export'
$LngCpP = 'Copy path-key'
$LngSvAs = 'Save as...'
$LngFRe = 'Registry file'
$LngSec = 'sec'
$LngDel = 'Delete'
$LngChg = 'Change'
$LngMS1 = 'Message'
$LngMS2 = 'The type is not supported'
$LngMS3 = 'Do you want to delete'
$LngMS4 = 'Specify the name'
$LngMS5 = 'name already exists'
$LngGT1 = 'Edit String'
$LngGT2 = 'Creating a parameter'
$LngCnl = 'Cancel'
$LngCrt = 'Create'
$LngSCr = 'successfully created'
$LngSDl = 'successfully deleted'
$LngErC = 'Error count'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngJmp = 'Перейти'
	$LngLVn = 'Параметр'
	$LngLVt = 'Тип'
	$LngLVv = 'Значение'
	$LngDft = '(По умолчанию)'
	$LngTmAs = 'Время доступа :'
	$LngExp = 'Экспорт'
	$LngCpP = 'Копировать путь к разделу'
	$LngSvAs = 'Сохранить как ...'
	$LngFRe = 'Файл реестра'
	$LngSec = 'сек'
	$LngDel = 'Удалить'
	$LngChg = 'Изменить'
	$LngMS1 = 'Сообщение'
	$LngMS2 = 'Выбранный тип не поддерживается'
	$LngMS3 = 'Вы хотите удалить'
	$LngMS4 = 'Укажите имя параметра'
	$LngMS5 = 'Параметр уже существует'
	$LngGT1 = 'Изменение строкового параметра'
	$LngGT2 = 'Создание параметра'
	$LngCnl = 'Отмена'
	$LngCrt = 'Создать'
	$LngSCr = 'успешно создан'
	$LngSDl = 'успешно удалён'
	$LngErC = 'Счёт ошибок'
EndIf

$hGui = GUICreate($LngTitle, 640, 560, -1, -1, $WS_OVERLAPPEDWINDOW)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
If Not @Compiled Then GUISetIcon(@ScriptDir & '\RegistryManager.ico')
Local $aParts[3] = [640-210, -1]
$hStatusBar = _GUICtrlStatusBar_Create($hGui, $aParts, '', $SBARS_TOOLTIPS+$SBARS_SIZEGRIP)

$restart = GUICtrlCreateButton("R", 640 - 20, 2, 18, 20)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_Restart")

$Address = GUICtrlCreateInput('', 5, 6, 570, 24)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)
$go = GUICtrlCreateButton(">", 577, 6, 24, 24)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
GUICtrlSetOnEvent(-1, "_JumpRegistry")
GUICtrlSetTip(-1, $LngJmp)

$TreeView = GUICtrlCreateTreeView(0, 35, 216, 500, -1, $WS_EX_CLIENTEDGE)
GUICtrlSetResizing(-1, 2 + 32 + 64 + 256)
$hTreeView = GUICtrlGetHandle($TreeView)

$hImage = _GUIImageList_Create(16, 16, 5, 1)
_GUIImageList_AddIcon($hImage, @SystemDir & '\shell32.dll', -4)
_GUIImageList_AddIcon($hImage, @SystemDir & '\shell32.dll', -5)
_GUIImageList_AddIcon($hImage, @SystemDir & '\shell32.dll', 0)
If @OSBuild < 5000 Then
	_GUIImageList_AddIcon($hImage, @WindowsDir & '\regedit.exe', 7)
	_GUIImageList_AddIcon($hImage, @WindowsDir & '\regedit.exe', 8)
Else
	_GUIImageList_AddIcon($hImage, @WindowsDir & '\regedit.exe', 3)
	_GUIImageList_AddIcon($hImage, @WindowsDir & '\regedit.exe', 4)
EndIf
_GUICtrlTreeView_SetNormalImageList($hTreeView, $hImage)

$RegRoot = StringSplit('HKEY_CLASSES_ROOT,HKEY_CURRENT_USER,HKEY_LOCAL_MACHINE,HKEY_USERS,HKEY_CURRENT_CONFIG', ',')
For $i = 1 To $RegRoot[0]
	$hTmp = _GUICtrlTreeView_Add($hTreeView, 0, $RegRoot[$i], 0, 0)
	_GUICtrlTreeView_SetChildren($hTreeView, $hTmp) ; добавляем плюсик
Next

$ListView = GUICtrlCreateListView($LngLVn & '| ' & $LngLVt & '| ' & $LngLVv, 220, 35, 420, 500, $LVS_SHOWSELALWAYS, BitOR($LVS_EX_INFOTIP, $WS_EX_CLIENTEDGE, $LVS_EX_FULLROWSELECT))
; GUICtrlSendMsg($ListView, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_TRACKSELECT, $LVS_EX_TRACKSELECT)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 64)
GUICtrlSetBkColor(-1, 0xf0f0f0) ; 0xE0DFE3
$hListView = GUICtrlGetHandle($ListView)
_GUICtrlListView_SetColumnWidth($ListView, 0, 200)
_GUICtrlListView_SetColumnWidth($ListView, 1, 90)
_GUICtrlListView_SetColumnWidth($ListView, 2, 240)
_GUICtrlListView_SetImageList($hListView, $hImage, 1)

$ReLbl = GUICtrlCreateLabel('', 216, 35, 5, 500)
GUICtrlSetResizing(-1, 2 + 32 + 64 + 256)
GUICtrlSetCursor(-1, 13)
GUISetOnEvent($GUI_EVENT_PRIMARYDOWN, "_ResizeField")

$ContMenu = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
$hTVMenu = GUICtrlGetHandle($ContMenu)

GUICtrlCreateMenuItem($LngExp, $ContMenu)
GUICtrlSetOnEvent(-1, "_Export")

GUICtrlCreateMenuItem($LngCpP, $ContMenu)
GUICtrlSetOnEvent(-1, "_CopyPathKey")


$ContMenuLV = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
$hLVMenu = GUICtrlGetHandle($ContMenuLV)

GUICtrlCreateMenuItem($LngDel, $ContMenuLV)
GUICtrlSetOnEvent(-1, "_DeleteItem")

GUICtrlCreateMenuItem($LngChg, $ContMenuLV)
GUICtrlSetOnEvent(-1, "_ChangeValue")

GUICtrlCreateMenuItem($LngCrt, $ContMenuLV)
GUICtrlSetOnEvent(-1, "_CreateNameValue")


$ContMenuLV2 = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
$hLVMenu2 = GUICtrlGetHandle($ContMenuLV2)
GUICtrlCreateMenuItem($LngCrt, $ContMenuLV2)
GUICtrlSetOnEvent(-1, "_CreateNameValue")


$iDummy = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_ActionFocus")
$iDelete = GUICtrlCreateDummy()
GUICtrlSetOnEvent(-1, "_DelHK")
Dim $AccelKeys[2][2] = [["{Enter}", $iDummy], ["{Del}", $iDelete]]
GUISetAccelerators($AccelKeys)

GUISetState()
GUIRegisterMsg($WM_NOTIFY, 'WM_NOTIFY')
GUIRegisterMsg($WM_SIZE, "WM_SIZE")
GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")

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
			_JumpRegistry()
		; Case 'SysTreeView321'
			; _Add()
		Case 'SysListView321'
			_Clipboard()
	EndSwitch
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
				$tmp = $aCur_Info[0]
			EndIf
			If Not $aCur_Info[2] Then ExitLoop ; выход если курсор отпущен
		WEnd
	EndIf
EndFunc

Func _CopyPathKey()
	ClipPut($PathClickRight)
EndFunc

Func _DelHK()
	Local $idx = _GUICtrlListView_GetSelectedIndices($hListView)
	If $idx Then
		$Cur_LV_idx = Number($idx)
		_DeleteItem()
	Else
		$ErrCount += 1
		_GUICtrlStatusBar_SetText($hStatusBar, $LngErC & ' ' & $ErrCount)
	EndIf
EndFunc

Func _DeleteItem()
	If $Cur_LV_idx = -1 Then Return
	; MsgBox(0, $Cur_LV_idx, $Cur_LV_idx)
	Local $sText = _GUICtrlListView_GetItemText($hListView, $Cur_LV_idx)
	; MsgBox(0, $sText, $PathCur)
	Local $Value = _RegRead($PathCur, $sText)
	If Not @error And MsgBox(4, $LngMS1, $LngMS3 &@CRLF& _
	'Key = ' & $PathCur &@CRLF& _
	'Name = ' & $sText &@CRLF& _
	'Value = ' & $Value, 0 , $hGui) = 6 Then
		If RegDelete($PathCur, $sText) = 1 And _GUICtrlListView_DeleteItem($hListView, $Cur_LV_idx) Then _GUICtrlStatusBar_SetText($hStatusBar, $sText & ' ' & $LngSDl)
	EndIf
	$Cur_LV_idx = -1
EndFunc

Func _Export()
	$SaveFile = FileSaveDialog($LngSvAs, @DesktopDir, $LngFRe & ' (*.reg)', 24, '', $hGui)
	If @error Then Return
	If StringRight($SaveFile, 4) <> '.reg' Then $SaveFile &= '.reg'
	_RegExport($SaveFile, $PathClickRight)
EndFunc

Func WM_SIZE($hWnd, $iMsg, $iwParam, $ilParam)
    _GUICtrlStatusBar_Resize ($hStatusBar)
	Local $aParts[3] = [BitAND($ilParam, 0xFFFF) - 210, -1]
	_GUICtrlStatusBar_SetParts ($hStatusBar, $aParts)
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SIZE

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $tmp, $aKey

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
						
						$j = 1
						$tmp = ''
						While 1
							$key = RegEnumKey($PathCur, $j)
							If @error Then ExitLoop
							$j += 1
							$tmp &= $key & '|'
						WEnd
						If $tmp Then
							$tmp = StringTrimRight($tmp, 1)
							$aKey = StringSplit($tmp, '|')
							For $i = 1 To $aKey[0]
								_GUICtrlListView_AddItem($hListView, $aKey[$i], 0)
							Next
						Else
							Dim $aKey[1] = [0]
						EndIf
						
						$j = 1
						While 1
							$key = RegEnumVal($PathCur, $j)
							If @error Then ExitLoop
							$j += 1
							_ListView_AddItem($hListView, $key, @extended)
						WEnd
						; авторазмер последней колонки
						GUICtrlSendMsg($ListView, $LVM_SETCOLUMNWIDTH, 2, $LVSCW_AUTOSIZE)
						GUICtrlSendMsg($ListView, $LVM_SETCOLUMNWIDTH, 2, $LVSCW_AUTOSIZE_USEHEADER)
						
						_GUICtrlListView_EndUpdate($hListView)
						
						; $KolChild = _GUICtrlTreeView_GetChildCount($hWndFrom, $hItem)
						
						If _GUICtrlTreeView_GetChildren($hWndFrom, $hItem) And Not _GUICtrlTreeView_ExpandedOnce($hWndFrom, $hItem) Then
							For $i = 1 To $aKey[0]
								$tmp = _GUICtrlTreeView_AddChild($hWndFrom, $hItem, $aKey[$i], 0, 0)
								$key = RegEnumKey($PathCur & '\' & $aKey[$i], 1)
								If Not @error Then _GUICtrlTreeView_SetChildren($hWndFrom, $tmp) ; добавляем плюсик
							Next
						EndIf
						_GUICtrlStatusBar_SetText($hStatusBar, $PathCur)
						_GUICtrlStatusBar_SetTipText($hStatusBar, 0, $PathCur)
						_GUICtrlStatusBar_SetText($hStatusBar, $LngTmAs & ' ' & Round(TimerDiff($timer) / 1000, 2) & ' ' & $LngSec, 2)
					Else
						Return
					EndIf
				Case $NM_RCLICK ; Вызов контекстного меню правой кнопкой мыши
					Local $tMPos = _WinAPI_GetMousePos(True, $hWndFrom) ; координаты относительно элемента
					Local $hItem = _GUICtrlTreeView_HitTestItem($hWndFrom, DllStructGetData($tMPos, 1), DllStructGetData($tMPos, 2)) ; получаем дескриптор пункта
					If $hItem <> -1 And $hItem <> 0x0 Then
						$PathClickRight = _GetPathItem($hWndFrom, $hItem)
						$x = MouseGetPos(0)
						$y = MouseGetPos(1)
						DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hTVMenu, "int", 0, "int", $x, "int", $y, "hwnd", $hGui, "ptr", 0)
					EndIf
			EndSwitch
		Case $hListView
			Switch $iCode
				Case $NM_CLICK
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					$iItem = DllStructGetData($tInfo, 'Index')
					If $iItem > -1 Then
						$tmp = _GUICtrlListView_GetItemText($hListView, $iItem, 2)
						GUICtrlSetData($Address, $tmp)
					EndIf
				Case $NM_DBLCLK
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					$iItem = DllStructGetData($tInfo, 'Index')
					If $iItem > -1 Then
						$tmp = _GUICtrlListView_GetItemText($hListView, $iItem, 2)
						ClipPut($tmp)
					EndIf
				Case $NM_RCLICK ; Вызов контекстного меню правой кнопкой мыши
                    $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					Local $iItem = DllStructGetData($tInfo, "Index")
					$x = MouseGetPos(0)
					$y = MouseGetPos(1)
					$Cur_LV_idx = $iItem
					If $iItem=-1 Then
						DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hLVMenu2, "int", 0, "int", $x, "int", $y, "hwnd", $hGui, "ptr", 0)
					Else
						DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hLVMenu, "int", 0, "int", $x, "int", $y, "hwnd", $hGui, "ptr", 0)
					EndIf
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc

; создать элементы и только тогда развернуть
Func _JumpRegistry()
	Local $aKey, $hItem, $i, $j, $key, $KeyChild, $sKey, $sKey2
	$sKey = GUICtrlRead($Address)
	If StringLeft($sKey, 2)<>'HK' Then
		ClipPut($sKey)
		Return
	EndIf
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
		; If _GUICtrlTreeView_GetChildCount($hTreeView, $hItem) = -1 And _GUICtrlTreeView_GetChildren($hTreeView, $hItem) Then
			$j = 1
			While 1
				$key = RegEnumKey($sKey2, $j)
				If @error Then ExitLoop
				$j += 1
				$KeyChild = _GUICtrlTreeView_AddChild($hTreeView, $hItem, $key, 0, 0)
				RegEnumKey($sKey2 & '\' & $key, 1)
				If Not @error Then _GUICtrlTreeView_SetChildren($hTreeView, $KeyChild) ; добавляем плюсик
			WEnd
		EndIf
		_GUICtrlTreeView_Expand($hTreeView, $hItem) ; разворачивает пункт
    Next
	_GUICtrlTreeView_ClickItem($hTreeView, $hItem, "left", False)
EndFunc

Func _GetPathItem($hTreeView, $hItem)
	Local $sep = Opt("GUIDataSeparatorChar", "\")
	Local $sPath = _GUICtrlTreeView_GetTree($hTreeView, $hItem)
	Opt("GUIDataSeparatorChar", $sep)
	Return $sPath
EndFunc

Func _Clipboard()
	ClipPut(GUICtrlRead($Address))
EndFunc

Func _ChangeValue()
	If $Cur_LV_idx = -1 Then Return
	Local $sName = _GUICtrlListView_GetItemText($hListView, $Cur_LV_idx)
	If $sName = $LngDft Then $sName = ''
; MsgBox(0, '|'&$sName&'|', $Cur_LV_idx)
	Local $Value = _RegRead($PathCur, $sName)
	If Not @error Then
		$extended = @extended
		Switch $extended
			Case 1 ; REG_SZ
				$Value = _Gui_REG_SZ($sName, $Value)
				If Not @error And RegWrite($PathCur, $sName, "REG_SZ", $Value) Then
					_GUICtrlListView_SetItemText($hListView, $Cur_LV_idx, $Value, 2)
				EndIf
			Case 2 ; REG_EXPAND_SZ
				$Value = _Gui_REG_SZ($sName, $Value)
				If Not @error And RegWrite($PathCur, $sName, "REG_EXPAND_SZ", $Value) Then
					_GUICtrlListView_SetItemText($hListView, $Cur_LV_idx, $Value, 2)
				EndIf
			; Case 4 ; REG_DWORD
				; ContinueCase
			; Case 3 ; REG_BINARY
				; ContinueCase
			Case Else
				MsgBox(0, $LngMS1, $LngMS2 & ' - ' & $extended, 0 , $hGui)
				Return
		EndSwitch
	; Else
		; MsgBox(0, '', 'error')
	EndIf
	$Cur_LV_idx = -1
EndFunc

Func _Gui_REG_SZ($sName, $Value)
	Local $iOK, $iCnl, $hGui1, $GP, $iBtnName, $iBtnValue, $tmp, $mode, $error = 1
	$GP = _ChildCoor($hGui, 378, 158)
	GUISetState(@SW_DISABLE, $hGui)
	$mode = Opt("GUIOnEventMode", 0)

	$hGui1 = GUICreate($LngGT1, $GP[2], $GP[3], $GP[0], $GP[1], $WS_CAPTION + $WS_SYSMENU + $WS_POPUP, -1, $hGui)
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\RegistryManager.ico')
	GUICtrlCreateLabel($LngLVn, 9, 11, 201, 15)
	$iBtnName = GUICtrlCreateInput($sName, 9, 32, 360, 23, $ES_READONLY)

	GUICtrlCreateLabel($LngLVv, 9, 66, 242, 15)
	$iBtnValue = GUICtrlCreateInput($Value, 9, 86, 360, 23)

	$iOK = GUICtrlCreateButton('OK', 213, 120, 75, 26)
	GUICtrlSetState(-1, $GUI_DEFBUTTON)
	$iCnl = GUICtrlCreateButton($LngCnl, 294, 120, 75, 26)
	GUISetState(@SW_SHOW, $hGui1)
	While 1
		Switch GUIGetMsg()
			Case $iOK
				$tmp = GUICtrlRead($iBtnValue)
				If Not($Value==$tmp) Then
					$Value=$tmp
					$error = 0
				EndIf
				ContinueCase
			Case -3, $iCnl
				GUISetState(@SW_ENABLE, $hGui)
				GUIDelete($hGui1)
				ExitLoop
		EndSwitch
	WEnd
	Opt("GUIOnEventMode", $mode)
	Return SetError($error, 0, $Value)
EndFunc

Func _CreateNameValue()
	Local $iOK, $iCnl, $hGui1, $GP, $iBtnName, $mode, $iType, $Radio[12][3] = [ _
[0, 'REG_NONE', 0], _
[0, 'REG_SZ', 1], _
[0, 'REG_EXPAND_SZ', 2], _
[0, 'REG_BINARY', 3], _
[0, 'REG_DWORD', 4], _
[0, 'REG_DWORD_BIG_ENDIAN', 5], _
[0, 'REG_LINK', 6], _
[0, 'REG_MULTI_SZ', 7], _
[0, 'REG_RESOURCE_LIST', 8], _
[0, 'REG_FULL_RESOURCE_DESCRIPTOR', 9], _
[0, 'REG_RESOURCE_REQUIREMENTS_LIST', 10], _
[0, 'REG_QWORD', 11]]
	$GP = _ChildCoor($hGui, 378, 380)
	GUISetState(@SW_DISABLE, $hGui)
	$mode = Opt("GUIOnEventMode", 0)

	$hGui1 = GUICreate($LngGT2, $GP[2], $GP[3], $GP[0], $GP[1], $WS_CAPTION + $WS_SYSMENU + $WS_POPUP, -1, $hGui)
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\RegistryManager.ico')
	GUICtrlCreateLabel($LngLVn, 9, 11, 201, 15)
	
	$iBtnName = GUICtrlCreateInput('New #' & _GUICtrlListView_GetItemCount($hListView) +1, 9, 32, 360, 23)

	GUICtrlCreateGroup($LngLVt, 9, 66, 242, 272)
	For $i = 0 To 11
		$Radio[$i][0] = GUICtrlCreateRadio('(' & $i & ') ' & $Radio[$i][1], 20, $i*20+87, -1, 20)
	Next
	GUICtrlCreateGroup("", -99, -99, 1, 1)
	GUICtrlSetState($Radio[1][0], $GUI_CHECKED)

	$iOK = GUICtrlCreateButton('OK', 213, 350, 75, 26)
	GUICtrlSetState(-1, $GUI_DEFBUTTON)
	$iCnl = GUICtrlCreateButton($LngCnl, 294, 350, 75, 26)
	GUISetState(@SW_SHOW, $hGui1)
	While 1
		Switch GUIGetMsg()
			Case $iOK
				$sName = GUICtrlRead($iBtnName)
				If $sName=='' Then
					MsgBox(0, $LngMS1, $LngMS4, 0 , $hGui1)
					ContinueLoop
				EndIf
				For $i = 0 To 11
					If GUICtrlRead($Radio[$i][0]) = $GUI_CHECKED Then
						$iType = $i
						ExitLoop
					EndIf
				Next
				RegRead($PathCur, $sName)
				If @error Then
					If RegWrite($PathCur, $sName, $Radio[$i][1], '') Then
						_ListView_AddItem($hListView, $sName, $iType)
						_GUICtrlStatusBar_SetText($hStatusBar, $sName & ' ' & $LngSCr)
					EndIf
				Else
					MsgBox(0, $LngMS1, $LngMS5, 0 , $hGui1)
					ContinueLoop
				EndIf
				ContinueCase
			Case -3, $iCnl
				GUISetState(@SW_ENABLE, $hGui)
				GUIDelete($hGui1)
				ExitLoop
		EndSwitch
	WEnd
	Opt("GUIOnEventMode", $mode)
EndFunc

Func _ListView_AddItem($hListView, $key, $extended)
	Local $inx, $keyItem, $tmp
	If $key Then
		$keyItem = $key
	Else
		$keyItem = $LngDft
	EndIf
	Switch $extended
		Case 0
			$inx = _GUICtrlListView_AddItem($hListView, $keyItem, 4)
			_GUICtrlListView_AddSubItem($hListView, $inx, 'NONE (0)', 1)
			$tmp = _RegRead($PathCur, $key)
			If Not @error Then _GUICtrlListView_AddSubItem($hListView, $inx, $tmp, 2)
		Case 1
			$inx = _GUICtrlListView_AddItem($hListView, $keyItem, 3)
			_GUICtrlListView_AddSubItem($hListView, $inx, 'SZ (1)', 1)
			$tmp = RegRead($PathCur, $key)
			If Not @error Then _GUICtrlListView_AddSubItem($hListView, $inx, $tmp, 2)
		Case 2
			$inx = _GUICtrlListView_AddItem($hListView, $keyItem, 3)
			_GUICtrlListView_AddSubItem($hListView, $inx, 'EXPAND_SZ (2)', 1)
			$tmp = RegRead($PathCur, $key)
			If Not @error Then _GUICtrlListView_AddSubItem($hListView, $inx, $tmp, 2)
		Case 3
			$inx = _GUICtrlListView_AddItem($hListView, $keyItem, 4)
			_GUICtrlListView_AddSubItem($hListView, $inx, 'BINARY (3)', 1)
			$tmp = RegRead($PathCur, $key)
			If Not @error Then _GUICtrlListView_AddSubItem($hListView, $inx, $tmp, 2)
		Case 4
			$inx = _GUICtrlListView_AddItem($hListView, $keyItem, 4)
			_GUICtrlListView_AddSubItem($hListView, $inx, 'DWORD (4)', 1)
			$tmp = RegRead($PathCur, $key)
			If Not @error Then _GUICtrlListView_AddSubItem($hListView, $inx, $tmp, 2)
		Case 5
			$inx = _GUICtrlListView_AddItem($hListView, $keyItem, 4)
			_GUICtrlListView_AddSubItem($hListView, $inx, 'DWORD_BIG_ENDIAN (5)', 1)
			$tmp = _RegRead($PathCur, $key)
			If Not @error Then _GUICtrlListView_AddSubItem($hListView, $inx, $tmp, 2)
		Case 6
			$inx = _GUICtrlListView_AddItem($hListView, $keyItem, 4)
			_GUICtrlListView_AddSubItem($hListView, $inx, 'LINK (6)', 1)
			$tmp = _RegRead($PathCur, $key)
			If Not @error Then _GUICtrlListView_AddSubItem($hListView, $inx, $tmp, 2)
		Case 7
			$inx = _GUICtrlListView_AddItem($hListView, $keyItem, 3)
			_GUICtrlListView_AddSubItem($hListView, $inx, 'MULTI_SZ (7)', 1)
			$tmp = RegRead($PathCur, $key)
			If Not @error Then _GUICtrlListView_AddSubItem($hListView, $inx, $tmp, 2)
		Case 8
			$inx = _GUICtrlListView_AddItem($hListView, $keyItem, 4)
			_GUICtrlListView_AddSubItem($hListView, $inx, 'RESOURCE_LIST (8)', 1)
			$tmp = _RegRead($PathCur, $key)
			If Not @error Then _GUICtrlListView_AddSubItem($hListView, $inx, $tmp, 2)
		Case 9
			$inx = _GUICtrlListView_AddItem($hListView, $keyItem, 4)
			_GUICtrlListView_AddSubItem($hListView, $inx, 'FULL_RESOURCE_DESCRIPTOR (9)', 1)
			$tmp = _RegRead($PathCur, $key)
			If Not @error Then _GUICtrlListView_AddSubItem($hListView, $inx, $tmp, 2)
		Case 10
			$inx = _GUICtrlListView_AddItem($hListView, $keyItem, 4)
			_GUICtrlListView_AddSubItem($hListView, $inx, 'RESOURCE_REQUIREMENTS_LIST (10)', 1)
			$tmp = _RegRead($PathCur, $key)
			If Not @error Then _GUICtrlListView_AddSubItem($hListView, $inx, $tmp, 2)
		Case 11
			$inx = _GUICtrlListView_AddItem($hListView, $keyItem, 4)
			_GUICtrlListView_AddSubItem($hListView, $inx, 'QWORD (11)', 1)
			$tmp = _RegRead($PathCur, $key)
			If Not @error Then _GUICtrlListView_AddSubItem($hListView, $inx, $tmp, 2)
		Case Else
			$inx = _GUICtrlListView_AddItem($hListView, $keyItem, 2)
			_GUICtrlListView_AddSubItem($hListView, $inx, 'UNKNOWN (-)', 1)
			$tmp = _RegRead($PathCur, $key)
			If Not @error Then _GUICtrlListView_AddSubItem($hListView, $inx, $tmp, 2)
	EndSwitch
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




; вычисление координат дочернего окна
; 1 - дескриптор родительского окна
; 2 - ширина дочернего окна
; 3 - высота дочернего окна
; 4 - тип 0 - по центру, или 0 - к левому верхнему родительского окна
; 5 - отступ от краёв
Func _ChildCoor($Gui, $w, $h, $c = 0, $d = 0)
	Local $aWA = _WinAPI_GetWorkingArea(), _
			$GP = WinGetPos($Gui), _
			$wgcs = WinGetClientSize($Gui)
	Local $dLeft = ($GP[2] - $wgcs[0]) / 2, _
			$dTor = $GP[3] - $wgcs[1] - $dLeft
	If $c = 0 Then
		$GP[0] = $GP[0] + ($GP[2] - $w) / 2 - $dLeft
		$GP[1] = $GP[1] + ($GP[3] - $h - $dLeft - $dTor) / 2
	EndIf
	If $d > ($aWA[2] - $aWA[0] - $w - $dLeft * 2) / 2 Or $d > ($aWA[3] - $aWA[1] - $h - $dLeft + $dTor) / 2 Then $d = 0
	If $GP[0] + $w + $dLeft * 2 + $d > $aWA[2] Then $GP[0] = $aWA[2] - $w - $d - $dLeft * 2
	If $GP[1] + $h + $dLeft + $dTor + $d > $aWA[3] Then $GP[1] = $aWA[3] - $h - $dLeft - $dTor - $d
	If $GP[0] <= $aWA[0] + $d Then $GP[0] = $aWA[0] + $d
	If $GP[1] <= $aWA[1] + $d Then $GP[1] = $aWA[1] + $d
	$GP[2] = $w
	$GP[3] = $h
	Return $GP
EndFunc

Func _WinAPI_GetWorkingArea()
	Local Const $SPI_GETWORKAREA = 48
	Local $stRECT = DllStructCreate("long; long; long; long")

	Local $SPIRet = DllCall("User32.dll", "int", "SystemParametersInfo", "uint", $SPI_GETWORKAREA, "uint", 0, "ptr", DllStructGetPtr($stRECT), "uint", 0)
	If @error Then Return 0
	If $SPIRet[0] = 0 Then Return 0

	Local $sLeftArea = DllStructGetData($stRECT, 1)
	Local $sTopArea = DllStructGetData($stRECT, 2)
	Local $sRightArea = DllStructGetData($stRECT, 3)
	Local $sBottomArea = DllStructGetData($stRECT, 4)

	Local $aRet[4] = [$sLeftArea, $sTopArea, $sRightArea, $sBottomArea]
	Return $aRet
EndFunc

Func _Restart()
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