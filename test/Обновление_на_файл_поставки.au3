#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#pragma compile(AutoItExecuteAllowed, true)
#include <Array.au3>
#include <WinAPIEx.au3>
#include <Constants.au3>
#Include <File.au3>
#include <Clipboard.au3>
#include <Date.au3>

Opt("SendKeyDelay",100) ; enable delay 20 ms for Send
Opt("WinDetectHiddenText", 1) ; show hidden text
Opt("WinSearchChildren", 1) ; search for sub-windows
Opt("WinWaitDelay", 500) ; wait 500 ms after window commands
Opt("WinTitleMatchMode", 3)

Global $PathPlatform = "C:\Program Files (x86)\1cv8\8.3.5.1517\bin\1cv8.exe"
Global $PathBase = "C:\Users\Makosov_A\Desktop\test\TESTbase\base"
Global $LogFile = "C:\Users\Makosov_A\Desktop\test\TESTbase\log.txt"
Global $MsgLog = " /Out" & """" & $LogFile & """" & " -NoTruncate"
Global $V8Stor = "C:\Users\Makosov_A\Desktop\test\TESTbase\30_PROF"
Global $UpdFile = "\\builder-fat\1c\8.2\AccountingCorp\3.0.40.21\1Cv8.cf"
Global $ConfigName = "Конфигуратор - Бухгалтерия предприятия, редакция 3.0"


If FileExists($LogFile) Then
   FileDelete ($LogFile)
   $hFile = FileOpen($LogFile, 1)
Else
   $hFile = FileOpen($LogFile, 2)
EndIf

BlockInput(1) ; отключаем клавиатуру и мышь
FileClose ($hFile )
$MyPID1 = Run("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBase & """" & " /N"""""& " /ConfigurationRepositoryF " & """" & $V8Stor & """" & " /ConfigurationRepositoryN ""Макосов""")

If Not $MyPID1 Then
   $hFile = FileOpen($LogFile, 1)
   Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!!Неверный путь к платформе: " & "" & $PathPlatform & "" &  ". Работа прекращена")
EndIf

$hFile = FileOpen($LogFile, 1)
Send("{CapsLock off}") ;Выключает CapsLock
$hWnd = WinWait($ConfigName) ; без таймаута (30) ожидание бесконеч


If WinActivate($hWnd) Then

   Call("LineLogFile",$LogFile, "Окно: " & "" & $ConfigName & "" &  " открылось")
   WinMove($hWnd, "", 10, 10, 800, 600)
   ;Если окно дерево метаданных не открыто, откроем его
   $hWndV8Grid = WinWait("[CLASS:V8Grid]", "", 3)
   If Not $hWndV8Grid Then
	  Call("LineLogFile",$LogFile, "Дерево кобъектов конфигурации не открыто, откроем его")
	  _WinAPI_SetKeyboardLayout($hWnd,0x0419)
	  Sleep(100)
	  WinActivate($hWnd)
	  Send("!ф")
	  Send("!a")
	  Send("{RIGHT 2}{ENTER}")
   EndIf
   WinWait("[CLASS:V8Grid]", "", 20)
   ; ввойдем в меню и нажмем "обновить конфигурацию"
   Call("LineLogFile",$LogFile, "ввойдем в меню и нажмем: " & "" & "обновить конфигурацию" & "")
   _WinAPI_SetKeyboardLayout($hWnd,0x0419)
   Sleep(100)
   WinActivate($hWnd)
   Send("!ф")
   Send("!a")
   Send("{RIGHT 2}{DOWN 5}{RIGHT}{ENTER}{DOWN}{TAB}{ENTER}{TAB 3}")
   ; получим первое окно "Обновление конфигурации" и заполним его строкой
   $hWnd0 = WinWait("Обновление конфигурации","",20)
   If WinActivate($hWnd0) Then
	  If FileExists($UpdFile) Then
		 _WinAPI_SetKeyboardLayout($hWnd,0x0409)
		 WinActivate($hWnd0)
		 Send($UpdFile)
		 WinActivate($hWnd0)
		 Send("{TAB 2}{ENTER}")
		 Call("LineLogFile",$LogFile, "В окне: " & "" & "Обновление конфигурации" & "" & " заполнили путь к файлу обновления ")
	  Else
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!!Неверный путь к файлу поставки: " & "" & $UpdFile & "" &  ". Работа прекращена")
		 FileClose($LogFile)
		 Exit
	  EndIf
	  Call("LineLogFile",$LogFile, "Появилось окно: " & "" & "Обновление конфигурации" & "")
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!!Не активно окно: " & "" & "Обновление конфигурации" & ", второе, " &  ". Работа прекращена")
	  FileClose($LogFile)
	  Exit
   EndIf
   ; получим второе окно "Обновление конфигурации"
   $hWnd1 = WinWait("Обновление конфигурации","",20)
   If WinActivate($hWnd1) Then
	  Call("LineLogFile",$LogFile, "Появилось окно: " & "" & "Обновление конфигурации" & " еще раз")
	  WinActivate($hWnd1)
	  Send("{ENTER}")
	  ProgressOn("", "", "", 100, 850)
	  local $i = 0
	  BlockInput(0) ; включаем клавиатуру и мышь
	  ; сворачиваем окно и ожидаем его активности
	  While 1
		 ProgressSet(($i*100/180),"№:" & $i, "Прогресс обновления КОРП-файлом")
		 If WinExists("Предупреждение") Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! В ПРОФ хранилище не захвачены объекты. Работа прекращена")
			FileClose($LogFile)
			Exit
		 EndIf
		 WinSetState($hWnd,"",@SW_MINIMIZE)
		 Sleep(3000)
		 $iState = WinGetState($hWnd)
		 If BitAND($iState, 4) Then
			;'доступно/'
			ProgressSet(100,"№:" & $i, "Прогресс 100%")
			Sleep(500)
			ProgressOff()
			ExitLoop
		 EndIf
		 $i +=1
	  WEnd
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!!Не активно окно: " & "" & "Обновление конфигурации" & ", второе, " &  ". Работа прекращена")
	  FileClose($LogFile)
	  Exit
   EndIf


EndIf
BlockInput(1) ; выключаем клавиатуру и мышь
WinSetState($hWnd,"",@SW_RESTORE)
WinMove($hWnd, "", 10, 10, 800, 600)
;слияния и объединения {TAB 12}{ENTER}
WinWait($hWnd)
If WinActivate($hWnd) Then
   Send("{TAB 12}{ENTER}")
   Call("LineLogFile",$LogFile, "В окне слияния и объединения нажал кнопку ДАЛЕЕ")
Else
   Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!!Не активно окно: " & "" & $hWnd & "" &  ". Работа прекращена")
   FileClose($LogFile)
   Exit
EndIf
;Неразрешимые ссылки (V8NewLocalFrameBaseWnd) {TAB 3}{ENTER}
$hWnd2 = WinWait("Неразрешимые ссылки")
If WinActivate($hWnd2) Then
   Send("{TAB 3}{ENTER}")
   Call("LineLogFile",$LogFile, "В окне Неразрешимые ссылки нажал кнопку ДАЛЕЕ")
Else
   Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!!Не активно окно: " & "" & "Неразрешимые ссылки" & "" &  ". Работа прекращена")
   FileClose($LogFile)
   Exit
EndIf
;Конфигуратор (V8NewLocalFrameBaseWnd) {ENTER}
$hWnd3 = WinWait("Конфигуратор")
If WinActivate($hWnd3) Then
   Send("{ENTER}")
   Call("LineLogFile",$LogFile, "В окне Конфигуратор нажал кнопку ДАЛЕЕ")
Else
   Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!!Не активно окно: " & "" & "Конфигуратор" & "" &  ". Работа прекращена")
   FileClose($LogFile)
   Exit
EndIf
;Настройка правил поддержки (V8NewLocalFrameBaseWnd) {TAB 6}{ENTER}
$hWnd4 = WinWait("Настройка правил поддержки")
If WinActivate($hWnd4) Then
   Send("{TAB 6}{ENTER}")
   Call("LineLogFile",$LogFile, "В окне Настройка правил поддержки нажал кнопку ДАЛЕЕ")
Else
   Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!!Не активно окно: " & "" & "Настройка правил поддержки" & "" &  ". Работа прекращена")
   FileClose($LogFile)
   Exit
EndIf
;Конфигуратор (V8NewLocalFrameBaseWnd) {ENTER}
$hWnd4 = WinWait("Конфигуратор")
If WinActivate($hWnd4) Then
   Send("{ENTER}")
   Call("LineLogFile",$LogFile, "В окне Конфигуратор нажал кнопку ДАЛЕЕ")
Else
   Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!!Не активно окно: " & "" & "Конфигуратор" & "" &  ". Работа прекращена")
   FileClose($LogFile)
   Exit
EndIf

Local $iPID = WinGetProcess($hWnd)
Call("CloseConfig",$hWnd,"интерактивное")



While 1
   If Not ProcessExists($iPID) Then
	  Call("LineLogFile",$LogFile, "Конфигуратор ПРОФ с номером процесса : /" & $iPID & "/ закрылся штатно")
	  ExitLoop
   EndIf
   Sleep(300000)
   Call("LineLogFile",$LogFile, "Ожидание когда будет завершен процесс : /" & $iPID)
WEnd
BlockInput(0) ; включаем клавиатуру и мышь
FileClose($LogFile)




Func LineLogFile($LogFileFunc, $Line)
	If FileExists($LogFileFunc) Then
		FileWriteLine($LogFileFunc, $Line)
	Else
		BlockInput(0) ; включаем клавиатуру и мышь
		MsgBox(0,"Ошибка","Нет LOG - файла работа остановлена")
		FileClose($LogFile)
		Exit
	EndIf
 EndFunc

 Func CloseConfig($hWndFunc, $TegErr)
   If ($TegErr="аварийное") Then
	  Call("KillPID",$hWndFunc)
   ElseIf ($TegErr="интерактивное") Then
	  ;Закрываем Конфигуратор интерактивно
	  WinClose($hWndFunc)
	  $hWnd4 = WinWait("Конфигуратор", "", 360)
	  If Not $hWnd4 Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Окно диалога ДА/НЕТ (сохранение конфигурации) не появилось***********")
		 Return "2"
	  ElseIf Not WinActivate($hWnd4) Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! Окно диалога ДА/НЕТ (сохранение конфигурации) не активно***********")
		 Return "2"
	  Else
		 Send("{ENTER}")
		 Local $iPID = WinGetProcess($hWndFunc)
		 Sleep(10000)
		 If Not ProcessExists($iPID)=0 Then
			Return "2"
		 EndIf
		 Return "0"
	  EndIf
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>ОШИБКА!!! что-то пощло не так, работа прекращена (1)***********")
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