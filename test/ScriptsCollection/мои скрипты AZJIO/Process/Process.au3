#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=Process.exe
#AutoIt3Wrapper_icon=Process.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Process.exe
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Icon_Add=1.ico
#AutoIt3Wrapper_Res_Icon_Add=2.ico
#AutoIt3Wrapper_Res_Field=Version|0.1
#AutoIt3Wrapper_Res_Field=Build|2011.10.19
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
; #AutoIt3Wrapper_Run_Obfuscator=y
; #Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
; #AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; #NoTrayIcon
#include "_RefreshTrayIcons.au3"
#include <Array.au3>

; En
$LngErr='Error'
$LngMB0='Message'
$LngMB1='Not found parameter list type (e or i)'
$LngMB2='There is no file in the specified path'
$LngMB3='Not found the option file path'
$LngMB4='The timer parameter not found'
$LngMB5='Missing file-list:'
$LngMB6='Want to create a list of current processes now?'
$LngLg1='Start, delay:'
$LngLg2='mode:'
$LngTT1='Delay:'
$LngTT2='Successfully completed:'
$LngTT3='Failed to complete:'
$LngTT4='Successfully completed'
$LngTT5='Failed to complete'
$LngCopy='Copy'
$LngHLP='Supported keys:'&@CRLF& _
'/3000 /e /path /l - Close the processes except those specified in the file list every 3 seconds, write to log file'&@CRLF& _
'/3000 /i /path /l - Close the processes specified in the file list every 3 seconds, write to log file'&@CRLF& _
'/3000 /e /path - Close the processes except those specified in the file list every 3 seconds'&@CRLF& _
'/3000 /i /path - Close the processes specified in the file list every 3 seconds'&@CRLF& _
'/e /path - Close the processes except those specified in the file list, and Exit'&@CRLF& _
'/i /path - Close the processes specified in the file list, and Exit'&@CRLF& _
'/3000 /e - Close the processes except those specified in the file list (ExceptProcessList.txt) every 3 seconds'&@CRLF& _
'/3000 /i - Close the processes specified in the file list (IncludeProcessList.txt) every 3 seconds'&@CRLF& _
'/e - Close the processes except those specified in the file list (ExceptProcessList.txt), and Exit'&@CRLF& _
'/i - Close the processes specified in the file list (IncludeProcessList.txt), and Exit'&@CRLF& _
'/c - Create a list of current processes, and Exit'&@CRLF&@CRLF& _
'IncludeProcessList.txt MUST NOT contain a list of system processes.'&@CRLF& _
'ExceptProcessList.txt SHOULD contain a list of system processes.'&@CRLF& _
'Starting without parameters implies a / e (if, there is a list)'

$UserIntLang=DllCall('kernel32.dll', 'int', 'GetUserDefaultUILanguage')
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
$LngErr='Ошибка'
$LngMB0='Сообщение'
$LngMB1='Не найден параметр тип списка (e или i)'
$LngMB2='Отсутствует файл по указанному пути'
$LngMB3='Не найден параметр пути к файлу'
$LngMB4='Не найден параметр таймера'
$LngMB5='Отсутствует файл-список:'
$LngMB6='Желаете сейчас создать список текущих процессов?'
$LngLg1='Старт, задержка:'
$LngLg2='режим:'
$LngTT1='Задержка:'
$LngTT2='Удачно завершено:'
$LngTT3='Не удалось завершить:'
$LngTT4='Удачно завершен'
$LngTT5='Не удалось завершить'
$LngCopy='Копия'
$LngHLP='Поддерживаются ключи:'&@CRLF& _
'/3000 /e /путь /l - Закрывать процессы кроме указанных в файл-списке каждые 3 секунды с записью лога'&@CRLF& _
'/3000 /i /путь /l - Закрывать процессы указанные в файл-списке каждые 3 секунды с записью лога'&@CRLF& _
'/3000 /e /путь - Закрывать процессы кроме указанных в файл-списке каждые 3 секунды'&@CRLF& _
'/3000 /i /путь - Закрывать процессы указанные в файл-списке каждые 3 секунды'&@CRLF& _
'/e /путь - Закрыть процессы кроме указанных в файл-списке и завершить скрипт'&@CRLF& _
'/i /путь - Закрыть процессы указанные в файл-списке и завершить скрипт'&@CRLF& _
'/3000 /e - Закрывать процессы кроме указанных в файл-списке ExceptProcessList.txt каждые 3 секунды'&@CRLF& _
'/3000 /i - Закрывать процессы указанные в файл-списке IncludeProcessList.txt каждые 3 секунды'&@CRLF& _
'/e - Закрыть процессы кроме указанных в файл-списке ExceptProcessList.txt и завершить скрипт'&@CRLF& _
'/i - Закрыть процессы указанные в файл-списке IncludeProcessList.txt и завершить скрипт'&@CRLF& _
'/c - Создать список текущих процессов и завершить скрипт'&@CRLF&@CRLF& _
'IncludeProcessList.txt НЕ ДОЛЖЕН содержать список систеных процессов.'&@CRLF& _
'ExceptProcessList.txt ДОЛЖЕН содержать список систеных процессов.'&@CRLF& _
'Запуск без параметров аналогично параметру /e (при условии существования списка)'
EndIf



Global $cmd_Log=0, $FileLog, $cmd_Path, $cmd_TypeList, $cmd_Timer, $spr=Chr(6)&Chr(1)&Chr(6) ; разделитель параметров

Switch $CmdLine[0]
	Case 0
		_Kill(@ScriptDir&'\ExceptProcessList.txt', 'e')
	Case 1
		Switch $CmdLine[1]
			Case '\e', '/e', '-e', 'e'
				_Kill(@ScriptDir&'\ExceptProcessList.txt', 'e')
			Case '\i', '/i', '-i', 'i'
				_Kill(@ScriptDir&'\IncludeProcessList.txt', 'i')
			Case '\c', '/c', '-c', 'c'
				_CreateList()
		EndSwitch
	Case 2
		$ParamLine=$spr&_ArrayToString($CmdLine, $spr, 1)&$spr
		
		; e или i - тип списка
		$aTmp=StringRegExp($ParamLine,  '(?i)'&$spr&'[\\/\-]?(e|i)'&$spr, 3)
		If Not @error And UBound($aTmp)=1 Then
			$cmd_TypeList=$aTmp[0]
		Else
			MsgBox(0, $LngErr, $LngMB1)
			Exit
		EndIf
		
		; 3000 - таймер
		$aTmp=StringRegExp($ParamLine,  $spr&'[\\/\-]?(\d+?)'&$spr, 3)
		If Not @error And UBound($aTmp)=1 Then
			If $cmd_TypeList = 'e' Then
				_KillMon(@ScriptDir&'\ExceptProcessList.txt', 'e', $aTmp[0])
			Else
				_KillMon(@ScriptDir&'\IncludeProcessList.txt', 'i', $aTmp[0])
			EndIf
		Else ; если таймер отсутсвует то вероятно указан путь 
			; C:\ - путь
			$aTmp=StringRegExp($ParamLine,  $spr&'[\\/\-]?([a-zA-Z]:\\[^/:*?"<>|'&$spr&']+[^.\\'&$spr&'])'&$spr, 3)
			If Not @error And UBound($aTmp)=1 Then
				If FileExists($aTmp[0]) Then
					_Kill($aTmp[0], $cmd_TypeList)
				Else
					MsgBox(0, $LngErr, $LngMB2)
					Exit
				EndIf
			Else
				MsgBox(0, $LngErr, $LngMB3)
				Exit
			EndIf
		EndIf
	Case 3, 4
		$ParamLine=$spr&_ArrayToString($CmdLine, $spr, 1)&$spr
		
		; 3000 - таймер
		$aTmp=StringRegExp($ParamLine,  $spr&'[\\/\-]?(\d+?)'&$spr, 3)
		If Not @error And UBound($aTmp)=1 Then
			$cmd_Timer=$aTmp[0]
		Else
			MsgBox(0, $LngErr, $LngMB4)
			Exit
		EndIf
		
		; C:\ - путь
		$aTmp=StringRegExp($ParamLine,  $spr&'[\\/\-]?([a-zA-Z]:\\[^/:*?"<>|'&$spr&']+[^.\\'&$spr&'])'&$spr, 3)
		If Not @error And UBound($aTmp)=1 Then
			If FileExists($aTmp[0]) Then
				$cmd_Path=$aTmp[0]
			Else
				MsgBox(0, $LngErr, $LngMB2)
				Exit
			EndIf
		Else
			MsgBox(0, $LngErr, $LngMB3)
			Exit
		EndIf
		
		; e или i - тип списка
		$aTmp=StringRegExp($ParamLine,  '(?i)'&$spr&'[\\/\-]?(e|i)'&$spr, 3)
		If Not @error And UBound($aTmp)=1 Then
			$cmd_TypeList=$aTmp[0]
		Else
			MsgBox(0, $LngErr, $LngMB1)
			Exit
		EndIf
		
		; l - запись лога
		$aTmp=StringRegExp($ParamLine,  '(?i)'&$spr&'[\\/\-]?(l)'&$spr, 3)
		If Not @error And UBound($aTmp)=1 Then $cmd_Log=1
		
		_KillMon($cmd_Path, $cmd_TypeList, $cmd_Timer)
	Case Else
		MsgBox(0, $LngMB0, $LngHLP)
EndSwitch
Exit

Func _Exit()
	If $cmd_Log Then FileClose($FileLog)
    Exit
EndFunc

Func _KillMon($PathList, $Include, $Delay)
	OnAutoItExitRegister('_Exit')
	Local $i, $list, $ProcessList
	If Not FileExists($PathList) Then
		If MsgBox(4+262144, $LngErr, $LngMB5&' '&StringRegExpReplace($PathList, '^(.*\\)(.*)$', '\2')&@CRLF&@CRLF&$LngHLP&@CRLF&@CRLF&$LngMB6)=6 Then _CreateList()
		Exit
	EndIf
	If $cmd_Log Then
		$FileLog = FileOpen(@ScriptDir&'\Process.log', 1)
		FileWrite($FileLog, @CRLF&@YEAR&"."&@MON&"."&@MDAY&"_"&@HOUR&"."&@MIN&"."&@SEC&' - '&StringRegExpReplace($PathList, '^(.*\\)(.*)$', '\2')& ' - '&$LngLg1&' '&$Delay&', '&$LngLg2&' '&$Include&@CRLF)
	EndIf
	$list=StringStripCR(FileRead($PathList))
	$list = '|'&StringReplace($list, @LF, '|')&'|'
	; $list='|'&StringRegExpReplace($list, '[\n]+','|')&'|'
	If $Delay < 1 Then $Delay = 1
	TraySetToolTip($LngTT1&' '&$Delay)
	$ke=0
	$kn=0
	If $Include='i' Then
		If Not @compiled Then
			TraySetIcon(@ScriptDir&'\2.ico')
		Else
			TraySetIcon(@AutoItExe, 202)
		EndIf
		While 1
			$ProcessList = ProcessList()
			For $i = 1 to $ProcessList[0][0]
				If StringInStr($list, '|'&$ProcessList[$i][0]&'|') Then
					If ProcessClose($ProcessList[$i][0]) Then
						$ke+=1
						TraySetToolTip($LngTT1&' '&$Delay &@CRLF& $LngTT2&' '&$ke &@CRLF& $LngTT3&' '&$kn)
						If $cmd_Log Then FileWrite($FileLog, @YEAR&"."&@MON&"."&@MDAY&"_"&@HOUR&"."&@MIN&"."&@SEC&' - '&$ProcessList[$i][0] & ' - '&$LngTT4 &@CRLF)
					Else
						$kn+=1
						TraySetToolTip($LngTT1&' '&$Delay &@CRLF& $LngTT2&' '&$ke &@CRLF& $LngTT3&' '&$kn)
						If $cmd_Log Then FileWrite($FileLog, @YEAR&"."&@MON&"."&@MDAY&"_"&@HOUR&"."&@MIN&"."&@SEC&' - '&$ProcessList[$i][0] & ' - '&$LngTT5 &@CRLF)
					EndIf
				EndIf
			Next
			Sleep($Delay)
		WEnd
	Else
		If Not @compiled Then
			TraySetIcon(@ScriptDir&'\1.ico')
		Else
			TraySetIcon(@AutoItExe, 201)
		EndIf
		While 1
			$ProcessList = ProcessList()
			For $i = 1 to $ProcessList[0][0]
				If Not StringInStr($list, '|'&$ProcessList[$i][0]&'|') Then
					If ProcessClose($ProcessList[$i][0]) Then
						$ke+=1
						TraySetToolTip($LngTT1&' '&$Delay &@CRLF& $LngTT2&' '&$ke &@CRLF& $LngTT3&' '&$kn)
						If $cmd_Log Then FileWrite($FileLog, @YEAR&"."&@MON&"."&@MDAY&"_"&@HOUR&"."&@MIN&"."&@SEC&' - '&$ProcessList[$i][0] & ' - '&$LngTT4 &@CRLF)
					Else
						$kn+=1
						TraySetToolTip($LngTT1&' '&$Delay &@CRLF& $LngTT2&' '&$ke &@CRLF& $LngTT3&' '&$kn)
						If $cmd_Log Then FileWrite($FileLog, @YEAR&"."&@MON&"."&@MDAY&"_"&@HOUR&"."&@MIN&"."&@SEC&' - '&$ProcessList[$i][0] & ' - '&$LngTT5 &@CRLF)
					EndIf
				EndIf
			Next
			Sleep($Delay)
		WEnd
	EndIf
	_RefreshTrayIcons()
EndFunc

Func _Kill($PathList, $Include)
	Local $i, $list, $ProcessList
	If Not FileExists($PathList) Then
		If MsgBox(4+262144, $LngErr, $LngMB5&' '&StringRegExpReplace($PathList, '^(.*\\)(.*)$', '\2')&@CRLF&@CRLF&$LngHLP&@CRLF&@CRLF&$LngMB6)=6 Then _CreateList()
		Exit
	EndIf
	$list=StringStripCR(FileRead($PathList))
	$list = '|'&StringReplace($list, @LF, '|')&'|'
	; $list='|'&StringRegExpReplace($list, '[\n]+','|')&'|'

	$ProcessList = ProcessList()
	If $Include='i' Then
		For $i = 1 to $ProcessList[0][0]
			If StringInStr($list, '|'&$ProcessList[$i][0]&'|') Then ProcessClose($ProcessList[$i][0])
		Next
	Else
		For $i = 1 to $ProcessList[0][0]
			If Not StringInStr($list, '|'&$ProcessList[$i][0]&'|') Then ProcessClose($ProcessList[$i][0])
		Next
	EndIf
	_RefreshTrayIcons()
EndFunc

Func _CreateList()
	Local $file, $i, $List, $Path, $ProcessList
	; Создаём список текущих процессов
	$ProcessList = ProcessList()
	$ProcessList=_ArrayUnique($ProcessList, 1, 1)
	_ArraySort($ProcessList, 0, 1)
	$List=''
	For $i = 1 to $ProcessList[0]
		$List&=$ProcessList[$i]&@CRLF
	Next
	$Path=_Path(@ScriptDir&'\ExceptProcessList.txt')

	$file = FileOpen($Path, 2)
	FileWrite($file, StringTrimRight($List, 2))
	FileClose($file)
EndFunc

Func _Path($Path)
	Local $j, $Name, $NameE, $PathR, $Tmp, $Type
	If FileExists($Path) Then
		$NameE = StringTrimLeft($Path, StringInStr($Path, '\', 0, -1))
		$PathR = StringLeft($Path, StringInStr($Path, '\', 0, -1))
		If StringInStr($NameE, '.') Then
			$Tmp=StringInStr($NameE, '.', 0, -1)-1
			$Type = StringTrimLeft($NameE, $Tmp) ; получить расширение файла
			$Name = StringLeft($NameE, $Tmp) ; получить имя файла без расширения
		Else
			$Type = ''
			$Name = $NameE
		EndIf
		; цикл проверки одноимённых файлов
		$j = 0
		Do
			$j+=1
			If $j = 1 Then
				$Path=$PathR&$Name& ' '&$LngCopy & $Type
			Else
				$Path=$PathR&$Name & ' '&$LngCopy&' (' & $j & ')' & $Type
			EndIf
		Until Not FileExists($Path)
	EndIf
	Return $Path
EndFunc