#include <GUIConstants.au3>
#include <WindowsConstants.au3>
#include <FontConstants.au3>
#include <GuiListView.au3>
#include <GuiTab.au3>
#include <WinAPI.au3>

Opt( "MustDeclareVars", 1 )

Global Const $iBorderWidth = 4

; Colors
Global $iColorSet = 0
Global $iColorSets = 5
Global Const $aColorSets[$iColorSets] = [ _
	"By name", "By hue", "By lightness", "By saturation", "By value" ]
Global Const $aColorFiles[$iColorSets] = [ _
	"CustDrawColorsName.txt", "CustDrawColorsHue.txt", "CustDrawColorsLightness.txt", "CustDrawColorsSaturation.txt", "CustDrawColorsValue.txt" ]
Global $iColors = 140, $aColors[$iColors]

Global $hGui, $hLV, $hLVfont, $hLVfontBold

MainScript()

Func MainScript()

	; Create GUI
	$hGui = GUICreate( "Web Colors", 556, 338, 400, 200 )

	; Create Tab control
	Local $aPos = WinGetClientSize( $hGui )
	Local $idTab = GUICtrlCreateTab( $iBorderWidth, $iBorderWidth, $aPos[0]-2*$iBorderWidth, $aPos[1]-2*$iBorderWidth, $TCS_MULTILINE )

	; Add Tab items
	For $colorset In $aColorSets
		GUICtrlCreateTabItem( $colorset )
	Next
	GUICtrlCreateTabItem( "" )

	; Create ListView control
	Local $idLV = GUICtrlCreateListView( "", 12, 34, 529, 290, $GUI_SS_DEFAULT_LISTVIEW, BitOR( $WS_EX_CLIENTEDGE, $LVS_EX_FULLROWSELECT ) )
	$hLV = ControlGetHandle( $hGui, "", $idLV )
	
	; Add 4 columns to ListView control
	_GUICtrlListView_AddColumn( $hLV, "Forecolor", 125 )
	_GUICtrlListView_AddColumn( $hLV, "Backcolor", 125 )
	_GUICtrlListView_AddColumn( $hLV, "Color name", 125 )
	_GUICtrlListView_AddColumn( $hLV, "RGB value", 125 )

	; Get the font of the ListView control
	; Copied from the _GUICtrlGetFont example by KaFu
	; See http://www.autoitscript.com/forum/index.php?showtopic=124526
	Local $hDC = _WinAPI_GetDC($hLV)
	Local $hFont = _SendMessage($hLV, $WM_GETFONT)
	Local $hObject = _WinAPI_SelectObject($hDC, $hFont)
	Local $lvLOGFONT = DllStructCreate($tagLOGFONT)
	Local $aRet = DllCall('gdi32.dll', 'int', 'GetObjectW', 'ptr', $hFont, 'int', DllStructGetSize($lvLOGFONT), 'ptr', DllStructGetPtr($lvLOGFONT))
	_WinAPI_SelectObject($hDC, $hObject)
	_WinAPI_ReleaseDC($hLV, $hDC)
	$hLVfont = _WinAPI_CreateFontIndirect( $lvLOGFONT )
	Local $iWeight = BitOR( DllStructGetData( $lvLOGFONT, "Weight" ), $FW_BOLD )
	DllStructSetData( $lvLOGFONT, "Weight", $iWeight )
	$hLVfontBold = _WinAPI_CreateFontIndirect( $lvLOGFONT )

	AddWebColorsFromFile( $iColorSet )

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

					Case $idTab
						$iColorSet = GUICtrlRead( $idTab )
						_GUICtrlListView_BeginUpdate( $hLV )
						_GUICtrlListView_DeleteAllItems( $hLV )
						AddWebColorsFromFile( $iColorSet )
						_GUICtrlListView_EndUpdate( $hLV )

					Case $GUI_EVENT_CLOSE
						ExitLoop

				EndSwitch

		EndSwitch

	WEnd

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

		Case $hLV

			Switch $iCode

				Case $NM_CUSTOMDRAW
					Local $tNMLVCUSTOMDRAW = DllStructCreate($tagNMLVCUSTOMDRAW, $lParam)
					Local $dwDrawStage = DllStructGetData($tNMLVCUSTOMDRAW, "dwDrawStage")

					Switch $dwDrawStage													; Holds a value that specifies the drawing stage

						Case $CDDS_PREPAINT
							; Before the paint cycle begins
							Return $CDRF_NOTIFYITEMDRAW							; Notify the parent window of any item-related drawing operations

						Case $CDDS_ITEMPREPAINT
							; Before painting an item
							Return $CDRF_NOTIFYSUBITEMDRAW					; Notify the parent window of any subitem-related drawing operations

						Case BitOR( $CDDS_ITEMPREPAINT, $CDDS_SUBITEM )
							; Before painting a subitem
							Local $iSubItem = DllStructGetData($tNMLVCUSTOMDRAW, "iSubItem")						; Subitem index
							Switch $iSubItem
								Case 0
									; Forecolor
									Local $dwItemSpec = DllStructGetData($tNMLVCUSTOMDRAW, "dwItemSpec")		; Item index
									Local $hDC = DllStructGetData($tNMLVCUSTOMDRAW, "HDC")									; Handle to the item's device context
									_WinAPI_SelectObject($hDC, $hLVfontBold)																; Bold
									DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText", $aColors[$dwItemSpec])		; Forecolor of item text
								Case 1
									; Backcolor
									Local $dwItemSpec = DllStructGetData($tNMLVCUSTOMDRAW, "dwItemSpec")		; Item index
									Local $hDC = DllStructGetData($tNMLVCUSTOMDRAW, "HDC")									; Handle to the item's device context
									_WinAPI_SelectObject($hDC, $hLVfont)																		; Normal
									DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", $aColors[$dwItemSpec])	; Backcolor of subitem text
								Case 2
									; Color name
									DllStructSetData( $tNMLVCUSTOMDRAW, "ClrText", 0x000000 )								; Forecolor of subitem text
									DllStructSetData( $tNMLVCUSTOMDRAW, "ClrTextBk", 0xFFFFFF )							; Backcolor of subitem text
								Case 3
									; RGB value (same as color name)
							EndSwitch
							Return $CDRF_NEWFONT										; $CDRF_NEWFONT must be returned after changing font or colors

					EndSwitch

			EndSwitch

	EndSwitch

	Return $GUI_RUNDEFMSG
EndFunc


#cs######################
#   Utility functions   #
#ce######################

Func AddWebColorsFromFile( $iColorSet )

	; Read file in one big bite for speed
	Local $file = FileOpen( $aColorFiles[$iColorSet], 16 )
	Local $data = BinaryToString( FileRead( $file ) )
	FileClose( $file )

	; Fill array and ListView
	Local $aFields, $item, $j
	Local $aLines = StringSplit( $data, @CRLF, 3 ), $aFields
	For $i = 0 To $iColors - 1
		$aFields = StringSplit( $aLines[$i], " ", 2 )
		$aColors[$i] = ColorConvert( $aFields[0] )								; BGR value
		_GUICtrlListView_AddItem( $hLV, $aFields[1] )							; Add ListView item, color name (forecolor)
		_GUICtrlListView_AddSubItem( $hLV, $i, "", 1 )						; Add subitem, empty field for backcolor
		_GUICtrlListView_AddSubItem( $hLV, $i, $aFields[1], 2 )		; Add subitem, color name
		_GUICtrlListView_AddSubItem( $hLV, $i, $aFields[0], 3 )		; Add subitem, RGB value
	Next
EndFunc

;RGB to BGR or BGR to RGB
Func ColorConvert($iColor)
	Return BitOR(BitAND($iColor, 0x00FF00), BitShift(BitAND($iColor, 0x0000FF), -16), BitShift(BitAND($iColor, 0xFF0000), 16))
EndFunc
