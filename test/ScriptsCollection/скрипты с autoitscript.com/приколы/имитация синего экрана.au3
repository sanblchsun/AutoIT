#Region
#AutoIt3Wrapper_icon=BSoD.ico
#AutoIt3Wrapper_outfile=..\BlueScr.exe
#AutoIt3Wrapper_Res_Description=BSoD
#AutoIt3Wrapper_Res_Fileversion=1.0.0.1
#AutoIt3Wrapper_Add_Constants=n
#EndRegion

#Include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#NoTrayIcon

_WinAPI_ShowCursor(False)

HotKeySet("{F8}", "ExitBlueScr")

Global $DesktopWidth = @DesktopWidth, $DesktopHeight = @DesktopHeight
Global $DesktopDepth = @DesktopDepth, $DesktopRefresh = @DesktopRefresh


GUICreate("Bluescr", @DesktopWidth + 4, @DesktopHeight + 4)
GUISetBkColor(0x0000A0)
$Label = GUICtrlCreateLabel("A problem has been detected and Windows has been shut down to prevent damage" & @CRLF & _
"to your computer." & @CRLF & _
@CRLF & _
"The problem seems to be caused by the following file: SPCMDCON.SYS" & @CRLF & _
@CRLF & _
"PAGE_FAULT_IN_NONPAGED_AREA" & @CRLF & _
@CRLF & _
"If this is the first time you've seen this stop error screen," & @CRLF & _
"restart your computer. If this screen appears again, follow" & @CRLF & _
"these steps:" & @CRLF & _
@CRLF & _
"Check to make sure any new hardware or software is properly installed." & @CRLF & _
"If this is a new installation, ask your hardware or software manufacturer" & @CRLF & _
"for any Windows updates you might need." & @CRLF & _
@CRLF & _
"If problems continue, disable or remove any newly installed hardware" & @CRLF & _
"or software. Disable BIOS memory options such as caching or shadowing." & @CRLF & _
"If you need to use Safe Mode to remove or disable components, restart" & @CRLF & _
"your computer, press F8 to select Advanced Startup Options, and then" & @CRLF & _
"select Safe Mode." & @CRLF & _
@CRLF & _
"Technical information:" & @CRLF & _
@CRLF & _
"*** STOP: 0x00000050 (0xFD3094C2,0x00000001,0xFBFE7617,0x00000000)" & @CRLF & _
@CRLF & _
@CRLF & _
"***  SPCMDCON.SYS - Address FBFE7617 base at FBFE5000, DateStamp 3d6dd67c", 10, 10, @DesktopWidth - 10, @DesktopHeight - 10)
GUICtrlSetFont(-1, 17, 100, -1, "Lucida Console")
GUICtrlSetColor(-1, 0xD8D8D8)
GUICtrlSetOnEvent(-1, "None")
GUISetState()
$iWidth = 1024
$iHeight = 768
$iBitsPP = 32
$iRefreshRate = 60
BlockInput(1)
If $iWidth = @DesktopWidth And $iHeight = @DesktopHeight And $iBitsPP = @DesktopDepth And $iRefreshRate = @DesktopRefresh Then
GUISetBkColor(0x000000)
GUICtrlSetState($Label, $GUI_HIDE)
_ChangeScreenRes(800, 600, $iBitsPP, $iRefreshRate)
Sleep(1000)
GUICtrlSetState($Label, $GUI_SHOW)
GUISetBkColor(0x0000A0)
_ChangeScreenRes($iWidth, $iHeight, $iBitsPP, $iRefreshRate)
Else
_ChangeScreenRes($iWidth, $iHeight, $iBitsPP, $iRefreshRate)
EndIf
While 1

WEnd


Func _ChangeScreenRes($i_Width = @DesktopWidth, $i_Height = @DesktopHeight, $i_BitsPP = @DesktopDepth, $i_RefreshRate = @DesktopRefresh) ;from ChangeResolution.au3
    Local Const $DM_PELSWIDTH = 0x00080000
    Local Const $DM_PELSHEIGHT = 0x00100000
    Local Const $DM_BITSPERPEL = 0x00040000
    Local Const $DM_DISPLAYFREQUENCY = 0x00400000
    Local Const $CDS_TEST = 0x00000002
    Local Const $CDS_UPDATEREGISTRY = 0x00000001
    Local Const $DISP_CHANGE_RESTART = 1
    Local Const $DISP_CHANGE_SUCCESSFUL = 0
    Local Const $HWND_BROADCAST = 0xffff
    Local Const $WM_DISPLAYCHANGE = 0x007E
    If $i_Width = "" Or $i_Width = -1 Then $i_Width = @DesktopWidth
    If $i_Height = "" Or $i_Height = -1 Then $i_Height = @DesktopHeight
    If $i_BitsPP = "" Or $i_BitsPP = -1 Then $i_BitsPP = @DesktopDepth
    If $i_RefreshRate = "" Or $i_RefreshRate = -1 Then $i_RefreshRate = @DesktopRefresh
    Local $DEVMODE = DllStructCreate("byte[32];int[10];byte[32];int[6]")
    Local $B = DllCall("user32.dll", "int", "EnumDisplaySettings", "ptr", 0, "long", 0, "ptr", DllStructGetPtr($DEVMODE))
    If @error Then
        $B = 0
        SetError(1)
        Return $B
    Else
        $B = $B[0]
    EndIf
    If $B <> 0 Then
        DllStructSetData($DEVMODE, 2, BitOR($DM_PELSWIDTH, $DM_PELSHEIGHT, $DM_BITSPERPEL, $DM_DISPLAYFREQUENCY), 5)
        DllStructSetData($DEVMODE, 4, $i_Width, 2)
        DllStructSetData($DEVMODE, 4, $i_Height, 3)
        DllStructSetData($DEVMODE, 4, $i_BitsPP, 1)
        DllStructSetData($DEVMODE, 4, $i_RefreshRate, 5)
        $B = DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DEVMODE), "int", $CDS_TEST)
        If @error Then
            $B = -1
        Else
            $B = $B[0]
        EndIf
        Select
            Case $B = $DISP_CHANGE_RESTART
                $DEVMODE = ""
                Return 2
            Case $B = $DISP_CHANGE_SUCCESSFUL
                DllCall("user32.dll", "int", "ChangeDisplaySettings", "ptr", DllStructGetPtr($DEVMODE), "int", $CDS_UPDATEREGISTRY)
                DllCall("user32.dll", "int", "SendMessage", "hwnd", $HWND_BROADCAST, "int", $WM_DISPLAYCHANGE, _
                        "int", $i_BitsPP, "int", $i_Height * 2 ^ 16 + $i_Width)
                $DEVMODE = ""
                Return 1
            Case Else
                $DEVMODE = ""
                SetError(1)
                Return $B
        EndSelect
    EndIf
EndFunc

Func None()

EndFunc

Func ExitBlueScr()
    _WinAPI_ShowCursor(True)
    _ChangeScreenRes($DesktopWidth, $DesktopHeight, $DesktopDepth, $DesktopRefresh)
    Exit
EndFunc
 