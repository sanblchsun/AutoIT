
#include "_FileDialogsEx.au3"

Global Const $CBN_SELCHANGE = 1
Global $__aDialogDef[3]

$__aDialogDef[0] = "Export to"
$__aDialogDef[1] = "Export"
$__aDialogDef[2] = "Cancel"
Global $Type = $ODM_VIEW_THUMBS
$Output = _FileSaveDialogEx("", @WindowsDir & "\Web\Wallpaper", "All Files (*.*)", BitOR($OFN_OVERWRITEPROMPT, $OFN_PATHMUSTEXIST, $OFN_DONTADDTORECENT), "", 0, "_HookProc")

$__aDialogDef[0] = "Save as"
$__aDialogDef[1] = "Save"
$__aDialogDef[2] = "Cancel"
Global $Type = $ODM_VIEW_ICONS
$Output = _FileSaveDialogEx("", @MyDocumentsDir, "Text Files (*.txt)", BitOR($OFN_OVERWRITEPROMPT, $OFN_PATHMUSTEXIST, $OFN_DONTADDTORECENT), "", 0, "_HookProc")

$__aDialogDef[0] = "Open File"
$__aDialogDef[1] = "Open"
$__aDialogDef[2] = "Cancel"
Global $Type = $ODM_VIEW_LIST
$Output = _FileOpenDialogEx("", @MyDocumentsDir, "Text Files (*.txt)", BitOR($OFN_FILEMUSTEXIST, $OFN_PATHMUSTEXIST, $OFN_ALLOWMULTISELECT), "", 0, "_HookProc")

$__aDialogDef[0] = "Import File"
$__aDialogDef[1] = "Import"
$__aDialogDef[2] = "Cancel"
Global $Type = $ODM_VIEW_TILES
$Output = _FileOpenDialogEx("", @MyDocumentsDir, "Text Files (*.txt)", BitOR($OFN_FILEMUSTEXIST, $OFN_PATHMUSTEXIST, $OFN_ALLOWMULTISELECT), "", 0, "_HookProc")

Func _HookProc($hWnd, $Msg, $wParam, $lParam)
	Switch $Msg
		Case $WM_INITDIALOG
			Local $hDlg = _WinAPI_GetParent($hWnd)
			_SendMessage($hDlg, $CDM_SETCONTROLTEXT, $IDOK, $__aDialogDef[1], 0, "int", "wstr")
			_SendMessage($hDlg, $CDM_SETCONTROLTEXT, $IDCANCEL, $__aDialogDef[2], 0, "int", "wstr")
			ControlCommand($hDlg, "", '[CLASS:ComboBox;Instance:3]', "AddString", 'ANSI')
			$aWinSize = WinGetPos($hDlg, "")
			WinMove($hDlg, "", @DesktopWidth / 2 - $aWinSize[2] / 2, @DesktopHeight / 2 - $aWinSize[3] / 2)
			WinSetTitle($hDlg, "", $__aDialogDef[0])
		Case $WM_COMMAND
			Local $hComboEnc = ControlGetHandle($hWnd, "", '[CLASS:ComboBox;Instance:3]')
			Local $iCode = BitShift($wParam, 16)
			If $lParam = $hComboEnc And $iCode = $CBN_SELCHANGE Then
				$sEncoding = ControlCommand($hWnd, "", '[CLASS:ComboBox;Instance:3]', "GetCurrentSelection", "")
			EndIf
			ConsoleWrite($sEncoding & @CRLF)
		Case $WM_NOTIFY
			Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR
			$tNMHDR = DllStructCreate("hwnd hWndFrom;int idFrom;int code", $lParam)
			$hWndFrom = DllStructGetData($tNMHDR, "hWndFrom")
			$iIDFrom = DllStructGetData($tNMHDR, "idFrom")
			$iCode = DllStructGetData($tNMHDR, "code")
			Switch $iCode
				Case $CDN_INITDONE
				Case $CDN_FOLDERCHANGE
					Local $aRet = DllCall('user32.dll', 'hwnd', 'FindWindowEx', 'hwnd', $hWndFrom, 'hwnd', 0, 'str', "SHELLDLL_DefView", 'str', "")
					If $aRet[0] = 0 Then
						ConsoleWrite("_FindWindowEx Error")
					Else
						DllCall('user32.dll', 'int', 'SendMessage', 'hwnd', $aRet[0], 'uint', $WM_COMMAND, 'wparam', $Type, 'lparam', 0)
					EndIf
			EndSwitch
	EndSwitch
EndFunc   ;==>_HookProc