#NoTrayIcon 
#include "ModernMenuRaw.au3" ; Only unknown constants are declared here 
 
; *** Create the tray icon *** 
$nTrayIcon1        = _TrayIconCreate("Tools", "shell32.dll", -13) 
_TrayIconSetClick(-1, 16) 
_TrayIconSetState() ; Show the tray icon 
; *** Create the tray context menu *** 
$nTrayMenu1        = _TrayCreateContextMenu() ; is the same like _TrayCreateContextMenu(-1) or _TrayCreateContextMenu($nTrayIcon1) 
$TrayHelp        = _TrayCreateItem("Help") 
$TrayExit        = _TrayCreateItem("Exit") 
_TrayItemSetIcon($TrayHelp, "shell32.dll", -24) 
_TrayItemSetIcon($TrayExit, "shell32.dll", -28) 
 
Dim $nTrayIcon2 = 0 
; Create an icon which demonstrates how to use click event - see the function 'MyTrayTipCallBack' 
Dim $nTrayIcon3 = _TrayIconCreate("Click me", "shell32.dll", -16, "MyTrayTipCallBack") 
_TrayIconSetState() 
Dim $nTrayIcon4 = _TrayIconCreate("Click me", "shell32.dll", -15, "MyTrayTipCallBack") 
_TrayIconSetState() 
 
 
While 1 
    $Msg = GUIGetMsg() 
    Switch $Msg 
        Case $TrayExit 
            ExitLoop 
             
        Case $TrayHelp 
            If $nTrayIcon2 = 0 Then 
                $nTrayIcon2 = _TrayIconCreate("New message", "shell32.dll", -14, "MyTrayTipCallBack") 
                _TrayIconSetState(-1, 5) ; Show icon and start flashing -> 1 + 4 
            Else 
                _TrayIconSetState($nTrayIcon2, 5) ; Show icon and start flashing -> 1 + 4 
            EndIf 
            _TrayTip($nTrayIcon2, "New message", "A new message has arrived." & @CRLF & "Please click here to read...", 15, $NIIF_INFO) 
    EndSwitch 
WEnd 
 
_TrayIconDelete($nTrayIcon1) 
_TrayIconDelete($nTrayIcon3) 
_TrayIconDelete($nTrayIcon4) 
If $nTrayIcon2 > 0 Then _TrayIconDelete($nTrayIcon2) 
Exit 
 
Func MyTrayTipCallBack($nID, $nMsg) 
    Switch $nID 
        Case $nTrayIcon2 
            Switch $nMsg 
                Case $NIN_BALLOONUSERCLICK, $NIN_BALLOONTIMEOUT 
                    _TrayIconSetState($nTrayIcon2, 8) ; Stop icon flashing 
                    If $nMsg = $NIN_BALLOONUSERCLICK Then MsgBox(64, "Information", "This could be your message.") 
                    _TrayIconSetState($nTrayIcon2, 2) ; Hide icon 
            EndSwitch 
        Case $nTrayIcon3 
            Switch $nMsg 
            ;;;    Case $WM_LBUTTONDOWN 
                    ; Put your stuff here 
            ;;;    case $WM_LBUTTONUP 
                    ; Put your stuff here ; One click and double click to put together is difficult 
            ;;;    case $WM_LBUTTONDBLCLK 
            ;;;    case $WM_RBUTTONDOWN 
                    ; Put your stuff here 
                case $WM_RBUTTONUP 
                    MsgBox(64,"","Был сделан клик правой кнопкой мышки по TrayIcon3") 
            ;;;    case $WM_RBUTTONDBLCLK 
                    ; Put your stuff here 
            ;;;    case $WM_MOUSEMOVE 
                    ; Put your stuff here 
            EndSwitch 
        Case $nTrayIcon4 
            Switch $nMsg 
            ;;;    Case $WM_LBUTTONDOWN 
                    ; Put your stuff here 
                case $WM_LBUTTONUP 
                    MsgBox(64,"","Был сделан клик левой кнопкой мышки по TrayIcon4") 
                    ; Put your stuff here ; One click and double click to put together is difficult 
            ;;;    case $WM_LBUTTONDBLCLK 
            ;;;    case $WM_RBUTTONDOWN 
                    ; Put your stuff here 
            ;;;    case $WM_RBUTTONUP 
            ;;;    case $WM_RBUTTONDBLCLK 
                    ; Put your stuff here 
            ;;;    case $WM_MOUSEMOVE 
                    ; Put your stuff here 
            EndSwitch 
    EndSwitch 
EndFunc 