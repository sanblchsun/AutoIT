Global Const $WM_KEYDOWN = 0x0100
Global Const $WM_KEYUP = 0x0101
Dim $iKeyIndex=""
Global $sKeyName

$Gui = GUICreate("Нажимай клавиши клавиатуры", 400, 50)
GUISetState()

; GUIRegisterMsg($WM_NCLBUTTONUP, "WindowEvents")
GUIRegisterMsg($WM_KEYDOWN, "WindowEvents")
GUIRegisterMsg($WM_KEYUP, "WindowEvents")

Do
Until GUIGetMsg() = -3

Func WindowEvents($hWnd, $Msg, $wParam, $lParam)
    Switch $Msg
        Case $WM_KEYUP
            $aRet = DllCall('user32.dll', 'int', 'GetKeyNameText', 'int', $lParam, 'str', "", 'int', 256)
            $sKeyName = $aRet[2]
            $iKeyIndex=StringReplace($iKeyIndex,$sKeyName,"")
            ; If StringInStr('QWERTYUIOPASDFGHJKLZXCVBNM',$sKeyName ) Then WinSetTitle($Gui, '', $sKeyName&'  - Отпущена')
            WinSetTitle($Gui, '', $sKeyName&'  - Отпущена')

        Case $WM_KEYDOWN
            $aRet = DllCall('user32.dll', 'int', 'GetKeyNameText', 'int', $lParam, 'str', "", 'int', 256)
            $sKeyName = $aRet[2]
            if Not StringInStr($iKeyIndex,$sKeyName) Then
                $iKeyIndex  = $iKeyIndex & $sKeyName
            ; If StringInStr('QWERTYUIOPASDFGHJKLZXCVBNM',$sKeyName ) Then WinSetTitle($Gui, '', $sKeyName&'  - Нажата')
                WinSetTitle($Gui, '', $sKeyName&'  - Нажата')
            EndIf
    EndSwitch
EndFunc