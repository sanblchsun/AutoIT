
;  @AZJIO
#NoTrayIcon ; скрыть иконку в трее
; #Include <File.au3>
; #include <WindowsConstants.au3>
; #include <GUIConstantsEx.au3> 
; #include <Array.au3>

;создание оболочки
Opt("GUICloseOnESC", 1) ; выход по ESC
$vRazdel='\t\'
$Gui = GUICreate("txtsetup.sif > reg",  300, 94, -1, -1, -1, 0x00000010)

$Input1 = GUICtrlCreateLabel('', 0, 0, 300, 94)
GUICtrlSetState(-1, 136) ; скрыть поле
GUICtrlCreateLabel ("Кинь сюда файл txtsetup.sif  для конвертации в reg", 10,2,280,17)
$StatusBar=GUICtrlCreateLabel (@CRLF&@CRLF&'Строка состояния', 10,46,280,57)

GUISetState ()

While 1
   $msg = GUIGetMsg()
   Select
			Case $msg = -13
				$filename=StringRegExp(@GUI_DRAGFILE,'(^.*)\\(.*)\.(.*)$',3)
				; генерируем имя нового файла с номером копии на случай если файл существует
				$Output = $filename[0]& '\reg_'
				$nm = 1
				While FileExists($Output & $nm & '_'&$filename[1]&'.reg')
					$nm += 1
				WEnd
				$Output = $Output & $nm & '_'&$filename[1]&'.reg' ; имя выходного файла
				$fileReg = FileOpen($Output, 2)
				FileWrite($fileReg, 'Windows Registry Editor Version 5.00'&@CRLF&@CRLF)
				
				; сохраняем
				$aHID = IniReadSection(@GUI_DRAGFILE, "HardwareIdsDatabase")
				;$aSCSILoad = IniReadSection(@GUI_DRAGFILE, "SCSI.Load")
				For $i=1 To $aHID[0][0]
					If StringInStr($aHID[$i][0], 'PCI\VEN') Then
						$HIDtmp=StringReplace($aHID[$i][0], 'PCI\VEN', 'PCI#VEN')
;MsgBox(0, 'Сообщение', $aHID[$i][0]&@CRLF&$HIDtmp)
						FileWrite($fileReg, '[HKEY_LOCAL_MACHINE'&$vRazdel&'ControlSet001\Control\CriticalDeviceDatabase\'&$HIDtmp&']'&@CRLF& _
						'"Service"='&$aHID[$i][1]&@CRLF&@CRLF)
						
						$HIDtmp = StringReplace($aHID[$i][0], '"', '')
						;$n = _ArraySearch($aSCSILoad, $HIDtmp, 1)
						FileWrite($fileReg, '[HKEY_LOCAL_MACHINE'&$vRazdel&'ControlSet001\Services\'&$HIDtmp&']'&@CRLF& _
						'"ErrorControl"=dword:00000001'&@CRLF& _
						'"Group"="SCSI miniport"'&@CRLF& _
						'"Start"=dword:00000004'&@CRLF& _
						'"Type"=dword:00000001'&@CRLF&@CRLF)
					EndIf
					If StringRegExp($aHID[$i][1], ',[ ]*{') Then
						$aPar=StringRegExp($aHID[$i][1], '(^.*?)([ ]*,[ ]*)(\{.*\})[ ]*$', 3)
						FileWrite($fileReg, '[HKEY_LOCAL_MACHINE'&$vRazdel&'ControlSet001\Control\CriticalDeviceDatabase\'&$aHID[$i][0]&']'&@CRLF& _
						'"Service"='&$aPar[0]&@CRLF& _
						'"ClassGUID"="'&$aPar[2]&'"'&@CRLF&@CRLF)
					EndIf
				Next
				GUICtrlSetData($StatusBar, 'Файл '&$filename[1]&'.'&$filename[2]&' принят'&@CRLF&'Сконвертированный файл reg_'& $nm & '_'&$filename[1]&'.reg создан.')
				FileClose($fileReg)
	  Case $msg = -3
		Exit
   EndSelect
WEnd
	