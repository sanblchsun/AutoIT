#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=ContMenuFiles.exe
#AutoIt3Wrapper_Icon=ContMenuFiles.ico
#AutoIt3Wrapper_Compression=n
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=ContMenuFiles.exe
#AutoIt3Wrapper_Res_Fileversion=0.7.5.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.7.5
#AutoIt3Wrapper_Res_Field=Build|2013.05.23
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Res_Icon_Add=icons\1.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\2.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\3.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\4.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\5.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\6.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\7.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\8.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\9.ico
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
; #AutoIt3Wrapper_Run_After=%autoitdir%\Aut2Exe\upx.exe -7 --compress-icons=0 "%out%"
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****

; AZJIO 2011-2013.05.23  (AutoIt3_v3.3.6.1)

#RequireAdmin
#NoTrayIcon
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiButton.au3>
#include <StaticConstants.au3>
#include <ListViewConstants.au3>
#include <ForContMenuFiles.au3>
#include <GuiTreeView.au3>
#include <GuiListView.au3>
; #include <WinAPI.au3>
#include <ModernMenuRaw.au3>

Global $aRunR, $Tr = 0, $TrIco = 0, $TypeNR, $RunR0 = '', $NameR0 = '', $NameMenuR0 = '', $FileDll = 'SHELL32.DLL', $Type0 = 'reg', $Editor, $TrTV = True, $item000, $sWorkKey, $iInxSel
$IndGr = 1
Opt("GUIResizeMode", 0x0322)
GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")

; En
$LngTitle = 'Context menu of the files'
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngCopy = 'Copy'
$LngRe = 'Restart Program'
$LngSBr = 'StatusBar'

$LngType = 'Type'
$LngName = 'Name'
$LngNmMn = 'Name Menu (not necessarily)'
$LngCom = 'Command (drag-and-drop = exe, lnk and other)'
$LngRd = 'Read'
; $LngRdH='Read the information on file type to the list'
$LngOpn = 'Open'
$LngOpnH = 'View selected item in the list in the registry'
$LngDel = 'Delete'
$LngDelH = 'Delete the selected item in the list in the registry'
$LngFill = 'Fill'
$LngFillH = 'Fill in the entry field selected list item'
$LngAdd = 'Add'
$LngAddH = 'Add the registry entry from the input fields'
$LngExp = 'Export'
; $LngExpH='Export to recover the current file type'
$LngCrt = 'Create'
; $LngCrtH='Create an extension'
$LngDef = 'Default'
$LngDefH = 'Default item'
$LngSb1 = 'made in'
$LngMS1 = 'Delete Key?'
$LngErr = 'Error'
$LngMS2 = 'Enter the required parameters!'
$LngMS3 = 'No data.'
$LngExt = 'Expansion'
$LngMS4 = 'exists, overwrite?'
$LngIB1 = 'Entering Class'
$LngIB2 = 'Select the name of the class'
$LngMS5 = 'Class'
$LngFOD = 'Select the file that contains icons'
$LngFOD1 = 'Icon files'
$LngMS9 = 'Message'
$LngMS6 = 'You want to create necessary ContMenuFiles.ini?' & @CRLF & 'Otherwise exit.'
$LngMS7 = 'Not Found'
; $LngMS8 = 'apply?'
$LngDRP = 'Open in'
$LngIni = 'Open ContMenuFiles.ini'
$LngIcoH = 'Change icon'
$LngPidH = 'Delete Progid'
$LngMOF = 'Open Folder'
$LngAct = 'Action'
$LngMnM = 'Menu'
$LngGrM = 'Group'
$LngEAll = 'Export of all Extensions'
$LngEGr = 'Export Extension Group'
$LngAddGr = 'Add item to a group'
$LngDIGr = 'Remove the item from the group'
$LngDfGr = 'The Default item in the group'
$LngNFn = 'Not found'
$LngReb = 'Rebuild Icon Cache'
$LngOpEpl = 'Open in Explorer'
$LngHLP = 'Help' & @TAB & 'F1'
$LngScrollAbt = 'The tool is designed to edit context menu items. ' & @CRLF & @CRLF & _
		'Allows recover, edit, add items to the same type of file types to delete, browse to the registry. ' & @CRLF & @CRLF & _
		'The utility is written in AutoIt3' & @CRLF & _
		'autoitscript.com'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngTitle = 'Контекстное меню файлов'
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngSite = 'Сайт'
	$LngCopy = 'Копировать'
	$LngRe = 'Перезапуск утилиты'
	$LngSBr = 'Строка состояния'
	$LngType = 'Тип'
	$LngName = 'Name'
	$LngNmMn = 'Имя Пункта Меню (не обязательно)'
	$LngCom = 'Командная строка (кинь сюда exe, lnk и другие)'
	$LngRd = 'Прочитать'
	; $LngRdH='Прочитать информацию'&@CRLF&'о типе файла в список'
	$LngOpn = 'Открыть'
	$LngOpnH = 'Открыть выделенный пункт' & @CRLF & 'списка в реестре'
	$LngDel = 'Удалить'
	$LngDelH = 'Удалить выделенный пункт' & @CRLF & 'списка в реестре'
	$LngFill = 'Заполнить'
	$LngFillH = 'Заполнить поля ввода' & @CRLF & 'выделенным пунктом списка'
	$LngAdd = 'Добавить'
	$LngAddH = 'Добавить в реестр запись' & @CRLF & 'из полей ввода'
	$LngExp = 'Экспорт'
	; $LngExpH='Экспортировать для восстановления'&@CRLF&'текущий тип файла'
	$LngCrt = 'Создать'
	; $LngCrtH='Создать расширение'&@CRLF&'и присвоить команду'
	$LngDef = 'Основной'
	$LngDefH = 'Пункт по умолчания' & @CRLF & 'при клике на файле'
	$LngSb1 = 'выполнен в'
	$LngMS1 = 'Удалить раздел реестра?'
	$LngErr = 'Ошибка'
	$LngMS2 = 'Введите обязательные параметры!'
	$LngMS3 = 'Нет данных.'
	$LngExt = 'Расширение'
	$LngMS4 = 'существует, перезаписать?'
	$LngIB1 = 'Ввод класса'
	$LngIB2 = 'Выберите имя класса'
	$LngMS5 = 'Класс'
	$LngFOD = 'Выберите файл, содержащий значки'
	$LngFOD1 = 'Файлы значков'
	$LngMS9 = 'Сообщение'
	$LngMS6 = 'Хотите создать необходимый ContMenuFiles.ini' & @CRLF & 'в качестве примера? Иначе выход.'
	$LngMS7 = 'Отсутствует'
	; $LngMS8 = 'Применить иконку?'
	$LngDRP = 'Открыть в'
	$LngIni = 'Открыть ContMenuFiles.ini'
	$LngIcoH = 'Изменить иконку'
	$LngPidH = 'Удалить переадресацию Progid' & @CRLF & 'рекомендуется сделать экспорт' & @CRLF & 'перед использованием.'
	$LngMOF = 'Открыть папку утилиты'
	$LngAct = 'Действие'
	$LngMnM = 'Меню'
	$LngGrM = 'Группы'
	$LngEAll = 'Экспорт всех расширений'
	$LngEGr = 'Экспорт группы расширений'
	$LngAddGr = 'Добавить пункт в группу'
	$LngDIGr = 'Удалить пункт из группы'
	$LngDfGr = 'Основной пункт в группе'
	$LngNFn = 'Показать отсутствующие'
	$LngReb = 'Обновить все иконки'
	$LngOpEpl = 'Открыть в проводнике'
	$LngHLP = 'Справка' & @TAB & 'F1'
	$LngScrollAbt = 'Утилита предназначена' & @CRLF & _
			'для редактирования пунктов контекстного меню.' & @CRLF & @CRLF & _
			'Позволяет  бэкапировать, редактировать, ' & _
			'добавлять пункт в однотипные типы файлов ' & _
			'удалять, просматривать в реестре.' & @CRLF & @CRLF & _
			'Утилита написана на AutoIt3' & @CRLF & _
			'autoitscript.com'
EndIf

$Ini = @ScriptDir & '\ContMenuFiles.ini'
$vData = _
		'Text=txt|log|ion|cfg|inc|lst|shl|sif|ini|php|css|inf' & @CRLF & _
		'Music=mp3|wav|wma|ogg|m3u|pls|ac3' & @CRLF & _
		'Video=avi|mpg|mpeg|mp4|asx|asf|wmv|3gp|mov|mkv|ifo|vob|flv|bik|swf' & @CRLF & _
		'Picture=bmp|gif|jpg|png|tga|tif|psd|xpm|dds' & @CRLF & _
		'Resource=dll|res|cpl|ax|exe|apl' & @CRLF & _
		'Script=au3|bat|cmd|reg|vbs|js' & @CRLF & _
		'Image=iso|mdf|img|mds|md0|md1|md2|md3|md4|ima' & @CRLF & _
		'Web=htm|html|mht|chm|xml' & @CRLF & _
		'Docum=doc|docx|rtf|xls|xlsx|pps|ppt|pdf' & @CRLF & _
		'Archive=rar|zip|7z|cab|gz|ace|arj|bzip2|bz|bz2|cpio|deb|dmg|gzip|hfs|jar|lha|lzh|lzma|rpm|split|swm|tar|taz|tbz|tbz2|tgz|tpz|uu|uue|xxe|z|wim|xar' & @CRLF & _
		'Archive1=bootskin|ip|ksf|r00|r01|r02|r03|r04|r05|r06|r07|r08|r09|r10|r11|r12|r13|r14|r15|r16|r17|r18|r19|r20|r21|r22|r23|r24|r25|r26|r27|r28|r29' & @CRLF & _
		'Icon=ico|cur|ani' & @CRLF & _
		'Midi=kar|mid|rmi|mmf' & @CRLF & _
		'Binary=bin|bif|bim' & @CRLF & _
		'Other=nfo|diz|gho|ghs|torrent|fb2|djvu|md5|s0m'
If Not FileExists($Ini) Then
	$hFile = FileOpen($Ini, 2)
	FileWrite($hFile, '[type]' & @CRLF & _
			$vData & @CRLF & @CRLF & _
			'[Setting]' & @CRLF & _
			'CRCULM=0')
	FileClose($hFile)
EndIf

$iTrKey = Number(IniRead($Ini, "Setting", "CRCULM", '0'))

Global $aTypeSec = IniReadSection($Ini, 'type')
If @error Then _ReadData($aTypeSec)
$vData = ''

Func _ReadData(ByRef $aTypeSec)
	Local $tmp
	$vData = StringSplit($vData, @CRLF, 1)
	Dim $aTypeSec[$vData[0] + 1][2] = [[$vData[0]]]
	For $i = 1 To $vData[0]
		$tmp = StringSplit($vData[$i], '=')
		$aTypeSec[$i][0] = $tmp[1]
		$aTypeSec[$i][1] = $tmp[2]
	Next
EndFunc   ;==>_ReadData
; $font = IniRead ($Ini, 'gui', 'fontsize', '')

$Gui = GUICreate($LngTitle, 560, 375, -1, -1, BitOR($GUI_SS_DEFAULT_GUI, $WS_OVERLAPPEDWINDOW, $WS_CLIPCHILDREN), $WS_EX_ACCEPTFILES)

$treeview = GUICtrlCreateTreeView(5, 24, 100, 306, BitOR($TVS_TRACKSELECT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS), $WS_EX_CLIENTEDGE + $WS_EX_COMPOSITED)
GUICtrlSetResizing(-1, 256 + 64 + 32 + 2)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
$hTreeView = GUICtrlGetHandle($treeview)

Global $aTreeViewItem[$aTypeSec[0][0] + 1]
Global $aTypeV[1][2]
$aTypeV[0][0] = 0

; Создаём дерево разделов
For $i = 1 To $aTypeSec[0][0]
	$aTreeViewItem[$i] = GUICtrlCreateTreeViewItem($aTypeSec[$i][0], $treeview)
	GUICtrlSetColor(-1, 0x0000C0)
	GUICtrlSetState(-1, $GUI_DEFBUTTON)
Next

; Создаём в разделах дерева пункты - расширение файлов
For $i = 1 To $aTypeSec[0][0]
	$aTypeTmp = StringSplit($aTypeSec[$i][1], '|')
	ReDim $aTypeV[$aTypeV[0][0] + $aTypeTmp[0] + 1][2]

	For $d = $aTypeV[0][0] + 1 To $aTypeV[0][0] + $aTypeTmp[0]
		$aTypeV[$d][0] = GUICtrlCreateTreeViewItem($aTypeTmp[$d - $aTypeV[0][0]], $aTreeViewItem[$i])
		$aTypeV[$d][1] = $aTypeTmp[$d - $aTypeV[0][0]]
	Next

	$aTypeV[0][0] = $aTypeV[0][0] + $aTypeTmp[0]
Next

; #include <Array.au3>
; _ArrayDisplay( $aTypeSec, "Groups" ) ; имена групп и содержимое групп
; _ArrayDisplay( $aTypeV, "Ext" ) ; имена всех расширений

; $fileM=GUICtrlCreateMenu('&File')
; $IMrestart=GUICtrlCreateMenuitem($LngRe,$fileM)
; $IMExit=GUICtrlCreateMenuitem('Exit',$fileM)

If @Compiled Then
	$AutoItExe = @AutoItExe
Else
	$AutoItExe = @ScriptDir & '\ContMenuFiles.dll'
	GUISetIcon($AutoItExe, 99)
EndIf

_SetMenuIconBkColor(_WinAPI_GetSysColor($COLOR_MENU))
_SetMenuBkColor(_WinAPI_GetSysColor($COLOR_MENU))
_SetMenuSelectRectColor(_WinAPI_GetSysColor($COLOR_HIGHLIGHT))
_SetMenuSelectBkColor(_WinAPI_GetSysColor($COLOR_HIGHLIGHT))
_SetMenuSelectTextColor(_WinAPI_GetSysColor($COLOR_HIGHLIGHTTEXT))

$MainM = GUICtrlCreateMenu($LngMnM)
$IMOpenF = _GUICtrlCreateODMenuItem($LngMOF, $MainM, "shell32.dll", 4)
$OpnIni = _GUICtrlCreateODMenuItem($LngIni, $MainM, "shell32.dll", 151)
GUICtrlCreateMenuItem('', $MainM)
$iHKCR = GUICtrlCreateMenuItem('HKCR', $MainM, -1, 1)
$iHKCU = GUICtrlCreateMenuItem('HKCU', $MainM, -1, 1)
$iHKLM = GUICtrlCreateMenuItem('HKLM', $MainM, -1, 1)
Switch $iTrKey
	Case 1
		GUICtrlSetState($iHKCU, $GUI_CHECKED)
		$sWorkKey = 'HKCU\Software\Classes\'
	Case 2
		GUICtrlSetState($iHKLM, $GUI_CHECKED)
		$sWorkKey = 'HKLM\SOFTWARE\Classes\'
	Case Else
		GUICtrlSetState($iHKCR, $GUI_CHECKED)
		$sWorkKey = 'HKCR\'
		$iTrKey = 0
EndSwitch
GUICtrlCreateMenuItem('', $MainM)
$Rebuild_Icon = _GUICtrlCreateODMenuItem($LngReb, $MainM, $AutoItExe, 209)
$NotFn = GUICtrlCreateMenuItem($LngNFn, $MainM)

; $About=GUICtrlCreateButton ("@", 660-40, 1, 18, 18)
; GUICtrlSetTip(-1,  $LngAbout)
; GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)

$ActionM = GUICtrlCreateMenu($LngAct)
$Read = _GUICtrlCreateODMenuItem($LngRd & @TAB & ' Ctrl+PageDown', $ActionM, $AutoItExe, 208)
$Export = _GUICtrlCreateODMenuItem($LngExp & @TAB & ' Ctrl+Down', $ActionM, $AutoItExe, 201)
$Create = _GUICtrlCreateODMenuItem($LngCrt & @TAB & ' Ctrl+Up', $ActionM, $AutoItExe, 207)

$GroupM = GUICtrlCreateMenu($LngGrM)
$IMAddGr = _GUICtrlCreateODMenuItem($LngAddGr, $GroupM, $AutoItExe, 204)
$IMDelGr = _GUICtrlCreateODMenuItem($LngDIGr, $GroupM, $AutoItExe, 202)
$IMDefGr = _GUICtrlCreateODMenuItem($LngDfGr, $GroupM, $AutoItExe, 205)
GUICtrlCreateMenuItem('', $GroupM)
$IMExpGr = _GUICtrlCreateODMenuItem($LngEGr, $GroupM, $AutoItExe, 201)
$IMExpAll = _GUICtrlCreateODMenuItem($LngEAll, $GroupM, $AutoItExe, 201)
$HlpM = GUICtrlCreateMenu('?')
$iHelp = _GUICtrlCreateODMenuItem($LngHLP, $HlpM, "shell32.dll", -24)
$About = _GUICtrlCreateODMenuItem($LngAbout, $HlpM, "shell32.dll", -222)
; $IMurl=GUICtrlCreateMenuitem('http://azjio.ucoz.ru', $HlpM)

$restart = GUICtrlCreateButton("R", 560 - 20, 1, 18, 18)
GUICtrlSetTip(-1, $LngRe)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)

; $OpnIni=GUICtrlCreateButton ("ini", 660-60, 1, 18, 18)
; GUICtrlSetTip(-1,  $LngIni)
; GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)

$StatusBar = GUICtrlCreateLabel($LngSBr, 5, 335, 520, 17)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 2)

GUICtrlCreateLabel($LngType, 113, 10, 40, 14)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 2)
$Type = GUICtrlCreateInput('reg', 110, 24, 40, 22)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 2)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

$icodll = GUICtrlCreateButton('', 152, 24, 23, 22, $BS_ICON)
GUICtrlSetTip(-1, $LngIcoH)

GUICtrlCreateLabel($LngName, 178, 10, 130, 14)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 2)
$Name = GUICtrlCreateInput('', 178, 24, 149, 22)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 2)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

GUICtrlCreateLabel($LngNmMn, 330, 10, 210, 14)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 2)
$NameMenu = GUICtrlCreateInput('', 330, 24, 220, 22)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 2)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)

GUICtrlCreateLabel($LngCom, 110, 51, 417, 14)
GUICtrlSetResizing(-1, 7 + 32 + 512)
$Run = GUICtrlCreateInput('', 110, 65, 417, 22)
GUICtrlSetResizing(-1, 7 + 32 + 512)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
$SelFile = GUICtrlCreateButton('O', 528, 65, 22, 22, $BS_ICON)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', 4, 0)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$ReadInfo = GUICtrlCreateListView('Name|Command|Name Menu', 110, 125, 560 - 120, 205, -1, BitOR($LVS_EX_DOUBLEBUFFER, $LVS_EX_FULLROWSELECT, $LVS_EX_INFOTIP, $WS_EX_CLIENTEDGE))
GUICtrlSetResizing(-1, 7 + 32 + 64)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
$hListView = GUICtrlGetHandle(-1)
GUICtrlSendMsg($ReadInfo, 0x1000 + 30, 0, 100)
GUICtrlSendMsg($ReadInfo, 0x1000 + 30, 1, 515)
GUICtrlSendMsg($ReadInfo, 0x1000 + 30, 2, 200)

$hImgLst1 = _GUIImageList_Create(16, 16, 5, 1, 0, 1)
$hImgLst2 = _GUIImageList_Create(16, 16, 5, 1, 0, 1)
$hImgLst3 = _GUIImageList_Create(16, 16, 5, 1, 0, 1)
$hImgLst4 = _GUIImageList_Create(16, 16, 5, 1, 0, 1)
$hImgLst5 = _GUIImageList_Create(16, 16, 5, 1, 0, 1)
_GUIImageList_AddIcon($hImgLst1, $AutoItExe, -201)
_GUIImageList_AddIcon($hImgLst2, $AutoItExe, -202)
_GUIImageList_AddIcon($hImgLst3, $AutoItExe, -203)
_GUIImageList_AddIcon($hImgLst4, $AutoItExe, -204)
_GUIImageList_AddIcon($hImgLst5, $AutoItExe, -205)

; 110 200 290 380 470 560 650
$DelItem = GUICtrlCreateButton($LngDel, 290, 95, 80, 25)
GUICtrlSetTip(-1, $LngDelH & @CRLF & 'Ctrl+Del')
GUICtrlSetResizing(-1, 512 + 256 + 32 + 2)
_GUICtrlButton_SetImageList(-1, $hImgLst2, 0)
$EnterData = GUICtrlCreateButton($LngFill, 200, 95, 80, 25)
GUICtrlSetTip(-1, $LngFillH & @CRLF & 'Ctrl+PageUp')
GUICtrlSetResizing(-1, 512 + 256 + 32 + 2)
_GUICtrlButton_SetImageList(-1, $hImgLst3, 0)

$Default = GUICtrlCreateButton($LngDef, 380, 95, 80, 25)
GUICtrlSetTip(-1, $LngDefH & @CRLF & 'Ctrl+Enter')
GUICtrlSetResizing(-1, 512 + 256 + 32 + 2)
_GUICtrlButton_SetImageList(-1, $hImgLst5, 0)

$OpenRegE = GUICtrlCreateButton($LngOpn, 470, 95, 80, 25)
GUICtrlSetTip(-1, $LngOpnH & @CRLF & 'Ctrl+NumPad0')
GUICtrlSetResizing(-1, 512 + 256 + 32 + 2)
_GUICtrlButton_SetImageList(-1, $hImgLst1, 0)

$Add = GUICtrlCreateButton($LngAdd, 110, 95, 80, 25) ; 560, 24
GUICtrlSetTip(-1, $LngAddH & @CRLF & 'Ctrl+Space')
; GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 2)
_GUICtrlButton_SetImageList(-1, $hImgLst4, 0)

$DelProgid = GUICtrlCreateButton('', 527, 332, 23, 23)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
_GUICtrlButton_SetImageList(-1, $hImgLst2, 0)
GUICtrlSetState($DelProgid, 32)

$iDummy = GUICtrlCreateDummy()

$ContMenu = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
$hMenu = GUICtrlGetHandle($ContMenu)
$iOpEpl = _GUICtrlCreateODMenuItem($LngOpEpl & @TAB & 'Enter', $ContMenu, "shell32.dll", 4)
$iCMdel = _GUICtrlCreateODMenuItem($LngDel & @TAB & 'Ctrl+Del', $ContMenu, $AutoItExe, 202)
$iCMDef = _GUICtrlCreateODMenuItem($LngDef & @TAB & 'Ctrl+Enter', $ContMenu, $AutoItExe, 205)
$iCMreg = _GUICtrlCreateODMenuItem($LngOpn & ' RegEdit' & @TAB & 'Ctrl+NumPad0', $ContMenu, $AutoItExe, 201)

Dim $AccelKeys[10][2] = [["^{PGDN}", $Read],["^{PGUP}", $EnterData],["^{DEL}", $DelItem],["^{Enter}", $Default],["{Enter}", $iDummy],["^{NUMPAD0}", $OpenRegE],["^{DOWN}", $Export],["^{UP}", $Create],["^{SPACE}", $Add],["{F1}", $iHelp]]

GUISetAccelerators($AccelKeys)

Global $hImgLstTmp = _GUIImageList_Create(16, 16, 5, 1, 0, 1) ; Создаём иконку для кнопки "смена иконки расширения"
_GUIImageList_AddIcon($hImgLstTmp, @SystemDir & "\shell32.dll") ; добавляем одну иконку и впоследствии меняем её

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

GUISetState()
While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $iHKCR, $iHKCU, $iHKLM
			If BitAND(GUICtrlRead($iHKCR), 1) Then
				$iTrKey = 0
				$sWorkKey = 'HKCR\'
			ElseIf BitAND(GUICtrlRead($iHKCU), 1) Then
				$iTrKey = 1
				$sWorkKey = 'HKCU\Software\Classes\'
			ElseIf BitAND(GUICtrlRead($iHKLM), 1) Then
				$iTrKey = 2
				$sWorkKey = 'HKLM\SOFTWARE\Classes\'
			EndIf
			IniWrite($Ini, "Setting", "CRCULM", $iTrKey)
		Case $iHelp
			If FileExists(@ScriptDir & '\ContMenuFiles.chm') Then ShellExecute(@ScriptDir & '\ContMenuFiles.chm')
		Case $iOpEpl
			_OpenExplorer()
		Case $SelFile
			$tmp = FileOpenDialog('', @ProgramFilesDir & "\", "File (*.exe;*.cmd;*.bat)", 1 + 2, '', $Gui)
			If @error Then ContinueLoop
			GUICtrlSetData($Run, '"' & $tmp & '" "%1"')
			$tmp = StringRegExpReplace($tmp, '(^.*)\\(.*)\.(.*)$', '\2')
			GUICtrlSetData($Name, $tmp)
			GUICtrlSetData($NameMenu, $LngDRP & ' ' & $tmp)
		Case $Rebuild_Icon
			_RebuildShellIconCache()
		Case $iDummy
			; MsgBox(0, '', ControlGetFocus($Gui))
			Switch ControlGetFocus($Gui)
				Case 'Edit1'
					_Read()
				Case 'Edit4', 'Edit2', 'Edit3'
					_Add()
				Case 'SysListView321'
					_OpenExplorer()
			EndSwitch
		Case $aTreeViewItem[1] To $aTreeViewItem[$aTypeSec[0][0]]
			$jj = $msg - $aTreeViewItem[1] + 1
			If $IndGr = $jj Then
				$TrTV = Not $TrTV ; триггер позволил сворачивать / разворачивать пункт
				If $TrTV Then
					ControlTreeView($Gui, "", $treeview, 'Collapse', '#' & $jj - 1)
				Else
					; ControlTreeView ($Gui, "", $treeview, 'Expand', '#'&$jj-1)
					GUICtrlSetState($aTreeViewItem[$jj], $GUI_EXPAND + $GUI_DEFBUTTON)
				EndIf
			Else
				_GUICtrlTreeView_Expand($hTreeView, 0, False)
				; ControlTreeView ($Gui, "", $treeview, "Collapse") ; это для всех не работает
				GUICtrlSetState($aTreeViewItem[$jj], $GUI_EXPAND + $GUI_DEFBUTTON)
				$TrTV = False
				$IndGr = $jj
			EndIf
		Case $aTypeV[1][0] To $aTypeV[$aTypeV[0][0]][0]
			$jj = $msg - $aTypeV[1][0] + 1
			GUICtrlSetData($Type, $aTypeV[$jj][1])
			_Read()
		Case -13
			If StringInStr(FileGetAttrib(@GUI_DragFile), "D") Then
				GUICtrlSetData($Type, $Type0)
				GUICtrlSetData($Run, $RunR0)
				GUICtrlSetData($Name, $NameR0)
				GUICtrlSetData($NameMenu, $NameMenuR0)
				ContinueLoop
			EndIf
			$DragExt = StringRight(@GUI_DragFile, 4)

			Switch $DragExt
				Case ".lnk"
					Local $aLNK = FileGetShortcut(@GUI_DragFile)
					If StringRight($aLNK[0], 4) <> ".exe" Then
						GUICtrlSetData($Run, '')
						GUICtrlSetData($Type, $Type0)
						ContinueLoop
					EndIf
					GUICtrlSetData($Run, '"' & $aLNK[0] & '" "%1"')
					$aLNK[0] = StringRegExpReplace($aLNK[0], '(^.*)\\(.*)\.(.*)$', '\2')
					GUICtrlSetData($Name, $aLNK[0])
					GUICtrlSetData($NameMenu, $LngDRP & ' ' & $aLNK[0])
					GUICtrlSetData($Type, $Type0)
				Case ".exe"
					GUICtrlSetData($Run, '"' & @GUI_DragFile & '" "%1"')
					$Exe = StringRegExpReplace(@GUI_DragFile, '(^.*)\\(.*)\.(.*)$', '\2')
					GUICtrlSetData($Name, $Exe)
					GUICtrlSetData($NameMenu, $LngDRP & ' ' & $Exe)
					GUICtrlSetData($Type, $Type0)
				Case Else
					GUICtrlSetData($Type, StringRegExpReplace(@GUI_DragFile, '.*\.(\S+)', '\1'))
					GUICtrlSetData($Run, $RunR0)
					GUICtrlSetData($Name, $NameR0)
					GUICtrlSetData($NameMenu, $NameMenuR0)
					_Read()
			EndSwitch
			_Mem()

		Case $OpnIni
			If Not $Editor Then
				$Editor = _FileAssociation('.txt')
				If @error Or Not FileExists($Editor) Then $Editor = @SystemDir & '\notepad.exe'
			EndIf
			Run('"' & $Editor & '" "' & $Ini & '"')

		Case $IMOpenF
			ShellExecute(@ScriptDir)

		Case $NotFn
			$Data = ''
			For $i = 1 To $aTypeSec[0][0]
				$aGrTypeTmp = StringSplit($aTypeSec[$i][1], '|')
				$Data &= $aTypeSec[$i][0] & ' = '
				For $d = 1 To $aGrTypeTmp[0]
					$Err1 = 2
					RegEnumKey('HKEY_CLASSES_ROOT\.' & $aGrTypeTmp[$d], 1)
					If @error Then $Err1 -= 1
					RegEnumVal('HKEY_CLASSES_ROOT\.' & $aGrTypeTmp[$d], 1)
					If @error Then $Err1 -= 1
					If $Err1 = 0 Then $Data &= $aGrTypeTmp[$d] & ', '
				Next
				$Data &= @CRLF
			Next
			$Data = StringRegExpReplace($Data, ', ' & @CRLF, @CRLF)
			$Data = StringRegExpReplace($Data, '\w+ = ' & @CRLF, '')
			MsgBox(0, $LngMS9, $Data, 0, $Gui)

		Case $IMDelGr
			If $Tr = 0 Then ContinueLoop
			$item000 = ControlListView($Gui, '', 'SysListView321', 'GetSelected') + 1
			If _test() Then ContinueLoop
			If MsgBox(4, $LngMS1, 'HKEY_CLASSES_ROOT\< ' & $aTypeSec[$IndGr][0] & ' >\shell\' & $aRunR[$item000][0], 0, $Gui) = 6 Then
				$aGrTypeTmp = StringSplit($aTypeSec[$IndGr][1], '|')
				For $i = 1 To $aGrTypeTmp[0]
					$ProgidR = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $aGrTypeTmp[$i], 'Progid')
					If Not @error And $ProgidR <> '' Then
						$TypeNR = $ProgidR
					Else
						$TypeNR = RegRead('HKEY_CLASSES_ROOT\.' & $aGrTypeTmp[$i], '')
						If @error Then ContinueLoop
					EndIf

					RegDelete('HKEY_CLASSES_ROOT\' & $TypeNR & '\shell\' & $aRunR[$item000][0])
				Next
				_Read()
			EndIf

		Case $IMAddGr
			$Name0 = GUICtrlRead($Name)
			$NameMenu0 = GUICtrlRead($NameMenu)
			$Run0 = GUICtrlRead($Run)
			If $Name0 = '' Or $Run0 = '' Then
				MsgBox(0, $LngErr, $LngMS2, 0, $Gui)
				ContinueLoop
			EndIf

			$aGrTypeTmp = StringSplit($aTypeSec[$IndGr][1], '|')

			For $i = 1 To $aGrTypeTmp[0]
				$ProgidR = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $aGrTypeTmp[$i], 'Progid')
				If Not @error And $ProgidR <> '' Then
					$TypeNR = $ProgidR
				Else
					$TypeNR = RegRead('HKEY_CLASSES_ROOT\.' & $aGrTypeTmp[$i], '')
					If @error Then ContinueLoop
				EndIf

				RegWrite($sWorkKey & $TypeNR & '\shell\' & $Name0 & '\command', '', 'REG_SZ', $Run0)
				If $NameMenu0 <> '' Then RegWrite($sWorkKey & $TypeNR & '\shell\' & $Name0, '', 'REG_SZ', $NameMenu0)
			Next
			_Read()
			_Mem()

		Case $IMDefGr
			If $Tr = 0 Then ContinueLoop
			$item000 = ControlListView($Gui, '', 'SysListView321', 'GetSelected') + 1
			If _test() Then ContinueLoop
			$aGrTypeTmp = StringSplit($aTypeSec[$IndGr][1], '|')
			For $i = 1 To $aGrTypeTmp[0]
				$ProgidR = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $aGrTypeTmp[$i], 'Progid')
				If Not @error And $ProgidR <> '' Then
					$TypeNR = $ProgidR
				Else
					$TypeNR = RegRead('HKEY_CLASSES_ROOT\.' & $aGrTypeTmp[$i], '')
					If @error Then ContinueLoop
				EndIf
				If _Reg_Exists('HKEY_CLASSES_ROOT\' & $TypeNR & '\shell\' & $aRunR[$item000][0]) Then RegWrite($sWorkKey & $TypeNR & '\shell', '', 'REG_SZ', $aRunR[$item000][0])
			Next
			_Read()

		Case $IMExpGr
			$aGrTypeTmp = StringSplit($aTypeSec[$IndGr][1], '|')

			$Data = ''
			For $i = 1 To $aGrTypeTmp[0]

				$ProgidR = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $aGrTypeTmp[$i], 'Progid')
				If Not @error And $ProgidR <> '' Then
					$TypeNR = $ProgidR
				Else
					$TypeNR = RegRead('HKEY_CLASSES_ROOT\.' & $aGrTypeTmp[$i], '')
					If @error Then ContinueLoop
				EndIf

				$RunR = RegEnumKey('HKEY_CLASSES_ROOT\' & $TypeNR & '\shell', 1)
				If @error Then ContinueLoop
				GUICtrlSetData($StatusBar, $LngExp & ' ' & $aGrTypeTmp[$i])

				$tmp = ''
				_RegExport_X('HKEY_CLASSES_ROOT\.' & $aGrTypeTmp[$i], $tmp)
				$Data &= @CRLF & ';================' & @CRLF & $tmp
				$tmp = ''
				_RegExport_X('HKEY_CLASSES_ROOT\' & $TypeNR, $tmp)
				$Data &= @CRLF & ';================' & @CRLF & $tmp
				$tmp = ''
				_RegExport_X('HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $aGrTypeTmp[$i], $tmp)
				$Data &= @CRLF & ';================' & @CRLF & $tmp
			Next
			$tmp = ''

			$filename = @ScriptDir & '\Backup'
			If Not FileExists($filename) Then DirCreate($filename)
			$i = 0
			While FileExists($filename & '\!Gr_' & $aTypeSec[$IndGr][0] & '_' & $i & '.reg')
				$i += 1
			WEnd

			$file = FileOpen($filename & '\!Gr_' & $aTypeSec[$IndGr][0] & '_' & $i & '.reg', 2)
			FileWrite($file, 'Windows Registry Editor Version 5.00' & @CRLF & @CRLF & $Data)
			FileClose($file)
			$Data = ''
			_Read()
			GUICtrlSetData($StatusBar, $LngExp & ' ' & $LngSb1 & ' Backup\!Gr_' & $aTypeSec[$IndGr][0] & '_' & $i & '.reg')

		Case $IMExpAll

			$Data = ''
			For $i = 1 To $aTypeV[0][0]

				$ProgidR = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $aTypeV[$i][1], 'Progid')
				If Not @error And $ProgidR <> '' Then
					$TypeNR = $ProgidR
				Else
					$TypeNR = RegRead('HKEY_CLASSES_ROOT\.' & $aTypeV[$i][1], '')
					If @error Then ContinueLoop
				EndIf

				$RunR = RegEnumKey('HKEY_CLASSES_ROOT\' & $TypeNR & '\shell', 1)
				If @error Then ContinueLoop
				GUICtrlSetData($StatusBar, $LngExp & ' ' & $aTypeV[$i][1])

				$tmp = ''
				_RegExport_X('HKEY_CLASSES_ROOT\.' & $aTypeV[$i][1], $tmp)
				$Data &= @CRLF & ';================' & @CRLF & $tmp
				$tmp = ''
				_RegExport_X('HKEY_CLASSES_ROOT\' & $TypeNR, $tmp)
				$Data &= @CRLF & ';================' & @CRLF & $tmp
				$tmp = ''
				_RegExport_X('HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $aTypeV[$i][1], $tmp)
				$Data &= @CRLF & ';================' & @CRLF & $tmp
			Next
			$tmp = ''

			$filename = @ScriptDir & '\Backup'
			If Not FileExists($filename) Then DirCreate($filename)
			$i = 0
			While FileExists($filename & '\!All_' & $i & '.reg')
				$i += 1
			WEnd

			$file = FileOpen($filename & '\!All_' & $i & '.reg', 2)
			FileWrite($file, 'Windows Registry Editor Version 5.00' & @CRLF & @CRLF & $Data)
			FileClose($file)
			$Data = ''
			_Read()
			GUICtrlSetData($StatusBar, $LngExp & ' ' & $LngSb1 & ' Backup\!All_' & $i & '.reg')

		Case $Export
			$Type0 = GUICtrlRead($Type)

			$ProgidR = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $Type0, 'Progid')
			If Not @error And $ProgidR <> '' Then
				$TypeNR = $ProgidR
			Else
				$TypeNR = RegRead('HKEY_CLASSES_ROOT\.' & $Type0, '')
				If @error Then ContinueLoop
			EndIf

			$RunR = RegEnumKey('HKEY_CLASSES_ROOT\' & $TypeNR & '\shell', 1)
			If @error Then ContinueLoop

			$filename = @ScriptDir & '\Backup'
			If Not FileExists($filename) Then DirCreate($filename)
			$i = 0
			While FileExists($filename & '\' & $Type0 & '_' & $TypeNR & '_' & $i & '.reg')
				$i += 1
			WEnd

			$Data = 'Windows Registry Editor Version 5.00' & @CRLF & @CRLF
			_RegExport_X('HKEY_CLASSES_ROOT\.' & $Type0, $Data)
			$tmp = ''
			_RegExport_X('HKEY_CLASSES_ROOT\' & $TypeNR, $tmp)
			$Data &= @CRLF & ';================' & @CRLF & $tmp
			$tmp = ''
			_RegExport_X('HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $Type0, $tmp)
			$Data &= @CRLF & ';================' & @CRLF & $tmp

			$file = FileOpen($filename & '\' & $Type0 & '_' & $TypeNR & '_' & $i & '.reg', 2)
			FileWrite($file, $Data)
			FileClose($file)
			$Data = ''
			_Read()
			GUICtrlSetData($StatusBar, $LngExp & ' ' & $TypeNR & ' ' & $LngSb1 & ' Backup\' & $Type0 & '_' & $TypeNR & '_' & $i & '.reg.')

		Case $EnterData
			_EnterData()

		Case $OpenRegE, $iCMreg
			If $Tr = 0 Then ContinueLoop
			$item000 = ControlListView($Gui, '', 'SysListView321', 'GetSelected') + 1
			If _test() Then ContinueLoop
			_JumpRegistry('HKEY_CLASSES_ROOT\' & $TypeNR & '\shell\' & $aRunR[$item000][0] & '\command')

		Case $Default, $iCMDef
			If $Tr = 0 Then ContinueLoop
			$item000 = ControlListView($Gui, '', 'SysListView321', 'GetSelected') + 1
			If _test() Then ContinueLoop
			RegWrite('HKEY_CLASSES_ROOT\' & $TypeNR & '\shell', '', 'REG_SZ', $aRunR[$item000][0])
			_Read()

		Case $DelItem, $iCMdel
			If $Tr = 0 Then ContinueLoop
			$item000 = ControlListView($Gui, '', 'SysListView321', 'GetSelected') + 1
			If _test() Then ContinueLoop
			If MsgBox(4, $LngMS1, 'HKEY_CLASSES_ROOT\' & $TypeNR & '\shell\' & $aRunR[$item000][0], 0, $Gui) = 6 Then
				RegDelete('HKEY_CLASSES_ROOT\' & $TypeNR & '\shell\' & $aRunR[$item000][0])
				_Read()
			EndIf

		Case $DelProgid
			$Type0 = GUICtrlRead($Type)
			If MsgBox(4, $LngMS1, 'HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $Type0 & @CRLF & 'ProgID=' & $TypeNR, 0, $Gui) = 6 Then
				RegDelete('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $Type0, 'ProgID')
				_Read()
			EndIf

		Case $Add
			_Add()

		Case $Create
			_CreateType()

		Case $icodll
			_seticodll()

		Case $Read
			_Read()

		Case $About; , $IMAbout
			_About()
			; Case $IMurl
			; ShellExecute ('http://azjio.ucoz.ru')
		Case $restart; , $IMrestart
			_restart()
		Case -3; , $IMExit
			Exit
	EndSwitch
WEnd

Func _OpenExplorer()
	Local $tmp = _GetPath(_GUICtrlListView_GetItemText($hListView, $iInxSel, 1))
	If Not @error Then Run('Explorer.exe /select,"' & $tmp & '"')
	; ShellExecute(StringRegExpReplace($item000, '(^.*)\\(.*)$', '\1'))
EndFunc   ;==>_OpenExplorer

Func _GetPath($Path)
	$Path = StringRegExp($Path, '(?i)(^.*?\.(?:exe|cmd|bat)).*$', 3)
	If @error Then Return SetError(1)
	$Path = StringReplace($Path[0], '"', '')
	Opt('ExpandEnvStrings', 1)
	If FileExists($Path) Then
		$Path = $Path ; превращение %переменной% в явный текст
		Opt('ExpandEnvStrings')
		Return $Path
	EndIf
	Opt('ExpandEnvStrings')
	Local $tmp = _WinAPI_PathFindOnPath($Path)
	If Not @error Then Return $tmp
	If FileExists(@SystemDir & '\' & $Path) Then
		Return @SystemDir & '\' & $Path
	ElseIf FileExists(@WindowsDir & '\' & $Path) Then
		Return @WindowsDir & '\' & $Path
	EndIf
	Return SetError(1)
EndFunc   ;==>_GetPath

Func _EnterData()
	If $Tr = 0 Then Return
	$item000 = ControlListView($Gui, '', 'SysListView321', 'GetSelected') + 1
	If _test() Then Return
	GUICtrlSetData($Name, $aRunR[$item000][0])
	GUICtrlSetData($Run, $aRunR[$item000][1])
	GUICtrlSetData($NameMenu, $aRunR[$item000][2])

	_Mem()
EndFunc   ;==>_EnterData

Func _Add()
	; Читаем поля
	$Type0 = GUICtrlRead($Type)
	$Name0 = GUICtrlRead($Name)
	$NameMenu0 = GUICtrlRead($NameMenu)
	$Run0 = GUICtrlRead($Run)
	; Если поля пустые, то...
	If $Type0 = '' Or $Name0 = '' Or $Run0 = '' Then
		MsgBox(0, $LngErr, $LngMS2, 0, $Gui)
		Return
	EndIf

	; читаем из реестре Progid
	$ProgidR = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $Type0, 'Progid')
	If Not @error And $ProgidR Then ; если нет ошибки Progid не пустой
		$TypeNR = $ProgidR
	Else ; иначе читаем основной раздел
		$TypeNR = RegRead('HKEY_CLASSES_ROOT\.' & $Type0, '')
		If @error Then
			_CreateType()
			Return ; если нет данных, то игнорируем событие вызова
		EndIf
	EndIf


	RegWrite($sWorkKey & $TypeNR & '\shell\' & $Name0 & '\command', '', 'REG_SZ', $Run0)
	If $NameMenu0 <> '' Then RegWrite($sWorkKey & $TypeNR & '\shell\' & $Name0, '', 'REG_SZ', $NameMenu0)
	_Read()
	_Mem()
EndFunc   ;==>_Add

Func _CreateType()
	$Type0 = GUICtrlRead($Type)
	$Name0 = GUICtrlRead($Name)
	$NameMenu0 = GUICtrlRead($NameMenu)
	$Run0 = GUICtrlRead($Run)
	If $Type0 = '' Or $Name0 = '' Or $Run0 = '' Then
		MsgBox(0, $LngErr, $LngMS2, 0, $Gui)
		Return
	EndIf

	$tmp = RegRead('HKEY_CLASSES_ROOT\.' & $Type0, '')
	If Not @error And MsgBox(4, $LngErr, $LngExt & ' ' & $Type0 & ' ' & $LngMS4, 0, $Gui) = 7 Then
		Return
	Else
		If $tmp = '' Then
			$newName = $Type0 & 'file'
		Else
			$newName = $tmp
		EndIf
	EndIf

	Local $GP = WinGetPos($Gui)
	; Local $GP = _GetPosClient($hListView)
	$Err1 = 2
	Do
		$otvet = 7
		$newName = InputBox($LngIB1, $LngIB2 & @CRLF, $newName, "", 170, 130, $GP[0] + 60, $GP[1], 0, $Gui)
		If @error Then Return
		RegEnumKey('HKEY_CLASSES_ROOT\' & $newName, 1)
		If @error Then $Err1 -= 1
		RegEnumVal('HKEY_CLASSES_ROOT\' & $newName, 1)
		If @error Then $Err1 -= 1
		If $Err1 = 0 Then
			$otvet = 6
		Else
			$Err1 = 2
			If MsgBox(4, $LngErr, $LngMS5 & ' ' & $newName & ' ' & $LngMS4, 0, $Gui) = 6 Then $otvet = 6
		EndIf
	Until $otvet = 6

	RegWrite($sWorkKey & '.' & $Type0, '', 'REG_SZ', $newName)
	RegWrite($sWorkKey & $newName & '\shell\' & $Name0 & '\command', '', 'REG_SZ', $Run0)
	If $NameMenu0 <> '' Then RegWrite($sWorkKey & $newName & '\shell\' & $Name0, '', 'REG_SZ', $NameMenu0)
	_Read()
	_Mem()
EndFunc   ;==>_CreateType

; Func _GetPosClient($hWnd)
; If Not IsHWnd($hWnd) Then Return SetError(1)
; Local $tPoint = DllStructCreate("int X;int Y")
; DllStructSetData($tPoint, "X", 0)
; DllStructSetData($tPoint, "Y", 0)
; _WinAPI_ClientToScreen($hWnd, $tPoint)
; Local $aXY[2]
; $aXY[0] = DllStructGetData($tPoint, "X")
; $aXY[1] = DllStructGetData($tPoint, "Y")
; Return $aXY
; EndFunc

Func _seticodll()
	If $Tr = 0 Then Return
	_Read()
	If $TypeNR = '' Then
		MsgBox(0, $LngErr, $LngMS3, 0, $Gui)
		Return
	EndIf

	If $TrIco = 0 Then
		$fdr = @SystemDir
		$TrIco = 1
	Else
		$fdr = @WorkingDir
	EndIf
	;Открытие файла библиотеки значков
	$sFileName = FileOpenDialog($LngFOD, $fdr, $LngFOD1 & " (*.dll;*.ocx;*.ico)", 1, $FileDll, $Gui)
	If @error Then Return
	If Not StringInStr(';.dll;.osx;.ico;', ';' & StringRight($sFileName, 4) & ';') Then $sFileName &= '.dll'
	If Not FileExists($sFileName) Then Return
	If StringRight($sFileName, 4) = '.ico' Then
		RegWrite($sWorkKey & $TypeNR & '\DefaultIcon', '', 'REG_SZ', $sFileName)
	Else
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		; Создаёт структуру для хранения индекса иконки
		$stIcon = DllStructCreate("int")
		$stString = DllStructCreate("wchar[260]")
		$structsize = DllStructGetSize($stString) / 2
		DllStructSetData($stString, 1, $sFileName)

		; Запускает PickIconDlg - с порядковым номером '62' для этой функции
		Local $aRes = DllCall("shell32.dll", "int", 62, "hwnd", 0, "ptr", DllStructGetPtr($stString), "int", $structsize, "ptr", DllStructGetPtr($stIcon))
		If @error Or Not $aRes[0] Then Return ; нажатие кнопки "Отмена" или закрыть окно

		$sFileName = DllStructGetData($stString, 1)
		$nIconIndex = DllStructGetData($stIcon, 1) ; Получение номера иконки
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		$stIcon = 0
		RegWrite($sWorkKey & $TypeNR & '\DefaultIcon', '', 'REG_SZ', $sFileName & ',' & $nIconIndex)
		$FileDll = StringRegExpReplace($sFileName, '(^.*)\\(.*)$', '\2')
	EndIf

	_Read()
	DllCall("shell32.dll", "none", "SHChangeNotify", "long", '0x8000000', "uint", '0x1000', "ptr", '0', "ptr", '0')
EndFunc   ;==>_seticodll

Func _Mem()
	$RunR0 = GUICtrlRead($Run)
	$NameR0 = GUICtrlRead($Name)
	$NameMenuR0 = GUICtrlRead($NameMenu)
EndFunc   ;==>_Mem

Func _test()
	If $TypeNR = '' Or $aRunR[$item000][0] = '' Then
		MsgBox(0, $LngErr, $LngMS3, 0, $Gui)
		Return 1
	Else
		Return 0
	EndIf
EndFunc   ;==>_test

Func _Read($TypeA = 0)
	$Type0 = GUICtrlRead($Type)
	If $Type0 = '' Then Return

	$aRunR = ''
	Dim $aRunR[11][3]
	GUICtrlSendMsg($ReadInfo, $LVM_DELETEALLITEMS, 0, 0)
	$TypeNR = RegRead('HKEY_CLASSES_ROOT\.' & $Type0, '')
	If @error Then
		$TypeNR = RegEnumVal('HKEY_CLASSES_ROOT\.' & $Type0 & '\OpenWithProgids', 1)
		If @error Then
			_setico(1)
			GUICtrlSetData($StatusBar, '')
			GUICtrlSetState($DelProgid, 32)
			Return
		EndIf
	EndIf
	$tmp = $TypeNR

	$ProgidR = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $Type0, 'Progid')
	If Not @error And $ProgidR Then
		GUICtrlSetState($DelProgid, 16)
		GUICtrlSetTip($DelProgid, $LngPidH & @CRLF & $ProgidR)
		$TypeNR = $ProgidR
	Else
		GUICtrlSetState($DelProgid, 32)
	EndIf

	$aRunR[0][0] = $TypeNR

	For $i = 1 To 10
		$NameR = RegEnumKey('HKEY_CLASSES_ROOT\' & $TypeNR & '\shell', $i)
		If @error Then ExitLoop
		$RunR = RegRead('HKEY_CLASSES_ROOT\' & $TypeNR & '\shell\' & $NameR & '\command', '')
		If @error Then ContinueLoop
		$NameMenuR = RegRead('HKEY_CLASSES_ROOT\' & $TypeNR & '\shell\' & $NameR, '')
		If Not @error Then
			$aRunR[$i][2] = $NameMenuR
		Else
			$aRunR[$i][2] = ''
		EndIf
		$aRunR[$i][0] = $NameR
		$aRunR[$i][1] = $RunR
		GUICtrlCreateListViewItem($NameR & '|' & $RunR & '|' & $NameMenuR, $ReadInfo)
	Next
	For $i = 0 To 2 ; авторазмер колонок
		GUICtrlSendMsg($ReadInfo, $LVM_SETCOLUMNWIDTH, $i, -1)
		GUICtrlSendMsg($ReadInfo, $LVM_SETCOLUMNWIDTH, $i, -2)
	Next
	$Tr = 1
	_setico()
	GUICtrlSetData($StatusBar, $Type0 & ' \ ' & $tmp & ' \ Def=' & RegRead('HKEY_CLASSES_ROOT\' & $TypeNR & '\shell', '') & ' \ Progid=' & $ProgidR)
EndFunc   ;==>_Read

Func _setico($seter = 0)
	$ico1 = RegRead('HKEY_CLASSES_ROOT\' & $TypeNR & '\DefaultIcon', '')
	If @error Or $seter Then ; если иконка не найдена в реестре, то
		_ReplaceIconButton(@SystemDir & '\shell32.dll') ; устанавливаем безымянную иконку
		Return
	EndIf
	$ico1 = StringReplace($ico1, '"', '')
	Local $old = Opt('ExpandEnvStrings', 1)
	$ico1 = StringSplit($ico1, ',')
	If @error Then
		_ReplaceIconButton($ico1[1])
	Else
		If StringInStr($ico1[2], '-') Then
			_ReplaceIconButton($ico1[1], $ico1[2])
		Else
			_ReplaceIconButton($ico1[1], $ico1[2])
		EndIf
	EndIf
	Opt('ExpandEnvStrings', $old)
EndFunc   ;==>_setico

Func _ReplaceIconButton($sFile, $iIndex = 0)
	Local $pIcon, $tIcon, $hIcon
	$tIcon = DllStructCreate("int Icon") ; структура
	$pIcon = DllStructGetPtr($tIcon) ; указатель структуры
	$iCount = _WinAPI_ExtractIconEx($sFile, $iIndex, 0, $pIcon, 1) ; извлекает иконку из файла
	; If $iCount = 0 Or $iCount > 10000 Then _WinAPI_ExtractIconEx(@SystemDir & '\shell32.dll', 0, 0, $pIcon, 1)
	If $iCount = 0 Or $iCount > 10000 Then _WinAPI_ExtractIconEx($AutoItExe, -206, 0, $pIcon, 1)
	$hIcon = DllStructGetData($tIcon, "Icon") ; Получаем дескриптор иконки
	_GUIImageList_ReplaceIcon($hImgLstTmp, 0, $hIcon) ; заменяем единственную иконку
	_WinAPI_DestroyIcon($hIcon) ; удаляем дескриптор
	_GUICtrlButton_SetImageList($icodll, $hImgLstTmp, 0) ; устанавливаем иконку на кнопку
	$tIcon = 0
EndFunc   ;==>_ReplaceIconButton

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	; If $hWnd = $Gui Then
	Local $tMINMAXINFO = DllStructCreate("int;int;" & _
			"int MaxSizeX; int MaxSizeY;" & _
			"int MaxPositionX;int MaxPositionY;" & _
			"int MinTrackSizeX; int MinTrackSizeY;" & _
			"int MaxTrackSizeX; int MaxTrackSizeY", _
			$lParam)
	DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 568) ; минимальные размеры окна
	DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 412)
	$tMINMAXINFO = 0
	; EndIf
EndFunc   ;==>WM_GETMINMAXINFO

Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $tInfo

	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hListView
			Switch $iCode
				Case $NM_DBLCLK ; левый двойной клик мышкой по пункту
					; $tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
					_EnterData()

				Case $NM_RCLICK ; правый клик мышкой по пункту
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $lParam)
					$iInxSel = DllStructGetData($tInfo, "Index")
					If $iInxSel <> -1 Then
						$x = MouseGetPos(0)
						$y = MouseGetPos(1)
						DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $Gui, "ptr", 0)
					EndIf
			EndSwitch
	EndSwitch

	$tNMHDR = 0
	$tInfo = 0
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _About()
	Local $url, $WbMn
	Global $iScroll_Pos, $Gui1, $nLAbt, $hAbt, $wAbtBt
	$wAbt = 270
	$hAbt = 180
	$wAbtBt = 20
	$wA = $wAbt / 2 - 80
	$wB = $hAbt / 3 * 2
	$iScroll_Pos = -$hAbt
	$TrAbt1 = 0
	$TrAbt2 = 0
	$BkCol1 = 0xE1E3E7
	$BkCol2 = 0
	$GP = _ChildCoor($Gui, $wAbt, $hAbt)
	GUISetState(@SW_DISABLE, $Gui)
	$font = "Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	If Not @Compiled Then GUISetIcon($AutoItExe, 99)
	GUISetBkColor($BkCol1)
	GUISetFont(-1, -1, -1, $font)
	$vk1 = GUICtrlCreateButton(ChrW('0x25BC'), 0, $hAbt - 20, $wAbtBt, 20)

	GUICtrlCreateTab($wAbtBt, 0, $wAbt - $wAbtBt, $hAbt + 35, 0x0100 + 0x0004 + 0x0002)
	$tabAbt0 = GUICtrlCreateTabItem("0")

	GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt - $wAbtBt, $hAbt)
	GUICtrlSetState(-1, 128)
	GUICtrlSetBkColor(-1, $BkCol1)

	GUICtrlCreateLabel($LngTitle, 0, 0, $wAbt, $hAbt / 3, $SS_CENTER + $SS_CENTERIMAGE)
	GUICtrlSetFont(-1, 15, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, $hAbt / 3, $wAbt - 2, 1, 0x10)

	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer & ' 0.7.5  2013.05.23', $wA, $wB - 30, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', $wA, $wB - 15, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', $wA + 37, $wB - 15, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', $wA, $wB, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', $wA + 75, $wB, 125, 17)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010-2013', $wA, $wB + 15, 210, 17)

	$tabAbt1 = GUICtrlCreateTabItem("1")

	GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt - $wAbtBt, $hAbt)
	GUICtrlSetState(-1, 128)
	GUICtrlSetBkColor(-1, 0x000000)

	$StopPlay = GUICtrlCreateButton(ChrW('0x25A0'), 0, $hAbt - 41, $wAbtBt, 20)
	GUICtrlSetState(-1, 32)

	$nLAbt = GUICtrlCreateLabel($LngScrollAbt, $wAbtBt, $hAbt, $wAbt - $wAbtBt, 360, 0x1) ; центр
	GUICtrlSetFont(-1, 9, 400, 2, $font)
	GUICtrlSetColor(-1, 0x99A1C0)
	GUICtrlSetBkColor(-1, -2) ; прозрачный
	GUICtrlCreateTabItem('')
	GUISetState(@SW_SHOW, $Gui1)

	While 1
		Switch GUIGetMsg()
			Case $vk1
				If $TrAbt1 = 0 Then
					GUICtrlSetState($tabAbt1, 16)
					GUICtrlSetState($nLAbt, 16)
					GUICtrlSetState($StopPlay, 16)
					GUICtrlSetData($vk1, ChrW('0x25B2'))
					GUISetBkColor($BkCol2)
					If $TrAbt2 = 0 Then AdlibRegister('_ScrollAbtText', 40)
					$TrAbt1 = 1
				Else
					GUICtrlSetState($tabAbt0, 16)
					GUICtrlSetState($nLAbt, 32)
					GUICtrlSetState($StopPlay, 32)
					GUICtrlSetData($vk1, ChrW('0x25BC'))
					GUISetBkColor($BkCol1)
					AdlibUnRegister('_ScrollAbtText')
					$TrAbt1 = 0
				EndIf
			Case $StopPlay
				If $TrAbt2 = 0 Then
					AdlibUnRegister('_ScrollAbtText')
					GUICtrlSetData($StopPlay, ChrW('0x25BA'))
					$TrAbt2 = 1
				Else
					AdlibRegister('_ScrollAbtText', 40)
					GUICtrlSetData($StopPlay, ChrW('0x25A0'))
					$TrAbt2 = 0
				EndIf
			Case $url
				ShellExecute('http://azjio.ucoz.ru')
			Case $WbMn
				ClipPut('R939163939152')
			Case -3
				AdlibUnRegister('_ScrollAbtText')
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($Gui1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>_About

Func _ScrollAbtText()
	$iScroll_Pos += 1
	ControlMove($Gui1, "", $nLAbt, $wAbtBt, -$iScroll_Pos)
	If $iScroll_Pos > 360 Then $iScroll_Pos = -$hAbt
EndFunc   ;==>_ScrollAbtText