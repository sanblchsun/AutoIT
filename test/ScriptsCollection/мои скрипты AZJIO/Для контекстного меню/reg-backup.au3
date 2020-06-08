;  @AZJIO 25.03.2010

; основные параметры скрипта
$tempfile=@TempDir&'\temporarily.reg'
$razdelit='' ; разделяет экспортированные ветки, количество тоже, что веток в файле удаления
$del=1 ;ключ 1 - создавать файл удаления веток, 0 - не создавать

$close = RegRead("HKCR\regfile\shell\mbackup", '')
If @error=1 Then
	;регистрация в реестре и копирование в системную папку, при первом запуске
RegWrite("HKCR\regfile\shell\mbackup","","REG_SZ","Бэкапировать reg")
RegWrite("HKCR\regfile\shell\mbackup\command","","REG_SZ",@AutoItExe&' "'&@SystemDir&'\reg-backup.au3" "%1"')
If Not FileExists(@SystemDir&'\reg-backup.au3') Then FileCopy(@ScriptDir&'\reg-backup.au3', @SystemDir,1)
EndIf

;Добавление $sTarget позволило использовать скрипт в контекстном меню
If $CmdLine[0]=0 Then
	$regfile = FileOpenDialog("Выбор файла *.reg, для которого будет выполнен бэкап.", @ScriptDir & "", "reg-файл (*.reg)", 1 + 4 )
	If @error Then Exit
Else
$regfile=$CmdLine[1]
EndIf


$aRegfileS = StringRegExp($regfile, "(^.*)\\(.*)$", 3) ; чтобы указать каталог reg-файла для выходных файлов
$aRegfileS1 = StringRegExp($regfile, "(^.*)\\(.*)\.(.*)$", 3)

$timer = TimerInit() ; засекаем время
; генерируем имя нового файла с номером копии на случай если файл существует
$i = 1
While FileExists($aRegfileS1[1]&'_BAK'&$i&'.reg') or FileExists($aRegfileS1[1]&'_DEL'&$i&'.reg')
    $i +=1
WEnd
$filename=$aRegfileS1[1]&'_BAK'&$i&'.reg'
$delname=$aRegfileS1[1]&'_DEL'&$i&'.reg'

If $del=1 Then
$delfile = FileOpen($aRegfileS[0]&'\'&$delname, 1)
FileWrite($delfile, '#Windows Registry Editor Version 5.00'&@CRLF&@CRLF)
EndIf

;оболочка сообщений о ходе процесса если reg-файл 100кб и более
ProgressOn("Бэкапирование", $aRegfileS[1], "1. Очистка подветок, 0 %"&@CRLF&@CRLF&"			@AZJIO 25.03.2010",-1,-1,18)

$regfileT = FileOpen($regfile, 0) ; открываем бэкапируемый файл для чтения
$regfileT1= FileRead($regfileT)
FileClose($regfileT)
 ; удаление пустых секций
$regfileT1=StringTrimRight (StringRegExpReplace($regfileT1 & "[","\[[^\]]*\]\s*(?=\[)",""),1) 
;$regfileT1=StringRegExpReplace($regfileT1,"(\[.*\])(?=(\s+\[.*|\s+$|$))","")
$aRegfileT1 = StringRegExp($regfileT1, "(\[HK.*?\])", 3) ; создание массива веток реестра

$regfileT1=''
For $i = 0 to UBound($aRegfileT1) - 1 ; объединение массива в многостроковый файл
$regfileT1&=$aRegfileT1[$i]&@CRLF
Next
$iaReg=UBound($aRegfileT1) - 1
; чистка подветок, пустых строк, повторов. Файл 1Мб обрабатывается до минуты в этом цикле.
; в тексте удаляется каждый элемент массива и добавляется в конец строки
; Регулярным выражением подготавливается поисковой шаблон, заменяются спец-символы на обрамляющий слеш
For $i = 0 to $iaReg
$regfileT1=StringRegExpReplace($regfileT1,StringRegExpReplace(StringTrimRight($aRegfileT1[$i], 1), "[][{}()*+?.\\^$|=<>#]", "\\$0")&'(\\.*|\])',"") 
If @Extended >0 Then $regfileT1 &= @CRLF&$aRegfileT1[$i] ; эта строка должна выполнятся без условия
$ps=Ceiling ($i*100/$iaReg)
ProgressSet( $ps, "1. Очистка подветок, 0 %"&$ps & " %,  ветка: "&$i&' / '&$iaReg&@CRLF&Ceiling(TimerDiff($timer) / 1000) & " сек"&@CRLF&"			@AZJIO 25.03.2010")
Next
$timer0=Ceiling(TimerDiff($timer) / 1000)
$regfileT1=StringRegExpReplace($regfileT1,'\n\r?\n\r?',"") ;удаление пустых строк

$aRecords = StringSplit($regfileT1, @CRLF) ; отправляем в массив построчно

ProgressSet( 0, "2. Экспорт из реестра, 0 %,  ветка: "&$i&@CRLF&@CRLF&"			@AZJIO 25.03.2010")
$timer1 = TimerInit() ; засекаем время для учёта времени создания экспорта
$filebackup = FileOpen($aRegfileS[0]&'\'&$filename, 1) ; открываем бэкап-файл
FileWrite($filebackup, 'Windows Registry Editor Version 5.00'&@CRLF&@CRLF)
;FileWrite($filebackup, 'REGEDIT4'&@CRLF&@CRLF) ; для win98
If $razdelit<>'' Then $razdelit&=@CRLF
$Data=''
$z=1
if IsInt($aRecords[0]/2) Then ; счётчик строк
	$a=$aRecords[0]/2
Else
	$a=($aRecords[0]-1)/2
EndIf
For $i=1 To $aRecords[0]
	If StringLeft($aRecords[$i], 3)='[HK' Then ; условие проверки валидности строки в элементе массива
		$temporarily = StringRegExpReplace($aRecords[$i],'\[|\]',"") ; удаление скобок в строке, дабы секция стала веткой
		If $del=1 Then FileWrite($delfile, '[-'&$temporarily&']'&@CRLF)
		$reg1 = RegRead($temporarily, "") ; проверка существования ветки
		If @error=1 Then
			ContinueLoop
		Else
			RunWait ( @Comspec&' /C reg export "'&$temporarily&'" "'&$tempfile&'"', '', @SW_HIDE )
			$vr = FileOpen($tempfile, 0)
			$vr1 = FileRead($vr)
			$vr1 = StringReplace($vr1, "Windows Registry Editor Version 5.00"&@CRLF&@CRLF, $razdelit)
			;$vr1 = StringReplace($vr1, "REGEDIT4"&@CRLF&@CRLF, $razdelit) ; для win98
			$Data &=$vr1
			FileClose($vr)
		EndIf
	EndIf
	; статистика: рассчёт полосы прогресса, проверка деления на 2, так как в массиве в 2 раза больше строк
	$ps=Ceiling ($i*100/$aRecords[0])
	if IsInt($i/2) Then $z=$i/2
	ProgressSet( $ps, "2. Экспорт из реестра, "&$ps & " %,  ветка: "&$z&' / '&$a&@CRLF&$timer0&' + '&Ceiling(TimerDiff($timer1) / 1000) & " сек"&@CRLF&"			@AZJIO 25.03.2010")
Next
ProgressOff()

$Data=StringTrimRight (StringRegExpReplace($Data & "[","\[[^\]]*\]\s*(?=\[)",""),1) 
FileWrite($filebackup, $Data)
; закрываем файлы
If $del=1 Then FileClose($delfile)
FileClose($filebackup)

;если файл пустой, то удаляем его. Добавляется четыре строки и пустой файл равен нескольким байтам.
If FileGetSize($aRegfileS[0]&'\'&$filename)=40 Then FileDelete($aRegfileS[0]&'\'&$filename)
If $del=1 Then 
   If FileGetSize($aRegfileS[0]&'\'&$delname)=41 Then FileDelete($aRegfileS[0]&'\'&$delname)
EndIf