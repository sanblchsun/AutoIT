#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#pragma compile(AutoItExecuteAllowed, true)
#include <Array.au3>
#include <WinAPIEx.au3>
#include <Constants.au3>
#Include <File.au3>
#include <Clipboard.au3>
#include <Date.au3>

Opt("SendKeyDelay",100) ; enable delay 20 ms for Send
Opt("WinDetectHiddenText", 1) ; show hidden text
Opt("WinSearchChildren", 1) ; search for sub-windows
Opt("WinWaitDelay", 500) ; wait 500 ms after window commands
Opt("WinTitleMatchMode", 3)

Global $PathPlatform = "C:\Program Files (x86)\1cv8\8.3.5.1517\bin\1cv8.exe"
Global $PathBase = "C:\Users\Makosov_A\Desktop\test\TESTbase\base"
Global $LogFile = "C:\Users\Makosov_A\Desktop\test\TESTbase\log.txt"
Global $MsgLog = " /Out" & """" & $LogFile & """" & " -NoTruncate"
Global $V8Stor = "C:\Users\Makosov_A\Desktop\test\TESTbase\30_PROF"
Global $UpdFile = "\\builder-fat\1c\8.2\AccountingCorp\3.0.40.21\1Cv8.cf"
Global $ConfigName = "������������ - ����������� �����������, �������� 3.0"


If FileExists($LogFile) Then
   FileDelete ($LogFile)
   $hFile = FileOpen($LogFile, 1)
Else
   $hFile = FileOpen($LogFile, 2)
EndIf

BlockInput(1) ; ��������� ���������� � ����
FileClose ($hFile )
$MyPID1 = Run("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBase & """" & " /N"""""& " /ConfigurationRepositoryF " & """" & $V8Stor & """" & " /ConfigurationRepositoryN ""�������""")

If Not $MyPID1 Then
   $hFile = FileOpen($LogFile, 1)
   Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!!�������� ���� � ���������: " & "" & $PathPlatform & "" &  ". ������ ����������")
EndIf

$hFile = FileOpen($LogFile, 1)
Send("{CapsLock off}") ;��������� CapsLock
$hWnd = WinWait($ConfigName) ; ��� �������� (30) �������� ��������


If WinActivate($hWnd) Then

   Call("LineLogFile",$LogFile, "����: " & "" & $ConfigName & "" &  " ���������")
   WinMove($hWnd, "", 10, 10, 800, 600)
   ;���� ���� ������ ���������� �� �������, ������� ���
   $hWndV8Grid = WinWait("[CLASS:V8Grid]", "", 3)
   If Not $hWndV8Grid Then
	  Call("LineLogFile",$LogFile, "������ ��������� ������������ �� �������, ������� ���")
	  _WinAPI_SetKeyboardLayout($hWnd,0x0419)
	  Sleep(100)
	  WinActivate($hWnd)
	  Send("!�")
	  Send("!a")
	  Send("{RIGHT 2}{ENTER}")
   EndIf
   WinWait("[CLASS:V8Grid]", "", 20)
   ; ������� � ���� � ������ "�������� ������������"
   Call("LineLogFile",$LogFile, "������� � ���� � ������: " & "" & "�������� ������������" & "")
   _WinAPI_SetKeyboardLayout($hWnd,0x0419)
   Sleep(100)
   WinActivate($hWnd)
   Send("!�")
   Send("!a")
   Send("{RIGHT 2}{DOWN 5}{RIGHT}{ENTER}{DOWN}{TAB}{ENTER}{TAB 3}")
   ; ������� ������ ���� "���������� ������������" � �������� ��� �������
   $hWnd0 = WinWait("���������� ������������","",20)
   If WinActivate($hWnd0) Then
	  If FileExists($UpdFile) Then
		 _WinAPI_SetKeyboardLayout($hWnd,0x0409)
		 WinActivate($hWnd0)
		 Send($UpdFile)
		 WinActivate($hWnd0)
		 Send("{TAB 2}{ENTER}")
		 Call("LineLogFile",$LogFile, "� ����: " & "" & "���������� ������������" & "" & " ��������� ���� � ����� ���������� ")
	  Else
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!!�������� ���� � ����� ��������: " & "" & $UpdFile & "" &  ". ������ ����������")
		 FileClose($LogFile)
		 Exit
	  EndIf
	  Call("LineLogFile",$LogFile, "��������� ����: " & "" & "���������� ������������" & "")
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!!�� ������� ����: " & "" & "���������� ������������" & ", ������, " &  ". ������ ����������")
	  FileClose($LogFile)
	  Exit
   EndIf
   ; ������� ������ ���� "���������� ������������"
   $hWnd1 = WinWait("���������� ������������","",20)
   If WinActivate($hWnd1) Then
	  Call("LineLogFile",$LogFile, "��������� ����: " & "" & "���������� ������������" & " ��� ���")
	  WinActivate($hWnd1)
	  Send("{ENTER}")
	  ProgressOn("", "", "", 100, 850)
	  local $i = 0
	  BlockInput(0) ; �������� ���������� � ����
	  ; ����������� ���� � ������� ��� ����������
	  While 1
		 ProgressSet(($i*100/180),"�:" & $i, "�������� ���������� ����-������")
		 If WinExists("��������������") Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! � ���� ��������� �� ��������� �������. ������ ����������")
			FileClose($LogFile)
			Exit
		 EndIf
		 WinSetState($hWnd,"",@SW_MINIMIZE)
		 Sleep(3000)
		 $iState = WinGetState($hWnd)
		 If BitAND($iState, 4) Then
			;'��������/'
			ProgressSet(100,"�:" & $i, "�������� 100%")
			Sleep(500)
			ProgressOff()
			ExitLoop
		 EndIf
		 $i +=1
	  WEnd
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!!�� ������� ����: " & "" & "���������� ������������" & ", ������, " &  ". ������ ����������")
	  FileClose($LogFile)
	  Exit
   EndIf


EndIf
BlockInput(1) ; ��������� ���������� � ����
WinSetState($hWnd,"",@SW_RESTORE)
WinMove($hWnd, "", 10, 10, 800, 600)
;������� � ����������� {TAB 12}{ENTER}
WinWait($hWnd)
If WinActivate($hWnd) Then
   Send("{TAB 12}{ENTER}")
   Call("LineLogFile",$LogFile, "� ���� ������� � ����������� ����� ������ �����")
Else
   Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!!�� ������� ����: " & "" & $hWnd & "" &  ". ������ ����������")
   FileClose($LogFile)
   Exit
EndIf
;������������ ������ (V8NewLocalFrameBaseWnd) {TAB 3}{ENTER}
$hWnd2 = WinWait("������������ ������")
If WinActivate($hWnd2) Then
   Send("{TAB 3}{ENTER}")
   Call("LineLogFile",$LogFile, "� ���� ������������ ������ ����� ������ �����")
Else
   Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!!�� ������� ����: " & "" & "������������ ������" & "" &  ". ������ ����������")
   FileClose($LogFile)
   Exit
EndIf
;������������ (V8NewLocalFrameBaseWnd) {ENTER}
$hWnd3 = WinWait("������������")
If WinActivate($hWnd3) Then
   Send("{ENTER}")
   Call("LineLogFile",$LogFile, "� ���� ������������ ����� ������ �����")
Else
   Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!!�� ������� ����: " & "" & "������������" & "" &  ". ������ ����������")
   FileClose($LogFile)
   Exit
EndIf
;��������� ������ ��������� (V8NewLocalFrameBaseWnd) {TAB 6}{ENTER}
$hWnd4 = WinWait("��������� ������ ���������")
If WinActivate($hWnd4) Then
   Send("{TAB 6}{ENTER}")
   Call("LineLogFile",$LogFile, "� ���� ��������� ������ ��������� ����� ������ �����")
Else
   Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!!�� ������� ����: " & "" & "��������� ������ ���������" & "" &  ". ������ ����������")
   FileClose($LogFile)
   Exit
EndIf
;������������ (V8NewLocalFrameBaseWnd) {ENTER}
$hWnd4 = WinWait("������������")
If WinActivate($hWnd4) Then
   Send("{ENTER}")
   Call("LineLogFile",$LogFile, "� ���� ������������ ����� ������ �����")
Else
   Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!!�� ������� ����: " & "" & "������������" & "" &  ". ������ ����������")
   FileClose($LogFile)
   Exit
EndIf

Local $iPID = WinGetProcess($hWnd)
Call("CloseConfig",$hWnd,"�������������")



While 1
   If Not ProcessExists($iPID) Then
	  Call("LineLogFile",$LogFile, "������������ ���� � ������� �������� : /" & $iPID & "/ �������� ������")
	  ExitLoop
   EndIf
   Sleep(300000)
   Call("LineLogFile",$LogFile, "�������� ����� ����� �������� ������� : /" & $iPID)
WEnd
BlockInput(0) ; �������� ���������� � ����
FileClose($LogFile)




Func LineLogFile($LogFileFunc, $Line)
	If FileExists($LogFileFunc) Then
		FileWriteLine($LogFileFunc, $Line)
	Else
		BlockInput(0) ; �������� ���������� � ����
		MsgBox(0,"������","��� LOG - ����� ������ �����������")
		FileClose($LogFile)
		Exit
	EndIf
 EndFunc

 Func CloseConfig($hWndFunc, $TegErr)
   If ($TegErr="���������") Then
	  Call("KillPID",$hWndFunc)
   ElseIf ($TegErr="�������������") Then
	  ;��������� ������������ ������������
	  WinClose($hWndFunc)
	  $hWnd4 = WinWait("������������", "", 360)
	  If Not $hWnd4 Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���� ������� ��/��� (���������� ������������) �� ���������***********")
		 Return "2"
	  ElseIf Not WinActivate($hWnd4) Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���� ������� ��/��� (���������� ������������) �� �������***********")
		 Return "2"
	  Else
		 Send("{ENTER}")
		 Local $iPID = WinGetProcess($hWndFunc)
		 Sleep(10000)
		 If Not ProcessExists($iPID)=0 Then
			Return "2"
		 EndIf
		 Return "0"
	  EndIf
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���-�� ����� �� ���, ������ ���������� (1)***********")
	  Return "2"
   EndIf
EndFunc

Func KillPID($hWndFunc2)
   ; ������� ��� �������� 1�:������������
   $iPID = WinGetProcess($hWndFunc2)
   ProcessClose($iPID)
   ProcessWaitClose($iPID, 240)
   If ProcessExists($iPID) Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ����� ������� ������� ������� ���������� 1� : /" & $iPID & "/ ������� �� �������� �� �����-�� �������, �������� ��� �������, ������ ����������")
	  Return "2"
   EndIf
   Return "0"
EndFunc