#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=instLiveCD.exe
#AutoIt3Wrapper_icon=instLiveCD.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=instLiveCD.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO
#NoTrayIcon
Global $Ini = @ScriptDir & '\instLiveCD.ini' ; путь к instLiveCD.ini
Global $gaDropFiles, $chars, $chars1, $chars2, $chars3, $chars4, $PathFiles, $charstext, $gaDropFiles1, $namefiles, $z, $chars000
$setldr=''
;Проверка существования instLiveCD.ini и атосоздание при отстутствии
$answerini = ""
If Not FileExists($Ini) Then $answerini = MsgBox(4, "Выгодное предложение", "Хотите создать необходимый instLiveCD.ini" & @CRLF & "для сохранения вводимых параметров?")
If $answerini = "6" Then
	IniWriteSection($Ini, "ldr", 'ntldr=PELDR' & @LF & 'bootfile=peldr.bin' & @LF & 'winnt=winnt.sif')
	IniWriteSection($Ini, "set", 'font=')
EndIf


;считываем instLiveCD.ini

$ntldr = IniRead($Ini, "ldr", "ntldr", "PELDR")
$bootfile = IniRead($Ini, "ldr", "bootfile", "peldr.bin")
$winnt = IniRead($Ini, "ldr", "winnt", "winnt.sif")
$font = IniRead($Ini, "set", "font", "")


; начало создания окна, вкладок, кнопок.
GUICreate("Установка LiveCD на HDD/Flash", 500, 220, -1, -1, -1, 0x00000010) ; размер окна
If $font <> "" Then GUISetFont($font)
$StatusBar = GUICtrlCreateLabel('Строка состояния', 44, 201, 450, 18)
GUICtrlSetTip(-1, "Показывает состояние процесса" & @CRLF & "и выполнение команд.")
$checkall = GUICtrlCreateCheckbox("", 20, 201, 17, 18)
GUICtrlSetTip(-1, "поставить/снять галки")
GuiCtrlSetState($checkall, 1)

$tab = GUICtrlCreateTab(0, 2, 500, 218-20) ; размер вкладки
$hTab = GUICtrlGetHandle($Tab) ; (1) строка определения хэндэла элемента (таба)

$tab3 = GUICtrlCreateTabitem("Boot") ; имя вкладки

GUICtrlCreateLabel("Шесть этапов установки", 150, 27, 180, 18)
GUICtrlSetColor(-1,0x0000ff)
GUICtrlSetFont (-1,10)
$Label80 = GUICtrlCreateLabel("Буква диска:", 296, 47, 80, 20)
$bykvadicka80 = GUICtrlCreateCombo("", 373, 43, 93, 18)
$DrivesArr = DriveGetDrive("all")
$list = ''
For $i = 1 To $DrivesArr[0]
	$DrTp = DriveGetType($DrivesArr[$i] & '\')
	If $DrTp = 'Removable' Then $DrTp = 'Rem'
	If $DrivesArr[$i] <> 'A:' And $DrTp <> 'CDROM' Then Assign('list', $list & '|' & StringUpper($DrivesArr[$i]) & ' (' & $DrTp & ')')
	If $DrivesArr[$i] = 'c:' Then $dr = $i
Next
GUICtrlSetData($bykvadicka80, $list, StringUpper($DrivesArr[$dr]) & ' (' & DriveGetType($DrivesArr[$dr] & '\') & ')')
$Label81 = GUICtrlCreateLabel("Имя NTLDR:", 296, 75, 80, 20)
GUICtrlSetTip(-1, "Имя прописывается в файл" & @CRLF & "загрузочного сектора")
$filename81 = GUICtrlCreateCombo("", 373, 71, 93, 18)
GUICtrlSetData(-1, $ntldr & '|PELDR|b1ldr|b2ldr|b3ldr', $ntldr)
$Label82 = GUICtrlCreateLabel("Имя файла:", 296, 103, 80, 20)
GUICtrlSetTip(-1, "Имя создаваемого файла" & @CRLF & "загрузочного сектора")
$filename82 = GUICtrlCreateCombo("", 373, 99, 93, 18)
GUICtrlSetData(-1, $bootfile & '|peldr.bin|b1.bin|b2.bin|b3.bin', $bootfile)

$Label82 = GUICtrlCreateLabel("Пункт в меню:", 296, 129, 80, 20)
GUICtrlSetTip(-1, "Пункт в загрузочном" & @CRLF & "меню boot.ini")
$tab8input = GUICtrlCreateInput("WinPE", 373, 127, 92, 20)

$Boot80 = GUICtrlCreateCheckbox("Сделать загрузочным (XP)", 20, 45, 250, 22)
GUICtrlSetTip(-1, "Сделать возможность загрузки WinXP," & @CRLF & "записав загрузочный сектор на указанный диск." & @CRLF & "Полезно флешку  сделать" & @CRLF & "загрузочной без форматирования")
$Boot81 = GUICtrlCreateCheckbox("Сектор в файл", 20, 65, 250, 22)
GUICtrlSetTip(-1, "Копировать загрузочный сектор" & @CRLF & "с указанного диска в файл")
$Boot82 = GUICtrlCreateCheckbox("Пункт в загрузкe", 20, 85, 250, 22)
GUICtrlSetTip(-1, "Добавить строку в меню загрузки boot.ini" & @CRLF & "для выбора загрузки при старте OS")
$Boot83 = GUICtrlCreateCheckbox("Создать winnt.sif", 20, 105, 250, 22)
GUICtrlSetTip(-1, "Создание необходимого файла" & @CRLF & "в котором укзан путь к WinPe.wim")
$Boot84 = GUICtrlCreateCheckbox("SETUPLDR.BIN, NTDETECT.COM в корень", 20, 125, 250, 22)
GUICtrlSetTip(-1, "Скопировать SETUPLDR.BIN" & @CRLF & "в корень диска С:")
$Boot85 = GUICtrlCreateCheckbox("WinPe.wim в Boot", 20, 145, 250, 22)
GUICtrlSetTip(-1, "Скопировать WinPe.wim" & @CRLF & "в C:\Boot")

GuiCtrlSetState($Boot80, 1)
GuiCtrlSetState($Boot81, 1)
GuiCtrlSetState($Boot82, 1)
GuiCtrlSetState($Boot83, 1)
GuiCtrlSetState($Boot84, 1)
GuiCtrlSetState($Boot85, 1)

$startboot89 = GUICtrlCreateButton("Выполнить", 373, 162, 92, 25)




$tab5 = GUICtrlCreateTabitem("Grub") ; имя вкладки
GUICtrlCreateLabel("Пять этапов установки", 150, 27, 180, 18)
GUICtrlSetColor(-1,0x0000ff)
GUICtrlSetFont (-1,10)
$Label90 = GUICtrlCreateLabel("Буква диска:", 296, 47, 80, 20)
$bykvadicka90 = GUICtrlCreateCombo("", 373, 43, 93, 18)
GUICtrlSetData($bykvadicka90, $list, StringUpper($DrivesArr[$dr]) & ' (' & DriveGetType($DrivesArr[$dr] & '\') & ')')

$Boot90 = GUICtrlCreateCheckbox("Сделать загрузочным (XP)", 20, 45, 250, 22)
GUICtrlSetTip(-1, "Сделать возможность загрузки WinXP," & @CRLF & "записав загрузочный сектор на указанный диск." & @CRLF & "Полезно флешку  сделать" & @CRLF & "загрузочной без форматирования")
$Boot91 = GUICtrlCreateCheckbox("Создание menu.lst и winnt.sif, копирование темы message33.gz", 20, 65, 350, 22)
GUICtrlSetTip(-1, "Меню пунктов загрузки menu.lst")
$Boot92 = GUICtrlCreateCheckbox("Переименование ntldr в ntldr.xp и копирование Grub", 20, 85, 310, 22)
GUICtrlSetTip(-1, "Откат заключается в обратном" & @CRLF & "переименовании ntldr.xp в ntldr" & @CRLF & "и удаление добавленных файлов" & @CRLF & "Копирование Grub в корень диска" & @CRLF & "с именем ntldr")
$Boot93 = GUICtrlCreateCheckbox("Копирование SETUPLDR.BIN и NTDETECT.COM", 20, 105, 310, 22)
GUICtrlSetTip(-1, "Скопировать SETUPLDR.BIN в С:\Boot\Bootldr")
$Boot94 = GUICtrlCreateCheckbox("WinPe.wim в Boot", 20, 125, 310, 22)
GUICtrlSetTip(-1, "Скопировать WinPe.wim" & @CRLF & "в C:\Boot")

GuiCtrlSetState($Boot90, 1)
GuiCtrlSetState($Boot91, 1)
GuiCtrlSetState($Boot92, 1)
GuiCtrlSetState($Boot93, 1)
GuiCtrlSetState($Boot94, 1)

$startboot99 = GUICtrlCreateButton("Выполнить", 373, 162, 92, 25)



$tab4 = GUICtrlCreateTabitem("LDR") ; имя вкладки
GUICtrlCreateLabel("", 2, 25, 496, 195)
GUICtrlSetState(-1,136)
$Label001=GUICtrlCreateLabel("Кинь сюда SETUPLDR.BIN, чтобы увидеть его параметры", 35, 33, 330, 20)
$readme=GUICtrlCreateButton ("readme", 154, 127, 48, 22)

; элементы первоначально создаются за пределами окна этой утилиты
$Label1=GUICtrlCreateLabel ('', 5,55,75,20)
$Label2=GUICtrlCreateLabel ('', 5,80,75,20)
$Label3=GUICtrlCreateLabel ('', 5,105,75,20)
$Label4=GUICtrlCreateLabel ('', 5,130,145,20)
$byfer1=GUICtrlCreateButton ("в буфер", 510,50,55,22)
$byfer2=GUICtrlCreateButton ("в буфер", 510,75,55,22)
$byfer3=GUICtrlCreateButton ("в буфер", 510,100,55,22)
$replace1=GUICtrlCreateButton ("заменить на", 510,50,75,72)
GUICtrlSetTip(-1, "Замена выполняется только"&@CRLF&"для заполненых полей ввода"&@CRLF&"и отмеченных чекбоксов")
$reinp1=GUICtrlCreateCombo ("", 510,50,105,22)
$reinp2=GUICtrlCreateCombo ("", 510,75,105,22)
GUICtrlSetData(-1,'|WINNT.SIF|WINNT.TXT|WINPE.SIF|256MB.SIF|I586\WN.S|BOOT\WN.S', '')
$reinp3=GUICtrlCreateCombo ("", 510,100,105,22)
GUICtrlSetData(-1,'|TXTSETUP.SIF|TXTSETNS.SIF|TXTSETAM.SIF', '')

$Label11=GUICtrlCreateLabel ('', 330,55,25,20)
GUICtrlSetTip(-1, "Количество замен")
$Label12=GUICtrlCreateLabel ('', 330,80,25,20)
GUICtrlSetTip(-1, "Количество замен")
$Label13=GUICtrlCreateLabel ('', 330,105,25,20)
GUICtrlSetTip(-1, "Количество замен")
$check1= GUICtrlCreateCheckbox("", 510,130,115,20)
$Label5=GUICtrlCreateLabel ('', 5,150,330,20)

$tab5 = GUICtrlCreateTabitem("    ?") ; имя вкладки
GUICtrlCreateLabel('В instLiveCD.ini можно указать параметры.'&@CRLF&'С вкладки "Boot" допустимо устанавливать только на WindowsXP. Рекомендуется устанавливать с вкладки Grub.'&@CRLF&'Чтобы выполнялась загрузка с харда/флешки нужно диск сделать активным диском в любом менджере дисков.'&@CRLF&'Этапы установки независимы, можно выбрать любое количество действий, выполнятся будут поочереди.'&@CRLF&'Необходимые утилите файлы: grldr, message33.gz, MKBT.EXE, NTDETECT.COM, RMBootSect.exe, SETUPLDR.BIN', 10, 30, 480, 160)
GUICtrlCreateLabel ('@AZJIO 20.03.2010', 395,175,100,18)

GUICtrlCreateTabitem("") ; конец вкладок

; (2) устранение проблем интерфейса, проверка OS, для установки нужного индекса
Switch @OSVersion
    Case 'WIN_2000', 'WIN_XP', 'WIN_2003'
        $Part = 10
    Case Else
        $Part = 11
EndSwitch
$Color = _WinAPI_GetThemeColor($hTab, 'TAB', $Part, 1, 0x0EED)
If Not @error Then
	; перечисление элементов, для которых нужно исправить проблему цвета
	$aVar = StringSplit( "Boot90|Boot91|Boot92|Boot93|Boot94|Boot80|Boot81|Boot82|Boot83|Boot84|Boot85", "|")
	For $i = 1 To $aVar[0]
    GUICtrlSetBkColor(Eval($aVar[$i])  , $Color)
	Next
    GUICtrlSetBkColor($check1 , $Color)
EndIf

GUISetState()

While 1
	$msg = GUIGetMsg()
	Select
		; установить/снять галки
		Case $msg = $checkall
			If GUICtrlRead($checkall)=1 Then
				For $i = 1 To $aVar[0]
					GuiCtrlSetState(Eval($aVar[$i]) , 1)
				Next
			Else
				For $i = 1 To $aVar[0]
					GuiCtrlSetState(Eval($aVar[$i]) , 4)
				Next
			EndIf
		; начало вкладки Boot
		Case $msg = $startboot89
			GUICtrlSetState($startboot89, 128)
			$bykvadicka081 = StringMid(GUICtrlRead($bykvadicka80), 1, 2)
			$nameldr = GUICtrlRead($filename81)
			$filename082 = GUICtrlRead($filename82)
			; Сделать загрузочным (XP)
			If GUICtrlRead($Boot80) = 1 Then
				RunWait(@Comspec & ' /C "' & @ScriptDir & '\RMBootSect.exe" /nt52 ' & $bykvadicka081, '', @SW_HIDE)
				GUICtrlSetData($StatusBar, 'Загрузочный сектор записан' & @CRLF & 'на диск ' & $bykvadicka081 & '.')
				GuiCtrlSetState($Boot80, 4)
			EndIf
			; Сектор в файл
			If GUICtrlRead($Boot81) = 1 Then
				If StringLen($nameldr)<>5 Then
					MsgBox(0, "Сообщение", $nameldr&@CRLF&"Требуется ввести 5 символов")
					GUICtrlSetState($startboot89, 64)
					ContinueLoop
				EndIf
				RunWait(@Comspec & ' /C "' & @ScriptDir & '\MKBT.EXE" -x -c ' & $bykvadicka081 & ' ' & $bykvadicka081 & '\tmp_' & $filename082, '', @SW_HIDE)
				$file0082 = FileOpen($bykvadicka081 & '\tmp_' & $filename082,16)
				If $file0082 = -1 Then
 				   MsgBox(0, "Ошибка", "Невозможно открыть файл.")
					GUICtrlSetState($startboot89, 64)
 				   ContinueLoop
 				EndIf
				$chars0082 = FileRead($file0082)
				If @error = -1 Then
  				  MsgBox(0, "Ошибка", "Невозможно прочитать файл.")
					GUICtrlSetState($startboot89, 64)
 				   ContinueLoop
				EndIf
				FileClose($file0082)
				
				$nameldrhex00 = StringMid(StringToBinary($nameldr), 3)
				$11 = StringMid($nameldrhex00, 1, 2)
				$22 = StringMid($nameldrhex00, 3, 2)
				$33 = StringMid($nameldrhex00, 5, 2)
				$44 = StringMid($nameldrhex00, 7, 2)
				$55 = StringMid($nameldrhex00, 9, 2)
				$nameldrhex01 = $11 & '00' & $22 & '00' & $33 & '00' & $44 & '00' & $55
				$chars0082 = StringRegExpReplace($chars0082, "4E0054004C00440052", $nameldrhex01)
				$file0082 = FileOpen($bykvadicka081 & '\' & $filename082,18)
				FileWrite($file0082,  $chars0082)
				FileClose($file0082)
				FileDelete ($bykvadicka081 & '\tmp_' & $filename082)
				IniWrite($Ini, "ldr", "ntldr", $nameldr)
				IniWrite($Ini, "ldr", "bootfile", $filename082)
				GUICtrlSetData($StatusBar, 'Файл загрузочного сектора ' & $bykvadicka081 & '\' & $filename082 & ' создан.')
				GuiCtrlSetState($Boot81, 4)
			EndIf
			; Пункт в загрузкe
			If GUICtrlRead($Boot82) = 1 Then
				$bootctroka = GUICtrlRead($tab8input)
				$bootini = MsgBox(4, "Выгодное предложение", "Хотите сделать бэкап boot.ini и посмотреть его," & @CRLF & "обновлённым для верности?" & @CRLF & "Атрибуты временно снимаются для правки.")
				If $bootini = "6" Then FileCopy($bykvadicka081 & '\boot.ini', $bykvadicka081 & '\boot.ini.BAK', 1)
				FileSetAttrib($bykvadicka081 & '\boot.ini', "-SHR")
				IniWrite($bykvadicka081 & '\boot.ini', "operating systems", 'C:\' & $filename082, '"' & $bootctroka & '"')
				GUICtrlSetData($StatusBar, 'Ожидание закрытия Блокнота')
				If $bootini = "6" Then RunWait('Notepad.exe ' & $bykvadicka081 & '\boot.ini')
				FileSetAttrib($bykvadicka081 & '\boot.ini', "+SHR")
				GUICtrlSetData($StatusBar, 'Строка загрузки в ' & $bykvadicka081 & '\boot.ini добавлена')
				GuiCtrlSetState($Boot82, 4)
			EndIf
			; Создать winnt.sif
			If GUICtrlRead($Boot83) = 1 Then
				If FileExists($bykvadicka081 & '\'&$winnt) Then
					If MsgBox(4, "Предупреждение", 'Хотите заменить' & @CRLF & 'существующий '&$winnt&'?') = "6" Then IniWriteSection($bykvadicka081 & '\'&$winnt, "SetupData", 'BootDevice="ramdisk(0)"' & @LF & 'BootPath="\i386\System32\"' & @LF & 'OsLoadOptions="/fastdetect /minint /rdimageoffset=8192 /rdimagelength=3161088 /rdpath=\boot\WinPe.wim"')
				Else
					IniWriteSection($bykvadicka081 & '\'&$winnt, "SetupData", 'BootDevice="ramdisk(0)"' & @LF & 'BootPath="\i386\System32\"' & @LF & 'OsLoadOptions="/fastdetect /minint /rdimageoffset=8192 /rdimagelength=3161088 /rdpath=\boot\WinPe.wim"')
				EndIf
				GuiCtrlSetState($Boot83, 4)
			EndIf
			; SETUPLDR.BIN, NTDETECT.COM в корень
			If GUICtrlRead($Boot84) = 1 Then
				If Not FileExists($bykvadicka081 & '\NTDETECT.COM') Then FileCopy(@ScriptDir & '\NTDETECT.COM', $bykvadicka081 & '\', 0)
				If not FileExists(@ScriptDir & '\SETUPLDR.BIN') Then
					MsgBox(0, "Мелкая ошибка", 'Отсутствует загрузчик ' & @ScriptDir & '\SETUPLDR.BIN')
					GUICtrlSetState($startboot89, 64)
					ContinueLoop
				EndIf
				If FileExists($bykvadicka081 & '\' & $nameldr) Then
					If MsgBox(4, "Предупреждение", "Хотите заменить" & @CRLF & "существующий файл?") = "6" Then
						FileCopy(@ScriptDir&'\SETUPLDR.BIN', $bykvadicka081&'\', 1)
						FileMove($bykvadicka081&'\SETUPLDR.BIN', $bykvadicka081&'\'&$nameldr, 9)
					EndIf
				Else
					FileCopy(@ScriptDir&'\SETUPLDR.BIN', $bykvadicka081&'\', 1)
					FileMove($bykvadicka081&'\SETUPLDR.BIN', $bykvadicka081&'\'&$nameldr, 9)
				EndIf
				GuiCtrlSetState($Boot84, 4)
			EndIf
			; WinPe.wim в Boot
			If GUICtrlRead($Boot85) = 1 Then
				$PathNameWim = FileOpenDialog("Выбор WinPe.wim.", @WorkingDir & "", "Образ диска (*.wim)", 1 + 4, 'WinPe.wim')
				If @error Then
					GUICtrlSetState($startboot89, 64)
					ContinueLoop
				EndIf
				GUICtrlSetData($StatusBar, 'Идёт копирование образа в ' & $bykvadicka081 & '\Boot\WinPe.wim')
				If FileExists($bykvadicka081 & '\Boot\WinPe.wim') Then
					If MsgBox(4, "Предупреждение", "Хотите заменить" & @CRLF & "существующий файл?") = "6" Then FileCopy($PathNameWim, $bykvadicka081 & '\Boot', 1)
				Else
					FileCopy($PathNameWim, $bykvadicka081 & '\Boot', 1)
				EndIf
				GUICtrlSetData($StatusBar, 'Готово! Копирование завершено.')
				GuiCtrlSetState($Boot85, 4)
			EndIf
			GUICtrlSetState($startboot89, 64)



; конец вкладки Boot, начало вкладки Grub ==============================
		Case $msg = $startboot99
			GUICtrlSetState($startboot99, 128)
			; Сделать загрузочным (XP)
			$bykvadicka081 = StringMid(GUICtrlRead($bykvadicka90), 1, 2)
			If GUICtrlRead($Boot90) = 1 Then
				RunWait(@Comspec & ' /C "' & @ScriptDir & '\RMBootSect.exe" /nt52 ' & $bykvadicka081, '', @SW_HIDE)
				GUICtrlSetData($StatusBar, 'Загрузочный сектор записан' & @CRLF & 'на диск ' & $bykvadicka081 & '.')
				GuiCtrlSetState($Boot90, 4)
			EndIf
			; Создание menu.lst и winnt.sif, копирование темы message33.gz
			If GUICtrlRead($Boot91) = 1 Then
				If FileExists($bykvadicka081 & '\menu.lst') Then
					If MsgBox(4, "Предупреждение", "Хотите заменить" & @CRLF & "существующий menu.lst?" & @CRLF & @CRLF & "иначе добавление" & @CRLF & "строк в текущий") = "6" Then FileDelete($bykvadicka081 & '\menu.lst')
				EndIf
				$file = FileOpen($bykvadicka081 & '\menu.lst', 1)
				; проверка открытия файла для записи строки
				If $file = -1 Then
					MsgBox(0, "Ошибка", "Не возможно открыть файл.")
					Exit
				EndIf
				FileWrite($file, @CRLF & @CRLF & _
				'timeout 3' & @CRLF & _
				'default 0' & @CRLF & _
				'gfxmenu /BOOT/Pictures/message33.gz' & @CRLF & _
				'#color white/light-gray   yellow/green' & @CRLF & _
				'color light-gray/black yellow/green light-cyan/black light-green/black' & @CRLF & _
				'#color  light-cyan/black   white/green' & @CRLF & @CRLF & _
				'title 0-Windows XP' & @CRLF & _
				'find --set-root /ntldr.xp' & @CRLF & _
				'chainloader /ntldr.xp' & @CRLF & @CRLF & _
				'title 1-Windows 7, Vista' & @CRLF & _
				'find --set-root /bootmgr' & @CRLF & _
				'chainloader /bootmgr' & @CRLF & @CRLF & _
				'title 2-WinPE-WIM' & @CRLF & _
				'find --set-root /Boot/Bootldr/SETUPLDR.BIN' & @CRLF & _
				'chainloader /Boot/Bootldr/SETUPLDR.BIN' & @CRLF & @CRLF)
				FileClose($file)
				If FileExists($bykvadicka081 & '\'&$winnt) Then
					If MsgBox(4, "Предупреждение", 'Хотите заменить' & @CRLF & 'существующий '&$winnt&'?') = "6" Then IniWriteSection($bykvadicka081 & '\'&$winnt, "SetupData", 'BootDevice="ramdisk(0)"' & @LF & 'BootPath="\i386\System32\"' & @LF & 'OsLoadOptions="/fastdetect /minint /rdimageoffset=8192 /rdimagelength=3161088 /rdpath=\boot\WinPe.wim"')
				Else
					IniWriteSection($bykvadicka081 & '\'&$winnt, "SetupData", 'BootDevice="ramdisk(0)"' & @LF & 'BootPath="\i386\System32\"' & @LF & 'OsLoadOptions="/fastdetect /minint /rdimageoffset=8192 /rdimagelength=3161088 /rdpath=\boot\WinPe.wim"')
				EndIf
				If FileExists($bykvadicka081 & '\BOOT\Pictures\message33.gz') Then
					If MsgBox(4, "Предупреждение", "Хотите заменить" & @CRLF & "существующий message33.gz?") = "6" Then FileCopy(@ScriptDir & '\message33.gz', $bykvadicka081 & '\BOOT\Pictures\message33.gz', 9)
				Else
					FileCopy(@ScriptDir & '\message33.gz', $bykvadicka081 & '\BOOT\Pictures\message33.gz', 9)
				EndIf
				GUICtrlSetData($StatusBar, 'Созданы menu.lst, '&$winnt&', message33.gz')
				GuiCtrlSetState($Boot91, 4)
			EndIf
			; Переименование ntldr в ntldr.xp и копирование Grub
			If GUICtrlRead($Boot92) = 1 Then
				If FileExists($bykvadicka081 & '\ntldr.xp') Then
					$answerWim = MsgBox(0, "Предупреждение", "Вы пытаетесь заменить существующий файл" & @CRLF & "ntldr.xp повторно. Эта операция не будет" & @CRLF & "выполнена.")
					GUICtrlSetState($startboot99, 64)
					ContinueLoop
				EndIf
				FileMove($bykvadicka081 & '\ntldr', $bykvadicka081 & '\ntldr.xp', 1)
				FileCopy(@ScriptDir & '\grldr', $bykvadicka081 & '\ntldr', 1)
				GUICtrlSetData($StatusBar, 'Переименование ntldr в ntldr.xp, grldr в ntldr, выполнено')
				GuiCtrlSetState($Boot92, 4)
			EndIf
			; Копирование SETUPLDR.BIN и NTDETECT.COM
			If GUICtrlRead($Boot93) = 1 Then
				If Not FileExists($bykvadicka081 & '\NTDETECT.COM') Then FileCopy(@ScriptDir & '\NTDETECT.COM', $bykvadicka081 & '\', 0)
				If not FileExists(@ScriptDir & '\SETUPLDR.BIN') Then
					MsgBox(0, "Мелкая ошибка", 'Отсутствует загрузчик ' & @ScriptDir & '\SETUPLDR.BIN')
					GUICtrlSetState($startboot99, 64)
					ContinueLoop
				EndIf
				If FileExists($bykvadicka081 & '\Boot\Bootldr\SETUPLDR.BIN') Then
					If MsgBox(4, "Предупреждение", "Хотите заменить" & @CRLF & "существующий файл?") = "6" Then
						FileCopy(@ScriptDir & '\SETUPLDR.BIN', $bykvadicka081 & '\Boot\Bootldr\', 9)
						$setldr=' SETUPLDR.BIN и '
					Else
						$setldr=' '
					EndIf
				Else
					FileCopy(@ScriptDir & '\SETUPLDR.BIN', $bykvadicka081 & '\Boot\Bootldr\', 9)
				EndIf
				GUICtrlSetData($StatusBar, 'Скопированы'&$setldr&'NTDETECT.COM')
				GuiCtrlSetState($Boot93, 4)
			EndIf
			; WinPe.wim в Boot
			If GUICtrlRead($Boot94) = 1 Then
				If Not FileExists($bykvadicka081 & '\Boot') Then DirCreate($bykvadicka081 & '\Boot')
				$PathNameWim = FileOpenDialog("Выбор WinPe.wim.", @WorkingDir & "", "Образ диска (*.wim)", 1 + 4, 'WinPe.wim')
				If @error Then
					GUICtrlSetState($startboot99, 64)
					ContinueLoop
				EndIf
				GUICtrlSetData($StatusBar, 'Идёт копирование образа в ' & $bykvadicka081 & '\Boot\WinPe.wim')
				If FileExists($bykvadicka081 & '\Boot\WinPe.wim') Then
					If MsgBox(4, "Предупреждение", "Хотите заменить" & @CRLF & "существующий файл?") = "6" Then FileCopy($PathNameWim, $bykvadicka081 & '\Boot', 1)
				Else
					FileCopy($PathNameWim, $bykvadicka081 & '\Boot', 1)
				EndIf
				GUICtrlSetData($StatusBar, 'Готово! Копирование завершено.')
				GuiCtrlSetState($Boot94, 4)
			EndIf
			GUICtrlSetState($startboot99, 64)
			
			
			
; Вкладка патча SETUPLDR.BIN
        Case $msg = $byfer1
            ClipPut($chars1)
            GUICtrlSetData($Label5, 'Скопировано в буфер '&$chars1)
        Case $msg = $byfer2
            ClipPut($chars2)
            GUICtrlSetData($Label5, 'Скопировано в буфер '&$chars2)
        Case $msg = $byfer3
            ClipPut($chars3)
            GUICtrlSetData($Label5, 'Скопировано в буфер '&$chars3)

; Выполнить замену
; ========================================================
        Case $msg = $replace1
			$reinp0=GUICtrlRead($reinp1)
			$reinp02=GUICtrlRead($reinp2)
			$reinp03=GUICtrlRead($reinp3)
				$err=''
				
			If StringLen($chars1)=4 Then
			
; условие для i386
			If $reinp0<>'' Then
			If StringLen($reinp0)=4 Then
				$reinp0 = StringTrimLeft(StringToBinary($reinp0), 2)
				$chars000=$chars1
				_regex()
				$chars = StringRegExpReplace($chars, $z&"(?=5C(53|73|6E|4E))", $reinp0)
				GUICtrlSetData($Label11, @extended)
				$err=0
			Else
				MsgBox(0, "Сообщение", $reinp0&@CRLF&"Требуется ввести 4 символа")
				$err=1
			EndIf
			EndIf
			
			Else
			
; условие для minint
			If $reinp0<>'' Then
			If StringLen($reinp0)=6 Then
				$reinp0 = StringTrimLeft(StringToBinary($reinp0), 2)
				$chars000=$chars1
				_regex()
				$chars = StringRegExpReplace($chars, $z&"(?=5C)", $reinp0)
				GUICtrlSetData($Label11, @extended)
				$err=0
			Else
				MsgBox(0, "Сообщение", $reinp0&@CRLF&"Требуется ввести 6 символов")
				$err=1
			EndIf
			EndIf
			
			EndIf

; условие для winnt.sif
			If $reinp02<>'' Then
			If StringLen($reinp02)=9 Then
				$reinp0 = StringTrimLeft(StringToBinary($reinp02), 2)
				$chars000=$chars2
				_regex()
				$chars = StringRegExpReplace($chars, $z, $reinp0)
				GUICtrlSetData($Label12, @extended)
				$err=0
			Else
				MsgBox(0, "Сообщение", $reinp02&@CRLF&"Требуется ввести 9 символов")
				$err=1
			EndIf
			EndIf

; условие для txtsetup.sif
			If $reinp03<>'' Then
			If StringLen($reinp03)=12 Then
				$reinp0 = StringTrimLeft(StringToBinary($reinp03), 2)
				$chars000=$chars3
				_regex()
				$chars = StringRegExpReplace($chars, $z, $reinp0)
				GUICtrlSetData($Label13, @extended)
				$err=0
			Else
				MsgBox(0, "Сообщение", $reinp03&@CRLF&"Требуется ввести 12 символов")
				$err=1
			EndIf
			EndIf

; условие для контроля оригинала EB1A 7403
			If $chars4='0xEB1A' and GUICtrlRead($check1)=1 Then $chars = StringRegExpReplace($chars, "EB1A(?=E9080039)", "7403")
			If $chars4='0x7403' and GUICtrlRead($check1)=1 Then $chars = StringRegExpReplace($chars, "7403(?=E9080039)", "EB1A")
			
; ========================================================
			If $err<>1 Then
; генерируем имя нового файла с приставкой new и номером копии на случай если файл существует
			For $i=1 To 200
			   If Not FileExists($namefiles[0]&'\new'&$i&'_'&$namefiles[1]) Then
			      $newfile=$namefiles[0]&'\new'&$i&'_'&$namefiles[1]
			      ExitLoop
			   EndIf
			Next
; Открываем файл в бинарном виде, записываем данные, закрываем с сохранением.
			$file1 = FileOpen($newfile,18)
			FileWrite($file1,  $chars)
			FileClose($file1)
			EndIf

            $newfileL=StringRegExp($newfile, "(^.*)\\(.*)$", 3)
            GUICtrlSetData($Label5, 'Проверте "'&$newfileL[1]&'", перетащив в это окно')
        Case $msg = -13
                AddDropedFiles(@GUI_DRAGFILE)
        Case $msg = $readme
                MsgBox(0, "Readme", 'Поддерживаемые загрузчики:'&@CRLF&'247024 (241кб) SP1 многоядерность на флешке'&@CRLF&'261376 (255кб) SP2 одноядерный (например Alkid)'&@CRLF&'298096 (291кб) IMG-одноядерный'&@CRLF&'302192 (295кб) IMG многоядерный'&@CRLF&'314480 (307кб) WIM'&@CRLF&'318576 (311кб) WIM-мультиядерный'&@CRLF&'322672 (315кб) WIM-мультиядер, мультитом'&@CRLF&'366172 (357кб) WIM-мультиядер, мультитом с NTDETECT.COM'&@CRLF&@CRLF&'282112 (275кб) IMG-мультиядерный, для сети (PXELDR)'&@CRLF&'298496 (291кб) WIM-мультиядерный, для сети (PXELDR)'&@CRLF&'346092 (337кб) WIM-мультиядерный, для сети (PXELDR)'&@CRLF&@CRLF&'7403 > EB1A - избавиться от сообщения "NTLDR corrupt"')
		Case $msg = -3
			Exit
	EndSelect
WEnd


; (3) устранение проблем интерфейса, обязательные три (сократил до одной) функции, скопированные из WinAPIEx.au3 ("Global $__RGB = True" - уже не нужен)
Func _WinAPI_GetThemeColor($hWnd, $sClass, $iPart, $iState, $iProp)
	Local $hTheme = DllCall('uxtheme.dll', 'ptr', 'OpenThemeData', 'hwnd', $hWnd, 'wstr', $sClass)
	Local $Ret = DllCall('uxtheme.dll', 'lresult', 'GetThemeColor', 'ptr', $hTheme[0], 'int', $iPart, 'int', $iState, 'int', $iProp, 'dword*', 0)

	If(@error) Or($Ret[0] < 0) Then
		$Ret = -1
	EndIf
	DllCall('uxtheme.dll', 'lresult', 'CloseThemeData', 'ptr', $hTheme[0])
	If $Ret = -1 Then
		Return SetError(1, 0, -1)
	EndIf
	Return SetError(0, 0, BitOR(BitAND($Ret[5], 0x00FF00), BitShift(BitAND($Ret[5], 0x0000FF), -16), BitShift(BitAND($Ret[5], 0xFF0000), 16)))
EndFunc   ;==>_WinAPI_GetThemeColor


; функция для файлов брошенных в окно программы
;=============================================================
Func AddDropedFiles($gaDropFiles)
$PathFiles=$gaDropFiles
$namefiles=StringRegExp($gaDropFiles, "(^.*)\\(.*)$", 3)
$gaDropFiles1=FileGetSize ( $gaDropFiles )
If $gaDropFiles1 > 1000000 Then
    MsgBox(0, "Ошибка", "Файл великоват для загрузчика.")
    Return
EndIf

GUICtrlSetData($Label5, '')
; условие для зарегистрированных загрузчиков с известными размерами
If $gaDropFiles1=298096 Or $gaDropFiles1=302192 Or $gaDropFiles1=314480 Or $gaDropFiles1=318576 Or $gaDropFiles1=261376 Or $gaDropFiles1=247024 Or $gaDropFiles1=366172 Or $gaDropFiles1=322672 Or $gaDropFiles1=346092 Or $gaDropFiles1=298496 Or $gaDropFiles1=282112 Then
$file = FileOpen($gaDropFiles,16)

If $file = -1 Then
    MsgBox(0, "Ошибка", "Невозможно открыть файл.")
    Exit
 EndIf

$chars = FileRead($file)
If @error = -1 Then
    MsgBox(0, "Ошибка", "Невозможно прочитать файл.")
    Exit
 EndIf

; взависимости от размера, файлы группируются по типам и для разных типов разное смещение патернов (образцов текста)
If $gaDropFiles1=298096 Or $gaDropFiles1=302192 Or $gaDropFiles1=314480 Or $gaDropFiles1=318576 Or $gaDropFiles1=366172 Or $gaDropFiles1=322672 Then
	   $chars1 = BinaryToString(BinaryMid($chars, 191850, 4))
	   $chars2 = BinaryToString(BinaryMid($chars, 172887, 9))
	   $chars3 = BinaryToString(BinaryMid($chars, 173315, 12))
	   GUICtrlSetData($reinp1,'|I386|A386|B386|L386|N386|R386|S386|X386|I486|I586|VAPE|LVCD|BOOT', '')
	   $chars4 = BinaryMid($chars, 8289, 2)
EndIf
If $gaDropFiles1=261376 Then
	   $chars1 = BinaryToString(BinaryMid($chars, 140924, 6))
	   $chars2 = BinaryToString(BinaryMid($chars, 140643, 9))
	   $chars3 = BinaryToString(BinaryMid($chars, 140903, 12))
	   GUICtrlSetData($reinp1,'|MININT|MININ_|MININ1|MININ2|MININ3|MININ4|MININ5', '')
	   $chars4 = ''
EndIf
If $gaDropFiles1=247024 Then
	   $chars1 = BinaryToString(BinaryMid($chars, 132812, 6))
	   $chars2 = BinaryToString(BinaryMid($chars, 132531, 9))
	   $chars3 = BinaryToString(BinaryMid($chars, 132791, 12))
	   GUICtrlSetData($reinp1,'|MININT|MININ_|MININ1|MININ2|MININ3|MININ4|MININ5', '')
	   $chars4 = ''
EndIf
If $gaDropFiles1=346092 Or $gaDropFiles1=298496 Or $gaDropFiles1=282112 Then
	   $chars1 = BinaryToString(BinaryMid($chars, 171770, 4))
	   $chars2 = BinaryToString(BinaryMid($chars, 152807, 9))
	   $chars3 = BinaryToString(BinaryMid($chars, 153235, 12))
	   GUICtrlSetData($reinp1,'|I386|A386|B386|L386|N386|R386|S386|X386|I486|I586|VAPE|LVCD|BOOT', '')
	   $chars4 = ''
EndIf

FileClose($file)
_butcr()

Else
    $answer = MsgBox(4, "Сообщение", 'Неизвестный утилите файл. '&@CRLF&'Прочитать его как для WIM?'&@CRLF&'Если имена будут валидными'&@CRLF&'то патчить допустимо.')
	If $answer = "6" Then
	$file = FileOpen($gaDropFiles,16)

If $file = -1 Then
    MsgBox(0, "Ошибка", "Невозможно открыть файл.")
    Exit
 EndIf

$chars = FileRead($file)
If @error = -1 Then
    MsgBox(0, "Ошибка", "Невозможно прочитать файл.")
    Exit
 EndIf
 
	   $chars1 = BinaryToString(BinaryMid($chars, 191850, 4))
	   $chars2 = BinaryToString(BinaryMid($chars, 172887, 9))
	   $chars3 = BinaryToString(BinaryMid($chars, 173315, 12))
	   GUICtrlSetData($reinp1,'|I386|A386|B386|L386|N386|R386|S386|X386|I486|I586|VAPE|LVCD|BOOT', '')
	   $chars4 = BinaryMid($chars, 8289, 2)
FileClose($file)
	   _butcr()
	EndIf
EndIf
EndFunc

; Функция создания шаблона для регулярного выражения
;=============================================================
Func _regex()
$a = StringSplit(StringLower($chars000), "")
$B = StringSplit(StringUpper($chars000), "")
$z = ''
; создаём шаблон ($z) для регулярного выражения
			For $i=1 To $a[0]
			   If $a[$i]==$B[$i] Then
				$z&=Hex(Asc($a[$i]), 2)
			  Else
				$z&='('&Hex(Asc($a[$i]), 2)&'|'&Hex(Asc($B[$i]), 2)&')'
			  EndIf
			Next
EndFunc

; Функция создания кнопок
;=============================================================
Func _butcr()
; отобразим все элементы (кнопки, раскрывающиеся списки, тексты) при получении файла
GUICtrlSetData($Label1, $chars1)
GUICtrlSetData($Label2, $chars2)
GUICtrlSetData($Label3, $chars3)
GUICtrlSetData($Label4, 'Размер: '&$gaDropFiles1&' байт, '&Round($gaDropFiles1/1024, 0)&'кб')
GUICtrlSetPos($byfer1, 80,50)
GUICtrlSetPos($byfer2, 80,75)
GUICtrlSetPos($byfer3, 80,100)
GUICtrlSetPos($replace1, 140,50)
GUICtrlSetPos($reinp1, 220,50)
GUICtrlSetPos($reinp2, 220,75)
GUICtrlSetPos($reinp3, 220,100)
GUICtrlSetData($Label001, 'Файл "'&$namefiles[1]&'" получен.')
GUICtrlSetData($Label11, '0')
GUICtrlSetData($Label12, '0')
GUICtrlSetData($Label13, '0')


If $chars4='0xEB1A' Then
GUICtrlSetPos($check1, 220,130)
GUICtrlSetData($check1, "Прописать 74 03")
GUICtrlSetState($check1, 4)
GUICtrlSetTip($check1, "Не рекомендуется")
EndIf

If $chars4='0x7403' Then
GUICtrlSetPos($check1, 220,130)
GUICtrlSetData($check1, "Прописать EB 1A")
GUICtrlSetState($check1, 1)
GUICtrlSetTip($check1, "Рекомендуется")
EndIf

If $chars4<>'0x7403' and $chars4<>'0xEB1A' Then GUICtrlSetPos($check1, 510,130)

EndFunc
