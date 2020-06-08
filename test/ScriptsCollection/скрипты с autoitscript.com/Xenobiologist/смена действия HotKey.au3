; http://www.autoitscript.com/forum/index.php?showtopic=25688&st=0&p=180881&hl=HotKey&fromsearch=1&#entry180881
HotKeySet("a", "pressed")
Dim $i = 0, $PushTime = 1000

While 1
    Sleep(100)
WEnd

Func pressed()
    $i += 1
    Sleep($PushTime)
    Switch $i
        Case 1
            put(1)
        Case 2
            put(2)
        Case 3
            put(3)
        Case 4
            Exit (0)
    EndSwitch
    $i = 0
EndFunc   ;==>pressed

Func put($y)
    MsgBox(0, "Func called: ", "Nr: " & $y)
EndFunc   ;==>put