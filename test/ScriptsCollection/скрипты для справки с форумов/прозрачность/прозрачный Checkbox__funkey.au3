#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <SendMessage.au3>
#include <SliderConstants.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
#include <StructureConstants.au3>

Global Const $tagNMCUSTOMDRAW = 'hwnd hWndFrom;uint_ptr IDFrom;int Code;dword DrawStage;hwnd hDC;' & $tagRECT & ';dword_ptr ItemSpec;uint ItemState;lparam ItemlParam'
Global Const $STM_GETIMAGE = 0x0173

Global $hGui = GUICreate("Test transparent checkbox replacement", 400, 200)
GUICtrlCreatePic(StringReplace(@AutoItExe, "AutoIt3.exe", "") & "Examples\GUI\msoobe.jpg", 0, 0, 400, 200, 0)
Global $hPic = GUICtrlGetHandle(-1)


GUICtrlCreateCheckbox("Standard checkbox", 10, 10, 200, 20)

GUICtrlCreateCheckbox("Standard checkbox transparent", 10, 50, 200, 20)
GUICtrlSetBkColor(-1, -2)

GUICtrlCreateCheckbox("Standard checkbox workaround", 10, 90, 13, 13)
GUICtrlCreateLabel("Standard checkbox workaround", 26, 90, 200, 13)
GUICtrlSetBkColor(-1, -2)


Global $hCB1 = _GuiCtrlCreateTransparentCheckbox("TransparentCheckbox 1", 10, 130)
Global $hCB2 = _GuiCtrlCreateTransparentCheckbox("TransparentCheckbox 2", 10, 170)

GUIRegisterMsg(0x004E, '_WM_NOTIFY')

GUISetState()

Do
Until GUIGetMsg() = -3

Func _GuiCtrlCreateTransparentCheckbox($text, $left, $top, $width = Default, $height = 13, $style = -1, $exStyle = 0)
GUICtrlCreateCheckbox($text, $left, $top, $width, $height, $style, $exStyle)
Return GUICtrlGetHandle(-1)
EndFunc   ;==>_GuiCtrlCreateTransparentCheckbox

Func _WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR

Local $tNMCD = DllStructCreate($tagNMCUSTOMDRAW, $lParam)
Local $hWndFrom = DllStructGetData($tNMCD, 'hWndFrom')
Local $Code = DllStructGetData($tNMCD, 'Code')
Local $DrawStage = DllStructGetData($tNMCD, 'DrawStage')
Local $ItemSpec = DllStructGetData($tNMCD, 'ItemSpec')
Local $hDC = DllStructGetData($tNMCD, 'hDC')
Local $hMemDC, $hBitmap, $hPrev
Local $aPos

Switch $hWndFrom
  Case $hCB1, $hCB2
   Switch $Code
    Case $NM_CUSTOMDRAW
     Switch $DrawStage
      Case $CDDS_PREPAINT, $CDDS_POSTPAINT
       $aPos = ControlGetPos($hWndFrom, '', '')
       Switch $DrawStage
        Case $CDDS_PREPAINT
;~          DllStructSetData($tNMCD, 'ItemState', BitXOR(DllStructGetData($tNMCD, 'ItemState'), $CDIS_FOCUS))
         $hMemDC = _WinAPI_CreateCompatibleDC($hDC)
         $hBitmap = _SendMessage($hPic, $STM_GETIMAGE, $IMAGE_BITMAP, 0)
         $hPrev = _WinAPI_SelectObject($hMemDC, $hBitmap)
         _WinAPI_BitBlt($hDC, 13, 0, $aPos[2], $aPos[3], $hMemDC, $aPos[0] + 13, $aPos[1], $SRCCOPY)
         _WinAPI_SelectObject($hMemDC, $hPrev)
         _WinAPI_DeleteDC($hMemDC)
         Return BitOR($CDRF_NOTIFYITEMDRAW, $CDRF_NOTIFYPOSTPAINT)
       EndSwitch
     EndSwitch
   EndSwitch
EndSwitch
Return $GUI_RUNDEFMSG
EndFunc   ;==>_WM_NOTIFY