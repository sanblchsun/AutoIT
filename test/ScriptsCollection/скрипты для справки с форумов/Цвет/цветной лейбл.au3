#include <GUIConstantsEx.au3> 
#include <StaticConstants.au3> 
; 

$hGUI = GUICreate("_GUICtrlCreateTFLabel Example", 300, 200) 

$sLabel1_Data = _ 
'some simple data and... <font color="0xFF0000" size="8.5" weight="800" attrib="2">My</font> ' & _ 
'<font color="0x0000FF" size="9" weight="800">Colored</font> ' & _ 
'<font color="0x008000" attrib="4" size="8.5" name="Tahoma">Label</font> data.' 

$sLabel2_Data = _ 
'<font top="1">and</font> ' & _ 
'<font color="0x0000FF" size="9" weight="800">Few</font> ' & _ 
'<font color="0xFF8000" size="9" weight="800" style="' & BitOr($GUI_SS_DEFAULT_LABEL, $SS_NOPREFIX) & '">&more&</font> ' & _ 
'<font color="0x000080" size="12" weight="800" top="-2.5" name="Georgia">strings</font> data.' 

_GUICtrlCreateTFLabel($sLabel1_Data, 20, 20) 
_GUICtrlCreateTFLabel($sLabel2_Data, 20, 50) 

GUISetState(@SW_SHOW, $hGUI) 

While 1 
Switch GUIGetMsg() 
Case $GUI_EVENT_CLOSE 
Exit 
EndSwitch 
WEnd 

Func _GUICtrlCreateTFLabel($sData, $iLeft, $iTop, $iWidth=-1, $iHeight=-1, $nStyle=-1, $nExStyle=-1) 
If Not StringRegExp($sData, '(?i)<font.*?>(.*?)</font>') Then Return _ 
GUICtrlCreateLabel($sData, $iLeft, $iTop, $iWidth, $iHeight, $nStyle, $nExStyle) 

Local $aData_Width, $a_nLabels[1000] 
Local $iTop_Correction, $iIn_Top_Correction, $sIn_Data 
Local $nFont_Color, $iFont_Size, $iFont_Weight, $sFont_Attrib, $sFont_Name, $nFont_Style, $nFont_ExStyle 
Local $nIn_Font_Color, $iIn_Font_Size, $iIn_Font_Weight, $sIn_Font_Attrib, $sIn_Font_Name, $nIn_Font_Style, $nIn_Font_ExStyle 
Local $aSplit_Data = StringRegExp($sData, "(?i)(?s)(.*?)(<font.*?>.*?</font>|)(.*?)", 3) 

For $i = 0 To UBound($aSplit_Data)-1 
If $aSplit_Data[$i] == "" Then ContinueLoop 

$iTop_Correction = 0 
$nFont_Color = 0x000000 
$iFont_Size = 8.5 
$iFont_Weight = 400 
$sFont_Attrib = 0 
$sFont_Name = "Arial" 
$nFont_Style = $nStyle 
$nFont_ExStyle = $nExStyle 

$a_nLabels[0] += 1 

If StringRegExp($aSplit_Data[$i], '(?i)<font.*?>(.*?)</font>') Then 
$sIn_Data = StringRegExpReplace($aSplit_Data[$i], '(?i)<font.*?>(.*?)</font>', '\1') 

$iIn_Top_Correction = StringRegExpReplace($aSplit_Data[$i], '(?i)<font.*?top="(.*?)".*?>.*?$', '\1') 
If @extended > 0 Then $iTop_Correction = $iIn_Top_Correction 

$nIn_Font_Color = StringRegExpReplace($aSplit_Data[$i], '(?i)<font.*?color="(.*?)".*?>.*?$', '\1') 
If @extended > 0 Then $nFont_Color = $nIn_Font_Color 

$iIn_Font_Size = StringRegExpReplace($aSplit_Data[$i], '(?i)<font.*?size="(.*?)".*?>.*?$', '\1') 
If @extended > 0 Then $iFont_Size = $iIn_Font_Size 

$iIn_Font_Weight = StringRegExpReplace($aSplit_Data[$i], '(?i)<font.*?weight="(.*?)".*?>.*?$', '\1') 
If @extended > 0 Then $iFont_Weight = $iIn_Font_Weight 

$sIn_Font_Attrib = StringRegExpReplace($aSplit_Data[$i], '(?i)<font.*?attrib="(.*?)".*?>.*?$', '\1') 
If @extended > 0 Then $sFont_Attrib = $sIn_Font_Attrib 

$sIn_Font_Name = StringRegExpReplace($aSplit_Data[$i], '(?i)<font.*?name="(.*?)".*?>.*?$', '\1') 
If @extended > 0 Then $sFont_Name = $sIn_Font_Name 

$nIn_Font_Style = StringRegExpReplace($aSplit_Data[$i], '(?i)<font.*?style="(.*?)".*?>.*?$', '\1') 
If @extended > 0 Then $nFont_Style = $nIn_Font_Style 

$nIn_Font_ExStyle = StringRegExpReplace($aSplit_Data[$i], '(?i)<font.*?exstyle="(.*?)".*?>.*?$', '\1') 
If @extended > 0 Then $nFont_ExStyle = $nIn_Font_ExStyle 
Else 
$sIn_Data = $aSplit_Data[$i] 
EndIf 

$a_nLabels[$a_nLabels[0]] = GUICtrlCreateLabel($sIn_Data, $iLeft, $iTop, $iWidth, $iHeight, $nFont_Style, $nFont_ExStyle) 
$aData_Width = __GUICtrlLabelGetTextWidth($sIn_Data, $iFont_Size, $iFont_Weight, $sFont_Name) 

GUICtrlSetColor(-1, $nFont_Color) 
GUICtrlSetFont(-1, $iFont_Size, $iFont_Weight, $sFont_Attrib, $sFont_Name) 
GUICtrlSetPos(-1, $iLeft, $iTop+$iTop_Correction, $aData_Width[0], $aData_Width[1]) 

$iLeft += $aData_Width[0] 
Next 

ReDim $a_nLabels[$a_nLabels[0]+1] 
Return $a_nLabels 
EndFunc 

Func __GUICtrlLabelGetTextWidth($s_Data, $i_FontSize=8.5, $i_FontWeight=-1, $s_TextFont="Arial") 
Local Const $DEFAULT_CHARSET = 0 ; ANSI character set 
Local Const $OUT_CHARACTER_PRECIS = 2 
Local Const $CLIP_DEFAULT_PRECIS = 0 
Local Const $PROOF_QUALITY = 2 
Local Const $FIXED_PITCH = 1 
Local Const $RGN_XOR = 3 
Local Const $LOGPIXELSY = 90 

If $i_FontWeight = "" Or $i_FontWeight = -1 Then $i_FontWeight = 400 ; default Font weight 

Local $h_GDW_GUI = GUICreate("Get Data Width", 10, 10, -100, -100, 0x80880000, 0x00000080) 

Local $ah_DC = DllCall("User32.dll", "int", "GetDC", "hwnd", $h_GDW_GUI) 
Local $intDeviceCap = DllCall("Gdi32.dll", "long", "GetDeviceCaps", "int", $ah_DC[0], "long", $LOGPIXELSY) 
Local $intFontHeight = DllCall("Kernel32.dll", "long", "MulDiv", "long", $i_FontSize, "long", $intDeviceCap[0], "long", 72) 

Local $ah_Font = DllCall("Gdi32.dll", "hwnd", "CreateFont", "int", -$intFontHeight[0], _ 
"int", 0, "int", 0, "int", 0, "int", $i_FontWeight, "int", 0, _ 
"int", 0, "int", 0, "int", $DEFAULT_CHARSET, _ 
"int", $OUT_CHARACTER_PRECIS, "int", $CLIP_DEFAULT_PRECIS, _ 
"int", $PROOF_QUALITY, "int", $FIXED_PITCH, "str", $s_TextFont) 

DllCall("Gdi32.dll", "hwnd", "SelectObject", "int", $ah_DC[0], "hwnd", $ah_Font[0]) 

Local $stRet = DllStructCreate("int;int") 

DllCall("Gdi32.dll", "int", "GetTextExtentPoint32", _ 
"int", $ah_DC[0], "str", $s_Data, "long", StringLen($s_Data), "ptr", DllStructGetPtr($stRet)) 

Local $a_RetLen[2] = [DllStructGetData($stRet, 1), DllStructGetData($stRet, 2)] 

GUIDelete($h_GDW_GUI) 
Return $a_RetLen 
EndFunc 