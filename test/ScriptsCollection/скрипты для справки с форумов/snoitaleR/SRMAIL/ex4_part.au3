
; ������

; ����������

 #Include <srmail.au3>
 #Include <array.au3> ; ��� ������� _ArrayDisplay()

 ; ��������� �����������

 $POP=IniRead("mail.ini","qwerty@mail.ru","pop","")
 $USER=IniRead("mail.ini","qwerty@mail.ru","user","")
 $PASS=IniRead("mail.ini","qwerty@mail.ru","pass","")

 ; �������� POP-������

 $SESSION=SRMAIL_POP($POP,$USER,$PASS)

 ; ����� � ������ ������

 If $SESSION<0 Then
  MsgBox(0,"��������!","������ �������� POP-������: "&$SESSION)
  Exit
 EndIf

 ; �������� ������ ���������� ���������

 $HEADERS=SRMAIL_HEADERS($SESSION)

 ; ����� � ������ ������

 If $HEADERS<0 Then
  MsgBox(0,"��������!","������ �������� ������ ���������� ���������: "&$HEADERS)
  Exit
 EndIf

; ����� � ������ ���������� ���������

 If Ubound($HEADERS)=0 Then
  MsgBox(0,"��������!","��� ���������")
  Exit
 EndIf

 ; �������� ������� ���������

 $MAIL=SRMAIL_LOAD($SESSION,1)

 ; ���������� ��������� �� ������������

 $PART=SRMAIL_PART($MAIL)

 ; �������� POP-������

 SRMAIL_CLOSE($SESSION)

 ; ���������� ���������

 For $iPART=1 To UBound($PART)-1

  $FILE=FileOpen($PART[$iPART][1],2)
  FileWrite($FILE,$PART[$iPART][0])
  FileClose($FILE)

 Next

; �����
