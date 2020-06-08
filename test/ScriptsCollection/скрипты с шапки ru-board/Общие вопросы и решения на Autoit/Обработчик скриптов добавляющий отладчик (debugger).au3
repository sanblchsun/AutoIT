#include <Constants.au3>

Opt('TrayAutoPause', 0)
Opt('TrayOnEventMode', 1)
Opt('TrayIconDebug', 1)

TrayItemSetText($TRAY_ITEM_PAUSE, 'Pause')
TrayItemSetText($TRAY_ITEM_EXIT, 'Exit')

If $CmdLine[0] = 0 Then
    $sIniDir = ""

    While 1
        $sScript_File = FileOpenDialog('Select file to write debug info', $sIniDir, 'AutoIt script (*.au3)', 1)

        If @error Then
            MsgBox(16, 'Attention', 'No file chosen... Program will now close.')
            Exit
        EndIf

        If StringRight($sScript_File, 4) = ".au3" Then ExitLoop

        MsgBox(48, 'Wrong file chosen...', 'Please select AutoIt v3 Script File.')
        $sIniDir = @WorkingDir
    WEnd
Else
    $sScript_File = StringRegExpReplace($CmdLineRaw, '\A"+|"+\z', '')
EndIf

$sDebugScript_File = _Add_Script_Debugger_Proc($sScript_File)

If $CmdLine[0] = 0 Then _
    MsgBox(64, 'Done!', _
        StringFormat('Debug parsing process completed seccesefully, new "-Debug" file created:\n\n[%s]', $sDebugScript_File))

Func _Add_Script_Debugger_Proc($sScript_File)
    Local $sDebugScript_File = StringTrimRight($sScript_File, 4) & '-Debug.au3'
    Local $aRead_Script = StringSplit(StringStripCR(FileRead($sScript_File)), @LF)
    Local $sCurrent_Line

    Local $sDebugScript_Content = _
        'Global $iDebug_Timer = TimerInit()' & @CRLF & _
        'Global $Debug_EditContent = ""' & @CRLF & _
        'Global $hDebug_GUI = GUICreate("AutoIt v3 Script Debugger", @DesktopWidth-5, 100, 0, 0, -1, 128)' & @CRLF & _
        'Global $Debug_EditCtrl = GUICtrlCreateEdit("", 0, 0, @DesktopWidth-5, 100, 3152064)' & @CRLF & _
        'GUICtrlSetBkColor(-1, 0xFFFFFF)' & @CRLF & _
        'DllCall("User32.dll", "int", "SendMessage", "hwnd", GUICtrlGetHandle(-1), _' & @CRLF & _
        '   "int", 197, "wparam", 1058000, "lparam", 0)' & @CRLF & _
        'GUISetState()' & @CRLF & _
        'WinSetOnTop($hDebug_GUI, "", 1)' & @CRLF & _
        'Opt("SendKeyDelay", 1)' & @CRLF & @CRLF

    For $i = 1 To $aRead_Script[0]
        $sCurrent_Line = $aRead_Script[$i]

        If StringStripWS($sCurrent_Line, 8) = '' Then
            $sDebugScript_Content &= @CRLF
            ContinueLoop
        EndIf

        If Not StringRegExp($sCurrent_Line, "(\A\s+|\A);") And _
            ($i = 1 Or ($i > 1 And Not StringRegExp($aRead_Script[$i-1], "(_\s+|_)\z"))) Then

            $sDebugScript_Content &= _
                '_SetDebugData_Proc(' & $i & ', ''' & _
                StringRegExpReplace(StringReplace($sCurrent_Line, "'", "''"), '\A\t+', '') & ''' & @CRLF)' & @CRLF & _
                $sCurrent_Line & @CRLF
        Else
            $sDebugScript_Content &= $sCurrent_Line & @CRLF
        EndIf

        If StringRegExp($sCurrent_Line, '(?i)(\A\s+|\A);NO DEBUG START(\s+$|$)') Then
            For $j = $i+1 To $aRead_Script[0]
                $i = $j

                $sCurrent_Line = $aRead_Script[$j]
                $sDebugScript_Content &= $sCurrent_Line & @CRLF

                If StringRegExp($sCurrent_Line, '(?i)(\A\s+|\A);NO DEBUG END(\s+$|$)') Then ExitLoop
            Next
        EndIf
    Next

    $sDebugScript_Content &= @CRLF & @CRLF & _
        'Func _SetDebugData_Proc($iLine, $sData)' & @CRLF & _
        '   TraySetToolTip("Line: " & $iLine)' & @CRLF & _
        '   $sData = "Line(#" & $iLine & ", Timer[" & Round(TimerDiff($iDebug_Timer), 2) & "]):" & @TAB & @TAB & $sData' & @CRLF & _
        '   ControlSend($hDebug_GUI, "", $Debug_EditCtrl, "^{END}")' & @CRLF & _
        '   GUICtrlSetData($Debug_EditCtrl, $sData, 1)' & @CRLF & _
        '   $Debug_EditContent &= $sData' & @CRLF & _
        'EndFunc' & @CRLF & @CRLF & _
        'Func OnAutoItExit()' & @CRLF & _
        '   $iAsk = MsgBox(262144+36, "Debugging system - Attention", _' & @CRLF & _
        '       "Would you like to save debugging log to the file?")' & @CRLF & @CRLF & _
        '   If $iAsk = 6 Then' & @CRLF & _
        '       $Debug_EditContent = _' & @CRLF & _
        '           @CRLF & @CRLF & "===== AutoIt v3 Debuggin Session Start at: " & _' & @CRLF & _
        '           @MDAY &"/"& @MON &"/"& @YEAR & ", " & @HOUR &":"& @MIN &":"& @SEC & " =====" & @CRLF & @CRLF & _' & @CRLF & _
        '           $Debug_EditContent' & @CRLF & @CRLF & _
        '       FileWrite(@ScriptFullPath & ".log", _' & @CRLF & _
        '           $Debug_EditContent)' & @CRLF & @CRLF & _
        '       MsgBox(262144+64, "Debugging system - Saved", _' & @CRLF & _
        '           "Log Saved as:" & @CRLF & _' & @CRLF & _
        '           "[" & @ScriptFullPath & ".log]")' & @CRLF & _
        '   EndIf' & @CRLF & _
        'EndFunc' & @CRLF

    Local $hOp_DebugScrpt = FileOpen($sDebugScript_File, 2)
    FileWrite($hOp_DebugScrpt, $sDebugScript_Content)
    FileClose($hOp_DebugScrpt)

    Return $sDebugScript_File
EndFunc