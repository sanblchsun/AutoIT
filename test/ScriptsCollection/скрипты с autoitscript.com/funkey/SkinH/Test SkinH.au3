#include <WindowsConstants.au3>
#include <GuiListView.au3>
#include <File.au3>
#include "SkinH.au3"

_SkinH_Init(@ScriptDir, 0)

Global $_SheSkinListDir = @ScriptDir & '\She' ; .she files folder
Global $_SheSkinListArray = _FileListToArray($_SheSkinListDir, '*.she', 1)

Global $hGui = GUICreate("Try Skins...", 470, 300, -1, -1, $WS_MAXIMIZEBOX + $WS_MINIMIZEBOX)
GUIRegisterMsg($WM_NOTIFY, "_WmNotify")

Global $a = GUICtrlCreateMenu("Menu1")
GUICtrlCreateMenuItem("MenuItem1", $a)
GUICtrlCreateMenuItem("MenuItem2", $a)
GUICtrlCreateMenuItem("MenuItem3", $a)
GUICtrlCreateMenuItem("MenuItem4", $a)
Global $b = GUICtrlCreateMenu("Menu2")
GUICtrlCreateMenuItem("MenuItem1", $b)

Global $_ListView = GUICtrlCreateListView(".She Skins List", 280, 5, 185, 250)
_GUICtrlListView_SetColumnWidth($_ListView, 0, $LVSCW_AUTOSIZE_USEHEADER)
_CreateListViewItem($_ListView, $_SheSkinListArray)

GUICtrlCreateGroup("Group1", 10, 10, 249, 193)
GUICtrlCreateInput("Input1", 40, 40, 100, 21)
GUICtrlCreateCombo("Combo1", 40, 90, 100, 25, 0x3)
GUICtrlSetData(-1, "Combo2|Combo3|Combo4|Combo5|Combo6|Combo7|Combo8|Combo9|Combo10")
Global $Btn1 = GUICtrlCreateButton("Button1", 10, 220, 75, 30)
Global $Btn2 = GUICtrlCreateButton("Button2", 100, 220, 75, 30)
Global $Btn3 = GUICtrlCreateButton("No Skin", 190, 220, 75, 30)
Global $Checkbox = GUICtrlCreateCheckbox("Aero", 150, 40, 80, 17)
Global $Checkbox2 = GUICtrlCreateCheckbox("Switch Menu !!", 150, 60)
Global $Radio = GUICtrlCreateRadio("Radio1", 150, 90, 80, 17)
GUICtrlCreateProgress(40, 120, 200, 20)
GUICtrlSetData(-1, 50)
Global $Slider = GUICtrlCreateSlider(40, 150, 100, 25)
GUICtrlSetLimit(-1, 255, 1)
GUICtrlSetData(-1, 200)
Global $Slider2 = GUICtrlCreateSlider(150, 150, 100, 25)
GUICtrlSetLimit(-1, 255, 1)
GUICtrlSetData(-1, 255)
Global $Slider3 = GUICtrlCreateSlider(40, 175, 100, 25)
GUICtrlSetLimit(-1, 25, 1)
GUICtrlSetData(-1, 20)
Global $Slider4 = GUICtrlCreateSlider(150, 175, 100, 25)
GUICtrlSetLimit(-1, 19, 2)
GUICtrlSetData(-1, 19)

;~ _SkinH_Attach() ;load skinh.she from @scriptdir
;~ _SkinH_SetWindowAlpha($hGui, 0xc0)		<-- same as WinSetTrans()

_SkinH_Map(GUICtrlGetHandle($Btn1), $SkinH_TYPE_RADIOBUTTON)
_SkinH_Map(GUICtrlGetHandle($Radio), $SkinH_TYPE_PUSHBUTTON)

_SkinH_SetMenuAlpha(200)

GUISetState()

Global $msg
Do
	$msg = GUIGetMsg()
	If $msg = $Btn1 Then MsgBox(0,"Skin-Test","This is some text and some more!")
	If $msg = $Btn2 Then FileOpenDialog("Open file", @ScriptDir, "All (*.*)")
	If $msg = $Btn3 Then _SkinH_Detach()
	If $msg = $Checkbox Then
		_SkinH_SetAero(GUICtrlRead($Checkbox) = 1)
		GUICtrlSetState($Checkbox2, 4)
	EndIf
	If $msg = $Checkbox2 Then
		_SkinH_SetAero(False)
		GUICtrlSetState($Checkbox, 4)
		_SkinH_SetTitleMenuBar($hGui, GUICtrlRead($Checkbox2) = 1, 0, 0, 100)
	EndIf
	If $msg = $Slider Or $msg = $Slider2 Or $msg = $Slider3 Or $msg = $Slider4 Then
		_SkinH_AdjustAero(GUICtrlRead($Slider), GUICtrlRead($Slider2), GUICtrlRead($Slider3), GUICtrlRead($Slider4))
		GUICtrlSetState($Checkbox, 1)
		GUICtrlSetState($Checkbox2, 4)
	EndIf
Until $msg = -3

GUIDelete()
_SkinH_DeInit(1)
Exit

Func _WmNotify($_Wnd, $_Msg, $_WParam, $_LParam)
	$_Tnmtv = DllStructCreate($tagNMTVDISPINFO, $_LParam)
	$_Code = DllStructGetData($_Tnmtv, "Code")
	$_Index = _GUICtrlListView_GetSelectedIndices($_ListView)
	If $_Code = $NM_CLICK And StringLen($_Index) <> 0 Then
		_SkinH_AttachEx($_SheSkinListDir & '\' & _GUICtrlListView_GetItemText($_ListView, Number($_Index)))
	EndIf
EndFunc   ;==>_WnNotify

Func _CreateListViewItem($_ListViewId, $_ListArray)
	For $_I = 1 To UBound($_ListArray) - 1
		GUICtrlCreateListViewItem($_ListArray[$_I], $_ListViewId)
	Next
EndFunc   ;==>_CreateListViewItem