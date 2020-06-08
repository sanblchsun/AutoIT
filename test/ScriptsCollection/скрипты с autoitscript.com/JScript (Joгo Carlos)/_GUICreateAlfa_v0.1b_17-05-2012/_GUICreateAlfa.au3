#include-once
; #INDEX# =======================================================================================================================
; Title .........: _GUICreateAlfa.au3
; AutoIt Version : 3.3.0.0++
; Language ......: English
; Description ...: Create an alpha blended form.
; Author(s) .....: João Carlos (jscript FROM Brazil) - DVI-Informática™ 2008.6-2012.2, dvi-suporte@hotmail.com
; Credits .......: Based on the Paul Campbell (PaulIA) demo.
; ===============================================================================================================================

; #INCLUDES# ====================================================================================================================
#include <GDIPlus.au3>
#include <WinAPI.au3>
;================================================================================================================================

; #VARIABLES# ===================================================================================================================
;================================================================================================================================

; #CURRENT# =====================================================================================================================
; _GUICreateAlfa
; ===============================================================================================================================

; #INTERNAL_USE_ONLY#============================================================================================================
; __WM_NCHITTEST
;================================================================================================================================

; #FUNCTION# ====================================================================================================================
; Name ..........: _GUICreateAlfa
; Description ...: Create an alpha blended form.
; Syntax ........: _GUICreateAlfa( Title, Image[, Width [, Height [, Left [, Top ]]]])
; Parameters ....: $sTitle				- The title of the dialog box.
;				   $sImage              - Filename of the picture to be loaded : supported types BMP, JPG, GIF(but not animated).
;                  $iWidth              - [optional] The width of the window. Default is image width.
;                  $iHeight             - [optional] The height of the window. Default is image height.
;                  $iLeft               - [optional] The left side of the dialog box. Default is -1 (the window is centered).
;										If defined, $iTop must also be defined.
;                  $iTop                - [optional] The top of the dialog box. Default is -1 (centered).
; Return values .: None
; Author ........: João Carlos (jscript FROM Brazil)
; Modified ......:
; Remarks .......: Based on the "Shows how to create an alpha blended form" by Paul Campbell (PaulIA)
; Related .......:
; Link ..........:
; Example .......: _GUICreateAlfa(@ScriptDir & "\GUILayered.png")
; ===============================================================================================================================
Func _GUICreateAlfa($sTitle, $sImage, $iWidth = -1, $iHeight = -1, $iLeft = -1, $iTop = -1, $lMove = True)
	Local $hScrDC, $hMemDC, $hBitmap, $hOld, $pSize, $tSize, $pSource, $tSource, $pBlend, $tBlend
	Local $hWnd = 0, $hForm = 0, $hImage, $iError = 0

	If Not FileExists($sImage) Then Return SetError(1, 0, 0)

	;----> Initialize GDI+ library only if not alread started!
	If $ghGDIPDll = 0 Then _GDIPlus_Startup()
	;<----

	;----> Load layered image
	$hImage = _GDIPlus_ImageLoadFromFile($sImage)
	Select
		Case $hImage > 0
			If $iWidth = -1 Then $iWidth = _GDIPlus_ImageGetWidth($hImage)
			If $iHeight = -1 Then $iHeight = _GDIPlus_ImageGetHeight($hImage)
			;<----

			;----> Create an layered window.
			$hWnd = GUICreate($sTitle, $iWidth, $iHeight, $iLeft, $iTop, $WS_POPUP, $WS_EX_LAYERED)
			;<----

			;----> Set Bitmap image into GUI.
			$hScrDC = _WinAPI_GetDC(0)
			$hMemDC = _WinAPI_CreateCompatibleDC($hScrDC)
			$hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
			$hOld = _WinAPI_SelectObject($hMemDC, $hBitmap)
			;-- Create structures.
			$tSize = DllStructCreate($tagSIZE)
			$pSize = DllStructGetPtr($tSize)
			DllStructSetData($tSize, "X", $iWidth)
			DllStructSetData($tSize, "Y", $iHeight)
			$tSource = DllStructCreate($tagPOINT)
			$pSource = DllStructGetPtr($tSource)
			$tBlend = DllStructCreate($tagBLENDFUNCTION)
			$pBlend = DllStructGetPtr($tBlend)
			DllStructSetData($tBlend, "Alpha", 255) ; 255 => Opacity
			DllStructSetData($tBlend, "Format", 1) ; 1 => $AC_SRC_ALPHA
			_WinAPI_UpdateLayeredWindow($hWnd, $hScrDC, 0, $pSize, $hMemDC, $pSource, 0, $pBlend, $ULW_ALPHA)
			;-- Release resources.
			_WinAPI_ReleaseDC(0, $hScrDC)
			_WinAPI_SelectObject($hMemDC, $hOld)
			_WinAPI_DeleteObject($hBitmap)
			_WinAPI_DeleteDC($hMemDC)
			_GDIPlus_ImageDispose($hImage)
			;<----

			;----> Register notification messages.
			If $lMove Then GUIRegisterMsg($WM_NCHITTEST, "__WM_NCHITTEST")
			;<----
			GUISetState(@SW_SHOW, $hWnd)
			;----> Gui for controls...
			$hForm = GUICreate("ControlGUI", $iWidth, $iHeight, $iLeft, $iTop, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $hWnd)
			GUISetBkColor(0xABABAB); For transparency!
			Switch @OSVersion
				Case "WIN_2000", "WIN_XP", "WIN_XPe", "WIN_2003"
					_WinAPI_SetLayeredWindowAttributes($hForm, 0xABABAB, 255, $LWA_COLORKEY);BitOR($LWA_COLORKEY, $LWA_ALPHA))
				Case Else
					_WinAPI_SetLayeredWindowAttributes($hForm, 0xABABAB, 255, BitOR($LWA_COLORKEY, $LWA_ALPHA))
			EndSwitch
			;<----
		Case Else
			$iError = 1
	EndSelect
	;----> Clean up resources used by Microsoft Windows GDI+.
	_GDIPlus_Shutdown()
	;<----
	Return SetError($iError, 0, $hWnd)
EndFunc   ;==>_GUICreateAlfa

; #INTERNAL_USE_ONLY# ===========================================================================================================
; Name ..........: __WM_NCHITTEST
; Description ...: For the layered window, so it can be dragged by clicking anywhere on the image.
; Syntax ........: __WM_NCHITTEST($hWnd, $iMsg, $iwParam, $ilParam)
; Parameters ....: $hWnd                - A handle value.
;                  $iMsg                - An integer value.
;                  $iwParam             - An integer value.
;                  $ilParam             - An integer value.
; Return values .: None
; Author ........: João Carlos (jscript FROM Brazil)
; Modified ......:
; Remarks .......: Based on the "Shows how to create an alpha blended form" by Paul Campbell (PaulIA)
; Related .......:
; Link ..........:
; Example .......: No
; ===============================================================================================================================
Func __WM_NCHITTEST($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg, $iwParam, $ilParam
	If $iMsg = $WM_NCHITTEST Then Return $HTCAPTION
EndFunc   ;==>__WM_NCHITTEST
