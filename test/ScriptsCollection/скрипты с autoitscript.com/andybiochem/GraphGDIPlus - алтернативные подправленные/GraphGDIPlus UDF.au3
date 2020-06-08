#include-once
#include <GDIplus.au3>
; #INDEX# =======================================================================================================================
; Title .........: GraphGDIPlus_UDF
; AutoIt Version : 3.2.10++
; Language ......: English
; Description ...: This module contains various functions for manipulating Graph object
; ===============================================================================================================================


; #CURRENT# =====================================================================================================================
;_GraphGDIPlus_Create
;_GraphGDIPlus_Delete
;_GraphGDIPlus_ReDraw
;_GraphGDIPlus_Clear
;_GraphGDIPlus_Set_RangeX
;_GraphGDIPlus_Set_RangeY
;_GraphGDIPlus_Plot_Start
;_GraphGDIPlus_Plot_Line
;_GraphGDIPlus_Plot_Point
;_GraphGDIPlus_Plot_Dot
;_GraphGDIPlus_Set_PenColor
;_GraphGDIPlus_Set_PenSize
;_GraphGDIPlus_Set_PenDash
;_GraphGDIPlus_Set_GridX
;_GraphGDIPlus_Set_GridY
;_GraphGDIPlus_Refresh
;_GraphGDIPlus_SaveImage
;_GraphGDIPlus_SmoothMode
; ===============================================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================================
; _GraphGDIPlus_RedrawRect
; _GraphGDIPlus_Reference_Pixel
; ===============================================================================================================================

; Offset for fields in $GraphArray
Local  Enum     $_GRAPH_NOUSE       = 0 , _ ; [0] Not used
                $_GRAPH_HANDLE          , _ ; [1] graphic control handle
                $_GRAPH_LEFT            , _ ; [2] left
                $_GRAPH_TOP             , _ ; [3] top
                $_GRAPH_WIDTH           , _ ; [4] width
                $_GRAPH_HEIGHT          , _ ; [5] height
                $_GRAPH_XLOW            , _ ; [6] x low 
                $_GRAPH_XHIGH           , _ ; [7] x high
                $_GRAPH_YLOW            , _ ; [8] y low
                $_GRAPH_YHIGH           , _ ; [9] y high
                $_GRAPH_HXTICKS         , _ ; [10] x ticks handles
                $_GRAPH_HXLABELS        , _ ; [11] x labels handles
                $_GRAPH_HYTICKS         , _ ; [12] y ticks handles
                $_GRAPH_HYLABELS        , _ ; [13] y labels handles
                $_GRAPH_BORDERCOLOR     , _ ; [14] Border Color
                $_GRAPH_FILLCOLOR       , _ ; [15] Fill Color
                $_GRAPH_HBITMAP         , _ ; [16] Bitmap Handle
                $_GRAPH_HBACKBUFFER     , _ ; [17] Backbuffer Handle
                $_GRAPH_LASTXPOS        , _ ; [18] Last used x pos
                $_GRAPH_LASTYPOS        , _ ; [19] Last used y pos
                $_GRAPH_HPEN            , _ ; [20] Pen (main) Handle
                $_GRAPH_HBRUSH          , _ ; [21] Brush (fill) Handle
                $_GRAPH_HPENBORDER      , _ ; [22] Pen (border) Handle
                $_GRAPH_HPENGRID        , _ ; [23] Pen (grid) Handle
                $_GRAPH_INTERNALINDEX   , _ ; [24] Index in internal graph array
                $_GRAPH_SMOOTHMODE      , _ ; [25] Smooth mode(default=0)
                $_GRAPH_SIZE                ; must be the last one

Global $aGraphGDIPlusaGraphArrayINTERNAL[1]
; #FUNCTION# ============================================================================
; Name...........: _GraphGDIPlus_Create
; Description ...: Creates graph area, and prepares array of specified data
; Syntax.........: _GraphGDIPlus_Create($hWnd,$iLeft,$iTop,$iWidth,$iHeight,$hColorBorder = 0xFF000000,$hColorFill = 0xFFFFFFFF)
; Parameters ....:  $hWnd - Handle to GUI
;                   $iLeft - left most position in GUI
;                   $iTop - top most position in GUI
;                   $iWidth - width of graph in pixels
;                   $iHeight - height of graph in pixels
;                   $hColorBorder - Color of graph border (ARGB)
;                   $hColorFill - Color of background (ARGB)
; Return values .: Returns array containing variables for subsequent functions...
;                    Returned Graph array is:
;                    [1] graphic control handle
;                    [2] left
;                    [3] top
;                    [4] width
;                    [5] height
;                    [6] x low
;                    [7] x high
;                    [8] y low
;                    [9] y high
;                    [10] x ticks handles
;                    [11] x labels handles
;                    [12] y ticks handles
;                    [13] y labels handles
;                    [14] Border Color
;                    [15] Fill Color
;                    [16] Bitmap Handle
;                    [17] Backbuffer Handle
;                    [18] Last used x pos
;                    [19] Last used y pos
;                    [20] Pen (main) Handle
;                    [21] Brush (fill) Handle
;                    [22] Pen (border) Handle
;                    [23] Pen (grid) Handle
;                    [24] Index in internal graph array
;                    [25] Smooth mode (default=0)
; =======================================================================================
Func _GraphGDIPlus_Create($hWnd,$iLeft,$iTop,$iWidth,$iHeight,$hColorBorder = 0xFF000000,$hColorFill = 0xFFFFFFFF)
    Local $graphics,$bitmap,$backbuffer,$brush,$bpen,$gpen,$pen
    Local $ahTicksLabelsX[1]
    Local $ahTicksLabelsY[1]
    Local $ahTicksX[1]
    Local $ahTicksY[1]
    Local $aGraphArray[1]
    local $i
    
    ;----- Set GUI transparency to SOLID (prevents GDI+ glitches) -----
    WinSetTrans($hWnd,"",255)
    ;----- GDI+ Initiate -----
    _GDIPlus_Startup()
    $graphics=_GDIPlus_GraphicsCreateFromHWND($hWnd)                ;graphics area
    $bitmap=_GDIPlus_BitmapCreateFromGraphics($iWidth+1,$iHeight+1,$graphics);buffer bitmap
    $backbuffer=_GDIPlus_ImageGetGraphicsContext($bitmap)           ;buffer area
    _GDIPlus_GraphicsSetSmoothingMode($backbuffer, 0)
    ;----- Set background Color -----
    $brush =  _GDIPlus_BrushCreateSolid($hColorFill)
    _GDIPlus_GraphicsfillRect($backbuffer,0,0,$iWidth,$iHeight,$brush)
    ;----- Set border Pen + color -----
    $bpen = _GDIPlus_PenCreate($hColorBorder)
    _GDIPlus_PenSetEndCap($bpen,$GDIP_LINECAPROUND)
    ;----- Set Grid Pen + color -----
    $gpen = _GDIPlus_PenCreate(0xFFf0f0f0)
    _GDIPlus_PenSetEndCap($gpen,$GDIP_LINECAPROUND)
    ;----- set Drawing Pen + Color -----
    $pen = _GDIPlus_PenCreate() ;drawing pen initially black, user to set
    _GDIPlus_PenSetEndCap($pen,$GDIP_LINECAPROUND)
    _GDIPlus_GraphicsDrawRect($backbuffer,0,0,$iWidth,$iHeight,$pen)
    ;----- draw -----
    _GDIPlus_GraphicsDrawImageRect($graphics,$bitmap,$iLeft,$iTop,$iWidth+1,$iHeight+1)
    ;----- register redraw -----
    GUIRegisterMsg(0x0006,"_GraphGDIPlus_ReDraw")
    ;----- prep + load array -----
    Dim $aGraphArray[$_GRAPH_SIZE] = ["", _
                                    $graphics, _                 ; [1] graphic control handle
                                    $iLeft,$iTop, _              ; [2] left, [3] top
                                    $iWidth,$iHeight, _          ; [4] width, [5] height
                                    0,1,0,1, _                   ; [6] x low, [7] x high, [8] y low, [9] y high
                                    $ahTicksX,$ahTicksLabelsX, _ ; [10] x ticks handles, [11] x labels handles
                                    $ahTicksY,$ahTicksLabelsY, _ ; [12] y ticks handles, [13] y labels handles
                                    $hColorBorder,$hColorFill, _ ; [14] Border Color, [15] Fill Color
                                    $bitmap,$backbuffer, _       ; [16] Bitmap Handle, [17] Backbuffer Handle
                                    0,0, _                       ; [18] Last used x pos, [19] Last used y pos
                                    $pen,$brush,$bpen,$gpen, _   ; [20] Pen (main) Handle, [21] Brush (fill) Handle, [22] Pen (border) Handle, [23] Pen (grid) Handle
                                    -1,0]                        ; [24] Index in $aGraphGDIPlusaGraphArrayINTERNAL, [25] Smooth mode

    $aGraphGDIPlusaGraphArrayINTERNAL[UBound($aGraphGDIPlusaGraphArrayINTERNAL,1)-1] = $aGraphArray
    $aGraphArray[$_GRAPH_INTERNALINDEX] = UBound($aGraphGDIPlusaGraphArrayINTERNAL,1)-1
    redim $aGraphGDIPlusaGraphArrayINTERNAL[UBound($aGraphGDIPlusaGraphArrayINTERNAL,1)+1]
    $aGraphGDIPlusaGraphArrayINTERNAL[UBound($aGraphGDIPlusaGraphArrayINTERNAL,1)-1]=-1

Return $aGraphArray
EndFunc


; #FUNCTION# ============================================================================
; Name...........: _GraphGDIPlus_ReDraw
; Description ...: redraw of the GDI+ Image upon window min/maximize
; Syntax.........: _GraphGDIPlus_Delete($hWnd)
; Parameters ....:  $hWnd - GUI handle
; Return values .: None
; =======================================================================================
Func _GraphGDIPlus_ReDraw($hWnd)
    local $i
    ;----- Allows redraw of the GDI+ Image upon window min/maximize -----
    _WinAPI_RedrawWindow($hWnd,0,0,0x0100)
    for $i=0 to UBound($aGraphGDIPlusaGraphArrayINTERNAL,1)-1
        if $aGraphGDIPlusaGraphArrayINTERNAL[$i] <> -1 then
            _GraphGDIPlus_Refresh($aGraphGDIPlusaGraphArrayINTERNAL[$i])
        EndIf
    Next
EndFunc



; #FUNCTION# ============================================================================
; Name...........: _GraphGDIPlus_Delete
; Description ...: Deletes previously created graph and related ticks/labels
; Syntax.........: _GraphGDIPlus_Delete($hWnd,ByRef $aGraphArray)
; Parameters ....:  $hWnd - GUI handle
;                   $aGraphArray - the array returned from _GraphGDIPlus_Create
;                   $iKeepGDIPlus - if not zero, function will not _GDIPlus_Shutdown()
; Return values .: None
; =======================================================================================
Func _GraphGDIPlus_Delete($hWnd,ByRef $aGraphArray,$iKeepGDIPlus = 0)
    Local $ahTicksX,$ahTicksLabelsX,$ahTicksY,$ahTicksLabelsY,$i
    ;----- delete x ticks/labels -----
    $ahTicksX = $aGraphArray[$_GRAPH_HXTICKS]
    $ahTicksLabelsX = $aGraphArray[$_GRAPH_HXLABELS]
    For $i = 1 to (UBound($ahTicksX) - 1)
        GUICtrlDelete($ahTicksX[$i])
    Next
    For $i = 1 to (UBound($ahTicksLabelsX) - 1)
        GUICtrlDelete($ahTicksLabelsX[$i])
    Next
    ;----- delete y ticks/labels -----
    $ahTicksY = $aGraphArray[$_GRAPH_HYTICKS]
    $ahTicksLabelsY = $aGraphArray[$_GRAPH_HYLABELS]
    For $i = 1 to (UBound($ahTicksY) - 1)
        GUICtrlDelete($ahTicksY[$i])
    Next
    For $i = 1 to (UBound($ahTicksLabelsY) - 1)
        GUICtrlDelete($ahTicksLabelsY[$i])
    Next
    ;----- delete graphic control -----
    _GDIPlus_GraphicsDispose($aGraphArray[$_GRAPH_HBACKBUFFER])
    _GDIPlus_BitmapDispose($aGraphArray[$_GRAPH_HBITMAP])
    _GDIPlus_GraphicsDispose($aGraphArray[$_GRAPH_HANDLE])
    _GDIPlus_BrushDispose($aGraphArray[$_GRAPH_HBRUSH])
    _GDIPlus_PenDispose($aGraphArray[$_GRAPH_HPEN])
    _GDIPlus_PenDispose($aGraphArray[$_GRAPH_HPENBORDER])
    _GDIPlus_PenDispose($aGraphArray[$_GRAPH_HPENGRID])
    If $iKeepGDIPlus = 0 Then _GDIPlus_Shutdown()
    _WinAPI_InvalidateRect($hWnd)
    
    ;----- Remove entry in $aGraphGDIPlusaGraphArrayINTERNAL -----
    $aGraphGDIPlusaGraphArrayINTERNAL[$aGraphArray [$_GRAPH_INTERNALINDEX]]=-1  

    ;----- close array -----
    $aGraphArray = 0
EndFunc



; #FUNCTION# ============================================================================
; Name...........: _GraphGDIPlus_Clear
; Description ...: Clears graph content
; Syntax.........: _GraphGDIPlus_Clear(ByRef $aGraphArray)
; Parameters ....: $aGraphArray - the array returned from _GraphGDIPlus_Create
; Return values .: None
; =======================================================================================
Func _GraphGDIPlus_Clear(ByRef $aGraphArray)
    ;----- Set background Color -----
    _GDIPlus_GraphicsfillRect($aGraphArray[$_GRAPH_HBACKBUFFER],0,0,$aGraphArray[$_GRAPH_WIDTH],$aGraphArray[$_GRAPH_HEIGHT], $aGraphArray[$_GRAPH_HBRUSH])
    ;----- set border + Color -----
    _GraphGDIPlus_RedrawRect($aGraphArray)
    ;----- draw -----
    _GDIPlus_GraphicsDrawImageRect($aGraphArray[$_GRAPH_HANDLE],$aGraphArray[$_GRAPH_HBITMAP],$aGraphArray[$_GRAPH_LEFT],$aGraphArray[$_GRAPH_TOP],$aGraphArray[$_GRAPH_WIDTH]+1,$aGraphArray[$_GRAPH_HEIGHT]+1)
EndFunc



; #FUNCTION# ============================================================================
; Name...........: _GraphGDIPlus_Set_RangeX
; Description ...: Allows user to set the range of the X axis and set ticks and rounding levels
; Syntax.........: _GraphGDIPlus_Set_RangeX(ByRef $aGraphArray,$iLow,$iHigh,$iXTicks = 1,$bLabels = 1,$iRound = 0)
; Parameters ....:   $aGraphArray - the array returned from _GraphGDIPlus_Create
;                    $iLow - the lowest value for the X axis (can be negative)
;                    $iHigh - the highest value for the X axis
;                    $iXTicks - [optional] number of ticks to show below axis, if = 0 then no ticks created
;                    $bLabels - [optional] 1=show labels, any other number=do not show labels
;                    $iRound - [optional] rounding level of label values
; Return values .: None
; =======================================================================================
Func _GraphGDIPlus_Set_RangeX(ByRef $aGraphArray,$iLow,$iHigh,$iXTicks = 1,$bLabels = 1,$iRound = 0)
    Local $ahTicksX,$ahTicksLabelsX,$i
    ;----- load user vars to array -----
    $aGraphArray[$_GRAPH_XLOW] = $iLow
    $aGraphArray[$_GRAPH_XHIGH] = $iHigh
    ;----- prepare nested array -----
    $ahTicksX = $aGraphArray[$_GRAPH_HXTICKS]
    $ahTicksLabelsX = $aGraphArray[$_GRAPH_HXLABELS]
    ;----- delete any existing ticks -----
    For $i = 1 to (UBound($ahTicksX) - 1)
        GUICtrlDelete($ahTicksX[$i])
    Next
    Dim $ahTicksX[1]
    ;----- create new ticks -----
    For $i = 1 To $iXTicks + 1
        ReDim $ahTicksX[$i + 1]
        $ahTicksX[$i] = GUICtrlCreateLabel("",(($i - 1) * ($aGraphArray[$_GRAPH_WIDTH] / $iXTicks)) + $aGraphArray[$_GRAPH_LEFT], _
        $aGraphArray[$_GRAPH_TOP] + $aGraphArray[$_GRAPH_HEIGHT],1,5)
        GUICtrlSetBkcolor(-1,0x000000)
        GUICtrlSetState(-1,128)
    Next
    ;----- delete any existing labels -----
    For $i = 1 to (UBound($ahTicksLabelsX) - 1)
        GUICtrlDelete($ahTicksLabelsX[$i])
    Next
    Dim $ahTicksLabelsX[1]
    ;----- create new labels -----
    For $i = 1 To $iXTicks + 1
        ReDim $ahTicksLabelsX[$i + 1]
        $ahTicksLabelsX[$i] = GUICtrlCreateLabel("", _
        ($aGraphArray[$_GRAPH_LEFT] + (($aGraphArray[$_GRAPH_WIDTH] / $iXTicks) * ($i - 1))) - (($aGraphArray[$_GRAPH_WIDTH] / $iXTicks) / 2), _
        $aGraphArray[$_GRAPH_TOP] + $aGraphArray[$_GRAPH_HEIGHT] + 10,$aGraphArray[$_GRAPH_WIDTH] / $iXTicks,13,1)
        GUICtrlSetBkcolor(-1,-2)
    Next
    ;----- if labels are required, then fill -----
    If $bLabels = 1 Then
        For $i = 1 To (UBound($ahTicksLabelsX) - 1)
            GUICtrlSetData($ahTicksLabelsX[$i], _
            StringFormat("%." & $iRound & "f",_GraphGDIPlus_Reference_Pixel("p",(($i - 1) * ($aGraphArray[$_GRAPH_WIDTH] / $iXTicks)), _
            $aGraphArray[$_GRAPH_XLOW],$aGraphArray[$_GRAPH_XHIGH],$aGraphArray[$_GRAPH_WIDTH])))
        Next
    EndIf
    ;----- load created arrays back into array -----
    $aGraphArray[$_GRAPH_HXTICKS] = $ahTicksX
    $aGraphArray[$_GRAPH_HXLABELS] = $ahTicksLabelsX
EndFunc



; #FUNCTION# ============================================================================
; Name...........: _GraphGDIPlus_Set_RangeY
; Description ...: Allows user to set the range of the Y axis and set ticks and rounding levels
; Syntax.........: _GraphGDIPlus_SetRange_Y(ByRef $aGraphArray,$iLow,$iHigh,$iYTicks = 1,$bLabels = 1,$iRound = 0)
; Parameters ....:    $aGraphArray - the array returned from _GraphGDIPlus_Create
;                    $iLow - the lowest value for the Y axis (can be negative)
;                    $iHigh - the highest value for the Y axis
;                    $iYTicks - [optional] number of ticks to show next to axis, if = 0 then no ticks created
;                    $bLabels - [optional] 1=show labels, any other number=do not show labels
;                    $iRound - [optional] rounding level of label values
; Return values .: None
; =======================================================================================
Func _GraphGDIPlus_Set_RangeY(ByRef $aGraphArray,$iLow,$iHigh,$iYTicks = 1,$bLabels = 1,$iRound = 0)
    Local $ahTicksY,$ahTicksLabelsY,$i
    ;----- load user vars to array -----
    $aGraphArray[$_GRAPH_YLOW] = $iLow
    $aGraphArray[$_GRAPH_YHIGH] = $iHigh
    ;----- prepare nested array -----
    $ahTicksY = $aGraphArray[$_GRAPH_HYTICKS]
    $ahTicksLabelsY = $aGraphArray[$_GRAPH_HYLABELS]
    ;----- delete any existing ticks -----
    For $i = 1 to (UBound($ahTicksY) - 1)
        GUICtrlDelete($ahTicksY[$i])
    Next
    Dim $ahTicksY[1]
    ;----- create new ticks -----
    For $i = 1 To $iYTicks + 1
        ReDim $ahTicksY[$i + 1]
        $ahTicksY[$i] = GUICtrlCreateLabel("",$aGraphArray[$_GRAPH_LEFT] - 5, _
        ($aGraphArray[$_GRAPH_TOP] + $aGraphArray[$_GRAPH_HEIGHT]) - (($aGraphArray[$_GRAPH_HEIGHT] / $iYTicks) * ($i - 1)),5,1)
        GUICtrlSetBkcolor(-1,0x000000)
        GUICtrlSetState(-1,128)
    Next
    ;----- delete any existing labels -----
    For $i = 1 to (UBound($ahTicksLabelsY) - 1)
        GUICtrlDelete($ahTicksLabelsY[$i])
    Next
    Dim $ahTicksLabelsY[1]
    ;----- create new labels -----
    For $i = 1 To $iYTicks + 1
        ReDim $ahTicksLabelsY[$i + 1]
        $ahTicksLabelsY[$i] = GUICtrlCreateLabel("",$aGraphArray[$_GRAPH_LEFT] - 40, _
        ($aGraphArray[$_GRAPH_TOP] + $aGraphArray[$_GRAPH_HEIGHT]) - (($aGraphArray[$_GRAPH_HEIGHT] / $iYTicks) * ($i - 1)) - 6,30,13,2)
        GUICtrlSetBkcolor(-1,-2)
    Next
    ;----- if labels are required, then fill -----
    If $bLabels = 1 Then
        For $i = 1 To (UBound($ahTicksLabelsY) - 1)
            GUICtrlSetData($ahTicksLabelsY[$i],StringFormat("%." & $iRound & "f",_GraphGDIPlus_Reference_Pixel("p", _
            (($i - 1) * ($aGraphArray[$_GRAPH_HEIGHT] / $iYTicks)),$aGraphArray[$_GRAPH_YLOW],$aGraphArray[$_GRAPH_YHIGH],$aGraphArray[$_GRAPH_HEIGHT])))
        Next
    EndIf
    ;----- load created arrays back into array -----
    $aGraphArray[$_GRAPH_HYTICKS] = $ahTicksY
    $aGraphArray[$_GRAPH_HYLABELS] = $ahTicksLabelsY
EndFunc



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Plot_Start
; Description ...: Move starting point of plot
; Syntax.........: _GraphGDIPlus_Plot_Start(ByRef $aGraphArray,$iX,$iY)
; Parameters ....:   $aGraphArray - the array returned from _GraphGDIPlus_Create
;                    $iX - x value to start at
;                    $iY - y value to start at
; Return values .: None
; ========================================================================================
Func _GraphGDIPlus_Plot_Start(ByRef $aGraphArray,$iX,$iY)
    ;----- MOVE pen to start point -----
    $aGraphArray[$_GRAPH_LASTXPOS] = _GraphGDIPlus_Reference_Pixel("x",$iX,$aGraphArray[$_GRAPH_XLOW],$aGraphArray[$_GRAPH_XHIGH],$aGraphArray[$_GRAPH_WIDTH])
    $aGraphArray[$_GRAPH_LASTYPOS] = _GraphGDIPlus_Reference_Pixel("y",$iY,$aGraphArray[$_GRAPH_YLOW],$aGraphArray[$_GRAPH_YHIGH],$aGraphArray[$_GRAPH_HEIGHT])
EndFunc



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Plot_Line
; Description ...: draws straight line to x,y from previous point / starting point
; Syntax.........: _GraphGDIPlus_Plot_Line(ByRef $aGraphArray,$iX,$iY)
; Parameters ....:   $aGraphArray - the array returned from _GraphGDIPlus_Create
;                    $iX - x value to draw to
;                    $iY - y value to draw to
; Return values .: None
; ========================================================================================
Func _GraphGDIPlus_Plot_Line(ByRef $aGraphArray,$iX,$iY)
    ;----- Draw line from previous point to new point -----
    $iX = _GraphGDIPlus_Reference_Pixel("x",$iX,$aGraphArray[$_GRAPH_XLOW],$aGraphArray[$_GRAPH_XHIGH],$aGraphArray[$_GRAPH_WIDTH])
    $iY = _GraphGDIPlus_Reference_Pixel("y",$iY,$aGraphArray[$_GRAPH_YLOW],$aGraphArray[$_GRAPH_YHIGH],$aGraphArray[$_GRAPH_HEIGHT])
    _GDIPlus_GraphicsDrawLine($aGraphArray[$_GRAPH_HBACKBUFFER],$aGraphArray[$_GRAPH_LASTXPOS],$aGraphArray[$_GRAPH_LASTYPOS],$iX,$iY,$aGraphArray[$_GRAPH_HPEN])
    _GraphGDIPlus_RedrawRect($aGraphArray)
    ;----- save current as last coords -----
    $aGraphArray[$_GRAPH_LASTXPOS] = $iX
    $aGraphArray[$_GRAPH_LASTYPOS] = $iY
EndFunc



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Plot_Point
; Description ...: draws point at coords
; Syntax.........: _GraphGDIPlus_Plot_Point(ByRef $aGraphArray,$iX,$iY)
; Parameters ....:   $aGraphArray - the array returned from _GraphGDIPlus_Create
;                    $iX - x value to draw at
;                    $iY - y value to draw at
; Return values .: None
; ========================================================================================
Func _GraphGDIPlus_Plot_Point(ByRef $aGraphArray,$iX,$iY)
    ;----- Draw point from previous point to new point -----
    $iX = _GraphGDIPlus_Reference_Pixel("x",$iX,$aGraphArray[$_GRAPH_XLOW],$aGraphArray[$_GRAPH_XHIGH],$aGraphArray[$_GRAPH_WIDTH])
    $iY = _GraphGDIPlus_Reference_Pixel("y",$iY,$aGraphArray[$_GRAPH_YLOW],$aGraphArray[$_GRAPH_YHIGH],$aGraphArray[$_GRAPH_HEIGHT])
    _GDIPlus_GraphicsDrawRect($aGraphArray[$_GRAPH_HBACKBUFFER],$iX-1,$iY-1,2,2,$aGraphArray[$_GRAPH_HPEN])
    _GraphGDIPlus_RedrawRect($aGraphArray)
    ;----- save current as last coords -----
    $aGraphArray[$_GRAPH_LASTXPOS] = $iX
    $aGraphArray[$_GRAPH_LASTYPOS] = $iY
EndFunc



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Plot_Dot
; Description ...: draws single pixel dot at coords
; Syntax.........: _GraphGDIPlus_Plot_Dot(ByRef $aGraphArray,$iX,$iY)
; Parameters ....:   $aGraphArray - the array returned from _GraphGDIPlus_Create
;                    $iX - x value to draw at
;                    $iY - y value to draw at
; Return values .: None
; ========================================================================================
Func _GraphGDIPlus_Plot_Dot(ByRef $aGraphArray,$iX,$iY)
    ;----- Draw point from previous point to new point -----
    $iX = _GraphGDIPlus_Reference_Pixel("x",$iX,$aGraphArray[$_GRAPH_XLOW],$aGraphArray[$_GRAPH_XHIGH],$aGraphArray[$_GRAPH_WIDTH])
    $iY = _GraphGDIPlus_Reference_Pixel("y",$iY,$aGraphArray[$_GRAPH_YLOW],$aGraphArray[$_GRAPH_YHIGH],$aGraphArray[$_GRAPH_HEIGHT])
    _GDIPlus_GraphicsDrawRect($aGraphArray[$_GRAPH_HBACKBUFFER],$iX,$iY,1,1,$aGraphArray[$_GRAPH_HPEN]) ;draws 2x2 dot ?HOW to get 1x1 pixel?????
    _GraphGDIPlus_RedrawRect($aGraphArray)
    ;----- save current as last coords -----
    $aGraphArray[$_GRAPH_LASTXPOS] = $iX
    $aGraphArray[$_GRAPH_LASTYPOS] = $iY
EndFunc



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Set_PenColor
; Description ...: sets the Color for the next drawing
; Syntax.........: _GraphGDIPlus_Set_PenColor(ByRef $aGraphArray,$hColor,$hBkGrdColor = $GUI_GR_NOBKColor)
; Parameters ....:   $aGraphArray - the array returned from _GraphGDIPlus_Create
;                    $hColor - the Color of the next item (ARGB)
; Return values .: None
; ========================================================================================
Func _GraphGDIPlus_Set_PenColor(ByRef $aGraphArray,$hColor)
    ;----- apply pen Color -----
    _GDIPlus_PenSetColor($aGraphArray[$_GRAPH_HPEN],$hColor)
EndFunc



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Set_PenSize
; Description ...: sets the pen for the next drawing
; Syntax.........: _GraphGDIPlus_Set_PenSize(ByRef $aGraphArray,$iSize = 1)
; Parameters ....:   $aGraphArray - the array returned from _GraphGDIPlus_Create
;                    $iSize - size of pen line
; Return values .: None
; ========================================================================================
Func _GraphGDIPlus_Set_PenSize(ByRef $aGraphArray,$iSize = 1)
    ;----- apply pen size -----
    _GDIPlus_PenSetWidth($aGraphArray[$_GRAPH_HPEN],$iSize)
EndFunc



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Set_PenDash
; Description ...: sets the pen dash style for the next drawing
; Syntax.........: GraphGDIPlus_Set_PenDash(ByRef $aGraphArray,$iDash = 0)
; Parameters ....:   $aGraphArray - the array returned from _GraphGDIPlus_Create
;                    $iDash - style of dash, where:
;                                       0 = solid line
;                                       1 = simple dashed line
;                                       2 = simple dotted line
;                                       3 = dash dot line
;                                       4 = dash dot dot line
; Return values .: None
; ========================================================================================
Func _GraphGDIPlus_Set_PenDash(ByRef $aGraphArray,$iDash = 0)
    Local $Style

    Switch $iDash
        Case 0 ;solid line _____
            $Style = $GDIP_DASHSTYLESOLID
        Case 1 ;simple dash -----
            $Style = $GDIP_DASHSTYLEDASH
        Case 2 ;simple dotted .....
            $Style = $GDIP_DASHSTYLEDOT
        Case 3 ;dash dot -.-.-
            $Style = $GDIP_DASHSTYLEDASHDOT
        Case 4 ;dash dot dot -..-..-..
            $Style = $GDIP_DASHSTYLEDASHDOTDOT
    EndSwitch

    ;----- apply pen dash -----
    _GDIPlus_PenSetDashStyle($aGraphArray[$_GRAPH_HPEN],$Style)
EndFunc



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Set_GridX
; Description ...: Adds X gridlines.
; Syntax.........: _GraphGDIPlus_Set_GridX(ByRef $aGraphArray, $Ticks=1, $hColor=0xf0f0f0)
; Parameters ....:  $aGraphArray - the array returned from _GraphGDIPlus_Create
;                   $Ticks - sets line at every nth unit assigned to axis
;                   $hColor - [optional] RGB value, defining Color of grid. Default is a light gray
;                   $hColorY0 - [optional] RGB value, defining Color of Y=0 line, Default black
; Return values .: None
; =======================================================================================
Func _GraphGDIPlus_Set_GridX(ByRef $aGraphArray, $Ticks=1, $hColor=0xFFf0f0f0, $hColorY0=0xFF000000)
    ;----- Set gpen to user color -----
    _GDIPlus_PenSetColor($aGraphArray[$_GRAPH_HPENGRID],$hColor)
    ;----- draw grid lines -----
    Select
        Case $Ticks > 0
            For $i = $aGraphArray[$_GRAPH_XLOW] To $aGraphArray[$_GRAPH_XHIGH] Step $Ticks
                If $i = Number($aGraphArray[$_GRAPH_XLOW]) Or $i = Number($aGraphArray[$_GRAPH_XHIGH]) Then ContinueLoop
                    _GDIPlus_GraphicsDrawLine($aGraphArray[$_GRAPH_HBACKBUFFER], _
                    _GraphGDIPlus_Reference_Pixel("x",$i,$aGraphArray[$_GRAPH_XLOW],$aGraphArray[$_GRAPH_XHIGH],$aGraphArray[$_GRAPH_WIDTH]), _
                    1, _
                    _GraphGDIPlus_Reference_Pixel("x",$i,$aGraphArray[$_GRAPH_XLOW],$aGraphArray[$_GRAPH_XHIGH],$aGraphArray[$_GRAPH_WIDTH]), _
                    $aGraphArray[$_GRAPH_HEIGHT] - 1, _
                    $aGraphArray[$_GRAPH_HPENGRID])
            Next
    EndSelect
    ;----- draw y=0 -----
    _GDIPlus_PenSetColor($aGraphArray[$_GRAPH_HPENGRID],$hColorY0)
    _GDIPlus_GraphicsDrawLine($aGraphArray[$_GRAPH_HBACKBUFFER], _
    _GraphGDIPlus_Reference_Pixel("x",0,$aGraphArray[$_GRAPH_XLOW],$aGraphArray[$_GRAPH_XHIGH],$aGraphArray[$_GRAPH_WIDTH]), _
    1, _
    _GraphGDIPlus_Reference_Pixel("x",0,$aGraphArray[$_GRAPH_XLOW],$aGraphArray[$_GRAPH_XHIGH],$aGraphArray[$_GRAPH_WIDTH]), _
    $aGraphArray[$_GRAPH_HEIGHT] - 1, _
    $aGraphArray[$_GRAPH_HPENGRID])
    _GDIPlus_GraphicsDrawLine($aGraphArray[$_GRAPH_HBACKBUFFER], _
    1, _
    _GraphGDIPlus_Reference_Pixel("y",0,$aGraphArray[$_GRAPH_YLOW],$aGraphArray[$_GRAPH_YHIGH],$aGraphArray[$_GRAPH_HEIGHT]), _
    $aGraphArray[$_GRAPH_WIDTH] - 1, _
    _GraphGDIPlus_Reference_Pixel("y",0,$aGraphArray[$_GRAPH_YLOW],$aGraphArray[$_GRAPH_YHIGH],$aGraphArray[$_GRAPH_HEIGHT]), _
    $aGraphArray[$_GRAPH_HPENGRID])
    ;----- re-set to user specs -----
    _GDIPlus_PenSetColor($aGraphArray[$_GRAPH_HPENGRID],$hColor) ;set Color back to user def
EndFunc



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Set_GridY
; Description ...: Adds Y gridlines.
; Syntax.........: _GraphGDIPlus_Set_GridY(ByRef $aGraphArray, $Ticks=1, $hColor=0xf0f0f0)
; Parameters ....:  $aGraphArray - the array returned from _GraphGDIPlus_Create
;                   $Ticks - sets line at every nth unit assigned to axis
;                   $hColor - [optional] RGB value, defining Color of grid. Default is a light gray
;                   $hColorX0 - [optional] RGB value, defining Color of X=0 line, Default black
; Return values .: None
; =======================================================================================
Func _GraphGDIPlus_Set_GridY(ByRef $aGraphArray, $Ticks=1, $hColor=0xFFf0f0f0, $hColorX0=0xFF000000)
    ;----- Set gpen to user color -----
    _GDIPlus_PenSetColor($aGraphArray[$_GRAPH_HPENGRID],$hColor)
    ;----- draw grid lines -----
    Select
        Case $Ticks > 0
            For $i = $aGraphArray[$_GRAPH_YLOW] To $aGraphArray[$_GRAPH_YHIGH] Step $Ticks
                If $i = Number($aGraphArray[$_GRAPH_YLOW]) Or $i = Number($aGraphArray[$_GRAPH_YHIGH]) Then ContinueLoop
                    _GDIPlus_GraphicsDrawLine($aGraphArray[$_GRAPH_HBACKBUFFER], _
                    1, _
                    _GraphGDIPlus_Reference_Pixel("y",$i,$aGraphArray[$_GRAPH_YLOW],$aGraphArray[$_GRAPH_YHIGH],$aGraphArray[$_GRAPH_HEIGHT]), _
                    $aGraphArray[$_GRAPH_WIDTH] - 1, _
                    _GraphGDIPlus_Reference_Pixel("y",$i,$aGraphArray[$_GRAPH_YLOW],$aGraphArray[$_GRAPH_YHIGH],$aGraphArray[$_GRAPH_HEIGHT]), _
                    $aGraphArray[$_GRAPH_HPENGRID])
            Next
    EndSelect
    ;----- draw abcissa/ordinate -----
    _GDIPlus_PenSetColor($aGraphArray[$_GRAPH_HPENGRID],$hColorX0)
    _GDIPlus_GraphicsDrawLine($aGraphArray[$_GRAPH_HBACKBUFFER], _
    _GraphGDIPlus_Reference_Pixel("x",0,$aGraphArray[$_GRAPH_XLOW],$aGraphArray[$_GRAPH_XHIGH],$aGraphArray[$_GRAPH_WIDTH]), _
    1, _
    _GraphGDIPlus_Reference_Pixel("x",0,$aGraphArray[$_GRAPH_XLOW],$aGraphArray[$_GRAPH_XHIGH],$aGraphArray[$_GRAPH_WIDTH]), _
    $aGraphArray[$_GRAPH_HEIGHT] - 1, _
    $aGraphArray[$_GRAPH_HPENGRID])
    _GDIPlus_GraphicsDrawLine($aGraphArray[$_GRAPH_HBACKBUFFER], _
    1, _
    _GraphGDIPlus_Reference_Pixel("y",0,$aGraphArray[$_GRAPH_YLOW],$aGraphArray[$_GRAPH_YHIGH],$aGraphArray[$_GRAPH_HEIGHT]), _
    $aGraphArray[$_GRAPH_WIDTH] - 1, _
    _GraphGDIPlus_Reference_Pixel("y",0,$aGraphArray[$_GRAPH_YLOW],$aGraphArray[$_GRAPH_YHIGH],$aGraphArray[$_GRAPH_HEIGHT]), _
    $aGraphArray[$_GRAPH_HPENGRID])
    ;----- re-set to user specs -----
    _GDIPlus_PenSetColor($aGraphArray[$_GRAPH_HPENGRID],$hColor) ;set Color back to user def
EndFunc



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Refresh
; Description ...: refreshes the graphic
; Syntax.........: _GraphGDIPlus_Refresh(ByRef $aGraphArray)
; Parameters ....:   $aGraphArray - the array returned from _GraphGDIPlus_Create
; Return values .: None
; ========================================================================================
Func _GraphGDIPlus_Refresh(ByRef $aGraphArray)
    ;----- draw -----
    _GDIPlus_GraphicsDrawImageRect($aGraphArray[$_GRAPH_HANDLE],$aGraphArray[$_GRAPH_HBITMAP],$aGraphArray[$_GRAPH_LEFT], _
    $aGraphArray[$_GRAPH_TOP],$aGraphArray[$_GRAPH_WIDTH]+1,$aGraphArray[$_GRAPH_HEIGHT]+1)
EndFunc



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_RedrawRect
; Description ...: INTERNAL FUNCTION - Re-draws the border
; Syntax.........: _GraphGDIPlus_RedrawRect(ByRef $aGraphArray)
; Parameters ....:     $aGraphArray - the array returned from _GraphGDIPlus_Create
; Notes..........: This prevents drawing over the border of the graph area
; Return values .: None
; =========================================================================================
Func _GraphGDIPlus_RedrawRect(ByRef $aGraphArray)
    ;----- draw border -----
    _GDIPlus_GraphicsDrawRect($aGraphArray[$_GRAPH_HBACKBUFFER],0,0,$aGraphArray[$_GRAPH_WIDTH],$aGraphArray[$_GRAPH_HEIGHT],$aGraphArray[$_GRAPH_HPENBORDER]) ;draw border
EndFunc



; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_Reference_Pixel
; Description ...: INTERNAL FUNCTION - performs pixel reference calculations
; Syntax.........: _GraphGDIPlus_Reference_Pixel($iType,$iValue,$iLow,$iHigh,$iTotalPixels)
; Parameters ....:     $iType - "x"=x axis pix, "y" = y axis pix, "p"=value from pixels
;                    $iValue - pixels reference or value
;                    $iLow - lower limit of axis
;                    $iHigh - upper limit of axis
;                    $iTotalPixels - total number of pixels in range (either width or height)
; Return values .: Pixel reference
; =========================================================================================
Func _GraphGDIPlus_Reference_Pixel($iType,$iValue,$iLow,$iHigh,$iTotalPixels)
;----- perform pixel reference calculations -----
    Switch $iType
        Case "x"
            Return (($iTotalPixels/($iHigh-$iLow))*(($iHigh-$iLow)*(($iValue-$iLow)/($iHigh-$iLow))))
        Case "y"
            Return ($iTotalPixels - (($iTotalPixels/($iHigh-$iLow))*(($iHigh-$iLow)*(($iValue-$iLow)/($iHigh-$iLow)))))
        Case "p"
            Return ($iValue / ($iTotalPixels/ ($iHigh - $iLow))) + $iLow
    EndSwitch
EndFunc


; #FUNCTION# =============================================================================
; Name...........: _GraphGDIPlus_SaveImage
; Description ...: INTERNAL FUNCTION - save drawn image to file
; Syntax.........: _GraphGDIPlus_Reference_Pixel($file, $hWnd)
; Parameters ....: $file - filename
;                  $hWnd - handle to GUI
; Return values .: Pixel reference
; Author ........: ptrex, ProgAndy, UEZ
; =========================================================================================
Func _GraphGDIPlus_SaveImage($file, $hWnd)
    Local $hDC, $memBmp, $memDC, $hImage, $w, $h
    Const $SRCCOPY = 0x00CC0020
    If $file <> "" And $hWnd <> "" Then
        $size = WinGetClientSize($hWnd)
        $w = $size[0]
        $h = $size[1]
        $hDC = _WinAPI_GetDC($hWnd)
        $memDC = _WinAPI_CreateCompatibleDC($hDC)
        $memBmp = _WinAPI_CreateCompatibleBitmap($hDC, $w, $h)
        _WinAPI_SelectObject ($memDC, $memBmp)
        _WinAPI_BitBlt($memDC, 0, 0, $w, $h, $hDC, 0, 0, $SRCCOPY)
        $hImage = _GDIPlus_BitmapCreateFromHBITMAP ($memBmp)
        _GDIPlus_ImageSaveToFile($hImage, $file)
        If @error Then
            Return SetError(1, 0, 0)
        Else
            Return SetError(0, 0, 0)
        EndIf
        _GDIPlus_ImageDispose ($hImage)
        _WinAPI_ReleaseDC($hWnd, $hDC)
        _WinAPI_DeleteDC($memDC)
        _WinAPI_DeleteObject ($memBmp)
    Else
        Return SetError(1, 0, 0)
    EndIf
EndFunc

; #FUNCTION# ============================================================================
; Name...........: _GraphGDIPlus_SmoothMode
; Description ...: Set smooth mode(default=1)
; Syntax.........: _GraphGDIPlus_Delete($aGraphArray,$iMode)
; Parameters ....:  $aGraphArray - GUI handle
;                   $iMode - smooth mode
;                     0 - No smooth
;                     1 - Smooth on a box of 8x4
;                     2 - Smooth on a box of 8x8
; Return values .: None
; Author .........: ptrex, ProgAndy, UEZ, winux38
; =======================================================================================
  Func _GraphGDIPlus_SmoothMode(ByRef $aGraphArray,$iMode=0)
      _GDIPlus_GraphicsSetSmoothingMode($aGraphArray[$_GRAPH_HBACKBUFFER], $iMode)
EndFunc