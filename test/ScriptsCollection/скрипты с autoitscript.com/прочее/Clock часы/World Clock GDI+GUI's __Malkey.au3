; Malkey
; http://www.autoitscript.com/forum/topic/65123-world-clock-gdiguis
#include <GDIPlus.au3>
#include <WinAPI.au3>
#include <GuiConstantsEx.au3>
#include <Date.au3>
#include <Windowsconstants.au3>
#include <Misc.au3>
#include <Constants.au3>

; =============================================================================================
; Description ...: Modified Simple Clock using layered windows into World Clock
; =============================================================================================

Global Const $iDotOpacity   = 250
Global Const $iFaceOpacity   = 80
Global Const $iOpacity      = 128
Global Const $iTickLen      = 0.02
Global Const $AC_SRC_ALPHA   = 1
;Global Const $ULW_ALPHA    = 2
Global Const $nPI           = 3.1415926535897932384626433832795
;Global Const $WM_LBUTTONDOWN = 0x0201  ; Drag Window 1 of 3 addin

Global $scale   = 0.4                   ;0.3  to 1.5
Global $iHourRad = Int(140*$scale)
Global  $iMinRad = Int(200*$scale)
Global  $iRadius = Int(200*$scale)
Global  $iSecRad = Int(200*$scale)
Global $guislock  = 1
Global $iCenter   = Int(200*$scale)
Global Enum $eScrDC=0, $eMemDC, $eBitmap, $eWidth, $eHeight, $eGraphic, $ePen, $eCap, $eBrush, $eFormat, $eFamily, $eFont, $eLayout, $eLast
Global $hDial, $hFace, $hTime, $hHour, $hMin, $hSec, $hDot,$aTime, $aHour, $aMin, $aSec, $aCurr[3][2], $aLast[3][2], $btime, $nMsg
Global  $user32_dll = DllOpen ("user32.dll"), $Msg,$x = 420,$y = 50 ,$hrdiff = 0, $mindiff = 0,$locname = " UTC Time"

Global $ContextMenu, $MenuItemMoveClock, $MenuItemExit,$iRet,$MenuItemreassClock,$viewitemface,$lockpositem,$separator1

Global $scaleb2     = 0.4                   ;0.3  to 1.5
Global $iHourRadb2  = Int(140*$scaleb2)
Global  $iMinRadb2  = Int(200*$scaleb2)
Global  $iRadiusb2  = Int(200*$scaleb2)
Global  $iSecRadb2  = Int(200*$scaleb2)
Global $guislock    = 1
Global $iCenterb2   = Int(200*$scaleb2)
Global $hDialb2, $hFaceb2, $hTimeb2, $hHourb2, $hMinb2, $hSecb2, $hDotb2,$aTimeb2, $aHourb2, $aMinb2, $aSecb2, $aCurrb2[3][2], $aLastb2[3][2], $btimeb2
Global $xb2 = 620,$yb2 = 50 ,$hrdiffb2 =10, $mindiffb2 = 0,$locnameb2 = " A place to be time zone."
Global $ContextMenub2, $MenuItemMoveClockb2, $MenuItemExitb2,$MenuItemreassClockb2,$viewitemfaceb2,$viewitemshowclockb2

Opt ("GUIOnEventMode", 1)
Opt("MustDeclareVars", 1)
w1clock()

Func w1clock( )
    ClockInit()
    FaceDraw ()
    DialDraw ()
    Draw    ()
    DotDraw  ()
    ClockInitb2()
    FaceDrawb2 ()
    DialDrawb2 ()
    Drawb2  ()
    DotDrawb2  ()
    ClockLoop()
    ClockDone()
EndFunc

; ==================================================================================
; Finalize clock
; ==================================================================================
Func ClockDone()
  ; Finalize GDI+ resources
  TimeDone()
  HourDone()
  MinDone ()
  SecDone ()
  TimeDoneb2()
  HourDoneb2()
  MinDoneb2 ()
  SecDoneb2 ()
  ; Finalize GDI+ library
  _GDIPlus_Shutdown()
EndFunc

; ==================================================================================
; Initialize clock
; ==================================================================================
Func ClockInit()
    Local $iX, $iY, $viewitemclock,$MenuItemTimediff
    ; Calculate the dial frame caption size
    $iX =   -(_WinAPI_GetSystemMetrics($SM_CXFRAME))        ; -4
    $iY =   -(_WinAPI_GetSystemMetrics($SM_CYCAPTION) + _WinAPI_GetSystemMetrics($SM_CYFRAME))  ; -23
    ; Allocate the window resources
    $hDial = GUICreate("Clock", $iRadius * 2, $iRadius * 2, $x,  $y, 0, BitOR($WS_EX_LAYERED, $WS_EX_TOPMOST,$WS_EX_ACCEPTFILES))
        GUISetCursor (9, 1, $hDial)
        GuiRegisterMsg($WM_LBUTTONDOWN, "_WinMove") ; Drag Window 2 of 3 addin
        GUISetState()
    $hFace = GUICreate("Face", $iRadius * 1.9, $iRadius * 1.9, $iX, $iY, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $hDial)
        GUISetState()
    $hTime = GUICreate("Time" , $iRadius * 2, $iRadius * 2, $iX, $iY+$iRadius*1.4, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $hDial)
        GUISetState()
    $hHour = GUICreate("Hour" , $iRadius * 2, $iRadius * 2, $iX , $iY, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $hDial)
        GUISetState()
    $hMin  = GUICreate("Min"  , $iRadius * 2, $iRadius * 2, $iX, $iY, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $hDial)
        GUISetState()
    $hSec  = GUICreate("Sec"  , $iRadius * 2, $iRadius * 2, $iX, $iY, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $hDial)
        GUISetState()
    $hDot  = GUICreate("Dot"  , $iRadius * 2, $iRadius * 2, $iX, $iY, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $hDial)
    $ContextMenu = GUICtrlCreateContextMenu ()
    $MenuItemMoveClock = GUICtrlCreateMenuitem ("Disassemble Clock", $ContextMenu, 0)
        GUICtrlSetOnEvent ($MenuItemMoveClock, "DissambleClock")
    $MenuItemreassClock = GUICtrlCreateMenuitem ("Re-assemble Clock", $ContextMenu, 1)
        GUICtrlSetOnEvent ($MenuItemreassClock, "reassembClock")
    $viewitemface = GUICtrlCreateMenuitem ("View Face",$ContextMenu,2)
        GUICtrlSetState($viewitemface,$GUI_CHECKED)
        GUICtrlSetOnEvent ($viewitemface, "viewface")
    $lockpositem = GUICtrlCreateMenuitem ("Lock Pieces Positions",$ContextMenu,3)
        GUICtrlSetState($lockpositem,$GUI_UNCHECKED)
        GUICtrlSetOnEvent ($lockpositem, "LockPos")
    $MenuItemMoveClock = GUICtrlCreateMenuitem ("Resize", $ContextMenu, 4)
        GUICtrlSetOnEvent ($MenuItemMoveClock, "resizeClock")
    $MenuItemTimediff = GUICtrlCreateMenuitem ("Set Time Difference", $ContextMenu, 5)
        GUICtrlSetOnEvent ($MenuItemTimediff, "TimeDiffConfig")
    $viewitemshowclockb2 = GUICtrlCreateMenuitem ("Show Other Clock",$ContextMenu,6)
        GUICtrlSetState($viewitemshowclockb2,$GUI_CHECKED)
        GUICtrlSetOnEvent ($viewitemshowclockb2, "Showclockb2")
    $separator1 = GUICtrlCreateMenuitem ("",$ContextMenu,7) ; create a separator line
    $MenuItemExit = GUICtrlCreateMenuitem ("Exit", $ContextMenu, 8)
        GUICtrlSetOnEvent ($MenuItemExit, "quitclk")
    GUISetState()
    $iRet = DllCall("User32.dll", "int", "SetWindowPos", "Hwnd", $hDial, "Hwnd", $hFace, _
        "int", 100, "int", 100, "int", 100, "int", 100, "uint", $SWP_NOSIZE + $SWP_NOMOVE)
  ; Initialize GDI+ library
    _GDIPlus_Startup()
  ; Initialize GDI+ resources
  TimeInit()
  HourInit()
  MinInit ()
  SecInit ()
  ; Hook non client hit test message so we can move the clock
  GUIRegisterMsg($WM_NCHITTEST, "WM_NCHITTEST")
EndFunc

; ==================================================================================
; Initialize clockb2
; ==================================================================================
Func ClockInitb2()
    Local $iX, $iY
    Local $viewitemclockb2,$MenuItemTimediffb2
    ; Calculate the dial frame caption size
    $iX =   -(_WinAPI_GetSystemMetrics($SM_CXFRAME))        ; -4
    $iY =   -(_WinAPI_GetSystemMetrics($SM_CYCAPTION) + _WinAPI_GetSystemMetrics($SM_CYFRAME))  ; -23
    ; Allocate the window resources
    $hDialb2 = GUICreate("Clockb2", $iRadiusb2 * 2, $iRadiusb2 * 2, $xb2,  $yb2, 0, BitOR($WS_EX_LAYERED, $WS_EX_TOPMOST,$WS_EX_ACCEPTFILES))
    GUISetCursor (9, 1, $hDialb2)
        GuiRegisterMsg($WM_LBUTTONDOWN, "_WinMove") ; Drag Window 2 of 3 addin
        GUISetState()
    $hFaceb2 = GUICreate("Faceb2", $iRadiusb2 * 1.9, $iRadiusb2 * 1.9, $iX, $iY, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $hDialb2)
        GUISetState()
    $hTimeb2 = GUICreate("Timeb2" , $iRadiusb2 * 2, $iRadiusb2 * 2, $iX, $iY+$iRadiusb2*1.4, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $hDialb2)
        GUISetState()
    $hHourb2 = GUICreate("Hourb2" , $iRadiusb2 * 2, $iRadiusb2 * 2, $iX , $iY, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $hDialb2)
        GUISetState()
    $hMinb2  = GUICreate("Minb2"  , $iRadiusb2 * 2, $iRadiusb2 * 2, $iX, $iY, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $hDialb2)
        GUISetState()
    $hSecb2  = GUICreate("Secb2"  , $iRadiusb2 * 2, $iRadiusb2 * 2, $iX, $iY, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $hDialb2)
        GUISetState()
    $hDotb2  = GUICreate("Dotb2"  , $iRadiusb2 * 2, $iRadiusb2 * 2, $iX, $iY, 0, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $hDialb2)

    $ContextMenub2 = GUICtrlCreateContextMenu ()
    $MenuItemMoveClockb2 = GUICtrlCreateMenuitem ("Disassemble Clock", $ContextMenub2, 0)
        GUICtrlSetOnEvent ($MenuItemMoveClockb2, "DissambleClockb2")
    $MenuItemreassClockb2 = GUICtrlCreateMenuitem ("Re-assemble Clock", $ContextMenub2, 1)
        GUICtrlSetOnEvent ($MenuItemreassClockb2, "reassembClockb2")
    $viewitemfaceb2 = GUICtrlCreateMenuitem ("View Face",$ContextMenub2,2)
        GUICtrlSetState($viewitemfaceb2,$GUI_CHECKED)
        GUICtrlSetOnEvent ($viewitemfaceb2, "viewfaceb2")
    $MenuItemMoveClockb2 = GUICtrlCreateMenuitem ("Resize", $ContextMenub2, 3)
        GUICtrlSetOnEvent ($MenuItemMoveClockb2, "resizeClockb2")
    $MenuItemTimediffb2 = GUICtrlCreateMenuitem ("Set Time Difference", $ContextMenub2, 4)
        GUICtrlSetOnEvent ($MenuItemTimediffb2, "TimeDiffConfigb2")
    $separator1 = GUICtrlCreateMenuitem ("",$ContextMenub2,5)   ; create a separator line
    $MenuItemExitb2 = GUICtrlCreateMenuitem ("Exit", $ContextMenub2, 6)
        GUICtrlSetOnEvent ($MenuItemExitb2, "quitclk")
    GUISetState()
    $iRet = DllCall("User32.dll", "int", "SetWindowPos", "Hwnd", $hDialb2, "Hwnd", $hFaceb2, _
        "int", 100, "int", 100, "int", 100, "int", 100, "uint", $SWP_NOSIZE + $SWP_NOMOVE)
  ; Initialize GDI+ library
    _GDIPlus_Startup()
  ; Initialize GDI+ resources
  TimeInitb2()
  HourInitb2()
  MinInitb2 ()
  SecInitb2 ()
  ; Hook non client hit test message so we can move the clock
  GUIRegisterMsg($WM_NCHITTEST, "WM_NCHITTEST")
EndFunc

; ===================================================================================
; Loop until user exits
; ===================================================================================
Func ClockLoop()
    $Msg = GUIGetMsg()
    Do
        Draw   ()
        Drawb2 ()
        sleep(250)
    until $Msg = $GUI_EVENT_CLOSE
EndFunc

; ==================================================================================
; Draw the center dot
; ==================================================================================
Func FaceDraw ()
    Local $aFace
    Local $aDot

    $aFace = ResourceInit($iRadius * 2, $iRadius * 2)
    $aFace[$eBrush] = _GDIPlus_BrushCreateSolid (0xFFE0FFFF)
    _GDIPlus_GraphicsFillEllipse($aFace[$eGraphic], ($iRadius*.09*cos(45*$nPI/180)) , ($iRadius*.09*Sin(45*$nPI/180)) ,$iRadius*1.9 , $iRadius*1.9,  $aFace[$eBrush])
   ResourceSet ($hFace, $aFace, $iFaceOpacity)
    ResourceDone($aFace)
EndFunc

; ================================================================================
; Draw the center dot
; ================================================================================
Func FaceDrawb2 ()
    Local $aFace
    Local $aDot
    $aFace = ResourceInit($iRadiusb2 * 2, $iRadiusb2 * 2)
    $aFace[$eBrush] = _GDIPlus_BrushCreateSolid (0xFFE0FFFF)
    _GDIPlus_GraphicsFillEllipse($aFace[$eGraphic], ($iRadiusb2*.09*cos(45*$nPI/180)) , ($iRadiusb2*.09*Sin(45*$nPI/180)) ,$iRadiusb2*1.9 , $iRadiusb2*1.9,  $aFace[$eBrush])
   ResourceSet ($hFaceb2, $aFace, $iFaceOpacity)
    ResourceDone($aFace)
EndFunc

; ==============================================================================
; Draw the center dot
; ==============================================================================
Func DotDraw()
  Local $aDot

  $aDot = ResourceInit($iRadius * 2, $iRadius * 2)
  $aDot[$eBrush] = _GDIPlus_BrushCreateSolid (0xFF000000)
  _GDIPlus_GraphicsFillEllipse($aDot[$eGraphic], $iRadius-10, $iRadius-10, 20, 20, $aDot[$eBrush])
  ResourceSet ($hDot, $aDot, $iDotOpacity)
  ResourceDone($aDot)
EndFunc

; ==============================================================================
; Draw the center dotColckb2
; ==============================================================================
Func DotDrawb2()
  Local $aDot

  $aDot = ResourceInit($iRadiusb2 * 2, $iRadiusb2 * 2)
  $aDot[$eBrush] = _GDIPlus_BrushCreateSolid (0xFF000000)
  _GDIPlus_GraphicsFillEllipse($aDot[$eGraphic], $iRadiusb2-10, $iRadiusb2-10, 20, 20, $aDot[$eBrush])
  ResourceSet ($hDotb2, $aDot, $iDotOpacity)
  ResourceDone($aDot)
EndFunc

; =============================================================================
; Draw the Clock elements
; =============================================================================
Func Draw ()
  ; Calculate current time element position
  $bTime = ModifyUTCTimeToArray($hrdiff, $mindiff)
  $aLast = $aCurr
  $aCurr[0][0] = $iCenter + Cos(TimeToRadians("sec", $bTime[7], $bTime[9])) * $iSecRad
  $aCurr[0][1] = $iCenter - Sin(TimeToRadians("sec", $bTime[7], $bTime[9] )) * $iSecRad
  $aCurr[1][0] = $iCenter + Cos(TimeToRadians("min", $bTime[7], $bTime[9] )) * $iMinRad
  $aCurr[1][1] = $iCenter - Sin(TimeToRadians("min", $bTime[7], $bTime[9] )) * $iMinRad
  $aCurr[2][0] = $iCenter + Cos(TimeToRadians("hour", $bTime[7], $bTime[9])) * $iHourRad
  $aCurr[2][1] = $iCenter - Sin(TimeToRadians("hour", $bTime[7], $bTime[9])) * $iHourRad
  TimeDraw($bTime[7], $bTime[9], $bTime[6], $bTime[4],$bTime[3],  StringTrimLeft( $bTime[0],2) )
  HourDraw()
  MinDraw ()
  SecDraw ()
EndFunc

; ==============================================================================
; Draw the clockb2 elements
; ==============================================================================
Func Drawb2 ()
  ; Calculate current time element position
  $bTimeb2 = ModifyUTCTimeToArray($hrdiffb2, $mindiffb2)
  $aLastb2 = $aCurrb2
  $aCurrb2[0][0] = $iCenterb2 + Cos(TimeToRadians("sec", $bTimeb2[7], $bTimeb2[9])) * $iSecRadb2
  $aCurrb2[0][1] = $iCenterb2 - Sin(TimeToRadians("sec", $bTimeb2[7], $bTimeb2[9] )) * $iSecRadb2
  $aCurrb2[1][0] = $iCenterb2 + Cos(TimeToRadians("min", $bTimeb2[7], $bTimeb2[9] )) * $iMinRadb2
  $aCurrb2[1][1] = $iCenterb2 - Sin(TimeToRadians("min", $bTimeb2[7], $bTimeb2[9] )) * $iMinRadb2
  $aCurrb2[2][0] = $iCenterb2 + Cos(TimeToRadians("hour", $bTimeb2[7], $bTimeb2[9])) * $iHourRadb2
  $aCurrb2[2][1] = $iCenterb2 - Sin(TimeToRadians("hour", $bTimeb2[7], $bTimeb2[9])) * $iHourRadb2
  TimeDrawb2($bTimeb2[7], $bTimeb2[9], $bTimeb2[6], $bTimeb2[4],$bTimeb2[3], StringTrimLeft( $bTimeb2[0],2) )
  HourDrawb2()
  MinDrawb2 ()
  SecDrawb2 ()
EndFunc

; ===============================================================================
; Draw the Clock dial
; ===============================================================================
Func DialDraw()
  Local $aDial, $hPen1, $hPen2, $iI, $iN, $iX1, $iY1, $iX2, $iY2
  $aDial = ResourceInit($iRadius * 2, $iRadius * 2)
  $hPen1 = _GDIPlus_PenCreate()
  $hPen2 = _GDIPlus_PenCreate(0xFFFF8000, 4)
  for $iI = 0 to 2 * $nPI Step $nPI / 30
    $iX1 = $iCenter + Cos($iI) * ($iRadius * (1.00 - $iTickLen))
    $iY1 = $iCenter - Sin($iI) * ($iRadius * (1.00 - $iTickLen))
    $iX2 = $iCenter + Cos($iI) * $iRadius
    $iY2 = $iCenter - Sin($iI) * $iRadius
    if Mod($iN, 5) = 0 then
    _GDIPlus_GraphicsDrawLine($aDial[$eGraphic], $iX1, $iY1, $iX2, $iY2, $hPen2)
    else
    _GDIPlus_GraphicsDrawLine($aDial[$eGraphic], $iX1, $iY1, $iX2, $iY2, $hPen1)
    endif
    $iN += 1
  next
  _GDIPlus_PenDispose($hPen2)
  _GDIPlus_PenDispose($hPen1)
  ResourceSet ($hDial, $aDial)
  ResourceDone($aDial)
EndFunc

; ============================================================================
; Draw the clockb2 dial
; ============================================================================
Func DialDrawb2()
  Local $aDial, $hPen1, $hPen2, $iI, $iN, $iX1, $iY1, $iX2, $iY2
  $aDial = ResourceInit($iRadiusb2 * 2, $iRadiusb2 * 2)
  $hPen1 = _GDIPlus_PenCreate()
  $hPen2 = _GDIPlus_PenCreate(0xFFFF8000, 4)
  for $iI = 0 to 2 * $nPI Step $nPI / 30
    $iX1 = $iCenterb2 + Cos($iI) * ($iRadiusb2 * (1.00 - $iTickLen))
    $iY1 = $iCenterb2 - Sin($iI) * ($iRadiusb2 * (1.00 - $iTickLen))
    $iX2 = $iCenterb2 + Cos($iI) * $iRadiusb2
    $iY2 = $iCenterb2 - Sin($iI) * $iRadiusb2
    if Mod($iN, 5) = 0 then
    _GDIPlus_GraphicsDrawLine($aDial[$eGraphic], $iX1, $iY1, $iX2, $iY2, $hPen2)
    else
    _GDIPlus_GraphicsDrawLine($aDial[$eGraphic], $iX1, $iY1, $iX2, $iY2, $hPen1)
    endif
    $iN += 1
  next
  _GDIPlus_PenDispose($hPen2)
  _GDIPlus_PenDispose($hPen1)
  ResourceSet ($hDialb2, $aDial)
  ResourceDone($aDial)
EndFunc

; ===========================================================================
; Finalize resources for the hour hand
; ===========================================================================
Func HourDone()
  _GDIPlus_PenDispose($aHour[$ePen])
  _GDIPlus_ArrowCapDispose($aHour[$eCap])
  ResourceDone($aHour)
EndFunc

; ==========================================================================
; Draw the hour hand
; ==========================================================================
Func HourDraw()
  if ($aLast[2][0] = $aCurr[2][0]) and ($aLast[2][1] = $aCurr[2][1]) then Return
  _GDIPlus_GraphicsDrawLine($aHour[$eGraphic], $iCenter, $iCenter, $aCurr[2][0], $aCurr[2][1], $aHour[$ePen])
  ResourceSet($hHour, $aHour)
EndFunc

; ===========================================================================
; Initialize resources for the hour hand
; ===========================================================================
Func HourInit()
  $aHour = ResourceInit($iRadius * 2, $iRadius * 2)
  $aHour[$ePen] = _GDIPlus_PenCreate(0xFFFF00FF)
  $aHour[$eCap] = _GDIPlus_ArrowCapCreate($iHourRad / 2, 8)
  _GDIPlus_PenSetCustomEndCap($aHour[$ePen], $aHour[$eCap])
EndFunc

; ============================================================================
; Finalize resources for the hour hand clockb2
; ============================================================================
Func HourDoneb2()
  _GDIPlus_PenDispose($aHourb2[$ePen])
  _GDIPlus_ArrowCapDispose($aHourb2[$eCap])
  ResourceDone($aHourb2)
EndFunc

; =============================================================================
; Draw the hour hand clockb2
; =============================================================================
Func HourDrawb2()
  if ($aLastb2[2][0] = $aCurrb2[2][0]) and ($aLastb2[2][1] = $aCurrb2[2][1]) then Return
  _GDIPlus_GraphicsDrawLine($aHourb2[$eGraphic], $iCenterb2, $iCenterb2, $aCurrb2[2][0], $aCurrb2[2][1], $aHourb2[$ePen])
  ResourceSet($hHourb2, $aHourb2)
EndFunc

; ============================================================================
; Initialize resources for the hour hand clockb2
; =============================================================================
Func HourInitb2()
  $aHourb2 = ResourceInit($iRadiusb2 * 2, $iRadiusb2 * 2)
  $aHourb2[$ePen] = _GDIPlus_PenCreate(0xFFFF00FF)
  $aHourb2[$eCap] = _GDIPlus_ArrowCapCreate($iHourRadb2 / 2, 8)
  _GDIPlus_PenSetCustomEndCap($aHourb2[$ePen], $aHourb2[$eCap])
EndFunc

; ==============================================================================
; Finalize resources for the minute hand
; ==============================================================================
Func MinDone()
  _GDIPlus_PenDispose($aMin[$ePen])
  _GDIPlus_ArrowCapDispose($aMin[$eCap])
  ResourceDone($aMin)
EndFunc

; ==============================================================================
; Draw the minute hand
; ==============================================================================
Func MinDraw()
  if ($aLast[1][0] = $aCurr[1][0]) and ($aLast[1][1] = $aCurr[1][1]) then Return
  _GDIPlus_GraphicsFillRect($aMin[$eGraphic], 0, 0, $iRadius * 2, $iRadius * 2)
  _GDIPlus_GraphicsDrawLine($aMin[$eGraphic], $iCenter, $iCenter, $aCurr[1][0], $aCurr[1][1], $aMin[$ePen])
  ResourceSet($hMin, $aMin)
EndFunc

; ============================================================================
; Initialize resources for the minute hand
; ============================================================================
Func MinInit()
  $aMin = ResourceInit($iRadius * 2, $iRadius * 2)
  $aMin[$ePen] = _GDIPlus_PenCreate(0xFFFF0000)
  $aMin[$eCap] = _GDIPlus_ArrowCapCreate($iMinRad / 2, 8)
  _GDIPlus_PenSetCustomEndCap($aMin[$ePen], $aMin[$eCap])
EndFunc

; =============================================================================
; Finalize resources for the minute hand clockb2
; =============================================================================
Func MinDoneb2()
  _GDIPlus_PenDispose($aMinb2[$ePen])
  _GDIPlus_ArrowCapDispose($aMinb2[$eCap])
  ResourceDone($aMinb2)
EndFunc

; =============================================================================
; Draw the minute hand clockb2
; =============================================================================
Func MinDrawb2()
  if ($aLastb2[1][0] = $aCurrb2[1][0]) and ($aLastb2[1][1] = $aCurrb2[1][1]) then Return
  _GDIPlus_GraphicsFillRect($aMinb2[$eGraphic], 0, 0, $iRadiusb2 * 2, $iRadiusb2 * 2)
  _GDIPlus_GraphicsDrawLine($aMinb2[$eGraphic], $iCenterb2, $iCenterb2, $aCurrb2[1][0], $aCurrb2[1][1], $aMinb2[$ePen])
  ResourceSet($hMinb2, $aMinb2)
EndFunc

; =============================================================================
; Initialize resources for the minute hand clockb2
; =============================================================================
Func MinInitb2()
  $aMinb2 = ResourceInit($iRadiusb2 * 2, $iRadiusb2 * 2)
  $aMinb2[$ePen] = _GDIPlus_PenCreate(0xFFFF0000)
  $aMinb2[$eCap] = _GDIPlus_ArrowCapCreate($iMinRadb2 / 2, 8)
  _GDIPlus_PenSetCustomEndCap($aMinb2[$ePen], $aMinb2[$eCap])
EndFunc

; =============================================================================
; Finalize resources for the second hand
; ==============================================================================
Func SecDone()
  _GDIPlus_PenDispose($aSec[$ePen])
  ResourceDone($aSec)
EndFunc

; ==============================================================================
; Draw the second hand
; ==============================================================================
Func SecDraw()
  if ($aLast[0][0] = $aCurr[0][0]) and ($aLast[0][1] = $aCurr[0][1]) then Return
  _GDIPlus_GraphicsFillRect($aSec[$eGraphic], 0, 0, $iRadius * 2, $iRadius * 2)
  _GDIPlus_GraphicsDrawLine($aSec[$eGraphic], $iCenter, $iCenter, $aCurr[0][0], $aCurr[0][1], $aSec[$ePen])
  ResourceSet($hSec, $aSec)
EndFunc

; =============================================================================
; Initialize resources for the second hand
; ==============================================================================
Func SecInit()
  $aSec = ResourceInit($iRadius * 2, $iRadius * 2)
  $aSec[$ePen] = _GDIPlus_PenCreate(0xFF000000)
EndFunc

; ==============================================================================
; Finalize resources for the second hand clockb2
; ==============================================================================
Func SecDoneb2()
  _GDIPlus_PenDispose($aSecb2[$ePen])
  ResourceDone($aSecb2)
EndFunc

; ==============================================================================
; Draw the second hand clockb2
; ==============================================================================
Func SecDrawb2()
  if ($aLastb2[0][0] = $aCurrb2[0][0]) and ($aLastb2[0][1] = $aCurrb2[0][1]) then Return
  _GDIPlus_GraphicsFillRect($aSecb2[$eGraphic], 0, 0, $iRadiusb2 * 2, $iRadiusb2 * 2)
  _GDIPlus_GraphicsDrawLine($aSecb2[$eGraphic], $iCenterb2, $iCenterb2, $aCurrb2[0][0], $aCurrb2[0][1], $aSecb2[$ePen])
  ResourceSet($hSecb2, $aSecb2)
EndFunc

; ==============================================================================
; Initialize resources for the second hand clockb2
; =============================================================================
Func SecInitb2()
  $aSecb2 = ResourceInit($iRadiusb2 * 2, $iRadiusb2 * 2)
  $aSecb2[$ePen] = _GDIPlus_PenCreate(0xFF000000)
EndFunc

; ==============================================================================
; Finalize drawing resources
; ==============================================================================
Func ResourceDone(ByRef $aInfo)
  _GDIPlus_GraphicsDispose($aInfo[$eGraphic])
  _WinAPI_ReleaseDC   (0, $aInfo[$eScrDC])
  _WinAPI_DeleteObject($aInfo[$eBitmap])
  _WinAPI_DeleteDC  ($aInfo[$eMemDC ])
EndFunc

; ==============================================================================
; Initialize bitmap resources
; ==============================================================================
Func ResourceInit($iWidth, $iHeight)
  Local $aInfo[$eLast + 1]

  $aInfo[$eScrDC  ] = _WinAPI_GetDC(0)
  $aInfo[$eMemDC  ] = _WinAPI_CreateCompatibleDC($aInfo[$eScrDC])
  $aInfo[$eBitmap ] = _WinAPI_CreateCompatibleBitmap($aInfo[$eScrDC], $iWidth, $iHeight)
  _WinAPI_SelectObject($aInfo[$eMemDC], $aInfo[$eBitmap])
  $aInfo[$eWidth  ] = $iWidth
  $aInfo[$eHeight ] = $iHeight
  $aInfo[$eGraphic] = _GDIPlus_GraphicsCreateFromHDC($aInfo[$eMemDC])
  _GDIPlus_GraphicsFillRect($aInfo[$eGraphic], 0, 0, $iWidth, $iHeight)
  Return $aInfo
EndFunc

; ===============================================================================
; Update layered window with resource information
; ===============================================================================
Func ResourceSet($hGUI, ByRef $aInfo, $iAlpha=-1)
  Local $pSize, $tSize, $pSource, $tSource, $pBlend, $tBlend
  if $iAlpha = -1 then $iAlpha = $iOpacity
  $tSize   = DllStructCreate($tagSIZE)
  $pSize   = DllStructGetPtr($tSize  )
  DllStructSetData($tSize, "X", $aInfo[$eWidth ])
  DllStructSetData($tSize, "Y", $aInfo[$eHeight])
  $tSource = DllStructCreate($tagPOINT)
  $pSource = DllStructGetPtr($tSource)
  $tBlend  = DllStructCreate($tagBLENDFUNCTION)
  $pBlend  = DllStructGetPtr($tBlend )
  DllStructSetData($tBlend, "Alpha" , $iAlpha   )
  DllStructSetData($tBlend, "Format", $AC_SRC_ALPHA)
  _WinAPI_UpdateLayeredWindow($hGUI, $aInfo[$eScrDC], 0, $pSize, $aInfo[$eMemDC], $pSource, 0, $pBlend, $ULW_ALPHA)
EndFunc

; ===========================================================================
; Finalize resources for the digital time
; ===========================================================================
Func TimeDone()
  _GDIPlus_FontDispose      ($aTime[$eFont  ])
  _GDIPlus_FontFamilyDispose  ($aTime[$eFamily])
  _GDIPlus_StringFormatDispose($aTime[$eFormat])
  _GDIPlus_BrushDispose     ($aTime[$eBrush ])
  ResourceDone($aTime)
EndFunc

; ============================================================================
; Draw the digital time
; ============================================================================
Func TimeDraw($hr,$min, $day,  $dayno,$Mth, $yr)
  Local $sString, $aSize
  if ($aLast[0][0] = $aCurr[0][0]) and ($aLast[0][1] = $aCurr[0][1]) then Return
  $sString = StringFormat(" %02d:%02d:%02d %s, %02d %s %02d %s", $hr , $min, @SEC, $day,$dayno,$Mth, $yr, $locname)
  $aSize   = _GDIPlus_GraphicsMeasureString($aTime[$eGraphic], $sString, $aTime[$eFont], $aTime[$eLayout], $aTime[$eFormat])
  DllStructSetData($aTime[$eLayout], "X", $iRadius - (DllStructGetData($aSize[0], "Width") / 2))
  DllStructSetData($aTime[$eLayout], "Y", $iRadius*2/ 3)
  _GDIPlus_GraphicsFillRect($aTime[$eGraphic], 0, 0, $iRadius * 2, $iRadius * 2)
  _GDIPlus_GraphicsDrawStringEx($aTime[$eGraphic], $sString, $aTime[$eFont], $aTime[$eLayout], $aTime[$eFormat], $aTime[$eBrush])
  ResourceSet($hTime, $aTime)
EndFunc

; ==========================================================================
; Initialize resources for the digital time
; ==========================================================================
Func TimeInit()
  $aTime = ResourceInit($iRadius * 2, $iRadius * 2)
  $aTime[$eBrush ] = _GDIPlus_BrushCreateSolid(0xFFFF8000)
  $aTime[$eFormat] = _GDIPlus_StringFormatCreate()
  $aTime[$eFamily] = _GDIPlus_FontFamilyCreate("Arial")
  $aTime[$eFont  ] = _GDIPlus_FontCreate($aTime[$eFamily], Int(24*$scale)+1, 1)
  $aTime[$eLayout] = _GDIPlus_RectFCreate(0, 0, $iRadius * 2 + 20, 100*$scale)
EndFunc

; ============================================================================
; Finalize resources for the digital timeClockb2
; ===========================================================================
Func TimeDoneb2()
  _GDIPlus_FontDispose      ($aTimeb2[$eFont  ])
  _GDIPlus_FontFamilyDispose  ($aTimeb2[$eFamily])
  _GDIPlus_StringFormatDispose($aTimeb2[$eFormat])
  _GDIPlus_BrushDispose     ($aTimeb2[$eBrush ])
  ResourceDone($aTimeb2)
EndFunc

; ============================================================================
; Draw the digital time clockb2
; ============================================================================
Func TimeDrawb2($hr,$min, $day,  $dayno,$Mth, $yr)
  Local $sString, $aSize
  if ($aLastb2[0][0] = $aCurrb2[0][0]) and ($aLastb2[0][1] = $aCurrb2[0][1]) then Return
  $sString = StringFormat(" %02d:%02d:%02d %s, %02d %s %02d %s", $hr , $min, @SEC, $day,$dayno,$Mth, $yr, $locnameb2)
  $aSize   = _GDIPlus_GraphicsMeasureString($aTimeb2[$eGraphic], $sString, $aTimeb2[$eFont], $aTimeb2[$eLayout], $aTimeb2[$eFormat])
  DllStructSetData($aTimeb2[$eLayout], "X", ($iRadiusb2 - (DllStructGetData($aSize[0], "Width") / 2)))
  DllStructSetData($aTimeb2[$eLayout], "Y", $iRadiusb2*2/ 3)
  _GDIPlus_GraphicsFillRect($aTimeb2[$eGraphic], 0, 0, $iRadiusb2 * 2, $iRadiusb2 * 2)
  _GDIPlus_GraphicsDrawStringEx($aTimeb2[$eGraphic], $sString, $aTimeb2[$eFont], $aTimeb2[$eLayout], $aTimeb2[$eFormat], $aTimeb2[$eBrush])
  ResourceSet($hTimeb2, $aTimeb2)
EndFunc

; ============================================================================
; Initialize resources for the digital time clockb2
; ============================================================================
Func TimeInitb2()
  $aTimeb2 = ResourceInit($iRadiusb2 * 2, $iRadiusb2 * 2)
  $aTimeb2[$eBrush ] = _GDIPlus_BrushCreateSolid(0xFFFF8000)
  $aTimeb2[$eFormat] = _GDIPlus_StringFormatCreate()
  $aTimeb2[$eFamily] = _GDIPlus_FontFamilyCreate("Arial")
  $aTimeb2[$eFont  ] = _GDIPlus_FontCreate($aTimeb2[$eFamily], Int(24*$scaleb2)+1, 1)
  $aTimeb2[$eLayout] = _GDIPlus_RectFCreate(0, 0, $iRadiusb2 * 2 + 20, 100*$scaleb2)
EndFunc

; =============================================================================
; Convert time value to radians
; =============================================================================
Func TimeToRadians($sTimeType,$hr ,$min)
  Switch $sTimeType
    case "sec"
    Return ($nPI / 2) - (@SEC  * ($nPI / 30))
    case "min"
    Return ($nPI / 2) - ($min  * ($nPI / 30)) - (Int(@SEC / 10) * ($nPI / 180))
    case "hour"
    Return ($nPI / 2) - ($hr * ($nPI / 6 )) - ($min / 12) * ($nPI / 30)
  EndSwitch
EndFunc

; ============================================================================
; Handle the WM_NCHITTEST message so our window can be dragged
; ============================================================================
Func WM_NCHITTEST($hWnd, $iMsg, $iwParam, $ilParam)
    if $hWnd = $hDial then Return $HTCAPTION
    if $hWnd = $hDialb2 then Return $HTCAPTION
EndFunc

;============================================================================
; $hrdiff = 0, $mindiff = 0 gives UTC time
;TimeMinusLocalTimeToArray(-5)   gives local time which is 5hrs behind UTC      like Jamaica.
;TimeMinusLocalTimeToArray(2,30) gives local time which is 2hrs 30mins infront of  UTC like India.
;try  http://www.timeticker.com/   for World times information
;=============================================================================
Func ModifyUTCTimeToArray($hrdiff = 0, $mindiff = 0)
   Local $tSystem,$tFile, $UTC,$UTC2,$UtcLocForm,$locminusUTC,$sNewDate,$datestr,$datar,$iWeekday
    Local $datearr[12]
    $tSystem = _Date_Time_GetSystemTime()
    $tFile   = _Date_Time_SystemTimeToFileTime(DllStructGetPtr($tSystem))
    $UTC =  StringSplit (_Date_Time_FileTimeToStr($tFile)," ")
    $UTC2 =  StringSplit ($UTC[1], "/")
    $UtcLocForm = $UTC2[3] & "/" & $UTC2[1] & "/" & $UTC2[2] & " " & $UTC[2]
    $locminusUTC = _DateDiff( 'n',_NowCalc(),$UtcLocForm)
    $sNewDate = _DateAdd( 'h',$hrdiff, _NowCalc())
    $sNewDate = _DateAdd( 'n',$mindiff + $locminusUTC , $sNewDate)
    ;MsgBox(0,"",_NowCalc() & "#   File time .:" & _Date_Time_FileTimeToStr($tFile) & "  date" & $sNewDate )
    $datestr = StringReplace ($sNewDate, "/", " ")
    $datestr = StringReplace ($datestr, ":"," ")
    $datar = StringSplit ($datestr , " ")
    ; [0] - No. in array    ;[1] - Year     ; [2] - Month   ; [3] - Day
    ; [4] - Hour            ; [5] - Minute   ; [6] - Second
    $iWeekday = _DateToDayOfWeek ($datar[1], $datar[2], $datar[3])
    $datearr[0] = $datar[1]                         ; Year
    $datearr[1] = $datar[2]                         ; Month number
    $datearr[2] = _DateToMonth($datar[2])           ; Month Long name
    $datearr[3] = _DateToMonth($datar[2],1)         ; Month Abbreviated name
    $datearr[4] = $datar[3]                         ; Day number
    $datearr[5] = _DateDayOfWeek($iWeekDay)         ; Day Long name
    $datearr[6] = _DateDayOfWeek($iWeekDay,1)       ; Day Abbreviated name
    $datearr[7] = $datar[4]                         ; Hour  (24hr )
    $datearr[8] = $datar[4] - (($datar[4] >= 13)*12)  ; Hour  (12hr )
    $datearr[9] = $datar[5]                         ; Minute
    $datearr[10] = $datar[6]                        ; Second
    If $datar[4] < 12 Then                          ; AM/PM
        $datearr[11] = "AM"
    Else
        $datearr[11] = "PM"
    EndIf
    Return $datearr
EndFunc

; ============================================================================
; Randomize Clock components
; ============================================================================
Func DissambleClock()
    Local $nxhr, $nyhr, $nxmin, $nymin,$nxtm, $nytm, $nxdot, $nydot,$nxsec, $nysec, $nxface, $nyface, $WinPos
    $nxhr = Random(@DesktopWidth * 0.25,@DesktopWidth * 0.75, 1)
    $nyhr = Random(@DesktopHeight * 0.25,@DesktopHeight * 0.75, 1)
    $nxmin = Random(@DesktopWidth * 0.25,@DesktopWidth * 0.75, 1)
    $nymin = Random(@DesktopHeight * 0.25,@DesktopHeight * 0.75, 1)
    $nxtm = Random(@DesktopWidth * 0.25,@DesktopWidth * 0.75, 1)
    $nytm = Random(@DesktopHeight * 0.25,@DesktopHeight * 0.75, 1)
    $nxdot = Random(@DesktopWidth * 0.25,@DesktopWidth * 0.75, 1)
    $nydot = Random(@DesktopHeight * 0.25,@DesktopHeight * 0.75, 1)
    $nxsec = Random(@DesktopWidth * 0.25,@DesktopWidth * 0.75, 1)
    $nysec = Random(@DesktopHeight * 0.25,@DesktopHeight * 0.75, 1)
    $nxface = Random(@DesktopWidth * 0.25,@DesktopWidth * 0.75, 1)
    $nyface = Random(@DesktopHeight * 0.25,@DesktopHeight * 0.75, 1)
    $WinPos = WinGetPos("Clock")
    for $m = 1 to 30 step 1
        WinMove("Min","",$WinPos[0]+int(($nxmin - $WinPos[0])*$m/30), $WinPos[1]+int(($nymin - $WinPos[1])*$m/30))
        WinMove("Hour","",$WinPos[0]+int(($nxhr - $WinPos[0])*$m/30), $WinPos[1]+int(($nyhr - $WinPos[1])*$m/30))
        WinMove("Time","",$WinPos[0]+int(($nxtm - $WinPos[0])*$m/30), $WinPos[1]+int(($nytm - $WinPos[1])*$m/30))
        WinMove("Dot","",$WinPos[0]+int(($nxdot - $WinPos[0])*$m/30), $WinPos[1]+int(($nydot - $WinPos[1])*$m/30))
        WinMove("Sec","",$WinPos[0]+int(($nxsec - $WinPos[0])*$m/30), $WinPos[1]+int(($nysec - $WinPos[1])*$m/30))
        WinMove("Face","",$WinPos[0]+int(($nxface - $WinPos[0])*$m/30), $WinPos[1]+int(($nyface - $WinPos[1])*$m/30))
        sleep(30)
    next
EndFunc

; ===========================================================================
; Randomize Clock components
; ===========================================================================
Func reassembClock()
    Local $WinPos, $WinPosmin, $WinPoshr,   $WinPostime, $WinPosdot,$WinPossec, $WinPosface, $adjfacex, $adjfacey, $WinPos
    $WinPos = WinGetPos("Clock")
    $WinPosmin = WinGetPos("Min")
    $WinPoshr = WinGetPos("Hour")
    $WinPostime = WinGetPos("Time")
    $WinPosdot = WinGetPos("Dot")
    $WinPossec = WinGetPos("Sec")
    $WinPosface = WinGetPos("Face")
    $adjfacex = $WinPos[0]-(2)
    $adjfacey = $WinPos[1]-(2)
    for $m = 1 to 30 ;step 10
        WinMove("Min","",$WinPosmin[0]-int(($WinPosmin[0] - $WinPos[0])*$m/30), $WinPosmin[1]-int(($WinPosmin[1] - $WinPos[1])*$m/30))
        WinMove("Hour","",$WinPoshr[0]-int(($WinPoshr[0] - $WinPos[0])*$m/30), $WinPoshr[1]-int(($WinPoshr[1] - $WinPos[1])*$m/30))
        WinMove("Time","",$WinPostime[0]-int(($WinPostime[0] - $WinPos[0])*$m/30), $WinPostime[1]-int(($WinPostime[1] - ($WinPos[1]+5+$WinPos[3]*2/3))*$m/30))
        WinMove("Dot","",$WinPosdot[0]-int(($WinPosdot[0] - $WinPos[0])*$m/30), $WinPosdot[1]-int(($WinPosdot[1] - $WinPos[1])*$m/30))
        WinMove("Sec","",$WinPossec[0]-int(($WinPossec[0] - $WinPos[0])*$m/30), $WinPossec[1]-int(($WinPossec[1] - $WinPos[1])*$m/30))
        WinMove("Face","",$WinPosface[0]-int(($WinPosface[0] - $adjfacex)*$m/30) , $WinPosface[1]-int(($WinPosface[1] - $adjfacey )*$m/30))
        sleep(30)
    next
EndFunc

; ===========================================================================
; Randomize clockb2 components
; ===========================================================================
Func DissambleClockb2()
    Local $nxhr, $nyhr, $nxmin, $nymin,$nxtm, $nytm, $nxdot, $nydot,$nxsec, $nysec, $nxface, $nyface, $WinPos
    $nxhr = Random(@DesktopWidth * 0.25,@DesktopWidth * 0.75, 1)
    $nyhr = Random(@DesktopHeight * 0.25,@DesktopHeight * 0.75, 1)
    $nxmin = Random(@DesktopWidth * 0.25,@DesktopWidth * 0.75, 1)
    $nymin = Random(@DesktopHeight * 0.25,@DesktopHeight * 0.75, 1)
    $nxtm = Random(@DesktopWidth * 0.25,@DesktopWidth * 0.75, 1)
    $nytm = Random(@DesktopHeight * 0.25,@DesktopHeight * 0.75, 1)
    $nxdot = Random(@DesktopWidth * 0.25,@DesktopWidth * 0.75, 1)
    $nydot = Random(@DesktopHeight * 0.25,@DesktopHeight * 0.75, 1)
    $nxsec = Random(@DesktopWidth * 0.25,@DesktopWidth * 0.75, 1)
    $nysec = Random(@DesktopHeight * 0.25,@DesktopHeight * 0.75, 1)
    $nxface = Random(@DesktopWidth * 0.25,@DesktopWidth * 0.75, 1)
    $nyface = Random(@DesktopHeight * 0.25,@DesktopHeight * 0.75, 1)
    ;MsgBox(0,""," $nx=" & $nx &"   $ny=" & $ny & "   wd=" & @DesktopWidth *.15 & "   Hd=" & @DesktopHeight*.15)
    $WinPos = WinGetPos("Clockb2")
    for $m = 1 to 30 step 1
        WinMove("Minb2","",$WinPos[0]+int(($nxmin - $WinPos[0])*$m/30), $WinPos[1]+int(($nymin - $WinPos[1])*$m/30))
        WinMove("Hourb2","",$WinPos[0]+int(($nxhr - $WinPos[0])*$m/30), $WinPos[1]+int(($nyhr - $WinPos[1])*$m/30))
        WinMove("Timeb2","",$WinPos[0]+int(($nxtm - $WinPos[0])*$m/30), $WinPos[1]+int(($nytm - $WinPos[1])*$m/30))
        WinMove("Dotb2","",$WinPos[0]+int(($nxdot - $WinPos[0])*$m/30), $WinPos[1]+int(($nydot - $WinPos[1])*$m/30))
        WinMove("Secb2","",$WinPos[0]+int(($nxsec - $WinPos[0])*$m/30), $WinPos[1]+int(($nysec - $WinPos[1])*$m/30))
        WinMove("Faceb2","",$WinPos[0]+int(($nxface - $WinPos[0])*$m/30), $WinPos[1]+int(($nyface - $WinPos[1])*$m/30))
        sleep(30)
    next
EndFunc

; ========================================================================
; Randomize clockb2 components
; =========================================================================
Func reassembClockb2()
    Local $WinPos, $WinPosmin, $WinPoshr,   $WinPostime, $WinPosdot,$WinPossec, $WinPosface, $adjfacex, $adjfacey, $WinPos
    $WinPos = WinGetPos("Clockb2")
    $WinPosmin = WinGetPos("Minb2")
    $WinPoshr = WinGetPos("Hourb2")
    $WinPostime = WinGetPos("Timeb2")
    $WinPosdot = WinGetPos("Dotb2")
    $WinPossec = WinGetPos("Secb2")
    $WinPosface = WinGetPos("Faceb2")
    $adjfacex = $WinPos[0]-(2)
    $adjfacey = $WinPos[1]-(2)
    ;$adjfacex = $WinPos[0]-($iRadius*.01 *cos(45*$nPI/180))
    ;$adjfacey = $WinPos[1]-($iRadius*.01 *Sin(45*$nPI/180))
    ;MsgBox(0,""," $nx=" & $nx &"   $ny=" & $ny & "   wd=" & @DesktopWidth *.15 & "   Hd=" & @DesktopHeight*.15)

    for $m = 1 to 30 ;step 10
        WinMove("Minb2","",$WinPosmin[0]-int(($WinPosmin[0] - $WinPos[0])*$m/30), $WinPosmin[1]-int(($WinPosmin[1] - $WinPos[1])*$m/30))
        WinMove("Hourb2","",$WinPoshr[0]-int(($WinPoshr[0] - $WinPos[0])*$m/30), $WinPoshr[1]-int(($WinPoshr[1] - $WinPos[1])*$m/30))
        WinMove("Timeb2","",$WinPostime[0]-int(($WinPostime[0] - $WinPos[0])*$m/30), $WinPostime[1]-int(($WinPostime[1] - ($WinPos[1]+5+$WinPos[3]*2/3))*$m/30))
        WinMove("Dotb2","",$WinPosdot[0]-int(($WinPosdot[0] - $WinPos[0])*$m/30), $WinPosdot[1]-int(($WinPosdot[1] - $WinPos[1])*$m/30))
        WinMove("Secb2","",$WinPossec[0]-int(($WinPossec[0] - $WinPos[0])*$m/30), $WinPossec[1]-int(($WinPossec[1] - $WinPos[1])*$m/30))
        WinMove("Faceb2","",$WinPosface[0]-int(($WinPosface[0] - $adjfacex)*$m/30) , $WinPosface[1]-int(($WinPosface[1] - $adjfacey )*$m/30))
        sleep(30)
    next
EndFunc

; ======================================================================
; Exit program
; =====================================================================
Func quitclk()
    $Msg = $GUI_EVENT_CLOSE
EndFunc

Func quitconfig()
    $nMsg = $GUI_EVENT_CLOSE
    MsgBox(0,""," here at quitconfig")
EndFunc

Func _WinMove($HWnd, $Command, $wParam, $lParam)
    If $guislock then
    If BitAND(WinGetState($HWnd), 32) Then Return $GUI_RUNDEFMSG
    ;DllCall("user32.dll", "long", "SendMessage", "hwnd", $HWnd, "int", $WM_SYSCOMMAND, "int", 0xF009, "int", 0)
    dllcall("user32.dll","int","SendMessage","hWnd", $HWnd, "int",$WM_NCLBUTTONDOWN,"int", $HTCAPTION,"int", 0)
    EndIf
    If $HWnd = $hFace Or $HWnd = $hDial Then
        $iRet = DllCall("User32.dll", "int", "SetWindowPos", "Hwnd", $hFace, "Hwnd", $hDial, _
            "int", 100, "int", 100, "int", 100, "int", 100, "uint", $SWP_NOSIZE + $SWP_NOMOVE) ; Z-order Parent $hDial sent to back.
    EndIf
    If $HWnd = $hFaceb2 Or $HWnd = $hDialb2 Then
        $iRet = DllCall("User32.dll", "int", "SetWindowPos", "Hwnd", $hFaceb2, "Hwnd", $hDialb2, _
            "int", 100, "int", 100, "int", 100, "int", 100, "uint", $SWP_NOSIZE + $SWP_NOMOVE) ; Z-order Parent $hDial sent to back.
    EndIf
EndFunc

; ================================================================
; Check if GUI (handle) is GUISetState(@SW_SHOW)- visible
; ================================================================
Func IsVisible($handle)
  If BitAnd( WinGetState($handle), 2 ) Then
    Return 1
  Else
    Return 0
  EndIf
EndFunc

; ============================================================
; Toggle Clock Face  visibility
; =============================================================
Func viewface()
    If BitAnd(GUICtrlRead($viewitemface),$GUI_CHECKED) = $GUI_CHECKED Then
        GUICtrlSetState($viewitemface,$GUI_UNCHECKED)
        GUISetState(@SW_HIDE,$hFace)
    Else
        GUICtrlSetState($viewitemface,$GUI_CHECKED)
        GUISetState(@SW_SHOW,$hFace)
        $iRet = DllCall("User32.dll", "int", "SetWindowPos", "Hwnd", $hFace, "Hwnd", $hDial, _
        "int", 100, "int", 100, "int", 100, "int", 100, "uint", $SWP_NOSIZE + $SWP_NOMOVE) ; Z-order Parent $hDial sent to back.
    EndIf
    ;If IsVisible($hFace) Then
    ;   GUISetState(@SW_HIDE,$hFace)
    ;Else
    ;   GUISetState(@SW_SHOW,$hFace)
    ;EndIf
EndFunc

; =================================================================
; Toggle clockb2 Face  visibility
; ==================================================================
Func viewfaceb2()
    If BitAnd(GUICtrlRead($viewitemfaceb2),$GUI_CHECKED) = $GUI_CHECKED Then
        GUICtrlSetState($viewitemfaceb2,$GUI_UNCHECKED)
        GUISetState(@SW_HIDE,$hFaceb2)
    Else
        GUICtrlSetState($viewitemfaceb2,$GUI_CHECKED)
        GUISetState(@SW_SHOW,$hFaceb2)
        $iRet = DllCall("User32.dll", "int", "SetWindowPos", "Hwnd", $hFaceb2, "Hwnd", $hDialb2, _
        "int", 100, "int", 100, "int", 100, "int", 100, "uint", $SWP_NOSIZE + $SWP_NOMOVE) ; Z-order Parent $hDial sent to back.
    EndIf
EndFunc

; ==================================================================
; Toggle Clock Face  visibility
; ==================================================================
Func Showclockb2()
    If BitAnd(GUICtrlRead($viewitemshowclockb2),$GUI_CHECKED) = $GUI_CHECKED Then
        GUICtrlSetState($viewitemshowclockb2,$GUI_UNCHECKED)
        GUISetState(@SW_HIDE,$hDialb2)
        GUISetState(@SW_HIDE,$hTimeb2)
        GUISetState(@SW_HIDE,$hFaceb2)
        GUISetState(@SW_HIDE,$hDotb2)
        GUISetState(@SW_HIDE,$hHourb2)
        GUISetState(@SW_HIDE,$hMinb2)
        GUISetState(@SW_HIDE,$hSecb2)
    Else
        GUICtrlSetState($viewitemshowclockb2,$GUI_CHECKED)
        GUISetState(@SW_SHOW,$hDialb2)
        GUISetState(@SW_SHOW,$hTimeb2)
        GUISetState(@SW_SHOW,$hFaceb2)
        GUISetState(@SW_SHOW,$hDotb2)
        GUISetState(@SW_SHOW,$hHourb2)
        GUISetState(@SW_SHOW,$hMinb2)
        GUISetState(@SW_SHOW,$hSecb2)
        $iRet = DllCall("User32.dll", "int", "SetWindowPos", "Hwnd", $hFaceb2, "Hwnd", $hDialb2, _
        "int", 100, "int", 100, "int", 100, "int", 100, "uint", $SWP_NOSIZE + $SWP_NOMOVE) ; Z-order Parent $hDial sent to back.
    EndIf
EndFunc

; ==============================================================
; Lock all pieces of Clock in position
; ===============================================================
Func LockPos()
    If BitAnd(GUICtrlRead($lockpositem),$GUI_CHECKED) = $GUI_CHECKED Then
        GUICtrlSetState($lockpositem,$GUI_UNCHECKED)
        $guislock = 1
    Else
        GUICtrlSetState($lockpositem,$GUI_CHECKED)
        $guislock = 0
    EndIf
EndFunc

Func resizeclock()
    Local $MousePos,$MousePos1,$Num,$Mousescale, $modifier = 5
    Opt ("MouseCoordMode", 2)
    $guislock = 0
    GUISetCursor (13, 1, $hDot)
    ToolTip ("Click black dot and drag to resize the clock.  Release to set size.")
    While 1
        $MousePos = MouseGetPos ()
        $Mousescale = ($scale*100*$modifier) +  $MousePos[0]
        If _IsPressed ("01", $user32_dll) Then
            While _IsPressed ("01", $user32_dll)
                $MousePos1 = MouseGetPos ()
                $Num = Int(( $Mousescale - $MousePos1[0]  )/$modifier)
                If $num > 10 and $num < 190 then
                $scale      = $num/100
                $iCenter    = Int(200*$scale)
                $iHourRad   = Int(140*$scale)
                $iMinRad    = Int(200*$scale)
                $iRadius    = Int(200*$scale)
                $iSecRad    = Int(200*$scale)
                HourDone ()
                HourInit ()
                MinDone  ()
                MinInit  ()
                SecDone  ()
                SecInit  ()
                TimeDone ()
                TimeInit ()
                FaceDraw ()
                DialDraw ()
                DotDraw  ()
                Draw ()
                endif
                Sleep (30)
            WEnd
            ExitLoop
        EndIf
        Sleep (10)
    WEnd
    ToolTip ("")
    GUISetCursor ()
    $guislock = 1
    Opt ("MouseCoordMode", 1)
EndFunc

Func resizeClockb2()
    Local $MousePos,$MousePos1,$Num,$Mousescale, $modifier = 5
    Opt ("MouseCoordMode", 2)
    $guislock = 0
    GUISetCursor (13, 1, $hDotb2)
    ToolTip ("Click black dot and drag to resize the clock.  Release to set size.")
    While 1
        $MousePos = MouseGetPos ()
        $Mousescale = ($scaleb2*100*$modifier) +  $MousePos[0]
        If _IsPressed ("01", $user32_dll) Then
            While _IsPressed ("01", $user32_dll)
                $MousePos1 = MouseGetPos ()
                $Num = Int(( $Mousescale - $MousePos1[0]  )/$modifier)
                If $num > 10 and $num < 190 then
                $scaleb2        = $num/100
                $iCenterb2      = Int(200*$scaleb2)
                $iHourRadb2     = Int(140*$scaleb2)
                $iMinRadb2      = Int(200*$scaleb2)
                $iRadiusb2      = Int(200*$scaleb2)
                $iSecRadb2      = Int(200*$scaleb2)
                HourDoneb2 ()
                HourInitb2 ()
                MinDoneb2  ()
                MinInitb2  ()
                SecDoneb2  ()
                SecInitb2  ()
                TimeDoneb2 ()
                TimeInitb2 ()
                FaceDrawb2 ()
                DialDrawb2 ()
                DotDrawb2  ()
                Drawb2 ()
                endif
                Sleep (30)
            WEnd
            ExitLoop
        EndIf
        Sleep (10)
    WEnd
    ToolTip ("")
    GUISetCursor ()
    $guislock = 1
    Opt ("MouseCoordMode", 1)
EndFunc

;=======================================================================
;Set time difference for Clock
;=======================================================================
Func TimeDiffConfig()
    Local $Form2,$GroupBox1,$Input1,$Input2,$inputtimezone,$MyButton1,$MyButton2,$Label1,$Label2,$Label3,$Button1
    Opt ("GUIOnEventMode", 0)
    $Form2 = GUICreate("Time Difference Configure", 292, 183, 351, 263, BitOR($WS_SYSMENU,$WS_CAPTION,$WS_POPUP,$WS_POPUPWINDOW,$WS_BORDER,$WS_CLIPSIBLINGS))
    GUISetIcon("D:\003.ico")
    GUISetBkColor(0xA6CAF0)
    $GroupBox1 = GUICtrlCreateGroup("", 0, -1, 291, 143)
    $Input1 = GUICtrlCreateInput("", 22, 44, 61, 24)
    GUICtrlSetBkColor(-1, 0xFFFFE1)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    $MyButton1 = GUICtrlCreateUpdown( $Input1)
            GUICtrlSetLimit(-1, 23,-23)
            GUICtrlSetData ($input1, $hrdiff )
    $Label1 = GUICtrlCreateLabel("Select Hours", 14, 22, 93, 20)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    $Input2 = GUICtrlCreateInput("", 165, 43, 61, 24)
    GUICtrlSetBkColor(-1, 0xFFFFE1)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    $MyButton2 = GUICtrlCreateUpdown( $Input2)
            GUICtrlSetLimit(-1, 59,-59)
            GUICtrlSetData ($input2, $mindiff)
    $Label2 = GUICtrlCreateLabel("Select Hours", 157, 21, 93, 20)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    $inputtimezone = GUICtrlCreateInput($locname, 4, 108, 281, 21)
    GUICtrlSetFont(-1, 10, 600, 0, "MS Sans Serif")
    $Label3 = GUICtrlCreateLabel("Enter text to display (Time Zone)", 28, 88, 228, 20)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    GUICtrlCreateGroup("", -99, -99, 1, 1)
    $Button1 = GUICtrlCreateButton("&OK", 105, 149, 75, 25, 0)
    GUISetState(@SW_SHOW)
    While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
            Case $GUI_EVENT_CLOSE, $Button1
                GUISetState(@SW_HIDE,$Form2)
                ExitLoop
        EndSwitch
        $hrdiff  = GUICtrlRead($input1)
        $mindiff = GUICtrlRead($input2)
        $locname = GUICtrlRead($inputtimezone)
        HourDone ()
        HourInit ()
        MinDone  ()
        MinInit  ()
        SecDone  ()
        SecInit  ()
        TimeDone ()
        TimeInit ()
        FaceDraw ()
        DialDraw ()
        DotDraw  ()
        Draw    ()
        Sleep (30)
    WEnd
    Opt ("GUIOnEventMode", 1)
    Return 1
EndFunc

;=======================================================================
;Set time difference for clockb2
;=======================================================================
Func TimeDiffConfigb2()
    Local $Form2,$GroupBox1,$Input1,$Input2,$inputtimezone,$MyButton1,$MyButton2,$Label1,$Label2,$Label3,$Button1
    Opt ("GUIOnEventMode", 0)
    $Form2 = GUICreate("Time Difference Configure", 292, 183, 351, 263, BitOR($WS_SYSMENU,$WS_CAPTION,$WS_POPUP,$WS_POPUPWINDOW,$WS_BORDER,$WS_CLIPSIBLINGS))
    GUISetIcon("D:\003.ico")
    GUISetBkColor(0xA6CAF0)
    $GroupBox1 = GUICtrlCreateGroup("", 0, -1, 291, 143)
    $Input1 = GUICtrlCreateInput("", 22, 44, 61, 24)
    GUICtrlSetBkColor(-1, 0xFFFFE1)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    $MyButton1 = GUICtrlCreateUpdown( $Input1)
            GUICtrlSetLimit(-1, 23,-23)
            GUICtrlSetData ($input1, $hrdiffb2 )
    $Label1 = GUICtrlCreateLabel("Select Hours", 14, 22, 93, 20)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    $Input2 = GUICtrlCreateInput("", 165, 43, 61, 24)
    GUICtrlSetBkColor(-1, 0xFFFFE1)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    $MyButton2 = GUICtrlCreateUpdown( $Input2)
            GUICtrlSetLimit(-1, 59,-59)
            GUICtrlSetData ($input2, $mindiffb2)
    $Label2 = GUICtrlCreateLabel("Select Hours", 157, 21, 93, 20)
    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    $inputtimezone = GUICtrlCreateInput($locnameb2, 4, 108, 281, 21)
    GUICtrlSetFont(-1, 10, 600, 0, "MS Sans Serif")
    $Label3 = GUICtrlCreateLabel("Enter text to display (Time Zone)", 28, 88, 228, 20)

    GUICtrlSetFont(-1, 10, 800, 0, "MS Sans Serif")
    GUICtrlCreateGroup("", -99, -99, 1, 1)
    $Button1 = GUICtrlCreateButton("&OK", 105, 149, 75, 25, 0)
    GUISetState(@SW_SHOW)
    While 1
        $nMsg = GUIGetMsg()
        Switch $nMsg
            Case $GUI_EVENT_CLOSE, $Button1
                GUISetState(@SW_HIDE,$Form2)
                ExitLoop
        EndSwitch
        $hrdiffb2  = GUICtrlRead($input1)
        $mindiffb2 = GUICtrlRead($input2)
        $locnameb2 = GUICtrlRead($inputtimezone)
        HourDoneb2 ()
        HourInitb2 ()
        MinDoneb2  ()
        MinInitb2  ()
        SecDoneb2  ()
        SecInitb2  ()
        TimeDoneb2 ()
        TimeInitb2 ()
        FaceDrawb2 ()
        DialDrawb2 ()
        DotDrawb2  ()
        Drawb2  ()
        Sleep (30)
    WEnd
    Drawb2  ()
    Opt ("GUIOnEventMode", 1)
    Return 1
EndFunc