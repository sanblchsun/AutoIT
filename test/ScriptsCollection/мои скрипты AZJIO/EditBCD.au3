#include <GUIConstants.au3>
#include <WindowsConstants.au3> 
#include <Encoding.au3> 

#NoTrayIcon
Opt("GUIResizeMode", 802)
Opt("GUIOnEventMode", 1)

Global $FileBCD, $ContentBCDBCD, $Combo0, $PathBcdEdit=@ScriptDir&'\Bcdedit.exe', $TrAll='active', $TrVnd=''
If Not FileExists($PathBcdEdit) Then
	$PathBcdEdit=@SystemDir&'\Bcdedit.exe'
	If Not FileExists($PathBcdEdit) Then
		MsgBox(0, 'Сообщение', 'Не найден файл Bcdedit.exe. Он необходим в папке программы или в System32')
		Exit
	EndIf
EndIf

$Gui=GUICreate('EditBCD', 670, 560, -1, -1, $WS_OVERLAPPEDWINDOW, $WS_EX_ACCEPTFILES)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
GUISetOnEvent($GUI_EVENT_DROPPED, "_Dropped")
$CatchDrop = GUICtrlCreateLabel("", 0, 0, 670, 560)
GUICtrlSetState(-1, $GUI_DISABLE + $GUI_DROPACCEPTED)


GUICtrlCreateLabel('Элемент редактирования:', 10, 13, 136, 17)
$hCombo=GUICtrlCreateCombo('', 146,10, 260, 23, 0x3)
GUICtrlSetOnEvent(-1, "_SelectItem")

GUICtrlCreateLabel('Команды :', 10, 43, 56, 17)
$hComList=GUICtrlCreateCombo('', 66,40, 340)

$Edit=GUICtrlCreateEdit('', 10, 70, 530, 560-100)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 64)

$ClipBoard=GUICtrlCreateButton('Копировать', 410, 10, 70, 22)
GUICtrlSetOnEvent(-1, "_ClipBoard")
GUICtrlSetTip(-1, 'Копировать ID'&@CRLF&'в буфер обмена')

$Open=GUICtrlCreateButton('...', 490, 10, 26, 23)
GUICtrlSetOnEvent(-1, "_OpenBCD")
GUICtrlSetTip(-1, 'Открыть файл'&@CRLF&'загрузочного меню BCD')
GUICtrlSetFont(-1, 16)

$Execute=GUICtrlCreateButton('Выполнить', 410, 40, 70, 22)
GUICtrlSetOnEvent(-1, "_Execute")
GUICtrlSetTip(-1, 'Выполнить команду')

$Delete=GUICtrlCreateButton('Удалить пункт', 560, 10, 100, 22)
GUICtrlSetOnEvent(-1, "_Delete")
GUICtrlSetTip(-1, 'Удалить пункт'&@CRLF&'загрузочного меню')
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$Checks=GUICtrlCreateButton('Checks', 560, 40, 100, 22)
GUICtrlSetOnEvent(-1, "_Checks")
GUICtrlSetTip(-1, 'Отключить проверку контрольной'&@CRLF&'суммы загрузочного файла (для bootmgr)')
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$hDescription=GUICtrlCreateButton('Название', 560, 70, 100, 22)
GUICtrlSetOnEvent(-1, "_Description")
GUICtrlSetTip(-1, 'Изменить название пункта'&@CRLF&'загрузочного меню')
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$hDefault=GUICtrlCreateButton('По умолчанию', 560, 100, 100, 22)
GUICtrlSetOnEvent(-1, "_Default")
GUICtrlSetTip(-1, 'Установить пункт загрузочным'&@CRLF&'по умолчанию')
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$hAddfirst=GUICtrlCreateButton('Первым', 560, 130, 100, 22)
GUICtrlSetOnEvent(-1, "_Addfirst")
GUICtrlSetTip(-1, 'Переместить пункт'&@CRLF&'в начало списка')
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$hAddlast=GUICtrlCreateButton('Последним', 560, 160, 100, 22)
GUICtrlSetOnEvent(-1, "_Addlast")
GUICtrlSetTip(-1, 'Переместить пункт'&@CRLF&'в конец списка')
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$hTimeout=GUICtrlCreateButton('Таймер', 560, 190, 100, 22)
GUICtrlSetOnEvent(-1, "_Timeout")
GUICtrlSetTip(-1, 'Установить время'&@CRLF&'ожидания выбора')
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$hDeleteValue=GUICtrlCreateButton('Удалить парам.', 560, 220, 100, 22)
GUICtrlSetOnEvent(-1, "_DeleteValue")
GUICtrlSetTip(-1, 'Удалить параметр'&@CRLF&'из пункта загрузки')
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$hCreate=GUICtrlCreateButton('WindowsXP', 560, 250, 100, 22)
GUICtrlSetOnEvent(-1, "_WindowsXP")
GUICtrlSetTip(-1, 'Создать пункт меню WindowsXP')
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$hCreate=GUICtrlCreateButton('boot.wim', 560, 280, 100, 22)
GUICtrlSetOnEvent(-1, "_BOOT_WIM")
GUICtrlSetTip(-1, 'Создать пункт меню WindowsXP')
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$hCreate=GUICtrlCreateButton('Создать пункт', 560, 310, 100, 22)
GUICtrlSetOnEvent(-1, "_Create")
GUICtrlSetTip(-1, 'Создать пункт меню')
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$hGrub4dos=GUICtrlCreateButton('Grub4dos', 560, 340, 100, 22)
GUICtrlSetOnEvent(-1, "_Grub4dos")
GUICtrlSetTip(-1, 'Создать пункт меню Grub4dos'&@CRLF&'требуется grldr.mbr')
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$hAllList=GUICtrlCreateCheckbox('all', 560, 470, 100, 17)
GUICtrlSetOnEvent(-1, "_AllList")
GUICtrlSetTip(-1, 'Показать все записи')
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$hVnd=GUICtrlCreateCheckbox('/v', 560, 490, 100, 17)
GUICtrlSetOnEvent(-1, "_Vnd")
GUICtrlSetTip(-1, 'Показать идентификатор')
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$StatusBar=GUICtrlCreateLabel('StatusBar', 5, 560-20, 580, 17)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUICtrlSetResizing(-1,  2 + 64 + 256 + 512)
GUISetState ()

While 1
	Sleep(100000)
WEnd

Func _SelectItem()
	$Combo0=GUICtrlRead($hCombo)
	_SetComList($Combo0)
EndFunc

Func _SetComList($GUID)
GUICtrlSendMsg($hComList, 0x14B, 0, 0)
GUICtrlSetData($hComList, _
'-set {bootmgr} timeout 3|'& _
'-DeleteValue {bootmgr} nointegritychecks|'& _
'-set {bootmgr} nointegritychecks yes|'& _
'-set {bootmgr} nointegritychecks no|'& _
'-displayorder {'&$GUID&'} -addfirst|'& _
'-displayorder {'&$GUID&'} -addlast|'& _
'-set {'&$GUID&'} description name|'& _
'-set {'&$GUID&'} device partition=C:|'& _
'-set {'&$GUID&'} device partition=boot|'& _
'-set {ntldr} path \ntldr|'& _
'set {ntldr} systemroot \windows|'& _
'-create {ntldr} /d "NameOS"|'& _
'-create /d "NameOS" -application osloader|'& _
'-create /d "NameOS')
EndFunc

Func _OpenBCD()
	$OpenFile = FileOpenDialog('Открыть', @WorkingDir , 'Файл загрузочного меню BCD (BC*)', 3, '', $Gui)
	If @error Then Return
	$FileBCD=$OpenFile
	GUICtrlSetData($StatusBar, $FileBCD)
	WinSetTitle($Gui, '', 'EditBCD - '&$FileBCD)
	_View($FileBCD)
EndFunc

Func _Dropped()
	$FileBCD=@GUI_DRAGFILE
	GUICtrlSetData($StatusBar, $FileBCD)
	WinSetTitle($Gui, '', 'EditBCD - '&$FileBCD)
	_View($FileBCD)
EndFunc

; удалить, проблемно работает, не отображает добавленый пункт ни в какую.
Func _Create()
	Local $Name, $hRun, $tmp, $line
	$Name=InputBox('Название пункта', 'Введите название пункта, которое будет создано', '', '', 170, 160)
	If $Name = '' Then Return
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" -create /d "'&$Name&'" -application osloader', '', @SW_HIDE, 2)
	$tmp=''
	While 1
		$line = StdoutRead($hRun)
		If @error Then ExitLoop
		$tmp &= $line
	Wend
	If $tmp = '' Then Return
	$tmp=StringStripWS(StringRegExpReplace($tmp, '(?:.*?)({.*?})(?:.*)', '\1'), 8)
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" /displayorder '&$tmp&' -addlast', '', @SW_HIDE, 2)
	_StdoutRead($hRun)
EndFunc

Func _BOOT_WIM2()
	Local $Name, $hRun
	$Name=InputBox('Название пункта', 'Введите название пункта, которое будет создано', 'Boot from BOOT.WIM', '', 170, 160)
	If $Name = '' Then Return
	; Создаём опции для загрузки из BOOT.WIM
	$hRun = RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /create /d "ramdisk options" -device', '', @SW_HIDE, 2)
	$tmp=''
	While 1
		$line = StdoutRead($hRun)
		If @error Then ExitLoop
		$tmp &= $line
	Wend
	MsgBox(0, 'tmp', $tmp)
	If $tmp = '' Then Return
	$RamGuid=StringStripWS(StringRegExpReplace($tmp, '(?:.*?)({.*?})(?:.*)', '\1'), 8) ; получили GUID
	MsgBox(0, 'RamGuid', $RamGuid)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /create '&$RamGuid&' /d "ramdisk options"', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$RamGuid&' ramdisksdidevice partition=boot', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$RamGuid&' ramdisksdipath \boot\boot.sdi', '', @SW_HIDE)
	; создаём пункт загрузки
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" /create /d "'&$Name&'" /application osloader', '', @SW_HIDE, 2)
	$tmp=''
	While 1
		$line = StdoutRead($hRun)
		If @error Then ExitLoop
		$tmp &= $line
	Wend
	If $tmp = '' Then Return
	$tmp=StringStripWS(StringRegExpReplace($tmp, '(?:.*?)({.*?})(?:.*)', '\1'), 8) ; получили GUID
	MsgBox(0, 'tmp', $tmp)
	
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' device ramdisk=[boot]\boot\boot.wim,'&$RamGuid, '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' path \windows\system32\boot\winload.exe', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' osdevice ramdisk=[boot]\boot\boot.wim,'&$RamGuid, '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' systemroot \Windows', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' winpe yes', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' detecthal yes', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' ems yes', '', @SW_HIDE)
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" /displayorder '&$tmp&' -addlast', '', @SW_HIDE, 2)
	_StdoutRead($hRun)
EndFunc

Func _BOOT_WIM()
	Local $Name, $hRun, $tmp
	$Name=InputBox('Название пункта', 'Введите название пункта, которое будет создано', 'Boot from BOOT.WIM', '', 170, 160)
	If $Name = '' Then Return
	; Создаём опции для загрузки из BOOT.WIM
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /create {ramdiskoptions} /d "ramdisk options"', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set {ramdiskoptions} ramdisksdidevice partition=boot', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set {ramdiskoptions} ramdisksdipath \boot\boot.sdi', '', @SW_HIDE)
	; создаём пункт загрузки
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" /create /d "'&$Name&'" /application osloader', '', @SW_HIDE, 2)
	$tmp=''
	While 1
		$line = StdoutRead($hRun)
		If @error Then ExitLoop
		$tmp &= $line
	Wend
	If $tmp = '' Then Return
	$tmp=StringStripWS(StringRegExpReplace($tmp, '(?:.*?)({.*?})(?:.*)', '\1'), 8) ; получили GUID
	
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' device ramdisk=[boot]\boot\boot.wim,{ramdiskoptions}', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' path \windows\system32\boot\winload.exe', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' osdevice ramdisk=[boot]\boot\boot.wim,{ramdiskoptions}', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' systemroot \Windows', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' winpe yes', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' detecthal yes', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' ems yes', '', @SW_HIDE)
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" /displayorder '&$tmp&' -addlast', '', @SW_HIDE, 2)
	_StdoutRead($hRun)
EndFunc

Func _BOOT_WIM0()
	Local $Name, $hRun, $tmp
	$Name=InputBox('Название пункта', 'Введите название пункта, которое будет создано', 'Boot from BOOT.WIM', '', 170, 160)
	If $Name = '' Then Return
	; Создаём опции для загрузки из BOOT.WIM
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" /create /d "'&$Name&' r" /d "ramdisk options"', '', @SW_HIDE, 2)
	$tmp=''
	While 1
		$line = StdoutRead($hRun)
		If @error Then ExitLoop
		$tmp &= $line
	Wend
	If $tmp = '' Then Return
	$tmp=StringStripWS(StringRegExpReplace($tmp, '(?:.*?)({.*?})(?:.*)', '\1'), 8) ; получили GUID
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' ramdisksdidevice partition=boot', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' ramdisksdipath \boot\boot.sdi', '', @SW_HIDE)
	; создаём пункт загрузки
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" /create /d "'&$Name&'" /application osloader', '', @SW_HIDE, 2)
	$tmp=''
	While 1
		$line = StdoutRead($hRun)
		If @error Then ExitLoop
		$tmp &= $line
	Wend
	If $tmp = '' Then Return
	$tmp=StringStripWS(StringRegExpReplace($tmp, '(?:.*?)({.*?})(?:.*)', '\1'), 8) ; получили GUID
	
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' device ramdisk=[boot]\boot\boot.wim,{ramdiskoptions}', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' path \windows\system32\boot\winload.exe', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' osdevice ramdisk=[boot]\boot\boot.wim,{ramdiskoptions}', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' systemroot \Windows', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' winpe yes', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' detecthal yes', '', @SW_HIDE)
	RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' ems yes', '', @SW_HIDE)
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" /displayorder '&$tmp&' -addlast', '', @SW_HIDE, 2)
	_StdoutRead($hRun)
EndFunc

Func _WindowsXP()
	Local $Name, $hRun
	$Name=InputBox('Название пункта', 'Введите название пункта, которое будет создано', 'Windows XP', '', 170, 160)
	If $Name = '' Then Return
	; $hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" /create {ntldr} /d '&$Name&' /application osloader', '', @SW_HIDE, 2)
	$hRun = RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /create {ntldr} /d "'&$Name&'"', '', @SW_HIDE)
	$hRun = RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set {ntldr} device partition=C:', '', @SW_HIDE)
	$hRun = RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set {ntldr} path \ntldr', '', @SW_HIDE)
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" /displayorder {ntldr} -addlast', '', @SW_HIDE, 2)
	_StdoutRead($hRun)
EndFunc

Func _Grub4dos()
	Local $Name, $hRun, $tmp
	$Name=InputBox('Название пункта', 'Введите название пункта, которое будет создано', 'Start Grub4dos', '', 170, 160)
	If $Name = '' Then Return
	; создаём пункт загрузки
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" /create /d "'&$Name&'" /application bootsector', '', @SW_HIDE, 2)
	$tmp=''
	While 1
		$line = StdoutRead($hRun)
		If @error Then ExitLoop
		$tmp &= $line
	Wend
	If $tmp = '' Then Return
	$tmp=StringStripWS(StringRegExpReplace($tmp, '(?:.*?)({.*?})(?:.*)', '\1'), 8) ; получили GUID
	$hRun = RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' device boot', '', @SW_HIDE)
	$hRun = RunWait($PathBcdEdit&' /store "'&$FileBCD&'" /set '&$tmp&' path \grldr.mbr', '', @SW_HIDE)
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" /displayorder '&$tmp&' /addlast', '', @SW_HIDE, 2)
	_StdoutRead($hRun)
EndFunc

Func _ClipBoard()
	ClipPut(GUICtrlRead($hCombo))
EndFunc

Func _Execute()
	Local $Value, $hRun
	$hComList0=GUICtrlRead($hComList)
	If $hComList0 = '' Then Return
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" '&$hComList0, '', @SW_HIDE, 2)
	_StdoutRead($hRun)
EndFunc

Func _DeleteValue()
	Local $Value, $hRun
	$Combo0=GUICtrlRead($hCombo)
	$Value=InputBox('Название параметра', 'Введите название параметра, которое необходимо удалить', '', '', 170, 160)
	If $Value = '' Then Return
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" /DeleteValue {'&$Combo0&'} '&$Value, '', @SW_HIDE, 2)
	_StdoutRead($hRun)
EndFunc

Func _Timeout()
	Local $hRun, $timeout
	$Combo0=GUICtrlRead($hCombo)
	$timeout=InputBox('Таймер', 'Время ожидания выбора в секундах. Необходимо ввести только целое положительное число.', '', '', 170, 170)
	If $timeout<>'' Then
		$timeout=Number($timeout)
	Else
		Return
	EndIf
	If Not(IsInt($timeout) And $timeout>=0) Then
		MsgBox(0, 'Сообщение', 'Необходимо ввести только целое полочительное число')
		Return
	EndIf
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" -set {bootmgr} timeout '&$timeout, '', @SW_HIDE, 2)
	_StdoutRead($hRun)
EndFunc

Func _Addfirst()
	$Combo0=GUICtrlRead($hCombo)
	Local $hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" -displayorder {'&$Combo0&'} -addfirst', '', @SW_HIDE, 2)
	_StdoutRead($hRun)
EndFunc

Func _Addlast()
	$Combo0=GUICtrlRead($hCombo)
	Local $hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" -displayorder {'&$Combo0&'} -addlast', '', @SW_HIDE, 2)
	_StdoutRead($hRun)
EndFunc

Func _Default()
	$Combo0=GUICtrlRead($hCombo)
	Local $hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" -default {'&$Combo0&'}', '', @SW_HIDE, 2)
	_StdoutRead($hRun)
EndFunc

Func _Description()
	Local $hRun, $description
	$Combo0=GUICtrlRead($hCombo)
	$description=InputBox('Имя пункта', 'Введите название пункта, которое отображается при загрузке в меню выбора.', '', '', 170, 160)
	If $description = '' Then Return
	$hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" -set {'&$Combo0&'} description '&$description, '', @SW_HIDE, 2)
	_StdoutRead($hRun)
EndFunc

Func _Checks()
	$Combo0=GUICtrlRead($hCombo)
	Local $hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" -set {'&$Combo0&'} nointegritychecks yes', '', @SW_HIDE, 2)
	_StdoutRead($hRun)
EndFunc

Func _Delete()
	$Combo0=GUICtrlRead($hCombo)
	Local $hRun = Run($PathBcdEdit&' /store "'&$FileBCD&'" -delete {'&$Combo0&'} /cleanup /f', '', @SW_HIDE, 2)
	_StdoutRead($hRun)
EndFunc

Func _StdoutRead($hRun)
	Local $tmp, $line
	$tmp=''
	While 1
		$line = StdoutRead($hRun)
		If @error Then ExitLoop
		$tmp &= $line
	Wend
	GUICtrlSetData($StatusBar, _Encoding_866To1251($tmp))
	_View($FileBCD)
EndFunc

Func _AllList()
	If GUICtrlRead($hAllList)=1 Then
		$TrAll='all'
	Else
		$TrAll='active'
	EndIf
	_View($FileBCD)
EndFunc

Func _Vnd()
	If GUICtrlRead($hVnd)=1 Then
		$TrVnd=' /v'
	Else
		$TrVnd=''
	EndIf
	_View($FileBCD)
EndFunc

Func _View($File)
	Local $ContentBCD, $hRun, $line
	$hRun = Run($PathBcdEdit&' /store "'&$File&'" /enum '&$TrAll&$TrVnd, '', @SW_HIDE, 2)
	$ContentBCD=''
	While 1
		$line = StdoutRead($hRun)
		If @error Then ExitLoop
		$ContentBCD &= $line
	Wend
	GUICtrlSetData($Edit, _Encoding_866To1251($ContentBCD))
	
	GUICtrlSendMsg($hCombo, 0x14B, 0, 0)
	$aCombo=StringRegExp($ContentBCD, 'identifier\h+\{(.*?)\}', 3)
	If Not @error Then
		$Combo=''
		For $i = 0 to UBound($aCombo)-1
			$Combo&='|'&$aCombo[$i]
		Next
		If $Combo0 <> '' And StringInStr($Combo&'|', '|'&$Combo0&'|') Then
			$tmp=$Combo0
		Else
			$tmp = StringRegExpReplace($Combo, '^\|(.*?)\|.*', '\1')
			If StringLeft($tmp, 1)='|' Then $tmp =StringTrimLeft($tmp, 1)
		EndIf
		GUICtrlSetData($hCombo, $Combo, $tmp)
		_SetComList($tmp)
	EndIf
EndFunc

Func _Exit()
	Exit
EndFunc

; оказалось конвертирование не нужно
Func _Encoding_1251To866($sString)
	Local $sResult = "", $iCode
	Local $Var866Arr = StringSplit($sString, "")

	For $i = 1 To $Var866Arr[0]
		$iCode = Asc($Var866Arr[$i])

		Select
			Case $iCode >= 192 And $iCode <= 239
				$Var866Arr[$i] = Chr($iCode - 64)
			Case $iCode >= 240 And $iCode <= 255
				$Var866Arr[$i] = Chr($iCode - 16)
			Case $iCode = 168
				$Var866Arr[$i] = Chr(240)
			Case $iCode = 184
				$Var866Arr[$i] = Chr(241)
			Case $iCode = 185
				$Var866Arr[$i] = Chr(252)
		EndSelect

		$sResult &= $Var866Arr[$i]
	Next

	Return $sResult
EndFunc   ;==>_Encoding_1251To866