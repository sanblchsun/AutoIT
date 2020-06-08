#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#Include <GuiButton.au3>
#include <midiudf.au3>
#include <GUIComboBox.au3>
#include <SliderConstants.au3>
#include <GuiListView.au3>
#include <EditConstants.au3>
#include <WinAPI.au3>
#include <Constants.au3>
#Include <Misc.au3>
#include <GuiToolbar.au3>
#Include <GuiImageList.au3>
#include <GuiToolTip.au3>
#include <ProgressConstants.au3>
#Include <GuiDateTimePicker.au3>
#Include <File.au3>

;~ Global Const $WM_LBUTTONDOWN = 0x0201
;~ Global Const $WM_MOUSELEAVE = 0x02A3

Dim $Note[88][2] = [ _
[$A0_ON,$A0_OFF],[$A0SHARP_ON,$A0SHARP_OFF],[$B0_ON,$B0_OFF], _
[$C1_ON,$C1_OFF],[$C1SHARP_ON,$C1SHARP_OFF],[$D1_ON,$D1_OFF],[$D1SHARP_ON,$D1SHARP_OFF],[$E1_ON,$E1_OFF],[$F1_ON,$F1_OFF],[$F1SHARP_ON,$F1SHARP_OFF],[$G1_ON,$G1_OFF],[$G1SHARP_ON,$G1SHARP_OFF],[$A1_ON,$A1_OFF],[$A1SHARP_ON,$A1SHARP_OFF],[$B1_ON,$B1_OFF], _
[$C2_ON,$C2_OFF],[$C2SHARP_ON,$C2SHARP_OFF],[$D2_ON,$D2_OFF],[$D2SHARP_ON,$D2SHARP_OFF],[$E2_ON,$E2_OFF],[$F2_ON,$F2_OFF],[$F2SHARP_ON,$F2SHARP_OFF],[$G2_ON,$G2_OFF],[$G2SHARP_ON,$G2SHARP_OFF],[$A2_ON,$A2_OFF],[$A2SHARP_ON,$A2SHARP_OFF],[$B2_ON,$B2_OFF], _
[$C3_ON,$C3_OFF],[$C3SHARP_ON,$C3SHARP_OFF],[$D3_ON,$D3_OFF],[$D3SHARP_ON,$D3SHARP_OFF],[$E3_ON,$E3_OFF],[$F3_ON,$F3_OFF],[$F3SHARP_ON,$F3SHARP_OFF],[$G3_ON,$G3_OFF],[$G3SHARP_ON,$G3SHARP_OFF],[$A3_ON,$A3_OFF],[$A3SHARP_ON,$A3SHARP_OFF],[$B3_ON,$B3_OFF], _
[$C4_ON,$C4_OFF],[$C4SHARP_ON,$C4SHARP_OFF],[$D4_ON,$D4_OFF],[$D4SHARP_ON,$D4SHARP_OFF],[$E4_ON,$E4_OFF],[$F4_ON,$F4_OFF],[$F4SHARP_ON,$F4SHARP_OFF],[$G4_ON,$G4_OFF],[$G4SHARP_ON,$G4SHARP_OFF],[$A4_ON,$A4_OFF],[$A4SHARP_ON,$A4SHARP_OFF],[$B4_ON,$B4_OFF], _
[$C5_ON,$C5_OFF],[$C5SHARP_ON,$C5SHARP_OFF],[$D5_ON,$D5_OFF],[$D5SHARP_ON,$D5SHARP_OFF],[$E5_ON,$E5_OFF],[$F5_ON,$F5_OFF],[$F5SHARP_ON,$F5SHARP_OFF],[$G5_ON,$G5_OFF],[$G5SHARP_ON,$G5SHARP_OFF],[$A5_ON,$A5_OFF],[$A5SHARP_ON,$A5SHARP_OFF],[$B5_ON,$B5_OFF], _
[$C6_ON,$C6_OFF],[$C6SHARP_ON,$C6SHARP_OFF],[$D6_ON,$D6_OFF],[$D6SHARP_ON,$D6SHARP_OFF],[$E6_ON,$E6_OFF],[$F6_ON,$F6_OFF],[$F6SHARP_ON,$F6SHARP_OFF],[$G6_ON,$G6_OFF],[$G6SHARP_ON,$G6SHARP_OFF],[$A6_ON,$A6_OFF],[$A6SHARP_ON,$A6SHARP_OFF],[$B6_ON,$B6_OFF], _
[$C7_ON,$C7_OFF],[$C7SHARP_ON,$C7SHARP_OFF],[$D7_ON,$D7_OFF],[$D7SHARP_ON,$D7SHARP_OFF],[$E7_ON,$E7_OFF],[$F7_ON,$F7_OFF],[$F7SHARP_ON,$F7SHARP_OFF],[$G7_ON,$G7_OFF],[$G7SHARP_ON,$G7SHARP_OFF],[$A7_ON,$A7_OFF],[$A7SHARP_ON,$A7SHARP_OFF],[$B7_ON,$B7_OFF], _
[$C8_ON,$C8_OFF]]

$Open = _MidiOutOpen()
;~ Play($open, 56, 400)
$lower_string = "C,D,E,F,G,A,B"
$higher_string = "A# Ab,C# Db,D# Eb,F# Gb,G# Ab"
$all_strings = "A,A# or Bb(Hb),B(H),C,C# or Db,D,D# or Eb,E,F,F# or Gb,G,G# or Ab"
$all_strings_split = StringSplit($all_strings, ",")
Global $n1_count = 5, $remembered_index
Global $n2_count = $n1_count
Global $a_count = 0, $b_count = 0
Global $current_global_handle, $current_global_index, $tooltip_Timer, $check_tooltip = false
Global $main_title = "Midi Keyboard"
Global $recording = false, $play_length_timer, $old_index, $playing=false
Global $aUtil_MinMax[4]
Global $holding = False
;~ Global $wProcNew

$Form1 = GUICreate($main_title, 999, 350+10, -1, -1, $WS_POPUP+$WS_SIZEBOX)
GUISetFont(8, 400, -1, "Arial")
GUISetBkColor(0, $form1)
$title_label = GUICtrlCreateLabel($main_title, 620, 3, 212, 37)
GUICtrlSetCursor(-1, 9)
GUICtrlSetFont(-1, 20, 800, 2, "Verdana")
GUICtrlSetColor(-1, 0xFFFFFF)
$title_label_signature = GUICtrlCreateLabel("by sandin", 840, 17, 60, 17)
GUICtrlSetFont(-1, 10, 800, 2);, "Verdana")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetCursor(-1, 9)

$X_icon = GUICtrlCreateIcon("Shell32.dll", -132, 980, 4, 16, 16)
GUICtrlSetTip(-1, "exit")
GUICtrlSetCursor(-1, 0)
$minimize_icon = GUICtrlCreateLabel("_", 960, -3, 16, 32)
GUICtrlSetFont(-1, 14, 800)
GUICtrlSetColor(-1, 0xB00000)
GUICtrlSetTip(-1, "minimize")
GUICtrlSetCursor(-1, 0)

GUICtrlCreateGraphic(0, 40, 999, 2)
GUICtrlSetBkColor(-1, 0x0053A6)
GUICtrlSetState(-1, $GUI_DISABLE)

GUICtrlCreateGraphic(0, 50, 999, 193)
GUICtrlSetBkColor(-1, 0x003D79)
GUICtrlSetState(-1, $GUI_DISABLE)
$y_coord = 235+10
GUICtrlCreateGraphic(0, $y_coord-3, 999, 2)
GUICtrlSetBkColor(-1, 0x0053A6)
GUICtrlSetState(-1, $GUI_DISABLE)

$x_coord = 5
;~ $y_coord = 235+10
$gw = 16
$gh = 70
$x_upper = $x_coord-8
dim $button[89]
for $i = 1 to 88
		if $b_count < 12 Then
			$b_count += 1
		Else
			$b_count = 1
		EndIf
		if $b_count <> 1 and $b_count <> 3 and $b_count <> 4 and $b_count <> 6 and $b_count <> 8 and $b_count <> 9 and $b_count <> 11 then
			if $b_count = 5 OR $b_count = 10 then
				$x_upper += ($gw+3)*2
			Else
				$x_upper += $gw+3
			EndIf
			$button[$i] = GUICtrlCreateButton("", $x_upper, $y_coord, $gw, $gh, $WS_CLIPSIBLINGS)
			GUICtrlSetCursor(-1, 0)
			GUICtrlSetBkColor(-1, 0x191919)
		EndIf
next
$b_count = 0
$zw = 20
$zh = 110
for $i = 1 to 88
	if $b_count < 12 Then
		$b_count += 1
	Else
		$b_count = 1
	EndIf
	if $b_count <> 2 AND $b_count <> 5 AND $b_count <> 7 AND $b_count <> 10 AND $b_count <> 12 Then
		$button[$i] = GUICtrlCreateButton("", $x_coord, $y_coord, $zw, $zh, $WS_CLIPSIBLINGS)
		GUICtrlSetCursor(-1, 0)
		$x_coord += $zw-1
	EndIf
Next

$position2 = WinGetPos($form1)
$position2b = WinGetClientSize($form1)
$light_border = ($position2[2]-$position2b[0])/2
$thick_border = ($position2[3]-$position2b[1])-$light_border
$x_first = $light_border+7
$y_first = $thick_border-3+27

GUICtrlCreateLabel("Available instruments:", $x_first, 10, 240, 17, $ES_CENTER)
GUICtrlSetFont(-1, 10, 800, 2)
GUICtrlSetColor(-1, 0xFFFFFF)

GUICtrlCreateGroup("", $x_first-1, $y_first-7, 242, 217)
GUICtrlCreateGraphic($x_first, $y_first, 240, 209)
;~ GUICtrlSetBkColor(-1, 0x001F3E);ovdee
GUICtrlSetBkColor(-1, 0);ovdee
GUICtrlSetState(-1, $GUI_DISABLE)
$instruments = _GUICtrlListView_Create($form1, "", $x_first, $y_first, 240, 190)
$current_instrument = GUICtrlCreateLabel("Current: 0 - Grand Piano", $x_first, $y_first+190, 240, 18, $ES_CENTER)
GUICtrlSetColor(-1, 0x9FCFFF);0xCEE9FF
GUICtrlSetFont(-1, 10, 800, 2)
;~ GUICtrlSetBkColor(-1, 0x001F3E)
GUICtrlSetBkColor(-1, 0)
_GUICtrlListView_SetExtendedListViewStyle($instruments, $LVS_EX_FULLROWSELECT)
_GUICtrlListView_SetTextColor($instruments, 0xFFFFFF)
_GUICtrlListView_SetTextBkColor($instruments, 0x3E1F00)
_GUICtrlListView_SetBkColor($instruments, 0x3E1F00)
_GUICtrlListView_AddColumn($instruments, "No.", 40)
_GUICtrlListView_AddColumn($instruments, "Instrument", 170)
$INSTRUMENTS_chars = "Grand Piano|Bright Piano|Electric Grand Piano|Honky-Tonk Piano|Electric piano 1|Electric Piano 2|Harpsichord|Clavinet|Celesta|Glockenspiel|Music Box|" _
				& "Vibraphone|Marimba|Xylophone|Tubular bells|Dulcimer|Drawbar Organ|Percussive Organ|Rock Organ|Church Organ|Reed Organ|Accordion|Harmonica|Tango Accordion|" _
				& "Nylon String Guitar|Steel String Guitar|Jazz Guitar|Clean Electric Guitar|Muted Electric Guitar|Overdrive Guitar|Distortion Guitar|Guitar Harmonics|Accoustic Bass|" _
				& "Fingered Bass|Picked Bass|Fretless Bass|Slap Bass 1|Slap Bass 2|Synth Bass 1|Synth Bass 2|Violin|Viola|Cello|Contrabass|Tremolo Strings|Pizzicato Strings|" _
				& "Orchestral Harp|Timpani|String Ensemble 1|String Ensemble 2|Synth Strings 1|Synth Strings 2|Choir ahh|Choir oohh|Synth Voice|Orchestral Hit|Trumpet|Trombone|" _
				& "Tuba|Muted Trumpet|French Horn|Brass Section|Synth Brass 1|Synth Brass 2|Soprano Sax|Alto Sax|Tenor Sax|Baritone Sax|Oboe|English Horn|Bassoon|Clarinet|Piccolo|" _
				& "Flute|Recorder|Pan flute|Blown Bottle|Shakuhachi|Whistle|Ocarina|Square Wave|Sawtooth Wave|Caliope|Chiff|Charang|Voice|Fifths|Bass & Lead|New Age|Warm|PolySynth|" _
				& "Choir|Bowed|Metallic|Halo|Sweep|FX: Rain|FX: Soundtrack|FX: Crystal|FX: Atmosphere|FX: Brightness|FX: Goblins|FX: Echo Drops|FX: Star Theme|Sitar|Banjo|Shamisen|" _
				& "Koto|Kalimba|Bagpipe|Fiddle|Shanai|Tinkle bell|Agogo|Steel Drums|Woodblock|Taiko Drum|Melodic Tom|Synth Drum|Reverse Cymbal|Guitar Fret Noise|Breath Noise|Seashore|" _
				& "Bird Tweet|Telephone Ring|Helicopter|Applause|Gunshot"
$inst_split = StringSplit($INSTRUMENTS_chars, "|")
_GUICtrlListView_BeginUpdate($instruments)
	For $i = 0 To 127
		_GUICtrlListView_AddItem($instruments, $I)
		_GUICtrlListView_AddSubItem($instruments, $I, $inst_split[$i+1], 1)
	Next
_GUICtrlListView_EndUpdate($instruments)
GUICtrlCreateGroup("", -99, -99, 1, 1)  ;close group

GUICtrlCreateLabel("Play script:", $x_first+250+8, 10+9, 80, 17, $ES_CENTER)
GUICtrlSetFont(-1, 10, 800, 2)
GUICtrlSetColor(-1, 0xFFFFFF)

GUICtrlCreateGroup("", $x_first+250-1, 30-7+9, 342+100+100, 205)
GUICtrlCreateGraphic($x_first+250, 30+9, 440+100, 197)
GUICtrlSetBkColor(-1, 0)
;~ GUICtrlSetBkColor(-1, 0x001F3E);ovdee
GUICtrlSetState(-1, $GUI_DISABLE)
$play_script_lw = _GUICtrlListView_Create($form1, "", $x_first+250, 30+9, 340+100+100, 176)
_GUICtrlListView_SetExtendedListViewStyle($play_script_lw, $LVS_EX_FULLROWSELECT)
_GUICtrlListView_SetTextColor($play_script_lw, 0xFFFFFF)
_GUICtrlListView_SetTextBkColor($play_script_lw, 0x3E1F00);0x3E1F00
_GUICtrlListView_SetBkColor($play_script_lw, 0x3E1F00)
_GUICtrlListView_AddColumn($play_script_lw, "Line", 40)
_GUICtrlListView_AddColumn($play_script_lw, "Note", 65)
_GUICtrlListView_AddColumn($play_script_lw, "Instrument", 139)
_GUICtrlListView_AddColumn($play_script_lw, "Duration [ms]", 75)
_GUICtrlListView_AddColumn($play_script_lw, "Key index", 90)
_GUICtrlListView_AddColumn($play_script_lw, "Time [mm:ss:ms]", 100)

$button_record = GUICtrlCreateButton("Record", $x_first+10+250-7, 206+9, 50, 21)
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlSetBkColor(-1, 0x0)
$button_play = GUICtrlCreateButton("Play", $x_first+60+250-7, 206+9, 35, 21)
$button_stop = GUICtrlCreateButton("Stop", $x_first+95+250-7, 206+9, 35, 21)
$button_insert_pause = GUICtrlCreateButton("Insert Pause", $x_first+130+250-7, 206+9, 70, 21)
$progress_time = GUICtrlCreateProgress($x_first+202+250-7, 208+9, 100, 17)
DllCall("UxTheme.dll", "int", "SetWindowTheme", "hwnd", GUICtrlGetHandle(-1), "wstr", 0, "wstr", 0)
GUICtrlSetStyle(-1, BitOr($GUI_SS_DEFAULT_PROGRESS, $PBS_SMOOTH))
GUICtrlSetColor(-1, 0x005B88)
GUICtrlSetBkColor(-1, 0xC4E1FF)
;~ GUICtrlSetData(-1, 25)
GUICtrlSetCursor(-1, 0)
$time_input = GUICtrlCreateInput("00:00", $x_first+300+250-2, 208+9, 40, 17, $ES_CENTER+$ES_READONLY)
GUICtrlSetBkColor(-1, 0x0053A6)
GUICtrlSetColor(-1, 0xFFFFFF)
$button_click_down = GUICtrlCreateButton("Hold down!", $x_first+300+250-2+42, 206+9, 70, 21)
$button_click_up = GUICtrlCreateButton("Release keys!", $x_first+300+250-2+42+70, 206+9, 75, 21)
$button_finish_clicking = GUICtrlCreateButton("Finish!", $x_first+300+250-2+42+70+75, 206+9, 49, 21)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlCreateGroup("", -99, -99, 1, 1)  ;close group

$width_opt = 100
$height_opt = 44
$x_pos_opt = $x_first+600+100+100
$y_pos_opt = 60

GUICtrlCreateGroup("", $x_pos_opt-1, $y_pos_opt-7, $width_opt+2, $height_opt+8)
GUICtrlCreateGraphic($x_pos_opt, $y_pos_opt, $width_opt, $height_opt)
GUICtrlSetBkColor(-1, 0x9FCFFF)
GUICtrlSetState(-1, $GUI_DISABLE)

$instant_rec = GUICtrlCreateCheckbox("Instant record", $x_pos_opt+5, $y_pos_opt+5, $width_opt-10, 17)
GUICtrlSetBkColor(-1, 0x9FCFFF)
$display_tooltip_checkbox = GUICtrlCreateCheckbox("Key tooltip", $x_pos_opt+5, $y_pos_opt+22, $width_opt-10, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlSetBkColor(-1, 0x9FCFFF)
GUICtrlCreateGroup("", -99, -99, 1, 1)  ;close group

$width_key_display = 100
$height_key_display = 70
$x_pos_key_display = $x_first+600+100+100
$y_pos_key_display = 115

GUICtrlCreateGroup("", $x_pos_key_display-1, $y_pos_key_display-7, $width_key_display+2, $height_key_display+8)
GUICtrlCreateGraphic($x_pos_key_display, $y_pos_key_display, $width_key_display, $height_key_display)
GUICtrlSetBkColor(-1, 0)
GUICtrlSetState(-1, $GUI_DISABLE)
$key_edit_display = GUICtrlCreateEdit("", $x_pos_key_display+1, $y_pos_key_display+1, $width_key_display-2, $height_key_display-2, $ES_MULTILINE+$ES_READONLY, $WS_EX_WINDOWEDGE)
GUICtrlSetBkColor(-1, 0)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlCreateGroup("", -99, -99, 1, 1)  ;close group

$width_down_display = 180
$height_down_display = 41
$x_pos_down_display = $x_first+600+100+100
$y_pos_down_display = 195
GUICtrlCreateGroup("", $x_pos_down_display-1, $y_pos_down_display-7, $width_down_display+2, $height_down_display+8)
GUICtrlCreateGraphic($x_pos_down_display, $y_pos_down_display, $width_down_display, $height_down_display)
GUICtrlSetBkColor(-1, 0)
GUICtrlSetState(-1, $GUI_DISABLE)
$edit_click_down = GUICtrlCreateEdit("", $x_pos_down_display+1, $y_pos_down_display+1, $width_down_display-2, $height_down_display-2, $ES_MULTILINE+$ES_READONLY, $WS_EX_WINDOWEDGE)
GUICtrlSetBkColor(-1, 0)
GUICtrlSetColor($edit_click_down, 0xFFFFFF)
GUICtrlCreateGroup("", -99, -99, 1, 1)  ;close group

$width_opet = 70
$height_opet = 125
$x_opet = $x_first+910
$y_opet = 60

GUICtrlCreateGroup("", $x_opet-1, $y_opet-7, $width_opet+2, $height_opet+8)
GUICtrlCreateGraphic($x_opet, $y_opet, $width_opet, $height_opet)
GUICtrlSetBkColor(-1, 0)
GUICtrlSetState(-1, $GUI_DISABLE)
$nota_slika = GUICtrlCreatePic("nota.jpg", $x_opet+1, $y_opet+1, $width_opet-2, $height_opet-2)
GUICtrlCreateGroup("", -99, -99, 1, 1)  ;close group


$form2 = GUICreate("Toolbar", 100, 27, 100+$x_first+250-7, 2+9, $WS_POPUP, $WS_EX_MDICHILD, $form1)
GUISetBkColor(0)
Global $hToolbar, $iMemo
Global $iItem ; Command identifier of the button associated with the notification.
Global Enum $idNew = 1000, $idOpen, $idSave, $idHelp

$hToolbar = _GUICtrlToolbar_Create ($form2, $WS_TABSTOP+0x00000800)

	$hToolTip = _GUIToolTip_Create($hToolbar)
	_GUICtrlToolbar_SetToolTips($hToolbar, $hToolTip)
	
	_GUICtrlToolbar_SetToolTips($hToolbar, $hToolTip)
	_GUICtrlToolbar_SetExtendedStyle($hToolbar, $TBSTYLE_EX_DRAWDDARROWS)
	_GUICtrlToolbar_GetStyleTransparent($hToolbar)
	_GUICtrlToolbar_SetColorScheme($hToolbar, 0x000000, 0x000000);0x3E1F00, 0x3E1F00)
	
	Global $hImage = _GUIImageList_Create(16, 16, 5, 3, 3)
	
	_GUIImageList_AddIcon($hImage, "Shell32.dll", 140) ;new    0
	_GUIImageList_AddIcon($hImage, "Shell32.dll", 193);-7) ;save    1
	_GUIImageList_AddIcon($hImage, "Shell32.dll", -9) ;open    2, -9, -127
	
	_GUICtrlToolbar_SetImageList($hToolbar, $hImage)
	
	_GUICtrlToolbar_AddButton ($hToolbar, $idNew, 0);, $new_button_txt)
	_GUICtrlToolbar_AddButton ($hToolbar, $idSave, 1, -1, $BTNS_DROPDOWN)
	_GUICtrlToolbar_AddButton ($hToolbar, $idOpen, 2);, $open_button_txt)

WinSetTrans($form2, "", 255)

GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")

GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
initMinMax(999+6,360+6,999+6,360+6)
GUISetState(@SW_SHOW, $Form2)
GUISetState(@SW_SHOW, $form1)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE, $X_icon
			_MidiOutClose($Open)
			Exit
		case $title_label, $title_label_signature;, $graph[1] to $graph[9]
			dllcall("user32.dll","int","SendMessage","hWnd", $Form1,"int",0xA1,"int", 2,"int", 0)
		case $minimize_icon
			GUISetState(@SW_MINIMIZE, $form1)
		case $button_record
			if $recording = false Then
				$recording = True
				GUICtrlSetColor($button_record, 0x0)
				GUICtrlSetBkColor($button_record, 0xFF0000)
			Else
				$recording = False
				GUICtrlSetColor($button_record, 0xFF0000)
				GUICtrlSetBkColor($button_record, 0x0)
			EndIf
		case $button_stop
			if $recording = True Then
				$recording = False
				GUICtrlSetColor($button_record, 0xFF0000)
				GUICtrlSetBkColor($button_record, 0x0)
			EndIf
		case $button_click_down
			$holding = true
			$hold_type_down = true
			GUICtrlSetState($button_click_down, $GUI_DISABLE)
			GUICtrlSetState($button_click_up, $GUI_DISABLE)
			GUICtrlSetState($button_finish_clicking, $GUI_ENABLE)
			GUICtrlSetColor($edit_click_down, 0xFF0000)
			GUICtrlSetData($edit_click_down, "Hold down keys [index]:")
		case $button_click_up
			$holding = true
			$hold_type_down = false
			GUICtrlSetState($button_click_up, $GUI_DISABLE)
			GUICtrlSetState($button_click_down, $GUI_DISABLE)
			GUICtrlSetState($button_finish_clicking, $GUI_ENABLE)
			GUICtrlSetColor($edit_click_down, 0x00FF00)
			GUICtrlSetData($edit_click_down, "Release keys [index]:")
		case $button_finish_clicking
			$holding = false
			GUICtrlSetState($button_click_down, $GUI_ENABLE)
			GUICtrlSetState($button_click_UP, $GUI_ENABLE)
			GUICtrlSetState($button_finish_clicking, $GUI_DISABLE)
			if GUICtrlRead($edit_click_down) <> "" AND $recording = true then
				$citanje = StringSplit(GUICtrlRead($edit_click_down), ":")
				if $citanje[0] = 2 then
					$citanje = StringTrimLeft($citanje[2], 2)
					if $citanje = "" then ContinueCase
					$sve = StringSplit($citanje, ",")
					dim $play_array[$sve[0]]
					for $i = 1 to $sve[0]
						$play_array[$i-1] = $sve[$i]
					Next
					$readingz = StringSplit(GUICtrlRead($current_instrument), "-")
					$readingz = Number(StringTrimLeft($readingz[1], 9))
					play($open, $play_array, 100, $readingz)
					if $hold_type_down = true Then
						_real_record_note(_ArrayToString($play_array, ","), "KeysDown", "-", "-")
					Else
						_real_record_note(_ArrayToString($play_array, ","), "KeysUp", "-", "-")
					EndIf
				EndIf
			EndIf
			GUICtrlSetData($edit_click_down, "")
	EndSwitch
	
	if WinActive($form1) OR WinActive($form2) Then
		Local $c = GUIGetCursorInfo($Form1)
		Switch $c[4]
			case $button[2] to $button[88]
				Local $current
				for $i = 1 to 88
					if $c[4] = $button[$i] Then
						$current = $i
						ExitLoop
					EndIf
				Next
				_play_on_click($button[$current], $current)
			case $progress_time
				Local $position_x = $c[0]-($x_first+202+250-7)
				if _IsPressed(01) Then
					Do
						$c = GUIGetCursorInfo($Form1)
						$position_x = $c[0]-($x_first+202+250-7)
						GUICtrlSetData($progress_time, $position_x)
						Local $selection_item_index = Round(_GUICtrlListView_GetItemCount($play_script_lw)*GUICtrlRead($progress_time)/100)
						_GUICtrlListView_EnsureVisible($play_script_lw, $selection_item_index)
						_GUICtrlListView_SetItemSelected($play_script_lw, $selection_item_index)
						Local $some_rd = StringLeft(_GUICtrlListView_GetItemText($play_script_lw, $selection_item_index, 5), 5)
;~ 						if $some_rd <> "" then GUICtrlSetData($time_input, $some_rd)
						Sleep(10)
					Until NOT _IsPressed(01)
				EndIf
			case $button_insert_pause
				if _IsPressed(01) Then
					Local $some_crap_timer = TimerInit()
					Do
					Until NOT _IsPressed(01)
					$timer_length = TimerDiff($some_crap_timer)
					if $recording = true then
;~ 						if $holding = false then
							if GUICtrlRead($instant_rec) = $GUI_CHECKED Then
								_real_record_note("-", "Pause", "-", Round($timer_length/10)*10)
							Else
								_record_note("-", "Pause", "-", Round($timer_length/10)*10)
							EndIf
;~ 						Else
							
;~ 						EndIf
					EndIf
				EndIf
		EndSwitch
		if $check_tooltip = true and TimerDiff($tooltip_Timer) >= 100 then
			ToolTip("")
			$check_tooltip = False
		EndIf
	EndIf
WEnd

func _play_on_click($Control_handle, $index)
	$tooltip_Timer = TimerInit()
	$check_tooltip = true
	Local $current_string_add = Int(($index-1)/12)
	Local $display_string = $index - $current_string_add*12
	Local $octave = Ceiling(($index-3)/12)*12
	$display_tooltip = "Note: " & $all_strings_split[$display_string] & @CRLF _
						& "Octave: " & $octave/12 & @CRLF _
						& "Index: " & $index
	if GUICtrlRead($display_tooltip_checkbox) = $GUI_CHECKED then
		ToolTip($display_tooltip, MouseGetPos(0), MouseGetPos(1)+20, "Key Info:", 1, 1+2)
	EndIf
	if $old_index <> $index Then
		GUICtrlSetData($key_edit_display, "Key info:" & @crlf & @crlf & $display_tooltip)
		$old_index = $index
	EndIf
    if _IsPressed(01) Then
		$play_length_timer = TimerInit()
		NoteOn($Open, $index)
        Do
        Until NOT _IsPressed(01)
		$timer_length = TimerDiff($play_length_timer)
		NoteOff($open, $index)
		if $recording = true then
			if $holding = False then
				if GUICtrlRead($instant_rec) = $GUI_CHECKED Then
					_real_record_note($index, $all_strings_split[$display_string], $octave/12, Round($timer_length/10)*10)
				Else
					_record_note($index, $all_strings_split[$display_string], $octave/12, Round($timer_length/10)*10)
				EndIf
			Else
				if StringRight(GUICtrlRead($edit_click_down), 1) = ":" then
					GUICtrlSetData($edit_click_down, GUICtrlRead($edit_click_down) & @CRLF & $index)
				Else
					GUICtrlSetData($edit_click_down, GUICtrlRead($edit_click_down) & "," & $index)
				EndIf
			EndIf
		EndIf
    EndIf
EndFunc

func _real_record_note($index, $note, $octave, $length)
	Local $next_row = _get_list_selection($play_script_lw);_GUICtrlListView_GetItemCount ($play_script_lw)
	if $next_row = -1 then
		$next_row = 0
	Else
		$next_row+= 1
	EndIf
;~ 	if $next_row <> 0 then $next_row+= 1
;~ 	_GUICtrlListView_InsertItem
	_GUICtrlListView_BeginUpdate($play_script_lw)
		_GUICtrlListView_InsertItem($play_script_lw, $next_row, $next_row)
		Local $total_numb = _GUICtrlListView_GetItemCount($play_script_lw)
		_update_list_items_in_front($next_row, $total_numb)
		_update_times($next_row, $total_numb, $length)
		_GUICtrlListView_SetItemText($play_script_lw, $next_row,  $note, 1)
		if $note = "Pause" Then
			_GUICtrlListView_SetItemText($play_script_lw, $next_row, "-", 2)
		Else
			_GUICtrlListView_SetItemText($play_script_lw, $next_row,  StringTrimLeft(GUICtrlRead($current_instrument), 9), 2);"0 - Grand Piano", 2)
		EndIf
		_GUICtrlListView_SetItemText($play_script_lw, $next_row,  $length, 3)
		_GUICtrlListView_SetItemText($play_script_lw, $next_row,  $index, 4)
;~ 		_GUICtrlListView_SetItemText($play_script_lw, $next_row, , 5
;~ 		_GUICtrlListView_InsertItem($play_script_lw, $next_row+1, $next_row+1)
	_GUICtrlListView_EndUpdate($play_script_lw)	
	_GUICtrlListView_EnsureVisible($play_script_lw, $next_row)
	_GUICtrlListView_SetItemSelected($play_script_lw, $next_row)
EndFunc

func _update_times($i_current_index, $total_numb, $length)
	if $i_current_index = 0 Then
;~ 		GUICtrlSetData($time_input, "00:00")
		_GUICtrlListView_SetItemText($play_script_lw, $i_current_index, "00:00:000", 5)
	Else
		Local $final_time
		if $i_current_index+1 = $total_numb then
			for $i = 0 to $i_current_index
				$final_time += _GUICtrlListView_GetItemText($play_script_lw, $i, 3)
			Next
			Local $time_to_input = _time_converter($final_time, 1)
			_GUICtrlListView_SetItemText($play_script_lw, $i_current_index, $time_to_input, 5)
;~ 			GUICtrlSetData($time_input, StringLeft($time_to_input, 5))
		else
			_GUICtrlListView_SetItemText($play_script_lw, $i_current_index, _GUICtrlListView_GetItemText($play_script_lw, $i_current_index+1, 5), 5)
			for $i = $i_current_index+1 to $total_numb-1
				
;~ 				MsgBox(0, "", _GUICtrlListView_GetItemText($play_script_lw, $i, 5))
				Local $previous_time = _time_converter(_GUICtrlListView_GetItemText($play_script_lw, $i, 5), 2)
;~ 				MsgBox(0, "", $previous_time)
;~ 				ConsoleWrite($previous_time & @CRLF)
				Local $create_new_time = $length+$previous_time
;~ 				MsgBox(0, "", $create_new_time)
;~ 				MsgBox(0, "", _time_converter($create_new_time, 1))
				_GUICtrlListView_SetItemText($play_script_lw, $i, _time_converter($create_new_time, 1), 5)
;~ 				GUICtrlSetData($time_input, StringLeft(_GUICtrlListView_GetItemText($play_script_lw, $i_current_index+1, 5), 5))
;~ 				_GUICtrlListView_SetItemText($play_script_lw, $i-1, _GUICtrlListView_GetItemText($play_script_lw, $i, 5), 5)
			Next
		EndIf
	EndIf
EndFunc

func _time_converter($final_time, $type)
	if $type = 1 then
		Local $minutes = Int($final_time/60000)
		Local $secundes = Int($final_time/1000)-$minutes*60
		Local $milisec = $final_time-$secundes*1000-$minutes*60000
		if StringLen($minutes) = 1 then $minutes = "0" & $minutes
		if StringLen($secundes) = 1 then $secundes = "0" & $secundes
		if StringLen($milisec) = 1 then
			$milisec = "00" & $milisec
		elseif StringLen($milisec) = 2 Then
			$milisec = "0" & $milisec
		EndIf
		Return String($minutes & ":" & $secundes & ":" & $milisec)
	Elseif $type = 2 then
		$splitting = StringSplit($final_time, ":")
		for $i = 1 to $splitting[0]
;~ 			MsgBox(0, "", Number($splitting[$i]) & @CRLF & $i)
		Next
		$ret_val = (Number($splitting[1])*60000+Number($splitting[2])*1000+Number($splitting[3]))
;~ 		MsgBox(0, "", $splitting[0] & @CRLF & $splitting[1] & @CRLF & $splitting[2])
		Return $ret_val
	EndIf
EndFunc

func _update_list_items_in_front($i_current_index, $total_numb)
;~ 	ConsoleWrite($i_current_index & ", " & $total_numb & @CRLF)
	if $i_current_index+1 = $total_numb then Return 0
	for $i = $i_current_index+1 to $total_numb
		_GUICtrlListView_SetItemText($play_script_lw, $i, $i)
	Next
EndFunc

func _record_note($index, $note, $octave, $length, $edit = false, $indexxx = 0, $instrummment = "0 - Grand Piano")
	Local $GUI_record = GUICreate("Record", 160, 135+25, -1, -1, -1, -1, $form1)
	GUICtrlCreateLabel("Length:", 5, 5+3+75, 45, 17)
	Local $length_x = GUICtrlCreateInput($length, 5+50, 5+75, 60, 21)
	GUICtrlCreateUpdown(-1)
	GUICtrlCreateLabel("[milisec]", 70+46, 5+3+75, 45, 17)
	GUICtrlCreateLabel("Index:", 5, 5+3, 45, 17)
	Local $index_x = GUICtrlCreateInput($index, 55, 5, 100, 20)
;~ 	GUICtrlSetLimit(-1, 2, 1)
	GUICtrlCreateUpdown(-1)
	GUICtrlSetLimit(-1, 88, 1)
	GUICtrlCreateLabel("Note:", 5, 5+3+25, 40, 17)
	Local $note_x = GUICtrlCreatecombo("", 55, 5+25, 100, 20, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, "A|A# or Bb(Hb)|B(H)|C|C# or Db|D|D# or Eb|E|F|F# or Gb|G|G# or Ab|Pause|KeysDown|KeysUp", $note)
	GUICtrlCreateLabel("Octave:", 5, 5+3+50, 45, 17)
	Local $octave_x = GUICtrlCreateInput($octave, 55, 5+50, 100, 20)
	GUICtrlSetLimit(-1, 1, 1)
	GUICtrlCreateUpdown(-1)
	GUICtrlSetLimit(-1, 8, 0)
	if $octave = "" then
		$octave = Ceiling(($index-3)/12)
;~ 		ConsoleWrite($index & @CRLF)
		GUICtrlSetData($octave_x, $octave)
	EndIf
	if $edit = true then
	Local $instrument_x = GUICtrlCreateCombo("", 5, 5+3+100, 150, 21)
	$x_instr = StringSplit($INSTRUMENTS_chars, "|")
	dim $loc_array[$x_instr[0]]
;~ 	$inst_split = StringSplit($INSTRUMENTS_chars, "|")
;~ 	_GUICtrlListView_BeginUpdate($instruments)
		For $i = 0 To 127
			$loc_array[$i] = $i & " - " & $x_instr[$i+1]
;~ 			_GUICtrlListView_AddItem($instruments, $I)
;~ 			_GUICtrlListView_AddSubItem($instruments, $I, $inst_split[$i+1], 1)
		Next
		$string_to_add = _ArrayToString($loc_array, "|")
		GUICtrlSetData($instrument_x, $string_to_add, $instrummment)
	_GUICtrlListView_EndUpdate($instruments)
	EndIf
	GUISetState(@SW_DISABLE, $Form1)
	GUISetState(@SW_SHOW, $GUI_record)
	Local $button_ok = GUICtrlCreateButton("OK", 5, 5+3+100+25, 72, 21)
	Local $button_canc = GUICtrlCreateButton("Cancel", 5+6+72, 5+3+100+25, 72, 21)
	While 1
		Local $nMsg2 = GUIGetMsg($GUI_record)
		Switch $nMsg2
			case $GUI_EVENT_CLOSE, $button_canc
				GUIDelete($GUI_record)
				GUISetState(@SW_ENABLE, $form1)
				ExitLoop
			case $button_ok, $length_x
				if $edit = false then
					_real_record_note(GUICtrlRead($index_x), GUICtrlRead($note_x), GUICtrlRead($octave_x), GUICtrlRead($length_x));, GUICtrlRead($instrument_x))
				Else
					_GUICtrlListView_SetItemText($play_script_lw, $indexxx, GUICtrlRead($note_x), 1)
					_GUICtrlListView_SetItemText($play_script_lw, $indexxx, GUICtrlRead($instrument_x), 2)
					_GUICtrlListView_SetItemText($play_script_lw, $indexxx, GUICtrlRead($length_x), 3)
					_GUICtrlListView_SetItemText($play_script_lw, $indexxx, GUICtrlRead($index_x), 4)
				EndIf
				GUIDelete($GUI_record)
				GUISetState(@SW_ENABLE, $form1)
				WinActivate($form1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc

Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)
	Switch $iwParam
		case $button_play
			$remembered_index = _get_list_selection($play_script_lw)
			$playing = true
			if $recording = True Then
				$recording = False
				GUICtrlSetColor($button_record, 0xFF0000)
				GUICtrlSetBkColor($button_record, 0x0)
			EndIf
			Local $first_item = _get_list_selection($play_script_lw)
			if $first_item = -1 then $first_item = 0
			for $i = $first_item to _GUICtrlListView_GetItemCount($play_script_lw)-1
				if $playing = false then ExitLoop
				_GUICtrlListView_EnsureVisible($play_script_lw, $i)
				_GUICtrlListView_SetItemSelected($play_script_lw, $i)
				if _GUICtrlListView_GetItemText($play_script_lw, $i, 1) = "Pause" Then
					Sleep(_GUICtrlListView_GetItemText($play_script_lw, $i, 3))
				Else
					Local $i_instrument = StringSplit(_GUICtrlListView_GetItemText($play_script_lw, $i, 2), "-")
					$i_instrument = Number($i_instrument[1])
					Local $some_note = _GUICtrlListView_GetItemText($play_script_lw, $i, 1)
;~ 					MsgBox(0, "", $some_note)
					if $some_note = "KeysDown" Then
						play($open, _string_to_array(_GUICtrlListView_GetItemText($play_script_lw, $i, 4), ","), _GUICtrlListView_GetItemText($play_script_lw, $i, 3), $i_instrument, true)
					elseif $some_note = "KeysUp" then
						release_keys($open, _string_to_array(_GUICtrlListView_GetItemText($play_script_lw, $i, 4), ","))
					Else
						play($open, _GUICtrlListView_GetItemText($play_script_lw, $i, 4), _GUICtrlListView_GetItemText($play_script_lw, $i, 3), $i_instrument)
					EndIf
				EndIf
;~ 				GUICtrlSetData($time_input, StringLeft(_GUICtrlListView_GetItemText($play_script_lw, $i+1, 5), 5))
;~ 				GUICtrlSetData($progress_time, Round(100*($the_ITEM+1)/_GUICtrlListView_GetItemCount($play_script_lw))+1)
				GUICtrlSetData($progress_time, int(100*($i+1)/_GUICtrlListView_GetItemCount($play_script_lw))+1);<-ovde sam
			Next
			$readingz = StringSplit(GUICtrlRead($current_instrument), "-")
			$readingz = Number(StringTrimLeft($readingz[1], 9))
			SetInstrument($open, $readingz)
			if $remembered_index <> -1 then
				_GUICtrlListView_EnsureVisible($play_script_lw, $remembered_index)
				_GUICtrlListView_SetItemSelected($play_script_lw, $remembered_index)
			EndIf
		case $button_stop
			$playing = false
			if $remembered_index <> -1 then
				_GUICtrlListView_EnsureVisible($play_script_lw, $remembered_index)
				_GUICtrlListView_SetItemSelected($play_script_lw, $remembered_index)
			EndIf
			_MidiOutClose($Open)
			$Open = _MidiOutOpen()
		case $idNew
			if MsgBox(3+32+262144, "question", "are you sure you wanna start new project?") = 6 then _GUICtrlListView_DeleteAllItems($play_script_lw)
		case $idSave
			$save_path = FileSaveDialog("save your play script", "", "PlayScripts (*.PSC)", 16+2)
			if @error then ContinueCase
			if StringRight($save_path, 4) <> ".PSC" then $save_path &= ".PSC"
			if FileExists($save_path) then
				FileDelete($save_path)
				FileWrite($save_path, "")
			EndIf
			for $i = 0 to _GUICtrlListView_GetItemCount($play_script_lw)-1
				$tekst = ""
				for $j = 0 to 5
					$tekst &= _GUICtrlListView_GetItemText($play_script_lw, $i, $j) & "|"
				Next
				$tekst = StringTrimRight($tekst, 1)
				FileWriteLine($save_path, $tekst)
			Next
			FileClose($save_path)
		case $idOpen
			if MsgBox(3+32+262144, "question", "are you sure you wanna open without saving?") = 6 then
				_GUICtrlListView_DeleteAllItems($play_script_lw)
			Else
				ContinueCase
			EndIf
			$open_path = FileOpenDialog("open play script", "", "PlayScript (*.PSC)|All Files (*.*)", 1+2)
			if @error then ContinueCase
			$file_line = ""
			$count = 0
			While 1
				$count += 1
				$file_line = FileReadLine($open_path, $count)
				if @error then ExitLoop
				$splitted = StringSplit($file_line, "|")
				$cur_indx = _GUICtrlListView_GetItemCount($play_script_lw)
				_GUICtrlListView_InsertItem($play_script_lw, $splitted[1], $cur_indx)
				for $i = 1 to 5
					_GUICtrlListView_SetItemText($play_script_lw, $cur_indx, $splitted[$i+1], $i)
				Next
			WEnd
			FileClose($open_path)
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc

func release_keys($handle, $array)
	for $i = 0 to UBound($array)-1
		NoteOff($handle, $array[$i])
	Next
EndFunc

func _string_to_array($string, $delimiter)
	$string = StringSplit($string, $delimiter)
	Local $some_array[$string[0]]
	for $i = 0 to $string[0]-1
		$some_array[$i] = $string[$i+1]
	Next
	Return $some_array
EndFunc

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg, $iwParam
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView, $tInfo, $iID
;~ 	Local $tBuffer
	$hWndListView = $instruments
	$hWndListView_playlist = $play_script_lw
	If Not IsHWnd($instruments) Then $hWndListView = GUICtrlGetHandle($instruments)
	if NOT IsHWnd($play_script_lw) then $hWndListView_playlist = GUICtrlGetHandle($play_script_lw)

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hWndListView
			Switch $iCode
				Case $NM_DBLCLK ; Sent by a list-view control when the user double-clicks an item with the left mouse button
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					Local $current_index = DllStructGetData($tInfo, "Index")
					Local $current_number = _GUICtrlListView_GetItemText($hWndListView, $current_index)
					SetInstrument($Open, $current_number)
					GUICtrlSetData($current_instrument, "Current: " & $current_number & " - " & _GUICtrlListView_GetItemText($hWndListView, $current_index, 1))
				EndSwitch
		case $hWndListView_playlist
			Switch $iCode
;~ 				case $NM_CLICK
				case $NM_DBLCLK
;~ 					ConsoleWrite(_get_list_selection($play_script_lw) & @LF)
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					Local $current_index = DllStructGetData($tInfo, "Index")
					Local $new_index = 50
					Local $new_note =  _GUICtrlListView_GetItemText($hWndListView_playlist, $current_index, 1)
					Local $new_octave = 4
					Local $new_length = _GUICtrlListView_GetItemText($hWndListView_playlist, $current_index, 3)
					$first_index = _GUICtrlListView_GetItemText($hWndListView_playlist, $current_index, 4)
					$second_note = _GUICtrlListView_GetItemText($hWndListView_playlist, $current_index, 1)
					$third_octave = ""
					$fourth_length = _GUICtrlListView_GetItemText($hWndListView_playlist, $current_index, 3)
					$fifth_instr = _GUICtrlListView_GetItemText($hWndListView_playlist, $current_index, 2)
					_record_note($first_index, $second_note, $third_octave, $fourth_length, true, $current_index, $fifth_instr)
;~ 					MsgBox(0, "", $new_index & @LF & $new_note & @LF & $new_octave & @lf & $new_length)
;~ 					_record_note($new_index, $new_note, $new_octave, $new_length)
		Case $LVN_INSERTITEM, $NM_CLICK
			Local $tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam)
			Local $the_ITEM = DllStructGetData($tInfo, "Item")
			GUICtrlSetData($progress_time, Round(100*($the_ITEM+1)/_GUICtrlListView_GetItemCount($play_script_lw))+1)
;~ 			GUICtrlSetData($time_input, StringLeft(_GUICtrlListView_GetItemText($play_script_lw, $the_ITEM, 5), 5))
		Case $LVN_ITEMCHANGING
			Local $tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam)
			Local $the_ITEM = DllStructGetData($tInfo, "Item")
			GUICtrlSetData($time_input, StringLeft(_GUICtrlListView_GetItemText($play_script_lw, $the_ITEM, 5), 5))
;~ 			GUICtrlSetData($progress_time, Round(100*($the_ITEM+1)/_GUICtrlListView_GetItemCount($play_script_lw))+1);<-ovde sam
;~ 			ConsoleWrite("promena" & @CRLF)
		Case $LVN_KEYDOWN ; A key has been pressed
				$tInfo = DllStructCreate($tagNMLVKEYDOWN, $ilParam)
				if DllStructGetData($tInfo, "VKey") = "22216750" then _GUICtrlListView_DeleteItemsSelected($hWndListView_playlist)
;~ 					ConsoleWrite("vkey: " & DllStructGetData($tInfo, "VKey") & @CRLF)
;~                     _DebugPrint("$LVN_KEYDOWN" & @LF & "--> hWndFrom:" & @TAB & $hWndFrom & @LF & _
;~                             "-->IDFrom:" & @TAB & $iIDFrom & @LF & _
;~                             "-->Code:" & @TAB & $iCode & @LF & _
;~                             "-->VKey:" & @TAB & DllStructGetData($tInfo, "VKey") & @LF & _
;~                             "-->Flags:" & @TAB & DllStructGetData($tInfo, "Flags"))
		EndSwitch
	EndSwitch

	$tInfo = DllStructCreate($tagNMTTDISPINFO, $ilParam)
	$iCode = DllStructGetData($tInfo, "Code")
	If $iCode = $TTN_GETDISPINFO Then
		$iID = DllStructGetData($tInfo, "IDFrom")
		Switch $iID
			Case $idNew
				DllStructSetData($tInfo, "aText", "New")
			Case $idOpen
				DllStructSetData($tInfo, "aText", "Open")
			Case $idSave
				DllStructSetData($tInfo, "aText", "Save")
		EndSwitch
	EndIf
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func SetInstrument($Handle, $Instrument)
    _MidiOutShortMsg($Handle,256 * $Instrument + 192)
EndFunc

func _get_list_selection($h_List)
	If Not IsHWnd($h_List) Then $h_List = GUICtrlGetHandle($h_List)
	Local $return_value
	Local $total_count = _GUICtrlListView_GetItemCount($h_List)
	if $total_count = 0 then Return -1
	for $i = 0 to $total_count
		if _GUICtrlListView_GetItemSelected($h_List, $i) = true Then
			$return_value = $i
			ExitLoop
		endif
	Next
	Return $return_value
EndFunc

Func Play($Handle, $Notes, $Duration, $instrument, $hold = false); Can play Single notes or use arrays for chords
	SetInstrument($open, $instrument)
If Isarray($Notes) Then
    For $i in $Notes
    If $i > 87 then Return 0
    $i-=1
    _MidiOutShortMsg($Handle, $Note[$i][0])
	Next
	if $hold = false then
		Sleep($Duration)
		For $i in $Notes
		$i-=1
		_MidiOutShortMsg($Handle, $Note[$i][1])
		Next
	endif
Else
    $Notes-=1
    _MidiOutShortMsg($Handle, $Note[$Notes][0])
    Sleep($Duration)
    _MidiOutShortMsg($Handle, $Note[$Notes][1])
EndIf
EndFunc

Func NoteOn($Handle, $NoteIdx)
    $Noteidx-=1
    _MidiOutShortMsg($Handle, $Note[$NoteIdx][0])
EndFunc

Func NoteOff($Handle, $NoteIdx)
    $NoteIdx-=1
    _MidiOutShortMsg($Handle, $Note[$NoteIdx][1])
Endfunc

Func initMinMax($x0,$y0,$x1,$y1)
    Local Const $WM_GETMINMAXINFO = 0x24
    $aUtil_MinMax[0]=$x0
    $aUtil_MinMax[1]=$y0
    $aUtil_MinMax[2]=$x1
    $aUtil_MinMax[3]=$y1
    GUIRegisterMsg($WM_GETMINMAXINFO,'MY_WM_GETMINMAXINFO')
EndFunc

Func MY_WM_GETMINMAXINFO($hWnd, $Msg, $wParam, $lParam)
    Local $minmaxinfo = DllStructCreate('int;int;int;int;int;int;int;int;int;int',$lParam)
    DllStructSetData($minmaxinfo,7,$aUtil_MinMax[0]); min X
    DllStructSetData($minmaxinfo,8,$aUtil_MinMax[1]); min Y
    DllStructSetData($minmaxinfo,9,$aUtil_MinMax[2]); max X
    DllStructSetData($minmaxinfo,10,$aUtil_MinMax[3]); max Y
    Return $GUI_RUNDEFMSG
EndFunc