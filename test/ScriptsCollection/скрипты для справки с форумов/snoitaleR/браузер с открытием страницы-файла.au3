; НАЧАЛО

 #Include <ie.au3>

 $GUI=GUICreate("",600,600)

; Создание элемента "Браузер"

 $oIE=_IECreateEmbedded()
 GUICtrlCreateObj($oIE,10,10,580,580)
 _IENavigate($oIE,'about:blank')
 
 $file = FileOpen(@ScriptDir&'\file.htm', 0)
$DESCRIPTION = FileRead($file)
FileClose($file)
 
 ; $DESCRIPTION="<html><body><h1>Привет!</h1></body></html>"
 _IEDocWriteHTML($oIE,$DESCRIPTION)
 
 GUISetState()

; Цикл обработки сообщений

 While True
  $MSG=GUIGetMsg()
  Switch $MSG
   Case -3
    ExitLoop
  EndSwitch
 WEnd

; КОНЕЦ