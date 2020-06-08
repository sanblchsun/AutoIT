Global $iPaused = True

HotKeySet("^+p", "_PauseToggle")
HotKeySet("{ESC}", "_Quit")

_PauseToggle()

$iDemo_Count = 0

While 1
    Sleep(1000)

    $iDemo_Count += 1
    ConsoleWrite(", " & $iDemo_Count)
WEnd

Func _PauseToggle()
    $iPaused = Not $iPaused

    If $iPaused Then
        ConsoleWrite(", Ждёмс... ")
    Else
        ConsoleWrite("Поехали... ")
    EndIf

    While $iPaused
        Sleep(10)
    WEnd
EndFunc

Func _Quit()
    Exit
EndFunc