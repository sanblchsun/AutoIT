
; ������

; ����������

 #Include <srmail.au3>
 #Include <array.au3> ; ��� ������� _ArrayDisplay()

 $SMTP=IniRead("mail.ini","qwerty@mail.ru","smtp","")
 $USER=IniRead("mail.ini","qwerty@mail.ru","user","")
 $PASS=IniRead("mail.ini","qwerty@mail.ru","pass","")

 $SUBJECT=""
 $TEXT=""
 $FROM=""
 $TO=""
 $ATTACH=""

 ; �������� SMTP-������

 $SESSION=SRMAIL_SMTP($SMTP,$USER,$PASS)

 ; ����� � ������ ������

 If $SESSION<0 Then
  MsgBox(0,"","������ �������� SMTP-������: "&$SESSION)
  Exit
 EndIf

 ; �������� ��������� � ���������

 $MAIL=SRMAIL_SEND($SESSION,$SUBJECT,$TEXT,$FROM,$TO,$ATTACH)

 ; ����� � ������ ������

 If $MAIL<0 Then
  MsgBox(0,"","������ �������� ���������: "&$MAIL)
  Exit
 EndIf

 ; �������� SMTP-������

 SRMAIL_CLOSE($SESSION)

 ; ���������� ���������

 SRMAIL_SAVE($MAIL)

; �����
