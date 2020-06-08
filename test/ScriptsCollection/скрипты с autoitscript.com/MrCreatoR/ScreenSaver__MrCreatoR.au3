; http://www.autoitscript.com/forum/topic/58249-screensaver-demo-matrix-included/page__view__findpost__p__440187

#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

If $CmdLineRaw = "/S" Then
    ScreenSaver_Proc()
ElseIf $CmdLine[0] = 0 Or StringLeft($CmdLineRaw, 3) = "/c:" Then
    SCR_Options_Proc(StringLeft($CmdLineRaw, 3) = "/c:")
EndIf

Func SCR_Options_Proc($DisableParent=0)
    Local $iMsg, $ParentHwnd = 0
    
    ;If "/c:" passed as commandline, that's mean that the "Options" button was pressed from the screensaver installation dialog
    ;therefore we can disable the parent dialog and open our Options dialog as child
    If $DisableParent = 1 Then
        $ParentHwnd = WinGetHandle("")
        WinSetState($ParentHwnd, "", @SW_DISABLE)
    EndIf
    
    Local $GUI = GuiCreate("ScreenSaver Options", 250, 120, -1, -1, -1, $WS_EX_TOOLWINDOW+$WS_EX_TOPMOST, $ParentHwnd)
    
    GUICtrlCreateLabel("Our Options go here", 30, 20, 200, 30)
    GUICtrlSetFont(-1, 16)
    
    Local $Preview_Button = GUICtrlCreateButton("Preview", 10, 80, 70, 20)
    
    GUISetState()
    
    While 1
        $iMsg = GUIGetMsg()
        Switch $iMsg
            Case $GUI_EVENT_CLOSE
                ;Enable back the parent dialog
                If $DisableParent = 1 Then WinSetState($ParentHwnd, "", @SW_ENABLE)
                Exit
            Case $Preview_Button
                ScreenSaver_Proc()
        EndSwitch
    WEnd
EndFunc

Func ScreenSaver_Proc()
    MsgBox(262144+64, "ScreenSaver", "Our ScreenSaver")
EndFunc