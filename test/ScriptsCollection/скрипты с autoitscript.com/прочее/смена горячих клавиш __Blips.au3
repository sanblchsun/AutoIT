;=====================
;Shadowbane AOE Macro
;=====================
#include <GUIConstants.au3>
Global $Select_Self, $Select_None, $Cast_AOE, $Combat_Mode, $Off_Stance, $Aoe_Delay, $Rest_Duration, $Cast_Times, $msgx, $Rest
Global $pause = 1
Global $window_title = "Shadowbane"
If @compiled = 1 Then
    Global $path = StringTrimRight(@AutoItExe,StringLen(@ScriptName)) & "\aoe.ini"
Else
    Global $path = StringTrimRight(@ScriptFullPath,StringLen(@ScriptName)) & "\aoe.ini"
EndIf
HotKeySet("{pause}", "_pause")
HotKeySet("{esc}", "_quitmacro")
$window = GUICreate("Aoe Macro", 135, 205, -1, -1)
GUICtrlCreateGroup ("", 0, -5, 135, 133)
GUICtrlCreateLabel("Select Self:", 30, 5)
$btn_selectself = GUICtrlCreateButton("1", 90, 5, 25, 18)
GUICtrlCreateLabel("Select None:", 22, 25)
$btn_selectnone = GUICtrlCreateButton("1", 90, 25, 25, 18)
GUICtrlCreateLabel("Combat Mode:", 15, 45)
$btn_combatmode = GUICtrlCreateButton("1", 90, 45, 25, 18)
GUICtrlCreateLabel("Offensive Mode:", 5, 65)
$btn_offmode = GUICtrlCreateButton("1", 90, 65, 25, 18)
GUICtrlCreateLabel("Cast Aoe:", 35, 85)
$btn_castaoe = GUICtrlCreateButton("1", 90, 85, 25, 18)
GUICtrlCreateLabel("Rest:", 55, 106,-1,17)
$btn_rest = GUICtrlCreateButton("1", 90, 105, 25, 18)
GUICtrlCreateGroup ("",-99,-99,1,1)
GUICtrlCreateGroup ("", 0, 125, 135, 75)
GUICtrlCreateLabel("Cast Delay:", 10, 138)
$edit_aoedelay = GUICtrlCreateInput ( "1", 66,  138, 50, 17)
GUICtrlCreateLabel("Rest Duration:", 5, 158)
$edit_restdur = GUICtrlCreateInput ( "1", 74,  158, 50, 17)
GUICtrlCreateLabel("Casts before rest:", 5, 180,-1,18)
$edit_casttimes = GUICtrlCreateInput ( "30", 89,  178, 30, 17)
GUICtrlCreateGroup ("",-99,-99,1,1)
_read_settings()
_write_settings()
GUISetState(@SW_SHOW, $window)
While 0 < 1
 $msg = GUIGetMsg(0)
Select
    Case $msg = $btn_selectself
        _btnCode($msg)
    Case $msg = $btn_selectnone
        _btnCode($msg)
    Case $msg = $btn_combatmode
        _btnCode($msg)
    Case $msg = $btn_offmode
        _btnCode($msg)
    Case $msg = $btn_castaoe
        _btnCode($msg)
    Case $msg = $btn_rest
        _btnCode($msg)
    Case $msg = $GUI_EVENT_CLOSE
        _quitmacro()
EndSelect
If $pause = 0 Then
    _lockhotkeys("1")
    _macro()
    _lockhotkeys("0")
EndIf
WEnd
Func _btnCode($msg)
        $msgx = $msg
        _keys("1")
EndFunc
Func _write_settings()
    IniWrite($path, "Settings", "SelectSelf", GUICtrlRead($btn_selectself))
    IniWrite($path, "Settings", "SelectNone", GUICtrlRead($btn_selectnone))
    IniWrite($path, "Settings", "CombatMode", GUICtrlRead($btn_combatmode))
    IniWrite($path, "Settings", "OffMode", GUICtrlRead($btn_offmode))
    IniWrite($path, "Settings", "CastAOE", GUICtrlRead($btn_castaoe))
    IniWrite($path, "Settings", "AOEDelay", GUICtrlRead($edit_aoedelay))
    IniWrite($path, "Settings", "Rest", GUICtrlRead($btn_rest))
    IniWrite($path, "Settings", "RestDurr", GUICtrlRead($edit_restdur))
    IniWrite($path, "Settings", "CastTimes", GUICtrlRead($edit_casttimes))
EndFunc
Func _read_settings()
    $Select_Self = IniRead($path, "Settings", "SelectSelf", "1")
    GUICtrlSetData ($btn_selectself,$Select_Self)
    $Select_None = IniRead($path, "Settings", "SelectNone", "2")
    GUICtrlSetData ($btn_selectnone,$Select_None)
    $Cast_AOE = IniRead($path, "Settings", "CombatMode", "c")
    GUICtrlSetData ($btn_combatmode,$Cast_AOE)
    $Combat_Mode = IniRead($path, "Settings", "OffMode", "F11")
    GUICtrlSetData ($btn_offmode,$Combat_Mode)
    $Off_Stance = IniRead($path, "Settings", "CastAOE", "F4")
    GUICtrlSetData ($btn_castaoe,$Off_Stance)
    $Rest = IniRead($path, "Settings", "Rest", "z")
    GUICtrlSetData ($btn_rest,$Rest)
    $Aoe_Delay = IniRead($path, "Settings", "AOEDelay", "15700")
    GUICtrlSetData ($edit_aoedelay,$Aoe_Delay)
    $Rest_Duration = IniRead($path, "Settings", "RestDurr", "0")
    GUICtrlSetData ($edit_restdur,$Rest_Duration)
    $Cast_Times = IniRead($path, "Settings", "CastTimes", "0")
    GUICtrlSetData ($edit_casttimes,$Cast_Times)
EndFunc
Func _macro()
    If WinExists($window_title) Then
        WinSetTitle($window_title,"" ,"Sb1")
    Else
        $pause = 1
        Return
    EndIf
    _CombatMode()
    $cnt = 0
    While $pause < 1
        _Send($Cast_AOE)
        Sleep($Aoe_Delay)
        If $Cast_Times > 0 AND $cnt >= $Cast_Times AND $Rest_Duration > 0 Then
            _Rest()
            $cnt = 0
        EndIf
        $cnt = $cnt + 1
    WEnd
EndFunc
Func _Rest()
        _Send($Rest)
        Sleep($Rest_Duration)
        _CombatMode()
EndFunc
Func _Send($key)
    ControlSend("Sb1","", "", $key)
EndFunc
Func _CombatMode()
    _Send($Select_None)
    Sleep(2000)
    _Send($Combat_Mode)
    Sleep(2000)
    _Send($Off_Stance)
    Sleep(2000)
    _Send($Combat_Mode)
    Sleep(2000)
    _Send($Select_Self)
EndFunc
Func _pause()
    HotKeySet("{pause}")
    If $pause = 0 then
        $pause = 1
    Else
        _write_settings()
        _read_settings()
        $pause = 0
    Endif
    HotKeySet("{pause}", "_pause")
EndFunc
Func _lockhotkeys($state)
    if $state = 1 then
        GUICtrlSetState($btn_selectself,$GUI_DISABLE)
        GUICtrlSetState($btn_selectnone,$GUI_DISABLE)
        GUICtrlSetState($btn_combatmode,$GUI_DISABLE)
        GUICtrlSetState($btn_offmode,$GUI_DISABLE)
        GUICtrlSetState($btn_castaoe,$GUI_DISABLE)
        GUICtrlSetState($btn_rest,$GUI_DISABLE)
        GUICtrlSetState($edit_aoedelay,$GUI_DISABLE)
        GUICtrlSetState($edit_restdur,$GUI_DISABLE)
    Else
        GUICtrlSetState($btn_selectself,$GUI_ENABLE)
        GUICtrlSetState($btn_selectnone,$GUI_ENABLE)
        GUICtrlSetState($btn_combatmode,$GUI_ENABLE)
        GUICtrlSetState($btn_offmode,$GUI_ENABLE)
        GUICtrlSetState($btn_castaoe,$GUI_ENABLE)
        GUICtrlSetState($btn_rest,$GUI_ENABLE)
        GUICtrlSetState($edit_aoedelay,$GUI_ENABLE)
        GUICtrlSetState($edit_restdur,$GUI_ENABLE)
    EndIf
EndFunc
Func _keys($state)
    If $state = "1" then
        HotKeySet("a", "_changeKey")
        HotKeySet("b", "_changeKey")
        HotKeySet("c", "_changeKey")
        HotKeySet("d", "_changeKey")
        HotKeySet("e", "_changeKey")
        HotKeySet("f", "_changeKey")
        HotKeySet("g", "_changeKey")
        HotKeySet("h", "_changeKey")
        HotKeySet("i", "_changeKey")
        HotKeySet("j", "_changeKey")
        HotKeySet("k", "_changeKey")
        HotKeySet("l", "_changeKey")
        HotKeySet("m", "_changeKey")
        HotKeySet("n", "_changeKey")
        HotKeySet("o", "_changeKey")
        HotKeySet("p", "_changeKey")
        HotKeySet("q", "_changeKey")
        HotKeySet("r", "_changeKey")
        HotKeySet("s", "_changeKey")
        HotKeySet("t", "_changeKey")
        HotKeySet("u", "_changeKey")
        HotKeySet("v", "_changeKey")
        HotKeySet("w", "_changeKey")
        HotKeySet("x", "_changeKey")
        HotKeySet("y", "_changeKey")
        HotKeySet("z", "_changeKey")
        HotKeySet("0", "_changeKey")
        HotKeySet("1", "_changeKey")
        HotKeySet("2", "_changeKey")
        HotKeySet("3", "_changeKey")
        HotKeySet("4", "_changeKey")
        HotKeySet("5", "_changeKey")
        HotKeySet("6", "_changeKey")
        HotKeySet("7", "_changeKey")
        HotKeySet("8", "_changeKey")
        HotKeySet("9", "_changeKey")
        HotKeySet("{F1}","_changeKey")
        HotKeySet("{F2}","_changeKey")
        HotKeySet("{F3}","_changeKey")
        HotKeySet("{F4}","_changeKey")
        HotKeySet("{F5}","_changeKey")
        HotKeySet("{F6}","_changeKey")
        HotKeySet("{F7}","_changeKey")
        HotKeySet("{F8}","_changeKey")
        HotKeySet("{F9}","_changeKey")
        HotKeySet("{F10}","_changeKey")
        HotKeySet("{F11}","_changeKey")
    Else
        HotKeySet("a")
        HotKeySet("b")
        HotKeySet("c")
        HotKeySet("d")
        HotKeySet("e")
        HotKeySet("f")
        HotKeySet("g")
        HotKeySet("h")
        HotKeySet("i")
        HotKeySet("j")
        HotKeySet("k")
        HotKeySet("l")
        HotKeySet("m")
        HotKeySet("n")
        HotKeySet("o")
        HotKeySet("p")
        HotKeySet("q")
        HotKeySet("r")
        HotKeySet("s")
        HotKeySet("t")
        HotKeySet("u")
        HotKeySet("v")
        HotKeySet("w")
        HotKeySet("x")
        HotKeySet("y")
        HotKeySet("z")
        HotKeySet("0")
        HotKeySet("1")
        HotKeySet("2")
        HotKeySet("3")
        HotKeySet("4")
        HotKeySet("5")
        HotKeySet("6")
        HotKeySet("7")
        HotKeySet("8")
        HotKeySet("9")
        HotKeySet("{F1}")
        HotKeySet("{F2}")
        HotKeySet("{F3}")
        HotKeySet("{F4}")
        HotKeySet("{F5}")
        HotKeySet("{F6}")
        HotKeySet("{F7}")
        HotKeySet("{F8}")
        HotKeySet("{F9}")
        HotKeySet("{F10}")
        HotKeySet("{F11}")
    EndIf
EndFunc
Func _changeKey()
    _keys("")
    GUICtrlSetData ($msgx,StringReplace(StringReplace(@HotKeyPressed, "{", ""), "}", ""))
    _write_settings()
    _read_settings()
EndFunc
Func _quitmacro()
    _write_settings()
    Exit
EndFunc
