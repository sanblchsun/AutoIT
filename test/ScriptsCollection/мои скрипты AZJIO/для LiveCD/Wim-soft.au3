;  @AZJIO 12.04.2010
#NoTrayIcon ;скрыть в системной панели индикатор AutoIt

Global $Ini = @ScriptDir&'\Wim-soft.ini' ; путь к Wim-soft.ini
;Проверка существования Wim-soft.ini
$answer = ""
If Not FileExists($Ini) Then $answer = MsgBox(4, "Выгодное предложение", "Хотите создать необходимый Wim-soft.ini"&@CRLF&"для добавления имён программ?")
If $answer = "6" Then
$iniopen = FileOpen($Ini,1)
FileWrite($iniopen, '[Wim-soft]'&@CRLF&'; имя и описание программы'&@CRLF&'AVP9|Антивирус Касперского 9'&@CRLF&'Ghost32'&@CRLF&'Everest|Подробная информация о железе'&@CRLF&'ACRONIS|Бэкап и восстановление жётского диска из образа'&@CRLF&'[Path]'&@CRLF&'; пути создания ярлыков'&@CRLF&'DPCD="Desktop"'&@CRLF&'DPRAM="Desktop"'&@CRLF&'b_wim="B:\wim-soft"'&@CRLF&'[setting]'&@CRLF&'autoclose=1'&@CRLF&'[autocreatealllnk]'&@CRLF&'; автосоздание ярлыков с указанных типов дисков'&@CRLF&'Fixed=1'&@CRLF&'Removable=1'&@CRLF&'CDROM=1')
FileClose($iniopen)
EndIf

;считываем Wim-soft.ini
$DPCD= IniRead ($Ini, "Path", 'DPCD', @StartMenuCommonDir&'\Wim-soft')
$DPRAM= IniRead ($Ini, "Path", "DPRAM", @StartMenuCommonDir&'\Wim-soft-RAM')
$b_wim= IniRead ($Ini, "Path", "b_wim", 'B:\wim-soft')
$autocloseini= IniRead ($Ini, "setting", "autoclose", '1')

$Fixed= IniRead ($Ini, "autocreatealllnk", "Fixed", '1')
$Removable= IniRead ($Ini, "autocreatealllnk", "Removable", '1')
$CDROM= IniRead ($Ini, "autocreatealllnk", "cdrom", '1')

$DPCDst=$DPCD
If $DPCD = 'Desktop' Then $DPCD = @DesktopDir
If $DPCD = 'Programs' Then $DPCD = @ProgramsDir
If $DPCD = 'QuickLaunch' Then $DPCD = @AppDataDir&'\Microsoft\Internet Explorer\Quick Launch'
If $DPCD = 'bar' Then $DPCD = @ProgramsDir&'\!\Windows\Panel'

If $DPRAM = 'Desktop' Then $DPRAM = @DesktopDir
If $DPRAM = 'Programs' Then $DPRAM = @ProgramsDir
If $DPRAM = 'QuickLaunch' Then $DPRAM = @AppDataDir&'\Microsoft\Internet Explorer\Quick Launch'
If $DPRAM = 'bar' Then $DPRAM = @ProgramsDir&'\!\Windows\Panel'

$close = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Wim-soft", "close")
If @error  Then
	RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Wim-soft", "close", "REG_SZ", $autocloseini)
	$close =$autocloseini
EndIf

$file = FileOpen($Ini, 0)
$filetext = FileRead($file)
FileClose($file)
$filetext = StringRegExpReplace($filetext, "(?s).*\[Wim-soft\]\r\n(.*?)(?:\r\n\[.*)", "\1")
$filetext = StringRegExpReplace(@CRLF&$filetext, "\r\n\s*;.*(\r\n)+|(\r\n)+", @CRLF)
$filetext = StringRegExpReplace(@CRLF&$filetext, "(\r\n){2,}", '')
;$filetext = StringRegExpReplace(@CRLF&$filetext, "(\r\n)+\s*;.*(\r\n)+|(\r\n){2,}", '')

;кусок кода из UDF File.au3 для разделения образца построчно в массив
	If StringInStr($filetext, @LF) Then
		$aFiletext = StringSplit(StringStripCR($filetext), @LF)
	ElseIf StringInStr($filetext, @CR) Then ;; @LF does not exist so split on the @CR
		$aFiletext = StringSplit($filetext, @CR)
	Else ;; unable to split the file
		If StringLen($filetext) Then
			Dim $aFiletext[2] = [1, $filetext]
		Else
			MsgBox(0, "Сообщение", "нет данных о программах в wim")
			Exit
		EndIf
	EndIf

For $i = 1 to UBound($aFiletext) - 1 ; создаём переменные в цикле
$aLNKWIM = StringSplit($aFiletext[$i], "|")
Assign('NME' & $i, $aLNKWIM[1])
If $aLNKWIM[0] = 1 Then
Assign('DSC' & $i, $aLNKWIM[1])
Else
Assign('DSC' & $i, $aLNKWIM[2])
EndIf
Next

; первый запуск только создание ярлыка на рабочем столе.

$TypeDrive = DriveGetType(StringMid(@ScriptDir, 1, 3))
If Eval($TypeDrive)=1 And FileExists('B:\') And NOT FileExists(@DesktopDir&'\wim-soft.lnk') Then
		For $i=1 To UBound($aFiletext) - 1
			$NME = Eval('NME' & $i)
		If $NME<>'' Then
			$DIR = $DPCD
			$LNK = $DIR&'\'&$NME
			$WRK = @ScriptDir&'\'&$NME
			$EXE = $WRK&'\'&$NME
			$DSC = Eval('DSC' & $i)
			$ICO = $EXE
			If NOT FileExists($DIR) Then DirCreate($DIR)
			If FileExists ($EXE&'.wim') Then FileCreateShortcut($EXE&'.wim', $LNK&'.lnk', $WRK,'', $DSC, $ICO&'.ico')
		Else
		 ExitLoop
		EndIf
			Next
Endif

If NOT FileExists(@DesktopDir&'\wim-soft.lnk') And FileExists('B:\') Then
   FileCreateShortcut(@WindowsDir&'\SYSTEM32\AutoIt3.exe', @DesktopDir&'\wim-soft.lnk', @ScriptDir, @ScriptDir&'\Wim-soft.au3', 'Подключение Wim-программ', @WindowsDir&'\SYSTEM32\shell32.dll','','162')
Exit
Endif


GUICreate("Создание ярлыков для WIM",540,340) ; размер окна
$restart0 = GUICtrlCreateButton("R", 520, 2, 18, 18)
GUICtrlSetTip(-1, "Перезапуск скрипта.")
$tab=GUICtrlCreateTab (0,2, 540,338) ; размер вкладки
$tab0=GUICtrlCreateTabitem ("Ярлыки") ; имя вкладки


GUICtrlCreateGroup("Создать здесь", 395, 27, 127, 124)
$Programs= GUICtrlCreateRadio("Programs", 415, 45, 90, 20)
GUICtrlSetTip(-1, "Создавать ярлыки в программной папке.")
$QuickLaunch = GUICtrlCreateRadio("QuickLaunch", 415, 65, 90, 20)
GUICtrlSetTip(-1, "Создавать ярлыки в панели быстрого запуска.")
$Bar = GUICtrlCreateRadio("Bar", 415, 85, 90, 20)
GUICtrlSetTip(-1, "Создавать ярлыки на верхней панели.")
$Desktop = GUICtrlCreateRadio("Desktop", 415, 105, 90, 20)
GUICtrlSetTip(-1, "Создавать ярлыки на рабочем столе.")
$RadioOR = GUICtrlCreateRadio("Другое", 415, 125, 90, 20)
GUICtrlSetTip(-1, "Создавать ярлыки по умолчанию.")
If $DPCDst='Desktop' or $DPCDst='Programs' or $DPCDst='QuickLaunch' or $DPCDst='bar' Then
GUICtrlSetState(Eval($DPCDst), 1)
Else
GUICtrlSetState($RadioOR, 1)
EndIf


$createlnk1=GUICtrlCreateButton ("Создать все", 395,160,127,22)
GUICtrlSetTip(-1, "Создать все ярлыки и закрыть окно")
$createlnk2=GUICtrlCreateButton ("Копировать+Создать", 395,190,127,22)
GUICtrlSetTip(-1, 'Копировать отмеченный Wim-soft на диск B:'&@CRLF&'и создать ярлыки.')
$checkall=GUICtrlCreateCheckbox ("Вкл/выкл все", 395,220,127,22)
GUICtrlSetTip(-1, "Убрать/поставить галочки" & @CRLF & "на всех пунктах")
$explorer=GUICtrlCreateButton ("Папка Wim-soft", 395,300,127,22)
GUICtrlSetTip(-1, "Открыть каталог Wim-soft.")
$autoclose=GUICtrlCreateCheckbox ("авто-закрыть", 395,240,127,22)
If $close = '1' Then GuiCtrlSetState(-1, 1)
GUICtrlSetTip(-1, "Автозакрытие при клике на кнопках.")
   
For $i=1 To UBound($aFiletext) - 1
	$NME = Eval('NME' & $i)
If $NME<>'' Then
	$DSC = Eval('DSC' & $i)
	$pos=$i*20+10
	$pos_L=10
	If $i>'15' Then $pos_L=135
	If $i>'15' Then $pos=$i*20+10-300
	If $i>'30' Then $pos_L=260
	If $i>'30' Then $pos=$i*20+10-600
	Assign('check' & $i, GUICtrlCreateCheckbox ($NME,$pos_L,$pos,120,20))
	If NOT FileExists(@ScriptDir&'\'&$NME&'\'&$NME&'.wim') Then GuiCtrlSetState(Eval('check' & $i), 128)
	GUICtrlSetTip(-1, $DSC)
Else
   ExitLoop
EndIf
	Next


$tab1=GUICtrlCreateTabitem ("Демонтировать") ; имя вкладки

GUICtrlCreateLabel ("Перед демонтированием программа должна быть закрыта.", 395,25,135,90)

$checkall_D=GUICtrlCreateCheckbox ("Вкл/выкл все", 395,270,127,22)
$Unmount=GUICtrlCreateButton ("Демонтировать", 395,300,127,22)
GUICtrlSetTip(-1, 'Демонтирование и удаление'&@CRLF&'каталога монтирования.')


If not FileExists(@SystemDir & '\imagex.exe /mount') Then

; извлечение информации о смонтированных wim
$rnim = Run(@SystemDir & '\imagex.exe /mount', @SystemDir, @SW_HIDE, 2)
$wiminfo = ''
While 1
	$line1 = StdoutRead($rnim)
	If @error Then ExitLoop
	$wiminfo &= $line1
Wend
$aPathwim = StringRegExp($wiminfo, "(?i)Mount Path \.*:\[(.*)]", 3)
$aNamewim = StringRegExp($wiminfo, "(?i)Image File \.*:\[(.*)]", 3)
$aNomer = StringRegExp($wiminfo, "(?i)Number of Mounted Images: \.*(.*)", 3)

If $aPathwim = '1' Then
	GUICtrlSetState($Unmount,128)
	GUICtrlSetState($checkall_D,128)
EndIf

; создание списка в GUI-оболочке
$nomer = Number($aNomer[0])
For $i = 1 To $nomer
	$x = $i - 1
	$aWim = StringRegExp($aNamewim[$x], "(^.*)\\(.*)$", 3)
	$pos = $i * 20 +10
	$pos_L = 10
	If $i > '15' Then $pos_L = 135
	If $i > '15' Then $pos = $i * 20 +10-300
	If $i > '30' Then $pos_L = 260
	If $i > '30' Then $pos = $i * 20+10-600
	Assign('check_D' & $i, GUICtrlCreateCheckbox($aWim[1], $pos_L, $pos, 120, 20))
	;GuiCtrlSetState(Eval('check' & $i), 1) ; поставить галочки по умолчанию
Next
Else
	GUICtrlSetState($Unmount,128)
	GUICtrlSetState($checkall_D,128)
EndIf

$tab1=GUICtrlCreateTabitem ("    ?") ; имя вкладки
GUICtrlCreateLabel ('Скрипт автосоздания ярлыков для программ в WIM-архиве.'&@CRLF&'Настройки хранятся в Wim-soft.ini. При его удалении скрипт предложит создать как пример с настройками по умолчанию.'&@CRLF&@CRLF&'Описание параметров:'&@CRLF&'DPCD= путь к ярлыкам при автосоздании или выборе "Другой"'&@CRLF&'DPRAM= путь к ярлыкам при автосоздании или выборе "Другой", если WIM скопирован в RAM'&@CRLF&'DPCD и DPRAM кроме указания прямого пути поддерживают параметры Programs, QuickLaunch, Bar, Desktop.'&@CRLF&'b_wim= каталог копирования в RAM'&@CRLF&'autoclose= автозакрытие скрипта при нажатии кнопок, (0,1).'&@CRLF&'Fixed=, Removable=, CDROM= - диски с которых происходит автосоздание ярлыков при загрузке, (0,1)'&@CRLF&'Секция [Wim-soft] содержит имя программы и описание через разделитель | (описание не обязательно).', 15,30,520,300)
GUICtrlCreateLabel ('@AZJIO 12.04.2010', 430,315,100,18)

GUICtrlCreateTabitem ("")   ; конец вкладок

GUISetState ()

While 1
	$msg = GUIGetMsg()
Select
	Case $msg = $createlnk1
		If GUICtrlRead ($Programs)=1 Then $DPCD=@ProgramsDir
		If GUICtrlRead ($QuickLaunch)=1 Then $DPCD=@UserProfileDir&'\Application Data\Microsoft\Internet Explorer\Quick Launch'
		If GUICtrlRead ($Bar)=1 Then $DPCD=@ProgramsDir&'\!\Windows\Panel'
		If GUICtrlRead ($Desktop)=1 Then $DPCD=@DesktopDir
		For $i=1 To UBound($aFiletext) - 1
			$NME = Eval('NME' & $i)
		If $NME<>'' Then
			$DIR = $DPCD
			$LNK = $DIR&'\'&$NME
			$WRK = @ScriptDir&'\'&$NME
			$EXE = $WRK&'\'&$NME
			$DSC = Eval('DSC' & $i)
			$ICO = $EXE
			If NOT FileExists($DIR) Then DirCreate($DIR)
			If FileExists ($EXE&'.wim') Then FileCreateShortcut($EXE&'.wim', $LNK&'.lnk', $WRK,'', $DSC, $ICO&'.ico')
		Else
		 ExitLoop
		EndIf
			Next
			If GUICtrlRead ($autoclose)=1 Then ExitLoop
			
; Копировать wim-soft на B:\wim-soft с проверкой чекбоксов и существования каталогов
		;создание ярлыков для B:\wim-soft
	Case $msg = $createlnk2
		If GUICtrlRead ($Programs)=1 Then $DPCD=@ProgramsDir
		If GUICtrlRead ($QuickLaunch)=1 Then $DPCD=@UserProfileDir&'\Application Data\Microsoft\Internet Explorer\Quick Launch'
		If GUICtrlRead ($Bar)=1 Then $DPCD=@ProgramsDir&'\!\Windows\Panel'
		If GUICtrlRead ($Desktop)=1 Then $DPCD=@DesktopDir
		If GUICtrlRead ($RadioOR)=1 Then $DPCD = $DPRAM

		For $i=1 To UBound($aFiletext) - 1
			$check = Eval('check' & $i)
			$NME = Eval('NME' & $i)
		If $NME<>'' Then
			$DIR = $DPCD
			$LNK = $DIR&'\'&$NME
			$WRK = $b_wim&'\'&$NME
			$EXE = $WRK&'\'&$NME
			$DSC = Eval('DSC' & $i)
			$ICO = $EXE
			If GUICtrlRead ($check)=1 And FileExists(@ScriptDir&'\'&$NME) Then
			DirCopy ( @ScriptDir&'\'&$NME, $WRK,1)
			If NOT FileExists($DIR) Then DirCreate($DIR)
			If FileExists ($EXE&'.wim') Then FileCreateShortcut($EXE&'.wim', $LNK&'.lnk', $WRK,'', $DSC, $ICO&'.ico')
			EndIf
		Else
		 ExitLoop
		EndIf
			Next
			If GUICtrlRead ($autoclose)=1 Then ExitLoop
			
; Выделить/отменить выделение всех
	Case $msg = $checkall
			If GUICtrlRead($checkall)=1 Then
				$p=1
			Else
				$p=4
			EndIf
	   	For $i=1 To UBound($aFiletext) - 1
			$NME = Eval('NME' & $i)
		If $NME<>'' Then
			GuiCtrlSetState(Eval('check' & $i), $p)
		Else
		 ExitLoop
		EndIf
			Next
	Case $msg = $explorer
		Run('explorer.exe '&@ScriptDir)

	; Отмонтировать отмеченные
	Case $msg = $Unmount
			For $i = 1 To $nomer
				If GUICtrlRead(Eval('check_D' & $i)) = 1 Then
					$x = $i - 1
					ShellExecuteWait(@SystemDir & '\imagex.exe', '/unmount "' & $aPathwim[$x] & '"', '', '', @SW_HIDE)
					DirRemove($aPathwim[$x], 1)
					GUICtrlSetState(Eval('check_D' & $i), 32)
				EndIf
			Next

	; Выделить/отменить выделение всех на вкладке "Демонтировать"
	Case $msg = $checkall_D
			If GUICtrlRead($checkall_D)=1 Then
				$p=1
			Else
				$p=4
			EndIf
			For $i = 1 To $nomer
				GuiCtrlSetState(Eval('check_D' & $i), $p)
			Next
			
			; сохранение в реестр настройки автозакрытия
			Case $msg = $autoclose
				If GUICtrlRead($autoclose) = 1 Then
					RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Wim-soft", "close", "REG_SZ", "1")
				Else
					RegWrite("HKEY_LOCAL_MACHINE\SOFTWARE\script_az\Wim-soft", "close", "REG_SZ", "4")
				EndIf
		Case $msg = $restart0
			_ScriptRestart()
	Case $msg = -3
		ExitLoop
EndSelect
WEnd

; функция перезапуска скрипта
Func _ScriptRestart()
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
EndFunc   ;==>_ScriptRestart