HotKeySet("^i", "Input") 
Opt("TrayMenuMode", 1) 
 
Global $OptionsArray[4] 
Global $DefaultNumber = 1 
 
$ChooseOption = TrayCreateItem("Указать количество пунктов в меню...") 
 
For $i = 1 To UBound($OptionsArray)-1 
    $OptionsArray[$i] = TrayCreateItem("Пункт " & $i) 
Next 
 
$Seperator = TrayCreateItem("") 
$ExitItem = TrayCreateItem("Exit") 
 
While 1 
    $TrayMsg = TrayGetMsg() 
 
        Switch $TrayMsg 
        Case $ExitItem 
            Exit 
        Case $ChooseOption 
            Input() 
    EndSwitch 
WEnd 
 
Func Input() 
    $Ubound = UBound($OptionsArray) ;Общее число пунктов + 1 (чтобы не считать каждый раз) 
 
        While 1 
        $Var = InputBox("", "Напишите необходимое количество", $DefaultNumber) 
        If @error Then Return ;Если нажата "Отмена" то выходим из функции 
        $Var = StringRegExpReplace($Var, '[^0-9]', '') 
 
                ;Проверяем ввёл ли юзер лигитимное число 
        If $Var = '' Then 
            MsgBox(48, "Внимание!", "Введено не верное число (или вовсе не число)" & @LF & "Введите ещё раз..", 5) 
            ContinueLoop 
        EndIf 
        ExitLoop 
    WEnd 
 
        ;Если юзер ввёл одинаковое число что и пунктов меню, то ничего не делаем 
    If $Var = $Ubound-1 Then Return 
 
        ;Если введено больше пунктов, то просто добавляем... 
    If $Var > $Ubound-1 Then 
        ReDim $OptionsArray[$Var+1] 
        For $i = $Ubound To $Var 
            $OptionsArray[$i] = TrayCreateItem("Пункт " & $i, -1, $i) 
        Next 
    Else ;если меньше, то удаляем лишние 
        For $i = $Var+1 To $Ubound-1 
            TrayItemDelete($OptionsArray[$i]) 
        Next 
        ReDim $OptionsArray[$Var+1] 
    EndIf 
 
        $DefaultNumber = $Var ;Чтобы запоминалось последнее введённое число 
EndFunc