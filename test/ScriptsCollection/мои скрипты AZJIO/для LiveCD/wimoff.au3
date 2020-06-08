;  @AZJIO
#include <File.au3>
#NoTrayIcon ;скрыть в системной панели индикатор AutoIt

; извлечение информации о смонтированных wim
$rnim = Run(@SystemDir & '\imagex.exe /mount', @SystemDir, @SW_HIDE, 2)
$wiminfo = ''
While 1
	$line1 = StdoutRead($rnim)
	If @error Then ExitLoop
	$wiminfo &= $line1
WEnd
$aPathwim = StringRegExp($wiminfo, "(?i)Mount Path \.*:\[(.*)]", 3)
$aNamewim = StringRegExp($wiminfo, "(?i)Image File \.*:\[(.*)]", 3)
$aNomer = StringRegExp($wiminfo, "(?i)Number of Mounted Images: \.*(.*)", 3)

; конец "извлечение информации о смонтированных wim"
If $aPathwim = '1' Then
	MsgBox(0, "Сообщение", "Нет смонтированных wim")
	If FileExists(@ProgramFilesDir & '\gimagex\gimagex.exe') Then ShellExecute(@ProgramFilesDir & '\gimagex\gimagex.exe', '', '', '')
	Exit
EndIf
$nomer = Number($aNomer[0])
Switch $nomer
	Case 1 To 15
		$guiw = 240
		$Butt = 140
	Case 16 To 30
		$guiw = 375
		$Butt = 275
	Case 31 To 45
		$guiw = 510
		$Butt = 410
	Case Else
		$guiw = 645
		$Butt = 545
EndSwitch

; начало создания окна, кнопок.
GUICreate("Демонтирование wim", $guiw, 320) ; размер окна
GUISetBkColor(0xF9F9F9)

; создание списка в GUI-оболочке
$nomer = Number($aNomer[0])
For $i = 1 To $nomer
	$x = $i - 1
	$aWim = StringRegExp($aNamewim[$x], "(^.*)\\(.*)$", 3)
	$pos = $i * 20 - 10
	$pos_L = 10
	If $i > '15' Then $pos_L = 145
	If $i > '15' Then $pos = $i * 20 - 310
	If $i > '30' Then $pos_L = 280
	If $i > '30' Then $pos = $i * 20 - 610
	If $i > '45' Then $pos_L = 415
	If $i > '45' Then $pos = $i * 20 - 910
	Assign('check' & $i, GUICtrlCreateCheckbox($aWim[1], $pos_L, $pos, 130, 20))
	;GuiCtrlSetState(Eval('check' & $i), 1) ; поставить галочки по умолчанию
Next

$checkall = GUICtrlCreateCheckbox("Вкл/выкл все", $Butt, 200, 90, 22)
GUICtrlSetTip(-1, "Убрать/поставить галочки" & @CRLF & "на всех пунктах")
$gimagex0 = GUICtrlCreateButton("Gimagex", $Butt, 230, 90, 22)
GUICtrlSetTip(-1, "Старт Gimagex")
$restart0 = GUICtrlCreateButton("Обновить", $Butt, 260, 90, 22)
GUICtrlSetTip(-1, "Обновление перезапуском скрипта")
$Unmount = GUICtrlCreateButton("Демонтировать", $Butt, 290, 90, 22)
GUICtrlSetTip(-1, "Демонтировать отмеченные")

GUISetState()

While 1
	$msg = GUIGetMsg()
	Select
		; Отмонтировать отмеченные
		Case $msg = $Unmount
			For $i = 1 To $nomer
				If GUICtrlRead(Eval('check' & $i)) = 1 Then
					$x = $i - 1
					ShellExecuteWait(@SystemDir & '\imagex.exe', '/unmount "' & $aPathwim[$x] & '"', '', '', @SW_HIDE)
					DirRemove($aPathwim[$x], 1)
					GUICtrlSetState(Eval('check' & $i), 32)
				EndIf
			Next
			; Выделить/отменить выделение всех
		Case $msg = $checkall
			If GUICtrlRead($checkall) = 1 Then
				$p = 1
			Else
				$p = 4
			EndIf
			For $i = 1 To $nomer
				GUICtrlSetState(Eval('check' & $i), $p)
			Next
			; Старт gimagex
		Case $msg = $gimagex0
			ShellExecute(@ProgramFilesDir & '\gimagex\gimagex.exe', '', '', '')
		Case $msg = $restart0
			_ScriptRestart()
		Case $msg = -3
			ExitLoop
	EndSelect
WEnd

Func _ScriptRestart()
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
EndFunc   ;==>_ScriptRestart