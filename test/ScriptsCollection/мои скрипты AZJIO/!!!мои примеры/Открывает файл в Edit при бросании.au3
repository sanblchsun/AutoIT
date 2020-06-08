#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiEdit.au3>

$hGui = GUICreate("���� �������������� � GUI", 400, 500, -1, -1, -1, $WS_EX_ACCEPTFILES) ; ������ ���� � ������ ������

$iEdit = GUICtrlCreateEdit("������ ������" & @CRLF & "������ ������", 3, 3, 400 - 6, 500 - 6, $ES_AUTOVSCROLL + $WS_VSCROLL + $ES_NOHIDESEL + $ES_WANTRETURN)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUICtrlSendMsg(-1, $EM_LIMITTEXT, -1, 0) ; ������� ����������� �� ���������� �������� 30 000
GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_DROPPED
			If $iEdit = @GUI_DropId Then
				$sPos = _GUICtrlEdit_GetSel($iEdit) ; �������� ���������� ����� � ���������� �������������� ������
				$sText = StringMid(GUICtrlRead($iEdit), $sPos[0] + 1) ; ������ ������ � ���������� ������, ������� ��� �������.
				$sPath = StringRegExpReplace($sText, '(?s)^(.+?)(?:\R.*)', '\1') ; ��������� ������ ������ ������
				WinSetTitle($hGui, '', StringRegExpReplace($sPath, '^(?:.*\\)([^\\]*?)(?:\.[^.]+)?$', '\1')) ; �������� ����� �����, ������� � ���������
				If FileExists($sPath) And Not StringInStr(FileGetAttrib($sPath), "D") Then
					GUICtrlSetData($iEdit, FileRead($sPath)) ; �������������� ������� ����������� �� ����� ������
				Else
					_GUICtrlEdit_ReplaceSel($iEdit, '') ; ������ ������ �������
				EndIf
			EndIf
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd

; ������: ������� ���� � ���� �������������� ��� �������� ����� � ����.
; ��������: ��� �������������� ���������� ������ � ����, � ������� ��� ��������� �����, ����� ����������� � ����� ������ � ��������� �����, ��� ������� ��������� � ����������� ������� ����� �� ���������������. ��� ��� ������� ���� ����������� �� ����� ������, �� ������ �� ����������� � Edit.
; ���� ������������ @GUI_DragFile, �� �� ���������� ����, ����������� � ������ ���� ����, �� ������� ���������� ���� � ������ ��������������, �� ���� ������������ �� ������, �� �������, � ��� ��� ����� �������.
; ���� �� �������� ����������� ($EM_LIMITTEXT), �� ��� ������� ������ ������� � ����� ����������, �������������� �� �������� Drag & Drop
; ��� ������ ���������� � UDF ����������, ��� WM_COMMAND �� ����� ������� DROP � ��� Edit ���� ��� �������� ����� ����������� (���� ������ ����).