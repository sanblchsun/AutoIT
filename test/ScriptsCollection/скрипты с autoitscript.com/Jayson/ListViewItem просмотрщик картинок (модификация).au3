; Jayson
; http://www.autoitscript.com/forum/topic/127935-list-view-display-thumbnails/#entry888097
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <File.au3>
#Include <EditConstants.au3>
#Include <Constants.au3>
#include <GuiListView.au3>
#include <GuiImageList.au3>
#include <GDIPlus.au3>
#include <WinAPI.au3>

Opt('MustDeclareVars', 1)

Global $sExtFilter = "bmp|gif|jpeg|jpg|png|tif|tiff"
Global $hGui, $Path, $BRowse, $LV, $Pic, $Msg
Global $hImageList, $sCur, $sLast, $iDX, $iPicState = 0, $DoubleClick = -1

$hGui = GUICreate(":-)", 330, 310)
GUICtrlCreateGroup("Browse for folder containing pictures", 5, 5, 320, 55)
$Path = GUICtrlCreateInput("", 15, 25, 230, 20, $ES_READONLY)
GUICtrlSetBkColor(-1, 0xFFFFFF)
$BRowse = GUICtrlCreateButton("Browse", 255, 25, 60, 20)
$LV = GUICtrlCreateListView("",  5, 70, 82, 234, -1, BitOr($WS_EX_CLIENTEDGE, $LVS_EX_DOUBLEBUFFER))
_GUICtrlListView_SetView($LV, 1)
_GUICtrlListView_SetIconSpacing($LV, 60, 30)
GUICtrlCreateGroup("Preview", 94, 65, 232, 241)
$Pic = GUICtrlCreatePic("", 100, 80, 220, 220)
GUISetState(@SW_SHOW, $hGui)

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

While 1
    $Msg = GUIGetMsg()
    Switch $Msg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $Browse
            _Browse()
        Case Else
            _LVEvent()
    EndSwitch
WEnd

Func _Browse()
    Local $FSF, $FL2A, $hBmp, $iCnt = 0
    $FSF = FileSelectFolder("Browse for folder containing pictures", "", "", $hGui)
    If Not @error And FileExists($FSF) Then
        If StringRight($FSF, 1) <> "\" Then $FSF &= "\"
        $FL2A = _FileListToArray($FSF, "*", 1)
        If Not @Error Then
            If IsPtr($hImageList) Then
                _GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($LV))
                _GUIImageList_Destroy($hImageList)
                $hImageList = ""
                _hBmpToPicControl($Pic, $hBmp)
                GUICtrlSetImage($Pic, "")
                $iDX = -1
                $iPicState = 0
                $sCur = ""
                $sLast = ""
            EndIf
            $hImageList = _GUIImageList_Create(60, 60, 5, 3)
            _GUICtrlListView_SetImageList($LV, $hImageList, 0)
            For $i = 1 To $FL2A[0]
                If StringRegExp($FL2A[$i], "(?i)\.(" & $sExtFilter & ")", 0) Then
                    $hBmp = _GetImage($FSF & $FL2A[$i], 60)
                    _GUIImageList_Add($hImageList, $hBmp)
                    _WinAPI_DeleteObject($hBmp)
                    _GUICtrlListView_AddItem($LV, $FL2A[$i], $iCnt)
                    _GUICtrlListView_SetItemImage($LV, $iCnt, $iCnt)
                    $iCnt += 1
                EndIf
            Next
            GUICtrlSetData($Path, $FSF)
        EndIf
        WinSetTitle($hGui, "", "Images Found: " & $iCnt)
    EndIf
EndFunc

Func _LVEvent()
    Local $hBMP
    If $iDX <> -1 Then
        $sCur = GUICtrlRead($Path) & _GUICtrlListView_GetItemText($LV, $iDX)
        If $sCur <> $sLast Then
            $hBMP = _GetImage($sCur, 220, BitOR(0xFF000000, _GetGuiBkColor(_WinAPI_GetForegroundWindow())))
            _hBmpToPicControl($Pic, $hBMP, 1)
            $sLast = $sCur
            $iPicState = 1
        EndIf
        $iDX = -1
    ElseIf  $iDX = -1 And _GUICtrlListView_GetNextItem($LV) = -1 And $iPicState Then
        _hBmpToPicControl($Pic, $hBMP)
        $iPicState = 0
        $sCur = ""
        $sLast = ""
    EndIf
    If $DoubleClick <> -1 Then
        ShellExecute(GUICtrlRead($Path) & _GUICtrlListView_GetItemText($LV, $DoubleClick))
        $DoubleClick = -1
    EndIf
EndFunc

Func _GetImage($sFile, $iWH, $iBkClr = 0xFFFFFF)
    Local $hBmp1, $hBitmap, $hGraphic, $hImage, $iW, $iH, $aGS, $hBmp2
    _GDIPlus_Startup()
    $hBmp1 = _WinAPI_CreateBitmap($iWH, $iWH, 1, 32)
    $hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp1)
    $hGraphic = _GDIPlus_ImageGetGraphicsContext($hBitmap)
    _WinAPI_DeleteObject($hBmp1)
    _GDIPlus_GraphicsClear($hGraphic, BitOR(0xFF000000, $iBkClr))
    $hImage = _GDIPlus_ImageLoadFromFile($sFile)
    $iW = _GDIPlus_ImageGetWidth($hImage)
    $iH = _GDIPlus_ImageGetHeight($hImage)
    $aGS = _GetScale($iW, $iH, $iWH)
    _GDIPlus_GraphicsDrawImageRect($hGraphic, $hImage, $aGS[0], $aGS[1], $aGS[2], $aGS[3])
    _GDIPlus_ImageDispose($hImage)
    _GDIPlus_GraphicsDispose($hGraphic)
    $hBmp2 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
    _GDIPlus_BitmapDispose($hBitmap)
    _GDIPlus_Shutdown()
    Return $hBmp2
EndFunc

Func _GetScale($iW, $iH, $iWH)
    Local $aRet[4]
    If $iW <= $iWH And $iH <= $iWH Then
        $aRet[2] = $iW
        $aRet[3] = $iH
        $aRet[0] = ($iWH - $aRet[2])/2
        $aRet[1] = ($iWH - $aRet[3])/2
    ElseIf $iW > $iH Then
        $aRet[2] = $iWH
        $aRet[3] = $iH/($iW/$iWH)
        $aRet[0] = 0
        $aRet[1] = ($iWH - $aRet[3])/2
    ElseIf $iW < $iH Then
        $aRet[2] = $iW/($iH/$iWH)
        $aRet[3] = $iWH
        $aRet[0] = ($iWH - $aRet[2])/2
        $aRet[1] = 0
    ElseIf $iW = $iH Then
        $aRet[2] = $iWH
        $aRet[3] = $iWH
        $aRet[0] = 0
        $aRet[1] = 0
    EndIf
    Return $aRet
EndFunc

Func _GetGuiBkColor($hWnd)
    Local $hDC, $aBGR
    $hDC = _WinAPI_GetDC($hWnd)
    $aBGR = DllCall('gdi32.dll', 'int', 'GetBkColor', 'hwnd', $hDC)
    _WinAPI_ReleaseDC($hWnd, $hDC)
    Return BitOR(BitAND($aBGR[0], 0x00FF00), BitShift(BitAND($aBGR[0], 0x0000FF), -16), BitShift(BitAND($aBGR[0], 0xFF0000), 16))
EndFunc

Func _hBmpToPicControl($iCID, ByRef $hBmp, $iFlag = 0)
    Local Const $STM_SETIMAGE = 0x0172
    Local Const $IMAGE_BITMAP = 0
    Local $hOldBmp
    $hOldBmp = GUICtrlSendMsg($iCID, $STM_SETIMAGE, $IMAGE_BITMAP, $hBmp)
    If $hOldBmp Then _WinAPI_DeleteObject($hOldBmp)
    If $iFlag Then _WinAPI_DeleteObject($hBmp)
EndFunc

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView, $tInfo, $aIDX
    $hWndListView = GUICtrlGetHandle($LV)
    $tNMHDR = DllStructCreate("hwnd hWndFrom;int_ptr IDFrom;int Code", $ilParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    Switch $hWndFrom
        Case $hWndListView
            Switch $iCode
                Case $NM_CLICK
                    $iDX = _GUICtrlListView_GetNextItem($hWndListView)
                Case $NM_DBLCLK
                    $DoubleClick = _GUICtrlListView_GetNextItem($hWndListView)
                Case $LVN_KEYDOWN
                    $tInfo = DllStructCreate("hwnd hWndFrom;int_ptr IDFrom;int Code;int_ptr VKey;int Flags", $ilParam)
                    Switch BitAnd(DllStructGetData($tInfo, "VKey"), 0xFFFF)
                        Case $VK_UP
                            $iDX = _GUICtrlListView_GetNextItem($hWndListView) -1
                            If $iDX < 0 Then $iDX = 0
                        Case $VK_DOWN
                            $iDX = _GUICtrlListView_GetNextItem($hWndListView) + 1
                            If $iDX >= _GUICtrlListView_GetItemCount($hWndListView) Then $iDX -= 1
                    EndSwitch
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc