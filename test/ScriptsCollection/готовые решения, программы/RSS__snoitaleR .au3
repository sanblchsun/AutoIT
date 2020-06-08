
; ������

 #Include <ie.au3>

; AUTOIT: ������� �����
 $URL="http://autoit-script.ru/index.php?type=rss;action=.xml"

; AUTOIT: ���������� � �������
; $URL="http://autoit-script.ru/index.php?type=rss;action=.xml;board=1;limit=20"

; AUTOIT: ��� �������
; $URL="http://autoit-script.ru/index.php?type=rss;action=.xml;limit=10"

; AUTOIT: ������� ������
; $URL="http://autoit-script.ru/index.php?type=rss;action=.xml;board=13;limit=10"

; AUTOIT: �������� ������� 
; $URL="http://autoit-script.ru/index.php?type=rss;action=.xml;boards=4,5,6,7,11,26;limit=20"

; AUTOIT: ��� ������� ����� � �������
; $URL="http://autoit-script.ru/index.php?type=rss;action=.xml;boards=1,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,19,20,21,23,26;limit=20"

; SOFTODROM: �������
; $URL="http://news.softodrom.ru/scr/rss.php"

; SOFTODROM: ���������
; $URL="http://soft.softodrom.ru/scr/rss.php"

 $PATH="rss.tmp" ; ��������� ����

; $AREA=LOAD($PATH) ; ��������� ������� �� �����

 $AREA=LOAD($PATH,$URL) ; ��������� ������� �� ���������

; ������ ��������� �����
; MsgBox(0,"���������",ATTR($AREA,"?xml","encoding"))

; ������ ������ �����
; MsgBox(0,"������",ATTR($AREA,"rss","version"))

 $CHANNEL=TAG($AREA,"channel") ; ��������� ������� "�����"

; ������ ��������� ������
; MsgBox(0,"���������",TAG($CHANNEL,"title"))

; ������ ������ �� ����
; MsgBox(0,"����",TAG($CHANNEL,"link"))

; ������ �������� ������
; MsgBox(0,"��������",TAG($CHANNEL,"description"))

; �������� ����

 $GUI=GUICreate("RSS-�����",600,490)

; �������� ������ ����������

 $TREE=GUICtrlCreateTreeView(10,10,580,220)

 $iL=0

 While True

  $iL+=1
  $ITEM=TAG($CHANNEL,"item",$iL)
  If $ITEM="" Then ExitLoop
  $TITLE=TAG($ITEM,"title")
  Assign("TREE"&StringFormat("%02d",$iL),GUICtrlCreateTreeViewItem($TITLE,$TREE))

 WEnd

; �������� �������� "�������"

 $oIE=_IECreateEmbedded()
 GUICtrlCreateObj($oIE,10,240,580,240)
 _IENavigate($oIE,'about:blank')
 $oBody=_IETagNameGetCollection($oIE,"body",0)

 GUISetState()

; ���� ��������� ���������

 While True
  $MSG=GUIGetMsg()
  Switch $MSG
   Case -3
    ExitLoop
  EndSwitch
  For $i=1 To $iL-1
   If $MSG=Eval("TREE"&StringFormat("%02d",$i)) Then
    If GUICtrlRead($TREE)=Eval("TREE"&StringFormat("%02d",$i)) Then
     $ITEM=TAG($CHANNEL,"item",$i)
     $AUTHOR=TAG($ITEM,"author")
     $CATEGORY=TAG($ITEM,"category")
     $DESCRIPTION=TAG($ITEM,"description")
     $DESCRIPTION="<p><i>"&$CATEGORY&"</i><br><b>"&$AUTHOR&"</b></p>"&$DESCRIPTION
     _IEBodyWriteHTML($oBody,$DESCRIPTION)
     ExitLoop
    EndIf
   EndIf
  Next
 WEnd

; �������

 ; �������� �������

 Func LOAD($PATH,$URL="")

  If $URL<>"" Then InetGet($URL,$PATH)
  $FILE=FileOpen($PATH,0)
  $AREA=FileRead($FILE)
  FileClose($FILE)
  $AREA=StringReplace($AREA,Chr(9),"")
  $AREA=StringReplace($AREA,Chr(10),"")
  $AREA=StringReplace($AREA,Chr(13),"")
  $AREA=StringReplace($AREA,"&#38;#093;","]")
  $AREA=StringReplace($AREA,"<![CDATA[","")
  $AREA=StringReplace($AREA,"]]>","")
  $AREA=StringReplace($AREA,"&nbsp;"," ")
  $AREA=StringReplace($AREA,"&quot;","""")
  $AREA=StringReplace($AREA,"&lt;","<")
  $AREA=StringReplace($AREA,"&gt;",">")
  $AREA=StringStripWS($AREA,4)
  ;$AREA=StringRegExpReplace($AREA,'(<a)(.*)(>)(.*)(</a>)','\4')
  ;$AREA=StringRegExpReplace($AREA,'(<img)(.*)(>)','')
  Return $AREA

 EndFunc

 ; ������ ����

 Func TAG($AREA,$TAG,$INDEX=1)

  $OPEN="<"&$TAG&">"
  $CLOSE="</"&$TAG&">"
  $BEGIN=StringInStr($AREA,$OPEN,0,$INDEX)
  If $BEGIN=0 Then Return ""
  $BEGIN=$BEGIN+StringLen($OPEN)
  $END=StringInStr($AREA,$CLOSE,0,1,$BEGIN)-1
  Return StringMid($AREA,$BEGIN,$END-$BEGIN+1)

 EndFunc

 ; ������ ��������

 Func ATTR($AREA,$TAG,$ATTR)

  $OPEN="<"&$TAG
  $CLOSE=">"
  $BEGIN=StringInStr($AREA,$OPEN)
  If $BEGIN=0 Then Return ""
  $BEGIN=$BEGIN+StringLen($OPEN)
  $END=StringInStr($AREA,$CLOSE,0,1,$BEGIN)-1
  $AREA=StringMid($AREA,$BEGIN,$END-$BEGIN+1)
  $BEGIN=StringInStr($AREA,$ATTR)
  If $BEGIN=0 Then Return ""
  $BEGIN=StringInStr($AREA,'"',0,1,$BEGIN)+1
  $END=StringInStr($AREA,'"',0,1,$BEGIN)-1
  Return StringMid($AREA,$BEGIN,$END-$BEGIN+1)

 EndFunc

; �����

 