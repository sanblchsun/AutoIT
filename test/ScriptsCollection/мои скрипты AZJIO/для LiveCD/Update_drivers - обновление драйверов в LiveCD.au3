;  @AZJIO
#Include <File.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3> 
#include <Array.au3>
; AutoItSetOption("TrayIconHide", 1) ;������ � ��������� ������ ��������� AutoIt
Global $Stack[50]
Global $Stack1[50]

;�������� ��������
GUICreate("��������� �������� � LiveCD v0.2",508,228, -1, -1, -1, $WS_EX_ACCEPTFILES) ; ������ ����
$tab=GUICtrlCreateTab (0,2, 508,204) ; ������ �������

GUICtrlCreateLabel ("����������� drag-and-drop", 250,5,200,18)

$tab3=GUICtrlCreateTabitem ("Update Drv") ; ��� �������

GUICtrlCreateLabel ("���� � I386 ��� MiniNT", 20,40,400,20)
$inputi386z=GUICtrlCreateInput ("", 20,60,420,22)
GUICtrlSetState(-1,8)
$filewim=GUICtrlCreateButton ("...", 455,59,35,24)
GUICtrlSetData($inputi386z, @ScriptDir&'\I386')

GUICtrlCreateLabel ("���� � ����� � ����������", 20,100,400,20)
$inputdrv=GUICtrlCreateInput ("", 20,120,420,22)
GUICtrlSetState(-1,8)
$filezip=GUICtrlCreateButton ("...", 455,119,35,24)
GUICtrlSetData($inputdrv, @ScriptDir&'\drivers')

$check=GUICtrlCreateCheckbox ("��������� ���������� *.exe (��� SCSIRAID)", 20,160,240,20)
GUICtrlSetTip(-1, "��� ��������� �����, �����, ���� *.exe-����� �� �����")
GuiCtrlSetState($check, 1)

$Upd=GUICtrlCreateButton ("���������", 390,160,100,26)
GUICtrlSetTip(-1, "�������� �������� � LiveCD")
$Label000=GUICtrlCreateLabel ('������ ���������			AZJIO 2009.12.30', 10,210,380,20)

$tab4=GUICtrlCreateTabitem ("?") ; ��� �������

GUICtrlCreateGroup("���������� ������ �� ���������", 11, 30, 200, 90)
GUICtrlCreateLabel ("*.sys > i386\system32\drivers\", 20,50,200,20)
GUICtrlCreateLabel ("*.dll, *.exe > i386\system32\", 20,70,200,20)
GUICtrlCreateLabel ("*.inf > i386\inf\", 20,90,200,20)

GUICtrlCreateGroup("��������� TXTSETUP.SIF", 222, 30, 275, 90)
GUICtrlCreateLabel ("������ SetValue, ��������� ������ � txtsetup.sif", 231,50,260,20)
GUICtrlCreateLabel ("������ DelLine, ������� ������ � txtsetup.sif", 231,70,260,20)
GUICtrlCreateLabel ("������� ������ ���� � ���� ����� BartPE", 231,90,260,20)

GUICtrlCreateLabel ("������� �����, �����, ���� ����� ��������� �����, ��� ��� �� ���������� ������ � txtsetup.sif, �������������� ������� ���������� �� ���������.", 20,130,400,40)




GUICtrlCreateTabitem ("")   ; ����� �������

GUISetState ()

While 1
   $msg = GUIGetMsg()
   Select
	  Case $msg = $Upd
		 $inputi386=GUICtrlRead ($inputi386z)
		 $inputzip0=GUICtrlRead ($inputdrv)
				If Not FileExists($inputi386) Then
					MsgBox(0, "������ ������", '�� ������ ������� i386')
					ContinueLoop
				EndIf
				If Not FileExists($inputzip0) Then
					MsgBox(0, "������ ������", '�� ������ ������� ���������')
					ContinueLoop
				EndIf
		 $size=FileGetSize($inputi386&'\TXTSETUP.SIF')
		 $size /=1024
		 $size=Ceiling ($size)
		 GUICtrlSetData($Label000, '����������� ����������...   TXTSETUP.SIF='&$size&'��')

; ����� ������
	If FileExists($inputzip0) Then
	  FileFindNextFirst($inputzip0)
   $filereg = FileOpen(@ScriptDir&'\drvlist.txt', 2)
   $fileinf = FileOpen(@ScriptDir&'\drvlist.inf', 2)
   FileWrite($fileinf, '[PEBuilder]'&@CRLF)
   FileWrite($fileinf, '[DelLine]'&@CRLF)
	; �������� �������� ����� ��� ������ ������
	If $filereg = -1 Then
	  MsgBox(0, "������", "�� �������� ������� ����.")
	  Exit
   EndIf
	  While 1 
		 $tempname = FileFindNext()
		 If $tempname = "" Then ExitLoop
		 ; ���������� ������ *.sys, ����������� � ������� drivers
		 $aPathwim = StringRegExp($tempname, "(^.*)\\(.*)$", 3)
		 If StringRight( $tempname, 3 )  = "sys" Then
			FileCopy($tempname, $inputi386&'\system32\drivers\', 9)
			FileWrite($filereg, 'i386\system32\drivers\'&$aPathwim[1]&@CRLF)
		 EndIf
		 ; ���������� ������ *.dll, ����������� � ������� system32
		 If StringRight( $tempname, 3 )  = "dll" Then
			FileCopy($tempname, $inputi386&'\system32\', 9)
			FileWrite($filereg, 'i386\system32\'&$aPathwim[1]&@CRLF)
		 EndIf
		 ; ���������� ������ *.exe, ����������� � ������� system32
		 If GUICtrlRead ($check)=1 And StringRight( $tempname, 3 )  = "exe" Then
			FileCopy($tempname, $inputi386&'\system32\', 9)
			FileWrite($filereg, 'i386\system32\'&$aPathwim[1]&@CRLF)
		 EndIf
		 
		 ; ���������� ������ *.inf, ����������� � ������� inf ��� ���� *.inf �������� ������ PEBuilder, �� ��������� ������
		 If StringRight( $tempname, 3 )  = "inf" Then
			$search1 = FileOpen($tempname, 0) ; ����������� � ������ ����
			$search2 = FileRead($search1)
			; �������� ��������� PEBuilder
			If StringRegExp($search2, "\[PEBuilder\]", 0)<>0 Then
			   $aSetValue = StringRegExp($search2, '(?s)\[SetValue\]([^\[]*)', 3) ; ���������� ��������� ��� ������������ ������ SetValue � ������
			   _ArrayToClip( $aSetValue, 0 ) ; ����������� ������� ����� �������� � ����� ������ � ������������ �������� �� ����� ������
			   $aRecords = StringSplit(ClipGet(), @CRLF) ; ������ ����� ������ ������������ � ������ ���������� �� ��������� ������� ���������
			   ;MsgBox(0, "������", $days[0])
			   
			   For $i=1 To $aRecords[0] ; ������ ������ ������� ��� ������ �� � ���� txtsetup.sif
			   If StringLeft($aRecords[$i], 14)='"txtsetup.sif"' Then ; �������� ��������� "txtsetup.sif" � ������
				  ; ��� �������� ������������ ����� ������ �� �������� (������, ��������, ��������)
				  $aSif = StringRegExp($aRecords[$i], '"(.*)", ?"(.*)", ?"(.*)", ?"(.*)"', 3)
				  If @Error=1 Then ExitLoop
				  ;MsgBox(0, "������", '1 '&$aSif[1]&@CRLF&'2 '&$aSif[2]&@CRLF&'3 '&$aSif[3])
				  ; �������������� ������� ������� ��� ���������
				  ;StringRegExpReplace($aSif3, '""', '"')
				  $aSif3 = StringReplace($aSif[3], '""', '"')

				  ;MsgBox(0, "������", '11 '&$aSif1&@CRLF&'22 '&$aSif2&@CRLF&'33 '&$aSif3)
				  ; ������ ���������� � txtsetup.sif �� �������� ini-�����
				  IniWrite($inputi386&'\txtsetup.sif', $aSif[1], $aSif[2], $aSif3)
				  FileWrite($fileinf, '"'&$aSif[0]&'","'&$aSif[1]&'","'&$aSif[2]&'"'&@CRLF) ; �������� ����� �� ��������, ��� ���������� �������� ��������
			   EndIf
			   Next
;=================================================================
			   ; ��������� ������ �� �������� �����
			   
			   If StringRegExp($search2, "\[DelLine\]", 0)<>0 Then
			   $aSetValue1 = StringRegExp($search2, '(?s)\[DelLine\]([^\[]*)', 3)
			   _ArrayToClip( $aSetValue1, 0 )
			   $aRecords = StringSplit(ClipGet(), @CRLF)
			   For $i=1 To $aRecords[0]
				  If StringLeft($aRecords[$i], 14)='"txtsetup.sif"' Then
					 $aSif = StringRegExp($aRecords[$i], '"(.*)", ?"(.*)", ?"(.*)"', 3)
					 IniDelete($inputi386&'\txtsetup.sif', $aSif[1], $aSif[2])
			   EndIf
			   Next
			   EndIf
;=================================================================
			Else
			   ; ����� ��������  *.inf � ����� inf
			   FileClose($tempname)
			   FileCopy($tempname, $inputi386&'\inf\', 9)
			   FileWrite($filereg, 'i386\inf\'&$aPathwim[1]&@CRLF)
			EndIf
		 EndIf
	  WEnd
	  FileClose($filereg)
	  FileClose($fileinf)
   EndIf
		 $size1=FileGetSize($inputi386&'\TXTSETUP.SIF')
		 $size1 /=1024
		 $size1=Ceiling ($size1)
   GUICtrlSetData($Label000, '��������� !!!                 TXTSETUP.SIF='&$size&'�� > '&$size1&'��')
   ;GUICtrlSetData($Label000, '����������� ����������...   TXTSETUP.SIF='&$size)

		; ������ "�����"
	  Case $msg = $filewim
		$tmpwim = FileSelectFolder ( "������� ����� i386 ��� MiniNT",'','3',@WorkingDir & '')
		GUICtrlSetData($inputi386z, $tmpwim)
	  Case $msg = $filezip
		$tmpzip = FileSelectFolder ( "������� ����� � ����������",'','3',@WorkingDir & '')
		GUICtrlSetData($inputdrv, $tmpzip)
	  Case $msg = $GUI_EVENT_CLOSE
		ExitLoop
   EndSelect
WEnd
	
;======================================================================================================
; ������� ������ ���� ������ � �������� (NIKZZZZ)
Func FileFindNextFirst($FindCat) 
  $Stack[0] = 1 
  $Stack1[1] = $FindCat 
  $Stack[$Stack[0]] = FileFindFirstFile($Stack1[$Stack[0]] & "\*.*") 
  Return $Stack[$Stack[0]] 
EndFunc   ;==>FileFindNextFirst 
 
Func FileFindNext() 
  While 1 
    $file = FileFindNextFile($Stack[$Stack[0]]) 
    If @error Then 
      FileClose($Stack[$Stack[0]]) 
      If $Stack[0] = 1 Then 
        Return "" 
      Else 
        $Stack[0] -= 1 
        ContinueLoop 
      EndIf 
    Else 
      If StringInStr(FileGetAttrib($Stack1[$Stack[0]] & "\" & $file), "D") > 0 Then 
        $Stack[0] += 1 
        $Stack1[$Stack[0]] = $Stack1[$Stack[0] - 1] & "\" & $file 
        $Stack[$Stack[0]] = FileFindFirstFile($Stack1[$Stack[0]] & "\*.*") 
        ContinueLoop 
      Else 
        Return $Stack1[$Stack[0]] & "\" & $file 
      EndIf 
    EndIf 
  WEnd 
EndFunc   ;==>FileFindNext