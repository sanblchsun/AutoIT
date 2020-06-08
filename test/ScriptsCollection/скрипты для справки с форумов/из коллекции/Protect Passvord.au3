#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

Global Const $sPASSVORD = 1234 ; Пароль для сравнения
$sGUI_NAME = "Ввоод пароля"
$sLIMIT_SIMBOL = 25

$sTextCheckbox1 = "Отображать вводимые символы"

$nFormPassvord = GUICreate($sGUI_NAME, 310, 144, 488, 351)
$Input1 = GUICtrlCreateInput("", 16, 32, 281, 21, BitOR($ES_PASSWORD,$ES_AUTOHSCROLL,$WS_BORDER))
	GUICtrlSetLimit(-1, $sLIMIT_SIMBOL)
$Input2 = GUICtrlCreateInput("", 16, 32, 281, 21, BitOR($ES_AUTOHSCROLL,$WS_BORDER))
	GUICtrlSetLimit(-1, $sLIMIT_SIMBOL)
		GUICtrlSetState(-1, $GUI_HIDE)
$Button1 = GUICtrlCreateButton("&Ok", 224, 112, 75, 25, $BS_DEFPUSHBUTTON)
		GUICtrlSetTip(-1, "Проверить")
$Group1 = GUICtrlCreateGroup(" Введите пароль ", 8, 8, 297, 97)
$Checkbox1 = GUICtrlCreateCheckbox($sTextCheckbox1, 16, 72, 193, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)

GUISetState(@SW_SHOW)
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Button1
			If GUICtrlGetState($Input1) = 80 Then
				If GUICtrlRead($Input1) <> $sPASSVORD Then
					MsgBox(48,"","Не верный пароль")
				Else
					MsgBox(64,"","Верный пароль")
					Exit
				EndIf
			Else
				If GUICtrlRead($Input2) <> $sPASSVORD Then
					MsgBox(48,"","Не верный пароль")
				Else
					MsgBox(64,"","Верный пароль")
					Exit
				EndIf
			EndIf

	EndSwitch
WEnd

Func WM_COMMAND($nHnwd, $MsgID, $WParam, $LParam)
	Local $iIDFrom = BitAND($WParam, 0xFFFF) ; Low Word
	Local $iCode = BitShift($WParam, 16) ; Hi Word
	Local $aRead[2] = [GUICtrlRead($iIDFrom), GUICtrlRead($iIDFrom, 1)]

	If $aRead[1] = $sTextCheckbox1 Then
		If GUICtrlRead($Checkbox1) = 4 Then
			GUICtrlSetState($Input1, $GUI_SHOW)
			GUICtrlSetState($Input2, $GUI_HIDE)
			GUICtrlSetData($Input1, GUICtrlRead($Input2))
			GUICtrlRead($Input2)
		Else
			GUICtrlSetState($Input2, $GUI_SHOW)
			GUICtrlSetState($Input1, $GUI_HIDE)
			GUICtrlSetData($Input2, GUICtrlRead($Input1))
			GUICtrlRead($Input1)
		EndIf
	EndIf

	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND
