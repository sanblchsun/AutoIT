#include <Constants.au3>
#include <GUIConstantsEx.au3>
#include <SendMessage.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>

Global Enum _
    $i_Start_Row = -1, _
        $i_hGUI_Row, $i_hPic_Row, $i_hCB_Row, _
    $i_Total_Rows
Global $aTrnsChckBxs_DATA[1][$i_Total_Rows]

$hGUI = GUICreate("Test transparent checkbox replacement", 400, 200)
$nPic = GUICtrlCreatePic(@AutoItExe & "\..\Examples\GUI\msoobe.jpg", 0, 0, 400, 200, 0)

GUICtrlCreateCheckbox("Standard checkbox", 10, 10, 200, 20)
GUICtrlCreateCheckbox("Standard checkbox transparent", 10, 50, 200, 20)
GUICtrlSetBkColor(-1, -2)
GUICtrlCreateCheckbox("Standard checkbox workaround", 10, 90, 13, 13)
GUICtrlCreateLabel("Standard checkbox workaround", 26, 90, 200, 13)
GUICtrlSetBkColor(-1, -2)

$nCB1 = _GUICtrlTransCheckbox_Create($hGUI, $nPic, "TransparentCheckbox 1", 10, 130)
$nCB2 = _GUICtrlTransCheckbox_Create($hGUI, $nPic, "TransparentCheckbox 2", 10, 170)

GUISetState(@SW_SHOW, $hGUI)

While 1
    $nGUIMsg = GUIGetMsg()
    
    Switch $nGUIMsg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $nCB1, $nCB2
            ConsoleWrite("CheckBox [" & GUICtrlRead($nGUIMsg, 1) & "] checked = " & (GUICtrlRead($nGUIMsg) = $GUI_CHECKED) & @LF)
    EndSwitch
WEnd

Func _GUICtrlTransCheckbox_Create($hGUI, $nBackPic, $sText, $iLeft, $iTop, $iWidth = -1, $iHeight = 13, $iStyle = -1, $iExStyle = 0)
    Local $nCB = GUICtrlCreateCheckbox($sText, $iLeft, $iTop, $iWidth, $iHeight, $iStyle, $iExStyle)
    Local $hCB = GUICtrlGetHandle($nCB)
    Local $hPic = GUICtrlGetHandle($nBackPic)
    
    If $aTrnsChckBxs_DATA[0][0] = 0 Then
        GUIRegisterMsg($WM_NOTIFY, '_TrnsChckBx_WM_NOTIFY')
    EndIf
    
    $aTrnsChckBxs_DATA[0][0] += 1
    ReDim $aTrnsChckBxs_DATA[$aTrnsChckBxs_DATA[0][0]+1][$i_Total_Rows]
    
    $aTrnsChckBxs_DATA[$aTrnsChckBxs_DATA[0][0]][$i_hGUI_Row] = $hGUI
    $aTrnsChckBxs_DATA[$aTrnsChckBxs_DATA[0][0]][$i_hPic_Row] = $hPic
    $aTrnsChckBxs_DATA[$aTrnsChckBxs_DATA[0][0]][$i_hCB_Row] = $hCB
    
    Return $nCB
EndFunc

Func _GUICtrlTransCheckbox_Delete($nChckBx)
    Local $hCB = GUICtrlGetHandle($nChckBx)
    Local $aTmp[$aTrnsChckBxs_DATA[0][0]][$i_Total_Rows]
    
    GUICtrlDelete($nChckBx)
    
    For $i = 1 To $aTrnsChckBxs_DATA[0][0]
        If $aTrnsChckBxs_DATA[$i][$i_hCB_Row] <> $hCB Then
            $aTmp[0][0] += 1
            
            $aTmp[$aTmp[0][0]][$i_hGUI_Row] = $aTrnsChckBxs_DATA[$i][$i_hGUI_Row]
            $aTmp[$aTmp[0][0]][$i_hPic_Row] = $aTrnsChckBxs_DATA[$i][$i_hPic_Row]
            $aTmp[$aTmp[0][0]][$i_hCB_Row] = $aTrnsChckBxs_DATA[$i][$i_hCB_Row]
        EndIf
    Next
    
    ReDim $aTmp[$aTmp[0][0]+1][$i_Total_Rows]
    $aTrnsChckBxs_DATA = $aTmp
    
    Return $aTmp[0][0]
EndFunc

Func _TrnsChckBx_WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
    Local $hWndFrom, $iIDFrom, $tNMHDR
    Local Const $tagNMCUSTOMDRAW = 'hwnd hWndFrom;uint_ptr IDFrom;int Code;dword DrawStage;hwnd hDC;' & $tagRECT & ';dword_ptr ItemSpec;uint ItemState;lparam ItemlParam'
    Local Const $STM_GETIMAGE = 0x0173
    
    Local $tNMCD = DllStructCreate($tagNMCUSTOMDRAW, $lParam)
    Local $hWndFrom = DllStructGetData($tNMCD, 'hWndFrom')
    Local $iCode = DllStructGetData($tNMCD, 'Code')
    Local $DrawStage = DllStructGetData($tNMCD, 'DrawStage')
    Local $ItemSpec = DllStructGetData($tNMCD, 'ItemSpec')
    Local $hDC = DllStructGetData($tNMCD, 'hDC')
    Local $hPic, $aPos, $hMemDC, $hBitmap, $hPrev
    
    For $i = 1 To $aTrnsChckBxs_DATA[0][0]
        If $hWndFrom = $aTrnsChckBxs_DATA[$i][$i_hCB_Row] Then
            Switch $iCode
                Case $NM_CUSTOMDRAW
                    Switch $DrawStage
                        Case $CDDS_PREPAINT, $CDDS_POSTPAINT
                            $hPic = $aTrnsChckBxs_DATA[$i][$i_hPic_Row]
                            $aPos = ControlGetPos($hWnd, '', $hWndFrom)
                            
                            If @error Then
                                ExitLoop
                            EndIf
                            
                            Switch $DrawStage
                                Case $CDDS_PREPAINT
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
            
            ExitLoop
        EndIf
    Next
    
    Return $GUI_RUNDEFMSG
EndFunc