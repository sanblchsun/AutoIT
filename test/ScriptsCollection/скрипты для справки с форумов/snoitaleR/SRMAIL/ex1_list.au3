
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
  MsgBox(0,"Внимание!","Ошибка создания POP-сессии: "&$SESSION)
  Exit
 EndIf

 ; Создание списка сообщений

 $LIST=SRMAIL_LIST($SESSION)

 ; Выход в случае ошибки
 
 If $LIST<0 Then
  MsgBox(0,"Внимание!","Ошибка создания списка сообщений: "&$LIST)
  Exit
 EndIf

 ; Выход в случае отсутствия сообщений

 If $LIST=0 Then
  MsgBox(0,"Внимание!","Нет сообщений...")
  Exit
 EndIf

 ; Закрытие POP-сессии

 SRMAIL_CLOSE($SESSION)

 ; Отображение массива с размерами сообщений

 _ArrayDisplay($LIST)

; КОНЕЦ
