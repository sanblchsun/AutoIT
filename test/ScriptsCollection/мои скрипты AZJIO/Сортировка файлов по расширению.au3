#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=Sort.exe
#AutoIt3Wrapper_icon=Sort.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Sort.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Field=Version|0.1
#AutoIt3Wrapper_Res_Field=Build|2011.09.24
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****



#NoTrayIcon
Opt("GUIOnEventMode", 1)
#include <FileOperations.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $iniTypeFile='avi;mpg;mpeg;mp4;vob;mkv;asf;asx;wmv;mov;3gp;flv;bik|mp3;wav;wma;ogg;ac3|bak;gid;log;tmp'& _
	'|htm;html;css;js;php|bmp;gif;jpg;jpeg;png;tif;tiff|exe;msi;scr;dll;cpl;ax|com;sys;bat;cmd'
Global $ini=@ScriptDir&'\sort_files.ini'

If Not FileExists($ini) And DriveStatus(StringLeft(@ScriptDir, 1))<>'NOTREADY' Then
	$file = FileOpen($ini,2)
	FileWrite($file, '[Set]' &@CRLF& _
	'TypeFile='&$iniTypeFile &@CRLF& _
	'TrType='&@CRLF& _
	'LastType='&@CRLF& _
	'Size='&@CRLF& _
	'PathOut='&@CRLF& _
	'Path=')
	FileClose($file)
EndIf

$iniTypeFile=IniRead($Ini, 'Set', 'TypeFile', $iniTypeFile)
$iniPath=IniRead($Ini, 'Set', 'Path', '')
$iniOutPath=IniRead($Ini, 'Set', 'PathOut', '')
$LastType=IniRead($Ini, 'Set', 'LastType', '')
$iniSize=IniRead($Ini, 'Set', 'Size', '')
$iniTrType=IniRead($Ini, 'Set', 'TrType', '')

If $LastType And $iniTypeFile And StringInStr('|'&$iniTypeFile&'|', '|'&$LastType&'|') Then
	StringReplace('|'&$iniTypeFile&'|', '|'&$LastType&'|', '|')
	StringTrimLeft($iniTypeFile, 1)
	StringTrimRight($iniTypeFile, 1)
EndIf

GUICreate("Сортировка по расширению", 450, 230, -1, -1, -1, $WS_EX_ACCEPTFILES) ; размер окна
If Not @compiled Then GUISetIcon(@ScriptDir&'\Sort.ico')
; GUISetBkColor(0xF9F9F9)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
GUISetOnEvent($GUI_EVENT_DROPPED, "_Dropped")

$StatusBar = GUICtrlCreateLabel(@CRLF & 'Строка состояния', 5, 196, 330, 34)

GUICtrlCreateLabel("Путь - источник (используйте drag-and-drop)", 20, 13, 400, 20)

$inpPath = GUICtrlCreateInput("", 20, 30, 410, 22)
GUICtrlSetState(-1, 8)
If $iniPath Then GUICtrlSetData(-1, $iniPath)


GUICtrlCreateLabel("Путь - получатель (используйте drag-and-drop)", 20, 63, 400, 20)
$OutPath = GUICtrlCreateInput("", 20, 80, 410, 22)
GUICtrlSetState(-1, 8)
If $iniOutPath Then GUICtrlSetData(-1, $iniOutPath)

$Ignore = GUICtrlCreateRadio("Игнорировать типы файлов", 20, 113, 180, 17)
GUICtrlSetTip(-1, "Если поле раскрывающегося списка" & @CRLF & "пустое, то этот пункт не учитывается")
$deltype = GUICtrlCreateRadio("Удалять типы файлов", 20, 130, 180, 17)
GUICtrlSetTip(-1, "Если поле раскрывающегося списка" & @CRLF & "пустое, то этот пункт не учитывается")

$typefile = GUICtrlCreateCombo("", 200, 117, 230, 24)
GUICtrlSetData(-1, $LastType&'|'&$iniTypeFile, $LastType)
GUICtrlSetTip(-1, "Оставте поле пустым" & @CRLF & "для игнорирования параметра")

GUICtrlCreateLabel("Удалять файлы менее указанного размера, кб", 20, 160, 260, 20)
$size = GUICtrlCreateInput("", 280, 157, 100, 22)
GUICtrlSetTip(-1, "Оставте поле пустым" & @CRLF & "для игнорирования размера")
If $iniSize Then GUICtrlSetData(-1, $iniSize)

$checkAtrb = GUICtrlCreateCheckbox("Снять атрибут", 20, 180, 95, 17)
GuiCtrlSetState(-1, 1)

$startsh = GUICtrlCreateButton("Сортировать", 340, 190, 90, 33)
GUICtrlSetOnEvent(-1, "_Sort")

$typefile0 = GUICtrlRead($typefile)
Switch $iniTrType
	Case 1
		If $typefile0 Then GUICtrlSetState($Ignore, 1)
	Case 2
		If $typefile0 Then GUICtrlSetState($deltype, 1)
EndSwitch

GUISetState()
OnAutoItExitRegister("_Exit_Save_Ini")

While 1
	Sleep(10000000)
WEnd

Func _Exit_Save_Ini()
	If DriveStatus(StringLeft(@ScriptDir, 1))<>'NOTREADY' Then
		$typefile0 = GUICtrlRead($typefile)
		If $typefile0<>$LastType Then IniWrite($Ini, 'Set', 'LastType', $typefile0)
		
		$inpPath0 = GUICtrlRead($inpPath)
		If FileExists($inpPath0) And $iniPath<>$inpPath0 Then IniWrite($Ini, 'Set', 'Path', $inpPath0)
		
		$OutPath0 = GUICtrlRead($OutPath)
		If FileExists($OutPath0) And $iniOutPath<>$OutPath0 Then IniWrite($Ini, 'Set', 'PathOut', $OutPath0)
		
		$size0 = GUICtrlRead($size)
		If $size0<>$iniSize Then IniWrite($Ini, 'Set', 'Size', $size0)
		
		If GUICtrlRead($Ignore)=1 And $iniTrType<>1 Then
			IniWrite($Ini, 'Set', 'TrType', 1)
		ElseIf GUICtrlRead($deltype)=1 And $iniTrType<>2 Then
			IniWrite($Ini, 'Set', 'TrType', 2)
		ElseIf GUICtrlRead($typefile)='' And $iniTrType<>0 Then
			IniWrite($Ini, 'Set', 'TrType', 0)
		EndIf
	EndIf
EndFunc

Func _Sort()
	$del0 = 0
	$ign0 = 0
	$move0 = 0
	$checkAtrb0 = GUICtrlRead($checkAtrb)
	$Ignore0 = GUICtrlRead($Ignore)
	$deltype0 = GUICtrlRead($deltype)
	$OutPath0 = GUICtrlRead($OutPath)
	$inpPath0 = GUICtrlRead($inpPath)
	$typefile0=StringRegExpReplace(';'&GUICtrlRead($typefile)&';', '[;]+', ';')
	$size0 = 1024 * GUICtrlRead($size)
	GUICtrlSetData($StatusBar, @CRLF & 'Началось...')
	If StringRegExpReplace($OutPath0, '[A-z]:\\[^/:*?"<>|]*', '') Or StringInStr($OutPath0, '\\') Or Not $OutPath0 Then Return MsgBox(0, 'Ошибка', 'Путь содержит неверные символы')
	If StringRight($OutPath0, 1)='\' Then $OutPath0 = StringTrimRight($OutPath0, 1)
	; поиск файлов
	If FileExists($inpPath0) Then
		$inpPath1 = StringRegExpReplace($inpPath0, "(^.*)\\(.*)$", '\1')
		$FileList = _FO_FileSearch($inpPath0, '*', True, 125, 1, 0) ; список полных путей
		If @error Then
			GUICtrlSetData($StatusBar, 'Файлов ненайдено')
			$FileList=''
			Return
		EndIf
		$FileList=StringRegExp($FileList, '(?m)^(.*\\)(.*?)(?:\r|\z)', 3)
		$ArrSz=UBound($FileList)
		
		GUICtrlSetData($StatusBar, @CRLF & 'Обрабатываются '&$ArrSz/2&' файлов')
; $fileName = $FileList[$i+1]
		For $i = 0 To $ArrSz-1 Step 2
			If StringInStr($FileList[$i+1], '.') Then
				$tmptype = StringTrimLeft($FileList[$i+1], StringInStr($FileList[$i+1], '.', 0, -1)) ; получить расширение файла
				$typeFolder = $tmptype
				
				If $deltype0 = 1 And $typefile0 And StringInStr($typefile0, ';' & $tmptype & ';') Then ; удалить типы файлов
					If $checkAtrb0=1 Then FileSetAttrib($FileList[$i]&$FileList[$i+1], "-RASHT")
					If FileDelete($FileList[$i]&$FileList[$i+1]) Then
						$del0 += 1
					Else
						$ign0 += 1
					EndIf
					ContinueLoop
				ElseIf $Ignore0 = 1 And $typefile0 And StringInStr($typefile0, ';' & $tmptype & ';') Then ; игнорировать
					$ign0 += 1
					ContinueLoop
				EndIf
			Else
				$tmptype = ''
				$typeFolder = 'файлы без расширения'
			EndIf

			If $size0 And FileGetSize($FileList[$i]&$FileList[$i+1]) <= $size0 Then ; удалить если менее указанного размера
				If $checkAtrb0=1 Then FileSetAttrib($FileList[$i]&$FileList[$i+1], "-RASHT")
				If FileDelete($FileList[$i]&$FileList[$i+1]) Then
					$del0 += 1
				Else
					$ign0 += 1
				EndIf
				ContinueLoop
			EndIf
			; если файл существует в новом каталоге, то переименовать его перед перемещением, иначе переместить
			$Path = $OutPath0 & '\' & $typeFolder & '\' & $FileList[$i+1]
			If FileExists($Path) Then
				If $tmptype Then
					$Name = StringLeft($FileList[$i+1], StringInStr($FileList[$i+1], '.', 0, -1)-1) ; получить имя файла без расширения
					$tmptype='.'&$tmptype
				Else
					$Name = $FileList[$i+1]
				EndIf
				; цикл проверки одноимённых файлов
				$j = 0
				Do
					$j+=1
					If $j = 1 Then
						$Path=$OutPath0 & '\' & $typeFolder & '\' & $Name & ' Копия' & $tmptype
					Else
						$Path=$OutPath0 & '\' & $typeFolder & '\' & $Name & ' Копия (' & $j & ')' & $tmptype
					EndIf
				Until Not FileExists($Path)
			EndIf
			If $checkAtrb0=1 Then FileSetAttrib($FileList[$i]&$FileList[$i+1], "-RASHT")
			If FileMove($FileList[$i]&$FileList[$i+1], $Path, 8) Then ; перемещаем если одноимённого не существует
				$move0 += 1
			Else
				$ign0 += 1
			EndIf
		Next
	EndIf
	GUICtrlSetData($StatusBar, 'Выполнено...  Из ' & $ArrSz/2 & ' файлов' & @CRLF & 'перемещено: ' & $move0 & ',  удалено: ' & $del0 & ',  игнорир: ' & $ign0)
EndFunc

Func _Dropped()
	Switch @GUI_DropID
		Case $inpPath
			GUICtrlSetData($inpPath, @GUI_DRAGFILE)
			GUICtrlSetData($OutPath, StringRegExpReplace(@GUI_DRAGFILE, "(^.*)\\(.*)$", '\1')&'\root')
		Case $OutPath
			GUICtrlSetData($OutPath, @GUI_DRAGFILE)
	EndSwitch
EndFunc

Func _Exit()
	Exit
EndFunc