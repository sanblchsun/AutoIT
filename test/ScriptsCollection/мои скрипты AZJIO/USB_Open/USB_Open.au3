#AutoIt3Wrapper_Outfile=USB_Open.exe
#AutoIt3Wrapper_Icon=USB_Open.ico
#AutoIt3Wrapper_Compression=n
#AutoIt3Wrapper_UseUpx=n
; #AutoIt3Wrapper_UseX64=y
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=
#AutoIt3Wrapper_Res_Description=USB_Open.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.3
#AutoIt3Wrapper_Res_Field=Build|2011.08.2
#AutoIt3Wrapper_Res_Field=Coded by|Author
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
; #AutoIt3Wrapper_Run_Obfuscator=y
; #Obfuscator_Parameters=/StripOnly
; #AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#AutoIt3Wrapper_Res_Icon_Add=1.ico
#AutoIt3Wrapper_Res_Icon_Add=2.ico
#AutoIt3Wrapper_Res_Icon_Add=3.ico
#AutoIt3Wrapper_Res_Icon_Add=4.ico
#AutoIt3Wrapper_Res_Icon_Add=5.ico
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\upx\upx.exe -7 --compress-icons=0 "%out%"

;  @AZJIO 2.08.2011 (AutoIt3_v3.3.6.1)
Opt("TrayIconHide", 1)
Global $curent

; En
$LngTitle='USB_Open'
$LngAbout='About'
$LngVer='Version'
$LngSite='Site'
$LngCopy='Copy'
$LngMs1='Message'
$LngMs2='Create'
$LngMs3='Supported Keys:'&@CRLF&'/l - open the disc'
$LngIni1='; exceptions for a single run with the key /l'
$LngIni2='; device types :'
$LngIni3='; REMOVABLE - flash drive, FIXED - hard drives'
$LngIni4='; open the flash drive in the file manager'
$LngIni5='; autorun file'
$LngIni6='; kill processes when removing flash'
$LngIni7='; autorun files when extracting flash'
$LngEAuR='Enable autorun autorun.inf'
$LngDAuR='Disable autorun autorun.inf'
$LngStp='Suspend'
$LngStr='Resume'
$LngOpI='Open'
$LngReU='Restart'
$LngQt='Exit'

$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang=DllCall ( $Lang_dll, "int", "GetUserDefaultUILanguage" )
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)
DllClose($Lang_dll)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	$LngTitle='USB_Open'
	$LngAbout='О программе'
	$LngVer='Версия'
	$LngSite='Сайт'
	$LngCopy='Копировать'
	$LngMs1='Сообщение'
	$LngMs2='Создаём'
	$LngMs3='Поддерживаются ключи:'&@CRLF&'/l - открыть диск и выйти'
	$LngIni1='; исключения для разового запуска с ключом /l'
	$LngIni2='; типы устройств :'
	$LngIni3='; REMOVABLE - флешка, FIXED - жёсткие диски'
	$LngIni4='; открыть флешку в файловом менеджере'
	$LngIni5='; автозапуск файлов'
	$LngIni6='; завершение процессов при извлечении флешки'
	$LngIni7='; автозапуск файлов при извлечении флешки'
	$LngEAuR='Включить автозапуск autorun.inf'
	$LngDAuR='Отключить автозапуск autorun.inf'
	$LngStp='Приостановить'
	$LngStr='Возобновить'
	$LngOpI='Открыть'
	$LngReU='Перезапуск'
	$LngQt='Выход'
EndIf

$Ini = @ScriptDir & '\USB_Open.ini'
If Not FileExists($Ini) Then
	MsgBox(0, $LngMs1, $LngMs2&' USB_Open.ini')
	$file = FileOpen($Ini,2)
	FileWrite($file, '[exclude]' & @CRLF & _
		$LngIni1 & @CRLF & _
		'Disk=C;D;K' & @CRLF & _
		'Label=FLASH;KINGSTON' & @CRLF & _
		'Path=1.ico;Documents and Settings\Administrator' & @CRLF & _
		$LngIni2&' CDROM;REMOVABLE;FIXED;NETWORK;RAMDISK;UNKNOWN' & @CRLF & _
		$LngIni3 & @CRLF & _
		'Type=CDROM;NETWORK;RAMDISK;UNKNOWN' & @CRLF &@CRLF & _
		'[Set]' & @CRLF & _
		$LngIni4 & @CRLF & _
		'FileMan=C:\WINDOWS\Explorer.exe' & @CRLF & _
		$LngIni5 & @CRLF & _
		';autorun=PStart.exe;C:\menu.lst;\USB_Open.ini;Text\1.txt' & @CRLF & _
		'autorun=' & @CRLF & _
		'arg=' & @CRLF & _
		'hide=0' & @CRLF & _
		$LngIni6 & @CRLF & _
		';OutProcessClose=taskmgr.exe;PStart.exe' & @CRLF & _
		'OutProcessClose=' & @CRLF & _
		$LngIni7 & @CRLF & _
		'autorun_exit=' & @CRLF & _
		'arg_exit=' & @CRLF & _
		'hide_exit=0' & @CRLF)
	FileClose($file)
EndIf

$FileMan=IniRead($Ini, 'Set', 'FileMan', '')
If $FileMan<>'' And Not FileExists($FileMan) Then $FileMan=''
$workFM=''
If $FileMan<>'' Then $workFM=StringRegExpReplace($FileMan, '(^.*)\\(.*)$', '\1')

If $CmdLine[0]>0 Then
	$IniType=IniRead($Ini, 'exclude', 'Type', 'CDROM;FIXED;NETWORK;RAMDISK;UNKNOWN')
	$IniLabel=IniRead($Ini, 'exclude', 'Label', '')
	$IniPath=IniRead($Ini, 'exclude', 'Path', '')
	$IniDisk=IniRead($Ini, 'exclude', 'Disk', '')
	Switch $CmdLine[1]
		Case '/l'
			_Open()
		Case Else; Or '/?' Or '/h' Or '/help'
			MsgBox(0, $LngMs1, $LngMs3)
	EndSwitch
EndIf


; http://www.autoitscript.com/forum/topic/79460-usbmon/page__view__findpost__p__572867
;============# Запрет на повторный запуск #====================================
$hMutex = DllCall("kernel32.dll", "hwnd", "OpenMutex", "int", 0x1F0001, "int", False, "str", "USB459345")

If $hMutex[0] Then
	$hWnd = WinGetHandle("USB459345")
	WinSetState($hWnd, "", @SW_RESTORE)
	DllCall("user32.dll", "int", "SetForegroundWindow", "hwnd", $hWnd)
	Exit
EndIf

$hMutex = DllCall("kernel32.dll", "hwnd", "CreateMutex", "int", 0, "int", False, "str", "USB459345")
;============================================================================

Opt("TrayIconHide", 0)
Opt("TrayMenuMode", 7)
Opt("TrayOnEventMode", 1)

Global $TpOff = 0, $curico=0, $Dr=0, $CurDrives[1]
Global Const $DBT_DEVICEARRIVAL          = 0x8000 ; Найдено новое устройство
Global Const $DBT_DEVICEREMOVECOMPLETE   = 0x8004 ; отключенное устройство
Global Const $DBT_DEVTYP_VOLUME          = 0x00000002 ; Логический диск

If @compiled Then
	$AutoItExe=@AutoItExe
Else
	$AutoItExe=@ScriptDir&'\USB_Open.dll'
EndIf

$autorun=IniRead($Ini, 'Set', 'autorun', '')
$arg=IniRead($Ini, 'Set', 'arg', '')
$hide=Execute(IniRead($Ini, 'Set', 'hide', ''))
$OutProcessClose=IniRead($Ini, 'Set', 'OutProcessClose', '')
$autorun_exit=IniRead($Ini, 'Set', 'autorun_exit', '')
$arg_exit=IniRead($Ini, 'Set', 'arg_exit', '')
$hide_exit=Execute(IniRead($Ini, 'Set', 'hide_exit', ''))
If $hide Then
	$hide=@SW_HIDE
Else
	$hide=@SW_SHOW
EndIf
If $hide_exit Then
	$hide_exit=@SW_HIDE
Else
	$hide_exit=@SW_SHOW
EndIf

TraySetToolTip('USB_Open')

$About = TrayCreateItem($LngAbout) 
TrayItemSetOnEvent(-1, "_About")

$yes_autorun = TrayCreateItem($LngEAuR) 
TrayItemSetOnEvent(-1, "_yes_autorun")

$no_autorun = TrayCreateItem($LngDAuR) 
TrayItemSetOnEvent(-1, "_no_autorun")

$On_Off = TrayCreateItem($LngStp&' USB_Open') 
TrayItemSetOnEvent(-1, "_On_Off")

$Open_ini= TrayCreateItem($LngOpI&' USB_Open.ini') 
TrayItemSetOnEvent(-1, "_Open_ini")

$restart = TrayCreateItem($LngReU) 
TrayItemSetOnEvent(-1, "_restart")

$nExit = TrayCreateItem($LngQt) 
TrayItemSetOnEvent(-1, "_Quit")

_Drive()
TraySetIcon($AutoItExe, $curico)
Global Const $TRAY_EVENT_PRIMARYDOUBLE		= -13
TraySetOnEvent($TRAY_EVENT_PRIMARYDOUBLE,"_OpenDisk")

TraySetState()


$Gui = GUICreate("USB1", 370, 140)
GUISetState(@SW_HIDE, $Gui)
GUISetState(@SW_DISABLE, $Gui)

GUIRegisterMsg(0x0219, "WM_DEVICECHANGE")

While 1
    Sleep(1000)
WEnd

Func _Open_ini()
	$Editor=_TypeGetPath('txt')
	If @error Then $Editor=@SystemDir&'\notepad.exe'
	Run($Editor&' '&$Ini)
EndFunc

Func _TypeGetPath($type)
	Local $typefile = RegRead('HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.'&$type, 'Progid')
	If @error Or  $typefile='' Then
		$typefile = RegRead('HKCR\.'&$type, '')
		If @error Then Return SetError(1)
	EndIf
	Local $Open = RegRead('HKCR\' & $typefile & '\shell', '')
	If @error Then $Open='open'
	$typefile = RegRead('HKCR\' & $typefile & '\shell\'&$Open&'\command', '')
	If @error Then Return SetError(1)
	Local $aPath=StringRegExp($typefile, '(?i)(^.*)(\.exe.*)$', 3)
	If @error Then Return SetError(1)
	$aPath = StringReplace($aPath[0], '"', '') & '.exe'
	Opt('ExpandEnvStrings', 1)
	If FileExists($aPath) Then
		$aPath=$aPath
		Opt('ExpandEnvStrings', 0)
		Return $aPath
	EndIf
	Opt('ExpandEnvStrings', 0)
	If FileExists(@SystemDir&'\'&$aPath) Then Return @SystemDir&'\'&$aPath
	Return SetError(1)
EndFunc

Func _On_Off()
    If $TpOff = 0 Then
		TrayItemSetText($On_Off, $LngStr&' USB_Open')
		$TpOff = 1
		GUIRegisterMsg(0x0219, "")
		TraySetIcon($AutoItExe, 202)
	Else
		TrayItemSetText($On_Off, $LngStp&' USB_Open')
		$TpOff = 0
		GUIRegisterMsg(0x0219, "WM_DEVICECHANGE")
		_Drive()
		TraySetIcon($AutoItExe, $curico)
	EndIf
EndFunc

Func _no_autorun()
	RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer","NoDriveTypeAutoRun","REG_DWORD",'255')
	RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\CancelAutoplay\Files","*.*","REG_SZ",'')
	RegWrite("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\IniFileMapping\Autorun.inf",'',"REG_SZ",'@SYS:DoesNotExist')
	RegWrite("HKLM\SYSTEM\CurrentControlSet\Services\Cdrom","AutoRun","REG_DWORD",'1') ; в 0 ставить нельзя, CD диск после смены не будет обновлять содержимое
	RegWrite("HKLM\SYSTEM\ControlSet001\Services\Cdrom","AutoRun","REG_DWORD",'1')
EndFunc

Func _yes_autorun()
	RegWrite("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\policies\Explorer","NoDriveTypeAutoRun","REG_DWORD",'0')
	RegDelete("HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\AutoplayHandlers\CancelAutoplay\Files", "*.*")
	RegDelete("HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\IniFileMapping\Autorun.inf", "")
	RegWrite("HKLM\SYSTEM\CurrentControlSet\Services\Cdrom","AutoRun","REG_DWORD",'1')
	RegWrite("HKLM\SYSTEM\ControlSet001\Services\Cdrom","AutoRun","REG_DWORD",'1')
EndFunc

Func _OpenDisk()
	If $FileMan<>'' And  $curent<>'' And FileExists($curent&'\') Then
	ShellExecute(FileGetShortName($FileMan), $curent&'\', $workFM)
	ElseIf $FileMan<>'' Then
		$DrivesArr = DriveGetDrive('REMOVABLE')
		If Not @error Then
		; убрать нечитаемые диски
			For $i=$DrivesArr[0] To 1 Step -1
				If DriveStatus($DrivesArr[$i])='READY' Then
					ShellExecute(FileGetShortName($FileMan), $DrivesArr[$i]&'\', $workFM)
					ExitLoop
				EndIf
			Next
		EndIf
	EndIf
EndFunc

; http://www.autoitscript.com/forum/topic/79460-usbmon/
Func WM_DEVICECHANGE($hWnd, $Msg, $wParam, $lParam)
		
	If ($wParam = $DBT_DEVICEARRIVAL) Or ($wParam = $DBT_DEVICEREMOVECOMPLETE) Then
		Local $DEV_BROADCAST_VOLUME = DllStructCreate("int dbcvsize;int dbcvdevicetype;int dbcvreserved;int dbcvunitmask;" & _
													  "ushort dbcvflags", $lParam)
		Local $iDriveType = DllStructGetData($DEV_BROADCAST_VOLUME, "dbcvdevicetype")
	Else
		Return 'GUI_RUNDEFMSG'
	EndIf
	
	If $iDriveType <> $DBT_DEVTYP_VOLUME Then Return 'GUI_RUNDEFMSG'
	
	Local $iMask = DllStructGetData($DEV_BROADCAST_VOLUME, "dbcvunitmask")
	$iMask = Log($iMask) / Log(2)
	
	Local $iDrive = Chr(65 + $iMask) & ":"
	
	Switch $wParam
		Case $DBT_DEVICEARRIVAL ; обнаружение флешки
			TraySetIcon($AutoItExe, 201)
			$curent=$iDrive
			
			; старт файлового менеджера
			If $FileMan<>'' Then ShellExecute(FileGetShortName($FileMan), $iDrive&'\', $workFM)

			; авторан
			If $autorun<>'' Then
				$aAutorun=StringSplit($autorun, ';')
				For $i = 1 to $aAutorun[0]
					If StringLeft($aAutorun[$i], 1)='\' Then
						$aAutorun[$i]=@ScriptDir&$aAutorun[$i]
					ElseIf StringMid($aAutorun[$i], 2, 2)<>':\' Then
						$aAutorun[$i]=$iDrive&'\'&$aAutorun[$i]
					EndIf
					If FileExists($aAutorun[$i]) Then
						$workfld=StringRegExpReplace($aAutorun[$i], '(^.*)\\(.*)$', '\1')
						ShellExecute(FileGetShortName($aAutorun[$i]), $arg, $workfld, '', $hide)
					EndIf
				Next
			EndIf
			
		Case $DBT_DEVICEREMOVECOMPLETE ; отключение флешки
			TraySetIcon($AutoItExe, 202)

			; авторан
			If $autorun_exit<>'' Then
				$aAutorun=StringSplit($autorun_exit, ';')
				For $i = 1 to $aAutorun[0]
					If StringLeft($aAutorun[$i], 1)='\' Then
						$aAutorun[$i]=@ScriptDir&$aAutorun[$i]
					ElseIf StringMid($aAutorun[$i], 2, 2)<>':\' Then
						$aAutorun[$i]=@ScriptDir&'\'&$aAutorun[$i]
					EndIf
					If FileExists($aAutorun[$i]) Then
						$workfld=StringRegExpReplace($aAutorun[$i], '(^.*)\\(.*)$', '\1')
						ShellExecute(FileGetShortName($aAutorun[$i]), $arg_exit, $workfld, '', $hide_exit)
					EndIf
				Next
			EndIf

			; закрытие процесса
			If $OutProcessClose<>'' Then
				$aOutProcessClose=StringSplit($OutProcessClose, ';')
				For $i = 1 to $aOutProcessClose[0]
					$PID = ProcessExists($aOutProcessClose[$i])
					If $PID Then ProcessClose($PID)
				Next
			EndIf
	EndSwitch
	
	_Drive()
	GUIRegisterMsg(0x0113, "WM_TIMER")
	DllCall("User32.dll", "int", "SetTimer", "hwnd", $Gui, "int", 50, "int", 2000, "int", 0)
	
	Return 'GUI_RUNDEFMSG'
EndFunc

Func WM_TIMER()
	TraySetIcon($AutoItExe, $curico)
	GUIRegisterMsg(0x0113, '')
    DllCall("user32.dll", "int", "KillTimer", "hwnd", $Gui, "int*", 50)
EndFunc

Func _Drive()
	If $Dr<>0 Then
		For $i = 1 to $Dr
			TrayItemDelete($CurDrives[$i][0])
		Next
	EndIf

	$DrivesArr = DriveGetDrive('REMOVABLE')
	If Not @error Then
	; убрать нечитаемые диски
		$Dr=0
		For $i=1 To $DrivesArr[0]
			If DriveStatus($DrivesArr[$i])='READY' Then
				$Dr+=1
				$DrivesArr[$Dr]=$DrivesArr[$i]
			EndIf
		Next
		Switch $Dr
			Case 0
				$curico=0
			Case 1
				$curico=203
			Case 2
				$curico=204
			Case 3 to 30
				$curico=205
			Case Else
			   $curico=0
		EndSwitch
	Else
		$curico=0
		$Dr=0
	EndIf
	If $Dr<>0 Then
		ReDim $CurDrives[$Dr+1][2]
		For $i = 1 to $Dr
			$CurDrives[$i][1]=StringUpper($DrivesArr[$i])
			$CurDrives[$i][0]=TrayCreateItem($CurDrives[$i][1]) 
			TrayItemSetOnEvent(-1, "_Open_Dr")
		Next
	EndIf
EndFunc

Func _Open_Dr()
	Run('"'&$FileMan&'" '&TrayItemGetText(@TRAY_ID)&'\')
EndFunc

Func _Quit()
	TraySetState(2)
	Exit
EndFunc


Func _Open()
	$DrivesArr = DriveGetDrive('ALL')
	If @error Or $DrivesArr[0]=0 Then Exit
	
	; убрать нечитаемые диски
		$d=0
		For $i=1 To $DrivesArr[0]
			If DriveStatus($DrivesArr[$i])='READY' Then
				$d+=1
				$DrivesArr[$d]=$DrivesArr[$i]
			EndIf
		Next
		If $d = 0 Then Exit
		$DrivesArr[0]=$d
		ReDim $DrivesArr[$d+1]
	
	; исключение по типу диска
	If $IniType<>'' Then
		$d=0
		For $i=1 To $DrivesArr[0]
			If Not StringInStr(';'&$IniType&';', ';'&DriveGetType($DrivesArr[$i]&'\')&';') Then
				$d+=1
				$DrivesArr[$d]=$DrivesArr[$i]
			EndIf
		Next
		If $d = 0 Then Exit
		$DrivesArr[0]=$d
		ReDim $DrivesArr[$d+1]
	EndIf
	
	; исключение по букве диска
	If $IniDisk<>'' Then
		$d=0
		For $i=1 To $DrivesArr[0]
			If Not StringInStr(';'&$IniDisk&';', ';'&StringLeft($DrivesArr[$i], 1)&';') Then
				$d+=1
				$DrivesArr[$d]=$DrivesArr[$i]
			EndIf
		Next
		If $d = 0 Then Exit
		$DrivesArr[0]=$d
		ReDim $DrivesArr[$d+1]
	EndIf
	
	; исключение по имени диска (метка, лэйбл)
	If $IniLabel<>'' Then
		$d=0
		For $i=1 To $DrivesArr[0]
			If Not StringInStr(';'&$IniLabel&';', ';'&DriveGetLabel($DrivesArr[$i]&'\')&';') Then
				$d+=1
				$DrivesArr[$d]=$DrivesArr[$i]
			EndIf
		Next
		If $d = 0 Then Exit
		$DrivesArr[0]=$d
		ReDim $DrivesArr[$d+1]
	EndIf
	
	; исключение по пути на диске
	If $IniPath<>'' Then
		$aIniPath=StringSplit($IniPath, ';')
		For $j = 1 to $aIniPath[0]
			$d=0
			For $i=1 To $DrivesArr[0]
				If Not FileExists($DrivesArr[$i]&'\'&$aIniPath[$j]) Then
					$d+=1
					$DrivesArr[$d]=$DrivesArr[$i]
				EndIf
			Next
			If $d = 0 Then Exit
			$DrivesArr[0]=$d
			ReDim $DrivesArr[$d+1]
		Next
	EndIf
	
	If $DrivesArr[0]=1 Then
		Run('"'&$FileMan&'" '&$DrivesArr[1]&'\')
		Exit
	EndIf
	
    $Gui1 = GUICreate('USB', $DrivesArr[0]*30+5, 35,-1,-1, -1, 0x00000080)
	For $i=1 To $DrivesArr[0]
		Assign('Drives'& $i, GUICtrlCreateButton($DrivesArr[$i], ($i-1)*30+5, 5, 25, 25))
	Next
	GUISetState(@SW_SHOW, $Gui1)
	
	While 1
		$msg = GUIGetMsg()
		For $i=1 To $DrivesArr[0]
			If $msg = Eval('Drives' & $i) Then
				Run('"'&$FileMan&'" '&$DrivesArr[$i]&'\')
				Exit
			EndIf
		Next
		If $msg = -3 Then Exit
    WEnd
EndFunc

Func _restart()
	Local $sAutoIt_File = @TempDir & "\~Au3_ScriptRestart_TempFile.au3"
	Local $sRunLine, $sScript_Content, $hFile

	$sRunLine = @ScriptFullPath
	If Not @Compiled Then $sRunLine = @AutoItExe & ' /AutoIt3ExecuteScript ""' & $sRunLine & '""'
	If $CmdLine[0] > 0 Then $sRunLine &= ' ' & $CmdLineRaw

	$sScript_Content &= '#NoTrayIcon' & @CRLF & _
			'While ProcessExists(' & @AutoItPID & ')' & @CRLF & _
			'   Sleep(10)' & @CRLF & _
			'WEnd' & @CRLF & _
			'Run("' & $sRunLine & '")' & @CRLF & _
			'FileDelete(@ScriptFullPath)' & @CRLF

	$hFile = FileOpen($sAutoIt_File, 2)
	FileWrite($hFile, $sScript_Content)
	FileClose($hFile)

	Run(@AutoItExe & ' /AutoIt3ExecuteScript "' & $sAutoIt_File & '"', @ScriptDir, @SW_HIDE)
	Sleep(1000)
	Exit
EndFunc   ;==>_restart

Func _ED($state=64)
    Local $de=StringSplit('restart,About,yes_autorun,no_autorun,On_Off,Open_ini,nExit', ',')
	For $i = 1 to $de[0]
		TrayItemSetState(Eval($de[$i]), $state)
	Next
EndFunc

Func _About()
	_ED(128)
	Local $font="Arial"
    Local $Gui1 = GUICreate($LngAbout, 210, 180, @DesktopWidth-350, @DesktopHeight-260, BitOr($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), 0x00000008, $Gui)
	GUISetBkColor (0xffca48)
	GUICtrlCreateLabel($LngTitle, 0, 0, 210, 63, 0x01+0x0200)
	GUICtrlSetFont (-1,14, 600, -1, $font)
	GUICtrlSetColor(-1,0xa13d00)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,64,208,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.3   2.08.2011', 15, 100, 210, 17)
	GUICtrlCreateLabel($LngSite&':', 15, 115, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', 52, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 15, 130, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', 90, 130, 125, 17)
	GUICtrlSetColor(-1,0xa21a10)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010', 15, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
	While 1
	  $msg = GUIGetMsg()
	  Select
		Case $msg = $url
			ShellExecute ('http://azjio.ucoz.ru')
		Case $msg = $WbMn
			ClipPut('R939163939152')
		Case $msg = -3
			$msg = 0
			GUIDelete($Gui1)
			_ED()
			ExitLoop
		EndSelect
    WEnd
EndFunc