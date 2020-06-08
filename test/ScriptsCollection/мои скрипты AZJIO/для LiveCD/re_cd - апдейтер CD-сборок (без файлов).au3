#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=re_cd.exe
#AutoIt3Wrapper_icon=UL.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=
#AutoIt3Wrapper_Res_Description=re_cd.exe
#AutoIt3Wrapper_Res_Fileversion=0.5.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2010.04.11
#Include <File.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

AutoItSetOption("TrayIconHide", 1) ;������ � ��������� ������ ��������� AutoIt

$sizewim=''
Global $Stack[50]
Global $Stack1[50]
Global $aDel
Global $Ini = @ScriptDir&'\reminint.ini' ; ���� � reminint.ini
;�������� ������������� reminint.ini
$answer = ""
If Not FileExists($Ini) Then $answer = MsgBox(4, "�������� �����������", "������ ������� ����������� reminint.ini ��� ���������� �������� ����������?")
If $answer = "6" Then
	IniWriteSection($Ini, "path", 'path1='&@LF&'path2='&@LF&'path3='&@LF&'check=0'&@LF&'save=1'&@LF&'bak=1')
EndIf
;��������� reminint.ini
$path1= IniRead ($Ini, "path", "path1", "")
$path2= IniRead ($Ini, "path", "path2", "")
$path3= IniRead ($Ini, "path", "path3", "")
$check= IniRead ($Ini, "path", "check", "0")
$save= IniRead ($Ini, "path", "save", "1")
$bak= IniRead ($Ini, "path", "bak", "1")

GUICreate("���������� CD-������",508,308, -1, -1, -1, $WS_EX_ACCEPTFILES) ; ������ ����
$tab=GUICtrlCreateTab (0,2, 508,284) ; ������ �������
$hTab = GUICtrlGetHandle($Tab) ; (1) ������ ����������� ������� �������� (����)

GUICtrlCreateLabel ("����������� drag-and-drop", 250,5,200,18)

$tab3=GUICtrlCreateTabitem ("Update") ; ��� �������

GUICtrlCreateLabel ("���� � I386", 20,40,400,20)
$inputi386z=GUICtrlCreateInput ("", 20,60,420,22)
GUICtrlSetState(-1,8)
$filei386=GUICtrlCreateButton ("...", 455,59,35,24)
GUICtrlSetFont (-1,15)
If $path1<>'' Then GUICtrlSetData($inputi386z, $path1)

GUICtrlCreateLabel ("���� � ����� � ������������", 20,100,400,20)
$inputzip=GUICtrlCreateInput ("", 20,120,420,22)
GUICtrlSetState(-1,8)
$filezip=GUICtrlCreateButton ("...", 455,119,35,24)
GUICtrlSetFont (-1,15)
If FileExists(@ScriptDir&'\Update') And $path2='' Then GUICtrlSetData($inputzip, @ScriptDir&'\Update')
If $path2<>'' Then GUICtrlSetData($inputzip, $path2)

GUICtrlCreateLabel ("��������� �������", 20,160,400,20)
$inputtmp=GUICtrlCreateInput ("", 20,180,420,22)
GUICtrlSetState(-1,8)
GUICtrlSetTip($inputtmp, "��� �������� ��������� reg-������")
If $path3='' Then
   GUICtrlSetData($inputtmp, @ScriptDir)
Else
   GUICtrlSetData($inputtmp, $path3)
EndIf
$filetmp=GUICtrlCreateButton ("...", 455,179,35,24)
GUICtrlSetFont (-1,15)

$checkpause=GUICtrlCreateCheckbox ("������� ����� ����� ��������������� ������ �������", 40,215,340,20)
GUICtrlSetTip($checkpause, "����� ��� �����������"&@CRLF&"������ ��������� �������")
If $check='1' Then GuiCtrlSetState($checkpause, 1)
If $check='0' Then GuiCtrlSetState($checkpause, 4)

$checksave=GUICtrlCreateCheckbox ("��������� ���������", 40,235,340,20)
If $save='1' Then GuiCtrlSetState($checksave, 1)
If $save='0' Then GuiCtrlSetState($checksave, 4)

$checkbak=GUICtrlCreateCheckbox ("������ backup �������", 40,255,340,20)
If $bak='1' Then GuiCtrlSetState($checkbak, 1)
If $bak='0' Then GuiCtrlSetState($checkbak, 4)


$Upd=GUICtrlCreateButton ("��������", 390,240,87,22)
$Label000=GUICtrlCreateLabel ('������ ���������			AZJIO 2010.04.11', 10,290,380,20)

GUICtrlCreateTabitem ("")   ; ����� �������

; (2) ���������� ������� ����������
Switch @OSVersion
    Case 'WIN_2000', 'WIN_XP', 'WIN_2003'
        $Part = 10
    Case Else
        $Part = 11
EndSwitch
$Color = _WinAPI_GetThemeColor($hTab, 'TAB', $Part, 1, 0x0EED)
If Not @error Then
	; ������������ ���������, ��� ������� ����� ��������� �������� �����
    GUICtrlSetBkColor($checkpause, $Color)
    GUICtrlSetBkColor($checksave, $Color)
    GUICtrlSetBkColor($checkbak, $Color)
EndIf

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg =  $GUI_EVENT_DROPPED  ;������� ������������ �� drag-and-drop (-13)
				If @GUI_DropID=$inputi386z Then GUICtrlSetData($inputi386z, @GUI_DRAGFILE)
				If @GUI_DropID=$inputzip Then GUICtrlSetData($inputzip, @GUI_DRAGFILE)
				If @GUI_DropID=$inputtmp Then GUICtrlSetData($inputtmp, @GUI_DRAGFILE)
			Case $msg = $Upd
				$inputi386z0=GUICtrlRead ($inputi386z)
				If Not FileExists($inputi386z0) Then
					MsgBox(0, "������ ������", '����������� ����� '&$inputi386z0)
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
				If GUICtrlRead ($checkbak)=1 Then
				   $inibak=1
				Else
				   $inibak=0
				EndIf
				If GUICtrlRead ($checkpause)=1 Then
				   $iniw=1
				Else
				   $iniw=0
				EndIf
				;���������� �������� � ini
				If GUICtrlRead ($checksave)=1 Then
				IniWrite($Ini, "path", "path1", $inputi386z0)
				IniWrite($Ini, "path", "path2", $inputzip0)
				IniWrite($Ini, "path", "path3", $inputtmp0)
				IniWrite($Ini, "path", "check", $iniw)
				IniWrite($Ini, "path", "bak", $inibak)
				IniWrite($Ini, "path", "save", '1')
				Else
				IniWrite($Ini, "path", "path1", '')
				IniWrite($Ini, "path", "path2", '')
				IniWrite($Ini, "path", "path3", '')
				IniWrite($Ini, "path", "check", '')
				IniWrite($Ini, "path", "bak", '')
				IniWrite($Ini, "path", "save", '0')
				EndIf
				If $inputtmp0='' or not FileExists($inputtmp0) Then $inputtmp0=@TempDir
				GUICtrlSetData($Label000, '�������� ��������� ����� tmp')
				If FileExists($inputtmp0&'\tmp') Then DirRemove($inputtmp0&'\tmp',1)
				DirCreate($inputtmp0&'\tmp')
				Sleep(900)
				
				
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
				
				$aPath = StringRegExp($inputi386z0, "(^.*)\\(.*)$", 3)
				
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
				   If $aDel[$i]<>'' and FileExists($aPath[0]&'\'&$aDel[$i]) Then FileDelete($aPath[0]&'\'&$aDel[$i])
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
				   If $aDel[$i]<>'' and FileExists($aPath[0]&'\'&$aDel[$i]) Then DirRemove($aPath[0]&'\'&$aDel[$i], 1)
				Next
				EndIf
			   WEnd
			EndIf
				  ; ������� �������� ������ �������
				FileSetAttrib($inputi386z0&'\system32\config\software', "-RASHT")
				FileSetAttrib($inputi386z0&'\system32\config\default', "-RASHT")
				FileSetAttrib($inputi386z0&'\system32\setupreg.hiv', "-RASHT")
				
				; ������ ����� �������
				If GUICtrlRead ($checkbak)=1 Then
				For $i=1 To 200
				   If Not FileExists(@ScriptDir&'\backup_reg'&$i) Then
					  FileCopy($inputi386z0&'\system32\config\software', @ScriptDir&'\backup_reg'&$i&'\system32\config\', 8)
					  FileCopy($inputi386z0&'\system32\config\default', @ScriptDir&'\backup_reg'&$i&'\system32\config\', 8)
					  FileCopy($inputi386z0&'\system32\setupreg.hiv', @ScriptDir&'\backup_reg'&$i&'\system32\', 8)
				      ExitLoop
				   EndIf
				Next
				EndIf
				
				GUICtrlSetData($Label000, '�������� ����� ���������� �� ����� root')
				If FileExists($inputzip0&'\root') Then DirCopy($inputzip0&'\root', $aPath[0]&'\', 1)
				
				; ����� ������� software, default � system ������������
				GUICtrlSetData($Label000, '���������� ����� �������')
				Run ( @Comspec&' /C REG LOAD HKLM\PE_LM_SW "'&$inputi386z0&'\system32\config\software"', '', @SW_HIDE )
				Run ( @Comspec&' /C REG LOAD HKLM\PE_CU_DF "'&$inputi386z0&'\system32\config\default"', '', @SW_HIDE )
				Run ( @Comspec&' /C REG LOAD HKLM\PE_SY_HI "'&$inputi386z0&'\system32\setupreg.hiv"', '', @SW_HIDE )
				GUICtrlSetData($Label000, '�������� ������� ������� � ������ �������')
				; ������ ������ � ������������ ������
				   ShellExecuteWait(@ScriptDir&'\tools\subinacl.exe','/subkeyreg HKEY_LOCAL_MACHINE\PE_LM_SW /grant=���=F','','', @SW_HIDE )
				   ShellExecuteWait(@ScriptDir&'\tools\subinacl.exe','/subkeyreg HKEY_LOCAL_MACHINE\PE_CU_DF /grant=���=F','','', @SW_HIDE )
				   ShellExecuteWait(@ScriptDir&'\tools\subinacl.exe','/subkeyreg HKEY_LOCAL_MACHINE\PE_SY_HI /grant=���=F','','', @SW_HIDE )
				GUICtrlSetData($Label000, '���������� ������ � ������ LiveCD.')
				RunWait ( @Comspec & ' /C regedit /s "'&$inputtmp0&'\tmp\base4.reg"', '', @SW_HIDE )
				RunWait ( @Comspec & ' /C regedit /s "'&$inputtmp0&'\tmp\base5.reg"', '', @SW_HIDE )
				
				;����������� �������� ����������� ������ �������
				$pe_lm_sw = RegRead("HKEY_LOCAL_MACHINE\PE_LM_SW", "")
				If @error=1 Then
				   $pe_lm_sw='�� ���������'
				   Run ( @Comspec&' /C REG LOAD HKLM\PE_LM_SW "'&$inputi386z0&'\system32\config\software"', '', @SW_HIDE )
				   ShellExecuteWait(@ScriptDir&'\tools\subinacl.exe','/subkeyreg HKEY_LOCAL_MACHINE\PE_LM_SW /grant=���=F','','', @SW_HIDE )
				Else
				   $pe_lm_sw='���������'
				EndIf
				$pe_cu_df = RegRead("HKEY_LOCAL_MACHINE\PE_CU_DF", "")
				If @error=1 Then
				   $pe_cu_df='�� ���������'
				   Run ( @Comspec&' /C REG LOAD HKLM\PE_CU_DF "'&$inputi386z0&'\system32\config\default"', '', @SW_HIDE )
				   ShellExecuteWait(@ScriptDir&'\tools\subinacl.exe','/subkeyreg HKEY_LOCAL_MACHINE\PE_CU_DF /grant=���=F','','', @SW_HIDE )
				Else
				   $pe_cu_df='���������'
				EndIf
				$pe_sy_hi = RegRead("HKEY_LOCAL_MACHINE\PE_SY_HI", "")
				If @error=1 Then
				   $pe_sy_hi='�� ���������'
				   Run ( @Comspec&' /C REG LOAD HKLM\PE_SY_HI "'&$inputi386z0&'\system32\setupreg.hiv"', '', @SW_HIDE )
				   ShellExecuteWait(@ScriptDir&'\tools\subinacl.exe','/subkeyreg HKEY_LOCAL_MACHINE\PE_SY_HI /grant=���=F','','', @SW_HIDE )
				Else
				   $pe_sy_hi='���������'
				EndIf
				   
				   ; ��������� �������� � ����� � ������������ �������������� ����� �������
				If GUICtrlRead ($checkpause)=1 Then
				  While 1
				$pe_lm_sw = RegRead("HKEY_LOCAL_MACHINE\PE_LM_SW", "")
				If @error=1 Then
				   $pe_lm_sw='�� ���������'
				   Run ( @Comspec&' /C REG LOAD HKLM\PE_LM_SW "'&$inputi386z0&'\system32\config\software"', '', @SW_HIDE )
				   ShellExecuteWait(@ScriptDir&'\tools\subinacl.exe','/subkeyreg HKEY_LOCAL_MACHINE\PE_LM_SW /grant=���=F','','', @SW_HIDE )
				Else
				   $pe_lm_sw='���������'
				EndIf
				$pe_cu_df = RegRead("HKEY_LOCAL_MACHINE\PE_CU_DF", "")
				If @error=1 Then
				   $pe_cu_df='�� ���������'
				   Run ( @Comspec&' /C REG LOAD HKLM\PE_CU_DF "'&$inputi386z0&'\system32\config\default"', '', @SW_HIDE )
				   ShellExecuteWait(@ScriptDir&'\tools\subinacl.exe','/subkeyreg HKEY_LOCAL_MACHINE\PE_CU_DF /grant=���=F','','', @SW_HIDE )
				Else
				   $pe_cu_df='���������'
				EndIf
				$pe_sy_hi = RegRead("HKEY_LOCAL_MACHINE\PE_SY_HI", "")
				If @error=1 Then
				   $pe_sy_hi='�� ���������'
				   Run ( @Comspec&' /C REG LOAD HKLM\PE_SY_HI "'&$inputi386z0&'\system32\setupreg.hiv"', '', @SW_HIDE )
				   ShellExecuteWait(@ScriptDir&'\tools\subinacl.exe','/subkeyreg HKEY_LOCAL_MACHINE\PE_SY_HI /grant=���=F','','', @SW_HIDE )
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
				
				
				
				
				GUICtrlSetData($Label000, '������ !!!')
				
				GUICtrlSetState($Upd, $GUI_ENABLE)
				
				; ������ "�����"
			Case $msg = $filei386
					$tmpi386 = FileSelectFolder ( "������� ����� i386",'','3',@WorkingDir & '')
					GUICtrlSetData($inputi386z, $tmpi386)
			Case $msg = $filezip
					$tmpzip = FileSelectFolder ( "������� ����� � ������������",'','3',@WorkingDir & '')
					GUICtrlSetData($inputzip, $tmpzip)
			Case $msg = $filetmp
					$tmpbartpe = FileSelectFolder ( "������� ��������� �����",'','3',@WorkingDir & '')
					GUICtrlSetData($inputtmp, $tmpbartpe)
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
		EndSelect
	WEnd



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

Func _WinAPI_GetThemeColor($hWnd, $sClass, $iPart, $iState, $iProp)
	Local $hTheme = DllCall('uxtheme.dll', 'ptr', 'OpenThemeData', 'hwnd', $hWnd, 'wstr', $sClass)
	Local $Ret = DllCall('uxtheme.dll', 'lresult', 'GetThemeColor', 'ptr', $hTheme[0], 'int', $iPart, 'int', $iState, 'int', $iProp, 'dword*', 0)

	If (@error) Or ($Ret[0] < 0) Then
		$Ret = -1
	EndIf
	DllCall('uxtheme.dll', 'lresult', 'CloseThemeData', 'ptr', $hTheme[0])
	If $Ret = -1 Then
		Return SetError(1, 0, -1)
	EndIf
	Return SetError(0, 0, BitOR(BitAND($Ret[5], 0x00FF00), BitShift(BitAND($Ret[5], 0x0000FF), -16), BitShift(BitAND($Ret[5], 0xFF0000), 16)))
EndFunc   ;==>_WinAPI_GetThemeColor