; ������

 #Include <ie.au3>

 $GUI=GUICreate("",200,200)

; �������� �������� "�������"

 $oIE=_IECreateEmbedded()
 GUICtrlCreateObj($oIE,10,10,180,180)
 _IENavigate($oIE,'about:blank')
 $DESCRIPTION="<html><body><h1>������!</h1></body></html>"
 _IEDocWriteHTML($oIE,$DESCRIPTION)
 
 GUISetState()

; ���� ��������� ���������

 While True
  $MSG=GUIGetMsg()
  Switch $MSG
   Case -3
    ExitLoop
  EndSwitch
 WEnd

; �����