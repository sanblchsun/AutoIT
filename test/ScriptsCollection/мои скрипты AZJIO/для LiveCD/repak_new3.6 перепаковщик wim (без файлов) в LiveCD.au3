;  @AZJIO
#Include <File.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

#NoTrayIcon ;������ � ��������� ������ ��������� AutoIt


Global $Stack[50]
Global $Stack1[50]
Global $aDel

GUICreate("���������� ����������� wim-������ v0.3.6",508,308, -1, -1, -1, $WS_EX_ACCEPTFILES) ; ������ ����
$tab=GUICtrlCreateTab (0,2, 508,284) ; ������ �������

GUICtrlCreateLabel ("����������� drag-and-drop", 250,3,200,18)

$tab3=GUICtrlCreateTabitem ("Update") ; ��� �������

GUICtrlCreateLabel ("���� � ������������ wim-�����", 20,40,400,20)
$inputwim=GUICtrlCreateInput ("", 20,60,420,22)
GUICtrlSetState(-1,8)
$filewim=GUICtrlCreateButton ("...", 455,59,35,24)

GUICtrlCreateLabel ("���� � ����� � ������������", 20,100,400,20)
$inputzip=GUICtrlCreateInput ("", 20,120,420,22)
GUICtrlSetState(-1,8)
$filezip=GUICtrlCreateButton ("...", 455,119,35,24)

GUICtrlCreateLabel ("��������� �������", 20,160,400,20)
$inputtmp=GUICtrlCreateInput ("", 20,180,420,22)
GUICtrlSetState(-1,8)
GUICtrlSetTip($inputtmp, "�� ��������� ���������� ����������"&@CRLF&"������ �������� � ���� �������������"&@CRLF&"������� ����� � ����� �����"&@CRLF&"��������� ����� �� ����� ��� �������� WIM")
$filetmp=GUICtrlCreateButton ("...", 455,179,35,24)

$checkpause=GUICtrlCreateCheckbox ("������� ����� ����� ������������� �������", 40,220,320,20)
GUICtrlSetTip($checkpause, "����� ��� �����������"&@CRLF&"������ ��������� �������")
GuiCtrlSetState($checkpause, 4)


$Readme=GUICtrlCreateButton ("Readme", 390,220,87,22)

$Upd=GUICtrlCreateButton ("��������", 390,250,87,22)
$Label000=GUICtrlCreateLabel ('������ ���������			AZJIO 2010.01.03', 10,290,380,20)
$LabelMb=GUICtrlCreateLabel ('', 392,286,80,20)
GUICtrlSetFont (-1,15)

GUICtrlCreateTabitem ("")   ; ����� �������

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = $Upd
				GUICtrlSetData($LabelMb, '')
				GUICtrlSetColor($LabelMb,0x000000)
				$inputwim0=GUICtrlRead ($inputwim)
				If Not FileExists($inputwim0) Then
					MsgBox(0, "������ ������", '����������� ���� '&$inputwim0)
					ContinueLoop
				EndIf
				$inputzip0=GUICtrlRead ($inputzip)
				If Not FileExists($inputzip0) Then
					MsgBox(0, "������ ������", '����������� ����� '&$inputzip0)
					ContinueLoop
				EndIf
				$inputtmp0=GUICtrlRead ($inputtmp)
				If Not FileExists($inputtmp0) Then
					MsgBox(0, "������ ������", '����������� ����� '&$inputtmp0)
					ContinueLoop
				EndIf
				GUICtrlSetState($Upd, $GUI_DISABLE)
				If $inputtmp0='' or not FileExists($inputtmp0) Then $inputtmp0=@TempDir
				GUICtrlSetData($Label000, '�������� ��������� ����� tmp')
				If FileExists($inputtmp0&'\tmp') Then DirRemove($inputtmp0&'\tmp',1)
				DirCreate($inputtmp0&'\tmp\base_wim')
				Sleep(900)
				
				
				; ����������� ����� WIM-�����
				$rnim = Run(@ScriptDir&'\imagex.exe /info "'&$inputwim0&'"', @SystemDir, @SW_HIDE, 2)
				$wiminfo=''
				While 1
				    $line1 = StdoutRead($rnim)
				    If @error Then ExitLoop
				     $wiminfo &= $line1
				Wend
				    $labelwim0 = StringRegExpReplace($wiminfo, "(?s).*<NAME>(.*)</NAME>.*", "\1")
				If $labelwim0='' Then 
				  MsgBox(0, "����������", '�� ������� ����� wim-�����.'&@CRLF&'��� ����� ������� wim-���� ����������.')
				  Exit
				EndIf
				; ����� - ����������� ����� WIM-�����
				
				$aPathwim = StringRegExp($inputwim0, "(^.*)\\(.*)$", 3)
				GUICtrlSetData($Label000, '���������� '&$aPathwim[1]&' �� ��������� ����� tmp')
				; ������� ���������� WIM-�����
				ShellExecuteWait (@ScriptDir&'\imagex.exe','/apply "'&$inputwim0&'" "'&$labelwim0&'" "'&$inputtmp0&'\tmp\base_wim"','','', @SW_HIDE )
				
				
				
				; ��������� ���� base5.reg
				GUICtrlSetData($Label000, '����������� base5.reg')
				If FileExists($inputzip0&'\reg') Then
				  FileFindNextFirst($inputzip0&'\reg')
				  $filereg = FileOpen($inputtmp0&'\tmp\base5.reg', 1)
				; �������� �������� ����� ��� ������ ������
				If $filereg = -1 Then
				  MsgBox(0, "������", "�� �������� ������� ����.")
				  Exit
				EndIf
				  FileWrite($filereg, 'Windows Registry Editor Version 5.00'&@CRLF&@CRLF)
				  While 1 
					 $tempname = FileFindNext()
					 If $tempname = "" Then ExitLoop 
					 If StringRight( $tempname, 3 )  = "reg" Then
						; ����������� reg-���� ��� ������ �����
						$search1 = FileOpen($tempname, 0)
						$search2 = FileRead($search1)
						$regline = FileReadLine($search1,1)
						If FileReadLine($search1,1) = 'Windows Registry Editor Version 5.00' Then
						   $SR1 = StringReplace($search2, "HKEY_CURRENT_USER", "HKEY_LOCAL_MACHINE\PE_CU_DF")
						   $SR1 = StringReplace($SR1, "HKEY_LOCAL_MACHINE\SOFTWARE", "HKEY_LOCAL_MACHINE\PE_LM_SW")
						   $SR1 = StringReplace($SR1, "HKEY_LOCAL_MACHINE\SYSTEM", "HKEY_LOCAL_MACHINE\PE_SY_HI")
						   $SR1 = StringReplace($SR1, "CurrentControlSet", "ControlSet001")
						   $SR1 = StringReplace($SR1, "HKEY_CLASSES_ROOT", "HKEY_LOCAL_MACHINE\PE_LM_SW\Classes")
						   $SR1 = StringReplace($SR1, "Windows Registry Editor Version 5.00", '# '& StringRegExpReplace($tempname, "^.*\\", ""))
						   ; ���������� ���������, �������� ������ � reg-����� �� ��������������� ��� ��������� �������
						   $SR1 = StringRegExpReplace($SR1, "(?s)\[(HKEY_USERS|HKEY_CURRENT_CONFIG|HKEY_LOCAL_MACHINE\\HARDWARE|HKEY_LOCAL_MACHINE\\SAM|HKEY_LOCAL_MACHINE\\SECURITY).*?([^\[]*)", "")
						   FileWrite($filereg, $SR1&@CRLF&@CRLF)
						   FileClose($tempname)
						EndIf
					 EndIf
				  WEnd
				  FileWrite($filereg, @CRLF)
				  FileClose($filereg)
				 EndIf
				; ����� - ��������� ���� base5.reg
				
				
				
				; ��������� ���� base4.reg
				GUICtrlSetData($Label000, '����������� base4.reg')
				If FileExists($inputzip0&'\reg') Then
				  FileFindNextFirst($inputzip0&'\reg')
				  $filereg = FileOpen($inputtmp0&'\tmp\base4.reg', 1)
				; �������� �������� ����� ��� ������ ������
				If $filereg = -1 Then
				  MsgBox(0, "������", "�� �������� ������� ����.")
				  Exit
				EndIf
				  FileWrite($filereg, 'REGEDIT4'&@CRLF&@CRLF)
				  While 1
					 $tempname = FileFindNext()
					 If $tempname = "" Then ExitLoop 
					 If StringRight( $tempname, 3 )  = "reg" Then
						; ����������� reg-���� ��� ������ �����
						$search1 = FileOpen($tempname, 0)
						$search2 = FileRead($search1)
						$regline = FileReadLine($search1,1)
						If FileReadLine($search1,1) = 'REGEDIT4' Then
						   $SR1 = StringReplace($search2, "HKEY_CURRENT_USER", "HKEY_LOCAL_MACHINE\PE_CU_DF")
						   $SR1 = StringReplace($SR1, "HKEY_LOCAL_MACHINE\SOFTWARE", "HKEY_LOCAL_MACHINE\PE_LM_SW")
						   $SR1 = StringReplace($SR1, "HKEY_LOCAL_MACHINE\SYSTEM", "HKEY_LOCAL_MACHINE\PE_SY_HI")
						   $SR1 = StringReplace($SR1, "CurrentControlSet", "ControlSet001")
						   $SR1 = StringReplace($SR1, "HKEY_CLASSES_ROOT", "HKEY_LOCAL_MACHINE\PE_LM_SW\Classes")
						   $SR1 = StringReplace($SR1, "REGEDIT4", '# '& StringRegExpReplace($tempname, "^.*\\", ""))
						   ; ���������� ���������, �������� ������ � reg-����� �� ��������������� ��� ��������� �������
						   $SR1 = StringRegExpReplace($SR1, "(?s)\[(HKEY_USERS|HKEY_CURRENT_CONFIG|HKEY_LOCAL_MACHINE\\HARDWARE|HKEY_LOCAL_MACHINE\\SAM|HKEY_LOCAL_MACHINE\\SECURITY).*?([^\[]*)", "")
						   FileWrite($filereg, $SR1&@CRLF&@CRLF)
						   FileClose($tempname)
						EndIf
					 EndIf
				  WEnd
				  FileWrite($filereg, @CRLF)
				  FileClose($filereg)
				 EndIf
				; ����� - ��������� ���� base4.reg
				
				
				; ��������� ������ �������� ������
				If FileExists($inputzip0&'\Del') Then
				  FileFindNextFirst($inputzip0&'\Del')
			   While 1
					 $tempname = FileFindNext()
					 If $tempname = "" Then ExitLoop 
					 If StringRight( $tempname, 12 )  = "_delfile.txt" Then
				_FileReadToArray($tempname,$aDel)
				For $i=1 To $aDel[0]
				   ; ��������� �������� ����������� � �����
				   If $aDel[$i]<>'' and FileExists($inputtmp0&'\tmp\base_wim\'&$aDel[$i]) Then FileDelete($inputtmp0&'\tmp\base_wim\'&$aDel[$i])
				Next
				EndIf
			   WEnd
				EndIf
			   
				; ��������� ������ �������� �����
				If FileExists($inputzip0&'\Del') Then
				  FileFindNextFirst($inputzip0&'\Del')
			   While 1
					 $tempname = FileFindNext()
					 If $tempname = "" Then ExitLoop 
					 If StringRight( $tempname, 11 )  = "_deldir.txt" Then
				_FileReadToArray($tempname,$aDel)
				For $i=1 To $aDel[0]
				   ; ��������� �������� ����������� � �����
				   If $aDel[$i]<>'' and FileExists($inputtmp0&'\tmp\base_wim\'&$aDel[$i]) Then DirRemove($inputtmp0&'\tmp\base_wim\'&$aDel[$i], 1)
				Next
				EndIf
			   WEnd
			EndIf
			
				GUICtrlSetData($Label000, '�������� ����� ���������� �� ����� root')
				If FileExists($inputzip0&'\root') Then DirCopy($inputzip0&'\root', $inputtmp0&'\tmp\base_wim', 1)
				
				; ����� ������� software, default � system ������������
				GUICtrlSetData($Label000, '���������� ����� �������')
				Run ( @Comspec&' /C REG LOAD HKLM\PE_LM_SW "'&$inputtmp0&'\tmp\base_wim\i386\system32\config\software"', '', @SW_HIDE )
				Run ( @Comspec&' /C REG LOAD HKLM\PE_CU_DF "'&$inputtmp0&'\tmp\base_wim\i386\system32\config\default"', '', @SW_HIDE )
				Run ( @Comspec&' /C REG LOAD HKLM\PE_SY_HI "'&$inputtmp0&'\tmp\base_wim\i386\system32\setupreg.hiv"', '', @SW_HIDE )
				GUICtrlSetData($Label000, '���������� ������ � ������ LiveCD.')
				RunWait ( @Comspec & ' /C regedit /s "'&$inputtmp0&'\tmp\base4.reg"', '', @SW_HIDE )
				RunWait ( @Comspec & ' /C regedit /s "'&$inputtmp0&'\tmp\base5.reg"', '', @SW_HIDE )
				
				;����������� �������� ����������� ������ �������
				$pe_lm_sw = RegRead("HKEY_LOCAL_MACHINE\PE_LM_SW", "")
				If @error=1 Then
				   $pe_lm_sw='�� ���������'
				   Run ( @Comspec&' /C REG LOAD HKLM\PE_LM_SW '&$inputtmp0&'\tmp\base_wim\i386\system32\config\software', '', @SW_HIDE )
				Else
				   $pe_lm_sw='���������'
				EndIf
				$pe_cu_df = RegRead("HKEY_LOCAL_MACHINE\PE_CU_DF", "")
				If @error=1 Then
				   $pe_cu_df='�� ���������'
				   Run ( @Comspec&' /C REG LOAD HKLM\PE_CU_DF '&$inputtmp0&'\tmp\base_wim\i386\system32\config\default', '', @SW_HIDE )
				Else
				   $pe_cu_df='���������'
				EndIf
				$pe_sy_hi = RegRead("HKEY_LOCAL_MACHINE\PE_SY_HI", "")
				If @error=1 Then
				   $pe_sy_hi='�� ���������'
				   Run ( @Comspec&' /C REG LOAD HKLM\PE_SY_HI '&$inputtmp0&'\tmp\base_wim\i386\system32\setupreg.hiv', '', @SW_HIDE )
				Else
				   $pe_sy_hi='���������'
				EndIf
				   
				If GUICtrlRead ($checkpause)=1 Then
				  While 1
				$pe_lm_sw = RegRead("HKEY_LOCAL_MACHINE\PE_LM_SW", "")
				If @error=1 Then
				   $pe_lm_sw='�� ���������'
				   Run ( @Comspec&' /C REG LOAD HKLM\PE_LM_SW "'&$inputtmp0&'\tmp\base_wim\i386\system32\config\software"', '', @SW_HIDE )
				Else
				   $pe_lm_sw='���������'
				EndIf
				$pe_cu_df = RegRead("HKEY_LOCAL_MACHINE\PE_CU_DF", "")
				If @error=1 Then
				   $pe_cu_df='�� ���������'
				   Run ( @Comspec&' /C REG LOAD HKLM\PE_CU_DF "'&$inputtmp0&'\tmp\base_wim\i386\system32\config\default"', '', @SW_HIDE )
				Else
				   $pe_cu_df='���������'
				EndIf
				$pe_sy_hi = RegRead("HKEY_LOCAL_MACHINE\PE_SY_HI", "")
				If @error=1 Then
				   $pe_sy_hi='�� ���������'
				   Run ( @Comspec&' /C REG LOAD HKLM\PE_SY_HI "'&$inputtmp0&'\tmp\base_wim\i386\system32\setupreg.hiv"', '', @SW_HIDE )
				Else
				   $pe_sy_hi='���������'
				EndIf
				RunWait ( @Comspec & ' /C regedit /s "'&$inputtmp0&'\tmp\base4.reg"', '', @SW_HIDE )
				RunWait ( @Comspec & ' /C regedit /s "'&$inputtmp0&'\tmp\base5.reg"', '', @SW_HIDE )
				$rger=MsgBox(6, "�������� �����������", '����� ��� ������ ������ ����� ���������.'&@CRLF&@CRLF&'"����������" - ��������.'&@CRLF&'"���������" - ���������� ������, ���� �� ���������.'&@CRLF&'"������" - ������� ���������.'&@CRLF&@CRLF&'software       - '&$pe_lm_sw&@CRLF&'default          - '&$pe_cu_df&@CRLF&'setupreg.hiv - '&$pe_sy_hi)
				If $rger=11 Then ExitLoop
				If $rger=2 Then
				; ���������� ������ �������
				   RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_LM_SW', '', @SW_HIDE )
				   RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_CU_DF', '', @SW_HIDE )
				   RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_SY_HI', '', @SW_HIDE )
				   Exit
				EndIf
				WEnd
				EndIf
				GUICtrlSetData($Label000, '��������� ����� �������')
				; ���������� ������ �������
				RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_LM_SW', '', @SW_HIDE )
				RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_CU_DF', '', @SW_HIDE )
				RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_SY_HI', '', @SW_HIDE )
				
				$namewimpe = StringTrimRight($aPathwim[1], 4)
				GUICtrlSetData($Label000, '����������� �������� � '&$namewimpe&'_New.wim. ��������� ����������.')
				
				; �������� wim � ��������-�����
				$ProgressBar = GUICtrlCreateProgress(154, 262, 200, 16)
				GUICtrlSetColor(-1, 32250); ���� ��� ������������ ����
				
				$iPos = 0
				$iPID = Run(@ScriptDir&'\imagex.exe /capture /boot "'&$inputtmp0&'\tmp\base_wim" "'&$inputtmp0&'\'&$namewimpe&'_New.wim" "'&$labelwim0&'" /compress maximum', '', @SW_HIDE)
				While ProcessExists($iPID)
				   $sizewim=''
				   If FileExists($inputtmp0&'\'&$namewimpe&'_New.wim') Then $sizewim=FileGetSize($inputtmp0&'\'&$namewimpe&'_New.wim')
					  $sizewim /=1048576
					  $sizewim=Ceiling ($sizewim)
					  GUICtrlSetData($LabelMb, $sizewim&' ��')
				  $iPos += 1
				  GUICtrlSetData($ProgressBar, $iPos)
				  Sleep(60)
				  If $iPos > 100 Then $iPos = 0
				WEnd
				   If FileExists($inputtmp0&'\'&$namewimpe&'_New.wim') Then $sizewim=FileGetSize($inputtmp0&'\'&$namewimpe&'_New.wim')
					  $sizewim /=1048576
					  $sizewim=Ceiling ($sizewim)
					  GUICtrlSetData($LabelMb, $sizewim&' ��')
				GUICtrlSetColor($LabelMb,0xEE0000)    ; Red
				GUICtrlDelete($ProgressBar)
				; �����: �������� wim � ��������-�����
				
				
				GUICtrlSetData($Label000, '������ !!! ������: '&$sizewim&' ��.')
				
				Run('Explorer.exe /select,"'&$inputtmp0&'\'&$namewimpe&'_New.wim"')
				GUICtrlSetState($Upd, $GUI_ENABLE)
				
				; ������ "�����"
			Case $msg = $filewim
					$tmpwim = FileOpenDialog("����� wim-�����.", @WorkingDir & "", "����������� ����� (*.wim)", 1 + 4 )
					GUICtrlSetData($inputwim, $tmpwim)
			Case $msg = $filezip
					$tmpzip = FileSelectFolder ( "������� ����� � ������������",'','3',@WorkingDir & '')
					GUICtrlSetData($inputzip, $tmpzip)
			Case $msg = $filetmp
					$tmpbartpe = FileSelectFolder ( "������� ��������� �����",'','3',@WorkingDir & '')
					GUICtrlSetData($inputtmp, $tmpbartpe)
			Case $msg = $Readme
					MsgBox(0, "������ ����������", '����� Update �������� �������������� �������� reg, root � del'&@CRLF&'reg - � ���� ������� ����������� ����� *.reg ��� ������ � ������ ������� ������.'&@CRLF&'root - � ���� ������� ����������� ���������� � ����� ����� �� ���������� ��������� �������� wim, ��������, root\i386'&@CRLF&'del - � ���� ������� ����������� �����-������ ��� �������� ������ � ������� ������.'&@CRLF&'_deldir.txt - � ���� ���� ����������� ������ �������� ����� � wim, �������� Programs\TotalCmd'&@CRLF&'_delfile.txt - � ���� ���� ����������� ������ �������� ������ � wim, �������� i386\System32\PENetwork_Fr.lng. � ������ ��� ������� �������� ����� ��������� ����� ��������, �������� PENet_delfile.txt')
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
		EndSelect
	WEnd


;======================================================================================================
; ������� ������ ���� ������ � ��������
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