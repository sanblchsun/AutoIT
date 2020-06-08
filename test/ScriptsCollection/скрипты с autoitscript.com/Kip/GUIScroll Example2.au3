#include <WindowsConstants.au3>
#include <GuiconstantsEx.au3>
#include <Timers.au3>

#include <Array.au3>


#Include "GUIScroll.au3"


$Caption = "Choice"
$ChoiceArray = StringSplit("Choice 1|Choice 2|Choice 3|Choice 4|Choice 5|Choice 6|Choice 7|Choice 8|Choice 9|Choice 10|Choice 11|Choice 12|Choice 13|Choice 14|Choice 15","|")
$GUIWidth = 150
$LabelWidth = 130
$GUIXPOS = -1
$GUIYPOS = -1
$LabelText = "Make your choice"
$SelectionType = 0
$MaxHeight = 250


$ReturnArray =_ChoiceBox($Caption, $ChoiceArray, $SelectionType, $LabelText, $GUIWidth, $LabelWidth, $GUIXPOS, $GUIYPOS, $MaxHeight)
_ArrayDisplay($ReturnArray, "Choice")


Func _ChoiceBox($Caption, $ChoiceArray, $SelectionType, $LabelText = "", $GUIWidth = 150, $LabelWidth = 130, $GUIXPOS = -1, $GUIYPOS = -1, $MaxHeight=250)
    Dim $SelectionArray[$ChoiceArray[0] + 1]
    Dim $YPOS = 10

    If $LabelText = "" Then
        $GUIHeight = ($ChoiceArray[0] * 20 + 40)
        If $GUIHeight > $MaxHeight Then $GUIHeight = $MaxHeight
        $GUI = GUICreate($Caption, $GUIWidth, $GUIHeight, $GUIXPOS, $GUIYPOS) 
    Else
        $GUIHeight = ($ChoiceArray[0] * 20 + 70)
        If $GUIHeight > $MaxHeight Then $GUIHeight = $MaxHeight + 70
        $GUI = GUICreate($Caption, $GUIWidth, $GUIHeight, $GUIXPOS, $GUIYPOS)
        GUICtrlCreateLabel($LabelText,10,10,$LabelWidth,20)
        Dim $YPOS = 30
    EndIf

    
    Scrollbar_Create($GUI, $SB_VERT, $GUIHeight + 100); But the actual window is 700 pixels high

    Scrollbar_Step(1, $GUI, $SB_VERT); Scrolls per 20 pixels. If not set the default is 1 (smooth scrolling)
    
    For $i = 1 To $ChoiceArray[0]
        Switch $SelectionType
            Case 0
                $SelectionArray[$i] = GUICtrlCreateCheckbox ($ChoiceArray[$i], 10, $YPOS, $LabelWidth, 20)
            Case 1
                $SelectionArray[$i] = GUICtrlCreateRadio    ($ChoiceArray[$i], 10, $YPOS, $LabelWidth, 20)
            Case Else

        EndSwitch
        $YPOS = $YPOS + 20
    Next

    $BtnOk = GUICtrlCreateButton("&OK", 5, $YPOS + 5, 80, 20)

    GUISetState()
        

    While 1
        $msg = GUIGetMsg()
        Switch $msg
            Case $GUI_EVENT_CLOSE
                Return 0

            Case $BtnOk
                Dim $Selected
                For $i = 1 To $ChoiceArray[0]
                    If GUICtrlRead($SelectionArray[$i]) = $GUI_CHECKED Then
                        $Selected = $Selected & GUICtrlRead($SelectionArray[$i], 1) & "|"
                    EndIf
                Next
                $Selected = StringTrimRight($Selected, 1)
                $Array = StringSplit($Selected, "|")
                Return StringSplit($Selected, "|")
        EndSwitch
    WEnd
EndFunc