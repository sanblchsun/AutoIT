
;����� ������� ��� ����������� ������ ������� (Ctrl Q).
HotKeySet("^q", "Quit")

;������� � ���������� $URL ������ �� �������.
$URL = "http://www.autoitscript.com/cgi-bin/getfile.pl?autoit3/autoit-v3.2.4.4-setup.exe"

;���� �� ������ ������ ��� �����.
$FileName = StringRegExpReplace($URL, "^.*/", "")

;�������� ����� ������ ����� �� ������ (� ������).
$InetGetSize = InetGetSize($URL)

;������ ������ �� ������� � ������� ������.
InetGet($URL, @ScriptDir & "\" & $FileName, 1, 1)

;����� ����� ������������� �������, ��� �������� ������ ������� ������� �����...
$TimerStart = TimerInit()

;��������� ���������� ��� ��������� �������� ������� �������� �������...
$LowsetSpeed = 0
$HighestSpeed = 0
$TempLowsetSpeed = 0
$TempHighestSpeed = 0

;�������� ����������� ���������
ProgressOn("Download Progress", "Download: " & $FileName, "Ready: 0%" & @LF & _
    "Downloading speed: 0 kb/s" & @LF & _
    "Approximately Remained Time: 00:00:00", -1, -1, 16)

;�������� ���������� ������������� ���� ��������� (��� ������ �������� �������� MsgBox).
$ProgressHwnd = WinGetHandle("Download Progress")

;���� ���� ������������, ��������� ������, ��������, ���������� �����, � ������� ����������...
While @InetGetActive
    ;�������� ������� ������ ��������� ������
    $InetGetBytesRead = @InetGetBytesRead

        ;�������� �������� ������� (��' � �������)
    $SpeedByBytes = _InetGetSpeed(1000)

        ;�������� ��������������� ���������� ����� �� ���������� �������
    $RemainedTime = _SecsToTime(Round(_InetGetRemained($InetGetBytesRead, $InetGetSize, $SpeedByBytes)))

        ;�������� ������� �� ���������� ������ (����������� �� �������� �������).
    $GetDownPrecent = Round(_InetGetPrecent($InetGetBytesRead, $InetGetSize))

        ;����� �������� � ������������ � ����������� �������...
    ProgressSet($GetDownPrecent, "Ready: " & $GetDownPrecent & "% (bytes: " & $InetGetBytesRead & ")" & @LF & _
        "Downloading speed: " & Round($SpeedByBytes/1024) & " kb/s" & @LF & _
        "Approximately Remained Time: " & $RemainedTime)

        $TempLowsetSpeed = $SpeedByBytes
    $TempHighestSpeed = $SpeedByBytes

        If $TempLowsetSpeed < $LowsetSpeed Or $LowsetSpeed = 0 Then $LowsetSpeed = $TempLowsetSpeed
    If $TempHighestSpeed > $HighestSpeed Or $HighestSpeed = 0 Then $HighestSpeed = $TempHighestSpeed
WEnd

;����� ���������� ��� ������ ������ � ���������� ���������� �������
;(����� ����� �������, ������� �������� �������, � ����� ������ ����������� ������ � ��).
$TotlaDownloadTime = _SecsToTime(Round(TimerDiff($TimerStart)/1000))
$AverageDownloadSpeed = Round(_GetMidleSpeed($LowsetSpeed, $HighestSpeed)/1024)
$TotalDownloadFileSize_Kb = Round($InetGetSize/1024, 1)

;���������� ���������� ��������� ���������� � ��������� ������ ���������
ProgressSet(100, "100% Done!" & @LF & "Downloading speed: " & $AverageDownloadSpeed & " KB/S" & @LF & _
    "Approximately Remained Time (seconds): 00:00:00")

_MsgBox(64, "Finish!", "Download of <" & $FileName & "> has finished." & @LF & _
    "Total downloading time: " & $TotlaDownloadTime & @LF & _
    "The file was downloaded with average speed of: " & $AverageDownloadSpeed & " KB/S" & @LF & _
    "The file size is: " & $TotalDownloadFileSize_Kb & " KB", $ProgressHwnd)

ProgressOff()

;������� ���������� �������� ���������� �� ������ ���������� ������ (��, � ����� �������) - ������������ ����� � ������� (b/s).
Func _InetGetSpeed($Sleep=1000)
    Local $BytesCheckBefore = @InetGetBytesRead
    Sleep($Sleep)
    Local $BytesCheckAfter = @InetGetBytesRead
    Local $RetSpeedByBytes = $BytesCheckAfter - $BytesCheckBefore
    If $RetSpeedByBytes < 0 Then $RetSpeedByBytes = 0
    Return $RetSpeedByBytes
EndFunc

;������� ���������� ������� �������� ������� (����������� �� ����������� ����� ����� ������� ���������� �������� ������� �� � ����� ���������).
Func _GetMidleSpeed($LowsetSpeed, $HighestSpeed)
    Return ($LowsetSpeed / 2) + ($HighestSpeed / 2)
EndFunc

;������� ���������� ���������� ����� � �������� (�� ���� ���������� �� ������ ������� ����� � ������� �� �������� ����������).
Func _InetGetRemained($Bytes, $TotalBytesSize, $SpeedByBytes)
    $RemainedBytes = $TotalBytesSize - $Bytes
    $RemainedBytes = $RemainedBytes / $SpeedByBytes
    If $RemainedBytes <= 0 Or StringLeft($RemainedBytes, 1) = "-" Then $RemainedBytes = 0
    Return $RemainedBytes
EndFunc

;������� ���������� ������� ���������� ������ (� ������������ � ����� �������� �����)
Func _InetGetPrecent($Bytes, $TotalBytesSize)
    Return 100 / ($TotalBytesSize / $Bytes)
EndFunc

;��������������� ������� ��� ������������� ������ � ����� ����� (� ������ ������������ ����������� �������).
Func _SecsToTime($iTicks, $Delim=":")
    If Number($iTicks) >= 0 Then
        $iHours = Int($iTicks / 3600)
        $iTicks = Mod($iTicks, 3600)
        $iMins = Int($iTicks / 60)
        $iSecs = Round(Mod($iTicks, 60))
        If StringLen($iHours) = 1 Then $iHours = "0" & $iHours
        If StringLen($iMins) = 1 Then $iMins = "0" & $iMins
        If StringLen($iSecs) = 1 Then $iSecs = "0" & $iSecs
        Return $iHours & $Delim & $iMins & $Delim & $iSecs
    Else
        Return SetError(1, 0, "00" & $Delim & "00" & $Delim & "00")
    EndIf
EndFunc

;������� ��� ����������� ��������� (��� ����� � ������������ �����).
Func _MsgBox($MsgBoxType, $MsgBoxTitle, $MsgBoxText, $mainGUI)
    $ret = DllCall ("user32.dll", "int", "MessageBox", _
            "hwnd", $mainGUI, _
            "str", $MsgBoxText , _
            "str", $MsgBoxTitle, _
            "int", $MsgBoxType)
    Return $ret [0]
EndFunc

;������� ������������� ��� ������� �� ����� ������� (���������� ��������� Ctrl Q).
Func Quit()
    $AskAbort = _MsgBox(256+52, "Attention", "Are you sure that you want to abort this download?", $ProgressHwnd)
    If $AskAbort <> 6 Then Return
    InetGet("abort")
    Exit
EndFunc
