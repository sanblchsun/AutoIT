#NoTrayIcon

Global $Stack[50]
Global $Stack1[50]
$sizefull=0
$sizefull1=0
$iPos = 0

$Source1="C:\PROGRAMS"
$Out1="C:\PePrograms1"


GUICreate("Копирование",318,52) ; размер окна
$ProgressBar = GUICtrlCreateProgress(4, 4, 300, 16)
$Label000=GUICtrlCreateLabel ('Строка состояния', 4,25,300,20)

GuiSetState()
; вычисляем сумму обьёмов всех файлов в общий размер
GUICtrlSetData($Label000, 'Вычисление размера')
If FileExists($Source1) Then
  FileFindNextFirst($Source1)
  While 1 
	 $msg = GUIGetMsg()
	 $tempname = FileFindNext()
	 If $tempname = "" Then ExitLoop
	 If $msg = -3 Then Exit
     $size = FileGetSize($tempname)
     $sizefull +=$size
  WEnd
;$sizefull /=1024
;$sizefull /=1048576
;$x = Round($sizefull, 1)
;MsgBox(0, "", $x)

$f2=Ceiling($sizefull/1048576)

  FileFindNextFirst($Source1)
  While 1
	 $msg = GUIGetMsg()
	 $tempname = FileFindNext()
	 If $tempname = "" Then ExitLoop
	 $sTarget = StringTrimLeft($tempname, StringLen($Source1))
	 If $msg = -3 Then Exit
	 $aPath = StringRegExp($Out1&$sTarget, "(^.*)\\(.*)$", 3)
	 GUICtrlSetData($Label000, $f2&' Мб, копируем '&$aPath[1])
       FileCopy($tempname, $Out1&$sTarget, 9)
     $size = FileGetSize($Out1&$sTarget)
     $sizefull1 +=$size
     $f=$sizefull1/$sizefull*100
     $f1=Ceiling ($f)
		GUICtrlSetData($ProgressBar, $f1)
  WEnd
EndIf



; функция поиска всех файлов в каталоге (NIKZZZZ)
Func FileFindNextFirst($FindCat) 
  $Stack[0] = 1 
  $Stack1[1] = $FindCat 
  $Stack[$Stack[0]] = FileFindFirstFile($Stack1[$Stack[0]] & "\*.*") 
  Return $Stack[$Stack[0]] 
EndFunc   ;==>FileFindNextFirst 
 
Func FileFindNext() 
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
        $Stack[0] += 1 
        $Stack1[$Stack[0]] = $Stack1[$Stack[0] - 1] & "\" & $file 
        $Stack[$Stack[0]] = FileFindFirstFile($Stack1[$Stack[0]] & "\*.*") 
        ContinueLoop 
      Else 
        Return $Stack1[$Stack[0]] & "\" & $file 
      EndIf 
    EndIf 
  WEnd 
EndFunc   ;==>FileFindNext