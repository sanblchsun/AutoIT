
; НАЧАЛО

; Библиотека для работы с электронной почтой по протоколам POP и SMTP
; Версия библиотеки: 0.5
; Версия AUTOIT: 3.3.6.1

 Opt("TCPTimeout",100)

 #Include <Encoding.au3>
 #Include <Array.au3>

 ; Открытие POP-сессии

 Func SRMAIL_POP($POP,$USER,$PASS)

  MONITOR("POP","Открытие сессии...")

  TCPStartup()
  $SOCKET=TCPConnect(TCPNameToIP($POP),110)
  If @error Then Return -1
  If SRMAIL_RESPONSE($SOCKET)=1 Then Return -1
  TCPSend($SOCKET,"USER "&$USER&@CRLF)
  If SRMAIL_RESPONSE($SOCKET)=-1 Then Return -1
  TCPSend($SOCKET,"PASS "&$PASS&@CRLF)
  If StringLeft(SRMAIL_RESPONSE($SOCKET),4)="-ERR" Then Return -2

  SplashOff()

  Return $SOCKET

 EndFunc

; Открытие SMTP-сессии

 Func SRMAIL_SMTP($SMTP,$USER,$PASS)

  MONITOR("SMTP","Открытие сессии...")

  TCPStartup()
  $SOCKET=TCPConnect(TCPNameToIP($SMTP),25)
  If $SOCKET=-1 Then Return -1
  SRMAIL_RESPONSE($SOCKET)
  TCPSend($SOCKET,"EHLO "&@ComputerName&@CRLF)
  SRMAIL_RESPONSE($SOCKET)
  TCPSend($SOCKET,"AUTH LOGIN"&@CRLF)
  SRMAIL_RESPONSE($SOCKET)
  TCPSend($SOCKET,_Encoding_Base64Encode($USER)&@CRLF)
  SRMAIL_RESPONSE($SOCKET)
  TCPSend($SOCKET,_Encoding_Base64Encode($PASS)&@CRLF)
  If StringLeft(SRMAIL_RESPONSE($SOCKET),1)<>"2" Then Return -2

  Return $SOCKET

 EndFunc

 ; Закрытие сессии

 Func SRMAIL_CLOSE($SOCKET)

  MONITOR("POP или SMTP","Закрытие сессии...")

  TCPSend($SOCKET,'QUIT'&@CRLF)
  TCPCloseSocket($SOCKET)
  TCPShutdown()

  SplashOff()

  Return 1

 EndFunc

 ; Получение списка сообщений

 Func SRMAIL_LIST($SOCKET)

  MONITOR("POP","Считывание списка...")

  TCPSend($SOCKET,'LIST'&@CRLF)
  $LIST=SRMAIL_MESSAGE($SOCKET)
  If $LIST=-1 Then Return -1
  If StringLeft($LIST,4)="-ERR" Then Return -2
  $LIST=StringTrimLeft($LIST,StringInStr($LIST,@CRLF)+1)
  $LIST=StringReplace($LIST,"."&@CRLF,"")
  If $LIST="" Then Return 0
  $LIST=StringTrimRight($LIST,2)
  $LIST=StringSplit($LIST,@CRLF,1)
  For $iL=1 To UBound($LIST)-1
   $LIST[$iL]=StringTrimLeft($LIST[$iL],StringInStr($LIST[$iL]," "))
  Next

  Return $LIST

 EndFunc

 ; Получение заголовка сообщения

 Func SRMAIL_HEADER($SOCKET,$INDEX)

  MONITOR("POP","Считывание заголовка...")

  TCPSend($SOCKET,"TOP "&$INDEX&" 0"&@CRLF)
  If StringLeft(SRMAIL_RESPONSE($SOCKET),4)="-ERR" Then Return -1
  $HEADER=SRMAIL_MESSAGE($SOCKET)
  If StringLeft($HEADER,4)="-ERR" Then Return -2

  Return $HEADER

 EndFunc

 ; Получение списка заголовков

 Func SRMAIL_HEADERS($SOCKET)

  MONITOR("POP","Создание массива заголовков...")

  $LIST=SRMAIL_LIST($SOCKET)

  ;MsgBox(0,"HEADERS->LIST",$LIST)

  If $LIST=-1 Then Return -1
  If $LIST=0 Then Return 0
  If StringLeft($LIST,4)="-ERR" Then Return -1
  Dim $HEADERS[UBound($LIST)][5]
  For $iH=1 To UBound($HEADERS)-1
   $HEADER=SRMAIL_HEADER($SOCKET,$iH)
   $HEADERS[$iH][0]=$LIST[$iH]
   $HEADERS[$iH][1]=SRMAIL_SUBJECT($HEADER)
   $HEADERS[$iH][2]=SRMAIL_FROM($HEADER)
   $HEADERS[$iH][3]=SRMAIL_TO($HEADER)
   $HEADERS[$iH][4]=SRMAIL_DATE($HEADER)
  Next

  Return $HEADERS

 EndFunc

 ; Загрузка сообщения

 Func SRMAIL_LOAD($SOCKET,$INDEX)

  MONITOR("POP","Загрузка сообщения...")

  TCPSend($SOCKET,"RETR "&$INDEX&@CRLF)
  If StringLeft(SRMAIL_RESPONSE($SOCKET),4)="-ERR" Then Return -1
  $LOAD=SRMAIL_MESSAGE($SOCKET)
  If StringLeft($LOAD,4)="-ERR" Then Return -2

  Return $LOAD

 EndFunc

 ; Пометка сообщения к удалению

 Func SRMAIL_DELETE($SOCKET,$INDEX)

  MONITOR("POP","Удаление сообщения...")

  TCPSend($SOCKET,"DELE "&$INDEX&@CRLF)
  If StringLeft(SRMAIL_RESPONSE($SOCKET),4)="-ERR" Then Return -1

  Return 1

 EndFunc

 ; Отказ от удаления сообщений в пределах сессии

 Func SRMAIL_RESET($SOCKET)

  MONITOR("POP","Отмена удаления сообщений...")

  TCPSend($SOCKET,"RSET "&@CRLF)
  If StringLeft(RESPONSE($SOCKET),4)="-ERR" Then Return -1

  Return 1

 EndFunc

 ; Сохранение исходного сообщения

 Func SRMAIL_SAVE($MAIL,$PATH=@ScriptDir)

  MONITOR("POP","Сохранение сообщения...")

  $BOUNDARY=SRMAIL_BOUNDARY()
  $FILE=FileOpen($PATH&"\"&$BOUNDARY&".MSG",2)
  FileWrite($FILE,$MAIL)
  FileClose($FILE)
  If $FILE=-1 Then Return -1

  Return 1

 EndFunc

 ; Содержание сообщения

 Func SRMAIL_PART($MAIL)

  MONITOR("POP","Разделение сообщения...")

  If StringInStr($MAIL,@CRLF&@CRLF,0,1,1)>0 Then
   $LINE=@CRLF
  ElseIf StringInStr($MAIL,@LF&@LF,0,1,1)>0 Then
   $LINE=@LF
  Else
   $LINE=@CRLF
  EndIf

  $BEGIN=1
  $END=StringInStr($MAIL,$LINE&$LINE,0,1,$BEGIN)+1
  $HEADER=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)

  $TITLE=StringInStr($MAIL,"boundary")

  If $TITLE=0 Then

   $BEGIN=StringInStr($MAIL,$LINE&$LINE,0,1,1)+4
   $END=StringInStr($MAIL,$LINE&$LINE,0,1,$BEGIN)+1
   $BODY=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)

   $BEGIN=StringInStr($MAIL,"charset",0,1,1)
   $BEGIN=StringInStr($MAIL,'=',0,1,$BEGIN)+1
   $END=StringInStr($MAIL,$LINE,0,1,$BEGIN)-1
   $TABLE=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)
   $TABLE=StringReplace($TABLE,' ',"")
   $TABLE=StringReplace($TABLE,'"',"")

   $BEGIN=StringInStr($MAIL,"Content-Transfer-Encoding:",0,1,1)
   $BEGIN=StringInStr($MAIL," ",0,1,$BEGIN)+1
   $END=StringInStr($MAIL,$LINE,0,1,$BEGIN)-1
   $FILTER=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)

   $BODY=SRMAIL_DECODE($BODY,$TABLE,$FILTER)

   Dim $PART[3][2]
   $PART[0][0]=3
   $PART[1][0]=$HEADER
   $PART[1][1]="header.txt"
   $PART[2][0]=$BODY
   $PART[2][1]="contents.txt"

  Else

   $BEGIN=StringInStr($MAIL,'"',0,1,$TITLE)+1
   $END=StringInStr($MAIL,'"',0,2,$TITLE)-1
   $SEPARATOR=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)

   ;MsgBox(0,"Разделитель",$SEPARATOR)

   $TITLE=StringInStr($MAIL,$SEPARATOR,0,2)
   $BEGIN=StringInStr($MAIL,$LINE&$LINE,0,1,$TITLE)+2
   $END=StringInStr($MAIL,"--"&$SEPARATOR,0,1,$BEGIN)-1
   $BODY=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)

   ;MsgBox(0,"Содержание",$BODY)

   $BEGIN=StringInStr($MAIL,"charset",0,1,$TITLE)
   $BEGIN=StringInStr($MAIL,'=',0,1,$BEGIN)+1
   $END=StringInStr($MAIL,$LINE,0,1,$BEGIN)-1
   $TABLE=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)
   $TABLE=StringReplace($TABLE,' ',"")
   $TABLE=StringReplace($TABLE,'"',"")

   ;MsgBox(0,"Кодировка",$TABLE)

   $BEGIN=StringInStr($MAIL,"Content-Transfer-Encoding:",0,1,$TITLE)
   $BEGIN=StringInStr($MAIL," ",0,1,$BEGIN)+1
   $END=StringInStr($MAIL,$LINE,0,1,$BEGIN)-1
   $FILTER=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)

   ;MsgBox(0,"Фильтр",$FILTER)

   $BODY=SRMAIL_DECODE($BODY,$TABLE,$FILTER)

   $INDEX=0

   Do

    $INDEX+=1
    $TITLE=StringInStr($MAIL,$SEPARATOR,0,$INDEX+1)

   Until $TITLE=0

   Dim $PART[$INDEX][2]
   $PART[0][0]=$INDEX
   $PART[1][0]=$HEADER
   $PART[1][1]="header.txt"
   $PART[2][0]=$BODY
   $PART[2][1]="contents.txt"

   For $iPART=3 To UBound($PART)-1

    $TITLE=StringInStr($MAIL,$SEPARATOR,0,$iPART)

    $BEGIN=StringInStr($MAIL,$LINE&$LINE,0,1,$TITLE)+4
    $END=StringInStr($MAIL,"--"&$SEPARATOR,0,1,$TITLE)-1
    $PART[$iPART][0]=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)

    $BEGIN=StringInStr($MAIL,"Content-Transfer-Encoding:",0,1,$TITLE)
    $BEGIN=StringInStr($MAIL," ",0,1,$BEGIN)+1
    $END=StringInStr($MAIL,$LINE,0,1,$BEGIN)-1
    $FILTER=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)

    $BEGIN=StringInStr($MAIL,"name",0,1,$TITLE)
    $BEGIN=StringInStr($MAIL,'=',0,1,$BEGIN)+1
    $END=StringInStr($MAIL,$LINE,0,1,$BEGIN)-1
    $NAME=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)
    $NAME=StringReplace($NAME,' ',"")
    $NAME=StringReplace($NAME,'"',"")

    $PART[$iPART][0]=SRMAIL_DECODE($PART[$iPART][0],"",$FILTER)
    $PART[$iPART][1]=$NAME

   Next

  EndIf

  Return $PART

 EndFunc

 ; Тема сообщения

 Func SRMAIL_SUBJECT($MAIL)

  MONITOR("POP","Получение темы сообщения...")

  $TITLE=StringInStr($MAIL,"Subject: ")
  If $TITLE=0 Then Return -1

  $BEGIN=StringInStr($MAIL,"?",0,3,$TITLE)+1
  $END=StringInStr($MAIL,"?",0,4,$TITLE)-1
  $SUBJECT=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)

  $BEGIN=StringInStr($MAIL,"?",0,1,$TITLE)+1
  $END=StringInStr($MAIL,"?",0,2,$TITLE)-1
  $TABLE=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)

  $BEGIN=StringInStr($MAIL,"?",0,2,$TITLE)+1
  $END=StringInStr($MAIL,"?",0,3,$TITLE)-1
  $FILTER=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)

  $SUBJECT=SRMAIL_DECODE($SUBJECT,$TABLE,$FILTER)

  Return $SUBJECT

 EndFunc

 ; Почтовый ящик отправителя сообщения

 Func SRMAIL_FROM($MAIL)

  $TITLE=StringInStr($MAIL,"From: ")
  If $TITLE=0 Then Return -1

  $BEGIN=StringInStr($MAIL,"<",0,1,$TITLE)+1
  $END=StringInStr($MAIL,'>',0,1,$TITLE)-1
  $FROM=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)

  Return $FROM

 EndFunc

 ; Почтовый ящик получателя сообщения
 ; Для рассылки не срабатывает

 Func SRMAIL_TO($MAIL)

  $TITLE=StringInStr($MAIL,"To: ")
  If $TITLE=0 Then Return -1

  $BEGIN=StringInStr($MAIL,"<",0,1,$TITLE)+1
  $END=StringInStr($MAIL,">",0,1,$TITLE)-1
  $TO=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)

  Return $TO

 EndFunc

 ; Дата получения сообщения

 Func SRMAIL_DATE($MAIL)

  $TITLE=StringInStr($MAIL,"Date: ")
  If $TITLE=0 Then Return -1

  $BEGIN=StringInStr($MAIL," ",0,1,$TITLE)+1
  $END=StringInStr($MAIL,@CRLF,0,1,$BEGIN)-1
  $DATE=StringMid($MAIL,$BEGIN,$END-$BEGIN+1)

  Return $DATE

 EndFunc

 ; Отправка сообщения

 Func SRMAIL_SEND($SOCKET,$SUBJECT,$TEXT,$FROM,$TO,$ATTACH="")

  $TO=StringSplit($TO,"|",1)
  If $ATTACH<>"" Then $ATTACH=StringSplit($ATTACH,"|",1)

  $BOUNDARY=SRMAIL_BOUNDARY()

  $MSG="Subject: =?windows-1251?b?"&_Encoding_Base64Encode($SUBJECT)&"?="&@CRLF
  $MSG&="From: <"&$FROM&">"&@CRLF
  $MSG&="To: <"&$TO[1]&">"&@CRLF
  $MSG&="MIME-Version: 1.0"&@CRLF
  $MSG&='Content-Type: multipart/mixed; boundary="'&$BOUNDARY&'"'&@CRLF&@CRLF
  $MSG&="--"&$BOUNDARY&@CRLF
  $MSG&='Content-Type: text/plain; charset="windows-1251"'&@CRLF
  $MSG&='Content-Transfer-Encoding: base64'&@CRLF&@CRLF
  $MSG&=_Encoding_Base64Encode($TEXT)&@CRLF

  If $ATTACH<>"" Then

   For $iATTACH=1 To UBound($ATTACH)-1

    $FILE=FileOpen($ATTACH[$iATTACH],0)
    $TEXT=FileRead($FILE)
    FileClose($FILE)

    $MSG&="--"&$BOUNDARY&@CRLF
    $MSG&='Content-Type: application/octet-stream; name="'&StringRegExpReplace($ATTACH[$iATTACH],"^.*\\","")&'"'&@CRLF
    $MSG&='Content-Disposition: attachment; filename="'&StringRegExpReplace($ATTACH[$iATTACH],"^.*\\","")&'"'&@CRLF
    $MSG&='Content-Transfer-Encoding: base64'&@CRLF&@CRLF
    $MSG&=_Encoding_Base64Encode($TEXT)&@CRLF

   Next

  EndIf

  $MSG&="--"&$BOUNDARY&"--"&@CRLF&@CRLF&"."&@CRLF

  TCPSend($SOCKET,"MAIL FROM:"&$FROM&@CRLF)
  If StringLeft(SRMAIL_RESPONSE($SOCKET),1)<>"2" Then -1

  For $iTO=1 To UBound($TO)-1

   TCPSend($SOCKET,"RCPT TO:"&$TO[$iTO]&@CRLF)
   If StringLeft(SRMAIL_RESPONSE($SOCKET),1)<>"2" Then Return -2

  Next

  TCPSend($SOCKET,"DATA"&@CRLF)
  If StringLeft(SRMAIL_RESPONSE($SOCKET),3)<>"354" Then Return -3

  TCPSend($SOCKET,$MSG)
  If StringLeft(SRMAIL_RESPONSE($SOCKET),1)<>"2" Then Return -4

  Return $MSG

 EndFunc

 ; Прием отклика сервера

 Func SRMAIL_RESPONSE($SOCKET)

  $BEGIN=TimerInit()
  Do
   $RECEIVE=TCPRecv($SOCKET,512)
   If TimerDiff($BEGIN)>10000 Then Return -1
  Until $RECEIVE<>""

  Return $RECEIVE

 EndFunc

 ; Прием сообщения от сервера

 Func SRMAIL_MESSAGE($SOCKET,$MESSAGE="")

  Do
   $R=SRMAIL_RESPONSE($SOCKET)
   If $R=-1 Then Return -1
   $MESSAGE&=$R
  Until StringRegExp($MESSAGE,@CRLF&"."&@CRLF)

  Return $MESSAGE

 EndFunc

 ; Декодирование текста

 Func SRMAIL_DECODE($TEXT,$TABLE,$FILTER)

  Switch $FILTER
   Case "","7bit"
   Case "b","base64"
    $TEXT=_Encoding_Base64Decode($TEXT)
   Case "q","quoted-printable"
    $TEXT=_Encoding_HexSymbolsToANSI($TEXT)
   Case Else
    $TEXT="[?f]"&$TEXT
  EndSwitch

  Switch $TABLE
   Case "","windows-1251"
   Case "utf-8"
    $TEXT=_Encoding_UTF8ToANSI($TEXT)
   Case "koi8-r"
    $TEXT=_Encoding_KOI8To1251($TEXT)
   Case "iso-8859-5"
    $TEXT=_Encoding_ISO8859To1251($TEXT)
   Case Else
    $TEXT="[?c]"&$TEXT
  EndSwitch

  Return $TEXT

 EndFunc

 ; Создание разделителя MIME

 Func SRMAIL_BOUNDARY()

  $BOUNDARY=@YEAR&"-"&@MON&"-"&@MDAY&"-"&@HOUR&"-"&@MIN&"-"&@SEC&"-"&@MSEC

  Return $BOUNDARY

 EndFunc

; Отображение сообщений

 Func MONITOR($TITLE1,$TEXT1,$TIME=0)

  SplashTextOn($TITLE1,$TEXT1,400,40,-1,int(@DesktopHeight*3/4),0,"courier",8)
  If $TIME>0 Then Sleep($TIME)

 EndFunc

; КОНЕЦ
