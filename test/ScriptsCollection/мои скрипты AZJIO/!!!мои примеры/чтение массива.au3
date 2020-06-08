
; если нет файла данных, создаём его
If not @ScriptDir&'\arr.txt' Then
$file = FileOpen(@ScriptDir&'\arr.txt' ,2)
FileWrite($file, 'A,B|F,Y|E,W|H,N|T,U|E,V|Y,S')
FileClose($file)
EndIf

; читаем файл и массив
$fileini=FileRead(@ScriptDir&'\arr.txt')
$aMacciv = StringSplit($fileini, "|")
For $i = 1 to $aMacciv[0]
   $aSubMacciv = StringSplit($aMacciv[$i ], ",")
Next

; сообщение об содержании элемента массива
MsgBox(0, "Сообщение", $aSubMacciv[2])

; разделитель в массиве лучше использовать тот который отсутствует в элементах массива. Например в текстах могут быть запятые, поэтому не нужно её использовать. А в перечислении расширений файлов можно.