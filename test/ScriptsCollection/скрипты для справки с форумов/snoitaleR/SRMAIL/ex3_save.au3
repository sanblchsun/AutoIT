
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

 $MAIL=SRMAIL_LOAD($SESSION,2)

; ����� � ������ ���������� ���������

 If $MAIL<0 Then
  MsgBox(0,"��������!","������ ��������� ��������: "$MAIL)
  Exit
 EndIf

 ; �������� POP-������

 SRMAIL_CLOSE($SESSION)

 ; ���������� ���������

 SRMAIL_SAVE($MAIL)

; �����
