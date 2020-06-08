#include <_RegFunc.au3> ; http://www.autoitscript.com/forum/topic/70108-custom-registry-functions-udf/
#include <Array.au3>

;  @AZJIO 2012.08
; Этот скрипт позволяет сделать экспотрт разделов реестра, параметры которого будут изменены в результате слияния REG-файла.
; Спасибо Spiff59 за оптимизацию поиска уникальных разделов, Erik Pilsits за _RegFunc.

; En
$LngCM = 'Backup reg'
$LngSel1 = 'Select'
$LngSel2 = 'REG-File'
$LngPr1 = '1. Search for unique , 0 %'
$LngPr2 = '%,  Key:'
$LngS = 'sec'
$LngPr3 = '2. Export, 0 %,  Key:'
$LngPr4 = '2. Export,'
; $LngErr1 = 'Key:"'
; $LngErr2 = '" Valuename:"'
; $LngErr3 = '" type:"'
; $LngErr4 = '" Value:"'

; Ru
; если русский, то использовать его
If @OSLang = 0419 Then
	$LngCM = 'Резервирование reg-данных'
	$LngSel1 = 'Выбор файла, данные которого резервируются.'
	$LngSel2 = 'REG-файл'
	$LngPr1 = '1. Поиск уникальных, 0 %'
	$LngPr2 = '%, раздел:'
	$LngS = 'сек'
	$LngPr3 = '2. Экспорт из реестра, 0 %,  разделов:'
	$LngPr4 = '2. Экспорт из реестра,'
	; $LngErr1 = 'ключ:"'
	; $LngErr2 = '" параметр:"'
	; $LngErr3 = '" тип:"'
	; $LngErr4 = '" значение:"'
EndIf

; входные параметры скрипта
$Author_Date = '@AZJIO 2012.08'
; $sHeader = 'REGEDIT4' ; для win98
$sHeader = 'Windows Registry Editor Version 5.00'
$iTrDel = 1 ; ключ 1 - создавать файл удаления веток, 0 - не создавать
Global $Data = '', $sKey, $DataErr = '', $Re = '', $sKey = '', $sValuename, $sValue, $sValuetype, $L, $hex

; Добавление в реестр
RegRead("HKCR\regfile\shell\mbackup", '')
If @error = 1 Then
	;регистрация в реестре и копирование в системную папку, при первом запуске
	RegWrite("HKCR\regfile\shell\mbackup", "", "REG_SZ", $LngCM)
	RegWrite("HKCR\regfile\shell\mbackup\command", "", "REG_SZ", @AutoItExe & ' "' & @SystemDir & '\reg-backup.au3" "%1"')
	If Not FileExists(@SystemDir & '\reg-backup.au3') Then FileCopy(@ScriptFullPath, @SystemDir, 1)
EndIf

;Добавление $sTarget позволило использовать скрипт в контекстном меню
If $CmdLine[0] Then
	$sPathReg = $CmdLine[1]
Else
	$sPathReg = FileOpenDialog($LngSel1, @ScriptDir & "", $LngSel2 & " (*.reg)", 1 + 4)
	If @error Then Exit
EndIf

$aPath = StringRegExp($sPathReg, "^(.*)\\(.*)\.(.*)$", 3) ; массив: путь, имя и расширение

$timer0 = TimerInit() ; засекаем время
; генерируем имя нового файла с номером копии на случай если файл существует
$iNFile = 1
While FileExists($aPath[0] & '\' & $aPath[1] & '_BAK' & $iNFile & '.reg') Or FileExists($aPath[0] & '\' & $aPath[1] & '_DEL' & $iNFile & '.reg')
	$iNFile += 1
WEnd

;оболочка сообщений о ходе процесса если reg-файл 100кб и более
ProgressOn($LngCM, $aPath[1] & '.reg', $LngPr1 & @CRLF & @CRLF & @Tab & @Tab & @Tab & $Author_Date, -1, -1, 18)

$sRegData = FileRead($sPathReg) ; открываем бэкапируемый файл для чтения

; удаление пустых секций
$sRegData = StringTrimRight(StringRegExpReplace($sRegData & "[", "\[[^\]]*\]\s*(?=\[)", ""), 1)
;$sRegData=StringRegExpReplace($sRegData,"(\[.*\])(?=(\s+\[.*|\s+$|$))","")
$sRegData = StringReplace($sRegData, "]", "\")
$aRegKey = StringRegExp($sRegData, "(?m)^(\[HK.*\\)(?:\r$|\z)", 3) ; создание массива веток реестра
If @error Then Exit ; если файл пустой, то выход
_ArraySort($aRegKey, 0) ; сортировать по убыванию

$n = UBound($aRegKey)
$i = 0
For $j = 1 to $n-1
    If Not StringInStr($aRegKey[$j], $aRegKey[$i]) Then
        $i += 1
        $aRegKey[$i] = $aRegKey[$j]
    Endif
Next
ReDim $aRegKey[$i + 1]
$n = $i

$timer0 = Round(TimerDiff($timer0) / 1000)

ProgressSet(0, $LngPr3 & ' ' & $i+1 & @CRLF & @CRLF & @Tab & @Tab & @Tab & $Author_Date)
$timer1 = TimerInit() ; засекаем время для учёта времени создания экспорта
$Data = ''
$z = 1

$sRegDel = ''
; _ArrayDisplay($aRegKey, 'Array')
; Exit
For $i = 0 To $n
	$sKey = StringRegExpReplace($aRegKey[$i], '^\[|\\$', "") ; удаление скобок в строке, дабы секция стала веткой
	If $iTrDel Then $sRegDel &= '[-' & $sKey & ']' & @CRLF ; запись строки в reg-файл удаления
	If _RegKeyExists($sKey) Then ; если существует, то
		_RegExport_X($sKey, $Data) ; экспорт указанного раздела реестра в переменную $Data
		; статистика: рассчёт полосы прогресса
		$ps = Round(($i+1) * 100 / ($n+1))
		ProgressSet($ps, $LngPr4 & ' ' & $ps & ' ' & $LngPr2 & ' ' & $i+1 & ' / ' & $n & @CRLF & _
		$timer0 & ' + ' & Round(TimerDiff($timer1) / 1000) & ' ' & $LngS & @CRLF & @Tab & @Tab & @Tab & $Author_Date)
	EndIf
Next
ProgressOff()

If $Data Or $DataErr Then ; пишем в файл, если данные получены
	$hFile = FileOpen($aPath[0] & '\' & $aPath[1] & '_BAK' & $iNFile & '.reg', 2)
	FileWrite($hFile, $sHeader & @CRLF & $Data & @CRLF & $DataErr & @CRLF)
	FileClose($hFile)
EndIf

If $iTrDel And $sRegDel Then; пишем в файл, если разделы есть и ключ $iTrDel включен
	$hFile = FileOpen($aPath[0] & '\' & $aPath[1] & '_DEL' & $iNFile & '.reg', 2)
	FileWrite($hFile, '#' & $sHeader & @CRLF & @CRLF & $sRegDel)
	FileClose($hFile)
EndIf


Func _RegExport_X($sKey, ByRef $Data)
	Local $aaaValue, $asValue0, $cmd, $DataErr, $hex, $i, $L, $line1, $Re, $sTemp, $sValue, $sValue0, $sValuename, $sValuetype

	$i = 0
	Do
		$i += 1
		; If $i=1 Then $Data &= @CRLF & '[' & $sKey & ']' & @CRLF
		$sValuename = RegEnumVal($sKey, $i)
		If @error Then ExitLoop
		$sValue = _RegRead($sKey, $sValuename, True)
		If @error Then ContinueLoop
		$sValuetype = @extended
		; $sValueName = StringRegExpReplace($sValueName, '[\\]', "\\$0") ; всегда заменяем в параметре наклонную черту на двойную
		$sValuename = StringReplace($sValuename, '\', "\\") ; всегда заменяем в параметре наклонную черту на двойную
		If $i = 1 Then $Data &= @CRLF & '[' & $sKey & ']' & @CRLF ; если строку переместить к началу, то все разделы даже пустые добавятся
		; здесь для каждого типа данных свой алгоритм извлечения значений
		Switch $sValuetype
			Case 1
				$sValue = StringReplace(StringReplace(StringRegExpReplace($sValue, '["\\]', "\\$0"), '=\"\"', '="\"'), '\"\"', '\""')
				$Data &= '"' & $sValuename & '"="' & $sValue & '"' & @CRLF
			Case 7, 2
				$hex = _HEX($sValuetype, $sValue, $sValuename, $L)
				$Data &= '"' & $sValuename & '"=' & $L & $hex & @CRLF
			Case 4
				$Data &= '"' & $sValuename & '"=dword:' & StringLower(Hex(Int($sValue))) & @CRLF
			Case 3
				$hex = _HEX(3, $sValue, $sValuename, $L)
				$Data &= '"' & $sValuename & '"=' & $L & $hex & @CRLF
			Case 0, 8, 9, 10, 11 ; тип данных которые не распознаёт AutoIt3, поэтому используется экспорт консольной командой.
				; Вытаскиваем значение в консоль и читаем с неё
				$hex = _HEX($sValuetype, $sValue, $sValuename, $L)
				$Data &= '"' & $sValuename & '"=' & $L & $hex & @CRLF
			Case Else
				$DataErr &= '# error... Key:"' & $sKey & '" Valuename:"' & $sValuename & '" Value:"' & $sValue & '" type:"' & $sValuetype & '"' & @CRLF
		EndSwitch
	Until 0
	;рекурсия
	$i = 0
	While 1
		$i += 1
		$sTemp = RegEnumKey($sKey, $i)
		If @error Then ExitLoop
		$DataErr &= _RegExport_X($sKey & '\' & $sTemp, $Data)
	WEnd
	$Data = StringReplace($Data, '""=', '@=') ; заменяем в данных параметры по умолчанию на правильные
	Return $DataErr
EndFunc

; функция шестнадцатеричных данных, основное её значение - привести запись к формату reg-файла (перенос строк)
; данные подгонялись методом сравнения оригинального экспорта и reg-файлом полученным скриптом до полного совпадения.
Func _HEX($sValuetype, ByRef $sValue, $sValuename, ByRef $L)
	Local $aValue, $hex, $i, $k, $len, $lenVN, $r, $s, $s0
	$k = 0
	$lenVN = StringLen($sValuename) - 1
	Switch $sValuetype
		Case 0
			$L = 'hex(0):'
		Case 3
			$k = 1
			$L = 'hex:'
		Case 2
			$k = 1
			$L = 'hex(2):'
			$sValue = StringToBinary($sValue, 2)
			$sValue &= '0000'
			$lenVN = StringLen($sValuename) + 2
		Case 7
			$k = 1
			$L = 'hex(7):'
			; $sValue = StringToBinary($sValue, 2) ; строковый в бинарный вид
			; $sValue = StringReplace($sValue, '000a00', '000000') ; по какой то причине экспортированные и прочитанные данные разнятся этими блоками
			; $sValue &= '00000000' ; шестнадцатеричные данные заполнены окончания нулями, иногда не совпадает количество, автоит обрезает так как читает данные как текстовые
		Case 8
			$sValue = StringTrimLeft($sValue, 2)
			$L = 'hex(8):'
		Case 10
			$L = 'hex(a):'
		Case 11
			$L = 'hex(b):'
		Case 9
			; $k = -1
			$sValue = StringTrimLeft($sValue, 2)
			$L = 'hex(9):'
	EndSwitch
	$hex = ''
	$aValue = StringRegExp($sValue, '..', 3)
	$len = UBound($aValue) ; от колич. символов параметра зависит колич. бинарных данных первой строки
	If $lenVN >= 69 Then $lenVN = 66
	$s0 = 22 - ($lenVN - Mod($lenVN, 3)) / 3 ; количество символов для первой строки reg-данных
	Switch $sValuetype
		Case 7, 8, 9
			$s0 -= 1
	EndSwitch
	$s = 0
	$r = 0
	For $i = $k To $len - 1 ; цикл формирует правильный перенос строк, и разделительные запятые
		If $s = $s0 Or $r = 24 Then
			$hex &= $aValue[$i] & ',\' & @CRLF & '  '
			$s = 24
			$r = 0
		Else
			$hex &= $aValue[$i] & ','
			$s += 1
			$r += 1
		EndIf
	Next
	$hex = StringTrimRight($hex, 1)
	If StringRight($hex, 5) = ',\' & @CRLF & ' ' Then $hex = StringTrimRight($hex, 5) ;обрезка конца значания
	$hex = StringLower($hex) ; преобразование в строчные
	Return $hex
EndFunc