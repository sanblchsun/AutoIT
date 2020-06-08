#include <GUIConstants.au3>

$GUI = GUICreate("Image Upload", 340, 140)

$Image_Input = GUICtrlCreateInput("", 5, 7, 300, 21)
$SF_Button = GUICtrlCreateButton("...", 310, 5, 25, 23)

$Progress = GUICtrlCreateProgress(5, 30, 300, 18, $PBS_SMOOTH)

$Upload_Button = GUICtrlCreateButton("Загрузить ", 5, 50, 330, 21, 0)

$Edit = GUICtrlCreateEdit("", 5, 75, 330, 55, BitOR($ES_AUTOVSCROLL, $ES_AUTOHSCROLL, $ES_WANTRETURN))

GUISetState(@SW_SHOW)

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            ExitLoop
        Case $SF_Button
            $sFile = FileOpenDialog("Open File", "", "Images (*.jpg;*.jpeg;*.png;*.gif)", 1)
            GUICtrlSetData($Image_Input, $sFile)
        Case $Upload_Button
            $Read_Input = GUICtrlRead($Image_Input)
            If Not FileExists($Read_Input) Then ContinueLoop

            GUISetState(@SW_DISABLE, $GUI)
            $pHwnd = ProgressCreate($GUI)

            $aRet = DllCall(@ScriptDir & "\UploadFile.dll", "str", "UploadFile", _
                "str", "http://www.imageshack.us/index.php", _
                "str", "fileupload", _
                "str", _GetContentType($Read_Input), _
                "str", $Read_Input)
            $Extract_URL = StringRegExp($aRet[0], '(?i)(?s).*value="(.*)"/>.*', 1)

            GUICtrlSetData($Edit, $Extract_URL[UBound($Extract_URL)-1] & @CRLF & @CRLF)
            GUICtrlSetData($Progress, 100)

            GUISetState(@SW_ENABLE, $GUI)
            GUIDelete($pHwnd)
            FileDelete(@TempDir & "\Temp_Prgrs_Script.au3")
    EndSwitch
WEnd

Func ProgressCreate($hWnd)
    Local $Ret_hWnd = GUICreate("__Progress_GUI__")

    Local $aPos = WinGetPos($hWnd)

    Local $iLeft = $aPos[0] + 7
    Local $iTop = $aPos[1] + 52

    Local $sScript = '#NoTrayIcon' & @CRLF
    $sScript &= '$Gui = GuiCreate("", 300, 18, ' & $iLeft & ', ' & $iTop & ', ' & $WS_POPUP & ')' & @CRLF
    $sScript &= '$Progress = GUICtrlCreateProgress(0, 0, 300, 18, ' & $PBS_SMOOTH & ')' & @CRLF
    $sScript &= 'GUISetState()' & @CRLF
    $sScript &= 'While WinExists("__Progress_GUI__")' & @CRLF
    $sScript &= '   $ReadProgress = GUICtrlRead($Progress, 1) + 2' & @CRLF
    $sScript &= '   If $ReadProgress >= 100 Then $ReadProgress = 0' & @CRLF
    $sScript &= '   GUICtrlSetData($Progress, $ReadProgress)' & @CRLF
    $sScript &= '   Sleep(50)' & @CRLF
    $sScript &= 'WEnd' & @CRLF
    $sScript &= 'GUIDelete($Gui)'

    $hFile = FileOpen(@TempDir & "\Temp_Prgrs_Script.au3", 2)
    FileWrite($hFile, $sScript)
    FileClose($hFile)

    Run(@AutoItExe & ' /AutoIt3ExecuteScript "' & @TempDir & '\Temp_Prgrs_Script.au3"')

    Return $Ret_hWnd
EndFunc

Func _GetContentType($sPath)
    Return "image/" & StringRegExpReplace($sPath, "^.*\.", "")
EndFunc