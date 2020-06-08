#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=ReName.exe
#AutoIt3Wrapper_icon=ReName.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=ReName.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Field=Version|0.3
#AutoIt3Wrapper_Res_Field=Build|2011.09.21
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; AZJIO 21.09.2011 (AutoIt3_v3.3.6.1)

#NoTrayIcon
Opt("GUIOnEventMode", 1)
#include <Crypt.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiListView.au3>
Opt("GUIResizeMode", 802)
Global $aFL='', $DrPath='', $FullList='', $TrTest=1, $Otkat='', $kFile=200, $kFile0=0, $OpenTrnstF=@ScriptDir&'\Translits\Russian.txt'
Global $iScroll_Pos, $Gui, $Gui1, $nLAbt, $hAbt, $wAbtBt, $TrAbt1, $TrAbt2, $tabAbt1, $StopPlay, $vk1, $BkCol2, $tabAbt0, $BkCol1
Global $ComboType, $Mask, $SubFolder, $SubFolder0=1, $AutuOtkat, $AutuOtkat0=4, $ObrabatExt, $ObrabatExt0=4, $KolTstInp, $exclude, $exclude0=True

; En
$LngTitle='ReName'
$LngAbout='About'
$LngVer='Version'
$LngSite='Site'
$LngCopy='Copy'
$LngSb1='StatusBar		( drag-and-drop )'
$LngRe='Restart Program'
$LngOpF='Open'
$LngAdd='Add'
$LngMod='Modification'
$LngDel='Delete'
$LngSea='Find'
$LngRep='Replace'
$LngSmRep='Simple replacement (not regexp)'
$LngStr='Rename'
$LngStrH='Run rename subdirectories'
$LngTst='Test'
$LngTstH='Preview of future names, only the first 200 files'
$LngTxt='Text'
$LngSel='Choose'
$LngExp='Expansion'
$LngTrn='Transliteration'
$LngRDT='Reverse direction'
$LngRNm='Recovery'
$LngAr0='None'
$LngAr1='Swap. Separator _'
$LngAr2='Swap. Separator "space"'
$LngAr3='Swap. Separator -'
$LngAr4='Remove 3 letters beginning'
$LngAr5='Remove 3 letters of the late'
$LngAr6='Delete 4 characters from the 2 nd'
$LngAr7='Remove special characters'
$LngAr8='mp3, remove numbers beginning'
$LngCA1='File size in bytes'
$LngCA2='File size in KB'
$LngCA3='File size in MB'
$LngCA4='File date'
$LngABN='At the beginning'
$LngAEN='At the end'
$LngROp='Open'
$LngRSv='Save'
$LngRVw='Display'
$LngRRc='Recovery'
$LngRL5='Create list MD5'
$LngRR5='Restore using MD5'
$LngOpt='Options'
$LngExF='Extensions of the files (* = all)'
$LngUpL='Refresh List'
$LngExc='Exclude'
$LngInS='Including subdirectories'
$LngASR='Autosave recovery list'
$LngASRH='Performed after each execution'&@CRLF&'of a rename always a new file'
$LngExt='including extensions'
$LngKolTst='Number of files to test'
$LngLVT='Name|New name'
$LngDF='Open'
$LngDF1='List_of_recovery'
$LngDF2='Text File'
$LngDF3='Save As ...'
$LngSb2='Selected file'
$LngSb3='Create a list of files...'
$LngSb4='Renaming files in list...'
$LngSb5='Computation of MD5 checksums of files...'
$LngSb6='List was created.'
$LngSb7='View a list of recovery.'
$LngSb8='Completed renaming files.'
$LngSb9='The list is not renamed files.'
$LngSb10='Current path'
$LngSb11='Are recovering ...'
$LngMs1='Message'
$LngMs2='None'
$LngMs3='Select the action'
$LngMs4='The choice is not'
; $LngMs5='Number of duplicates with different names in one folder :'
; $LngMs6='Before renaming want to create a "List MD5". Standard recovery will not happen. Continue?'
$LngMs7='File not found or invalid mask'
$LngUpp='Upper case'
$LngLwr='Lower case'
$LngRstr='First upper'
$LngErrLb='On this tab,'&@CRLF&'there is no recovery'
$LngGen='Generation'
$LngNmrG='Number'
$LngTxtG='Text'
$LngSep='Separator'
$LngWdth='Minimum'&@CRLF&'width'

$LngScrollAbt = 'The tool is designed' & @CRLF & _
'to rename files.' & @CRLF & @CRLF & _
'Allows you to select a rule, ' &  _
'perform the preview, ' &  _
'makes recovery provided backup names.' & @CRLF & @CRLF & _
'The utility is written in AutoIt3' & @CRLF & _
'autoitscript.com'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngTitle='ReName'
	$LngAbout='О программе'
	$LngVer='Версия'
	$LngSite='Сайт'
	$LngCopy='Копировать'
	$LngSb1='Строка состояния		( перетащи каталог в таблицу )'
	$LngRe='Перезапуск утилиты'
	$LngOpF='Открыть'
	$LngAdd='Добавить'
	$LngMod='Модификация'
	$LngDel='Удалить'
	$LngSea='Искать'
	$LngRep='Заменить'
	$LngSmRep='Обычная замена (не regexp)'
	$LngStr='Переименовать'
	$LngStrH='Выполнить переименование'&@CRLF&'включая подкаталоги'
	$LngTst='Предпросмотр'
	$LngTstH='Предпросмотр будущих имён'&@CRLF&'только первые 200 файлов'
	$LngTxt='Текст'
	$LngSel='Выбрать'
	$LngExp='Расширение'
	$LngTrn='Транслит'
	$LngRDT='Обратное направление'
	$LngRNm='Восстановление'
	$LngAr0='Ничего'
	$LngAr1='Поменять местами, делит _'
	$LngAr2='Поменять местами, делит пробел'
	$LngAr3='Поменять местами, делит тире'
	$LngAr4='Удалить 3 символа начала'
	$LngAr5='Удалить 3 символа конца'
	$LngAr6='Удалить 4 символа со 2-го'
	$LngAr7='Удалить спец-символы'
	$LngAr8='mp3 убрать цифры начала'
	$LngCA1='Размер файла в байтах'
	$LngCA2='Размер файла в кб'
	$LngCA3='Размер файла в Мб'
	$LngCA4='Дату файла'
	$LngABN='В начало имени'
	$LngAEN='В конец имени'
	$LngROp='Открыть список восстановления'
	$LngRSv='Сохранить список восстановления'
	$LngRVw='Отобразить список восстановления'
	$LngRRc='Восстановить предыдущие имена'
	$LngRL5='Создать список восстановления с MD5'
	$LngRR5='Восстановить имена по списку MD5'
	$LngOpt='Опции'
	$LngExF='Расширения обрабатываемых файлов (* = все)'
	$LngUpL='Обновить список'
	$LngExc='Исключить указанные в маске'
	$LngInS='Включая вложенные каталоги'
	$LngASR='Автосохранение списка восстановления'
	$LngASRH='Выполняется после каждого выполнения'&@CRLF&'переименования, всегда в новый файл'
	$LngExt='Обрабатывать расширения'
	$LngKolTst='Количество файлов для теста'
	$LngLVT='Имя|Новое имя'
	$LngDF='Открыть'
	$LngDF1='Список_отката'
	$LngDF2='Текстовый файл'
	$LngDF3='Сохранить как ...'
	$LngSb2='Выбран файл'
	$LngSb3='Создание списка файлов...'
	$LngSb4='Переименование файлов по списку...'
	$LngSb5='Вычисление контрольных сумм MD5 файлов...'
	$LngSb6='Список создан.'
	$LngSb7='Просмотр списка восстановления.'
	$LngSb8='Переименование файлов выполнено.'
	$LngSb9='Список непереименованных файлов.'
	$LngSb10='Текущий путь'
	$LngSb11='Выполняется откат...'
	$LngMs1='Сообщение'
	$LngMs2='Отсутствует'
	$LngMs3='Не выбрано преобразование имён'
	$LngMs4='Отсутствует файл транслитерации'
	; $LngMs5='Количество разноимённых дубликатов'&@CRLF&'в одноимённых папках :'
	; $LngMs6='Перед переименованием требуется создать'&@CRLF&'"Список MD5", стандартного отката не будет.'&@CRLF&'Продолжить?'
	$LngMs7='Файлов не найдено или неверная маска'
	$LngUpp='Верхний регистр'
	$LngLwr='Нижний регистр'
	$LngRstr='Красная строка'
	$LngErrLb='На этой вкладке'&@CRLF&'откат отсутствует'
	$LngGen='Генерация'
	$LngNmrG='Число'
	$LngTxtG='Текст'
	$LngSep='Разделитель'
	$LngWdth='Минимальная'&@CRLF&'разрядность'
	
	$LngScrollAbt = 'Утилита предназначена' & @CRLF & _
	'для переименования файлов.' & @CRLF & @CRLF & _
	'Позволяет  выбрать правило, ' &  _
	'выполнить предпросмотр ' &  _
	'сделать откат, при условии бэкапирования имён.' & @CRLF & @CRLF & _
	'Утилита написана на AutoIt3' & @CRLF & _
	'autoitscript.com'
EndIf

$Gui = GUICreate($LngTitle, 460, 445, -1, -1, $WS_OVERLAPPEDWINDOW, $WS_EX_ACCEPTFILES)
If Not @Compiled Then GUISetIcon(@ScriptDir & '\ReName.ico')
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
GUISetOnEvent($GUI_EVENT_DROPPED, "_Dropped")

$StatusBar = GUICtrlCreateLabel($LngSb1, 3, 410, 456, 17, 0xC)
GUICtrlSetResizing(-1, 512 + 64 + 2)

$Setting=GUICtrlCreateButton($LngOpt, 460-316, 171, 55, 23)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_Setting")

$OpenF=GUICtrlCreateButton($LngOpF, 460-256, 171, 55, 23)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_OpenFld")

$Test=GUICtrlCreateButton($LngTst, 460-196, 171, 95, 23)
GUICtrlSetTip(-1,  $LngTstH)
GUICtrlSetOnEvent(-1, "_Test")
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)

$Start=GUICtrlCreateButton($LngStr, 460-96, 171, 95, 23)
GUICtrlSetTip(-1,  $LngStrH)
GUICtrlSetOnEvent(-1, "_Start")
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)

GUICtrlCreateButton ("R", 460-20, 1, 18, 18)
GUICtrlSetTip(-1, $LngRe)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetOnEvent(-1, "_restart")

; $About=GUICtrlCreateButton ("@", 460-40, 1, 18, 18)
; GUICtrlSetTip(-1,  $LngAbout)
; GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)


$menuOtkat = GUICtrlCreateMenu($LngRNm)

$OtkatBt = GUICtrlCreateMenuItem($LngRRc, $menuOtkat)
GUICtrlSetOnEvent(-1, "_OtkatBt")

$OtkatLV = GUICtrlCreateMenuItem($LngRVw, $menuOtkat)
GUICtrlSetOnEvent(-1, "_OtkatLV")

$OtkatOp = GUICtrlCreateMenuItem($LngROp, $menuOtkat)
GUICtrlSetOnEvent(-1, "_OtkatOp")

$OtkatSv = GUICtrlCreateMenuItem($LngRSv, $menuOtkat)
GUICtrlSetOnEvent(-1, "_OtkatSv")

$ListMD5 = GUICtrlCreateMenuItem($LngRL5, $menuOtkat)
GUICtrlSetOnEvent(-1, "_ListMD5")

$ReNmMD5 = GUICtrlCreateMenuItem($LngRR5, $menuOtkat)
GUICtrlSetOnEvent(-1, "_ReNmMD5")

$menuHelp = GUICtrlCreateMenu('?')
GUICtrlCreateMenuItem($LngAbout, $menuHelp)
GUICtrlSetOnEvent(-1, "_About")
GUICtrlCreateMenuItem($LngRe, $menuHelp)
GUICtrlSetOnEvent(-1, "_restart")



$TabMain=GUICtrlCreateTab(0, 2, 460, 170, -1, 0x0080)
GUICtrlSetResizing(-1, 512 + 32 + 2)

$Tab_RegEx=GUICtrlCreateTabitem('RegEx')

GUICtrlCreateLabel($LngSea, 250, 28, 50, 17)
$InpSr=GUICtrlCreateInput('', 250, 43, 195, 20)
GUICtrlSetResizing(-1, 512 + 2 + 32 + 4)

GUICtrlCreateLabel($LngRep, 250, 74, 50, 17)
$InpRep=GUICtrlCreateInput('', 250, 89, 195, 20)
GUICtrlSetResizing(-1, 512 + 2 + 32 + 4)

$SmpRep=GUICtrlCreateCheckbox($LngSmRep, 250, 115, 195, 17)


Dim $RegExPat[9][3] = [ _
['', '', '0 '&$LngAr0], _
['(.*?)_(.*)', '\2_\1', '1 '&$LngAr1], _
['(.*?) (.*)', '\2 \1', '2 '&$LngAr2], _
['(.*?)-(.*)', '\2-\1', '3 '&$LngAr3], _
['(.{3})(.*)', '\2', '4 '&$LngAr4], _
['(^.*)(.{3})$', '\1', '5 '&$LngAr5], _
['(.{2})(.{4})(.*)', '\1\3', '6 '&$LngAr6], _
['[!№#$;%^&\[\]{}()]', '', '7 '&$LngAr7], _
['(^\d+)( |_|-)(.*)', '\3', '8 '&$LngAr8]]
; GUICtrlCreateLabel($LngSel, 10, 90, 70, 17)
$ComboSel1=GUICtrlCreateList('', 10, 30, 230, 140)
GUICtrlSetOnEvent(-1, "_RegExList")
$tmp=''
For $i = 0 to UBound($RegExPat)-1
	$tmp&=$RegExPat[$i][2]&'|'
Next
GUICtrlSetData($ComboSel1, StringTrimRight($tmp, 1), $RegExPat[0][2])
$tmp=''



$Tab_Mod=GUICtrlCreateTabitem($LngMod)

$Upper=GUICtrlCreateRadio($LngUpp, 10, 30, 120, 17)
$Lower=GUICtrlCreateRadio($LngLwr, 10, 50, 120, 17)
$RedString=GUICtrlCreateRadio($LngRstr, 10, 70, 120, 17)
GUICtrlSetState (-1, 1)
GUICtrlCreateLabel($LngErrLb, 10, 110, 170, 40)
GUICtrlSetColor(-1, 0xff0000)
GUICtrlSetFont(-1, 13, 700)


$Tab_Add=GUICtrlCreateTabitem($LngAdd)

GUICtrlCreateLabel($LngTxt, 10, 30, 70, 17)
$InpTx1=GUICtrlCreateInput('', 80, 30, 200, 20)

GUICtrlCreateLabel($LngSel, 10, 60, 70, 17)
$ComboSel2=GUICtrlCreateCombo('', 80, 60, 200, -1 , 0x3)
GUICtrlSetData(-1,'0 '&$LngAr0&'|1.1 '&$LngCA1&'|1.2 '&$LngCA2&'|1.3 '&$LngCA3&'|2.1 '&$LngCA4&'', '0 '&$LngAr0)

$AddPrfStr=GUICtrlCreateRadio($LngABN, 10, 90, 120, 17)
$AddPrfEnd=GUICtrlCreateRadio($LngAEN, 10, 110, 120, 17)
GUICtrlSetState (-1, 1)


$Tab_Exp=GUICtrlCreateTabitem($LngExp)

GUICtrlCreateLabel($LngSel, 10, 30, 70, 17)
$ComboSel3=GUICtrlCreateCombo('', 80, 30, 60)
GUICtrlSetData(-1,'avi|mp3|txt|bin|rar', 'avi')

$ExRep=GUICtrlCreateRadio($LngRep, 10, 60, 120, 17)
GUICtrlSetState (-1, 1)
$ExAdd=GUICtrlCreateRadio($LngAdd, 10, 80, 120, 17)
$ExDel=GUICtrlCreateRadio($LngDel, 10, 100, 120, 17)




$Tab_Trn=GUICtrlCreateTabitem($LngTrn)

$TrnstF=GUICtrlCreateButton($LngOpF, 10, 35, 80, 23)
GUICtrlSetOnEvent(-1, "_OpenTranslit")
$ObrTrnstF=GUICtrlCreateCheckbox($LngRDT, 10, 70, 140, 17)



$Tab_Gen=GUICtrlCreateTabitem($LngGen)

GUICtrlCreateGroup("", 10, 26, 125, 80)
$GenRep=GUICtrlCreateRadio($LngRep, 20, 40, 110, 17)
GUICtrlSetState (-1, 1)
$GenAddS=GUICtrlCreateRadio($LngABN, 20, 60, 110, 17)
$GenAddE=GUICtrlCreateRadio($LngAEN, 20, 80, 110, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)

GUICtrlCreateGroup("", 10, 105, 125, 60)
$GenNmrG=GUICtrlCreateRadio($LngNmrG, 20, 120, 70, 17)
GUICtrlSetState (-1, 1)
$GenTxtG=GUICtrlCreateRadio($LngTxtG, 20, 140, 70, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)

GUICtrlCreateLabel($LngSep, 150, 83, 80, 17)
$InpSep=GUICtrlCreateInput('_', 230, 80, 40, 23)

GUICtrlCreateLabel($LngWdth, 150, 115, 80, 34)
$ComboGenK=GUICtrlCreateCombo('',230, 120, 40)
GUICtrlSetData(-1,'1|2|3|4|5|6|7|8|9', '4')

GUICtrlCreateTabitem ("")

; Name|New_Name
$FileList=GUICtrlCreateListView($LngLVT, 0, 195, 460, 215, -1, $WS_EX_CLIENTEDGE)
_GUICtrlListView_SetExtendedListViewStyle(GUICtrlGetHandle($FileList), BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
GUICtrlSetResizing(-1, 7 + 32 + 64)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUICtrlSendMsg(-1, 0x1000+30, 0, 226)
GUICtrlSendMsg(-1, 0x1000+30, 1, 226)



GUISetState ()
; WinMove($Gui, '', 10, 10, 900, 700)
; WM_SIZING()
GUIRegisterMsg($WM_SIZING , "WM_SIZING")
GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")


While 1
	Sleep(1000000)
WEnd

Func _Exit()
	Exit
EndFunc

Func _Setting()
	GUIRegisterMsg($WM_SIZING, "")
	$GP=_ChildCoor($Gui, 340, 220)
	GUISetState(@SW_DISABLE, $Gui)
	$Gui1 = GUICreate($LngOpt, $GP[2], $GP[3], $GP[0], $GP[1], BitOr($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\ReName.ico')
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit2")
	
	GUICtrlCreateLabel($LngExF, 10, 10, 260, 17)
	$ComboType=GUICtrlCreateCombo('', 10, 30, 260)
	GUICtrlSetData(-1, '*|mp3;wav;wma|avi;mpg;mpeg;mp4;asx;asf;wmv;3gp;mov;mkv;vob;flv|rar;zip;7z;cab|htm;html|txt;doc;docx;rtf;xls;xlsx;pps;ppt;pdf|bmp;gif;jpg;jpeg;png;tif;tiff;tga;psd;xpm;dds|exe;msi|dll|bat;cmd;vbs;js|kar;mid;rmi;mmf', '*')
	
	$exclude=GUICtrlCreateCheckbox($LngExc, 10, 60, 260, 17)
	If Not $exclude0 Then GUICtrlSetState(-1, 1)

	$SubFolder=GUICtrlCreateCheckbox($LngInS, 10, 80, 220, 17)
	GUICtrlSetState(-1, $SubFolder0)

	$AutuOtkat=GUICtrlCreateCheckbox($LngASR, 10, 100, 220, 17)
	GUICtrlSetTip(-1, $LngASRH)
	GUICtrlSetState(-1, $AutuOtkat0)

	$ObrabatExt=GUICtrlCreateCheckbox($LngExt, 10, 120, 220, 17)
	GUICtrlSetState(-1, $ObrabatExt0)

	GUICtrlCreateLabel($LngKolTst, 10, 142, 180, 17)
	$KolTstInp=GUICtrlCreateInput('', 190, 140, 80, 20)
	GUICtrlSetData(-1, $kFile)

	$OK=GUICtrlCreateButton("OK", ($GP[2]-60)/2, $GP[3]-48, 60, 30)
	GUICtrlSetOnEvent(-1, "_OK")
	
	GUISetState(@SW_SHOW, $Gui1)
EndFunc

Func _OK()
	$Mask=GUICtrlRead($ComboType)
	$SubFolder0=GUICtrlRead($SubFolder)
	$AutuOtkat0=GUICtrlRead($AutuOtkat)
	$ObrabatExt0=GUICtrlRead($ObrabatExt)
	$kFile=GUICtrlRead($KolTstInp)
	If $kFile < 10 Then $kFile=10
	
	If GUICtrlRead($exclude)=1 Then ; исключения
		$exclude0=False
	Else
		$exclude0=True
	EndIf
	_Exit2()
	_UpdateList()
EndFunc

Func _Exit2()
	GUISetState(@SW_ENABLE, $Gui)
	GUIDelete($Gui1)
	GUIRegisterMsg($WM_SIZING, "WM_SIZING")
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
EndFunc

Func _Dropped()
	$DrPath=@GUI_DRAGFILE
	_FileListUpd()
EndFunc

Func _OpenFld()
	$tmp = FileSelectFolder ( $LngDF,'', 2,$DrPath, $Gui)
	; $tmp = FileSelectFolder ( $LngDF, @DesktopDir, 2, '', $Gui)
	If @error Then Return
	$DrPath = $tmp
	_FileListUpd()
EndFunc

Func _UpdateList()
	If $DrPath='' Or Not FileExists($DrPath) Then Return
	If StringInStr(FileGetAttrib($DrPath), "D") Then
		_FileListUpd()
	EndIf
EndFunc

Func _OpenTranslit()
	If @WorkingDir=@ScriptDir Then
		$tmp=@ScriptDir&'\Translits'
	Else
		$tmp=@WorkingDir
	EndIf
	$OpenTrnstF = FileOpenDialog($LngDF, $tmp, $LngTrn&" (*.txt)", 3, "", $Gui)
	If @error Then
		$OpenTrnstF=@ScriptDir&'\Translits\Russian.txt'
		Return
	EndIf
	GUICtrlSetData($StatusBar,$LngSb2&' '&StringRegExpReplace($OpenTrnstF, '(^.*)\\(.*)$', '\2'))
EndFunc

Func _RegExList()
	$n=StringRegExpReplace(GUICtrlRead($ComboSel1), '(^\d{1,2})[ ].*', '\1')
	
	GUICtrlSetData($InpSr, $RegExPat[$n][0])
	GUICtrlSetData($InpRep, $RegExPat[$n][1])
EndFunc

Func _OtkatBt()
	If $Otkat='' Then
		MsgBox(0, $LngMs1, $LngMs2)
		Return
	EndIf
	GUICtrlSetData($StatusBar,$LngSb11)
	$FullList=$Otkat
	_ReName_And_Backup()
	_FileListUpd()
EndFunc

Func _OtkatSv()
	If $Otkat='' Then
		MsgBox(0, $LngMs1, $LngMs2)
		Return
	EndIf
	$SaveFile = FileSaveDialog($LngDF3, @WorkingDir , $LngDF2&" (*.txt)", 24, $LngDF1&'.txt', $Gui)
	If @error Then Return
	If StringRight($SaveFile, 4) <> '.txt' Then $SaveFile&='.txt'
	$file = FileOpen($SaveFile,2)
	FileWrite($file, $Otkat)
	FileClose($file)
EndFunc

Func _OtkatOp()
	$OpenFile = FileOpenDialog($LngDF, @WorkingDir , " (*.txt)", 3, $LngDF1&'.txt', $Gui)
	If @error Then Return
	$Otkat = StringStripCR(FileRead($OpenFile))
	_OtkatLV()
EndFunc

Func _Test()
Switch GUICtrlRead($TabMain, 1)
#Region ;_Test RegEx
	Case $Tab_RegEx
		If $aFL='' Then Return
		If $TrTest=0 Then _FileListUpd()
		$InpSr0=GUICtrlRead($InpSr)
		$InpRep0=GUICtrlRead($InpRep)
		$SmpRep0=GUICtrlRead($SmpRep)
		
		If $InpSr0='' And $InpRep0='' Then
			MsgBox(0, $LngMs1, $LngMs3)
			Return
		EndIf
		
		GUICtrlSendMsg($FileList, 0x1000+9, 0, 0)
		For $i = 1 to $aFL[0][0]
			If $ObrabatExt0=4 Then
				If $SmpRep0=1 Then
					$tmp=StringReplace($aFL[$i][1], $InpSr0, $InpRep0)
				Else
					$tmp=StringRegExpReplace($aFL[$i][1], $InpSr0, $InpRep0)
				EndIf
				GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$tmp&$aFL[$i][2], $FileList)
				If $aFL[$i][1]==$tmp Then GUICtrlSetBkColor(-1, 0xffe7e7)
			Else
				If $SmpRep0=1 Then
					$tmp=StringReplace($aFL[$i][1]&$aFL[$i][2], $InpSr0, $InpRep0)
				Else
					$tmp=StringRegExpReplace($aFL[$i][1]&$aFL[$i][2], $InpSr0, $InpRep0)
				EndIf
				$tmp=StringRegExpReplace($aFL[$i][1]&$aFL[$i][2], $InpSr0, $InpRep0)
				GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$tmp, $FileList)
				If $aFL[$i][1]&$aFL[$i][2]==$tmp Then GUICtrlSetBkColor(-1, 0xffe7e7)
			EndIf
		Next
		$TrTest=1
#EndRegion ;_Test RegEx
		

#Region ;_Test Add
	Case $Tab_Add
		If $aFL='' Then Return
		If $TrTest=0 Then _FileListUpd()
		
		$ComboSel02=GUICtrlRead($ComboSel2)
		$InpTx01=GUICtrlRead($InpTx1)
		$AddPrfStr0=GUICtrlRead($AddPrfStr)
		$AddPrfEnd0=GUICtrlRead($AddPrfEnd)
		
		If $InpTx01='' And StringLeft($ComboSel02, 1)='0' Then
			MsgBox(0, $LngMs1, $LngMs3)
			Return
		EndIf
		GUICtrlSendMsg($FileList, 0x1000+9, 0, 0)
		
		If StringLeft($ComboSel02, 1)='1' Then

			Switch StringLeft($ComboSel02, 3)
				Case '1.1'
				   $dev = 1
				Case '1.2'
					$dev = 1024
				Case '1.3'
					$dev = 1024^2
			EndSwitch
			
			If $AddPrfStr0 = 1 Then
				For $i = 1 to $aFL[0][0]
					$aFS=Int(FileGetSize($aFL[$i][0]&$aFL[$i][1]&$aFL[$i][2])/$dev)
					GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$aFS&$InpTx01&$aFL[$i][1]&$aFL[$i][2], $FileList)
				Next
			EndIf
			
			If $AddPrfEnd0 = 1 Then
				For $i = 1 to $aFL[0][0]
					$aFS=Int(FileGetSize($aFL[$i][0]&$aFL[$i][1]&$aFL[$i][2])/$dev)
					GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$aFL[$i][1]&$InpTx01&$aFS&$aFL[$i][2], $FileList)
				Next
			EndIf
			
		EndIf
		
		If StringLeft($ComboSel02, 3)='2.1' Then
			
			If $AddPrfStr0 = 1 Then
				For $i = 1 to $aFL[0][0]
					$aFS=FileGetTime($aFL[$i][0]&$aFL[$i][1]&$aFL[$i][2])
					GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$aFS[0]&'_'&$aFS[1]&'_'&$aFS[2]&$InpTx01&$aFL[$i][1]&$aFL[$i][2], $FileList)
				Next
			EndIf
			
			If $AddPrfEnd0 = 1 Then
				For $i = 1 to $aFL[0][0]
					$aFS=FileGetTime($aFL[$i][0]&$aFL[$i][1]&$aFL[$i][2])
					GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$aFL[$i][1]&$InpTx01&$aFS[0]&'_'&$aFS[1]&'_'&$aFS[2]&$aFL[$i][2], $FileList)
				Next
			EndIf
			
		EndIf
		
		If StringLeft($ComboSel02, 1)='0' Then
			
			If $AddPrfStr0 = 1 Then
				For $i = 1 to $aFL[0][0]
					GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$InpTx01&$aFL[$i][1]&$aFL[$i][2], $FileList)
				Next
			EndIf
			
			If $AddPrfEnd0 = 1 Then
				For $i = 1 to $aFL[0][0]
					GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$aFL[$i][1]&$InpTx01&$aFL[$i][2], $FileList)
				Next
			EndIf
			
		EndIf
		$TrTest=1
#EndRegion ;_Test Add


#Region ;_Test Exp
	Case $Tab_Exp
		If $aFL='' Then Return
		If $TrTest=0 Then _FileListUpd()

		$ComboSel03=GUICtrlRead($ComboSel3)
		
		GUICtrlSendMsg($FileList, 0x1000+9, 0, 0)

		If GUICtrlRead($ExRep)=1 Then
			For $i = 1 to $aFL[0][0]
				If $aFL[$i][2] Then
					GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$aFL[$i][1]&'.'&$ComboSel03, $FileList)
					If $aFL[$i][2]=='.'&$ComboSel03 Then GUICtrlSetBkColor(-1, 0xffe7e7)
				EndIf
			Next
		ElseIf GUICtrlRead($ExAdd)=1 Then
			For $i = 1 to $aFL[0][0]
				If Not $aFL[$i][2] Then GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$aFL[$i][1]&'.'&$ComboSel03, $FileList)
			Next
		ElseIf GUICtrlRead($ExDel)=1 Then
			For $i = 1 to $aFL[0][0]
				If $aFL[$i][2] Then GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$aFL[$i][1], $FileList)
			Next
		EndIf
		
		$TrTest=1
#EndRegion ;_Test Exp


#Region ;_Test Trn
	Case $Tab_Trn
		If $aFL='' Then Return
		If $TrTest=0 Then _FileListUpd()
		
		If Not FileExists($OpenTrnstF) Then
			MsgBox(0, $LngMs1, $LngMs4)
			Return
		EndIf
		
		$tmp = FileRead($OpenTrnstF)
		
		If GUICtrlRead($ObrTrnstF)=4 Then
			$Trt1=StringRegExp($tmp, '(.*)(?:=.*?\r\n)', 3)
			$Trt2=StringRegExp($tmp, '(?:.*?=)(.*)(?=\r\n)', 3)
		Else
			$Trt1=StringRegExp($tmp, '(?:.*?=)(.*)(?=\r\n)', 3)
			$Trt2=StringRegExp($tmp, '(.*)(?:=.*?\r\n)', 3)
		EndIf
		
		GUICtrlSendMsg($FileList, 0x1000+9, 0, 0)
		For $i = 1 to $aFL[0][0]
			$tmp=$aFL[$i][1]
			For $j = 0 to UBound($Trt1)-1
				$tmp=StringReplace($tmp, $Trt1[$j], $Trt2[$j], 0, 1)
			Next
			GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$tmp&$aFL[$i][2], $FileList)
			If $aFL[$i][1]==$tmp Then GUICtrlSetBkColor(-1, 0xffe7e7)
		Next
		$TrTest=1
#EndRegion ;_Test Trn
	
#Region ;_Test Mod
	Case $Tab_Mod
		If $aFL='' Then Return
		If $TrTest=0 Then _FileListUpd()
		
		GUICtrlSendMsg($FileList, 0x1000+9, 0, 0)

		If GUICtrlRead($Upper)=1 Then
			For $i = 1 to $aFL[0][0]
				If $ObrabatExt0=4 Then
					$tmp=StringUpper($aFL[$i][1])&$aFL[$i][2]
				Else
					$tmp=StringUpper($aFL[$i][1]&$aFL[$i][2])
				EndIf
				GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$tmp, $FileList)
				If $aFL[$i][1]&$aFL[$i][2]==$tmp Then GUICtrlSetBkColor(-1, 0xffe7e7)
			Next
		ElseIf GUICtrlRead($Lower)=1 Then
			For $i = 1 to $aFL[0][0]
				If $ObrabatExt0=4 Then
					$tmp=StringLower($aFL[$i][1])&$aFL[$i][2]
				Else
					$tmp=StringLower($aFL[$i][1]&$aFL[$i][2])
				EndIf
				GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$tmp, $FileList)
				If $aFL[$i][1]&$aFL[$i][2]==$tmp Then GUICtrlSetBkColor(-1, 0xffe7e7)
			Next
		ElseIf GUICtrlRead($RedString)=1 Then
			For $i = 1 to $aFL[0][0]
				If $ObrabatExt0=4 Then
					If StringLen($aFL[$i][1])>1 Then
						$tmp=StringUpper(StringLeft($aFL[$i][1], 1))&StringLower(StringTrimLeft($aFL[$i][1], 1))&$aFL[$i][2]
					EndIf
				Else
					If StringLen($aFL[$i][1]&$aFL[$i][2])>1 Then
						$tmp=StringUpper(StringLeft($aFL[$i][1]&$aFL[$i][2], 1))&StringLower(StringTrimLeft($aFL[$i][1]&$aFL[$i][2], 1))
					EndIf
				EndIf
				GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$tmp, $FileList)
				If $aFL[$i][1]&$aFL[$i][2]==$tmp Then GUICtrlSetBkColor(-1, 0xffe7e7)
			Next
		EndIf
		
		$TrTest=1
#EndRegion ;_Test Mod

#Region ;_Test Gen
	Case $Tab_Gen
		If $aFL='' Then Return
		If $TrTest=0 Then _FileListUpd()
		
		$GenNmrG0=GUICtrlRead($GenNmrG)
		$GenTxtG0=GUICtrlRead($GenTxtG)
		$ComboGenK0=GUICtrlRead($ComboGenK)
		$GenRep0=GUICtrlRead($GenRep)
		$GenAddS0=GUICtrlRead($GenAddS)
		$GenAddE0=GUICtrlRead($GenAddE)
		$InpSep0=GUICtrlRead($InpSep)
		
		GUICtrlSendMsg($FileList, 0x1000+9, 0, 0)
		
		Switch 1
			Case $GenNmrG0
				Switch 1
					Case $GenRep0
						For $i = 1 to $aFL[0][0]
							$tmp=StringFormat('%0'&$ComboGenK0&'d', $i)
							If $ObrabatExt0=4 Then
								GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$tmp&$aFL[$i][2], $FileList)
							Else
								GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$tmp, $FileList)
							EndIf
						Next
					Case $GenAddS0
						For $i = 1 to $aFL[0][0]
							$tmp=StringFormat('%0'&$ComboGenK0&'d', $i)
							GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$tmp&$InpSep0&$aFL[$i][1]&$aFL[$i][2], $FileList)
						Next
					Case $GenAddE0
						For $i = 1 to $aFL[0][0]
							$tmp=StringFormat('%0'&$ComboGenK0&'d', $i)
							GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$aFL[$i][1]&$InpSep0&$tmp&$aFL[$i][2], $FileList)
						Next
					Case Else
						Return
				EndSwitch
			Case $GenTxtG0
				Switch 1
					Case $GenRep0
						For $i = 1 to $aFL[0][0]
							$num=$i
							$text=''
							While 1
								$ost=Mod($num, 26)
								$num=($num-$ost)/26
								$text =Chr($ost+97)&$text
								If $num=0 Then ExitLoop
							WEnd
							$tmp=StringFormat('%'&$ComboGenK0&'s', $text)
							$tmp=StringReplace($tmp, ' ', 'a')
							If $ObrabatExt0=4 Then
								GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$tmp&$aFL[$i][2], $FileList)
							Else
								GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$tmp, $FileList)
							EndIf
						Next
					Case $GenAddS0
						For $i = 1 to $aFL[0][0]
							$num=$i
							$text=''
							While 1
								$ost=Mod($num, 26)
								$num=($num-$ost)/26
								$text =Chr($ost+97)&$text
								If $num=0 Then ExitLoop
							WEnd
							$tmp=StringFormat('%'&$ComboGenK0&'s', $text)
							$tmp=StringReplace($tmp, ' ', 'a')
							GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$tmp&$InpSep0&$aFL[$i][1]&$aFL[$i][2], $FileList)
						Next
					Case $GenAddE0
						For $i = 1 to $aFL[0][0]
							$num=$i
							$text=''
							While 1
								$ost=Mod($num, 26)
								$num=($num-$ost)/26
								$text =Chr($ost+97)&$text
								If $num=0 Then ExitLoop
							WEnd
							$tmp=StringFormat('%'&$ComboGenK0&'s', $text)
							$tmp=StringReplace($tmp, ' ', 'a')
							GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|'&$aFL[$i][1]&$InpSep0&$tmp&$aFL[$i][2], $FileList)
						Next
					Case Else
						Return
				EndSwitch
			Case Else
				Return
		EndSwitch
		
		$TrTest=1
#EndRegion ;_Test Gen


EndSwitch
EndFunc

Func _Start()
If $DrPath='' Or Not FileExists($DrPath) Or Not StringInStr(FileGetAttrib($DrPath), "D") Then Return
Switch GUICtrlRead($TabMain, 1)

#Region ;_Start RegEx
	Case $Tab_RegEx
		
		$InpSr0=GUICtrlRead($InpSr)
		$InpRep0=GUICtrlRead($InpRep)
		$SmpRep0=GUICtrlRead($SmpRep)

		If $InpSr0='' And $InpRep0='' Then
			MsgBox(0, $LngMs1, $LngMs3)
			Return
		EndIf

		GUICtrlSetData($StatusBar,$LngSb3)
		
		_FileSearchToArray3()
		If @error Then
			GUICtrlSetData($StatusBar, $LngMs7)
			Return
		EndIf
		
		For $i = 1 to $aFL[0][0]
			If $ObrabatExt0=4 Then
				If $SmpRep0=1 Then
					$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& StringReplace($aFL[$i][1], $InpSr0, $InpRep0)&$aFL[$i][2]&@LF
				Else
					$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& StringRegExpReplace($aFL[$i][1], $InpSr0, $InpRep0)&$aFL[$i][2]&@LF
				EndIf
			Else
				If $SmpRep0=1 Then
					$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& StringReplace($aFL[$i][1]&$aFL[$i][2], $InpSr0, $InpRep0)&@LF
				Else
					$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& StringRegExpReplace($aFL[$i][1]&$aFL[$i][2], $InpSr0, $InpRep0)&@LF
				EndIf
			EndIf
		Next
		GUICtrlSetData($StatusBar,$LngSb4)

		_ReName_And_Backup()
		
		_SaveFileOtkat()
		$TrTest=0
#EndRegion ;_Start RegEx
		

#Region ;_Start Add
	Case $Tab_Add
		$ComboSel02=GUICtrlRead($ComboSel2)
		$InpTx01=GUICtrlRead($InpTx1)
		$AddPrfStr0=GUICtrlRead($AddPrfStr)
		$AddPrfEnd0=GUICtrlRead($AddPrfEnd)

		If $InpTx01='' And StringLeft($ComboSel02, 1)='0' Then
			MsgBox(0, $LngMs1, $LngMs3)
			Return
		EndIf

		GUICtrlSetData($StatusBar,$LngSb3)
		
		_FileSearchToArray3()
		If @error Then
			GUICtrlSetData($StatusBar, $LngMs7)
			Return
		EndIf
		
		For $i = 1 to $aFL[0][0]
			If StringLeft($ComboSel02, 1)='1' Then

				Switch StringLeft($ComboSel02, 3)
					Case '1.1'
					   $dev = 1
					Case '1.2'
						$dev = 1024
					Case '1.3'
						$dev = 1024^2
				EndSwitch
				
				If $AddPrfStr0 = 1 Then
					$aFS=Int(FileGetSize($aFL[$i][0]&$aFL[$i][1]&$aFL[$i][2])/$dev)
					$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $aFS&$InpTx01&$aFL[$i][1]&$aFL[$i][2]&@LF
				EndIf
				
				If $AddPrfEnd0 = 1 Then
					$aFS=Int(FileGetSize($aFL[$i][0]&$aFL[$i][1]&$aFL[$i][2])/$dev)
					$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $aFL[$i][1]&$InpTx01&$aFS&$aFL[$i][2]&@LF
				EndIf
				
			EndIf
			
			If StringLeft($ComboSel02, 3)='2.1' Then
				
				If $AddPrfStr0 = 1 Then
					$aFS=FileGetTime($aFL[$i][0]&$aFL[$i][1]&$aFL[$i][2])
					$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $aFS[0]&'_'&$aFS[1]&'_'&$aFS[2]&$InpTx01&$aFL[$i][1]&$aFL[$i][2]&@LF
				EndIf
				
				If $AddPrfEnd0 = 1 Then
					$aFS=FileGetTime($aFL[$i][0]&$aFL[$i][1]&$aFL[$i][2])
					$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $aFL[$i][1]&$InpTx01&$aFS[0]&'_'&$aFS[1]&'_'&$aFS[2]&$aFL[$i][2]&@LF
				EndIf
				
			EndIf
			If StringLeft($ComboSel02, 1)='0' Then
				
				If $AddPrfStr0 = 1 Then
					$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $InpTx01&$aFL[$i][1]&$aFL[$i][2]&@LF
				EndIf
				
				If $AddPrfEnd0 = 1 Then
					$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $aFL[$i][1]&$InpTx01&$aFL[$i][2]&@LF
				EndIf
				
			EndIf
		Next

		GUICtrlSetData($StatusBar,$LngSb4)
		
		_ReName_And_Backup()
		
		_SaveFileOtkat()
		$TrTest=0
#Region ;_Start Add


#Region ;_Start Exp
	Case $Tab_Exp
			$ComboSel03=GUICtrlRead($ComboSel3)
		
			GUICtrlSetData($StatusBar,$LngSb3)
			
		_FileSearchToArray3()
		If @error Then
			GUICtrlSetData($StatusBar, $LngMs7)
			Return
		EndIf

		For $i = 1 to $aFL[0][0]
			If GUICtrlRead($ExRep)=1 Then
					If $aFL[$i][2] Then $FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $aFL[$i][1]&'.'&$ComboSel03&@LF
			ElseIf GUICtrlRead($ExAdd)=1 Then
					If Not $aFL[$i][2] Then $FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $aFL[$i][1]&'.'&$ComboSel03&@LF
			ElseIf GUICtrlRead($ExDel)=1 Then
					If $aFL[$i][2] Then $FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $aFL[$i][1]&@LF
			EndIf
		Next
				
			GUICtrlSetData($StatusBar,$LngSb4)
		
		_ReName_And_Backup()
		
		_SaveFileOtkat()
		$TrTest=0
#Region ;_Start Exp

#Region ;_Start Trn
	Case $Tab_Trn
		If Not FileExists($OpenTrnstF) Then
			MsgBox(0, $LngMs1, $LngMs4)
			Return
		EndIf
		
		GUICtrlSetData($StatusBar,$LngSb3)

		$tmp = FileRead($OpenTrnstF)
		
		If GUICtrlRead($ObrTrnstF)=4 Then
			$Trt1=StringRegExp($tmp, '(.*)(?:=.*?\r\n)', 3)
			$Trt2=StringRegExp($tmp, '(?:.*?=)(.*)(?=\r\n)', 3)
		Else
			$Trt1=StringRegExp($tmp, '(?:.*?=)(.*)(?=\r\n)', 3)
			$Trt2=StringRegExp($tmp, '(.*)(?:=.*?\r\n)', 3)
		EndIf

		_FileSearchToArray3()
		If @error Then
			GUICtrlSetData($StatusBar, $LngMs7)
			Return
		EndIf
		
		For $i = 1 to $aFL[0][0]
			$tmp=$aFL[$i][1]
			For $j = 0 to UBound($Trt1)-1
				$tmp=StringReplace($tmp, $Trt1[$j], $Trt2[$j], 0, 1)
			Next
			$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $tmp&$aFL[$i][2]&@LF
		Next
		GUICtrlSetData($StatusBar,$LngSb4)

		_ReName_And_Backup()
		
		_SaveFileOtkat()
		$TrTest=0
#EndRegion ;_Start Trn

#Region ;_Start Mod
	Case $Tab_Mod
		Local $TrSel=0
			
		If GUICtrlRead($Upper)=1 Then
			$TrSel=1
		ElseIf GUICtrlRead($Lower)=1 Then
			$TrSel=2
		ElseIf GUICtrlRead($RedString)=1 Then
			$TrSel=3
		EndIf
		
		GUICtrlSetData($StatusBar,$LngSb3)
		
		_FileSearchToArray3()
		If @error Then
			GUICtrlSetData($StatusBar, $LngMs7)
			Return
		EndIf
		
		For $i = 1 to $aFL[0][0]
			Switch $TrSel
				Case 1
					If $ObrabatExt0=4 Then
						$tmp=StringUpper($aFL[$i][1])&$aFL[$i][2]
					Else
						$tmp=StringUpper($aFL[$i][1]&$aFL[$i][2])
					EndIf
					; $FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $tmp&@LF
					$FullList&=$aFL[$i][0]&'|'&$tmp &'|'& '$#%@&!'&$tmp&@LF
				Case 2
					If $ObrabatExt0=4 Then
						$tmp=StringLower($aFL[$i][1])&$aFL[$i][2]
					Else
						$tmp=StringLower($aFL[$i][1]&$aFL[$i][2])
					EndIf
					; $FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $tmp&@LF
					$FullList&=$aFL[$i][0]&'|'&$tmp &'|'& '$#%@&!'&$tmp&@LF
				Case 3
					If $ObrabatExt0=4 Then
						If StringLen($aFL[$i][1])>1 Then
							$tmp=StringUpper(StringLeft($aFL[$i][1], 1))&StringLower(StringTrimLeft($aFL[$i][1], 1))&$aFL[$i][2]
						EndIf
					Else
						If StringLen($aFL[$i][1]&$aFL[$i][2])>1 Then
							$tmp=StringUpper(StringLeft($aFL[$i][1]&$aFL[$i][2], 1))&StringLower(StringTrimLeft($aFL[$i][1]&$aFL[$i][2], 1))
						EndIf
					EndIf
					$FullList&=$aFL[$i][0]&'|'&$tmp &'|'& '$#%@&!'&$tmp&@LF
				Case Else
					Return
			EndSwitch
		Next
		GUICtrlSetData($StatusBar,$LngSb4)
		
		_ReName_And_Backup()

		$FullList=$Otkat
		_ReName_And_Backup()
		_FileListUpd()
		$Otkat=''
		
		$TrTest=0
#EndRegion ;_Start Mod
		

#Region ;_Start Gen
	Case $Tab_Gen
		$GenNmrG0=GUICtrlRead($GenNmrG)
		$GenTxtG0=GUICtrlRead($GenTxtG)
		$ComboGenK0=GUICtrlRead($ComboGenK)
		$GenRep0=GUICtrlRead($GenRep)
		$GenAddS0=GUICtrlRead($GenAddS)
		$GenAddE0=GUICtrlRead($GenAddE)
		$InpSep0=GUICtrlRead($InpSep)

		GUICtrlSetData($StatusBar,$LngSb3)
		
		_FileSearchToArray3()
		If @error Then
			GUICtrlSetData($StatusBar, $LngMs7)
			Return
		EndIf
		
		Switch 1
			Case $GenNmrG0
				Switch 1
					Case $GenRep0
						For $i = 1 to $aFL[0][0]
							$tmp=StringFormat('%0'&$ComboGenK0&'d', $i)
							If $ObrabatExt0=4 Then
								$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $tmp&$aFL[$i][2]&@LF
							Else
								$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $tmp&@LF
							EndIf
						Next
					Case $GenAddS0
						For $i = 1 to $aFL[0][0]
							$tmp=StringFormat('%0'&$ComboGenK0&'d', $i)
							$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $tmp&$InpSep0&$aFL[$i][1]&$aFL[$i][2]&@LF
						Next
					Case $GenAddE0
						For $i = 1 to $aFL[0][0]
							$tmp=StringFormat('%0'&$ComboGenK0&'d', $i)
							$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $aFL[$i][1]&$InpSep0&$tmp&$aFL[$i][2]&@LF
						Next
					Case Else
						Return
				EndSwitch
			Case $GenTxtG0
				Switch 1
					Case $GenRep0
						For $i = 1 to $aFL[0][0]
							$num=$i
							$text=''
							While 1
								$ost=Mod($num, 26)
								$num=($num-$ost)/26
								$text =Chr($ost+97)&$text
								If $num=0 Then ExitLoop
							WEnd
							$tmp=StringFormat('%'&$ComboGenK0&'s', $text)
							$tmp=StringReplace($tmp, ' ', 'a')
							If $ObrabatExt0=4 Then
								$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $tmp&$aFL[$i][2]&@LF
							Else
								$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $tmp&@LF
							EndIf
						Next
					Case $GenAddS0
						For $i = 1 to $aFL[0][0]
							$num=$i
							$text=''
							While 1
								$ost=Mod($num, 26)
								$num=($num-$ost)/26
								$text =Chr($ost+97)&$text
								If $num=0 Then ExitLoop
							WEnd
							$tmp=StringFormat('%'&$ComboGenK0&'s', $text)
							$tmp=StringReplace($tmp, ' ', 'a')
							$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $tmp&$InpSep0&$aFL[$i][1]&$aFL[$i][2]&@LF
						Next
					Case $GenAddE0
						For $i = 1 to $aFL[0][0]
							$num=$i
							$text=''
							While 1
								$ost=Mod($num, 26)
								$num=($num-$ost)/26
								$text =Chr($ost+97)&$text
								If $num=0 Then ExitLoop
							WEnd
							$tmp=StringFormat('%'&$ComboGenK0&'s', $text)
							$tmp=StringReplace($tmp, ' ', 'a')
							$FullList&=$aFL[$i][0]&'|'&$aFL[$i][1]&$aFL[$i][2] &'|'& $aFL[$i][1]&$InpSep0&$tmp&$aFL[$i][2]&@LF
						Next
					Case Else
						Return
				EndSwitch
			Case Else
				Return
		EndSwitch

		GUICtrlSetData($StatusBar,$LngSb4)
		
		_ReName_And_Backup()
		
		_SaveFileOtkat()
		$TrTest=0
#Region ;_Start Gen
EndSwitch
EndFunc

Func _SaveFileOtkat()
	If $AutuOtkat0=1 And $Otkat<>'' Then
		$file = FileOpen(@ScriptDir&'\'&StringLeft($DrPath, 1)&StringReplace(StringTrimLeft($DrPath, 2), '\', '_')&"__"&@YEAR&"."&@MON&"."&@MDAY&"__"&@HOUR&"."&@MIN&"."&@SEC&'.txt',2)
		FileWrite($file, $Otkat)
		FileClose($file)
	EndIf
EndFunc

Func _ListMD5()
	If $DrPath='' Or Not FileExists($DrPath) Or Not StringInStr(FileGetAttrib($DrPath), "D") Then Return
	
	$SaveFile = FileSaveDialog($LngDF3, @WorkingDir , $LngDF2&" (*.txt)", 24, $LngDF1&'_MD5.txt', $Gui)
	If @error Then Return
	If StringRight($SaveFile, 4) <> '.txt' Then $SaveFile&='.txt'
	
	GUICtrlSetData($StatusBar, $LngSb5)
	_Crypt_Startup()

	_FileSearchToArray3()
	If @error Then
		GUICtrlSetData($StatusBar, $LngMs7)
		Return
	EndIf
	
	For $i = 1 to $aFL[0][0]
		$FullList&=$aFL[$i][0]&'|'&_Crypt_HashFile($aFL[$i][0]&$aFL[$i][1]&$aFL[$i][2], $CALG_MD5) &'|'& $aFL[$i][1]&$aFL[$i][2]&@LF
	Next
	GUICtrlSetData($StatusBar,$LngSb6)

	_Crypt_Shutdown()
	
	If $FullList='' Then Return
	
	$tmp=_Dubl_MD5_ind()
	; If $tmp > 0 Then MsgBox(0, $LngMs1, $LngMs5&' '&$tmp)
	
	$file = FileOpen($SaveFile,2)
	FileWrite($file, $FullList)
	FileClose($file)
EndFunc

Func _Dubl_MD5_ind()
	Local $tmp, $k=0, $aFullList=StringRegExp(StringStripCR($FullList), '(?m)^(.*?)\|(.*?)\|(.*)$', 3)
	
	Assign('/', -100000, 1)
	For $i = 0 to UBound($aFullList)-1 Step 3
		$tmp=StringReplace($aFullList[$i]&$aFullList[$i+1], '[', '>')
		Assign($tmp&'/', Eval($tmp&'/')+1, 1)
		If Eval($tmp&'/') > 1 Then
			$k+=1
			$aFullList[$i+1]&='('&Eval($tmp&'/')-1&')'
		EndIf
	Next
	If $k > 0 Then
		$FullList='' 
		For $i = 0 to UBound($aFullList)-1 Step 3
			$FullList&=$aFullList[$i]&'|'&$aFullList[$i+1] &'|'& $aFullList[$i+2]&@LF
		Next
	EndIf
		; $aFullList[$i]&$aFullList[$i+2]
	Return $k
EndFunc

Func _ReNmMD5()
	If $DrPath='' Or Not FileExists($DrPath) Or Not StringInStr(FileGetAttrib($DrPath), "D") Then Return
	; If MsgBox(4, $LngMs1, $LngMs6) = 7 Then Return
	GUICtrlSetData($StatusBar,$LngSb3)
	_Crypt_Startup()

	_FileSearchToArray3()
	If @error Then
		GUICtrlSetData($StatusBar, $LngMs7)
		Return
	EndIf
	
	For $i = 1 to $aFL[0][0]
		$FullList&=$aFL[$i][0]&'|'&_Crypt_HashFile($aFL[$i][0]&$aFL[$i][1]&$aFL[$i][2], $CALG_MD5) &'|'& $aFL[$i][1]&$aFL[$i][2]&@LF
	Next
	_Crypt_Shutdown()
	
	$tmp=_Dubl_MD5_ind()
	$aFullList=StringRegExp($FullList, '(?m)^(.*?)\|(.*?)\|(.*)$', 3)
	; If $tmp > 0 Then MsgBox(0, $LngMs1, $LngMs5&' '&$tmp)
	
;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i Открываем список отката MD5
	$OpenFile = FileOpenDialog($LngDF, @WorkingDir , " (*.txt)", 3, $LngDF1&'.txt', $Gui)
	If @error Then Return
	$Otkat = StringStripCR(FileRead($OpenFile))

	If $Otkat='' Then
		MsgBox(0, $LngMs1, $LngMs2)
		Return
	EndIf
	
	$aOtkat=StringRegExp($Otkat, '(?m)^(.*?)\|(.*?)\|(.*)$', 3)
	GUICtrlSendMsg($FileList, 0x1000+9, 0, 0)
;!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i!i
	_RestoreMD5($aFullList, $aOtkat)
	
	GUICtrlSetData($StatusBar,$LngSb4)
	_ReName_And_Backup()
	$TrTest=0
EndFunc

Func _RestoreMD5($aFullList, $aOtkat)
	Local $tmp, $k=0
	
	Assign('/', -100000, 1)
	For $i = 0 to UBound($aFullList)-1 Step 3
		$tmp=StringReplace($aFullList[$i]&$aFullList[$i+1], '[', '>')
		Assign($tmp&'/', $aFullList[$i+2], 1)
	Next
	For $i = 0 to UBound($aOtkat)-1 Step 3
		$tmp=StringReplace($aOtkat[$i]&$aOtkat[$i+1], '[', '>')
		Assign($tmp&'/', Eval($tmp&'/')&'|'&$aOtkat[$i+2], 1)
	Next
	$ErrList=''
	$FullList=''
	For $i = 0 to UBound($aFullList)-1 Step 3
		$tmp=StringReplace($aFullList[$i]&$aFullList[$i+1], '[', '>')
		$tmp=StringSplit(Eval($tmp&'/'), '|')
		If $tmp[0]=2 And $tmp[1] And $tmp[2] Then
			$FullList&=$aFullList[$i]&'|'&$tmp[1]&'|'&$tmp[2]&@LF
		Else
			$ErrList&=$aFullList[$i]&$tmp[1&@LF
		EndIf
	Next
EndFunc

Func _FileSearchToArray3()
	$aFL=''
	$Level=0
	If $SubFolder0 = 1 Then $Level=125
	$tmpK=$kFile
	$kFile=100000000
	$aFL0=_FileSearch($DrPath, $Mask, $exclude0, $Level)
	If @error Then Return SetError(1)
	$kFile=$tmpK
	$aFL0=StringSplit($aFL0, @CRLF, 1)
	Dim $aFL[$aFL0[0]+1][3]
	$aFL[0][0]=$aFL0[0]
	$FullList=''

	For $i = 1 to $aFL[0][0]
		$tmp=StringRegExp($aFL0[$i], '^(.*\\)([^\\]*?)(\.[^.]+)?$', 3)
		$aFL[$i][0]=$tmp[0]
		$aFL[$i][1]=$tmp[1]
		If UBound($tmp)=3 Then
			$aFL[$i][2]=$tmp[2]
		EndIf
	Next
EndFunc

Func _OtkatLV()
	If $Otkat='' Then
		MsgBox(0, $LngMs1, $LngMs2)
		Return
	EndIf
	
	$Otkat=StringStripCR($Otkat)
	$aOtkat=StringRegExp($Otkat, '(?m)^(.*?)\|(.*?)\|(.*)$', 3)
	GUICtrlSendMsg($FileList, 0x1000+9, 0, 0)
	
	For $i = 0 to UBound($aOtkat)-1 Step 3
		GUICtrlCreateListViewItem($aOtkat[$i]&$aOtkat[$i+1]&'|'&$aOtkat[$i]&$aOtkat[$i+2], $FileList)
		GUICtrlSetBkColor ( -1, 0xffffaa)
	Next
	GUICtrlSetData($StatusBar,$LngSb7)
EndFunc

Func _ReName_And_Backup()
	$ErrorList=''
	$Otkat=''
	$aFullList=StringRegExp(StringStripCR($FullList), '(?m)^(.*?)\|(.*?)\|(.*)$', 3)
	
	For $i = 0 to UBound($aFullList)-1 Step 3
		If $aFullList[$i+1]=$aFullList[$i+2] Then ContinueLoop ; изменил == на = так как регистр не имеет смысла, функция FileMove не сработает
		If FileMove($aFullList[$i]&$aFullList[$i+1], $aFullList[$i]&$aFullList[$i+2]) Then
			$Otkat&=$aFullList[$i]&'|'&$aFullList[$i+2]&'|'&$aFullList[$i+1]&@LF
		Else
			$ErrorList&=$aFullList[$i]&$aFullList[$i+1]&@LF
		EndIf
	Next
	$Otkat=StringTrimRight($Otkat, 1)
	GUICtrlSetData($StatusBar, $LngSb8)

	If $ErrorList Then
		GUICtrlSendMsg($FileList, 0x1000+9, 0, 0)
		$aErrorList=StringSplit($ErrorList, @LF)
		For $i = 1 to $aErrorList[0]-1
			GUICtrlCreateListViewItem($aErrorList[$i]&'|', $FileList)
			; GUICtrlSetColor(-1,0x777777)
			GUICtrlSetBkColor ( -1, 0xffd7d7 )
		Next
		GUICtrlSetData($StatusBar, $LngSb9)
	EndIf
EndFunc


Func _FileListUpd()
	GUICtrlSendMsg($FileList, 0x1000+9, 0, 0)
	If StringInStr(FileGetAttrib($DrPath), "D") Then
		GUICtrlSetData($StatusBar, $LngSb3)
		$Level=0
		If $SubFolder0 = 1 Then $Level=125
		$kFile0=0
		$aFL0=_FileSearch($DrPath, $Mask, $exclude0, $Level)
		If @error Then
			GUICtrlSetData($StatusBar, $LngMs7&' - '&@error)
			$aFL=''
			Return
		EndIf
		$aFL0=StringSplit($aFL0, @CRLF, 1)
		Dim $aFL[$aFL0[0]+1][3]
		$aFL[0][0]=$aFL0[0]
		For $i = 1 to $aFL[0][0]
			$tmp=StringRegExp($aFL0[$i], '^(.*\\)([^\\]*?)(\.[^.]+)?$', 3)
			$aFL[$i][0]=$tmp[0]
			$aFL[$i][1]=$tmp[1]
			If UBound($tmp)=3 Then
				$aFL[$i][2]=$tmp[2]
			EndIf
		Next
		_GUICtrlListView_BeginUpdate($FileList)
		For $i = 1 to $aFL[0][0]
			GUICtrlCreateListViewItem($aFL[$i][1]&$aFL[$i][2]&'|', $FileList)
		Next
		_GUICtrlListView_EndUpdate($FileList)
		GUICtrlSetData($StatusBar, $LngSb10&' "'&$DrPath&'"')
	EndIf
EndFunc

Func _restart()
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

Func WM_SIZING($hWnd, $iMsg, $wparam, $lparam)
	Local $sRect = DllStructCreate("Int[3]", $lparam), _
	$left = DllStructGetData($sRect, 1, 1), _
	$Right = DllStructGetData($sRect, 1, 3)

	$w=($Right-$left)/2-8
	GUICtrlSendMsg($FileList, 0x1000+30, 0, $w)
	GUICtrlSendMsg($FileList, 0x1000+30, 1, $w)
	Return 'GUI_RUNDEFMSG'
EndFunc

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	If $hWnd = $GUI Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 468) ; минимальные размеры окна
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 483)
	EndIf
EndFunc

; _FileSearch (__FileSearch, __FileSearchAll, __FileSearchMask)
; Автор ..........: AZJIO
Func _FileSearch($Path, $Mask = '*', $Include = True, $Level = 125)
	Local $FileList, $i

	If Not StringRegExp($Path, '(?i)^[a-z]:[^/:*?"<>|]*$') Or StringInStr($Path, '\\') Then Return SetError(1, 0, '')
	If StringRight($Path, 1) <> '\' Then $Path &= '\'
	If $Mask = '' Then $Mask = '*'

	If $Mask = '*' Then
		$FileList = StringTrimRight(__FileSearchAll($Path, $Level), 2)
	Else
		While StringInStr($Mask, '.;')
			$Mask = StringReplace($Mask, '.;', ';'
		WEnd
		While StringInStr($Mask, ';;')
			$Mask = StringReplace($Mask, ';;', ';'
		WEnd
		If $Mask = ';' Then Return SetError(2, 0, '')
		If StringInStr($Mask, '*') Or StringInStr($Mask, '?') Or StringInStr($Mask, '.') Then
			If StringRegExp($Mask, '[\\/:"<>|]') Then Return SetError(2, 0, '')
			__GetListMask($Path, $Mask, $Include, $Level, $FileList)
		Else
			If StringRegExp($Mask, '[\\/:*?"<>|]') Then Return SetError(2, 0, '')
			$FileList = StringTrimRight(__FileSearchType($Path, ';' & $Mask & ';', $Include, $Level), 2)
		EndIf
	EndIf
	If Not $FileList Then Return SetError(3, 0, '')
	Return $FileList
EndFunc

; Получение списка и обработка регулярным выражением
Func __GetListMask($Path, $Mask, $Include, $Level, ByRef $FileList)
	Local $aFileList
	$FileList = StringTrimRight(__FileSearchMask($Path, $Level), 2)

	$Mask = StringStripWS(StringRegExpReplace(StringRegExpReplace($Mask, '\*+', '*'), "\s*;\s*", "|"), 3)
	If StringInStr('|' & $Mask & '|', '|*|') Then $Mask=StringTrimRight(StringTrimLeft(StringReplace('|' & $Mask & '|', '|*|', '|'), 1), 1)
	$Mask = StringReplace(StringReplace(StringRegExpReplace($Mask, '[][$^.{}()+]', '\\$0'), '?', '.'), '*', '.*?')
	If $Include Then
		$aFileList = StringRegExp($FileList, '(?mi)^(.+\|(?:' & $Mask & '))(?:\r|\z)', 3)
		$FileList = ''
		For $i = 0 To UBound($aFileList) - 1
			$FileList &= $aFileList[$i] & @CRLF
		Next
	Else
		$FileList = StringRegExpReplace($FileList & @CRLF, '(?mi)^.+\|(' & $Mask & ')\r\n', '')
	EndIf
	$FileList = StringReplace(StringTrimRight($FileList, 2), '|', '')
EndFunc

; поиск указанных типов файлов
Func __FileSearchType($Path, $Mask, $Include, $Level, $LD = 0)
	Local $tmp, $FileList = '', $file, $s = FileFindFirstFile($Path & '*')
	If $s = -1 Then Return ''
	While $kFile0<$kFile
		$file = FileFindNextFile($s)
		If @error Then ExitLoop
		If @extended Then
			If $LD >= $Level Then ContinueLoop
			$FileList &= __FileSearchType($Path & $file & '\', $Mask, $Include, $Level, $LD + 1)
		Else
			$tmp = StringInStr($file, ".", 0, -1)
			If $tmp And StringInStr($Mask, ';' & StringTrimLeft($file, $tmp) & ';') = $Include Then
				$FileList &= $Path & $file & @CRLF
				$kFile0+=1
			ElseIf Not $tmp And Not $Include Then
				$FileList &= $Path & $file & @CRLF
				$kFile0+=1
			EndIf
		EndIf
	WEnd
	FileClose($s)
	Return $FileList
EndFunc

Func __FileSearchMask($Path, $Level, $LD = 0)
	Local $FileList = '', $file, $s = FileFindFirstFile($Path & '*')
	If $s = -1 Then Return ''
	While $kFile0<$kFile
		$file = FileFindNextFile($s)
		If @error Then ExitLoop
		If @extended Then
			If $LD >= $Level Then ContinueLoop
			$FileList &= __FileSearchMask($Path & $file & '\', $Level, $LD + 1)
		Else
			$FileList &= $Path & '|' & $file & @CRLF
			$kFile0+=1
		EndIf
	WEnd
	FileClose($s)
	Return $FileList
EndFunc

; поиск файлов по маске
Func __FileSearchAll($Path, $Level, $LD = 0)
	Local $FileList = '', $file, $s = FileFindFirstFile($Path & '*')
	If $s = -1 Then Return ''
	While $kFile0<$kFile
		$file = FileFindNextFile($s)
		If @error Then ExitLoop
		If @extended Then
			If $LD >= $Level Then ContinueLoop
			$FileList &= __FileSearchAll($Path & $file & '\', $Level, $LD + 1)
		Else
			$FileList &= $Path & $file & @CRLF
			$kFile0+=1
		EndIf
	WEnd
	FileClose($s)
	Return $FileList
EndFunc

Func _ChildCoor($Gui, $w, $h, $c=0, $d=0)
	Local $aWA = _WinAPI_GetWorkingArea(), _
	$GP = WinGetPos($Gui), _
	$wgcs=WinGetClientSize($Gui)
	Local $dLeft=($GP[2]-$wgcs[0])/2, _
	$dTor=$GP[3]-$wgcs[1]-$dLeft
	If $c = 0 Then
		$GP[0]=$GP[0]+($GP[2]-$w)/2-$dLeft
		$GP[1]=$GP[1]+($GP[3]-$h-$dLeft-$dTor)/2
	EndIf
	If $d>($aWA[2]-$aWA[0]-$w-$dLeft*2)/2 Or $d>($aWA[3]-$aWA[1]-$h-$dLeft+$dTor)/2 Then $d=0
	If $GP[0]+$w+$dLeft*2+$d>$aWA[2] Then $GP[0]=$aWA[2]-$w-$d-$dLeft*2
	If $GP[1]+$h+$dLeft+$dTor+$d>$aWA[3] Then $GP[1]=$aWA[3]-$h-$dLeft-$dTor-$d
	If $GP[0]<=$aWA[0]+$d Then $GP[0]=$aWA[0]+$d
	If $GP[1]<=$aWA[1]+$d Then $GP[1]=$aWA[1]+$d
	$GP[2]=$w
	$GP[3]=$h
	Return $GP
EndFunc

Func _WinAPI_GetWorkingArea()
    Local Const $SPI_GETWORKAREA = 48
    Local $stRECT = DllStructCreate("long; long; long; long")

    Local $SPIRet = DllCall("User32.dll", "int", "SystemParametersInfo", "uint", $SPI_GETWORKAREA, "uint", 0, "ptr", DllStructGetPtr($stRECT), "uint", 0)
    If @error Then Return 0
    If $SPIRet[0] = 0 Then Return 0

    Local $sLeftArea = DllStructGetData($stRECT, 1)
    Local $sTopArea = DllStructGetData($stRECT, 2)
    Local $sRightArea = DllStructGetData($stRECT, 3)
    Local $sBottomArea = DllStructGetData($stRECT, 4)

    Local $aRet[4] = [$sLeftArea, $sTopArea, $sRightArea, $sBottomArea]
    Return $aRet
EndFunc

Func _About()
	GUIRegisterMsg($WM_SIZING, "")
	$wAbt=270
	$hAbt=180
	$GP=_ChildCoor($Gui, $wAbt, $hAbt)
	$wAbtBt=20
	$wA=$wAbt/2-80
	$wB=$hAbt/3*2
	$iScroll_Pos = -$hAbt
	$TrAbt1 = 0
	$TrAbt2 = 0
	$BkCol1=0xE1E3E7
	$BkCol2=0
	$GuiPos = WinGetPos($Gui)
	GUISetState(@SW_DISABLE, $Gui)
	$font="Arial"

    $Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOr($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	GUISetBkColor ($BkCol1)
If Not @Compiled Then GUISetIcon(@ScriptDir & '\ReName.ico')
	GUISetFont (-1, -1, -1, $font)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")
	
	$vk1=GUICtrlCreateButton (ChrW('0x25BC'), 0, $hAbt-20, $wAbtBt, 20)
	GUICtrlSetOnEvent(-1, "_About_vk1")

	GUICtrlCreateTab ($wAbtBt,0, $wAbt-$wAbtBt,$hAbt+35,0x0100+0x0004+0x0002)
	$tabAbt0=GUICtrlCreateTabitem ("0")

	GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt-$wAbtBt, $hAbt)
	GUICtrlSetState(-1, 128)
	GUICtrlSetBkColor (-1, $BkCol1)


	GUICtrlCreateLabel($LngTitle, 0, 0, $wAbt, $hAbt/3, 0x01+0x0200)
	GUICtrlSetFont (-1,15, 600, -1, $font)
	GUICtrlSetColor(-1,0x3a6a7e)
	GUICtrlSetBkColor (-1, 0xF1F1EF)
	GUICtrlCreateLabel ("-", 1,$hAbt/3, $wAbt-2,1,0x10)

	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.3  21.09.2011', $wA, $wB-36, 210, 17)
	GUICtrlCreateLabel($LngSite&':', $wA, $wB-17, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', $wA+39, $wB-17, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlSetOnEvent(-1, "_About_url")
	GUICtrlCreateLabel('WebMoney:', $wA, $wB+2, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', $wA+75, $wB+2, 125, 17)
	GUICtrlSetColor(-1,0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetOnEvent(-1, "_About_WbMn")
	GUICtrlCreateLabel('Copyright AZJIO © 2010', $wA, $wB+21, 210, 17)

	$tabAbt1=GUICtrlCreateTabitem ("1")

	GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt-$wAbtBt, $hAbt)
	GUICtrlSetState(-1, 128)
	GUICtrlSetBkColor (-1, 0x000000)

$StopPlay= GUICtrlCreateButton(ChrW('0x25A0'), 0, $hAbt-41, $wAbtBt, 20)
GUICtrlSetState(-1,32)
	GUICtrlSetOnEvent(-1, "_About_StopPlay")

$nLAbt = GUICtrlCreateLabel($LngScrollAbt, $wAbtBt, $hAbt, $wAbt-$wAbtBt, 360, 0x1) ; центр
GUICtrlSetFont(-1, 9, 400, 2, $font)
GUICtrlSetColor(-1, 0x99A1C0)
GUICtrlSetBkColor(-1, -2) ; прозрачный
GUICtrlCreateTabitem ('')
GUISetState(@SW_SHOW, $Gui1)
EndFunc

Func _Exit1()
	AdlibUnRegister('_ScrollAbtText')
	GUISetState(@SW_ENABLE, $Gui)
	GUIDelete($Gui1)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	GUIRegisterMsg($WM_SIZING, "WM_SIZING")
EndFunc

Func _About_url()
	ShellExecute ('http://azjio.ucoz.ru')
EndFunc

Func _About_WbMn()
	ClipPut('R939163939152')
EndFunc

Func _About_StopPlay()
	If $TrAbt2 = 0 Then
		AdlibUnRegister('_ScrollAbtText')
		GUICtrlSetData($StopPlay, ChrW('0x25BA'))
		$TrAbt2 = 1
	Else
		AdlibRegister('_ScrollAbtText', 40)
		GUICtrlSetData($StopPlay, ChrW('0x25A0'))
		$TrAbt2 = 0
	EndIf
EndFunc

Func _About_vk1()
	If $TrAbt1 = 0 Then
		GUICtrlSetState($tabAbt1,16)
		GUICtrlSetState($nLAbt,16)
		GUICtrlSetState($StopPlay,16)
		GUICtrlSetData($vk1, ChrW('0x25B2'))
		GUISetBkColor ($BkCol2)
		If $TrAbt2 = 0 Then AdlibRegister('_ScrollAbtText', 40)
		$TrAbt1 = 1
	Else
		GUICtrlSetState($tabAbt0,16)
		GUICtrlSetState($nLAbt,32)
		GUICtrlSetState($StopPlay,32)
		GUICtrlSetData($vk1, ChrW('0x25BC'))
		GUISetBkColor ($BkCol1)
		AdlibUnRegister('_ScrollAbtText')
		$TrAbt1 = 0
	EndIf
EndFunc

Func _ScrollAbtText()
    $iScroll_Pos += 1
    ControlMove($Gui1, "", $nLAbt, $wAbtBt, -$iScroll_Pos)
    If $iScroll_Pos > 360 Then $iScroll_Pos = -$hAbt
EndFunc