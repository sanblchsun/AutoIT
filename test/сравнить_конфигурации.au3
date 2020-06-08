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
#Include <WindowsConstants.au3>

Opt("SendKeyDelay",100) ; enable delay 20 ms for Send
Opt("WinDetectHiddenText", 1) ; show hidden text
Opt("WinSearchChildren", 1) ; search for sub-windows
Opt("WinWaitDelay", 500) ; wait 500 ms after window commands
Opt("WinTitleMatchMode", 3)
Opt('PixelCoordMode', 1);!!!

Global $PathPlatform = "C:\Program Files (x86)\1cv8\8.3.5.1517\bin\1cv8.exe"
Global $PathBase = "C:\Users\Makosov_A\Desktop\test\TESTbase\base"
Global $LogFile = "C:\Users\Makosov_A\Desktop\test\TESTbase\log.txt"
Global $MsgLog = " /Out" & """" & $LogFile & """" & " -NoTruncate"
Global $V8Stor = "C:\Users\Makosov_A\Desktop\test\TESTbase\30_PROF"
Global $UpdFile = "\\builder-fat\1c\8.2\AccountingCorp\3.0.40.21\1Cv8.cf"
Global $ConfigName = "������������ - ����������� �����������, �������� 3.0"
Global $ConfigProfDo = "D:\work\3.0.40.20\1Cv8_����_��.cf"
Global $PatchReportProf = "C:\Users\Makosov_A\Desktop\Instrument\NoCat\����.txt"


If FileExists($LogFile) Then
   FileDelete ($LogFile)
   $hFile = FileOpen($LogFile, 1)
Else
   $hFile = FileOpen($LogFile, 2)
EndIf


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
   Call("LineLogFile",$LogFile, "������� � ���� � ������: " & "" & "�������� ������������" & "")
   _WinAPI_SetKeyboardLayout($hWnd,0x0419)
   Sleep(100)
   WinActivate($hWnd)
   Send("!�")
   Send("!a")
   Send("{RIGHT 2}{DOWN 9}{ENTER}")

   ;���� ���� "��������� ������������"
   $hWnd0 = WinWait("��������� ������������")

   ;��������� ������� �� ����� � ���� ������� ������ ����������� ����� ���� ����� ����
   If Not String(Call("CheckWindows",$hWnd0,0,175,0,33))=="3101733842" Then
	  Call("LineLogFile",$LogFile, "!!!***������. � ����: " & "" & "��������� ������������" & "" & " ����� �����, ������� ��")
	  Exit
   EndIf


   _WinAPI_SetKeyboardLayout($hWnd0,0x0409)
   Send("{TAB 2}")
   Send($ConfigProfDo)
   Send("{TAB 2}{ENTER}")

   ;���� � ����� ����������� ����
   While 1
	  Sleep(3000)
	  $iState = WinGetState($hWnd)
	  If BitAND($iState, 4) Then
		 ;'��������/'
		 ExitLoop
	  EndIf
   WEnd

   ; ��������� ����� ���� � ���������, ������ ���� "��������� �������� ������������ - ���� " & $ConfigProfDo"
   $text = WinGetText($hWnd)
   If StringInStr($text, "��������� �������� ������������ - ���� " & $ConfigProfDo)=0 Then
      Call("LineLogFile",$LogFile, "<<<!!!������, ��� ����: " & "" & "��������� �������� ������������ - ����" & "")
      Exit
   EndIf
   Call("LineLogFile",$LogFile, "�������� ����: " & "" & "��������� �������� ������������ - ����" & "")
   Send("{TAB 6}{ENTER}{DOWN 4}{ENTER}")
   Call("LineLogFile",$LogFile, "������� ����: " & "" & "����� ��������� ����������" & "")
   $hWnd1 = WinWait("����� ��������� ����������")
   Call("LineLogFile",$LogFile, "�������� ����: " & "" & "����� ��������� ����������" & "")

   If String(Call("CheckWindows",$hWnd1,20,40,300,55))="2889010289" Then
	  Call("LineLogFile",$LogFile, "����: " & "" & "����� ��������� ����������" & "" & " ������ �������� �� ����������� �����")
	  Send("{TAB 7}")
	  Send($PatchReportProf)
	  Send("{TAB}{ENTER}")
   Else
	  Call("LineLogFile",$LogFile, "!!!***������. ����: " & "" & "����� ��������� ����������" & "" & " �� ������ �������� �� ����������� �����")
	  Exit
   EndIf

   $hWnd2 = WinWait("[CLASS:V8Window]")

EndIf




FileClose($LogFile)


;---------------------------Func----------------------------------------------------------
;�������� ���� �� ����������� �����
Func CheckWindows($hWndFunc,$correctionLeft,$correctionTop,$correctionRight,$correctionBottom)
   ; ������ ���������, � ������� ������������ ����������
   $tRect = _WinAPI_GetWindowRect($hWndFunc)
   ;������� ����������
   $Left = DllStructGetData($tRect, "Left") + $correctionLeft
   $Top = DllStructGetData($tRect, "Top") + $correctionTop
   $Right = DllStructGetData($tRect, "Right") - $correctionRight
   $Bottom = DllStructGetData($tRect, "Bottom") - $correctionBottom
   ;���������� ����������� ����� ������� �������
   $checksum = PixelChecksum($Left, $Top, $Right-1, $Bottom-1)
   ;������ ���� �������� � ����
   $hForm = GUICreate('', $Right - $Left, $Bottom - $Top, $Left, $Top, $WS_POPUP, $WS_EX_TOPMOST)
   GUISetBkColor(0xFF00000)
   WinSetTrans($hForm, '', 150) ; ������������
   GUISetState()
   Sleep(2000)
   GUIDelete()
   ;��� �������
   ;ConsoleWrite($Left & '/' & $Top & '/' & $Right & '/' & $Bottom & @CRLF& _
   ;$checksum & @LF)

   Return $checksum
EndFunc


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