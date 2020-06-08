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

$hGui = GUICreate("Image Viewer", 490, 620)
$Path = GUICtrlCreateInput("", 10, 10, 400, 20, $ES_READONLY)
$BRowse = GUICtrlCreateButton("Browse", 420, 10, 60, 20)
$LV = GUICtrlCreateListView("",  5, 40, 480, 575, -1, BitOr($WS_EX_CLIENTEDGE, $LVS_EX_DOUBLEBUFFER))
_GUICtrlListView_SetView($LV, 1)
_GUICtrlListView_SetIconSpacing($LV, 75, 60)
$Pic = GUICtrlCreatePic("", 200, 80, 440, 440)
GUISetState(@SW_SHOW)

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

While 1
    $Msg = GUIGetMsg()
    Switch $Msg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $Browse
            _Browse()
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
                _GUiImageList_Destroy($hImageList)
                $hImageList = ""
                _hBmpToPicControl($Pic, $hBmp)
                GUICtrlSetImage($Pic, "")
                $iDX = -1
                $iPicState = 0
                $sCur = ""
                $sLast = ""
            EndIf
            $hImageList = _GUiImageList_Create(60, 60, 5, 3)
            _GUICtrlListView_SetImageList($LV, $hImageList, 0)
            For $i = 1 To $FL2A[0]
                If StringRegExp($FL2A[$i], "(?i)\.(" & $sExtFilter & ")", 0) Then
                    $hBmp = _GetImage($FSF & $FL2A[$i], 60)
                    _GUiImageList_Add($hImageList, $hBmp)
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
    $tNMHDR = DllStructCreate('hwnd hWndFrom;int_ptr IDFrom;int Code', $ilParam)
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
                    $tInfo = DllStructCreate('hwnd hWndFrom;int_ptr IDFrom;int Code;int_ptr VKey;int Flags', $ilParam)
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