#include <Array.au3>
#include <EditConstants.au3>
#include <File.au3>
#include <GUIConstantsEx.au3>
#Include <GuiListView.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

Opt('GUIResizeMode', 802) ; control will not move during resizing

Global Const $WIDTH = 200, $HEIGHT = 300, $B = 10 ; border between objects
Global Const $EXTRA_HEIGHT = 150 ; height added in expanded view

Global $chordData[20][3] = [['A', '1.2|1.3|1.4', 'xo|||o'], ['A7', '1.2|1.4', 'xo|o|o'], ['Am', '1.2|1.3|0.4', 'xo|||o'], _
    ['Asus2', '1.2|1.3', 'xo||oo'], ['Asus4', '1.2|1.3|2.4', 'xo|||o'], ['B7', '1.1|0.2|1.3|1.5', 'x|||o|'], _
    ['C', '2.1|1.2|0.4', 'x||o|o'], ['C7', '2.1|1.2|2.3|0.4', 'x||||o'], ['D', '1.3|2.4|1.5', 'xxo|||'], _
    ['D7', '1.3|0.4|1.5', 'xxo|||'], ['Dm', '1.3|2.4|0.5', 'xxo|||'], ['Dsus2', '1.3|2.4', 'xxo||o'], _
    ['Dsus4', '1.3|2.4|3.5', 'xxo|||'], ['E', '1.1|1.2|0.3', 'o||||oo'], ['E7', '1.1|0.3', 'o|o||oo'], _
    ['Em', '1.1|1.2', 'o||ooo'], ['Esus4', '1.1|1.2|1.3', 'o|||oo'], ['Fmaj7', '2.2|1.3|0.4', 'xx|||o'], _
    ['G', '2.0|1.1|2.5', '||ooo|'], ['G7', '2.0|1.1|0.5', '||ooo|']]

Global $listview = -1


Global $checkedList[UBound($chordData)]
    For $i = 0 to UBound($chordData) - 1
        $checkedList[$i] = 0
    Next
Global $currentIndex = -1

$gui = GUICreate('Chord Practice', $WIDTH + $B * 2, $HEIGHT + $B * 8)

$chordPic = '56]' ; not quite sure why I needed this, but using a random negative number messed everything up

Global $xOffset = 5
$chordName = GUICtrlCreateLabel('', $B * 2, $B * 2.5, $WIDTH - $B * 2, 32, $SS_CENTER)
    GUICtrlSetFont(-1, 20)
    GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
    GUICtrlSetFont(-1, 20, 500, -1, 'Tahoma')

Global $lblStrum[6]
For $i = 0 to UBound($lblStrum) - 1
    $lblStrum[$i] = GUICtrlCreateLabel('', 31 - $xOffset + 30 * $i, 53, 20, 18, BitOR($SS_CENTER, $SS_CENTERIMAGE))
        GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
        GUICtrlSetFont(-1, 16, 500, -1, 'Tahoma')
Next

$txtInterval = GUICtrlCreateInput('2', $B, $HEIGHT + $B * 2, 40, 20, $ES_NUMBER)
GUICtrlCreateUpdown($txtInterval)
GUICtrlCreateLabel('Interval (seconds)', $B + 45, $HEIGHT + $B * 2 +3, 90)

$startStop = GUICtrlCreateButton('Start', $WIDTH - 40, $HEIGHT + $B * 2, 50, 20)

$btnExpand = GUICtrlCreateButton('>>>', $B, $HEIGHT + $B * 5, $WIDTH, 20)
$expanded = False

GUIRegisterMsg($WM_NOTIFY, 'WM_NOTIFY')
GUISetState()

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
        Case $startStop
            If GUICtrlRead($startStop) = 'Start' then
                $int = GUICtrlRead($txtInterval)
                If $int < 1 then
                    $int = 1
                    GUICtrlSetData($txtInterval, $int)
                EndIf
                AdlibRegister('_ChangeChordPic', $int * 1000)
                GUICtrlSetData($startStop, 'Stop')
                GUICtrlSetState($txtInterval, $GUI_DISABLE)
                GUICtrlSetState($btnExpand, $GUI_DISABLE)
                _UpdateCheckedList()
                If $expanded then _Contract()
                _ChangeChordPic()
            Else
                AdlibUnRegister('_ChangeChordPic')
                GUICtrlSetData($startStop, 'Start')
                GUICtrlSetState($txtInterval, $GUI_ENABLE)
                GUICtrlSetState($btnExpand, $GUI_ENABLE)
            EndIf
        Case $btnExpand
            If $expanded then
                _Contract()
            Else
                _Expand()
            EndIf
    EndSwitch
WEnd

Func _ChangeChordPic()
    Local $index = -1
    Do
        $index = Random(0, UBound($chordData) - 1, 1)
    Until $index <> $currentIndex and $checkedList[$index] = 1
    $currentIndex = $index

    _SetChord()
EndFunc

Func _UpdateCheckedList()
    For $i = 0 to _GUICtrlListView_GetItemCount($listview) - 1
        If _GUICtrlListView_GetItemChecked($listview, $i) then
            $checkedList[$i] = 1
        Else
            $checkedList[$i] = 0
        EndIf
    Next
EndFunc


Func _Contract()
    GUICtrlSetState($listview, $GUI_HIDE)

    $pos = WinGetPos($gui)
    WinMove($gui, '', $pos[0], $pos[1], $pos[2], $pos[3] - $EXTRA_HEIGHT)

    GUICtrlSetPos($btnExpand, $B, $HEIGHT + $B * 5, $WIDTH, 20)

    $expanded = False
    GUICtrlSetData($btnExpand, '>>>')
EndFunc


Func _Expand()
    $pos = WinGetPos($gui)
    WinMove($gui, '', $pos[0], $pos[1], $pos[2], $pos[3] + $EXTRA_HEIGHT)

    If $listview <> -1 then
        GUICtrlSetState($listview, $GUI_SHOW)
    Else
        $listview = GUICtrlCreateListView('Chord', $B, $HEIGHT + $B * 5, $WIDTH, $EXTRA_HEIGHT)
        _GUICtrlListView_SetExtendedListViewStyle($listview, BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_CHECKBOXES, $LVS_EX_GRIDLINES))
        _GUICtrlListView_SetColumnWidth($listview, 0, $WIDTH - 30)

        For $i = 0 to UBound($chordData) - 1
            _GUICtrlListView_AddItem($listview, $chordData[$i][0])
            If $checkedList[$i] = 1 then
                _GUICtrlListView_SetItemChecked($listview, $i, True)
            EndIf
        Next
    EndIf

    GUICtrlSetPos($btnExpand, $B, $HEIGHT + $B * 5 + $EXTRA_HEIGHT + 5, $WIDTH, 20)

    $expanded = True
    GUICtrlSetData($btnExpand, '<<<')
EndFunc

Func _SetChord()
    GUICtrlDelete($chordPic)

    $chordPic = GUICtrlCreateGraphic($B, $B, $WIDTH, $HEIGHT)
        GUICtrlSetBkColor(-1, 0xFFFFFF)
        GUICtrlSetColor(-1, 0)

    GUICtrlSetData($chordName, $chordData[$currentIndex][0])

    $strum = StringSplit($chordData[$currentIndex][2], '')
    For $i = 0 to UBound($lblStrum) - 1
        If $strum[$i + 1] = '|' then $strum[$i + 1] = ''
        GUICtrlSetData($lblStrum[$i], $strum[$i + 1])
    Next

    For $i = 1 to 6
        GUICtrlSetGraphic($chordPic, $GUI_GR_RECT, $i * 30 - $xOffset, 65, 2, 184)
    Next
    GUICtrlSetGraphic($chordPic, $GUI_GR_RECT, 30 - $xOffset, 65, 150, 2)
    For $i = 0 to 5
        GUICtrlSetGraphic($chordPic, $GUI_GR_RECT, 30 - $xOffset, 72 + $i * 35, 150, 2)
    Next

    ; open E string would be 0.0... open A string would be 0.1..
    $pos = StringSplit($chordData[$currentIndex][1], '|')
    GUICtrlSetGraphic($chordPic, $GUI_GR_COLOR, 0, 0)
    For $i = 0 to UBound($pos) - 2
        $stringSplit = StringSplit($pos[$i + 1], '.')
        GUICtrlSetGraphic($chordPic, $GUI_GR_ELLIPSE, ($stringSplit[2] + 1) * 30 - 15, ($stringSplit[1]) * 35 + 63 + 35/2, 22, 22)
    Next
    GUICtrlSetGraphic($chordPic, $GUI_GR_REFRESH)
EndFunc

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    #forceref $hWnd, $iMsg, $iwParam
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView, $tInfo

    $hWndListView = $listview
    If Not IsHWnd($listview) Then $hWndListView = GUICtrlGetHandle($listview)

    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    Switch $hWndFrom
        Case $hWndListView
            Switch $iCode
                Case $NM_CLICK ; Sent by a list-view control when the user clicks an item with the left mouse button
                    $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
                    $currentIndex = DllStructGetData($tInfo, 'SubItem')
                    _SetChord()
                    ; No return value
                Case $NM_DBLCLK ; Sent by a list-view control when the user double-clicks an item with the left mouse button
                    $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
                    $index = DllStructGetData($tInfo, 'SubItem')
                    If _GUICtrlListView_GetItemChecked($listview, $index) then
                        _GUICtrlListView_SetItemChecked($listview, $index, False)
                    Else
                        _GUICtrlListView_SetItemChecked($listview, $index)
                    EndIf
                    ; No return value
;~              Case $NM_RCLICK ; Sent by a list-view control when the user clicks an item with the right mouse button
;~                  $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)

;~                  ;Return 1 ; not to allow the default processing
;~                  Return 0 ; allow the default processing
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
 