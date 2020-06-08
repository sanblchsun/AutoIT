#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <ButtonConstants.au3>
#include <Crypt.au3>

Global $ItemIndex, $iInput, $CacheText, $CurrentPath, $sTextAU3, $iChanges = 0, $aVar2D
Global $hGui, $iListView, $hListView, $dummy1, $dummy2, $CurMD5

; En
$LngTitle = 'Renaming variables'
$LngOpn = 'Open'
$LngSv = 'Save'
$LngVar = 'Variable'
$LngCnt = 'Count'
$LngErr = 'Error'
$LngMB1 = 'The number of substitutions does not match'
$LngMB2 = 'Save changes?'
$LngMB3 = 'The text contains invalid characters:'
$LngMB4 = 'Variable with the same name already exists'
$LngMB5 = 'The File was changed by other application.,' & @LF & 'these change can be lost.' & @LF & @LF & 'Save?'

; Ru
If @OSLang = 0419 Then
	$LngAbout = 'О программе'
	$LngOpn = 'Открыть'
	$LngSv = 'Сохранить'
	$LngVar = 'Переменная'
	$LngCnt = 'Количество'
	$LngErr = 'Ошибка'
	$LngMB1 = 'Количество замен не соответствует'
	$LngMB2 = 'Сохранить изменения?'
	$LngMB3 = 'Текст содержит недопустимые символы:'
	$LngMB4 = 'Переменная с таким именем уже существует'
	$LngMB5 = 'С момента открытия скрипт был изменён другим' & @LF & 'приложением, эти изменения будут потеряны.' & @LF & @LF & @TAB & 'Сохранить?'
EndIf

$hGui = GUICreate($LngTitle, 450, 450, -1, -1, $WS_OVERLAPPEDWINDOW, $WS_EX_ACCEPTFILES)

$iInput = GUICtrlCreateInput("", 0, 0, 0, 0)
GUICtrlSetState(-1, $GUI_HIDE)

; $iListView = GUICtrlCreateListView('Var|Count 2', 5, 35, 440, 330, BitOR($GUI_SS_DEFAULT_LISTVIEW, $LVS_REPORT, $LVS_SHOWSELALWAYS))
; $hListView = GUICtrlGetHandle(-1)
_CreateListView()

$iBtnOpen = GUICtrlCreateButton('-', 5, 4, 21, 21, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', 4, 0)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
GUICtrlSetTip(-1, $LngOpn)

$iBtnSave = GUICtrlCreateButton('-', 30, 4, 21, 21, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', 6, 0)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
GUICtrlSetTip(-1, $LngSv)

; $LngRe = 'Перечитать файл'
; $iBtnReOpen = GUICtrlCreateButton('-', 30, 4, 21, 21, $BS_ICON)
; GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', 6, 0)
; GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
; GUICtrlSetTip(-1, $LngRe)

$dummy1 = GUICtrlCreateDummy()
$dummy2 = GUICtrlCreateDummy()
Global $AccelKeys[2][2] = [["{F2}", $dummy1],["{ENTER}", $dummy2]]
GUISetAccelerators($AccelKeys)
GUISetState()
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND") ; для скрытия поля ввода при потере фокуса.
_Crypt_Startup()


If $CmdLine[0] Then _Open($CmdLine[1])

While 1
	Switch GUIGetMsg()
		Case $iBtnSave
			_Save()
		Case $iBtnOpen
			$tmp = FileOpenDialog('', @ScriptDir & "\", "AutoIt Script (*.au3)", 1, '', $hGui)
			If @error Then ContinueLoop
			_Open($tmp)
		Case -13
			_Open(@GUI_DragFile)
		Case $dummy1
			$tmp = _GUICtrlListView_GetSelectedIndices($hListView, True)
			If $tmp[0] > 0 Then _GUICtrlListView_EditItem($hListView, $tmp[1])
		Case $dummy2
			If ControlGetFocus($hGui) = 'Edit1' Then
				_SaveChange()
				GUICtrlSetState($iListView, $GUI_FOCUS)
			EndIf
		Case -3
			If $iChanges Then
				Switch MsgBox(3, $LngTitle, $LngMB2, 0, $hGui)
					Case 6
						_Save()
					Case 2
						ContinueLoop
				EndSwitch
			EndIf
			_Crypt_Shutdown()
			Exit
	EndSwitch
WEnd

Func _Save()
	If Not ($CurrentPath And $iChanges) Then Return
	
	Local $bDigest = _Crypt_HashFile($CurrentPath, $CALG_MD5)
	If @error Then
		$tmpMD5 = 'Error ' & Random()
	Else
		$tmpMD5 = $bDigest
	EndIf
	If $tmpMD5 <> $CurMD5 And MsgBox(4 + 256, $LngErr, @TAB & @TAB & ' ------ MD5 ------' & @LF & 'Old:' & @TAB & $CurMD5 & @LF & 'New:' & @TAB & $tmpMD5 & @LF & @LF & $LngMB5, 0, $hGui) = 7 Then Return
	
	$hFile = FileOpen($CurrentPath, 2)
	FileWrite($hFile, $sTextAU3)
	FileClose($hFile)
	$iChanges = 0

	Local $bDigest = _Crypt_HashFile($CurrentPath, $CALG_MD5) ; обновляем контрольную сумму после сохранения
	If @error Then
		$CurMD5 = 'Error ' & Random()
	Else
		$CurMD5 = $bDigest
	EndIf
EndFunc   ;==>_Save

Func _Open($sFilePath)
	$sTmp = _FO_IsDir($sFilePath)
	If @error Or $sTmp Or StringRight($sFilePath, 4) <> '.au3' Then Return

	$sTextAU3 = FileRead($sFilePath)
	Local $aVar = _GetVar($sTextAU3)
	If @error Then
		$CurrentPath = ''
		$sTextAU3 = ''
		GUICtrlDelete($iListView)
		_CreateListView()
		Return
	EndIf
	$CurrentPath = $sFilePath
	GUICtrlDelete($iListView)
	_CreateListView()
	_GUICtrlListView_BeginUpdate($hListView)
	For $i = 1 To $aVar[0][0]
		GUICtrlCreateListViewItem($aVar[$i][0] & '|' & $aVar[$i][1], $iListView)
	Next
	For $i = 0 To 1
		GUICtrlSendMsg($iListView, $LVM_SETCOLUMNWIDTH, $i, -1)
		GUICtrlSendMsg($iListView, $LVM_SETCOLUMNWIDTH, $i, -2)
	Next
	
	WinSetTitle($hGui, '', $LngTitle & ' (' & StringRegExpReplace($CurrentPath, '^.*\\(.*)$', '\1') & ')')
	
	_GUICtrlListView_EndUpdate($hListView)
	Local $bDigest = _Crypt_HashFile($CurrentPath, $CALG_MD5)
	If @error Then
		$CurMD5 = 'Error ' & Random()
	Else
		$CurMD5 = $bDigest
	EndIf
EndFunc   ;==>_Open

Func _CreateListView()
	$GuiPos = WinGetClientSize($hGui)
	$iListView = GUICtrlCreateListView($LngVar & '|' & $LngCnt, 5, 30, $GuiPos[0] - 10, $GuiPos[1] - 45, BitOR($GUI_SS_DEFAULT_LISTVIEW, $LVS_REPORT, $LVS_SHOWSELALWAYS))
	GUICtrlSetState(-1, $GUI_DROPACCEPTED)
	; GUICtrlSetBkColor(-1, 0xf0f0f0) ; 0xE0DFE3
	GUICtrlSetResizing(-1, 6 + 32 + 64)
	$hListView = GUICtrlGetHandle(-1)
EndFunc   ;==>_CreateListView

Func _GetVar($sText)
	Local $k = 0
	$aNameVar = StringRegExp($sText & @CRLF, '(?<=\$)\w+', 3) ; детектируем переменные в массив
	If @error Then
		$aVar2D = ''
		Return SetError(1)
	Else
		For $i = 0 To UBound($aNameVar) - 1
			Assign($aNameVar[$i] & '/', Eval($aNameVar[$i] & '/') + 1, 1)
			If Eval($aNameVar[$i] & '/') = 1 Then
				$aNameVar[$k] = $aNameVar[$i]
				$k += 1
			EndIf
		Next
		ReDim $aNameVar[$k]

		_ArraySort($aNameVar) ; сортировка массива
		Dim $aVar2D[$k + 1][2] = [[$k]]

		For $i = 0 To $k - 1
			$aVar2D[$i + 1][0] = $aNameVar[$i]
			$aVar2D[$i + 1][1] = Eval($aNameVar[$i] & '/')
		Next

		Return $aVar2D
	EndIf
EndFunc   ;==>_GetVar

; Выводит элемент Input на передний план
Func _GUICtrlListView_EditItem($hWnd, $iIndex)
	;funkey 19.02.2010, Mod AZJIO
	If $iIndex < 0 Then Return
	Local $aPos, $aRect, $x, $y, $w, $h
	$aRect = _GUICtrlListView_GetItemRect($hWnd, $iIndex, 2)
	$aPos = ControlGetPos($hGui, "", $hWnd)
	$x = $aPos[0] + $aRect[0]
	$y = $aPos[1] + $aRect[1]
	$w = $aRect[2] - $aRect[0]
	$h = $aRect[3] - $aRect[1]
	GUICtrlSetPos($iInput, $x - 1, $y + 1, $w + 1, $h + 1)
	$CacheText = _GUICtrlListView_GetItemText($hWnd, $iIndex)
	GUICtrlSetData($iInput, $CacheText)
	GUICtrlSetState($iInput, $GUI_SHOW)
	GUICtrlSetState($iInput, $GUI_FOCUS)
	$ItemIndex = $iIndex
EndFunc   ;==>_GUICtrlListView_EditItem

; Сохранить изменения редактирования пункта
Func _SaveChange()
	Local $sText = GUICtrlRead($iInput)
	GUICtrlSetState($iInput, $GUI_HIDE)
	If StringRegExp($sText, '\W') Then
		MsgBox(0, $LngTitle, $LngMB3 & ' ' & StringRegExpReplace($sText, '\w', ''), 0, $hGui)
	Else
		For $i = 1 To $aVar2D[0][0]
			If $sText = $aVar2D[$i][0] Then
				MsgBox(0, $LngTitle, $LngMB4, 0, $hGui)
				Return
			EndIf
		Next
		_GUICtrlListView_SetItemText($hListView, $ItemIndex, $sText, 0)
		_GUICtrlListView_SetColumnWidth($hListView, 0, -2) ;$LVSCW_AUTOSIZE_USEHEADER
		$sTextAU3 = StringRegExpReplace($sTextAU3, '(?<=\$)' & $CacheText & '(?!\w)', $sText)
		Local $cnt1 = @extended
		Local $cnt2 = _GUICtrlListView_GetItemText($hListView, $ItemIndex, 1)
		If $cnt2 <> $cnt1 Then MsgBox(0, $LngMB1, $cnt1 & ' --> ' & $cnt2, 0, $hGui)
		$iChanges = 1
	EndIf
EndFunc   ;==>_SaveChange

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR
	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	; $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hListView
			Switch $iCode
				Case $NM_DBLCLK ; двойной клик - редактируем пункт ListView
					Local $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					_GUICtrlListView_EditItem($hListView, DllStructGetData($tInfo, "Index"))
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg
	Local $iIDFrom, $iCode
	$iIDFrom = BitAND($iwParam, 0xFFFF) ; младшее слово
	$iCode = BitShift($iwParam, 16) ; старшее слово
	Switch $iIDFrom
		Case $iInput
			Switch $iCode
				Case $EN_KILLFOCUS
					GUICtrlSetState($iInput, $GUI_HIDE)
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

; FileOperations.au3
Func _FO_IsDir($sTmp)
	$sTmp = FileGetAttrib($sTmp)
	Return SetError(@error, 0, StringInStr($sTmp, 'D', 2) > 0)
EndFunc   ;==>_FO_IsDir