#include <GUIConstants.au3> 
$file = "" 
GUICreate("Player", 250, 150, -1, -1, -1) 
GUISetIcon(@ProgramFilesDir & "\Winamp\winamp.exe", 0) 
GUICtrlCreateLabel("Simple player", 100, 5, 100, 15, -1) 

;Button 
$play = GUICtrlCreateButton("Play", 10, 115, 60) 
$open = GUICtrlCreateButton("Open", 10, 10, 60) 

;Slider 
$slider = GUICtrlCreateSlider(83, 115, 100, 30, -1) 
GUICtrlSetLimit($slider, 100, 0) 

GUISetState() 

While 1 
$msg = GUIGetMsg() 
Select 
Case $msg = $open 
$file = FileOpenDialog("Add selected file", "", "Sound files (*.mp3)", 1) 
If @error = 0 Then 
GUICtrlSetData($slider, 100) 
SoundPlay($file, 0) 
EndIf 
Case $msg = $play 
If Not $file = "" Then 
SoundPlay($file, 0) 
Else 
MsgBox(64, "Error", "Please open file") 
EndIf 
Case $msg = $slider 
$Read_slider = GUICtrlRead($slider) 
SoundSetWaveVolume($Read_slider) 
Case $msg = $Gui_Event_Close 
ExitLoop 
EndSelect 
WEnd 