; http://www.autoitscript.com/forum/topic/146933-solved-display-picture-as-tooltip/#entry1041041
;coded by UEZ 2012
#include <GUIConstantsEx.au3>
#include <GDIPlus.au3>
#include <WinAPI.au3>
#include <WindowsConstants.au3>
Opt("MustDeclareVars", 1)

_GDIPlus_Startup()
Global Const $STM_SETIMAGE = 0x0172
Global $sPathKey = "HKLM64\SOFTWARE\AutoIt v3\AutoIt\"
If @OSArch = "x64" Then $sPathKey = "HKLM\SOFTWARE\Wow6432Node\AutoIt v3\AutoIt\"
Global $sImage1 = RegRead($sPathKey, "InstallDir") & "\Examples\GUI\msoobe.jpg"
Global $sImage2 = RegRead($sPathKey, "InstallDir") & "\Examples\GUI\Torus.png"

Global $hGUI = GUICreate("Test", 300, 100)
Global $iInput = GUICtrlCreateInput($sImage1, 20, 20, 200, 20)
Global $iInput2 = GUICtrlCreateInput($sImage2, 20, 60, 200, 20)
Global $iBtn = GUICtrlCreateButton("Exit", 240, 26, 50, 50)

Global $hGui_PreviewSize = 200, $iBGColor = 0xF0F0F0
Global $hGui_Preview = GUICreate("", $hGui_PreviewSize, $hGui_PreviewSize + 58, -1, -1, $WS_POPUP + $WS_BORDER, $WS_EX_TOPMOST, $hGUI)
Global $idPic = GUICtrlCreatePic("", 0, 0, $hGui_PreviewSize, $hGui_PreviewSize)
Global $idLabel_Info = GUICtrlCreateLabel("", 0, $hGui_PreviewSize + 8, $hGui_PreviewSize * 2, 50)
GUICtrlSetFont(-1, 9, 400, 0, "Arial", 5)
GUICtrlSetColor(-1, $iBGColor)
GUICtrlSetBkColor(-1, 0x222222)
GUISetState(@SW_HIDE, $hGui_Preview)
GUISetState(@SW_SHOW, $hGUI)
ControlFocus($hGUI, "", $iBtn)

Global $aMouseInfo, $aPosCtrl, $aPosWin, $hBmp_Tmp, $sFile, $bShow = False, $bHide = False

Do
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE, $iBtn
			If $hBmp_Tmp Then _WinAPI_DeleteObject($hBmp_Tmp)
			_GDIPlus_Shutdown()
			GUIDelete($hGui_Preview)
			GUIDelete($hGUI)
			Exit
	EndSwitch
	$aMouseInfo = GUIGetCursorInfo($hGUI)
	Switch $aMouseInfo[4]
		Case $iInput
			$sFile = GUICtrlRead($iInput)
			If FileExists($sFile) And Not $bShow Then
				ShowPreview($sFile, $iInput)
				$bShow = True
				$bHide = False
			EndIf
		Case $iInput2
			$sFile = GUICtrlRead($iInput2)
			If FileExists($sFile) And Not $bShow Then
				ShowPreview($sFile, $iInput2)
				$bShow = True
				$bHide = False
			EndIf
		Case Else
			If Not $bHide Then
				GUISetState(@SW_HIDE, $hGui_Preview)
				$bHide = True
			EndIf
			$bShow = False
	EndSwitch
Until False

Func ShowPreview($sFile, $iCtrl)
	$aPosWin = WinGetPos($hGUI)
	$aPosCtrl = ControlGetPos($hGUI, "", $iCtrl)
	WinMove($hGui_Preview, "", $aPosWin[0] + $aPosCtrl[0] + $aPosCtrl[2], $aPosWin[1] + $aPosCtrl[1] + $aPosCtrl[3])
	$hBmp_Tmp = _GetImage($sFile, $hGui_PreviewSize, $iBGColor)
	_hBmpToPicControl($idPic, $hBmp_Tmp, 1)
	GUISetState(@SW_SHOW, $hGui_Preview)
EndFunc   ;==>ShowPreview

Func _GetImage($sFile, $iWH, $iBkClr = 0xFFFFFF)
	Local $hBmp1, $hBitmap, $hGraphic, $hImage, $iW, $iH, $aGS, $hBmp2, $aFTS
	$aFTS = FileGetTime($sFile)
	If @error Then Return SetError(1, 0, 0)
	$hBmp1 = _WinAPI_CreateBitmap($iWH, $iWH, 1, 32)
	$hBitmap = _GDIPlus_BitmapCreateFromHBITMAP($hBmp1)
	$hGraphic = _GDIPlus_ImageGetGraphicsContext($hBitmap)
	_WinAPI_DeleteObject($hBmp1)
	_GDIPlus_GraphicsClear($hGraphic, BitOR(0xFF000000, $iBkClr))
	$hImage = _GDIPlus_ImageLoadFromFile($sFile)
	$iW = _GDIPlus_ImageGetWidth($hImage)
	$iH = _GDIPlus_ImageGetHeight($hImage)
	GUICtrlSetData($idLabel_Info, StringRegExpReplace($sFile, ".*\\(.*)", "$1") & @LF & Round(FileGetSize($sFile) / 1024, 0) & " kb (" & $iW & " x " & $iH & ")" & @LF & $aFTS[0] & "/" & $aFTS[1] & "/" & $aFTS[2] & " " & $aFTS[3] & ":" & $aFTS[4] & ":" & $aFTS[5])
	$aGS = _GetScale($iW, $iH, $iWH)
	_GDIPlus_GraphicsDrawImageRect($hGraphic, $hImage, $aGS[0], $aGS[1], $aGS[2], $aGS[3])
	_GDIPlus_ImageDispose($hImage)
	_GDIPlus_GraphicsDispose($hGraphic)
	$hBmp2 = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hBitmap)
	_GDIPlus_BitmapDispose($hBitmap)
	Return $hBmp2
EndFunc   ;==>_GetImage

Func _GetScale($iW, $iH, $iWH)
	Local $aRet[4]
	If $iW <= $iWH And $iH <= $iWH Then
		$aRet[2] = $iW
		$aRet[3] = $iH
		$aRet[0] = ($iWH - $aRet[2]) / 2
		$aRet[1] = ($iWH - $aRet[3]) / 2
	ElseIf $iW > $iH Then
		$aRet[2] = $iWH
		$aRet[3] = $iH / ($iW / $iWH)
		$aRet[0] = 0
		$aRet[1] = ($iWH - $aRet[3]) / 2
	ElseIf $iW < $iH Then
		$aRet[2] = $iW / ($iH / $iWH)
		$aRet[3] = $iWH
		$aRet[0] = ($iWH - $aRet[2]) / 2
		$aRet[1] = 0
	ElseIf $iW = $iH Then
		$aRet[2] = $iWH
		$aRet[3] = $iWH
		$aRet[0] = 0
		$aRet[1] = 0
	EndIf
	Return $aRet
EndFunc   ;==>_GetScale

Func _hBmpToPicControl($iCID, ByRef $hBmp, $iFlag = 0)
	Local Const $STM_SETIMAGE = 0x0172
	Local Const $IMAGE_BITMAP = 0
	Local $hOldBmp
	$hOldBmp = GUICtrlSendMsg($iCID, $STM_SETIMAGE, $IMAGE_BITMAP, $hBmp)
	If $hOldBmp Then _WinAPI_DeleteObject($hOldBmp)
	If $iFlag Then _WinAPI_DeleteObject($hBmp)
EndFunc   ;==>_hBmpToPicControl