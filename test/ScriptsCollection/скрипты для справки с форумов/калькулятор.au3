#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <StaticConstants.au3>

Global $aButtons_Arr[11]
Global $aOperations_Arr[1]

$Left = 60
$Top = 140

$Gui = GUICreate("Calculator - Demo", 240, 290)

$CTRL_Edit = GUICtrlCreateEdit(0, 8, 2, 220, 23, BitOR($ES_READONLY, $ES_RIGHT), $WS_EX_STATICEDGE)

GUICtrlCreateGroup("Operations", 10, 25, 220, 90)

$Plus_Button = GUICtrlCreateButton("+", 20, 40, 25, 20)
$Minus_Button = GUICtrlCreateButton("-", 50, 40, 25, 20)
$Devide_Button = GUICtrlCreateButton("/", 80, 40, 25, 20)
$Multiply_Button = GUICtrlCreateButton("*", 110, 40, 25, 20)

GuiCtrlCreateSeperator(1, 142, 40, 3, 20)

$Pi_Button = GUICtrlCreateButton("Pi", 150, 40, 30, 20)
$Sqrt_Button = GUICtrlCreateButton("Sqrt", 190, 40, 30, 20)

GuiCtrlCreateSeperator(0, 18, 70, 3, 205)

$Equel_Button = GUICtrlCreateButton("=", 20, 80, 60, 25)
$CE_Button = GUICtrlCreateButton("CE", 150, 80, 70, 25)

GUICtrlCreateGroup("Digits", 10, 125, 220, 150)

For $i = 1 To 9
    If $Left >= 180 Then
        $Left = 60
        $Top += 32
    EndIf

    $aButtons_Arr[$i] = GUICtrlCreateButton($i, $Left, $Top, 36, 29)
    $Left += 40
Next

;Забыл нолик :D
$aButtons_Arr[10] = GUICtrlCreateButton("0", 60, 240, 115, 29)

GUISetState()

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case - 3
            Exit
        Case $aButtons_Arr[1] To $aButtons_Arr[10]
            Local $iUbound = UBound($aOperations_Arr)

            If $iUbound > 1 And StringIsDigit($aOperations_Arr[$iUbound - 1]) Then
                $aOperations_Arr[$iUbound - 1] &= GUICtrlRead($nMsg, 1)
                $iUbound -= 1
            Else
                ReDim $aOperations_Arr[$iUbound + 1]
                $aOperations_Arr[$iUbound] = GUICtrlRead($nMsg, 1)
            EndIf

            GUICtrlSetData($CTRL_Edit, $aOperations_Arr[$iUbound])
        Case $Plus_Button To $Multiply_Button
            Local $iUbound = UBound($aOperations_Arr)

            If $iUbound <= 1 Or $aOperations_Arr[$iUbound - 1] = GUICtrlRead($nMsg, 1) Then ContinueLoop

            ReDim $aOperations_Arr[$iUbound + 1]
            $aOperations_Arr[$iUbound] = GUICtrlRead($nMsg, 1)
        Case $Equel_Button
            Local $Operations_Str = ""

            For $i = 1 To UBound($aOperations_Arr) - 1
                $Operations_Str &= $aOperations_Arr[$i]
            Next

            ClearOperations()

            $sResults = Execute($Operations_Str)
            If $sResults = "" Then $sResults = 0

            GUICtrlSetData($CTRL_Edit, $sResults)
        Case $Pi_Button
            ClearOperations()
            GUICtrlSetData($CTRL_Edit, Pi_Calculate())
        Case $Sqrt_Button
            Local $ReadEdit = GUICtrlRead($CTRL_Edit)
            If $ReadEdit <= 0 Then ContinueLoop

            ClearOperations()
            GUICtrlSetData($CTRL_Edit, Sqrt($ReadEdit))
        Case $CE_Button
            ClearOperations()
            GUICtrlSetData($CTRL_Edit, "0")
    EndSwitch
WEnd

Func ClearOperations()
    $aOperations_Arr = ""
    Dim $aOperations_Arr[1]
EndFunc

Func Pi_Calculate($iRound = 100000)
    Local $n = 0
    For $i = 1 To $iRound
        $n += 1 / ($i * $i)
    Next
    Return Sqrt($n * 6)
EndFunc

Func GuiCtrlCreateSeperator($Direction, $Left, $Top, $Width = 3, $Lenght = 25)
    Switch $Direction
        Case 0
            GUICtrlCreateLabel("", $Left, $Top, $Lenght, $Width, $SS_SUNKEN)
        Case 1
            GUICtrlCreateLabel("", $Left, $Top, $Width, $Lenght, $SS_SUNKEN)
    EndSwitch
EndFunc