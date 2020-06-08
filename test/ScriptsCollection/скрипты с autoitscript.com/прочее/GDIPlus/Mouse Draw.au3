; UEZ
; http://www.autoitscript.com/forum/topic/141547-help-drawing-in-autoit/#entry995768
#include <Misc.au3>
#include <WinAPI.au3>
#include <GDIPlus.au3>
#include <GUIConstants.au3>
#include <EditConstants.au3>
#include <WindowsConstants.au3>

$vU32Dll = DllOpen("User32.dll")

$iGraphicX = 100
$iGraphicY = 5
$iGraphicWidth = 395
$iGraphicHeight = 390

$Spessore_Penna = 2

$frm_Disegno = GUICreate("Mouse Draw", 500, 400)
$idPic = GUICtrlCreatePic("", $iGraphicX, $iGraphicY, $iGraphicWidth, $iGraphicHeight)
GUICtrlSetState(-1, $GUI_DISABLE)
$hPic = GUICtrlGetHandle($idPic)
$cButton_Reset = GUICtrlCreateButton("Reset", 15, 190, 60, 25)
$cButton_Save = GUICtrlCreateButton("Save", 15, 220, 60, 25)
Global $Array_xy[10000][2]

GUISetState()

_GDIPlus_Startup()

$hGraphic = _GDIPlus_GraphicsCreateFromHWND($hPic)
$hBitmap = _GDIPlus_BitmapCreateFromGraphics($iGraphicWidth, $iGraphicHeight, $hGraphic)
$hBuffer = _GDIPlus_ImageGetGraphicsContext($hBitmap)
_GDIPlus_GraphicsSetSmoothingMode($hBuffer, 2)

$hPen_Main = _GDIPlus_PenCreate(0xFF000000, $Spessore_Penna)

$aOldPos = "none"
$punti = 0
_ResetImage()

While 1

	$msg = GUIGetMsg()
	If $msg = $GUI_EVENT_CLOSE Then
		_Exit()
	EndIf
	If $msg = $cButton_Reset Then _ResetImage()
	If $msg = $cButton_Save Then _SaveImage()

	$InfoCursore = GUIGetCursorInfo($frm_Disegno)

	If $InfoCursore[4] = $idPic And _IsPressed("01", $vU32Dll) Then ; Se tasto Mouse Sinistro Premuto e la pressione avviene nel rettangolo dell'area definita di disegno
		If $aOldPos[0] - $iGraphicX <> $InfoCursore[0] - $iGraphicX Or $aOldPos[1] - $iGraphicY <> $InfoCursore[1] - $iGraphicY Then
			$punti += 1
			$Array_xy[0][0] = $punti
			$Array_xy[$punti][0] = $InfoCursore[0] - $iGraphicX
			$Array_xy[$punti][1] = $InfoCursore[1] - $iGraphicY
			_GDIPlus_GraphicsDrawCurve($hBuffer, $Array_xy, $hPen_Main)
			_GDIPlus_GraphicsDrawRect($hBuffer, 0, 0, $iGraphicWidth - 1, $iGraphicHeight - 1) ;Rettangolo Bordo Disegno
			_GDIPlus_GraphicsDrawImageRect($hGraphic, $hBitmap, 0, 0, $iGraphicWidth, $iGraphicHeight)
		EndIf
	Else
		$aOldPos = "none"
		$punti = 0
		$Array_xy[0][0] = $punti
	EndIf

	$aOldPos = $InfoCursore
	Sleep(10)

WEnd
;******************************************************************************************************************************
Func _ResetImage()
	;******************************************************************************************************************************
	_GDIPlus_GraphicsClear($hBuffer, 0xFFFFFFFF)
	_GDIPlus_GraphicsDrawRect($hBuffer, 0, 0, $iGraphicWidth - 1, $iGraphicHeight - 1) ;Rettangolo Bordo Disegno
	_GDIPlus_GraphicsDrawImageRect($hGraphic, $hBitmap, 0, 0, $iGraphicWidth, $iGraphicHeight) ;disegna rettangolo bianco di disegno
EndFunc
;******************************************************************************************************************************
Func _SaveImage()
	;******************************************************************************************************************************
	_GDIPlus_ImageSaveToFile($hBitmap, @DesktopDir & "\File001.jpg")
EndFunc
;******************************************************************************************************************************
Func _Exit()
	;******************************************************************************************************************************
	_GDIPlus_GraphicsDispose($hGraphic)
	_GDIPlus_GraphicsDispose($hBuffer)
	_GDIPlus_BitmapDispose($hBitmap)
	_GDIPlus_PenDispose($hPen_Main)
	_GDIPlus_Shutdown()
	GUIDelete()
	Exit
EndFunc