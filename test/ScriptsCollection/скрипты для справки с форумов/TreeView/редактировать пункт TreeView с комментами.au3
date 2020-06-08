#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiTreeView.au3>
#include <Constants.au3>
#include <GUIScrollBars.au3>
#include <ScrollBarConstants.au3>


;;Main scripting from Sandin
;;http://www.autoitscript.com/forum/index.php?showtopic=85846

DIM $TVN_BEGINDRAG
DIM $TVN_BEGINLABELEDIT
DIM $TVN_ENDLABELEDIT
DIM $vAutoSbDnEnd ;for vertical autoscroll - defined under begindrag
DIM $vAutoSbUpEnd ;for vertical autoscroll - defined under begindrag
DIM $vAutoSbValue = 1

Opt("PixelCoordMode", 2)
Global $Startx, $Starty, $Endx, $Endy, $aM_Mask, $aMask, $nc
Global Const $VK_F2 = 0x71
Global Const $VK_ESC = 0x1B
Global $just_edited = False, $fDragging = False, $hDragItem, $fWhere, $moving_txt, $item_above_drag, $item_below_drag
Opt("GUICloseOnESC", 0)
Global $iEditFlag = 0
$hGUI = GUICreate("Test GUI", 300, 200)
GUICtrlCreateLabel("F2 - Edit text, Enter - Set text, ESC - Cancel edit", 16, 10, 250, 16)

DIM $tvTop=40, $tvHt=140
$hTreeView = _GUICtrlTreeView_Create($hGUI, 10, $tvtop, 280, $tvHt, _
BitOR($TVS_EDITLABELS, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVIS_DROPHILITED, $TVS_SHOWSELALWAYS, $WS_TABSTOP), $WS_EX_CLIENTEDGE)

For $i = 1 To 5
    $hItem = _GUICtrlTreeView_Add($hTreeView, $i, "Item" & $i)
    For $j = 1 To 5
        _GUICtrlTreeView_AddChild($hTreeView, $hItem, "SubItem" & $i&"."&$j)
    Next
Next
GUISetState(@SW_SHOW, $hGUI)

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
$wProcHandle = DllCallbackRegister("_WindowProc", "int", "hwnd;uint;wparam;lparam")
$wProcOld = _WinAPI_SetWindowLong($hTreeView, $GWL_WNDPROC, DllCallbackGetPtr($wProcHandle))



Func addRegion()
    $aMask = DllCall("gdi32.dll", "long", "CreateRectRgn", "long", $Startx, "long", $Starty, "long", $Endx + 1, "long", $Endy + 1)
    $nc += 1
    DllCall("gdi32.dll", "long", "CombineRgn", "long", $aM_Mask[0], "long", $aMask[0], "long", $aM_Mask[0], "int", 3)
EndFunc

While 1

    if $fDragging = True then
        chase() ;; moves cursor icon and drag-gui with mousemove
    endif
    if $just_edited = True Then
        $just_edited = False
        ConsoleWrite("New txt: " & _GUICtrlTreeView_GetText($hTreeView, _GUICtrlTreeView_GetSelection($hTreeView)) & @CRLF)
    EndIf
    $msg = GUIGetMsg()
    Switch $msg
        Case $GUI_EVENT_CLOSE
            _WinAPI_SetWindowLong($hTreeView, $GWL_WNDPROC, $wProcOld)
            DllCallbackFree($wProcHandle)
            Exit
        case $GUI_EVENT_MOUSEMOVE
            If $fDragging = False Then ContinueCase
            $hItemHover = TreeItemFromPoint($hTreeView)
            If $hItemHover <> 0 Then
                $aRect = _GUICtrlTreeView_DisplayRect($hTreeView, $hItemHover)
                $iTreeY = _WinAPI_GetMousePosY(True, $hTreeView)
                Switch $iTreeY
                    Case $aRect[1] To $aRect[1]+Int(($aRect[3]-$aRect[1])/4)
                        if $fWhere <> -1 Then
                            _GUICtrlTreeView_SetInsertMark($hTreeView, $hItemHover, False)
                            $fWhere = -1
                        EndIf
                    Case 1+$aRect[1]+Int(($aRect[3]-$aRect[1])/3) To $aRect[1]+Int(($aRect[3]-$aRect[1])*2/3)
                        if $fWhere <> 0 Then
                            _SendMessage($hTreeView, $TVM_SETINSERTMARK, 0, 0)
                            $fWhere = 0
                        EndIf
                    Case 1+$aRect[1]+Int(($aRect[3]-$aRect[1])*2/3) To $aRect[3]
                        if $fWhere <> 1 Then
                            _GUICtrlTreeView_SetInsertMark($hTreeView, $hItemHover)
                            $fWhere = 1
                        EndIf
                EndSwitch

           EndIf


        Case $GUI_EVENT_PRIMARYUP
            If $fDragging Then
                ToolTip("")
                _WinAPI_InvalidateRect($hTreeView)
                $fDragging = False
                _WinAPI_ShowCursor(True)
                _SendMessage($hTreeView, $TVM_SETINSERTMARK, 0, 0)
                If (TreeItemFromPoint($hTreeView) = $hDragItem) Then ContinueCase
                if TreeItemFromPoint($hTreeView) = $item_above_drag AND $fWhere = 1 then ContinueCase
                if TreeItemFromPoint($hTreeView) = $item_below_drag AND $fWhere = -1 then ContinueCase
                if $fWhere <> 0 then
                    $hItem = TreeItemCopy($hTreeView, $hDragItem, TreeItemFromPoint($hTreeView), $fWhere)
                    If $hItem <> 0 Then
                        _GUICtrlTreeView_SelectItem($hTreeView, $hItem)
                        _GUICtrlTreeView_Delete($hTreeView, $hDragItem)
                    EndIf
                EndIf
            EndIf
    EndSwitch
WEnd

Func TreeItemCopy($hWnd, $hItemSource, $hItemTarget, $fDirection)
    $hTest = $hItemTarget
    Do
        $hTest = _GUICtrlTreeView_GetParentHandle($hWnd, $hTest)
        If $hTest = $hItemSource Then Return 0
    Until $hTest = 0
    $sText = _GUICtrlTreeView_GetText($hWnd, $hItemSource)
    $hParent = _GUICtrlTreeView_GetParentHandle($hWnd, $hItemTarget)
    Switch $fDirection
        Case -1
            $hPrev = _GUICtrlTreeView_GetPrevSibling($hWnd, $hItemTarget)
            If $hPrev = 0 Then
                $hNew = _GUICtrlTreeView_AddFirst($hWnd, $hItemTarget, $sText)
            Else
                $hNew = _GUICtrlTreeView_InsertItem($hWnd, $sText, $hParent, $hPrev)
            EndIf
        Case 0
            $hNew = _GUICtrlTreeView_InsertItem($hWnd, $sText, $hItemTarget)
        Case 1
            $hNew = _GUICtrlTreeView_InsertItem($hWnd, $sText, $hParent, $hItemTarget)
        Case Else
            Return 0
    EndSwitch
    _GUICtrlTreeView_SetState($hWnd, $hNew, _GUICtrlTreeView_GetState($hWnd, $hItemSource))
    If _GUICtrlTreeView_GetStateImageList($hWnd) <> 0 Then
        _GUICtrlTreeView_SetStateImageIndex($hWnd, $hNew, _GUICtrlTreeView_GetStateImageIndex($hWnd, $hItemSource))
    EndIf
    If _GUICtrlTreeView_GetNormalImageList($hWnd) <> 0 Then
        _GUICtrlTreeView_SetImageIndex($hWnd, $hNew, _GUICtrlTreeView_GetImageIndex($hWnd, $hItemSource))
        _GUICtrlTreeView_SetSelectedImageIndex($hWnd, $hNew, _GUICtrlTreeView_GetSelectedImageIndex($hWnd, $hItemSource))
    EndIf
    $iChildCount = _GUICtrlTreeView_GetChildCount($hWnd, $hItemSource)
    If $iChildCount > 0 Then
        For $i = 0 To $iChildCount-1
            $hRecSource = _GUICtrlTreeView_GetItemByIndex($hWnd, $hItemSource, $i)
            TreeItemCopy($hWnd, $hRecSource, $hNew, 0)
        Next
    EndIf
    Return $hNew
EndFunc

Func TreeItemFromPoint($hWnd)
    Local $tMPos = _WinAPI_GetMousePos(True, $hWnd)
    Return _GUICtrlTreeView_HitTestItem($hWnd, DllStructGetData($tMPos, 1), DllStructGetData($tMPos, 2))
EndFunc

func GetNeighbourItem($hWnd, $hItemTarget, $above = True)
    if $above = True Then
        Local $hPrev = _GUICtrlTreeView_GetPrevSibling($hWnd, $hItemTarget)
        Return $hPrev
    Else
        Local $hNext = _GUICtrlTreeView_GetNextSibling($hWnd, $hItemTarget)
        Return $hNext
    EndIf
EndFunc

Func chase()
    $mp = MouseGetPos()
    tooltip($moving_txt, $mp[0]+18, $mp[1])
    ;tooltip($vAutoSbUpEnd&"<>"&$vAutoSbdnEnd&@lf&$mp[1], $mp[0]+18, $mp[1])
    if $mp[1] < $vAutoSbUpEnd and $mp[1] > $vAutoSbUpEnd-25 then TvVScroll(-$vAutoSbValue)
    if $mp[1] > $vAutoSbdnEnd and $mp[1] < $vAutoSbdnEnd+25 then TvVScroll(+$vAutoSbValue)


EndFunc

Func WM_NOTIFY($hWnd, $Msg, $wParam, $lParam)
    Local $tNMHDR, $HwndFrom, $iCode, $tInfo
    $tNMHDR = DllStructCreate($tagNMHDR, $lParam)
    $HwndFrom = DllStructGetData($tNMHDR, "HwndFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    Switch $HwndFrom
        Case $hTreeView
            Switch $iCode
                Case $TVN_BEGINDRAG, $TVN_BEGINDRAGW
                    Local $tInfo = DllStructCreate($tagNMTREEVIEW, $lParam)
                    Local $hNewItem = DllStructGetData($tInfo, "NewhItem")
                    _GUICtrlTreeView_SelectItem($hTreeView, $hNewItem)
                    $fDragging = True
                    $moving_txt = "Moving: " & _GUICtrlTreeView_GetText($hTreeView, $hNewItem) & _
                    "";;_WinAPI_ShowCursor(False)
                    HotKeySet("{Esc}", "_cancel_dragging2")
                    tooltip($moving_txt, MouseGetPos(0)+18, MouseGetPos(1))
                    $hDragItem = TreeItemFromPoint($hTreeView)
                    $item_above_drag = GetNeighbourItem($hTreeView, $hDragItem)
                    $item_below_drag = GetNeighbourItem($hTreeView, $hDragItem, false)
                    ;; for auto-scroll
                    $aWinpos =  WingetPos($hGUI)
                    $vAutoSbUpEnd = $aWinpos[1] + $tvTop+30 ;;for Wintitle
                    $vAutoSbDnEnd = $aWinpos[1] +$tvTop+20 +$tvHt
                Case $NM_RCLICK
                    if $fDragging = True Then
                        _cancel_dragging()
                    Else
                        Local $tInfo = DllStructCreate($tagNMTREEVIEW, $lParam)
                        Local $hNewItem = DllStructGetData($tInfo, "NewParam")
                        ConsoleWrite(_GUICtrlTreeView_GetText($hTreeView, $hNewItem) & ", ")
                        _GUICtrlTreeView_SelectItem($hTreeView, $hNewItem)
                    EndIf
                Case $TVN_ENDLABELEDIT, $TVN_ENDLABELEDITW
                    HotKeySet("{Enter}")
                    HotKeySet("{Esc}")
                    If $iEditFlag Then
                        $iEditFlag = 0
                        Local $tInfo = DllStructCreate($tagNMTVDISPINFO, $lParam)
                        Local $sBuffer = DllStructCreate("wchar Text[" & DllStructGetData($tInfo, "TextMax") & "]")
                        If Not _GUICtrlTreeView_GetUnicodeFormat($HwndFrom) Then $sBuffer = StringTrimLeft($sBuffer, 1)
                        DllStructSetData($sBuffer, "Text", DllStructGetData($tInfo, "Text"))
                        If StringLen(DllStructGetData($sBuffer, "Text")) Then
                            $just_edited = true
                            Return 1
                        EndIf
                    EndIf
                Case $TVN_BEGINLABELEDIT, $TVN_BEGINLABELEDITW
                    HotKeySet("{Enter}", "_TextSet")
                    HotKeySet("{Esc}", "_EditClose")
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc

Func _cancel_dragging2()
    if $fDragging = True then _cancel_dragging()
EndFunc

Func _WindowProc($hWnd, $Msg, $wParam, $lParam)
    Switch $hWnd
        Case $hTreeView
            Switch $Msg
                Case $WM_GETDLGCODE
                    Switch $wParam
                        case $VK_F2
                            _TextEdit()
                    EndSwitch
            EndSwitch
    EndSwitch
    Return _WinAPI_CallWindowProc($wProcOld, $hWnd, $Msg, $wParam, $lParam)
EndFunc

func _cancel_dragging()
    HotKeySet("{Esc}")
    $fDragging = False
    _WinAPI_ShowCursor(True)
    ToolTip("")
    _WinAPI_InvalidateRect($hTreeView)
    _SendMessage($hTreeView, $TVM_SETINSERTMARK, 0, 0)
EndFunc

Func _TextEdit()
    Local $hItem = _GUICtrlTreeView_GetSelection($hTreeView)
    If $hItem Then _GUICtrlTreeView_EditText($hTreeView, $hItem)
EndFunc

Func _TextSet()
    $iEditFlag = 1
    _GUICtrlTreeView_EndEdit($hTreeView)
EndFunc

Func _EditClose()
    $iEditFlag = 0
    _GUICtrlTreeView_EndEdit($hTreeView)
EndFunc


func TvVScroll($val)
    $tSBI = DllStructCreate($tagSCROLLINFO)
    DllStructSetData($tSBI, 'cbSize', DllStructGetSize($tSBI))
    DllStructSetData($tSBI, 'fMask', $SIF_ALL)

    If _GUIScrollBars_GetScrollInfo($hTreeview, $SB_VERT, $tSBI) Then
        $iMax = DllStructGetData($tSBI, 'nMax')
        $iPos = DllStructGetData($tSBI, 'nPos')
        ;consolewrite($ipos&" > "&$iMax&@lf)
        if $val <0 and $ipos = 0 then return
        if $val >0 and $ipos+7 >= $iMax then return

        _GUICtrlTreeView_BeginUpdate($hTreeview)
        DllStructSetData($tSBI, 'nPos', $ipos+$val)
        _GUIScrollBars_SetScrollInfo($hTreeview, $SB_VERT, $tSBI)
        _GUICtrlTreeView_EndUpdate($hTreeview)
    Else
        ConsoleWrite('Error' & @LF)
    EndIf

    $tSbi = 0
endfunc