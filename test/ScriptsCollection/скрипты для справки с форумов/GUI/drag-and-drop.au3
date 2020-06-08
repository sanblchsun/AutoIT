; Пример для перетаскивания одного файла на GUI.
; Источник: http://www.autoitscript.com/forum/topic/149659-alternate-data-streams-viewer/
#include <WindowsConstants.au3>

Global Const $hUSER32 = DllOpen("user32.dll")
Global Const $hSHELL32 = DllOpen("shell32.dll")

; Global Const $WM_DROPFILES = 0x0233 ; в AutoIt3 v3.3.6.1 и ниже эта константа не определена
$sDescription = 'Функция WM_DROPFILES выполняется при перетаскивании объектов на элементы окна' & @CRLF & _
'В отличии от нативного механизма функция не вставляет принудительно путь в элемент Edit'

$hGui = GUICreate('GUI c поддержкой drag-and-drop', 600, 360, -1, -1, -1, $WS_EX_ACCEPTFILES)
$iEdit = GUICtrlCreateEdit($sDescription, 5, 5, 590, 300)
GUISetState()
GUIRegisterMsg($WM_DROPFILES, "WM_DROPFILES")

Do
Until GUIGetMsg() = -3

;======================================================
; Proccessing files dropped onto the GUI
Func WM_DROPFILES($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $lParam
	If $hWnd = $hGUI Then
		$sFile = _DragQueryFile($wParam)
		If @error Or StringInStr(FileGetAttrib($sFile), "D") Then ; Если ошибка или каталог
			_MessageBeep(48)
			Return 1
		EndIf
		_DragFinish($wParam)
        GUICtrlSetData($iEdit, $sFile) ; Если требуется длительная обработка, то сюда не вставлять
		Return 1
	EndIf
	_MessageBeep(48) ; Если в другое окно
	Return 1
EndFunc
;======================================================


;======================================================
; Functions to handle dropped files
Func _DragQueryFile($hDrop, $iIndex = 0)
	Local $aCall = DllCall($hSHELL32, "dword", "DragQueryFileW", _
			"handle", $hDrop, _
			"dword", $iIndex, _
			"wstr", "", _
			"dword", 32767)
	If @error Or Not $aCall[0] Then Return SetError(1, 0, "")
	Return $aCall[3]
EndFunc

Func _DragFinish($hDrop)
	DllCall($hSHELL32, "none", "DragFinish", "handle", $hDrop)
EndFunc

Func _MessageBeep($iType)
	DllCall($hUSER32, "int", "MessageBeep", "dword", $iType)
EndFunc
;======================================================