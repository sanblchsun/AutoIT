#include "_FileDialogsEx.au3"

Global Const $CBN_SELCHANGE = 1
Global $__aDialogDef[3]

$__aDialogDef[0] = "Export to"
$__aDialogDef[1] = "Export"
$__aDialogDef[2] = "Cancel"
$Output = _FileSaveDialogEx("", @MyDocumentsDir, "Text Files (*.txt)", BitOR($OFN_OVERWRITEPROMPT, $OFN_PATHMUSTEXIST, $OFN_DONTADDTORECENT), "", 0, "_FileSave_HookProc")

$__aDialogDef[0] = "Save as"
$__aDialogDef[1] = "Save"
$__aDialogDef[2] = "Cancel"
$Output = _FileSaveDialogEx("", @MyDocumentsDir, "Text Files (*.txt)", BitOR($OFN_OVERWRITEPROMPT, $OFN_PATHMUSTEXIST, $OFN_DONTADDTORECENT), "", 0, "_FileSave_HookProc")

$__aDialogDef[0] = "Open File"
$__aDialogDef[1] = "Open"
$__aDialogDef[2] = "Cancel"
$Output = _FileOpenDialogEx("", @MyDocumentsDir, "Text Files (*.txt)", BitOR($OFN_FILEMUSTEXIST, $OFN_PATHMUSTEXIST, $OFN_ALLOWMULTISELECT), "", 0, "_FileSave_HookProc")

$__aDialogDef[0] = "Import File"
$__aDialogDef[1] = "Import"
$__aDialogDef[2] = "Cancel"
$Output = _FileOpenDialogEx("", @MyDocumentsDir, "Text Files (*.txt)", BitOR($OFN_FILEMUSTEXIST, $OFN_PATHMUSTEXIST, $OFN_ALLOWMULTISELECT), "", 0, "_FileSave_HookProc")

Func _FileSave_HookProc($hWnd, $Msg, $wParam, $lParam)
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

    EndSwitch
EndFunc   ;==>_FileSave_HookProc