Global $Timer=TimerInit(), $pid
AdlibRegister('_Timer', 1000)
GUICreate("My Program", 250, 94, -1, @DesktopHeight/2-210)
$Button1=GUICtrlCreateButton('Старт дочернего скрипта', 10, 10, 230, 22)
$Button2=GUICtrlCreateButton('Принудительно закрыть дочерний скрипт', 10, 40, 230, 22)
$StatusBar=GUICtrlCreateLabel('', 10, 70, 230, 22)
GUISetState ()
While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = $Button1
	   MsgBox(0, 'Сообщение', 'Обычное сообщение приостанавливает выполнение скрипта,'&@CRLF&'обновление таймера в строке состояния не выполняется')
           _subsidiary()
       Case $msg = $Button2
		If ProcessExists($pid) Then
			ProcessClose($pid)
		Else
			MsgBox(0, 'Сообщение', 'Отсутствует процесс')
		EndIf
	   Case $msg = -3
           Exit
   EndSelect
WEnd

Func _subsidiary()
Local $name, $i = 0
Do
    $i+=1
	$name=@TempDir&'\d8r0m4d'&$i&'z'&Random(1,1000,1)&'.au3'
Until Not FileExists($name)
	Local $file = FileOpen($name,2)
	FileWrite($file, 'MsgBox(0, "Сообщение", "Дочерний скрипт запущен")' )
	FileClose($file)
	$pid=Run(@AutoItExe&' /AutoIt3ExecuteScript "'&$name&'"', '', @SW_HIDE)
EndFunc

Func _Timer()
	GUICtrlSetData($StatusBar,Ceiling(TimerDiff($Timer)/1000))
EndFunc