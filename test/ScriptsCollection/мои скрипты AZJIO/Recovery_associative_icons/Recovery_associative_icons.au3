#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=Recovery_associative_icons.exe
#AutoIt3Wrapper_icon=Recovery_associative_icons.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=Recovery of associative icons
#AutoIt3Wrapper_Res_Description=Recovery_associative_icons.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Icon_Add=1.ico
#AutoIt3Wrapper_Res_Icon_Add=2.ico
#AutoIt3Wrapper_Res_Icon_Add=3.ico
#AutoIt3Wrapper_Res_Field=Version|0.2
#AutoIt3Wrapper_Res_Field=Build|2013.06.22
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****

; AZJIO 2013.06.22  (AutoIt3_v3.3.6.1)

#NoTrayIcon
#include <File.au3>
#include <GuiImageList.au3>
#include <GuiListView.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiComboBox.au3>
#include <ForRecovery_associative_icons.au3>
; #include <ButtonConstants.au3>
; #include <Array.au3>

Opt("GUIOnEventMode", 1)
Opt("GUIResizeMode", 802)
GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")

; По умолчанию устанавливаем англоязычный интерфейс, в случае отсутствия языковых файлов.
Global $aLngDef[39][2] = [[ _
		38, 38],[ _
		'1', 'Recovery associative icons'],[ _
		'2', 'About'],[ _
		'3', 'Version'],[ _
		'4', 'Site'],[ _
		'5', 'Copy'],[ _
		'6', 'Restart "Recovery associative icons"'],[ _
		'7', 'Help'],[ _
		'8', 'Apply'],[ _
		'9', 'Open list'],[ _
		'10', 'Open the config file-list'],[ _
		'11', 'Apply'],[ _
		'12', 'Apply icons marked with an arrow'],[ _
		'13', 'Refresh list'],[ _
		'14', 'Refresh the list after changes'],[ _
		'15', 'Создание списка'],[ _
		'16', 'All'],[ _
		'17', 'All groups'],[ _
		'18', 'Scan'],[ _
		'19', 'Scan all file types in the registry'],[ _
		'20', 'Save'],[ _
		'21', 'Save the scanned file types in file-list'],[ _
		'22', 'Clear list'],[ _
		'23', 'Clear list'],[ _
		'24', 'Refresh the cache'],[ _
		'25', 'Refresh icon cache'],[ _
		'26', 'Double click on a line list will restore this icon.' & @CRLF & @CRLF & 'Next to the changed icon will appear "Arrow".' & @CRLF & @CRLF & 'If the icon file is missing, you receive the "Crosshairs"' & @CRLF & @CRLF & 'Copy the dll-files in the folder "System32"'],[ _
		'27', 'Type'],[ _
		'28', '1. Before change keep all icons in file-list.' & @CRLF & @CRLF & _
		'2. Double click on a line list will restore this icon.' & @CRLF & @CRLF & _
		'3. Icons requiring rehabilitation are indicated by a green arrow.' & @CRLF & @CRLF & _
		'4. If the icon file is missing, you receive the "Crosshairs"' & @CRLF & @CRLF & _
		'5. Icons with ProgID not identical may be different. For example in 7z for each extension its ProgID, and in WinRAR almost all the same. So if you have association with WinRAR, you should not change the icons, so as to use one icon for all - the last selected for the ProgID = WinRAR' & @CRLF & @CRLF & _
		'6. If you applied the icons, but they do not appear for the corresponding files in the explorer, which means you need to copy the dll to the system directory. The program sees the current directory and it works for her, and the operating system looks for files with a set of icons in the system catalog. And click "Refresh cache".'],[ _
		'29', 'Open the file array'],[ _
		'30', 'Text file'],[ _
		'31', 'Error'],[ _
		'32', 'Unable to open file'],[ _
		'33', 'Message'],[ _
		'34', 'You want to recover all the icons?'],[ _
		'35', 'Would you like to make changes to the registry?'],[ _
		'36', 'Path'],[ _
		'37', 'Save as ...'],[ _
		'38', 'Recovery' & @CRLF & 'associative icons']]

; Ru
; если русская локализация, то русский язык. Эта фишка необязательна, но удобство в том, чтобы на родном языке не требовался файл русификации
If @OSLang = 0419 Then
	Dim $aLngDef[39][2] = [[ _
			38, 38],[ _
			'1', 'Восстановление ассоциативных иконок'],[ _
			'2', 'О программе'],[ _
			'3', 'Версия'],[ _
			'4', 'Сайт'],[ _
			'5', 'Копировать'],[ _
			'6', 'Перезапуск утилиты'],[ _
			'7', 'Справка'],[ _
			'8', 'Установить'],[ _
			'9', 'Открыть список'],[ _
			'10', 'Открыть конфигурационный' & @CRLF & 'файл-список'],[ _
			'11', 'Применить'],[ _
			'12', 'Применить иконки' & @CRLF & 'отмеченные стрелкой'],[ _
			'13', 'Обновить список'],[ _
			'14', 'Обновить список' & @CRLF & 'после изменений'],[ _
			'15', 'Создание списка'],[ _
			'16', 'Все'],[ _
			'17', 'Все группы'],[ _
			'18', 'Сканировать'],[ _
			'19', 'Сканировать все текущие' & @CRLF & 'расширения в реестре'],[ _
			'20', 'Сохранить'],[ _
			'21', 'Сохранить сканированные' & @CRLF & 'расширения в файл'],[ _
			'22', 'Очистить окно'],[ _
			'23', 'Очистить список'],[ _
			'24', 'Обновить кэш'],[ _
			'25', 'Обновить кэш иконок'],[ _
			'26', 'Двойной клик на строке списка восстановит кликнутую иконку.' & @CRLF & @CRLF & 'Напротив изменённой иконки появится "Стрелка".' & @CRLF & @CRLF & 'Если файл иконок отсутствует, появится "Крестик"' & @CRLF & @CRLF & 'Скопируйте dll-файлы в папку System32'],[ _
			'27', 'Тип  '],[ _
			'28', '1. Рекомендуется сохранить все иконки перед какими либо манипуляциями, для этого нужно создать список всех расширений и сохранить в файл.' & @CRLF & @CRLF & _
			'2. Двойной клик на строке списка восстановит кликнутую иконку.' & @CRLF & @CRLF & _
			'3. Иконки, требующие восстановления помечены индикатором в виде зелёной стрелки.' & @CRLF & @CRLF & _
			'4. Если прочитанный из текстового списка dll-файл иконок отсутствует (или exe, ico), то будет помечен красным крестиком' & @CRLF & @CRLF & _
			'5. Иконки с одинаковым ProgID не могут быть разными. Например у 7z для каждого расширения свой ProgID, а у WinRAR практически у всех одинаковый. Поэтому если у вас ассоциации с WinRAR, то не стоит менять иконки, так как будет использоваться одна иконка для всех - последняя выбранная для ProgID = WinRAR' & @CRLF & @CRLF & _
			'6. Если вы применили иконки, но они не отображаются для соответствующих файлов в эксплорере, это значит, нужно скопировать dll в системный каталог. Программа видит текущий каталог и для неё это работает, а операционная система ищет файлы с набором иконок в системном каталоге. А также нажмите кнопку "Обновить кэш".'],[ _
			'29', 'Открыть файл массив'],[ _
			'30', 'Текстовый файл'],[ _
			'31', 'Ошибка'],[ _
			'32', 'Невозможно открыть файл'],[ _
			'33', 'Сообщение'],[ _
			'34', 'Вы желаете восстановить все иконки?'],[ _
			'35', 'Вы желаете внести изменения в реестр?'],[ _
			'36', 'Путь'],[ _
			'37', 'Сохранить как ...'],[ _
			'38', 'Восстановление ' & @CRLF & 'ассоциативных иконок']]
EndIf
Global $aLng[39] = [38]
_SetLangCur($aLngDef)

Func _SetLangCur($aLng2D)
	; генерируем переменные массива
	Local $tmp
	For $i = 1 To $aLng2D[0][0]
		If StringInStr($aLng2D[$i][1], '\n') Then $aLng2D[$i][1] = StringReplace($aLng2D[$i][1], '\n', @CRLF) ; Обеспечивает перенос строк, который не поддерживает ini
		$tmp = Number($aLng2D[$i][0])
		If $tmp > 0 And $tmp <= $aLng[0] Then $aLng[$tmp] = $aLng2D[$i][1] ; добавление текста, если его параметр является число используемое как индекс массива
		; Фактически если переданный в $tmp параметр не является числом в диапазоне индексов массива, то он будет отброшен. Массив не вызывает ошибки, так как число не превысит количество элементов массива.
	Next
EndFunc   ;==>_SetLangCur

Global $TypeNR, $aAssot, $aAssot2, $hListView, $hImage, $TrStart = 0, $CurrentFile = @ScriptDir & '\associative_icons.txt', $aColumn, $d
Global $XYPos[4], $Tr7 = 0, $Gui1, $Gui

Switch @OSVersion
	Case 'WIN_VISTA', 'WIN_7'
		$Tr7 = 1
EndSwitch

$iniType0 = 'txt,log,ion,cfg,inc,lst,shl,sif,ini,php,inf|mp3,wav,wma,ogg,m3u,pls,ac3|avi,mpg,mpeg,mp4,asx,asf,wmv,3gp,mov,mkv,ifo,vob,flv,bik,swf|bmp,gif,jpg,png,tga,tif,psd,xpm,dds|dll,res,cpl,ax,apl|au3,bat,cmd,reg,vbs,js|iso,mdf,img,mds,md0,md1,md2,md3,md4,md5,ima|htm,html,mht|doc,rtf,xls,pps,ppt,pdf|rar,zip,7z,cab,gz,ace,arj,bzip2,bz,bz2,cpio,deb,dmg,gzip,hfs,jar,lha,lzh,lzma,rpm,split,swm,tar,taz,tbz,tbz2,tgz,tpz,uu,uue,xxe,z,wim,xar|bootskin,ip,ksf,r00,r01,r02,r03,r04,r05,r06,r07,r08,r09,r10,r11,r12,r13,r14,r15,r16,r17,r18,r19,r20,r21,r22,r23,r24,r25,r26,r27,r28,r29|kar,mid,rmi,mmf|bin,bif,bim|nfo,diz,gho,ghs,torrent,fb2,djvu,s0m'
$iniClmn0 = '58|24|23|195|57|97|41|107'

$Ini = @ScriptDir & '\Recovery_associative_icons.ini'
If Not FileExists($Ini) Then
	$file = FileOpen($Ini, 2)
	FileWrite($file, '[setting]' & @CRLF & _
			'column=' & $iniClmn0 & @CRLF & _
			'W=450' & @CRLF & _
			'H=560' & @CRLF & _
			'X=-1' & @CRLF & _
			'Y=-1' & @CRLF & _
			'type=' & $iniType0)
	FileClose($file)
EndIf

$iniType = IniRead($Ini, 'setting', 'type', $iniType0)
If @error Then $iniType = $iniType0
$iniClmn = IniRead($Ini, 'setting', 'column', $iniClmn0)
$aColumn = StringSplit($iniClmn, '|')
If $aColumn[0] < 8 Then $aColumn = StringSplit($iniClmn0, '|')
; минимальная ширина колонок
For $i = 1 To 8
	$aColumn[$i] = Number($aColumn[$i])
	If $aColumn[$i] < 20 Then $aColumn[$i] = 20
Next
ReDim $aColumn[13]

$XYPos[0] = Number(IniRead($Ini, 'setting', 'W', '450'))
$XYPos[1] = Number(IniRead($Ini, 'setting', 'H', '560'))
$XYPos[2] = IniRead($Ini, 'setting', 'X', '')
$XYPos[3] = IniRead($Ini, 'setting', 'Y', '')

If $XYPos[0] < 230 Then $XYPos[0] = 230 ; ограничение ширины
If $XYPos[1] < 300 Then $XYPos[1] = 300 ; ограничение высоты
_SetCoor($XYPos)

$Gui = GUICreate($aLng[1], $XYPos[0], $XYPos[1], $XYPos[2], $XYPos[3], $WS_OVERLAPPEDWINDOW)
If @Compiled Then
	$AutoItExe = @AutoItExe
Else
	$AutoItExe = @ScriptDir & '\Recovery_associative_icons.dll'
	GUISetIcon($AutoItExe, 99)
EndIf
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

GUICtrlCreateButton('R', $XYPos[0] - 23, 2, 18, 18)
GUICtrlSetOnEvent(-1, "_restart")
GUICtrlSetTip(-1, $aLng[6])
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

GUICtrlCreateButton('?', $XYPos[0] - 45, 2, 18, 18);, $BS_ICON
GUICtrlSetOnEvent(-1, "_Help")
GUICtrlSetTip(-1, $aLng[7])
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
; GUICtrlSetImage(-1, "shell32.dll", -155, 0)

GUICtrlCreateButton('@', $XYPos[0] - 68, 2, 18, 18)
GUICtrlSetOnEvent(-1, "_About")
GUICtrlSetTip(-1, $aLng[2])
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

GUICtrlCreateGroup($aLng[8], $XYPos[0] - 115, 21, 111, 106)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
GUICtrlCreateButton($aLng[9], $XYPos[0] - 110, 37, 100, 25)
GUICtrlSetOnEvent(-1, "_Open")
GUICtrlSetTip(-1, $aLng[10])
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

GUICtrlCreateButton($aLng[11], $XYPos[0] - 110, 67, 100, 25)
GUICtrlSetOnEvent(-1, "_Restore")
GUICtrlSetTip(-1, $aLng[12])
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

GUICtrlCreateButton($aLng[13], $XYPos[0] - 110, 97, 100, 25)
GUICtrlSetOnEvent(-1, "_Update")
GUICtrlSetTip(-1, $aLng[14])
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

GUICtrlCreateGroup($aLng[15], $XYPos[0] - 115, 129, 111, 106)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
$Combo = GUICtrlCreateCombo('', $XYPos[0] - 110, 145, 100, -1, $CBS_DROPDOWNLIST + $WS_VSCROLL)
GUICtrlSetData(-1, $aLng[16] & '|' & $aLng[17] & '|' & $iniType, $aLng[17])
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)
_GUICtrlComboBox_SetDroppedWidth(-1, 400)

GUICtrlCreateButton($aLng[18], $XYPos[0] - 110, 175, 100, 25)
GUICtrlSetOnEvent(-1, "_Create")
GUICtrlSetTip(-1, $aLng[19])
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

GUICtrlCreateButton($aLng[20], $XYPos[0] - 110, 205, 100, 25)
GUICtrlSetOnEvent(-1, "_Save")
GUICtrlSetTip(-1, $aLng[21])
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

GUICtrlCreateButton($aLng[22], $XYPos[0] - 110, 240, 100, 25)
GUICtrlSetOnEvent(-1, "_Clear")
GUICtrlSetTip(-1, $aLng[23])
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

GUICtrlCreateButton($aLng[24], $XYPos[0] - 110, 270, 100, 25)
GUICtrlSetOnEvent(-1, "_RebuildShellIconCache")
GUICtrlSetTip(-1, $aLng[25])
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

GUICtrlCreateLabel($aLng[26], $XYPos[0] - 116, 300, 115, 230)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$ListView = GUICtrlCreateListView($aLng[27] & "|N|Tr|ProgID", 5, 5, $XYPos[0] - 125, $XYPos[1] - 10, $LVS_REPORT);,$LVS_SORTDESCENDING)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 64)
$hListView = GUICtrlGetHandle($ListView)
_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES))
GUICtrlSendMsg($hListView, $LVM_SETCOLUMNWIDTH, 3, 140)
OnAutoItExitRegister('_Exit')

If FileExists($CurrentFile) Then
	$wCLV = 9
	_Build()
	For $i = 0 To 3
		GUICtrlSendMsg($hListView, $LVM_SETCOLUMNWIDTH, $i, $aColumn[$i + 1])
	Next
Else
	$wCLV = 9
	_Create()
	For $i = 0 To 3
		GUICtrlSendMsg($hListView, $LVM_SETCOLUMNWIDTH, $i, $aColumn[$i + 5])
	Next
EndIf

GUISetState()

GUIRegisterMsg($WM_SIZE, "WM_SIZE")
GUIRegisterMsg($WM_WINDOWPOSCHANGING, "WM_WINDOWPOSCHANGING")
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

While 1
	Sleep(100000)
WEnd

Func _Help()
	MsgBox(0, $aLng[7], $aLng[28], 0, $Gui)
EndFunc   ;==>_Help

Func _Clear()
	If $TrStart = 0 Then Return
	$aAssot = 0
	_GUIImageList_Destroy($hImage)
	_GUICtrlListView_DeleteAllItems($hListView)
EndFunc   ;==>_Clear

Func _Open()
	$tmp = FileOpenDialog($aLng[29], @ScriptDir, $aLng[30] & ' (*.txt)', '', '', $Gui)
	If @error Then Return
	_Clear()
	$CurrentFile = $tmp
	_Build()
EndFunc   ;==>_Open

Func _Update()
	_Clear()
	_Build()
EndFunc   ;==>_Update

Func _Build()
	Local $aType
	If Not _FileReadToArray($CurrentFile, $aType) Then Return MsgBox(4096, $aLng[31], $aLng[32], 0, $Gui)
	$Sz = 16
	$hImage = _GUIImageList_Create($Sz, $Sz, 5, 3)
	$TrStart = 1
	_GUICtrlListView_SetImageList($hListView, $hImage, 1)
	For $i = 0 To 3
		$aColumn[$i + $wCLV] = GUICtrlSendMsg($ListView, $LVM_GETCOLUMNWIDTH, $i, 0)
	Next

	; Создаём сначала массив элементов
	Dim $aAssot[$aType[0]][8]
	;0 тип
	;1 файл
	;2 иконка
	;3 файл из реестра
	;4 иконка из реестра
	;5 ProgID (класс)
	;6 различие
	;7 ошибка, путь не существует
	$d = -1
	For $i = 1 To $aType[0]
		$aTypeIco = StringSplit($aType[$i], '|')
		If $aTypeIco[0] < 3 Or $aTypeIco[3] = '' Then ContinueLoop
		$ico1 = _AssotFile($aTypeIco[1])
		If Not @error Then
			Switch UBound($ico1)
				Case 3
					; If Not FileExists($ico1[1]) Then ContinueLoop
					; _GUIImageList_AddIcon($hImage, $ico1[1], ($ico1[2]+1)*-1)
					_GUIImageList_AddIcon($hImage, $ico1[1], $ico1[2])
					If @error Then ContinueLoop
				Case 2
					; If Not FileExists($ico1[1]) Then ContinueLoop
					If StringInStr(';exe;scr;ico;ani;cur;', ';' & $aTypeIco[1] & ';') Then
						ContinueLoop
					Else
						ReDim $ico1[3]
						$ico1[2] = 0
						_GUIImageList_AddIcon($hImage, $ico1[1], $ico1[2])
						If @error Then ContinueLoop
					EndIf
				Case Else
					ContinueLoop
			EndSwitch
		Else
			ContinueLoop
		EndIf
		$d += 1
		_GUIImageList_AddIcon($hImage, $aTypeIco[2], $aTypeIco[3])
		If @error Then
			_GUIImageList_AddIcon($hImage, $ico1[1], $ico1[2])
			$aAssot[$d][7] = 1
			$aAssot[$d][1] = $ico1[1] ; если ошибка то пути из реестра, дабы при полной замене не вставлять пути на dll, которой не существует.
			$aAssot[$d][2] = $ico1[2]
		Else
			$aAssot[$d][7] = 0
			$aAssot[$d][1] = $aTypeIco[2]
			$aAssot[$d][2] = $aTypeIco[3]
		EndIf
		$aAssot[$d][0] = $aTypeIco[1]
		$aAssot[$d][3] = $ico1[1]
		$aAssot[$d][4] = $ico1[2]
		$aAssot[$d][5] = $TypeNR
		If StringTrimLeft($ico1[1], StringInStr($ico1[1], '\', 0, -1)) & $ico1[2] <> StringTrimLeft($aTypeIco[2], StringInStr($aTypeIco[2], '\', 0, -1)) & $aTypeIco[3] Then
			$aAssot[$d][6] = 1
		Else
			$aAssot[$d][6] = 0
		EndIf
	Next

	If $d < 1 Then Return _Clear()
	ReDim $aAssot[$d + 1][8]
	_GUIImageList_AddIcon($hImage, $AutoItExe, -201)
	_GUIImageList_AddIcon($hImage, $AutoItExe, -202)
	_GUIImageList_AddIcon($hImage, $AutoItExe, -203)

	_GUICtrlListView_BeginUpdate($hListView)
	For $i = 0 To $d
		_GUICtrlListView_AddItem($hListView, $aAssot[$i][0], $i * 2)
		_GUICtrlListView_AddSubItem($hListView, $i, '', 1, $i * 2 + 1)
		If $aAssot[$i][6] And Not $aAssot[$i][7] Then _GUICtrlListView_AddSubItem($hListView, $i, '', 2, $d * 2 + 2)
		If $aAssot[$i][7] Then _GUICtrlListView_AddSubItem($hListView, $i, '', 2, $d * 2 + 3)
		_GUICtrlListView_AddSubItem($hListView, $i, $aAssot[$i][5], 3)
	Next
	For $i = 0 To 3
		GUICtrlSendMsg($ListView, $LVM_SETCOLUMNWIDTH, $i, $aColumn[$i + 1])
	Next
	$wCLV = 1
	_GUICtrlListView_SetColumn($hListView, 1, 'N')
	_GUICtrlListView_SetColumn($hListView, 2, 'Re')
	_GUICtrlListView_EndUpdate($hListView)
EndFunc   ;==>_Build

Func _Restore()
	If Not IsArray($aAssot) Then Return
	If MsgBox(1, $aLng[33], $aLng[34], 0, $Gui) = 1 Then
		For $i = 0 To UBound($aAssot) - 1
			If StringInStr($aAssot[$i][1], ' ') Then $aAssot[$i][1] = '"' & $aAssot[$i][1] & '"'
			RegWrite('HKCR\' & $aAssot[$i][5] & '\DefaultIcon', '', "REG_SZ", $aAssot[$i][1] & ',' & $aAssot[$i][2])
		Next
	EndIf
	_Update()
EndFunc   ;==>_Restore

Func WM_NOTIFY($hWnd, $Msg, $wParam, $lParam)
	If $wCLV = 5 Then Return $GUI_RUNDEFMSG
	Local $tNMHDR, $iIDFrom, $iCode
	
	; If Not IsHWnd($hListView) Then $hWndListView = GUICtrlGetHandle($hListView)
	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	
	Switch $iIDFrom
		Case $ListView
			Switch $iCode
				Case $NM_DBLCLK
					Local $tInfo = DllStructCreate($tagNMLISTVIEW, $lParam)
					$ind = DllStructGetData($tInfo, "Item")
					If MsgBox(1, $aLng[33], $aLng[35] & @CRLF & 'HKCR\' & $aAssot[$ind][5] & '\DefaultIcon' & @CRLF & $aAssot[$ind][1] & ',' & $aAssot[$ind][2], 0, $Gui) = 1 Then
						If StringInStr($aAssot[$ind][1], ' ') Then $aAssot[$ind][1] = '"' & $aAssot[$ind][1] & '"'
						RegWrite('HKCR\' & $aAssot[$ind][5] & '\DefaultIcon', '', "REG_SZ", $aAssot[$ind][1] & ',' & $aAssot[$ind][2])
						$icoind = _GUICtrlListView_GetItemImage($hListView, $ind, 1) ; получить индекс иконки
						_GUICtrlListView_SetItemImage($hListView, $ind, $icoind, 0) ; вставить иконку
						_GUICtrlListView_SetItemImage($hListView, $ind, $d * 2 + 4, 2) ; жёлтая стрелка
					EndIf
			EndSwitch
	EndSwitch
	
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _Create()
	_Clear()
	
	$Sz = 16
	$hImage = _GUIImageList_Create($Sz, $Sz, 5, 3)
	$TrStart = 1
	_GUICtrlListView_SetImageList($hListView, $hImage, 1)
	$Combo0 = GUICtrlRead($Combo)
	Switch $Combo0
		Case $aLng[16]
			$TrType = 0
		Case $aLng[17]
			$TrType = 1
			$Combo0 = '|.' & StringReplace(StringReplace($iniType, '|', '|.'), ',', '|.') & '|'
		Case Else
			$TrType = 1
			$Combo0 = '|.' & StringReplace($Combo0, ',', '|.') & '|'
			; MsgBox(0, 'Сообщение', $Combo0)
	EndSwitch
	For $i = 0 To 3
		$aColumn[$i + $wCLV] = GUICtrlSendMsg($ListView, $LVM_GETCOLUMNWIDTH, $i, 0)
	Next
	
	Dim $aAssot2[1][4]
	$d = -1
	$i = 1
	While 1
		$i += 1
		; MsgBox(0, 'Сообщение', $i)
		$key = RegEnumKey("HKCR", $i)
		If @error Or StringLeft($key, 1) <> '.' Then ExitLoop
		If $TrType And Not StringInStr($Combo0, '|' & $key & '|') Then ContinueLoop
		$key = StringTrimLeft($key, 1)
		$ico1 = _AssotFile($key)
		If Not @error Then
			Switch UBound($ico1)
				Case 3
					_GUIImageList_AddIcon($hImage, $ico1[1], $ico1[2])
					If @error Then ContinueLoop
				Case 2
					If StringInStr(';exe;scr;ico;ani;cur;', ';' & $key & ';') Then
						ContinueLoop
					Else
						ReDim $ico1[3]
						$ico1[2] = 0
						_GUIImageList_AddIcon($hImage, $ico1[1], $ico1[2])
						If @error Then ContinueLoop
					EndIf
				Case Else
					ContinueLoop
			EndSwitch
			$d += 1
			ReDim $aAssot2[$d + 1][4]
			$aAssot2[$d][0] = $key
			$aAssot2[$d][1] = $ico1[1]
			$aAssot2[$d][2] = $ico1[2]
			$aAssot2[$d][3] = $TypeNR
		Else
			ContinueLoop
		EndIf
	WEnd
	
	_GUICtrlListView_BeginUpdate($hListView)
	For $i = 0 To $d
		_GUICtrlListView_AddItem($hListView, $aAssot2[$i][0], $i)
		_GUICtrlListView_AddSubItem($hListView, $i, $aAssot2[$i][1], 1)
		_GUICtrlListView_AddSubItem($hListView, $i, $aAssot2[$i][2], 2)
		_GUICtrlListView_AddSubItem($hListView, $i, $aAssot2[$i][3], 3)
	Next
	For $i = 0 To 3
		GUICtrlSendMsg($ListView, $LVM_SETCOLUMNWIDTH, $i, $aColumn[$i + 5])
	Next
	$wCLV = 5
	_GUICtrlListView_SetColumn($hListView, 1, $aLng[36])
	_GUICtrlListView_SetColumn($hListView, 2, 'nICO')
	_GUICtrlListView_EndUpdate($hListView)
EndFunc   ;==>_Create

Func _Save()
	If Not IsArray($aAssot2) Then Return
	
	$SaveFile = FileSaveDialog($aLng[37], @ScriptDir, $aLng[30] & ' (*.txt)', 24, 'associative_icons', $Gui)
	If @error Then Return
	If StringRight($SaveFile, 4) <> '.txt' Then $SaveFile &= '.txt'

	$content = ''
	For $i = 0 To UBound($aAssot2) - 1
		$content &= $aAssot2[$i][0] & '|' & $aAssot2[$i][1] & '|' & $aAssot2[$i][2] & @CRLF
	Next
	$content = StringTrimRight($content, 2)
	$file = FileOpen($SaveFile, 2)
	FileWrite($file, $content)
	FileClose($file)
EndFunc   ;==>_Save

Func WM_SIZE($hWnd, $Msg, $wParam, $lParam) ;можно переместить в WM_WINDOWPOSCHANGING но тогда не будет ресайза в текущем времени для элеметов "по особым правилам" и учесть что в этой функции клиентские размеры,в отличии от WM_WINDOWPOSCHANGING
	Switch $Tr7
		Case 1
			If Not BitAND(WinGetState($Gui), 16) Then
				$XYPos[0] = BitAND($lParam, 0x0000FFFF)
				$XYPos[1] = BitShift($lParam, 16)
			EndIf
		Case Else ; Если окно не свёрнуто при выходе, то сохраняем координаты в переменную.
			If Not BitAND(WinGetState($Gui), 16) Then
				$XYPos[0] = BitAND($lParam, 0x0000FFFF)
				$XYPos[1] = BitShift($lParam, 16)
			EndIf
	EndSwitch
	; _WinAPI_MoveWindow($Dubl, 10, 100, $XYPos[0]-20, $XYPos[1]-100) ; изменение размера по особым правилам, например для _GUICtrlListView_Create
	Return 'GUI_RUNDEFMSG'
EndFunc   ;==>WM_SIZE

Func WM_WINDOWPOSCHANGING($hWnd, $Msg, $wParam, $lParam)
	Local $sRect = DllStructCreate("Int[6]", $lParam)
	Switch $Tr7
		Case 1
			If DllStructGetData($sRect, 1, 5) <> 0 And Not BitAND(WinGetState($Gui), 16) Then
				$XYPos[2] = DllStructGetData($sRect, 1, 3)
				$XYPos[3] = DllStructGetData($sRect, 1, 4)
			EndIf
		Case Else ; Если окно отпущено после перемещения, не вызвано диалогового окна, не свёрнуто при выходе, то сохраняем координаты в переменную
			If DllStructGetData($sRect, 1, 2) And DllStructGetData($sRect, 1, 5) <> 0 And Not BitAND(WinGetState($Gui), 16) Then
				$XYPos[2] = DllStructGetData($sRect, 1, 3)
				$XYPos[3] = DllStructGetData($sRect, 1, 4)
			EndIf
	EndSwitch
	Return 'GUI_RUNDEFMSG'
EndFunc   ;==>WM_WINDOWPOSCHANGING

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	If $hWnd = $Gui Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 450) ; минимальные размеры окна
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 560)
	EndIf
EndFunc   ;==>WM_GETMINMAXINFO

Func _Exit()
	For $i = 0 To 3
		$aColumn[$i + $wCLV] = GUICtrlSendMsg($ListView, $LVM_GETCOLUMNWIDTH, $i, 0)
	Next
	$w = ''
	For $i = 1 To 8
		$w &= $aColumn[$i] & '|'
	Next
	IniWrite($Ini, 'setting', 'column', StringTrimRight($w, 1))
	IniWrite($Ini, 'setting', 'W', $XYPos[0])
	IniWrite($Ini, 'setting', 'H', $XYPos[1])
	IniWrite($Ini, 'setting', 'X', $XYPos[2])
	IniWrite($Ini, 'setting', 'Y', $XYPos[3])
	Exit
EndFunc   ;==>_Exit

Func _About()
	$GP = _ChildCoor($Gui, 290, 190)
	GUIRegisterMsg(0x0024, "")
	GUIRegisterMsg($WM_SIZE, "")
	GUIRegisterMsg($WM_WINDOWPOSCHANGING, "")
	GUIRegisterMsg($WM_NOTIFY, "")
	GUISetState(@SW_DISABLE, $Gui)
	$font = "Arial"
	$Gui1 = GUICreate($aLng[2], $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui) ; WS_CAPTION+WS_SYSMENU
	If Not @Compiled Then GUISetIcon($AutoItExe, 99)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")
	GUISetBkColor(0xE1E3E7)
	GUICtrlCreateLabel($aLng[38], 0, 0, 290, 63, 0x01)
	GUICtrlSetFont(-1, 14, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, 64, 288, 1, 0x10)

	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($aLng[3] & ' 0.2  2013.06.22', 55, 100, 210, 17)
	GUICtrlCreateLabel($aLng[4] & ':', 55, 115, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetOnEvent(-1, "_url")
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetOnEvent(-1, "_WbMn")
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $aLng[5])
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2009-2013', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
EndFunc   ;==>_About

Func _url()
	ShellExecute('http://azjio.ucoz.ru')
EndFunc   ;==>_url

Func _WbMn()
	ClipPut('R939163939152')
EndFunc   ;==>_WbMn

Func _Exit1()
	GUISetState(@SW_ENABLE, $Gui)
	GUIDelete($Gui1)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")
	GUIRegisterMsg($WM_SIZE, "WM_SIZE")
	GUIRegisterMsg($WM_WINDOWPOSCHANGING, "WM_WINDOWPOSCHANGING")
	GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
EndFunc   ;==>_Exit1