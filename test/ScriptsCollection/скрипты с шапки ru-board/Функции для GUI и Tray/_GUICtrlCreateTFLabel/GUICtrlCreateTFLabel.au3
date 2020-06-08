#Region Header

#include-once
#include <WinAPI.au3>
#include <FontConstants.au3>
#include <WindowsConstants.au3>

#CS UDF Info
	Name.........:      _GUICtrlCreateTFLabel.au3
	Description..:      Creates Text Formatted Label control(s).
	Forum link...:      http://www.autoitscript.com/forum/index.php?showtopic=96986
	Author.......:      G.Sandler a.k.a MrCreatoR (CreatoR's Lab, www.creator-lab.ucoz.ru, www.autoit-script.ru)
	Remarks......:  	
						1)	Nested tags does not supported, i.e: <font...>some <font...>formatted</font> data</font>.
						2)	There is few fonts (combined with few sizes) that might cause a problems with formatting the labels.
						3)  Do not use @CRLFs in the data, the result can be bad sometimes :)
	
	
	*** Version History ***
	
	v1.3
		+ Added "cursor" parameter in <font> tag, wich supports numeric IDs and string values (POINTING, ARROW, CROSS, etc.), example:
			<font attrib="underlined" cursor="POINTING">Hyperlink</font>
		+ Added "Formatted Labels Editor", allows to use the library much easier - now the formatted labels can be generated visualy.
		* Fixed wrong charset usage, was causing adding of extra lenght to the formatted labels when using several fonts.
		* Now the unformatted label data created with the font that currently used in the GUI (by GUISetFont).
		* Cosmetic changes in the code.
	
	v1.2
		+ Added "string attribute" recognition to "attrib" parameter for <font> tag.
			Supported: i(talic) (2), u(nderlined) (4), s(trike) (8).
		+ Added support for html-like colors format (#FF0000) in "color" parameter.
		+ The "color" parameter in <font> tag can accept now RGB shortcut color, not just RrGgBb.
		+ The "color" parameter in <font> tag can also accept now color with no prefix (# or 0x).
	
	v1.1
		+ Added "bkcolor" parameter to <font> tag.
		+ Added "state" parameter to <font> tag.
		+ Added "string color" recognition to "bk/color" parameter for <font> tag. Supporting 140 known color strings.
		+ Added example with formatted labels on button control.
		
		* Now the parameters in <font> tag do not have to be wrapped with quotes.
	
	v1.0
		* First release.
	
#CE

#EndRegion Header

#Region Public Functions

; #FUNCTION# ====================================================================================================
; Name...........:	_GUICtrlCreateTFLabel
; Description....:	Creates Text Formatted Label control(s).
; Syntax.........:	_GUICtrlCreateTFLabel($sData, $iLeft, $iTop, $iWidth=-1, $iHeight=-1, $nStyle=-1, $nExStyle=-1)
;
; Parameters.....:	$sData    - Formatted data. To set formatted data use <font></font> tag for data string.
;                              * This tag supports the following parameters (when used, they *can* be wrapped with quotes):
;                                   Color   - Text *Color* of data between the tags.
;                                   Size    - Text *Size*.
;                                   Weight  - Text *Weight* (the same values as used in GUICtrlSetFont()).
;                                   Attrib  - Text *Attributes* - The same values as used in GUICtrlSetFont(),
;                                                or supported strings combined together: i(talic), u(nderlined), s(trike).
;                                   Name    - Text font *Name* (the same values as used in GUICtrlSetFont()).
;                                   Style   - Label control’s Style (applies for partial data between the tags).
;                                   ExStyle - Label control’s ExStyle (applies for partial data between the tags).
;                                   Cursor  - Label control’s Cursor (can be cursor IDs, or strings, see description for MouseGetCursor).
;                                   Top     - Top position correction (relative to the global $iTop parameter).
;                                             This is designed to avoid text corruption when using different font names/text's size.
;
;					$iLeft    - Left position (starting point in case when <font> tags are used) of label controls.
;					$iTop     - Top position of label controls.
;					$iWidth   - [Optional] Width of label control - Not used when <font> tags found in the data.
;					$iHeight  - [Optional] Height of label control - Not used when <font> tags found in the data.
;					$nStyle   - [Optional] (Forced) Style for entire label controls. Can be overridden by local Style parameter.
;					$nExStyle - [Optional] (Forced) ExStyle for entire label controls. Can be overridden by local ExStyle parameter.
;					
; Return values..:	Success   - Returns array of identifiers (Control IDs) of new created label controls.
;					Failure   - Returns 0.
; Author.........:	G.Sandler (a.k.a MrCreatoR)
; Modified.......:	13.06.2010
; Remarks........:	
; Related........:	
; Link...........:	http://www.autoitscript.com/forum/index.php?showtopic=96986
; Example........:	Yes.
; ===============================================================================================================
Func _GUICtrlCreateTFLabel($sData, $iLeft, $iTop, $iWidth=-1, $iHeight=-1, $nStyle=-1, $nExStyle=-1)
	If Not StringRegExp($sData, '(?i)<font.*?>(.*?)</font>') Then
		Local $a_nLabels[2] = [1, GUICtrlCreateLabel($sData, $iLeft, $iTop, $iWidth, $iHeight, $nStyle, $nExStyle)]
		Return $a_nLabels
	EndIf
	
	Local $aData_Width, $aFontData, $a_nLabels[1000]
	Local $iTop_Correction, $iIn_Top_Correction, $sIn_Data
	Local $nFont_Color, $nFont_BkColor, $nFont_Cursor, $iFont_Size, $iFont_Weight, $sFont_Attrib, $sFont_Name
	Local $nLabel_State, $nLabel_Style, $nLabel_ExStyle
	Local $nIn_Font_Color, $nIn_Font_BkColor, $iIn_Font_Size, $iIn_Font_Weight, $sIn_Font_Attrib, $sIn_Font_Name
	Local $nIn_Label_State, $nIn_Label_Style, $nIn_Label_ExStyle
	Local $aSplit_Data = StringRegExp($sData, "(?i)(.*?)(<font.*?>.*?</font>|$)(.*?)", 3)
	
	$aFontData = __GUIGetFont()
	
	If @error Then
		Dim $aFontData[6] = [5, 8.5, 400, 0, "Arial", 0]
	EndIf
	
	For $i = 0 To UBound($aSplit_Data)-1
		If $aSplit_Data[$i] == "" Then
			ContinueLoop
		EndIf
		
		$iTop_Correction = 0
		$nFont_Color = 0x000000
		$nFont_BkColor = -1
		$nFont_Cursor = -1
		$iFont_Size = $aFontData[1]
		$iFont_Weight = $aFontData[2]
		$sFont_Attrib = $aFontData[3]
		$sFont_Name = $aFontData[4]
		$nLabel_State = 0
		$nLabel_Style = $nStyle
		$nLabel_ExStyle = $nExStyle
		
		$a_nLabels[0] += 1
		
		If StringRegExp($aSplit_Data[$i], '(?i)<font.*?>(.*?)</font>') Then
			$sIn_Data = StringRegExpReplace($aSplit_Data[$i], '(?i)<font.*?>(.*?)</font>', '\1')
			
			__FontTagGetParamValue($aSplit_Data[$i], "top", $iTop_Correction)
			__FontTagGetParamValue($aSplit_Data[$i], "color", $nFont_Color)
			__FontTagGetParamValue($aSplit_Data[$i], "bkcolor", $nFont_BkColor)
			__FontTagGetParamValue($aSplit_Data[$i], "cursor", $nFont_Cursor)
			__FontTagGetParamValue($aSplit_Data[$i], "size", $iFont_Size)
			__FontTagGetParamValue($aSplit_Data[$i], "weight", $iFont_Weight)
			__FontTagGetParamValue($aSplit_Data[$i], "attrib", $sFont_Attrib)
			__FontTagGetParamValue($aSplit_Data[$i], "name", $sFont_Name)
			__FontTagGetParamValue($aSplit_Data[$i], "state", $nLabel_State)
			__FontTagGetParamValue($aSplit_Data[$i], "style", $nLabel_Style)
			__FontTagGetParamValue($aSplit_Data[$i], "exstyle", $nLabel_ExStyle)
		Else
			$sIn_Data = $aSplit_Data[$i]
		EndIf
		
		$a_nLabels[$a_nLabels[0]] = GUICtrlCreateLabel($sIn_Data, $iLeft, $iTop, $iWidth, $iHeight, $nLabel_Style, $nLabel_ExStyle)
		$aData_Width = __GUICtrlLabelGetTextWidth($sIn_Data, $iFont_Size, $iFont_Weight, $sFont_Name)
		
		$sFont_Attrib = StringRegExpReplace($sFont_Attrib, "(?:(\+)|)(?:italic|i)(?:(\+|\d|[^tkn])|[^\w]|$)", "${1}2${2}")
		$sFont_Attrib = StringRegExpReplace($sFont_Attrib, "(?:(\+)|)(?:underlined|u)(?:(\+|\d|[^n])|[^\w]|$)", "${1}4${2}")
		$sFont_Attrib = StringRegExpReplace($sFont_Attrib, "(?:(\+)|)(?:strike|s)(?:(\+|\d|[^t])|[^\w]|$)", "${1}8${2}")
		$sFont_Attrib = StringRegExpReplace($sFont_Attrib, "(.)", "$1+")
		$sFont_Attrib = StringRegExpReplace($sFont_Attrib, "\A\++|\++$|(\+)+", "$1")
		
		$sFont_Attrib = Execute($sFont_Attrib)
		
		If Dec($nFont_Color) > 0 Then
			$nFont_Color = StringRegExpReplace("0x" & $nFont_Color, "\A0x0x", "0x")
		EndIf
		
		$nFont_Color = StringRegExpReplace($nFont_Color, "\A#", "0x")
		$nFont_BkColor = StringRegExpReplace($nFont_BkColor, "\A#", "0x")
		
		If Not StringIsInt($nFont_Color) Then
			$nFont_Color = __ColorConvertValue($nFont_Color)
		EndIf
		
		If Not StringIsInt($nFont_BkColor) Then
			$nFont_BkColor = __ColorConvertValue($nFont_BkColor)
		EndIf
		
		If Not StringIsInt($nFont_Cursor) Then
			$nFont_Cursor = __CursorGetStringValue($nFont_Cursor, 1)
		EndIf
		
		GUICtrlSetColor($a_nLabels[$a_nLabels[0]], $nFont_Color)
		GUICtrlSetBkColor($a_nLabels[$a_nLabels[0]], $nFont_BkColor)
		GUICtrlSetCursor($a_nLabels[$a_nLabels[0]], $nFont_Cursor)
		GUICtrlSetState($a_nLabels[$a_nLabels[0]], $nLabel_State)
		GUICtrlSetFont($a_nLabels[$a_nLabels[0]], $iFont_Size, $iFont_Weight, $sFont_Attrib, $sFont_Name)
		GUICtrlSetPos($a_nLabels[$a_nLabels[0]], $iLeft, $iTop+$iTop_Correction, $aData_Width[0], $aData_Width[1])
		
		$iLeft += $aData_Width[0]
	Next
	
	ReDim $a_nLabels[$a_nLabels[0]+1]
	Return $a_nLabels
EndFunc

#EndRegion Public Functions

#Region Internal Functions

; #HELPER FUNCTION - Get test width for the label control#
Func __GUICtrlLabelGetTextWidth($s_Data, $i_FontSize = 8.5, $i_FontWeight = -1, $s_TextFont = "Arial")
	Local Const $DEFAULT_CHARSET = 1 ; 0 = ANSI character set
	Local Const $OUT_CHARACTER_PRECIS = 2
	Local Const $CLIP_DEFAULT_PRECIS = 0
	Local Const $PROOF_QUALITY = 2
	Local Const $FIXED_PITCH = 1
	Local Const $RGN_XOR = 3
	Local Const $LOGPIXELSY = 90
	
	If $i_FontWeight = "" Or $i_FontWeight = -1 Then
		$i_FontWeight = 400 ; default Font weight
	EndIf
	
	Local $hDC = _WinAPI_GetDC(0)
	Local $intDeviceCap = _WinAPI_GetDeviceCaps($hDC, $LOGPIXELSY)
	Local $intFontHeight = _WinAPI_MulDiv($i_FontSize, $intDeviceCap, 72)
	Local $hFont = _WinAPI_CreateFont(-$intFontHeight, 0, 0, 0, $i_FontWeight, 0, 0, 0, _
		$DEFAULT_CHARSET, $OUT_CHARACTER_PRECIS, $CLIP_DEFAULT_PRECIS, $PROOF_QUALITY, $FIXED_PITCH, $s_TextFont)
	
	_WinAPI_SelectObject($hDC, $hFont)
	Local $stRet = _WinAPI_GetTextExtentPoint32($hDC, $s_Data)
	
	_WinAPI_DeleteObject($hFont)
	_WinAPI_ReleaseDC(0, $hDC)
	;_WinAPI_InvalidateRect(0, 0)
	
	Local $a_RetLen[2] = [DllStructGetData($stRet, 1), DllStructGetData($stRet, 2)]
	Return $a_RetLen
EndFunc

; #HELPER FUNCTION - Get <font> tag's parameter value#
Func __FontTagGetParamValue($sTag_Data, $sParamName, ByRef $sDefault)
	Local $sRet = StringRegExpReplace($sTag_Data, '(?i)<font.*?' & $sParamName & '=(?:"|)(.*?)(?:"| |>).*?>.*?$', '\1')
	
	If @extended > 0 Then $sDefault = $sRet
	Return $sDefault
EndFunc

; #HELPER FUNCTION - Get color by it's name#
Func __ColorConvertValue($sColor, $iMode=-1)
	If $iMode = -1 And StringRegExp($sColor, "\A0x") And StringLen($sColor) = 5 Then _
		$sColor = StringRegExpReplace($sColor, "\A(0x)|(.)", "\1\2\2")
	
	Local $aStrColors_Table = StringSplit( _
		"White|Ivory|Lightyellow|Yellow|Snow|Floralwhite|Lemonchiffon|" & _
		"Cornsilk|Seashell|Lavenderblush|Papayawhip|Blanchedalmond|Mistyrose|Bisque|" & _
		"Moccasin|Navajowhite|Peachpuff|Gold|Pink|Lightpink|Orange|" & _
		"Lightsalmon|Darkorange|Coral|Hotpink|Tomato|Orangered|Deeppink|" & _
		"Magenta|Fuchsia|Red|Oldlace|Lightgoldenrodyellow|Linen|Antiquewhite|" & _
		"Salmon|Ghostwhite|Mintcream|Whitesmoke|Beige|Wheat|Sandybrown|" & _
		"Azure|Honeydew|Aliceblue|Khaki|Lightcoral|Palegoldenrod|Violet|" & _
		"Darksalmon|Lavender|Lightcyan|Burlywood|Plum|Gainsboro|Crimson|" & _
		"Palevioletred|Goldenrod|Orchid|Thistle|Lightgrey|Tan|Chocolate|" & _
		"Peru|Indianred|Mediumvioletred|Silver|Darkkhaki|Rosybrown|Mediumorchid|" & _
		"Darkgoldenrod|Firebrick|Powderblue|Lightsteelblue|Paleturquoise|Greenyellow|Lightblue|" & _
		"Darkgray|Brown|Sienna|Yellowgreen|Darkorchid|Palegreen|Darkviolet|" & _
		"Mediumpurple|Lightgreen|Darkseagreen|Saddlebrown|Darkmagenta|Darkred|Blueviolet|" & _
		"Lightskyblue|Skyblue|Gray|Olive|Purple|Maroon|Aquamarine|" & _
		"Chartreuse|Lawngreen|Mediumslateblue|Lightslategray|Slategray|Olivedrab|Slateblue|" & _
		"Dimgray|Mediumaquamarine|Cornflowerblue|Cadetblue|Darkolivegreen|Indigo|Mediumturquoise|" & _
		"Darkslateblue|Steelblue|Royalblue|Turquoise|Mediumseagreen|Limegreen|Darkslategray|" & _
		"Seagreen|Forestgreen|Lightseagreen|Dodgerblue|Midnightblue|Cyan|Aqua|" & _
		"Springgreen|Lime|Mediumspringgreen|Darkturquoise|Deepskyblue|Darkcyan|Teal|" & _
		"Green|Darkgreen|Blue|Mediumblue|Darkblue|Navy|Black", "|")
	
	Local $aHexColors_Table = StringSplit( _
		"FFFFFF|FFFFF0|FFFFE0|FFFF00|" & _
		"FFFAFA|FFFAF0|FFFACD|FFF8DC|FFF5EE|FFF0F5|FFEFD5|" & _
		"FFEBCD|FFE4E1|FFE4C4|FFE4B5|FFDEAD|FFDAB9|FFD700|" & _
		"FFC0CB|FFB6C1|FFA500|FFA07A|FF8C00|FF7F50|FF69B4|" & _
		"FF6347|FF4500|FF1493|FF00FF|FF00FF|FF0000|FDF5E6|" & _
		"FAFAD2|FAF0E6|FAEBD7|FA8072|F8F8FF|F5FFFA|F5F5F5|" & _
		"F5F5DC|F5DEB3|F4A460|F0FFFF|F0FFF0|F0F8FF|F0E68C|" & _
		"F08080|EEE8AA|EE82EE|E9967A|E6E6FA|E0FFFF|DEB887|" & _
		"DDA0DD|DCDCDC|DC143C|DB7093|DAA520|DA70D6|D8BFD8|" & _
		"D3D3D3|D2B48C|D2691E|CD853F|CD5C5C|C71585|C0C0C0|" & _
		"BDB76B|BC8F8F|BA55D3|B8860B|B22222|B0E0E6|B0C4DE|" & _
		"AFEEEE|ADFF2F|ADD8E6|A9A9A9|A52A2A|A0522D|9ACD32|" & _
		"9932CC|98FB98|9400D3|9370DB|90EE90|8FBC8F|8B4513|" & _
		"8B008B|8B0000|8A2BE2|87CEFA|87CEEB|808080|808000|" & _
		"800080|800000|7FFFD4|7FFF00|7CFC00|7B68EE|778899|" & _
		"708090|6B8E23|6A5ACD|696969|66CDAA|6495ED|5F9EA0|" & _
		"556B2F|4B0082|48D1CC|483D8B|4682B4|4169E1|40E0D0|" & _
		"3CB371|32CD32|2F4F4F|2E8B57|228B22|20B2AA|1E90FF|" & _
		"191970|00FFFF|00FFFF|00FF7F|00FF00|00FA9A|00CED1|" & _
		"00BFFF|008B8B|008080|008000|006400|0000FF|0000CD|" & _
		"00008B|000080|000000", "|")
	
	For $i = 1 To $aStrColors_Table[0]
		If $iMode = -1 And $sColor = $aStrColors_Table[$i] Then
			Return "0x" & $aHexColors_Table[$i]
		ElseIf $iMode <> -1 And StringRegExp($sColor, "\A(0x|#|)" & $aHexColors_Table[$i] & "$") Then
			Return $aStrColors_Table[$i]
		EndIf
	Next
	
	If $sColor = -1 Or $sColor = "" Or (IsKeyword($sColor) And $sColor = Default) Then Return -1
	Return "0x" & Hex($sColor, 6)
EndFunc

; #HELPER FUNCTION - Get cursor ID by it's name or vise versa#
Func __CursorGetStringValue($vValue, $iRet_Mode = -1)
	Local $aStr_Values[17] = [ _
		"POINTING", _ ;Grabbing hand
		"APPSTARTING", _
		"ARROW", _ ;Default?
		"CROSS", _
		"HELP", _
		"IBEAM", _ ;Selection
		"ICON", "NO", "SIZE", "SIZEALL", "SIZENESW", "SIZENS", "SIZENWSE", "SIZEWE", "UPARROW", "WAIT", "HAND"]
	
	If $iRet_Mode <> -1 Or Not StringIsDigit($vValue) Then
		For $i = 0 To UBound($aStr_Values)-1
			If $vValue = $aStr_Values[$i] Then
				Return $i
			EndIf
		Next
		
		Return SetError(1, 0, $vValue)
	EndIf
	
	If $vValue < UBound($aStr_Values) And $vValue >= 0 Then
		Return $aStr_Values[$vValue]
	EndIf
	
	Return SetError(1, 0, $vValue)
EndFunc

Func __GUIGetFont($hWnd = 0)
	; [0] - 5
	; [1] - Size
	; [2] - Weight
	; [3] - Attribute
	; [4] - Name
	; [5] - Quality
	
	Local $Ret, $Label, $hLabel, $hPrev, $hDC, $hFont, $tFont
	Local $aFont = 0
	
	If $hWnd = 0 Then
		$Label = GUICtrlCreateLabel('', 0, 0)
		
		If Not $Label Then
			Return 0
		EndIf
		
		$hWnd = _WinAPI_GetParent(GUICtrlGetHandle($Label))
		
		GUICtrlDelete($Label)
	EndIf
	
	$hPrev = GUISwitch($hWnd)
	
	If Not $hPrev Then
		Return 0
	EndIf
	
	$Label = GUICtrlCreateLabel('', 0, 0, 0, 0)

	If Not $Label Then
		Return 0
	EndIf
	
	$hLabel = GUICtrlGetHandle($Label)
	$hDC = _WinAPI_GetDC($hLabel)
	$hFont = _SendMessage($hLabel, $WM_GETFONT)
	$tFont = DllStructCreate($tagLOGFONT)
	$Ret = DllCall('gdi32.dll', 'int', 'GetObjectW', 'ptr', $hFont, 'int', DllStructGetSize($tFont), 'ptr', DllStructGetPtr($tFont))
	
	If (Not @error) And ($Ret[0]) Then
		Dim $aFont[6] = [5]
		$aFont[1] = -Round(DllStructGetData($tFont, 'Height') / _WinAPI_GetDeviceCaps($hDC, $LOGPIXELSY) * 72, 1)
		$aFont[2] = DllStructGetData($tFont, 'Weight')
		$aFont[3] = BitOR(2 * (DllStructGetData($tFont, 'Italic') <> 0), 4 * (DllStructGetData($tFont, 'Underline') <> 0), 8 * (DllStructGetData($tFont, 'Strikeout') <> 0))
		$aFont[4] = DllStructGetData($tFont, 'FaceName')
		$aFont[5] = DllStructGetData($tFont, 'Quality')
	EndIf
	
	_WinAPI_ReleaseDC($hLabel, $hDC)
	GUICtrlDelete($Label)
	GUISwitch($hPrev)
	
	Return $aFont
EndFunc

#EndRegion Internal Functions
