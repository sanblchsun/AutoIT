; http://www.autoitscript.com/forum/topic/24342-form-snap/page__view__findpost__p__170144
#include <GUIConstants.au3>

Global Const $SPI_GETWORKAREA = 0x30

Global $nGap = 15
Global $k=0

$Gui = GUICreate("Snapped window", 370, 330, -1, -1, 0x00040000+0x00020000)
$condition = GUICtrlCreateLabel('', 5, 5, 360, 330)
GUISetState()
GUIRegisterMsg(0x0046, "WM_WINDOWPOSCHANGING")

While 1
    $GUIMsg = GUIGetMsg()
    
    Switch $GUIMsg
        Case $GUI_EVENT_CLOSE
            ExitLoop
    EndSwitch
WEnd

Func WM_WINDOWPOSCHANGING($hWnd, $Msg, $wParam, $lParam)
    Local $stRect = DllStructCreate("int;int;int;int")
    Local $stWinPos = DllStructCreate("uint;uint;int;int;int;int;uint", $lParam)
    DllCall("User32.dll", "int", "SystemParametersInfo", "int", $SPI_GETWORKAREA, "int", 0, "ptr", DllStructGetPtr($stRect), "int", 0)
    Local $nLeft   = DllStructGetData($stRect, 1)
    Local $nTop = DllStructGetData($stRect, 2)
    Local $nRight  = DllStructGetData($stRect, 3) - DllStructGetData($stWinPos, 5)
    Local $nBottom = DllStructGetData($stRect, 4) - DllStructGetData($stWinPos, 6)
    If Abs($nLeft - DllStructGetData($stWinPos, 3)) <= $nGap Then DllStructSetData($stWinPos, 3, $nLeft)
    If Abs($nTop - DllStructGetData($stWinPos, 4)) <= $nGap Then DllStructSetData($stWinPos, 4, $nTop)
    If Abs($nRight - DllStructGetData($stWinPos, 3)) <= $nGap Then DllStructSetData($stWinPos, 3, $nRight)
    If Abs($nBottom - DllStructGetData($stWinPos, 4)) <= $nGap Then DllStructSetData($stWinPos, 4, $nBottom)
	
	$k+=1
	GUICtrlSetData($condition,'Вызов ' &$k& ' раз'&@CRLF& 'Left='&$nLeft&@CRLF&'Top='&$nTop&@CRLF&@CRLF&'--Разница между размером экрана и размером окна--'&@CRLF& 'nRight='&$nRight&@CRLF&'nBottom='&$nBottom&@CRLF&@CRLF&'--Координаты окна--'&@CRLF& 'stWinPos3='&DllStructGetData($stWinPos, 3)&@CRLF&'stWinPos4='&DllStructGetData($stWinPos, 4)&@CRLF&@CRLF&'--Размеры окна--'&@CRLF& 'stWinPos5='&DllStructGetData($stWinPos, 5)&@CRLF&'stWinPos6='&DllStructGetData($stWinPos, 6)&@CRLF&@CRLF&'--Размеры экрана (без ширины панели задач)--'&@CRLF& 'stRect3='&DllStructGetData($stRect, 3)&@CRLF&'stRect4='&DllStructGetData($stRect, 4))
    Return 0
EndFunc