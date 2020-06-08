#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=icons.exe
#AutoIt3Wrapper_icon=icons.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=
#AutoIt3Wrapper_Res_Description=icons.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2010.04.11
#Include <File.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3> 
#include <Array.au3>
AutoItSetOption("TrayIconHide", 1) ;скрыть в системной панели индикатор AutoIt
Global $Stack[50], $Stack1[50], $aRecords

;создание оболочки
GUICreate("Замена иконок в LiveCD",500,228, -1, -1, -1, $WS_EX_ACCEPTFILES) ; размер окна
$tab=GUICtrlCreateTab (0,2, 500,204) ; размер вкладки
$hTab = GUICtrlGetHandle($Tab) ; (1) устранение проблем интерфейса

GUICtrlCreateLabel ("используйте drag-and-drop", 250,5,200,18)

$tab3=GUICtrlCreateTabitem ("Патч") ; имя вкладки

GUICtrlCreateLabel ("Путь к I386 или MiniNT", 20,40,400,20)
$inputi386z=GUICtrlCreateInput ("", 20,60,420,22)
GUICtrlSetState(-1,8)
$filewim=GUICtrlCreateButton ("...", 455,59,27,24)
GUICtrlSetFont (-1,14)
GUICtrlSetTip(-1, "Обзор...")

GUICtrlCreateLabel ("Путь к папке PROGRAMS", 20,100,400,20)
$inputprg=GUICtrlCreateInput ("", 20,120,420,22)
GUICtrlSetState(-1,8)
$filezip=GUICtrlCreateButton ("...", 455,119,27,24)
GUICtrlSetFont (-1,14)
GUICtrlSetTip(-1, "Обзор...")


$checkbak=GUICtrlCreateCheckbox ("Делать backup файлов", 40,155,340,20)

$Upd=GUICtrlCreateButton ("Выполнить", 390,160,92,26)
$Label000=GUICtrlCreateLabel ('Строка состояния			AZJIO 2010.04.11', 10,210,380,20)

$tab4=GUICtrlCreateTabitem ("    ?") ; имя вкладки

GUICtrlCreateLabel ("Пропатчиваемые файлы:"&@CRLF&"shell32.dll, rasdlg.dll, fontext.dll, msgina.dll, mshtml.dll, mstask.dll, netshell.dll, setupapi.dll, shimgvw.dll, webcheck.dll, xpsp2res.dll, stobject.dll, mydocs.dll, moricons.dll, url.dll, mpcicons.dll, assot.dll, explorer.exe, iexplore.exe, sndvol32.exe, shutdown.exe, charmap.exe, wordpad.exe, taskmgr.exe, wmplayer.exe, wscript.exe, spider.exe, sol.exe, freecell.exe, regedit.exe, winmine.exe, notepad.exe, calc.exe, mspaint.exe, main.cpl, mmsys.cpl, sysdm.cpl, joy.cpl, telephon.cpl, timedate.cpl, desk.cpl", 20,40,460,140)

$RHE=@ScriptDir&'\ResHacker.exe'
$res=@ScriptDir&'\resources'

GUICtrlCreateTabitem ("")   ; конец вкладок

; (2) устранение проблем интерфейса
Switch @OSVersion
    Case 'WIN_2000', 'WIN_XP', 'WIN_2003'
        $Part = 10
    Case Else
        $Part = 11
EndSwitch
$Color = _WinAPI_GetThemeColor($hTab, 'TAB', $Part, 1, 0x0EED)
If Not @error Then
	; перечисление элементов, для которых нужно исправить проблему цвета
    GUICtrlSetBkColor($checkbak, $Color)
EndIf

GUISetState ()

While 1
   $msg = GUIGetMsg()
   Select
	  Case $msg = $Upd
		 $inputi386=GUICtrlRead ($inputi386z)
		 $inputprg0=GUICtrlRead ($inputprg)
				If Not FileExists($inputi386) Then
					MsgBox(0, "Мелкая ошибка", 'Не указан каталог i386')
					ContinueLoop
				EndIf
				If Not FileExists($inputprg0) Then
					MsgBox(0, "Мелкая ошибка", 'Не указан каталог PROGRAMS')
					ContinueLoop
				EndIf
		 GUICtrlSetData($Label000, 'Выполняется обновление...')
		 
				  ; делаем бэкап системных файлов
				If GUICtrlRead ($checkbak)=1 Then
				For $i=1 To 200
				   If Not FileExists(@ScriptDir&'\backup_dll'&$i) Then
If FileExists($inputi386&'\system32\shell32.dll') Then FileCopy($inputi386&'\system32\shell32.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\rasdlg.dll') Then FileCopy($inputi386&'\system32\rasdlg.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\fontext.dll') Then FileCopy($inputi386&'\system32\fontext.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\msgina.dll') Then FileCopy($inputi386&'\system32\msgina.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\mshtml.dll') Then FileCopy($inputi386&'\system32\mshtml.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\mstask.dll') Then FileCopy($inputi386&'\system32\mstask.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\netshell.dll') Then FileCopy($inputi386&'\system32\netshell.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\setupapi.dll') Then FileCopy($inputi386&'\system32\setupapi.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\shimgvw.dll') Then FileCopy($inputi386&'\system32\shimgvw.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\webcheck.dll') Then FileCopy($inputi386&'\system32\webcheck.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\xpsp2res.dll') Then FileCopy($inputi386&'\system32\xpsp2res.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\stobject.dll') Then FileCopy($inputi386&'\system32\stobject.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\mydocs.dll') Then FileCopy($inputi386&'\system32\mydocs.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\moricons.dll') Then FileCopy($inputi386&'\system32\moricons.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\url.dll') Then FileCopy($inputi386&'\system32\url.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\sndvol32.exe') Then FileCopy($inputi386&'\system32\sndvol32.exe', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\shutdown.exe') Then FileCopy($inputi386&'\system32\shutdown.exe', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\charmap.exe') Then FileCopy($inputi386&'\system32\charmap.exe', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\wordpad.exe') Then FileCopy($inputi386&'\system32\wordpad.exe', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\taskmgr.exe') Then FileCopy($inputi386&'\system32\taskmgr.exe', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\wmplayer.exe') Then FileCopy($inputi386&'\system32\wmplayer.exe', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\wscript.exe') Then FileCopy($inputi386&'\system32\wscript.exe', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\spider.exe') Then FileCopy($inputi386&'\system32\spider.exe', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\sol.exe') Then FileCopy($inputi386&'\system32\sol.exe', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\freecell.exe') Then FileCopy($inputi386&'\system32\freecell.exe', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\regedit.exe') Then FileCopy($inputi386&'\system32\regedit.exe', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\winmine.exe') Then FileCopy($inputi386&'\system32\winmine.exe', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\notepad.exe') Then FileCopy($inputi386&'\system32\notepad.exe', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\calc.exe') Then FileCopy($inputi386&'\system32\calc.exe', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\mspaint.exe') Then FileCopy($inputi386&'\system32\mspaint.exe', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\main.cpl') Then FileCopy($inputi386&'\system32\main.cpl', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\mmsys.cpl') Then FileCopy($inputi386&'\system32\mmsys.cpl', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\sysdm.cpl') Then FileCopy($inputi386&'\system32\sysdm.cpl', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\joy.cpl') Then FileCopy($inputi386&'\system32\joy.cpl', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\telephon.cpl') Then FileCopy($inputi386&'\system32\telephon.cpl', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\timedate.cpl') Then FileCopy($inputi386&'\system32\timedate.cpl', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\desk.cpl') Then FileCopy($inputi386&'\system32\desk.cpl', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\assot.dll') Then FileCopy($inputi386&'\system32\assot.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\system32\mpcicons.dll') Then FileCopy($inputi386&'\system32\mpcicons.dll', @ScriptDir&'\backup_dll'&$i&'\i386\system32\', 8)
If FileExists($inputi386&'\explorer.exe') Then FileCopy($inputi386&'\explorer.exe', @ScriptDir&'\backup_dll'&$i&'\i386\', 8)
If FileExists($inputi386&'\iexplore.exe') Then FileCopy($inputi386&'\iexplore.exe', @ScriptDir&'\backup_dll'&$i&'\i386\', 8)
If FileExists($inputi386&'\regedit.exe') Then FileCopy($inputi386&'\regedit.exe', @ScriptDir&'\backup_dll'&$i&'\i386\', 8)
If FileExists($inputprg0&'\7-Zip\7z.dll') Then FileCopy($inputprg0&'\7-Zip\7z.dll', @ScriptDir&'\backup_dll'&$i&'\PROGRAMS\7-Zip\', 8)
				      ExitLoop
				   EndIf
				Next
			 EndIf
			 
$script=@ScriptDir&'\resources\_script'
; поиск файлов
	If FileExists($script) Then
	  FileFindNextFirst($script)
While 1
  $tempname = FileFindNext()
  If $tempname = "" Then ExitLoop
	 If StringRight( $tempname, 8 )  = "_scr.txt" Then
		$aPath = StringRegExp($tempname, "(^.*)\\(.*)$", 3)
		$aName = StringRegExp($aPath[1], "(.*)_(.*)_(.*)", 3)
		If $aName[1]="s32" Then $folder=$inputi386&"\system32\"
		If $aName[1]="386" Then $folder=$inputi386&"\"
		If $aName[1]="7-Zip" Then $folder=$inputprg0&"\7-Zip\"
		IniWrite ( $tempname, "FILENAMES", "Exe", $folder&$aName[0] )
		IniWrite ( $tempname, "FILENAMES", "SaveAs", $folder&$aName[0] )
		FileSetAttrib($folder&$aName[0], "-RASHT")
		$sPath = StringTrimLeft($tempname, StringLen(@ScriptDir&'\'))
		If FileExists($folder&$aName[0]) Then ShellExecuteWait(@ScriptDir&'\ResHacker.exe','-script '&$sPath,'','', @SW_HIDE )

	  EndIf
	 If StringRight( $tempname, 8 )  = "eous.txt" Then
		 If Not _FileReadToArray($tempname,$aRecords) Then 
			MsgBox(4096,"Ошибка", "Ошибка чтения массива", @error) 
			Exit 
		 EndIf
		   For $i=1 To $aRecords[0]
			; решение проблемы пустых строк, пропускать цикл для пустой строки
			If $aRecords[$i]<>'' Then
			$aRes = StringSplit($aRecords[$i], "|")
			If $aRes[1]="s32" Then $folder=$inputi386&"\system32\"
			If $aRes[1]="386" Then $folder=$inputi386&"\"
			FileSetAttrib($folder&$aRes[2], "-RASHT")
			; патч
			If FileExists($folder&$aRes[2]) Then ShellExecuteWait(@ScriptDir&'\ResHacker.exe','-modify '&$folder&$aRes[2]&', '&$folder&$aRes[2]&', '&@ScriptDir&'\'&$aRes[3],'','', @SW_HIDE )
			EndIf
		   Next
	  EndIf
WEnd
EndIf
GUICtrlSetData($Label000, 'Готово')
		; кнопки "Обзор"
	  Case $msg = $filewim
		$tmpwim = FileSelectFolder ( "Указать папку i386 или MiniNT",'','3',@WorkingDir & '')
		GUICtrlSetData($inputi386z, $tmpwim)
	  Case $msg = $filezip
		$tmpzip = FileSelectFolder ( "Указать папку PROGRAMS",'','3',@WorkingDir & '')
		GUICtrlSetData($inputprg, $tmpzip)
	  Case $msg = $GUI_EVENT_CLOSE
		ExitLoop
   EndSelect
WEnd



;========================================
; функция поиска всех файлов в каталоге (NIKZZZZ)
Func FileFindNextFirst($FindCat) 
  $Stack[0] = 1 
  $Stack1[1] = $FindCat 
  $Stack[$Stack[0]] = FileFindFirstFile($Stack1[$Stack[0]] & "\*.*") 
  Return $Stack[$Stack[0]] 
EndFunc   ;==>FileFindNextFirst 
 
Func FileFindNext() 
  While 1 
    $file = FileFindNextFile($Stack[$Stack[0]]) 
    If @error Then 
      FileClose($Stack[$Stack[0]]) 
      If $Stack[0] = 1 Then 
        Return "" 
      Else 
        $Stack[0] -= 1 
        ContinueLoop 
      EndIf 
    Else 
      If StringInStr(FileGetAttrib($Stack1[$Stack[0]] & "\" & $file), "D") > 0 Then 
        $Stack[0] += 1 
        $Stack1[$Stack[0]] = $Stack1[$Stack[0] - 1] & "\" & $file 
        $Stack[$Stack[0]] = FileFindFirstFile($Stack1[$Stack[0]] & "\*.*") 
        ContinueLoop 
      Else 
        Return $Stack1[$Stack[0]] & "\" & $file 
      EndIf 
    EndIf 
  WEnd 
EndFunc   ;==>FileFindNext


; (3) устранение проблем интерфейса
Func _WinAPI_GetThemeColor($hWnd, $sClass, $iPart, $iState, $iProp)
	Local $hTheme = DllCall('uxtheme.dll', 'ptr', 'OpenThemeData', 'hwnd', $hWnd, 'wstr', $sClass)
	Local $Ret = DllCall('uxtheme.dll', 'lresult', 'GetThemeColor', 'ptr', $hTheme[0], 'int', $iPart, 'int', $iState, 'int', $iProp, 'dword*', 0)

	If (@error) Or ($Ret[0] < 0) Then
		$Ret = -1
	EndIf
	DllCall('uxtheme.dll', 'lresult', 'CloseThemeData', 'ptr', $hTheme[0])
	If $Ret = -1 Then
		Return SetError(1, 0, -1)
	EndIf
	Return SetError(0, 0, BitOR(BitAND($Ret[5], 0x00FF00), BitShift(BitAND($Ret[5], 0x0000FF), -16), BitShift(BitAND($Ret[5], 0xFF0000), 16)))
EndFunc   ;==>_WinAPI_GetThemeColor