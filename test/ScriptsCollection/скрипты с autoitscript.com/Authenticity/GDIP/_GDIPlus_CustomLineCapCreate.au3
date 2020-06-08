#include <GDIP.au3>
#include <GUIConstantsEx.au3>
Opt("MustDeclareVars", 1)

_Example()

Func _Example()
	Local $hGUI, $hGraphics, $hPath, $hCustomLineCap, $hClonedLineCap, $hPen
	Local $avPoints[4][2] = [[3], [-15, -15], [0, 0], [15, -15]]
	
	; Initialize GDI+
	_GDIPlus_Startup()
	
	$hGUI = GUICreate("_GDIPlus_CustomLineCapCreate Example", 400, 200)
	GUISetState()
	
	$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
	
	; Create GraphicsPath and add two lines to it.
    $hPath = _GDIPlus_PathCreate()
    _GDIPlus_PathAddLines($hPath, $avPoints)

	; Create a CustomLineCap object.
	$hCustomLineCap = _GDIPlus_CustomLineCapCreate(0, $hPath)

	; Create a clone CustomLineCap object.
	$hClonedLineCap = _GDIPlus_CustomLineCapClone($hCustomLineCap)

	; Create a Pen object, assign cloned cap as the custom end cap, and draw a line.
	$hPen = _GDIPlus_PenCreate()
	_GDIPlus_PenSetCustomEndCap($hPen, $hClonedLineCap)
   
	_GDIPlus_GraphicsDrawLine($hGraphics, 0, 0, 100, 100, $hPen)
	
	Do
	Until GUIGetMsg() = $GUI_EVENT_CLOSE
	
	; Clean up
	_GDIPlus_PenDispose($hPen)
	_GDIPlus_CustomLineCapDispose($hClonedLineCap)
	_GDIPlus_CustomLineCapDispose($hCustomLineCap)
	_GDIPlus_PathDispose($hPath)
	_GDIPlus_GraphicsDispose($hGraphics)
	
	; Uninitialize GDI+
	_GDIPlus_Shutdown()
EndFunc