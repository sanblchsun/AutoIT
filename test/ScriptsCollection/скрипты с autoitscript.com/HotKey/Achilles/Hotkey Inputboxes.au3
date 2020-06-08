#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

HotKeySet('{CAPSLOCK}', '_ExcludeHotkey') 
HotKeySEt('{NUMLOCK}', '_ExcludeHotkey')

Global Const $HKM_SETHOTKEY = $WM_USER + 1
Global Const $HKM_GETHOTKEY = $WM_USER + 2
Global Const $HKM_SETRULES = $WM_USER + 3

Global Const $HOTKEYF_ALT = 0x04
Global Const $HOTKEYF_CONTROL = 0x02
Global Const $HOTKEYF_EXT = 0x80; Extended key
Global Const $HOTKEYF_SHIFT = 0x01

; invalid key combinations
Global Const $HKCOMB_A = 0x8; ALT
Global Const $HKCOMB_C = 0x4; CTRL
Global Const $HKCOMB_CA = 0x40; CTRL+ALT
Global Const $HKCOMB_NONE = 0x1; Unmodified keys
Global Const $HKCOMB_S = 0x2; SHIFT
Global Const $HKCOMB_SA = 0x20; SHIFT+ALT
Global Const $HKCOMB_SC = 0x10; SHIFT+CTRL
Global Const $HKCOMB_SCA = 0x80; SHIFT+CTRL+ALT


$gui_Main = GUICreate('Get Hotkey', 220, 90)

$bt = GUICtrlCreateButton('See Value', 10, 50, 200, 30);
    GUICtrlSetState(-1, $GUI_DEFBUTTON)

$hWnd = _WinAPI_CreateWindowEx (0, 'msctls_hotkey32', '', BitOR($WS_CHILD, $WS_VISIBLE), 10, 10, 200, 25, $gui_Main)

_SendMessage($hWnd, $HKM_SETRULES, _
BitOR($HKCOMB_NONE, $HKCOMB_S), _                   ; invalid key combinations
BitOR(BitShift($HOTKEYF_ALT, -16), BitAND(0, 0xFFFF))); add ALT to invalid entries

GUISetState()

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            ExitLoop
        Case $bt
            $i_HotKey = _SendMessage($hWnd, $HKM_GETHOTKEY)
            $n_Flag = BitShift($i_HotKey, 8); high byte
            $i_HotKey = BitAND($i_HotKey, 0xFF); low byte
            $sz_Flag = ""
            If BitAND($n_Flag, $HOTKEYF_SHIFT) Then $sz_Flag = "SHIFT + "
            If BitAND($n_Flag, $HOTKEYF_CONTROL) Then $sz_Flag = $sz_Flag & " CTRL + "
            If BitAND($n_Flag, $HOTKEYF_ALT) Then $sz_Flag = $sz_Flag & " ALT + "
            Msgbox(0, $sz_Flag & Chr($i_Hotkey), 'Chr(' & $i_HotKey & ') = ' & Chr($i_Hotkey) & @CRLF & @CRLF & _GetCode($sz_Flag & Chr($i_Hotkey)))
            If $i_HotKey = 20 or $i_HotKey = 144 then
                _SendMessage($hWnd, $HKM_SETHOTKEY)
            EndIf
    EndSwitch
WEnd
_WinAPI_DestroyWindow ($hWnd)

Exit

Func _GetCode($string)
    $temp = StringSplit($string, '+')
    
    $lastTerm = StringLower(StringStripWS($temp[Ubound($temp) - 1], 8))

    If StringLen($lastTerm) > 1 then
        If StringLeft($lastTerm, 1) = 'F' then
            $append = '{' & StringUpper($lastTerm) & '}'
        EndIf
    Else
        $temp = StringLower(StringRight($string, 1))
        If $temp = '!' then
            $append = '{PGUP}'
        ElseIf $temp = '"' then
            $append = '{PGDN}'
        ElseIf $temp = '$' then
            $append = '{HOME}'
        ElseIf $temp = '#' then
            $append = '{END}'
        ElseIf $temp = '-' then
            $append = '{INS}'
        Else         
            $append = StringLower(StringRight($string, 1))
        EndIf
    EndIf
    
    $hotkeyAssignment = ''
    If StringInStr($string, 'CTRL') > 0 then
        $hotkeyAssignment &= '^'
    EndIf

    If StringInStr($string, 'SHIFT') > 0 then
        $hotkeyAssignment &= '+'
    EndIf

    If StringInStr($string, 'ALT') > 0 then
        $hotkeyAssignment &= '!'
    EndIf

    $hotkeyAssignment &= $append
    
    Return $hotkeyAssignment
EndFunc

Func _ExcludeHotkey() 
    _SendMessage(_WinAPI_GetFocus(), $HKM_SETHOTKEY)
EndFunc