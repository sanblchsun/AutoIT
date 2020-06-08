; ----------------------------------------------------------------------------
;
; Script:			Tristate TreeView
; Version:			0.3
; AutoIt Version:	3.2.0.X
; Author:			Holger Kotsch
; 
; Script Function:
;	Demonstrates a tristate treeview control -> just more like a fifthstate treeview ;)
;
;	5 item checkbox! states are usable:
;	(can only used with TreeView with TVS_CHECKBOXES-style)
;		- $GUI_CHECKED
;		- $GUI_UNCHECKED
;		- $GUI_INDETERMINATE
;		- $GUI_DISABLE + $GUI_CHECKED
;		- $GUI_DISABLE + $GUI_UNCHECKED
;
; ----------------------------------------------------------------------------

#include <GUIConstants.au3>
#include "TristateTreeViewLib.au3"
#include <ComboConstants.au3>
#include <GUIConstantsEx.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>

; You could also use a integrated bmw (with ResourceHacker)
; Please see TristateTreeViewLib.au3 in line 257 (LoadStateImage)
; !!! You must not compiled it full with UPX, just use after compiling: upx.exe --best --compress-resources=0 xyz.exe !!!
; If you choose another reource number then 170 you have to change the LoadStateImage() function
;
; Userfunction My-WM_Notify() is registered in TristateTreeViewLib.au3 !
;
; You can get other check bitmaps also together with freeware install programs like i.e. NSIS
; it must have 5 image states in it:
; 1.empty, 2.unchecked, 3.checked, 4.disabled and unchecked, 5.disabled and checked

;Global $sStateIconFile = @ScriptDir & "\simple.bmp"
Global $sStateIconFile = @ScriptDir & "\modern.bmp"

GUICreate("Tristate Treeview", 400, 300)

GUICtrlCreateLabel("Select installation type:", 10, 15, 120, 20)
$nCombo	= GUICtrlCreateCombo("", 150, 10, 200, 100, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, "Full|Standard|Lite", "Full")

$nTV	= GUICtrlCreateTreeView(150, 50, 200, 200, BitOr($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_CHECKBOXES), $WS_EX_CLIENTEDGE)

$nItem1	= GUICtrlCreateTreeViewItem("Main Program (required)", $nTV)
MyCtrlSetItemState($nTV, $nItem1, $GUI_CHECKED + $GUI_DISABLE)
$nItem2	= GUICtrlCreateTreeViewItem("Interfaces", $nTV		)	; 7
$nItem3	= GUICtrlCreateTreeViewItem("ABC", $nItem2)				; 8
$nItem4	= GUICtrlCreateTreeViewItem("LED", $nItem2)				; 9
$nItem5	= GUICtrlCreateTreeViewItem("Book", $nItem3)			; 10
$nItem6	= GUICtrlCreateTreeViewItem("Letter", $nItem3)			; 11
$nItem7	= GUICtrlCreateTreeViewItem("Red", $nItem4)				; 12
$nItem8	= GUICtrlCreateTreeViewItem("Extra", $nTV)				; 13
$nItem9	= GUICtrlCreateTreeViewItem("Controlboard", $nItem8)	; 14

LoadStateImage($nTV, $sStateIconFile)

$nBtn	= GUICtrlCreateButton("Test", 10, 200, 70, 20)

GUISetState()

SelectFull()

While 1
	$nMsg = GUIGetMsg()

	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			ExitLoop
		
		Case $nCombo
			$nVal = GUICtrlRead($nCombo)
			Switch $nVal
				Case "Full"
					SelectFull()
				Case "Standard"
					SelectStandard()
				Case "Lite"
					SelectLite()
			EndSwitch
			
		Case $nBtn
			Msgbox(0, "Info ABC-item", "State:" & MyCtrlGetItemState($nTV, $nItem3))
	EndSwitch
WEnd

GUIDelete()

Exit


;**********************************************************
; Check all items
;**********************************************************
Func SelectFull()
	For $i = $nItem2 To $nItem9
		MyCtrlSetItemState($nTV, $i, $GUI_CHECKED)
	Next
EndFunc


;**********************************************************
; Checks/Unchecks some items
;**********************************************************
Func SelectStandard()
	For $i = $nItem2 To $nItem6
		MyCtrlSetItemState($nTV, $i, $GUI_CHECKED)
	Next
	
	MyCtrlSetItemState($nTV, $nItem8, $GUI_UNCHECKED)
EndFunc


;**********************************************************
; Checks/Unchecks some items
;**********************************************************
Func SelectLite()
	For $i = $nItem2 To $nItem6
		MyCtrlSetItemState($nTV, $i, $GUI_CHECKED)
	Next
	
	MyCtrlSetItemState($nTV, $nItem5, $GUI_CHECKED)
	MyCtrlSetItemState($nTV, $nItem7, $GUI_CHECKED)
	MyCtrlSetItemState($nTV, $nItem6, $GUI_UNCHECKED)
	MyCtrlSetItemState($nTV, $nItem9, $GUI_UNCHECKED)
EndFunc






