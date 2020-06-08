;  @AZJIO
#include <GUIConstants.au3>
AutoItSetOption("TrayIconHide", 1) ;скрыть в системной панели индикатор AutoIt
Global $Ini1 = @ScriptDir&'\ServUDaemon.ini'
Global $Ini = @ScriptDir&'\ftpset.ini' ; путь к ftpset.ini
;Проверка существования ftpset.ini и атосоздание при отстутствии
$answerini = ""
If Not FileExists($Ini) Then $answerini = MsgBox(4, "Выгодное предложение", "Хотите создать необходимый ftpset.ini"&@CRLF&"для сохранения вводимых параметров?")
If $answerini = "6" Then
	IniWriteSection($Ini, "ip", 'ip1="10.10.1.3"'&@LF&'ip2="10.10.1.4"'&@LF&'ip3="10.10.1.9"'&@LF&'ip4="10.10.1.16"'&@LF&'ip5="10.10.1.17"'&@LF&'ip6="192.168.1.3"'&@LF&'ip7="192.168.1.4"'&@LF&'ip8="192.168.1.9"'&@LF&'ip9="192.168.1.16"'&@LF&'ip10="192.168.1.17"')
	IniWriteSection($Ini, "path", 'pathhome1=C:\FTP\home'&@LF&'pathhome2=D:\FTP\home'&@LF&'pathhome3=E:\FTP\home'&@LF&'pathhome4=B:\FTP\home'&@LF&'pathhome5=X:\FTP\home'&@LF&'path_mhe1=C:\FTP\MHE'&@LF&'path_mhe2=D:\FTP\MHE'&@LF&'path_mhe3=E:\FTP\MHE'&@LF&'path_mhe4=B:\FTP\MHE'&@LF&'path_mhe5=X:\FTP\MHE'&@LF&'path_pass1=C:\FTP\Password'&@LF&'path_pass2=D:\FTP\Password'&@LF&'path_pass3=E:\FTP\Password'&@LF&'path_pass4=B:\FTP\Password'&@LF&'path_pass5=X:\FTP\Password')
	IniWriteSection($Ini, "user", 'username=user1')
	IniWriteSection($Ini, "password", 'pass1="iz317B75870B2AC5A2182C7F898D968C7D"'&@LF&'pass2="zy36617169DA089A168F12635C51D72F1C"'&@LF&'pass3="aq920713A3ECCE3FE942966897490B2BF9"'&@LF&'pass4="bpAA7F52F3729E8CD309603A0EBA801649"'&@LF&'pass5="jy4864323CA9861453C645845A45608620"')
EndIf


;считываем ftpset.ini

$ip1= IniRead ($Ini, "ip", "ip1", "10.10.1.3")
$ip2= IniRead ($Ini, "ip", "ip2", "10.10.1.4")
$ip3= IniRead ($Ini, "ip", "ip3", "10.10.1.9")
$ip4= IniRead ($Ini, "ip", "ip4", "10.10.1.16")
$ip5= IniRead ($Ini, "ip", "ip5", "10.10.1.17")
$ip6= IniRead ($Ini, "ip", "ip6", "192.168.1.3")
$ip7= IniRead ($Ini, "ip", "ip7", "192.168.1.4")
$ip8= IniRead ($Ini, "ip", "ip8", "192.168.1.9")
$ip9= IniRead ($Ini, "ip", "ip9", "192.168.1.16")
$ip10= IniRead ($Ini, "ip", "ip10", "192.168.1.17")


$pathhome1= IniRead ($Ini, "path", "pathhome1", "C:\FTP\home")
$pathhome2= IniRead ($Ini, "path", "pathhome2", "D:\FTP\home")
$pathhome3= IniRead ($Ini, "path", "pathhome3", "E:\FTP\home")
$pathhome4= IniRead ($Ini, "path", "pathhome4", "B:\FTP\home")
$pathhome5= IniRead ($Ini, "path", "pathhome5", "X:\FTP\home")

$path_mhe1= IniRead ($Ini, "path", "path_mhe1", "C:\FTP\MHE")
$path_mhe2= IniRead ($Ini, "path", "path_mhe2", "D:\FTP\MHE")
$path_mhe3= IniRead ($Ini, "path", "path_mhe3", "E:\FTP\MHE")
$path_mhe4= IniRead ($Ini, "path", "path_mhe4", "B:\FTP\MHE")
$path_mhe5= IniRead ($Ini, "path", "path_mhe5", "X:\FTP\MHE")

$path_pass1= IniRead ($Ini, "path", "path_pass1", "C:\FTP\Password")
$path_pass2= IniRead ($Ini, "path", "path_pass2", "D:\FTP\Password")
$path_pass3= IniRead ($Ini, "path", "path_pass3", "E:\FTP\Password")
$path_pass4= IniRead ($Ini, "path", "path_pass4", "B:\FTP\Password")
$path_pass5= IniRead ($Ini, "path", "path_pass5", "X:\FTP\Password")

$pass1= IniRead ($Ini, "password", "pass1", "iz317B75870B2AC5A2182C7F898D968C7D") ;123456789
$pass2= IniRead ($Ini, "password", "pass2", "zy36617169DA089A168F12635C51D72F1C") ;11111
$pass3= IniRead ($Ini, "password", "pass3", "aq920713A3ECCE3FE942966897490B2BF9") ;WinPE
$pass4= IniRead ($Ini, "password", "pass4", "bpAA7F52F3729E8CD309603A0EBA801649") ;1324354657687980
$pass5= IniRead ($Ini, "password", "pass5", "jy4864323CA9861453C645845A45608620") ;d8k2g0rl8esj8y

$username= IniRead ($Ini, "user", "username", "user1")

; начало создания окна, вкладок, кнопок.
GUICreate("Start FTP",257,303) ; размер окна
$tab=GUICtrlCreateTab (4,5, 249,295) ; размер вкладки
GUICtrlCreateTabitem ("ServU") ; имя вкладки

GUICtrlCreateLabel ("IP", 99,40,22,22)
GUICtrlSetTip(-1, "Айпишник сетевых настроек.")
$combo_ip=GUICtrlCreateCombo ("", 120,36,125,18)
GUICtrlSetData(-1,$ip1&'|'&$ip2&'|'&$ip3&'|'&$ip4&'|'&$ip5&'|'&$ip6&'|'&$ip7&'|'&$ip8&'|'&$ip9&'|'&$ip10, $ip1)

GUICtrlCreateLabel ("Домашний каталог", 20,70,99,22)
GUICtrlSetTip(-1, "Домашний каталог для аккаунта Anonymous"&@CRLF&"и доступен для "&$username&" (автосоздание).")
$combo_ph=GUICtrlCreateCombo ("", 120,66,125,18)
GUICtrlSetData(-1,$pathhome1&'|'&$pathhome2&'|'&$pathhome3&'|'&$pathhome4&'|'&$pathhome5, $pathhome1)

GUICtrlCreateLabel ("Каталог закачек", 20,100,99,22)
GUICtrlSetTip(-1, "Каталог для закачки"&@CRLF&"на сервер (автосоздание).")
$combo_pm=GUICtrlCreateCombo ("", 120,96,125,18)
GUICtrlSetData(-1,$path_mhe1&'|'&$path_mhe2&'|'&$path_mhe3&'|'&$path_mhe4&'|'&$path_mhe5, $path_mhe1)

GUICtrlCreateLabel ("Каталог с паролем", 20,130,99,22)
GUICtrlSetTip(-1, "Домашний каталог для"&@CRLF&"аккаунта "&$username&" (автосоздание).")
$combo_pp=GUICtrlCreateCombo ("", 120,126,125,18)
GUICtrlSetData(-1,$path_pass1&'|'&$path_pass2&'|'&$path_pass3&'|'&$path_pass4&'|'&$path_pass5, $path_pass1)


$Check_full_1=GUICtrlCreateCheckbox ("Полный доступ к диску:", 20,155,146,20)
GUICtrlSetTip(-1, "Для обоих аккаунтов,"&@CRLF&"Anonymous и "&$username&".")
$bykvadicka_1=GUICtrlCreateCombo ("", 202,155,43,18)
GUICtrlSetData(-1,'C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z', 'C')

$Check_full_2=GUICtrlCreateCheckbox ("Полный доступ к диску:", 20,185,146,20)
GUICtrlSetTip(-1, "Для обоих аккаунтов,"&@CRLF&"Anonymous и "&$username&".")
$bykvadicka_2=GUICtrlCreateCombo ("", 202,185,43,18)
GUICtrlSetData(-1,'C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z', 'D')


GUICtrlCreateLabel ("Аккаунт:", 20,216,47,20)
GUICtrlSetTip(-1, "Учётка или логин"&@CRLF&"для подключения к серверу.")
$username1=GUICtrlCreateInput ($username, 70,214,110,22)

GUICtrlCreateLabel ("Пароль:", 20,246,47,20)
GUICtrlSetTip(-1, "Установить один"&@CRLF&"из пяти паролей.")
$password=GUICtrlCreateCombo ("", 70,242,43,18)
GUICtrlSetData(-1,'1|2|3|4|5', '1')
$copy=GUICtrlCreateButton ("в буфер", 120,243,60,22)
GUICtrlSetTip(-1, "Копировать пароль"&@CRLF&"в буфер обмена.")

$setnostart=GUICtrlCreateCheckbox ("Без старта сервера", 20,270,146,20)
GUICtrlSetTip(-1, "Конфигурировать,"&@CRLF&"не запуская сервер.")


$Readme=GUICtrlCreateButton ("Readme", 185,216,60,22)
GUICtrlSetTip(-1, "Старт сервера"&@CRLF&"с текущими настройками.")


$stop=GUICtrlCreateButton ("Стоп", 185,243,60,22)
GUICtrlSetTip(-1, "Остановить сервер"&@CRLF&"убив процесс.")


$start=GUICtrlCreateButton ("Старт", 185,270,60,22)
GUICtrlSetTip(-1, "Старт сервера"&@CRLF&"с текущими настройками.")
GUICtrlCreateTabitem ("")   ; конец вкладок

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
            Case $msg = $start
			   If FileExists($Ini1 & '.BAK') Then FileDelete ($Ini1 & '.BAK')
			   If FileExists($Ini1) Then
			   FileCopy($Ini1, $Ini1 & '.BAK', 1)
			   FileDelete ($Ini1)
			   EndIf
			   $password03 = GUICtrlRead ($password)
			   If $password03 = "1" Then $password0=$pass1
			   If $password03 = "2" Then $password0=$pass2
			   If $password03 = "3" Then $password0=$pass3
			   If $password03 = "4" Then $password0=$pass4
			   If $password03 = "5" Then $password0=$pass5
			   If $password03 <> "1" And $password03 <> "2" And $password03 <> "3" And $password03 <> "4" And $password03 <> "5" Then $password0=$pass1
			   $username0=GUICtrlRead ($username1)
			   $combo_ip0=GUICtrlRead ($combo_ip)
			   $combo_ph0=GUICtrlRead ($combo_ph)
			   $combo_pm0=GUICtrlRead ($combo_pm)
			   $combo_pp0=GUICtrlRead ($combo_pp)
			   $bykvadicka01=GUICtrlRead ($bykvadicka_1)
			   $bykvadicka02=GUICtrlRead ($bykvadicka_2)
			   If Not FileExists($combo_ph0&'\') Then DirCreate($combo_ph0)
			   If Not FileExists($combo_pm0&'\') Then DirCreate($combo_pm0)
			   If Not FileExists($combo_pp0&'\') Then DirCreate($combo_pp0)
			   ; создание Anonymous
			   IniWrite($Ini1, "GLOBAL", "Version", "6.2.0.0")
			   IniWrite($Ini1, "DOMAINS", "Domain1", $combo_ip0&'||21|Server|1|0|0')
			   IniWrite($Ini1, "Domain1", "User1", "Anonymous|1|0")
			   IniWrite($Ini1, "Domain1", "User2", $username0&"|1|0")
			   IniWrite($Ini1, "Domain1", "DynDNSEnable", "1")
			   IniWrite($Ini1, "USER=Anonymous|1", "HomeDir", $combo_ph0)
			   IniWrite($Ini1, "USER=Anonymous|1", "RelPaths", "1")
			   IniWrite($Ini1, "USER=Anonymous|1", "PasswordLastChange", "1226523413")
			   IniWrite($Ini1, "USER=Anonymous|1", "TimeOut", "600")
			   IniWrite($Ini1, "USER=Anonymous|1", "Note1", '"Wizard generated account"')
			   IniWrite($Ini1, "Domain1", "VirPath2", $combo_ph0&'|%HOME%|!home')
			   IniWrite($Ini1, "Domain1", "VirPath1", $combo_pm0&'|%HOME%|!MHE')
			   IniWrite($Ini1, "USER=Anonymous|1", "Access1", $combo_ph0&'|RLP')
			   IniWrite($Ini1, "USER=Anonymous|1", "Access2", $combo_pm0&'|RWLCP')
			   ; создание Password
			   IniWrite($Ini1, "USER="&$username0&"|1", "Password", $password0)
			   IniWrite($Ini1, "USER="&$username0&"|1", "HomeDir", $combo_pp0)
			   IniWrite($Ini1, "USER="&$username0&"|1", "RelPaths", "1")
			   IniWrite($Ini1, "USER="&$username0&"|1", "PasswordLastChange", "1226523413")
			   IniWrite($Ini1, "USER="&$username0&"|1", "TimeOut", "600")
			   IniWrite($Ini1, "USER="&$username0&"|1", "Note1", '"Wizard generated account"')
			   IniWrite($Ini1, "USER="&$username0&"|1", "Access1", $combo_ph0&'|RLP')
			   IniWrite($Ini1, "USER="&$username0&"|1", "Access2", $combo_pm0&'|RWLCP')
			   IniWrite($Ini1, "USER="&$username0&"|1", "Access3", $combo_pp0&'|RWAMLCD')
			   ; включение полного доступа к указанным дискам
			   If GUICtrlRead ($Check_full_1)=1 Then
			   IniWrite($Ini1, "Domain1", "VirPath3", $bykvadicka01&':\|%HOME%|Disk'&$bykvadicka01)
			   IniWrite($Ini1, "USER=Anonymous|1", "Access3", $bykvadicka01&':\|RWAMLCDP')
			   IniWrite($Ini1, "USER="&$username0&"|1", "Access4", $bykvadicka01&':\|RWAMLCDP')
			   EndIf
			   If GUICtrlRead ($Check_full_2)=1 Then
			   IniWrite($Ini1, "Domain1", "VirPath4", $bykvadicka02&':\|%HOME%|Disk'&$bykvadicka02)
			   IniWrite($Ini1, "USER=Anonymous|1", "Access4", $bykvadicka02&':\|RWAMLCDP')
			   IniWrite($Ini1, "USER="&$username0&"|1", "Access5", $bykvadicka02&':\|RWAMLCDP')
			   EndIf
			   ; сохранений установок
			   IniWrite($Ini, "ip", "ip1", $combo_ip0)
			   IniWrite($Ini, "path", "pathhome1", $combo_ph0)
			   IniWrite($Ini, "path", "path_mhe1", $combo_pm0)
			   IniWrite($Ini, "path", "path_pass1", $combo_pp0)
			   IniWrite($Ini, "user", "nameuser", $username0)
			   If GUICtrlRead ($setnostart)=$GUI_UNCHECKED Then
			   Run(@ScriptDir&'\ServUTray.exe')
			   Run(@ScriptDir&'\ServUAdmin.exe')
			   EndIf
            Case $msg = $copy
			   $password03 = GUICtrlRead ($password)
			   If $password03 = "1" Then $password0=$pass1
			   If $password03 = "2" Then $password0=$pass2
			   If $password03 = "3" Then $password0=$pass3
			   If $password03 = "4" Then $password0=$pass4
			   If $password03 = "5" Then $password0=$pass5
			   If $password03 <> "1" And $password03 <> "2" And $password03 <> "3" And $password03 <> "4" And $password03 <> "5" Then $password0=$pass1
			   $password01=""
			   If $password0 = "iz317B75870B2AC5A2182C7F898D968C7D" Then $password01="123456789"
			   If $password0 = "zy36617169DA089A168F12635C51D72F1C" Then $password01="11111"
			   If $password0 = "aq920713A3ECCE3FE942966897490B2BF9" Then $password01="WinPE"
			   If $password0 = "bpAA7F52F3729E8CD309603A0EBA801649" Then $password01="1324354657687980"
			   If $password0 = "jy4864323CA9861453C645845A45608620" Then $password01="d8k2g0rl8esj8y"
			   If $password01="" Then $password01="неизвестен"
			   ClipPut($password01)
			   MsgBox(0, "Сообщение", 'Пароль: '&$password01&' скопирован в буфер обмена')
			Case $msg = $stop
			   $PID1 = ProcessExists("ServUTray.exe")
			   If $PID1 Then ProcessClose($PID1)
			   $PID2 = ProcessExists("ServUAdmin.exe")
			   If $PID2 Then ProcessClose($PID2)
			   $PID3 = ProcessExists("ServUDaemon.exe")
			   If $PID3 Then ProcessClose($PID3)
			Case $msg = $Readme
			   MsgBox(0, "Readme", 'Конфигуратор задуман для быстрого старта сервера, указав основные настройки. Настройки конфигуратора сохраняются в файл ftpset.ini, многое можно изменить в нём. Настройки сервера можно подправить после старта. Свой пароль можно запомнить, а его шифрованный вид вытащить и вписать в ftpset.ini. При старте получаем два аккаунта, анонимный без пароля и аккаунт с паролем. Читать подсказки с кнопок и надписей. Если что-то не устраивает, скрипт в открытом виде, редактируйте под себя.')
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
		EndSelect
	WEnd