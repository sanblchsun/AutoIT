#Include <GuiConstantsEx.au3>
#Include <GuiListView.au3>
#include <WindowsConstants.au3>
 
;fonts for custom draw example
;bold
Global $aFont1 = DLLCall("gdi32.dll","int","CreateFont", "int", 14, "int", 0, "int", 0, "int", 0, "int", 700, _
                        "dword", 0, "dword", 0, "dword", 0, "dword", 0, "dword", 0, "dword", 0, "dword", 0, _
                        "dword", 0, "str", "")
;italic
Global $aFont2 = DLLCall("gdi32.dll","int","CreateFont", "int", 14, "int", 0, "int", 0, "int", 0, "int", 400, _
                        "dword", 1, "dword", 0, "dword", 0, "dword", 0, "dword", 0, "dword", 0, "dword", 0, _
                        "dword", 0, "str", "")
 
$GUI = GUICreate("Listview Custom Draw", 400, 300)
$cListView = GUICtrlCreateListView("", 2, 2, 394, 268)
$hListView = GUICtrlGetHandle($cListView)
;or
;~ $hListView = _GUICtrlListView_Create($GUI, "", 2, 2, 394, 268)
 
_GUICtrlListView_SetExtendedListViewStyle($hListView, BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT))
_GUICtrlListView_InsertColumn($hListView, 0, "Column 1", 100)
_GUICtrlListView_InsertColumn($hListView, 1, "Column 2", 100)
_GUICtrlListView_InsertColumn($hListView, 2, "Column 3", 100)
 
; Add items
For $i = 1 To 30
    _GUICtrlListView_AddItem($hListView, "Row" & $i & ": Col 1", $i-1)
    For $j = 1 To 2
        _GUICtrlListView_AddSubItem ($hListView, $i-1, "Row" & $i & ": Col " & $j+1, $j)
    Next
Next
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
GUISetState()
 
Do
Until GUIGetMsg() = $GUI_EVENT_CLOSE
DLLCall("gdi32.dll","int","DeleteObject", "hwnd", $aFont1[0])
DLLCall("gdi32.dll","int","DeleteObject", "hwnd", $aFont2[0])
Exit
 
Func WM_NOTIFY($hWnd, $Msg, $wParam, $lParam)
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR
 
    $tNMHDR = DllStructCreate($tagNMHDR, $lParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    Switch $hWndFrom
        Case $hListView
            Switch $iCode
                Case $NM_CUSTOMDRAW
                    If Not _GUICtrlListView_GetViewDetails($hWndFrom) Then Return $GUI_RUNDEFMSG
                     Local $tCustDraw = DllStructCreate('hwnd hwndFrom;int idFrom;int code;' & _
                                        'dword DrawStage;hwnd hdc;long rect[4];dword ItemSpec;int ItemState;dword Itemlparam;' & _
                                        'dword clrText;dword clrTextBk;int SubItem;' & _
                                        'dword ItemType;dword clrFace;int IconEffect;int IconPhase;int PartID;int StateID;long rectText[4];int Align', _ ;winxp or later
                                        $lParam), $iDrawStage, $iItem, $iSubitem, $hDC, $iColor1, $iColor2, $iColor3
                    $iDrawStage = DllStructGetData($tCustDraw, 'DrawStage')
                    If $iDrawStage = $CDDS_PREPAINT Then Return $CDRF_NOTIFYITEMDRAW ;request custom drawing of items
                    If $iDrawStage = $CDDS_ITEMPREPAINT Then Return $CDRF_NOTIFYSUBITEMDRAW ;request drawing each cell separately
                    If Not BitAND($iDrawStage, $CDDS_SUBITEM) Then Return $CDRF_DODEFAULT
                    $iItem = DllStructGetData($tCustDraw, 'ItemSpec')
                    $iSubitem = DllStructGetData($tCustDraw, 'SubItem')
                    Switch $iItem
                        Case 0 To 9 ;for rows 1-10 lets do this
                            $iColor1 = RGB2BGR(0xFBFFD8)
                            $iColor2 = RGB2BGR(-1)
                            $iColor3 = RGB2BGR(0xFF0000)
                            If Mod($iSubitem, 2) Then ;odd columns
                                DllStructSetData($tCustDraw, 'clrTextBk', $iColor1)
                                DllStructSetData($tCustDraw, 'clrText', 0)
                            Else ;even columns
                                DllStructSetData($tCustDraw, 'clrTextBk', $iColor2)
                                DllStructSetData($tCustDraw, 'clrText', $iColor3)
                            EndIf
                        Case 10 To 19 ;for rows 11-20 lets do this
                            $iColor1 = RGB2BGR(0xFBFFD8)
                            $iColor2 = RGB2BGR(0x3DF8FF)
                            $hDC = DllStructGetData($tCustDraw, 'hdc')
                            If Mod($iItem, 2) Then
                                If Mod($iSubitem, 2) Then
                                    DllStructSetData($tCustDraw, 'clrTextBk', $iColor1)
                                Else
                                    DllStructSetData($tCustDraw, 'clrTextBk', $iColor2)
                                EndIf
                                DLLCall("gdi32.dll","hwnd","SelectObject", "hwnd", $hDC, "hwnd", $aFont1[0]) ;select our chosen font into DC
                            Else
                                If Mod($iSubitem, 2) Then
                                    DllStructSetData($tCustDraw, 'clrTextBk', $iColor2)
                                Else
                                    DllStructSetData($tCustDraw, 'clrTextBk', $iColor1)
                                EndIf
                                DLLCall("gdi32.dll","hwnd","SelectObject", "hwnd", $hDC, "hwnd", $aFont2[0])
                            EndIf
                        Case 20 To 29 ;for rows 21-30 lets do this
                            $iColor1 = RGB2BGR(0xFBFFD8)
                            $iColor2 = RGB2BGR(-1)
                            If Mod($iItem, 2) Then ;odd rows
                                DllStructSetData($tCustDraw, 'clrTextBk', $iColor2)
                            Else
                                DllStructSetData($tCustDraw, 'clrTextBk', $iColor1)
                            EndIf                     
                    EndSwitch
                    Return $CDRF_NEWFONT
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
 
Func RGB2BGR($iColor)
    Return BitAND(BitShift(String(Binary($iColor)), 8), 0xFFFFFF)
EndFunc