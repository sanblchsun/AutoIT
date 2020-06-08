#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_outfile=FileFindExTest.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/om /cn=0 /cs=0 /sf=1 /sv=1
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <_FileFindEx.au3>
#include <Array.au3>
; Author: Ascend4nt

Global $aFileFindArray,$iTotalCount,$iFolderCount,$iTimer,$sFilename,$sAttrib,$hFindFileHandle
Global $sFolder=@WindowsDir&'\'	; @UserProfileDir&'\'	; (the latter results in some REPARSE Points)
Global $sSearchWildCard="*.*"
Global $s_FileFindExStats="",$sFileFindFileStats="",$bDuplicateResults=True,$bShowStats=True,$iIsFolder
Global $Timer1, $Timer2

FFEXTest() ; ����� ������������ ��������� Ascend4nt
FileFindTest() ; �������� ����� ��������� AutoIt3

$sFileFindFileStats=StringSplit($sFileFindFileStats, @CRLF, 1)
_ArrayDisplay($sFileFindFileStats, $Timer1&" - ��������")

$s_FileFindExStats=StringSplit($s_FileFindExStats, @CRLF, 1)
_ArrayDisplay($s_FileFindExStats, $Timer2&" - ����")

Func FFEXTest()
	$iTotalCount=0
	$iFolderCount=0
	$iTimer=TimerInit()
	$aFileFindArray=_FileFindExFirstFile($sFolder & $sSearchWildCard)
	If $aFileFindArray=-1 Then Exit

	Do
		; ���������, ���� ��� �����, ��
		If BitAND($aFileFindArray[2],16) Then
			; ����������� �������� � �������� _Find (First | Next) File. ������������� ����� ����� ������������:
			If $aFileFindArray[0]='.' Or $aFileFindArray[0]='..' Then ContinueLoop
			; ���������� �������� ��������� �����
			$iFolderCount+=1
		EndIf
		; ����� ���������� ������ � �����
		$iTotalCount+=1

		If $bShowStats Then
			$s_FileFindExStats &= $aFileFindArray[0] & @CRLF
		EndIf
	Until Not _FileFindExNextFile($aFileFindArray)
	_FileFindExClose($aFileFindArray)

	$Timer2=Round(TimerDiff($iTimer), 2) & ' ����'
	$s_FileFindExStats="������:" & $iTotalCount-$iFolderCount & ", �����:" & $iFolderCount & _
		", �����:" & $Timer2 & @CRLF & $s_FileFindExStats
EndFunc

; ------------ FileFindTest --------------

Func FileFindTest()
	$iTotalCount=0
	$iFolderCount=0
	$iTimer=TimerInit()
	$hFindFileHandle=FileFindFirstFile($sFolder & $sSearchWildCard)
	While 1
		$sFilename=FileFindNextFile($hFindFileHandle)
		$iIsFolder=@extended
		If @error Then ExitLoop
		If $iIsFolder Then $iFolderCount+=1

		; ����� ���������� ������ � �����
		$iTotalCount+=1

		If $bShowStats Then
			$sFileFindFileStats&=$sFilename & @CRLF
		EndIf
		
	WEnd
	FileClose($hFindFileHandle)
	
	$Timer1=Round(TimerDiff($iTimer), 2) & ' ����'
	$sFileFindFileStats="������:" & $iTotalCount-$iFolderCount & ", �����:" & $iFolderCount & _
		", �����:" & $Timer1 &  @CRLF & $sFileFindFileStats
EndFunc

