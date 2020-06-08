#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Run_AU3Check=n
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

Global $PathPlatform = "C:\Program Files (x86)\1cv8\8.3.6.2152\bin\1cv8.exe"
Global $iEventError
Global $HexNumber
Global $Status = False

; ��� ����� - ������������ �������_______________________________________________________________
If Not $CmdLine[0] Then

   $MyPID = @AutoItPID
   ;�������� ������� �������������� �������� ��������, ��� �� �������� ���������
   $aProcessList = ProcessList(@ScriptName)
   If $aProcessList[0][0]>1 Then
	  For $i = 1 To $aProcessList[0][0]
		 If $aProcessList[$i][1]<>$MyPID Then
			ProcessClose($aProcessList[$i][1])
		 EndIf
	  Next
   EndIf

   ;�������� ������� 1� ��������, ������� ��
   $aProcessList = ProcessList("1cv8.exe")
   If $aProcessList[0][0] Then
	  For $i = 1 To $aProcessList[0][0]
		 ProcessClose($aProcessList[$i][1])
	  Next
   EndIf

;~    Const $Run = @ScriptDir & '\CreateDT.exe'
   Dim $aWorkTemp[5][5] = [["������� ���������� PID","PID-��������","��� ������������","�������","������"],["-","","�-��","","-"],["-","","����","","-"],["-","","����","","-"],["-","","����","","-"]]

   For $i = 1 To UBound($aWorkTemp)-1
	  $aWorkTemp[$i][1] = Run('"' & @ScriptFullPath & '" /AutoIt3ExecuteScript "' & @ScriptFullPath & '" ' & '"' & $aWorkTemp[$i][2] & '"', '', @SW_HIDE, $STDIN_CHILD + $STDOUT_CHILD)
   Next

 While 1
	  Sleep(1000)
	  For $i = 1 To UBound($aWorkTemp)-1
		 If StringRight(StdoutRead($aWorkTemp[$i][1], True), 5)=="�����" Then
			ContinueLoop 2
		 EndIf
	  Next
	  For $i = 1 To UBound($aWorkTemp)-1
		 If	StringRight(StdoutRead($aWorkTemp[$i][1], False), 5)=="�����" Then
			StdinWrite($aWorkTemp[$i][1], "�����")
			ExitLoop
		 EndIf
	  Next
   WEnd
   Exit
EndIf

;��� ����� - �������� ��� ��������� ��������____________________________________________________________________
Global Const $TipConf = $CmdLine[1]

Switch $TipConf
Case "����"
   Global $ConfigName = "������������ - ����������� �����������, �������� 3.0"
   Global $LogFile = "C:\Accounting\log.txt"
   Global $PathIn = "C:\Accounting\in"
   Global $PathBaseDemo = "C:\������\basePROF\demo"
   Global $PathBaseEmpty = "C:\������\basePROF\empty"
   Global $MsgLog = " /Out" & """" & $LogFile & """" & " -NoTruncate"
   Global $PathDtOut = "C:\Accounting\out\DemoDB"
   Global $PosN2progres = 900
   Global $ObrStopMaket = "C:\EPF\MaketStop_����.epf"
   Global $ObrSetData = "C:\EPF\SetData_����.epf"
   Global $Obr_Hash_empty_User = "C:\EPF\Hash_empty_User_����.epf"
   Global $Login ="������� (��������)"
   Global $Name = "����������������������"
   Global $Synonym = "����������� �����������, �������� 3.0"
   Global $ShortInf = "����������� �����������, �������� 3.0"
   Global $LongInf = "����������� �����������, �������� 3.0"

Case "�-��"
   ;---------------------------------------------
   Global $ConfigName = "������������ - ����������� ����������� (�������), �������� 3.0"
   Global $LogFile = "C:\AccountingBase\log.txt"
   Global $PathIn = "C:\AccountingBase\in"
   Global $PathBaseDemo = "C:\������\baseBASE\demo"
   Global $PathBaseEmpty = "C:\������\baseBASE\empty"
   Global $MsgLog = " /Out" & """" & $LogFile & """" & " -NoTruncate"
   Global $PathDtOut = "C:\AccountingBase\out\DemoDB"
   Global $PosN2progres = 100
   Global $ObrStopMaket = "C:\EPF\MaketStop_�-��.epf"
   Global $ObrSetData = "C:\EPF\SetData_�-��.epf"
   Global $TempFile = @TempDir & '\AutoitB_Temp'
   Global $Obr_Hash_empty_User = "C:\EPF\Hash_empty_User_�-��.epf"
   Global $Login =""
   Global $Name = "�����������������������������"
   Global $Synonym = "����������� ����������� (�������), �������� 3.0"
   Global $ShortInf = "����������� ����������� (�������), �������� 3.0"
   Global $LongInf = "����������� ����������� (�������), �������� 3.0"
   Global $avArray[7] = ["����������������", "�������������������������", "�������������������", "�������������������������������", "���������������������������", "�������", "�����������"]

Case "����"
   ;---------------------------------------------
   Global $ConfigName = "������������ - ����������� ����������� (�������), �������� 3.0"
   Global $LogFile = "C:\AccountingPBOULBase\log.txt"
   Global $PathIn = "C:\AccountingPBOULBase\in"
   Global $PathBaseDemo = "C:\������\basePBOUL\demo"
   Global $PathBaseEmpty = "C:\������\basePBOUL\empty"
   Global $MsgLog = " /Out" & """" & $LogFile & """" & " -NoTruncate"
   Global $PathDtOut = "C:\AccountingPBOULBase\out\DemoDB"
   Global $PosN2progres = 500
   Global $ObrStopMaket = "C:\EPF\MaketStop_����.epf"
   Global $ObrSetData = "C:\EPF\SetData_����_��������_��_��.epf"
   Global $TempFile = @TempDir & '\AutoitPBUL_Temp'
   Global $Obr_Hash_empty_User = "C:\EPF\Hash_empty_User_����.epf"
   Global $Login =""
   Global $Name = "�����������������������������"
   Global $Synonym = "����������� ����������� (�������), �������� 3.0"
   Global $ShortInf = "����������� ����������� (�������), �������� 3.0"
   Global $LongInf = "����������� ����������� (�������), �������� 3.0"
   Global $avArray[7] = ["����������������", "�������������������������", "�������������������", "�������������������������������", "���������������������������", "�������", "�����������"]
Case "����"
   Global $ConfigName = "������������ - ����������� ����������� ����, �������� 3.0"
   Global $LogFile = "C:\AccountingCorp\log.txt"
   Global $PathIn = "C:\AccountingCorp\in"
   Global $PathBaseDemo = "C:\������\baseCORP\demo"
   Global $PathBaseEmpty = "C:\������\baseCORP\empty"
   Global $MsgLog = " /Out" & """" & $LogFile & """" & " -NoTruncate"
   Global $PathDtOut = "C:\AccountingCorp\out\DemoDB"
   Global $PosN2progres = 1300
   Global $ObrStopMaket = "C:\EPF\MaketStop_����.epf"
   Global $ObrSetData = "C:\EPF\SetData_����.epf"
   Global $Obr_Hash_empty_User = "C:\EPF\Hash_empty_User_����.epf"
   Global $Login ="������� (��������)"
   Global $Name = "��������������������������"
   Global $Synonym = "����������� ����������� ����, �������� 3.0"
   Global $ShortInf = "����������� ����������� ����, �������� 3.0"
   Global $LongInf = "����������� ����������� ����, �������� 3.0"
Case Else
   MsgBox(0,"������ ���������", "��������: " & $TipConf & " �� ������")
   Exit
EndSwitch



While 1
   $iEventError = 0
   $HexNumber = 0
   $Status = False
   $My1C=""
   $v8 = ""
   $Obr = ""
   $ResDT = False
   $ResCF = False

   Call("LineLogFile",$LogFile, "" & @CRLF & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & "| ������ �����: " & @CRLF & $PathIn & "\1cv8.cf" & @CRLF & $PathIn & "\1Cv8.dt")

   ProgressOn("�������� �������� ������� ������ 10 ���", $TipConf, "0 ���������", $PosN2progres, 850)

   While 1
	  If Not $ResDT Then
		 If FileMove($PathIn & "\1Cv8.dt", $PathIn & "\1Cv8.dt" , 1) Then $ResDT = True
	  EndIf

	  If Not $ResCF Then
		 If FileMove($PathIn & "\*.cf", $PathIn & "\1Cv8.cf" , 1) Then $ResCF = True
	  EndIf

	  If $ResDT And $ResCF Then ExitLoop
	  Sleep(10000)
   WEnd

	; ������� ��� �������� LOG - ����
	If FileExists($LogFile) Then
		FileDelete ($LogFile)
		$hFile = FileOpen($LogFile, 1)
	Else
		$hFile = FileOpen($LogFile, 2)
	EndIf

	ProgressOn("������������ ��������� " & $TipConf, $TipConf, "0 ���������", $PosN2progres, 850)

   DirRemove($PathBaseEmpty, 1)
   If FileExists($PathBaseEmpty) Then
	  Call("LineLogFile",$LogFile, "������� ����: " & $PathBaseEmpty & " ����������. ������ ����������")
	  ProgressOff()
	  ContinueLoop
   Else
	  If DirCreate($PathBaseEmpty) = 0 Then
		  Call("LineLogFile",$LogFile, "������� ����: " & $PathBaseEmpty & " ��������. ������ ����������")
		 ProgressOff()
		 ContinueLoop
	  EndIf
   EndIf

   DirRemove($PathBaseDemo, 1)
   If FileExists($PathBaseDemo) Then
	  Call("LineLogFile",$LogFile, "������� ����: " & $PathBaseDemo & " ����������. ������ ����������")
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   Else
	  If DirCreate($PathBaseDemo) = 0 Then
		  Call("LineLogFile",$LogFile, "������� ����: " & $PathBaseDemo & " ��������. ������ ����������")
		  Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	  EndIf
   EndIf

   DirRemove($PathDtOut, 1)
   If FileExists($PathDtOut) Then
	  Call("LineLogFile",$LogFile, "������� ����: " & $PathDtOut & " ����������. ������ ����������")
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   Else
	  If DirCreate($PathDtOut) = 0 Then
		  Call("LineLogFile",$LogFile, "������� ����: " & $PathDtOut & " ��������. ������ ����������")
		  Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	  EndIf
   EndIf


	Call("LineLogFile",$LogFile, "" & @CRLF & "		������ ����")

	ProgressSet (10, "�������� ������ ���� ��� ����")
	;////-----------------������: �������� ������ ����--------------------------------------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ �������� ������ ����")

	FileClose ($hFile )

	If Not RunWait($PathPlatform & " CREATEINFOBASE File=" & $PathBaseDemo & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! � ��������: " & $PathBaseDemo & " ��������� ����. ������ ����������")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)


	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� �������� ������ ����")

	ProgressSet (15, "�������� �� �� �����")
	;////-----------------������: ��������� �� �� �����--------------------------------------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ ��������� �� �� �����")

	FileClose ($hFile )
	If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseDemo & """" & " /restoreib" & """" & $PathIn & "\1Cv8.dt" & """" & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!!� ����: " & $PathBaseDemo & " �� �������� ���� �� " & "" & $PathIn & "\1Cv8.dt" & "" &  ". ������ ����������")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� �������� �� �� �����")

	ProgressSet (20, "��� ����������")
	;////-----������: ����� ������������ � ���������----------------------------------
   ConsoleWrite("�����")
   Call("ConsoleWriteRead")
   ConsoleWrite("�����")

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ ����� ������������ � ���������")

	ProgressSet (25, "������ ������������ � ���������")
	FileClose ($hFile )
   $MyPID1 = Run("""" & $PathPlatform & """" & " DESIGNER /F " & """" & $PathBaseDemo & """" & " /N" & """" & $Login & """")
	If Not $MyPID1 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!!�������� ���� � ���������: " & "" & $PathPlatform & "" &  ". ������ ����������")
		 Call("DelPathIn")
		 ProgressOff()
		 ProcessClose ($MyPID1)
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)

	If Call("OnEdit") Then
	  Call("DelPathIn")
	  ProgressOff()
	  ConsoleWrite("�����")
	  ContinueLoop
	EndIf


	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� ����� ������������ � ���������")
	FileClose ($hFile )
   ConsoleWrite("�����")

	ProgressSet (30, "�������� ���� ������������ � ����-����")
	;////-----������: ��������� ���� ������������----------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ ��������� ���� ������������")

	FileClose ($hFile )
   ;����� 3 ������� ��������� ���� ������������
   For $i=1 To 3
	  Sleep(3000)
	  If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseDemo & """" & "/N" & """" & $Login & """" & " /LoadCfg" & """" & $PathIn & "\1cv8.cf" & """" & $MsgLog) = 0 Then
		 If $i==3 Then
			$hFile = FileOpen($LogFile, 1)
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! � ����: " & $PathBaseDemo & " �� �������� ���� ������������ " & "" & $PathIn & "\1cv8.cf" & "" &  ". ������ ����������")
			Call("DelPathIn")
			ProgressOff()
			ContinueLoop
		 EndIf
	  Else
		 ExitLoop
	  EndIf
   Next
	$hFile = FileOpen($LogFile, 1)


	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� ��������� ���� ������������")

	ProgressSet (35, "��� ����������")
	;////-----������: ����� ������������ � ���������----------------------------------
   ConsoleWrite("�����")
   Call("ConsoleWriteRead")
   ConsoleWrite("�����")

   If $TipConf = "�-��" Then

	  Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ ����� ������������ � ��������� � ��������� ������������ ���� �� �������")

   ElseIf $TipConf = "����" Then

	  Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ ����� ������������ � ��������� � ��������� ������������ ���� �� ���������������")

   Else
	  Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ ����� ������������ � ���������")
   EndIf

   If $TipConf = "�-��" Then
	  ProgressSet (40, "������ � ��������� � ����� �� ���� ������� ")
   ElseIf $TipConf = "����" Then
	  ProgressSet (40, "������ � ��������� � ����� �� ���� ��������������� ")
   Else
	  ProgressSet (40, "������ ������������ � ��������� - ���")
   EndIf

	FileClose ($hFile )
   $MyPID2 = Run("""" & $PathPlatform & """" & " DESIGNER /F " & """" & $PathBaseDemo & """" & " /N" & """" & $Login & """")
   $hFile = FileOpen($LogFile, 1)
   If Not $MyPID2 Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!!�������� ���� � ���������: " & "" & $PathPlatform & "" &  ". ������ ����������")
	  Call("DelPathIn")
	  ProgressOff()
	  ProcessClose ($MyPID2)
	  ContinueLoop
   EndIf

   $Status = True
   If Call("DeleteSupport") Then
	  Call("DelPathIn")
	  ProgressOff()
	  ConsoleWrite("�����")
	  ContinueLoop
   EndIf

   If $TipConf = "�-��" Then
	  Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� ����� ������������ � ��������� � ��������� ������������ ���� �� �������")
   ElseIf $TipConf = "����" Then
	  Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� ����� ������������ � ��������� � ��������� ������������ ���� �� ����")
   Else
	  Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� ����� ������������ � ���������")
   EndIf

   ConsoleWrite("�����")

	ProgressSet (45, "�������� ��")
	;////-----������: �������� ��------------------------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ �������� ��")

	FileClose ($hFile )
	If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseDemo & """" & "/N" & """" & $Login & """" & " /UpdateDBCfg /N" & """" & $Login & """" & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! �� �� ���������� " & "" & $PathBaseDemo & "" &  ". ������ ����������")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)


	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� �������� ��")

   ProgressSet (47, "�������� ����� ������������")
;////-----������: �������� �� ��� ������� � �.�.________________________
   Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ �������� ����� ������������")

   $oMyError = ObjEvent("AutoIt.Error", "ErrFunc") ; ��������� ����������� ������
   $My1C = ObjCreate("V83.COMConnector")

   If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! �� ������ ObjCreate. ������: " & $HexNumber)
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   EndIf
   Call("LineLogFile",$LogFile, "������ COM - ������")
   $v8 = ""

   For $i=0 To 3
	  $v8 = $My1C.Connect("File=" & $PathBaseDemo & "; Usr =" & """" & $Login & """" & ";Pwd="""";")
	  If $iEventError Then
		 Call("LineLogFile",$LogFile, "     �� �������� Connect1. ������: " & $HexNumber & " ������� �: " & $i)
		 If $i=3 Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! �� �������� Connect1. ������: " & $HexNumber)
			Call("DelPathIn")
			ProgressOff()
			ContinueLoop 2
		 EndIf
	  Else
		 ExitLoop
	  EndIf
	  Sleep(3000)
   Next

   Call("LineLogFile",$LogFile, "������� COM - ���������� � �����")

   $oResalt = $v8.Metadata.Name()
   $oResalt1 = $v8.Metadata.Synonym()
   $oResalt2 = $v8.Metadata.BriefInformation()
   $oResalt3 = $v8.Metadata.DetailedInformation()
   If $oResalt<>$Name Or _
	  $oResalt1<>$Synonym Or _
	  $oResalt2<>$ShortInf Or _
	  $oResalt3<>$LongInf Then

	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������ � ����� ��: " & @CRLF & $oResalt& @CRLF & $oResalt1& @CRLF & $oResalt2& @CRLF & $oResalt3)
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   Else
	  Call("LineLogFile",$LogFile, "			" & $oResalt & @CRLF & "			" & $oResalt1& @CRLF & _
			   "			" & $oResalt2& @CRLF & "			" & $oResalt3)
   EndIf

   Call("LineLogFile",$LogFile, "�������� ����� ������� �� ������������")

   Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� �������� ����� ������������")


	ProgressSet (50, "�������� ������������ � ����")
;////-----������: �������� ������� � ������������ ��������, ��� ������� � ����----------------------------------
   If $TipConf = "�-��" Or $TipConf = "����" Then

	  Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ �������� ������� � ������������ ��������")
	  ProgressSet (48, "�������� ������������ � ����")

	  If FileExists($PathBaseDemo & "_Distr") Then
		 If DirRemove($PathBaseDemo & "_Distr",1)=0 Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! �������: " & $PathBaseDemo & "_Distr" & " ����������, �� ����� ��� �������� ������� � ������������ ��������")
			Call("DelPathIn")
			ProgressOff()
			ContinueLoop
		 EndIf
	  EndIf

	  DirCopy ( $PathBaseDemo, $PathBaseDemo & "_Distr" ,1 )

	  ;����������� ��������� ������� ��� �������� �������
	  If FileExists($TempFile) Then
		 If Not DirRemove ($TempFile, 1) Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ������ �������� ���������� �������� ����� ��������� ������� : " & $TempFile & " " &  ". ������ ����������")
			Call("DelPathIn")
			ProgressOff()
			ContinueLoop
		 EndIf
	  EndIf
	  If Not DirCreate ($TempFile) Then
		 MsgBox(0,"","������ ��� �������� ���������� ��������")
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ������ ��� �������� ���������� �������� ��� �������� �������: " & $TempFile & " " &  ". ������ ����������")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	  EndIf

	  $qqq111 = """" & $PathPlatform & """" & " DESIGNER /F " & """" & $PathBaseDemo & "_Distr" & """" & " /CreateDistributionFiles -cffile " & """" & $PathIn & "\1Cv8_distr.cf"" /N" & """" & $Login & """"
	  FileClose ($hFile )
	  $MyPID3 = RunWait($qqq111 & $MsgLog)
	  $hFile = FileOpen($LogFile, 1)
	  If $MyPID3 Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������������: " & $PathIn & "\1Cv8_distr.cf")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	  EndIf

	  Call("LineLogFile",$LogFile, "������ ���� �: " & $PathIn & "\1Cv8_distr.cf")

	  ;��������� ���� ������������----------------------------------
	  FileClose ($hFile )
	  $MyPID4 = RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseDemo & "_Distr" & """" & "/N" & """" & $Login & """" & " /LoadCfg" & """" & $PathIn & "\1Cv8_distr.cf" & """" & $MsgLog)
	  $hFile = FileOpen($LogFile, 1)
	  If $MyPID4 Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ��������: " & $PathIn & "\1Cv8_distr.cf")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	  EndIf

	  Call("LineLogFile",$LogFile, "�������� ���� : " & $PathIn & "\1Cv8_distr.cf" & " � ����: " & $PathBaseDemo & "_Distr")

	  ;��������� ������ ��������----------------------------------
	  $qqq222 = """" & $PathPlatform & """" & " DESIGNER /F " & """" & $PathBaseDemo & "_Distr" & """" & " /N" & """" & $Login & """" & "/DumpConfigFiles " & """" & $TempFile & """" & " -Module"
	  $MyPID5 = RunWait("" & $qqq222 & "")
	  If $MyPID5 Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� �������� ������� �: " & $TempFile)
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	  EndIf

	  Call("LineLogFile",$LogFile, "��������� ������ � �������: " & $TempFile)

	  ;��� � ���� �������� ������� ��������----------------------------------
	  If $TipConf = "�-��" Then
		 If FileExists($TempFile & "\�����������.����������������.������.txt") Or _
			   FileExists($TempFile & "\�����������.�������������������������.������.txt") Or _
			   FileExists($TempFile & "\�����������.�������������������.������.txt") Or _
			   FileExists($TempFile & "\�����������.�������������������������������.������.txt") Or _
			   FileExists($TempFile & "\�����������.���������������������������.������.txt") Or _
			   FileExists($TempFile & "\�����������.�������.������.txt") Or _
			   FileExists($TempFile & "\�����������.�������.�����������") Then

			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ������ ������� ������� ������������ �� ���������, ������ �: " & $TempFile)
			Call("DelPathIn")
			ProgressOff()
			ContinueLoop
		 EndIf

		 Call("LineLogFile",$LogFile, "� ��������: " & $TempFile & " ��� ������:" & @CRLF &  _
						"		�����������.����������������.������.txt" & @CRLF & _
						"		�����������.�������������������������.������.txt" & @CRLF & _
						"		�����������.�������������������.������.txt" & @CRLF & _
						"		�����������.�������������������������������.������.txt" & @CRLF & _
						"		�����������.���������������������������.������.txt" & @CRLF & _
						"		�����������.�������.������.txt"  & @CRLF & _
						"		�����������.�����������.������.txt"  & @CRLF & _
						"������������� � ���� ������� ����� ��������")
		 Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� �������� ������� � ������������ ��������, ��� �������")
	  ElseIf $TipConf = "����" Then
		 If FileExists($TempFile & "\�����������.����������������.������.txt") Or _
			   FileExists($TempFile & "\�����������.�������������������������.������.txt") Or _
			   FileExists($TempFile & "\�����������.�������������������.������.txt") Or _
			   FileExists($TempFile & "\�����������.�������������������������������.������.txt") Or _
			   FileExists($TempFile & "\�����������.���������������������������.������.txt") Or _
			   FileExists($TempFile & "\�����������.�������.������.txt") Or _
			   FileExists($TempFile & "\�����������.�������.�����������") Then

			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ������ ������� ������� ������������ �� ���������, ������ �: " & $TempFile)
			Call("DelPathIn")
			ProgressOff()
			ContinueLoop
		 EndIf

		 Call("LineLogFile",$LogFile, "� ��������: " & $TempFile & " ��� ������:" & @CRLF &  _
						"		�����������.����������������.������.txt" & @CRLF & _
						"		�����������.�������������������������.������.txt" & @CRLF & _
						"		�����������.�������������������.������.txt" & @CRLF & _
						"		�����������.�������������������������������.������.txt" & @CRLF & _
						"		�����������.���������������������������.������.txt" & @CRLF & _
						"		�����������.�������.������.txt"  & @CRLF & _
						"		�����������.�����������.������.txt"  & @CRLF & _
						"������������� � ���� ������� ����� ��������")
		 Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� �������� ������� � ������������ ��������, ��� ����")
	  Else
		 Call("LineLogFile",$LogFile, "!!!***������ ����������� ���� ������������ ���� ��� �-��")
	  EndIf

   EndIf

	;////-----������: ��������� ������������ � ����------------------------------------------------
	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ ��������� ������������ � ����")

	FileClose ($hFile )
	If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseDemo & """" & "/N" & """" & $login & """" & " /DumpCfg" & """" & $PathIn & "\1cv8.cf" & "_" & """" & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! � ����: " & $PathBaseDemo & " �� �������� ���� ������������ " & "" & $PathIn & "\1cv8.cf" & "" &  ". ������ ����������")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� ��������� ������������ � ����")

	ProgressSet (55, "�������� ��������� MaketStop 3_0.epf (COM)")

	;////-----������: ��������� ��������� MaketStop 3_0.epf (COM)------------------------------------------------
	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ ��������� ��������� MaketStop 3_0.epf")

	$Obr = $v8.ExternalDataProcessors.Create($ObrStopMaket,False)
	$iEventError = 0

	If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! �� ������ ������ - ������� ���������. ������: " & $HexNumber)
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	 EndIf
   Call("LineLogFile",$LogFile, "������ COM - ������� ���������")

	FileClose ($hFile )
	Sleep(1000)
	$Resalt = $Obr.Test()
	$hFile = FileOpen($LogFile, 1)
   If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ������ ���������� ��������� ���������. ������: " & $HexNumber)
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   EndIf

	If $Resalt = "�������" Then
		Call("LineLogFile",$LogFile, " ���������� ������������ ����������, ��������: " & $Resalt)
	Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>��������!!!�������� ������������ ����������: " & $Resalt)
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   EndIf

   $Obr =""
   $Resalt = ""
   $v8 = ""
   $iEventError = 0

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� ��������� ��������� MaketStop 3_0.epf")
#cs
	;////-----������: ��������� ��������� Hash_empty_User_?.epf (COM)------------------------------------------------
	ProgressSet (57, "�������� ��������� Hash_empty_User_?.epf (COM)")

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ ��������� ��������� Hash_empty_User_?.epf")

  $Obr = $v8.ExternalDataProcessors.Create($Obr_Hash_empty_User,False)

	If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! �� ������ ������ ���������. ������: " & $HexNumber)
	  Exit
	  EndIf
	  Call("LineLogFile",$LogFile, "������ ������ ���������")
   Call("LineLogFile",$LogFile, "������ COM - ������� ���������")



	$Resalt = $Obr.�������������������������()
   If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ������ ���������� ��������� ���������. ������: " & $HexNumber)
	  Exit
   EndIf

   $Resalt = StringReplace($Resalt, "   ", @CRLF)
   Call("LineLogFile",$LogFile, $Resalt)


   $Obr =""
   $v8 = ""

   $iEventError = 0

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� Hash_empty_User_����.epf")
#ce
	ProgressSet (60, "�������� 1Cv8.dt")

	;-----������:  �������� 1Cv8.dt------------------------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ �������� 1Cv8.dt ����")

	FileClose ($hFile )
	If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseDemo & """" & "/N" & """" & $Login & """" & " /DumpIB" & """" & $PathDtOut & "\1Cv8.dt" & """" & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! � ����: " & $PathBaseDemo & " �� �������� ���� ������������ " & "" & $PathDtOut & "\1Cv8.dt" & "" &  ". ������ ����������")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� �������� 1Cv8.dt ����")

	ProgressSet (65, "������ ������ ���� ��� NEW - ����")

	;////-----------------������: �������� ������ ���� -------------------------------------
	Call("LineLogFile",$LogFile, "" & @CRLF & "		������ ����")

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ �������� ������ ����")

	FileClose ($hFile )

	If Not RunWait($PathPlatform & " CREATEINFOBASE File=" & $PathBaseEmpty & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! � ��������: " & $PathBaseEmpty & " ��������� ����. ������ ����������")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� �������� ������ ����")
	ProgressSet (70, "�������� ���� ������������ � NEW-����")

	;//-----������: ��������� ���� ������������ ----------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ ��������� ���� ������������ � ������ ����")

	FileClose ($hFile )
	If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseEmpty & """" & "/N"""" /LoadCfg" & """" & $PathIn & "\1cv8.cf" & "_" & """" & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! � ����: " & $PathBaseEmpty & " �� �������� ���� ������������ " & "" & $PathIn & "\1cv8.cf" & "_" & "" &  ". ������ ����������")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� ��������� ���� ������������ � ������ ����")

	ProgressSet (75, "�������� ��")

	;//-----������: �������� �� ----------------------------------
	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ �������� ��")

	FileClose ($hFile )
	If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseEmpty & """" & "/N"""" /UpdateDBCfg /N"""""& $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! �� �� ���������� " & "" & $PathBaseEmpty & "" &  ". ������ ����������")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)


	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� �������� ��")

	ProgressSet (80, "�������� ������� SetData 1�:�����������")

	;//-----������: ������ ������ 1�:����������� � ���������� ������� SetData 1�:�����������  ----------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ ������ ������ 1�:����������� � ���������� ������� SetData 1�:�����������")

   $v8 = ""
   $v8 = $My1C.Connect("File="& $PathBaseEmpty &"; Usr ="""";Pwd="""";")

   If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! �� �������� Connect2. ������: " & $HexNumber)
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   EndIf
   Call("LineLogFile",$LogFile, "������ COM - ���������� � �����")

	$Obr = $v8.ExternalDataProcessors.Create($ObrSetData,False)

	If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! �� ������ ������ ���������. ������: " & $HexNumber)
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	  EndIf

   Call("LineLogFile",$LogFile, "������ COM - ������� ���������")

	ProgressSet (85, "�������� ������� SetData 1�:�����������")

	FileClose ($hFile )
	$Resalt = $Obr.Run()
	$hFile = FileOpen($LogFile, 1)
   If $iEventError Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ������ ���������� ��������� ���������. ������: " & $HexNumber)
	  Call("DelPathIn")
	  ProgressOff()
	  ContinueLoop
   EndIf
	If $Resalt = "�������" Then
		Call("LineLogFile",$LogFile, " ���������� ������������ ����������, ��������: " & $Resalt)
	Else
		Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!!�������� ������������ ����������: " & $Resalt)
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf

   $Obr =""
   $v8 = ""

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� ������ ������ 1�:����������� � ���������� ������� SetData 1�:�����������")

	ProgressSet (95, "�������� 1Cv8new.dt")

	;-----������:  �������� 1Cv8new.dt------------------------------------------------

	Call("LineLogFile",$LogFile, "|--------------------------------------------------|" & @CRLF & _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ������ �������� 1Cv8new.dt ����")

	FileClose ($hFile )
	If Not RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBaseEmpty & """" & "/N"""" /DumpIB" & """" & $PathDtOut & "\1Cv8new.dt" & """" & $MsgLog) = 0 Then
		$hFile = FileOpen($LogFile, 1)
		Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! �� �������� ���� �� " & "" & $PathDtOut & "" &  ". ������ ����������")
		 Call("DelPathIn")
		 ProgressOff()
		 ContinueLoop
	EndIf
	$hFile = FileOpen($LogFile, 1)

	Call("LineLogFile",$LogFile, _Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & " ����� �������� 1Cv8new.dt ����")

	ProgressSet (100, "100 %")



	ProgressOff() ; ������� ���� ���������

   Call("DelPathIn")
 WEnd

; ------------------------------������� ���� ���������
Func DelPathIn()
	If DirRemove($PathIn, 1) = 0 Then
		Call("LineLogFile",$LogFile, "������� ����: " & $PathIn & " ����������. ������ ����������")
		Exit
	 EndIf
	If DirCreate($PathIn) = 0 Then
	  Sleep(3000)
	   If DirCreate($PathIn) = 0 Then
		 Call("LineLogFile",$LogFile, "������� ����: " & $PathIn & " ��������. ������ ����������")
		 Exit
	  EndIf
	EndIf
	FileClose ($hFile )
EndFunc

Func ErrFunc()
    $HexNumber = Hex($oMyError.number, 8)
   $iEventError = ">>>>>>>>>>������!!! COM  ! �����: " & $HexNumber

EndFunc   ;==>ErrFunc


Func OnEdit()

   BlockInput(1) ; ��������� ���������� � ����
   Send("{CapsLock off}") ;��������� CapsLock
   ;������� ���������� � ������������
   ;�������� ������� ��������� ���� �������������, ����� ���������� ���, � ������ ������ ����� � �������.
   $hWnd = WinWait($ConfigName, "", 1200) ; ��� �������� (30) �������� ����������
   If Not $hWnd Then
	  ;��������� ������������
	  IF Call("CloseConfig", $hWnd, "���������") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������")
	  EndIf
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ������� ����� �������� ���� �������������, 20 �����, ������ �����������")
	  BlockInput(0) ; �������� ���������� � ����
	  Return 1
   Else
		If Call("OnEditNext", $hWnd) Then Return 1
   EndIf
EndFunc

Func OnEditNext($hWndFunc)

	;������ � ���-����
   Call("LineLogFile",$LogFile, "���� ������������� �������, ���������� ��� � ��������� ���� ��������� � ���������")

   If WinActivate($hWndFunc) Then
	  WinMove($hWndFunc, "", 10, 10, 800, 600)
   Else
	  ;������ � ���-����
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���� ������������� �� �������, ��������� ������ �������***********")
	  If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������***********")
	  EndIf
	  Return 1
   EndIf

   ;���� ���� ������ ���������� �� �������, ������� ���
   $hWndV8Grid = WinWait("[CLASS:V8Grid]", "", 3)
   If Not $hWndV8Grid Then
	  _WinAPI_SetKeyboardLayout($hWndFunc,0x0419)
	  Sleep(100)
	  Send("!�")
	  Send("!a")
	  Send("{RIGHT 2}{ENTER}")
   EndIf

   WinWait("[CLASS:V8Grid]", "", 20)
   WinActivate($hWndFunc)
   ; ������� � ���� ��������� � ���������
   _WinAPI_SetKeyboardLayout($hWndFunc,0x0419)
   Sleep(100)
   Send("!�")
   Send("!a")
   Send("{RIGHT 2}{DOWN 6}{RIGHT}{DOWN}{ENTER}")

   $hWnd1 = WinWait("��������� ���������", "", 50)
   Call("LineLogFile",$LogFile, "�������� � ���� ��������� ��������� �������� �� ������ � ��������� ������������ ")

;---------------------�������� �������� �� ��������� ���������� �� ����������� ����� ����������� � ���� "��������� ���������"
   Sleep(2000)
   If WinActivate($hWnd1) Then
	  WinMove($hWnd1, "", 800, 10, 800, 600)
	  Local $StrKod = String(Call("CheckWindows",$hWnd1,7,30,400,550))
	  Switch $StrKod
	  Case "3862447798"
		 Send("{ESC}")
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>��������!!! ������������ �� ������ �� ��������� - ��� �������������. ��������� ������������ - ���������� ������")
		 ;��������� ������������
		 IF Call("CloseConfig", $hWndFunc, "���������") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*********")
		 EndIf
		 Return 1
	  Case "3919286857"
		 Send("{ENTER}")
	  Case "3822077678"
		 Send("{ESC}")
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>��������!!! ������������ ��� ����� ���������� ���������, �� ����� �� ��������� - ��� �������������. ��������� ������������ - ���������� ������")
		 ;��������� ������������
		 IF Call("CloseConfig", $hWndFunc, "���������") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*********")
		 EndIf
		 Return 1
	  Case Else
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���������� ������� ����� �� ������������ �� ��������� (" & $StrKod & ")  , ���������� ������****")
		 If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*****")
		 EndIf
		 Return 1
	  EndSwitch
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! �������� �������� �� ���������� ���������� ���� ��������� ��������� �� �������, ���������� ������****")
	  If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*****")
	  EndIf
	  Return 1
   EndIf

   ;���� ���������� ���� �� ���
   $hWnd2 = WinWait("������������", "", 30)
   If Not $hWnd2 Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���� ������� ��/��� �� ���������, ��������� ������������ � ���������� ������***")
	  If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������****")
	  EndIf
	  Return 1
   EndIf

   If WinActivate($hWnd2) Then
	  Send("{ENTER}")
   EndIf

   $hWnd3 = WinWait("��������� ������ ���������", "", 30)
   If Not WinActivate($hWnd3) Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���� ��������� ������ ��������� �� ���������, ��������� ������������ � ���������� ������**")
	  If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*****")
	  EndIf
	  Return 1
   EndIf


   Send("{DOWN 2}{TAB}{DOWN 2}{TAB}{ENTER}")
   Sleep(2000)
   Local $aPos = WinGetPos($hWnd1)
   ; �������� ����������
   WinMove($hWnd1, "", 10, 10)
   ; ���������� � ������������� ������� ���� � �������������� ���������.
   WinMove($hWnd1, "", $aPos[0], $aPos[1], $aPos[2], $aPos[3])
   ; --------------------�������� ����������� ���������----------------------------------
   ; --------������� ���� ��������� ���������----------------------
   If WinActivate($hWnd1) Then
	  Send("{ESC}")
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���� ��������� ��������� �� �������, ��������� ������������ � ���������� ������**")
	  If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*****")
	  EndIf
	  Return 1
   EndIf

   Call("LineLogFile",$LogFile, "� ������������ �������� ����������� ���������. ��������� ������������")
   ;��������� ������������
   IF Call("CloseConfig", $hWndFunc, "�������������") = "2" Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������, ����� �������� ����������*")
	  Return 1
   EndIf

   BlockInput(0) ; �������� ���������� � ����

EndFunc


Func DeleteSupport()

   BlockInput(1) ; ��������� ���������� � ����
   Send("{CapsLock off}") ;��������� CapsLock
   ;������� ���������� � ������������
   ;�������� ������� ��������� ���� �������������, ����� ���������� ���, � ������ ������ ����� � �������.
   $hWnd = WinWait($ConfigName, "", 1200) ; ��� �������� (30) �������� ����������
   If Not $hWnd Then
	  ;��������� ������������
	  IF Call("CloseConfig", $hWnd, "���������") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������")
	  EndIf
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ������� ����� �������� ���� �������������, 20 �����, ������ �����������")
	  BlockInput(0) ; �������� ���������� � ����
	  Return 1
   Else
		If Call("DeleteSupportNext", $hWnd) Then Return 1
   EndIf
EndFunc

Func DeleteSupportNext($hWndFunc)

		;������ � ���-����
   Call("LineLogFile",$LogFile, "���� ������������� �������, ���������� ��� � ��������� ���� ��������� � ���������")

   If WinActivate($hWndFunc) Then
	  WinMove($hWndFunc, "", 10, 10, 800, 600)
   Else
	  ;������ � ���-����
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���� ������������� �� �������, ��������� ������ �������***********")
	  If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������***********")
	  EndIf
	  Return 1
   EndIf

   ;���� ���� ������ ���������� �� �������, ������� ���
   $hWndV8Grid = WinWait("[CLASS:V8Grid]", "", 3)
   If Not $hWndV8Grid Then
	  _WinAPI_SetKeyboardLayout($hWndFunc,0x0419)
	  Sleep(100)
	  Send("!�")
	  Send("!a")
	  Send("{RIGHT 2}{ENTER}")
   EndIf

   WinWait("[CLASS:V8Grid]", "", 20)
   WinActivate($hWndFunc)
   ; ������� � ���� ��������� � ���������
   _WinAPI_SetKeyboardLayout($hWndFunc,0x0419)
   Sleep(100)
   Send("!�")
   Send("!a")
   Send("{RIGHT 2}{DOWN 6}{RIGHT}{DOWN}{ENTER}")

   $hWnd1 = WinWait("��������� ���������", "", 50)
   Call("LineLogFile",$LogFile, "�������� � ���� ��������� ��������� �������� �� ������ � ��������� ������������ ")
  ;---------------------�������� �������� �� ��������� ���������� �� ����������� ����� ����������� � ���� "��������� ���������"
   Sleep(2000)
   If WinActivate($hWnd1) Then
	  WinMove($hWnd1, "", 800, 10, 800, 600)
	  Local $StrKod = String(Call("CheckWindows",$hWnd1,7,30,400,550))
	  Switch $StrKod
	  Case "3862447798"
		 Send("{ESC}")
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>��������!!! ������������ �� ������ �� ��������� - ��� �������������. ��������� ������������ - ���������� ������")
		 ;��������� ������������
		 IF Call("CloseConfig", $hWndFunc, "���������") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*********")
		 EndIf
		 Return 1
	  Case "3919286857"
		 Send("{ENTER}")
	  Case "3822077678"
		 Send("{ESC}")
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>��������!!! ������������ ��� ����� ���������� ���������, �� ����� �� ��������� - ��� �������������. ��������� ������������ - ���������� ������")
		 ;��������� ������������
		 IF Call("CloseConfig", $hWndFunc, "���������") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*********")
		 EndIf
		 Return 1
	  Case Else
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���������� ������� ����� �� ������������ �� ��������� (" & $StrKod & ")  , ���������� ������****")
		 If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*****")
		 EndIf
		 Return 1
	  EndSwitch
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! �������� �������� �� ���������� ���������� ���� ��������� ��������� �� �������, ���������� ������****")
	  If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*****")
	  EndIf
	  Return 1
   EndIf

   ;���� ���������� ���� �� ���
   $hWnd2 = WinWait("������������", "", 30)
   If Not $hWnd2 Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���� ������� ��/��� �� ���������, ��������� ������������ � ���������� ������***")
	  If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������****")
	  EndIf
	  Return 1
   EndIf

   If WinActivate($hWnd2) Then
	  Send("{ENTER}")
   EndIf

   $hWnd3 = WinWait("��������� ������ ���������", "", 30)
   If Not WinActivate($hWnd3) Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���� ��������� ������ ��������� �� ���������, ��������� ������������ � ���������� ������**")
	  If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*****")
	  EndIf
	  Return 1
   EndIf


   Send("{DOWN 2}{TAB}{DOWN 2}{TAB}{ENTER}")
   Sleep(2000)
   Local $aPos = WinGetPos($hWnd1)
   ; �������� ����������
   WinMove($hWnd1, "", 10, 10)
   ; ���������� � ������������� ������� ���� � �������������� ���������.
   WinMove($hWnd1, "", $aPos[0], $aPos[1], $aPos[2], $aPos[3])
   ; --------------------�������� ����������� ���������----------------------------------
   ; --------------------������� � ���������----------------------------------
   Send("{TAB 3}{ENTER}")
   $hWnd2 = WinWait("������������", "", 1200)
   If Not $hWnd2 Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���� ������� ��/��� �� ���������, ��������� ������������ � ���������� ������****")
		 If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*****")
		 EndIf
	  Return 1
   EndIf
   If WinActivate($hWnd2) Then
	  Send("{ENTER}")
   EndIf
; -----------------------����� � ���������-------------------------------------------


;---------------------�������� �������� �� ��������� ���������� �� ����������� ����� �����������
   Sleep(2000)
   If WinActivate($hWnd1) Then
	  Local $StrKod = String(Call("CheckWindows",$hWnd1,7,30,400,550))
	  Switch $StrKod
	  Case "3862447798"
		 Call("LineLogFile",$LogFile, "������������ ����� � ���������")
	  Case "3919286857"
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! �������� �������� ������������ �������� �� ���������, ���������� ������****")
		 If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*****")
		 EndIf
		 Return 1
	  Case "3822077678"
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! �������� �������� ������������ �������� �� ��������� � ������������ ����������, ���������� ������****")
		 If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*****")
		 EndIf
		 Return 1
	  Case Else
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���������� ������� ����� �� ������������ �� ��������� (" & $StrKod & ")  , ���������� ������****")
		 If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*****")
		 EndIf
		 Return 1
	  EndSwitch
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! �������� �������� �� ���������� ���������� ���� ��������� ��������� �� �������, ���������� ������****")
	  If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*****")
	  EndIf
	  Return 1
   EndIf

   ; --------������� ���� ��������� ���������----------------------
   If WinActivate($hWnd1) Then
	  Send("{ESC}")
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���� ��������� ��������� �� �������, ��������� ������������ � ���������� ������**")
	  If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������*****")
	  EndIf
	  Return 1
   EndIf

 ;���� ���� ������� ��� ������� ������������ ����� ���� ���� ������� �������
   If $TipConf = "�-��" Then
	  If Call("Prof_To_Base_Start1", $hWndFunc) Then
		 BlockInput(0) ; �������� ���������� � ����
		 If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������**")
		 EndIf
		 Return 1
	  EndIf
   EndIf

   If $TipConf = "����" Then
	  If Call("Prof_To_Base_PBUL", $hWndFunc) Then
		 BlockInput(0) ; �������� ���������� � ����
		 If Call("CloseConfig", $hWndFunc, "���������") = "2" Then
			Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������**")
		 EndIf
		 Return 1
	  EndIf
   EndIf

   Call("LineLogFile",$LogFile, "� ������������ ������ ���������. ��������� ������������")
   ;��������� ������������
   IF Call("CloseConfig", $hWndFunc, "�������������") = "2" Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ������� ������������, ����� �������� ����������*")
	  Return 1
   EndIf

   BlockInput(0) ; �������� ���������� � ����

EndFunc


Func CloseConfig($hWndFunc1, $TegErr)
   If ($TegErr="���������") Then
	  Call("KillPID",$hWndFunc1)
	  BlockInput(0) ; �������� ���������� � ����
   ElseIf ($TegErr="�������������") Then
	  ;��������� ������������ ������������
	  WinClose($hWndFunc1)
	  $hWnd4 = WinWait("������������", "", 360)
	  If Not WinActivate($hWnd4) Then
		 Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���� ������� ��/��� (���������� ������������) �� �������***********")
		 Call("KillPID",$hWndFunc1)
		 BlockInput(0)
		 Return "2"
	  Else
		 WinActivate($hWnd4)
		 Send("{ENTER}")
		 $iPID = WinGetProcess($hWndFunc1)
		 If WinWaitClose($hWndFunc1,"",600)=0 Then
			if ProcessWaitClose($iPID, 300)=0 Then
			   Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ������������ �� ���������� 10 ���, ������ ��������, � ��������� ������***********")
			   Call("KillPID",$hWndFunc1)
			   BlockInput(0)
			   Return "2"
			EndIf
		 EndIf
		 BlockInput(0)
		 Call("LineLogFile",$LogFile,_Date_Time_SystemTimeToDateTimeStr(_Date_Time_GetLocalTime()) & "������������ ������")
		 Sleep(500)
		 Return "0"
	  EndIf
   Else
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ���-�� ����� �� ���, ������ ���������� (1)***********")
	  BlockInput(0)
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

Func ConsoleWriteRead()
   Local $sOutput
   While 1
	  $sOutput = StringRight(ConsoleRead(False), 5)
	  If @error Then
		 MsgBox(4096, "", "������ ������ �:" & $TipConf)
	  ElseIf $sOutput=="�����" Then
		 ExitLoop
	  EndIf
	  Sleep(1000)
   WEnd
EndFunc


Func LineLogFile($LogFileFunc, $Line)
	If FileExists($LogFileFunc) Then
		FileWriteLine($LogFileFunc, $Line)
	Else
		BlockInput(0) ; �������� ���������� � ����
		MsgBox(0,"������","��� LOG - ����� ������ �����������")
		Exit
	EndIf
EndFunc

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
   Return $checksum
EndFunc

;////-----������: ������� �� ���� �������----------------------------------

Func Prof_To_Base_Start1($hWndFunc_Base)
   ;////////������� �������� ������������--------------------------------------
   _WinAPI_SetKeyboardLayout($hWndFunc_Base,0x0419)
   Send("{ENTER}")
   Send($Name)
   Send("{TAB}")
   Send($Synonym)
   Send("{TAB 22}")
   Send($ShortInf)
   Send("{TAB}")
   Send("^{�}")
   Send($LongInf)
   Send("{TAB}{ESC}")
   Call("LineLogFile",$LogFile, "�������� ��������� � ���/�������/������� ����������/��������� ���������� ������������ ����� �� ������� ������������")

   ;////////��������� ����� �������--------------------------------------

   Sleep(100)
   Send("!�")
   Sleep(100)
   Send("!a")
   Sleep(100)
   Send("{RIGHT 2}")
   Sleep(100)
   Send("{DOWN 14}")
   Sleep(100)
   Send("{RIGHT}")
   Sleep(100)
   Send("{DOWN}")
   Sleep(100)
   Send("{ENTER}")
   Sleep(100)

   $hWnd3 = WinWaitActive("��������� ��������", "", 30)
   If Not $hWnd3  Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ��������� ������ ������� �� ������ ���� ��������� �������� ***********")
	  Return 1
   EndIf
   WinSetState($hWnd3,'',@SW_MAXIMIZE )
   Send("{DOWN}{RIGHT}{DOWN 2}{RIGHT}")

   Local $StringMod = ""

   For $i = 0  To UBound($avArray)-1
	  Send($avArray[$i])
	  Send("{APPSKEY}{DOWN}{ENTER}{TAB}{SPACE}{DOWN}{ENTER}{LEFT}")
	  Sleep(100)
	  $StringMod = $StringMod & $avArray[$i]& @CRLF
   Next

   Send("{TAB 2}{ENTER}")

   Call("LineLogFile",$LogFile, "�������� ���������� ������� �������: " & @CRLF & $StringMod)

   Return 0
EndFunc

;////-----������: ������� �� ���� ����----------------------------------

Func Prof_To_Base_PBUL($hWndFunc_PBUL)
   ;////////������� �������� ������������--------------------------------------
   _WinAPI_SetKeyboardLayout($hWndFunc_PBUL,0x0419)
   Send("{ENTER}")
   Send($Name)
   Send("{TAB}")
   Send($Synonym)
   Send("{TAB 22}")
   Send($ShortInf)
   Send("{TAB}")
   Send("^{�}")
   Send($LongInf)
   Send("{TAB}{ESC}")
   Call("LineLogFile",$LogFile, "�������� ��������� � ���/�������/������� ����������/��������� ���������� ������������ ����� �� ����")

   ;////////��������� ����� �������--------------------------------------

   Sleep(200)
   Send("!�")
   Sleep(200)
   Send("!a")
   Sleep(200)
   Send("{RIGHT 2}")
   Sleep(200)
   Send("{DOWN 14}")
   Sleep(200)
   Send("{RIGHT}")
   Sleep(200)
   Send("{DOWN}")
   Sleep(200)
   Send("{ENTER}")
   Sleep(200)

   $hWnd3 = WinWait("��������� ��������", "", 120)

   If Not WinActivate($hWnd3)  Then
	  Call("LineLogFile",$LogFile, ">>>>>>>>>>������!!! ��� ������� ��������� ������ ������� �� ������ ���� ��������� �������� ***********")
	  Return 1
   EndIf
   WinSetState($hWnd3,'',@SW_MAXIMIZE )
   Send("{DOWN}{RIGHT}{DOWN 2}{RIGHT}")

   Local $StringMod = ""

   For $i = 0  To UBound($avArray)-1
	  Send($avArray[$i])
	  Send("{APPSKEY}{DOWN}{ENTER}{TAB}{SPACE}{DOWN}{ENTER}{LEFT}")
	  Sleep(100)
	  $StringMod = $StringMod & $avArray[$i]& @CRLF
   Next
   Sleep(100)
   Send("{TAB 2}{ENTER}")

   Call("LineLogFile",$LogFile, "�������� ���������� ������� �������: " & @CRLF & $StringMod)

   Return 0
EndFunc