
; НАЧАЛО

; БИБЛИОТЕКИ

 #Include <srmail.au3>
 #Include <array.au3> ; для функции _ArrayDisplay()

 $SMTP=IniRead("mail.ini","qwerty@mail.ru","smtp","")
 $USER=IniRead("mail.ini","qwerty@mail.ru","user","")
 $PASS=IniRead("mail.ini","qwerty@mail.ru","pass","")

 $SUBJECT=""
 $TEXT=""
 $FROM=""
 $TO=""
 $ATTACH=""

 ; Создание SMTP-сессии

 $SESSION=SRMAIL_SMTP($SMTP,$USER,$PASS)

 ; Выход в случае ошибки

 If $SESSION<0 Then
  MsgBox(0,"","Ошибка создания SMTP-сессии: "&$SESSION)
  Exit
 EndIf

 ; Отправка сообщения с вложением

 $MAIL=SRMAIL_SEND($SESSION,$SUBJECT,$TEXT,$FROM,$TO,$ATTACH)

 ; Выход в случае ошибки

 If $MAIL<0 Then
  MsgBox(0,"","Ошибка передачи сообщения: "&$MAIL)
  Exit
 EndIf

 ; Закрытие SMTP-сессии

 SRMAIL_CLOSE($SESSION)

 ; Сохранение сообщения

 SRMAIL_SAVE($MAIL)

; КОНЕЦ
