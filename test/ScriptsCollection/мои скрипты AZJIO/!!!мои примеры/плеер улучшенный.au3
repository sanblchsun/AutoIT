#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#NoTrayIcon
Global $file
$Gui = GUICreate("Player", 340, 100, -1, -1, -1, $WS_EX_ACCEPTFILES)
$CatchDrop = GUICtrlCreateLabel("", -1, -1, 340, 100)
GUICtrlSetState(-1, $GUI_DISABLE + $GUI_DROPACCEPTED)
GUISetIcon(@SystemDir&"\wmploc.dll", 0)
GUICtrlCreateLabel("используйте drag-and-drop", 10, 5, 200, 18)
$LabNameSize = GUICtrlCreateLabel("Это значит кинь сюда файл", 10, 20, 270, 34)
$open = GUICtrlCreateButton("Open", 10, 60, 21, 21, $BS_ICON)
GUICtrlSetImage(-1, 'shell32.dll', 4, 0)
$play = GUICtrlCreateButton("Play "& ChrW('0x25BA'), 40, 60, 21, 21, $BS_ICON)
GUICtrlSetImage(-1, 'shell32.dll', -138, 0)
GUICtrlSetFont (-1,-1, -1, -1, 'Arial')
GUICtrlSetTip(-1, "Воспроизвести сначала")
$slider = GUICtrlCreateSlider(290, 0, 30, 100, 0x0002)
GUICtrlSetLimit(-1, 100, 0)
GUICtrlSetData(-1, 100-50)
SoundSetWaveVolume(50)
GUISetState()

GUIRegisterMsg(0x0115 , 'WM_VSCROLL')
GUIRegisterMsg(0x020A , "WM_MOUSEWHEEL")

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $open
			$tmp = FileOpenDialog("Выберите файл", "", "Медиафайлы (*.mp3)", 1)
			If @error Then ContinueLoop
			$file=$tmp
			_pl()
		Case $play
			If Not $file = "" Then
				SoundPlay($file, 0)
			Else
				MsgBox(64, "Выгодное предложение", "Не желаете открыть файл?")
			EndIf
        Case -13
				$file=@GUI_DRAGFILE
				_pl()
		Case $Gui_Event_Close
			ExitLoop
	EndSwitch
WEnd

Func _pl()
GUICtrlSetColor($LabNameSize,0xff0000)
GUICtrlSetFont($LabNameSize,-1, 700)
$namefiles=StringRegExp($file, "(^.*)\\(.*)$", 3)
GUICtrlSetData($LabNameSize, $namefiles[1]&' ('&Ceiling (FileGetSize ( $file )/1048576)&' Мб)')
SoundPlay($file)
EndFunc

Func WM_VSCROLL($hWnd, $Msg, $wParam, $lParam)
	#forceref $Msg, $wParam, $lParam
	Local $nScrollCode = BitAND($wParam, 0x0000FFFF), $value = BitShift($wParam, 16)
	If $nScrollCode = 5 Then SoundSetWaveVolume(100-$value)
	Return 'GUI_RUNDEFMSG'
EndFunc

; реакция регулятора на колёсико мыши
Func WM_MOUSEWHEEL($hWndGui, $MsgId, $wParam, $lParam)
    If $MsgId = $WM_MOUSEWHEEL Then
		Local $value
        If BitShift($wParam, 16) > 0 Then
            $value = GUICtrlRead($slider) - 5
            GUICtrlSetData($slider, $value)
			SoundSetWaveVolume(100-$value)
        Else
            $value = GUICtrlRead($slider) + 5
            GUICtrlSetData($slider, $value)
			SoundSetWaveVolume(100-$value)
        EndIf
    EndIf
EndFunc