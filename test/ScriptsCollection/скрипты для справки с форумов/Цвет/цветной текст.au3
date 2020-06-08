#include <GuiConstants.au3> 

$GUI = GUICreate("Test Script", 300, 200) 

Dim $aLabel_Data[4][6] 

$aLabel_Data[0][0] = 3 

$aLabel_Data[1][0] = "My " 
$aLabel_Data[1][1] = 0xFF0000 
$aLabel_Data[1][2] = 8.5 
$aLabel_Data[1][3] = 800 
$aLabel_Data[1][4] = 2 

$aLabel_Data[2][0] = "New " 
$aLabel_Data[2][1] = 0x0000FF 
$aLabel_Data[2][2] = 8.5 
$aLabel_Data[2][3] = 800 

$aLabel_Data[3][0] = "Label" 
$aLabel_Data[3][1] = 0x8000FF 
$aLabel_Data[3][2] = 8.5 
$aLabel_Data[3][3] = 400 
$aLabel_Data[3][4] = 4 

_GUICtrlCreateLabelEx($aLabel_Data, 20, 40) 

GUISetState(@SW_SHOW, $GUI) 

While 1 
Switch GUIGetMsg() 
Case $GUI_EVENT_CLOSE 
Exit 
EndSwitch 
WEnd 

Func _GUICtrlCreateLabelEx($aData, $iLeft, $iTop, $iWidth=-1, $iHeight=-1, $nStyle=-1, $nExStyle=-1) 
If Not IsArray($aData) Then Return GUICtrlCreateLabel($aData, $iLeft, $iTop, $iWidth, $iHeight, $nStyle, $nExStyle) 

If UBound($aData, 2) <> 6 Then Return SetError(1, 0, 0) 

Local $a_nLabels[$aData[0][0]+1] 

For $i = 1 To $aData[0][0] 
$a_nLabels[$i] = GUICtrlCreateLabel($aData[$i][0], $iLeft, $iTop, -1, $iHeight, $nStyle, $nExStyle) 
$iLeft += (StringLen($aData[$i][0]) * 7) 

If $aData[$i][1] <> "" Then GUICtrlSetColor(-1, $aData[$i][1]) 

If $aData[$i][2] <> "" Then 
$iSize = $aData[$i][2] 
$iWeight = $aData[$i][3] 
$sAttribute = $aData[$i][4] 
$sFontName = $aData[$i][5] 

GUICtrlSetFont(-1, $iSize, $iWeight, $sAttribute, $sFontName) 
EndIf 
Next 

Return $a_nLabels 
EndFunc  
