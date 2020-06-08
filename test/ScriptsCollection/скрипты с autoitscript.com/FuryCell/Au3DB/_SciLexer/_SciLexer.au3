
#include-once

#include <GUIConstants.au3>
#include "scintilla.h.au3"
#include <string.au3>
#include <array.au3>

Global $ScintillaDir=@ScriptDir&"\Scintilla"
Global $user32 = DllOpen("user32.dll")
Global $kernel32 = DllOpen("kernel32.dll")
Global $hlStart, $hlEnd, $sCallTip
Global Enum $MARGIN_SCRIPT_NUMBER = 0, $MARGIN_SCRIPT_ICON, $MARGIN_SCRIPT_FOLD



Func Sci_CreateEditor($Hwnd, $X,$Y,$W,$H) ; The return value is the hwnd of the window, and can be used for Win.. functions
	$Sci = CreateEditor($Hwnd,$X,$Y,$W,$H)
	If @error Then
		Return 0
	EndIf
	InitEditor($Sci)
	If @error Then
		Return 0
	Else
		Return $Sci
	EndIf
EndFunc


; |||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||

Func Sci_DelLines($Sci)
	SendMessage($Sci, $SCI_CLEARALL, 0, 0)
	If @error Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc


Func Sci_AddLines($Sci, $Text,$Line)
	$Oldpos = Sci_GetCurrentLine($Sci)
	If @error Then
		Return 0
	EndIf
	Sci_SetCurrentLine($Sci, $Line)
	If @error Then
		Return 0
	EndIf
	$LineLenght = StringSplit($Text,"")
	If @error Then
		Return 0
	EndIf
	DllCall($user32, "long", "SendMessageA", "long", $Sci, "int", $SCI_ADDTEXT, "int", $LineLenght[0], "str", $Text)
	If @error Then
		Return 0
	EndIf
	Sci_SetCurrentLine($Sci, $Oldpos)
	If @error Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc

Func Sci_GetLines($Sci)
	Local $ret, $sText
	$iLen = SendMessage($Sci, $SCI_GETTEXT, 0, 0)
	If @error Then
		Return 0
	EndIf
	$sBuf = DllStructCreate("byte[" & $iLen & "]")
	If @error Then
		Return 0
	EndIf
	$ret = DllCall($user32, "long", "SendMessageA", "long", $Sci, "int", $SCI_GETTEXT, "int", $iLen, "ptr", DllStructGetPtr($sBuf))
	If @error Then
		Return 0
	EndIf
	$sText = BinaryToString(DllStructGetData($sBuf, 1))
	$sBuf = 0
	If @error Then
		Return 0
	Else
		Return $sText
	EndIf
EndFunc

Func Sci_GetLine($Sci, $Line)

	Local $ret, $sText
	$iLen = SendMessage($Sci, $SCI_GETLINE, $Line, 0)
	If @error Then
		Return 0
	EndIf
	$sBuf = DllStructCreate("byte[" & $iLen & "]")
	;If @error Then
	;	Return 0
	;EndIf
	$ret = DllCall($user32, "long", "SendMessageA", "long", $Sci, "int", $SCI_GETLINE, "int", $Line, "ptr", DllStructGetPtr($sBuf))
	If @error Then
		Return 0
	EndIf
	$sText = BinaryToString(DllStructGetData($sBuf, 1))
	$sBuf = 0
	If @error Then
		Return 0
	Else
		Return $sText
	EndIf

EndFunc

Func Sci_InsertText($Sci, $Pos, $Text)
	SendMessageString($Sci, $SCI_INSERTTEXT, $Pos, $Text)
EndFunc

Func Sci_SetZoom($Sci, $Zoom)
	SendMessage($Sci, $SCI_SETZOOM, $Zoom-1, 0)
	If @error Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc

Func Sci_GetZoom($Sci)
	$Zoom = SendMessage($Sci, $SCI_GETZOOM, 0, 0)
	Return $Zoom+1
EndFunc

Func Sci_GetCurrentPos($Sci)
	$Pos = SendMessage($Sci, $SCI_GETCURRENTPOS, 0, 0)
	Return $Pos
EndFunc

Func Sci_SetCurrentPos($Sci, $Char)
	SendMessage($Sci, $SCI_GOTOPOS, $Char, 0)
	If @error Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc

Func Sci_GetLineFromPos($Sci, $Pos)

	Return SendMessage($Sci, $SCI_LINEFROMPOSITION, $Pos, 0)

EndFunc

Func Sci_GetLineStartPos($Sci, $Line)

	Return SendMessage($Sci, $SCI_POSITIONFROMLINE, $Line, 0)

EndFunc

Func Sci_VisibleFirst($Sci)

	Return SendMessage($Sci, $SCI_GETFIRSTVISIBLELINE, 0, 0)

EndFunc

Func Sci_VisibleScreen($Sci)

	Return SendMessage($Sci, $SCI_LINESONSCREEN, 0, 0)

EndFunc

Func Sci_SelectAll($Sci)

	Return SendMessage($Sci, $SCI_SELECTALL, 0, 0)

EndFunc

Func Sci_GetLineEndPos($Sci, $Line)

	Return SendMessage($Sci, $SCI_GETLINEENDPOSITION, $Line, 0)

EndFunc

Func Sci_GetLineLenght($Sci, $Line)

	Return SendMessage($Sci, $SCI_LINELENGTH, $Line, 0)

EndFunc

Func Sci_GetLineCount($Sci)

	Return SendMessage($Sci, $SCI_GETLINECOUNT, 0, 0)

EndFunc

Func Sci_SetCurrentLine($Sci, $Line)
	SendMessage($Sci, $SCI_GOTOLINE, $Line-1, 0)
	If @error Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc

Func Sci_GetCurrentLine($Sci)
	$Pos = SendMessage($Sci, $SCI_GETCURRENTPOS, 0, 0)
	$Line = SendMessage($Sci, $SCI_LINEFROMPOSITION, $Pos, 0)
	Return $Line+1
EndFunc

Func Sci_GetChar($Sci, $Pos)
	Return SendMessage($Sci, $SCI_GETCHARAT, $Pos, 0)
EndFunc

Func Sci_SetSelection($Sci, $BeginChar, $EndChar)
	$Pos = SendMessage($Sci, $SCI_SETSEL, $BeginChar, $EndChar)
	Return $Pos
EndFunc

Func Sci_GetSelection($Sci)
	Local $Return[2]
	$Return[0] = SendMessage($Sci, $SCI_GETSELECTIONSTART, 0, 0)
	$Return[1] = SendMessage($Sci, $SCI_GETSELECTIONEND, 0, 0)
	Return $Return
EndFunc

Func Sci_SetSelectionColor($Sci, $Color, $State=True)

	SendMessage($Sci, $SCI_SETSELFORE, $State, $Color)

EndFunc

Func Sci_SetSelectionBkColor($Sci, $Color, $State=True)

	SendMessage($Sci, $SCI_SETSELBACK, $State, $Color)

EndFunc

Func Sci_SetSelectionAlpha($Sci, $Trans)

	SendMessage($Sci, $SCI_SETSELALPHA, $Trans, 0)

EndFunc

Func Sci_Cut($Sci)

	SendMessage($Sci, $SCI_CUT, 0, 0)

EndFunc

Func Sci_Copy($Sci)

	SendMessage($Sci, $SCI_COPY, 0, 0)

EndFunc

Func Sci_Paste($Sci)

	SendMessage($Sci, $SCI_PASTE, 0, 0)

EndFunc

Func Sci_GetCurrentWord($Sci)
	Local $Return

	$CurrentPos = Sci_GetCurrentPos($Sci)
	$Line = Sci_GetLineFromPos($Sci, $CurrentPos)
	$Text = Sci_GetLine($Sci, $Line)
	$Return = Chr(Sci_GetChar($Sci, $CurrentPos))

	if $Return and $Return <> " " and $Return <> @TAB and $Return <> @LF And $Return <> @CR Then

		$i = 1
		While 1

			$Get = Sci_GetChar($Sci, $CurrentPos-$i)
			$Char = Chr($Get)


			If $Get And $Char <> " " and $Char <> @TAB and $Char <> @LF And $Char <> @CR Then
				$Return = $Char & $Return
			Else
				ExitLoop
			EndIf

			$i += 1

		WEnd

		$i = 1

		While 1

			$Get = Sci_GetChar($Sci, $CurrentPos+$i)
			$Char = Chr($Get)

			If $Get And $Char <> " " and $Char <> @TAB and $Char <> @LF And $Char <> @CR Then
				$Return &= $Char
			Else
				ExitLoop
			EndIf

			$i += 1

		WEnd

		Return $Return

	Else
		Return ""
	EndIf

EndFunc

; -----------------------------------------------------------------------------------------------------------------------------------------------
;////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
;================================================================================================================================================
;  SciLexer Functions	|||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
;================================================================================================================================================
;\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
;------------------------------------------------------------------------------------------------------------------------------------------------


Func CreateWindowEx($dwExStyle, $lpClassName, $lpWindowName = "", $dwStyle = -1, $X = 0, $Y = 0, $nWidth = 0, $nHeight = 0, $hwndParent = 0, $hMenu = 0, $hInstance = 0, $lParm = 0)
	Local $ret
	If $hInstance = 0 Then
		$ret = DllCall($user32, "long", "GetWindowLong", "hwnd", $hwndParent, "int", -6)
		$hInstance = $ret[0]
	EndIf
	$ret = DllCall($user32, "hwnd", "CreateWindowEx", "long", $dwExStyle, _
			"str", $lpClassName, "str", $lpWindowName, _
			"long", $dwStyle, "int", $X, "int", $Y, "int", $nWidth, "int", $nHeight, _
			"hwnd", $hwndParent, "hwnd", $hMenu, "long", $hInstance, "ptr", $lParm)
	If @error Then Return 0
	Return $ret[0]
EndFunc   ;==>CreateWindowEx

Func LoadLibrary($lpFileName)
	Local $ret
	$ret = DllCall($kernel32, "int", "LoadLibrary", "str", $lpFileName)

	If @error Then Return 0

	Local $hLib = $ret[0]

	Return $ret[0]
EndFunc   ;==>LoadLibrary

Func SendMessage($hwnd, $msg, $wp, $lp)
	Local $ret
	$ret = DllCall($user32, "long", "SendMessageA", "long", $hwnd, "int", $msg, "int", $wp, "int", $lp)
	If @error Then
		SetError(1)
		Return 0
	Else
		SetError(0)
		Return $ret[0]
	EndIf

EndFunc   ;==>SendMessage

Func SendMessageString($hwnd, $msg, $wp, $str)
	Local $ret
	$ret = DllCall($user32, "int", "SendMessageA", "hwnd", $hwnd, "int", $msg, "int", $wp, "str", $str)
	Return $ret[0]
EndFunc   ;==>SendMessageString

Func CreateEditor($Hwnd, $X,$Y,$W,$H)
	Local $GWL_HINSTANCE = -6
	Local $hLib = LoadLibrary($ScintillaDir&"\SciLexer.dll")
	If @error Then
		Return 0
	EndIf

	Local  $Sci
	$Sci = CreateWindowEx($WS_EX_CLIENTEDGE, "Scintilla", _
			"SciLexer", BitOR($WS_CHILD, $WS_VISIBLE, $WS_HSCROLL, $WS_VSCROLL, $WS_TABSTOP, $WS_CLIPCHILDREN),  $X,$Y,$W,$H, _
			$Hwnd, 0, 0, 0)
	;If @error Then
	;	Return 0
	;EndIf
	;$aiSize = WinGetClientSize($Hwnd)
	If @error Then
		Return 0
	Else

		If not IsHWnd($Sci) Then $Sci = HWnd($Sci)

		Return $Sci
	EndIf
EndFunc   ;==>CreateEditor

Func InitEditor($Sci)
	SendMessage($Sci, $SCI_SETLEXER, $SCLEX_AU3, 0)
	Local $bits = SendMessage($Sci, $SCI_GETSTYLEBITSNEEDED, 0, 0)
	SendMessage($Sci, $SCI_SETSTYLEBITS, $bits, 0)

	SendMessage($Sci, $SCI_SETTABWIDTH, 4, 0)
	SendMessage($Sci, $SCI_SETINDENTATIONGUIDES, True, 0)

	SendMessage($Sci, $SCI_SETZOOM, IniRead($ScintillaDir & "\config.ini", "Settings", "Zoom", -1), 0)

	SendMessageString($Sci, $SCI_SETKEYWORDS, 0, FileRead($ScintillaDir & "\Keywords.txt"))
	SendMessageString($Sci, $SCI_SETKEYWORDS, 1, FileRead($ScintillaDir & "\Functions.txt"))
	SendMessageString($Sci, $SCI_SETKEYWORDS, 2, FileRead($ScintillaDir & "\Macros.txt"))
	SendMessageString($Sci, $SCI_SETKEYWORDS, 3, FileRead($ScintillaDir & "\SendKeys.txt"))
	SendMessageString($Sci, $SCI_SETKEYWORDS, 4, FileRead($ScintillaDir & "\PreProcessor.txt"))
	SendMessageString($Sci, $SCI_SETKEYWORDS, 5, FileRead($ScintillaDir & "\Special.txt"))
	;SendMessageString($Sci, $SCI_SETKEYWORDS, 6,"simple scilexer UDF by Kip")
	SendMessageString($Sci, $SCI_SETKEYWORDS, 7, FileRead($ScintillaDir & "\UDFs.txt"))

	SendMessage($Sci, $SCI_SETMARGINTYPEN, $MARGIN_SCRIPT_NUMBER, $SC_MARGIN_NUMBER)
	SendMessage($Sci, $SCI_SETMARGINWIDTHN, $MARGIN_SCRIPT_NUMBER, SendMessageString($Sci, $SCI_TEXTWIDTH, $STYLE_LINENUMBER, "_99999"))

	SendMessage($Sci, $SCI_SETMARGINWIDTHN, $MARGIN_SCRIPT_ICON, 16)

	SendMessage($Sci, $SCI_AUTOCSETSEPARATOR, Asc(@CR), 0)
	SendMessage($Sci, $SCI_AUTOCSETIGNORECASE, True, 0)

	SetStyle($Sci, $STYLE_DEFAULT, 0x000000, 0xFFFFFF, 10, "Courier New")
	SendMessage($Sci, $SCI_STYLECLEARALL, 0, 0)

	SetStyle($Sci, $STYLE_BRACEBAD, 0x009966, 0xFFFFFF, 0, "", 0, 1)

	SetStyle($Sci, $SCE_AU3_DEFAULT, 0x000000, 0xFFFFFF)
	SetStyle($Sci, $SCE_AU3_COMMENT, 0x339900, 0xFFFFFF)
	SetStyle($Sci, $SCE_AU3_COMMENTBLOCK, 0x009966, 0xFFFFFF)
	SetStyle($Sci, $SCE_AU3_NUMBER, 0xA900AC, 0xFFFFFF, 0, "", 1)

	SetStyle($Sci, $SCE_AU3_FUNCTION, 0xAA0000, 0xFFFFFF, 0, "", 1, 1)

	SetStyle($Sci, $SCE_AU3_KEYWORD, 0xFF0000, 0xFFFFFF, 0, "", 1)
	SetStyle($Sci, $SCE_AU3_MACRO, 0xFF33FF, 0xFFFFFF, 0, "", 1)
	SetStyle($Sci, $SCE_AU3_STRING, 0xCC9999, 0xFFFFFF, 0, "", 1)
	SetStyle($Sci, $SCE_AU3_OPERATOR, 0x0000FF, 0xFFFFFF, 0, "", 1)
	SetStyle($Sci, $SCE_AU3_VARIABLE, 0x000090, 0xFFFFFF, 0, "", 1)
	SetStyle($Sci, $SCE_AU3_SENT, 0x0080FF, 0xFFFFFF, 0, "", 1)

	SetStyle($Sci, $SCE_AU3_PREPROCESSOR, 0xFF00F0, 0xFFFFFF, 0, "", 0, 0)
	SetStyle($Sci, $SCE_AU3_SPECIAL, 0xF00FA0, 0xFFFFFF, 0, "", 0, 1)
	SetStyle($Sci, $SCE_AU3_EXPAND, 0x0000FF, 0xFFFFFF, 0, "", 1)
	SetStyle($Sci, $SCE_AU3_COMOBJ, 0xFF0000, 0xFFFFFF, 0, "", 1, 1)
	SetStyle($Sci, $SCE_AU3_UDF, 0xFF8000, 0xFFFFFF, 0, "", 1, 1)

	SetProperty($Sci, "fold", "1")
	SetProperty($Sci, "fold.compact", "1")
	SetProperty($Sci, "fold.comment", "1")
	SetProperty($Sci, "fold.preprocessor", "1")

	SendMessage($Sci, $SCI_SETMARGINWIDTHN, $MARGIN_SCRIPT_FOLD, 0); fold margin width=0

	SendMessage($Sci, $SCI_SETMARGINTYPEN, $MARGIN_SCRIPT_FOLD, $SC_MARGIN_SYMBOL)
	SendMessage($Sci, $SCI_SETMARGINMASKN, $MARGIN_SCRIPT_FOLD, $SC_MASK_FOLDERS)
	SendMessage($Sci, $SCI_SETMARGINWIDTHN, $MARGIN_SCRIPT_FOLD, 20)
	SendMessage($Sci, $SCI_MARKERDEFINE, $SC_MARKNUM_FOLDER, $SC_MARK_ARROW)
	SendMessage($Sci, $SCI_MARKERDEFINE, $SC_MARKNUM_FOLDEROPEN, $SC_MARK_ARROWDOWN)
	SendMessage($Sci, $SCI_MARKERDEFINE, $SC_MARKNUM_FOLDEREND, $SC_MARK_ARROW)
	SendMessage($Sci, $SCI_MARKERDEFINE, $SC_MARKNUM_FOLDERMIDTAIL, $SC_MARK_TCORNER)
	SendMessage($Sci, $SCI_MARKERDEFINE, $SC_MARKNUM_FOLDEROPENMID, $SC_MARK_ARROWDOWN)
	SendMessage($Sci, $SCI_MARKERDEFINE, $SC_MARKNUM_FOLDERSUB, $SC_MARK_VLINE)
	SendMessage($Sci, $SCI_MARKERDEFINE, $SC_MARKNUM_FOLDERTAIL, $SC_MARK_LCORNER)
	SendMessage($Sci, $SCI_SETFOLDFLAGS, 16, 0)
	SendMessage($Sci, $SCI_MARKERSETFORE, $SC_MARKNUM_FOLDER, 0xFFFFFF)
	SendMessage($Sci, $SCI_MARKERSETBACK, $SC_MARKNUM_FOLDERSUB, 0x808080)
	SendMessage($Sci, $SCI_MARKERSETBACK, $SC_MARKNUM_FOLDEREND, 0x808080)
	SendMessage($Sci, $SCI_MARKERSETFORE, $SC_MARKNUM_FOLDEREND, 0xFFFFFF)
	SendMessage($Sci, $SCI_MARKERSETBACK, $SC_MARKNUM_FOLDERTAIL, 0x808080)
	SendMessage($Sci, $SCI_MARKERSETBACK, $SC_MARKNUM_FOLDERMIDTAIL, 0x808080)
	SendMessage($Sci, $SCI_MARKERSETBACK, $SC_MARKNUM_FOLDER, 0x808080)
	SendMessage($Sci, $SCI_MARKERSETFORE, $SC_MARKNUM_FOLDEROPEN, 0xFFFFFF)
	SendMessage($Sci, $SCI_MARKERSETBACK, $SC_MARKNUM_FOLDEROPEN, 0x808080)
	SendMessage($Sci, $SCI_MARKERSETFORE, $SC_MARKNUM_FOLDEROPENMID, 0xFFFFFF)
	SendMessage($Sci, $SCI_MARKERSETBACK, $SC_MARKNUM_FOLDEROPENMID, 0x808080)
	SendMessage($Sci, $SCI_SETMARGINSENSITIVEN, $MARGIN_SCRIPT_FOLD, 1)

	SendMessage($Sci, $SCI_MARKERSETBACK, 0, 0x0000FF)

	GUIRegisterMsg(0x004E, "WM_NOTIFY")

	If @error Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc   ;==>InitEditor

Func SetProperty($hwnd, $property, $value, $int1 = False, $int2 = False)
	Local $ret
	If $int1 And $int2 Then
		$ret = DllCall($user32, "int", "SendMessageA", "hwnd", $hwnd, "int", $SCI_SETPROPERTY, "int", $property, "int", $value)
	ElseIf Not $int1 And Not $int2 Then
		$ret = DllCall($user32, "int", "SendMessageA", "hwnd", $hwnd, "int", $SCI_SETPROPERTY, "str", $property, "str", $value)
	ElseIf $int1 And Not $int2 Then
		$ret = DllCall($user32, "int", "SendMessageA", "hwnd", $hwnd, "int", $SCI_SETPROPERTY, "int", $property, "str", $value)
	ElseIf Not $int1 And $int2 Then
		$ret = DllCall($user32, "int", "SendMessageA", "hwnd", $hwnd, "int", $SCI_SETPROPERTY, "str", $property, "int", $value)
	EndIf
	Return $ret[0]
EndFunc   ;==>SetProperty

Func WM_NOTIFY($hWndGUI, $MsgID, $wParam, $lParam)


	#forceref $hWndGUI, $MsgID, $wParam
	Local $tagNMHDR, $event
	Local $tagNMHDR = DllStructCreate("int;int;int;int;int;int;int;ptr;int;int;int;int;int;int;int;int;int;int;int", $lParam)
	If @error Then Return

	Local $hwndFrom = DllStructGetData($tagNMHDR, 1)
	Local $idFrom = DllStructGetData($tagNMHDR, 2)
	Local $event = DllStructGetData($tagNMHDR, 3)
	Local $position = DllStructGetData($tagNMHDR, 4)
	Local $ch = DllStructGetData($tagNMHDR, 5)
	Local $modifiers = DllStructGetData($tagNMHDR, 6)
	Local $modificationType = DllStructGetData($tagNMHDR, 7)
	Local $char = DllStructGetData($tagNMHDR, 8)
	Local $length = DllStructGetData($tagNMHDR, 9)
	Local $linesAdded = DllStructGetData($tagNMHDR, 10)
	Local $message = DllStructGetData($tagNMHDR, 11)
	Local $uptr_t = DllStructGetData($tagNMHDR, 12)
	Local $sptr_t = DllStructGetData($tagNMHDR, 13)
	Local $Line = DllStructGetData($tagNMHDR, 14)
	Local $foldLevelNow = DllStructGetData($tagNMHDR, 15)
	Local $foldLevelPrev = DllStructGetData($tagNMHDR, 16)
	Local $margin = DllStructGetData($tagNMHDR, 17)
	Local $listType = DllStructGetData($tagNMHDR, 18)
	Local $X = DllStructGetData($tagNMHDR, 19)
	Local $Y = DllStructGetData($tagNMHDR, 20)
	Local $Sci = $hwndFrom
	If not IsHWnd($Sci) Then $Sci = HWnd($Sci)
	Local $line_number = SendMessage($Sci, $SCI_LINEFROMPOSITION, $position, 0)
	;Select
		;Case $hwndFrom = $Sci
		;If IsHWnd($Sci) Then
			Switch $event
				Case $SCN_CHARADDED
					If Chr($ch) = "(" Then
						Local $ret, $sText, $iPos = SendMessage($Sci, $SCI_GETCURRENTPOS, 0, 0), $sFuncName
						$iLen = SendMessage($Sci, $SCI_GETCURLINE, 0, 0)
						$sBuf = DllStructCreate("byte[" & $iLen & "]")
						$ret = DllCall($user32, "long", "SendMessageA", "long", $Sci, "int", $SCI_GETCURLINE, "int", $iLen, "ptr", DllStructGetPtr($sBuf))
						$current = $ret[0]
						$startword = $current
						While $startword > 0 And StringIsAlpha(Chr(DllStructGetData($sBuf, 1, $startword - 1)))
							$startword -= 1
							$sFuncName &= Chr(DllStructGetData($sBuf, 1, $startword))
						WEnd
						$sFuncName = _StringReverse($sFuncName)
						$sBuf = 0

					ElseIf Chr($ch) = "," Then
						If SendMessage($Sci, $SCI_CALLTIPACTIVE, 0, 0) Then
							$hlStart = $hlEnd
							$iTemp = StringInStr(StringTrimLeft($sCallTip, $hlStart + 1), ",") + $hlStart
							If StringInStr(StringTrimLeft($sCallTip, $hlStart + 1), ")") + $hlStart < $iTemp Or $iTemp - $hlStart = 0 Then
								$hlEnd = StringInStr(StringTrimLeft($sCallTip, $hlStart + 1), ")") + $hlStart
							Else
								$hlEnd = $iTemp
							EndIf
							SendMessage($Sci, $SCI_CALLTIPSETHLT, $hlStart, $hlEnd)
						EndIf
					ElseIf Chr($ch) = ")" Then
						If SendMessage($Sci, $SCI_CALLTIPACTIVE, 0, 0) Then SendMessage($Sci, $SCI_CALLTIPCANCEL, 0, 0)

					ElseIf Chr($ch) = @CR Then ; if: enter is pressed / new line created

						$CurrentLine = Sci_GetCurrentLine($Sci)
						$PreviousLine = Sci_GetLine($Sci, $CurrentLine-1)
						$TabsAdd = ""
						$Tabs = StringSplit($PreviousLine,@TAB)

						for $i = 1 to $Tabs[0]
							$TabsAdd &= @TAB
						Next

						Sci_AddLines($Sci, $TabsAdd, $CurrentLine)
						$Pos = Sci_GetLineEndPos($Sci, $CurrentLine-1)
						Sci_SetCurrentPos($Sci, $Pos)

					Else

						#CS ; Uncomment this to add autocomplete for variables

						If Not SendMessage($Sci, $SCI_AUTOCACTIVE, 0,0) Then

							$Word = Sci_GetCurrentWord($Sci)
							If $Word And StringLeft($Word,1) = "$" Then

								$AllWords = StringSplit(Sci_GetLines($Sci)," ")

								$AllVariables = @CR

								For $i = 1 to $AllWords[0] ; Get all variables from the script and trim them

									$Variable = $AllWords[$i]

									If StringLeft($Variable,1) = "$" Then

										$InStr = StringInStr($Variable,@CR)
										If $InStr Then $Variable = StringLeft($Variable,$InStr-1)

										$InStr = StringInStr($Variable,"[")
										If $InStr Then $Variable = StringLeft($Variable,$InStr-1)

										$InStr = StringInStr($Variable,"(")
										If $InStr Then $Variable = StringLeft($Variable,$InStr-1)

										$InStr = StringInStr($Variable,"]")
										If $InStr Then $Variable = StringLeft($Variable,$InStr-1)

										$InStr = StringInStr($Variable,")")
										If $InStr Then $Variable = StringLeft($Variable,$InStr-1)

										$InStr = StringInStr($Variable,"-")
										If $InStr Then $Variable = StringLeft($Variable,$InStr-1)

										$InStr = StringInStr($Variable,"+")
										If $InStr Then $Variable = StringLeft($Variable,$InStr-1)

										$InStr = StringInStr($Variable,"/")
										If $InStr Then $Variable = StringLeft($Variable,$InStr-1)

										$InStr = StringInStr($Variable,"*")
										If $InStr Then $Variable = StringLeft($Variable,$InStr-1)

										$InStr = StringInStr($Variable,"^")
										If $InStr Then $Variable = StringLeft($Variable,$InStr-1)

										$InStr = StringInStr($Variable,",")
										If $InStr Then $Variable = StringLeft($Variable,$InStr-1)

										$InStr = StringInStr($Variable,"=")
										If $InStr Then $Variable = StringLeft($Variable,$InStr-1)


										if not StringInStr($AllVariables, @CR & $Variable &@CR) Then
											$AllVariables &= $Variable&@CR
										EndIf

									EndIf

								Next

								$AllVariables = StringTrimLeft($AllVariables,1) ; remove the first CR
								$AllVariables = StringTrimRight($AllVariables,1) ; remove the last CR

								$AllVariablesSplit = StringSplit($AllVariables,@CR)
								_ArraySort($AllVariablesSplit,0,1)
								$AllVariables = _ArrayToString($AllVariablesSplit, @CR, 1)


								SendMessageString($Sci, $SCI_AUTOCSHOW, StringLen($Word)-1, $AllVariables)

							ElseIf $Word Then




							EndIf
						EndIf
						#CE
					EndIf
				Case $SCN_MARGINCLICK
					SendMessage($Sci, $SCI_TOGGLEFOLD, $line_number, 0)

				Case $SCN_SAVEPOINTREACHED

				Case $SCN_SAVEPOINTLEFT

			EndSwitch
		;EndIf
	;EndSelect
	Local $tagNMHDR = 0
	Local $event = 0
	$lParam = 0
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY


Func SetStyle($Sci, $style, $fore, $back, $size = 0, $font = "", $bold = 0, $italic = 0, $underline = 0)
	SendMessage($Sci, $SCI_STYLESETFORE, $style, $fore)
	SendMessage($Sci, $SCI_STYLESETBACK, $style, $back)
	If $size >= 1 Then
		SendMessage($Sci, $SCI_STYLESETSIZE, $style, $size)
	EndIf
	If $font <> '' Then
		SendMessageString($Sci, $SCI_STYLESETFONT, $style, $font)
	EndIf


	SendMessage($Sci, $SCI_STYLESETBOLD, $style, $bold)
	SendMessage($Sci, $SCI_STYLESETITALIC, $style, $italic)
	SendMessage($Sci, $SCI_STYLESETUNDERLINE, $style, $underline)
EndFunc   ;==>SetStyle
