#include <GUIConstants.au3>
#include <WindowsConstants.au3>
#include <FontConstants.au3>
#include <GuiTreeView.au3>
#include <WinAPI.au3>

Opt( "MustDeclareVars", 1 )

Global Const $iBorderWidth = 4

; Structures
Global Const $tagENUMLOGFONTEX = $tagLOGFONT & ";wchar elfFullName[64]; wchar elfStyle[32]; wchar elfScript[32]"

Global Const $tagNEWTEXTMETRIC = _
	"long tmHeight;long tmAscent;long tmDescent;long tmInternalLeading;long tmExternalLeading;long tmAveCharWidth;" & _
	"long tmMaxCharWidth;long tmWeight;long tmOverhang;long tmDigitizedAspectX;long tmDigitizedAspectY;wchar tmFirstChar;" & _
	"wchar tmLastChar;wchar tmDefaultChar;wchar tmBreakChar;byte tmItalic;byte tmUnderlined;byte tmStruckOut;" & _
	"byte tmPitchAndFamily;byte tmCharSet;dword ntmFlags;uint ntmSizeEM;uint ntmCellHeight;uint ntmAvgWidth"
Global const $tagFONTSIGNATURE = "dword fsUsb[4];dword fsCsb[2]"
Global const $tagNEWTEXTMETRICEX = $tagNEWTEXTMETRIC & ";" & $tagFONTSIGNATURE

; Character sets
Global Const $iCharSets = 14
Global Const $aCharSets[$iCharSets] = [ _
	$ANSI_CHARSET, $BALTIC_CHARSET, $CHINESEBIG5_CHARSET, $EASTEUROPE_CHARSET, $GB2312_CHARSET, $GREEK_CHARSET, $HANGEUL_CHARSET, _
	$MAC_CHARSET, $OEM_CHARSET, $RUSSIAN_CHARSET, $SHIFTJIS_CHARSET, $SYMBOL_CHARSET, $TURKISH_CHARSET, $VIETNAMESE_CHARSET ]
Global Const $sCharSets[$iCharSets] = [ _
	"ANSI", "Baltic", "Chinese Big5", "East Europe", "GB2312", "Greek", "Hangeul", _
	"MAC", "OEM", "Russian", "Shift JIS", "Symbol", "Turkish", "Vietnamese" ]
Global $hANSI, $hBaltic, $hChineseBig5, $hEastEurope, $hGB2312, $hGreek, $hHangeul
Global $hMAC, $hOEM, $hRussian, $hShiftJIS, $hSymbol, $hTurkish, $hVietnamese

; Fonts
Global $iFonts = 0, $aFonts[100][2], $tvFontHeight, $tvFontWidth

Global $hGui, $hTV, $hRoot, $hItem

MainScript()

Func MainScript()

	; Create GUI
	$hGui = GUICreate( "Fonts", 500, 300, 500, 300 )

	; Create TreeView control
	Local $aPos = WinGetClientSize( $hGui )
	Local $idTV = GUICtrlCreateTreeView( $iBorderWidth, $iBorderWidth, $aPos[0]-2*$iBorderWidth, $aPos[1]-2*$iBorderWidth, $GUI_SS_DEFAULT_TREEVIEW+$TVS_NOHSCROLL, $WS_EX_CLIENTEDGE )
	$hTV = ControlGetHandle( $hGui, "", $idTV )

	; Add root item
	$hRoot = _GUICtrlTreeView_Add( $hTV, 0, "Fonts for character sets" )

	; Get the font of the TreeView control
	; Copied from the _GUICtrlGetFont example by KaFu
	; See http://www.autoitscript.com/forum/index.php?showtopic=124526
	Local $hDC = _WinAPI_GetDC($hTV)
	Local $hFont = _SendMessage($hTV, $WM_GETFONT)
	Local $hObject = _WinAPI_SelectObject($hDC, $hFont)
	Local $tvLOGFONT = DllStructCreate($tagLOGFONT)
	Local $aRet = DllCall('gdi32.dll', 'int', 'GetObjectW', 'ptr', $hFont, 'int', DllStructGetSize($tvLOGFONT), 'ptr', DllStructGetPtr($tvLOGFONT))
	_WinAPI_SelectObject($hDC, $hObject)
	_WinAPI_ReleaseDC($hTV, $hDC)
	$tvFontHeight = DllStructGetData( $tvLOGFONT, "Height" )
	$tvFontWidth = DllStructGetData( $tvLOGFONT, "Width" )

	; Add fonts for character sets in FontConstants.au3
	EnumFontFamilies( $hANSI )
	EnumFontFamilies( $hBaltic )
	EnumFontFamilies( $hChineseBig5 )
	EnumFontFamilies( $hEastEurope )
	EnumFontFamilies( $hGB2312 )
	EnumFontFamilies( $hGreek )
	EnumFontFamilies( $hHangeul )
	EnumFontFamilies( $hMAC )
	EnumFontFamilies( $hOEM )
	EnumFontFamilies( $hRussian )
	EnumFontFamilies( $hShiftJIS )
	EnumFontFamilies( $hSymbol )
	EnumFontFamilies( $hTurkish )
	EnumFontFamilies( $hVietnamese )

	; Functions for Windows Messages
	GUIRegisterMsg( $WM_NOTIFY, "WM_NOTIFY" )

	; Show GUI
	GUISetState( @SW_SHOW, $hGui )

	; Message loop
	While 1

		Local $aMsg = GUIGetMsg(1)

		Switch $aMsg[1]

			; Events for the main GUI
			Case $hGui

				Switch $aMsg[0]

					Case $GUI_EVENT_CLOSE
						ExitLoop

				EndSwitch

		EndSwitch

	WEnd

	For $i = 0 To $iFonts - 1
		_WinAPI_DeleteObject( $aFonts[$i][0] )
	Next
	GUIDelete( $hGui )
	Exit

EndFunc


#cs###################################
#   Functions for Windows Messages   #
#ce###################################

Func WM_NOTIFY($hWnd, $iMsg, $wParam, $lParam)
	#forceref $hWnd, $iMsg, $wParam
	Local $tNMHDR, $hWndFrom, $iCode
	$tNMHDR = DllStructCreate($tagNMHDR, $lParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iCode = DllStructGetData($tNMHDR, "Code")

	Switch $hWndFrom

		Case $hTV

			Switch $iCode

				Case $NM_CUSTOMDRAW
					Local $tNMTVCUSTOMDRAW = DllStructCreate($tagNMTVCUSTOMDRAW, $lParam)
					Local $dwDrawStage = DllStructGetData($tNMTVCUSTOMDRAW, "DrawStage")

					Switch $dwDrawStage												; Holds a value that specifies the drawing stage

						Case $CDDS_PREPAINT
							; Before the paint cycle begins
							Return BitOr( $CDRF_NOTIFYITEMDRAW, _	; Notify the parent window of any item-related drawing operations
														$CDRF_NOTIFYPOSTPAINT )	; Notify the parent window after item-related drawing operations

						Case $CDDS_ITEMPREPAINT
							; Before painting an item
							Local $hItemSpec  = DllStructGetData($tNMTVCUSTOMDRAW, "ItemSpec")			; $hItemSpec = $hItem
							Local $iItemParam = DllStructGetData($tNMTVCUSTOMDRAW, "ItemParam")			; ItemParam = index in array
							Switch $hItemSpec
								Case $hRoot, $hANSI, $hBaltic, $hChineseBig5, $hEastEurope, $hGB2312, $hGreek, $hHangeul, _
										 $hMAC, $hOEM, $hRussian, $hShiftJIS, $hSymbol, $hTurkish, $hVietnamese
								Case Else
									Local $hDC = DllStructGetData($tNMTVCUSTOMDRAW, "HDC")							; Handle to the item's device context
									_WinAPI_SelectObject($hDC, $aFonts[$iItemParam][0])
							EndSwitch
							Return BitOr( $CDRF_NEWFONT, _				; $CDRF_NEWFONT must be returned after changing font or colors
														$CDRF_NOTIFYPOSTPAINT )	; Notify the parent window after item-related drawing operations

						Case $CDDS_ITEMPOSTPAINT
							; After painting an item
							Local $hItemSpec = DllStructGetData($tNMTVCUSTOMDRAW, "ItemSpec")				; $hItemSpec = $hItem
							Switch $hItemSpec
								Case $hRoot, $hANSI, $hBaltic, $hChineseBig5, $hEastEurope, $hGB2312, $hGreek, $hHangeul, _
										 $hMAC, $hOEM, $hRussian, $hShiftJIS, $hSymbol, $hTurkish, $hVietnamese
								Case Else
									Local $iItemState = DllStructGetData($tNMTVCUSTOMDRAW, "ItemState")
									Local $iItemParam = DllStructGetData($tNMTVCUSTOMDRAW, "ItemParam")	; ItemParam = index in array
									Local $hDC        = DllStructGetData($tNMTVCUSTOMDRAW, "HDC")				; Handle to the item's device context
									Local $tRECT = DllStructCreate( $tagRECT )													; To define 2 rectangles at the right side of the item
									DllStructSetData( $tRECT, "Top", DllStructGetData($tNMTVCUSTOMDRAW, "Top") )				; Top of the item text rectangle
									DllStructSetData( $tRECT, "Bottom", DllStructGetData($tNMTVCUSTOMDRAW, "Bottom") )	; Bottom
									Local $left = 280, $width = 200
									If BitAnd( $iItemState, $CDIS_FOCUS ) Then
										; The TreeView item with the focus
										DllStructSetData( $tRECT, "Left", $left )													; Rectangle at the right side of the item
										DllStructSetData( $tRECT, "Right", $left+$width )
										_WinAPI_DrawText( $hDC, $aFonts[$iItemParam][1], $tRECT, $DT_LEFT ); Draw the font name
									Else
										; The TreeView item that previously had focus
										Local $hBrush = _WinAPI_CreateSolidBrush( 0xFFFFFF )							; Clear the rectangle by
										DllStructSetData( $tRECT, "Left", $left )													; filling it with a white color
										DllStructSetData( $tRECT, "Right", $left+$width )
										_WinAPI_FillRect( $hDC, $tRECT, $hBrush )
										_WinAPI_DeleteObject( $hBrush )
									EndIf
									Return $CDRF_DODEFAULT	; The control draws itself without any additional NM_CUSTOMDRAW messages for this paint cycle
							EndSwitch

					EndSwitch

			EndSwitch

	EndSwitch

	Return $GUI_RUNDEFMSG
EndFunc


#cs#######################
#   Callback functions   #
#ce#######################

Func EnumFontFamilies( ByRef $hCharSet )
	
	Static $idxCharSet = 0
	Local $count = $iFonts

	$hItem = _GUICtrlTreeView_AddChild( $hTV, $hRoot, $sCharSets[$idxCharSet] )
	$hCharSet = $hItem

	Local $tLOGFONT = DllStructCreate( $tagLOGFONT )
	DllStructSetData( $tLOGFONT, "CharSet", $aCharSets[$idxCharSet] )
	DllStructSetData( $tLOGFONT, "FaceName", "" )

	; Call EnumFontFamiliesEx
	Local $hCallBack = DllCallbackRegister("EnumFontFamExProc", "int", "ptr;ptr;dword;lparam")

	; Call EnumFontFamiliesEx
	Local $hDC = _WinAPI_GetDC( $hTV )
	DllCall( "gdi32.dll", "int", "EnumFontFamiliesExW", "handle", $hDC, "struct*", $tLOGFONT, "ptr", DllCallbackGetPtr($hCallBack), "lparam", 0, "dword", 0 )
	_WinAPI_ReleaseDC( $hTV, $hDC )

	; Delete callback function
	DllCallbackFree( $hCallBack )

	$count = $iFonts - $count
	_GUICtrlTreeView_SetText($hTV, $hItem, $sCharSets[$idxCharSet] & " (" & $count & ")" )

	$idxCharSet += 1

EndFunc

; Enumerate fonts for the character set in the CharSet member of $pENUMLOGFONTEX
Func EnumFontFamExProc( $pENUMLOGFONTEX, $pNEWTEXTMETRICEX, $FontType, $lParam )
	Local $tENUMLOGFONTEX = DllStructCreate( $tagENUMLOGFONTEX, $pENUMLOGFONTEX )
	Local $elfFullName = DllStructGetData( $tENUMLOGFONTEX, "elfFullName" )	; Full name of the font
	Local $tLOGFONT = DllStructCreate( $tagLOGFONT )												; $tagLOGFONT struct to create a new font
	DllStructSetData( $tLOGFONT, "Height", $tvFontHeight )									; Set height to height of the TreeView font
	DllStructSetData( $tLOGFONT, "Width", $tvFontWidth )										; Set width to width of the TreeView font
	DllStructSetData( $tLOGFONT, "FaceName", $elfFullName )									; Set facename to the full name
	If Mod( $iFonts, 100 ) = 0 Then ReDim $aFonts[$iFonts+100][2]
	$aFonts[$iFonts][0] = _WinAPI_CreateFontIndirect( $tLOGFONT )						; Create font and save it in aFonts
	$aFonts[$iFonts][1] = $elfFullName																			; Save full name of the font in aFonts
	Local $item = _GUICtrlTreeView_AddChild( $hTV, $hItem, $elfFullName )		; Add TreeView item
	_GUICtrlTreeView_SetItemParam( $hTV, $item, $iFonts )										; Set ItemParam to index in aFonts. Remark that native TreeView items
	$iFonts += 1																														; uses ItemParam to hold ControlId. Don't set ItemParam for native items.
	Return 1																																; Return 1 to continue enumeration
EndFunc
