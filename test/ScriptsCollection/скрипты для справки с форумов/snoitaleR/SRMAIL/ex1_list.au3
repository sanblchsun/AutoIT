
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

 ; �������� ������ ���������

 $LIST=SRMAIL_LIST($SESSION)

 ; ����� � ������ ������
 
 If $LIST<0 Then
  MsgBox(0,"��������!","������ �������� ������ ���������: "&$LIST)
  Exit
 EndIf

 ; ����� � ������ ���������� ���������

 If $LIST=0 Then
  MsgBox(0,"��������!","��� ���������...")
  Exit
 EndIf

 ; �������� POP-������

 SRMAIL_CLOSE($SESSION)

 ; ����������� ������� � ��������� ���������

 _ArrayDisplay($LIST)

; �����
