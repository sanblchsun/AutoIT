#include-once
#include <AutoItObject.au3>
#include "D3D9Constants.au3"
#include "D3D9Structures.au3"

Global $ghD3D9dll, $ghD3DX9dll
_AutoItObject_StartUp()

Func _D3D_Startup()
	$ghD3D9dll = DllOpen("d3d9.dll")
	If $ghD3D9dll = -1 Then Return SetError(1, 0, False)
	$ghD3DX9dll = DllOpen("d3dx9_36.dll")
	If $ghD3DX9dll = -1 Then
		DllClose($ghD3D9dll)
		Return SetError(2, 0, False)
	EndIf

	Return SetError(0, 0, True)
EndFunc

Func _D3D_Shutdown()
	DllClose($ghD3DX9dll)
	DllClose($ghD3D9dll)
EndFunc

Func _D3D_Init($hWnd, $iWidth, $iHeight, $iDeviceType = 1, $fWindowed = True)
	Local $aResult, $pd3d9, $od3d9, $td3dcaps9, $td3dpp, $ivp

	$aResult = DllCall($ghD3D9dll, "ptr", "Direct3DCreate9", "uint", $D3D_SDK_VERSION)
	If @error Then Return SetError(@error, @extended, 0)
	If $aResult[0] = 0 Then Return SetError(-1, 0, 0)

	$pd3d9 = $aResult[0]
	$od3d9 = _AutoItObject_WrapperCreate($pd3d9, $tagIDirect3D9)
	$td3dcaps9 = DllStructCreate($tagD3DCAPS9)
	$od3d9.GetDeviceCaps("long", "uint", 0, "int", $iDeviceType, "ptr", Number(DllStructGetPtr($td3dcaps9)))

	If BitAND(DllStructGetData($td3dcaps9, "DevCaps"), $D3DDEVCAPS_HWTRANSFORMANDLIGHT) Then ; Device can support transformation and lighting in hardware
		$ivp = $D3DCREATE_HARDWARE_VERTEXPROCESSING
	Else
		$ivp = $D3DCREATE_SOFTWARE_VERTEXPROCESSING
	EndIf

	$td3dpp = DllStructCreate($tagD3DPRESENT_PARAMETERS)
	DllStructSetData($td3dpp, "BackBufferWidth", $iWidth)
	DllStructSetData($td3dpp, "BackBufferHeight", $iHeight)
	DllStructSetData($td3dpp, "BackBufferFormat", $D3DFMT_A8R8G8B8)
	DllStructSetData($td3dpp, "BackBufferCount", 1)
	DllStructSetData($td3dpp, "MultiSampleType", $D3DMULTISAMPLE_NONE)
	DllStructSetData($td3dpp, "MultiSampleQuality", 0)
	DllStructSetData($td3dpp, "SwapEffect", $D3DSWAPEFFECT_DISCARD)
	DllStructSetData($td3dpp, "hDeviceWindow", $hWnd)
	DllStructSetData($td3dpp, "Windowed", $fWindowed)
	DllStructSetData($td3dpp, "EnableAutoDepthStencil", True)
	DllStructSetData($td3dpp, "AutoDepthStencilFormat",	$D3DFMT_D24S8)
	DllStructSetData($td3dpp, "Flags", 0)
	DllStructSetData($td3dpp, "FullScreen_RefreshRateInHz", $D3DPRESENT_RATE_DEFAULT)
	DllStructSetData($td3dpp, "PresentationInterval", $D3DPRESENT_INTERVAL_IMMEDIATE)

	$aResult = $od3d9.CreateDevice("long", "uint", 0, "int", $iDeviceType, "hwnd", Number($hWnd), "uint", $ivp, "ptr", Number(DllStructGetPtr($td3dpp)), "ptr*", 0)
	If $aResult[0] <> 0 Then
		DllStructSetData($td3dpp, "AutoDepthStencilFormat", $D3DFMT_D16)
		$aResult = $od3d9.CreateDevice("long", "uint", 0, "int", $iDeviceType, "hwnd", Number($hWnd), "uint", $ivp, "ptr", Number(DllStructGetPtr($td3dpp)), "ptr*", 0)
		If $aResult[0] <> 0 Then
			$od3d9.Release("long")
			Return SetError(-2, 0, 0)
		EndIf
	EndIf

	Return SetError(0, 0, $aResult[7])
EndFunc

Func _D3D_CreateVector3($nX, $nY, $nZ)
	Local $tV = DllStructCreate($tagD3DVECTOR3)
	DllStructSetData($tV, "x", $nX)
	DllStructSetData($tV, "y", $nY)
	DllStructSetData($tV, "z", $nZ)
	Return SetError(0, 0, $tV)
EndFunc

Func _D3D_CreateMaterial($iClrDiffuse = -1, $iClrAmbient = -1, $iClrSpecular = -1, $iClrEmissive = 0, $nPower = 2)
	Local $aClrs[4] = [$iClrDiffuse, $iClrAmbient, $iClrSpecular, $iClrEmissive]
	Local $tMaterial9 = DllStructCreate($tagD3DMATERIAL9), $xClr

	For $i = 0 To 3
		$xClr = Binary($aClrs[$i])
		For $j = 3 To 0 Step -1
			DllStructSetData($tMaterial9, $i+1, Number(BinaryMid($xClr, 4-$j, 1))/255, $j+1)
		Next
	Next

	DllStructSetData($tMaterial9, "Power", $nPower)
	Return $tMaterial9
EndFunc

Func _D3DX_CreateTeapot($pDevice)
	Local $aResult = DllCall($ghD3DX9dll, "long", "D3DXCreateTeapot", "ptr", $pDevice, "ptr*", 0, "ptr", 0)

	If $aResult[0] <> 0 Then Return SetError(1, 0, $aResult[0])
	Return SetError(0, 0, $aResult[2])
EndFunc

Func _D3DX_CreateSprite($pDevice)
	Local $aResult = DllCall($ghD3DX9dll, "long", "D3DXCreateSprite", "ptr", $pDevice, "ptr*", 0)

	If $aResult[0] <> 0 Then Return SetError(1, 0, $aResult[0])
	Return SetError(0, 0, $aResult[2])
EndFunc

Func _D3DX_CreateTextureFromFile($pDevice, $sSrcFile)
	Local $aResult = DllCall($ghD3DX9dll, "long", "D3DXCreateTextureFromFileW", "ptr", $pDevice, "wstr", $sSrcFile, "ptr*", 0)

	If $aResult[0] <> 0 Then Return SetError(1, 0, $aResult[0])
	Return SetError(0, 0, $aResult[3])
EndFunc

Func _D3DX_CreateTextureFromFileEx($pDevice, $sSrcFile, $iWidth, $iHeight, $iMipLevels = 0, $iUsage = 0, $iFormat = 21, $iPool = 1, $iFilter = -1, $iMipFilter = -1, $iColorKey = 0, $pSrcInfo = 0, $pPalette = 0)
	Local $aResult = DllCall($ghD3DX9dll, "long", "D3DXCreateTextureFromFileExW", "ptr", $pDevice, "wstr", $sSrcFile, "uint", $iWidth, "uint", $iHeight, "uint", $iMipLevels, "uint", $iUsage, "int", $iFormat, "int", $iPool, "uint", $iFilter, "uint", $iMipFilter, "uint", $iColorKey, "ptr", $pSrcInfo, "ptr", $pPalette, "ptr*", 0)

	If $aResult[0] <> 0 Then Return SetError(1, 0, $aResult[0])
	Return SetError(0, 0, $aResult[14])
EndFunc

Func _D3DX_MatrixIdentity()
	Local $tD3DMatrix = DllStructCreate($tagD3DMATRIX)

	DllStructSetData($tD3DMatrix, "m", 1, 1)
	DllStructSetData($tD3DMatrix, "m", 1, 6)
	DllStructSetData($tD3DMatrix, "m", 1, 11)
	DllStructSetData($tD3DMatrix, "m", 1, 16)

	Return $tD3DMatrix
EndFunc

Func _D3DX_MatrixLookAtLH($pEye, $pAt, $pUp)
	Local $aResult, $tOut, $pOut

	$tOut = DllStructCreate($tagD3DMATRIX)
	$pOut = DllStructGetPtr($tOut)

	DllCall($ghD3DX9dll, "ptr", "D3DXMatrixLookAtLH", "ptr", $pOut, "ptr", $pEye, "ptr", $pAt, "ptr", $pUp)
	Return SetError(0, 0, $tOut)
EndFunc

Func _D3DX_MatrixMultiply(ByRef $tD3DM1, ByRef $tD3DM2)
	Local $iX, $iY, $iI, $iOffset, $nT, $tD3DM

	$tD3DM = DllStructCreate($tagD3DMATRIX)

	For $iY = 0 To 3
		For $iX = 0 To 3
			$nT = 0

			For $iI = 0 To 3
				$nT += DllStructGetData($tD3DM2, "m", $iY * 4 + $iI + 1) * DllStructGetData($tD3DM1, "m", $iI * 4 + $iX + 1)
			Next
			DllStructSetData($tD3DM, "m", $nT, $iY * 4 + $iX + 1)
		Next
	Next

	Return $tD3DM
EndFunc

Func _D3DX_MatrixPerspectiveFovLH($nFOVy, $nAspect, $nZN, $nZF)
	Local $tOut, $pOut

	$tOut = DllStructCreate($tagD3DMATRIX)
	$pOut = DllStructGetPtr($tOut)
	DllCall($ghD3DX9dll, "ptr", "D3DXMatrixPerspectiveFovLH", "ptr", $pOut, "float", $nFOVy, "float", $nAspect, "float", $nZN, "float", $nZF)
	Return SetError(0, 0, $tOut)
EndFunc

Func _D3DX_MatrixRotationX($nAngle)
	Local $tOut, $pOut

	$tOut = DllStructCreate($tagD3DMATRIX)
	$pOut = DllStructGetPtr($tOut)
	DllCall($ghD3DX9dll, "ptr", "D3DXMatrixRotationX", "ptr", $pOut, "float", $nAngle)
	Return SetError(0, 0, $tOut)
EndFunc

Func _D3DX_MatrixRotationY($nAngle)
	Local $tOut, $pOut

	$tOut = DllStructCreate($tagD3DMATRIX)
	$pOut = DllStructGetPtr($tOut)
	DllCall($ghD3DX9dll, "ptr", "D3DXMatrixRotationY", "ptr", $pOut, "float", $nAngle)
	Return SetError(0, 0, $tOut)
EndFunc

Func _D3DX_MatrixRotationZ($nAngle)
	Local $tOut, $pOut

	$tOut = DllStructCreate($tagD3DMATRIX)
	$pOut = DllStructGetPtr($tOut)
	DllCall($ghD3DX9dll, "ptr", "D3DXMatrixRotationZ", "ptr", $pOut, "float", $nAngle)
	Return SetError(0, 0, $tOut)
EndFunc