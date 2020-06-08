
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <WinAPIEx.au3>
#include <EditConstants.au3>

Local $hGui, $msg, $Input1, $Input2, $Input3, $Input4, $Input5, $Input6, $BtnOk

$hGui = GUICreate("GUI с поддержкой drag and drop", 380, 250, @DesktopWidth / 2 - 190, @DesktopHeight / 2 - 80, -1, $WS_EX_ACCEPTFILES)
$Input1 = GUICtrlCreateInput('', 10, 5, 360, 20, $ES_NUMBER)
$Input2 = GUICtrlCreateInput('', 10, 35, 360, 20, $ES_NUMBER)
$Input3 = GUICtrlCreateInput('', 10, 65, 360, 22,$ES_NUMBER)
$Input4 = GUICtrlCreateInput('', 10, 95, 360, 22, $ES_NUMBER)
$Input5 = GUICtrlCreateInput('', 10, 150, 360, 22, -1, $WS_EX_STATICEDGE)
$Input6 = GUICtrlCreateInput('', 10, 185, 360, 22, -1, $WS_EX_DLGMODALFRAME)

GUICtrlSetData($Input1, 0)
GUICtrlSetData($Input2, 0)
GUICtrlSetData($Input3, 0)
GUICtrlSetData($Input4, 0)
GUICtrlSetData($Input5, "Введите Title окна")

$BtnOk = GUICtrlCreateButton("OK", (380 - 70) / 2, 220, 70, 26)

GUISetState()

While 1
    $msg = GUIGetMsg()
    Switch $msg
        Case $GUI_EVENT_CLOSE
            ExitLoop
		 Case $BtnOk
			$hWnd = WinActivate(GUICtrlRead($Input5))
			If Not $hWnd Then
			   GUICtrlSetData($Input6, "Окно не активно")
			Else
			   GUICtrlSetData($Input6, String(Call("CheckWindows",$hWnd,GUICtrlRead($Input1),GUICtrlRead($Input2),GUICtrlRead($Input3),GUICtrlRead($Input4))))
			EndIf

    EndSwitch
 WEnd

 ;проверка окна по контрольной сумме
Func CheckWindows($hWndFunc,$correctionLeft,$correctionTop,$correctionRight,$correctionBottom)
   ; Создаёт структуру, в которую возвращаются координаты
   $tRect = _WinAPI_GetWindowRect($hWndFunc)
   ;Получим координаты
   $Left = DllStructGetData($tRect, "Left") + $correctionLeft
   $Top = DllStructGetData($tRect, "Top") + $correctionTop
   $Right = DllStructGetData($tRect, "Right") - $correctionRight
   $Bottom = DllStructGetData($tRect, "Bottom") - $correctionBottom
   ;Генерируем контрольную сумму области пикселе
   $checksum = PixelChecksum($Left, $Top, $Right-1, $Bottom-1)
   ;покажу зону контроля в окне
   $hForm = GUICreate('', $Right - $Left, $Bottom - $Top, $Left, $Top, $WS_POPUP, $WS_EX_TOPMOST)
   GUISetBkColor(0xFF00000)
   WinSetTrans($hForm, '', 150) ; прозрачность
   GUISetState()
   Sleep(2000)
   GUIDelete()
   ;для отладки
   ConsoleWrite($Left & '/' & $Top & '/' & $Right & '/' & $Bottom & @CRLF& _
   $checksum & @LF)

   Return $checksum
EndFunc