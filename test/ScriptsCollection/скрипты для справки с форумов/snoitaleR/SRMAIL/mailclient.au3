
; НАЧАЛО

; Содержание файла mail.ini
;
; [название ящика]      
; user=           
; pass=
; pop=      
; smtp=
;
; Секций должно быть столько, сколько отслеживаемых ящиков    

 Opt("TrayIconDebug",1)

 #Include <srmail.au3>
 #Include <array.au3>

 $CFGINI="mail.ini"
 $KNOWNINI="known.ini"
 
 $GUI=GUICreate("Почта",400,400,-1,-1)
 $MAILBOXTREE=GUICtrlCreateTreeView(10,10,380,345,0x0001+0x0002+0x0004+0x0010+0x0020+0x0100+0x8000) ; +0x0200
 $CHECK=GUICtrlCreateButton("Обработать",10,365,380,25)

 $aMAILBOX=IniReadSectionNames($CFGINI)
 $aKNOWN=IniReadSection($KNOWNINI,"include")

 LOADMAILBOXLIST()

 GUISetState()

 While True

  Switch GUIGetMsg()
   Case -3
    Exit
   Case $CHECK
    CHECK()
  EndSwitch

 WEnd

 Func LOADMAILBOXLIST()

  Global $MAILBOXLIST[UBound($aMAILBOX)][2]

  For $iMAILBOX=1 To UBound($aMAILBOX)-1
   $MAILBOXLIST[$iMAILBOX][0]=GUICtrlCreateTreeViewItem($aMAILBOX[$iMAILBOX],$MAILBOXTREE)
  Next

 EndFunc

; Проверка почтового ящика

 Func CHECK()

  For $iMAILBOX=1 To UBound($aMAILBOX)-1

   $STATE=GUICtrlRead($MAILBOXLIST[$iMAILBOX][0])
   $NAME=GUICtrlRead($MAILBOXLIST[$iMAILBOX][0],1)

   If ($STATE=1) Or ($STATE=257) Then

    $POP=IniRead($CFGINI,$NAME,"pop","")
    $USER=IniRead($CFGINI,$NAME,"user","")
    $PASS=IniRead($CFGINI,$NAME,"pass","")

    $SESSION=SRMAIL_POP($POP,$USER,$PASS)

    If $SESSION<0 Then
     ContinueLoop
    EndIf

    $HEADERS=SRMAIL_HEADERS($SESSION)

    If $HEADERS<0 Then
     SRMAIL_CLOSE($SESSION)
     ContinueLoop
    EndIf

    If $HEADERS=0 Then
     GuiCtrlSetState($MAILBOXLIST[$iMAILBOX][0],0)
     SRMAIL_CLOSE($SESSION)
     ContinueLoop
    EndIf

    SRMAIL_CLOSE($SESSION)

    Local $MAIL[UBound($HEADERS)][2]

    For $iHEADERS=1 To UBound($HEADERS)-1

     For $iKNOWN=1 To UBound($aKNOWN)-1
      If $aKNOWN[$iKNOWN][0]=$HEADERS[$iHEADERS][2] Then
       $SENDERNAME=$aKNOWN[$iKNOWN][1]
       ExitLoop
      Else
       $SENDERNAME="{неизвестный отправитель}"
      EndIf
     Next

     $MAIL[$iHEADERS][0]=GUICtrlCreateTreeViewItem($SENDERNAME,$MAILBOXLIST[$iMAILBOX][0])

     Local $MSG[UBound($HEADERS,2)]

     For $iMSG=0 To UBound($HEADERS,2)-1

      $MSG[$iMSG]=GUICtrlCreateTreeViewItem($HEADERS[$iHEADERS][$iMSG],$MAIL[$iHEADERS][0])
      HIDECHECKBOX($MAILBOXTREE,$MSG[$iMSG])

     Next

     $MAIL[$iHEADERS][1]=$MSG

    Next

    GuiCtrlSetState($MAILBOXLIST[$iMAILBOX][0],0)

    $MAILBOXLIST[$iMAILBOX][1]=$MAIL

   EndIf

  Next

 EndFunc

 Func HIDECHECKBOX($VIEW,$ITEM)

  ;$S=DllStructCreate("uint;dword;uint;uint;ptr;int;int;int;int;int;int")
  ;DllStructSetData($S,1,0x00000008)
  ;DllStructSetData($S,2,$ITEM)
  ;DllStructSetData($S,3,0)
  ;DllStructSetData($S,4,0x0000F000)
  ;DllCall("user32.dll","int","SendMessage","hwnd",$VIEW,"int",4365,"int",0,"int",DllStructGetPtr($S))

    Local $hWnd = GUICtrlGetHandle($VIEW)
    If $hWnd = 0 Then $hWnd = $VIEW
   
    Local $hItem = GUICtrlGetHandle($ITEM)
    If $hItem = 0 Then $hItem = $ITEM
   
    Local $tvItem = DllStructCreate("uint;dword;uint;uint;ptr;int;int;int;int;int;int")
   
    DllStructSetData($tvItem, 1, 0x00000008)
    DllStructSetData($tvItem, 2, $hItem)
    DllStructSetData($tvItem, 3, 0)
    DllStructSetData($tvItem, 4, 0x0000F000)

    $TVM_SETITEMA=0x1100+13
   
    $nResult = DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", $TVM_SETITEMA, "int", 0, "int", DllStructGetPtr($tvItem))

 EndFunc


; КОНЕЦ
