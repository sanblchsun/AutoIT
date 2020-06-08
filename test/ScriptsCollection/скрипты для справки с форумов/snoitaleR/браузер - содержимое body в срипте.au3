; НАЧАЛО

 #Include <ie.au3>

 $GUI=GUICreate("",200,200)

; Создание элемента "Браузер"

 $oIE=_IECreateEmbedded()
 GUICtrlCreateObj($oIE,10,10,180,180)
 _IENavigate($oIE,'about:blank')
 $oBody=_IETagNameGetCollection($oIE,"body",0)
 $DESCRIPTION="<h1>Привет!</h1>"
 _IEBodyWriteHTML($oBody,$DESCRIPTION)

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