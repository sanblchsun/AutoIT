#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=mail_del_spam.exe
#AutoIt3Wrapper_icon=mail_del_spam.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=mail_del_spam.exe
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 21.01.2011 (AutoIt3_v3.3.6.1)
; автор UDF srmail.au3 - snoitaleR
#NoTrayIcon
 #Include <srmail.au3>
Global $ListSpam, $SESSION, $POP, $USER, $PASS, $ListSpam, $AUTODELETE, $TrGui=0, $kol=0

If $CmdLine[0]>0 Then
	$msgdel='Выполнено'
	$S1=';'
	For $i = 1 to $CmdLine[0]
		If $i=1 And StringLen($CmdLine[1])>3 Then ContinueLoop
		$S1&=StringTrimLeft($CmdLine[$i], 1)&';'
	Next
	If StringInStr($S1, ';?;') Then
		MsgBox(0, 'Сообщение', 'В качестве параметров принимаются ключи:'&@CRLF&@CRLF& _
		'/do - удалить старые письма (кроме сегодняшних)'&@CRLF& _
		'/da - удалить все письма в ящике'&@CRLF& _
		'/ds - удалить спам'&@CRLF& _
		'/с - создать конфигурационный файл для примера'&@CRLF& _
		'/o - открыть конфигурационный файл (применяется совместно с ключами удаления)'&@CRLF& _
		'/? - справка')
		Exit
	EndIf
	If StringInStr($S1, ';c;') Then
		_Create()
		MsgBox(0, 'Сообщение', 'Конфигурационный файл создан')
		Exit
	EndIf
	If Not FileExists($CmdLine[1]) Then
		If Not StringInStr($S1, ';o;') Then
			MsgBox(0, 'Сообщение', 'Отсутствует файл')
			Exit
		EndIf
	EndIf
	$POP= IniRead ($CmdLine[1], 'setting', 'server', '')
	$USER= IniRead ($CmdLine[1], 'setting', 'email', '')
	$PASS= IniRead ($CmdLine[1], 'setting', 'pass', '')
	$ListSpam = IniReadSection($CmdLine[1], "spam")

	If StringInStr($S1, ';o;') Then
		$tmpPath = FileOpenDialog("Указать файл", @WorkingDir & "", "Файл-список адресов спама (*spam.ini)", 3 )
		If @error Then Exit
		$POP= IniRead ($tmpPath, 'setting', 'server', '')
		$USER= IniRead ($tmpPath, 'setting', 'email', '')
		$PASS= IniRead ($tmpPath, 'setting', 'pass', '')
		$ListSpam = IniReadSection($tmpPath, "spam")
		$AUTODELETE=$tmpPath
	EndIf
	If StringInStr($S1, ';do;') Then
		_DeleteOld()
		$msgdel&= @CRLF&'Старые письма удалены, в количестве '&$kol
	EndIf
	If StringInStr($S1, ';da;') Then
		_DeleteAll()
		$msgdel&= @CRLF&'Почтовый ящик очищен, все письма удалены, в количестве '&$kol
	EndIf
	If StringInStr($S1, ';ds;') Then
		$AUTODELETE=$CmdLine[1]
		_DeleteSpam()
		$msgdel&= @CRLF&'Спам удалён, в количестве '&$kol&' писем'
	EndIf
	MsgBox(0, 'Сообщение', $msgdel)
Else
$TrGui=1
$Gui = GUICreate("Удаление спама",  390, 290, -1, -1, -1, 0x00000010)
$StatusBar = GUICtrlCreateLabel('Строка состояния', 5, 290-17, 380, 15, 0xC)

$Label1 = GUICtrlCreateLabel("Указываем сервер, например - pop.mail.ru", 20, 10, 350, 17)
$Input1 = GUICtrlCreateInput("pop.mail.ru", 20, 27, 350, 21)

$Label2 = GUICtrlCreateLabel("Указываем почтовый ящик, например - xxx@mail.ru", 20, 60, 350, 17)
$Input2 = GUICtrlCreateInput("", 20, 77, 350, 21)

$Label3 = GUICtrlCreateLabel("Пароль", 20, 110, 350, 17)
$Input3 = GUICtrlCreateInput("", 20, 127, 350, 21)

$Label4 = GUICtrlCreateLabel("Адрес отправителя, чьи письма являются спамом", 20, 170, 350, 17)
$Input4 = GUICtrlCreateInput("", 20, 187, 350, 21)
GUICtrlSetState(-1, 8)

$DeleteSpam = GUICtrlCreateButton("Удалить спам", 290, 220, 87, 23)
GUICtrlSetTip(-1, 'Удалить письма спама')
$Open = GUICtrlCreateButton("Открыть", 20, 220, 77, 23)
GUICtrlSetTip(-1, 'Открыть файл-профиль данных с настройками ящика')
$Create = GUICtrlCreateButton("Создать ini", 110, 220, 77, 23)
GUICtrlSetTip(-1, 'Создать шаблон-пример для профиля')
$Delete = GUICtrlCreateButton("Удалить все", 200, 220, 77, 23)
GUICtrlSetTip(-1, 'Удалить все письма в ящике')
$DeleteOld = GUICtrlCreateButton("Удалить все, кроме сегодняшних", 200, 245, 177, 23)
GUICtrlSetTip(-1, 'Удалить все письма в ящике')

GUISetState ()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg =  $Delete
			$POP= GUICtrlRead($Input1)
			$USER = GUICtrlRead($Input2)
			$PASS = GUICtrlRead($Input3)
			_DeleteAll()
			If Not @error Then
				GUICtrlSetData($StatusBar, 'Почтовый ящик очищен, все письма удалены, в количестве '&$kol)
			Else
				GUICtrlSetData($StatusBar, 'Ошибка')
			EndIf
		Case $msg =  $DeleteOld
			$POP= GUICtrlRead($Input1)
			$USER = GUICtrlRead($Input2)
			$PASS = GUICtrlRead($Input3)
			_DeleteOld()
			If Not @error Then
				GUICtrlSetData($StatusBar, 'Старые письма удалены, в количестве '&$kol)
			Else
				GUICtrlSetData($StatusBar, 'Ошибка')
			EndIf
		Case $msg =  $Create
			_Create()
		Case $msg =  -13
			_Open(1)
		Case $msg =  $Open
			_Open()
		Case $msg =  $DeleteSpam
			$POP= GUICtrlRead($Input1)
			$USER = GUICtrlRead($Input2)
			$PASS = GUICtrlRead($Input3)
			$AUTODELETE = GUICtrlRead($Input4)
			GUICtrlSetData($StatusBar, 'Выполняется ... подключаемся к серверу')
			_DeleteSpam()
			If Not @error Then
				GUICtrlSetData($StatusBar, 'Спам удалён, в количестве '&$kol&' писем')
			Else
				GUICtrlSetData($StatusBar, 'Ошибка')
			EndIf
		Case $msg = -3
			Exit
	EndSelect
WEnd
EndIf


Func _TestErr($sp=0)
	If $POP='' Then Return SetError(1, 0, MsgBox(0, 'Сообщение', 'Не указан сервер'))
	If $USER='' Then Return SetError(1, 0, MsgBox(0, 'Сообщение', 'Не указан ящик'))
	If $PASS='' Then Return SetError(1, 0, MsgBox(0, 'Сообщение', 'Не указан пароль'))
	If $sp=0 And $AUTODELETE='' Then Return SetError(1, 0, MsgBox(0, 'Сообщение', 'Не указан спам'))
EndFunc

Func _DeleteSpam()
	_TestErr()
	If @error Then
		If $TrGui=1 Then
			GUICtrlSetData($StatusBar, 'Ошибка данных')
		Else
			MONITOR('Статус','Ошибка данных')
		EndIf
		Return SetError(1)
	EndIf
		
	$SESSION=SRMAIL_POP($POP,$USER,$PASS)

	If $SESSION<0 Then
		MsgBox(0,"Внимание!","Ошибка подключения к серверу: "&$SESSION)
		Return
	EndIf
	If $TrGui=1 Then
		GUICtrlSetData($StatusBar, 'Выполняется ... подключено')
	Else
		MONITOR('Статус','Выполняется ... подключено')
	EndIf

	 $HEADERS=SRMAIL_HEADERS($SESSION)

	If $HEADERS<0 Then
		MsgBox(0,"Внимание!","Ошибка создания списка заголовков сообщений: "&$SESSION)
		Return
	EndIf
	If $TrGui=1 Then
		GUICtrlSetData($StatusBar, 'Выполняется ... прочитаны заголовки писем, удаление')
	Else
		MONITOR('Статус','Выполняется ... прочитаны заголовки писем, удаление')
	EndIf
	
	If Ubound($HEADERS)=0 Then
		MsgBox(0,"Внимание!","Нет сообщений")
		Return
	EndIf	
	
	$kol=0
	$ErrorDel=0
	If StringRight($AUTODELETE, 8) = 'spam.ini' Then
		For $i = 1 to $ListSpam[0][0]
			 For $iH=1 To UBound($HEADERS)-1
				If $HEADERS[$iH][2]=$ListSpam[$i][1] Then
					$DELETE=SRMAIL_DELETE($SESSION,$iH)
					If $DELETE<0 Then
						$ErrorDel+=1
					Else
						$kol+=1
					EndIf
				EndIf
			 Next
		Next
	Else
		 For $i=1 To UBound($HEADERS)-1
			If $HEADERS[$i][2]=$AUTODELETE Then
				$DELETE=SRMAIL_DELETE($SESSION,$i)
				If $DELETE<0 Then
					$ErrorDel+=1
				Else
					$kol+=1
				EndIf
			EndIf
		 Next
	 EndIf
	 If $ErrorDel <> 0 Then MsgBox(0, 'Сообщение', 'Количество ошибок удаления = '&$ErrorDel)
	SRMAIL_CLOSE($SESSION)
EndFunc

Func _Open($Ot=0)
	If $Ot = 1 Then
		$tmpPath = @GUI_DRAGFILE
	Else
		$tmpPath = FileOpenDialog("Указать файл", @WorkingDir & "", "Файл-список адресов спама (*spam.ini)", 3 )
		If @error Then Return
	EndIf
	GUICtrlSetData($Input1, IniRead ($tmpPath, 'setting', 'server', ''))
	GUICtrlSetData($Input2, IniRead ($tmpPath, 'setting', 'email', ''))
	GUICtrlSetData($Input3, IniRead ($tmpPath, 'setting', 'pass', ''))
	GUICtrlSetData($Input4, $tmpPath)
	$ListSpam = IniReadSection($tmpPath, "spam")
EndFunc

Func _Create()
	$POP='pop.mail.ru'
	$USER ='xxx@mail.ru'
	$PASS = ''
	$AUTODELETE='xxx@mail.com'
	If $TrGui=1 Then
		$tmp= GUICtrlRead($Input1)
		If $tmp <> '' Then $POP= $tmp
		$tmp = GUICtrlRead($Input2)
		If $tmp <> '' Then $USER= $tmp
		$tmp = GUICtrlRead($Input3)
		If $tmp <> '' Then $PASS = $tmp
		$tmp = GUICtrlRead($Input4)
		If $tmp <> '' And Not StringInStr($tmp, ':\') Then $AUTODELETE = $tmp
	EndIf
	$file = FileOpen(@ScriptDir&'\Name_spam.ini',2)
	FileWrite($file, '[setting]' & @CRLF & _
	'server='&$POP & @CRLF & _
	'email='&$USER & @CRLF & _
	'pass='&$PASS & @CRLF & _
	@CRLF & _
	'[spam]' & @CRLF & _
	'1='&$AUTODELETE & @CRLF & _
	'2=xxx1@mail.com')
	FileClose($file)
EndFunc

Func _DeleteOld()
	_TestErr(1)
	If @error Then
		If $TrGui=1 Then
			GUICtrlSetData($StatusBar, 'Ошибка данных')
		Else
			MONITOR('Статус','Ошибка данных')
		EndIf
		Return SetError(1)
	EndIf
	$HEADERS=_GetHeaders()
	If @error Then Return
	$kol=0
	$ErrorDel=0
	For $i=1 To UBound($HEADERS)-1
		$day=StringRegExpReplace($HEADERS[$i][4], '(\w+, )(\d+)( \w+ \d{4} \d{2}:\d{2}:\d{2}.*)', '\2')
		If $day>=1 And $day<=31 And $day<>@MDAY Then
			$DELETE=SRMAIL_DELETE($SESSION,$i)
			If $DELETE<0 Then
				$ErrorDel+=1
			Else
				$kol+=1
			EndIf
		EndIf
	Next
	 If $ErrorDel <> 0 Then MsgBox(0, 'Сообщение', 'Количество ошибок удаления = '&$ErrorDel)
	SRMAIL_CLOSE($SESSION)
EndFunc

Func _DeleteAll()
	_TestErr(1)
	If @error Then
		If $TrGui=1 Then
			GUICtrlSetData($StatusBar, 'Ошибка данных')
		Else
			MONITOR('Статус','Ошибка данных')
		EndIf
		Return SetError(1)
	EndIf
	$HEADERS=_GetHeaders()
	If @error Then Return
	$kol=0
	$ErrorDel=0
	 For $i=1 To UBound($HEADERS)-1
		$DELETE=SRMAIL_DELETE($SESSION,$i)
		If $DELETE<0 Then
			$ErrorDel+=1
		Else
			$kol+=1
		EndIf
	 Next
	 If $ErrorDel <> 0 Then MsgBox(0, 'Сообщение', 'Количество ошибок удаления = '&$ErrorDel)
	SRMAIL_CLOSE($SESSION)
EndFunc

Func _GetHeaders()
	If $TrGui=1 Then
		GUICtrlSetData($StatusBar, 'Выполняется ... подключаемся к серверу')
	Else
		MONITOR('Статус','Выполняется ... подключаемся к серверу')
	EndIf
		
	$SESSION=SRMAIL_POP($POP,$USER,$PASS)

	If $SESSION<0 Then
		MsgBox(0,"Внимание!","Ошибка подключения к серверу: "&$SESSION)
		Return SetError(1)
	EndIf
	If $TrGui=1 Then
		GUICtrlSetData($StatusBar, 'Выполняется ... подключено')
	Else
		MONITOR('Статус','Выполняется ... подключено')
	EndIf

	 $HEADERS=SRMAIL_HEADERS($SESSION)

	If $HEADERS<0 Then
		MsgBox(0,"Внимание!","Ошибка создания списка заголовков сообщений: "&$SESSION)
		Return SetError(1)
	EndIf
	If $TrGui=1 Then
		GUICtrlSetData($StatusBar, 'Выполняется ... прочитаны заголовки писем ('&UBound($HEADERS)-1&'), удаление')
	Else
		MONITOR('Статус','Выполняется ... прочитаны заголовки писем, удаление')
	EndIf

	If Ubound($HEADERS)=0 Then
		MsgBox(0,"Внимание!","Нет сообщений")
		Return SetError(1)
	EndIf	
	Return $HEADERS
EndFunc