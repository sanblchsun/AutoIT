Global $Stack[50], $Stack1[50]
#include <Array.au3>

$Text = ""
$timer=TimerInit()
FileFindNextFirst("C:\WINDOWS")
While 1
	$tempname = FileFindNext()
	If $tempname = "" Then ExitLoop
	$Text &= $tempname & @LF
WEnd
; здесь должна быть проверка $Text <> ""
$aText=StringSplit (StringTrimRight($Text, 1), @LF)
MsgBox(0,"Время выполнения", 'за '&Round(TimerDiff($timer) / 1000, 2) & ' сек')
_ArrayDisplay($aText, 'Array')


Func FileFindNextFirst($FindCat)
	$Stack[0] = 1
	$Stack1[1] = $FindCat
	$Stack[1] = FileFindFirstFile($FindCat & "\*.*")
	Return $Stack[1]
EndFunc   ;==>FileFindNextFirst

;$mode=0 - файлы
;$mode=1 - типы файлов
;$mode=2 - каталоги
;$Level=  от 1 до 49
;$type = может иметь перечисление расширений, например exe;dll;com точнее $tempname = FileFindNext('exe;dll;com',1,1)
Func FileFindNext($type = 'log', $mode = 0, $Level = 49)
	While 1
		$file = FileFindNextFile($Stack[$Stack[0]])
		If @error Then
			FileClose($Stack[$Stack[0]])
			If $Stack[0] = 1 Then
				Return ""
			Else
				$Stack[0] -= 1
				ContinueLoop
			EndIf
		Else
			If StringInStr(FileGetAttrib($Stack1[$Stack[0]] & "\" & $file), "D") > 0 Then
				If $Stack[0] = $Level Then ContinueLoop
				$Stack[0] += 1
				$Stack1[$Stack[0]] = $Stack1[$Stack[0] - 1] & "\" & $file
				$Stack[$Stack[0]] = FileFindFirstFile($Stack1[$Stack[0]] & "\*.*")
				If $mode = 2 Then
					Return $Stack1[$Stack[0]]
				Else
					ContinueLoop
				EndIf
			Else
				If $mode = 2 Then ContinueLoop
				If $mode = 1 Then
					;If StringInStr (';'&$type&';', ';'&StringRight($Stack1[$Stack[0]] & "\" & $file, 3)&';')=0  Then
					If StringInStr (';'&$type&';', ';'&StringRegExpReplace($Stack1[$Stack[0]] & "\" & $file, '.*\.(\S+)', '\1')&';')=0  Then
						ContinueLoop
					Else
						Return $Stack1[$Stack[0]] & "\" & $file
					EndIf
				Else
					Return $Stack1[$Stack[0]] & "\" & $file
				EndIf
			EndIf
		EndIf
	WEnd
EndFunc   ;==>FileFindNext