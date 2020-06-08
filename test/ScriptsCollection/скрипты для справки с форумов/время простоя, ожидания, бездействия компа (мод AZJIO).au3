; http://forum.ru-board.com/topic.cgi?forum=5&topic=33902&start=1680#18
; Модернизировал функцию от amel27 + CreatoR под свои (AZJIO) нужды
; Запускать из SciTE, результат направляется в консоль

#include <Date.au3>

Global $Diff=0
AdlibRegister('_IdleWaitStart', 1000)

HotKeySet("{ESC}", "_Quit")

While 1
	Sleep(100000)
WEnd

; Ожидание начала бездействия пользователя.
; Возвращает время неактивности (в тиках)
Func _IdleWaitStart()
    Local $aRet, $iSave, $iTick, $LastInputInfo = DllStructCreate("uint;dword")
    DllStructSetData($LastInputInfo, 1, DllStructGetSize($LastInputInfo))
    DllCall("user32.dll", "int", "GetLastInputInfo", "ptr", DllStructGetPtr($LastInputInfo))
	$iSave = DllStructGetData($LastInputInfo, 2)
	$aRet = DllCall("kernel32.dll", "long", "GetTickCount")
    $Diff = $aRet[0] - DllStructGetData($LastInputInfo, 2)
    ConsoleWrite(_Now() & ' ' & @UserName & ' неактивен уже ' & _TickToTimeString($Diff) & @CRLF)
EndFunc   ;==>_IdleWaitStart

Func _TickToTimeString($iTicks)
    Local $iHours, $iMins, $iSecs, $sText = ''
    _TicksToTime($iTicks, $iHours, $iMins, $iSecs)

    If $iHours Then $sText = $iHours & ' часов '
    If $iMins Then $sText &= $iMins & ' минут '
    If $iSecs Then $sText &= $iSecs & ' секунд'
    If $sText = '' Then $sText = 'меньше секунды'

    Return $sText
EndFunc   ;==>_TickToTimeString

Func _Quit()
    Exit
EndFunc   ;==>_Quit