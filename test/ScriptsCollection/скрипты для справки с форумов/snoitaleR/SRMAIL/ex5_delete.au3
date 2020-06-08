
; НАЧАЛО

; БИБЛИОТЕКИ

 #Include <srmail.au3>
 #Include <array.au3> ; для функции _ArrayDisplay()

 ; Параметры подключения

 $POP=IniRead("mail.ini","qwerty@mail.ru","pop","")
 $USER=IniRead("mail.ini","qwerty@mail.ru","user","")
 $PASS=IniRead("mail.ini","qwerty@mail.ru","pass","")

 ; Открытие POP-сессии

 $SESSION=SRMAIL_POP($POP,$USER,$PASS)

 ; Выход в случае ошибки

 If $SESSION<0 Then
  MsgBox(0,"Внимание!","Ошибка подключения к серверу: "&$SESSION)
  Exit
 EndIf

 ; Создание списка заголовков сообщений

 $HEADERS=SRMAIL_HEADERS($SESSION)

 ; Выход в случае ошибки

 If $HEADERS<0 Then
  MsgBox(0,"Внимание!","Ошибка создания списка заголовков сообщений: "&$SESSION)
  Exit
 EndIf

 ; Выход в случае отсутствия сообщений

 If Ubound($HEADERS)=0 Then
  MsgBox(0,"Внимание!","Нет сообщений")
  Exit
 EndIf

 ; Удаление первого сообщения

 $DELETE=SRMAIL_DELETE($SESSION,1)

 ; Выход в случае ошибки

 If $DELETE<0 Then
  MsgBox(0,"Внимание!","Ошибка удаления сообщения: "&$DELETE)
  Exit
 EndIf

 ; Закрытие POP-сессии

 SRMAIL_CLOSE($SESSION)

; КОНЕЦ
