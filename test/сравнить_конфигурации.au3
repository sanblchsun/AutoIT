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
#Include <WindowsConstants.au3>

Opt("SendKeyDelay",100) ; enable delay 20 ms for Send
Opt("WinDetectHiddenText", 1) ; show hidden text
Opt("WinSearchChildren", 1) ; search for sub-windows
Opt("WinWaitDelay", 500) ; wait 500 ms after window commands
Opt("WinTitleMatchMode", 3)
Opt('PixelCoordMode', 1);!!!

Global $PathPlatform = "C:\Program Files (x86)\1cv8\8.3.5.1517\bin\1cv8.exe"
Global $PathBase = "C:\Users\Makosov_A\Desktop\test\TESTbase\base"
Global $LogFile = "C:\Users\Makosov_A\Desktop\test\TESTbase\log.txt"
Global $MsgLog = " /Out" & """" & $LogFile & """" & " -NoTruncate"
Global $V8Stor = "C:\Users\Makosov_A\Desktop\test\TESTbase\30_PROF"
Global $UpdFile = "\\builder-fat\1c\8.2\AccountingCorp\3.0.40.21\1Cv8.cf"
Global $ConfigName = "Конфигуратор - Бухгалтерия предприятия, редакция 3.0"
Global $ConfigProfDo = "D:\work\3.0.40.20\1Cv8_ПРОФ_ДО.cf"
Global $PatchReportProf = "C:\Users\Makosov_A\Desktop\Instrument\NoCat\ПРОФ.txt"


If FileExists($LogFile) Then
   FileDelete ($LogFile)
   $hFile = FileOpen($LogFile, 1)
Else
   $hFile = FileOpen($LogFile, 2)
EndIf


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
   Call("LineLogFile",$LogFile, "ввойдем в меню и нажмем: " & "" & "сравнить конфигурации" & "")
   _WinAPI_SetKeyboardLayout($hWnd,0x0419)
   Sleep(100)
   WinActivate($hWnd)
   Send("!ф")
   Send("!a")
   Send("{RIGHT 2}{DOWN 9}{ENTER}")

   ;ждем окно "Сравнение конфигураций"
   $hWnd0 = WinWait("Сравнение конфигураций")

   ;Проверяем нестоит ли галка в окне методом сверки контрольной суммы этой части окна
   If Not String(Call("CheckWindows",$hWnd0,0,175,0,33))=="3101733842" Then
	  Call("LineLogFile",$LogFile, "!!!***Ошибка. В окне: " & "" & "Сравнение конфигураций" & "" & " стоит галка, удалите ее")
	  Exit
   EndIf


   _WinAPI_SetKeyboardLayout($hWnd0,0x0409)
   Send("{TAB 2}")
   Send($ConfigProfDo)
   Send("{TAB 2}{ENTER}")

   ;ждем в цикле доступность окна
   While 1
	  Sleep(3000)
	  $iState = WinGetState($hWnd)
	  If BitAND($iState, 4) Then
		 ;'доступно/'
		 ExitLoop
	  EndIf
   WEnd

   ; Извлекает текст окна и проверяем, должно быть "Сравнение Основная конфигурация - Файл " & $ConfigProfDo"
   $text = WinGetText($hWnd)
   If StringInStr($text, "Сравнение Основная конфигурация - Файл " & $ConfigProfDo)=0 Then
      Call("LineLogFile",$LogFile, "<<<!!!Ошибка, нет окна: " & "" & "Сравнение Основная конфигурация - Файл" & "")
      Exit
   EndIf
   Call("LineLogFile",$LogFile, "Получили окно: " & "" & "Сравнение Основная конфигурация - Файл" & "")
   Send("{TAB 6}{ENTER}{DOWN 4}{ENTER}")
   Call("LineLogFile",$LogFile, "Ожидаем окно: " & "" & "Отчет сравнения метаданных" & "")
   $hWnd1 = WinWait("Отчет сравнения метаданных")
   Call("LineLogFile",$LogFile, "Получили окно: " & "" & "Отчет сравнения метаданных" & "")

   If String(Call("CheckWindows",$hWnd1,20,40,300,55))="2889010289" Then
	  Call("LineLogFile",$LogFile, "Окно: " & "" & "Отчет сравнения метаданных" & "" & " прошло проверку на контрольную сумму")
	  Send("{TAB 7}")
	  Send($PatchReportProf)
	  Send("{TAB}{ENTER}")
   Else
	  Call("LineLogFile",$LogFile, "!!!***Ошибка. Окно: " & "" & "Отчет сравнения метаданных" & "" & " не прошло проверку на контрольную сумму")
	  Exit
   EndIf

   $hWnd2 = WinWait("[CLASS:V8Window]")

EndIf




FileClose($LogFile)


;---------------------------Func----------------------------------------------------------
;проверка окна по контрольной сумме
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
   ;для отладки
   ;ConsoleWrite($Left & '/' & $Top & '/' & $Right & '/' & $Bottom & @CRLF& _
   ;$checksum & @LF)

   Return $checksum
EndFunc


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