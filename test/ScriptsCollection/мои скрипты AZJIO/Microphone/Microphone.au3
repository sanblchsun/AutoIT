#include "SoundGetSetQuery.au3"
Opt("TrayMenuMode", 7)
Opt("TrayOnEventMode", 1)
HotKeySet('^{PAUSE}', "_MUTE")
If _SoundGetAllRecordMute()= 0 Then
	TraySetIcon('sndico.dll', 1)
Else
	TraySetIcon('sndico.dll', 2)
EndIf

Global Const $TRAY_EVENT_PRIMARYDOUBLE = -13
TraySetOnEvent($TRAY_EVENT_PRIMARYDOUBLE,"_MUTE")

; $nExit = TrayCreateItem('Выход') 
TrayItemSetOnEvent(TrayCreateItem('Вкл/Выкл') , "_MUTE")
TrayItemSetOnEvent(TrayCreateItem('Выход') , "_Quit")
TraySetToolTip('Коммутатор микрофона')

While 1
    Sleep(1000)
WEnd

Func _MUTE()
	$Mute=_SoundGetAllRecordMute()
	If $Mute = 0 Then 
		_SoundSetMicrophoneMute(1)
		_SoundSetAllRecordMute(1)
		TraySetIcon('sndico.dll', 2)
		; MsgBox(0, 'Сообщение', 'Микрофон выключен')
	EndIf
	If $Mute = 1 Then
		_SoundSetMicrophoneMute(0)
		_SoundSetAllRecordMute(0)
		TraySetIcon('sndico.dll', 1)
		; MsgBox(0, 'Сообщение', 'Микрофон включен')
	EndIf
EndFunc

Func _SoundSetMicrophoneMute($fMute)
	Local $iRet = SoundSetGet(0, "sAnalog", 9, "Mute", True, $fMute)
	SetError(@error) 
	Return $iRet
EndFunc

Func _SoundSetAllRecordMute($fMute)
	Local $iRet = SoundSetGet(2, "dWave", 1, "Mute", True, $fMute)
	SetError(@error) 
	Return $iRet
EndFunc

Func _SoundGetAllRecordMute()
	Local $iRet = SoundSetGet(2, "dWave", 1, "Mute", False, 0)
	SetError(@error) 
	Return $iRet
EndFunc

Func _Quit()
	TraySetState(2)
	Exit
EndFunc