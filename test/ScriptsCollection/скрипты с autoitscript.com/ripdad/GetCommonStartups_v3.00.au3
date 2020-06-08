;========================================
; GetCommonStartups v3.00
; Released: September 17, 2012 by ripdad
; Example: Yes
;========================================
;
#include 'array.au3'
#RequireAdmin
;
Opt('TrayAutoPause', 0)
Opt('MustDeclareVars', 1)
;
Local $sTitle = 'GetCommonStartups v3.00'
;
Local Const $OSA = @OSArch, $OSV = @OSVersion
Local $HKCR, $HKLM, $HKCU, $HKU, $OSA64 = 0, $Vista_7 = 0
;
GCS_CheckEnvironment()
;
Local Const $sWMI_Moniker = 'Winmgmts:{ImpersonationLevel=Impersonate,AuthenticationLevel=PktPrivacy,(Debug,Restore,Security)}!\\.\root\cimv2'
Local $oErrorHandler = ObjEvent('AutoIt.Error', '_ObjErrorHandler')
Local $nWMI, $Object_Error = 0, $Suppress_ErrorMsg = 1
;
GCS_TestWMI()
;
Local Const $GUI_SHOW = 16, $GUI_HIDE = 32, $GUI_ENABLE = 64, $GUI_DISABLE = 128, $GUI_FOCUS = 256
Local Const $LVM_DELETEALLITEMS = 0x1009, $LVM_SETCOLUMNWIDTH = 0x101E, $LVSCW_AUTOSIZE = -1
Local Const $NM_CLICK = -2, $NM_DBLCLK = -3, $NM_RCLICK = -5, $dtWidth = @DesktopWidth
;
Local $nAdv = 0, $nProcessEvent = 0, $nTLvID = 0, $nState = 0, $nSwitch = 1, $nPID = 0
Local $nClientHeight, $nClientWidth, $aProcesses, $id_FROM, $Menu_ID, $nLastPID = 0
;
Local $aENV = _GetEnvironmentArray()
;
DllCall('uxtheme.dll', 'none', 'SetThemeAppProperties', 'int', 1)
;
;<--[GUI]
Local $id_GUI = GUICreate($sTitle, 600, 400, -1, -1, 0x00CF0000)
;Listviews and DragBar
Local $id_LV1, $id_LV2, $id_DragBar
;InfoBar
Local $aIB[6] = [5]
For $i = 1 To 4
    $aIB[$i] = GUICtrlCreateLabel('', 0, 0, 0, 0, BitOR(0x1000, 0x01));$SS_SUNKEN,$SS_CENTER
    GUICtrlSetFont($aIB[$i], 9, Default, Default, 'arial')
    GUICtrlSetBkColor($aIB[$i], 0xEEEEEE)
Next
GUICtrlSetData($aIB[1], @ComputerName)
GUICtrlSetData($aIB[2], $OSV & '_' & $OSA)
GUICtrlSetData($aIB[3], @HomeDrive & '\' & Round(DriveSpaceFree(@HomeDrive), 1) & ' mbFS')
GUICtrlSetData($aIB[4], 'GCS Properties')
GUICtrlSetBkColor($aIB[4], 0xC0FFC0)
$aIB[5] = GUICtrlCreateProgress(0, 0, 0, 0, 1)
GUICtrlSetBkColor($aIB[5], 0xEEEEEE)
GUICtrlSetColor($aIB[5], 0x000080)
Local $swp = $aIB[4]
Local $prb = $aIB[5]
GUICtrlSetOnEvent($swp, '_Swap')
;Menus
Local $aCM[22] = [21]
Local $m1 = GUICtrlCreateMenu('File', -1)
GUICtrlCreateMenuItem('Run', $m1)
GUICtrlSetOnEvent(-1, '_RunProgram')
GUICtrlCreateMenuItem('', $m1)
GUICtrlCreateMenuItem('Exit', $m1)
GUICtrlSetOnEvent(-1, '_AllExit')
Local $m2 = GUICtrlCreateMenu('Tools', -1)
GUICtrlCreateMenuItem('Windows Explorer', $m2)
GUICtrlSetOnEvent(-1, '_RunExplorer')
GUICtrlCreateMenuItem('Command Prompt', $m2)
GUICtrlSetOnEvent(-1, '_RunCommandPrompt')
GUICtrlCreateMenuItem('', $m2)
GUICtrlCreateMenuItem('Computer Management', $m2)
GUICtrlSetOnEvent(-1, '_RunCompmgmtMSC')
GUICtrlCreateMenuItem('Clear Event Logs', $m2)
GUICtrlSetOnEvent(-1, '_ClearEventLogs')
GUICtrlCreateMenuItem('Reboot-Check Hard Drive', $m2)
GUICtrlSetOnEvent(-1, '_Reboot_CheckHardDrive')
GUICtrlCreateMenuItem('View Hosts File', $m2)
GUICtrlSetOnEvent(-1, '_ViewHostsFile')
GUICtrlCreateMenuItem('', $m2)
GUICtrlCreateMenuItem('Common Startups (reset)', $m2)
GUICtrlSetOnEvent(-1, '_StartupList')
;Client Events
GUISetOnEvent(-3, '_AllExit')
GUISetOnEvent(-5, 'GCS_AutoSizeGUI')
GUISetOnEvent(-6, 'GCS_AutoSizeGUI')
GUISetOnEvent(-12, 'GCS_AutoSizeGUI')
Opt('GUIOnEventMode', 1)
;ShowGUI
GUISetState(@SW_SHOW, $id_GUI)
;<--[/GUI]
;
_Init_CtrlId()
_StartupList()
;
GUIRegisterMsg(0x0024, '_WM_GETMINMAXINFO')
GUIRegisterMsg(0x004E, '_WM_NOTIFY')
;
While 1
    Sleep(100)
    If $nPID Then
        _GetModulesByPID($nPID)
        $nPID = 0
    EndIf
WEnd
;
Func _StartupList()
    Local $a, $string, $attributes, $id_Item, $sSource, $sItem, $sPath, $sKey = 0
    GCS_CreateListView($id_LV1, 'Common Startups|Source|Company Name|Version|File Description|Created|Attributes')

    Local $aItems = GetCommonStartups()
    $nTLvID = 0

    For $i = 1 To $aItems[0]
        GUICtrlSetData($prb, ($i / $aItems[0]) * 100)
        $sItem = StringTrimLeft($aItems[$i], 1)

        Switch Number(StringLeft($aItems[$i], 1))
            Case 1
                $sKey = $sItem
                $id_Item = GUICtrlCreateListViewItem($sKey & '|||||---|K', $id_LV1)
                GUICtrlSetImage($id_Item, 'regedit.exe', 100)
                If $nTLvID = 0 Then $nTLvID = $id_Item
            Case 2
                $sKey = 0
                $attributes = _FolderTimeAttributes($sItem)
                $id_Item = GUICtrlCreateListViewItem($sItem & '|||||' & $attributes, $id_LV1)
                GUICtrlSetImage($id_Item, 'explorer.exe', 252)
            Case 3
                $a = StringSplit($sItem, '^', 1)
                If $a[0] <> 2 Then ContinueLoop
                $sSource = $a[1]
                $sPath = $a[2]

                $string = Reg_GetFriendlyPath($sPath) & '|' & $sSource & '|'
                $sPath = Reg_GetFriendlyPath($sPath, 1)
                $string &= _GetFileProperties($sPath)

                $attributes = FileGetAttrib($sPath)
                $string &= '|' & $attributes
                $id_Item = GUICtrlCreateListViewItem($string, $id_LV1)

                If StringInStr($attributes, 'H') Then
                    GUICtrlSetBkColor($id_Item, 0xFFB0B0)
                ElseIf StringInStr($sItem, '<--[') Then
                    GUICtrlSetBkColor($id_Item, 0xFF8080)
                Else
                    GUICtrlSetBkColor($id_Item, 0xFFD0D0)
                EndIf

                If $sKey Then
                    RegRead($sKey, $sSource)
                    Switch @extended
                        Case 0
                        Case 1, 2
                            GUICtrlSetImage($id_Item, 'regedit.exe', 205)
                        Case Else
                            GUICtrlSetImage($id_Item, 'regedit.exe', 206)
                    EndSwitch
                Else
                    If Not GUICtrlSetImage($id_Item, $sPath, -1) Then
                        GUICtrlSetImage($id_Item, 'shell32.dll', 3)
                    EndIf
                EndIf
        EndSwitch
    Next

    LV_SetColumnWidth($id_LV1, '420,600|90,100|125,150|90,100|130,150|70,80|70,80')

    GUICtrlSetState($id_LV1, $GUI_FOCUS)
    GUICtrlSetState($id_LV1, $GUI_SHOW)
    GUICtrlSetData($prb, 0)
    $nState = 1
EndFunc
;
Func _LvScreen()
    Local $s, $nIcon, $id_Item, $sItem, $aItems, $type
    Local $sText = GUICtrlRead(@GUI_CtrlId, 1)

    Switch $sText
        Case 'System Information'
            GCS_CreateListView($id_LV1, $sText & '| ')
            $s = GetSystemInfo()
            $aItems = StringSplit($s, @CRLF, 1)
            For $i = 1 To $aItems[0]
                GUICtrlSetData($prb, ($i / $aItems[0]) * 100)
                $sItem = $aItems[$i]
                If StringInStr($sItem, '<--', 0, 1, 1, 3) Then
                    $sItem = StringReplace($sItem, '<--', ' ')
                    $id_Item = GUICtrlCreateListViewItem($sItem, $id_LV1)
                    GUICtrlSetBkColor($id_Item, 0xC0C0C0)
                Else
                    GUICtrlCreateListViewItem($sItem, $id_LV1)
                EndIf
            Next
            GUICtrlSendMsg($id_LV1, $LVM_SETCOLUMNWIDTH, 0, 270)
            GUICtrlSendMsg($id_LV1, $LVM_SETCOLUMNWIDTH, 1, $LVSCW_AUTOSIZE)
        Case 'Registry Settings'
            GCS_CreateListView($id_LV1, $sText)
            $s = Reg_GetRegistrySettings()
            $aItems = StringSplit($s, @CRLF, 1)
            For $i = 1 To $aItems[0]
                GUICtrlSetData($prb, ($i / $aItems[0]) * 100)
                $sItem = $aItems[$i]
                If $sItem = '' Then ExitLoop
                $sItem = StringLeft($sItem, StringInStr($sItem, '^', 0, -1) - 1)
                $type = StringLeft(StringRight($aItems[$i], 3), 1)
                $nIcon = StringLeft(StringRight($aItems[$i], 2), 1)
                $id_Item = GUICtrlCreateListViewItem($sItem, $id_LV1)
                ;
                If $type = 1 Then
                    GUICtrlSetImage($id_Item, 'regedit.exe', 100)
                    GUICtrlSetBkColor($id_Item, 0xCCCCCC)
                Else
                    If $nIcon = 0 Then
                        ; do nothing
                    ElseIf ($nIcon = 1) Or ($nIcon = 2) Then
                        GUICtrlSetImage($id_Item, 'regedit.exe', 205)
                    Else
                        GUICtrlSetImage($id_Item, 'regedit.exe', 206)
                    EndIf
                EndIf
            Next
            GUICtrlSendMsg($id_LV1, $LVM_SETCOLUMNWIDTH, 0, $dtWidth - 50)
        Case 'NTLog_Errors', 'NTLog_Warnings', 'NTLog_ChkDsk'
            GCS_CreateListView($id_LV1, $sText)
            Switch $sText
                Case 'NTLog_Errors'
                    $s = NTLogs_GetEvents('Error')
                Case 'NTLog_Warnings'
                    $s = NTLogs_GetEvents('Warnings')
                Case 'NTLog_ChkDsk'
                    $s = NTLogs_GetEvents('Information')
            EndSwitch
            If @error Then
                _WMI_ObjectError(-1)
            Else
                $aItems = StringSplit($s, @CRLF, 1)
                For $i = 1 To $aItems[0]
                    GUICtrlSetData($prb, ($i / $aItems[0]) * 100)
                    $id_Item = GUICtrlCreateListViewItem($aItems[$i], $id_LV1)
                    If StringInStr($aItems[$i], '<--', 0, 1, 1, 3) Then GUICtrlSetBkColor($id_Item, 0xCCCCCC)
                Next
                GUICtrlSendMsg($id_LV1, $LVM_SETCOLUMNWIDTH, 0, $dtWidth - 50)
            EndIf
    EndSwitch

    GUICtrlSetState($id_LV1, $GUI_FOCUS)
    GUICtrlSetState($id_LV1, $GUI_SHOW)
    GUICtrlSetData($prb, 0)
    $nState = 0
EndFunc
;
Func _WM_GETMINMAXINFO($hwnd, $msg, $wParam, $lParam)
    Local $tagMaxinfo = DllStructCreate('int;int;int;int;int;int;int;int;int;int', $lParam)
    DllStructSetData($tagMaxinfo, 7, 600); min-width
    DllStructSetData($tagMaxinfo, 8, 400); min-height
    Return 'GUI_RUNDEFMSG'
EndFunc
;
Func _WM_NOTIFY($hwnd, $iMsg, $wParam, $lParam)
    #forceref $hWnd, $iMsg, $wParam, $lParam
    Local $tStruct = DllStructCreate('hwnd hWndFrom;uint_ptr IDFrom;int Code', $lParam)
    If @error Then Return
    Local $aItems, $iCode = DllStructGetData($tStruct, 'Code')
    Local $sText, $idFROM = DllStructGetData($tStruct, 'IDFrom')
    ;
    ; <--[Click Detection/Direction/Menu State]
    ;
    If $iCode = $NM_DBLCLK Then
        $id_FROM = $idFROM
        Switch $nSwitch
            Case 1
                _FilePropertiesEx()
            Case 2
                _WindowsProperties()
            Case 3
                _Jump2Path()
        EndSwitch
    ElseIf $iCode = $NM_RCLICK Then
        $id_FROM = $idFROM
        $aItems = StringSplit(StringTrimRight(GUICtrlRead(GUICtrlRead($idFROM)), 1), '|')
        If ($nState = 0) Or ($aItems[0] <> 7) Then
            If StringInStr($aItems[1], 'HKEY', 0, 1, 1, 4) Then
                GUICtrlSetState($aCM[2], $GUI_ENABLE)
            Else
                GUICtrlSetState($aCM[2], $GUI_DISABLE)
            EndIf
            GUICtrlSetState($aCM[4], $GUI_DISABLE)
            GUICtrlSetState($aCM[5], $GUI_DISABLE)
            GUICtrlSetState($aCM[17], $GUI_DISABLE)
        ElseIf $nState = 1 Then
            If StringRegExp($aItems[7], '(D|K)') Then
                GUICtrlSetState($aCM[2], $GUI_ENABLE)
                GUICtrlSetState($aCM[4], $GUI_DISABLE)
                GUICtrlSetState($aCM[5], $GUI_DISABLE)
                GUICtrlSetState($aCM[17], $GUI_DISABLE)
            Else
                GUICtrlSetState($aCM[2], $GUI_ENABLE)
                GUICtrlSetState($aCM[4], $GUI_ENABLE)
                GUICtrlSetState($aCM[5], $GUI_DISABLE)
                GUICtrlSetState($aCM[17], $GUI_ENABLE)
            EndIf
        ElseIf $nState = 2 Then
            GUICtrlSetState($aCM[2], $GUI_ENABLE)
            GUICtrlSetState($aCM[4], $GUI_DISABLE)
            GUICtrlSetState($aCM[5], $GUI_ENABLE)
            GUICtrlSetState($aCM[17], $GUI_ENABLE)
        ElseIf $nState = 3 Then
            GUICtrlSetState($aCM[2], $GUI_ENABLE)
            GUICtrlSetState($aCM[4], $GUI_DISABLE)
            GUICtrlSetState($aCM[5], $GUI_DISABLE)
            GUICtrlSetState($aCM[17], $GUI_ENABLE)
        EndIf
    ElseIf $nProcessEvent And ($idFROM = $id_LV1) And ($iCode = $NM_CLICK) Then
        $aItems = StringSplit(StringTrimRight(GUICtrlRead(GUICtrlRead($id_LV1)), 1), '|')
        If ($aItems[0] = 7) And StringIsDigit($aItems[2]) Then
            $nPID = $aItems[2]
        EndIf
    EndIf
    Return 'GUI_RUNDEFMSG'
EndFunc
;
Func _AllExit()
    Opt('GUIOnEventMode', 0)
    GUIRegisterMsg(0x0024, '')
    GUIRegisterMsg(0x004E, '')
    GUIDelete($id_GUI)
    $aProcesses = ''
    Exit
EndFunc
;
Func NoWMI()
    MsgBox(8240, $sTitle, 'WMI Service Not Available', 5)
    Return ''
EndFunc
;
Func _Swap()
    $nSwitch += 1
    If ($nSwitch > 3) Then $nSwitch = 1
    Local $a = StringSplit('GCS Properties|Windows Properties|Jump to...', '|')
    GUICtrlSetData($swp, $a[$nSwitch])
EndFunc
;
Func _Copy2Clip()
    Local $s = StringTrimRight(GUICtrlRead(GUICtrlRead($id_FROM)), 1)
    If StringRegExp($s, '[\w]') Then
        ClipPut($s)
    Else
        ClipPut('')
    EndIf
EndFunc
;
;======================================================================================
; #Function ...: StringMatch()
; Description .: A simple and down to earth string compare. (with Statement Mode)
; Released ....: July 11, 2012 by ripdad
; Version .....: v1.00
; Example .....: Yes
; .............:
; Syntax ......: $s = Input String.
; .............: $c = Compare String.
; .............: $m = Statement Mode. (Default 0 = off)
; .............: $d = Delimiter to use. (Default '|')
; .............:
; Remarks .....: Using == and low-case, it only cares "If THIS Strictly Matches THAT".
; .............: 1) Compares with Single or Multiple Strings.
; .............: 2) Returns the Position Number if matched. (in Normal Mode)
; .............: 3) Returns 0 if not matched. (in Normal Mode)
;======================================================================================
Func StringMatch($s, $c, $m = 0, $d = '|')
    $s = StringLower($s)
    $c = StringLower($c)
    Local $a = StringSplit($c, $d, 1)
    Local $n = 0
    ;
    For $i = 1 To $a[0]
        If ($s == $a[$i]) Then
            $n = $i
            ExitLoop
        EndIf
    Next
    ;
    Switch $m
        Case 0; (OFF) Normal Mode
            If $n Then Return $n
        Case 1; (ON)
            If $n = 0 Then Return 1
        Case 2; (ON)
            If $n > 0 Then Return 1
    EndSwitch
    Return 0
EndFunc
;
Func StringExists($s_String, $i_Chars = 30)
    $s_String = StringStripWS(StringLeft($s_String, $i_Chars), 8)
    If Not StringLen($s_String) Then
        Return SetError(0, 0, 0)
    ElseIf $s_String <> 0 Then
        Return SetError(0, 0, 1)
    Else
        Return SetError(0, 1, 1)
    EndIf
EndFunc
;
Func GetByteFormat($n_b, $ns_os = 1); $ns_os can be number or string, within scope of function.
    If Not StringIsDigit($ns_os) Then
        $ns_os = StringMatch($ns_os, 'Bytes|KiloBytes|MegaBytes')
    EndIf
    Local $a_ab = StringSplit('Bytes|KB|MB|GB|TB', '|')
    If ($ns_os < 1) Or ($ns_os > $a_ab[0]) Then Return $n_b
    For $i = $ns_os To $a_ab[0]; in @ offset -> div -> abrv -> out
        If ($n_b < 1024) Then Return Round($n_b, 2) & ' ' & $a_ab[$i]
        $n_b /= 1024
    Next
EndFunc
;
Func _FolderTimeAttributes($sPath)
    If Not FileExists($sPath) Then Return '---|---'
    Local $string
    Local $array = FileGetTime($sPath, 1)
    If IsArray($array) Then
        $string = $array[1] & '/' & $array[2] & '/' & $array[0] & '|'
    Else
        $string = '---|'
    EndIf
    Local $attrib = FileGetAttrib($sPath)
    If $attrib Then
        $string &= $attrib
    Else
        $string &= '---'
    EndIf
    If $Vista_7 And _IsJunction($sPath) Then
        $string &= 'J'
    EndIf
    Return $string
EndFunc
;
Func _GetFileProperties($sPath)
    If Not $sPath Then Return 'File Not Found|---|---|---'
    Local $a, $s, $t, $b = '---|'
    $t = FileGetVersion($sPath, 'CompanyName')
    If StringRegExp($t, '(?i)[A-Z1-9]') Then
        $s = $t & '|'
    Else
        $s = $b
    EndIf
    $t = FileGetVersion($sPath)
    If StringRegExp($t, '[1-9]') Then
        $s &= $t & '|'
    Else
        $s &= $b
    EndIf
    $t = FileGetVersion($sPath, 'FileDescription')
    If StringRegExp($t, '(?i)[A-Z1-9]') Then
        $s &= $t & '|'
    Else
        $s &= $b
    EndIf
    $a = FileGetTime($sPath, 1)
    If Not IsArray($a) Then Return $s & '---'
    $s &= $a[1] & '/' & $a[2] & '/' & $a[0]
    Return $s
EndFunc
;
Func _FilePropertiesEx()
    Local $aItems = StringSplit(StringTrimRight(GUICtrlRead(GUICtrlRead($id_FROM)), 1), '|')
    If $aItems[0] <> 7 Then Return
    Local $sPath = $aItems[1]
    If StringInStr($sPath, 'HKEY', 0, 1, 1, 4) Then Return
    If StringInStr($aItems[7], 'D') Then Return
    $sPath = Reg_GetFriendlyPath($sPath, 1)
    If Not $sPath Then Return MsgBox(8256, $sTitle & ' - Extended Properties', 'File Not Found')
    Local $t, $s = $sPath & @CRLF & @CRLF
    $t = FileGetVersion($sPath, 'CompanyName')
    If $t Then $s &= 'CompanyName: ' & $t & @CRLF
    $t = FileGetVersion($sPath, 'FileDescription')
    If $t Then $s &= 'Description: ' & $t & @CRLF
    $t = FileGetVersion($sPath, 'ProductName')
    If $t Then $s &= 'ProductName: ' & $t & @CRLF
    $t = FileGetVersion($sPath, 'LegalCopyright')
    If $t Then $s &= 'Copyright: ' & $t & @CRLF
    $t = FileGetVersion($sPath)
    If Not StringInStr($t, '0.0.0.0') Then $s &= 'Version: ' & $t & @CRLF
    Local $fgt = FileGetTime($sPath, 1)
    If Not IsArray($fgt) Then Return MsgBox(8256, $sTitle & ' - Extended Properties', $s)
    $s &= 'Date Created: ' & $fgt[1] & '/' & $fgt[2] & '/' & $fgt[0] & @CRLF
    $s &= 'Attributes: ' & FileGetAttrib($sPath) & @CRLF
    $t = GetByteFormat(FileGetSize($sPath))
    If $t Then $s &= 'File Size: ' & $t & @CRLF
    MsgBox(8256, $sTitle & ' - Extended Properties', $s)
EndFunc
;
Func _WindowsProperties()
    Local $aItems = StringSplit(StringTrimRight(GUICtrlRead(GUICtrlRead($id_FROM)), 1), '|')
    If $aItems[0] <> 7 Then Return
    Local $sPath = $aItems[1]
    If StringInStr($sPath, 'HKEY', 0, 1, 1, 4) Then Return
    If Not StringInStr($aItems[7], 'D') Then
        $sPath = Reg_GetFriendlyPath($sPath, 1)
    EndIf
    If Not $sPath Then Return MsgBox(8256, $sTitle & ' - Windows Properties', 'File Not Found')
    ;<== "http://msdn.microsoft.com/en-us/library/bb762231(VS.85).aspx" ==========================================#
    DllCall('shell32.dll', 'bool', 'SHObjectProperties', 'hwnd', 0, 'dword', 0x00000002, 'wstr', $sPath, 'wstr', 0)
    ;<============================================================================================================#
    If @error Then MsgBox(8256, $sTitle & ' - Windows Properties', 'oops, something went wrong!')
EndFunc
;
Func Env_GetFriendlyPath($string)
    For $i = 1 To $aENV[0][0]
        If StringInStr($string, $aENV[$i][0]) Then
            $string = StringStripWS(StringReplace($string, $aENV[$i][0], $aENV[$i][1]), 3)
        EndIf
    Next
    Return $string
EndFunc
;
; =====================================================================================
; Function: Reg_GetFriendlyPath()
; Released: July 04, 2011 by ripdad
; Modified: May 17, 2012
; Version:  1.0.6
;
; Description: Extracts a given string taken from the registry and transforms it to
;              something more friendly for various uses - such as FileGetVersion()
;
; Dependencies: FileTool(), Env_GetFriendlyPath()
;
; Example: Yes
; =====================================================================================
Func Reg_GetFriendlyPath($string, $mode = 0)
    If StringInStr($string, '%') Then
        $string = Env_GetFriendlyPath($string)
    EndIf
    If StringRegExp(StringLeft($string, 1), '\W') Then
        $string = StringRegExpReplace($string, '\W+(.*)', '\1')
    EndIf
    $string = StringStripWS(StringReplace($string, '"', ''), 3)
    If $mode = 0 Then Return $string; includes switches, keywords, etc
    ;
    ; The sections below, attempts to make the path proper for (File Properties) and (Jump to...) functions.
    ; Works when $mode is not 0.
    ;
    ; [Setup]
    Local $sFile, $sPath, $sResult, $nExts, $GetNumberOfExtensions = 1, $GetPrimaryPath = 3
    ;
    StringReplace($string, ':\', '')
    If @extended > 1 Then
        $string = StringLeft($string, StringInStr($string, ':\', 0, 2) - 2)
    ElseIf StringInStr($string, ':\') > 3 Then
        $string = StringLeft($string, StringInStr($string, ':\', 0, 1) - 2)
    EndIf
    $string = StringStripWS($string, 3)
    ;
    If StringInStr($string, '\') Then; separate file from path
        $sFile = StringTrimLeft($string, StringInStr($string, '\', 0, -1))
        $sPath = StringLeft($string, StringInStr($string, '\', 0, -1) - 1) & '\'
    Else
        $sFile = $string
        $sPath = ''
    EndIf
    ;
    $sFile = StringRegExpReplace($sFile, '[\/\,]', '|'); tag switches and commas
    If StringInStr($sFile, '|') Then; extract from 1st occurrence of a pipe
        $sFile = StringStripWS(StringLeft($sFile, StringInStr($sFile, '|', 0, 1) - 1), 3)
    EndIf
    ;
    $nExts = FileTool($sFile, $GetNumberOfExtensions)
    $string = $sPath & $sFile; reassemble path and file
    ; [/Setup]
    ;
    If $sPath And Not $nExts Then
        If StringInStr(StringRight($string, 4), '.', 0, 1, 1, 1) Then Return $string
    EndIf
    ;
    ; Attempt to extract path from $string in order of risk
    ;
    ; [Attempt 1]
    If $nExts Then; this file has one "known" executable extension
        $sResult = FileTool($string, $GetPrimaryPath); extract path from string
        If $sResult Then Return $sResult
        Return SetError(-1, 0, ''); file not found
    EndIf
    ;
    ; We are working with a file that has no extension from here.
    ;
    ; [Attempt 2]
    $sFile = StringReplace($sFile, ' -', '|'); tag '-' switches in $sFile
    If StringInStr($sFile, '|') Then; extract string from 1st occurrence
        $sFile = StringStripWS(StringLeft($sFile, StringInStr($sFile, '|', 0, 1) - 1), 3)
    EndIf
    $string = $sPath & $sFile & '.exe'
    $sResult = FileTool($string, $GetPrimaryPath)
    If $sResult Then Return $sResult
    ;
    ; [Attempt 3]
    $string = '(?i)( auto| delay| hide| hidden| max| min| run| wait)'
    $sFile = StringRegExpReplace($sFile, $string, '|'); tag keywords
    If StringInStr($sFile, '|') Then; extract string from 1st occurrence
        $sFile = StringStripWS(StringLeft($sFile, StringInStr($sFile, '|', 0, 1) - 1), 3)
    EndIf
    $string = $sPath & $sFile & '.exe'
    $sResult = FileTool($string, $GetPrimaryPath)
    If $sResult Then Return $sResult
    ;
    Return SetError(-2, 0, ''); file not found
EndFunc
;
; =====================================================================================
; Function: FileTool()
; Released: July 04, 2011 by ripdad
; Modified: May 23, 2012 - changed $sSysPath string for x64
; Version:  1.0.2
;
; Description: Has several abilities working with files and extensions.
;
; $nMode values:
;     1 = (Returns a number) of all "Defined Extensions" found in a string (Default)
;     2 = (Returns an array) of all "Defined Extensions" found in a string
;     3 = (Returns a string) of the first path found in a string
;
; Dependencies: None
;
; Example: Yes
; =====================================================================================
Func FileTool($sInput, $nMode = 1)
    Local $sPath, $sFile
    If StringInStr($sInput, '\') Then
        $sFile = StringTrimLeft($sInput, StringInStr($sInput, '\', 0, -1))
        $sPath = StringLeft($sInput, StringInStr($sInput, '\', 0, -1) - 1) & '\'
    Else
        $sFile = $sInput
        $sPath = ''
    EndIf
    Local $aExt = StringRegExp($sFile, '(?i)(\.exe|\.bat|\.cmd|\.com|\.msi|\.scr)', 3)
    If Not IsArray($aExt) Then Return SetError(-1, 0, 0); no matched extension found
    Local $nExt = UBound($aExt)
    If $nMode = 1 Then Return SetError(0, 0, $nExt); number of extensions
    If $nMode = 2 Then Return SetError(0, 0, $aExt); array of extensions
    Local $sDrvPath, $sSysPath, $sWinPath, $sExt, $nOS
    If $nMode = 3 Then; extract the path and check if it exist
        $sExt = $aExt[$nExt - 1]; get the last extension in string
        StringReplace($sFile, $sExt, ''); count occurrences of last extension in string
        $nOS = @extended; number of occurrences
        $sFile = StringStripWS(StringLeft($sFile, StringInStr($sFile, $sExt, 0, $nOS) + 3), 3); extract filename
        If StringInStr($sPath, '\') Then; string has a path
            $sPath &= $sFile; reassemble path and file
            If FileExists($sPath) Then Return SetError(0, 0, $sPath); file found
            Return SetError(-2, 0, 0); file not found
        Else; <-- this string has no path, so try system paths below
            $sDrvPath = @HomeDrive & '\' & $sFile
            $sSysPath = @WindowsDir & '\System32\' & $sFile
            $sWinPath = @WindowsDir & '\' & $sFile
            If FileExists($sWinPath) Then
                If FileExists($sSysPath) Then Return SetError(-3, 0, 0); multi-path
                If FileExists($sDrvPath) Then Return SetError(-4, 0, 0); multi-path
                Return SetError(0, 0, $sWinPath)
            ElseIf FileExists($sSysPath) Then
                If FileExists($sDrvPath) Then Return SetError(-5, 0, 0); multi-path
                Return SetError(0, 0, $sSysPath)
            ElseIf FileExists($sDrvPath) Then
                Return SetError(0, 0, $sDrvPath)
            Else
                Return SetError(-6, 0, 0); file not found
            EndIf
        EndIf
    EndIf
    Return SetError(-7, 0, 0); invalid mode
EndFunc
;
Func _Jump2Path()
    Local $aItems = StringSplit(StringTrimRight(GUICtrlRead(GUICtrlRead($id_FROM)), 1), '|')
    If ($aItems[0] <> 7) And ($nState <> 0) Then Return
    Local $sKey, $sItem = $aItems[1]

    If StringInStr($sItem, 'HKEY', 0, 1, 1, 4) Then
        ;====================================================================================
        ; modified tidbit from GEOSoft --> "http://www.autoitscript.com/forum/topic/91906-open-regedit-at-a-particular-key/page__p__661225__hl__%22open+regedit%22__fromsearch__1#entry661225"
        If ProcessExists('regedit.exe') Then
            WinClose('Registry Editor')
            Sleep(20)
            If ProcessExists('regedit.exe') Then
                ProcessClose('regedit.exe')
                Sleep(20)
            EndIf
        EndIf
        $sKey = $HKCU & '\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit'
        If $OSA64 Then $sItem = StringReplace($sItem, '64\', '\'); Won't work if RootKey64 is in "LastKey" value.
        If RegWrite($sKey, 'LastKey', 'Reg_SZ', 'Computer\' & $sItem) Then; "My Computer" won't work on Win7 ("Computer" or "Machine" works on XP & Win7)
            Sleep(20)
            ShellExecute('regedit.exe')
        EndIf;===============================================================================
        Return
    ElseIf ($nState = 0) Then
        Return
    EndIf

    If Not StringInStr($aItems[7], 'D') Then
        $sItem = Reg_GetFriendlyPath($sItem, 1)
    EndIf
    If Not FileExists($sItem) Then Return

    Local $sMsg, $dir = 0, $attrib = FileGetAttrib($sItem); get original attributes
    If StringInStr($attrib, 'D') Then $dir = 1; if a folder
    If StringInStr($attrib, 'H') Then; if hidden
        $sMsg = $sItem & ' [' & $attrib & ']' & @CRLF & @CRLF & 'Remove Hidden Attribute?' & @TAB & @TAB
        If MsgBox(8228, 'This Item is Hidden', $sMsg) = 6 Then; permission to remove Hidden Attribute
            $attrib = StringRegExpReplace($attrib, 'D|H', ''); cannot set "D", so remove with "H" also
            FileSetAttrib($sItem, '+' & $attrib & '-H'); set original attributes, minus Hidden
        EndIf
    EndIf

    If $dir Then; item is a folder
        ShellExecute(@WindowsDir & '\Explorer.exe', '/e,"' & $sItem & '"')
    Else; item is a file
        ShellExecute(@WindowsDir & '\Explorer.exe', '/e,/select,"' & $sItem & '"')
    EndIf
EndFunc
;
Func _ItemDelete()
    Local $IdCtrl = GUICtrlRead($id_LV1)
    Local $aItems = StringSplit(StringTrimRight(GUICtrlRead($IdCtrl), 1), '|')
    If $aItems[0] <> 7 Then Return
    Local $sItem = $aItems[2], $attribute = $aItems[7]

    If StringRegExp($attribute, '(D|K)') Then
        MsgBox(8240, $sTitle, 'Cannot Delete Keys or Folders' & @TAB)
        Return
    EndIf

    Local $msg, $sPath, $Winlogon
    ;
    For $i = $IdCtrl To $nTLvID Step -1
        $aItems = StringSplit(StringTrimRight(GUICtrlRead($i), 1), '|')
        If $aItems[0] <> 7 Then Return
        If StringInStr($aItems[7], 'D') Or StringInStr($aItems[7], 'K') Then
            $sPath = $aItems[1]
            ExitLoop
        Else
            ContinueLoop
        EndIf
    Next
    ;
    If StringInStr($sPath, 'HKEY', 0, 1, 1, 4) Then
        If StringInStr($sPath, 'Microsoft\Windows NT\CurrentVersion\Winlogon') Then $Winlogon = $sPath
        ;
        ; If registry entry is system critical... the section below will automatically make it right
        If $Winlogon Then
            If MsgBox(8228, 'Restore the Default Registry Entry?', $Winlogon & '-->' & $sItem) <> 6 Then Return
            If $sItem = 'Userinit' Then
                If StringInStr($Winlogon, 'Wow6432Node') And StringInStr($Winlogon, $HKLM) Then
                    RegWrite($Winlogon, 'Userinit', 'REG_SZ', 'userinit.exe')
                ElseIf StringInStr($Winlogon, $HKCU) Then
                    RegDelete($Winlogon, 'Userinit')
                ElseIf StringInStr($Winlogon, $HKLM) Then
                    RegWrite($Winlogon, 'Userinit', 'REG_SZ', @WindowsDir & '\System32\userinit.exe,')
                EndIf
            ElseIf $sItem = 'Shell' Then
                If StringInStr($Winlogon, 'Wow6432Node') And StringInStr($Winlogon, $HKLM) Then
                    RegWrite($Winlogon, 'Shell', 'REG_SZ', 'explorer.exe')
                ElseIf StringInStr($Winlogon, $HKCU) Then
                    RegDelete($Winlogon, 'Shell')
                ElseIf StringInStr($Winlogon, $HKLM) Then
                    RegWrite($Winlogon, 'Shell', 'REG_SZ', 'explorer.exe')
                EndIf
            ElseIf $sItem = 'UIHost' Then
                If StringInStr($Winlogon, 'Wow6432Node') And StringInStr($Winlogon, $HKLM) Then
                    RegDelete($Winlogon, 'UIHost')
                ElseIf StringInStr($Winlogon, $HKCU) Then
                    RegDelete($Winlogon, 'UIHost')
                ElseIf $Vista_7 And StringInStr($Winlogon, $HKLM) Then
                    RegDelete($Winlogon, 'UIHost')
                ElseIf (Not $Vista_7) And StringInStr($Winlogon, $HKLM) Then
                    RegWrite($Winlogon, 'UIHost', 'REG_EXPAND_SZ', 'logonui.exe')
                EndIf
            EndIf
        Else; hopefully, below is not system critcal, so be careful!
            If MsgBox(8228, 'Delete Registry Entry?', $sPath & '-->' & $sItem) <> 6 Then Return
            RegDelete($sPath, $sItem)
        EndIf
    Else
        If StringInStr($sItem, ':') Then
            $sPath = $sItem
        Else
            $sPath &= '\' & $sItem
        EndIf
        If StringInStr(StringRight($sItem, 3), 'lnk') Then
            $msg = 'Delete this Shortcut'
        Else
            $msg = 'Delete this File'
        EndIf
        If FileExists($sPath) Then
            If MsgBox(8228, $msg & '?', $sPath) <> 6 Then Return
            FileSetAttrib($sPath, '-RASHNOT')
            If Not FileDelete($sPath) Then MsgBox(8240, $sTitle, 'Cannot ' & $msg & ':' & @CRLF & $sPath)
        Else
            MsgBox(8240, $sTitle, 'File Not Found:' & @CRLF & $sPath)
        EndIf
    EndIf
    Sleep(250)
    _StartupList(); refresh
EndFunc
;
Func GetSystemInfo()
    Local $string
    If $nWMI Then
        $string = _WMI_SystemInfo(); Primary Action
        If Not @error Then Return $string
    EndIf

    ; Secondary Action
    Local $eMsg = '[System Information]' & @CRLF & 'Error|Could Not Obtain SystemInfo' & @CRLF
    Local $exePath = @WindowsDir & '\System32\systeminfo.exe'
    Local $comPath = @WindowsDir & '\System32\systeminfo.com'
    Local $cp, $pid, $stdout = ''
    ;
    If Not FileExists($exePath) Then Return $eMsg
    ;
    $pid = Run($exePath, '', @SW_HIDE, 6)
    If Not $pid Then
        $cp = FileCopy($exePath, $comPath)
        If $cp Then
            $pid = Run($comPath, '', @SW_HIDE, 6)
        EndIf
        If Not $pid Then
            If $cp Then FileDelete($comPath)
            Return $eMsg
        EndIf
    EndIf
    ;
    Do
        Sleep(10)
        $stdout &= StdoutRead($pid, 0, 0)
    Until @error
    ;
    If $cp Then FileDelete($comPath)
    If Not StringExists($stdout) Then Return $eMsg
    ;
    Local $sFormatted, $sLeft, $sRight, $string
    $stdout = StringReplace($stdout, '[', '(')
    $stdout = StringReplace($stdout, ']', ')')
    $stdout = StringStripCR($stdout)
    Local $a = StringSplit($stdout, @LF)
    ;
    For $i = 1 To $a[0]
        $string = StringStripWS($a[$i], 3)
        If StringExists($string) Then
            If StringInStr($string, ':') Then
                $sLeft = StringStripWS(StringLeft($string, StringInStr($string, ':', 0, 1)), 3) & '|'
                $sRight = StringStripWS(StringTrimLeft($string, StringInStr($string, ':', 0, 1)), 3)
                $sFormatted &= $sLeft & $sRight & @CRLF
            Else
                $sFormatted &= $string & ':' & @CRLF
            EndIf
        EndIf
    Next
    Return $sFormatted
EndFunc
;
;====================================================================
; #Function _WMI_SystemInfo()
;
; Specific Properties Example:
; Local $Pattern = 'Caption|CSDVersion|CSName|InstallDate|Name|Organization|RegisteredUser|SerialNumber|TotalVisibleMemorySize|Version'
; Local $s = _WMI_InstancesOf('Win32_OperatingSystem', $Pattern)
;
; Use of this symbol ^ defines a NOT statement. (see examples below)
;====================================================================
Func _WMI_SystemInfo()
    Local $s = _WMI_InstancesOf('Win32_OperatingSystem')
    If @error Then Return SetError(-1)
    $s &= _WMI_InstancesOf('Win32_ComputerSystem', '^OEMLogoBitmap|PauseAfterReset')
    $s &= _WMI_InstancesOf('Win32_ComputerSystemProduct', '^Caption|Description')
    $s &= _WMI_InstancesOf('Win32_SystemEnclosure', '^Caption|Description')
    $s &= _WMI_InstancesOf('Win32_BaseBoard', '^Caption|Description')
    $s &= _WMI_InstancesOf('Win32_BIOS', '^BiosCharacteristics|Caption|Description', 1)
    $s &= _WMI_InstancesOf('Win32_PhysicalMemory', '^Caption|Description', 1)
    $s &= _WMI_InstancesOf('Win32_Processor', 0, 1)
    $s &= _WMI_InstancesOf('Win32_VideoController', 0, 1)
    $s &= _WMI_InstancesOf('Win32_DesktopMonitor Where Status="OK"', '^Caption|Description', 1)
    $s &= _WMI_InstancesOf('Win32_PnPEntity Where PNPDeviceID Like "DISPLAY%"', 0, 1)
    $s &= _GetDisplayEDID(1)
    $s &= _WMI_InstancesOf('Win32_DiskDrive', '^BytesPerSector|Capabilities', 1)
    $s &= _WMI_InstancesOf('Win32_LogicalDisk', 0, 1)
    $s &= _WMI_InstancesOf('Win32_CDROMDrive Where Status="OK"', '^Availability|Capabilities', 1)
    $s &= _WMI_InstancesOf('Win32_NetworkAdapter Where NetConnectionID>"0"', '^Description', 1)
    $s &= _WMI_InstancesOf('Win32_NetworkAdapterConfiguration Where IPEnabled="True"', 0, 1)
    $s &= _WMI_InstancesOf('Win32_SoundDevice Where Status="OK"', 0, 1)
    $s &= _WMI_InstancesOf('Win32_Keyboard Where Status="OK"', '^Caption|Description', 1)
    $s &= _WMI_InstancesOf('Win32_PointingDevice Where Status="OK"', 0, 1)
    $s &= _WMI_QuickFixEngineering()
    $nAdv = 0
    Return $s
EndFunc
;
; _WMI_InstancesOf() - ver.0.7 - July 15, 2012 - by ripdad
Func _WMI_InstancesOf($sClass, $sPattern = 0, $iItemize = 0, $iFormat = 0, $sNameSpace = 'CIMV2')
    ; gui - progress bar ======
    $nAdv += 6
    GUICtrlSetData($prb, $nAdv)
    ; =========================

    Local $a = StringRegExp($sClass, '^(\w+)(\W)', 3); check for GET enumeration string
    If IsArray($a) Then
        If Not StringIsSpace($a[1]) Then
            MsgBox(8240, '_WMI_InstancesOf', 'Unsupported Class String' & @TAB)
            Return SetError(-1, 0, '')
        EndIf
    EndIf

    $a = StringRegExp($sClass, '[^\w\.:=<>%" '']', 3); check for invalid characters
    If IsArray($a) Then
        MsgBox(8240, '_WMI_InstancesOf', 'Invalid Character in Class String -->   ' & $a[0] & @TAB)
        Return SetError(-2, 0, '')
    EndIf

    Local $sWMI_Moniker = 'Winmgmts:{ImpersonationLevel=Impersonate,AuthenticationLevel=PktPrivacy,(Debug,Restore,Security)}!\\.\root\'
    Local $objWMI = ObjGet($sWMI_Moniker & $sNameSpace)
    If @error Or Not IsObj($objWMI) Then Return SetError(-3, 0, '')

    Local $objInstances = $objWMI.InstancesOf($sClass)
    Local $count = $objInstances.Count
    If @error Or Not $count Then Return SetError(-4, 0, '')

    $sClass = StringRegExpReplace($sClass, '(?i)(.*?)\W.*', '\1')
    Local $objClass = $objWMI.Get($sClass, 0x20000); wbemFlagUseAmendedQualifiers
    If @error Or Not IsObj($objClass) Then Return SetError(-5, 0, '')

    Local $sp_dt1 = '(\d{4})(\d{2})(\d{2})(\d{2})(\d{2})(\d{2})', $sp_dt2 = '\2/\3/\1 - \4:\5:\6'
    Local $Name, $Value, $Q_Item, $Q_Name, $string = ''
    Local $n = 0, $aVM = 0, $nVM = 0
    ;
    Local $pStatementMode = 1;Normal Statement Mode
    If StringInStr($sPattern, '^', 0, 1, 1, 1) Then
        $sPattern = StringTrimLeft($sPattern, 1)
        $pStatementMode = 2;NOT Statement Mode
    EndIf
    ;
    $Suppress_ErrorMsg = 1
    For $objInstance In $objInstances
        If $iItemize Then; set itemize format - x/y
            $n += 1
            $string &= '(' & $n & ')'
            If ($iItemize = 1) Then
                $string &= '^'
            EndIf
        EndIf
        ;
        For $objProperty In $objInstance.Properties_()
            $Name = $objProperty.Name

            ; [Filter]
            Switch $Name
                Case 'CreationClassName', 'CSCreationClassName', 'SystemCreationClassName', 'SystemName'
                    ContinueLoop
                Case Else
                    If $sPattern Then
                        If StringMatch($Name, $sPattern, $pStatementMode) Then ContinueLoop
                    EndIf
                    $Value = $objProperty.Value
                    $Value = _WMI_ProcessItem($Value)
                    If Not StringLen($Value) Then ContinueLoop
            EndSwitch; [/Filter]

            ; [Process Data Types]
            For $objQualifier In $objClass.Properties_($Name).Qualifiers_()
                $Q_Name = $objQualifier.Name
                $Q_Item = $objQualifier.Value

                Switch $Q_Name
                    Case 'CIMType'
                        If ($Q_Item = 'DateTime') Then
                            If StringRegExp($Value, '(\d{14}\.\d{6}\W\d{1,4})') Then
                                $Value = StringLeft($Value, 14)
                                $Value = StringRegExpReplace($Value, $sp_dt1, $sp_dt2)
                            EndIf
                        EndIf
                    Case 'Units'
                        Switch $Q_Item
                            Case 'Bytes', 'KiloBytes', 'MegaBytes'
                                $Value = GetByteFormat($Value, $Q_Item)
                            Case Else
                                $Value &= ' ' & $Q_Item
                        EndSwitch
                    Case 'ValueMap'
                        If IsArray($Q_Item) And UBound($Q_Item) Then
                            $aVM = $Q_Item
                            $nVM = 1
                        EndIf
                    Case 'Values'; [Value Translation] - translated values appear in this format:  3=(Enabled)
                        If IsArray($Q_Item) And UBound($Q_Item) Then
                            If $nVM And StringIsDigit($Value) Then; [VT1] <- value is a number with a valuemap
                                If UBound($Q_Item) = UBound($aVM) Then
                                    For $i = 0 To UBound($Q_Item) - 1
                                        If ($Value = $aVM[$i]) Then
                                            $Value &= '=(' & $Q_Item[$i] & ')'
                                            ExitLoop
                                        EndIf
                                    Next
                                EndIf
                            ElseIf StringIsDigit($Value) Then;      [VT2] <- value is a number with no valuemap
                                For $i = 0 To UBound($Q_Item) - 1
                                    If ($Value = $i) Then
                                        $Value &= '=(' & $Q_Item[$i] & ')'
                                        ExitLoop
                                    EndIf
                                Next
                            ElseIf StringInStr($Value, ', ') Then;  [VT3] <- value is a comma delimited string
                                $a = StringSplit($Value, ', ', 1)
                                If StringIsDigit($a[1]) Then
                                    For $i = 1 To $a[0]
                                        For $j = 0 To UBound($Q_Item) - 1
                                            If ($a[$i] = $j) Then
                                                $Value &= '^¦' & $a[$i] & '=(' & $Q_Item[$j] & ')'
                                            EndIf
                                        Next
                                    Next
                                EndIf
                            EndIf
                        EndIf
                        $nVM = 0; [/Value Translation]
                    Case Else
                EndSwitch
            Next; [/Process Data Types]

            ; Skip values that return "Unknown"
            If StringInStr($Value, '=(Unknown)') Or $Value == -1 Then
                ; do nothing, let it go
            Else
                $string &= $Name & '¦' & $Value & '^'
            EndIf

        Next
        $string &= '^'
    Next
    If _WMI_ObjectError(1) Then Return SetError(-13, 0, '')

    $objInstances = ''
    $objClass = ''
    $objWMI = ''

    $string = StringStripWS($string, 7)
    If Not $string Then Return SetError(-6, 0, '')

    $string = '<--' & $sClass & '^' & $string
    $string = StringReplace($string, @TAB, ' - ')
    $string = StringReplace($string, '^', @CRLF)
    $string = StringReplace($string, '|', ', ')
    $string = StringReplace($string, '¦', '|')
    Return $string
EndFunc
;
; _WMI_MiniInstancesOf() - ver.0.1 - July 19, 2012 - by ripdad
Func _WMI_MiniInstancesOf($sClass, $sPattern = 0, $sNameSpace = 'CIMV2')
    Local $sWMI_Moniker = 'Winmgmts:{ImpersonationLevel=Impersonate,AuthenticationLevel=PktPrivacy,(Debug,Restore,Security)}!\\.\root\'
    Local $objWMI = ObjGet($sWMI_Moniker & $sNameSpace)
    If @error Or Not IsObj($objWMI) Then Return SetError(-1, 0, '')

    Local $objInstances = $objWMI.InstancesOf($sClass)
    Local $count = $objInstances.Count
    If @error Or Not $count Then Return SetError(-2, 0, '')

    Local $Name, $oi_Name, $Value, $s, $n = 0, $string = ''
    ;
    $Suppress_ErrorMsg = 1
    For $objInstance In $objInstances
        $oi_Name = $objInstance.Name

        $n += 1
        If ($n > 100) Then $n = 0
        GUICtrlSetData($prb, $n)
        ;
        For $objProperty In $objInstance.Properties_()
            $Name = $objProperty.Name

            If $sPattern Then
                If StringMatch($Name, $sPattern, 1) Then ContinueLoop
            EndIf

            $Value = $objProperty.Value
            $Value = _WMI_ProcessItem($Value)
            If Not StringLen($Value) Then ContinueLoop

            If StringMatch($s, $oi_Name) Then
                $string &= '|' & $Value
            Else
                $s = $oi_Name
                $string &= '¦' & $Value
            EndIf
        Next
    Next
    If _WMI_ObjectError(1) Then Return SetError(-3, 0, '')

    $objInstances = ''
    $objWMI = ''

    $string = StringStripWS($string, 7)
    If Not $string Then Return SetError(-4, 0, '')

    $string = StringTrimLeft($string, 1)
    Local $a = StringSplit($string, '¦')
    _ArraySort($a, 0, 1)
    $string = ''
    Return $a
EndFunc
;
Func _Drivers_Services()
    If Not $nWMI Then Return NoWMI()

    Local $sText = GUICtrlRead(@GUI_CtrlId, 1)
    Local $a, $array, $attributes, $id_Item, $sClass, $sPath

    Switch $sText
        Case 'Loaded Drivers'
            $sClass = 'Win32_SystemDriver'
        Case 'Running Services'
            $sClass = 'Win32_Service'
    EndSwitch

    GCS_CreateListView($id_LV1, $sText & '|Registry Name|Company Name|Version|File Description|Created|Attributes')

    $array = _WMI_MiniInstancesOf($sClass & ' Where State="Running"', 'DisplayName|PathName')
    If @error Then Return _WMI_ObjectError(-1)

    For $i = 1 To $array[0]
        GUICtrlSetData($prb, ($i / $array[0]) * 100)
        $a = StringSplit($array[$i], '|')

        $sPath = $a[2]
        If ($sClass = 'Win32_Service') And StringInStr($sPath, 'svchost') Then
            If Not StringInStr($sPath, 'svchost.exe') Then
                $sPath = StringReplace($sPath, 'svchost', 'svchost.exe')
            EndIf
        EndIf

        $a[2] = Reg_GetFriendlyPath($sPath, 0)
        $sPath = Reg_GetFriendlyPath($a[2], 1)
        $attributes = FileGetAttrib($sPath)
        $a[2] &= '|' & $a[1] & '|' & _GetFileProperties($sPath) & '|' & $attributes
        GUICtrlSetData($id_LV1, $sText & ': ' & $i)
        $id_Item = GUICtrlCreateListViewItem($a[2], $id_LV1)
        If StringInStr($attributes, 'H') Then GUICtrlSetBkColor($id_Item, 0xFFB0B0)
    Next

    LV_SetColumnWidth($id_LV1, '300,400|120,150|130,130|100,100|210,250|70,80|70,80')

    GUICtrlSetState($id_LV1, $GUI_FOCUS)
    GUICtrlSetState($id_LV1, $GUI_SHOW)
    GUICtrlSetData($prb, 0)
    $nState = 3
EndFunc
;
Func _WMI_QuickFixEngineering()
    Local $objWMI = ObjGet($sWMI_Moniker)
    Local $objClass = $objWMI.InstancesOf('Win32_QuickFixEngineering')
    Local $s = '<--Win32_QuickFixEngineering' & @CRLF
    Local $std, $str, $c = 0
    ;
    $Suppress_ErrorMsg = 1
    For $objItem In $objClass
        $str = $objItem.HotFixID
        If StringExists($str) And Not StringInStr($str, 'File 1') Then; (nothing useful for "File 1")
            $std = $objItem.InstalledOn
            If StringInStr($std, '/') Then
                $str &= ':|' & $std
            EndIf
            $c += 1
            $s &= '(' & $c & ')  -  ' & $str & @CRLF
        EndIf
    Next
    If _WMI_ObjectError(1) Then Return ''
    ;
    $objClass = ''
    $objWMI = ''
    Return $s
EndFunc
;
; _WMI_GetATAPISmartData - v0.9.GCS.01 by ripdad
Func _WMI_GetATAPISmartData()
    If Not $nWMI Then Return NoWMI()

    Local $a[76][2] = [[75, 'Attribute Name'], _
            [1, 'ReadErrorRate'], _
            [2, 'ThroughputPerformance'], _
            [3, 'SpinUpTime'], _
            [4, 'StartStopCount'], _
            [5, 'ReallocatedSectorsCount/SSDRetiredBlockCount'], _
            [6, 'ReadChannelMargin'], _
            [7, 'SeekErrorRate'], _
            [8, 'SeekTimePerformance'], _
            [9, 'PowerOnHours(POH)'], _
            [10, 'SpinRetryCount'], _
            [11, 'CalibrationRetryCount'], _
            [12, 'PowerCycleCount'], _
            [13, 'SoftReadErrorRate'], _
            [170, 'SSDReservedBlockCount'], _
            [171, 'SSDProgramFailBlockCount'], _
            [172, 'SSDEraseFailBlockCount'], _
            [173, 'SSDWearLevelingCount'], _
            [174, 'SSDUnexpectedPowerLossCount'], _
            [175, 'SSDProgramFailCount(Chip)'], _
            [176, 'SSDEraseFailCount(Chip)'], _
            [177, 'SSDWearRangeDelta/SSDWearLevelingCount'], _
            [178, 'SSDUsedReservedBlockCount(Chip)'], _
            [179, 'SSDUsedReservedBlockCount'], _
            [180, 'BlockCountTotal/SSDUnusedReservedBlockCount'], _
            [181, 'SSDProgramFailCount'], _
            [182, 'SSDEraseFailCount'], _
            [183, 'SATADownshiftErrorCount/SSDRuntimeBadBlock'], _
            [184, 'EndtoEnderror'], _
            [185, 'HeadStability'], _
            [186, 'InducedOpVibrationDetection'], _
            [187, 'ReportedUncorrectableErrors/SSDUncorrectableErrorCount'], _
            [188, 'CommandTimeout'], _
            [189, 'HighFlyWrites'], _
            [190, 'AirflowTemperatureWDC/TemperatureDifferenceFrom100'], _
            [191, 'GSenseErrorRate'], _
            [192, 'PoweroffRetractCount'], _
            [193, 'LoadCycleCount'], _
            [194, 'Temperature'], _
            [195, 'HardwareECCRecovered/SSDECCOnTheFlyCount'], _
            [196, 'ReallocationEventCount'], _
            [197, 'CurrentPendingSectorCount'], _
            [198, 'UncorrectableSectorCount/SSDOffLineUncorrectableErrorCount'], _
            [199, 'UltraDMACRCErrorCount/SSDCRCErrorCount'], _
            [200, 'MultiZoneErrorRate/WriteErrorRate'], _
            [201, 'OffTrackSoftReadErrorRate/SSDUncorrectableSoftReadErrorRate'], _
            [202, 'DataAddressMarkErrors'], _
            [203, 'RunOutCancel'], _
            [204, 'SSDSoftECCCorrection'], _
            [205, 'ThermalAsperityRate(TAR)'], _
            [206, 'FlyingHeight'], _
            [207, 'SpinHighCurrent'], _
            [208, 'SpinBuzz'], _
            [209, 'OfflineSeekPerformance'], _
            [210, 'VibrationDuringWrite'], _
            [211, 'VibrationDuringWrite'], _
            [212, 'ShockDuringWrite'], _
            [220, 'DiskShift'], _
            [221, 'GSenseErrorRateAlt'], _
            [222, 'LoadedHours'], _
            [223, 'LoadUnloadRetryCount'], _
            [224, 'LoadFriction'], _
            [225, 'LoadUnloadCycleCount'], _
            [226, 'LoadInTime'], _
            [227, 'TorqueAmplificationCount'], _
            [228, 'PowerOffRetractCycle'], _
            [230, 'GMRHeadAmplitude/SSDLifeCurveStatus'], _
            [231, 'SSDLifeLeft/Temperature'], _
            [232, 'AvailableReservedSpace/EnduranceRemaining'], _
            [233, 'MediaWearoutIndicator/PowerOnHours'], _
            [234, 'SSDReservedVS'], _
            [240, 'HeadFlyingHours/TransferErrorRate'], _
            [241, 'SSDLifeTimeWritesFromHost/TotalLBAsWritten'], _
            [242, 'SSDLifeTimeReadsFromHost/TotalLBAsRead'], _
            [250, 'ReadErrorRetryRate'], _
            [254, 'FreeFallProtection']]

    ; VSD = VendorSpecificData
    ; Nom/Flag = Nominal Value or Flag
    ; Cycles = Number of Turnovers from "Raw/Value". One Cycle = 256
    ; SumCounts = Dual Meaning, A Play on Words -> SumCounts (The total amount of 2 columns) And SomeCounts (as opposed to AllCounts):
    ;             1) The total of ("Cycles" * 256) + "Raw/Value"
    ;             2) Only the Attribute Names "PowerOnHours(POH)" Or the word "Count" in the string are processed in this column -- Else, it is set to zero.
    Local $aSMART[1][15] = [['Attribute', 'Nom/Flag', 'Status', 'Value/%', 'Worst/%', 'Raw/Value', 'Cycles', 'VSD1', 'VSD2', 'VSD3', 'VSD4', 'VSD5', 'Threshold', 'SumCounts', 'AttributeName']]

    GCS_CreateListView($id_LV1, 'Attribute|Nom/Flag|Status|Value/%|Worst/%|Raw/Value|Cycles|VSD1|VSD2|VSD3|VSD4|VSD5|Threshold|SumCounts|DriveInfo / AttributeName')

    Local $objWMI = ObjGet('Winmgmts:{ImpersonationLevel=Impersonate,AuthenticationLevel=PktPrivacy,(Debug)}!\\.\root\CIMV2')
    If @error Or Not IsObj($objWMI) Then Return _WMI_ObjectError(-1)

    Local $aDriveList[20][4]
    Local $aVendorSpecific, $objClass2, $sPNPDeviceID, $sDriveTitle, $nDevice = -1
    Local $sInstanceName, $string, $n = 0, $offset = 2, $pass = 0, $swap = 0
    Local $id_Item, $PredictFailure, $SSD_Detected = 0

    Local $objClass = $objWMI.InstancesOf('Win32_DiskDrive')
    Local $count = $objClass.Count
    If @error Or Not $count Then Return _WMI_ObjectError(-1)

    $Suppress_ErrorMsg = 1
    For $objItem In $objClass
        $n += 1
        $aDriveList[$n][0] = $objItem.Model
        $aDriveList[$n][1] = $objItem.DeviceID
        $aDriveList[$n][2] = $objItem.Size
        $aDriveList[$n][3] = $objItem.PNPDeviceID
    Next
    If _WMI_ObjectError() Then Return

    $aDriveList[0][0] = $n
    ReDim $aDriveList[$n + 1][4]

    $n = 0

    $objClass = $objWMI.InstancesOf('Win32_LogicalDiskToPartition')
    $count = $objClass.Count
    If @error Or Not $count Then Return _WMI_ObjectError(-1)

    $Suppress_ErrorMsg = 1
    For $objItem In $objClass; Match DeviceID to Drive Letter
        $string = $objItem.Antecedent
        $string = StringRegExpReplace($string, '.*#(\d),.*', '\1')
        If ($string <> $nDevice) Then; Else, drive already processed
            $nDevice = $string

            $n += 1
            If $n > $aDriveList[0][0] Then
                ExitLoop; just in case
            EndIf

            If StringRight($aDriveList[$n][1], 1) = $nDevice Then
                $string = $objItem.Dependent
                $aDriveList[$n][1] &= '=' & StringRight($string, 4)
            EndIf
        EndIf
    Next
    If _WMI_ObjectError() Then Return

    $nAdv = 0

    $objWMI = ObjGet('Winmgmts:{ImpersonationLevel=Impersonate,AuthenticationLevel=PktPrivacy,(Debug)}!\\.\root\WMI')
    If @error Or Not IsObj($objWMI) Then Return _WMI_ObjectError(-1)

    $objClass = $objWMI.InstancesOf('MSStorageDriver_ATAPISmartData')
    $count = $objClass.Count
    If @error Or Not $count Then Return _WMI_ObjectError(-1)

    $Suppress_ErrorMsg = 1
    For $objItem In $objClass
        $aVendorSpecific = $objItem.VendorSpecific
        If @error Or Not IsArray($aVendorSpecific) Then ContinueLoop

        $sInstanceName = $objItem.InstanceName
        $sPNPDeviceID = 0

        For $i = 1 To $aDriveList[0][0]
            $sPNPDeviceID = StringLeft($aDriveList[$i][3], StringLen($aDriveList[$i][3]) - 5)
            If Not $sPNPDeviceID Then ContinueLoop

            If StringInStr($sInstanceName, $sPNPDeviceID) Then
                $sDriveTitle = 'Model: ' & $aDriveList[$i][0] & '  -  DeviceID: ' & $aDriveList[$i][1] & '  -  Size: ' & GetByteFormat($aDriveList[$i][2])
                ExitLoop
            EndIf
        Next

        If Not $sPNPDeviceID Then ContinueLoop

        ReDim $aSMART[1][15]
        ReDim $aSMART[76][15]

        $SSD_Detected = 0
        $n = 0

        For $i = $offset To (UBound($aVendorSpecific) - 1) Step 12
            $nAdv += 1
            If $nAdv > 100 Then $nAdv = 0
            GUICtrlSetData($prb, $nAdv)

            If ($aVendorSpecific[$i] = 0) Then ContinueLoop

            ; SSD Attribute Detection
            ;========================================================
            If StringRegExp($aVendorSpecific[$i], '(17[0-9])') Then
                $SSD_Detected += 1
            EndIf
            ;========================================================

            $n += 1

            For $j = 0 To 11
                $aSMART[$n][$j] = $aVendorSpecific[$i + $j]
                If ($j = 2) Then
                    If ($aSMART[$n][$j] = 0) Then
                        $aSMART[$n][$j] = 'OK'
                    EndIf
                ElseIf ($j = 5) And StringRegExp($aSMART[$n][0], '(190|194)') Then
                    If $aSMART[$n][5] Then
                        $aSMART[$n][5] &= 'C/' & Round(($aSMART[$n][5] * 1.8) + 32) & 'F'
                    EndIf
                EndIf
            Next

            For $j = 1 To $a[0][0]
                If $a[$j][0] = $aVendorSpecific[$i] Then
                    $aSMART[$n][14] = $a[$j][1]
                    If StringInStr($aSMART[$n][14], 'Count') Or ($aSMART[$n][0] = 9) Then
                        $aSMART[$n][13] = ($aSMART[$n][6] * 256) + $aSMART[$n][5]
                    Else
                        $aSMART[$n][13] = 0
                    EndIf
                EndIf
            Next

            ; Unknown Attributes
            ;==========================================
            If Not StringExists($aSMART[$n][14]) Then
                $aSMART[$n][14] = '(UnknownAttribute)'
                $aSMART[$n][13] = 0
            EndIf
            ;==========================================
        Next

        $n = 0

        $objClass2 = $objWMI.InstancesOf('MSStorageDriver_FailurePredictThresholds')
        $count = $objClass2.Count
        If @error Or Not $count Then Return _WMI_ObjectError(-1)

        $Suppress_ErrorMsg = 1
        For $objItem In $objClass2
            $aVendorSpecific = $objItem.VendorSpecific
            If @error Or Not IsArray($aVendorSpecific) Then ContinueLoop

            $sInstanceName = $objItem.InstanceName
            If StringInStr($sInstanceName, $sPNPDeviceID) Then
                For $i = $offset To (UBound($aVendorSpecific) - 1) Step 12
                    $nAdv += 1
                    If $nAdv > 100 Then $nAdv = 0
                    GUICtrlSetData($prb, $nAdv)

                    If $aVendorSpecific[$i] Then
                        $n += 1
                        $aSMART[$n][12] = $aVendorSpecific[$i + 1]
                    EndIf
                Next
                ExitLoop
            EndIf
        Next
        If _WMI_ObjectError() Then Return

        $objClass2 = $objWMI.InstancesOf('MSStorageDriver_FailurePredictStatus')
        $count = $objClass2.Count
        If @error Or Not $count Then Return _WMI_ObjectError(-1)

        $Suppress_ErrorMsg = 1
        For $objItem In $objClass2
            $sInstanceName = $objItem.InstanceName
            If @error Or Not $sInstanceName Then ContinueLoop

            If StringInStr($sInstanceName, $sPNPDeviceID) Then
                $sDriveTitle &= '  -  PredictFailure=' & $objItem.PredictFailure
                ExitLoop
            EndIf
        Next
        If _WMI_ObjectError() Then Return

        ReDim $aSMART[$n + 1][15]

        $id_Item = GUICtrlCreateListViewItem('||||||||||||||' & $sDriveTitle, $id_LV1)
        If ($PredictFailure = True) Then
            GUICtrlSetBkColor($id_Item, 0xFFB0B0); red-ish
        ElseIf $SSD_Detected Then
            GUICtrlSetBkColor($id_Item, 0xFFFF50); yellow-ish
        Else
            GUICtrlSetBkColor($id_Item, 0xC0C0C0); gray-ish
        EndIf

        For $i = 1 To UBound($aSMART) - 1
            $string = ''
            For $j = 1 To 15
                $string &= $aSMART[$i][$j - 1] & '|'
            Next
            GUICtrlCreateListViewItem($string, $id_LV1)
        Next
        ;_ArrayDisplay($aSMART, $sDriveTitle & '|  SSD Attributes Detected: ' & $SSD_Detected)
    Next
    If _WMI_ObjectError() Then Return

    GUICtrlSendMsg($id_LV1, $LVM_SETCOLUMNWIDTH, 14, -1)
    GUICtrlSetState($id_LV1, $GUI_FOCUS)
    GUICtrlSetState($id_LV1, $GUI_SHOW)
    GUICtrlSetData($prb, 0)
    $nState = 0
EndFunc
;
;====================================================================
; #Function....: _GetDisplayEDID()
;..............: Extended Display Identification Data (EDID)
;..............:
; Released.....: (Experimental) June 01, 2012 by ripdad
; Modified.....: June 06, 2012 - Added Win32_PnPEntity
;..............: June 07, 2012 - Added MfgYear
;..............:
; Description..: Attempts to get this info on active monitors:
;..............: the Manufacturer, Model, Serial Number and Year
;..............: in a unordered comma delimited string.
;..............:
;Reference Link:
;  http://en.wikipedia.org/wiki/Extended_display_identification_data
;====================================================================
Func _GetDisplayEDID($n_os = 1);<-- offset
    Local $objWMI = ObjGet('winmgmts:root\cimv2')
    If @error Or Not IsObj($objWMI) Then Return ''; SetError(-1, 0, -1)
    ;Local $objClass = $objWMI.InstancesOf('Win32_DesktopMonitor Where Status="OK"')
    Local $objClass = $objWMI.InstancesOf('Win32_PnPEntity Where PNPDeviceID Like "DISPLAY%"')
    If @error Or Not IsObj($objClass) Then Return ''; SetError(-2, 0, -2)
    Local $sKey = 'HKEY_LOCAL_MACHINE64\SYSTEM\CurrentControlSet\Enum\'
    Local $a, $PNPDeviceID, $s, $y, $str = ''
    If @OSArch = 'X32' Then
        $sKey = StringReplace($sKey, '64', '')
    EndIf
    ;
    For $objItem In $objClass
        $PNPDeviceID = $objItem.PNPDeviceID
        $s = RegRead($sKey & $PNPDeviceID & '\Device Parameters', 'EDID')
        If @error Then ContinueLoop
        $y = ''
        ;
        ; Test if binary string has a proper header
        If (StringLeft($s, 8) = '0x00FFFF') Then; Else, continue without year
            $y = StringMid($s, 37, 2)
            $y = Dec($y)
            $y += 1990
            If ($y > 1996) And ($y <= @YEAR) Then; assume good
                $y = ', MfgYear:' & $y
            Else
                $y = ''
            EndIf
        EndIf
        ;
        $s = BinaryToString(StringLeft($s, 258))
        $s = StringRegExpReplace($s, '[^\w\-]', ',')
        $s = StringRegExpReplace($s, '\,{1,}', ',')
        $a = StringSplit($s, ',')
        $s = ''
        ;
        For $i = $n_os To $a[0]
            If StringLen($a[$i]) > 2 Then
                $s &= $a[$i] & ', '
            EndIf
        Next
        If $s Then
            $s = StringTrimRight($s, 2)
            $str &= $objItem.DeviceID & '|(' & $s & $y & ')' & @CRLF
        EndIf
    Next
    If $str Then
        Return '<--Display_EDID_String' & @CRLF & $str & @CRLF
    EndIf
    Return ''
    ;Return SetError(-3, 0, 'Nothing Found')
EndFunc
;
Func _WMI_ProcessItem($Item); v0.3
    If Not IsArray($Item) Then
        If StringExists($Item) Then
            Return StringStripWS($Item, 3)
        EndIf
        Return ''
    EndIf
    ;
    If Not UBound($Item) Then
        Return ''
    EndIf
    ;
    Local $string = ''
    For $i = 0 To UBound($Item) - 1
        If StringExists($Item[$i]) Then
            $string &= $Item[$i] & ', '
        EndIf
    Next
    ;
    If StringExists($string) Then
        $string = StringTrimRight($string, 2)
        Return StringStripWS($string, 3)
    EndIf
    Return ''
EndFunc
;
;====================================================================
; ProcessList_Extended v2.00.GCS.01 - September 08, 2012 - by ripdad
Func _ProcessList_Extended()
    If Not $nWMI Then Return NoWMI()

    $nState = -1

    GCS_CreateListView($id_LV2, 'Attached Modules|PID|Company Name|Version|File Description|Created|Attributes', 1)
    GCS_CreateListView($id_LV1, 'Running Programs|PID|Company Name|Version|File Description|Created|Attributes')

    $nProcessEvent = 1
    GCS_AutoSizeGUI()

    Local $objWMI = ObjGet($sWMI_Moniker)
    If @error Or Not IsObj($objWMI) Then Return _WMI_ObjectError(-1)
    Local $objClass = $objWMI.InstancesOf('CIM_ProcessExecutable')
    Local $count = $objClass.Count
    If @error Or Not $count Then Return _WMI_ObjectError(-1)

    Local $n = 0, $s = '', $s1 = '', $s2 = '', $s3 = ''
    Local $extension, $id_Item, $nPID, $sPath

    $Suppress_ErrorMsg = 1
    For $objItem In $objClass
        $n += 0.1
        If ($n > 100) Then $n = 0
        GUICtrlSetData($prb, $n)

        $nPID = StringRegExpReplace($objItem.Dependent, '.*"(.*?)"', '\1')
        $sPath = StringRegExpReplace($objItem.Antecedent, '.*"(.*?)"', '\1')
        $sPath = Reg_GetFriendlyPath($sPath)
        $sPath = StringReplace($sPath, '\\', '\')
        $s &= '*' & $sPath & '|' & $nPID
    Next
    If _WMI_ObjectError() Then Return

    $s = StringTrimLeft($s, 1)
    Local $a = StringSplit($s, '*')
    _ArraySort($a, 0, 1)

    $s = ''
    $n = 0

    Local $attributes, $b, $cnt = 0

    For $i = 1 To $a[0]
        $n += 0.2
        If ($n > 100) Then $n = 0
        GUICtrlSetData($prb, $n)

        $sPath = $a[$i]
        $b = StringSplit($sPath, '|')
        $extension = StringRight($b[1], 4)

        If StringRegExp($extension, '(?i)(\.cmd|\.com|\.exe|\.msi|\.scr)') Then
            $cnt += 1
            GUICtrlSetData($id_LV1, 'Running Programs: ' & $cnt)
            $attributes = FileGetAttrib($b[1])
            If StringInStr($attributes, 'H') Then $attributes = '(HIDDEN)'
            $s = $sPath & '|' & _GetFileProperties($b[1]) & '|' & $attributes
            $id_Item = GUICtrlCreateListViewItem($s, $id_LV1)
            If Not GUICtrlSetImage($id_Item, $b[1], -1) Then GUICtrlSetImage($id_Item, 'shell32.dll', 3)
            If ($attributes = '(HIDDEN)') Then GUICtrlSetBkColor($id_Item, 0xFFB0B0)
        EndIf
    Next

    LV_SetColumnWidth($id_LV1, '300,400|50,50|150,200|100,150|210,250|70,80|70,80')
    LV_SetColumnWidth($id_LV2, '300,400|50,50|150,200|100,150|210,250|70,80|70,80')

    GUICtrlSetState($id_LV1, $GUI_FOCUS)
    GUICtrlSetState($id_LV1, $GUI_SHOW)
    GUICtrlSetState($id_LV2, $GUI_SHOW)

    GUICtrlSetData($prb, 0)
    $nLastPID = 0
    $nState = 2

    $aProcesses = $a
    $objClass = ''
    $objWMI = ''
    $a = ''
EndFunc
;
Func _GetModulesByPID($n_Pid)
    If ($n_Pid == $nLastPID) Then Return
    $nLastPID = $n_Pid
    GUISetState(@SW_DISABLE, $id_GUI)
    Local $a, $attributes, $id_Item, $s
    GUICtrlSendMsg($id_LV2, $LVM_DELETEALLITEMS, 0, 0)
    For $i = 1 To $aProcesses[0]
        $a = StringSplit($aProcesses[$i], '|')
        If $a[2] = $n_Pid Then
            $attributes = FileGetAttrib($a[1])
            If StringInStr($attributes, 'H') Then $attributes = '(HIDDEN)'
            $s = $a[1] & '|' & $a[2] & '|' & _GetFileProperties($a[1]) & '|' & $attributes
            $id_Item = GUICtrlCreateListViewItem($s, $id_LV2)
            If ($attributes = '(HIDDEN)') Then GUICtrlSetBkColor($id_Item, 0xFFB0B0)
        EndIf
    Next
    GUISetState(@SW_ENABLE, $id_GUI)
EndFunc
;
Func _ProcessClose()
    Local $aItems = StringSplit(StringTrimRight(GUICtrlRead(GUICtrlRead($id_LV1)), 1), '|')
    If $aItems[0] <> 7 Then Return
    If Not StringIsDigit($aItems[2]) Then Return
    Local $sMsg
    If StringInStr($aItems[1], @WindowsDir) And StringInStr($aItems[3], 'Microsoft Corporation') Then
        $sMsg = $aItems[1] & @CRLF & @CRLF
        $sMsg &= 'Killing a System Process may crash your computer!' & @TAB & @CRLF & 'Are you sure?' & @CRLF
        If MsgBox(8212, 'Warning - Microsoft System Process', $sMsg) <> 6 Then Return
    Else
        If MsgBox(8228, 'Kill this process?', $aItems[1] & @TAB) <> 6 Then Return
    EndIf
    Sleep(250)
    If ProcessClose($aItems[2]) Then
        GUICtrlDelete(GUICtrlRead($id_LV1))
        If $nProcessEvent Then
            GUICtrlSendMsg($id_LV2, $LVM_DELETEALLITEMS, 0, 0)
            ; Or
            ; _ProcessList_Extended(); refresh list? it's slower though.
        EndIf
    EndIf
EndFunc
;
;===========================================================
; NTLogs_GetEvents v2.01.GCS.02 - July 29, 2012 - by ripdad
Func NTLogs_GetEvents($sType)
    If Not $nWMI Then Return NoWMI()

    Local $sMsg, $sRec, $p = 0, $nRecordsToGet = 30
    Local $nCount, $nType, $nSearchDepth, $objClass
    Local $count, $str = '', $utc = ''
    If $Vista_7 Then $utc = ' UTC'
    Local $aLogs = StringSplit('Application|System|Security', '|')
    Local $objWMI = ObjGet($sWMI_Moniker)
    If @error Or Not IsObj($objWMI) Then Return SetError(-1)
    ;
    For $i = 1 To $aLogs[0]
        $nSearchDepth = 0
        $nCount = 0

        $objClass = $objWMI.InstancesOf('Win32_NTLogEvent Where Logfile="' & $aLogs[$i] & '"')
        $count = $objClass.Count
        If @error Or Not $count Then ContinueLoop
        ;
        $Suppress_ErrorMsg = 1
        For $objItem In $objClass
            $nSearchDepth += 1
            If ($nSearchDepth > 500) Then ExitLoop

            $p += 0.1
            If ($p > 100) Then $p = 0
            GUICtrlSetData($prb, $p)

            $sMsg = $objItem.Message
            If Not StringExists($sMsg, 250) Then ContinueLoop

            $nType = $objItem.EventType

            Switch $nType
                Case 1; error
                    If $sType <> 'Error' Then ContinueLoop
                Case 2; warning
                    If $sType <> 'Warnings' Then ContinueLoop
                Case 3; information (ChkDsk)
                    If ($i > 1) Then ContinueLoop
                    If $sType <> 'Information' Then ContinueLoop
                    If Not ($objItem.EventIdentifier = '1073742825') Then ContinueLoop
                    If Not StringInStr($sMsg, 'Checking file system') Then ContinueLoop
                    $sMsg = StringRegExpReplace($sMsg, '(?is)(.*)Internal Info.*', '\1')
                Case Else
                    ContinueLoop
            EndSwitch

            $sRec = '<--[ ' & $aLogs[$i] & ' Log'
            $sRec &= ' ] [ Type: ' & $objItem.Type
            $sRec &= ' ] [ Record #' & $objItem.RecordNumber
            $sRec &= ' ] [ ' & WMI_DTConvert($objItem.TimeGenerated) & $utc
            $sRec &= ' ] [ Source: ' & $objItem.SourceName
            $sRec &= ' ] [ EventID: ' & $objItem.EventIdentifier
            $sRec &= ' ] [ EventCode: ' & $objItem.EventCode
            $sRec &= ' ] [ User: ' & $objItem.User & ' ]' & @CRLF & @CRLF

            $sMsg = StringStripWS($sMsg, 3)
            $sMsg = StringReplace($sMsg, @CRLF, '^')
            $sMsg = StringStripWS($sMsg, 7)
            $sMsg = StringRegExpReplace($sMsg, '(\^{1,9})', '\^')
            $sMsg = StringRegExpReplace($sMsg, '(\s\^)|(\^\s)', '\^')
            $sMsg = StringReplace($sMsg, '^', @CRLF)
            $sMsg = StringRegExpReplace($sMsg, '(.{125}[\\ \-])', '\1' & @CRLF)

            $sRec &= $sMsg & @CRLF & @CRLF
            $str &= $sRec

            $nCount += 1
            If ($nCount >= $nRecordsToGet) Then ExitLoop
        Next
        If _WMI_ObjectError(1) Then Return SetError(-2)
    Next
    ;
    $objClass = ''
    $objWMI = ''
    ;
    If Not $str Then
        $str = 'No Records Found' & @CRLF & @CRLF
    EndIf
    ;
    Return $str
EndFunc
;
Func WMI_DTConvert($x)
    If Not StringIsDigit(StringLeft($x, 14)) Then Return 'Unknown Date'
    Local $a = StringRegExp($x, '(\d{2})', 3)
    Return ($a[2] & '/' & $a[3] & '/' & $a[0] & $a[1] & ' - ' & $a[4] & ':' & $a[5] & ':' & $a[6])
EndFunc
;
Func Reg_GetRegistrySettings()
    ;<===========================================================================HKEY_LOCAL_MACHINE
    Local $k1 = $HKLM & '\Software\Microsoft\Windows NT\CurrentVersion\Image File Execution Options'
    Local $k2 = $HKLM & '\Software\Microsoft\Windows\CurrentVersion\Explorer\Browser Helper Objects'
    Local $s = $HKLM & '\Software\Classes\.exe|'
    $s &= $HKLM & '\Software\Classes\.exe\PersistentHandler|'
    $s &= $HKLM & '\Software\Classes\exefile|'
    $s &= $HKLM & '\Software\Classes\exefile\DefaultIcon|'
    $s &= $HKLM & '\Software\Classes\exefile\shell\open\command|'
    $s &= $HKLM & '\Software\Classes\exefile\shell\runas\command|'
    $s &= $HKLM & '\Software\Clients\StartMenuInternet\FIREFOX.EXE\shell\open\command|'
    $s &= $HKLM & '\Software\Clients\StartMenuInternet\FIREFOX.EXE\shell\safemode\command|'
    $s &= $HKLM & '\Software\Clients\StartMenuInternet\IEXPLORE.EXE\shell\open\command|'
    $s &= $HKLM & '\Software\Microsoft\Rpc|'
    $s &= $HKLM & '\Software\Microsoft\Rpc\ClientProtocols|'
    $s &= $HKLM & '\Software\Microsoft\Rpc\SecurityService|'
    $s &= $HKLM & '\Software\Microsoft\Security Center|'
    $s &= $HKLM & '\Software\Microsoft\Windows\CurrentVersion\Internet Settings|'
    $s &= $HKLM & '\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop|'
    $s &= $HKLM & '\Software\Microsoft\Windows\CurrentVersion\Policies\Associations|'
    $s &= $HKLM & '\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments|'
    $s &= $HKLM & '\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer|'
    $s &= $HKLM & '\Software\Microsoft\Windows\CurrentVersion\Policies\System|'
    $s &= $HKLM & '\Software\Microsoft\Windows NT\CurrentVersion\SystemRestore|'
    $s &= $HKLM & '\Software\Microsoft\Windows NT\CurrentVersion\Windows|'
    $s &= $HKLM & '\Software\Microsoft\Windows NT\CurrentVersion\Winlogon|'
    ;<============================================================================HKEY_CURRENT_USER
    $s &= $HKCU & '\Software\Clients\StartMenuInternet|'
    $s &= $HKCU & '\Software\Microsoft\Internet Explorer\Download|'
    $s &= $HKCU & '\Software\Microsoft\Internet Explorer\Main|'
    $s &= $HKCU & '\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced|'
    $s &= $HKCU & '\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.exe|'
    $s &= $HKCU & '\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.exe\OpenWithList|'
    $s &= $HKCU & '\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.exe\OpenWithProgids|'
    $s &= $HKCU & '\Software\Microsoft\Windows\CurrentVersion\Internet Settings|'
    $s &= $HKCU & '\Software\Microsoft\Windows\CurrentVersion\Policies\ActiveDesktop|'
    $s &= $HKCU & '\Software\Microsoft\Windows\CurrentVersion\Policies\Associations|'
    $s &= $HKCU & '\Software\Microsoft\Windows\CurrentVersion\Policies\Attachments|'
    $s &= $HKCU & '\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer|'
    $s &= $HKCU & '\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\DisallowRun|'
    $s &= $HKCU & '\Software\Microsoft\Windows\CurrentVersion\Policies\System|'
    $s &= $HKCU & '\Software\Microsoft\Windows NT\CurrentVersion\Windows|'
    $s &= $HKCU & '\Software\Microsoft\Windows NT\CurrentVersion\Winlogon|'
    ;
    Local $a = StringSplit(StringTrimRight($s, 1), '|')
    $s = $k1 & '^110' & @CRLF & Reg_Debuggers($k1)
    $s &= $k2 & '^110' & @CRLF & Reg_BHOs($k2)
    For $i = 1 To $a[0]
        $s &= $a[$i] & '^110' & @CRLF & Reg_GetValues($a[$i])
    Next
    Return $s
EndFunc
;
Func Reg_GetValues($k); v0.2
    Local $a, $e, $s, $v, $x
    For $i = 1 To 1000
        $v = '|' & RegEnumVal($k, $i)
        If @error <> 0 Then ExitLoop
        $s &= $v
    Next
    $a = StringSplit(StringTrimLeft($s, 1), '|')
    _ArraySort($a, 0, 1)
    $s = ''
    $v = RegRead($k, '')
    $e = @error
    If $e = 0 Then
        $s &= '(Default) = ' & $v & '^210' & @CRLF
    ElseIf $e = -1 Then
        $s &= '(Default) = (value not set)^210' & @CRLF
    Else
        $s &= '(key does not exist)^000' & @CRLF
    EndIf
    For $i = 1 To $a[0]
        If StringExists($a[$i]) Then
            $v = RegRead($k, $a[$i])
            $e = @error
            $x = @extended
            $v = StringRegExpReplace($v, '[\n\|]', ', ')
            If $x = 0 Then
                $s &= $a[$i] & ' = ^230' & @CRLF
            ElseIf $e = 0 Then
                $s &= $a[$i] & ' = ' & $v & '^2' & $x & '0' & @CRLF
            ElseIf $e = -1 Then
                $s &= $a[$i] & ' = (value not set)^2' & $x & '0' & @CRLF
            Else
                $s &= '(key does not exist)^000' & @CRLF
            EndIf
        EndIf
    Next
    Return $s
EndFunc
;
Func Reg_Debuggers($k)
    Local $sub, $v, $x, $s = ''
    For $i = 1 To 100; if exist, just get a max sample of 100
        $sub = RegEnumKey($k, $i)
        If @error <> 0 Then ExitLoop
        If $sub = 'Your Image File Name Here without a path' Then ContinueLoop
        $v = RegRead($k & '\' & $sub, 'Debugger')
        $x = @extended
        If $v Then $s &= $sub & '-->Debugger = ' & $v & '^2' & $x & '1' & @CRLF
    Next
    If $s Then Return $s
    Return '(No Debuggers Found)^000' & @CRLF
EndFunc
;
Func Reg_BHOs($k)
    Local $sub, $v, $x, $s = ''
    For $i = 1 To 100
        $sub = RegEnumKey($k, $i)
        If @error <> 0 Then ExitLoop
        $v = RegRead($HKLM & '\Software\Classes\CLSID\' & $sub & '\InprocServer32', '')
        $x = @extended
        If $v Then $s &= $sub & ' = ' & $v & '^2' & $x & '0' & @CRLF
    Next
    If $s Then Return $s
    Return '(No BHOs Found)^000' & @CRLF
EndFunc
;
Func Reg_GetRunKeys()
    Local $str = $HKU & '|'
    $str &= $HKCU & '\Software\Microsoft\Windows\CurrentVersion|'
    $str &= $HKLM & '\Software\Microsoft\Windows\CurrentVersion|'
    If $OSA64 Then $str &= $HKLM & '\Software\Wow6432Node\Microsoft\Windows\CurrentVersion|'
    Local $aKeys = StringSplit(StringTrimRight($str, 1), '|')
    Local $key, $sub, $n = 1
    $str = ''
    ;
    For $i = 1 To $aKeys[0]
        If $i = 1 Then
            $sub = RegEnumKey($aKeys[$i], $n)
            If @error <> 0 Then ContinueLoop
            $key = $aKeys[$i] & '\' & $sub & '\Software\Microsoft\Windows\CurrentVersion'
            $n += 1
            $i = 0
        Else
            $key = $aKeys[$i]
        EndIf
        ;
        For $j = 1 To 1000
            $sub = RegEnumKey($key, $j)
            If @error <> 0 Then ExitLoop
            If StringInStr($sub, 'Run') Then $str &= $key & '\' & $sub & '|'
        Next
    Next
    ;
    Return StringSplit(StringTrimRight($str, 1), '|')
EndFunc
;
; ============================================================================================
; Function: GetCommonStartups
; Release Date: April 12, 2011
; Last Modified: August 04, 2012
; Version: 2.6.0
;
; Description:
; Returns an array of all Run Keys (including all SID Run Keys), UserInit and Startup Folders
; ============================================================================================
Func GetCommonStartups()
    Local $UPD = StringLeft(@UserProfileDir, StringInStr(@UserProfileDir, '\', 0, -1) - 1)
    Local $WSP = @WindowsDir & '\System32\config\systemprofile', $WTD = @WindowsDir & '\Temp'
    Local $HKWOW_WLN = $HKLM & '\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Winlogon'
    Local $HKWOW_AID = $HKLM & '\Software\Wow6432Node\Microsoft\Windows NT\CurrentVersion\Windows'
    Local $HKLM_AID = $HKLM & '\Software\Microsoft\Windows NT\CurrentVersion\Windows'
    Local $HKLM_WLN = $HKLM & '\Software\Microsoft\Windows NT\CurrentVersion\Winlogon'
    Local $HKCU_WLN = $HKCU & '\Software\Microsoft\Windows NT\CurrentVersion\Winlogon'
    Local $sPath, $str, $val, $vn
    Local $aKeys = Reg_GetRunKeys()
    ;
    For $i = 1 To $aKeys[0]
        $str &= 1 & $aKeys[$i] & '|'
        For $j = 1 To 1000
            $vn = RegEnumVal($aKeys[$i], $j)
            If @error <> 0 Then ExitLoop
            $val = Reg_GetFriendlyPath(RegRead($aKeys[$i], $vn))
            $sPath = Reg_GetFriendlyPath($val, 1)
            ;
            If StringInStr($sPath, $UPD) Or StringInStr($sPath, $WSP) Or StringInStr($sPath, $WTD) Then
                $str &= 3 & $vn & '^' & $val & '<--[!]|'
            Else
                $str &= 3 & $vn & '^' & $val & '|'
            EndIf
            $val = ''
        Next
    Next
    ;
    ; Wow6432Node - 64 bit OS
    If $Vista_7 And $OSA64 Then
        $str &= 1 & $HKWOW_WLN & '|'
        $val = RegRead($HKWOW_WLN, 'Userinit')
        If $val <> 'userinit.exe' Then
            $str &= 3 & 'Userinit^' & $val & '<--[Default: userinit.exe]|'
        Else
            $str &= 3 & 'Userinit^' & $val & '|'
        EndIf
        ;
        $val = RegRead($HKWOW_WLN, 'Shell')
        If $val <> 'explorer.exe' Then
            $str &= 3 & 'Shell^' & $val & '<--[Default: explorer.exe]|'
        Else
            $str &= 3 & 'Shell^' & $val & '|'
        EndIf
        ;
        $val = RegRead($HKWOW_WLN, 'UIHost')
        If $val Then
            $str &= 3 & 'UIHost^' & $val & '<--[Default: ValueName does not exist]|'
        EndIf
        ;
        $str &= 1 & $HKWOW_AID & '|'
        $val = RegRead($HKWOW_AID, 'AppInit_DLLs')
        If $val Then
            $str &= 3 & 'AppInit_DLLs^' & $val & '<--[Default: Blank]|'
        EndIf
    EndIf
    ;
    ; All OS
    $str &= 1 & $HKCU_WLN & '|'
    $val = RegRead($HKCU_WLN, 'Shell')
    If $val Then
        $str &= 3 & 'Shell^' & $val & '<--[Default: ValueName does not exist]|'
    EndIf
    ;
    $str &= 1 & $HKLM_AID & '|'
    $val = RegRead($HKLM_AID, 'AppInit_DLLs')
    If $val Then
        $str &= 3 & 'AppInit_DLLs^' & $val & '<--[Default: Blank]|'
    EndIf
    ;
    $str &= 1 & $HKLM_WLN & '|'
    $val = RegRead($HKLM_WLN, 'Userinit')
    If $val = 'userinit.exe' Then; <-- Good
        $str &= 3 & 'Userinit^' & $val & '|'
    ElseIf $val = @WindowsDir & '\System32\userinit.exe' Then; <-- Good
        $str &= 3 & 'Userinit^' & $val & '|'
    ElseIf $val = @WindowsDir & '\System32\userinit.exe,' Then; <-- Good (Default)
        $str &= 3 & 'Userinit^' & $val & '|'
    Else; <-- Not Good
        $str &= 3 & 'Userinit^' & $val & '<--[Default: ' & @WindowsDir & '\System32\userinit.exe,]|'
    EndIf
    ;
    $val = RegRead($HKLM_WLN, 'UIHost')
    If $val Then
        If $Vista_7 Then
            $str &= 3 & 'UIHost^' & $val & '<--[Default: ValueName does not exist]|'
        ElseIf $val <> 'logonui.exe' Then
            $str &= 3 & 'UIHost^' & $val & '<--[Default: logonui.exe]|'
        Else
            $str &= 3 & 'UIHost^' & $val & '|'
        EndIf
    EndIf
    ;
    $val = RegRead($HKLM_WLN, 'Shell')
    If $val <> 'explorer.exe' Then
        $str &= 3 & 'Shell^' & $val & '<--[Default: explorer.exe]|'
    Else
        $str &= 3 & 'Shell^' & $val & '|'
    EndIf
    ;
    ; Startup Folders
    $sPath = $UPD & '\'
    Local $Startup = '\' & StringTrimLeft(@StartupCommonDir, StringInStr(@StartupCommonDir, '\', 0, -3))
    Local $aPath, $sFolder, $sFile, $string, $tPath, $shortcut = 0
    Local $hF = FileFindFirstFile($sPath & '*')
    If $hF = -1 Then
        MsgBox(8240, $sTitle, 'An error was encountered.' & @CRLF & 'Startup folders will not be processed.')
        Return StringSplit(StringTrimRight($str, 1), '|')
    EndIf
    While 1
        $sFolder = FileFindNextFile($hF)
        If @error Then ExitLoop
        If Not @extended Then ContinueLoop
        $string &= $sPath & $sFolder & '|'
    WEnd
    FileClose($hF)
    ;
    If $Vista_7 Then $string &= StringLeft(@StartupCommonDir, StringInStr(@StartupCommonDir, '\', 0, -3) - 1) & '|'
    Local $aItems = StringSplit(StringTrimRight($string, 1), '|')
    ;
    For $i = 1 To $aItems[0]
        $sPath = $aItems[$i] & $Startup
        If Not FileExists($sPath) Then ContinueLoop
        $hF = FileFindFirstFile($sPath & '\*')
        If $hF = -1 Then ContinueLoop
        $str &= 2 & $sPath & '|'
        $tPath = $sPath
        While 1
            $sFile = FileFindNextFile($hF)
            If @error Then ExitLoop
            If @extended Then ContinueLoop
            If StringRight($sFile, 4) = '.ini' Then ContinueLoop
            If StringRight($sFile, 4) = '.lnk' Then
                $aPath = FileGetShortcut($sPath & '\' & $sFile)
                $tPath = $aPath[0]
                $shortcut = 1
            EndIf
            If StringInStr($tPath, $UPD) Or StringInStr($tPath, $WSP) Or StringInStr($tPath, $WTD) Then
                If $shortcut Then
                    $str &= 3 & $sFile & '^' & $tPath & '<--[!]|'
                Else
                    $str &= 3 & $sFile & '^' & $tPath & '\' & $sFile & '<--[!]|'
                EndIf
            Else
                If $shortcut Then
                    $str &= 3 & $sFile & '^' & $tPath & '|'
                Else
                    $str &= 3 & $sFile & '^' & $tPath & '\' & $sFile & '|'
                EndIf
            EndIf
            $tPath = $sPath
            $shortcut = 0
        WEnd
        FileClose($hF)
    Next
    ;
    Local $a[18] = [17]
    $a[1] = FileGetLongName(StringLeft(@UserProfileDir, StringInStr(@UserProfileDir, '\', 0, -1) - 1))
    $a[2] = FileGetLongName(@UserProfileDir)
    $a[3] = FileGetLongName(@UserProfileDir & '\Local Settings\Application Data')
    $a[4] = FileGetLongName(@UserProfileDir & '\Local Settings\AppData')
    $a[5] = FileGetLongName(@AppDataDir)
    $a[6] = FileGetLongName(@AppDataCommonDir)
    $a[7] = FileGetLongName(@TempDir)
    $a[8] = FileGetLongName(@UserProfileDir & '\Local Settings\Application Data\Macromedia')
    $a[9] = FileGetLongName(@UserProfileDir & '\Local Settings\Application Data\Sun')
    $a[10] = FileGetLongName(@UserProfileDir & '\Recent')
    $a[11] = FileGetLongName(@UserProfileDir & '\Templates')
    $a[12] = FileGetLongName(@AppDataDir & '\Macromedia')
    $a[13] = FileGetLongName(@AppDataDir & '\Sun')
    $a[14] = FileGetLongName(@WindowsDir & '\System32\Config\SystemProfile')
    $a[15] = FileGetLongName(@WindowsDir & '\System32\Config\SystemProfile\Local Settings\Temp')
    $a[16] = FileGetLongName(@WindowsDir & '\System32\Config\Systemprofile\Start Menu\Programs\Startup')
    $a[17] = FileGetLongName(@WindowsDir & '\Temp')
    Local $sD, $sF
    ;
    For $i = 1 To $a[0]
        If FileExists($a[$i]) Then
            $sD = $a[$i]
            $str &= 2 & $sD & '|'
            $hF = FileFindFirstFile($sD & '\*')
            If $hF = -1 Then ContinueLoop
            While 1
                $sF = FileFindNextFile($hF)
                If @error Then ExitLoop
                If @extended Then ContinueLoop
                If StringRegExp(StringRight($sF, 4), '(?i)(\.bat|\.cmd|\.com|\.exe|\.scr)') Then
                    $str &= 3 & $sF & '^' & $sD & '\' & $sF & '<--[!]|'
                EndIf
            WEnd
        EndIf
    Next
    ;
    Return StringSplit(StringTrimRight($str, 1), '|')
EndFunc
;
Func _RunProgram()
    Local $sPath = FileOpenDialog('Select a File to Run', @ScriptDir, 'Executable (*.bat;*.com;*.exe)', 1)
    If @error Or Not $sPath Then Return
    If Not Run('"' & $sPath & '"') Then
        MsgBox(8228, $sTitle, 'Cannot Run this File' & @TAB)
    EndIf
EndFunc
;
Func _ClearEventLogs()
    If MsgBox(8228, 'Clear_NT_EventLogs', 'Clear NT Logs?' & @TAB) <> 6 Then Return
    Local $objWMI = ObjGet($sWMI_Moniker)
    Local $objClass = $objWMI.InstancesOf('Win32_NTEventLogFile')
    Local $count = $objClass.Count
    If @error Or Not $count Then
        Return MsgBox(8208, $sTitle, 'Error Getting Object: Win32_NTEventLogFile' & @TAB)
    EndIf
    Local $errors = 0, $number = 0

    $Suppress_ErrorMsg = 1
    For $objItem In $objClass
        $number += $objItem.NumberOfRecords
        $errors += $objItem.ClearEventLog
    Next
    If _WMI_ObjectError(1) Then $errors += 1

    MsgBox(8256, 'Clear_NT_EventLogs - Finished', 'Cleared: ' & $number & @CRLF & 'Errors: ' & $errors & @TAB)
    $objClass = ''
    $objWMI = ''
EndFunc
;
Func _Reboot_CheckHardDrive()
    If MsgBox(8228, $sTitle, 'Reboot and Check Hard Drive?' & @TAB) <> 6 Then Return
    Local $string = 'autocheck autochk /p \??\' & @HomeDrive & @LF & 'autocheck autochk *'
    Local $sKey = $HKLM & '\System\CurrentControlSet\Control\Session Manager'
    If RegWrite($sKey, 'BootExecute', 'REG_MULTI_SZ', $string) Then
        Sleep(2000)
        Shutdown(6)
        _AllExit()
    EndIf
    MsgBox(8208, $sTitle, 'Error writing to registry' & @TAB)
EndFunc
;
Func _RunCommandPrompt()
    ShellExecute(@WindowsDir & '\system32\cmd.exe')
EndFunc
;
Func _RunCompmgmtMSC()
    ShellExecute('compmgmt.msc')
EndFunc
;
Func _RunExplorer()
    ShellExecute(@WindowsDir & '\explorer.exe', '/e,' & @HomeDrive & '\')
EndFunc
;
Func _ViewHostsFile()
    Local $sPath = @WindowsDir & '\System32\Drivers\etc\hosts.'
    If Not FileExists($sPath) Then Return MsgBox(8208, 'View Hosts File', 'Path Not Found --> ' & $sPath)
    FileSetAttrib($sPath, '-RSHNOT+A')
    Run(@WindowsDir & '\System32\notepad.exe "' & $sPath & '"')
    ;RunWait(@WindowsDir & '\System32\notepad.exe "' & $sPath & '"')
    ;FileSetAttrib($sPath, '+RA')
EndFunc
;
Func GCS_CreateListView(ByRef $IDLV, $sHeader, $nDragBar = 0)

    GCS_DeleteListView($IDLV); delete current listview(s)

    $IDLV = GUICtrlCreateListView($sHeader, 0, 1000, 0, 0); create new
    GUICtrlSetState($IDLV, $GUI_HIDE)

    If $nDragBar Then
        $id_DragBar = GUICtrlCreateLabel('', 0, $nClientHeight - 150, 0, 0)
        GUICtrlSetOnEvent($id_DragBar, 'GCS_AutoSizeGUI')
        GUICtrlSetCursor($id_DragBar, 11)
    Else
        GCS_CreateContextMenu()
        If ($nState > -1) Then
            GCS_AutoSizeGUI()
        EndIf
    EndIf
EndFunc
;
Func GCS_DeleteListView(ByRef $IDLV)

    If $nProcessEvent Then
        GUICtrlSetState($id_DragBar, $GUI_HIDE)
        GUICtrlSetState($id_LV1, $GUI_HIDE)
        GUICtrlSetState($id_LV2, $GUI_HIDE)
        GUICtrlSetOnEvent($id_DragBar, '')
        GUICtrlDelete($id_DragBar)
        GUICtrlDelete($id_LV1)
        GUICtrlDelete($id_LV2)
        $nProcessEvent = 0
        $id_DragBar = ''
        $id_LV1 = ''
        $id_LV2 = ''
    Else
        GUICtrlSetState($IDLV, $GUI_HIDE)
        GUICtrlDelete($IDLV)
    EndIf
EndFunc
;
Func LV_SetColumnWidth(ByRef $IDLV, $sWidth)
    Local $a, $n = 1
    If ($nClientWidth > 1024) Then $n = 2
    Local $aColumnWidth = StringSplit($sWidth, '|')
    For $i = 1 To $aColumnWidth[0]
        $a = StringSplit($aColumnWidth[$i], ',')
        GUICtrlSendMsg($IDLV, $LVM_SETCOLUMNWIDTH, $i - 1, Number($a[$n]))
    Next
EndFunc
;
Func GCS_CreateContextMenu()
    For $i = 1 To $aCM[0]
        If $aCM[$i] Then
            GUICtrlSetOnEvent($aCM[$i], '')
            GUICtrlDelete($aCM[$i])
            $aCM[$i] = ''
        EndIf
    Next
    $aCM[1] = GUICtrlCreateContextMenu($id_LV1)
    $aCM[2] = GUICtrlCreateMenuItem('Jump to...', $aCM[1])
    $aCM[3] = GUICtrlCreateMenuItem('Copy to Clipboard', $aCM[1])
    GUICtrlCreateMenuItem('', $aCM[1])
    $aCM[4] = GUICtrlCreateMenuItem('Delete Item', $aCM[1])
    $aCM[5] = GUICtrlCreateMenuItem('Kill Process', $aCM[1])
    GUICtrlCreateMenuItem('', $aCM[1])
    $aCM[6] = GUICtrlCreateMenuItem('System Information', $aCM[1])
    $aCM[7] = GUICtrlCreateMenuItem('Common Startups', $aCM[1])
    $aCM[8] = GUICtrlCreateMenuItem('Registry Settings', $aCM[1])
    GUICtrlCreateMenuItem('', $aCM[1])
    $aCM[9] = GUICtrlCreateMenuItem('Running Programs', $aCM[1])
    $aCM[10] = GUICtrlCreateMenuItem('Running Services', $aCM[1])
    $aCM[11] = GUICtrlCreateMenuItem('Loaded Drivers', $aCM[1])
    GUICtrlCreateMenuItem('', $aCM[1])
    $aCM[12] = GUICtrlCreateMenuItem('HD_SMART_DATA', $aCM[1])
    GUICtrlCreateMenuItem('', $aCM[1])
    $aCM[13] = GUICtrlCreateMenu('NTLog Events', $aCM[1])
    $aCM[14] = GUICtrlCreateMenuItem('NTLog_Errors', $aCM[13])
    $aCM[15] = GUICtrlCreateMenuItem('NTLog_Warnings', $aCM[13])
    $aCM[16] = GUICtrlCreateMenuItem('NTLog_ChkDsk', $aCM[13])
    GUICtrlCreateMenuItem('', $aCM[1])
    $aCM[17] = GUICtrlCreateMenuItem('GCS Properties', $aCM[1])
    GUICtrlSetOnEvent($aCM[2], '_Jump2Path')
    GUICtrlSetOnEvent($aCM[3], '_Copy2Clip')
    GUICtrlSetOnEvent($aCM[4], '_ItemDelete')
    GUICtrlSetOnEvent($aCM[5], '_ProcessClose')
    GUICtrlSetOnEvent($aCM[6], '_LvScreen')
    GUICtrlSetOnEvent($aCM[7], '_StartupList')
    GUICtrlSetOnEvent($aCM[8], '_LvScreen')
    GUICtrlSetOnEvent($aCM[9], '_ProcessList_Extended')
    GUICtrlSetOnEvent($aCM[10], '_Drivers_Services')
    GUICtrlSetOnEvent($aCM[11], '_Drivers_Services')
    GUICtrlSetOnEvent($aCM[12], '_WMI_GetATAPISmartData')
    GUICtrlSetOnEvent($aCM[14], '_LvScreen')
    GUICtrlSetOnEvent($aCM[15], '_LvScreen')
    GUICtrlSetOnEvent($aCM[16], '_LvScreen')
    GUICtrlSetOnEvent($aCM[17], '_FilePropertiesEx')
    If ($nState = -1) Then
        $aCM[18] = GUICtrlCreateContextMenu($id_LV2)
        $aCM[19] = GUICtrlCreateMenuItem('Jump to...', $aCM[18])
        $aCM[20] = GUICtrlCreateMenuItem('Copy to Clipboard', $aCM[18])
        GUICtrlSetOnEvent($aCM[19], '_Jump2Path')
        GUICtrlSetOnEvent($aCM[20], '_Copy2Clip')
    EndIf
EndFunc
;
Func GCS_AutoSizeGUI()
    Local $array = WinGetClientSize($sTitle)
    If Not IsArray($array) Then Return
    $nClientWidth = $array[0]
    $nClientHeight = $array[1]

    Local $CW = $array[0] - 10; set max width
    Local $CH = $array[1] - 30; set max height
    Local $CY, $DY

    If @GUI_CtrlId == $id_DragBar Then
        GUICtrlSetBkColor($id_DragBar, 0xDD00DD)
        Do
            Sleep(10)
            $array = GUIGetCursorInfo()
            $CY = $array[1]
            If ($CY > 100) And ($CY < ($CH - 100)) Then
                ControlMove($id_GUI, '', $id_DragBar, 5, $CY - 2, $CW, 5)
            EndIf
        Until Not $array[2]
        GUICtrlSetBkColor($id_DragBar, -1)
    EndIf

    If $nProcessEvent Then
        $array = ControlGetPos($sTitle, '', $id_DragBar)
        If IsArray($array) Then
            $DY = $array[1]
            If ($DY > ($CH - 100)) Then
                $DY = 250
            EndIf
            ControlMove($id_GUI, '', $id_DragBar, 5, $DY, $CW, 5)
            ControlMove($id_GUI, '', $id_LV1, 5, 20, $CW, $DY - 20)
            ControlMove($id_GUI, '', $id_LV2, 5, $DY + 5, $CW, ($CH - $DY) + 15)
        EndIf
    Else
        ControlMove($id_GUI, '', $id_LV1, 5, 20, $CW, $CH)
    EndIf

    $CW /= 5
    For $i = 1 To 5
        ControlMove($id_GUI, '', $aIB[$i], $CW * ($i - 1) + 5, 1, $CW, 18)
    Next
EndFunc
;
Func _Init_CtrlId()
    Local $dummy = GUICtrlCreateDummy()
    GUICtrlSetOnEvent($dummy, '_Dummy')
    GUICtrlSendToDummy($dummy)
    GUICtrlSetOnEvent($dummy, '')
    GUICtrlDelete($dummy)
    $dummy = ''
EndFunc
;
Func _Dummy()
EndFunc
;
Func _ObjErrorHandler()
    If Not IsObj($oErrorHandler) Then
        MsgBox(8240, ' Object Error', '$oErrorHandler is not an object!')
        Exit
    EndIf
    ;
    If $Suppress_ErrorMsg Then
        $oErrorHandler.Clear
        $Object_Error = 1
        Return SetError(-1)
    EndIf
    ;
    Local $AOE1 = $oErrorHandler.Description
    Local $AOE2 = $oErrorHandler.WinDescription
    Local $AOE3 = $oErrorHandler.Number
    Local $AOE4 = $oErrorHandler.Source
    Local $AOE5 = $oErrorHandler.ScriptLine
    ;
    $oErrorHandler.Clear
    ;
    Local $eMsg = ''
    ;
    If $AOE1 Then $eMsg &= 'Description: ' & $AOE1 & @TAB & @CRLF
    If $AOE2 Then $eMsg &= 'WinDesciption: ' & $AOE2 & @TAB & @CRLF
    If $AOE3 Then $eMsg &= 'Error Number: ' & Hex($AOE3, 8) & @TAB & @CRLF
    If $AOE4 Then $eMsg &= 'Source Name: ' & $AOE4 & @TAB & @CRLF
    If $AOE5 Then $eMsg &= 'Script Line: ' & $AOE5 & @TAB & @CRLF
    ;
    If $eMsg Then
        MsgBox(8240, ' Object Error', $eMsg)
    Else
        MsgBox(8240, ' Object Error', 'Unknown Error' & @TAB)
    EndIf
    Return SetError(-1)
EndFunc
;
Func _WMI_ObjectError($mode = 0)
    If $mode = -1 Then
        $Object_Error = 1; force an error
    EndIf

    $Suppress_ErrorMsg = 0; reset

    If $Object_Error Then
        $Object_Error = 0; reset

        If ($mode = 1) Then Return 1; just acknowledge

        GUICtrlSendMsg($id_LV1, $LVM_DELETEALLITEMS, 0, 0)
        GUICtrlCreateListViewItem('Object Error!', $id_LV1)
        GUICtrlSetBkColor(-1, 0xFFB0B0); red-ish
        GUICtrlSendMsg($id_LV1, $LVM_SETCOLUMNWIDTH, 0, 100)
        GUICtrlSetState($id_LV1, $GUI_SHOW)
        GUICtrlSetData($prb, 0)
        Return 1
    EndIf
EndFunc
;
Func GCS_CheckEnvironment()
    Switch $OSA
        Case 'X86'
            $HKCR = 'HKEY_CLASSES_ROOT'
            $HKCU = 'HKEY_CURRENT_USER'
            $HKLM = 'HKEY_LOCAL_MACHINE'
            $HKU = 'HKEY_USERS'
        Case 'X64'
            If Not @AutoItX64 Then
                ExitMsg('64Bit OS Detected. Please use the 64Bit version of this program.')
            EndIf
            $HKCR = 'HKEY_CLASSES_ROOT64'
            $HKCU = 'HKEY_CURRENT_USER64'
            $HKLM = 'HKEY_LOCAL_MACHINE64'
            $HKU = 'HKEY_USERS64'
            $OSA64 = 1
        Case Else
            ExitMsg('Not tested on --> ' & $OSA)
    EndSwitch
    ;
    Switch $OSV
        Case 'Win_2003', 'Win_XP'
            If $OSA <> 'X86' Then
                ExitMsg('Not tested on ' & $OSV & ' --> ' & $OSA)
            EndIf
        Case 'Win_2008', 'Win_7', 'Win_Vista'
            $Vista_7 = 1
        Case Else
            ExitMsg('Not tested on --> ' & $OSV)
    EndSwitch
EndFunc
;
Func ExitMsg($str)
    MsgBox(8208, $sTitle, $str & @TAB)
    Exit
EndFunc
;
Func GCS_TestWMI()
    Local $error, $obj_WMI

    _StartService('winmgmt')
    $error = @error

    Switch $error
        Case 0, 1056; (0 = started service), (1056 = already running)
            $obj_WMI = ObjGet($sWMI_Moniker & ':Win32_LocalTime')
            $error = @error
            If Not $error And IsObj($obj_WMI) Then
                $nWMI = 1; success
            Else
                $nWMI = 'WMI Object Error: ' & $error
            EndIf
        Case 1060
            $nWMI = 'WMI Service does not exist. Error: ' & $error
        Case Else
            $nWMI = 'WMI Service Error: ' & $error
    EndSwitch

    $Suppress_ErrorMsg = 0
    $obj_WMI = 0

    If $nWMI <> 1 Then
        MsgBox(8240, $sTitle & ' - ' & $nWMI, 'WMI Service Not Available.' & @CRLF & 'Information will be limited.' & @TAB)
        $nWMI = 0
    EndIf
EndFunc
;
Func _GetEnvironmentArray()
    Local $a[11][2] = [[10, '']]
    $a[1][0] = '%ProgramFiles(x86)%'
    $a[1][1] = RegRead($HKLM & '\Software\Microsoft\Windows\CurrentVersion', 'ProgramFilesDir (x86)')
    $a[2][0] = '%ProgramFiles (x86)%'
    $a[2][1] = $a[1][1]
    $a[3][0] = '%ProgramFiles%'
    $a[3][1] = RegRead($HKLM & '\Software\Microsoft\Windows\CurrentVersion', 'ProgramFilesDir')
    $a[4][0] = '%ProgramFilesDir%'
    $a[4][1] = $a[3][1]
    $a[5][0] = '%HomeDrive%'
    $a[5][1] = @HomeDrive
    $a[6][0] = '%SystemDrive%'
    $a[6][1] = $a[5][1]
    $a[7][0] = '%SystemRoot%'
    $a[7][1] = @WindowsDir
    $a[8][0] = '%WinDir%'
    $a[8][1] = $a[7][1]
    $a[9][0] = '%SystemDir%'
    $a[9][1] = @SystemDir
    $a[10][0] = '%SystemDirectory%'
    $a[10][1] = $a[9][1]
    Return $a
EndFunc
;
;=========================================
; #Function: _IsJunction()
; Author: wraithdu
;-----------------------------------------
; Junctions have these attributes:
; FILE_ATTRIBUTE_HIDDEN = 0x2
; FILE_ATTRIBUTE_SYSTEM = 0x4
; FILE_ATTRIBUTE_REPARSE_POINT = 0x400
;=========================================
Func _IsJunction($sDirectory)
    Local Const $INVALID_FILE_ATTRIBUTES = -1
    Local Const $FILE_ATTRIBUTE_JUNCTION = 0x406
    Local $attrib = DllCall('kernel32.dll', 'dword', 'GetFileAttributesW', 'wstr', $sDirectory)
    If @error Or $attrib[0] = $INVALID_FILE_ATTRIBUTES Then Return SetError(1, 0, -1)
    Return (BitAND($attrib[0], $FILE_ATTRIBUTE_JUNCTION) = $FILE_ATTRIBUTE_JUNCTION)
EndFunc
;
;================================================================================
; Description:      Starts a service
; Syntax:           _StartService($sServiceName)
; Parameter(s):     $sServiceName - Name of service to start
; Requirement(s):   None
; Return Value(s):  On Success - Sets: @error = 0
;                   On Failure - Sets: @error = 1056: Already running
;                                      @error = 1060: Service does not exist
; Author(s):        SumTingWong
; Documented by:    noone
;================================================================================
Func _StartService($sServiceName)
    Local $arRet, $hSC, $hService, $lError = -1
    $arRet = DllCall("advapi32.dll", "long", "OpenSCManager", "str", "", "str", "ServicesActive", "long", 0x0001)
    If $arRet[0] = 0 Then
        $arRet = DllCall("kernel32.dll", "long", "GetLastError")
        $lError = $arRet[0]
    Else
        $hSC = $arRet[0]
        $arRet = DllCall("advapi32.dll", "long", "OpenService", "long", $hSC, "str", $sServiceName, "long", 0x0010)
        If $arRet[0] = 0 Then
            $arRet = DllCall("kernel32.dll", "long", "GetLastError")
            $lError = $arRet[0]
        Else
            $hService = $arRet[0]
            $arRet = DllCall("advapi32.dll", "int", "StartService", "long", $hService, "long", 0, "str", "")
            If $arRet[0] = 0 Then
                $arRet = DllCall("kernel32.dll", "long", "GetLastError")
                $lError = $arRet[0]
            EndIf
            DllCall("advapi32.dll", "int", "CloseServiceHandle", "long", $hService)
        EndIf
        DllCall("advapi32.dll", "int", "CloseServiceHandle", "long", $hSC)
    EndIf
    If $lError <> -1 Then SetError($lError)
EndFunc
;================================================================================
;


