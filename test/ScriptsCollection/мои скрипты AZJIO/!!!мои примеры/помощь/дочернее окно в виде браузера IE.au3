; http://autoit-script.ru/index.php/topic,7122.msg49085.html#msg49085
#include <WindowsConstants.au3>
#Include <ie.au3>

$Gui=GUICreate("Программа", 300,200)
If Not @compiled Then GUISetIcon(@ScriptDir&'\icon.ico')
$Viewer=GUICtrlCreateButton ("Просмотр", 130, 120,120,38)
GUISetState()

While 1
    $msg = GUIGetMsg()
    Switch $msg
        Case $Viewer
            $text_arr='<div  style="background:#eeffee;"><a href="http://autoit-script.ru/index.php/topic,7122.msg49040/topicseen.html#new" target="_blank">типа ссылка</a><br><b><font color="#00A1E6">текст какой то</font></b> - текст какой то<br><br>текст какой то</div>'
            _Viewer($text_arr)
        Case -3
            Exit
    EndSwitch
WEnd

Func _Viewer($html)
Local $EditBut, $Gui1, $msg, $StrBut
    GUISetState(@SW_DISABLE, $Gui)
    
    $Gui1 = GUICreate('ага', 700, 500, -1, -1, $WS_OVERLAPPEDWINDOW, -1,$Gui)
    If Not @compiled Then GUISetIcon(@ScriptDir&'\icon.ico')

     $oIE=_IECreateEmbedded()
     GUICtrlCreateObj($oIE, 5, 5, 690, 490)
    GUICtrlSetResizing(-1, 2+4+32+64)
     _IENavigate($oIE,'about:blank')
     _IEDocWriteHTML($oIE, '<html><body style="background:#eeeeee;">'&$html&'</body></html>')
 
    GUISetState(@SW_SHOW, $Gui1)
    While 1
      $msg = GUIGetMsg()
      Select
        Case $msg = -3
            ExitLoop
        EndSelect
    WEnd
    GUISetState(@SW_ENABLE, $Gui)
    GUIDelete($Gui1)
EndFunc