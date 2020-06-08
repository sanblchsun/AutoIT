; НАЧАЛО

 #Include <ie.au3>

 $GUI=GUICreate("",200,200)

; Создание элемента "Браузер"

 $oIE=_IECreateEmbedded()
 GUICtrlCreateObj($oIE,10,10,180,180)
 _IENavigate($oIE,'about:blank')
 $DESCRIPTION="<html><body><h1>Привет!</h1></body></html>"
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