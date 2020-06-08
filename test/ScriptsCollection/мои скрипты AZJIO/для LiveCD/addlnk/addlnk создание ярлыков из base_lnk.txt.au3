#Include <File.au3> ; в каталоге AutoIt3.exe должна быть папка Include с файлом File.au3
#NoTrayIcon
If Not FileExists(@ScriptDir&'\base_lnk.txt') Then Exit
Global $aRecords
; читаем бэкап-файл в массив
If Not _FileReadToArray(@ScriptDir&'\base_lnk.txt',$aRecords) Then 
	MsgBox(4096,"Ошибка", "Ошибка чтения массива", @error) 
	Exit 
EndIf 
; В массиве $aRecords будут содержаться все строки файла... 
; В массив $aLnk читается каждая строчка состоящая из данных ярлыка
$aSet = StringSplit($aRecords[1], "|")
$restore_lnk2 = $aSet[1] ; установить путь извечения из бэкапа в первой строке
For $i=3 To $aRecords[0]
; решение проблемы пустых строк, пропускать цикл для пустой строки
If $aRecords[$i]<>'' Then
$aLnk = StringSplit($aRecords[$i], "|")
; проверка, если ярлык содержит "\", то это путь и нужно создать каталог
If StringInStr($aLnk[1], '\') > 0 Then 
   $aDirlnk=StringRegExp($aLnk[1], "(^.*)\\(.*)$", 3)
   If Not FileExists($restore_lnk2&'\'&$aDirlnk[0]) Then DirCreate($restore_lnk2&'\'&$aDirlnk[0])
EndIf
; создание ярлыка
FileCreateShortcut($aLnk[2],$restore_lnk2&'\'&$aLnk[1]&'.lnk',$aLnk[3],$aLnk[4],$aLnk[5],$aLnk[6],'',$aLnk[7])
EndIf
Next