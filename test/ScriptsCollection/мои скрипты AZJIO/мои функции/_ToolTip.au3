#include <GUIToolTip.au3>
#include <FontConstants.au3>

Global $aInfo[6][2] = [[ _
		'�������', '1'],[ _
		'����� ������', '2'],[ _
		'����� ������', '3'],[ _
		'����� ���������', '4'],[ _
		'����� ����������', '5'],[ _
		'�������� ������', '6']]

$sText = ''
For $i = 0 To 5
	_StringFormat($sText, $aInfo[$i][0], $aInfo[$i][1])
Next
$sText = StringTrimRight($sText, 1)

Func _StringFormat(ByRef $sText, $sString1, $sString2)
	$sText &= StringFormat("%-18s: %s\n", $sString1, $sString2)
EndFunc   ;==>_StringFormat
; MsgBox(0, '���������', $sText)

; �������� ���������� ������
$hIcon = _WinAPI_LoadShell32Icon(15)

$hTool = _ToolTip($sText, 500, 300, '����������', $hIcon, $TTS_NOPREFIX  + $TTS_BALLOON, 16, 'Consolas', 0x1EBFFF, 0x395A00)
$hFont = @extended
; _ToolTip($sText, 500, 300)
Sleep(1500)

For $i = 1 To StringLen($sText) - 1
	_GUIToolTip_UpdateTipText($hTool, 0, 0, StringTrimRight($sText, $i))
	Sleep(10)
Next
Sleep(500)
_GUIToolTip_UpdateTipText($hTool, 0, 0, $sText)
If $hFont Then _WinAPI_DeleteObject($hFont) ; �������� ������� ������ (�������� ��������, ��� ����� �� �������� ����� �������� �������)

For $i = 1 To 5
	; ������������� ������� ���������
	_GUIToolTip_TrackPosition($hTool, Random(0, @DesktopWidth, 1), Random(0, @DesktopHeight, 1))
	Sleep(400)
Next

_GUIToolTip_TrackPosition($hTool, 500, 300)
For $i = 1 To 4
	; ������������� ���������� ���������
	_GUIToolTip_TrackActivate($hTool, False)
	Sleep(500)

	; ������������� ���������� ���������
	_GUIToolTip_TrackActivate($hTool)
	Sleep(500)
Next

_GUIToolTip_Destroy($hTool) ; ������� ���������

; #FUNCTION# ;=================================================================================
; Function Name ...: _ToolTip
; Description ........: ToolTip extended
; Syntax................: _ToolTip ( $sText[, $iX = 0[, $iY = 0[, $iTitle = ''[, $hIcon = 0[, $iStyle = 0[, $iFontSize = 0[, $iFontFamily = 'Arial'[, $iFontColor = 0[, $iBkColor = 0]]]]]]]]] )
; Parameters:
;		$sText - The text of the tooltip
;		$iX - The x position of the tooltip
;		$iY - The y position of the tooltip
;		$iTitle - The title for the tooltip
;		$hIcon - Pre-defined icon to show next to the title: Requires a title.
;			0 = No icon, 1 = Info icon, 2 = Warning icon, 3 = Error Icon, Handle to the Icon
;		$iStyle - ToolTip style (_GUIToolTip_Create)
;		$iFontSize - height of font.
;		$iFontFamily - typeface name.
;		$iFontColor - text color.
;		$iBkColor - background color.
; Return values ....: Success - The handle to the Tooltip window, @extended = $hFont
;					Failure - 0, @error:
;					-1 - $hTool = 0, ToolTip will not be displayed
;					1 - error of the font
;					2 - error of the title
;					3 - error 1 and 2 together
; Author(s) ..........: AZJIO
; Remarks ..........: When you no longer need the font, call the _WinAPI_DeleteObject function to delete it
; ============================================================================================
; ��� ������� ...: _ToolTip
; �������� ........: ����������� ��������� � ������������ �����������.
; ���������.......: _ToolTip ( $sText[, $iX = 0[, $iY = 0[, $iTitle = ''[, $hIcon = 0[, $iStyle = 0[, $iFontSize = 0[, $iFontFamily = 'Arial'[, $iFontColor = 0[, $iBkColor = 0]]]]]]]]] )
; ���������:
;		$sText - ����� ����������� ���������
;		$iX - X-���������� ����������� ���������
;		$iY - Y-���������� ����������� ���������
;		$iTitle - ��������� ����������� ���������
;		$hIcon - ������, ������������ ����� � ����������. ������� �������� ��������� $iTitle.
;					| 0 - ��� ������ (�� ���������)
;					| 1 - ������ "����������"
;					| 2 - ������ "��������������"
;					| 3 - ������ "������
;					| ���������� ������
;		$iStyle - �����. �������� ������������� ���������� _GUIToolTip_Create.
;		$iFontSize - ������ ������.
;		$iFontFamily - ��� ������.
;		$iFontColor - ���� ������.
;		$iBkColor - ��� ����������� ���������.
; ������������ ��������: ������� - ���������� ���������� ToolTip, @extended �������� ���������� ������
;					�������� - ���������� 0 � ������������� @error = 1
;					-1 - $hTool �� ������, ��������� �� ����� ������������
;					1 - ������ ��������� ������
;					2 - ������ �������� ���������
;					3 - ������ 1 � 2 ������
; ����� ..........: AZJIO
; ���������� ..: ����� ���������� ������������� _ToolTip ������� ������ $hFont
; ============================================================================================
Func _ToolTip($sText, $iX = 0, $iY = 0, $iTitle = '', $hIcon = 0, $iStyle = 0, $iFontSize = 0, $iFontFamily = 'Arial', $iFontColor = 0, $iBkColor = 0)
	; If BitAND($iStyle, 1) Then $iStyle += $TTS_BALLOON

	; ������ ToolTip
	Local $hFont = 0, $iError = 0
	Local $hTool = _GUIToolTip_Create(0, $iStyle)
	If Not $hTool Then Return SetError(-1, 0, 0)

	; ������������� ������ ToolTip
	_GUIToolTip_SetMaxTipWidth($hTool, @DesktopWidth)
	; ����� ���� ��� ��������� ���������� ����� � ��������� ������. ����� @CRLF �� ����� ����� �������.

	; ������������� ����� ��� ToolTip
	If $iFontSize Then
		$hFont = _WinAPI_CreateFont($iFontSize, 0, 0, 0, 400, False, False, False, $DEFAULT_CHARSET, $OUT_DEFAULT_PRECIS, $CLIP_DEFAULT_PRECIS, $DEFAULT_QUALITY, 0, $iFontFamily)
		If $hFont Then
			_WinAPI_SetFont($hTool, $hFont)
		Else
			$iError += 1
		EndIf
	EndIf

	; ������������� ����
	If $iFontColor Then _GUIToolTip_SetTipTextColor($hTool, $iFontColor) ; ���� ������ (BGR) ����������� ���������
	If $iBkColor Then _GUIToolTip_SetTipBkColor($hTool, $iBkColor) ; ���� ���� (BGR) ����������� ���������

	; ��������� ��������� �������� � ����� � ������������
	If Not _GUIToolTip_AddTool($hTool, 0, $sText, 0, 0, 0, 0, 0, 8 + $TTM_TRACKPOSITION) Then Return SetError(1, 0, 0)

	; ������������� ��������� ���������
	If $iTitle And Not _GUIToolTip_SetTitle($hTool, $iTitle, $hIcon) Then $iError += 2

	; ������������� ������� ���������
	_GUIToolTip_TrackPosition($hTool, $iX, $iY)

	; ������������� ���������� ���������
	_GUIToolTip_TrackActivate($hTool)
	Return SetError($iError, $hFont, $hTool)
EndFunc   ;==>_ToolTip