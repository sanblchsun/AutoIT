;  @AZJIO
AutoItSetOption("TrayIconHide", 1) ;������ � ��������� ������ ��������� AutoIt
$Replace='1' ; ���� 1 - ��������� ����������, ����� �� ���������
$razdelit='# ============' ; ����������� �������������� ��������, ����������� ������ ������ ����������� # ��� �������� ������.
$regtemp = @TempDir&'\export.reg'

; ����� ������� � ������� �������� ������ ������� � ����-�������� ���������
RunWait(@ScriptDir&'\pebuilder.exe -skipfiles -auto -overwrite -exit', '', @SW_HIDE)

; ����������� �������
RunWait (@SystemDir&'\reg.exe load HKLM\PE_LM_SW BartPE\I386\SYSTEM32\CONFIG\SOFTWARE', '', @SW_HIDE )
RunWait (@SystemDir&'\reg.exe load HKLM\PE_CU_DF BartPE\I386\SYSTEM32\CONFIG\DEFAULT', '', @SW_HIDE )
RunWait (@SystemDir&'\reg.exe load HKLM\PE_SY_HI BartPE\I386\SYSTEM32\SETUPREG.HIV', '', @SW_HIDE )

; ��������� ���� ��� ������������ ��������� reg-�����

For $i=1 To 200
   If Not FileExists(@ScriptDir&'\export'&$i&'.reg') Then
      $regfile1=@ScriptDir&'\export'&$i&'.reg'
      ExitLoop
   EndIf
Next

$regfile = FileOpen($regfile1, 1)
; �������� �������� ����� ��� ������ ������
If $regfile = -1 Then
  MsgBox(0, "������", "�� �������� ������� ����.")
  Exit
EndIf
FileWrite($regfile, 'Windows Registry Editor Version 5.00'&@CRLF&@CRLF) ;��������� ���������

RegDelete("HKEY_LOCAL_MACHINE\PE_SY_HI\ControlSet001\Control\PE Builder") ; ������� ���� �������� ������ �� �������

; ������� ������� �� ��������� ����� � ���������� ����� � �������������� ����.
;RunWait (@SystemDir&'\reg.exe export "'&@TempDir&'\export.reg" "HKEY_LOCAL_MACHINE\PE_LM_SW"', '', @SW_HIDE )
;RunWait ( @Comspec&' /C reg export "'&$temporarily&'" "'&$tempfile&'"', '', @SW_HIDE )
RunWait ( @Comspec&' /C regedit.exe -e "'&$regtemp&'" "HKEY_LOCAL_MACHINE\PE_LM_SW"', '', @SW_HIDE )
obrabotka()
RunWait ( @Comspec&' /C regedit.exe -e "'&$regtemp&'" "HKEY_LOCAL_MACHINE\PE_CU_DF"', '', @SW_HIDE )
obrabotka()
RunWait ( @Comspec&' /C regedit.exe -e "'&$regtemp&'" "HKEY_LOCAL_MACHINE\PE_SY_HI"', '', @SW_HIDE )
obrabotka()

FileClose($regfile)

; ���������� �������
RunWait (@SystemDir&'\reg.exe unload HKLM\PE_LM_SW', '', @SW_HIDE )
RunWait (@SystemDir&'\reg.exe unload HKLM\PE_CU_DF', '', @SW_HIDE )
RunWait (@SystemDir&'\reg.exe unload HKLM\PE_SY_HI', '', @SW_HIDE )


Func obrabotka()
$r1 = FileOpen($regtemp, 0)
$vr = FileRead($r1)
$vr = StringRegExpReplace($vr, "(?s)\[[^\]]+\]\s{4,}", "")
;$vr = StringReplace($vr, @CRLF&@CRLF&@CRLF, @CRLF&@CRLF)
$vr = StringReplace($vr, "Windows Registry Editor Version 5.00"&@CRLF, $razdelit)
If $Replace='1' Then
   $vr = StringReplace($vr, "HKEY_LOCAL_MACHINE\PE_CU_DF", "HKEY_CURRENT_USER")
   $vr = StringReplace($vr, "HKEY_LOCAL_MACHINE\PE_LM_SW", "HKEY_LOCAL_MACHINE\SOFTWARE")
   $vr = StringReplace($vr, "HKEY_LOCAL_MACHINE\PE_SY_HI", "HKEY_LOCAL_MACHINE\SYSTEM")
   $vr = StringReplace($vr, "ControlSet001", "CurrentControlSet")
EndIf
FileWrite($regfile, $vr)
FileClose($r1)
EndFunc






