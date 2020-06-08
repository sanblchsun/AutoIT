;  @AZJIO 28.08.2010
; AutoIt3 v3.2.12.1 - 3.3.4.0, на 3.2.12.1  компактней.
; сохраняем несколько сессий, при старте программы все сессии в текущем каталоге будут найдены и можно переключаться между ними. Особенно удобно при переключениями между виндами или LiveCD, когда нужно открыть сессию каталогов, создав рабочую обстановку.
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=SaveFolders.exe
#AutoIt3Wrapper_icon=SaveFolders.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=SaveFolders.exe
#AutoIt3Wrapper_Res_Fileversion=0.9.0.0
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;ModernMenuRaw.au3 - http://www.autoitscript.com/forum/index.php?showtopic=20967
#include "ModernMenuRaw.au3"
#include <Array.au3>

#NoTrayIcon
Opt("GUIOnEventMode", 1)

Global $sTmp, $d, $file, $file_open0, $obj="[CLASS:Edit; INSTANCE:1]", $1a, $1f, $1n, $1g, $Tr7=0
Global $avTrayItems[1] ;создаём с чередующимся через три элемента массив, с элементами идентификации ID, имя пункта, имя меню. К массиву будем добавлять по три элемента группой.
		
    ; Case 'WIN_2000', 'WIN_XP', 'WIN_2003'
Switch @OSVersion
    Case 'WIN_VISTA', 'WIN_7'
        $obj = "[CLASS:ToolbarWindow32; INSTANCE:2]"
		$Tr7=1
    Case Else
		HotKeySet("{F2}", "_Rename") ; переименование файлов не затрагивая расширение
EndSwitch

; HotKeySet('!{ESC}', "_Quit") ;по желанию выход по ALT+ESC
HotKeySet("{F1}", "_Rename2") ; переименование файлов
HotKeySet("{F9}", "_CreateFT") ; создаём папку
$CrTx="{F10}"
HotKeySet($CrTx, "_CreateFT") ; создаём файл текстовый

$langdef = '0000'&@OSLang ; читаем язык по умолчанию

; En
$LngES='Edit session'
$LngNF='Filename'
$LngDad='drag-and-drop'
$LngAdd='Add'
$LngDel='Remove item'
$LngRe='Rerun'
$LngReH='To update the tray'&@CRLF&'needs to be restarted'
$LngCS='current startup'
$LngOF='Open these directories'
$LngAc='Actions'
$LngEx='Exit'
$LngRS='Rerun to update the list of current'
$LngSR='Save open folders and rerun'
$LngCf='Close the open folders'
$LngAdS='Add session'
$LngFP='Program Folder'
$LngAb='About'
$LngEr='Error'
$LngM1='Unable to open file.'
$LngM2='Предупреждение'
$LngM3='Path exists in the session'&@CRLF&'and will not be added.'
$LngFs='Select Folder'
$LngOs='Open session'
$LngCf1='Close these directories'
$LngSS='Save Session'
$LngID='Not Found ID'
$LngM4='No folders'
$LngAbT1="About SaveFolders v0.9"
$LngAbT2="Hot keys"&@CRLF& _
"F1 - rename extension"&@CRLF& _
"F2 - renamed without extension"&@CRLF& _
"F9 - create a folder"&@CRLF& _
"F10 - create a text file"&@CRLF& _
"ALT+ESC - output"&@CRLF&@CRLF&"		@AZJIO 28.08.2010"

; Ru
; если есть русский в раскладках клавиатуры, то использовать его
If $langdef = 00000419 Then
	$LngES='Редактировать сессию'
	$LngNF='Имя файла'
	$LngDad='используйте drag-and-drop'
	$LngAdd='Добавить'
	$LngDel='Удалить пункт'
	$LngRe='Перезапуск'
	$LngReH='Для обновления в трее'&@CRLF&'требуется перезапуск'
	$LngCS='текущие при старте'
	$LngOF='Открыть эти каталоги'
	$LngAc='Действия'
	$LngEx='Выход'
	$LngRS='Перезапуск для обновление списка текущих'
	$LngSR='Сохранить открытые каталоги и перезапуск'
	$LngCf='Закрыть открытые каталоги'
	$LngAdS='Добавить сессию'
	$LngFP='Папка программы'
	$LngAb='О программе'
	$LngEr='Ошибка'
	$LngM1='Невозможно открыть файл.'
	$LngM2='Предупреждение'
	$LngM3='Добавляемый путь существует в сессии'&@CRLF&'и не будет добавлен.'
	$LngFs='Выбрать добавляемую папку'
	$LngOs='Открываем сессию'
	$LngCf1='Закрыть эти каталоги'
	$LngSS='Сохраняем сессию'
	$LngID='Не найден ID'
	$LngM4='нет папки'
	$LngAbT1="О программе SaveFolders v0.9"
	$LngAbT2="Горячие клавиши"&@CRLF& _
	"F1 - переименование c расширением"&@CRLF& _
	"F2 - переименование без расширения"&@CRLF& _
	"F9 - создание папки"&@CRLF& _
	"F10 - создание текстового файла"&@CRLF& _
	"ALT+ESC - выход"&@CRLF&@CRLF&"		@AZJIO 28.08.2010"
EndIf

$1a='a'
$1f='f'
$1n='n'
$1g='g'
If $langdef = 00000419 Then
	$1a='ф'
	$1f='а'
	$1n='т'
	$1g='п'
EndIf

_SetFlashTimeOut(250)
If @compiled=0 Then
	$nTrayIcon1= _TrayIconCreate("SaveFolders", "shell32.dll", -111)
Else
	$nTrayIcon1= _TrayIconCreate("SaveFolders", "SaveFolders.exe", -1)
EndIf
$nTrayMenu1		= _TrayCreateContextMenu()
$bUseAdvTrayMenu = FALSE

; Окно "Редактирование сессии"
$nMain = GUICreate($LngES, 602, 285, -1, -1, -1, 0x00000010) ;drag-and-drop

GUISetBkColor (0xF9F9F9)
$Label5 = GUICtrlCreateLabel($LngNF, 10,3,260,16)
GUICtrlCreateLabel ($LngDad, 400,3,200,16)

$Folderlist = GUICtrlCreateList ("", 10, 24, 580, 230)
GUICtrlSetState(-1, 8)
GUISetOnEvent(-13, "_Folderlist")

$nOpen = GUICtrlCreateButton ($LngAdd, 160, 255, 80, 24)
GUICtrlSetOnEvent(-1, "_nOpen")
$nDel = GUICtrlCreateButton ($LngDel, 250, 255, 90, 24)
GUICtrlSetOnEvent(-1, "_nDel")
$nRestart = GUICtrlCreateButton ($LngRe, 350, 255, 80, 24)
GUICtrlSetOnEvent(-1, "_restart")
GUICtrlSetTip(-1, $LngReH)

GUISetOnEvent(-3, "_sdf")

$search = FileFindFirstFile(@ScriptDir & "\*.inc")
If $search <> -1 Then
For $d = 1 To 20
    $file_open = FileFindNextFile($search) 
    If @error Then ExitLoop
	_add(25)
Next
EndIf
FileClose($search)

_TrayCreateItem("") 

$curent = _TrayCreateMenu($LngCS)
_TrayItemSetIcon(-1, "shell32.dll", -5)
_TrayCreateItem("")

$allfoldercur= _TrayCreateItem($LngOF, $curent)
GUICtrlSetOnEvent(-1, "_allfolder")
_TrayItemSetIcon(-1, "shell32.dll", -5)
_ArrayAdd( $avTrayItems,Eval('allfoldercur'))
_ArrayAdd( $avTrayItems,'O')
_ArrayAdd( $avTrayItems, 'grup0')
_TrayCreateItem("", $curent)

$y=0
$AllWindows = WinList()
For $i = 1 To $AllWindows[0][0]
	If _IsVisible($AllWindows[$i][1]) and $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 13)='\explorer.exe' Then
		$y+=1
		$tmp=ControlGetText ( $AllWindows[$i][0], '', $obj)
		If $Tr7=1 Then
			If $tmp='' Then $tmp=$AllWindows[$i][0]
			$tmp=StringRegExpReplace($tmp,'(.*)(.:\\.*)', '\2')
			If Not FileExists($tmp)  Then ContinueLoop
		EndIf
		Assign('grup0' & $y, _TrayCreateItem($tmp, $curent))
		GUICtrlSetOnEvent(-1, "_TrayItemHit")
		_TrayItemSetIcon(-1, "shell32.dll", -4)
		_ArrayAdd( $avTrayItems,Eval('grup0' & $y))
		_ArrayAdd( $avTrayItems,$tmp)
		_ArrayAdd( $avTrayItems, 'grup0_' & $y)
	EndIf
Next


$action = _TrayCreateMenu($LngAc)
_TrayItemSetIcon(-1, "shell32.dll", -177)

$nUpd= _TrayCreateItem($LngRS, $action)
GUICtrlSetOnEvent(-1, "_restart")
_TrayItemSetIcon(-1, "shell32.dll", -147)

$nSave= _TrayCreateItem($LngSR, $action)
GUICtrlSetOnEvent(-1, "_save")
_TrayItemSetIcon(-1, "shell32.dll", -195)

$nClose= _TrayCreateItem($LngCf, $action)
GUICtrlSetOnEvent(-1, "_close")
_TrayItemSetIcon(-1, "shell32.dll", -110)

$nAdd= _TrayCreateItem($LngAdS, $action)
GUICtrlSetOnEvent(-1, "_addses")
_TrayItemSetIcon(-1, "shell32.dll", -5)

$nSFolder= _TrayCreateItem($LngFP, $action)
GUICtrlSetOnEvent(-1, "_sfolder")
_TrayItemSetIcon(-1, "shell32.dll", -4)

$nAbout= _TrayCreateItem($LngAb, $action)
GUICtrlSetOnEvent(-1, "_about")
_TrayItemSetIcon(-1, "shell32.dll", -222)

;_ArrayDisplay( $avTrayItems, "Смотрим текущий массив" )
$nExit = _TrayCreateItem($LngEx) 
GUICtrlSetOnEvent(-1, "_Quit")
_TrayItemSetIcon(-1, "shell32.dll", -216)

_TrayIconSetState()

While 1
    Sleep(20)
WEnd

Func _GUI() ; вызов окна "Редактирование сессии"
	;Opt("TrayIconHide", 1) ; скрываем иконку в трее
;деактивация пунктов
For $i = 1 To UBound($avTrayItems) - 1 Step 3
$n = _ArraySearch($avTrayItems, $avTrayItems[$i], 1)
GUICtrlSetState($avTrayItems[$n],128)
    If @error Then ExitLoop
Next
GUICtrlSetState($nAdd,128)
GUICtrlSetState($nUpd,128)
GUICtrlSetState($nSave,128)
GUICtrlSetState($nClose,128)
	
	$msg = $nMain
	GUISetState()
	_edit()
	$file_open = StringRegExpReplace($file_open0, "(^.*)\\(.*)$", '\2')
	GUICtrlSetData($Label5, $file_open)
	$file = FileOpen($file_open0, 0)
	If $file = -1 Then
 	   MsgBox(0, $LngEr, $LngM1)
 	   return
	EndIf
	$sTmp = FileRead($file)
	FileClose($file)
	$aPath = StringSplit($sTmp, "|")
	GUICtrlDelete($Folderlist)
	$Folderlist = GUICtrlCreateList ("", 10, 24, 580, 230)
	GUICtrlSetState(-1, 8)
	GUICtrlSetData($Folderlist, $sTmp)
EndFunc


Func _sdf() 
For $i = 1 To UBound($avTrayItems) - 1 Step 3
$n = _ArraySearch($avTrayItems, $avTrayItems[$i], 1)
GUICtrlSetState($avTrayItems[$n],64)
    If @error Then ExitLoop
Next
GUICtrlSetState($nAdd,64)
GUICtrlSetState($nUpd,64)
GUICtrlSetState($nSave,64)
GUICtrlSetState($nClose,64)
            GUISetState(@SW_HIDE, $nMain)
EndFunc


Func _Folderlist() 
			If StringInStr(FileGetAttrib(@GUI_DRAGFILE), "D") = 0 Then return
			If StringInStr($sTmp&'|', @GUI_DRAGFILE&'|')>0 Then
				MsgBox(0, $LngM2, $LngM3)
				return
			EndIf
			$sTmp &= "|"&@GUI_DRAGFILE
			_updedit()
EndFunc

Func _nDel() 
			$myFolder = GUICtrlRead($Folderlist)
			$myFolder=StringRegExpReplace($myFolder,"[][{}()+.\\^$=#]", "\\$0")
			$sTmp = StringRegExpReplace($sTmp&'|', $myFolder&'\|', '')
			;$sTmp = StringRegExpReplace($sTmp, '\|\|', '|')
			;If StringLeft( $sTmp, 1 )='|' Then $sTmp = StringTrimLeft( $sTmp ,1 )
			If StringRight( $sTmp, 1 )='|' Then $sTmp = StringTrimRight( $sTmp ,1 )
			_updedit()
EndFunc

Func _nOpen() 
			$addfold = FileSelectFolder ( $LngFs,'')
			If @error Then return
			If StringInStr($sTmp, $addfold)>0 Then
				MsgBox(0, $LngM2, $LngM3)
				return
			EndIf
			$sTmp &= "|"&$addfold
			_updedit()
EndFunc

; обновление файла при редактировании сессии
Func _updedit()
			$file = FileOpen($file_open0, 2)
			If $file = -1 Then
				MsgBox(0, $LngEr, $LngM1)
				return
			EndIf
			FileWrite($file, $sTmp)
			FileClose($file)
			GUICtrlDelete($Folderlist)
			$Folderlist = GUICtrlCreateList ("", 10, 24, 580, 230)
			GUICtrlSetState(-1, 8)
			GUICtrlSetData($Folderlist, $sTmp)
EndFunc  ;==>_addses

; добавить сессию
Func _addses()
	GUICtrlSetState(@GUI_CTRLID,4)
	$y=0
	$d+=1
	$file_open = FileOpenDialog($LngOs, @ScriptDir & "", "Session (*.inc)", 1 + 4 , "Session.inc")
	If @error Then return
	_add(0)
EndFunc  ;==>_addses

; добавить пункты в меню трея для файлов сессий
Func _add($sor)
	$file = FileOpen($file_open, 0)
	If $file = -1 Then
 	   MsgBox(0, $LngEr, $LngM1)
 	   return
	EndIf
	$sTmp = FileRead($file)
	FileClose($file)
	$aPath = StringSplit($sTmp, "|")
	$file_open0=$file_open
	If StringInStr($file_open, "\")>0 Then $file_open = StringRegExpReplace($file_open, "(^.*)\\(.*)$", '\2')
	$file_open = StringTrimRight( $file_open, 4 ) 
	Assign('Session' & $d, _TrayCreateMenu ($file_open,-1,$sor))
	_TrayItemSetIcon(-1, "shell32.dll", -5)
	
	Assign('edit' & $d, _TrayCreateItem($LngES, Eval('Session' & $d)))
	GUICtrlSetOnEvent(-1, "_GUI")
	_TrayItemSetIcon(-1, "shell32.dll", -2)
	_ArrayAdd( $avTrayItems,Eval('edit' & $d))
	_ArrayAdd( $avTrayItems,'E')
	If StringInStr($file_open0, "\")=0 Then $file_open0 = @ScriptDir & "\" & $file_open0
	_ArrayAdd( $avTrayItems,$file_open0)
	
	Assign('allfolder' & $d, _TrayCreateItem($LngOF, Eval('Session' & $d)))
	GUICtrlSetOnEvent(-1, "_allfolder")
	_TrayItemSetIcon(-1, "shell32.dll", -5)
	_ArrayAdd( $avTrayItems,Eval('allfolder' & $d))
	_ArrayAdd( $avTrayItems,'O')
	_ArrayAdd( $avTrayItems,'grup' & $d)
	
	Assign('sesfolclose' & $d, _TrayCreateItem($LngCf1, Eval('Session' & $d)))
	GUICtrlSetOnEvent(-1, "_sesfolclose")
	_TrayItemSetIcon(-1, "shell32.dll", -110)
	_ArrayAdd( $avTrayItems,Eval('sesfolclose' & $d))
	_ArrayAdd( $avTrayItems,'C')
	_ArrayAdd( $avTrayItems,'grup' & $d)
	
	_TrayCreateItem("", Eval('Session' & $d))
	$y=0
	For $i = 1 To $aPath[0]
		If FileExists($aPath[$i]) Then
			$y+=1
			Assign('grup' & $d & '_' & $y, _TrayCreateItem($aPath[$i], Eval('Session' & $d)))
			GUICtrlSetOnEvent(-1, "_TrayItemHit")
			_TrayItemSetIcon(-1, "shell32.dll", -4)
			_ArrayAdd( $avTrayItems,Eval('grup' & $d & '_' & $y))
			_ArrayAdd( $avTrayItems,$aPath[$i])
			_ArrayAdd( $avTrayItems,'grup' & $d & '_' & $y)
		EndIf
	Next
EndFunc  ;==>_add

Func _save()
	GUICtrlSetState(@GUI_CTRLID,4)
	$file_save = FileSaveDialog( $LngSS, @ScriptDir & "", "Session (*.inc)", 24, "Session.inc")
	If @error Then return
	If StringRight($file_save, 4 )<>'.inc' Then $file_save&='.inc'
	$file = FileOpen($file_save, 2)
	If $file = -1 Then
 	   MsgBox(0, $LngEr, $LngM1)
 	   return
	EndIf
	$AllWindows = WinList()
	$sTmp = ""
	For $i = 1 To $AllWindows[0][0]
		If _IsVisible($AllWindows[$i][1]) And $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 13)='\explorer.exe' Then
			$tmp=ControlGetText ( $AllWindows[$i][0], '', $obj)
			If $Tr7=1 Then
				If $tmp='' Then $tmp=$AllWindows[$i][0]
				$tmp=StringRegExpReplace($tmp,'(.*)(.:\\.*)', '\2')
				If Not FileExists($tmp)  Then ContinueLoop
			EndIf
			If $sTmp = "" Then
				$sTmp &= $tmp ; создаём список путей
			Else
				$sTmp &= "|"&$tmp
			EndIf
		EndIf
	Next
	FileWrite($file, $sTmp)
	FileClose($file)
	_restart()
EndFunc  ;==>_save


; редактировать сессию, поиск ID элемента, считывание пути, отправление для редактирования
Func _edit()
	GUICtrlSetState(@GUI_CTRLID,128+4)
    Local $n = _ArraySearch($avTrayItems, @GUI_CTRLID, 1)
    If @error Then
		MsgBox(0, $LngEr, $LngID)
		Exit
    EndIf
		$n+=2
	$file_open0=$avTrayItems[$n]
EndFunc  ;==>_edit

; открыть все папки, поиск ID элемента, считывание имя группы, открытие папок группы
Func _allfolder()
	If $Tr7=1 Then ; условие запрета на повторное открытие каталогов в Win7
		$AllWindows = WinList()
		Local $sTmp='|'
		For $i = 1 To $AllWindows[0][0]
			If _IsVisible($AllWindows[$i][1]) and $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 13)='\explorer.exe' Then
				$y+=1
				$tmp=ControlGetText ( $AllWindows[$i][0], '', $obj)
				If $tmp='' Then $tmp=$AllWindows[$i][0]
				$tmp=StringRegExpReplace($tmp,'(.*)(.:\\.*)', '\2')
				If Not FileExists($tmp)  Then ContinueLoop
				$sTmp&=$tmp&'|'
			EndIf
		Next
	EndIf
		
	GUICtrlSetState(@GUI_CTRLID,4)
    Local $n = _ArraySearch($avTrayItems, @GUI_CTRLID, 1)
    If @error Then
		MsgBox(0, $LngEr, $LngID)
		Exit
    EndIf
		$n+=2
	For $i = 1 To 35
		$z = _ArraySearch($avTrayItems, $avTrayItems[$n]&'_'&$i, 1)
		If @error Then ExitLoop
		$z-=1
		If Not FileExists($avTrayItems[$z]) Then ContinueLoop
		If $Tr7=1 Then
			If StringInStr('|'&$sTmp&'|', '|'&$avTrayItems[$z]&'|')=0 Then Run('Explorer.exe "'&$avTrayItems[$z]&'"')
		Else
			Run('Explorer.exe "'&$avTrayItems[$z]&'"')
		EndIf
	Next
EndFunc  ;==>_allfolder

; открыть все папки, поиск ID элемента, считывание имя группы, открытие папок группы
Func _sesfolclose()
	GUICtrlSetState(@GUI_CTRLID,4)
    Local $n = _ArraySearch($avTrayItems, @GUI_CTRLID, 1)
    If @error Then
		MsgBox(0, $LngEr, $LngID)
		Exit
    EndIf
		$n+=2
For $i = 1 To 35
	$z = _ArraySearch($avTrayItems, $avTrayItems[$n]&'_'&$i, 1)
    If @error Then ExitLoop
	$z-=1
	; в обоих случаях, когда имя окна может быть путь и имя папки
	$file_open = StringRegExpReplace($avTrayItems[$z], "(^.*)\\(.*)$", '\2')
	If WinExists($avTrayItems[$z]) And _IsVisible($avTrayItems[$z]) And StringRight(_ProcessGetPath(WinGetProcess($avTrayItems[$z])), 13)='\explorer.exe' Then WinClose($avTrayItems[$z])
	If WinExists($file_open) And _IsVisible($file_open) And StringRight(_ProcessGetPath(WinGetProcess($file_open)), 13)='\explorer.exe' Then WinClose($file_open)
Next
EndFunc  ;==>_sesfolclose

; считывание ID пункта меню, поиск в массиве, сдвиг на 1 и открыть путь
Func _TrayItemHit()
	GUICtrlSetState(@GUI_CTRLID,4)
    Local $i = _ArraySearch($avTrayItems, @GUI_CTRLID, 1)
    If @error Then
		MsgBox(16, $LngEr, $LngEr)
		Exit
    EndIf
		$i+=1
    If Not FileExists($avTrayItems[$i]) Then
        MsgBox(16, $LngEr, $LngM4)
        Return
    EndIf
    Run('Explorer.exe "'&$avTrayItems[$i]&'"')
EndFunc  ;==>_TrayItemHit

; проверка открытых окнон
Func _IsVisible($handle)
	If BitAND(WinGetState($handle), 4) and BitAND(WinGetState($handle), 2) Then
			Return 1
		Else
			Return 0
	EndIf
EndFunc  ;==>_IsVisible

;извлечь путь процесса зная PID
Func _ProcessGetPath($PID)
    If IsString($PID) Then $PID = ProcessExists($PID)
    $Path = DllStructCreate('char[1000]')
    $dll = DllOpen('Kernel32.dll')
    $handle1 = DllCall($dll, 'int', 'OpenProcess', 'dword', 0x0400 + 0x0010, 'int', 0, 'dword', $PID)
    $ret = DllCall('Psapi.dll', 'long', 'GetModuleFileNameEx', 'long', $handle1[0], 'int', 0, 'ptr', DllStructGetPtr($Path), 'long', DllStructGetSize($Path))
    $ret = DllCall($dll, 'int', 'CloseHandle', 'hwnd', $handle1[0])
    DllClose($dll)
    Return DllStructGetData($Path, 1)
EndFunc  ;==>_ProcessGetPath

; закрытие открытых окон
Func _close()
	GUICtrlSetState(@GUI_CTRLID,4)
	$AllWindows = WinList()
	$sTmp = ""
	For $i = 1 To $AllWindows[0][0]
		If _IsVisible($AllWindows[$i][1]) And $AllWindows[$i][0] <> "" And $AllWindows[$i][0] <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($AllWindows[$i][0])), 13)='\explorer.exe' Then
				WinClose($AllWindows[$i][0])
		EndIf
	Next
EndFunc  ;==>_close

Func _restart()
_TrayIconDelete($nTrayIcon1)
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
EndFunc  ;==>_restart

Func _Quit()
_TrayIconDelete($nTrayIcon1)
    Exit
EndFunc

Func _Rename2()
	$window=WinGetTitle('')
    If (_WinGetClass($window) = "CabinetWClass") Or (_WinGetClass($window) = "Progman") Then
    HotKeySet("{F1}")
    HotKeySet("{F2}")
    Send("{F2}")
    Send("{SHIFTDOWN}{END}{SHIFTUP}")
    HotKeySet("{F2}", "_Rename")
    HotKeySet("{F1}", "_Rename2")
	Else
    HotKeySet("{F1}")
    Send("{F1}")
    HotKeySet("{F1}", "_Rename2")
    EndIf
EndFunc

; функцию _Rename заимствовал у Monamo, немного изменив.
;http://www.autoitscript.com/forum/index.php?showtopic=88903
Func _Rename()
    HotKeySet("{F2}"); откл. горячей клавиши
    Send("{F2}")
	$window=WinGetTitle('')
		$adrPath= ControlGetText ( $window, '', $obj)
    If (_WinGetClass($window) = "CabinetWClass") Or (_WinGetClass($window) = "Progman") Then
        $oldClipboard = ClipGet()
        Sleep(100)
        Send("^{insert}")
        $sFilename = ClipGet()
		If StringInStr(FileGetAttrib($adrPath & "\" & $sFilename), "D") = 0 Then ; проверка что объёкт является файлом
        $iExtPosition = StringInStr($sFilename, ".", 0, -1)
        If $iExtPosition <> 0 Then
            $iPosition = StringLen($sFilename) - $iExtPosition+1
            $i = 0
            Do
                Send("+{LEFT}")
                $i += 1
            Until $i = $iPosition
            Send("{SHIFTDOWN}{SHIFTUP}")
        EndIf
        EndIf
        ClipPut($oldClipboard)
    EndIf
    HotKeySet("{F2}", "_Rename"); возвращаем hotkey
EndFunc

Func _WinGetClass($hWnd)
; credit = SmOke_N from post http://www.autoitscript.com/forum/index.php?showtopic=41622&view=findpost&p=309799
    If IsHWnd($hWnd) = 0 And WinExists($hWnd) Then $hWnd = WinGetHandle($hWnd)
    Local $aGCNDLL = DllCall('User32.dll', 'int', 'GetClassName', 'hwnd', $hWnd, 'str', '', 'int', 4095)
    If @error = 0 Then Return $aGCNDLL[2]
    Return SetError(1, 0, '')
EndFunc

Func _CreateFT()
	$L1 =HEX(_WinAPI_GetKeyboardLayout(WinGetHandle('')))
	$window=WinGetTitle('')
	If $window <> "" And $window <> "Program Manager" And StringRight(_ProcessGetPath(WinGetProcess($window)), 13)='\explorer.exe' Then
		If $Tr7=1 Then Send("{ESC}")
		$win_handle = WinGetHandle ($window)
		_SetKeyboardLayout($langdef, $win_handle)
		; Send('!{'&$1a&'}')
		Send('{ALTDOWN}{'&$1a&'}{ALTUP}')
		Sleep(100)
		Send('{'&$1f&'}')
		If @HotKeyPressed=$CrTx Then
			Send('{'&$1n&'}') ; текстовый документ
			_Rename()
		Else
			Send('{'&$1g&'}') ; папка
		EndIf
		_SetKeyboardLayout($L1, $win_handle) ; возвращаем язык по умолчанию
	EndIf
EndFunc

; переключение раскладки клавиатуры
Func _SetKeyboardLayout($sLayoutID, $hWnd)
    Local $ret = DllCall("user32.dll", "long", "LoadKeyboardLayout", "str", $sLayoutID, "int", 0)
    DllCall("user32.dll", "int", "SendMessage", "hwnd", $hWnd, "int", 0x50, "int", 1, "int", $ret[0])
EndFunc

Func _WinAPI_GetKeyboardLayout($hWnd)

	Local $ret

	$ret = DllCall('user32.dll', 'long', 'GetWindowThreadProcessId', 'hwnd', $hWnd, 'ptr', 0)
	If (@error) Or (Not $ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	$ret = DllCall('user32.dll', 'long', 'GetKeyboardLayout', 'long', $ret[0])
	If (@error) Or (Not $ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf
	Return BitAND($ret[0], 0xFFFF)
EndFunc   ;==>_WinAPI_GetKeyboardLayout

Func _sfolder()
    Run('Explorer.exe "'&@ScriptDir&'"')
EndFunc

Func _about()
MsgBox(0, $LngAbT1, $LngAbT2)
EndFunc