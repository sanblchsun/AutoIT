;  @AZJIO
#include <GUIConstants.au3>
AutoItSetOption("TrayIconHide", 1) ;скрыть в системной панели индикатор AutoIt
Global $Ini = @ScriptDir&'\raset.ini' ; путь к raset.ini
;Проверка существования raset.ini и атосоздание при отстутствии
$answerini = ""
If Not FileExists($Ini) Then $answerini = MsgBox(4, "Выгодное предложение", "Хотите создать необходимый raset.ini"&@CRLF&"для сохранения вводимых параметров?")
If $answerini = "6" Then
	IniWriteSection($Ini, "password", 'pass1="3870e3b9f6f4fb9ef89c779211f4ce1a"'&@LF&'pass2="c332c582f10ec850b73c20f723271614"'&@LF&'pass3="42dfed0ba335a1c1af33cb2fa55c7066"'&@LF&'pass4="59dcd1982ff66958c24b25a3d6dd6fdf"'&@LF&'pass5="411c1eecd1fea51069e5b61d0576afbe"')
EndIf


;считываем raset.ini

$pass1= IniRead ($Ini, "password", "pass1", "3870e3b9f6f4fb9ef89c779211f4ce1a") ;123456789
$pass2= IniRead ($Ini, "password", "pass2", "c332c582f10ec850b73c20f723271614") ;11111111
$pass3= IniRead ($Ini, "password", "pass3", "42dfed0ba335a1c1af33cb2fa55c7066") ;WinPE000
$pass4= IniRead ($Ini, "password", "pass4", "59dcd1982ff66958c24b25a3d6dd6fdf") ;1324354657687980
$pass5= IniRead ($Ini, "password", "pass5", "411c1eecd1fea51069e5b61d0576afbe") ;d8k2g0rl8esj8y

; начало создания окна, вкладок, кнопок.
GUICreate("Start RAdmin",257,190) ; размер окна
$tab=GUICtrlCreateTab (4,5, 249,182) ; размер вкладки
GUICtrlCreateTabitem ("RAdmin") ; имя вкладки

GUICtrlCreateLabel ("Пароль", 20,36,47,22)
GUICtrlSetTip(-1, "Установить один"&@CRLF&"из пяти паролей.")
$password=GUICtrlCreateCombo ("", 70,32,43,18)
GUICtrlSetData(-1,'1|2|3|4|5', '1')
$copy=GUICtrlCreateButton ("в буфер", 120,33,60,22)
GUICtrlSetTip(-1, "Копировать пароль"&@CRLF&"в буфер обмена.")
$Readme=GUICtrlCreateButton ("Readme", 185,33,60,22)

$client=GUICtrlCreateButton ("Старт клиента", 15,65,110,22)
GUICtrlSetTip(-1, "Рекомендуется восстановить список"&@CRLF&" клиентов из ClientsBkUp.reg до старта.")

$Import=GUICtrlCreateButton ("Восстановить", 15,95,110,22)
GUICtrlSetTip(-1, "Восстановить список клиентов"&@CRLF&"из файла ClientsBkUp.reg")

$export=GUICtrlCreateButton ("Сохранить клиентов", 15,125,110,22)
GUICtrlSetTip(-1, "Сохранить список клиентов"&@CRLF&"в файл ClientsBkUp.reg")

$passset=GUICtrlCreateButton ("Сохранить пароль", 15,155,110,22)
GUICtrlSetTip(-1, "Сохранить текущий пароль сервера"&@CRLF&"в файл raset.ini в пароль-1")

$server=GUICtrlCreateButton ("Старт сервера", 135,65,110,22)
GUICtrlSetTip(-1, "Старт сервера"&@CRLF&"Radmin.")

$stop=GUICtrlCreateButton ("Остановить сервер", 135,95,110,22)

$del=GUICtrlCreateButton ("Удалить в реестре", 135,125,110,22)
GUICtrlSetTip(-1, "Удалить все записи в реестре,"&@CRLF&"регистрацию, учётки, настройки.")

$setup=GUICtrlCreateButton ("Настройки", 135,155,110,22)
GUICtrlSetTip(-1, "Настройки сервера"&@CRLF&"(после старта сервера)")

GUICtrlCreateTabitem ("")   ; конец вкладок

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
            Case $msg = $server
			   $password03 = GUICtrlRead ($password)
			   If $password03 = "1" Then $password0=$pass1
			   If $password03 = "2" Then $password0=$pass2
			   If $password03 = "3" Then $password0=$pass3
			   If $password03 = "4" Then $password0=$pass4
			   If $password03 = "5" Then $password0=$pass5
			   If $password03 <> "1" And $password03 <> "2" And $password03 <> "3" And $password03 <> "4" And $password03 <> "5" Then $password0=$pass1
			   ;ручной запуск сервера
			   RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\r_server","Start","REG_DWORD",'3')
			   ;пароль сервера 12345678 - 02ba5e187e2589be6f80da0046aa7e3c
			   RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\RAdmin\v2.0\Server\Parameters","Parameter","REG_BINARY",$password0)
			   ;установить ожидание разрешения пользователя на подключение к серверу, 
			   ;при отсутствии ответа пользователя сброс через 10 секунд
			   RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\RAdmin\v2.0\Server\Parameters","Timeout","REG_BINARY",'0a000000')
			   RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\RAdmin\v2.0\Server\Parameters","AutoAllow","REG_BINARY",'00000000')
			   RegWrite("HKEY_LOCAL_MACHINE\SYSTEM\RAdmin\v2.0\Server\Parameters","AskUser","REG_BINARY",'01000000')
			   ;Лицензия
			   RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\RAdmin\v1.01\ViewType","Data","REG_BINARY",'35e3dbda7cef32ad2ca5b81a4be2b2477b1deb054c360e658affecaa7d63a14750dbf20ac5a71ddd086b7f02902bb86cda7a96cbdcc9e21a8c4d253957f8ee83')
			   RunWait ( @Comspec & ' /C '&@ScriptDir&'\r_server.exe /silence /install', '', @SW_HIDE )
			   RunWait ( @Comspec & ' /C '&@ScriptDir&'\r_server.exe /start', '', @SW_HIDE )
            Case $msg = $client
			   ;не показывать заставку при запуске клиента
			   RegWrite("HKEY_CURRENT_USER\Software\RAdmin\v2.0\Parameters","showbw","REG_BINARY",'00000000')
			   ;вид отображения IP-адресов - списком
			   RegWrite("HKEY_CURRENT_USER\Software\RAdmin\v2.0\Parameters","ViewType","REG_BINARY",'03000000')
			   ;rem Режим соединения - "Управление"
			   RegWrite("HKEY_CURRENT_USER\Software\RAdmin\v2.0\Parameters","ConnectionMode","REG_BINARY",'499c0000')
			   ;Отображение файлов списком при выборе режима "Обмен файлами"
			   RegWrite("HKEY_CURRENT_USER\Software\RAdmin\v2.0\Parameters","FileManLocalViewMode","REG_BINARY",'569c0000')
			   RegWrite("HKEY_CURRENT_USER\Software\RAdmin\v2.0\Parameters","FileManRemoteViewMode","REG_BINARY",'569c0000')
			   ;Лицензия
			   RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\RAdmin\v1.01\ViewType","Data","REG_BINARY",'35e3dbda7cef32ad2ca5b81a4be2b2477b1deb054c360e658affecaa7d63a14750dbf20ac5a71ddd086b7f02902bb86cda7a96cbdcc9e21a8c4d253957f8ee83')
			   Run (@ScriptDir&'\radmin.exe')
            Case $msg = $setup ;настройки
			   RunWait ( @Comspec & ' /C '&@ScriptDir&'\r_server.exe /setup', '', @SW_HIDE )
            Case $msg = $copy ;пароль в буфер
			   $password03 = GUICtrlRead ($password)
			   If $password03 = "1" Then $password0=$pass1
			   If $password03 = "2" Then $password0=$pass2
			   If $password03 = "3" Then $password0=$pass3
			   If $password03 = "4" Then $password0=$pass4
			   If $password03 = "5" Then $password0=$pass5
			   If $password03 <> "1" And $password03 <> "2" And $password03 <> "3" And $password03 <> "4" And $password03 <> "5" Then $password0=$pass1
			   $password01=""
			   If $password0 = "3870e3b9f6f4fb9ef89c779211f4ce1a" Then $password01="123456789"
			   If $password0 = "c332c582f10ec850b73c20f723271614" Then $password01="11111111"
			   If $password0 = "42dfed0ba335a1c1af33cb2fa55c7066" Then $password01="WinPE000"
			   If $password0 = "59dcd1982ff66958c24b25a3d6dd6fdf" Then $password01="1324354657687980"
			   If $password0 = "411c1eecd1fea51069e5b61d0576afbe" Then $password01="d8k2g0rl8esj8y"
			   If $password01="" Then $password01="неизвестен"
			   ClipPut($password01)
			   MsgBox(0, "Сообщение", 'Пароль: '&$password01&' скопирован в буфер обмена')
			Case $msg = $stop ;остановить сервер
			   Run ( @Comspec & ' /C '&@ScriptDir&'\r_server.exe /silence /uninstall', '', @SW_HIDE )
			Case $msg = $export ;сохранить список серверов пользователей
			   If FileExists(@ScriptDir&'\ClientsBkUp.reg.BAK') Then FileDelete (@ScriptDir&'\ClientsBkUp.reg.BAK')
			   If FileExists(@ScriptDir&'\ClientsBkUp.reg') Then
			   FileCopy(@ScriptDir&'\ClientsBkUp.reg', @ScriptDir&'\ClientsBkUp.reg.BAK', 1)
			   FileDelete (@ScriptDir&'\ClientsBkUp.reg')
			   EndIf
			   Run ( @Comspec & ' /C reg export HKCU\Software\RAdmin\v2.0\Clients '&@ScriptDir&'\ClientsBkUp.reg', '', @SW_HIDE )
			Case $msg = $Import ; восстановить список серверов пользователей
			   Run ( @Comspec & ' /C regedit.exe /s '&@ScriptDir&'\ClientsBkUp.reg', '', @SW_HIDE )
			Case $msg = $passset ;сохранение текущего пароля
			   $passset0 = RegRead("HKEY_LOCAL_MACHINE\SYSTEM\RAdmin\v2.0\Server\Parameters", "Parameter")
			   If $passset0 <> "" Then IniWrite($Ini, "password", "pass1", $passset0)
			   If $passset0 = "" Then MsgBox(0, "Мелкая ошибка", 'Пароль отсутствует')
			Case $msg = $del ;удалить о радмине все записи в реестре
			   RegDelete("HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\r_server")
			   RegDelete("HKEY_LOCAL_MACHINE\SYSTEM\RAdmin")
			   RegDelete("HKEY_LOCAL_MACHINE\SOFTWARE\RAdmin")
			   RegDelete("HKEY_CURRENT_USER\Software\RAdmin")
			Case $msg = $Readme
			   MsgBox(0, "Readme", 'Оболочка упаравление радмином для LiveCD. Работает и в стационарной Windows, но с учётом автонастройки при запуске на стандартные параметры.')
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
		EndSelect
	WEnd