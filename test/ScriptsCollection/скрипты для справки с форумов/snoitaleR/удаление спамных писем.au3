
; НАЧАЛО

#Region > СВЕДЕНИЯ О БИБЛИОТЕКЕ

; Библиотека для работы с электронной почтой по протоколам POP и SMTP
; Версия библиотеки: 0.3
; Версия AUTOIT: 3.3.6.1

#EndRegion < СВЕДЕНИЯ О БИБЛИОТЕКЕ

#Region > ПРИМЕРЫ

#cs > ПРИМЕР: КОЛИЧЕСТВО СООБЩЕНИЙ

 $POP="pop.mail.ru"
 $USER=""
 $PASS=""

 $SESSION=OPEN($POP,$USER,$PASS)

 If $SESSION=-1 Then
  MsgBox("Ошибка подключения к серверу")
  Exit
 EndIf

 $LIST=LIST($SESSION)
 
 If $LIST=-1 Then
  MsgBox("Ошибка создания списка сообщений")
  Exit
 EndIf

 MsgBox(0,"",UBound($LIST)-1)

 CLOSE($SESSION)

#ce < ПРИМЕР: КОЛИЧЕСТВО СООБЩЕНИЙ

;#cs > ПРИМЕР: УДАЛЕНИЕ СООБЩЕНИЙ

 $POP="pop.mail.ru"
 $USER="xxx@mail.ru"
 $PASS="xxx"

 ; Адрес отправителя, сообщения которого автоматически удаляются
 $AUTODELETE="spo_ekb@subscribe.teztour.com"

 $SESSION=OPEN($POP,$USER,$PASS)

 If $SESSION=-1 Then
  MsgBox("Ошибка подключения к серверу")
  Exit
 EndIf

 $HEADERS=HEADERS($SESSION)

 If $HEADERS=-1 Then
  MsgBox("Ошибка создания списка сообщений")
  Exit
 EndIf

 For $iH=1 To UBound($HEADERS)-1
 If $HEADERS[$iH][2]=$AUTODELETE Then
   DELETE($SESSION,$iH)
  EndIf
 Next

 CLOSE($SESSION)

;#ce < ПРИМЕР: УДАЛЕНИЕ СООБЩЕНИЙ

#EndRegion < ПРИМЕРЫ

#Region > ИСПОЛЬЗУЕМЫЕ БИБЛИОТЕКИ

; #Include <Encoding.au3>
; #Include <Array.au3>

#EndRegion < ИСПОЛЬЗУЕМЫЕ БИБЛИОТЕКИ

#Region > ФУНКЦИИ ПОЛУЧЕНИЯ СООБЩЕНИЙ

; Открытие сессии

 Func OPEN($POP,$USER,$PASS)
  ; Запуск TCP-сервиса
  TCPStartup()
  ; Подключение к почтовому серверу
  $SOCKET=TCPConnect(TCPNameToIP($POP),110)
  ; Выход в случае ошибки
  If $SOCKET=-1 Then Return -1
  ; Прием отклика
  RECEIVE($SOCKET)
  ; Передача команды авторизации
  TCPSend($SOCKET,"user "&$USER&@CRLF)
  ; Прием отклика
  RECEIVE($SOCKET)
  ; Передача команды подтверждения личности
  TCPSend($SOCKET,"pass "&$PASS&@CRLF)
  ; Выход в случае ошибки
  If RECEIVE($SOCKET)=-1 Then Return -2
  ; Возвращение номера сессии
  Return $SOCKET
 EndFunc ; < OPEN()

; Закрытие сессии

 Func CLOSE($SOCKET)
  ; Отправка команды завершения сессии
  TCPSend($SOCKET,'quit'&@CRLF)
  ; Отключение от сервера
  TCPCloseSocket($SOCKET)
  ; Остановка TCP-сервиса
  TCPShutdown()
 EndFunc ; < CLOSE()

; Получение списка сообщений

 Func LIST($SOCKET)
  ; Запрос списка сообщений
  TCPSend($SOCKET,'list'&@CRLF)
  ; Выход в случае ошибки
  If RECEIVE($SOCKET)=-1 Then Return -1
  ; Получение списка сообщений
  $LIST=RECEIVE($SOCKET)
  ; Выход в случае ошибки
  If $LIST=-1 Then Return -1
  ; Формирование массива размеров сообщений
  $LIST=StringReplace($LIST,@CRLF&"."&@CRLF,"")
  $LIST=StringSplit($LIST,@CRLF,1)
  For $iL=1 To UBound($LIST)-1
   $LIST[$iL]=StringTrimLeft($LIST[$iL],StringInStr($LIST[$iL]," "))
  Next
  ; Возвращение массива размеров сообщений
  Return $LIST
 EndFunc ; < LIST()

; Получение заголовка сообщения

 Func HEADER($SOCKET,$INDEX)
  ; Запрос заголовка сообщения
  TCPSend($SOCKET,"top "&$INDEX&" 0"&@CRLF)
  ; Выход в случае ошибки
  If RECEIVE($SOCKET)=-1 Then Return -1
  ; Получени заголовка сообщения
  $HEADER=RECEIVE($SOCKET)
  ; Выход в случае ошибки
  If $HEADER=-1 Then Return -1
  ; Возвращение заголовока сообщения
  Return $HEADER
 EndFunc ; < HEADER()

; Получение списка заголовков

 Func HEADERS($SOCKET)
  $LIST=LIST($SOCKET)
  If $LIST=-1 Then -1
  Dim $HEADERS[UBound($LIST)][5]
  For $iH=1 To UBound($HEADERS)-1
   ; Загрузка заголовка сообщения
   $HEADER=HEADER($SOCKET,$iH)
   ; Размер сообщения
   $HEADERS[$iH][0]=$LIST[$iH]
   ; Тема сообщения
   $HEADERS[$iH][1]=SUBJECT($HEADER)
   ; Почтовый ящик отправителя
   $HEADERS[$iH][2]=SENDER($HEADER)
   ; Почтовый ящик получателя
   $HEADERS[$iH][3]=RECIPIENT($HEADER)
   ; Дата получения сообщения
   $HEADERS[$iH][4]=DATE($HEADER)
  Next
  ; Возвращение массива заголовков сообщений
  Return $HEADERS
 EndFunc

 ; Загрузка сообщения

 Func LOAD($SOCKET,$INDEX)
  ; Отправка команды загрузки сообщения
  TCPSend($SOCKET,"retr "&$INDEX&@CRLF)
  ; Выход в случае ошибки
  If RECEIVE($SOCKET)=-1 Then Return -1
  ; Загрузка сообщения
  $LOAD=RECEIVE($SOCKET)
  ; Выход в случае ошибки
  If $LOAD=-1 Then Return -1
  ; Возвращение содержания сообщения
  Return $LOAD
 EndFunc ; < LOAD()

; Пометка сообщения к удалению

 Func DELETE($SOCKET,$INDEX)
  ; Отправка команды пометки сообщения к удалению
  TCPSend($SOCKET,"dele "&$INDEX&@CRLF)
  ; Получение подтверждения
  $DELETE=RECEIVE($SOCKET)
  ; Выход в случае ошибки
  If $DELETE=-1 Then Return -1
  ; Возвращение подтверждения
  Return 1
 EndFunc ; < DELETE()

; Отказ от удаления сообщений в пределах сессии

 Func RESET($SOCKET)
  ; Отправка команды отказа от удаления сообщений
  TCPSend($SOCKET,"rset "&@CRLF)
  ; Получение подтверждения
  $RESET=RECEIVE($SOCKET)
  ; Выход в случае ошибки
  If $RESET=-1 Then Return -1
  ; Возвращение подтверждения
  Return 1
 EndFunc ; < RESET()

; Прием данных

 Func RECEIVE($SOCKET)
  ; Опустошение буфера данных
  $DATA=""
  Do
   Do
    ; Считывание пустых порций данных
    $RECIVE=TCPRecv($SOCKET,512)
   Until $RECIVE<>""
   ; Добавление непустой порции данных в буфер
   $DATA&=$RECIVE
   ; Условия завершения приема данных
   $C1=(StringInStr($DATA,"+OK")>0)
   $C2=(StringInStr($DATA,"-ERR")>0)
   $C3=(StringInStr($DATA,@CRLF&"."&@CRLF)>0)
  Until $C1 Or $C2 Or $C3
  ; Выход в случае ошибки
  If $C2 Then Return -1
  ; Возвращение содержимого буфера
  Return $DATA
 EndFunc ; < RECEIVE()

#EndRegion < ФУНКЦИИ ПОЛУЧЕНИЯ СООБЩЕНИЙ

#Region > ФУНКЦИИ ДЛЯ РАБОТЫ С ЗАГОЛОВКАМИ СООБЩЕНИЙ

; Тема сообщения

 Func SUBJECT($HEADER)
  $BEGIN=StringInStr($HEADER,"Subject: ")+9
  If $BEGIN=0 Then Return -1
  $END=StringInStr($HEADER,@CRLF,0,1,$BEGIN)-1
  Return StringMid($HEADER,$BEGIN,$END-$BEGIN+1)
 EndFunc ; < SUBJECT()

#cs ; Содержание сообщения

 Func CONTENTS($HEADER,$INDEX=0)
  $BEGIN=StringInStr($HEADER,"boundary")
  $BEGIN=StringInStr($HEADER,'"',0,1,$BEGIN)+1
  $END=StringInStr($HEADER,'"',0,1,$BEGIN)-1
  $SEPARATOR=StringMid($HEADER,$BEGIN,$END-$BEGIN+1)
  $BEGIN=StringInStr($HEADER,$SEPARATOR,0,$INDEX+1)+StringLen($SEPARATOR)
  $END=StringInStr($HEADER,$SEPARATOR,0,1,$BEGIN)-1
  Return StringMid($HEADER,$BEGIN,$END-$BEGIN+1)
 EndFunc ; < CONTENTS()

#ce

; Почтовый ящик отправителя сообщения

 Func SENDER($HEADER)
  $BEGIN=StringInStr($HEADER,"From: ")
  If $BEGIN=0 Then Return -1
  $BEGIN=StringInStr($HEADER,"<",0,1,$BEGIN)+1
  $END=StringInStr($HEADER,'>',0,1,$BEGIN)-1
  Return StringMid($HEADER,$BEGIN,$END-$BEGIN+1)
 EndFunc ; < SENDER()

; Почтовый ящик получателя сообщения

 Func RECIPIENT($HEADER)
  $BEGIN=StringInStr($HEADER,"To: ")+4
  If $BEGIN=0 Then Return -1
  $END=StringInStr($HEADER,@CRLF,0,1,$BEGIN)-1
  Return StringMid($HEADER,$BEGIN,$END-$BEGIN+1)
 EndFunc ; < RECIPIENT()

; Дата получения сообщения

 Func DATE($HEADER)
  $BEGIN=StringInStr($HEADER,"Date: ")+6
  If $BEGIN=0 Then Return -1
  $END=StringInStr($HEADER,@CRLF,0,1,$BEGIN)-1
  Return StringMid($HEADER,$BEGIN,$END-$BEGIN+1)
 EndFunc ; < DATE()

#EndRegion < ФУНКЦИИ ДЛЯ РАБОТЫ С ЗАГОЛОВКАМИ СООБЩЕНИЙ

; КОНЕЦ
