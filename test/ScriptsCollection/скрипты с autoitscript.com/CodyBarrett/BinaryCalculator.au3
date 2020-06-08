#include <WindowsConstants.au3>
#include <StaticConstants.au3>
Opt ('GUIONEVENTMODE',1)
$dec = 1
$status = ''

;---------------------------------------------------------------
;this loop to determine how big of a binary digit you want to use.
Do
    $status = MsgBox (3,'Welcome','What size of Binary Digit would you like?' & @CRLF & 'Current Size: ' & $dec)
    If $status  = 7 Then
        $dec = $dec*2
    ElseIf $status = 2 Then
        Exit
    EndIf
Until $status = 6
$bit = $dec
;---------------------------------------------------------------


Dim $binary_ID_grid[1][$bit] ;Make the first Element anything you want for mulitple rows of binary digits.
Dim $value_ID_grid[UBound ($binary_ID_grid,1)] ;holds the GUICtrlID for the Value of each Row of binary digits.

$size = 50 ;this is the size of each side of each label

$main_hwnd = GUICreate ('BinaryCalculator',$size*($bit+2),$size*UBound ($binary_ID_grid,1)+$size)
GUISetFont (10,999,'','Tahoma')
GUICtrlSetDefBkColor (0x0)
GUICtrlSetDefColor (0xFF0000)
GUISetOnEvent (-3,'QUIT')


;---------------------------------------------------------------
;This loop makes the top values for each column of binary bits.
For $l = ($bit-1) To 0 Step -1
    $GUICTRL_ID = GUICtrlCreateLabel (2^$l,(($bit-1)-$l)*$size,0,$size,$size,BitOR ($SS_CENTER,$SS_CENTERIMAGE,$WS_BORDER))
    GUICtrlSetBkColor ($GUICTRL_ID,0xFFFFFF)
Next
;---------------------------------------------------------------

$GUICTRL_ID = GUICtrlCreateLabel ('Value',$bit*$size,0,$size*2,$size,BitOR ($SS_CENTER,$SS_CENTERIMAGE,$WS_BORDER))
    GUICtrlSetBkColor ($GUICTRL_ID,0xFFFFFF)


;---------------------------------------------------------------
;Actually makes a label for each bit in each row of each binary digit
For $t = 0 To UBound ($binary_ID_grid,1)-1
    $top = (($t*$size)+$size)
    For $l = 0 To ($bit-1)
        $left = ($l*$size)
        $binary_ID_grid[$t][$l] = GUICtrlCreateLabel ('0',$left,$top,$size,$size,BitOR ($SS_CENTER,$SS_CENTERIMAGE,$WS_BORDER))
        GUICtrlSetOnEvent ($binary_ID_grid[$t][$l],'Clicked')
        GUICtrlSetCursor ($binary_ID_grid[$t][$l],0)
    Next
    $GUICTRL_ID = GUICtrlCreateLabel ('=',$bit*$size,$top,$size,$size,BitOR ($SS_CENTER,$SS_CENTERIMAGE,$WS_BORDER))
        GUICtrlSetBkColor ($GUICTRL_ID,0xFF0000)
        GUICtrlSetColor ($GUICTRL_ID,0xFFFFFF)
    $value_ID_grid[$t] = GUICtrlCreateLabel ('0',($bit+1)*$size,$top,$size,$size,BitOR ($SS_CENTER,$SS_CENTERIMAGE,$WS_BORDER))
        GUICtrlSetBkColor ($value_ID_grid[$t],0xFFFFFF)
Next
;---------------------------------------------------------------


GUISetState ()


;---------------------------------------------------------------
While 1
    For $t = 0 To (UBound ($binary_ID_grid,1)-1)
        $value = Int (GUICtrlRead ($value_ID_grid[$t]))
        $string = ''
        For $l = 0 To ($bit-1)
            $string &= GUICtrlRead ($binary_ID_grid[$t][$l])
        Next
        If BinToDec ($string) <> $value Then GUICtrlSetData ($value_ID_grid[$t], BinToDec ($string))
    Next
    Sleep (100)
WEnd
;---------------------------------------------------------------


;---------------------------------------------------------------
Func Clicked ()
    If GUICtrlRead (@GUI_CtrlId) == '1' Then
        GUICtrlSetData (@GUI_CtrlId,'0')
    Else
        GUICtrlSetData (@GUI_CtrlId,'1')
    EndIf
EndFunc
;---------------------------------------------------------------

;---------------------------------------------------------------
;This function calculates (oldschool) the decimal of the binary digit specified in the main loop.
Func BinToDec ($bin)
    Local $dec = 0, $n
    For $n = ($bit-1) To 0 Step -1
        If StringMid ($bin,($bit-$n),1) = '1' Then $dec += (2^$n)
    Next
    Return $dec
EndFunc
;---------------------------------------------------------------

;---------------------------------------------------------------
Func QUIT ()
    Exit
EndFunc
;---------------------------------------------------------------