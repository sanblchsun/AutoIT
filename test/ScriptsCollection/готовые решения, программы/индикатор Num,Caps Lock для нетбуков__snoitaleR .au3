; НАЧАЛО

; Всплывающая подсказка

 TraySetToolTip("Индикатор режимов клавиатуры")

; Проверка текущего состояния NumLock и CapsLock

 FCAPSLOCK()
 FNUMLOCK()

; Регистрация комбинаций клавиш

 HotKeySet("{NUMLOCK}","FNUMLOCK")
 HotKeySet("{CAPSLOCK}","FCAPSLOCK")

; Бесконечный цикл MessageLoop

 While Sleep(100)
 WEnd

; Функция, следящая за режимом NumLock

 Func FNUMLOCK()

  $STATE=DllCall('user32.dll','int','GetKeyState','int',0x90)

  If BitAND($STATE[0],1)=0 Then
   TraySetState(8)
  Else
   TraySetState(4)
  EndIf

 EndFunc

; Функция, следящая за режимом CapsLock

 Func FCAPSLOCK()

  DllCall('user32.dll','int','keybd_event','int',0x14,'int',0,'int',0x02,'ptr',0)
  $STATE=DllCall('user32.dll','int','GetKeyState','int',0x14)

  If BitAND($STATE[0],1)=0 Then
   $Icon=75
  Else
   $Icon=73
  EndIf
 
  TraySetIcon("shell32.dll",-($Icon+($Icon>-1)))

 EndFunc

; КОНЕЦ
 