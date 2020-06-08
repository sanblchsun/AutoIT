
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

 ; Создание списка заголовков сообщений

 $HEADERS=SRMAIL_HEADERS($SESSION)

 ; Выход в случае ошибки

 If $HEADERS<0 Then
  MsgBox(0,"Внимание!","Ошибка создания списка заголовков сообщений: "&$HEADERS)
  Exit
 EndIf

; Выход в случае отсутствия сообщений

 If Ubound($HEADERS)=0 Then
  MsgBox(0,"Внимание!","Нет сообщений")
  Exit
 EndIf

 ; Загрузка первого сообщения

 $MAIL=SRMAIL_LOAD($SESSION,1)

 ; Разделение сообщения на составляющие

 $PART=SRMAIL_PART($MAIL)

 ; Закрытие POP-сессии

 SRMAIL_CLOSE($SESSION)

 ; Сохранение сообщения

 For $iPART=1 To UBound($PART)-1

  $FILE=FileOpen($PART[$iPART][1],2)
  FileWrite($FILE,$PART[$iPART][0])
  FileClose($FILE)

 Next

; КОНЕЦ
