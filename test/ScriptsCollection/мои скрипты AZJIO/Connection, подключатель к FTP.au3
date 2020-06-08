#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=Connection.exe
#AutoIt3Wrapper_icon=Connection.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=
#AutoIt3Wrapper_Res_Description=Connection.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 12.10.2010 (AutoIt3_v3.2.12.1 - AdlibEnable)
#NoTrayIcon
Opt("GUIResizeMode", 0x0322)
#Include <File.au3>
#include <ListViewConstants.au3>

Dim $nCurCol    = -1
Dim $nSortDir   = 1
Dim $bSet       = 0
Dim $nCol       = 1
Global Const $LVM_GETITEM = $LVM_FIRST + 5

Global $iScroll_Pos, $Gui1, $nLAbt, $hAbt, $wAbtBt ; для About
Global $aRecords, $aIPPP, $PingInp0, $Port0, $IP, $ipinp01=1, $ipinp02=0, $h, $sPath
Global $Ini = @ScriptDir&'\ip.ini'
If Not FileExists($Ini) And MsgBox(4, "Выгодное предложение", "Хотите создать необходимый ip.ini"&@CRLF&"для хранения IP (айпишнеков)?")=6 Then
	$file = FileOpen($Ini,1)
	FileWrite($file, '192.168.30.92|Nick'&@CRLF&'192.168.31.93')
	FileClose($file)
EndIf

_Open()
$Gui= GUICreate("Connection - ip",300,140+$h, @DesktopWidth-308, -1, 0x00040000+0x00020000, 0x00000010) ; размер окна
$GuiPos = WinGetPos($Gui)
$delta=$GuiPos[3]-110-$h
$hListView = GUICtrlCreateListView('IP|Ping|Port|NickName' ,5,5,290,$h, $LVS_SHOWSELALWAYS + $LVS_SINGLESEL, $LVS_EX_FULLROWSELECT + $LVS_EX_CHECKBOXES)
GUICtrlSetState(-1, 8)
GUICtrlSetResizing(-1, 102+256)
; GUICtrlSendMsg($hListView, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_CHECKBOXES, $LVS_EX_CHECKBOXES)
; GUICtrlSendMsg($hListView, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_FULLROWSELECT, $LVS_EX_FULLROWSELECT)
GUICtrlSendMsg($hListView, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_TRACKSELECT, $LVS_EX_TRACKSELECT)

GUICtrlRegisterListViewSort (-1, "_Sort" )
GUICtrlSendMsg($hListView, 0x1000+30, 0, 125)
GUICtrlSendMsg($hListView, 0x1000+30, 1, 40)
GUICtrlSendMsg($hListView, 0x1000+30, 2, 48)
GUICtrlSendMsg($hListView, 0x1000+30, 3, 50)

GUICtrlSetBkColor(-1,0xf0f0f0) ; 0xE0DFE3 - цвет стандартный серый
_item()
$aRecords=''

$StatusBar=GUICtrlCreateLabel ('Строка состояния	  @AZJIO 12.10.2010', 10,110-18+$h,284,18, 0xC)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$checkall=GUICtrlCreateCheckbox("вкл/выкл все", 11,10+$h,81,22)
GUICtrlSetTip(-1, "Снять/поставить все галочки.")
GUICtrlSetState(-1,1)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$chP=GUICtrlCreateCheckbox("Вкл p+", 120,10+$h,65,22)
GUICtrlSetTip(-1, "Поставить галочки"&@CRLF&"на успешно пингованные компы")
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

GUICtrlCreateGroup('', 105, 26+$h, 77, 33)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$Scan=GUICtrlCreateButton("Ген", 107,35+$h,35,22)
GUICtrlSetTip(-1, "Генерировать список"&@CRLF&"диапазона IP")
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$Add=GUICtrlCreateButton("Add", 144,35+$h,35,22)
GUICtrlSetTip(-1, "Добавить отмеченные"&@CRLF&"в последний открытый список IP")
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$OpenSpicok=GUICtrlCreateButton ("Откр", 186,10+$h,37,22)
GUICtrlSetTip(-1, "Открыть список IP")
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$spicok=GUICtrlCreateButton ("ini", 225,10+$h,22,22)
GUICtrlSetTip(-1, "Редактировать список.")
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$re=GUICtrlCreateButton ("R", 249,10+$h,22,22)
GUICtrlSetTip(-1, "Перезапуск программки"&@CRLF&"после редактирования ini")
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$About=GUICtrlCreateButton ("@", 273,10+$h,22,22)
GUICtrlSetTip(-1, "О программе")
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$checkping=GUICtrlCreateCheckbox("Только пинг", 11,33+$h,86,22)
GUICtrlSetState(-1, 1)
GUICtrlSetTip(-1, "Быстрее. Не проверяется"&@CRLF&"соединение по порту")
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

GUICtrlCreateLabel("Пинг, мсек :", 10,67+$h,76,22)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$PingInp=GUICtrlCreateInput('250', 70,66+$h,30, 20)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$LPort=GUICtrlCreateLabel ('порт :', 110,67+$h,61,17)
GUICtrlSetState(-1, 128)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$ComboP=GUICtrlCreateCombo('', 143,65+$h,45)
GUICtrlSetState(-1, 128)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetData($ComboP,'21|80|81|82', '21')

$find=GUICtrlCreateButton ("Проверить", 200,35+$h,95,24)
GUICtrlSetTip(-1, "Проверить коннект"&@CRLF&"отмеченные галочкой")
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetState(-1, 256)

$conn=GUICtrlCreateButton ("Подключить", 200,64+$h,95,24)
GUICtrlSetTip(-1, "Подключится тоталом (21)"&@CRLF&"или браузером (80)"&@CRLF&"выделить не галочкой")
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$tr=0
GUISetState ()

While 1
	$msg = GUIGetMsg()
	Select
        Case $msg = $About
				_About()
		Case $msg =  -13
			If StringInStr(FileGetAttrib(@GUI_DRAGFILE), "D") = 0 And StringRight(@GUI_DRAGFILE, 4)='.ini' Then
				$Ini=@GUI_DRAGFILE
				_OpenSpicok()
			EndIf
		Case $msg = $OpenSpicok
			$IniFile = FileOpenDialog('Открыть', @WorkingDir , "Конфигурационный (*.ini)", "", "", $Gui)
			If @error Or StringRight($IniFile, 4)<>'.ini' Then ContinueLoop
			$Ini=$IniFile
			_OpenSpicok()
		Case $msg = $Add
			$file = FileOpen($Ini, 0)
			$textini = FileRead($file)
			FileClose($file)
			$file = FileOpen($Ini,1)
			$x=''
			$kol=0
			For $i=1 To $aIPPP[0][0]
				If GUICtrlRead($aIPPP[$i][0],1)=1 Then
					If Not StringRegExp($textini&@CRLF,'\Q'&$aIPPP[$i][1]&'\E(\s|\|)',0) Then
						$x&=@CRLF&$aIPPP[$i][1]
						$kol+=1
					EndIf
				EndIf
			Next
			FileWrite($file, $x)
			FileClose($file)
			GUICtrlSetData($StatusBar, 'Добавлено айпишнеков : '&$kol& ' шт')
		Case $msg = $Scan
			_MsgFile()
			If $ipinp01=1 Or $ipinp02=0 Then ContinueLoop
			$01start=StringRegExpReplace($ipinp01,'(^.*)\.(\d+)$','\2')
			$02start=StringRegExpReplace($ipinp01,'(^.*)\.(\d+)$','\1')
			if $ipinp02<0 Or $ipinp02>255 Or $ipinp02<=$01start Then
				MsgBox(0, 'Сообщение', "Параметры заданы не верно")
				ContinueLoop
			EndIf
			
			GUICtrlSendMsg($hListView, 0x1000+9, 0, 0)
			$aIPPP=''
			Dim $aIPPP[$ipinp02-$01start+2][5]
			$aIPPP[0][0]=$ipinp02-$01start+1
			$x=0
			For $i=$01start To $ipinp02
				$x+=1
				$aIPPP[$x][0]=GUICtrlCreateListViewItem($02start&'.'&$i,$hListView)
				GUICtrlSetState($aIPPP[$x][0],1)
				$aIPPP[$x][1]=$02start&'.'&$i
			Next
			
		Case $msg = $checkping
			If GUICtrlRead($checkping)=1 Then
				GUICtrlSetState($LPort, 128)
				GUICtrlSetState($ComboP, 128)
			Else
				GUICtrlSetState($LPort, 64)
				GUICtrlSetState($ComboP, 64)
			EndIf
		Case $msg = $find
			$timer = TimerInit() ; засекаем время
			If $tr=1 Then
				GUICtrlSetState($hListView, 32)
				For $i=1 To $aIPPP[0][0]
						GUICtrlSetColor($aIPPP[$i][0],0x000000)
						GUICtrlSetBkColor($aIPPP[$i][0],0xf0f0f0)
				Next
				GUICtrlSetState($hListView, 16)
			EndIf
			$Port0=GUICtrlRead($ComboP)
			$PingInp0=GUICtrlRead($PingInp)
			$checkping0=GUICtrlRead($checkping)
			TCPStartUp()
			
			$kol=0
			For $i=1 To $aIPPP[0][0]
				If GUICtrlRead($aIPPP[$i][0],1)=1 Then $kol+=1
			Next
			
			$t=0
			$p=0
			For $i=1 To $aIPPP[0][0]
			If GUICtrlRead($aIPPP[$i][0],1)=1 Then
			$t+=1
				GUICtrlSetData($StatusBar, 'Проверка '&$aIPPP[$i][1]&'	/ '&$kol&' / '&$kol-$t&' / '&$p&' / '&Ceiling(TimerDiff($timer) / 1000)&' сек')
				$Ping=Ping($aIPPP[$i][1], $PingInp0)
				If $Ping Then
					$aIPPP[$i][2]='p+'
					$p+=1
					If $checkping0=4 Then
						$iSocket = TCPConnect($aIPPP[$i][1], $Port0)
						If @error Then
							$aIPPP[$i][3]=$Port0&'-'
							GUICtrlSetData($aIPPP[$i][0],$aIPPP[$i][1]&'|'&$aIPPP[$i][2]&'|'&$aIPPP[$i][3])
							GUICtrlSetBkColor($aIPPP[$i][0],0xffff00)
						Else
							$aIPPP[$i][3]=$Port0&'+'
							GUICtrlSetData($aIPPP[$i][0],$aIPPP[$i][1]&'|'&$aIPPP[$i][2]&'|'&$aIPPP[$i][3])
							GUICtrlSetBkColor($aIPPP[$i][0],0x00ff00)
						EndIf
						TCPCloseSocket($iSocket)
					Else
						GUICtrlSetData($aIPPP[$i][0],$aIPPP[$i][1]&'|'&$aIPPP[$i][2])
						GUICtrlSetBkColor($aIPPP[$i][0],0xffff00)
					EndIf
				Else
					$aIPPP[$i][2]='p-'
					GUICtrlSetData($aIPPP[$i][0],$aIPPP[$i][1]&'|'&$aIPPP[$i][2]&'|'&$aIPPP[$i][3])
					GUICtrlSetColor($aIPPP[$i][0],0xcc0000)
					GUICtrlSetBkColor($aIPPP[$i][0],0xffd7d7)
				EndIf
			EndIf
			Next

			If $t Then
				GUICtrlSetData($StatusBar, 'Готово !!!'&'	/ '&$kol&' / '&$p&' / за '&Ceiling(TimerDiff($timer) / 1000)&' сек')
			Else
				GUICtrlSetData($StatusBar, 'Нет отмеченных галочкой.')
				MsgBox(0, 'Сообщение', 'Нет отмеченных галочкой.')
				TCPShutdown()
				ContinueLoop
			EndIf
			TCPShutdown()
			$tr=1

			; Выделить/отменить выделение всех
		Case $msg = $checkall
			If GUICtrlRead($checkall)=1 Then
				$p=1
			Else
				$p=4
			EndIf
			For $i = 1 To $aIPPP[0][0]
				GUICtrlSetState($aIPPP[$i][0],$p)
			Next

			; Выделить p+
		Case $msg = $chP
			If GUICtrlRead($chP)=1 Then
				For $i = 1 To $aIPPP[0][0]
					If $aIPPP[$i][2]='p+' Then GUICtrlSetState($aIPPP[$i][0],1)
					If $aIPPP[$i][2]='p-' Then GUICtrlSetState($aIPPP[$i][0],4)
				Next
			Else
				For $i = 1 To $aIPPP[0][0]
					GUICtrlSetState($aIPPP[$i][0],4)
				Next
			EndIf

		Case $msg = $conn
			TCPStartUp()
			$Port0=GUICtrlRead($ComboP)
			$PingInp0=GUICtrlRead($PingInp)
			$item000=ControlListView($Gui, '', 'SysListView321', 'GetSelected')
			$IP=ControlListView($Gui, '', 'SysListView321', 'GetText', $item000)
			If $Port0=21 Then
			_ConnectFTP()
			If @error Then ContinueLoop
			TCPShutdown()

			$aPath = StringSplit(@ScriptDir&'\Totalcmd.exe|'&@ProgramFilesDir&'\Totalcmd\Totalcmd.exe|'&@ProgramFilesDir&'\Totalcmd Podarok Edition\Totalcmd.exe|'&@ProgramFilesDir&'\Total Commander\Totalcmd.exe', "|")
			For $i=1 To $aPath[0]
				If FileExists($aPath[$i]) Then
					$sPath =$aPath[$i]
					ExitLoop
				else
					ContinueLoop
				endif
			Next
			If Not FileExists($sPath) Then
				MsgBox(0, 'Сообщение', 'Не найден Totalcmd в "Program Files"'&@CRLF&'Либо переместите утилиту в каталог Totalcmd')
				ContinueLoop
			EndIf

			$delfile = FileOpen(@TempDir&'\3k9tm6.ini', 2)
			FileWrite($delfile, '[connections]'&@CRLF& _
'1='&$IP&@CRLF& _
'default='&$IP&@CRLF& _
'[default]'&@CRLF& _
'pasvmode=0'&@CRLF& _
'[General]'&@CRLF& _
'ConnectRetries=10'&@CRLF& _
'WaitDelay=5'&@CRLF& _
'transfermode=I'&@CRLF& _
'LogFile='&@CRLF& _
'FtpInBackground=0'&@CRLF& _
'ModeZ=1'&@CRLF& _
'e-mail='&@CRLF& _
'['&$IP&']'&@CRLF& _
'host='&$IP&@CRLF& _
'username=anonymous'&@CRLF& _
'anonymous=1'&@CRLF& _
'directory=/'&@CRLF& _
'pasvmode=0'&@CRLF& _
'password=B4DB8CDB1AFFFF5DBE5112CE3D'&@CRLF)
FileClose($delfile)
			If ProcessExists ( "TOTALCMD.EXE" )<>0 Then ;если существует процесс TOTALCMD.EXE, то завершить его
				If  MsgBox(4, "Сообщение", "Перезапускаем Тотал?"&@CRLF&"(иначе ничего не получится)")=6 Then
					ProcessClose ( "TOTALCMD.EXE" )
					ProcessWaitClose ( "TOTALCMD.EXE" )
				Else
					ContinueLoop
				EndIf
			EndIf
			Run ( '"'&$sPath&'"  /F="'&@TempDir&'\3k9tm6.ini"', '', @SW_SHOW)
			WinWaitActive("[REGEXPTITLE:Total Commander *]", '', 2)
			If WinActive("[REGEXPTITLE:Total Commander *]") Then
				; меняем раскладку на клавиатуре
				$hWnd = WinGetHandle("classname=TTOTAL_CMD")
				$dll = DllOpen("user32.dll")
				Local $ret = DllCall($dll, "long", "LoadKeyboardLayout", "str", '00000409', "int", 0)
				DllCall("user32.dll", "ptr", "SendMessage", "hwnd", $hWnd, "int", 0x50, "int", 1, "int", $ret[0])
				DllClose($dll)
				; ожидаем окно
				Send("^{а}")
				sleep(100)
				If not WinActive("Соединение с FTP-сервером") Then
					Send("^{f}")
					sleep(100)
				EndIf
				If WinActive("Соединение с FTP-сервером") Then
					Send("{ENTER}")
				EndIf
			EndIf
			EndIf

			If $Port0=80 Or $Port0=81 Or $Port0=82 Then
				_ConnectHTTP()
				If @error Then ContinueLoop
				TCPShutdown()
				ShellExecute ('http://'&$IP&':'&$Port0)
			EndIf

		Case $msg = $spicok
			ShellExecute($Ini)
		Case $msg = $re
			_re()
		Case $msg = -3
			Exit
	     Case $hListView
            $bSet = 0
            $nCurCol = $nCol
	EndSelect
WEnd

Func _OpenSpicok()
	GUICtrlSendMsg($hListView, 0x1000+9, 0, 0)
	_Open()
	_item()
	$aRecords=''
	$GuiPos = WinGetPos($Gui)
	WinMove($Gui, '', @DesktopWidth-308, @DesktopHeight/2-110/2-$h/2-$delta/2-10, 300, 110+$h+$delta)
	GUICtrlSetPos($hListView, 5, 5, -1, $h)
	$finame=StringRegExpReplace($Ini,'(^.*)\\(.*)\.(.*)$','\2')
	WinSetTitle($Gui, '', 'Connection - '&$finame)
	GUICtrlSetTip($Add, "Добавить отмеченные"&@CRLF&"в последний открытый список IP"&@CRLF&"в "&$finame)
	GUICtrlSetData($StatusBar, 'Открыт файл: '&$finame&', '&$aIPPP[0][0]&' шт')
EndFunc

Func _Open()
; читаем данные ip.ini в массив
If Not _FileReadToArray($Ini,$aRecords) Then
   MsgBox(4096,"Ошибка", "Ошибка чтения массива ip.ini", @error)
   Exit
EndIf
$h=$aRecords[0]*18+25+18 ; установка размера по количеству итемов
If $aRecords[0]*18>@DesktopHeight-210 Then $h=@DesktopHeight-210
EndFunc

Func _item()
Dim $aIPPP[$aRecords[0]+1][5]
$aIPPP[0][0]=$aRecords[0]

For $i=1 To $aRecords[0]
	If StringInStr($aRecords[$i], '|') Then
		$aRec=StringSplit($aRecords[$i], '|')
		$aRecords[$i]=$aRec[1]
		$aIPPP[$i][4]=$aRec[2]
		$aIPPP[$i][0]=GUICtrlCreateListViewItem($aRecords[$i]&'|||'&$aRec[2],$hListView)
		GUICtrlSetState($aIPPP[$i][0],1)
	Else
		$aIPPP[$i][0]=GUICtrlCreateListViewItem($aRecords[$i],$hListView)
		GUICtrlSetState($aIPPP[$i][0],1)
	EndIf
	$aIPPP[$i][1]=$aRecords[$i]
Next
EndFunc

Func _MsgFile()
	$ipinp01=1
	$ipinp02=0
	$GuiPos = WinGetPos($Gui)
	GUISetState(@SW_DISABLE, $Gui)
	
    $Gui1 = GUICreate('Выбираем диапазон IP', 185, 70,$GuiPos[0]+60, $GuiPos[1]+$GuiPos[3]-210, -1, 0x00000080,$Gui)
	GUICtrlCreateLabel('От', 10, 12, 15, 17)
	$ipinp1=GUICtrlCreateInput('192.168.30.0', 25, 10, 100, 20)
	GUICtrlCreateLabel('до', 130, 12, 15, 17)
	$ipinp2=GUICtrlCreateInput('255', 145, 10, 30, 20)
	$Ok=GUICtrlCreateButton ('Ok', 50, 40, 80, 22)
	GUISetState(@SW_SHOW, $Gui1)
$msg = $Gui1
	While 1
	  $msg = GUIGetMsg()
	  Select
		Case $msg = $Ok
			$ipinp01=GUICtrlRead($ipinp1)
			$ipinp02=GUICtrlRead($ipinp2)
			ContinueCase
		Case $msg = -3
			$msg = $Gui
			GUIDelete($Gui1)
			WinActivate($Gui)
			GUISetState(@SW_ENABLE, $Gui)
			ExitLoop
		EndSelect
    WEnd
EndFunc

Func _ConnectFTP()
	$Ping=Ping($IP, $PingInp0)
	If $Ping Then
		TCPConnect($IP, $Port0)
		If @error And MsgBox(4, "Сообщение", 'Сервер '&$IP&' : '&$Port0&' недоступен,'&@CRLF&' всё равно продолжить?')=7 Then
			TCPShutdown()
			Return SetError(1)
		EndIf
	Else
		If MsgBox(4, "Сообщение", 'Сервер '&$IP&' : '&$Port0&' недоступен,'&@CRLF&' всё равно продолжить?')=7 Then
			TCPShutdown()
			Return SetError(1)
		EndIf
	EndIf
	Return SetError(0)
EndFunc

Func _ConnectHTTP()
	$Ping=Ping($IP, $PingInp0)
	If @error And MsgBox(4, "Сообщение", 'Хост '&$IP&' недоступен,'&@CRLF&' всё равно продолжить?')=7 Then
		TCPShutdown()
		Return SetError(1)
	EndIf
		
	$iSocket = TCPConnect($IP, $Port0)
	If @error And MsgBox(4, "Сообщение", 'Сервер '&$IP&' : '&$Port0&' недоступен,'&@CRLF&' всё равно продолжить?')=7 Then
		TCPShutdown()
		Return SetError(1)
	EndIf
    
    Local $sCommand = "HEAD / HTTP/1.1" & @CRLF & _
    "Host: " & $IP & @CRLF & _
    "User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.8) Gecko/20100722 Firefox/3.6.8" & @CRLF & _
    "Referer: " & $IP & @CRLF & _
    "Connection: close" & @CRLF & @CRLF
    
    Local $iBytesSent = TCPSend($iSocket, $sCommand)
    If $iBytesSent = 0 Then Return SetError(2, @error, 0)
    Local $sRecv = "", $sCurrentRecv
    
    While 1
        $sCurrentRecv = TCPRecv($iSocket, 16)
        If @error <> 0 Then ExitLoop
        If $sCurrentRecv <> "" Then $sRecv &= $sCurrentRecv
    WEnd
    
    TCPCloseSocket($iSocket)
    Return StringRegExp($sRecv, "(?i)HTTP/\d.\d (200|301)") = 1
EndFunc

Func _Sort($hWnd, $nItem1, $nItem2, $nColumn)

    ; Switch the sorting direction
    If $nColumn = $nCurCol Then
        If Not $bSet Then
            $nSortDir = $nSortDir * -1
            $bSet = 1
        EndIf
    Else
        $nSortDir = 1
    EndIf
    $nCol = $nColumn

    $val1   = GetSubItemText($hListView, $nItem1, $nColumn)
    $val2   = GetSubItemText($hListView, $nItem2, $nColumn)

    ; If it is the 3rd colum (column starts with 0) then compare the dates
    If $nColumn = 2 Then
        $val1 = StringRight($val1, 4) & StringMid($val1, 4, 2) & StringLeft($val1, 2)
        $val2 = StringRight($val2, 4) & StringMid($val2, 4, 2) & StringLeft($val2, 2)
    EndIf

    $nResult = 0        ; No change of item1 and item2 positions

    If $val1 < $val2 Then
        $nResult = -1   ; Put item2 before item1
    ElseIf  $val1 > $val2 Then
        $nResult = 1    ; Put item2 behind item1
    EndIf

    $nResult = $nResult * $nSortDir

    Return $nResult
EndFunc


; Retrieve the text of a listview item in a specified column
Func GetSubItemText($nCtrlID, $nItemID, $nColumn)
    Local $stLvfi       = DllStructCreate("uint;ptr;int;int[2];int")
    DllStructSetData($stLvfi, 1, $LVFI_PARAM)
    DllStructSetData($stLvfi, 3, $nItemID)

    Local $stBuffer     = DllStructCreate("char[260]")

    $nIndex = GUICtrlSendMsg($nCtrlID, $LVM_FINDITEM, -1, DllStructGetPtr($stLvfi));

    Local $stLvi        = DllStructCreate("uint;int;int;uint;uint;ptr;int;int;int;int")

    DllStructSetData($stLvi, 1, $LVIF_TEXT)
    DllStructSetData($stLvi, 2, $nIndex)
    DllStructSetData($stLvi, 3, $nColumn)
    DllStructSetData($stLvi, 6, DllStructGetPtr($stBuffer))
    DllStructSetData($stLvi, 7, 260)

    GUICtrlSendMsg($nCtrlID, $LVM_GETITEM, 0, DllStructGetPtr($stLvi));

    $sItemText  = DllStructGetData($stBuffer, 1)

    $stLvi      = 0
    $stLvfi     = 0
    $stBuffer   = 0

    Return $sItemText
EndFunc

Func _re()
    Local $sAutoIt_File = @TempDir & "\~Au3_ScriptRestart_TempFile.au3"
    Local $sRunLine, $sScript_Content, $hFile

    $sRunLine = @ScriptFullPath
    If Not @Compiled Then $sRunLine = @AutoItExe & ' /AutoIt3ExecuteScript ""' & $sRunLine & '""'
    If $CmdLine[0] > 0 Then $sRunLine &= ' ' & $CmdLineRaw

    $sScript_Content &= '#NoTrayIcon' & @CRLF & _
    'While ProcessExists(' & @AutoItPID & ')' & @CRLF & _
    '   Sleep(10)' & @CRLF & _
    'WEnd' & @CRLF & _
    'Run("' & $sRunLine & '")' & @CRLF & _
    'FileDelete(@ScriptFullPath)' & @CRLF

    $hFile = FileOpen($sAutoIt_File, 2)
    FileWrite($hFile, $sScript_Content)
    FileClose($hFile)

    Run(@AutoItExe & ' /AutoIt3ExecuteScript "' & $sAutoIt_File & '"', @ScriptDir, @SW_HIDE)
    Sleep(1000)
    Exit
EndFunc  ;==>_re

Func _About()
	$LngTitle='Connection'
	$LngAbout='О программе'
	$LngVer='Версия'
	$LngSite='Сайт'
	$LngCopy='Копировать'
	$wAbt=270
	$hAbt=180
	$wAbtBt=20
	$wA=$wAbt/2-80
	$wB=$hAbt/3*2
	$iScroll_Pos = -$hAbt
	$TrAbt1 = 0
	$TrAbt2 = 0
	$BkCol1=0xf8c848
	$BkCol2=0
	$GuiPos = WinGetPos($Gui)
	GUISetState(@SW_DISABLE, $Gui)
	$font="Arial"
	
	$Gui1 = GUICreate($LngAbout, $wAbt, $hAbt,$GuiPos[0]+5, $GuiPos[1]+$GuiPos[3]-315, -1, 0x00000080,$Gui)
	GUISetBkColor ($BkCol1)
	GUISetFont (-1, -1, -1, $font)
	$vk1=GUICtrlCreateButton (ChrW('0x25BC'), 0, $hAbt-20, $wAbtBt, 20)
		
	GUICtrlCreateTab ($wAbtBt,0, $wAbt-$wAbtBt,$hAbt+35,0x0100+0x0004+0x0002)
	$tabAbt0=GUICtrlCreateTabitem ("0")

	GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt-$wAbtBt, $hAbt)
	GUICtrlSetState(-1, 128) 
	GUICtrlSetBkColor (-1, $BkCol1)


	GUICtrlCreateLabel($LngTitle, 0, 0, $wAbt, $hAbt/3, 0x01+0x0200)
	GUICtrlSetFont (-1,15, 600, -1, $font)
	GUICtrlSetColor(-1,0xa21a10)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,$hAbt/3, $wAbt-2,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.3  13.10.2010', $wA, $wB-30, 210, 17)
	GUICtrlCreateLabel($LngSite&':', $wA, $wB-15, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', $wA+37, $wB-15, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', $wA, $wB, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', $wA+75, $wB, 125, 17)
	GUICtrlSetColor(-1,0xa21a10)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010', $wA, $wB+15, 210, 17)

	$tabAbt1=GUICtrlCreateTabitem ("1")

	GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt-$wAbtBt, $hAbt)
	GUICtrlSetState(-1, 128) 
	GUICtrlSetBkColor (-1, 0x000000)

$StopPlay= GUICtrlCreateButton(ChrW('0x25A0'), 0, $hAbt-41, $wAbtBt, 20)
GUICtrlSetState(-1,32)

$LngScrollAbt = 'Connection v0.3' & @CRLF & _
'утилитка для проверки серверов в онлайне' & @CRLF & @CRLF & _
'1. Список можно сгенерировать (Ген), проверить по списку, добавить (Add) онлайновые в список.' & @CRLF & _
'2. Списки можно открывать или кидать в окно утилиты, т.е. иметь несколько списков.' & @CRLF & _
'3. Сортировка по графе Ping позволяет сгруппировать онлайновые сервера.' & @CRLF & _
'4. Для ускорения проверки использовать "Только пинг". Проверка с учётом порта займёт много больше времени.' & @CRLF & @CRLF & _
'первая опубликованная версия'

$nLAbt = GUICtrlCreateLabel($LngScrollAbt, $wAbtBt, $hAbt, $wAbt-$wAbtBt, 360, 0x1) ; центр
GUICtrlSetFont(-1, 9, 400, 2, $font)
GUICtrlSetColor(-1, 0xFFD800)
GUICtrlSetBkColor(-1, -2) ; прозрачный
GUICtrlCreateTabitem ('')
GUISetState(@SW_SHOW, $Gui1)

$msg = $Gui1
	While 1
	  $msg = GUIGetMsg()
	  Select
		Case $msg =$vk1
			If $TrAbt1 = 0 Then
				GUICtrlSetState($tabAbt1,16)
				GUICtrlSetState($nLAbt,16)
				GUICtrlSetState($StopPlay,16)
				GUICtrlSetData($vk1, ChrW('0x25B2'))
				GUISetBkColor ($BkCol2)
				If $TrAbt2 = 0 Then AdlibEnable('_ScrollAbtText', 40)
				$TrAbt1 = 1
			Else
				GUICtrlSetState($tabAbt0,16)
				GUICtrlSetState($nLAbt,32)
				GUICtrlSetState($StopPlay,32)
				GUICtrlSetData($vk1, ChrW('0x25BC'))
				GUISetBkColor ($BkCol1)
				AdlibDisable()
				$TrAbt1 = 0
			EndIf
		Case $msg = $StopPlay
			If $TrAbt2 = 0 Then
				AdlibDisable()
				GUICtrlSetData($StopPlay, ChrW('0x25BA'))
				$TrAbt2 = 1
			Else
				AdlibEnable('_ScrollAbtText', 40)
				GUICtrlSetData($StopPlay, ChrW('0x25A0'))
				$TrAbt2 = 0
			EndIf
		Case $msg = $url
			ShellExecute ('http://azjio.ucoz.ru')
		Case $msg = $WbMn
			ClipPut('R939163939152')
		Case $msg = -3
			AdlibDisable()
			$msg = $Gui
			GUISetState(@SW_ENABLE, $Gui)
			GUIDelete($Gui1)
			ExitLoop
		EndSelect
    WEnd
EndFunc

Func _ScrollAbtText()
    $iScroll_Pos += 1
    ControlMove($Gui1, "", $nLAbt, $wAbtBt, -$iScroll_Pos)
    If $iScroll_Pos > 360 Then $iScroll_Pos = -$hAbt
EndFunc