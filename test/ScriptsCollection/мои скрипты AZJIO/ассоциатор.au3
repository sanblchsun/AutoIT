#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=assotiations.exe
#AutoIt3Wrapper_icon=assotiations.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=assotiations.exe
#AutoIt3Wrapper_Res_Fileversion=1.4.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Field=Version|1.4
#AutoIt3Wrapper_Res_Field=Build|2012.08.31
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2012.08.31 (AutoIt3_v3.2.12.1+)

#RequireAdmin
#NoTrayIcon ;скрыть в системной панели индикатор AutoIt
#include <WindowsConstants.au3>
#include <ComboConstants.au3>
#include <ForAssotiations.au3>

; Код для включения файлов в скомпилированный скрипт. Такой расклад позволяет стартовать скомпилированный скрипт на незаписываемом носителе. Перед компиляцией нужно единожды использовать скрипт, чтоб скопировались dll в системные каталоги и оттуда добавлялись в скомпилированный скрипт. И при условии системы на диске C.
If @compiled Then
	FileInstall("assot.dll", @TempDir & '\assot.dll')
	FileInstall("mpcicons.dll", @TempDir & '\mpcicons.dll')
	FileInstall("imageicons.dll", @TempDir & '\imageicons.dll')
	$Dir=@TempDir
Else
	FileInstall("assot.dll", "*")
	FileInstall("mpcicons.dll", "*")
	FileInstall("imageicons.dll", "*")
	$Dir=@ScriptDir
EndIf

Global $Data=''
$EXE=''
; начало создания окна
$Gui = GUICreate("Ассоциатор программ", 380, 130, -1, -1, -1, $WS_EX_ACCEPTFILES)
If Not @Compiled Then GUISetIcon(@ScriptDir & '\assotiations.ico')
GUICtrlCreateLabel("", -1, -1, 380, 130)
GUICtrlSetState(-1, 136)
GUICtrlCreateLabel("Кинь сюда программу или её ярлык, чтобы ассоциировать с ней файлы", 4, 3, 370, 20)
$Label23=GUICtrlCreateLabel ("Тип программы:", 30,25,90,20)
GUICtrlSetTip(-1, "Выбрать тип для определения"&@CRLF&"какие файлы требуется ассоциировать,"&@CRLF&"в случае, если программа отсутствует"&@CRLF&"в списке авто-детектирования")
$type=GUICtrlCreateCombo ("", 120,22,100,18, $CBS_DROPDOWNLIST + $WS_VSCROLL)
GUICtrlSetData(-1,'авто|музыка|видео|текст|гарфика|iso, mdf, img|bin|dll, res|nfo, diz|xls, doc, ppt|архивы|htm, html', 'авто')
$info=GUICtrlCreateButton ("Инфо", 230, 22, 60, 22)
$warning=GUICtrlCreateButton ("?", 330,22,22,22)
GUICtrlSetTip(-1, "Посмотреть список расширений"&@CRLF&"для выбранного в списке типа")
$About=GUICtrlCreateButton ("@", 355,22,22,22)
$checkcfg=GUICtrlCreateButton ("дополнения", 300,55,75,22)
GUICtrlSetTip(-1, "Добавить всплывающие сообщения о типе файлов"&@CRLF&"bak, tmp, gid, srs, tbk, rpb, csc, nib, gso и др.")
$saveBK=GUICtrlCreateCheckbox ("Индивидуальный бэкап", 10,55,150,22)
GUICtrlSetTip(-1, "Только для принимаемой"&@CRLF&"программы")
$saveall=GUICtrlCreateButton ("Бэкап всех ассоциаций", 160,55,130,22)
GUICtrlSetTip(-1, "Создание reg-файла"&@CRLF&"для восстановления")
$autoicons=GUICtrlCreateCheckbox ("Автообновление иконок", 10,85,150,22)
$Updateicon=GUICtrlCreateButton ("Обновить кэш иконок", 160,85,130,22)
GUICtrlSetTip(-1, "Смена иконок происходит"&@CRLF&"только после обновления кэша")

$StatusBar=GUICtrlCreateLabel ("Строка состояния			автор AZJIO 2012.08.31", 5,130-20,370,15)
GUISetState(@SW_SHOW, $Gui)

While 1
	  Switch GUIGetMsg()
        Case $About
				_About()
        Case $checkcfg
				If MsgBox(4, "Выгодное предложение", "Желаете в реестр добавить всплывающие"&@CRLF&"сообщения о типе файлов"&@CRLF&"bak, tmp, gid, srs, tbk, rpb, csc, nib, gso и др?") = 6 Then
RegWrite("HKCR\.bak","InfoTip","REG_SZ",'Бэкап файла, копия оригинального файла перед изменением')
RegWrite("HKCR\.gid","InfoTip","REG_SZ",'Генерируется при открытии справки *.hlp')
RegWrite("HKCR\.tmp","InfoTip","REG_SZ",'Временный файл')
RegWrite("HKCR\.tbk","InfoTip","REG_SZ",'Резервная копия почтовых ящиков The Bat!')
RegWrite("HKCR\.srs","InfoTip","REG_SZ",'Скрипт Search and Replace, градиент текста HTML')
RegWrite("HKCR\.rpb","InfoTip","REG_SZ",'Список контактов radmin')
RegWrite("HKCR\.sxp","InfoTip","REG_SZ",'Сохранённый профиль StatistXP')
RegWrite("HKCR\.csc","InfoTip","REG_SZ",'Список дубликатов CloneSpy')
RegWrite("HKCR\.ctl","InfoTip","REG_SZ",'База CD Collection')
RegWrite("HKCR\.nib","InfoTip","REG_SZ",'Файл органайзера Блокнотик')
RegWrite("HKCR\.gso","InfoTip","REG_SZ",'Файл органайзера WinOrganizer')
If FileExists(@SystemDir&'\assot.dll') Then
RegWrite("HKCR\.gso\DefaultIcon","","REG_SZ",'assot.dll,6')
RegWrite("HKCR\.nib\DefaultIcon","","REG_SZ",'assot.dll,6')
RegWrite("HKCR\.ctl\DefaultIcon","","REG_SZ",'assot.dll,6')
RegWrite("HKCR\.csc\DefaultIcon","","REG_SZ",'assot.dll,6')
RegWrite("HKCR\.sxp\DefaultIcon","","REG_SZ",'assot.dll,6')
RegWrite("HKCR\.tbk\DefaultIcon","","REG_SZ",'assot.dll,6')
RegWrite("HKCR\.srs\DefaultIcon","","REG_SZ",'assot.dll,6')
RegWrite("HKCR\.rpb\DefaultIcon","","REG_SZ",'assot.dll,6')
RegWrite("HKCR\swffile\DefaultIcon","","REG_SZ",'assot.dll,3')
RegWrite("HKCR\ShockwaveFlash.ShockwaveFlash\DefaultIcon","","REG_SZ",'assot.dll,3')
EndIf
	GUICtrlSetData($StatusBar, 'Всплывающие сообщения добавлены')
;$typeall='bak|gid|tmp|tbk|srs|rpb|sxp|csc|ctl|nib|gso'
;$EXE=''
;If GUICtrlRead($saveBK)=1 Then _backup($typeall, $EXE)
            EndIf
        Case -13
			$typeall=''
			GUICtrlSetColor($StatusBar,0x0)
            $accepted = StringRegExp(@GUI_DRAGFILE, "(^.*)\\(.*)$", 3) ; для строки состояния "не приянто"
            If StringRight(@GUI_DRAGFILE, 4) = ".lnk" Or StringRight(@GUI_DRAGFILE, 4) = ".exe"  Then
                If StringRight( @GUI_DRAGFILE, 4 )  = ".lnk" Then ; принятие если lnk (ярлык) и объект (exe) в переменную
                $aLNK = FileGetShortcut(@GUI_DRAGFILE)
                $EXE=$aLNK[0]
                EndIf
                If StringRight( @GUI_DRAGFILE, 4 )  = ".exe" Then $EXE=@GUI_DRAGFILE ; принятие exe-файла
			Else
                GUICtrlSetData($StatusBar, 'Не принят - "'&$accepted[1]&'"')
				GUICtrlSetColor($StatusBar,0xEE0000)
				If MsgBox(4, "Выгодное предложение", "Хотите открыть каталог ассоциированной программы") = "6" Then
				  $Editor=_TypeGetPath(StringRegExpReplace(@GUI_DRAGFILE, ".*\.(\S+)", '\1'))
				  If FileExists($Editor) Then Run('Explorer.exe /select,"'&$Editor&'"')
				EndIf
                ContinueLoop
            EndIf
			GUICtrlSetData($StatusBar, 'Не принят - "'&$accepted[1]&'"')
            ; копирование необходимых файлов содержащих иконки ассоциаций
            If Not FileExists(@SystemDir&'\assot.dll') and FileExists($Dir & '\assot.dll') Then FileCopy($Dir & '\assot.dll', @SystemDir&'\', 0)
            If Not FileExists(@SystemDir&'\mpcicons.dll') and FileExists($Dir & '\mpcicons.dll') Then FileCopy($Dir & '\mpcicons.dll', @SystemDir&'\', 0)
            If Not FileExists(@SystemDir&'\imageicons.dll') and FileExists($Dir & '\imageicons.dll') Then FileCopy($Dir & '\imageicons.dll', @SystemDir&'\', 0)
			$assot=0
			If FileExists(@SystemDir&'\assot.dll') Then $assot=1
            $aEXE = StringRegExp($EXE, "(^.*)\\(.*)$", 3)
			$EXENAME = StringTrimRight($aEXE[1], 4)
            If StringRight( $EXE, 4 )  <> ".exe" Then ContinueLoop ; проверка возвращаемого из LNK обьекта, иногда это не exe-файл
; Добавление к файлу всплывающей подсказки о типе файла.
			; Добавление программы в список "Выбор программы" для неассоциированных файлов.
			RegWrite("HKCR\Applications\"&$EXENAME&".exe\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
            $type1=GUICtrlRead ($type)
;проверка для видеофайлов
            If $type1 = "видео" Or $EXENAME = "mplayerc" Or $EXENAME = "kmplayer" Then
; удаление из реестра веток, возможно это повлияет на успешную регистрацию.
;$aTypeV0 = StringSplit( "avi|mpg|mpeg|asf|wmv", "|")
;For $i = 1 To $aTypeV0[0]
;	RegDelete("HKCR\."&$aTypeV0[$i])
;	RegDelete("HKCR\."&$aTypeV0[$i]&"file")
;Next
$typeall="avi|mpg|mpeg|mp4|asx|asf|wmv|3gp|mov|mkv|ifo|vob|flv"
$aTypeV = StringSplit( $typeall, "|")
For $i = 1 To $aTypeV[0]
	RegDelete("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\."&$aTypeV[$i],"ProgID")
	;RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\."&$aTypeV[$i],"ProgID","REG_SZ",$aTypeV[$i]&"file")
	;RegDelete("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\."&$aTypeV[$i])
	RegDelete("HKCR\"&$aTypeV[$i]&"file\shell\open\DropTarget")
	RegWrite("HKCR\."&$aTypeV[$i],"","REG_SZ",$aTypeV[$i]&'file')
	RegWrite("HKCR\"&$aTypeV[$i]&"file","","REG_SZ",'видео')
	RegWrite("HKCR\"&$aTypeV[$i]&"file\shell\open","","REG_SZ",'Открыть в '&$EXENAME)
	RegWrite("HKCR\"&$aTypeV[$i]&"file\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
	
	$play = RegRead("HKCR\"&$aTypeV[$i]&"file\shell\open", "LegacyDisable")
	If @error=0 Then
		RegDelete("HKCR\"&$aTypeV[$i]&"file\shell\open", "LegacyDisable")
	EndIf
	
	$play = RegRead("HKCR\"&$aTypeV[$i]&"file\shell\play", "")
	If @error=0 Then
	RegWrite("HKCR\"&$aTypeV[$i]&"file\shell\play","","REG_SZ",'Воспроизвести в '&$EXENAME)
	RegWrite("HKCR\"&$aTypeV[$i]&"file\shell\play\command","","REG_SZ",'"'&$EXE&'" "%1"')
	EndIf
Next
If FileExists(@SystemDir&'\mpcicons.dll') Then
RegWrite("HKCR\avifile\DefaultIcon","","REG_SZ",'mpcicons.dll,14')
RegWrite("HKCR\mpgfile\DefaultIcon","","REG_SZ",'mpcicons.dll,11')
RegWrite("HKCR\mpegfile\DefaultIcon","","REG_SZ",'mpcicons.dll,11')
RegWrite("HKCR\mp4file\DefaultIcon","","REG_SZ",'mpcicons.dll,28')
RegWrite("HKCR\bikfile\DefaultIcon","","REG_SZ",'mpcicons.dll,26')
RegWrite("HKCR\asxfile\DefaultIcon","","REG_SZ",'mpcicons.dll,27')
RegWrite("HKCR\asffile\DefaultIcon","","REG_SZ",'mpcicons.dll,12')
RegWrite("HKCR\wmvfile\DefaultIcon","","REG_SZ",'mpcicons.dll,13')
RegWrite("HKCR\3gpfile\DefaultIcon","","REG_SZ",'mpcicons.dll,30')
RegWrite("HKCR\movfile\DefaultIcon","","REG_SZ",'mpcicons.dll,18')
RegWrite("HKCR\mkvfile\DefaultIcon","","REG_SZ",'mpcicons.dll,16')
RegWrite("HKCR\ifofile\DefaultIcon","","REG_SZ",'mpcicons.dll,22')
RegWrite("HKCR\vobfile\DefaultIcon","","REG_SZ",'mpcicons.dll,10')
RegWrite("HKCR\flvfile\DefaultIcon","","REG_SZ",'mpcicons.dll,31')
EndIf
	GUICtrlSetData($StatusBar, 'Видео-файлы ассоциированы с '&$aEXE[1])
            EndIf


;проверка для файлов музыки
            If $type1 = "музыка" Or $EXENAME = "AIMP2" Or $EXENAME = "winamp" Then

; удаление из реестра веток, возможно это повлияет на успешную регистрацию.
;$aTypeA0 = StringSplit( "mp3|wma", "|")
;For $i = 1 To $aTypeA0[0]
;	RegDelete("HKCR\."&$aTypeA0[$i])
;	RegDelete("HKCR\."&$aTypeA0[$i]&"file")
;Next

; удаление из реестра веток, это повлияло на успешную регистрацию. возможно эти ветки являются ключевыми.
$typeall="mp3|wav|wma|ogg|m3u|pls"
$aTypeM = StringSplit( $typeall, "|")
For $i = 1 To $aTypeM[0]
	RegDelete("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\."&$aTypeM[$i],"ProgID")
	;RegDelete("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\."&$aTypeM[$i]&"\OpenWithProgids")
	;RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\."&$aTypeM[$i],"ProgID","REG_SZ",$aTypeM[$i]&"file")
	;RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\."&$aTypeM[$i],"ProgID","REG_SZ",$aTypeM[$i]&"file")
	RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\."&$aTypeM[$i]&"\OpenWithProgids",$aTypeM[$i]&"file","REG_SZ",'')
	RegDelete("HKCR\"&$aTypeM[$i]&"file\shell\open\DropTarget")
	RegWrite("HKCR\."&$aTypeM[$i],"","REG_SZ",$aTypeM[$i]&'file')
	RegWrite("HKCR\"&$aTypeM[$i]&"file","","REG_SZ",$aTypeM[$i]&' - аудиофайл')
	RegWrite("HKCR\"&$aTypeM[$i]&"file\shell\open","","REG_SZ",'Открыть в '&$EXENAME)
	RegWrite("HKCR\"&$aTypeM[$i]&"file\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
	$play = RegRead("HKCR\"&$aTypeM[$i]&"file\shell\play", "")
	If @error=0 Then
		RegWrite("HKCR\"&$aTypeM[$i]&"file\shell\play","","REG_SZ",'Воспроизвести в '&$EXENAME)
		RegWrite("HKCR\"&$aTypeM[$i]&"file\shell\play\command","","REG_SZ",'"'&$EXE&'" "%1"')
	EndIf
Next

RegWrite("HKCR\plsfile","","REG_SZ",'pls - плэй лист')
RegWrite("HKCR\m3ufile","","REG_SZ",'m3u - плэй лист')
If FileExists(@SystemDir&'\mpcicons.dll') Then
RegWrite("HKCR\mp3file\DefaultIcon","","REG_SZ",'mpcicons.dll,1')
RegWrite("HKCR\SoundRec\DefaultIcon","","REG_SZ",'mpcicons.dll,0')
RegWrite("HKCR\wavfile\DefaultIcon","","REG_SZ",'mpcicons.dll,4')
RegWrite("HKCR\wmafile\DefaultIcon","","REG_SZ",'mpcicons.dll,3')
RegWrite("HKCR\oggfile\DefaultIcon","","REG_SZ",'mpcicons.dll,5')
RegWrite("HKCR\m3ufile\DefaultIcon","","REG_SZ",'mpcicons.dll,21')
RegWrite("HKCR\plsfile\DefaultIcon","","REG_SZ",'mpcicons.dll,21')
EndIf
	GUICtrlSetData($StatusBar, 'Файлы музыки ассоциированы с '&$aEXE[1])
            EndIf


;проверка для файлов гарфики
            If $type1 = "гарфика" Or $EXENAME = "Imagine" Or $EXENAME = "mspaint" Or $EXENAME = "HprSnap6" Or $EXENAME = "PhotoFiltre" Or $EXENAME = "Photoshop" Or $EXENAME = "GIMP" Then
$typeall="bmp|gif|jpg|png|tga|tif|psd"
$aTypeP = StringSplit( $typeall, "|")
For $i = 1 To $aTypeP[0]
	RegDelete("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\."&$aTypeP[$i],"ProgID")
	;RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\."&$aTypeP[$i],"ProgID","REG_SZ",$aTypeP[$i]&"file")
	;RegDelete("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\."&$aTypeP[$i]&"\OpenWithProgids")
	RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\."&$aTypeP[$i]&"\OpenWithProgids",$aTypeP[$i]&"file","REG_SZ",'')
	;RegDelete("HKCR\."&$aTypeP[$i]&"\OpenWithProgids")
	;RegWrite("HKCR\."&$aTypeP[$i]&"\OpenWithProgids",$aTypeP[$i]&"file","REG_SZ",'')
	RegDelete("HKCR\"&$aTypeP[$i]&"file\shell\open\DropTarget")
	RegWrite("HKCR\."&$aTypeP[$i],"","REG_SZ",$aTypeP[$i]&'file')
	RegWrite("HKCR\"&$aTypeP[$i]&"file","","REG_SZ",'рисунок')
	RegWrite("HKCR\"&$aTypeP[$i]&"file\shell\open","","REG_SZ",'Открыть в '&$EXENAME)
	RegWrite("HKCR\"&$aTypeP[$i]&"file\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
Next
RegDelete("HKCR\giffile\shell\open\ddeexec")
If FileExists(@SystemDir&'\imageicons.dll') Then
RegWrite("HKCR\bmpfile\DefaultIcon","","REG_SZ",'imageicons.dll,0')
RegWrite("HKCR\giffile\DefaultIcon","","REG_SZ",'imageicons.dll,1')
RegWrite("HKCR\jpgfile\DefaultIcon","","REG_SZ",'imageicons.dll,2')
RegWrite("HKCR\pngfile\DefaultIcon","","REG_SZ",'imageicons.dll,3')
RegWrite("HKCR\tgafile\DefaultIcon","","REG_SZ",'imageicons.dll,4')
RegWrite("HKCR\tiffile\DefaultIcon","","REG_SZ",'imageicons.dll,5')
RegWrite("HKCR\psdfile\DefaultIcon","","REG_SZ",'imageicons.dll,6')
EndIf
	GUICtrlSetData($StatusBar, 'Файлы графики ассоциированы с '&$aEXE[1])
            EndIf


;проверка для бинарных файлов (чаще загрузчики WinPE, бутсекторы hdd/cd,dvd/flash)
            If $type1 = "bin" Or $EXENAME = "WinHex" Or $EXENAME = "uedit32" Then
$typeall='bin|bif|bim'
RegWrite("HKCR\.bin","","REG_SZ",'binfile')
RegWrite("HKCR\binfile","","REG_SZ",'бинарный файл')
RegWrite("HKCR\binfile\shell\Open","","REG_SZ",'Открыть в '&$EXENAME)
RegWrite("HKCR\binfile\shell\Open\command","","REG_SZ",'"'&$EXE&'" "%1"')
RegWrite("HKCR\binfile\DefaultIcon","","REG_SZ",'%SystemRoot%\System32\certmgr.dll,11')
RegWrite("HKCR\.bif","","REG_SZ",'binfile')
RegWrite("HKCR\.bim","","REG_SZ",'binfile')

RegWrite("HKCR\Unknown\shell\Open_with_"&$EXENAME,"","REG_SZ","Открыть в "&$EXENAME)
RegWrite("HKCR\Unknown\shell\Open_with_"&$EXENAME&"\command","","REG_SZ",'"'&$EXE&'" "%1"')
	GUICtrlSetData($StatusBar, 'Бинарные файлы ассоциированы с '&$aEXE[1])
            EndIf


;проверка для файлов содержащих ресурсы
            If $type1 = "dll, res" Or $EXENAME = "ResHacker" Or $EXENAME = "pexplorer" Or $EXENAME = "ARTICONS" Or $EXENAME = "IconWorkshop" Then
$typeall='dll|res|cpl|ax|exe|apl'
RegWrite("HKCR\.dll","","REG_SZ",'dllfile')
RegWrite("HKCR\dllfile\shell\Open_with_"&$EXENAME,"","REG_SZ","Открыть в "&$EXENAME)
RegWrite("HKCR\dllfile\shell\Open_with_"&$EXENAME&"\command","","REG_SZ",'"'&$EXE&'" "%1"')

RegWrite("HKCR\.cpl","","REG_SZ",'cplfile')
RegWrite("HKCR\cplfile\shell\Open_with_"&$EXENAME,"","REG_SZ","Открыть в "&$EXENAME)
RegWrite("HKCR\cplfile\shell\Open_with_"&$EXENAME&"\command","","REG_SZ",'"'&$EXE&'" "%1"')

RegWrite("HKCR\.ax","","REG_SZ",'DirectShowFilter')
RegWrite("HKCR\DirectShowFilter\shell\Open_with_"&$EXENAME,"","REG_SZ","Открыть в "&$EXENAME)
RegWrite("HKCR\DirectShowFilter\shell\Open_with_"&$EXENAME&"\command","","REG_SZ",'"'&$EXE&'" "%1"')

RegWrite("HKCR\.exe","","REG_SZ",'exefile')
RegWrite("HKCR\exefile\shell\Open_with_"&$EXENAME,"","REG_SZ","Открыть в "&$EXENAME)
RegWrite("HKCR\exefile\shell\Open_with_"&$EXENAME&"\command","","REG_SZ",'"'&$EXE&'" "%1"')

RegWrite("HKCR\.apl","","REG_SZ",'aplfile')
RegWrite("HKCR\aplfile\shell\Open_with_"&$EXENAME,"","REG_SZ","Открыть в "&$EXENAME)
RegWrite("HKCR\aplfile\shell\Open_with_"&$EXENAME&"\command","","REG_SZ",'"'&$EXE&'" "%1"')

RegWrite("HKCR\dllfile\shell\register","","REG_SZ",'Зарегистрировать')
RegWrite("HKCR\dllfile\shell\register\command","","REG_SZ",'regsvr32.exe "%1"')
RegWrite("HKCR\dllfile\shell\s_unregister","","REG_SZ",'Отмена регистрации')
RegWrite("HKCR\dllfile\shell\s_unregister\command","","REG_SZ",'regsvr32.exe /u "%1"')

; для регистрации (и отмены регистрации) кодеков *.ax в OS
RegWrite("HKCR\DirectShowFilter\shell\register","","REG_SZ",'Зарегистрировать')
RegWrite("HKCR\DirectShowFilter\shell\register\command","","REG_SZ",'regsvr32.exe "%1"')
RegWrite("HKCR\DirectShowFilter\shell\s_unregister","","REG_SZ",'Отмена регистрации')
RegWrite("HKCR\DirectShowFilter\shell\s_unregister\command","","REG_SZ",'regsvr32.exe /u "%1"')

; родной файл ресурсов ResHacker
RegWrite("HKCR\.res","","REG_SZ",'resfile')
RegWrite("HKCR\resfile","","REG_SZ",'Сохранённые ресурсы dll, exe')
RegWrite("HKCR\resfile\shell\Open","","REG_SZ",'Открыть в '&$EXENAME)
RegWrite("HKCR\resfile\shell\Open\command","","REG_SZ",'"'&$EXE&'" "%1"')
If $assot=1 Then RegWrite("HKCR\resfile\DefaultIcon","","REG_SZ",'assot.dll,7')
	GUICtrlSetData($StatusBar, 'Файлы ресурсов ассоциированы с '&$aEXE[1])
            EndIf


;проверка для текстовых файлов
            If $type1 = "текст" Or $EXENAME = "notepad++" Or $EXENAME = "notepad" Or $EXENAME = "akelpad" Or $EXENAME = "bred3_2k" Or $EXENAME = "EmEditor" Or $EXENAME = "PSPad" Or $EXENAME = "SciTE" Or $EXENAME = "Texter2" Or $EXENAME = "uedit32" Then
$typeall='txt|log|ion|cfg|inc|lst|shl|sif|ini|php|bat|cmd|html|reg|inf'
RegWrite("HKCR\.txt","","REG_SZ",'txtfile')
RegWrite("HKCR\.log","","REG_SZ",'txtfile')
RegWrite("HKCR\.ion","","REG_SZ",'txtfile')
RegWrite("HKCR\txtfile\Shell\Open\Command","","REG_SZ",'"'&$EXE&'" "%1"')
RegWrite("HKCR\.cfg","","REG_SZ",'inifile') ; конфигурационный файл в играх
RegWrite("HKCR\.inc","","REG_SZ",'inifile') ; файл настройки gfxboot-меню для grub4dos
RegWrite("HKCR\.lst","","REG_SZ",'inifile') ; файл-меню для grub4dos
RegWrite("HKCR\.shl","","REG_SZ",'inifile') ; текстовый файл описывающий старт программы
RegWrite("HKCR\.sif","","REG_SZ",'inifile') ; файл ответов и файл начальной загрузки OS
RegWrite("HKCR\inifile\Shell\Open\Command","","REG_SZ",'"'&$EXE&'" "%1"')
RegWrite("HKCR\.php","","REG_SZ",'phpfile') ; скрипт движка форума
If $assot=1 Then RegWrite("HKCR\phpfile\DefaultIcon","","REG_SZ",'assot.dll,14')
RegWrite("HKCR\phpfile\Shell\Open\Command","","REG_SZ",'"'&$EXE&'" "%1"')
; пункт контекстного меню "Изменить"
RegWrite("HKCR\batfile\shell\edit\command","","REG_SZ",'"'&$EXE&'" "%1"')
RegWrite("HKCR\cmdfile\shell\edit\command","","REG_SZ",'"'&$EXE&'" "%1"')
RegWrite("HKCR\htmlfile\shell\Edit\command","","REG_SZ",'"'&$EXE&'" "%1"')
RegWrite("HKCR\regfile\shell\edit\command","","REG_SZ",'"'&$EXE&'" "%1"')
RegWrite("HKCR\inffile\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
RegWrite("HKLM\SOFTWARE\Microsoft\Internet Explorer\View Source Editor\Editor Name","","REG_SZ",'"'&$EXE&'"')
	GUICtrlSetData($StatusBar, 'Текстовые файлы ассоциированы с '&$aEXE[1])
            EndIf


;проверка для файлов CD,DVD-образов
            If $type1 = "iso, mdf, img" Or $EXENAME = "UltraISO" Then
$typeall='iso|mdf|img|mds|md0|md1|md2|md3|md4|md5'
RegWrite("HKCR\.iso","","REG_SZ",'isofile')
RegWrite("HKCR\isofile\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
If $assot=1 Then RegWrite("HKCR\isofile\DefaultIcon","","REG_SZ",'assot.dll,16')
RegWrite("HKCR\.mds","","REG_SZ",'mdsfile')
RegWrite("HKCR\mdsfile\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
If $assot=1 Then RegWrite("HKCR\mdsfile\DefaultIcon","","REG_SZ",'assot.dll,18')
RegWrite("HKCR\.mdf","","REG_SZ",'mdffile')
RegWrite("HKCR\mdffile\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
If $assot=1 Then RegWrite("HKCR\mdffile\DefaultIcon","","REG_SZ",'assot.dll,17')
RegWrite("HKCR\.img","","REG_SZ",'imgfile')
RegWrite("HKCR\imgfile\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
If $assot=1 Then RegWrite("HKCR\imgfile\DefaultIcon","","REG_SZ",'assot.dll,15')

RegWrite("HKCR\.md0","","REG_SZ",'md0file')
RegWrite("HKCR\md0file","","REG_SZ",'md0 - файл, часть образа')
If $assot=1 Then RegWrite("HKCR\md0file\DefaultIcon","","REG_SZ",'assot.dll,4')
RegWrite("HKCR\.md1","","REG_SZ",'md0file')
RegWrite("HKCR\.md2","","REG_SZ",'md0file')
RegWrite("HKCR\.md3","","REG_SZ",'md0file')
RegWrite("HKCR\.md4","","REG_SZ",'md0file')
RegWrite("HKCR\.md5","","REG_SZ",'md0file')
	GUICtrlSetData($StatusBar, 'Файлы CD,DVD-образов ассоциированы с '&$aEXE[1])
            EndIf


;проверка для файлов diz, nfo
            If $type1 = "nfo, diz" Or $EXENAME = "AsciiArtStudio" Then
$typeall='nfo|diz'
RegWrite("HKCR\.diz","","REG_SZ",'dizfile')
RegWrite("HKCR\dizfile","","REG_SZ",'Сопроводительный файл к дистрибутиву программы')
If $assot=1 Then RegWrite("HKCR\dizfile\DefaultIcon","","REG_SZ",'assot.dll,10')
RegWrite("HKCR\dizfile\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
RegWrite("HKCR\.nfo","","REG_SZ",'dizfile')
	GUICtrlSetData($StatusBar, 'Файлы diz, nfo ассоциированы с '&$aEXE[1])
            EndIf


;проверка для файлов htm, html
            If $type1 = "htm, html" Or $EXENAME = "Maxthon" Or $EXENAME = "firefox" Or $EXENAME = "opera" Or $EXENAME = "iexplore" Then
$typeall='htm|html'
If $EXENAME = "iexplore" Then
RegWrite("HKCR\.htm","","REG_SZ",'htmlfile')
RegWrite("HKCR\.html","","REG_SZ",'htmlfile')
RegWrite("HKCR\htmlfile\shell\open\command","","REG_SZ",'"'&$EXE&'" -nohome')
RegWrite("HKCR\htmlfile\shell\opennew\command","","REG_SZ",'"'&$EXE&'" "%1"')
Else
RegWrite("HKCR\.htm","","REG_SZ",$EXENAME)
RegWrite("HKCR\.html","","REG_SZ",$EXENAME)
RegWrite("HKCR\"&$EXENAME&"\DefaultIcon","","REG_SZ",'%SystemRoot%\System32\url.dll,0')
RegWrite("HKCR\"&$EXENAME&"\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
EndIf
; клик на ссылках
; RegWrite("HKCR\HTTP\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
; RegWrite("HKCR\HTTP\DefaultIcon","","REG_SZ",'%SystemRoot%\System32\url.dll,0')
RegWrite("HKCR\http\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
RegWrite("HKCR\http\shell\open\ddeexec\Application","","REG_SZ",$EXENAME)
RegWrite("HKCR\http\DefaultIcon","","REG_SZ",'%SystemRoot%\System32\url.dll,0')
RegWrite("HKCR\https\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
RegWrite("HKCR\https\shell\open\ddeexec\Application","","REG_SZ",$EXENAME)
RegWrite("HKCR\https\DefaultIcon","","REG_SZ",'%SystemRoot%\System32\url.dll,0')

RegWrite("HKCR\htmlfile\DefaultIcon","","REG_SZ",'%SystemRoot%\System32\url.dll,0')
	GUICtrlSetData($StatusBar, 'Файлы htm, html ассоциированы с '&$aEXE[1])
            EndIf


;проверка для файлов xls, doc, rtf, pps
            If $type1 = "xls, doc, ppt" And StringInStr($EXENAME, "Excel")>0 Then
$typeall='xls'
RegWrite("HKCR\.xls","","REG_SZ",'xlsfile')
RegWrite("HKCR\xlsfile","","REG_SZ",'Документ Excel')
RegWrite("HKCR\xlsfile\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
If $assot=1 Then RegWrite("HKCR\xlsfile\DefaultIcon","","REG_SZ",'assot.dll,9')
	GUICtrlSetData($StatusBar, 'Файл xls ассоциирован с '&$aEXE[1])
            EndIf
            If $type1 = "xls, doc, ppt" And StringInStr($EXENAME, "Word")>0 Then
$typeall='doc|rtf'
; doc 
RegWrite("HKCR\.doc","","REG_SZ",'docfile')
RegWrite("HKCR\docfile","","REG_SZ",'Документ Word')
RegWrite("HKCR\docfile\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
If $assot=1 Then RegWrite("HKCR\docfile\DefaultIcon","","REG_SZ",'assot.dll,8')
; rtf
RegWrite("HKCR\.rtf","","REG_SZ",'rtffile')
RegWrite("HKCR\rtffile","","REG_SZ",'Документ Word')
RegWrite("HKCR\rtffile\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
If $assot=1 Then RegWrite("HKCR\rtffile\DefaultIcon","","REG_SZ",'assot.dll,8')
	GUICtrlSetData($StatusBar, 'Файлы doc, rtf ассоциированы с '&$aEXE[1])
            EndIf
            If $type1 = "xls, doc, ppt" And StringInStr($EXENAME, "PowerPoint")>0 Then
$typeall='pps|ppt'
; pps 
RegWrite("HKCR\.pps","","REG_SZ",'ppsfile')
RegWrite("HKCR\ppsfile","","REG_SZ",'Документ PowerPoint')
RegWrite("HKCR\ppsfile\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
RegWrite("HKCR\ppsfile\DefaultIcon","","REG_SZ",$EXE&',0')
; ppt 
RegWrite("HKCR\.ppt","","REG_SZ",'ppsfile')
	GUICtrlSetData($StatusBar, 'Файлы pps, ppt ассоциированы с '&$aEXE[1])
            EndIf


;проверка для файлов архивов
            If $type1 = "архивы" Then
$typeall="bootskin|ip|ksf|rar|zip|7z|cab|gz|ace|arj|bzip2|bz|bz2|cpio|deb|dmg|gzip|hfs|jar|lha|lzh|lzma|rpm|split|swm|tar|taz|tbz|tbz2|tgz|tpz|uu|uue|xxe|z|wim|xar"
$aTypeA1 = StringSplit( $typeall, "|")
For $i = 1 To $aTypeA1[0]
	RegWrite("HKCR\."&$aTypeA1[$i],"","REG_SZ",'archive')
Next
RegWrite("HKCR\archive","","REG_SZ",'Архив '&$aEXE[1])
RegWrite("HKCR\archive\DefaultIcon","","REG_SZ",$EXE)
RegWrite("HKCR\archive\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
	GUICtrlSetData($StatusBar, 'Файлы архивов ассоциированы с '&$aEXE[1])
            EndIf


;проверка для файлов Ghostexp
            If $EXENAME = "Ghostexp" Then
$typeall='gho|ghs'
;gho
RegWrite("HKCR\.gho","","REG_SZ",'GHOST')
RegWrite("HKCR\GHOST","","REG_SZ",'Файл GHOST')
If $assot=1 Then RegWrite("HKCR\GHOST\DefaultIcon","","REG_SZ",'assot.dll,0')
RegWrite("HKCR\GHOST\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
;ghs
RegWrite("HKCR\.ghs","","REG_SZ",'ghsfile')
RegWrite("HKCR\ghsfile","","REG_SZ",'ghs - файл, часть образа')
If $assot=1 Then RegWrite("HKCR\ghsfile\DefaultIcon","","REG_SZ",'assot.dll,1')
	GUICtrlSetData($StatusBar, 'Файлы gho, ghs ассоциированы с '&$aEXE[1])
            EndIf


;проверка для файлов ArtIcons
            If $EXENAME = "ARTICONS" Then
$typeall='ico|cur|ani'
RegWrite("HKCR\icofile","","REG_SZ",'icofile')
RegWrite("HKCR\icofile\DefaultIcon","","REG_SZ",'%1')
RegWrite("HKCR\icofile\shell","","REG_SZ",'open')
RegWrite("HKCR\icofile\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
RegWrite("HKCR\.ico","","REG_SZ",'icofile')
RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ico","Progid","REG_SZ",'icofile')
RegWrite("HKCR\.cur","","REG_SZ",'icofile')
RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.cur","Progid","REG_SZ",'icofile')
RegWrite("HKCR\.ani","","REG_SZ",'icofile')
RegWrite("HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ani","Progid","REG_SZ",'icofile')
	GUICtrlSetData($StatusBar, 'Файлы ico, cur, ani ассоциированы с '&$aEXE[1])
            EndIf


;проверка для файлов WinImage
            If $EXENAME = "WinImage" Then
$typeall='ima'
RegWrite("HKCR\.ima","","REG_SZ",'WinImage')
If $assot=1 Then RegWrite("HKCR\WinImage\DefaultIcon","","REG_SZ",'assot.dll,2')
RegWrite("HKCR\WinImage\shell\Extract\command","","REG_SZ",'"'&$EXE&'" /e "%1"')
RegWrite("HKCR\WinImage\shell\open\command","","REG_EXPAND_SZ",'"'&$EXE&'" "%1"')
	GUICtrlSetData($StatusBar, 'Файл ima ассоциированы с '&$aEXE[1])
            EndIf


;проверка для файлов vmidi
            If $EXENAME = "vmidi" Then
$typeall='kar|mid|rmi'
RegWrite("HKCR\.kar","","REG_SZ",'vanBasco.MIDI')
RegWrite("HKCR\.mid","","REG_SZ",'vanBasco.MIDI')
RegWrite("HKCR\.rmi","","REG_SZ",'vanBasco.MIDI')
RegWrite("HKCR\vanBasco.MIDI","","REG_SZ",'vanBasco''s Karaoke Player MIDI Sequence')
RegWrite("HKCR\vanBasco.MIDI","EditFlags","REG_DWORD",'65536')
RegWrite("HKCR\vanBasco.MIDI\DefaultIcon","","REG_SZ",'%SystemRoot%\System32\mmsys.cpl,19')
RegWrite("HKCR\vanBasco.MIDI\shell","","REG_SZ",'play')
RegWrite("HKCR\vanBasco.MIDI\shell\open","","REG_SZ",'&Open')
RegWrite("HKCR\vanBasco.MIDI\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
RegWrite("HKCR\vanBasco.MIDI\shell\open\ddeexec","","REG_SZ",'[load("%1")]')
RegWrite("HKCR\vanBasco.MIDI\shell\play","","REG_SZ",'&Play')
RegWrite("HKCR\vanBasco.MIDI\shell\play\command","","REG_SZ",'"'&$EXE&'" "%1"')
RegWrite("HKCR\vanBasco.MIDI\shell\play\ddeexec","","REG_SZ",'[load("%1")][play]')
	GUICtrlSetData($StatusBar, 'Файлы kar, mid ассоциированы с '&$aEXE[1])
            EndIf


;проверка для файлов WinRAR
            If $type1<>"архивы" and $EXENAME = "WinRAR" Then
$typeall="rar|cab|gz|ace|arj|bz|bz2|jar|lha|lzh|tar|tbz|tbz2|tgz|uu|uue|xxe|z|r00|r01|r02|r03|r04|r05|r06|r07|r08|r09|r10|r11|r12|r13|r14|r15|r16|r17|r18|r19|r20|r21|r22|r23|r24|r25|r26|r27|r28|r29"
$aTypeR1 = StringSplit( $typeall, "|")
For $i = 1 To $aTypeR1[0]
	RegWrite("HKCR\."&$aTypeR1[$i],"","REG_SZ",'WinRAR')
Next
; отсебятина
RegWrite("HKCR\.bootskin","","REG_SZ",'WinRAR.ZIP')
RegWrite("HKCR\.ip","","REG_SZ",'WinRAR.ZIP')
RegWrite("HKCR\.ksf","","REG_SZ",'WinRAR.ZIP')
; популярные типы файлов
RegWrite("HKCR\.zip","","REG_SZ",'WinRAR.ZIP')
RegWrite("HKCR\.7z","","REG_SZ",'7zfile')
If $assot=1 Then RegWrite("HKCR\WinRAR\DefaultIcon","","REG_SZ",'assot.dll,5')
RegWrite("HKCR\WinRAR\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
If $assot=1 Then RegWrite("HKCR\WinRAR.ZIP\DefaultIcon","","REG_SZ",'assot.dll,22')
RegWrite("HKCR\WinRAR.ZIP\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
If $assot=1 Then RegWrite("HKCR\7zfile\DefaultIcon","","REG_SZ",'assot.dll,21')
RegWrite("HKCR\7zfile\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
	GUICtrlSetData($StatusBar, 'Файлы архивов ассоциированы с '&$aEXE[1])
            EndIf


;проверка для файлов 7zip
            If $type1<>"архивы" and $EXENAME = "7zFM" Then
$typeall="rar|zip|7z|cab|gz|arj|bzip2|bz2|cpio|deb|dmg|gzip|hfs|lha|lzh|lzma|rpm|split|swm|tar|taz|tbz|tbz2|tgz|tpz|z|wim|xar"
; отсебятина
RegWrite("HKCR\.bootskin","","REG_SZ",'7-Zip.zip')
RegWrite("HKCR\.ip","","REG_SZ",'7-Zip.zip')
RegWrite("HKCR\.ksf","","REG_SZ",'7-Zip.zip')

$aType7 = StringSplit( $typeall, "|")
For $i = 1 To $aType7[0]
	RegWrite("HKCR\."&$aType7[$i],"","REG_SZ",'7-Zip.'&$aType7[$i])
	RegWrite("HKCR\7-Zip."&$aType7[$i],"","REG_SZ",$aType7[$i]&' - архив')
	RegWrite("HKCR\7-Zip."&$aType7[$i]&"\shell","","REG_SZ",'')
	RegWrite("HKCR\7-Zip."&$aType7[$i]&"\shell\open","","REG_SZ",'')
	RegWrite("HKCR\7-Zip."&$aType7[$i]&"\shell\open\command","","REG_SZ",'"'&$EXE&'" "%1"')
Next

RegWrite("HKCR\7-Zip.7z\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,0')
RegWrite("HKCR\7-Zip.arj\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,4')
RegWrite("HKCR\7-Zip.bz2\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,2')
RegWrite("HKCR\7-Zip.bzip2\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,2')
RegWrite("HKCR\7-Zip.cab\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,7')
RegWrite("HKCR\7-Zip.cpio\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,12')
RegWrite("HKCR\7-Zip.deb\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,11')
RegWrite("HKCR\7-Zip.dmg\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,17')
RegWrite("HKCR\7-Zip.gz\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,14')
RegWrite("HKCR\7-Zip.gzip\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,14')
RegWrite("HKCR\7-Zip.hfs\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,18')
RegWrite("HKCR\7-Zip.lha\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,6')
RegWrite("HKCR\7-Zip.lzh\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,6')
RegWrite("HKCR\7-Zip.lzma\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,16')
RegWrite("HKCR\7-Zip.rar\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,3')
RegWrite("HKCR\7-Zip.rpm\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,10')
RegWrite("HKCR\7-Zip.split\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,9')
RegWrite("HKCR\7-Zip.swm\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,15')
RegWrite("HKCR\7-Zip.tar\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,13')
RegWrite("HKCR\7-Zip.taz\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,5')
RegWrite("HKCR\7-Zip.tbz\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,2')
RegWrite("HKCR\7-Zip.tbz2\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,2')
RegWrite("HKCR\7-Zip.tgz\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,14')
RegWrite("HKCR\7-Zip.tpz\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,14')
RegWrite("HKCR\7-Zip.wim\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,15')
RegWrite("HKCR\7-Zip.xar\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,19')
RegWrite("HKCR\7-Zip.z\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,5')
RegWrite("HKCR\7-Zip.zip\DefaultIcon","","REG_SZ",$aEXE[0]&'\7z.dll,1')
	GUICtrlSetData($StatusBar, 'Файлы архивов ассоциированы с '&$aEXE[1])
            EndIf
				If GUICtrlRead($autoicons)=1 and $typeall<>'' Then DllCall("shell32.dll", "none", "SHChangeNotify", "long", '0x8000000', "uint", '0x1000', "ptr", '0', "ptr", '0')
				If GUICtrlRead($saveBK)=1 and $typeall<>'' Then _backup($typeall, $EXE)
		Case $saveall
				$typeall="avi|mpg|mpeg|mp4|asx|asf|wmv|3gp|mov|mkv|ifo|vob|flv" & _
"mp3|wav|wma|ogg|m3u|pls" & _
"bmp|gif|jpg|png|tga|tif|psd" & _
'bin|bif|bim' & _
'dll|res|cpl|ax|exe|apl' & _
'txt|log|ion|cfg|inc|lst|shl|sif|ini|php|bat|cmd|html|reg|inf' & _
'iso|mdf|img|mds|md0|md1|md2|md3|md4|md5' & _
'nfo|diz' & _
'htm|html' & _
'xlsdoc|rtf|pps|ppt' & _
'gho|ghs' & _
'ico|cur|ani' & _
'ima' & _
'kar|mid|rmi' & _
"bootskin|ip|ksf|rar|zip|7z|cab|gz|ace|arj|bzip2|bz|bz2|cpio|deb|dmg|gzip|hfs|jar|lha|lzh|lzma|rpm|split|swm|tar|taz|tbz|tbz2|tgz|tpz|uu|uue|xxe|z|wim|xar"
;MsgBox(4, "gf", $typeall)
;Exit
				$EXE=''
				_backup($typeall, $EXE)
		Case $Updateicon
				_RebuildShellIconCache()
		Case $info
            $type1=GUICtrlRead ($type)
            If $type1 = "авто" Then MsgBox(0, "Информация", 'Если установлено "авто", то утилита автоматически определяет с какими файлами ассоциировать программу.'&@CRLF&'Если программы не оказалось в списке авто-детектирования, то выбираем тип программы и она будет ассоциированна с указанным типом.'&@CRLF&'Недостатки: возможно мои предпочтения не совпадают с вашими, иногда даже изменяются со временем. Здесь поможет только редактирование скрипта добавлением или удалением строк параметров для реестра.'&@CRLF&'В "авто" утилита дополнительно принимает индивидуально программы: Ghostexp, ArtIcons, vanBasco''s Karaoke Player, WinImage, WinRAR, 7zFM, для которых делает ассоциации.')
            If $type1 = "видео" Then MsgBox(0, "Информация", "Авто-детектируемые плееры:"&@CRLF&"mplayerc, kmplayer"&@CRLF&""&@CRLF&"Расширения:"&@CRLF&"avi, mpg, mpeg, mp4, asx, asf,"&@CRLF&"wmv, 3gp, mov, mkv, ifo, vob, flv")
            If $type1 = "bin" Then MsgBox(0, "Информация", "Авто-детектируемые:"&@CRLF&"WinHex, uedit32"&@CRLF&""&@CRLF&"Расширения:"&@CRLF&"bin, bif, bim, Unknown")
            If $type1 = "текст" Then MsgBox(0, "Информация", "Авто-детектируемые редакторы:"&@CRLF&"notepad++, notepad, akelpad, bred3_2k,"&@CRLF&"EmEditor, PSPad, SciTE, Texter2, uedit32"&@CRLF&""&@CRLF&"Расширения:"&@CRLF&"txt, log, ion, ini, cfg, inc, lst, shl, sif, php, inf"&@CRLF&"А также пункт ""Изменить"" для:"&@CRLF&"bat, cmd, htm, reg"&@CRLF&"И просморщик HTML-кода.")
            If $type1 = "музыка" Then MsgBox(0, "Информация", "Авто-детектируемые плееры:"&@CRLF&"AIMP2, winamp"&@CRLF&""&@CRLF&"Расширения:"&@CRLF&"mp3, wav, wma, ogg, m3u, pls")
            If $type1 = "dll, res" Then MsgBox(0, "Информация", "Авто-детектируемые программы:"&@CRLF&"ResHacker, pexplorer, ARTICONS, IconWorkshop"&@CRLF&""&@CRLF&"Расширения:"&@CRLF&"dll, res, cpl, ax, exe, apl"&@CRLF&"В контекстное меню добавляется пункты:"&@CRLF&"Открыть в %программе%"&@CRLF&"а также ""Регистрировать"" и ""Отмена регистрации""")
            If $type1 = "iso, mdf, img" Then MsgBox(0, "Информация", "Авто-детектируемые:"&@CRLF&"UltraISO"&@CRLF&""&@CRLF&"Расширения:"&@CRLF&"iso, mds, mdf, img")
            If $type1 = "nfo, diz" Then MsgBox(0, "Информация", "Авто-детектируемые:  AsciiArtStudio"&@CRLF&""&@CRLF&"Расширения:   diz, nfo"&@CRLF&""&@CRLF&"Для этих файлов можно"&@CRLF&"использовать любой блокнот.")
            If $type1 = "xls, doc, ppt" Then MsgBox(0, "Информация", "Без авто-детектирования:"&@CRLF&"принимаются только портабельные сборки"&@CRLF&"содержащие в именах файлов Excel, Word, PowerPoint"&@CRLF&"и обязательно при условии выбора xls, doc, ppt"&@CRLF&""&@CRLF&"Расширения:   xls, doc, rtf, ppt, pps")
            If $type1 = "архивы" Then MsgBox(0, "Информация", "Без авто-детектирования"&@CRLF&"WinRAR и 7zFM лучше принимать в авто"&@CRLF&"здесь универсальный способ"&@CRLF&"дающий одинаковую иконку программы всем архивам"&@CRLF&""&@CRLF&"Расширения:   (bootskin, ip, ksf) rar, zip, 7z, cab, gz, ace, arj,"&@CRLF&"bzip2, bz, bz2, cpio, deb, dmg, gzip, hfs, jar, lha, lzh, lzma,"&@CRLF&"rpm, split, swm, tar, taz, tbz, tbz2, tgz, tpz, uu, uue, xxe, z, wim, xar")
            If $type1 = "htm, html" Then MsgBox(0, "Информация", "Авто-детектируемые"&@CRLF&"Maxthon, Firefox, Opera, iexplore"&@CRLF&@CRLF&"Расширения:  htm, html")
            If $type1 = "гарфика" Then MsgBox(0, "Информация", "Авто-детектируемые"&@CRLF&"Imagine, mspaint, HprSnap6,"&@CRLF&"PhotoFiltre, Photoshop, GIMP"&@CRLF&@CRLF&"Расширения:"&@CRLF&"bmp, gif, jpg, png, tga, tif, psd")
		Case $warning
				MsgBox(0, "Напутствие", "Перед использованием программы сделайте точку восстановления, данные изменяются только в реестре, поэтому легко будет сделать откат системы."&@CRLF&"Когда появится доверие к программе и сделанные изменения будут устраивать, тогда можно будет пользоваться и без контрольных точек."&@CRLF&"После выполнения операций проверяйте открытие, иконки и контекстное меню у ассоциированных файлов."&@CRLF&"Программа тестирована на - WindousXP SP3 (SP1 и SP2 - аналогичны).")
		Case -3
				ExitLoop
		EndSwitch
WEnd

Func _backup($typeall, $EXE)
	Local $Data, $filename
	If $EXE Then
		$EXE='before_'&StringRegExpReplace($EXE, '^(?:.*\\)([^\\]*?)(?:\.[^.]+)?$', '\1')
	Else
		$EXE='all_assot'
	EndIf
	$filename=@ScriptDir&'\backup_'&$EXE
	; генерируем имя нового файла с номером копии на случай если файл существует
	$j = 1
	While FileExists($filename&$j&'.reg')
		$j +=1
	WEnd
	$filename=$filename&$j&'.reg'
	$aTypeAll = StringSplit( $typeall, "|")
	$TypeFileData='|' ; для отфильтровки повторного обращения к классу ассоциаций

	For $i = 1 To $aTypeAll[0]
		
		$ProgidR = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $aTypeAll[$i], 'Progid')
		If Not @error And $ProgidR <> '' Then
			$TypeNR = $ProgidR
		Else
			$TypeNR = RegRead('HKEY_CLASSES_ROOT\.' & $aTypeAll[$i], '')
			If @error Then ContinueLoop
		EndIf
		
		$RunR = RegEnumKey('HKEY_CLASSES_ROOT\' & $TypeNR & '\shell', 1)
		If @error Then ContinueLoop
		GUICtrlSetData($StatusBar, $aTypeAll[$i])
		
		_RegExport_X('HKEY_CLASSES_ROOT\.' & $aTypeAll[$i], $Data)
		_RegExport_X('HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.' & $aTypeAll[$i], $Data)

		
		If Not _Reg_Exists("HKCR\"&$TypeNR) or StringInStr($TypeFileData, '|' & $TypeNR & '|') Then ContinueLoop
		$TypeFileData &=$TypeNR & '|'
		_RegExport_X('HKEY_CLASSES_ROOT\' & $TypeNR, $Data)
	Next

	$hFile = FileOpen($filename, 2) ; открываем бэкап-файл
	; $Data=StringTrimRight (StringRegExpReplace($Data & "[","\[[^\]]*\]\s*(?=\[)",""),1) ; удаление строк создание разделов не содержащих параметры
	FileWrite($hFile, 'Windows Registry Editor Version 5.00'&@CRLF&@CRLF&$Data&@CRLF)
	FileClose($hFile)
	GUICtrlSetData($StatusBar, 'Экпорт выполнен в файл "backup_'&$EXE&$j&'.reg"')
EndFunc

Func _About()
$LngTitle='Assotiations'
$LngAbout='О программе'
$LngVer='Версия'
$LngSite='Сайт'
$LngCopy='Копировать'

$GP=_ChildCoor($Gui, 270, 180)
GUISetState(@SW_DISABLE, $Gui)
$font="Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOr($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	If Not @Compiled Then GUISetIcon(@ScriptDir & '\assotiations.ico')
	GUISetBkColor (0xE1E3E7)
	GUICtrlCreateLabel($LngTitle, 0, 0, 270, 63, 0x01+0x0200)
	GUICtrlSetFont (-1,15, 600, -1, $font)
	GUICtrlSetColor(-1,0x3a6a7e)
	GUICtrlSetBkColor (-1, 0xF1F1EF)
	GUICtrlCreateLabel ("-", 2,64,268,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 1.4  2012.08.31', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite&':', 55, 115, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetColor(-1,0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010-2012', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)

	While 1
	  Switch GUIGetMsg()
		Case $url
			ShellExecute ('http://azjio.ucoz.ru')
		Case $WbMn
			ClipPut('R939163939152')
		Case -3
			GUISetState(@SW_ENABLE, $Gui)
			GUIDelete($Gui1)
			ExitLoop
		EndSwitch
    WEnd
EndFunc

; 'изменение/восстановление'&@CRLF&'ассоциаций файлов'