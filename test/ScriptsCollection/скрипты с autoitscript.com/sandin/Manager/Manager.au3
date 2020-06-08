#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=Data\COMPLUSg.ico
#AutoIt3Wrapper_outfile=manager.exe
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Misc.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
#include <ScreenCapture.au3>
#Include <GDIPlus.au3>
#Include <WinAPI.au3>
#include <EditConstants.au3>
#include <ModernMenuRaw.au3>

Global Const $GWL_EXSTYLE = -20
Global $Progname = "Window manager v0.1"
Global $font = "Bank Gothic Medium BT"
Global $fade_effect = 150
Global $aUtil_MinMax[4]

Global Const $SC_MOVE = 0xF010
Global Const $SC_SIZE = 0xF000
Global Const $SC_CLOSE = 0xF060

;ShellHook notification codes:
Global Const $HSHELL_WINDOWCREATED = 1;
Global Const $HSHELL_WINDOWDESTROYED = 2;
;~ Global Const $HSHELL_ACTIVATESHELLWINDOW = 3;
;~ Global Const $HSHELL_WINDOWACTIVATED = 4;
;~ Global Const $HSHELL_GETMINRECT = 5;
Global Const $HSHELL_REDRAW = 6;
;~ Global Const $HSHELL_TASKMAN = 7;
;~ Global Const $HSHELL_LANGUAGE = 8;
;~ Global Const $HSHELL_SYSMENU = 9;
;~ Global Const $HSHELL_ENDTASK = 10;
;~ Global Const $HSHELL_ACCESSIBILITYSTATE = 11;
;~ Global Const $HSHELL_APPCOMMAND = 12;
;~ Global Const $HSHELL_WINDOWREPLACED = 13;
;~ Global Const $HSHELL_WINDOWREPLACING = 14;
;~ Global Const $HSHELL_RUDEAPPACTIVATED = 32772;
;~ Global Const $HSHELL_FLASH = 32774;

Global $bHook = 1
Global $allow_renaming_global = true
Global $start_up_windows; = true
Global $ballon_popup; = true
Global $X_kill; = true;false
Global $realtime_refresh; = true
Global $remove_hidden; = False
Global $sound1 = true
Global $refresh_rate_interval; = 1000
Global $ini_save_file = @ScriptDir & "\data\data.dat"
Global $do_not_remove_list[1]

if FileExists($ini_save_file) = 0 then
	FileWrite($ini_save_file, "")
;~ 	IniWrite($ini_save_file, "Options", "allow_renaming_global", "true")
	IniWrite($ini_save_file, "Options", "start_up_windows", "false")
	IniWrite($ini_save_file, "Options", "ballon_popup", "true")
	IniWrite($ini_save_file, "Options", "X_kill", "false")
	IniWrite($ini_save_file, "Options", "remove_hidden", "false")
	IniWrite($ini_save_file, "Options", "realtime_refresh", "true")
	IniWrite($ini_save_file, "Options", "refresh_rate_interval", "1000")
EndIf

;~ if IniRead($ini_save_file, "Options", "allow_renaming_global", "true") = "true" Then
;~ 	$allow_renaming_global = True
;~ Else
;~ 	$allow_renaming_global = False
;~ EndIf
if IniRead($ini_save_file, "Options", "start_up_windows", "true") = "true" Then
	$start_up_windows = True
Else
	$start_up_windows = False
EndIf
if IniRead($ini_save_file, "Options", "ballon_popup", "true") = "true" Then
	$ballon_popup = True
Else
	$ballon_popup = False
EndIf
if IniRead($ini_save_file, "Options", "X_kill", "true") = "true" Then
	$X_kill = True
Else
	$X_kill = False
EndIf
if IniRead($ini_save_file, "Options", "realtime_refresh", "true") = "true" Then
	$realtime_refresh = True
Else
	$realtime_refresh = False
EndIf
if IniRead($ini_save_file, "Options", "remove_hidden", "true") = "true" Then
	$remove_hidden = True
Else
	$remove_hidden = False
EndIf
$refresh_rate_interval = IniRead($ini_save_file, "Options", "refresh_rate_interval", "1000")

InstallFont(@ScriptDir & "\data\Font.ttf")

Func InstallFont($sSourceFile, $sFontDescript="", $sFontsPath="")
    Local Const $HWND_BROADCAST = 0xFFFF
    Local Const $WM_FONTCHANGE = 0x1D
   
    If $sFontsPath = "" Then $sFontsPath = @WindowsDir & "\fonts"
   
    Local $sFontName = StringRegExpReplace($sSourceFile, "^.*\\", "")
    If Not FileCopy($sSourceFile, $sFontsPath & "\" & $sFontName, 1) Then Return SetError(1, 0, 0)
   
    Local $hSearch = FileFindFirstFile($sSourceFile)
    Local $iFontIsWildcard = StringRegExp($sFontName, "\*|\?")
    Local $aRet, $hGdi32_DllOpen = DllOpen("gdi32.dll")
   
    If $hSearch = -1 Then Return SetError(2, 0, 0)
    If $hGdi32_DllOpen = -1 Then Return SetError(3, 0, 0)
   
    While 1
        $sFontName = FileFindNextFile($hSearch)
        If @error Then ExitLoop
       
        If $iFontIsWildcard Then $sFontDescript = StringRegExpReplace($sFontName, "\.[^\.]*$", "")
       
        $aRet = DllCall($hGdi32_DllOpen, "Int", "AddFontResource", "str", $sFontsPath & "\" & $sFontName)
        If IsArray($aRet) And $aRet[0] > 0 Then
            RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts", _
                $sFontDescript, "REG_SZ", $sFontsPath & "\" & $sFontName)
        EndIf
    WEnd
   
    DllClose($hGdi32_DllOpen)
    DllCall("user32.dll", "Int", "SendMessage", "hwnd", $HWND_BROADCAST, "int", $WM_FONTCHANGE, "int", 0, "int", 0)
    Return 1
EndFunc

Global $windows_visibility_list = false
Global $real_time_refresh = true

Opt("GUIOnEventMode", True)
Opt("WinTitleMatchMode", 3)

;~ MsgBox(262144, "ok", $CmdLineRaw)

$dll = DllOpen("user32.dll")

#Region GUI
;~ $Form1 = GUICreate("")
$Form2 = GUICreate($Progname, 725, 250, -1, -1, $WS_POPUP+$WS_SIZEBOX, $WS_EX_TOPMOST); , $Form1)
GUISetIcon("shell32.dll", 282, $Form2)
GUISetBkColor("0x99ccff")
$contextmenu = GUICtrlCreateContextMenu()
$icon_win = GUICtrlCreateIcon("shell32.dll", 282, 5, 3, 16, 16)
GUICtrlSetResizing(-1, $GUI_DOCKSIZE+$GUI_DOCKTOP+$GUI_DOCKLEFT)
$headlines = GUICtrlCreateLabel($Progname, 25, 3, 219)
GUICtrlSetResizing(-1, $GUI_DOCKSIZE+$GUI_DOCKTOP+$GUI_DOCKLEFT)
GUICtrlSetColor(-1, "0x003366")
GUICtrlSetFont(-1, 14, 400, 2, $font)
$BY_label = GUICtrlCreateLabel("... by Sandin", 250, 8, 60, 15)
GUICtrlSetResizing(-1, $GUI_DOCKSIZE+$GUI_DOCKTOP+$GUI_DOCKLEFT)
GUICtrlSetColor(-1, "0x003366")
GUICtrlSetFont(-1, 8, 800, 0, "arial")
$icon1 = GUICtrlCreateIcon("shell32.dll", 240, 630+75, 3, 16, 16)
GUICtrlSetResizing(-1, $GUI_DOCKSIZE+$GUI_DOCKTOP+$GUI_DOCKRIGHT)
$icon2 = GUICtrlCreateIcon("shell32.dll", 24, 608+75, 3, 16, 16)
GUICtrlSetResizing(-1, $GUI_DOCKSIZE+$GUI_DOCKTOP+$GUI_DOCKRIGHT)

$exStyles = BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES)
$listt = GUICtrlCreateListView("", 90, 25, 550+75, 220, BitOR($LVS_SHOWSELALWAYS, $LVS_REPORT))
GUICtrlSetResizing(-1, $GUI_DOCKBORDERS)
_GUICtrlListView_SetExtendedListViewStyle($listt, $exStyles)
GUICtrlSetBkColor(-1, "0xDFF3FE")

$ListDummy = GUICtrlCreateDummy()
$list_context = GUICtrlCreateContextMenu($ListDummy)
$Rename_Window = GUICtrlCreateMenuItem("Rename window", $ListDummy)
$Set_on_top_Window = GUICtrlCreateMenuItem("Trigger on-top", $ListDummy)
$Set_transparency = GUICtrlCreateMenuItem("Set transparency", $ListDummy)
$Set_visibility = GUICtrlCreateMenuItem("Trigger visibility", $ListDummy)
$Set_self_rename = GUICtrlCreateMenuItem("Allow Self-Renaming", $ListDummy)
GUICtrlCreateMenuItem("", $ListDummy)
$go_to_folder = GUICtrlCreateMenuItem("Go to process's folder", $ListDummy)
GUICtrlCreateMenuItem("", $ListDummy)
$view_visible = GUICtrlCreateMenuItem("List only visible windows", $ListDummy)
GUICtrlSetState(-1, $GUI_CHECKED)
$Refresh_List = GUICtrlCreateMenuItem("Refresh list", $ListDummy)
GUICtrlCreateMenuItem("", $ListDummy)
$Kill_window = GUICtrlCreateMenuItem("Close this window", $ListDummy)
$Kill_processs = GUICtrlCreateMenuItem("Kill window's process", $ListDummy)


$hImage = _GUIImageList_Create(16, 16, 5, 3)
_GUICtrlListView_AddColumn($listt, "Window(s)", 120)
_GUICtrlListView_AddColumn($listt, "On-Top", 50)
_GUICtrlListView_AddColumn($listt, "Transparent", 75)
_GUICtrlListView_AddColumn($listt, "Visible", 50)
_GUICtrlListView_AddColumn($listt, "Self-Rename", 75)
_GUICtrlListView_AddColumn($listt, "Window's executable (.exe)", 250)
_GUICtrlListView_AddColumn($listt, "Window's handle", 100)

GUISetOnEvent ($GUI_EVENT_PRIMARYDOWN, "Drag" )
GUICtrlSetOnEvent ($headlines, "Drag" )
GUICtrlSetOnEvent ($icon1, "_Minimize_manager")
GUICtrlSetOnEvent ($icon2, "_help_pop_up")
GUICtrlSetOnEvent ($listt, "_Sort_items")

GUICtrlSetOnEvent ($Rename_Window, "_Rename_Window")
GUICtrlSetOnEvent ($Set_on_top_Window, "_Set_on_top_Window")
GUICtrlSetOnEvent ($Set_transparency, "_Set_Transparency")
GUICtrlSetOnEvent ($Set_visibility, "_Set_visibility")
GUICtrlSetOnEvent ($Set_self_rename, "_Set_self_rename")

GUICtrlSetOnEvent ($go_to_folder, "_go_to_process_folder")

GUICtrlSetOnEvent ($view_visible, "_Set_to_view_only_visible")
GUICtrlSetOnEvent ($Refresh_List, "_List_refreshing")

GUICtrlSetOnEvent ($Kill_window, "_Close_selected_window")
GUICtrlSetOnEvent ($Kill_processs, "_Close_selected_window_process")

;~ DllCall($dll, "int", "AnimateWindow", "hwnd", $form2, "int", $fade_effect, "long", 0x00080000);fade-in
WinSetTrans($form2, "", 254)
;~ GUISetState(@SW_SHOW, $form2)

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
GUIRegisterMsg(RegisterWindowMessage("SHELLHOOK"), "HShellWndProc")
ShellHookWindow($form2, $bHook)
initMinMax(370,150,@DesktopWidth-30,@DesktopHeight-30)

If _MutexExists($progname) Then
    MsgBox(262144, $progname, "Program is allready running")
    Exit
EndIf

if $CmdLineRaw = "/background" Then
	GUISetState(@SW_HIDE)
	$1st_time = true
Else
	GUISetState(@SW_SHOW)
	$1st_time = false
EndIf
#EndRegion

#Region tray menu
SetBlueTrayColors()

$nTrayIcon1		= _TrayIconCreate($Progname, "shell32.dll", 282)
_TrayIconSetClick(-1, 9)

$nTrayMenu1		= _TrayCreateContextMenu()

$TrayRestore		= _TrayCreateItem("Restore")
GUICtrlSetState(-1, $GUI_DEFBUTTON)
_TrayCreateItem("")
_TrayItemSetIcon(-1, "", 0)
$MenuOptions	= _TrayCreateItem("Options")
_TrayCreateItem("")
_TrayItemSetIcon(-1, "", 0)
$TrayExit		= _TrayCreateItem("Exit")

_TrayItemSetIcon($TrayRestore, "shell32.dll", -147)
_TrayItemSetIcon($MenuOptions, "shell32.dll", -166)
_TrayItemSetIcon($TrayExit, "shell32.dll", -28)

GUICtrlSetOnEvent ($TrayExit, "_exit1")
GUICtrlSetOnEvent ($MenuOptions, "_Option_Window")
GUICtrlSetOnEvent ($TrayRestore, "_restore_manager")

_TrayIconSetState()
#EndRegion

if $CmdLineRaw <> "/background" Then
	_DisplaySelection()
	Sleep(100)
	_GUICtrlListView_RegisterSortCallBack($listt)
endif

Func _MutexExists($sOccurenceName)
    Local $ERROR_ALREADY_EXISTS = 183, $handle, $lastError
    
    $sOccurenceName = StringReplace($sOccurenceName, "\", ""); to avoid error
    $handle = DllCall("kernel32.dll", "int", "CreateMutex", "int", 0, "long", 1, "str", $sOccurenceName)

    $lastError = DllCall("kernel32.dll", "int", "GetLastError")
    Return $lastError[0] = $ERROR_ALREADY_EXISTS
    
EndFunc  ;==>_MutexExists

Func HShellWndProc($hWnd, $Msg, $wParam, $lParam)
    Switch $wParam
;~ 		Case $HSHELL_WINDOWCREATED
;~ 			_add_window($lParam, WinGetTitle($lParam))
;~         Case $HSHELL_WINDOWDESTROYED
;~ 			_delete_window($lParam, WinGetTitle($lParam))
        Case $HSHELL_REDRAW
			_change_title_window($lParam, WinGetTitle($lParam))
    EndSwitch
EndFunc

func _Option_Window()
	_toggle_hooker()
	_call_option_window($Progname & " Options")
	_toggle_hooker()
EndFunc

func _call_option_window($win_name1)
	opt("GUIOnEventMode", False)
	Local $readings
	Local $mouse_position = MouseGetPos()
	Local $form2_position = WinGetPos($Form2)
	
	Local $form4 = GUICreate($win_name1, 200, 280, $form2_position[0]+$form2_position[2]/2-70, $form2_position[1]+$form2_position[3]/2-63, $WS_POPUP, $WS_EX_TOPMOST)
	GUISetIcon("shell32.dll", -166)
	
	GUISetBkColor("0x99ccff")
	GUICtrlCreateIcon("shell32.dll", -166, 6, 7, 16, 16)
	Local $size2 = WinGetClientSize($form4)
	$ex_icon = GUICtrlCreateIcon("shell32.dll", -132, $size2[0]-22, 7, 16, 16)
	GUICtrlCreateLabel($win_name1, 25, 4, $size2[0]-50, 60, $ES_CENTER)
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 14, 400, 0, "Bank Gothic Medium BT")
	
	GUICtrlCreateGraphic(0, 0, $size2[0], $size2[1], $SS_BLACKFRAME)
	GUICtrlSetColor(-1, 0)
	GUICtrlCreateGraphic(3, 3, $size2[0]-6, $size2[1]-6, $SS_BLACKFRAME)
	GUICtrlSetColor(-1, 0)
	
	GUICtrlCreateGroup("Basic Options", 10, 65, $size2[0]-20, 100)
	$start_up_checkbox = GUICtrlCreateCheckbox("Start Up with Windows", 15, 80, 130, 17)
	if $start_up_windows = true Then
		GUICtrlSetState($start_up_checkbox, $GUI_CHECKED)
	endif
	$allow_balloon_popups = GUICtrlCreateCheckbox("Allow Balloon Pop-Ups", 15, 100, 130, 17)
	if $ballon_popup = true Then
		GUICtrlSetState($allow_balloon_popups, $GUI_CHECKED)
	endif
	$x_kill_mark = GUICtrlCreateCheckbox("X-mark Kills Manager", 15, 120, 130, 17)
	if $X_kill = true Then
		GUICtrlSetState($x_kill_mark, $GUI_CHECKED)
	endif
	$remove_hidden_opt = GUICtrlCreateCheckbox("Remove Hidden from List", 15, 140, 150, 17)
	if $remove_hidden = true Then
		GUICtrlSetState($remove_hidden_opt, $GUI_CHECKED)
	endif
	GUICtrlCreateGroup("", -99, -99, 1, 1)  ;close group
	
	GUICtrlCreateGroup("Real-Time Refresh", 10, 170, $size2[0]-20, 70)
	$reeal_time_refresh_list_checkbox = GUICtrlCreateCheckbox("Allow Real-Time List Refresh", 15, 190, 160, 17)
	$interval_input_label = GUICtrlCreateLabel("Refresh Rate Interval (sec.)", 15, 210, 130, 17)
;~ 	GUICtrlSetState(-1, $GUI_DISABLE)
	$interval_input = GUICtrlCreateInput($refresh_rate_interval/1000, 147, 208, 40, 20, $ES_NUMBER+$ES_CENTER+$ES_AUTOHSCROLL)
	GUICtrlSetBkColor(-1, "0xDFF3FE")
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetLimit(-1, 2, 0)
;~ 	GUICtrlSetState(-1, $GUI_DISABLE)
	$interval_input_updown = GUICtrlCreateUpdown(-1)
	GUICtrlSetLimit(-1, 99, 0)
;~ 	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreateGroup("", -99, -99, 1, 1)  ;close group
	
	if $realtime_refresh = true Then
		GUICtrlSetState($reeal_time_refresh_list_checkbox, $GUI_CHECKED)
	Else
		GUICtrlSetState($interval_input_updown, $GUI_DISABLE)
		GUICtrlSetState($interval_input, $GUI_DISABLE)
		GUICtrlSetState($interval_input_label, $GUI_DISABLE)
	EndIf
	
	Local $i_button_ok_form4 = GUICtrlCreateButton("Ok", 110, 250, 80, 20)
;~ 	initMinMax($size2[0]+6,$size2[1]+6,$size2[0]+6,$size2[1]+6)
	GUISetState(@SW_SHOW, $form4)
	
	While 1
		if WinActive($form2) then
;~ 			Sleep(250)
			WinActivate($form4)
			SoundPlay(@WindowsDir & "\media\ding.wav", 0)
		endif
		$nMsg = GUIGetMsg()
		Switch $nMsg
			case $i_button_ok_form4
				if GUICtrlRead($start_up_checkbox) = $GUI_CHECKED Then
					IniWrite($ini_save_file, "Options", "start_up_windows", "true")
					RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", $Progname, "REG_SZ", @ScriptFullPath & " /background")
				Else
					IniWrite($ini_save_file, "Options", "start_up_windows", "false")
					RegDelete("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", $Progname)
				EndIf
				if GUICtrlRead($allow_balloon_popups) = $GUI_CHECKED Then
					$ballon_popup = true
					IniWrite($ini_save_file, "Options", "ballon_popup", "true")
				Else
					$ballon_popup = false
					IniWrite($ini_save_file, "Options", "ballon_popup", "false")
				EndIf
				if GUICtrlRead($remove_hidden_opt) = $GUI_CHECKED Then
					$remove_hidden = true
					IniWrite($ini_save_file, "Options", "remove_hidden", "true")
					ReDim $do_not_remove_list[1]
;~ 					_TrayTip(-1, "ok", "true", 10)
				Else
					$remove_hidden = false
					IniWrite($ini_save_file, "Options", "remove_hidden", "false")
;~ 					_TrayTip(-1, "ok", "false", 10)
				EndIf
				if GUICtrlRead($x_kill_mark) = $GUI_CHECKED Then
					$X_kill = true
					IniWrite($ini_save_file, "Options", "X_kill", "true")
				Else
					$X_kill = false
					IniWrite($ini_save_file, "Options", "X_kill", "false")
				EndIf
				if GUICtrlRead($reeal_time_refresh_list_checkbox) = $GUI_CHECKED Then
					$realtime_refresh = true
					IniWrite($ini_save_file, "Options", "realtime_refresh", "true")
				Else
					$realtime_refresh = false
					IniWrite($ini_save_file, "Options", "realtime_refresh", "false")
				EndIf
				$refresh_rate_interval = GUICtrlRead($interval_input)*1000
				IniWrite($ini_save_file, "Options", "refresh_rate_interval", $refresh_rate_interval)
				opt("GUIOnEventMode", True)
				DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $form4, "int", $fade_effect, "long", 0x00090000)
				GUIDelete($form4)
				Return 1
			case $ex_icon
				opt("GUIOnEventMode", True)
				DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $form4, "int", $fade_effect, "long", 0x00090000)
				GUIDelete($form4)
				Return 0
			case $GUI_EVENT_PRIMARYDOWN
				dllcall("user32.dll","int","SendMessage","hWnd", $form4,"int",0xA1,"int", 2,"int", 0)
			case $reeal_time_refresh_list_checkbox
				if GUICtrlRead($reeal_time_refresh_list_checkbox) = $GUI_CHECKED Then
;~ 					$remove_hidden = true
					GUICtrlSetState($interval_input, $GUI_ENABLE)
					GUICtrlSetState($interval_input_updown, $GUI_ENABLE)
					GUICtrlSetState($interval_input_label, $GUI_ENABLE)
				Else
;~ 					$remove_hidden = false
					GUICtrlSetState($interval_input, $GUI_DISABLE)
					GUICtrlSetState($interval_input_updown, $GUI_DISABLE)
					GUICtrlSetState($interval_input_label, $GUI_DISABLE)
				EndIf
		EndSwitch
		Sleep(10)
	WEnd
EndFunc

func _restore_manager()
	GUISetState(@SW_SHOW, $form2)
	if $1st_time = true Then
		_DisplaySelection()
		Sleep(100)
		_GUICtrlListView_RegisterSortCallBack($listt)
		$1st_time = false
	EndIf
;~ 	DllCall($dll, "int", "AnimateWindow", "hwnd", $form2, "int", $fade_effect, "long", 0x00080000);fade-in
;~ 	_List_refreshing()
;~ 	_set_icons()
EndFunc

func _Minimize_manager()
	if $X_kill = true then
		_exit1()
	Else
		if $ballon_popup = True then _TrayTip(-1, $Progname, "...to restore " & $Progname & @CRLF & "click here, then click Restore.", 10);, $nInfoFlags = 0)
		GUISetState(@SW_HIDE, $form2)
	EndIf
;~ 	DllCall($dll, "int", "AnimateWindow", "hwnd", $form2, "int", 200, "long", 0x00090000);fade-out
EndFunc

Func ShellHookWindow($hWnd, $bFlag)
    Local $sFunc = 'DeregisterShellHookWindow'
    If $bFlag Then $sFunc = 'RegisterShellHookWindow'
    Local $aRet = DllCall('user32.dll', 'int', $sFunc, 'hwnd', $hWnd)
    Return $aRet[0]
EndFunc

Func RegisterWindowMessage($sText)
    Local $aRet = DllCall('user32.dll', 'int', 'RegisterWindowMessage', 'str', $sText)
    Return $aRet[0]
EndFunc

Func On_WM_SYSCOMMAND($hWnd, $Msg, $wParam, $lParam)
    Switch BitAND($wParam, 0xFFF0)
        Case $SC_MOVE, $SC_SIZE
        Case $SC_CLOSE
            ShellHookWindow($form2, 0)
            Return $GUI_RUNDEFMSG
    EndSwitch
EndFunc

Func initMinMax($x0,$y0,$x1,$y1)
    Local Const $WM_GETMINMAXINFO = 0x24
    $aUtil_MinMax[0]=$x0
    $aUtil_MinMax[1]=$y0
    $aUtil_MinMax[2]=$x1
    $aUtil_MinMax[3]=$y1
    GUIRegisterMsg($WM_GETMINMAXINFO,'MY_WM_GETMINMAXINFO')
EndFunc

Func MY_WM_GETMINMAXINFO($hWnd, $Msg, $wParam, $lParam)
    Local $minmaxinfo = DllStructCreate('int;int;int;int;int;int;int;int;int;int',$lParam)
    DllStructSetData($minmaxinfo,7,$aUtil_MinMax[0]); min X
    DllStructSetData($minmaxinfo,8,$aUtil_MinMax[1]); min Y
    DllStructSetData($minmaxinfo,9,$aUtil_MinMax[2]); max X
    DllStructSetData($minmaxinfo,10,$aUtil_MinMax[3]); max Y
    Return $GUI_RUNDEFMSG
EndFunc

func _help_pop_up()
	_toggle_hooker()
	_msgBox_helper($Progname & " Help")
	_toggle_hooker()
EndFunc

func _msgBox_helper($win_name1)
	
	Local $bassdll = DllOpen(@ScriptDir & "\data\BASSMOD.dll")
	Local $sFirstTime2 = 1
	
	$play = 0
;~ 	$path = ""
	$spath = @ScriptDir & "\data\music.xm"
	$play = _load_song($sPath, $bassdll)
	
;~ 	Local $sound1 = true
	Local $Help_text = "Thank you for using " & $Progname & @CRLF & _
						@crlf & _
						@crlf & _
						"This application will help you to get more controls over any window running on your desktop. It has ability of detecting if a window is having on-top attribude, or detecting window's transparency. It can also change this values, so you can set any window to be on-top, or change it's transparency, or even hide it, disable it's ability to self-rename, etc..." & @crlf & _
						@crlf & _
						"Once you run the program, you'll notice a list with all windows curently running in the list. By double left click on an item from the list you'll set selected window as curently active one. By right clicking, you'll get a list of this application features:" & @crlf & _
						@crlf & _
						"Rename window - will allow you to set window's title to what ever you want." & @crlf & _
						@crlf & _
						"Trigger on-top - will set On/off top attribute to selected window" & @crlf & _
						@crlf & _
						"Set Transparency - will allow you to set your window's transparency from full solid (100%) to barely visible (10%)" & @crlf & _
						@crlf & _
						"Trigger visibility - will hide your window from desktop, and from task manager (Applications section) or show it on desktop again if it's hidden" & @crlf & _
						@crlf & _
						"Allow Self-Renaming - will disable window's ability to self-rename (like Firefox does when u switch between tabs)" & @crlf & _
						@crlf & _
						"Go to process's folder - will open Windows Explorer with location of the application of the window (will set application's exe as curent)" & @crlf & _
						@crlf & _
						"List Only Visible Windows - will trigger on/off display of all windows, or only visible ones (there are many windows on your desktop running which you are not aware of)" & @crlf & _
						@crlf & _
						"Refresh List - will refresh entire list" & @crlf & _
						@crlf & _
						"Close this window - will close selected window, or multiple windows" & @crlf & _
						@crlf & _
						"Kill window's process - will kill the process (or processes) which is linked to the selected window (windows)" & @crlf & _
						@crlf & _
						@crlf & _
						"When you run this application, you'll notice new icon in the tray menu (tray menu is usualy in the right bottom part of your screen, next to the clock), icon of this program. By clicking on it, you'll get 3 following options:" & @crlf & _
						@crlf & _
						"Restore - when you click on X-mark in manager, it won't close, it'll disapear, though, by clicking on this option ""Restore"" you'll restore your manager back to visible state." & @crlf & _
						@crlf & _
						"Options - will display options window" & @crlf & _
						@crlf & _
						"Quit - will close $progname" & @crlf & _
						@crlf & _
						@crlf & _
						"As for options window:" & @crlf & _
						@crlf & _
						"Start Up With Windows - will set the $progname to start together with your Windows" & @crlf & _
						@crlf & _
						"Allow Balloon Pop-Ups - will allow/disallow tray balloon notification pop-ups" & @crlf & _
						@crlf & _
						"X-Mark Kills Manager - if checked ""X"" on your manager will close manager, if it's unchecked, ""X"" will hide your manager to tray icon" & @crlf & _
						@crlf & _
						"Remove Hidden From List - If Checked, when you trigger Visibility on any of the windows in the list, the window will disapear from the list (you'll be able to restore it if you set the list to vew all, even hidden windows). if it's unchecked, and you trigger visibility of any window in the list, the window will stay in the list." & @crlf & _
						@crlf & _
						"Allow Real-Time list Refresh - If checked, it will act like Task Manager, it will add new window if a new window is created, or delete the old one, if the window closes. If checked it will take more ressources, but you can reduce refresh rate interval, by increasing input bellow."
Local $credits_text = "Main coder:" & @crlf & _
						@crlf & _
						"sandin" & @crlf & _
						@crlf & _
						@crlf & _
						@crlf & _
						"Many thanks to all contributors of this application:" & @crlf & _
						@crlf & _
						"MrCreator" & @crlf & _
						"(Font Install)" & @crlf & _
						@crlf & _
						"PsaltyDS" & @crlf & _
						"(ProcessList)" & @crlf & _
						@crlf & _
						"rasim" & @crlf & _
						"(mod music)" & @crlf & _
						@crlf & _
						"GaryFrost" & @crlf & _
						"(ListView event)" & @crlf & _
						@crlf & _
						"Xandl" & @crlf & _
						"(MinMax Win Size)" & @crlf & _
						@crlf & _
						"Holger" & @crlf & _
						"(Modern Tray)" & @crlf & _
						@crlf & _
						"Siao" & @crlf & _
						"(Hook Windows)" & @crlf & _
						@crlf & _
						"LarryDalooza" & @crlf & _
						"(Hook Windows)" & @crlf & _
						@crlf & _
						@crlf & _
						"...and everyone from general help section of AutoIt forum which helped indirectly." & @crlf & _
						@crlf & _
						@crlf & _
						@crlf & _
						"special thanks to tester:" & @crlf & _
						@crlf & _
						"Gogili"
	$fade_effect = 150
	opt("GUIOnEventMode", False)
	Local $readings
	Local $mouse_position = MouseGetPos()
	Local $form2_position = WinGetPos($Form2)
	Local $form4 = GUICreate($win_name1, 400, 280, $form2_position[0]+$form2_position[2]/2-130, $form2_position[1]+$form2_position[3]/2-63, $WS_POPUP, $WS_EX_TOPMOST)
	GUISetIcon("shell32.dll", 24)
	GUISetBkColor("0x99ccff")
	GUICtrlCreateIcon("shell32.dll", 24, 6, 7, 16, 16)
	Local $size2 = WinGetClientSize($form4)
	$ex_icon = GUICtrlCreateIcon("shell32.dll", -132, $size2[0]-22, 7, 16, 16)
	GUICtrlCreateLabel($win_name1, 25, 4, $size2[0]-50, 20, $ES_CENTER)
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 14, 400, 0, "Bank Gothic Medium BT")
	
	GUICtrlCreateGraphic(0, 0, $size2[0], $size2[1], $SS_BLACKFRAME)
	GUICtrlSetColor(-1, 0)
	GUICtrlCreateGraphic(3, 3, $size2[0]-6, $size2[1]-6, $SS_BLACKFRAME)
	GUICtrlSetColor(-1, 0)
	
	GUICtrlCreateGroup("Manual", 10, 30, 190, 240)
	$help_edit = GUICtrlCreateEdit($Help_text, 20, 50, 170, 210, $ES_READONLY+$WS_VSCROLL)
;~ 	_GUICtrlEdit_Create($form4, $Help_text, 20, 50, 170, 210, $ES_READONLY)
	GUICtrlSetBkColor(-1, 0xDFF3FE)
	GUICtrlSetColor(-1, 0x003366)
	GUICtrlCreateGroup("", -99, -99, 1, 1)  ;close group
	
	GUICtrlCreateGroup("Credits:", 205, 30, 185, 210)
	GUICtrlCreateGraphic(215, 50, 165, 180)
	GUICtrlSetColor(-1, 0x003366)
;~     GUICtrlSetBkColor(-1, 0xDFF3FE)
;~ 	GUICtrlSetState(-1, $GUI_DISABLE)
	
	Local $i_button_ok_form4 = GUICtrlCreateButton("Close", $size2[0]-90, 250, 80, 20)
	Local $i_button_sound_form4 = GUICtrlCreateButton("Music", $size2[0]-175, 250, 80, 20)
	Local $icon_sound = GUICtrlCreateIcon("shell32.dll", -169, $size2[0]-193, 253, 16, 16)
	if $sound1 = true Then
		GUICtrlSetImage($icon_sound, "shell32.dll", -169)
	Else
		GUICtrlSetImage($icon_sound, "shell32.dll", -110)
	EndIf

	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 10, 400, 0, "Bank Gothic Medium BT")
	GUICtrlCreateGroup("", -99, -99, 1, 1)  ;close group
	
	Local $form45 = GUICreate("",163, 177, 213, 22 ,BitOR($WS_POPUP,$WS_CHILD),$WS_EX_MDICHILD,$form4)
	GUISetBkColor(0xDFF3FE, $form45)
	$credits_label = GUICtrlCreateLabel($credits_text, 5, 177, 153, 1050, $ES_CENTER)
	GUICtrlSetColor(-1, "0x003366")
;~ 	GUICtrlSetBkColor(-1, 0x000000)
	GUICtrlSetFont(-1, 14, 400, 0, "Tahoma")
;~ 	WinSetTrans($form45,"",254)
	GUISetState()
	
	$sTransHeight = 4
	For $x = 0 to 15
		Local $stemp1 = GUICreate("",163, $sTransHeight, 213, ($sTransHeight * $x)+22 ,BitOR($WS_POPUP,$WS_CHILD),$WS_EX_MDICHILD,$form4)
		GUISetBkColor(0xDFF3FE)
		GUISetState()
		WinSetTrans($stemp1,"",(255/15)*(-1*($x-15)))
	Next

	For $x = 0 to 15
		Local $stemp2 = GUICreate("",163, $sTransHeight, 213, 196 - ($sTransHeight * $x) ,BitOR($WS_POPUP,$WS_CHILD),$WS_EX_MDICHILD,$form4)
		GUISetBkColor(0xDFF3FE)
		GUISetState()
		WinSetTrans($stemp2,"",(255/15)*(-1*($x-15)))
	Next
	
	GUISetState(@SW_SHOW, $form4)
	
	if $sound1 = true then DllCall($bassdll, "int:cdecl", "BASSMOD_MusicPlay", "int", $play)
	
	Local $sTime = TimerInit()
	Local $sScroll = 5
	Local $sFirstTime = 1

	While 1
		If ($sFirstTime AND TimerDiff($sTime) > 10) OR (Not $sFirstTime AND TimerDiff($sTime) > 30) Then
			$sFirstTime = 0
			$sTime = TimerInit()
			Local $credits_location = ControlGetPos($form45, "", $credits_label)
			if $credits_location[1] < -1050	Then
				ControlMove($form45,"",$credits_label,5,177)
				$sScroll = 0
			Else
				ControlMove($form45,"",$credits_label,5,177-$sScroll) ;reset ovoga
				$sScroll += 1
			EndIf
		EndIf
		if WinActive($form2) then
			WinActivate($form4)
			SoundPlay(@WindowsDir & "\media\ding.wav",0)
		endif
		$nMsg = GUIGetMsg()
		Switch $nMsg
			case $i_button_ok_form4
				DllCall($bassdll, "int:cdecl", "BASSMOD_MusicStop", "int", $play)
				opt("GUIOnEventMode", True)
				GUIDelete($stemp1)
				GUIDelete($stemp2)
				GUIDelete($form45)
				DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $form4, "int", $fade_effect, "long", 0x00090000)
				GUIDelete($form4)
				DllCall($bassdll, "int:cdecl", "BASSMOD_MusicFree", "int", $play)
				DllClose($bassdll)
				Return 1
			case $ex_icon
				DllCall($bassdll, "int:cdecl", "BASSMOD_MusicStop", "int", $play)
				opt("GUIOnEventMode", True)
				GUIDelete($stemp1)
				GUIDelete($stemp2)
				GUIDelete($form45)
				DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $form4, "int", $fade_effect, "long", 0x00090000)
				GUIDelete($form4)
				DllCall($bassdll, "int:cdecl", "BASSMOD_MusicFree", "int", $play)
				DllClose($bassdll)
				Return 0
			case $GUI_EVENT_PRIMARYDOWN
				WinSetTrans($form45,"",254)
				do
					dllcall("user32.dll","int","SendMessage","hWnd", $form4,"int",0xA1,"int", 2,"int", 0)
					Local $msgg2 = GUIGetMsg()
				Until $msgg2 <> -7
				WinSetTrans($form45,"",255)
			case $i_button_sound_form4
				if $sound1 = true Then
					GUICtrlSetImage($icon_sound, "shell32.dll", -110)
					$sound1 = false
					DllCall($bassdll, "int:cdecl", "BASSMOD_MusicFree", "int", $play)
					Sleep(100)
					$play = _load_song($sPath, $bassdll)
				Else
					GUICtrlSetImage($icon_sound, "shell32.dll", -169)
					$sound1 = true
					DllCall($bassdll, "int:cdecl", "BASSMOD_MusicPlay", "int", $play)
				EndIf
		EndSwitch
		Sleep(10)
	WEnd
EndFunc

func _load_song($path, $bassdll)
	Local $style = 1028;BitOR(1024, 4)
	Local $Init = DllCall($bassdll, "int", "BASSMOD_Init", "int", -1, "int", 44100, "int", 0)
	Local $Name_H = DllStructCreate("char[255]")
	DllStructSetData($Name_H, 1, $path)
	$Lod = DllCall($bassdll, "int", "BASSMOD_MusicLoad", "int", 0, _
				"ptr", DllStructGetPtr($Name_H), _
				"int", 0, _
				"int", 0, _
				"int", $style)
	Return $Init[0]
EndFunc

func _toggle_hooker()
	$bHook = BitXOR($bHook, 1)
	ShellHookWindow($form2, $bHook)
EndFunc

func _go_to_process_folder()
	Local $get_state = _get_item_substring()
	Local $hwnd2 = $get_state[0]
	Local $process_Pid = WinGetProcess($hwnd2)
	if $get_state[5] <> "0" Then
		Run(@ComSpec & " /c " & "explorer /e,/select," & $get_state[5], "", @SW_HIDE)
	Else
		MsgBox(262144, "Error", "location of this window could not be retrieved", 10)
	EndIf
EndFunc

func _Close_selected_window_process()
	Local $question2
	Local $get_state = _get_item_substring()
	if $get_state[6] <> "" AND $get_state[6] <> $Form2 Then
		Local $hwnd2 = HWnd($get_state[6])
		Local $process_Pid = WinGetProcess($hwnd2)
		Local $process_name = _get_process_name($process_Pid)
		_toggle_hooker()
		Local $show_selection = _show_curent_selections()
		if $show_selection[1] < 2 Then
			$question2 = _msgBox_Close_Process($get_state[0], $process_name, $process_Pid)
			if $question2 = 1 then ; treba da napravis da se uniste vise procesa odjednom ako je vise itema selektovano na listi
				ProcessClose($process_name)
				_GUICtrlListView_DeleteItem(GUICtrlGetHandle($listt), $get_state[4])
			EndIf
		Else
			Local $imena[1][2]
			Local $string_split = StringSplit($show_selection[0], "|")
			ReDim $imena[$string_split[0]+1][2]
			for $j = 1 to $string_split[0]
				$imena[$j][0] = _GUICtrlListView_GetItemText($listt, Number($string_split[$j]), 0)
				$imena[$j][1] = _GUICtrlListView_GetItemText($listt, Number($string_split[$j]), 6)
			Next
			for $i = 1 to $string_split[0]
				Local $2nd_process_name = $imena[$i][0]
				Local $hwnd3 = HWnd($imena[$i][1])
				$process_Pid = WinGetProcess($2nd_process_name)
				$process_name = _get_process_name($process_Pid)
				$question2 = _msgBox_Close_Process($2nd_process_name, $process_name, $process_Pid)
				if $question2 = 1 then ; treba da napravis da se uniste vise procesa odjednom ako je vise itema selektovano na listi
					ProcessClose($process_name)
					_refresh_list()
				EndIf
			Next
		EndIf
		_toggle_hooker()
	Else
		SoundPlay(@WindowsDir & "\media\ding.wav",0)
	EndIf
EndFunc

func _msgBox_Close_Process($window_name2, $process_name2, $process_pid2)
	opt("GUIOnEventMode", False)
	Local $readings
	Local $mouse_position = MouseGetPos()
	Local $form2_position = WinGetPos($Form2)
	Local $form4 = GUICreate("Kill Process", 300, 140, $form2_position[0]+$form2_position[2]/2-150, $form2_position[1]+$form2_position[3]/2-70, $WS_POPUP, $WS_EX_TOPMOST)
	GUISetIcon("shell32.dll", 28)
	Local $i_label_form4 = GUICtrlCreateLabel("Window name:" & @CRLF & "Process name:" & @CRLF & "Process ID (PID):", 10, 55, 110, 51)
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 10, 400, 0, "Arial")
	Local $i_label_form4_win_name = GUICtrlCreateLabel($window_name2, 125, 55, 165, 17)
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 10, 800, 0, "Arial")
	Local $i_label_form4_win_proc = GUICtrlCreateLabel($process_name2, 125, 72, 165, 17)
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 10, 800, 0, "Arial")
	Local $i_label_form4_win_pid = GUICtrlCreateLabel($process_pid2, 125, 89, 165, 17)
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 10, 800, 0, "Arial")
	GUISetBkColor("0x99ccff")
	GUICtrlCreateGraphic(0, 0, 300, 140, $SS_BLACKFRAME)
	GUICtrlSetColor(-1, 0)
	GUICtrlCreateGraphic(3, 3, 294, 134, $SS_BLACKFRAME)
	GUICtrlSetColor(-1, 0)
	GUICtrlCreateIcon("shell32.dll", 28, 6, 7, 16, 16)
	GUICtrlCreateLabel("Kill Process", 90, 4, 160, 20)
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 14, 400, 0, $font)
	GUICtrlCreateLabel("Would you like to kill selected process?", 33-10, 30, 250+20, 20, $ES_CENTER)
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 10, 400, 0, "Arial")
	Local $i_button_ok_form4 = GUICtrlCreateButton("Accept", 60, 110, 80, 20)
	Local $i_button_cancel_form4 = GUICtrlCreateButton("&Cancel", 165, 110, 80, 20)
;~ 	DllCall($dll, "int", "AnimateWindow", "hwnd", $form4, "int", 200, "long", 0x00080000);fade-in
	GUISetState(@SW_SHOW, $form4)
	While 1
		if WinActive($form2) then
			WinActivate($form4)
			SoundPlay(@WindowsDir & "\media\ding.wav",0)
		endif
		$nMsg = GUIGetMsg()
		Switch $nMsg
			case $i_button_ok_form4
				opt("GUIOnEventMode", True)
				DllCall($dll, "int", "AnimateWindow", "hwnd", $form4, "int", 200, "long", 0x00090000);fade-out
				GUIDelete($form4)
				Return 1
			case $i_button_cancel_form4
				opt("GUIOnEventMode", True)
				DllCall($dll, "int", "AnimateWindow", "hwnd", $form4, "int", 200, "long", 0x00090000);fade-out
				GUIDelete($form4)
				Return 0
			case $GUI_EVENT_PRIMARYDOWN
				dllcall($dll,"int","SendMessage","hWnd", $form4,"int",0xA1,"int", 2,"int", 0)
		EndSwitch
		Sleep(10)
	WEnd
EndFunc

func _get_process_name($i_pid)
	Local $processes = ProcessList ()
	for $k = 1 to $processes[0][0]
		if $processes[$k][1] = $i_pid then ExitLoop
	Next
	Return $processes[$k][0]
EndFunc

func _Close_selected_window()
	Local $question
	Local $get_state = _get_item_substring()
	if $get_state[6] <> "" AND $get_state[6] <> $form2 Then
		Local $hwnd2 = HWnd($get_state[6])
		_toggle_hooker()
		Local $show_selection = _show_curent_selections()
		if $show_selection[1] < 2 Then
			$question = _msgBox_Close_Window($get_state[0])
			if $question = 1 then
				WinClose($hwnd2)
				_GUICtrlListView_DeleteItem(GUICtrlGetHandle($listt), $get_state[4])
			EndIf
		Else
			Local $imena[1][2]
			Local $string_split = StringSplit($show_selection[0], "|")
			ReDim $imena[$string_split[0]+1][2]
			for $j = 1 to $string_split[0]
				$imena[$j][0] = _GUICtrlListView_GetItemText($listt, Number($string_split[$j]), 0)
				$imena[$j][1] = _GUICtrlListView_GetItemText($listt, Number($string_split[$j]), 6)
			Next
			for $i = 1 to $string_split[0]
				Local $2nd_window_name = $imena[$i][0]
				$question = _msgBox_Close_Window($2nd_window_name)
				if $question = 1 then
					WinClose(HWnd($imena[$i][1]))
					_refresh_list()
				EndIf
			Next
		EndIf
		_toggle_hooker()
	Else
		SoundPlay(@WindowsDir & "\media\ding.wav",0)
	EndIf
EndFunc

func _msgBox_Close_Window($win_name1)
	opt("GUIOnEventMode", False)
	Local $readings
	Local $mouse_position = MouseGetPos()
	Local $form2_position = WinGetPos($Form2)
	Local $form4 = GUICreate("Close Window", 300, 123, $form2_position[0]+$form2_position[2]/2-150, $form2_position[1]+$form2_position[3]/2-61, $WS_POPUP, $WS_EX_TOPMOST)
	GUISetIcon("shell32.dll", 26)
	Local $i_label_form4 = GUICtrlCreateLabel($win_name1, 10, 55, 280, 34, $ES_CENTER)
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 10, 800, 0, "Arial")
	GUISetBkColor("0x99ccff")
	GUICtrlCreateGraphic(0, 0, 300, 123, $SS_BLACKFRAME)
	GUICtrlSetColor(-1, 0)
	GUICtrlCreateGraphic(3, 3, 294, 117, $SS_BLACKFRAME)
	GUICtrlSetColor(-1, 0)
	GUICtrlCreateIcon("shell32.dll", 26, 6, 7, 16, 16)
	GUICtrlCreateLabel("Close Window", 90, 4, 160, 20)
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 14, 400, 0, $font)
	GUICtrlCreateLabel("Would you like to close selected window?", 33-10, 30, 250+10, 20, $ES_CENTER)
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 10, 400, 0, "Arial")
	Local $i_button_ok_form4 = GUICtrlCreateButton("Accept", 60, 93, 80, 20)
	Local $i_button_cancel_form4 = GUICtrlCreateButton("&Cancel", 165, 93, 80, 20)
;~ 	DllCall($dll, "int", "AnimateWindow", "hwnd", $form4, "int", 200, "long", 0x00080000);fade-in
	GUISetState(@SW_SHOW, $form4)
	While 1
		if WinActive($form2) then
			WinActivate($form4)
			SoundPlay(@WindowsDir & "\media\ding.wav",0)
		endif
		$nMsg = GUIGetMsg()
		Switch $nMsg
			case $i_button_ok_form4
				opt("GUIOnEventMode", True)
				DllCall($dll, "int", "AnimateWindow", "hwnd", $form4, "int", 200, "long", 0x00090000);fade-out
				GUIDelete($form4)
				Return 1
			case $i_button_cancel_form4
				opt("GUIOnEventMode", True)
				DllCall($dll, "int", "AnimateWindow", "hwnd", $form4, "int", 200, "long", 0x00090000);fade-out
				GUIDelete($form4)
				Return 0
			case $GUI_EVENT_PRIMARYDOWN
				dllcall($dll,"int","SendMessage","hWnd", $form4,"int",0xA1,"int", 2,"int", 0)
		EndSwitch
		Sleep(10)
	WEnd
EndFunc

Func _Set_to_view_only_visible()
	if $windows_visibility_list = False Then
		$windows_visibility_list = True
		GUICtrlSetState($view_visible, $GUI_UNCHECKED)
	Else
		$windows_visibility_list = False
		GUICtrlSetState($view_visible, $GUI_CHECKED)
	EndIf
	_List_refreshing()
EndFunc

func _List_refreshing()
	TrayTip("", "", 10)
	_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($listt))
	_DisplaySelection()
EndFunc

func _Sort_items()
	_GUICtrlListView_SortItems($listt, GUICtrlGetState($listt))
EndFunc

func _Set_Transparency()
	Local $get_state = _get_item_substring()
	Local $hwnd2 = $get_state[6]
	_toggle_hooker()
	Local $percentage = _Window_Transparency($get_state[2], $hwnd2)
	_toggle_hooker()
	_GUICtrlListView_SetItem($listt, $percentage, $get_state[4], 2, 1)
EndFunc

func _Window_Transparency($Default, $hwnd)
	Local $hwnd2 = HWnd($hwnd)
	opt("GUIOnEventMode", False)
	Local $readings
	Local $mouse_position = MouseGetPos()
	Local $form2_position = WinGetPos($Form2)
	Local $form4 = GUICreate("Window Transparency", 260, 127, $form2_position[0]+$form2_position[2]/2-130, $form2_position[1]+$form2_position[3]/2-63, $WS_POPUP, $WS_EX_TOPMOST)
	GUISetIcon("shell32.dll", 281)
	GUISetBkColor("0x99ccff")
	GUICtrlCreateGraphic(0, 0, 260, 127, $SS_BLACKFRAME)
	GUICtrlSetColor(-1, 0)
	GUICtrlCreateGraphic(3, 3, 254, 121, $SS_BLACKFRAME)
	GUICtrlSetColor(-1, 0)
	GUICtrlCreateIcon("shell32.dll", 281, 6, 7, 16, 16)
	GUICtrlCreateLabel("Window Transparency", 25, 4, 223, 20)
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 14, 400, 0, $font)
	GUICtrlCreateLabel("Select transparency percentage please:", 15, 30, 230, 17)
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 10, 400, 0, "Arial")
	Local $i_button_ok_form4 = GUICtrlCreateButton("&Accept", 22, 90, 80, 20)
	Local $i_button_cancel_form4 = GUICtrlCreateButton("&Cancel", 160, 90, 80, 20)
	Local $i_Slider_form4 = GUICtrlCreateSlider(15, 50, 230, 40)
	GUICtrlSetLimit(-1,100,10)
	GUICtrlSetBkColor(-1, "0xDFF3FE")
	GUICtrlSetBkColor(-1, "0x99ccff")
	GUICtrlSetData(-1, StringTrimRight($Default, 1))
	Local $i_input_form41 = GUICtrlCreateInput(GUICtrlRead($i_Slider_form4) & "%", 110, 90, 43, 20, $ES_READONLY+$ES_CENTER)
	GUICtrlSetFont(-1, 10, 800, 0, "Arial")
	GUICtrlSetBkColor(-1, "0xDFF3FE")
	GUICtrlSetColor(-1, "0x003366")
	DllCall($dll, "int", "AnimateWindow", "hwnd", $form4, "int", 200, "long", 0x00080000);fade-in
	GUISetState(@SW_SHOW)
	ControlFocus($form4, "", $i_button_ok_form4)
	Local $old_readdings
	WinSetTrans($hwnd2, "", 254)
	While 1
		Local $new_readdings = GUICtrlRead($i_Slider_form4)
		if $old_readdings <> $new_readdings then
				Local $racunanje = $new_readdings*255/100
				if $new_readdings <> 100 then
					WinSetTrans($hwnd2, "", $racunanje)
				Else
					WinSetTrans($hwnd2, "", 254)
				EndIf
				GUICtrlSetData($i_input_form41, $new_readdings & "%")
				$old_readdings = $new_readdings
		EndIf
		if WinActive($form2) then
			WinActivate($form4)
			SoundPlay(@WindowsDir & "\media\ding.wav",0)
		endif
		$nMsg = GUIGetMsg()
		Switch $nMsg
			case $i_button_ok_form4
				opt("GUIOnEventMode", True)
				if $new_readdings = 100 then WinSetTrans($hwnd2, "", 255)
				DllCall($dll, "int", "AnimateWindow", "hwnd", $form4, "int", 200, "long", 0x00090000);fade-out
				GUIDelete($form4)
				Return $new_readdings & "%"
			case $i_button_cancel_form4
				opt("GUIOnEventMode", True)
				WinSetTrans($hwnd2, "", StringTrimRight($Default, 1)*255/100)
				DllCall($dll, "int", "AnimateWindow", "hwnd", $form4, "int", 200, "long", 0x00090000);fade-out
				GUIDelete($form4)
				Return $Default
			case $GUI_EVENT_PRIMARYDOWN
				dllcall($dll,"int","SendMessage","hWnd", $form4,"int",0xA1,"int", 2,"int", 0)
		EndSwitch
		Sleep(10)
	WEnd
EndFunc

func _Set_self_rename()
	Local $get_state = _get_item_substring()
;~ 	TrayTip("ok",  $get_state[7], 10)
	if $get_state[6] <> "" AND $get_state[6] <> $form2 Then
		Local $auto_rename = True
;~ 		TrayTip("ok",  $get_state[7], 10)
		if $get_state[7] = "Disallow" then $auto_rename = False
		Local $hwnd2 = HWnd($get_state[6]);WinGetHandle($get_state[0])
		if $auto_rename = True Then
			_GUICtrlListView_SetItem($listt, "Disallow", $get_state[4], 4, 2)
		Else
			_GUICtrlListView_SetItem($listt, "Allow", $get_state[4], 4, 0)
		EndIf
	Else
		SoundPlay(@WindowsDir & "\media\ding.wav",0)
	EndIf
EndFunc

func _Set_visibility()
	Local $get_state = _get_item_substring()
	Local $visibility = True
	if $get_state[6] <> "" AND $get_state[6] <> $form2 Then
		if $get_state[3] = "No" then $visibility = False
		Local $hwnd2 = HWnd($get_state[6])
		_toggle_hooker()
		if $visibility = True Then
			_GUICtrlListView_SetItem($listt, "No", $get_state[4], 3, 2)
			if $remove_hidden = False then _ArrayAdd($do_not_remove_list, $hwnd2)
			WinSetState($hwnd2, "", @SW_HIDE)
		Else
			Local $index = _ArraySearch($do_not_remove_list, $hwnd2)
			if Not @error Then _ArrayDelete($do_not_remove_list, $index)
			_GUICtrlListView_SetItem($listt, "Yes", $get_state[4], 3, 0)
			WinSetState($hwnd2, "", @SW_SHOW)
		EndIf
		_toggle_hooker()
		_set_above_win()
	Else
		SoundPlay(@WindowsDir & "\media\ding.wav",0)
	EndIf
EndFunc

func _set_above_win()
	Local $get_state = _get_item_substring()
	for $i = 0 to _GUICtrlListView_GetItemCount($listt)
		if _GUICtrlListView_GetItemText($listt, $i, 6) = $form2 Then ExitLoop
	Next
	if _GUICtrlListView_GetItemText($listt, $i, 1) = "Yes" Then WinSetOnTop($Form2, "", 1)
EndFunc

func _Set_on_top_Window()
	Local $get_state = _get_item_substring()
	if $get_state[6] <> "" then;AND $get_state[6] <> $form2 Then
		Local $on_top = True
		if $get_state[1] = "No" then $on_top = False
		Local $hwnd2 = HWnd($get_state[6]);WinGetHandle($get_state[0])
		if $on_top = False Then
			_GUICtrlListView_SetItem($listt, "Yes", $get_state[4], 1, 0)
			WinSetOnTop($hwnd2, "", 1)
		Else
			_GUICtrlListView_SetItem($listt, "No", $get_state[4], 1, 2)
			WinSetOnTop($hwnd2, "", 0)
		EndIf
		_set_above_win()
	Else
		SoundPlay(@WindowsDir & "\media\ding.wav",0)
	EndIf
EndFunc

func _get_item_substring($handle = "")
	dim $display2[8]
;~ 	$readings = GUICtrlRead($listt, 0)
	for $i = 0 to _GUICtrlListView_GetItemCount($listt)
		if $handle = "" then
			if _GUICtrlListView_GetItemSelected($listt, $i) = true Then
				$display2[0] = _GUICtrlListView_GetItemText($listt, $i) ;total count
				$display2[1] = _GUICtrlListView_GetItemText($listt, $i, 1) ;window name
				$display2[2] = _GUICtrlListView_GetItemText($listt, $i, 2) ;on top
				$display2[3] = _GUICtrlListView_GetItemText($listt, $i, 3) ;transparent
				$display2[4] = $i ;current count
				$display2[5] = _GUICtrlListView_GetItemText($listt, $i, 5) ;window's exe.
				$display2[6] = _GUICtrlListView_GetItemText($listt, $i, 6) ;win's hwnd
				$display2[7] = _GUICtrlListView_GetItemText($listt, $i, 4) ;allow self-renaming
				ExitLoop
			EndIf
		Else
			if _GUICtrlListView_GetItemText($listt, $i, 6) = $handle Then
				$display2[0] = _GUICtrlListView_GetItemText($listt, $i) ;total count
				$display2[1] = _GUICtrlListView_GetItemText($listt, $i, 1) ;window name
				$display2[2] = _GUICtrlListView_GetItemText($listt, $i, 2) ;on top
				$display2[3] = _GUICtrlListView_GetItemText($listt, $i, 3) ;transparent
				$display2[4] = $i ;current count
				$display2[5] = _GUICtrlListView_GetItemText($listt, $i, 5) ;window's exe
				$display2[6] = _GUICtrlListView_GetItemText($listt, $i, 6) ;win's hwnd
				$display2[7] = _GUICtrlListView_GetItemText($listt, $i, 4) ;allow self-renaming
				ExitLoop
			EndIf
		EndIf
	Next
	Return $display2
EndFunc

func _Rename_Window()
	Local $get_win = _get_item_substring()
	if $get_win[6] <> "" AND $get_win[6] <> $form2 Then
		Local $hwnd2 = HWnd($get_win[6]);WinGetHandle($get_win[0])
		_toggle_hooker()
		Local $new_name = _My_Input_Box($get_win[0])
		_toggle_hooker()
		if $new_name <> -1 then
;~ 			MsgBox(0, "ok", $hwnd2 & ", " & $get_win[6])
			$allow_renaming_global = false
			WinSetTitle($hwnd2, "", $new_name)
			_GUICtrlListView_SetItem($listt, $new_name, $get_win[4])
			_set_above_win()
		EndIf
		$allow_renaming_global = true
	Else
		SoundPlay(@WindowsDir & "\media\ding.wav",0)
	EndIf
EndFunc

func _My_Input_Box($Default)
	opt("GUIOnEventMode", False)
	Local $readings
	Local $mouse_position = MouseGetPos()
	Local $form2_position = WinGetPos($Form2)
	Local $form4 = GUICreate("", 200, 133, $form2_position[0]+$form2_position[2]/2-100, $form2_position[1]+$form2_position[3]/2-66, $WS_POPUP, $WS_EX_TOPMOST)
	GUISetIcon("shell32.dll", 24)
	Local $i_input_form4 = GUICtrlCreateInput($Default, 15, 70, 170, 20, $ES_CENTER+$ES_AUTOHSCROLL)
	GUICtrlSetBkColor(-1, "0xDFF3FE")
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 10, 400, 0, "Arial")
	GUISetBkColor("0x99ccff")
	GUICtrlCreateGraphic(0, 0, 200, 133, $SS_BLACKFRAME)
	GUICtrlSetColor(-1, 0)
	GUICtrlCreateGraphic(3, 3, 194, 127, $SS_BLACKFRAME)
	GUICtrlSetColor(-1, 0)
	GUICtrlCreateIcon("shell32.dll", 24, 6, 7, 16, 16)
	GUICtrlCreateLabel("Rename Window", 25, 4, 160, 20)
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 14, 400, 0, $font)
	GUICtrlCreateLabel("Type new name for selected" & @CRLF &"         window please:", 15, 30, 180, 37)
	GUICtrlSetColor(-1, "0x003366")
	GUICtrlSetFont(-1, 10, 400, 0, "Arial")
	Local $i_button_ok_form4 = GUICtrlCreateButton("Accept", 15, 100, 80, 20)
	Local $i_button_cancel_form4 = GUICtrlCreateButton("&Cancel", 105, 100, 80, 20)
;~ 	DllCall($dll, "int", "AnimateWindow", "hwnd", $form4, "int", 200, "long", 0x00080000);fade-in
	GUISetState(@SW_SHOW)
	While 1
		if WinActive($form2) then
			WinActivate($form4)
			SoundPlay(@WindowsDir & "\media\ding.wav",0)
		endif
		if ControlGetFocus($form4) = "Edit1" AND _IsPressed("0D", $dll) then
			$readings = GUICtrlRead($i_input_form4)
			opt("GUIOnEventMode", True)
			DllCall($dll, "int", "AnimateWindow", "hwnd", $form4, "int", 200, "long", 0x00090000);fade-out
			GUIDelete($form4)
			Return $readings
		EndIf
		$nMsg = GUIGetMsg()
		Switch $nMsg
			case $i_button_ok_form4
				$readings = GUICtrlRead($i_input_form4)
				opt("GUIOnEventMode", True)
				GUIDelete($form4)
				Return $readings
			case $i_button_cancel_form4
;~ 				DllClose($dll)
				opt("GUIOnEventMode", True)
				DllCall($dll, "int", "AnimateWindow", "hwnd", $form4, "int", 200, "long", 0x00090000);fade-out
				GUIDelete($form4)
;~ 				$readings = ""
				Return -1;$readings
			case $GUI_EVENT_PRIMARYDOWN
				dllcall($dll,"int","SendMessage","hWnd", $form4,"int",0xA1,"int", 2,"int", 0)
		EndSwitch
		Sleep(10)
	WEnd
EndFunc

Func Drag()
    dllcall($dll,"int","SendMessage","hWnd", $Form2,"int",0xA1,"int", 2,"int", 0)
EndFunc

Func _WinGetPath($proc_pid="", $sInResString="", $iWholeWord=1)
    Local $hKernel32_Dll = DllOpen('Kernel32.dll'), $hPsapi_Dll = DllOpen('Psapi.dll')
    Local $aOpenProc, $aProcPath, $sFileVersion
    If $hKernel32_Dll = -1 Then Return SetError(1, 0, '')
    If $hPsapi_Dll = -1 Then $hPsapi_Dll = DllOpen(@SystemDir & '\Psapi.dll')
    If $hPsapi_Dll = -1 Then $hPsapi_Dll = DllOpen(@WindowsDir & '\Psapi.dll')
    If $hPsapi_Dll = -1 Then Return SetError(2, 0, '')
    Local $vStruct   = DllStructCreate('int[1024]')
    Local $pStructPtr   = DllStructGetPtr($vStruct)
    Local $iStructSize  = DllStructGetSize($vStruct)
        $aOpenProc = DllCall($hKernel32_Dll, 'hwnd', 'OpenProcess', _
            'int', BitOR(0x0400, 0x0010), 'int', 0, 'int', $proc_pid)
       DllCall($hPsapi_Dll, 'int', 'EnumProcessModules', _
            'hwnd', $aOpenProc[0], _
            'ptr', $pStructPtr, _
            'int', $iStructSize, _
            'int_ptr', 0)
        $aProcPath = DllCall($hPsapi_Dll, 'int', 'GetModuleFileNameEx', _
            'hwnd', $aOpenProc[0], _
            'int', DllStructGetData($vStruct, 1), _
            'str', '', _
            'int', 2048)
	Local $return = $aProcPath[3]
    DllClose($hKernel32_Dll)
    DllClose($hPsapi_Dll)
    Return $return
EndFunc

func _get_current_window_list()
	Local $return_array_current[1]
	$return_array_current[0] = 0
	Local $n = 0
        $var = WinList()
        For $i = 1 to $var[0][0]
			If $var[$i][0] <> "Program manager" then
				Local $visible_window = IsVisible($var[$i][1])
				if $windows_visibility_list = True then
					If $var[$i][0] <> "" then
						$n += 1
						ReDim $return_array_current[$n+1]
						$return_array_current[$n] = $var[$i][1]
					EndIf
				Else
					If $var[$i][0] <> "" AND $visible_window Then
						$n += 1
						ReDim $return_array_current[$n+1]
						$return_array_current[$n] = $var[$i][1]
					EndIf
				EndIf
			EndIf
        Next
	$return_array_current[0] = $n
	Return $return_array_current
EndFunc

func _get_old_window_list()
	Local $u = 0
	Local $old_count = _GUICtrlListView_GetItemCount($listt)
	Local $return_array_old[$old_count+1]
	$return_array_old[0] = 0
	for $h = 1 to $old_count
		$return_array_old[$h] = _GUICtrlListView_GetItemText($listt, $u, 6)
		$u += 1
	Next
	$return_array_old[0] = $old_count
	Return $return_array_old
EndFunc

func _add_window($handle7, $title)
	Local $visible_window = IsVisible($handle7)
	_AddingItems($title, _GUICtrlListView_GetItemCount($listt), $visible_window, $handle7)
;~ 	_GUICtrlListView_SetImageList($listt, $hImage, 1)
;~ 	_set_icons()
EndFunc

func _delete_window($handle, $title)
	Local $something = False
	Local $something2
	Local $hIcons1;, $hIcons2 
	for $i = 0 to _GUICtrlListView_GetItemCount($listt)
		if _GUICtrlListView_GetItemText($listt, $i, 6) = $handle Then
			$something = True
			$something2 = $i
			ExitLoop
		EndIf
	Next
	if $something = True then
;~ 		$remove_hidden
;~ 		_ArraySearch($do_not_remove_list, $handle)
;~ 		if @error then
;~ 			MsgBox(262144, "pre", _GUIImageList_GetImageCount($hImage))
;~ 			Hex($hIcons[0])
			if $remove_hidden = False Then
;~ 				_TrayTip(-1, "ok", "false", 10)
				_ArraySearch($do_not_remove_list, $handle)
				if @error Then
					_GUICtrlListView_DeleteItem(GUICtrlGetHandle($listt), $something2)
;~ 					$hIcons1 = _GUIImageList_GetIcon($hImage, $something2+5)
;~ 					MsgBox(262144, "icon handle", "0x" & Hex($hIcons1))
;~ 					$hIcons2 = _GUIImageList_GetIcon($hImage, $something2+6)
;~ 					MsgBox(262144, "ok", _GUIImageList_DestroyIcon($hIcons1))
;~ 					_GUIImageList_DestroyIcon($hIcons2)
				EndIf
			Else
;~ 				_TrayTip(-1, "ok", "true", 10)
				_GUICtrlListView_DeleteItem(GUICtrlGetHandle($listt), $something2)
;~ 				$hIcons1 = _GUIImageList_GetIcon($hImage, $something2+5)
;~ 				$hIcons2 = _GUIImageList_GetIcon($hImage, $something2+6)
;~ 				_GUIImageList_DestroyIcon($hIcons1)
;~ 				_GUIImageList_DestroyIcon($hIcons2)
			EndIf
;~ 			_set_icons()
;~ 			MsgBox(262144, "posle", _GUIImageList_GetImageCount($hImage))
;~ 		EndIf
	EndIf
EndFunc

func _change_title_window($handle, $title)
	Local $item_index = 9999999
;~ 	Local $get_state = _get_item_substring()
	for $w = 0 to _GUICtrlListView_GetItemCount($listt)-1
		if _GUICtrlListView_GetItemText($listt, $w, 6) = $handle Then
			$item_index = $w	
			ExitLoop
		endif
	Next
	if $item_index <> 9999999 then
		if _GUICtrlListView_GetItemText($listt, $item_index, 4) = "Allow" then
			_GUICtrlListView_SetItemText($listt, $item_index, $title)
		Else
			if $allow_renaming_global = true Then
				WinSetTitle($handle, "", _GUICtrlListView_GetItemText($listt, $item_index, 0))
				Sleep(10)
			EndIf
		EndIf
	EndIf
EndFunc

;~ func _set_icons()
;~ 	Local $get_curent_count = _get_old_window_list()
;~ 	_GUIImageList_Remove($hImage)
;~ 	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 146)
;~ 	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 171)
;~ 	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 131)
;~ 	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 24)
;~ 	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 165)
;~ 	for $p = 0 to $get_curent_count[0]-1
;~ 		Local $icon_exists = _GetIconCount(_GUICtrlListView_GetItemText($listt, $p, 5))
;~ 		if _GUICtrlListView_GetItemText($listt, $p, 5) <> @WindowsDir & "\Explorer.exe" Then
;~ 			if $icon_exists <> 0 then
;~ 				_GUIImageList_AddIcon($hImage, _GUICtrlListView_GetItemText($listt, $p, 5))
;~ 			Else
;~ 				_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 2)
;~ 			EndIf
;~ 		Else
;~ 			_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 4)
;~ 		EndIf
;~ 	Next
;~ 	_GUICtrlListView_SetImageList($hImage, $hImage, 1)
;~ EndFunc

func _refresh_list()
	Local $new_list = _get_current_window_list()
	Local $old_list = _get_old_window_list()
	for $i = 1 to $new_list[0]
		_ArraySearch($old_list, $new_list[$i])
		if @error then
			_add_window($new_list[$i], WinGetTitle($new_list[$i]))
;~ 			_set_icons()
		EndIf
	Next
	for $i = 1 to $old_list[0]
		_ArraySearch($new_list, $old_list[$i])
		if @error Then
			_delete_window($old_list[$i], WinGetTitle($old_list[$i]))
;~ 			_set_icons()
		EndIf
	Next
EndFunc

While 1
	if $realtime_refresh = true then
		if WinGetState($form2) <> 5 Then
			if $real_time_refresh = true Then
				_refresh_list()
;~ 				_set_icons()
				Sleep($refresh_rate_interval)
			EndIf
		EndIf
	EndIf
	Sleep(10)
WEnd

func _exit1()
	_GUICtrlListView_UnRegisterSortCallBack($listt)
	DllClose($dll)
	DllCall($dll, "int", "AnimateWindow", "hwnd", $form2, "int", $fade_effect, "long", 0x00090000);fade-out
	_TrayIconDelete($nTrayIcon1)
	Exit
EndFunc

Func _GetIconCount($sFilename)
    Local $iCount= DllCall("Shell32", "int", "ExtractIconEx", "str", $sFilename, "int", -1, "ptr", 0, "ptr", 0, "int", 1)
    If not @error Then Return $iCount[0]
    Return 0
EndFunc

func _AddingItems($Name, $number, $visibility2 = 1, $handlee = 0)
	if $Name <> "Program Manager" Then
		$path = _WinGetPath(WinGetProcess($Name))
		$icon_exists = _GetIconCount($path)
;~ 		MsgBox(262144, "", $icon_exists & ', ' & $path)
		if $path <> @WindowsDir & "\Explorer.exe" then; AND $icon_exists <> 0 then
			if $icon_exists <> 0 then
				_GUIImageList_AddIcon($hImage, $path)
				if @error then _GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 4)
			Else
				_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 2)
			EndIf
		Else
			_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 4)
		EndIf
		
		_GUICtrlListView_AddItem($listt, $Name, _GUIImageList_GetImageCount($hImage)-1, _GUICtrlListView_GetItemCount($listt)+999)
		
		if _get_on_top_attribute($handlee) Then
			_GUICtrlListView_AddSubItem($listt, $number, "Yes", 1, 0)
		Else
			_GUICtrlListView_AddSubItem($listt, $number, "No", 1, 2)
		EndIf
		Local $trans = _WinGetTrans($handlee)
			_GUICtrlListView_AddSubItem($listt, $number, $trans & "%", 2, 1)
			_GUICtrlListView_AddSubItem($listt, $number, $handlee, 6, 4)
			_GUICtrlListView_AddSubItem($listt, $number, "Allow", 4, 0)
		if $visibility2 = 1 then
			_GUICtrlListView_AddSubItem($listt, $number, "Yes", 3, 0)
		ElseIf $visibility2 = 0 then
			_GUICtrlListView_AddSubItem($listt, $number, "No", 3, 2)
		EndIf
		if $path <> "0" then
			_GUICtrlListView_AddSubItem($listt, $number, $path, 5, 3)
		Else
			_GUICtrlListView_AddSubItem($listt, $number, "- Error - Could not be retrieved", 5, 2)
		EndIf
	EndIf
EndFunc

Func _WinGetTrans($hWnd)
    If Not $hWnd Then Return -1
    Local $aRet = DllCall($dll, "int", "GetLayeredWindowAttributes", "hwnd", $hWnd, "ptr", 0, "int*", 0, "ptr", 0)
	If @error Or Not $aRet[1] Then Return -1
	If $aRet[0]<1 Then $aRet[3]=255 ; If $aRet[0] is 0 and other keys exist, the window is NOT transparent regardless of $aRet[3]'s value
	Local $return = Round($aRet[3]*100/255)
    Return $return
EndFunc
	
func _get_on_top_attribute($window_handle)
	Local $value
	Local $handle3 = HWnd($window_handle);WinGetHandle($window_name)
	Local $get3 = _WinAPI_GetWindowLong($handle3, $GWL_EXSTYLE)
	Local $last3 = StringRight(Hex($get3), 2)
	if StringTrimLeft($last3, 1) = 8 Then
		$value = 1
	Else
		$value = 0
	EndIf
	Return $value
EndFunc

func _DisplaySelection()
	Local $b = 0
	_GUIImageList_Remove($hImage)
;~ 	_GUICtrlListView_SetImageList($listt, $hImage, 1)
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 146) ;yes icon = 0
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 171) ;trans icon = 1
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 131) ;no icon = 2
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 24) ;path icon = 3
	_GUIImageList_AddIcon($hImage, @SystemDir & "\shell32.dll", 165) ;hwnd icon = 4
        $var = WinList()
        For $i = 1 to $var[0][0]
			Local $visible_window = IsVisible($var[$i][1])
			if $windows_visibility_list = True then
				If $var[$i][0] <> "" then; AND $visible_window Then
					_AddingItems($var[$i][0], $b, $visible_window, $var[$i][1])
					$b += 1
				EndIf
			Else
				If $var[$i][0] <> "" AND $visible_window Then
					_AddingItems($var[$i][0], $b, $visible_window, $var[$i][1])
					$b += 1
				EndIf
				_ArraySearch($do_not_remove_list, $var[$i][1])
				if NOT @error Then
					_AddingItems($var[$i][0], $b, 0, $var[$i][1])
					$b += 1
				EndIf
			EndIf
        Next
		_GUICtrlListView_SetImageList($listt, $hImage, 1)
		Local $position = WinGetPos($form2)
		Local $trans_text1 = _TransparentTextWindow("MyTextGUI", "List updated", $position[2]/1.16, $position[2]/8, 1, 1, $font, 400, 0x003366, 1, -1, -1, 1, False)
		Local $position2 = WinGetPos($trans_text1)
		WinMove($trans_text1, "", $position[0]+$position[2]/2-$position2[2]/2, $position[1]+$position[3]/2-$position2[3]/2)
;~ 		WinSetTrans($trans_text1, "", 180)
		WinSetOnTop($trans_text1, "", 1)
		Local $transss = 254
		for $i = 1 to 10
			$transss-=10
			WinSetTrans($form2, "", $transss)
		Next
		DllCall($dll, "int", "AnimateWindow", "hwnd", $trans_text1, "int", 300, "long", 0x00080000);fade-in
		GUISetState(@SW_SHOW, $trans_text1)
		Local $timer1 = TimerInit()
		do
		Until TimerDiff($timer1) >= 800
		DllCall($dll, "int", "AnimateWindow", "hwnd", $trans_text1, "int", 300, "long", 0x00090000);fade-out
		GUIDelete($trans_text1)
		for $i = 1 to 10
			$transss+=10
			WinSetTrans($form2, "", $transss)
		Next
EndFunc

Func _TransparentTextWindow($h_WinTitle, $s_WinText, $i_WinWidth, $i_WinHeight, $i_WinXPosn = -1, $i_WinYPosn = -1, _
		$s_TextFont = -1, $i_FontWeight = -1, $v_FontColor = -1, $i_FontItalics = 0, $i_FontUnderline = 0, $i_FontStrikeOut = 0, $i_Taskbar = 0, $i_WinExist = False, $i_hwnd = 0)
    Local Const $DEFAULT_CHARSET = 0 ; ANSI character set
    Local Const $OUT_CHARACTER_PRECIS = 2
    Local Const $CLIP_DEFAULT_PRECIS = 0
    Local Const $PROOF_QUALITY = 2
    Local Const $FIXED_PITCH = 1
    Local Const $RGN_XOR = 3
    If $h_WinTitle = "" Then $h_WinTitle = "Notice"
    If $s_WinText = "" Then $s_WinText = "Error"
    If $i_WinWidth < 1 Or $i_WinWidth > @DesktopWidth Then SetError(1)
    If $i_WinHeight < 1 Or $i_WinHeight > @DesktopHeight Then SetError(1)
    If $i_WinXPosn = -1 Then $i_WinXPosn = (@DesktopWidth / 2) - ($i_WinWidth / 2)
    If $i_WinYPosn = -1 Then $i_WinYPosn = (@DesktopHeight / 2) - ($i_WinHeight / 2)
    If $i_WinXPosn < 1 Or $i_WinXPosn > (@DesktopWidth - $i_WinWidth) Then SetError(1)
    If $i_WinYPosn < 1 Or $i_WinYPosn > (@DesktopHeight - $i_WinHeight) Then SetError(1)
    If @error Then Return
    If $s_TextFont = "" Or $s_TextFont = -1 Then $s_TextFont = "Microsoft Sans Serif"
    If $i_FontWeight = "" Or $i_FontWeight = -1 Then $i_FontWeight = 450
    If $v_FontColor = "" Or $v_FontColor = -1 Then $v_FontColor = "0xFF0000"
    If $i_FontItalics <> 1 Then $i_FontItalics = 0
    If $i_FontUnderline <> 1 Then $i_FontUnderline = 0
    If $i_FontStrikeOut <> 1 Then $i_FontStrikeOut = 0
    If $i_Taskbar <> 1 Then
        if $i_WinExist = False Then
            Local $h_GUI = GUICreate($h_WinTitle, $i_WinWidth, $i_WinHeight, $i_WinXPosn, _
                $i_WinYPosn, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
        Else
            Local $h_GUI = WinGetHandle($i_hwnd)
        EndIf
    Else ; hide tray icon
        if $i_WinExist = False Then
            Local $h_GUI = GUICreate($h_WinTitle, $i_WinWidth, $i_WinHeight, $i_WinXPosn, _
                $i_WinYPosn, $WS_POPUP, BitOR($WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
        Else
            Local $h_GUI = WinGetHandle($i_hwnd)
        EndIf
    EndIf
    GUISetBkColor($v_FontColor)
    Local $hDC = DllCall($dll, "int", "GetDC", "hwnd", $h_GUI)
    Local $hMyFont = DllCall("gdi32.dll", "hwnd", "CreateFont", "int", $i_WinHeight, _
            "int", 0, "int", 0, "int", 0, "int", $i_FontWeight, "int", $i_FontItalics, _
            "int", $i_FontUnderline, "int", $i_FontStrikeOut, "int", $DEFAULT_CHARSET, _
            "int", $OUT_CHARACTER_PRECIS, "int", $CLIP_DEFAULT_PRECIS, _
            "int", $PROOF_QUALITY, "int", $FIXED_PITCH, "str", $s_TextFont)
    Local $hOldFont = DllCall("gdi32.dll", "hwnd", "SelectObject", "int", $hDC[0], _
            "hwnd", $hMyFont[0])
    DllCall("gdi32.dll", "int", "BeginPath", "int", $hDC[0])
    DllCall("gdi32.dll", "int", "TextOut", "int", $hDC[0], "int", 0, "int", 0, _
            "str", $s_WinText, "int", StringLen($s_WinText))
    DllCall("gdi32.dll", "int", "EndPath", "int", $hDC[0])
    Local $hRgn1 = DllCall("gdi32.dll", "hwnd", "PathToRegion", "int", $hDC[0])
    Local $rc = DllStructCreate("int;int;int;int")
    DllCall("gdi32.dll", "int", "GetRgnBox", "hwnd", $hRgn1[0], _
            "ptr", DllStructGetPtr($rc))
    Local $hRgn2 = DllCall("gdi32.dll", "hwnd", "CreateRectRgnIndirect", _
            "ptr", DllStructGetPtr($rc))
    DllCall("gdi32.dll", "int", "CombineRgn", "hwnd", $hRgn2[0], "hwnd", $hRgn2[0], _
            "hwnd", $hRgn1[0], "int", $RGN_XOR)
    DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $hRgn1[0])
    DllCall($dll, "int", "ReleaseDC", "hwnd", $h_GUI, "int", $hDC[0])
    DllCall($dll, "int", "SetWindowRgn", "hwnd", $h_GUI, "hwnd", $hRgn2[0], "int", 1)
    DllCall("", "int", "SelectObject", "int", $hDC[0], "hwnd", $hOldFont[0])
    Return $h_GUI
EndFunc

Func IsVisible($handle)
    If BitAnd( WinGetState($handle), 2 ) Then
        Return 1
    Else
        Return 0
    EndIf
EndFunc

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    #forceref $hWnd, $iMsg, $iwParam
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView, $tInfo
;~  Local $tBuffer
    $hWndListView = $listt
    If Not IsHWnd($listt) Then $hWndListView = GUICtrlGetHandle($listt)

    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    Switch $hWndFrom
        Case $hWndListView
            Switch $iCode
;~                 Case $LVN_COLUMNCLICK ; A column was clicked
;~                     $tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam)
;~ 					MsgBox(0, "ok", "kolona")
;~                 Case $LVN_KEYDOWN ; A key has been pressed
;~                     $tInfo = DllStructCreate($tagNMLVKEYDOWN, $ilParam)
;~ 					MsgBox(0, "ok", "key")
;~                 Case $NM_CLICK ; Sent by a list-view control when the user clicks an item with the left mouse button
;~                     $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
;~ 					$readings = GUICtrlRead($listt, 1)
;~ 					for $i = 0 to _GUICtrlListView_GetItemCount($listt)
;~ 						if _GUICtrlListView_GetItemSelected($listt, $i) = true Then
;~ 							$display = _GUICtrlListView_GetItemText($listt, $i)
;~ 							ExitLoop
;~ 						EndIf
;~ 					Next
;~ 					if $display <> " " Then _display_form3($display[6]);MsgBox(0, "ok", $display)

                Case $NM_DBLCLK ; Sent by a list-view control when the user double-clicks an item with the left mouse button
                    $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					
					_win_set_active()
					
;~ 					Local $cooool = _Left_Click_on_listItem() ;izbaci sliku
;~ 					if $cooool <> " " Then _display_form3($display[6]);MsgBox(0, "ok", $display)



;~ 					$readings = GUICtrlRead($listt, 1)
;~ 					for $i = 0 to _GUICtrlListView_GetItemCount($listt)
;~ 						if _GUICtrlListView_GetItemSelected($listt, $i) = true Then
;~ 							$display = _GUICtrlListView_GetItemText($listt, $i)
;~ 							ExitLoop
;~ 						EndIf
;~ 					Next
;~ 					if $display <> " " Then _display_form3($display[6])
;~ 					MsgBox(0, "ok", "dupli levi klik na item")
;~                 Case $NM_KILLFOCUS ; The control has lost the input focus
                Case $NM_RCLICK ; Sent by a list-view control when the user clicks an item with the right mouse button
                    $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					ShowMenu($Form2, $listt, $list_context)
                    Return 0 ; allow the default processing
;~                 Case $NM_RDBLCLK ; Sent by a list-view control when the user double-clicks an item with the right mouse button
;~                     $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
;~                 Case $NM_RETURN ; The control has the input focus and that the user has pressed the ENTER key
;~                 Case $NM_SETFOCUS ; The control has received the input focus
            EndSwitch
		EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

func _win_set_active()
	Local $nestoo = _Left_Click_on_listItem()
	Local $hwnd2 = HWnd($nestoo);WinGetHandle($nestoo)
	if WinGetState($hwnd2) = 16 Then
		WinSetState($hwnd2, "", @SW_RESTORE)
	EndIf
	WinActivate($hwnd2)
EndFunc

func _Left_Click_on_listItem()
	Local $display = ""
	$readings = GUICtrlRead($listt, 1)
	for $i = 0 to _GUICtrlListView_GetItemCount($listt)
		if _GUICtrlListView_GetItemSelected($listt, $i) = true Then
			$display = _GUICtrlListView_GetItemText($listt, $i, 6)
			ExitLoop
		EndIf
	Next
	Return $display; <> " " Then _display_form3($display[6]);MsgBox(0, "ok", $display)
EndFunc

func _show_curent_selections()
	Local $rezultati[2]
	$rezultati[0] = ""
	$rezultati[1] = 0
	for $i = 0 to _GUICtrlListView_GetItemCount($listt)
		if _GUICtrlListView_GetItemSelected($listt, $i) = true Then
			if $rezultati[0] = "" Then
				$rezultati[0] &= $i
				$rezultati[1] += 1
			Else
				$rezultati[0] &= "|" & $i
				$rezultati[1] += 1
			EndIf
		EndIf
	Next
	Return $rezultati
EndFunc

Func ShowMenu($hWnd, $CtrlID, $nContextID)
	Local $show_selection = _show_curent_selections()
	if $show_selection[1] < 2 Then
		GUICtrlSetState($Refresh_List, $GUI_ENABLE)
		GUICtrlSetState($view_visible, $GUI_ENABLE)
		Local $get_item = _get_item_substring()
		if $get_item[1] = "Yes" Then
			GUICtrlSetState($Set_on_top_Window, $GUI_CHECKED)
		Else
			GUICtrlSetState($Set_on_top_Window, $GUI_UNCHECKED)
		EndIf
		if $get_item[3] = "Yes" Then
			GUICtrlSetState($Set_visibility, $GUI_CHECKED)
		Else
			GUICtrlSetState($Set_visibility, $GUI_UNCHECKED)
		EndIf
		if $get_item[7] = "Allow" Then
			GUICtrlSetState($Set_self_rename, $GUI_CHECKED)
		Else
			GUICtrlSetState($Set_self_rename, $GUI_UNCHECKED)
		EndIf
		
		if $get_item[6] = "" then
			GUICtrlSetState($Rename_Window, $GUI_DISABLE)
			GUICtrlSetState($Set_on_top_Window, $GUI_DISABLE)
			GUICtrlSetState($Set_transparency, $GUI_DISABLE)
			GUICtrlSetState($Set_visibility, $GUI_DISABLE)
			GUICtrlSetState($Set_self_rename, $GUI_DISABLE)
			GUICtrlSetState($go_to_folder, $GUI_DISABLE)
			GUICtrlSetState($Kill_window, $GUI_DISABLE)
			GUICtrlSetState($Kill_processs, $GUI_DISABLE)
		Else
			if $get_item[0] <> $Progname Then
				GUICtrlSetState($Rename_Window, $GUI_ENABLE)
				GUICtrlSetState($Set_on_top_Window, $GUI_ENABLE)
				GUICtrlSetState($Set_visibility, $GUI_ENABLE)
				GUICtrlSetState($Set_self_rename, $GUI_ENABLE)
				GUICtrlSetState($Kill_window, $GUI_ENABLE)
				GUICtrlSetState($Kill_processs, $GUI_ENABLE)
			Else
				GUICtrlSetState($Rename_Window, $GUI_DISABLE)
;~ 				GUICtrlSetState($Set_on_top_Window, $GUI_DISABLE)
				GUICtrlSetState($Set_visibility, $GUI_DISABLE)
				GUICtrlSetState($Set_self_rename, $GUI_DISABLE)
				GUICtrlSetState($Kill_window, $GUI_DISABLE)
				GUICtrlSetState($Kill_processs, $GUI_DISABLE)
			EndIf
			GUICtrlSetState($Set_transparency, $GUI_ENABLE)
			GUICtrlSetState($go_to_folder, $GUI_ENABLE)
		EndIf
	Else
		GUICtrlSetState($Refresh_List, $GUI_DISABLE)
		GUICtrlSetState($view_visible, $GUI_DISABLE)
		GUICtrlSetState($Rename_Window, $GUI_DISABLE)
		GUICtrlSetState($Set_on_top_Window, $GUI_DISABLE)
		GUICtrlSetState($Set_transparency, $GUI_DISABLE)
		GUICtrlSetState($Set_visibility, $GUI_DISABLE)
		GUICtrlSetState($Set_self_rename, $GUI_DISABLE)
		GUICtrlSetState($go_to_folder, $GUI_DISABLE)
		GUICtrlSetState($Kill_window, $GUI_ENABLE)
		GUICtrlSetState($Kill_processs, $GUI_ENABLE)
	EndIf
	
		Local $arPos, $x, $y
		Local $hMenu = GUICtrlGetHandle($nContextID)
		
		$arPos = MouseGetPos()
		
		$x = $arPos[0]+5
		$y = $arPos[1]+5

		TrackPopupMenu($hWnd, $hMenu, $x, $y)
;~ 	EndIf
EndFunc   ;==>ShowMenu

Func TrackPopupMenu($hWnd, $hMenu, $x, $y)
	DllCall($dll, "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $hWnd, "ptr", 0)
EndFunc   ;==>TrackPopupMenu

Func SetBlueTrayColors()
	_SetTrayBkColor(0xFFD8C0)
	_SetTrayIconBkColor(0xEE8877)
	_SetTrayIconBkGrdColor(0x703330)
	_SetTraySelectBkColor(0x662222)
	_SetTraySelectRectColor(0x4477AA)
	_SetTraySelectTextColor(0xFFFFFF)
	_SetTrayTextColor(0x000000)
EndFunc