#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>

$hGui = GUICreate('������ �����', 220, 180)
$iInput = GUICtrlCreateInput('', 10, 10, 200, 20, -1, $WS_EX_STATICEDGE)
GUISetState()
GUIRegisterMsg($WM_COMMAND, 'WM_COMMAND')

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd

Func WM_COMMAND($hWnd, $imsg, $iwParam, $ilParam)
	Local $nNotifyCode, $nID, $sText, $iInput0
	$nNotifyCode = BitShift($iwParam, 16)
	$nID = BitAND($iwParam, 0xFFFF)
	Switch $hWnd
		Case $hGui
			Switch $nID
				Case $iInput
					Switch $nNotifyCode
						Case $EN_CHANGE
							; $sText = StringRegExp(GUICtrlRead($iInput), '(\d+\.\d+|\d+\.|\d+)', 2) ; ������ �������
							$iInput0 = GUICtrlRead($iInput)
							$sText = StringRegExp($iInput0, '(\d+(\.(\d+)?)?)', 2) ; ����������� ����� � ��������� ������
							; $sText = StringRegExp($iInput0, '(-?(\d+([.,](\d+)?)?)?)', 2) ; ��������� "-" � "," �������� "-3,5"
							; $sText = StringRegExp($iInput0, '([.,](\d+)?)|(-?(\d+([.,](\d+)?)?)?)', 2) ; ��������� "-" � "," � ����� ������ �����, �������� "-3,5" ��� ",34"
							If @error Then
								GUICtrlSetData($iInput, '')
							Else
								If $iInput0 <> $sText[0] Then GUICtrlSetData($iInput, $sText[0])
							EndIf
					EndSwitch
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND