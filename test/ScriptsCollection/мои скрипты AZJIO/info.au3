;  @AZJIO
; определяем количество дисков до создания оболочки, ведь от этого зависит её размер
$DrivesArr = DriveGetDrive("all")
$list = ''
For $i = 1 To $DrivesArr[0]
	$DrTp = DriveGetType($DrivesArr[$i] & '\')
	If $DrTp = 'Removable' Then $DrTp = 'Rem'
	If $DrivesArr[$i] <> 'A:' And $DrTp <> 'CDROM' Then Assign('list', $list & '|' & StringUpper($DrivesArr[$i]) & ' (' & $DrTp & ')')
Next
$aListDrive = StringSplit($list, "|")

$xD = @DesktopWidth
GUICreate("Статистика", 267, $aListDrive[0] * 50 + 70, $xD - 277, 30)
Dim $progress, $main, $sub

$restart = GUICtrlCreateButton("R", 238, 22, 20, 17)
GUICtrlSetTip(-1, "Перезапуск скрипта")

$refresh = GUICtrlCreateButton("Re", 10, 80, 20, 17)
GUICtrlSetTip(-1, "Обновить данные харда")

$checkHDD = GUICtrlCreateCheckbox("автообновление датчиков HDD", 40, 80, 180, 17)
GUICtrlSetTip(-1, "Обновить данные харда")

$mem = MemGetStats()
$ramsize = 'Свободно ' & Round($mem[2] / 1048576, 2) & ' / ' & Round($mem[1] / 1048576, 2) & ' (Гб)'
$ram = _ProgressOn($progress, $main, $sub, "ОЗУ", $ramsize, 10, 5, 1, 0x00f20b, 0xff5c2b)
_ProgressSet($ram, ($mem[1] - $mem[2]) / $mem[1] * 100, "")

$sValue = RegRead('HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0', 'ProcessorNameString')
$cpu = GUICtrlCreateLabel('CPU: ' & $sValue, 10, 50, 250, 30, 0x0080)
GUICtrlSetFont(-1, -1, 700)

For $i = 2 To $aListDrive[0]
	Assign('bykva' & $i, StringLeft($aListDrive[$i], 1))
	Assign('hdd' & $i, _ProgressOn($progress, $main, $sub, $aListDrive[$i] & ' ' & DriveGetFileSystem(Eval('bykva' & $i) & ":\"), 'Свободно ' & Round(DriveSpaceFree(Eval('bykva' & $i) & ":\") / 1024, 1) & ' / ' & Round(DriveSpaceTotal(Eval('bykva' & $i) & ":\") / 1024, 1) & ' (Гб)', 10, $i * 50 + 10, 1, 0xe9e549, 0x2b83ff))
	_ProgressSet(Eval('hdd' & $i), (DriveSpaceTotal(Eval('bykva' & $i) & ":\") - DriveSpaceFree(Eval('bykva' & $i) & ":\")) / DriveSpaceTotal(Eval('bykva' & $i) & ":\") * 100, "")
	Assign('Open' & $i, GUICtrlCreateButton("...", 238, $i * 50 + 27, 20, 18))
	GUICtrlSetTip(-1, "Открыть диск")
Next

GUISetState()
$r = 0
$h = 0
While 1
	$msg = GUIGetMsg()
	Sleep(10)
	For $i = 2 To $aListDrive[0]
		If $msg = Eval('Open' & $i) Then ShellExecute(Eval('bykva' & $i) & ":\")
	Next

	$r += 1
	If $r = 50 Then ; каждые 0,5 секунд проверка размера памяти
		$r = 0
		$mem = MemGetStats()
		$ramsize = 'Свободно ' & Round($mem[2] / 1048576, 2) & ' / ' & Round($mem[1] / 1048576, 2) & ' (Гб)'
		_ProgressSet($ram, ($mem[1] - $mem[2]) / $mem[1] * 100, $ramsize)
	EndIf

	If GUICtrlRead($checkHDD) = 1 Then
		$h += 1
		If $h = 70 Then ; каждые 0,7 секунд проверка хардов, обновление информации
			$h = 0
			For $i = 2 To $aListDrive[0]
				_ProgressSet(Eval('hdd' & $i), (DriveSpaceTotal(Eval('bykva' & $i) & ":\") - DriveSpaceFree(Eval('bykva' & $i) & ":\")) / DriveSpaceTotal(Eval('bykva' & $i) & ":\") * 100)
			Next
		EndIf
	EndIf

	Switch $msg
		Case $refresh
			For $i = 2 To $aListDrive[0]
				_ProgressSet(Eval('hdd' & $i), (DriveSpaceTotal(Eval('bykva' & $i) & ":\") - DriveSpaceFree(Eval('bykva' & $i) & ":\")) / DriveSpaceTotal(Eval('bykva' & $i) & ":\") * 100)
			Next
		Case $restart
			_restart()
		Case -3
			Exit
	EndSwitch
WEnd

;===============================================================================
; Создать прогресс, автор функций RazerM
;===============================================================================
Func _ProgressOn(ByRef $s_mainlabel, ByRef $s_sublabel, ByRef $s_control, $s_main, $s_sub, $x, $y, $fSmooth = 0, $BkCol = 0xE0DFE3, $Color = 0xB2B4BF)
	$s_mainlabel = GUICtrlCreateLabel($s_main, $x, $y, StringLen($s_main) * 9, 17)
	GUICtrlSetFont(-1, -1, 700)
	If $s_mainlabel = 0 Then
		SetError(1)
		Return 0
	EndIf
	If StringInStr(@OSType, "WIN32_NT") And $fSmooth = 1 Then
		$prev = DllCall("uxtheme.dll", "int", "GetThemeAppProperties");, "int", 0)
		DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0)
	EndIf
	$s_control = GUICtrlCreateProgress($x, $y + 17, 220, 17, 1)
	GUICtrlSetColor(-1, $Color)
	GUICtrlSetBkColor(-1, $BkCol)
	If StringInStr(@OSType, "WIN32_NT") And $fSmooth = 1 Then
		DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", $prev[0])
	EndIf
	If $s_control = 0 Then
		SetError(1)
		Return 0
	EndIf
	$s_sublabel = GUICtrlCreateLabel($s_sub, $x + 105, $y, 17)
	GUICtrlSetFont(-1, -1, 700)
	If $s_sublabel = 0 Then
		SetError(1)
		Return 0
	EndIf
	Dim $a_info[5]
	$a_info[0] = $s_control
	$a_info[1] = $s_mainlabel
	$a_info[2] = $s_sublabel
	$a_info[3] = $x
	$a_info[4] = $y
	Return $a_info
EndFunc
;===============================================================================
; установка параметров, автор функций RazerM  (слегка модифицировано)
;===============================================================================
;
Func _ProgressSet($a_info, $i_per, $s_sub = "", $s_main = "")
	If $s_main = "" Then $s_main = GUICtrlRead($a_info[1])
	If $s_sub = "" Then $s_sub = GUICtrlRead($a_info[2])
	$set1 = GUICtrlSetData($a_info[0], $i_per)
	$set2 = GUICtrlSetData($a_info[1], $s_main)
	$set3 = GUICtrlSetData($a_info[2], $s_sub)
	GUICtrlSetPos($a_info[2], $a_info[3] + 105, $a_info[4], StringLen($s_sub) * 6, 17)
	GUICtrlSetPos($a_info[1], $a_info[3], $a_info[4], StringLen($s_main) * 7)
	If ($set1 = 0) Or ($set2 = 0) Or ($set3 = 0) Or ($set1 = -1) Or ($set2 = -1) Or ($set3 = -1) Then
		SetError(1)
		Return 0
	EndIf
	Return 1
EndFunc

Func _restart()
	Local $sAutoIt_File = @TempDir & "\~Au3_ScriptRestart_TempFile.au3"
	Local $sRunLine, $sScript_Content, $hFile

	$sRunLine = @ScriptFullPath
	If Not @Compiled Then $sRunLine = @AutoItExe & ' /AutoIt3ExecuteScript ""' & $sRunLine & '""'
	If $CmdLine[0] > 0 Then $sRunLine &= ' ' & $CmdLineRaw

	$sScript_Content &= '#NoTrayIcon' & @CRLF
	$sScript_Content &= 'While ProcessExists(' & @AutoItPID & ')' & @CRLF
	$sScript_Content &= '   Sleep(10)' & @CRLF
	$sScript_Content &= 'WEnd' & @CRLF
	$sScript_Content &= 'Run("' & $sRunLine & '")' & @CRLF
	$sScript_Content &= 'FileDelete(@ScriptFullPath)' & @CRLF

	$hFile = FileOpen($sAutoIt_File, 2)
	FileWrite($hFile, $sScript_Content)
	FileClose($hFile)

	Run(@AutoItExe & ' /AutoIt3ExecuteScript "' & $sAutoIt_File & '"', @ScriptDir, @SW_HIDE)
	Sleep(1000)
	Exit
EndFunc