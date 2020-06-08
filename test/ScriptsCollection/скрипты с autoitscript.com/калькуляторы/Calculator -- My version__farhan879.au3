#cs ----------------------------------------------------------------------------
    
    Pogram  Version: 1.0
    
    Author:         Farhan
    
    Script Function: Calculates maths

    © Copyright 2008. All rights reserved.
#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <GUIConstants.au3>

#Region ### START Koda GUI section ### Form=f:\my documents\koda form designer\koda_1.7.0.1\forms\calc.kxf
$Form2 = GUICreate("Calculator", 210, 190, 303, 222)
$Result = GUICtrlCreateInput("", 8, 8, 193, 21)
$clear = GUICtrlCreateButton("Clear", 128, 40, 73, 25, 0)
$One = GUICtrlCreateButton("1", 8, 104, 35, 25, 0)
$Zero = GUICtrlCreateButton("0", 8, 136, 35, 25, 0)
$Point = GUICtrlCreateButton(".", 48, 136, 33, 25, 0)
$Equal = GUICtrlCreateButton("=", 88, 136, 115, 25, 0)
GUICtrlSetFont(-1, 14, 400, 0, "MS Sans Serif")
$Two = GUICtrlCreateButton("2", 48, 104, 33, 25, 0)
$Three = GUICtrlCreateButton("3", 88, 104, 33, 25, 0)
$Four = GUICtrlCreateButton("4", 8, 72, 35, 25, 0)
$Five = GUICtrlCreateButton("5", 48, 72, 35, 25, 0)
$Six = GUICtrlCreateButton("6", 88, 72, 35, 25, 0)
$Seven = GUICtrlCreateButton("7", 8, 40, 35, 25, 0)
$Eight = GUICtrlCreateButton("8", 48, 40, 35, 25, 0)
$Nine = GUICtrlCreateButton("9", 88, 40, 35, 25, 0)
$Times = GUICtrlCreateButton("x", 128, 72, 35, 25, 0)
$Plus = GUICtrlCreateButton("+", 128, 104, 33, 25, 0)
$Divide = GUICtrlCreateButton("/", 168, 72, 33, 25, 0)
$Minus = GUICtrlCreateButton("-", 168, 104, 33, 25, 0)
$Menu_file = GUICtrlCreateMenu("&File")
$Menu_about = GUICtrlCreateMenuItem("About", $Menu_file)
$Menu_exit = GUICtrlCreateMenuItem("Exit", $Menu_file)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


GUISetBkColor(0x494e48)


While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $Menu_about
            MsgBox(64, "About", "Product name:   Calculator" & @CRLF & "Author:              Farhan (farhan_879@hotmail.com" & @CRLF & "Version:             1.0" & @CRLF & "" & @CRLF & "© Copyright 2008. All rights reserved.")
        Case $Menu_exit
            Exit

        Case $One
            calc(1)

        Case $Two
            calc(2)

        Case $Three
            calc(3)

        Case $Four
            calc(4)

        Case $Five
            calc(5)

        Case $Six
            calc(6)

        Case $Seven
            calc(7)

        Case $Eight
            calc(8)

        Case $Nine
            calc(9)

        Case $Zero
            calc('nul')

        Case $Divide
            calc('/')

        Case $Times
            calc('x')

        Case $Equal
            calc('get')

        Case $Plus
            calc('+')

        Case $Minus
            calc('-')

        Case $Point
            calc('.')

        Case $clear
            GUICtrlSetData($Result, '')

    EndSwitch
WEnd
Func calc($num)
    If $num = 'get' Then
        get()
    Else
        If $num = 'nul' Then
            GUICtrlSetData($Result, GUICtrlRead($Result) & 0)
        Else
            GUICtrlSetData($Result, GUICtrlRead($Result) & $num)
        EndIf

    EndIf
EndFunc   ;==>calc

Func get()
    $p = Execute(StringReplace(GUICtrlRead($Result), 'x', '*'))
    If @error Then
        GUICtrlSetData($Result, 'Syntax ERROR')
    Else
        GUICtrlSetData($Result, $p)
    EndIf

EndFunc   ;==>get