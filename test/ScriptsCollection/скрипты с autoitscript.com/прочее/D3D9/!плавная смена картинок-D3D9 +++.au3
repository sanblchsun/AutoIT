#include "D3D9.au3"
#include <File.au3>
#include <WindowsConstants.au3>
Opt("MustDeclareVars", 1)
Opt("GUIOnEventMode", 1)

Local Const $sFolder = "Images"
Local Const $sFolderPath = @ScriptDir & "\" & $sFolder

Local Const $iWidth = 640, $iHeight = 480
Local const $nRatio = $iWidth / $iHeight
Local Const $FVF_VERTEX = BitOR($D3DFVF_XYZ, $D3DFVF_TEX1)
Local $aFiles = _FileListToArray($sFolderPath, "*.jpg", 1)
If @error Then Exit MsgBox(0x10, "Error", 'Could not locate image folder: "' & $sFolder & '"')

Local $hGUI = GUICreate("", $iWidth, $iHeight, -1, -1, $WS_POPUP)
Local $pDevice, $oDevice, $pTextureOut, $oTextureOut, $pTextureIn, $oTextureIn, $pVB, $oVB
Local $tMtrlOut, $pMtrlOut, $tMtrlIn, $pMtrlIn
Local $iImgIdx = 2, $iImgMax = $aFiles[0]

_D3D_Startup()
$pDevice = _D3D_Init($hGUI, $iWidth, $iHeight)
$oDevice = _AutoItObject_WrapperCreate($pDevice, $tagID3DDevice9Interface)

$pTextureOut = _D3DX_CreateTextureFromFile($pDevice, $sFolderPath & "\" & $aFiles[1])
$oTextureOut = _AutoItObject_WrapperCreate($pTextureOut, $tagIDirect3DTexture9)
$pTextureIn  = _D3DX_CreateTextureFromFile($pDevice, $sFolderPath & "\" & $aFiles[2])
$oTextureIn  = _AutoItObject_WrapperCreate($pTextureIn, $tagIDirect3DTexture9)

_Setup()
GUISetOnEvent(-3, "_Quit")
OnAutoItExitRegister("_Cleanup")
GUISetState()

Local $nOpacityOut = 1, $nOpacityIn = 0
Local $nTimer = TimerInit()

While 1
    _Render()
    _HighPrecisionSleep(4000)

    $nOpacityOut -= 0.005
    $nOpacityIn  += 0.005

    If $nOpacityOut > 1 Then
        $nOpacityOut = 1
    ElseIf $nOpacityOut < 0 Then
        $nOpacityOut = 0
    EndIf

    If $nOpacityIn > 1 Then
        $nOpacityIn = 1
    ElseIf $nOpacityIn < 0 Then
        $nOpacityIn = 0
    EndIf

    If TimerDiff($nTimer) > 3000 Then
        $nOpacityOut = 1
        $nOpacityIn  = 0
        $iImgIdx += 1
        If $iImgIdx > $iImgMax Then $iImgIdx = 1
        _UpdateTextures($iImgIdx)
        $nTimer = TimerInit()
    EndIf
WEnd

Func _UpdateTextures($iIndex)
    $pTextureOut = 0
    $oTextureOut = 0
    $pTextureOut = $pTextureIn
    $oTextureOut = $oTextureIn
    $pTextureIn  = _D3DX_CreateTextureFromFile($pDevice, $sFolderPath & "\" & $aFiles[$iIndex])
    $oTextureIn  = _AutoItObject_WrapperCreate($pTextureIn, $tagIDirect3DTexture9)
EndFunc

Func _Render()
    $oDevice.Clear("long", "uint", 0, "ptr", 0, "uint", BitOR($D3DCLEAR_TARGET, $D3DCLEAR_ZBUFFER), "uint", 0, "float", 1, "uint", 0)
    $oDevice.BeginScene("long")

    DllStructSetData($tMtrlOut, "Diffuse", $nOpacityOut, 4)
    DllStructSetData($tMtrlIn, "Diffuse", $nOpacityIn, 4)

    If IsObj($oTextureOut) And IsObj($oTextureIn) Then

        ; Set our vertex buffer as the source of the triangles vertices
        $oDevice.SetStreamSource("long", "uint", 0, "ptr", Number($pVB), "uint", 0, "uint", 20)
        ; Set the flexible vertex format (xyz and texture coordinates in this example)
        $oDevice.SetFVF("long", "uint", $FVF_VERTEX)

        ; Set materials and textures and draw
        $oDevice.SetMaterial("long", "ptr", Number($pMtrlOut))
        $oDevice.SetTexture("long", "uint", 0, "ptr", Number($pTextureOut))
        $oDevice.DrawPrimitive("long", "int", $D3DPT_TRIANGLEFAN, "uint", 0, "uint", 2)

        $oDevice.SetMaterial("long", "ptr", Number($pMtrlIn))
        $oDevice.SetTexture("long", "uint", 0, "ptr", Number($pTextureIn))
        $oDevice.DrawPrimitive("long", "int", $D3DPT_TRIANGLEFAN, "uint", 0, "uint", 2)
    EndIf

    $oDevice.EndScene("long")
    ; Present our next scene for rendering (swap back and front buffers)
    $oDevice.Present("long", "ptr", 0, "ptr", 0, "hwnd", 0, "ptr", 0)
EndFunc

Func _Setup()
    Local $aResult, $tLight, $tVertex, $pVertex
    Local $aVertices[4][5] = [ _
    [-$nRatio,  1, 1, 0, 0], _
    [ $nRatio,  1, 1, 1, 0], _
    [ $nRatio, -1, 1, 1, 1], _
    [-$nRatio, -1, 1, 0, 1]]

    $tMtrlOut = _D3D_CreateMaterial()
    $pMtrlOut = DllStructGetPtr($tMtrlOut)
    $tMtrlIn  = _D3D_CreateMaterial()
    $pMtrlIn  = DllStructGetPtr($tMtrlIn)

    $aResult = $oDevice.CreateVertexBuffer("long", "uint", 4 * 20, "uint", $D3DUSAGE_WRITEONLY, "uint", $FVF_VERTEX, "int", $D3DPOOL_MANAGED, "ptr*", 0, "ptr", 0)
    $pVB = $aResult[6]
    $oVB = _AutoItObject_WrapperCreate($pVB, $tagIDirect3DVertexBuffer9)

    $aResult = $oVB.Lock("long", "uint", 0, "uint", 0, "ptr*", 0, "uint", 0)
    $pVertex = $aResult[4]
    $tVertex = DllStructCreate("float[" & 4 * 5 & "]", $pVertex)

    For $i = 0 To UBound($aVertices)-1
        For $j = 0 To UBound($aVertices, 2)-1
            DllStructSetData($tVertex, 1, $aVertices[$i][$j], $i*5+$j+1)
        Next
    Next

    $oVB.Unlock("long")

    $tLight = DllStructCreate($tagD3DLIGHT9)
    DllStructSetData($tLight, "Type", $D3DLIGHT_DIRECTIONAL)
    For $i = 1 To 4
        DllStructSetData($tLight, "Diffuse", 1, $i)
        DllStructSetData($tLight, "Specular", 1, $i)
        DllStructSetData($tLight, "Ambient", 1, $i)
    Next

    $oDevice.SetLight("long", "uint", 0, "ptr", Number(DllStructGetPtr($tLight)))
    $oDevice.LightEnable("long", "uint", 0, "bool", True)

    $oDevice.SetSamplerState("long", "uint", 0, "int", $D3DSAMP_MAGFILTER, "uint", $D3DTEXF_LINEAR)
    $oDevice.SetSamplerState("long", "uint", 0, "int", $D3DSAMP_MINFILTER, "uint", $D3DTEXF_LINEAR)
    $oDevice.SetSamplerState("long", "uint", 0, "int", $D3DSAMP_MIPFILTER, "uint", $D3DTEXF_POINT)

    $oDevice.SetTextureStageState("long", "uint", 0, "int", $D3DTSS_ALPHAARG1, "uint", $D3DTA_DIFFUSE)
    $oDevice.SetTextureStageState("long", "uint", 0, "int", $D3DTSS_ALPHAOP, "uint", $D3DTOP_SELECTARG1)

    $oDevice.SetRenderState("long", "int", $D3DRS_SRCBLEND, "uint", $D3DBLEND_SRCALPHA)
    $oDevice.SetRenderState("long", "int", $D3DRS_DESTBLEND, "uint", $D3DBLEND_INVSRCALPHA)

    Local $tProj = _D3DX_MatrixPerspectiveFovLH(ASin(1), $nRatio, 1, 1000)
    $oDevice.SetTransform("long", "int", $D3DTS_PROJECTION, "ptr", Number(DllStructGetPtr($tProj)))
    ; Enable alpha-blend channel processing
    $oDevice.SetRenderState("long", "int", $D3DRS_ALPHABLENDENABLE, "uint", True)
EndFunc

Func _Quit()
    Exit
EndFunc

Func _Cleanup()
    If IsObj($oTextureIn) Then $oTextureIn = 0
    If IsObj($oTextureOut) Then $oTextureOut = 0
    If IsObj($oVB) Then $oVB = 0
    $oDevice = 0
    GUIDelete()
    _D3D_Shutdown()
EndFunc

; #FUNCTION#;===============================================================================
;
; Name...........: _HighPrecisionSleep()
; Description ...: Sleeps down to 0.1 microseconds
; Syntax.........: _HighPrecisionSleep( $iMicroSeconds, $hDll=False)
; Parameters ....:  $iMicroSeconds      - Amount of microseconds to sleep
;                  $hDll  - Can be supplied so the UDF doesn't have to re-open the dll all the time.
; Return values .: None
; Author ........: Andreas Karlsson (monoceres)
; Modified.......:
; Remarks .......: Even though this has high precision you need to take into consideration that it will take some time for autoit to call the function.
; Related .......:
; Link ..........;
; Example .......; No
;
;;==========================================================================================
Func _HighPrecisionSleep($iMicroSeconds,$hDll=False)
    Local $hStruct, $bLoaded
    If Not $hDll Then
        $hDll=DllOpen("ntdll.dll")
        $bLoaded=True
    EndIf
    $hStruct=DllStructCreate("int64 time;")
    DllStructSetData($hStruct,"time",-1*($iMicroSeconds*10))
    DllCall($hDll,"dword","ZwDelayExecution","int",0,"ptr",DllStructGetPtr($hStruct))
    If $bLoaded Then DllClose($hDll)
EndFunc
 