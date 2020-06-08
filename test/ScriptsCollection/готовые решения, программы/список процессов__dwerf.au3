;AutoIt3_v3.3.6.1
;автор dwerf
Opt('MustDeclareVars', 1)

;~ #include <GUIConstantsEx.au3>
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_CHECKED = 1
Global Const $GUI_SHOW = 16
Global Const $GUI_HIDE = 32
Global Const $GUI_ENABLE = 64
Global Const $GUI_DISABLE = 128

;~ #include <WindowsConstants.au3>
Global Const $WS_MAXIMIZEBOX = 0x00010000
Global Const $WS_MINIMIZEBOX = 0x00020000
Global Const $WS_SIZEBOX = 0x00040000
Global Const $WS_SYSMENU = 0x00080000
Global Const $WS_VSCROLL = 0x00200000
Global Const $WS_BORDER = 0x00800000
Global Const $WS_CAPTION = 0x00C00000
Global Const $WS_POPUP = 0x80000000
Global Const $WS_EX_COMPOSITED = 0x02000000
Global Const $WM_GETMINMAXINFO = 0x0024
Global Const $GUI_SS_DEFAULT_GUI = BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU)


SetPrivilege('SeDebugPrivilege', 1)

Global $hPsAPI = DllOpen('Psapi.dll')
Global $hKernel = DllOpen('Kernel32.dll')

OnAutoItExitRegister('_DllClose')

Global $Sorted

Global $Form1 = GUICreate('Processes and windows monitor', 590, 510, -1, -1, BitOR($GUI_SS_DEFAULT_GUI, $WS_MAXIMIZEBOX, $WS_SIZEBOX), $WS_EX_COMPOSITED)

Global $Edit1 = GUICtrlCreateEdit('', 10, 10, 570, 430, 3152064)
GUICtrlSetResizing($Edit1, 102)
GUICtrlSetState($Edit1, $GUI_HIDE)
GUICtrlSetBkColor($Edit1, 0xFFFFFF)

Global $List1 = GUICtrlCreateList('', 10, 10, 160, 430, BitOr($WS_BORDER, $WS_VSCROLL))
GUICtrlSetResizing($List1, 354)

Global $Edit2 = GUICtrlCreateEdit('', 180, 10, 400, 430, 3152064)
GUICtrlSetResizing($Edit2, 102)
GUICtrlSetBkColor($Edit2, 0xFFFFFF)

Global $Prgs1 = GUICtrlCreateProgress(10, 210, 570, 20)
GUICtrlSetState($Prgs1, $GUI_HIDE)
GUICtrlSetResizing($Prgs1, 646)

Global $ChkB1 = GUICtrlCreateCheckbox('Text only', 10, 450, 60, 20)
GUICtrlSetResizing($ChkB1, 834)

Global $ChkB2 = GUICtrlCreateCheckbox('Correct the pathes while loading', 80, 450, 180, 20)
GUICtrlSetResizing($ChkB2, 834)

Global $Radi0 = GUICtrlCreateRadio('Sort with ProcessList()', 10, 480, 120, 20)
GUICtrlSetResizing($Radi0, 834)

Global $Radi1 = GUICtrlCreateRadio('Sort by ProcessID', 140, 480, 100, 20)
GUICtrlSetResizing($Radi1, 834)

Global $Radi2 = GUICtrlCreateRadio('Sort by ProcessName', 250, 480, 120, 20)
GUICtrlSetResizing($Radi2, 834)

Global $Butt1 = GUICtrlCreateButton('Reload', 420, 480, 160, 20)
GUICtrlSetResizing($Butt1, 836)

Global $Button_About = GUICtrlCreateButton('About', 420, 450, 160, 20)
GUICtrlSetResizing($Button_About, 836)

GUICtrlSetState($ChkB2, $GUI_CHECKED)
GUICtrlSetState($Radi2, $GUI_CHECKED)

GUIRegisterMsg($WM_GETMINMAXINFO, 'WM_GETMINMAXINFO')
GUISetState()

Reload()

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit

        Case $Butt1
            Reload()

        Case $List1
            GetText()

        Case $ChkB1
            If BitAND(GUICtrlRead($ChkB1), $GUI_CHECKED) = $GUI_CHECKED Then
                GUICtrlSetState($Edit1, $GUI_SHOW)
                GUICtrlSetState($List1, $GUI_HIDE)
                GUICtrlSetState($Edit2, $GUI_HIDE)
            Else
                GUICtrlSetState($Edit1, $GUI_HIDE)
                GUICtrlSetState($List1, $GUI_SHOW)
                GUICtrlSetState($Edit2, $GUI_SHOW)
            EndIf

        Case $Button_About
            About()
    EndSwitch
WEnd

Func _DllClose()
    DllClose($hPsAPI)
    DllClose($hKernel)
EndFunc

Func WM_GETMINMAXINFO($hWnd, $msg, $wParam, $lParam)
    Local $Struct = DllStructCreate("int;int;int;int;int;int;int;int;int;int", $lParam)
    If $hWnd = $Form1 Then
        DllStructSetData($Struct, 7, 598)
        DllStructSetData($Struct, 8, 511)
    EndIf
EndFunc

Func Reload()
    GUICtrlSetState($ChkB1, $GUI_DISABLE)
    GUICtrlSetState($ChkB2, $GUI_DISABLE)
    GUICtrlSetState($Butt1, $GUI_DISABLE)
    GUICtrlSetState($Radi0, $GUI_DISABLE)
    GUICtrlSetState($Radi1, $GUI_DISABLE)
    GUICtrlSetState($Radi2, $GUI_DISABLE)
    GUICtrlSetState($Edit1, $GUI_HIDE)
    GUICtrlSetState($List1, $GUI_HIDE)
    GUICtrlSetState($Edit2, $GUI_HIDE)
    GUICtrlSetState($Prgs1, $GUI_SHOW)
    GUICtrlSetState($Button_About, $GUI_DISABLE)

    GUICtrlSetData($Edit1, '')
    GUICtrlSetData($List1, '')
    GUICtrlSetData($Edit2, '')

    Local $aProcesses = ProcessList()
    If @error Or IsArray($aProcesses) <> 1 Or UBound($aProcesses, 0) <> 2 Or $aProcesses[0][0] <= 0 Then
        MsgBox(48, 'Error', 'Error in ProcessList()')
        Return SetError(1, 0, 0)
    EndIf

    Local $aWindows = WinList()
    If @error Or IsArray($aWindows) <> 1 Or UBound($aWindows, 0) <> 2 Or $aWindows[0][0] <= 0 Then
        MsgBox(48, 'Error', 'Error in WinList()')
        Return SetError(1, 0, 0)
    EndIf

    If BitAND(GUICtrlRead($Radi0), $GUI_CHECKED) = $GUI_CHECKED Then
        $Sorted = 0
    ElseIf BitAND(GUICtrlRead($Radi1), $GUI_CHECKED) = $GUI_CHECKED Then
        SortByPID($aProcesses)
        $Sorted = 1
    ElseIf BitAND(GUICtrlRead($Radi2), $GUI_CHECKED) = $GUI_CHECKED Then
        SortByPName($aProcesses)
        $Sorted = 2
    EndIf

    Local $percent = 100/$aProcesses[0][0], $progress = 0
    For $i = 1 To $aProcesses[0][0] Step +1
        GUICtrlSetData($Edit1, 'Process ID: '   & $aProcesses[$i][1] & @CRLF & _
                               'Process Name: ' & $aProcesses[$i][0] & @CRLF & _
                               'Process Path: ' & _ProcessGetPath($aProcesses[$i][1]) & @CRLF, 1)

        If $Sorted = 2 Then
            GUICtrlSetData($List1, $aProcesses[$i][0] & ' - ' & $aProcesses[$i][1] & '|')
        Else
            GUICtrlSetData($List1, $aProcesses[$i][1] & ' - ' & $aProcesses[$i][0] & '|')
        EndIf

        For $i2 = 1 To $aWindows[0][0] Step +1
            If WinGetProcess($aWindows[$i2][1]) = $aProcesses[$i][1] Then
                GUICtrlSetData($Edit1, 'Window Name: '   & $aWindows[$i2][0] & @CRLF & _
                                       'Window Handle: ' & $aWindows[$i2][1] & @CRLF, 1)
            EndIf
        Next

        GUICtrlSetData($Edit1, @CRLF, 1)

        $progress += $percent
        GUICtrlSetData($Prgs1, $progress)
    Next


    GUICtrlSetState($Prgs1, $GUI_HIDE)
    GUICtrlSetData($Prgs1, 0)
    If BitAND(GUICtrlRead($ChkB1), $GUI_CHECKED) = $GUI_CHECKED Then
        GUICtrlSetState($Edit1, $GUI_SHOW)
    Else
        GUICtrlSetState($List1, $GUI_SHOW)
        GUICtrlSetState($Edit2, $GUI_SHOW)
    EndIf
    GUICtrlSetState($Button_About, $GUI_ENABLE)
    GUICtrlSetState($Radi0, $GUI_ENABLE)
    GUICtrlSetState($Radi1, $GUI_ENABLE)
    GUICtrlSetState($Radi2, $GUI_ENABLE)
    GUICtrlSetState($ChkB1, $GUI_ENABLE)
    GUICtrlSetState($ChkB2, $GUI_ENABLE)
    GUICtrlSetState($Butt1, $GUI_ENABLE)
EndFunc

Func GetText()
    Local $Title = GUICtrlRead($List1), $PID, $Text
    If $Sorted = 2 Then
        $PID = StringTrimLeft($Title, StringInStr($Title, ' - ')+2)
    Else
        $PID = StringLeft($Title, StringInStr($Title, ' - ')-1)
    EndIf
    $Text = GUICtrlRead($Edit1)
    $Text = StringMid($Text, StringInStr($Text, 'Process ID: ' & $PID & @CRLF))
    $Text = StringLeft($Text, StringInStr($Text, @CRLF & @CRLF, 0, 1)-1)
    GUICtrlSetData($Edit2, $Text)
EndFunc

Func _ProcessGetPath($hPID)
    Local $sPath = DllStructCreate('char[1000]')
    Local $hProcess = DllCall($hKernel, 'int', 'OpenProcess', 'dword', 0x0400 + 0x0010, 'int', 0, 'dword', $hPID)
    DllCall($hPsAPI, 'long', 'GetModuleFileNameEx', 'long', $hProcess[0], 'int', 0, 'ptr', DllStructGetPtr($sPath), 'long', DllStructGetSize($sPath))
    DllCall($hKernel, 'int', 'CloseHandle', 'hwnd', $hProcess[0])
    Local $ret = DllStructGetData($sPath, 1)
    If BitAND(GUICtrlRead($ChkB2), $GUI_CHECKED) = $GUI_CHECKED Then
        Local $c, $Drives = DriveGetDrive('ALL')
        For $i = 1 To $Drives[0] Step +1
            If Not StringInStr($Drives[$i], ':') Then ContinueLoop
            $c = StringInStr($ret, $Drives[$i])
            If $c = 1 Then
                ExitLoop
            ElseIf $c > 1 Then
                $ret = StringTrimLeft($ret, $c-1)
                ExitLoop
            EndIf
        Next
        If StringInStr($ret, '\SystemRoot\') = 1 Then $ret = StringReplace($ret, '\SystemRoot', @WindowsDir, 1)
    EndIf
    Return $ret
EndFunc

Func SortByPID(ByRef $aArray)
    Local $max, $var, $id
    For $i = 1 To $aArray[0][0] Step +1
        $max = -1
        For $i2 = $i To $aArray[0][0] Step +1
            If $aArray[$i2][1] < $max Or $max = -1 Then
                $max = $aArray[$i2][1]
                $id = $i2
            EndIf
        Next
        For $i2 = 0 To 1 Step +1
            $var = $aArray[$i][$i2]
            $aArray[$i][$i2] = $aArray[$id][$i2]
            $aArray[$id][$i2] = $var
        Next
    Next
EndFunc

Func SortByPName(ByRef $aArray)
    If IsArray($aArray) <> 1 Or UBound($aArray, 0) <> 2 Then Return SetError(1)
    Local $vVar, $chr = -1, $max, $asc, $id
    For $i = 0 To $aArray[0][0] Step +1
        If StringLen($aArray[$i][0]) > $chr Or $chr = -1 Then $chr = StringLen($aArray[$i][0])
    Next
    For $chr = $chr To 1 Step -1
        For $num = 1 To $aArray[0][0] Step +1
            $max = -1
            For $i = $num To $aArray[0][0] Step +1
                $asc = Asc(StringMid($aArray[$i][0], $chr, 1))
                If $asc < $max Or $max = -1 Then
                    $max = $asc
                    $id = $i
                EndIf
            Next
            For $i = 0 To 1
                $vVar = $aArray[$id][$i]
                For $ii = $id-1 To $num Step -1
                    $aArray[$ii+1][$i] = $aArray[$ii][$i]
                Next
                $aArray[$num][$i] = $vVar
            Next
        Next
    Next
EndFunc

;==================================================================================
; Function:         SetPrivilege( $privilege, $bEnable )
; Description:      Enables (or disables) the $privilege on the current process
;                   (Probably) requires administrator privileges to run
;
; Author(s):        Larry (from autoitscript.com's Forum)
; Notes(s):
; http://www.autoitscript.com/forum/index.php?s=&showtopic=31248&view=findpost&p=223999
;==================================================================================

Func SetPrivilege( $privilege, $bEnable )
    Const $MY_TOKEN_ADJUST_PRIVILEGES = 0x0020
    Const $MY_TOKEN_QUERY = 0x0008
    Const $MY_SE_PRIVILEGE_ENABLED = 0x0002
    Local $hToken, $SP_auxret, $SP_ret, $hCurrProcess, $nTokens, $nTokenIndex, $priv
    Local $LUID, $TOKEN_PRIVILEGES, $NEWTOKEN_PRIVILEGES, $ret, $f ;MustDeclareVars, me
    $nTokens = 1
    $LUID = DLLStructCreate("dword;int")
    If IsArray($privilege) Then    $nTokens = UBound($privilege)
    $TOKEN_PRIVILEGES = DLLStructCreate("dword;dword[" & (3 * $nTokens) & "]")
    $NEWTOKEN_PRIVILEGES = DLLStructCreate("dword;dword[" & (3 * $nTokens) & "]")
    $hCurrProcess = DLLCall("kernel32.dll","hwnd","GetCurrentProcess")
    $SP_auxret = DLLCall("advapi32.dll","int","OpenProcessToken","hwnd",$hCurrProcess[0],   _
            "int",BitOR($MY_TOKEN_ADJUST_PRIVILEGES,$MY_TOKEN_QUERY),"int*",0)
    If $SP_auxret[0] Then
        $hToken = $SP_auxret[3]
        DLLStructSetData($TOKEN_PRIVILEGES,1,1)
        $nTokenIndex = 1
        While $nTokenIndex <= $nTokens
            If IsArray($privilege) Then
                $priv = $privilege[$nTokenIndex-1]
            Else
                $priv = $privilege
            EndIf
            $ret = DLLCall("advapi32.dll","int","LookupPrivilegeValue","str","","str",$priv,   _
                    "ptr",DLLStructGetPtr($LUID))
            If $ret[0] Then
                If $bEnable Then
                    DLLStructSetData($TOKEN_PRIVILEGES,2,$MY_SE_PRIVILEGE_ENABLED,(3 * $nTokenIndex))
                Else
                    DLLStructSetData($TOKEN_PRIVILEGES,2,0,(3 * $nTokenIndex))
                EndIf
                DLLStructSetData($TOKEN_PRIVILEGES,2,DllStructGetData($LUID,1),(3 * ($nTokenIndex-1)) + 1)
                DLLStructSetData($TOKEN_PRIVILEGES,2,DllStructGetData($LUID,2),(3 * ($nTokenIndex-1)) + 2)
                DLLStructSetData($LUID,1,0)
                DLLStructSetData($LUID,2,0)
            EndIf
            $nTokenIndex += 1
        WEnd
        $ret = DLLCall("advapi32.dll","int","AdjustTokenPrivileges","hwnd",$hToken,"int",0,   _
                "ptr",DllStructGetPtr($TOKEN_PRIVILEGES),"int",DllStructGetSize($NEWTOKEN_PRIVILEGES),   _
                "ptr",DllStructGetPtr($NEWTOKEN_PRIVILEGES),"int*",0)
        $f = DLLCall("kernel32.dll","int","GetLastError")
    EndIf
    $NEWTOKEN_PRIVILEGES=0
    $TOKEN_PRIVILEGES=0
    $LUID=0
    If $SP_auxret[0] = 0 Then Return 0
    $SP_auxret = DLLCall("kernel32.dll","int","CloseHandle","hwnd",$hToken)
    If Not $ret[0] And Not $SP_auxret[0] Then Return 0
    return $ret[0]
EndFunc

Func About()
    If Not IsDeclared('Form_About') Then
        Global $Form_About = GUICreate('About...', 275, 230, -1, -1, $GUI_SS_DEFAULT_GUI, -1, $Form1)
        Global $Label_Name = GUICtrlCreateLabel('Processes and windows monitor', 10, 10, 255, 15)
        GUICtrlSetFont($Label_Name, 12, 600)
        Global $Label_Version = GUICtrlCreateLabel('Version: 0.99', 10, 30, 85, 15)
        GUICtrlSetFont($Label_Version, 11, 450)
        Global $Label_Author = GUICtrlCreateLabel('Author: dwerf', 10, 50, 70, 15)
        GUICtrlSetFont($Label_Author, 8.5, 450)
        Global $Label_Thanks = GUICtrlCreateLabel('Thanks to:' & @CRLF & 'Yashied' & @TAB & @TAB & 'kzru_hunter' & @CRLF & 'Larry' & @TAB & @TAB & 'BugFix' & @CRLF & 'Anton'  &  @TAB & @TAB & 'AspirinJunkie', 10, 80, 175, 65)
        GUICtrlSetFont($Label_Thanks, 10, 450)
        Global $Label_RU  = GUICtrlCreateLabel('http://autoitscript.ru/', 10, 165, 100, 17)
        GUICtrlSetFont($Label_RU, 8.5, 400, 0)
        GUICtrlSetColor($Label_RU, 0x0000FF)
        GUICtrlSetCursor($Label_RU, 0)
        Global $Label_DE  = GUICtrlCreateLabel('http://autoit.de/', 10, 185, 80, 17)
        GUICtrlSetFont($Label_DE, 8.5, 400, 0)
        GUICtrlSetColor($Label_DE, 0x0000FF)
        GUICtrlSetCursor($Label_DE, 0)
        Global $Label_COM = GUICtrlCreateLabel('http://autoitscript.com/', 10, 205, 110, 17)
        GUICtrlSetFont($Label_COM, 8.5, 400, 0)
        GUICtrlSetColor($Label_COM, 0x0000FF)
        GUICtrlSetCursor($Label_COM, 0)
    EndIf
    Local $L_Hover = 0, $gci
    GUISetState(@SW_SHOW, $Form_About)
    GUISetState(@SW_DISABLE, $Form1)
    While 1
        $gci = GUIGetCursorInfo($Form_About)
        If Not @error Then
            Switch $gci[4]
                Case $Label_RU
                    If Not $L_Hover = 1 Then
                        GUICtrlSetFont($Label_RU, 8.5, 400, 4)
                        GUICtrlSetFont($Label_DE, 8.5, 400, 0)
                        GUICtrlSetFont($Label_COM, 8.5, 400, 0)
                        $L_Hover = 1
                    EndIf
                Case $Label_DE
                    If Not $L_Hover = 2 Then
                        GUICtrlSetFont($Label_RU, 8.5, 400, 0)
                        GUICtrlSetFont($Label_DE, 8.5, 400, 4)
                        GUICtrlSetFont($Label_COM, 8.5, 400, 0)
                        $L_Hover = 2
                    EndIf
                Case $Label_COM
                    If Not $L_Hover = 3 Then
                        GUICtrlSetFont($Label_RU, 8.5, 400, 0)
                        GUICtrlSetFont($Label_DE, 8.5, 400, 0)
                        GUICtrlSetFont($Label_COM, 8.5, 400, 4)
                        $L_Hover = 3
                    EndIf
                Case Else
                    If Not $L_Hover = 0 Then
                        GUICtrlSetFont($Label_RU, 8.5, 400, 0)
                        GUICtrlSetFont($Label_DE, 8.5, 400, 0)
                        GUICtrlSetFont($Label_COM, 8.5, 400, 0)
                        $L_Hover = 0
                    EndIf
            EndSwitch
        EndIf
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE
                ExitLoop
            Case $Label_RU
                ShellExecute('http://autoitscript.ru/')
            Case $Label_DE
                ShellExecute('http://autoit.de/')
            Case $Label_COM
                ShellExecute('http://autoitscript.com/')
        EndSwitch
    WEnd
    GUISetState(@SW_ENABLE, $Form1)
    GUISetState(@SW_HIDE, $Form_About)
EndFunc
 