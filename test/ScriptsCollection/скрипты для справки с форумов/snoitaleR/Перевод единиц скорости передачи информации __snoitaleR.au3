; ������

 $O='���|�������|�������|�������|����|��������|��������|��������'
 $T='� �������|� ������|� ���|� �����|� ������|� �����|� ���'
 Dim $AO[8]=[1,1024,1024*1024,1024*1024*1024,8,1024*8,1024*1024*8,1024*1024*1024*8]
 Dim $AT[7]=[1,60,60*60,60*60*24,60*60*24*7,60*60*24*30,60*60*24*365]

 $GUI=GUICreate('�������� �������� ����������',10+100+10+100+10+100+10+100+10,10+25+10+120+10-10)

 $IV=GUICtrlCreateInput('',10,10,100+10+100,25)
 $IO=GUICtrlCreateList('',10,10+25+10,100,120,0)
 $IT=GUICtrlCreateList('',10+100+10,10+25+10,100,120,0)

 $OV=GUICtrlCreateInput('',10+100+10+100+10,10,100+10+100,25,0x0800)
 $OO=GUICtrlCreateList('',10+100+10+100+10,10+25+10,100,120,0)
 $OT=GUICtrlCreateList('',10+100+10+100+10+100+10,10+25+10,100,120,0)

 GUICtrlSetData($IV,'1')
 GUICtrlSetData($IO,$O,'���')
 GUICtrlSetData($IT,$T,'� �������')

 GUICtrlSetData($OV,'1')
 GUICtrlSetData($OO,$O,'���')
 GUICtrlSetData($OT,$T,'� �������')

 GUISetState()

 $HIV=GUICtrlGetHandle($IV)

 GUIRegisterMsg(0x0111,'WM_COMMAND')

 While True
  Switch GUIGetMsg()
   Case -3
    ExitLoop
   Case $IO,$IT,$OO,$OT
    CALC()
  EndSwitch
 WEnd

 Func CALC()
  $IVV=GUICtrlRead($IV)
  $IOV=ControlCommand($GUI,'',$IO,'FindString',GUICtrlRead($IO))
  $ITV=ControlCommand($GUI,'',$IT,'FindString',GUICtrlRead($IT))
  $OOV=ControlCommand($GUI,'',$OO,'FindString',GUICtrlRead($OO))
  $OTV=ControlCommand($GUI,'',$OT,'FindString',GUICtrlRead($OT))
  GUICtrlSetData($OV,Floor($IVV*$AO[$IOV]*$AT[$OTV]/$AT[$ITV]/$AO[$OOV]))
 EndFunc

 Func WM_COMMAND($hWnd,$iMsg,$iwParam,$ilParam)
  Switch $ilParam
   Case $HIV
    Switch BitShift($iwParam,16)
     Case 0x300
      CALC()
     EndSwitch
  EndSwitch
  Return 'GUI_RUNDEFMSG'
 EndFunc

; �����
 