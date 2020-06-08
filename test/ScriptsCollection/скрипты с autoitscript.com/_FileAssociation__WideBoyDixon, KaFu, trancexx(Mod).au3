; http://www.autoitscript.com/forum/topic/96988-winapi-findexecutable-replacement/page__view__findpost__p__697477

Global Const $ASSOCF_INIT_NOREMAPCLSID = 0x00000001
Global Const $ASSOCF_INIT_BYEXENAME = 0x00000002
Global Const $ASSOCF_OPEN_BYEXENAME = 0x00000002
Global Const $ASSOCF_INIT_DEFAULTTOSTAR = 0x00000004
Global Const $ASSOCF_INIT_DEFAULTTOFOLDER = 0x00000008
Global Const $ASSOCF_NOUSERSETTINGS = 0x00000010
Global Const $ASSOCF_NOTRUNCATE = 0x00000020
Global Const $ASSOCF_VERIFY = 0x00000040
Global Const $ASSOCF_REMAPRUNDLL = 0x00000080
Global Const $ASSOCF_NOFIXUPS = 0x00000100
Global Const $ASSOCF_IGNOREBASECLASS = 0x00000200

Global Const $ASSOCSTR_COMMAND = 1
Global Const $ASSOCSTR_EXECUTABLE = 2
Global Const $ASSOCSTR_FRIENDLYDOCNAME = 3
Global Const $ASSOCSTR_FRIENDLYAPPNAME = 4
Global Const $ASSOCSTR_NOOPEN = 5
Global Const $ASSOCSTR_SHELLNEWVALUE = 6
Global Const $ASSOCSTR_DDECOMMAND = 7
Global Const $ASSOCSTR_DDEIFEXEC = 8
Global Const $ASSOCSTR_DDEAPPLICATION = 9
Global Const $ASSOCSTR_DDETOPI = 10



Func _FileAssociation($sExt)

    Local $aCall = DllCall("shlwapi.dll", "int", "AssocQueryStringW", _
            "dword", $ASSOCF_VERIFY, _
            "dword", $ASSOCSTR_EXECUTABLE, _
            "wstr", $sExt, _
            "ptr", 0, _
            "wstr", "", _
            "dword*", 65536)

    If @error Then
        Return SetError(1, 0, ""); call failed
    EndIf

    If Not $aCall[0] Then
        Return SetError(0, 0, $aCall[5])
    ElseIf $aCall[0] = 0x80070002 Then
        Return SetError(0, 0, "{unknown}"); COM Error 0x80070002, ?The system cannot find the file specified.'
    ElseIf $aCall[0] = 0x80004005 Then
        Return SetError(0, 0, "{fail}"); E_FAIL
    Else
        Return SetError(2, $aCall[0], ""); dammit!!!
    EndIf

EndFunc  ;==>_FileAssociation



; =========================================================================================
; Example #2
; =========================================================================================

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>

Local $listview, $button, $item1, $item2, $item3, $input1, $msg

GUICreate("_WinAPI_FindExecutable Example", 600, 400)

$hListView = GUICtrlCreateListView("Extension|Executable", 0, 0, 600, 400);,$LVS_SORTDESCENDING)

$i = 0
$bFirstFound = False; needed because the first entry on my system ist !ut_auto_file
While 1
    $i += 1
    $var = RegEnumKey("HKEY_CLASSES_ROOT", $i)
    If @error <> 0 Then ExitLoop
    If $bFirstFound = False Then
        If StringLeft($var, 1) = "." Then $bFirstFound = True
    ElseIf StringLeft($var, 1) <> "." Then
        ExitLoop
    EndIf
    If StringLeft($var, 1) = "." Then GUICtrlCreateListViewItem($var & "|" & _FileAssociation($var), $hListView)
WEnd

_GUICtrlListView_SetColumnWidth($hListView, 0, $LVSCW_AUTOSIZE)
_GUICtrlListView_SetColumnWidth($hListView, 1, $LVSCW_AUTOSIZE)

GUISetState()

Do
    $msg = GUIGetMsg()

Until $msg = $GUI_EVENT_CLOSE