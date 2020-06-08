$sTitle = 'Диспетчер задач Windows'
$sControl = 'SysListView321'
$sIniFile = @ScriptDir & '\Test.ini'
Run('taskmgr')
$hHandle = WinWait($sTitle, '', 3)
If Not $hHandle Then Exit
$iCurrentTab = ControlCommand($hHandle, '', 'SysTabControl321', 'CurrentTab', '')
If @error Then Exit
If $iCurrentTab <> 2 Then
    Switch $iCurrentTab
        Case 1
            ControlCommand($hHandle, '', 'SysTabControl321', 'TabRight', '')
            If @error Then Exit
        Case Else
            For $i = 1 To $iCurrentTab - 2
                ControlCommand($hHandle, '', 'SysTabControl321', 'TabLeft', '')
                If @error Then Exit
            Next
    EndSwitch
    Sleep(100)
EndIf

$iCount_Item = ControlListView($hHandle, '', $sControl, 'GetItemCount')
If @error Then Exit
$iCount_SubItem = ControlListView($hHandle, '', $sControl, 'GetSubItemCount')
If @error Then Exit
Dim $aResult[$iCount_Item][2]
For $i = 0 To $iCount_Item - 1
    $aResult[$i][0] = ControlListView($hHandle, '', $sControl, 'GetText', $i, 0)
    If @error Then Exit
    For $j = 1 To $iCount_SubItem - 1
        If $j <> $iCount_SubItem - 1 Then
            $aResult[$i][1] &= ControlListView($hHandle, '', $sControl, 'GetText', $i, $j) & ','
            If @error Then Exit
        Else
            $aResult[$i][1] &= ControlListView($hHandle, '', $sControl, 'GetText', $i, $j) & '.'
            If @error Then Exit
        EndIf
    Next
Next
IniWriteSection($sIniFile, $sControl, $aResult, 0)
;WinClose($hHandle)