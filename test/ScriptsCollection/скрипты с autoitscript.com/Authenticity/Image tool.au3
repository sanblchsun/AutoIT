#include <Constants.au3>
#include <GDIP.au3>
#include <GUIConstantsEx.au3>
#include <ScrollBarConstants.au3>
#include <GUIToolbar.au3>
#include <WindowsConstants.au3>

Opt('MustDeclareVars', 1)

If Not IsDeclared("SB_ENDSCROLL") Then Global Const $SB_ENDSCROLL = 8

Global $hToolbar
Global Enum $idOpen = 0x0400, $idSave
Global $aLables[5] = ["Contrast", "Brightness", "Saturation", "Hue", "Gamma"]
; Slider, hSlider, Label, Min, Max, Default, Factor, Precision, PreviousVal
Global $aSliders[5][9] = _
   [[0, 0, 0, 4, 80, 20, 0.05, 2, -1], _
    [0, 0, 0, -20, 20, 0, 0.05, 2, -1], _
    [0, 0, 0, 0, 60, 20, 0.05, 2, -1], _
    [0, 0, 0, -45, 45, 0, 4, 0, -1], _
    [0, 0, 0, 4, 80, 20, 0.05, 2, -1]]
    
Global $hGraphics, $hImage, $hBackImage, $hImageContext, $hIA, $tPreHue, $tPostHue, $aImageSize, $sImage, $iPicWidth, $iPicHeight, $fChange
Global $sImageFormats = "All Picture Files (*.bmp;*.gif;*.jpg;*.jpeg;*.jpe;*.jfif;*.tif;*.tiff;*.png;*.exif;*.wmf;*.emf)"

_GDIPlus_Startup()
_Main()
_GDIPlus_Shutdown()

Func _Main()
    Local $hGUI, $BtnReset, $BtnBlackWhite, $iGUIWidth, $iGUIHeight, $iLeft, $iTop, $iI, $aSize
    
    $iGUIWidth = @DesktopWidth*0.75
    $iGUIHeight = @DesktopHeight*0.75
    
    If $iGUIWidth < 900 Then $iGUIWidth = 900
    If $iGUIHeight < 700 Then $iGUIHeight = 700

    $hGUI = GUICreate("Image tool", $iGUIWidth, $iGUIHeight)
    $hToolbar = _GUICtrlToolbar_Create ($hGUI)
    $aSize = _GUICtrlToolbar_GetMaxSize ($hToolbar)
    
    
    $iPicWidth = $iGUIWidth-250
    $iPicHeight = $iGUIHeight - $aSize[1] - 30

    GUICtrlCreateLabel("", 10, $aSize[1] + 20, $iPicWidth, $iPicHeight, -1, $WS_EX_CLIENTEDGE)
    $hGraphics = _GDIPlus_GraphicsCreateFromHWND(GUICtrlGetHandle(-1))
    $hIA = _GDIPlus_ImageAttributesCreate()
    
    _GDIPlus_GraphicsSetInterpolationMode($hGraphics, 7)
    
    $iLeft = $iGUIWidth - 230
    $iTop = $aSize[1]+20
    
    For $iI = 0 To UBound($aSliders)-1
        GUICtrlCreateLabel($aLables[$iI], $iLeft, $iI*60+$iTop)
        $aSliders[$iI][0] = GUICtrlCreateSlider($iLeft, $iI*60+$iTop+20, 150, 20)
        $aSliders[$iI][1] = GUICtrlGetHandle(-1)
        $aSliders[$iI][2] = GUICtrlCreateLabel("", $iLeft+160, $iI*60+$iTop+20, 40, 25)
        GUICtrlSetLimit($aSliders[$iI][0], $aSliders[$iI][4], $aSliders[$iI][3])
    Next
    
    _Reset()

    $BtnReset = GUICtrlCreateButton("Reset", $iLeft+125, $iI*60+$iTop, 70, 25)
    $BtnBlackWhite = GUICtrlCreateButton("Black&&White", $iLeft+50, $iI*60+$iTop, 70, 25)
    
    _GUICtrlToolbar_AddBitmap ($hToolbar, 1, -1, $IDB_STD_LARGE_COLOR)
    _GUICtrlToolbar_AddButton ($hToolbar, $idOpen, $STD_FILEOPEN)
    _GUICtrlToolbar_AddButton ($hToolbar, $idSave, $STD_FILESAVE)

    GUIRegisterMsg($WM_NOTIFY, "_WM_NOTIFY")
    GUIRegisterMsg($WM_HSCROLL, "_WM_HSCROLL")
    GUISetState()
    
    While 1
        Switch GUIGetMsg()
            Case $BtnReset
                _Reset()
                
            Case $BtnBlackWhite
                _BlackAndWhite()
            
            Case $GUI_EVENT_RESTORE
                If $hImage Then _Update()
                
            Case $GUI_EVENT_CLOSE
                If $fChange Then
                    If _Save() Then
                        If $hImageContext Then _GDIPlus_GraphicsDispose($hImageContext)
                        If $hBackImage Then _GDIPlus_ImageDispose($hBackImage)
                        If $hImage Then _GDIPlus_ImageDispose($hImage)
                        _GDIPlus_ImageAttributesDispose($hIA)
                        _GDIPlus_GraphicsDispose($hGraphics)
                        ExitLoop
                    EndIf
                Else
                    ExitLoop
                EndIf
        EndSwitch
    WEnd

EndFunc

Func _Reset()
    Local $iI
    
    For $iI = 0 To UBound($aSliders)-1
         GUICtrlSetData($aSliders[$iI][2], _GetStringFormat($iI, $aSliders[$iI][5]))
        GUICtrlSetData($aSliders[$iI][0], $aSliders[$iI][5])
        $aSliders[$iI][8] = -1
    Next
    
    _GDIPlus_ImageAttributesSetThreshold($hIA, 0, False)
    If $hImage Then _Update()
EndFunc

Func _Save()
    Local $iRet
    
    If $fChange Then
        $iRet = MsgBox(0x23, "Save changes", 'Would you like to save changes to "' & StringTrimLeft($sImage, StringInStr($sImage, "\", 0, -1)) & '"?')
        
        If $iRet = 2 Then
            Return False
        ElseIf $iRet = 6 Then
            _GDIPlus_ImageSaveToFile($hBackImage, $sImage)
        EndIf
    EndIf
    
    Return True
EndFunc

Func _Initialize()
    $tPreHue = _GDIPlus_ColorMatrixCreate()
    $tPostHue = _GDIPlus_ColorMatrixCreate()
    _GDIPlus_ColorMatrixInitHue($tPreHue, $tPostHue)
    
    
    $aImageSize = _GDIPlus_ImageGetDimension($hImage)
    _GDIPlus_GraphicsDrawImageRect($hGraphics, $hImage, 0, 0, $iPicWidth, $iPicHeight)
    _Reset()
    $fChange = False
EndFunc

Func _Update()
    Local $tColorMatrix, $pColorMatrix, $nContrast, $nBrightness, $nSaturation, $nHue, $nGamma
    
    $tColorMatrix = _GDIPlus_ColorMatrixCreate()
    $pColorMatrix = DllStructGetPtr($tColorMatrix)
    
    $nContrast = _GetValue(0)
    $nBrightness = _GetValue(1)
    $nSaturation = _GetValue(2)
    $nHue = _GetValue(3)
    $nGamma = _GetValue(4)
    
    _GDIPlus_ColorMatrixScale($tColorMatrix, $nContrast, $nContrast, $nContrast, 1, 1)
    _GDIPlus_ColorMatrixTranslate($tColorMatrix, $nBrightness, $nBrightness, $nBrightness, 0, 1)
    _GDIPlus_ColorMatrixSetSaturation($tColorMatrix, $nSaturation, 1)
    _GDIPlus_ColorMatrixRotateHue($tColorMatrix, $tPreHue, $tPostHue, $nHue)
    
    _GDIPlus_ImageAttributesSetColorMatrix($hIA, 0, True, $pColorMatrix)
    _GDIPlus_ImageAttributesSetGamma($hIA, 0, True, $nGamma)
    
    _GDIPlus_GraphicsDrawImageRectRectIA($hImageContext, $hImage, 0, 0, $aImageSize[0], $aImageSize[1], 0, 0, $aImageSize[0], $aImageSize[1], $hIA)
    _GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hBackImage, 0, 0, $aImageSize[0], $aImageSize[1], 0, 0, $iPicWidth, $iPicHeight)
EndFunc

Func _GetValue($iIndex)
    Return GUICtrlRead($aSliders[$iIndex][0])*$aSliders[$iIndex][6]
EndFunc

Func _GetStringFormat($iIndex, $iVal)
    If $aSliders[$iIndex][7] Then
        Return StringFormat("%." & $aSliders[$iIndex][7] & "f", $iVal*$aSliders[$iIndex][6])
    Else
        Return StringFormat("%d", $iVal*$aSliders[$iIndex][6])
    EndIf
EndFunc

Func _BlackAndWhite()
    Local $tBWMatrix, $pBWMatrix
    
    If $hImage Then
        _GDIPlus_ImageAttributesSetThreshold($hIA, 0, True, 0.5)
        $tBWMatrix = _GDIPlus_ColorMatrixCreateGrayScale()
        $pBWMatrix = DllStructGetPtr($tBWMatrix)
        
        _GDIPlus_ImageAttributesSetColorMatrix($hIA, 0, True, $pBWMatrix)
        _GDIPlus_GraphicsDrawImageRectRectIA($hImageContext, $hImage, 0, 0, $aImageSize[0], $aImageSize[1], 0, 0, $aImageSize[0], $aImageSize[1], $hIA)
        _GDIPlus_GraphicsDrawImageRectRect($hGraphics, $hBackImage, 0, 0, $aImageSize[0], $aImageSize[1], 0, 0, $iPicWidth, $iPicHeight)
        $fChange = True
    EndIf
EndFunc

Func _WM_HSCROLL($hWnd, $iMsg, $iwParam, $ilParam)
    Local $iI, $iPos, $iCode
    
    $iCode = BitAND($iwParam, 0xFFFF)
    If $iCode = $SB_ENDSCROLL Or $iCode = $SB_THUMBPOSITION Then Return 0
    
    For $iI = 0 To UBound($aSliders)-1
        If $aSliders[$iI][1] = $ilParam Then
            $iPos = GUICtrlRead($aSliders[$iI][0])
            
            If $iPos <> $aSliders[$iI][8] Then
                GUICtrlSetData($aSliders[$iI][2], _GetStringFormat($iI, $iPos))
                $aSliders[$iI][8] = $iPos
                
                If $hImage Then
                    $fChange = True
                    _Update()
                EndIf
            EndIf
            ExitLoop
        EndIf
    Next
  
    Return $GUI_RUNDEFMSG
EndFunc

Func _WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    Local $tNMHDR, $hFrom, $iCode,  $iCommand, $sFileName, $sFile, $sExt, $sTmp, $hBitmap, $hContext
    
    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hFrom = DllStructGetData($tNMHDR, "hWndFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    
    If $hFrom = $hToolbar And $iCode = $NM_LDOWN Then
        Local $iCommand = _GUICtrlToolbar_IndexToCommand($hToolbar, _GUICtrlToolbar_GetHotItem($hToolbar))
        
        Switch $iCommand
            Case $idOpen
                $sFileName = FileOpenDialog("Open File", @WorkingDir, $sImageFormats, 3)
                    
                If $sFileName Then
                    If _Save() Then
                        $sImage = $sFileName
                        
                        If $hImage Then
                            _GDIPlus_GraphicsDispose($hImageContext)
                            _GDIPlus_ImageDispose($hBackImage)
                            _GDIPlus_ImageDispose($hImage)
                            $hImage = 0
                            $hBackImage = 0
                            $hImageContext = 0
                            $sImage = ""
                        EndIf
                        
                        $hBitmap = _GDIPlus_ImageLoadFromFile($sFileName)
                        If @error Then
                            MsgBox(0x10, "Error", "Could not load image")
                            _Reset()
                            $fChange = False
                        Else
                            $hImage = _GDIPlus_BitmapCreateFromScan0(_GDIPlus_ImageGetWidth($hBitmap), _GDIPlus_ImageGetHeight($hBitmap))
                            $hContext = _GDIPlus_ImageGetGraphicsContext($hImage)
                            _GDIPlus_GraphicsDrawImage($hContext, $hBitmap, 0, 0)
                            _GDIPlus_GraphicsDispose($hContext)
                            _GDIPlus_ImageDispose($hBitmap)
                            $hBackImage = _GDIPlus_ImageClone($hImage)
                            $hImageContext = _GDIPlus_ImageGetGraphicsContext($hBackImage)
                            _Initialize()
                        EndIf
                    EndIf
                EndIf
            Case $idSave
                If $hImage Then
                    $sFile = StringTrimLeft($sImage, StringInStr($sImage, "\", 0, -1))
                    $sExt = StringTrimLeft($sFile, StringInStr($sFile, ".", 0, -1))
                    
                    $sFileName = FileSaveDialog("Save As", @WorkingDir, $sImageFormats, 18, $sFile)
                    
                    If $sFileName Then
                        If StringRight($sFileName, StringLen($sExt)+1) <> "." & $sExt Then $sFileName &= "." & $sExt
                        _GDIPlus_ImageSaveToFile($hBackImage, $sFileName)
                        $fChange = False
                    EndIf
                EndIf
        EndSwitch
    EndIf
    
    Return $GUI_RUNDEFMSG
EndFunc