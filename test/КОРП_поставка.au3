

Global $PathPlatform = "C:\Program Files (x86)\1cv8\8.3.5.1460\bin\1cv8.exe"
Global $PathBase = "D:\1C_Base\3.0\Основной_30_КОРП"
Global $LogFile = "C:\Accounting\log.txt"
Global $MsgLog = " /Out" & """" & $LogFile & """" & " -NoTruncate"
Global $CFUBuildFolder = "C:\Accounting\1Cv8_КОРП_поставка.cf"
Global $V8Stor = "TCP://aura.dept07:3542/30_CORP\"


	If FileExists($LogFile) Then
		FileDelete ($LogFile)
		$hFile = FileOpen($LogFile, 1)
	Else
		$hFile = FileOpen($LogFile, 2)
	EndIf

FileClose ($hFile )
RunWait("""" & $PathPlatform & """" & " DESIGNER /F" & """" & $PathBase & """" & " /N""Администратор"""& " /ConfigurationRepositoryF " & """" & $V8Stor & """" & " /ConfigurationRepositoryN ""Макосов""" & " /CreateDistributionFiles -cffile " & """" & $CFUBuildFolder & """" & $MsgLog)


$hFile = FileOpen($LogFile, 1)