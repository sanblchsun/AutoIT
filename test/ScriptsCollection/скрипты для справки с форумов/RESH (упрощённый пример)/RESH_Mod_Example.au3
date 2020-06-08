#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiRichEdit.au3>
#include <RESH_Mod.au3>

OnAutoItExitRegister("_Exit") ; �����������, �� ������ ������ ����������� ������� ������� �� ���������
Func _Exit()
    GUIDelete()
EndFunc

Global $hGUI, $hRichEdit, $sRTFCode

$hGUI = GUICreate('������������ ����� �������������� �� "�" � "�"', 720, 570)
$hRichEdit = _GUICtrlRichEdit_Create($hGUI, "", 8, 8, 701, 510, BitOR($ES_MULTILINE, $WS_VSCROLL, $ES_AUTOVSCROLL))

$Button = GUICtrlCreateButton("���������� ����������� �����", 530, 530, 180, 30)

; ��������� ����� ������� ����� ���������� �����
_GUICtrlRichEdit_SetText($hRichEdit, '������� � ������� ������ ���� � �� ���� �����, ��� ������� �����. ������ ���������� �������� � ����...')
$sRTFCode = _RESH_SyntaxHighlight($hRichEdit) ; ������������ ����� � RichEdit

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $Button
			$sText = _GUICtrlRichEdit_GetText($hRichEdit) ; �������� ����� �� RichEdit
			If Not @error And $sText Then $sRTFCode = _RESH_SyntaxHighlight($hRichEdit) ; ������������ ����� � RichEdit
		Case $GUI_EVENT_CLOSE
			_GUICtrlRichEdit_Destroy($hRichEdit)
			Exit
	EndSwitch
WEnd