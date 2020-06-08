#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#pragma compile(AutoItExecuteAllowed, true)
#include <Array.au3>
#include <WinAPIEx.au3>
#include <Constants.au3>
#Include <File.au3>
#include <Clipboard.au3>
#include <Date.au3>
#Include <WindowsConstants.au3>

Opt("SendKeyDelay",100) ; enable delay 20 ms for Send
Opt("WinDetectHiddenText", 1) ; show hidden text
Opt("WinSearchChildren", 1) ; search for sub-windows
Opt("WinWaitDelay", 500) ; wait 500 ms after window commands
Opt("WinTitleMatchMode", 3)

Global $PathPlatform = "C:\Program Files (x86)\1cv8\8.3.6.2152\bin\1cv8.exe"
Global $iEventError
Global $HexNumber
Global $Status = False

; эта часть - родительский процесс_______________________________________________________________
If Not $CmdLine[0] Then

   $MyPID = @AutoItPID
   ;Проверим наличие конкурирующего процесса сткрипта, что бы избежать конфликта
   $aProcessList = ProcessList(@ScriptName)
   If $aProcessList[0][0]>1 Then
	  For $i = 1 To $aProcessList[0][0]
		 If $aProcessList[$i][1]<>$MyPID Then
			ProcessClose($aProcessList[$i][1])
		 EndIf
	  Next
   EndIf

   ;Проверим наличие 1с процесса, закроем их
   $aProcessList = ProcessList("1cv8.exe")
   If $aProcessList[0][0] Then
	  For $i = 1 To $aProcessList[0][0]
		 ProcessClose($aProcessList[$i][1])
	  Next
   EndIf

;~    Const $Run = @ScriptDir & '\CreateDT.exe'
   Dim $aWorkTemp[5][5] = [["Признак считывания PID","PID-процесса","Тип конфигурации","Передал","Статус"],["-","","Б-АЯ","","-"],["-","","ПБЮЛ","","-"],["-","","ПРОФ","","-"],["-","","КОРП","","-"]]

   For $i = 1 To UBound($aWorkTemp)-1
	  $aWorkTemp[$i][1] = Run('"' & @ScriptFullPath & '" /AutoIt3ExecuteScript "' & @ScriptFullPath & '" ' & '"' & $aWorkTemp[$i][2] & '"', '', @SW_HIDE, $STDIN_CHILD + $STDOUT_CHILD)
   Next

 While 1
	  Sleep(1000)
	  For $i = 1 To UBound($aWorkTemp)-1
		 If StringRight(StdoutRead($aWorkTemp[$i][1], True), 5)=="Занят" Then
			ContinueLoop 2
		 EndIf
	  Next
	  For $i = 1 To UBound($aWorkTemp)-1
		 If	StringRight(StdoutRead($aWorkTemp[$i][1], False), 5)=="Готов" Then
			StdinWrite($aWorkTemp[$i][1], "Старт")
			ExitLoop
		 EndIf
	  Next
   WEnd
   Exit
EndIf

;эта часть - основной код дочернего процесса____________________________________________________________________
Global Const $TipConf = $CmdLine[1]

Switch $TipConf
Case "ПРОФ"
   Global $ConfigName = "Конфигуратор - Бухгалтерия предприятия, редакция 3.0"
   Global $LogFile = "C:\Accounting\log.txt"
   Global $PathIn = "C:\Accounting\in"
   Global $PathBaseDemo = "C:\сборка\basePROF\demo"
   Global $PathBaseEmpty = "C:\сборка\basePROF\empty"
   Global $MsgLog = " /Out" & """" & $LogFile & """" & " -NoTruncate"
   Global $PathDtOut = "C:\Accounting\out\DemoDB"
   Global $PosN2progres = 900
   Global $ObrStopMaket = "C:\EPF\MaketStop_ПРОФ.epf"
   Global $ObrSetData = "C:\EPF\SetData_ПРОФ.epf"
   Global $Obr_Hash_empty_User = "C:\EPF\Hash_empty_User_ПРОФ.epf"
   Global $Login ="Абдулов (директор)"
   Global $Name = "БухгалтерияПредприятия"
   Global $Synonym = "Бухгалтерия предприятия, редакция 3.0"
   Global $ShortInf = "Бухгалтерия предприятия, редакция 3.0"
   Global $LongInf = "Бухгалтерия предприятия, редакция 3.0"

Case "Б-АЯ"
   ;---------------------------------------------
   Global $ConfigName = "Конфигуратор - Бухгалтерия предприятия (базовая), редакция 3.0"
   Global $LogFile = "C:\AccountingBase\log.txt"
   Global $PathIn = "C:\AccountingBase\in"
   Global $PathBaseDemo = "C:\сборка\baseBASE\demo"
   Global $PathBaseEmpty = "C:\сборка\baseBASE\empty"
   Global $MsgLog = " /Out" & """" & $LogFile & """" & " -NoTruncate"
   Global $PathDtOut = "C:\AccountingBase\out\DemoDB"
   Global $PosN2progres = 100
   Global $ObrStopMaket = "C:\EPF\MaketStop_Б-АЯ.epf"
   Global $ObrSetData = "C:\EPF\SetData_Б-АЯ.epf"
   Global $TempFile = @TempDir & '\AutoitB_Temp'
   Global $Obr_Hash_empty_User = "C:\EPF\Hash_empty_User_Б-АЯ.epf"
   Global $Login =""
   Global $Name = "БухгалтерияПредприятияБазовая"
   Global $Synonym = "Бухгалтерия предприятия (базовая), редакция 3.0"
   Global $ShortInf = "Бухгалтерия предприятия (базовая), редакция 3.0"
   Global $LongInf = "Бухгалтерия предприятия (базовая), редакция 3.0"
   Global $avArray[7] = ["НалоговыйУчетУСН", "ОбщегоНазначенияБПСобытия", "РасчетСебестоимости", "УправлениеВнеоборотнымиАктивами", "УправлениеДоступомСлужебный", "УчетНДС", "УчетТоваров"]

Case "ПБЮЛ"
   ;---------------------------------------------
   Global $ConfigName = "Конфигуратор - Бухгалтерия предприятия (базовая), редакция 3.0"
   Global $LogFile = "C:\AccountingPBOULBase\log.txt"
   Global $PathIn = "C:\AccountingPBOULBase\in"
   Global $PathBaseDemo = "C:\сборка\basePBOUL\demo"
   Global $PathBaseEmpty = "C:\сборка\basePBOUL\empty"
   Global $MsgLog = " /Out" & """" & $LogFile & """" & " -NoTruncate"
   Global $PathDtOut = "C:\AccountingPBOULBase\out\DemoDB"
   Global $PosN2progres = 500
   Global $ObrStopMaket = "C:\EPF\MaketStop_ПБЮЛ.epf"
   Global $ObrSetData = "C:\EPF\SetData_ПБЮЛ_Отличный_от_др.epf"
   Global $TempFile = @TempDir & '\AutoitPBUL_Temp'
   Global $Obr_Hash_empty_User = "C:\EPF\Hash_empty_User_ПБЮЛ.epf"
   Global $Login =""
   Global $Name = "БухгалтерияПредприятияБазовая"
   Global $Synonym = "Бухгалтерия предприятия (базовая), редакция 3.0"
   Global $ShortInf = "Бухгалтерия предприятия (базовая), редакция 3.0"
   Global $LongInf = "Бухгалтерия предприятия (базовая), редакция 3.0"
   Global $avArray[7] = ["НалоговыйУчетУСН", "ОбщегоНазначенияБПСобытия", "РасчетСебестоимости", "УправлениеВнеоборотнымиАктивами", "УправлениеДоступомСлужебный", "УчетНДС", "УчетТоваров"]
Case "КОРП"
   Global $ConfigName = "Конфигуратор - Бухгалтерия предприятия КОРП, редакция 3.0"
   Global $LogFile = "C:\AccountingCorp\log.txt"
   Global $PathIn = "C:\AccountingCorp\in"
   Global $PathBaseDemo = "C:\сборка\baseCORP\demo"
   Global $PathBaseEmpty = "C:\сборка\baseCORP\empty"
   Global $MsgLog = " /Out" & """" & $LogFile & """" & " -NoTruncate"
   Global $PathDtOut = "C:\AccountingCorp\out\DemoDB"
   Global $PosN2progres = 1300
   Global $ObrStopMaket = "C:\EPF\MaketStop_КОРП.epf"
   Global $ObrSetData = "C:\EPF\SetData_КОРП.epf"
   Global $Obr_Hash_empty_User = "C:\EPF\Hash_empty_User_КОРП.epf"
   Global $Login ="Абдулов (директор)"
   Global $Name = "БухгалтерияПредприятияКОРП"
   Global $Synonym = "Бухгалтерия предприятия КОРП, редакция 3.0"
   Global $ShortInf = "Бухгалтерия предприятия КОРП, редакция 3.0"
   Global $LongInf = "Бухгалтерия предприятия КОРП, редакция 3.0"
Case Else
   MsgBox(0,"Ошибка параметра", "Параметр: " & $TipConf & " не верный")
   Exit
EndSwitch



While 1
   $iEventError = 0
   $HexNumber = 0
   $Status = False
   $My1C=""
   $v8 = ""
   $Obr = ""
   $ResDT = False
   $ResCF = False

   Call("LineLogFile",$LogFile, "" & @CRLF & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & "| Ожидаю файлы: " & @CRLF & $PathIn & "\1cv8.cf" & @CRLF & $PathIn & "\1Cv8.dt")

   ProgressOn("Считываю входящий каталог каждые 10 сек", $TipConf, "0 процентов", $PosN2progres, 850)

   While 1
	  If Not $ResDT Then
		 If FileMove($PathIn & "\1Cv8.dt", $PathIn & "\1Cv8.dt" , 1) Then $ResDT = True
	  EndIf

	  If Not $ResCF Then
		 If FileMove($PathIn & "\*.cf", $PathIn & "\1Cv8.cf" , 1) Then $ResCF = True
	  EndIf

	  If $ResDT And $ResCF Then ExitLoop
	  Sleep(10000)
   WEnd

	; очистим или создадим LOG - файл
	If FileExists($LogFile) Then
		FileDelete ($LogFile)
		$hFile = FileOpen($LogFile, 1)
	Else
		$hFile = FileOpen($LogFile, 2)
	EndIf

	ProgressOn("Демонстрация прогресса " & $TipConf, $TipConf, "0 процентов", $PosN2progres, 850)

   DirRemove($PathBaseEmpty, 1)
   If FileExists($PathBaseEmpty) Then
	  Call("LineLogFile",$LogFile, "Каталог базы: " & $PathBaseEmpty & " недоступен. Работа прекращена")
	  ProgressOff()
	  ContinueLoop
   Else
	  If DirCreate($PathBaseEmpty) = 0 Then
		  Call("LineLogFile",$LogFile, "Каталог базы: " & $PathBaseEmpty & " несоздан. Работа прекращена")
		 ProgressOff()
		 ContinueLoop
	  EndIf
   EndIf

   DirRemove($PathBaseDemo, 1)
   If FileExists($PathBaseDemo) Then
	  Call("LineLogFile",$LogFile, "Каталог базы: " & $PathBaseDemo & " недоступен. Работа прекращена")
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   Else
	  If DirCreate($PathBaseDemo) = 0 Then
		  Call("LineLogFile",$LogFile, "Каталог базы: " & $PathBaseDemo & " несоздан. Работа прекращена")
		  Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	  EndIf
   EndIf

   DirRemove($PathDtOut, 1)
   If FileExists($PathDtOut) Then
	  Call("LineLogFile",$LogFile, "Каталог базы: " & $PathDtOut & " недоступен. Работа прекращена")
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   Else
	  If DirCreate($PathDtOut) = 0 Then
		  Call("LineLogFile",$LogFile, "Каталог базы: " & $PathDtOut & " несоздан. Работа прекращена")
		  Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	  EndIf
   EndIf


	Call("LineLogFile",$LogFile, "" & @CRLF & "		ПЕРВЫЙ ЭТАП")

	ProgressSet (10, "создание пустой базы для демо")
	;////-----------------ПРОЕКТ: создание пустой базы--------------------------------------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " начало создание пустой базы")

	FileClose ($hFile )

	If Not RunWait($PathPlatform & " CREATEINFOBASE File=" & $PathBaseDemo & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! В каталоге: " & $PathBaseDemo & " несоздана база. Работа прекращена")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)


	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец создания пустой базы")

	ProgressSet (15, "загружаю ИБ из файла")
	;////-----------------ПРОЕКТ: загрузить ИБ из файла--------------------------------------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " начало загрузить ИБ из файла")

	FileClose ($hFile )
	If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseDemo & """" & " /restoreib" & """" & $PathIn & "\1Cv8.dt" & """" & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!!В базу: " & $PathBaseDemo & " не загружен файл ИБ " & "" & $PathIn & "\1Cv8.dt" & "" &  ". Работа прекращена")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец загрузки ИБ из файла")

	ProgressSet (20, "Жду конкурента")
	;////-----ПРОЕКТ: Снять конфигурацию с поддержки----------------------------------
   ConsoleWrite("Готов")
   Call("ConsoleWriteRead")
   ConsoleWrite("Занят")

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " начало Снять конфигурацию с поддержки")

	ProgressSet (25, "Снимаю конфигурацию с поддержки")
	FileClose ($hFile )
   $MyPID1 = Run("""" & $PathPlatform & """" & " DESIGNER /F " & """" & $PathBaseDemo & """" & " /N" & """" & $Login & """")
	If Not $MyPID1 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!!Неверный путь к платформе: " & "" & $PathPlatform & "" &  ". Работа прекращена")
		 Call("DelPathIn")
		 ProgressOff()
		 ProcessClose ($MyPID1)
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)

	If Call("OnEdit") Then
	  Call("DelPathIn")
	  ProgressOff()
	  ConsoleWrite("Конец")
	  ContinueLoop
	EndIf


	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец Снять конфигурацию с поддержки")
	FileClose ($hFile )
   ConsoleWrite("Конец")

	ProgressSet (30, "Загружаю файл конфигурации в ДЕМО-базу")
	;////-----ПРОЕКТ: Загрузить файл конфигурации----------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " начало Загрузить файл конфигурации")

	FileClose ($hFile )
   ;дадим 3 попытки загрузить файл конфигурации
   For $i=1 To 3
	  Sleep(3000)
	  If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseDemo & """" & "/N" & """" & $Login & """" & " /LoadCfg" & """" & $PathIn & "\1cv8.cf" & """" & $MsgLog) = 0 Then
		 If $i==3 Then
			$hFile = FileOpen($LogFile, 1)
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! В базу: " & $PathBaseDemo & " не загружен файл конфигурации " & "" & $PathIn & "\1cv8.cf" & "" &  ". Работа прекращена")
			Call("DelPathIn")
			ProgressOff()
			ContinueLoop
		 EndIf
	  Else
		 ExitLoop
	  EndIf
   Next
	$hFile = FileOpen($LogFile, 1)


	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец Загрузить файл конфигурации")

	ProgressSet (35, "Жду конкурента")
	;////-----ПРОЕКТ: Снять конфигурацию с поддержки----------------------------------
   ConsoleWrite("Готов")
   Call("ConsoleWriteRead")
   ConsoleWrite("Занят")

   If $TipConf = "Б-АЯ" Then

	  Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " начало Снять конфигурацию с поддержки и изменение конфигурации ПРОФ на Базовую")

   ElseIf $TipConf = "ПБЮЛ" Then

	  Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " начало Снять конфигурацию с поддержки и изменение конфигурации ПРОФ на Предпринимателя")

   Else
	  Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " начало Снять конфигурацию с поддержки")
   EndIf

   If $TipConf = "Б-АЯ" Then
	  ProgressSet (40, "Снимаю с поддержки и делаю из ПРОФ базовую ")
   ElseIf $TipConf = "ПБЮЛ" Then
	  ProgressSet (40, "Снимаю с поддержки и делаю из ПРОФ Предприниматель ")
   Else
	  ProgressSet (40, "Снимаю конфигурацию с поддержки - ДВА")
   EndIf

	FileClose ($hFile )
   $MyPID2 = Run("""" & $PathPlatform & """" & " DESIGNER /F " & """" & $PathBaseDemo & """" & " /N" & """" & $Login & """")
   $hFile = FileOpen($LogFile, 1)
   If Not $MyPID2 Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!!Неверный путь к платформе: " & "" & $PathPlatform & "" &  ". Работа прекращена")
	  Call("DelPathIn")
	  ProgressOff()
	  ProcessClose ($MyPID2)
	  ContinueLoop
   EndIf

   $Status = True
   If Call("DeleteSupport") Then
	  Call("DelPathIn")
	  ProgressOff()
	  ConsoleWrite("Конец")
	  ContinueLoop
   EndIf

   If $TipConf = "Б-АЯ" Then
	  Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец Снять конфигурацию с поддержки и изменение конфигурации ПРОФ на Базовую")
   ElseIf $TipConf = "ПБЮЛ" Then
	  Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец Снять конфигурацию с поддержки и изменение конфигурации ПРОФ на ПБЮЛ")
   Else
	  Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец Снять конфигурацию с поддержки")
   EndIf

   ConsoleWrite("Конец")

	ProgressSet (45, "Обновляю ИБ")
	;////-----ПРОЕКТ: Обновить ИБ------------------------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " начало Обновить ИБ")

	FileClose ($hFile )
	If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseDemo & """" & "/N" & """" & $Login & """" & " /UpdateDBCfg /N" & """" & $Login & """" & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! ИБ не обновилась " & "" & $PathBaseDemo & "" &  ". Работа прекращена")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)


	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец Обновить ИБ")

   ProgressSet (47, "Проверка Имени конфигурации")
;////-----ПРОЕКТ: Проверка на ИМЯ СИНОНИМ и т.д.________________________
   Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " Начало Проверка Имени конфигурации")

   $oMyError = ObjEvent("AutoIt.Error", "ErrFunc") ; Установка обработчика ошибок
   $My1C = ObjCreate("V83.COMConnector")

   If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! НЕ Создан ObjCreate. Ошибка: " & $HexNumber)
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   EndIf
   Call("LineLogFile",$LogFile, "Создан COM - объект")
   $v8 = ""

   For $i=0 To 3
	  $v8 = $My1C.Connect("File=" & $PathBaseDemo & "; Usr =" & """" & $Login & """" & ";Pwd="""";")
	  If $iEventError Then
		 Call("LineLogFile",$LogFile, "     НЕ Выполнен Connect1. Ошибка: " & $HexNumber & " попытка №: " & $i)
		 If $i=3 Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! НЕ Выполнен Connect1. Ошибка: " & $HexNumber)
			Call("DelPathIn")
			ProgressOff()
			ContinueLoop 2
		 EndIf
	  Else
		 ExitLoop
	  EndIf
	  Sleep(3000)
   Next

   Call("LineLogFile",$LogFile, "Создано COM - соединение с базой")

   $oResalt = $v8.Metadata.Name()
   $oResalt1 = $v8.Metadata.Synonym()
   $oResalt2 = $v8.Metadata.BriefInformation()
   $oResalt3 = $v8.Metadata.DetailedInformation()
   If $oResalt<>$Name Or _
	  $oResalt1<>$Synonym Or _
	  $oResalt2<>$ShortInf Or _
	  $oResalt3<>$LongInf Then

	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА в одном из: " & @CRLF & $oResalt& @CRLF & $oResalt1& @CRLF & $oResalt2& @CRLF & $oResalt3)
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   Else
	  Call("LineLogFile",$LogFile, "			" & $oResalt & @CRLF & "			" & $oResalt1& @CRLF & _
			   "			" & $oResalt2& @CRLF & "			" & $oResalt3)
   EndIf

   Call("LineLogFile",$LogFile, "Завершен вызов функций из конфигурации")

   Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " Конец Проверка Имени конфигурации")


	ProgressSet (50, "Сохраняю конфигурацию в файл")
;////-----ПРОЕКТ: проверка модулей с выключенными текстами, для базовой и ПБЮЛ----------------------------------
   If $TipConf = "Б-АЯ" Or $TipConf = "ПБЮЛ" Then

	  Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " Начало Проверка модулей с выключенными текстами")
	  ProgressSet (48, "Сохраняю конфигурацию в файл")

	  If FileExists($PathBaseDemo & "_Distr") Then
		 If DirRemove($PathBaseDemo & "_Distr",1)=0 Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Каталог: " & $PathBaseDemo & "_Distr" & " недоступен, он нужен для проверки модулей с выключенными текстами")
			Call("DelPathIn")
			ProgressOff()
			ContinueLoop
		 EndIf
	  EndIf

	  DirCopy ( $PathBaseDemo, $PathBaseDemo & "_Distr" ,1 )

	  ;Подготовить временный каталог для выгрузки модулей
	  If FileExists($TempFile) Then
		 If Not DirRemove ($TempFile, 1) Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Ошибка удаления временного каталога перед выгрузкой модулей : " & $TempFile & " " &  ". Работа прекращена")
			Call("DelPathIn")
			ProgressOff()
			ContinueLoop
		 EndIf
	  EndIf
	  If Not DirCreate ($TempFile) Then
		 MsgBox(0,"","Ошибка при создании временного каталога")
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Ошибка при создании временного каталога для выгрузки модулей: " & $TempFile & " " &  ". Работа прекращена")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	  EndIf

	  $qqq111 = """" & $PathPlatform & """" & " DESIGNER /F " & """" & $PathBaseDemo & "_Distr" & """" & " /CreateDistributionFiles -cffile " & """" & $PathIn & "\1Cv8_distr.cf"" /N" & """" & $Login & """"
	  FileClose ($hFile )
	  $MyPID3 = RunWait($qqq111 & $MsgLog)
	  $hFile = FileOpen($LogFile, 1)
	  If $MyPID3 Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При формировании: " & $PathIn & "\1Cv8_distr.cf")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	  EndIf

	  Call("LineLogFile",$LogFile, "Создан файл в: " & $PathIn & "\1Cv8_distr.cf")

	  ;Загрузить файл конфигурации----------------------------------
	  FileClose ($hFile )
	  $MyPID4 = RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseDemo & "_Distr" & """" & "/N" & """" & $Login & """" & " /LoadCfg" & """" & $PathIn & "\1Cv8_distr.cf" & """" & $MsgLog)
	  $hFile = FileOpen($LogFile, 1)
	  If $MyPID4 Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При загрузке: " & $PathIn & "\1Cv8_distr.cf")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	  EndIf

	  Call("LineLogFile",$LogFile, "Загружен файл : " & $PathIn & "\1Cv8_distr.cf" & " в базу: " & $PathBaseDemo & "_Distr")

	  ;Выгрузить модули объектов----------------------------------
	  $qqq222 = """" & $PathPlatform & """" & " DESIGNER /F " & """" & $PathBaseDemo & "_Distr" & """" & " /N" & """" & $Login & """" & "/DumpConfigFiles " & """" & $TempFile & """" & " -Module"
	  $MyPID5 = RunWait("" & $qqq222 & "")
	  If $MyPID5 Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При выгрузке модулей в: " & $TempFile)
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	  EndIf

	  Call("LineLogFile",$LogFile, "Выгружены модули в каталог: " & $TempFile)

	  ;Это и есть проверка модулей объектов----------------------------------
	  If $TipConf = "Б-АЯ" Then
		 If FileExists($TempFile & "\ОбщийМодуль.НалоговыйУчетУСН.Модуль.txt") Or _
			   FileExists($TempFile & "\ОбщийМодуль.ОбщегоНазначенияБПСобытия.Модуль.txt") Or _
			   FileExists($TempFile & "\ОбщийМодуль.РасчетСебестоимости.Модуль.txt") Or _
			   FileExists($TempFile & "\ОбщийМодуль.УправлениеВнеоборотнымиАктивами.Модуль.txt") Or _
			   FileExists($TempFile & "\ОбщийМодуль.УправлениеДоступомСлужебный.Модуль.txt") Or _
			   FileExists($TempFile & "\ОбщийМодуль.УчетНДС.Модуль.txt") Or _
			   FileExists($TempFile & "\ОбщийМодуль.УчетНДС.УчетТоваров") Then

			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! тексты модулей базовой конфигурации не отключены, смотри в: " & $TempFile)
			Call("DelPathIn")
			ProgressOff()
			ContinueLoop
		 EndIf

		 Call("LineLogFile",$LogFile, "В каталоге: " & $TempFile & " нет файлов:" & @CRLF &  _
						"		ОбщийМодуль.НалоговыйУчетУСН.Модуль.txt" & @CRLF & _
						"		ОбщийМодуль.ОбщегоНазначенияБПСобытия.Модуль.txt" & @CRLF & _
						"		ОбщийМодуль.РасчетСебестоимости.Модуль.txt" & @CRLF & _
						"		ОбщийМодуль.УправлениеВнеоборотнымиАктивами.Модуль.txt" & @CRLF & _
						"		ОбщийМодуль.УправлениеДоступомСлужебный.Модуль.txt" & @CRLF & _
						"		ОбщийМодуль.УчетНДС.Модуль.txt"  & @CRLF & _
						"		ОбщийМодуль.УчетТоваров.Модуль.txt"  & @CRLF & _
						"следовательно в этих модулях текст отключен")
		 Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " Конец Проверка модулей с выключенными текстами, для базовой")
	  ElseIf $TipConf = "ПБЮЛ" Then
		 If FileExists($TempFile & "\ОбщийМодуль.НалоговыйУчетУСН.Модуль.txt") Or _
			   FileExists($TempFile & "\ОбщийМодуль.ОбщегоНазначенияБПСобытия.Модуль.txt") Or _
			   FileExists($TempFile & "\ОбщийМодуль.РасчетСебестоимости.Модуль.txt") Or _
			   FileExists($TempFile & "\ОбщийМодуль.УправлениеВнеоборотнымиАктивами.Модуль.txt") Or _
			   FileExists($TempFile & "\ОбщийМодуль.УправлениеДоступомСлужебный.Модуль.txt") Or _
			   FileExists($TempFile & "\ОбщийМодуль.УчетНДС.Модуль.txt") Or _
			   FileExists($TempFile & "\ОбщийМодуль.УчетНДС.УчетТоваров") Then

			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! тексты модулей базовой конфигурации не отключены, смотри в: " & $TempFile)
			Call("DelPathIn")
			ProgressOff()
			ContinueLoop
		 EndIf

		 Call("LineLogFile",$LogFile, "В каталоге: " & $TempFile & " нет файлов:" & @CRLF &  _
						"		ОбщийМодуль.НалоговыйУчетУСН.Модуль.txt" & @CRLF & _
						"		ОбщийМодуль.ОбщегоНазначенияБПСобытия.Модуль.txt" & @CRLF & _
						"		ОбщийМодуль.РасчетСебестоимости.Модуль.txt" & @CRLF & _
						"		ОбщийМодуль.УправлениеВнеоборотнымиАктивами.Модуль.txt" & @CRLF & _
						"		ОбщийМодуль.УправлениеДоступомСлужебный.Модуль.txt" & @CRLF & _
						"		ОбщийМодуль.УчетНДС.Модуль.txt"  & @CRLF & _
						"		ОбщийМодуль.УчетТоваров.Модуль.txt"  & @CRLF & _
						"следовательно в этих модулях текст отключен")
		 Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " Конец Проверка модулей с выключенными текстами, для ПБЮЛ")
	  Else
		 Call("LineLogFile",$LogFile, "!!!***ОШИБКА определения типа конфигурации ПБЮЛ или Б-АЯ")
	  EndIf

   EndIf

	;////-----ПРОЕКТ: Сохранить конфигурацию в файл------------------------------------------------
	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " начало Сохранить конфигурацию в файл")

	FileClose ($hFile )
	If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseDemo & """" & "/N" & """" & $login & """" & " /DumpCfg" & """" & $PathIn & "\1cv8.cf" & "_" & """" & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! В базу: " & $PathBaseDemo & " не сохранен файл конфигурации " & "" & $PathIn & "\1cv8.cf" & "" &  ". Работа прекращена")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец Сохранить конфигурацию в файл")

	ProgressSet (55, "выполняю обработку MaketStop 3_0.epf (COM)")

	;////-----ПРОЕКТ: выполнить обработку MaketStop 3_0.epf (COM)------------------------------------------------
	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " начало выполнить обработку MaketStop 3_0.epf")

	$Obr = $v8.ExternalDataProcessors.Create($ObrStopMaket,False)
	$iEventError = 0

	If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! НЕ Создан объект - внешняя обработка. Ошибка: " & $HexNumber)
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	 EndIf
   Call("LineLogFile",$LogFile, "Создан COM - внешняя обработка")

	FileClose ($hFile )
	Sleep(1000)
	$Resalt = $Obr.Test()
	$hFile = FileOpen($LogFile, 1)
   If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Ошибка выполнения внешненей обработки. Ошибка: " & $HexNumber)
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   EndIf

	If $Resalt = "Успешно" Then
		Call("LineLogFile",$LogFile, " Выполнение обработчиков обновления, резултат: " & $Resalt)
	Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>Внимание!!!резултат обработчиков обновления: " & $Resalt)
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   EndIf

   $Obr =""
   $Resalt = ""
   $v8 = ""
   $iEventError = 0

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец выполнить обработку MaketStop 3_0.epf")
#cs
	;////-----ПРОЕКТ: выполнить обработку Hash_empty_User_?.epf (COM)------------------------------------------------
	ProgressSet (57, "выполняю обработку Hash_empty_User_?.epf (COM)")

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " начало выполнить обработку Hash_empty_User_?.epf")

  $Obr = $v8.ExternalDataProcessors.Create($Obr_Hash_empty_User,False)

	If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! НЕ создан объект обработка. Ошибка: " & $HexNumber)
	  Exit
	  EndIf
	  Call("LineLogFile",$LogFile, "Создан объект обработка")
   Call("LineLogFile",$LogFile, "Создан COM - внешняя обработка")



	$Resalt = $Obr.ОчиститьНаСервереЧерезКом()
   If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Ошибка выполнения внешненей обработки. Ошибка: " & $HexNumber)
	  Exit
   EndIf

   $Resalt = StringReplace($Resalt, "   ", @CRLF)
   Call("LineLogFile",$LogFile, $Resalt)


   $Obr =""
   $v8 = ""

   $iEventError = 0

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец Hash_empty_User_ПРОФ.epf")
#ce
	ProgressSet (60, "выгружаю 1Cv8.dt")

	;-----ПРОЕКТ:  выгрузка 1Cv8.dt------------------------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " Начало выгрузка 1Cv8.dt ПРОФ")

	FileClose ($hFile )
	If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseDemo & """" & "/N" & """" & $Login & """" & " /DumpIB" & """" & $PathDtOut & "\1Cv8.dt" & """" & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! В базу: " & $PathBaseDemo & " не сохранен файл конфигурации " & "" & $PathDtOut & "\1Cv8.dt" & "" &  ". Работа прекращена")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец выгрузка 1Cv8.dt ПРОФ")

	ProgressSet (65, "создаю пустой базы для NEW - базы")

	;////-----------------ПРОЕКТ: создание пустой базы -------------------------------------
	Call("LineLogFile",$LogFile, "" & @CRLF & "		ВТОРОЙ ЭТАП")

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " начало создание пустой базы")

	FileClose ($hFile )

	If Not RunWait($PathPlatform & " CREATEINFOBASE File=" & $PathBaseEmpty & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! В каталоге: " & $PathBaseEmpty & " несоздана база. Работа прекращена")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец создания пустой базы")
	ProgressSet (70, "Загружаю файл конфигурации в NEW-базу")

	;//-----ПРОЕКТ: Загрузить файл конфигурации ----------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " начало Загрузить файл конфигурации в пустую базу")

	FileClose ($hFile )
	If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseEmpty & """" & "/N"""" /LoadCfg" & """" & $PathIn & "\1cv8.cf" & "_" & """" & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! В базу: " & $PathBaseEmpty & " не загружен файл конфигурации " & "" & $PathIn & "\1cv8.cf" & "_" & "" &  ". Работа прекращена")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец Загрузить файл конфигурации в пустую базу")

	ProgressSet (75, "Обновляю ИБ")

	;//-----ПРОЕКТ: Обновить ИБ ----------------------------------
	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " начало Обновить ИБ")

	FileClose ($hFile )
	If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseEmpty & """" & "/N"""" /UpdateDBCfg /N"""""& $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! ИБ не обновилась " & "" & $PathBaseEmpty & "" &  ". Работа прекращена")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)


	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец Обновить ИБ")

	ProgressSet (80, "Заполняю данными SetData 1С:Предприятие")

	;//-----ПРОЕКТ: Первый запуск 1С:Предприятие и Заполнение данными SetData 1С:Предприятие  ----------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " начало Первый запуск 1С:Предприятие и Заполнение данными SetData 1С:Предприятие")

   $v8 = ""
   $v8 = $My1C.Connect("File="& $PathBaseEmpty &"; Usr ="""";Pwd="""";")

   If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! НЕ Выполнен Connect2. Ошибка: " & $HexNumber)
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   EndIf
   Call("LineLogFile",$LogFile, "Создан COM - соединение с базой")

	$Obr = $v8.ExternalDataProcessors.Create($ObrSetData,False)

	If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! НЕ создан объект обработка. Ошибка: " & $HexNumber)
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	  EndIf

   Call("LineLogFile",$LogFile, "Создан COM - внешняя обработка")

	ProgressSet (85, "Заполняю данными SetData 1С:Предприятие")

	FileClose ($hFile )
	$Resalt = $Obr.Run()
	$hFile = FileOpen($LogFile, 1)
   If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Ошибка выполнения внешненей обработки. Ошибка: " & $HexNumber)
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   EndIf
	If $Resalt = "Успешно" Then
		Call("LineLogFile",$LogFile, " Выполнение обработчиков обновления, резултат: " & $Resalt)
	Else
		Call("LineLogFile",$LogFile, ">>>>>>>>>>Ошибка!!!резултат обработчиков обновления: " & $Resalt)
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf

   $Obr =""
   $v8 = ""

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец Первый запуск 1С:Предприятие и Заполнение данными SetData 1С:Предприятие")

	ProgressSet (95, "выгружаю 1Cv8new.dt")

	;-----ПРОЕКТ:  выгрузка 1Cv8new.dt------------------------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " Начало выгрузка 1Cv8new.dt ПРОФ")

	FileClose ($hFile )
	If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseEmpty & """" & "/N"""" /DumpIB" & """" & $PathDtOut & "\1Cv8new.dt" & """" & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! не сохранен файл ИБ " & "" & $PathDtOut & "" &  ". Работа прекращена")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " конец выгрузка 1Cv8new.dt ПРОФ")

	ProgressSet (100, "100 %")



	ProgressOff() ; убирает окно прогресса

   Call("DelPathIn")
 WEnd

; ------------------------------Функции этой программы
Func DelPathIn()
	If DirRemove($PathIn, 1) = 0 Then
		Call("LineLogFile",$LogFile, "Каталог базы: " & $PathIn & " недоступен. Работа прекращена")
		Exit
	 EndIf
	If DirCreate($PathIn) = 0 Then
	  Sleep(3000)
	   If DirCreate($PathIn) = 0 Then
		 Call("LineLogFile",$LogFile, "Каталог базы: " & $PathIn & " несоздан. Работа прекращена")
		 Exit
	  EndIf
	EndIf
	FileClose ($hFile )
EndFunc

Func ErrFunc()
    $HexNumber = Hex($oMyError.number, 8)
   $iEventError = ">>>>>>>>>>ОШИБКА!!! COM  ! Номер: " & $HexNumber

EndFunc   ;==>ErrFunc


Func OnEdit()

   BlockInput(1) ; отключаем клавиатуру и мышь
   Send("{CapsLock off}") ;Выключает CapsLock
   ;Удалить поставщика в конфигурации
   ;Проверим сначало появление окна конфигуратора, потом активируем его, в случае ошибки выход с ошибкой.
   $hWnd = WinWait($ConfigName, "", 1200) ; без таймаута (30) ожидание бесконечно
   If Not $hWnd Then
	  ;Закрываем Конфигуратор
	  IF Call("CloseConfig", $hWnd, "аварийное") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор")
	  EndIf
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Истекло время ожидания окна конфигуратора, 20 минут, работа остановлена")
	  BlockInput(0) ; включаем клавиатуру и мышь
	  Return 1
   Else
		If Call("OnEditNext", $hWnd) Then Return 1
   EndIf
EndFunc

Func OnEditNext($hWndFunc)

	;запись в лог-файл
   Call("LineLogFile",$LogFile, "Окно конфигуратора найдено, активируем его и открываем окно настройки и поддержки")

   If WinActivate($hWndFunc) Then
	  WinMove($hWndFunc, "", 10, 10, 800, 600)
   Else
	  ;запись в лог-файл
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Окно конфигуратора не активно, завершаем работу скрипта***********")
	  If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор***********")
	  EndIf
	  Return 1
   EndIf

   ;Если окно дерево метаданных не открыто, откроем его
   $hWndV8Grid = WinWait("[CLASS:V8Grid]", "", 3)
   If Not $hWndV8Grid Then
	  _WinAPI_SetKeyboardLayout($hWndFunc,0x0419)
	  Sleep(100)
	  Send("!ф")
	  Send("!a")
	  Send("{RIGHT 2}{ENTER}")
   EndIf

   WinWait("[CLASS:V8Grid]", "", 20)
   WinActivate($hWndFunc)
   ; ввойдем в окно настройки и поддержки
   _WinAPI_SetKeyboardLayout($hWndFunc,0x0419)
   Sleep(100)
   Send("!ф")
   Send("!a")
   Send("{RIGHT 2}{DOWN 6}{RIGHT}{DOWN}{ENTER}")

   $hWnd1 = WinWait("Настройка поддержки", "", 50)
   Call("LineLogFile",$LogFile, "Начинаем в Окне Настройка поддержки действия по снятию с поддержки конфигурации ")

;---------------------выполнли проверку на остсутвие поставщика по контрольной сумме изоброжения в окне "Настройка поддержки"
   Sleep(2000)
   If WinActivate($hWnd1) Then
	  WinMove($hWnd1, "", 800, 10, 800, 600)
	  Local $StrKod = String(Call("CheckWindows",$hWnd1,7,30,400,550))
	  Switch $StrKod
	  Case "3862447798"
		 Send("{ESC}")
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ВНИМАНИЕ!!! Конфигурация не стояла на поддержке - Это подозрительно. Закрываем конфигуратор - прекращаем работу")
		 ;Закрываем Конфигуратор
		 IF Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*********")
		 EndIf
		 Return 1
	  Case "3919286857"
		 Send("{ENTER}")
	  Case "3822077678"
		 Send("{ESC}")
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ВНИМАНИЕ!!! Конфигурация уже снята блокировка изменений, но стоит на поддержке - Это подозрительно. Закрываем конфигуратор - прекращаем работу")
		 ;Закрываем Конфигуратор
		 IF Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*********")
		 EndIf
		 Return 1
	  Case Else
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Невозможно сказать стоит ли конфигурация на поддержке (" & $StrKod & ")  , прекращаем работу****")
		 If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*****")
		 EndIf
		 Return 1
	  EndSwitch
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! выполняя проверку на отсутствие поставщика окно Настройка поддержки не активно, прекращаем работу****")
	  If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*****")
	  EndIf
	  Return 1
   EndIf

   ;ждем диалоговое окно ДА НЕТ
   $hWnd2 = WinWait("Конфигуратор", "", 30)
   If Not $hWnd2 Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Окно диалога ДА/НЕТ не появилось, закрываем конфигуратор и прекращаем работу***")
	  If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор****")
	  EndIf
	  Return 1
   EndIf

   If WinActivate($hWnd2) Then
	  Send("{ENTER}")
   EndIf

   $hWnd3 = WinWait("Настройка правил поддержки", "", 30)
   If Not WinActivate($hWnd3) Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Окно Настройка правил поддержки не появилось, закрываем конфигуратор и прекращаем работу**")
	  If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*****")
	  EndIf
	  Return 1
   EndIf


   Send("{DOWN 2}{TAB}{DOWN 2}{TAB}{ENTER}")
   Sleep(2000)
   Local $aPos = WinGetPos($hWnd1)
   ; Пытаемся Перемещать
   WinMove($hWnd1, "", 10, 10)
   ; Перемещает и устанавливает размеры окна в первоначальное состояние.
   WinMove($hWnd1, "", $aPos[0], $aPos[1], $aPos[2], $aPos[3])
   ; --------------------Включили возможность изменений----------------------------------
   ; --------закроем окно Настройка поддержки----------------------
   If WinActivate($hWnd1) Then
	  Send("{ESC}")
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Окно Настройка поддержки не активно, закрываем конфигуратор и прекращаем работу**")
	  If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*****")
	  EndIf
	  Return 1
   EndIf

   Call("LineLogFile",$LogFile, "В конфигурации включена возможность изменений. Закрываем конфигуратор")
   ;Закрываем Конфигуратор
   IF Call("CloseConfig", $hWndFunc, "интерактивное") = "2" Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор, после удаления поставщика*")
	  Return 1
   EndIf

   BlockInput(0) ; включаем клавиатуру и мышь

EndFunc


Func DeleteSupport()

   BlockInput(1) ; отключаем клавиатуру и мышь
   Send("{CapsLock off}") ;Выключает CapsLock
   ;Удалить поставщика в конфигурации
   ;Проверим сначало появление окна конфигуратора, потом активируем его, в случае ошибки выход с ошибкой.
   $hWnd = WinWait($ConfigName, "", 1200) ; без таймаута (30) ожидание бесконечно
   If Not $hWnd Then
	  ;Закрываем Конфигуратор
	  IF Call("CloseConfig", $hWnd, "аварийное") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор")
	  EndIf
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Истекло время ожидания окна конфигуратора, 20 минут, работа остановлена")
	  BlockInput(0) ; включаем клавиатуру и мышь
	  Return 1
   Else
		If Call("DeleteSupportNext", $hWnd) Then Return 1
   EndIf
EndFunc

Func DeleteSupportNext($hWndFunc)

		;запись в лог-файл
   Call("LineLogFile",$LogFile, "Окно конфигуратора найдено, активируем его и открываем окно настройки и поддержки")

   If WinActivate($hWndFunc) Then
	  WinMove($hWndFunc, "", 10, 10, 800, 600)
   Else
	  ;запись в лог-файл
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Окно конфигуратора не активно, завершаем работу скрипта***********")
	  If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор***********")
	  EndIf
	  Return 1
   EndIf

   ;Если окно дерево метаданных не открыто, откроем его
   $hWndV8Grid = WinWait("[CLASS:V8Grid]", "", 3)
   If Not $hWndV8Grid Then
	  _WinAPI_SetKeyboardLayout($hWndFunc,0x0419)
	  Sleep(100)
	  Send("!ф")
	  Send("!a")
	  Send("{RIGHT 2}{ENTER}")
   EndIf

   WinWait("[CLASS:V8Grid]", "", 20)
   WinActivate($hWndFunc)
   ; ввойдем в окно настройки и поддержки
   _WinAPI_SetKeyboardLayout($hWndFunc,0x0419)
   Sleep(100)
   Send("!ф")
   Send("!a")
   Send("{RIGHT 2}{DOWN 6}{RIGHT}{DOWN}{ENTER}")

   $hWnd1 = WinWait("Настройка поддержки", "", 50)
   Call("LineLogFile",$LogFile, "Начинаем в Окне Настройка поддержки действия по снятию с поддержки конфигурации ")
  ;---------------------выполнли проверку на остсутвие поставщика по контрольной сумме изоброжения в окне "Настройка поддержки"
   Sleep(2000)
   If WinActivate($hWnd1) Then
	  WinMove($hWnd1, "", 800, 10, 800, 600)
	  Local $StrKod = String(Call("CheckWindows",$hWnd1,7,30,400,550))
	  Switch $StrKod
	  Case "3862447798"
		 Send("{ESC}")
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ВНИМАНИЕ!!! Конфигурация не стояла на поддержке - Это подозрительно. Закрываем конфигуратор - прекращаем работу")
		 ;Закрываем Конфигуратор
		 IF Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*********")
		 EndIf
		 Return 1
	  Case "3919286857"
		 Send("{ENTER}")
	  Case "3822077678"
		 Send("{ESC}")
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ВНИМАНИЕ!!! Конфигурация уже снята блокировка изменений, но стоит на поддержке - Это подозрительно. Закрываем конфигуратор - прекращаем работу")
		 ;Закрываем Конфигуратор
		 IF Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*********")
		 EndIf
		 Return 1
	  Case Else
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Невозможно сказать стоит ли конфигурация на поддержке (" & $StrKod & ")  , прекращаем работу****")
		 If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*****")
		 EndIf
		 Return 1
	  EndSwitch
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! выполняя проверку на отсутствие поставщика окно Настройка поддержки не активно, прекращаем работу****")
	  If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*****")
	  EndIf
	  Return 1
   EndIf

   ;ждем диалоговое окно ДА НЕТ
   $hWnd2 = WinWait("Конфигуратор", "", 30)
   If Not $hWnd2 Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Окно диалога ДА/НЕТ не появилось, закрываем конфигуратор и прекращаем работу***")
	  If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор****")
	  EndIf
	  Return 1
   EndIf

   If WinActivate($hWnd2) Then
	  Send("{ENTER}")
   EndIf

   $hWnd3 = WinWait("Настройка правил поддержки", "", 30)
   If Not WinActivate($hWnd3) Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Окно Настройка правил поддержки не появилось, закрываем конфигуратор и прекращаем работу**")
	  If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*****")
	  EndIf
	  Return 1
   EndIf


   Send("{DOWN 2}{TAB}{DOWN 2}{TAB}{ENTER}")
   Sleep(2000)
   Local $aPos = WinGetPos($hWnd1)
   ; Пытаемся Перемещать
   WinMove($hWnd1, "", 10, 10)
   ; Перемещает и устанавливает размеры окна в первоначальное состояние.
   WinMove($hWnd1, "", $aPos[0], $aPos[1], $aPos[2], $aPos[3])
   ; --------------------Включили возможность изменений----------------------------------
   ; --------------------снимаем с поддержки----------------------------------
   Send("{TAB 3}{ENTER}")
   $hWnd2 = WinWait("Конфигуратор", "", 1200)
   If Not $hWnd2 Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Окно диалога ДА/НЕТ не появилось, закрываем конфигуратор и прекращаем работу****")
		 If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*****")
		 EndIf
	  Return 1
   EndIf
   If WinActivate($hWnd2) Then
	  Send("{ENTER}")
   EndIf
; -----------------------сняли с поддержки-------------------------------------------


;---------------------выполнли проверку на остсутвие поставщика по контрольной сумме изоброжения
   Sleep(2000)
   If WinActivate($hWnd1) Then
	  Local $StrKod = String(Call("CheckWindows",$hWnd1,7,30,400,550))
	  Switch $StrKod
	  Case "3862447798"
		 Call("LineLogFile",$LogFile, "Конфигурация снята с поддержки")
	  Case "3919286857"
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! выполняя проверку Конфигурация осталась на поддержке, прекращаем работу****")
		 If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*****")
		 EndIf
		 Return 1
	  Case "3822077678"
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! выполняя проверку Конфигурация осталась на поддержке с возможностью изменнений, прекращаем работу****")
		 If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*****")
		 EndIf
		 Return 1
	  Case Else
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Невозможно сказать стоит ли конфигурация на поддержке (" & $StrKod & ")  , прекращаем работу****")
		 If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*****")
		 EndIf
		 Return 1
	  EndSwitch
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! выполняя проверку на отсутствие поставщика окно Настройка поддержки не активно, прекращаем работу****")
	  If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*****")
	  EndIf
	  Return 1
   EndIf

   ; --------закроем окно Настройка поддержки----------------------
   If WinActivate($hWnd1) Then
	  Send("{ESC}")
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Окно Настройка поддержки не активно, закрываем конфигуратор и прекращаем работу**")
	  If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор*****")
	  EndIf
	  Return 1
   EndIf

 ;Если этот процесс для базовой конфигурации тогда этот ПРОФ сделаем базовой
   If $TipConf = "Б-АЯ" Then
	  If Call("Prof_To_Base_Start1", $hWndFunc) Then
		 BlockInput(0) ; включаем клавиатуру и мышь
		 If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор**")
		 EndIf
		 Return 1
	  EndIf
   EndIf

   If $TipConf = "ПБЮЛ" Then
	  If Call("Prof_To_Base_PBUL", $hWndFunc) Then
		 BlockInput(0) ; включаем клавиатуру и мышь
		 If Call("CloseConfig", $hWndFunc, "аварийное") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор**")
		 EndIf
		 Return 1
	  EndIf
   EndIf

   Call("LineLogFile",$LogFile, "В конфигурации удален поставщик. Закрываем конфигуратор")
   ;Закрываем Конфигуратор
   IF Call("CloseConfig", $hWndFunc, "интерактивное") = "2" Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки закрыть конфигуратор, после удаления поставщика*")
	  Return 1
   EndIf

   BlockInput(0) ; включаем клавиатуру и мышь

EndFunc


Func CloseConfig($hWndFunc1, $TegErr)
   If ($TegErr="аварийное") Then
	  Call("KillPID",$hWndFunc1)
	  BlockInput(0) ; включаем клавиатуру и мышь
   ElseIf ($TegErr="интерактивное") Then
	  ;Закрываем Конфигуратор интерактивно
	  WinClose($hWndFunc1)
	  $hWnd4 = WinWait("Конфигуратор", "", 360)
	  If Not WinActivate($hWnd4) Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Окно диалога ДА/НЕТ (сохранение конфигурации) не активно***********")
		 Call("KillPID",$hWndFunc1)
		 BlockInput(0)
		 Return "2"
	  Else
		 WinActivate($hWnd4)
		 Send("{ENTER}")
		 $iPID = WinGetProcess($hWndFunc1)
		 If WinWaitClose($hWndFunc1,"",600)=0 Then
			if ProcessWaitClose($iPID, 300)=0 Then
			   Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! конфигуратор не закрывался 10 мин, закрыл аварийно, и прекратил работу***********")
			   Call("KillPID",$hWndFunc1)
			   BlockInput(0)
			   Return "2"
			EndIf
		 EndIf
		 BlockInput(0)
		 Call("LineLogFile",$LogFile,_Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & "Конфигуратор закрыт")
		 Sleep(500)
		 Return "0"
	  EndIf
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! что-то пощло не так, работа прекращена (1)***********")
	  BlockInput(0)
	  Return "2"
   EndIf
EndFunc

Func KillPID($hWndFunc2)
   ; Получим ПИД процесса 1С:Конфигуратор
   $iPID = WinGetProcess($hWndFunc2)
   ProcessClose($iPID)
   ProcessWaitClose($iPID, 240)
   If ProcessExists($iPID) Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! После попытки закрыть процесс приложения 1С : /" & $iPID & "/ процесс не закрылся по какой-то причине, закройте его вручную, работа прекращена")
	  Return "2"
   EndIf
   Return "0"
EndFunc

Func ConsoleWriteRead()
   Local $sOutput
   While 1
	  $sOutput = StringRight(ConsoleRead(False), 5)
	  If @error Then
		 MsgBox(4096, "", "ошибка чтения в:" & $TipConf)
	  ElseIf $sOutput=="Старт" Then
		 ExitLoop
	  EndIf
	  Sleep(1000)
   WEnd
EndFunc


Func LineLogFile($LogFileFunc, $Line)
	If FileExists($LogFileFunc) Then
		FileWriteLine($LogFileFunc, $Line)
	Else
		BlockInput(0) ; включаем клавиатуру и мышь
		MsgBox(0,"Ошибка","Нет LOG - файла работа остановлена")
		Exit
	EndIf
EndFunc

Func CheckWindows($hWndFunc,$correctionLeft,$correctionTop,$correctionRight,$correctionBottom)
   ; Создаёт структуру, в которую возвращаются координаты
   $tRect = _WinAPI_GetWindowRect($hWndFunc)
   ;Получим координаты
   $Left = DllStructGetData($tRect, "Left") + $correctionLeft
   $Top = DllStructGetData($tRect, "Top") + $correctionTop
   $Right = DllStructGetData($tRect, "Right") - $correctionRight
   $Bottom = DllStructGetData($tRect, "Bottom") - $correctionBottom
   ;Генерируем контрольную сумму области пикселе
   $checksum = PixelChecksum($Left, $Top, $Right-1, $Bottom-1)
   ;покажу зону контроля в окне
   $hForm = GUICreate('', $Right - $Left, $Bottom - $Top, $Left, $Top, $WS_POPUP, $WS_EX_TOPMOST)
   GUISetBkColor(0xFF00000)
   WinSetTrans($hForm, '', 150) ; прозрачность
   GUISetState()
   Sleep(2000)
   GUIDelete()
   Return $checksum
EndFunc

;////-----ПРОЕКТ: сделать из ПРОФ базовую----------------------------------

Func Prof_To_Base_Start1($hWndFunc_Base)
   ;////////изменим свойство конфигурации--------------------------------------
   _WinAPI_SetKeyboardLayout($hWndFunc_Base,0x0419)
   Send("{ENTER}")
   Send($Name)
   Send("{TAB}")
   Send($Synonym)
   Send("{TAB 22}")
   Send($ShortInf)
   Send("{TAB}")
   Send("^{ф}")
   Send($LongInf)
   Send("{TAB}{ESC}")
   Call("LineLogFile",$LogFile, "Завершил изменения в Имя/Синоним/Краткое информация/Подробная информация конфигурации ПРОФа на базовую конфигурацию")

   ;////////отключить текты модулей--------------------------------------

   Sleep(100)
   Send("!ф")
   Sleep(100)
   Send("!a")
   Sleep(100)
   Send("{RIGHT 2}")
   Sleep(100)
   Send("{DOWN 14}")
   Sleep(100)
   Send("{RIGHT}")
   Sleep(100)
   Send("{DOWN}")
   Sleep(100)
   Send("{ENTER}")
   Sleep(100)

   $hWnd3 = WinWaitActive("Настройка поставки", "", 30)
   If Not $hWnd3  Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки отключить тексты модулей Не увидел окно Настройка поставки ***********")
	  Return 1
   EndIf
   WinSetState($hWnd3,'',@SW_MAXIMIZE )
   Send("{DOWN}{RIGHT}{DOWN 2}{RIGHT}")

   Local $StringMod = ""

   For $i = 0  To UBound($avArray)-1
	  Send($avArray[$i])
	  Send("{APPSKEY}{DOWN}{ENTER}{TAB}{SPACE}{DOWN}{ENTER}{LEFT}")
	  Sleep(100)
	  $StringMod = $StringMod & $avArray[$i]& @CRLF
   Next

   Send("{TAB 2}{ENTER}")

   Call("LineLogFile",$LogFile, "Завершил отключение текстов модулей: " & @CRLF & $StringMod)

   Return 0
EndFunc

;////-----ПРОЕКТ: сделать из ПРОФ ПБЮЛ----------------------------------

Func Prof_To_Base_PBUL($hWndFunc_PBUL)
   ;////////изменим свойство конфигурации--------------------------------------
   _WinAPI_SetKeyboardLayout($hWndFunc_PBUL,0x0419)
   Send("{ENTER}")
   Send($Name)
   Send("{TAB}")
   Send($Synonym)
   Send("{TAB 22}")
   Send($ShortInf)
   Send("{TAB}")
   Send("^{ф}")
   Send($LongInf)
   Send("{TAB}{ESC}")
   Call("LineLogFile",$LogFile, "Завершил изменения в Имя/Синоним/Краткое информация/Подробная информация конфигурации ПРОФа на ПБЮЛ")

   ;////////отключить текты модулей--------------------------------------

   Sleep(200)
   Send("!ф")
   Sleep(200)
   Send("!a")
   Sleep(200)
   Send("{RIGHT 2}")
   Sleep(200)
   Send("{DOWN 14}")
   Sleep(200)
   Send("{RIGHT}")
   Sleep(200)
   Send("{DOWN}")
   Sleep(200)
   Send("{ENTER}")
   Sleep(200)

   $hWnd3 = WinWait("Настройка поставки", "", 120)

   If Not WinActivate($hWnd3)  Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! При попытки отключить тексты модулей Не увидел окно Настройка поставки ***********")
	  Return 1
   EndIf
   WinSetState($hWnd3,'',@SW_MAXIMIZE )
   Send("{DOWN}{RIGHT}{DOWN 2}{RIGHT}")

   Local $StringMod = ""

   For $i = 0  To UBound($avArray)-1
	  Send($avArray[$i])
	  Send("{APPSKEY}{DOWN}{ENTER}{TAB}{SPACE}{DOWN}{ENTER}{LEFT}")
	  Sleep(100)
	  $StringMod = $StringMod & $avArray[$i]& @CRLF
   Next
   Sleep(100)
   Send("{TAB 2}{ENTER}")

   Call("LineLogFile",$LogFile, "Завершил отключение текстов модулей: " & @CRLF & $StringMod)

   Return 0
EndFunc