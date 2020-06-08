#include "GDIpProgress.au3"
;##################################
; EXAMPLE
#Region EXAMPLE

$Gui = GUICreate("Gradient ProgressBar", 400, 350)

;Progress 1 + Controls
$slid = GUICtrlCreateSlider(5, 20, 310, 30) ;; check only for first bar
$Status_Label = GUICtrlCreateLabel("0%", 330, 30, 30, 20)
$btn_0 = GUICtrlCreateButton("0", 2, 100, 15, 25, 0)
$btn_25 = GUICtrlCreateButton("25", 20, 100, 75, 25, 0)
$btn_50 = GUICtrlCreateButton("50", 120, 100, 75, 25, 0)
$btn_75 = GUICtrlCreateButton("75", 220, 100, 75, 25, 0)
$btn_cl1 = GUICtrlCreateButton("Colors 1", 20, 140, 75, 25, 0)
$btn_cl2 = GUICtrlCreateButton("Colors 2", 220, 140, 75, 25, 0)
$btn_vistOK = GUICtrlCreateButton("Vista OK", 220, 180, 75, 25, 0)
$btn_vistError = GUICtrlCreateButton("Vista Error", 220, 210, 75, 25, 0)
$btn_vistPause = GUICtrlCreateButton("Vista Pause", 220, 240, 75, 25, 0)
$btn_txt = GUICtrlCreateButton("Set Text", 100, 180, 75, 25, 0)
$in_txt = GUICtrlCreateInput("%P%", 20, 180, 75, 25, 0)
GUICtrlSetTip(-1, "Use %P% to show Percentage" & @CRLF & "Leave empty to show no text")
$sID = _ProgressCreate(10, 60, 300, 40)
_ProgressSetText($sID, "Install %P%%")

; End Progress 1 + Controls

;Progress 2 + Controls
$Progress2 = _ProgressCreate(10, 280, 300, 20)
_ProgressSet($Progress2, 43)
$input = GUICtrlCreateInput("43", 320, 280, 50, 20, $ES_NUMBER)
GUICtrlSetLimit($input, 3, 1)
$updown = GUICtrlCreateUpdown($input)
GUICtrlSetLimit($updown, 100, 0)
;End Progress 2 + Controls

;Progress Marquee + Controls
$PMarquee = _ProgressCreate(10, 310, 300, 30)
_ProgressSetImages($PMarquee, @ScriptDir & "\prgimgs\marquee.jpg", @ScriptDir & "\prgimgs\bg.jpg")
_ProgressMarquee($PMarquee, 2, 0)
$marVist = GUICtrlCreateCheckbox("Vista Style",315,315,100,20)
GUICtrlSetState(-1,$GUI_CHECKED)
;End Progress Marquee + Controls

GUISetState()

While 1

	$nMsg = GUIGetMsg()
	Switch $nMsg

		Case $btn_0
			_ProgressSet($sID, 0)
			GUICtrlSetData($slid, 0)
		Case $btn_25
			_ProgressSet($sID, 25)
			GUICtrlSetData($slid, 25)
		Case $btn_50
			_ProgressSet($sID, 50)
			GUICtrlSetData($slid, 50)
		Case $btn_75
			_ProgressSet($sID, 75)
			GUICtrlSetData($slid, 75)
			
		Case $btn_cl1
			_ProgressSetColors($sID, 0xFF0000, 0x00FF00, 0xA1B0BB, 0x4455FF)
			_ProgressSetFont($sID, "", -1, -1, 0xFFBBBBFF, 0, True)
		Case $btn_cl2
			_ProgressSetColors($sID, 0x89A49B, 0xF0D6C7, 0xFFFFFF, 0xFFFFFF)
			_ProgressSetFont($sID, "", -1, -1, 0x000000, 1)
		Case $btn_vistOK
			_ProgressSetImages($sID, @ScriptDir & "\prgimgs\green.jpg", @ScriptDir & "\prgimgs\bg.jpg")
			_ProgressSetFont($sID, "", -1, -1, 0x0000FF,0)
		Case $btn_vistPause
			_ProgressSetImages($sID, @ScriptDir & "\prgimgs\yellow.jpg", @ScriptDir & "\prgimgs\bg.jpg")
			_ProgressSetFont($sID, "", -1, -1, 0xFF0000, 0)
		Case $btn_vistError
			_ProgressSetImages($sID, @ScriptDir & "\prgimgs\red.jpg", @ScriptDir & "\prgimgs\bg.jpg")
			_ProgressSetFont($sID, "", -1, -1, 0x000000, 0)
			
		Case $btn_txt
			_ProgressSetText($sID, GUICtrlRead($in_txt))
		Case $input, $updown
			_ProgressSet($Progress2, GUICtrlRead($input))
			
		Case $marVist
			If BitAND(GUICtrlRead($marVist),$GUI_CHECKED) = $GUI_CHECKED Then
				_ProgressSetImages($PMarquee, @ScriptDir & "\prgimgs\marquee.jpg", @ScriptDir & "\prgimgs\bg.jpg")
			Else
				_ProgressSetColors($PMarquee, 0xFFFF00, 0x00FF00, 0xAAAA00, 0xFF0000)
				_ProgressMarquee($PMarquee, 2, 1)
			EndIf
			
		Case $GUI_EVENT_CLOSE
			_ProgressDelete($sID) ; MUST BE DONE ON EXIT
			_Progress_CallBack_Free(1) ; Force Killing Timer

			_GDIPlus_Shutdown()

			Exit
	EndSwitch

	If $iPercent <> GUICtrlRead($slid) Then
		$iPercent = GUICtrlRead($slid)
		GUICtrlSetData($Status_Label, $iPercent & "%")
		_ProgressSet($sID, $iPercent)
	EndIf


WEnd