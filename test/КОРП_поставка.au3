

Global $PathPlatform = "C:\Program Files (x86)\1cv8\8.3.5.1460\bin\1cv8.exe"
Global $PathBase = "D:\1C_Base\3.0\��������_30_����"
Global $LogFile = "C:\Accounting\log.txt"
Global $MsgLog = " /Out" & """" & $LogFile & """" & " -NoTruncate"
Global $CFUBuildFolder = "C:\Accounting\1Cv8_����_��������.cf"
Global $V8Stor = "TCP://aura.dept07:3542/30_CORP\"


	If FileExists($LogFile) Then
		FileDelete ($LogFile)
		$hFile = FileOpen($LogFile, 1)
	Else
		$hFile = FileOpen($LogFile, 2)
	EndIf

FileClose ($hFile )
RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBase & """" & " /N""�������������"""& " /ConfigurationRepositoryF " & """" & $V8Stor & """" & " /ConfigurationRepositoryN ""�������""" & " /CreateDistributionFiles -cffile " & """" & $CFUBuildFolder & """" & $MsgLog)


$hFile = FileOpen($LogFile, 1)