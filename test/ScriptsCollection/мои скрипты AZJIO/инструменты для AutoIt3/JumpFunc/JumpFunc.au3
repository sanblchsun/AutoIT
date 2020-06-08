#NoTrayIcon
#include <nppUDF.au3>
#include <File.au3>
; #include <Array.au3>

; [1] $(NPP_DIRECTORY)
; [2] $(CURRENT_WORD)
; [3] $(FULL_CURRENT_PATH)
Local $aLng[8] = [ _
		'Error', _
		'Select the name of the function', _
		'The "Include" directory not found', _
		'Not found', _
		'Sought but not found', _
		'Possible problems:' & @LF & '1. The function name with typo' & @LF & '2. "Include" is not inserted' & @LF & @LF & 'Want to do a search in all "include"?', _
		'Found in', _
		'Copy string to Clipboard?']

; Local $aLng[8] = [ _
; '������', _
; '�������� ��� �������', _
; '������� Include �� ������', _
; '�� ������', _
; '������, �� �� �����', _
; '��������� ��������:' & @LF & '1. ��� ������� � ���������' & @LF & '2. include �� ���������' & @LF & @LF & '������ ������� ����� �� ���� include?', _
; '������� �', _
; '���������� ������ � �����?']

If $CmdLine[0] > 2 Then
	; $sText = FileRead($CmdLine[3]) ; ������ ����. ��������, ������������ ������ �� ��������������
	$sText = _npp_GetText() ; ������ �� ���� ���������. ��� �������� ���� ����� �� �������.
	$a = StringRegExp($sText, '(?i)[\r\n\A]\s*Func\s+' & $CmdLine[2], 1) ; ����� ����� ������� � ������
	If @error Then
		$Include_script = StringRegExp($sText, '(?mi)^\s*#include\s*[<"'']*([^\r\n]+?\.au3)', 3) ; ���������� include ��������� � �������
		; _ArrayDisplay($Include_script, 'Array')
		$sInclude_Path = _GetIncludePath()
		; If @error Then
		; $sInclude_Path = @ScriptDir
		; Else
		; $sInclude_Path &= ';' & @ScriptDir
		; EndIf
		$aInclude_Path = StringSplit($sInclude_Path, ';')
		For $j = 1 To $aInclude_Path[0]
			If Not FileExists($aInclude_Path[$j]) Then ContinueLoop
			For $i = 0 To UBound($Include_script) - 1
				; MsgBox(0, '���������', $sInclude_Path)
				; MsgBox(0, '���������', $Include_script[$i])
				$sText = FileRead($aInclude_Path[$j] & '\' & $Include_script[$i]) ; ��������� include ����
				$a = StringRegExp($sText, '(?i)[\r\n\A]\s*Func\s+' & $CmdLine[2], 1) ; ����� ����� ������� � ������
				If Not @error Then ; ���� ��� ������, �.�. �����, �� ������ ������
					$iPos = @extended - StringLen($a[0]) + 6 ; ����� ��������� �������
					Run('"' & $CmdLine[1] & '\notepad++.exe" "' & $aInclude_Path[$j] & '\' & $Include_script[$i] & '"') ; ��������� ����
					Sleep(300) ; �� ������ ������ ��� ��� ��������
					_JumpToFunc($sText, $iPos) ; ��������� ������ � �����
					Exit
				EndIf
			Next
		Next
		If MsgBox(4 + 32, $aLng[3], $aLng[5]) = 6 Then
			For $j = 1 To $aInclude_Path[0] ; ��������� ���� ������ � include-������
				If Not FileExists($aInclude_Path[$j]) Then ContinueLoop
				$aFileList = _FileListToArray($aInclude_Path[$j], '*.au3', 1) ; ����� ������
				If Not @error Then ; ���� ��� ������ (������� ������� �����), ��
					For $i = 1 To $aFileList[0] ; ������������ ������ ����
						$sText = FileRead($aInclude_Path[$j] & '\' & $aFileList[$i]) ; ��������� include ����
						$a = StringRegExp($sText, '(?i)[\r\n\A]\s*Func\s+' & $CmdLine[2], 1) ; ����� ����� ������� � ������
						If Not @error Then ; ���� ��� ������, �.�. �����, �� ������ ������
							$iPos = @extended - StringLen($a[0]) + 6 ; ����� ��������� �������
							Run('"' & $CmdLine[1] & '\notepad++.exe" "' & $aInclude_Path[$j] & '\' & $aFileList[$i] & '"') ; ��������� ����
							Sleep(300) ; �� ������ ������ ��� ��� ��������
							_JumpToFunc($sText, $iPos) ; ��������� ������ � �����
							If MsgBox(4 + 32, $aLng[6] & ' ' & $aFileList[$i], $aLng[7] & @LF & @LF & '#include <' & $aFileList[$i] & '>') = 6 Then ClipPut('#include <' & $aFileList[$i] & '>')
							Exit
						EndIf
					Next
				EndIf
			Next
		EndIf
		MsgBox(16, $aLng[3], $aLng[4], 1)
	Else
		; ���� � ������� �����
		$iPos = @extended - StringLen($a[0]) + 6
		_JumpToFunc($sText, $iPos)
	EndIf
Else
	MsgBox(0, $aLng[0], $aLng[1])
EndIf

Func _JumpToFunc(ByRef $AllText, $iPos)
	; ����� ���������� � ������ ����
	
	; ��������� ����� ������
	$iPos = StringRegExp(StringLeft($AllText, $iPos), '(\r\n|\r|\n)', 3)
	$iPos = UBound($iPos)
	; ������ ��������, ���� ����������� ������ � ������ ����
	$CurLine = _SendMessage(WinGetHandle('[CLASS:Notepad++]'), $NPPM_GETCURRENTLINE, 0, 0)
	$pos = ControlGetPos('[CLASS:Notepad++]', "", "[CLASSNN:Scintilla1]")
	$iPos2 = $pos[3] / 32 ; ������ ����� �� 32 ������� ����� ���������� ��� ����� �� ������� ����
	If $iPos > $CurLine Then
		$iPos2 = $iPos + $iPos2
	Else
		$iPos2 = $iPos - $iPos2
	EndIf
	_npp_SetCurPos($iPos2)
	_npp_SetCurPos($iPos)
	WinActivate('[CLASS:Notepad++]')
EndFunc   ;==>_JumpToFunc

Func _GetIncludePath()
	$sInclude_Path = RegRead("HKLM\SOFTWARE\AutoIt v3\AutoIt", "InstallDir")
	If @error Then
		$sInclude_Path = RegRead('HKCU\Software\AutoIt v3\Autoit', 'Include')
	Else
		$sInclude_Path &= "\Include"
	EndIf
	If $sInclude_Path Then
		Return $sInclude_Path & ';' & @ScriptDir
	Else
		Return @ScriptDir
	EndIf
EndFunc   ;==>_GetIncludePath