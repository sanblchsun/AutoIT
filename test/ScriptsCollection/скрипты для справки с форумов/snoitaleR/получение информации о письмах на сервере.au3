
; НАЧАЛО

; Библиотека для работы с электронной почтой по протоколам POP и SMTP

; ПРИМЕР

;#cs

 $POP="pop.mail.ru"
 $USER="xxx@mail.ru"
 $PASS="xxx"

 $SESSION=OPEN($POP,$USER,$PASS)
 If $SESSION=-1 Then Exit
 $LIST=LIST($SESSION)
 For $iL=1 To UBound($LIST)-1
  MsgBox(0,"[Сообщений: "&UBound($LIST)-1&"] Заголовок сообщения №"&$iL&" Размер: "&$LIST[$iL],HEADER($SESSION,$iL))
 Next
 CLOSE($SESSION)

;#ce

; ФУНКЦИИ

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
 EndFunc

; Закрытие сессии

 Func CLOSE($SOCKET)
  ; Отправка команды завершения сессии
  TCPSend($SOCKET,'quit'&@CRLF)
  ; Отключение от сервера
  TCPCloseSocket($SOCKET)
  ; Остановка TCP-сервиса
  TCPShutdown()
 EndFunc

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
  ; Создание массива размеров сообщений
  $LIST=StringReplace($LIST,@CRLF&"."&@CRLF,"")
  $LIST=StringSplit($LIST,@CRLF,1)
  For $iL=1 To UBound($LIST)-1
   $LIST[$iL]=StringTrimLeft($LIST[$iL],StringInStr($LIST[$iL]," "))
  Next
  ; Возвращение массива размеров сообщений
  Return $LIST
 EndFunc

; Получение заголовка сообщения

 Func HEADER($SOCKET,$INDEX)
  ; Запрос заголовка сообщения
  TCPSend($SOCKET,"top "&$INDEX&" 0"&@CRLF)
  ; Выход в случае ошибки
  If RECEIVE($SOCKET)=-1 Then Return -1
  ; Получени заголовка сообщения
  $TOP=RECEIVE($SOCKET)
  ; Выход в случае ошибки
  If $TOP=-1 Then Return -1
  ; Возвращение заголовока сообщения
  Return $TOP
 EndFunc

; ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ

; Прием данных

 Func RECEIVE($SOCKET)
  ; Опустошение буфера данных
  $DATA=""
  Do
   Do
    ; Считывание пустых порций
    $RECIVE=TCPRecv($SOCKET,512)
   Until $RECIVE<>""
   ; Добавление порции в буфер
   $DATA&=$RECIVE
   ; Условия завершения приема данных
   $C1=(StringInStr($DATA,"+OK")>0)
   $C2=(StringInStr($DATA,"-ERR")>0)
   $C3=(StringInStr($DATA,@CRLF&"."&@CRLF)>0)
  Until $C1 Or $C2 Or $C3
  ; Выход в случае ошибки
  If $C2 Then Return -1
  ; Возвращение содержимое буфера
  Return $DATA
 EndFunc

; КОНЕЦ
