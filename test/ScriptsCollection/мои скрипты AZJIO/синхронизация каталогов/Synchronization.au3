#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Synchronization.exe
#AutoIt3Wrapper_Icon=Synchronization.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Synchronization.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Icon_Add=1.ico
#AutoIt3Wrapper_Res_Icon_Add=2.ico
#AutoIt3Wrapper_Res_Icon_Add=3.ico
#AutoIt3Wrapper_Res_Icon_Add=4.ico
#AutoIt3Wrapper_Res_Icon_Add=5.ico
#AutoIt3Wrapper_Res_Field=Version|0.3
#AutoIt3Wrapper_Res_Field=Build|2013.03.04
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2013.03.04 AutoIt3_v3.3.6.1

#NoTrayIcon

#include <ComboConstants.au3>
#include <GuiListView.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include "FileOperations.au3"
#include "_CopyWithProgress.au3"
#include "ForSynchronization.au3"
; #include <Array.au3>

; En
$LngTitle = 'Synchronization of directories'
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngCopy = 'Copy'
$LngSB = 'Statusbar'
$LngRe = 'Restart "Synchronization of directories"'
$LngFld = 'Folder'
$LngPth = 'Path'
$LngSz = 'Size'
$LngDt = 'Date'
$LngCtRH = 'Copy to the right'
$LngCtLH = 'Copy to the right'
$LngDLH = 'Delete from the left'
$LngDRH = 'Delete from the right'
$LngCS1 = 'path (difference)'
$LngCS2 = 'path and size (difference)'
$LngCS3 = 'path and date (difference)'
$LngCS4 = 'path, size and date (difference)'
$LngCS5 = 'path (same)'
$LngCS6 = 'path and size (same)'
$LngCS7 = 'path and date (same)'
$LngCS8 = 'path, size and date (same)'
$LngScn = 'Scan'
$LngAllH = 'Checked / Unchecked'
$LngMEx = 'Open with explorer'
$LngStFl = 'Run file (double click)'
$LngCp1 = 'Copy'
$LngCp2 = 'Copy finished'
$LngCpEr = 'Error copying'
$LngMsk = 'Mask'
$LngSNM = 'Search for other than those specified in the mask'
$LngSub = 'In sub-directories'
$LngKS = 'Convert the size in GB, MB, KB'
$LngRcl = 'Sends a files to the recycle bin'
$LngAtr = 'Remove attributes when you remove'
$LngOpF = 'Open directory'
$LngDLV = 'Removal of the left window'
$LngDErr = 'Failed to delete'
$LngDRV = 'Removal of the right window'
$LngELD = 'Completed removal of the left window, error'
$LngLFE = 'list is empty'
$LngERD = 'Completed removal of the right window, error'
$LngCRW = 'Copy to the right'
$LngErCp = 'Error copying'
$LngEC1 = 'Completed copying'
$LngEC2 = 'file in the right window, errors'
$LngEC3 = 'file in the left window, errors'
$LngCLW = 'Copy in the left window'
$LngErr = 'Error'
$LngMS1 = 'Specify the existing path'
$LngMS2 = 'left and right path pointing to the same directory'
$LngSB1 = 'Scanning directory'
$LngSB2 = 'Failed to create the list'
$LngSB3 = 'Build a list 1, in the view'
$LngSB4 = 'Build a list 2, in the view'
$LngDn = 'Done'
$LngSB5 = 'Folder'
$LngSB6 = 'from'
$LngEF = 'Search for empty folders'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngTitle = 'Синхронизация каталогов'
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngSite = 'Сайт'
	$LngCopy = 'Копировать'
	$LngSB = 'Строка состояния'
	$LngRe = 'Перезапуск утилиты'
	$LngFld = 'Каталог'
	$LngPth = 'Путь'
	$LngSz = 'Размер'
	$LngDt = 'Дата'
	$LngCtRH = 'Копировать в правое окно'
	$LngCtLH = 'Копировать в левое окно'
	$LngDLH = 'Удалить из левого окна'
	$LngDRH = 'Удалить из правого окна'
	$LngCS1 = 'путь различные'
	$LngCS2 = 'путь и размер различные'
	$LngCS3 = 'путь и дата различные'
	$LngCS4 = 'путь, размер и дата различные'
	$LngCS5 = 'путь одинаковые'
	$LngCS6 = 'путь и размер одинаковые'
	$LngCS7 = 'путь и дата одинаковые'
	$LngCS8 = 'путь, размер и дата одинаковые'
	$LngScn = 'Сканировать'
	$LngAllH = 'Снять или поставить галочки в списке'
	$LngMEx = 'Открыть в проводнике'
	$LngStFl = 'Запустить файл (двойной клик)'
	$LngCp1 = 'Копирование'
	$LngCp2 = 'Копирование выполнено'
	$LngCpEr = 'Ошибка копирования'
	$LngMsk = 'Маска'
	$LngSNM = 'Искать, кроме указанных в маске'
	$LngSub = 'В подкаталогах'
	$LngKS = 'Преобразовать размер в Гб, Мб, Кб'
	$LngRcl = 'Удалять в корзину'
	$LngAtr = 'Снимать атрибуты при удалении'
	$LngOpF = 'Открыть каталог'
	$LngDLV = 'Удаление из левого окна'
	$LngDErr = 'Ошибка удаления'
	$LngDRV = 'Удаление из правого окна'
	$LngELD = 'Завершено удаление из левого окна, ошибок'
	$LngLFE = 'Список пуст'
	$LngERD = 'Завершено удаление из правого окна, ошибок'
	$LngCRW = 'Копирование в правое окно'
	$LngErCp = 'Ошибка копирования'
	$LngEC1 = 'Завершено копирование'
	$LngEC2 = 'файлов в правое окно, ошибок'
	$LngEC3 = 'файлов в левое окно, ошибок'
	$LngCLW = 'Копирование в левое окно'
	$LngErr = 'Ошибка'
	$LngMS1 = 'Укажите существующие пути'
	$LngMS2 = 'Правый и левый путь указывают на один и тот же каталог'
	; $LngMS=''
	$LngSB1 = 'Сканирование каталога'
	$LngSB2 = 'Ошибка создания списка'
	$LngSB3 = 'Построение списка 1 в окне просмотра'
	$LngSB4 = 'Построение списка 2 в окне просмотра'
	$LngDn = 'Готово'
	$LngSB5 = 'Каталог'
	$LngSB6 = 'из'
	; $LngSB=''
	$LngEF = 'Поиск пустых папок'
	; $Lng=''
EndIf

Global $FileList41, $FileList42, $Path01, $Path02, $Out1[1][1] = [[0]], $Out2[1][1] = [[0]], $hListView1, $hListView2, $TrRcl = 1, $TrAtr = 1, $TrFrmSize = 1, $TrFrmData = 1, $hRcl, $hAtr, $hFSize, $hFData, $FileCopy1, $FileCopy2, $Tr_Scan=1, $aEF1[1][1] = [[0]], $aEF2[1][1] = [[0]]
Global $TypeFile = '*.txt;*.doc;*.docx;*.xls;*.xlsx|*.avi;*.mpg;*.mpeg;*.mp4;*.vob;*.mkv;*.asf;*.asx;*.wmv;*.mov;*.3gp;*.flv;*.bik|*.mp3;*.wav;*.wma;*.ogg;*.ac3|*.bak;*.gid;*.log;*.tmp' & _
		'|*.htm;*.html;*.css;*.js;*.php|*.bmp;*.gif;*.jpg;*.jpeg;*.png;*.tif;*.tiff|*.exe;*.msi;*.scr;*.dll;*.cpl;*.ax|*.com;*.sys;*.bat;*.cmd'
Global $Mask = '*', $TrInc = True, $TrSub = 125, $ComboMask, $hChInc, $hChSub, $TrSub = 125, $Gui, $Gui1
Global $fDrag = False, $ItemText = '', $DragItemText = '', $iWin7=1

Opt("GUIOnEventMode", 1)
Opt("GUIResizeMode", 802)
GUIRegisterMsg($WM_SIZE, "WM_SIZE")
GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")


Switch @OSVersion
	Case "WIN_2003", "WIN_XP", "WIN_XPe", "WIN_2000"
		$iWin7=0
EndSwitch

$Gui = GUICreate($LngTitle, 570, 490, -1, -1, $WS_OVERLAPPEDWINDOW, $WS_EX_ACCEPTFILES)
If @Compiled Then
	$AutoItExe = @AutoItExe
Else
	$AutoItExe = @ScriptDir & '\Synchronization.dll'
	GUISetIcon($AutoItExe, 99)
EndIf
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
GUISetOnEvent($GUI_EVENT_DROPPED, "_Dropped")

$StatusBar = GUICtrlCreateLabel($LngSB, 5, 490 - 17, 560, 17, $SS_LEFTNOWORDWRAP)
GUICtrlSetResizing(-1, 2 + 64 + 512)

GUICtrlCreateButton('R', 570 - 18, 0, 18, 18)
GUICtrlSetOnEvent(-1, "_Restart")
GUICtrlSetTip(-1, $LngRe)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

GUICtrlCreateButton('@', 570 - 40, 0, 18, 18)
GUICtrlSetOnEvent(-1, "_About")
GUICtrlSetTip(-1, $LngAbout)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

GUICtrlCreateLabel($LngFld & ' 1', 10, 6, -1, 17)
GUICtrlSetResizing(-1, 2 + 32 + 256 + 512)
GUICtrlCreateLabel($LngFld & ' 2', 290, 6, -1, 17)
GUICtrlSetResizing(-1, 8 + 32 + 256 + 512)

$Path1 = GUICtrlCreateInput('', 10, 20, 245, 22)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
; GUICtrlSetResizing(-1,  32 + 512)

$Path2 = GUICtrlCreateInput('', 290, 20, 245, 22)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
; GUICtrlSetResizing(-1, 32 + 512)

$Open1 = GUICtrlCreateButton('opn', 259, 20, 22, 22, $BS_ICON)
GUICtrlSetOnEvent(-1, "_Open1")
GUICtrlSetImage(-1, 'shell32.dll', 4, 0)
; GUICtrlSetResizing(-1, 32 + 256 + 512)

$Open2 = GUICtrlCreateButton('opn', 539, 20, 22, 22, $BS_ICON)
GUICtrlSetOnEvent(-1, "_Open2")
GUICtrlSetImage(-1, 'shell32.dll', 4, 0)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$ListView1 = GUICtrlCreateListView($LngPth & ' 1|' & $LngSz & '|' & $LngDt, 10, 50, 270, 390, $LVS_SINGLESEL, $LVS_EX_CHECKBOXES + $LVS_EX_FULLROWSELECT+$WS_EX_CLIENTEDGE)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 265)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
; GUICtrlSetResizing(-1, 32 + 64)
$hListView1 = GUICtrlGetHandle($ListView1)

$ListView2 = GUICtrlCreateListView($LngPth & ' 2|' & $LngSz & '|' & $LngDt, 290, 50, 270, 390, $LVS_SINGLESEL, $LVS_EX_CHECKBOXES + $LVS_EX_FULLROWSELECT+$WS_EX_CLIENTEDGE)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 265)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
; GUICtrlSetResizing(-1, 32 + 64)
$hListView2 = GUICtrlGetHandle($ListView2)

$CopyToRight = GUICtrlCreateButton('>', 258, 446, 22, 22, $BS_ICON)
GUICtrlSetOnEvent(-1, "_CopyToRight")
GUICtrlSetTip(-1, $LngCtRH)
GUICtrlSetImage(-1, $AutoItExe, 201, 0)
GUICtrlSetResizing(-1, 64 + 8 + 256 + 512)

$CopyToLeft = GUICtrlCreateButton('<', 290, 446, 22, 22, $BS_ICON)
GUICtrlSetOnEvent(-1, "_CopyToLeft")
GUICtrlSetTip(-1, $LngCtLH)
GUICtrlSetImage(-1, $AutoItExe, 202, 0)
GUICtrlSetResizing(-1, 64 + 8 + 256 + 512)

$DelLeft = GUICtrlCreateButton('v', 228, 446, 22, 22, $BS_ICON)
GUICtrlSetOnEvent(-1, "_DelLeft")
GUICtrlSetTip(-1, $LngDLH)
GUICtrlSetImage(-1, $AutoItExe, 203, 0)
GUICtrlSetResizing(-1, 64 + 8 + 256 + 512)

$DelRight = GUICtrlCreateButton('v', 320, 446, 22, 22, $BS_ICON)
GUICtrlSetOnEvent(-1, "_DelRight")
GUICtrlSetTip(-1, $LngDRH)
GUICtrlSetImage(-1, $AutoItExe, 203, 0)
GUICtrlSetResizing(-1, 64 + 8 + 256 + 512)

$ComboM = GUICtrlCreateCombo("", 10, 449, 175, 23, $CBS_DROPDOWNLIST + $WS_VSCROLL) ; стиль не редактируемого списка
GUICtrlSetData(-1, '0 ' & $LngCS1 & '|1 ' & $LngCS2 & '|2 ' & $LngCS3 & '|3 ' & $LngCS4 & '|' & _
		'4 ' & $LngCS5 & '|5 ' & $LngCS6 & '|6 ' & $LngCS7 & '|7 ' & $LngCS8, '3 ' & $LngCS4)
GUICtrlSetOnEvent(-1, "_Compare")
GUICtrlSetResizing(-1, 2 + 64 + 512)

$Setting = GUICtrlCreateButton('set', 445, 446, 22, 22, $BS_ICON)
GUICtrlSetOnEvent(-1, "_Setting")
GUICtrlSetImage(-1, $AutoItExe, 204, 0)
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)

$Scan = GUICtrlCreateButton($LngScn, 470, 446, 90, 28)
GUICtrlSetOnEvent(-1, "_Scan")
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)

$hAllChec1 = GUICtrlCreateCheckbox('', 209, 446, 16, 16)
GUICtrlSetOnEvent(-1, "_AllChec1")
GUICtrlSetResizing(-1, 64 + 8 + 256 + 512)
GUICtrlSetTip(-1, $LngAllH)
GUICtrlSetState(-1, $GUI_HIDE)

$hAllChec2 = GUICtrlCreateCheckbox('', 349, 446, 16, 16)
GUICtrlSetOnEvent(-1, "_AllChec2")
GUICtrlSetResizing(-1, 64 + 8 + 256 + 512)
GUICtrlSetTip(-1, $LngAllH)
GUICtrlSetState(-1, $GUI_HIDE)

$EmptyFolders = GUICtrlCreateButton('s', 415, 446, 22, 22, $BS_ICON)
GUICtrlSetOnEvent(-1, "_EmptyFolders")
GUICtrlSetTip(-1, $LngEF)
GUICtrlSetImage(-1, $AutoItExe, 205, 0)
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)

$ContMenu = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
GUICtrlCreateMenuItem($LngMEx, $ContMenu)
GUICtrlSetOnEvent(-1, "_OpenExplorer")
GUICtrlCreateMenuItem($LngStFl, $ContMenu)
GUICtrlSetOnEvent(-1, "_OpenFile")
$hMenu = GUICtrlGetHandle($ContMenu)

GUISetState()
GUIRegisterMsg($WM_NOTIFY, 'WM_NOTIFY')
While 1
	Sleep(100)
	If $FileCopy1 And $FileCopy2 Then
		$tmp = StringRegExpReplace($FileCopy1, '(^.*)\\(.*)$', '\2')
		GUICtrlSetData($StatusBar, $LngCp1 & '... "' & $tmp & '"')
		If FileGetSize($FileCopy1) > 10000000 Then
			If _CopyWithProgress($FileCopy1, $FileCopy2) Then GUICtrlSetData($StatusBar, $LngCp2 & ' - "' & $tmp & '"')
		Else
			If FileCopy($FileCopy1, $FileCopy2, 9) Then GUICtrlSetData($StatusBar, $LngCp2 & ' - "' & $tmp & '"')
		EndIf
		$FileCopy1 = ''
		$FileCopy2 = ''
	EndIf
WEnd

Func _EmptyFolders()
	$Path01 = GUICtrlRead($Path1)
	$Path02 = GUICtrlRead($Path2)
	If Not (FileExists($Path01) Or FileExists($Path02)) Then
		MsgBox(0, $LngErr, $LngMS1, 0, $Gui)
		Return
	EndIf
	_Clear()
	Dim $Out1[1][1] = [[0]]
	Dim $Out2[1][1] = [[0]]
	$Tr_Scan=0
	_DisableGuiBtn($GUI_DISABLE)
	
	If StringRight($Path01, 1) = '\' Then $Path01 = StringTrimRight($Path01, 1)
	If FileExists($Path01) Then
		$aEF1=_InArrEF($Path01)
		If Not @error Then
			For $i = 1 To $aEF1[0][0]
				$aEF1[$i][4] = GUICtrlCreateListViewItem($aEF1[$i][0] & '|0|' & _ConvertFileData($aEF1[$i][2]), $ListView1)
				GUICtrlSetState(-1, 1)
			Next
			If $aEF1[0][0] Then
				GUICtrlSetState($hAllChec1, $GUI_SHOW + $GUI_CHECKED)
				GUICtrlSetState($DelLeft, $GUI_ENABLE)
			EndIf
		EndIf
	EndIf
	
	If StringRight($Path02, 1) = '\' Then $Path02 = StringTrimRight($Path02, 1)
	If FileExists($Path02) And $Path01 <> $Path02 Then
		$aEF2=_InArrEF($Path02)
		If Not @error Then
			For $i = 1 To $aEF2[0][0]
				$aEF2[$i][4] = GUICtrlCreateListViewItem($aEF2[$i][0] & '|0|' & _ConvertFileData($aEF2[$i][2]), $ListView2)
				GUICtrlSetState(-1, 1)
			Next
			If $aEF2[0][0] Then
				GUICtrlSetState($hAllChec2, $GUI_SHOW + $GUI_CHECKED)
				GUICtrlSetState($DelRight, $GUI_ENABLE)
			EndIf
		EndIf
	EndIf
	
	GUICtrlSetState($Scan, $GUI_ENABLE)
	GUICtrlSetState($Setting, $GUI_ENABLE)
	GUICtrlSetState($EmptyFolders, $GUI_ENABLE)
	
	GUICtrlSetData($StatusBar, $LngDn & '! ' & $LngSB5 & '1 = (' & $aEF1[0][0] & '), ' & $LngSB5 & '2 = (' & $aEF2[0][0] & ')')
EndFunc

Func _InArrEF($Path)
	Local $aTmp0 =_FO_SearchEmptyFolders($Path, 0, 1, 0)
	If @error Then
		Dim $aTmp0[1][1] = [[0]]
		Return SetError(1, 0, $aTmp0)
	EndIf
	
	Local $aTmp[$aTmp0[0] + 1][5] = [[$aTmp0[0]]]
	For $i = 1 To $aTmp0[0]
		$aTmp[$i][0] = $aTmp0[$i]
		; $out[$i][1] = 0
		$aTmp[$i][2] = FileGetTime(StringTrimRight($Path & '\' & $aTmp[$i][0], 1), 0, 1)
		; $aTmp[$i][3] = 
	Next
	; _ArrayDisplay($aTmp, 'Array')
	Return $aTmp
EndFunc


Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	Local $hWndFrom, $iCode, $tNMHDR, $tInfo, $tmp

	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, 'hWndFrom'))
	$iCode = DllStructGetData($tNMHDR, 'Code')
	Switch $hWndFrom
		Case $hListView1
			Switch $iCode
				Case $NM_RCLICK ; правый клик - вызов конт меню
					$tmp = GUICtrlRead($ListView1)
					If Not $tmp Then Return
					$tmp = GUICtrlRead($tmp)
					If $tmp = '' Then Return
					$ItemText = $Path01 & '\' & StringLeft($tmp, StringInStr($tmp, '|') - 1)
					$x = MouseGetPos(0)
					$y = MouseGetPos(1)
					DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $Gui, "ptr", 0)
				Case $NM_DBLCLK
					$tmp = GUICtrlRead($ListView1)
					If Not $tmp Then Return
					$tmp = GUICtrlRead($tmp)
					If $tmp = '' Then Return
					$tmp = $Path01 & '\' & StringLeft($tmp, StringInStr($tmp, '|') - 1)
					If FileExists($tmp) Then ShellExecute($tmp)
				Case $LVN_BEGINDRAG
					If Not $Tr_Scan Then Return $GUI_RUNDEFMSG
					$tmp = GUICtrlRead($ListView1)
					If Not $tmp Then Return
					$tmp = GUICtrlRead($tmp)
					If $tmp = '' Then Return
					$DragItemText = StringLeft($tmp, StringInStr($tmp, '|') - 1)
					$fDrag = 1
				Case $LVN_HOTTRACK
					If Not $Tr_Scan Then Return $GUI_RUNDEFMSG
					Switch $fDrag
						Case 1
							$fDrag = 0
							$DragItemText = ''
						Case 2
							If FileExists($Path02 & '\' & $DragItemText) Then
								$FileCopy1 = $Path02 & '\' & $DragItemText
								$FileCopy2 = $Path01 & '\' & $DragItemText
							Else
								GUICtrlSetData($StatusBar, $LngCpEr)
							EndIf
							$fDrag = 0
					EndSwitch
			EndSwitch
		Case $hListView2
			Switch $iCode
				Case $NM_RCLICK ; правый клик - вызов конт меню
					$tmp = GUICtrlRead($ListView2)
					If Not $tmp Then Return
					$tmp = GUICtrlRead($tmp)
					If $tmp = '' Then Return
					$ItemText = $Path02 & '\' & StringLeft($tmp, StringInStr($tmp, '|') - 1)
					$x = MouseGetPos(0)
					$y = MouseGetPos(1)
					DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $Gui, "ptr", 0)
				Case $NM_DBLCLK
					$tmp = GUICtrlRead($ListView2)
					If Not $tmp Then Return
					$tmp = GUICtrlRead($tmp)
					If $tmp = '' Then Return
					$tmp = $Path02 & '\' & StringLeft($tmp, StringInStr($tmp, '|') - 1)
					If FileExists($tmp) Then ShellExecute($tmp)
				Case $LVN_BEGINDRAG
					If Not $Tr_Scan Then Return $GUI_RUNDEFMSG
					$tmp = GUICtrlRead($ListView2)
					If Not $tmp Then Return
					$tmp = GUICtrlRead($tmp)
					If $tmp = '' Then Return
					$DragItemText = StringLeft($tmp, StringInStr($tmp, '|') - 1)
					$fDrag = 2
				Case $LVN_HOTTRACK
					If Not $Tr_Scan Then Return $GUI_RUNDEFMSG
					Switch $fDrag
						Case 1
							If FileExists($Path01 & '\' & $DragItemText) Then
								$FileCopy1 = $Path01 & '\' & $DragItemText
								$FileCopy2 = $Path02 & '\' & $DragItemText
							Else
								GUICtrlSetData($StatusBar, $LngCpEr)
							EndIf
							$fDrag = 0
						Case 2
							$fDrag = 0
							$DragItemText = ''
					EndSwitch
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc

Func _OpenExplorer()
	If FileExists($ItemText) Then Run('Explorer.exe /select,"' & $ItemText & '"')
	$ItemText = ''
EndFunc

Func _OpenFile()
	If FileExists($ItemText) Then ShellExecute($ItemText)
	$ItemText = ''
EndFunc

Func _AllChec1()
	Local $i, $stat
	_GUICtrlListView_BeginUpdate($hListView1)
	If $Tr_Scan Then
		If $Out1[0][0] Then
			Local $stat = 4
			If GUICtrlRead($hAllChec1) = 1 Then $stat = 1
			For $i = 1 To $Out1[0][0]
				GUICtrlSetState($Out1[$i][4], $stat)
			Next
		EndIf
	Else
		If $aEF1[0][0] Then
			Local $stat = 4
			If GUICtrlRead($hAllChec1) = 1 Then $stat = 1
			For $i = 1 To $aEF1[0][0]
				GUICtrlSetState($aEF1[$i][4], $stat)
			Next
		EndIf
	EndIf
	_GUICtrlListView_EndUpdate($hListView1)
EndFunc

Func _AllChec2()
	Local $i, $stat
	_GUICtrlListView_BeginUpdate($hListView2)
	If $Tr_Scan Then
		If $Out2[0][0] Then
			Local $stat = 4
			If GUICtrlRead($hAllChec2) = 1 Then $stat = 1
			For $i = 1 To $Out2[0][0]
				GUICtrlSetState($Out2[$i][4], $stat)
			Next
		EndIf
	Else
		If $aEF2[0][0] Then
			Local $stat = 4
			If GUICtrlRead($hAllChec2) = 1 Then $stat = 1
			For $i = 1 To $aEF2[0][0]
				GUICtrlSetState($aEF2[$i][4], $stat)
			Next
		EndIf
	EndIf
	_GUICtrlListView_EndUpdate($hListView2)
EndFunc

Func _Setting()
	GUIRegisterMsg($WM_SIZE, "")
	; GUIRegisterMsg($WM_WINDOWPOSCHANGING , "")
	$GP = _ChildCoor($Gui, 340, 210)
	GUISetState(@SW_DISABLE, $Gui)
	$Gui1 = GUICreate('Опции', $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	If Not @Compiled Then GUISetIcon($AutoItExe, 1)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit2")

	GUICtrlCreateLabel($LngMsk, 10, 13, 40, 17)
	$ComboMask = GUICtrlCreateCombo("", 50, 10, 280)
	GUICtrlSetData(-1, '*|' & $TypeFile, '*')
	
	$hChInc = GUICtrlCreateCheckbox($LngSNM, 10, 40, 260, 17)
	If Not $TrInc Then GUICtrlSetState(-1, 1)
	$hChSub = GUICtrlCreateCheckbox($LngSub, 10, 60, 260, 17)
	If $TrSub = 125 Then GUICtrlSetState(-1, 1)
	
	$hFSize = GUICtrlCreateCheckbox($LngKS, 10, 90, 260, 17)
	If $TrFrmSize = 1 Then GUICtrlSetState(-1, 1)
	
	$hRcl = GUICtrlCreateCheckbox($LngRcl, 10, 110, 260, 17)
	If $TrRcl = 1 Then GUICtrlSetState(-1, 1)
	
	$hAtr = GUICtrlCreateCheckbox($LngAtr, 10, 130, 260, 17)
	If $TrAtr = 1 Then GUICtrlSetState(-1, 1)
	
	; $hFData=GUICtrlCreateCheckbox('Преобразовать дату в удобочитаемый вид', 10, 110, 260, 17)
	; If $TrFrmData=1 Then GUICtrlSetState(-1, 1)

	$OK = GUICtrlCreateButton("OK", ($GP[2] - 60) / 2, $GP[3] - 48, 60, 30)
	GUICtrlSetOnEvent(-1, "_OK")
	
	GUISetState(@SW_SHOW, $Gui1)
EndFunc

Func _OK()
	$Mask = GUICtrlRead($ComboMask)
	
	If GUICtrlRead($hAtr) = 1 Then
		$TrAtr = 1
	Else
		$TrAtr = 0
	EndIf
	
	If GUICtrlRead($hChInc) = 1 Then
		$TrInc = False
	Else
		$TrInc = True
	EndIf
	
	If GUICtrlRead($hChSub) = 1 Then
		$TrSub = 125
	Else
		$TrSub = 0
	EndIf
	
	If GUICtrlRead($hFSize) = 1 Then
		$TrFrmSize = 1
	Else
		$TrFrmSize = 0
	EndIf
	
	If GUICtrlRead($hRcl) = 1 Then
		$TrRcl = 1
	Else
		$TrRcl = 0
	EndIf
	
	; If GUICtrlRead($hFData)=1 Then
	; $TrFrmData=1
	; Else
	; $TrFrmData=0
	; EndIf
	_Exit2()
EndFunc

Func _Exit2()
	GUISetState(@SW_ENABLE, $Gui)
	GUIDelete($Gui1)
	GUIRegisterMsg($WM_SIZE, "WM_SIZE")
	; GUIRegisterMsg($WM_WINDOWPOSCHANGING , "WM_WINDOWPOSCHANGING")
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
EndFunc

Func _Open1()
	Local $tmp = FileSelectFolder($LngOpF, '', 2, '', $Gui)
	If @error Then Return
	GUICtrlSetData($Path1, $tmp)
EndFunc

Func _Open2()
	Local $tmp = FileSelectFolder($LngOpF, '', 2, '', $Gui)
	If @error Then Return
	GUICtrlSetData($Path2, $tmp)
EndFunc

Func _Dropped()
	Switch @GUI_DropId
		Case $Path1
			If _FO_IsDir(@GUI_DragFile) Then
				GUICtrlSetData($Path1, @GUI_DragFile)
			Else
				GUICtrlSetData($Path1, '')
			EndIf
		Case $Path2
			If _FO_IsDir(@GUI_DragFile) Then
				GUICtrlSetData($Path2, @GUI_DragFile)
			Else
				GUICtrlSetData($Path2, '')
			EndIf
		Case $ListView1
			If @GUI_DragId <> $ListView2 And _FO_IsDir(@GUI_DragFile) Then GUICtrlSetData($Path1, @GUI_DragFile)
		Case $ListView2
			If @GUI_DragId <> $ListView1 And _FO_IsDir(@GUI_DragFile) Then GUICtrlSetData($Path2, @GUI_DragFile)
	EndSwitch
EndFunc

Func _DelLeft()
	_DisableGuiBtn($GUI_DISABLE)
	GUICtrlSetData($StatusBar, $LngDLV)
	If $Tr_Scan Then ; триггер Сканировать, иначе пустые папки
		Local $kol = 0, $ErrKol = 0, $ErrDel = ''
		If $Out1[0][0] Then
			If $iWin7 Then _GUICtrlListView_BeginUpdate($hListView1)
			For $i = 1 To $Out1[0][0]
				If GUICtrlRead($Out1[$i][4], 1) = 1 Then
					If $TrRcl = 1 Then ; триггер корзины
						If FileExists($Path01 & '\' & $Out1[$i][0]) And FileRecycle($Path01 & '\' & $Out1[$i][0]) Then ; в корзину
							$kol += 1
							GUICtrlSetState($Out1[$i][4], 4)
						Else
							$ErrDel &= $Out1[$i][0] & @CRLF
							$ErrKol += 1
						EndIf
					Else
						If FileExists($Path01 & '\' & $Out1[$i][0]) Then
							If FileDelete($Path01 & '\' & $Out1[$i][0]) Then
								$kol += 1
								GUICtrlSetState($Out1[$i][4], 4)
							Else
								If $TrAtr Then ; триггер снятия атрибутов
									FileSetAttrib($Path01 & '\' & $Out1[$i][0], "-RST")
									If FileDelete($Path01 & '\' & $Out1[$i][0]) Then
										$kol += 1
										GUICtrlSetState($Out1[$i][4], 4)
									Else
										$ErrDel &= $Out1[$i][0] & @CRLF
										$ErrKol += 1
									EndIf
								Else
									$ErrDel &= $Out1[$i][0] & @CRLF
									$ErrKol += 1
								EndIf
							EndIf
						Else
							$ErrDel &= $Out1[$i][0] & @CRLF
							$ErrKol += 1
						EndIf
					EndIf
				EndIf
			Next
			If $iWin7 Then _GUICtrlListView_EndUpdate($hListView1)
			If $ErrDel Then MsgBox(0, $LngDErr & ' (' & $ErrKol & ')', $ErrDel, 0, $Gui)
			GUICtrlSetData($StatusBar, $LngELD & ' ' & $ErrKol)
		Else
			GUICtrlSetData($StatusBar, $LngLFE)
		EndIf
	Else
		Local $kol = 0, $ErrKol = 0, $ErrDel = ''
		If $aEF1[0][0] Then
			If $iWin7 Then _GUICtrlListView_BeginUpdate($hListView1)
			For $i = 1 To $aEF1[0][0]
				If GUICtrlRead($aEF1[$i][4], 1) = 1 Then
					If $TrRcl = 1 Then
						If FileExists($Path01 & '\' & $aEF1[$i][0]) And FileRecycle($Path01 & '\' & $aEF1[$i][0]) Then ; в корзину
							$kol += 1
							GUICtrlSetState($aEF1[$i][4], 4)
						Else
							$ErrDel &= $aEF1[$i][0] & @CRLF
							$ErrKol += 1
						EndIf
					Else
						If FileExists($Path01 & '\' & $aEF1[$i][0]) Then
							If DirRemove($Path01 & '\' & $aEF1[$i][0], 1) Then
								$kol += 1
								GUICtrlSetState($aEF1[$i][4], 4)
							Else
								If $TrAtr Then
									FileSetAttrib($Path01 & '\' & $aEF1[$i][0], "-R", 1)
									If DirRemove($Path01 & '\' & $aEF1[$i][0], 1) Then
										$kol += 1
										GUICtrlSetState($aEF1[$i][4], 4)
									Else
										$ErrDel &= $aEF1[$i][0] & @CRLF
										$ErrKol += 1
									EndIf
								Else
									$ErrDel &= $aEF1[$i][0] & @CRLF
									$ErrKol += 1
								EndIf
							EndIf
						Else
							$ErrDel &= $aEF1[$i][0] & @CRLF
							$ErrKol += 1
						EndIf
					EndIf
				EndIf
			Next
			If $iWin7 Then _GUICtrlListView_EndUpdate($hListView1)
			If $ErrDel Then MsgBox(0, $LngDErr & ' (' & $ErrKol & ')', $ErrDel, 0, $Gui)
			GUICtrlSetData($StatusBar, $LngELD & ' ' & $ErrKol)
		Else
			GUICtrlSetData($StatusBar, $LngLFE)
		EndIf
	EndIf
	_DisableGuiBtn($GUI_ENABLE)
EndFunc

Func _DelRight()
	_DisableGuiBtn($GUI_DISABLE)
	GUICtrlSetData($StatusBar, $LngDRV)
	If $Tr_Scan Then ; триггер Сканировать, иначе пустые папки
		Local $kol = 0, $ErrKol = 0, $ErrDel = ''
		If $Out2[0][0] Then
			If $iWin7 Then _GUICtrlListView_BeginUpdate($hListView2)
			For $i = 1 To $Out2[0][0]
				If GUICtrlRead($Out2[$i][4], 1) = 1 Then
					If $TrRcl = 1 Then ; триггер корзины
						If FileExists($Path02 & '\' & $Out2[$i][0]) And FileRecycle($Path02 & '\' & $Out2[$i][0]) Then ; в корзину
							$kol += 1
							GUICtrlSetState($Out2[$i][4], 4)
						Else
							$ErrDel &= $Out2[$i][0] & @CRLF
							$ErrKol += 1
						EndIf
					Else
						If FileExists($Path02 & '\' & $Out2[$i][0]) Then
							If FileDelete($Path02 & '\' & $Out2[$i][0]) Then
								$kol += 1
								GUICtrlSetState($Out2[$i][4], 4)
							Else
								If $TrAtr Then ; триггер снятия атрибутов
									FileSetAttrib($Path02 & '\' & $Out2[$i][0], "-RST")
									If FileDelete($Path02 & '\' & $Out2[$i][0]) Then
										$kol += 1
										GUICtrlSetState($Out2[$i][4], 4)
									Else
										$ErrDel &= $Out2[$i][0] & @CRLF
										$ErrKol += 1
									EndIf
								Else
									$ErrDel &= $Out2[$i][0] & @CRLF
									$ErrKol += 1
								EndIf
							EndIf
						Else
							$ErrDel &= $Out2[$i][0] & @CRLF
							$ErrKol += 1
						EndIf
					EndIf
				EndIf
			Next
			If $iWin7 Then _GUICtrlListView_EndUpdate($hListView2)
			If $ErrDel Then MsgBox(0, $LngDErr & ' (' & $ErrKol & ')', $ErrDel, 0, $Gui)
			GUICtrlSetData($StatusBar, $LngERD & ' ' & $ErrKol)
		Else
			GUICtrlSetData($StatusBar, $LngLFE)
		EndIf
	Else
		Local $kol = 0, $ErrKol = 0, $ErrDel = ''
		If $aEF2[0][0] Then
			If $iWin7 Then _GUICtrlListView_BeginUpdate($hListView2)
			For $i = 1 To $aEF2[0][0]
				If GUICtrlRead($aEF2[$i][4], 1) = 1 Then
					If $TrRcl = 1 Then
						If FileExists($Path02 & '\' & $aEF2[$i][0]) And FileRecycle($Path02 & '\' & $aEF2[$i][0]) Then ; в корзину
							$kol += 1
							GUICtrlSetState($aEF2[$i][4], 4)
						Else
							$ErrDel &= $aEF2[$i][0] & @CRLF
							$ErrKol += 1
						EndIf
					Else
						If FileExists($Path02 & '\' & $aEF2[$i][0]) Then
							If DirRemove($Path02 & '\' & $aEF2[$i][0], 1) Then
								$kol += 1
								GUICtrlSetState($aEF2[$i][4], 4)
							Else
								If $TrAtr Then
									FileSetAttrib($Path02 & '\' & $aEF2[$i][0], "-R", 1)
									If DirRemove($Path02 & '\' & $aEF2[$i][0], 1) Then
										$kol += 1
										GUICtrlSetState($aEF2[$i][4], 4)
									Else
										$ErrDel &= $aEF2[$i][0] & @CRLF
										$ErrKol += 1
									EndIf
								Else
									$ErrDel &= $aEF2[$i][0] & @CRLF
									$ErrKol += 1
								EndIf
							EndIf
						Else
							$ErrDel &= $aEF2[$i][0] & @CRLF
							$ErrKol += 1
						EndIf
					EndIf
				EndIf
			Next
			If $iWin7 Then _GUICtrlListView_EndUpdate($hListView2)
			If $ErrDel Then MsgBox(0, $LngDErr & ' (' & $ErrKol & ')', $ErrDel, 0, $Gui)
			GUICtrlSetData($StatusBar, $LngELD & ' ' & $ErrKol)
		Else
			GUICtrlSetData($StatusBar, $LngLFE)
		EndIf
	EndIf
	_DisableGuiBtn($GUI_ENABLE)
EndFunc

Func _CopyToRight()
	_DisableGuiBtn($GUI_DISABLE)
	GUICtrlSetData($StatusBar, $LngCRW)
	Local $kol = 0, $ErrKol = 0, $ErrDel = ''
	If $Out1[0][0] Then
		If $iWin7 Then _GUICtrlListView_BeginUpdate($hListView1)
		For $i = 1 To $Out1[0][0]
			If GUICtrlRead($Out1[$i][4], 1) = 1 Then
				GUICtrlSetData($StatusBar, $kol + 1 & ' / ' & $Out1[$i][0])
				If FileExists($Path01 & '\' & $Out1[$i][0]) And FileCopy($Path01 & '\' & $Out1[$i][0], $Path02 & '\' & $Out1[$i][0], 9) Then
					$kol += 1
					GUICtrlSetState($Out1[$i][4], 4)
				Else
					$ErrDel &= $Out1[$i][0] & @CRLF
					$ErrKol += 1
				EndIf
			EndIf
		Next
		If $iWin7 Then _GUICtrlListView_EndUpdate($hListView1)
		If $ErrDel Then MsgBox(0, $LngErCp & ' (' & $ErrKol & ')', $ErrDel, 0, $Gui)
		GUICtrlSetData($StatusBar, $LngEC1 & ' ' & $kol & ' ' & $LngEC2 & ' ' & $ErrKol)
	Else
		GUICtrlSetData($StatusBar, $LngLFE)
	EndIf
	_DisableGuiBtn($GUI_ENABLE)
EndFunc

Func _CopyToLeft()
	_DisableGuiBtn($GUI_DISABLE)
	GUICtrlSetData($StatusBar, $LngCLW)
	Local $kol = 0, $ErrKol = 0, $ErrDel = ''
	If $Out2[0][0] Then
		If $iWin7 Then _GUICtrlListView_BeginUpdate($hListView2)
		For $i = 1 To $Out2[0][0]
			If GUICtrlRead($Out2[$i][4], 1) = 1 Then
				GUICtrlSetData($StatusBar, $kol + 1 & ' / ' & $Out2[$i][0])
				If FileExists($Path02 & '\' & $Out2[$i][0]) And FileCopy($Path02 & '\' & $Out2[$i][0], $Path01 & '\' & $Out2[$i][0], 9) Then
					$kol += 1
					GUICtrlSetState($Out2[$i][4], 4)
				Else
					$ErrDel &= $Out2[$i][0] & @CRLF
					$ErrKol += 1
				EndIf
			EndIf
		Next
		If $iWin7 Then _GUICtrlListView_EndUpdate($hListView2)
		If $ErrDel Then MsgBox(0, $LngErCp & ' (' & $ErrKol & ')', $ErrDel, 0, $Gui)
		GUICtrlSetData($StatusBar, $LngEC1 & ' ' & $kol & ' ' & $LngEC3 & ' ' & $ErrKol)
	Else
		GUICtrlSetData($StatusBar, $LngLFE)
	EndIf
	_DisableGuiBtn($GUI_ENABLE)
EndFunc

Func _DisableGuiBtn($State)
	GUICtrlSetState($Scan, $State)
	GUICtrlSetState($Setting, $State)
	GUICtrlSetState($CopyToRight, $State)
	GUICtrlSetState($CopyToLeft, $State)
	GUICtrlSetState($DelLeft, $State)
	GUICtrlSetState($DelRight, $State)
	GUICtrlSetState($ComboM, $State)
	GUICtrlSetState($EmptyFolders, $State)
EndFunc

Func _Clear()
	GUICtrlSendMsg($ListView1, $LVM_DELETEALLITEMS, 0, 0)
	GUICtrlSendMsg($ListView2, $LVM_DELETEALLITEMS, 0, 0)
	GUICtrlSetState($hAllChec1, $GUI_HIDE)
	GUICtrlSetState($hAllChec2, $GUI_HIDE)
EndFunc

Func _Scan()
	_Clear()
	Dim $aEF1[1][1] = [[0]]
	Dim $aEF2[1][1] = [[0]]
	$Tr_Scan=1
	$Path01 = GUICtrlRead($Path1)
	$Path02 = GUICtrlRead($Path2)
	If Not (FileExists($Path01) And FileExists($Path02)) Then
		MsgBox(0, $LngErr, $LngMS1, 0, $Gui)
		Return
	EndIf
	If StringRight($Path01, 1) = '\' Then $Path01 = StringTrimRight($Path01, 1)
	If StringRight($Path02, 1) = '\' Then $Path02 = StringTrimRight($Path02, 1)
	If $Path01 = $Path02 Then
		MsgBox(0, $LngErr, $LngMS2, 0, $Gui)
		Return
	EndIf
	$FileList41 = $Path01
	$FileList42 = $Path02
	_DisableGuiBtn($GUI_DISABLE)
	
	GUICtrlSetData($StatusBar, $LngSB1 & ' 1')
	_InArr($FileList41)
	If @error Then
		GUICtrlSetData($StatusBar, $LngSB2 & ' 1')
		_DisableGuiBtn($GUI_ENABLE)
		Return _Clear()
	EndIf
	GUICtrlSetData($StatusBar, $LngSB1 & ' 2')
	_InArr($FileList42)
	If @error Then
		GUICtrlSetData($StatusBar, $LngSB2 & ' 2')
		_DisableGuiBtn($GUI_ENABLE)
		Return _Clear()
	EndIf
	_Compare()
	_DisableGuiBtn($GUI_ENABLE)
EndFunc

Func _Compare()
	If Not IsArray($FileList41) Then Return
	_Clear()
	; GUICtrlSetData($StatusBar, 'Сравнение результатов 1')
	$ComboM0 = Number(StringLeft(GUICtrlRead($ComboM), 1))
	$Out1 = _Compare1($FileList42, $FileList41, $ComboM0)
	If Not @error Then
		GUICtrlSetData($StatusBar, $LngSB3)
		For $i = 1 To $Out1[0][0]
			If $TrFrmSize Then
				$Size = _ConvertFileSize($Out1[$i][1])
			Else
				$Size = StringRegExpReplace($Out1[$i][1], '(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))', '\1 ')
			EndIf
			If $TrFrmData Then
				$data = _ConvertFileData($Out1[$i][2])
			Else
				$data = $Out1[$i][2]
			EndIf
			$Out1[$i][4] = GUICtrlCreateListViewItem($Out1[$i][0] & '|' & $Size & '|' & $data, $ListView1)
			GUICtrlSetState(-1, 1)
		Next
	Else
		Dim $Out1[1][1] = [[0]]
	EndIf
	If $Out1[0][0] Then GUICtrlSetState($hAllChec1, $GUI_SHOW + $GUI_CHECKED)
	; GUICtrlSetData($StatusBar, 'Сравнение результатов 2')
	$Out2 = _Compare1($FileList41, $FileList42, $ComboM0)
	If Not @error Then
		GUICtrlSetData($StatusBar, $LngSB4)
		For $i = 1 To $Out2[0][0]
			If $TrFrmSize Then
				$Size = _ConvertFileSize($Out2[$i][1])
			Else
				$Size = StringRegExpReplace($Out2[$i][1], '(\A\d{1,3}(?=(\d{3})+\z)|\d{3}(?=\d))', '\1 ')
			EndIf
			If $TrFrmData Then
				$data = _ConvertFileData($Out2[$i][2])
			Else
				$data = $Out2[$i][2]
			EndIf
			$Out2[$i][4] = GUICtrlCreateListViewItem($Out2[$i][0] & '|' & $Size & '|' & $data, $ListView2)
			GUICtrlSetState(-1, 1)
		Next
	Else
		Dim $Out2[1][1] = [[0]]
	EndIf
	If $Out2[0][0] Then GUICtrlSetState($hAllChec2, $GUI_SHOW + $GUI_CHECKED)
	GUICtrlSetData($StatusBar, $LngDn & '! ' & $LngSB5 & '1 = (' & $Out1[0][0] & ' ' & $LngSB6 & ' ' & $FileList41[0][0] & '), ' & $LngSB5 & '2 = (' & $Out2[0][0] & ' ' & $LngSB6 & ' ' & $FileList42[0][0] & ')')
EndFunc

Func _InArr(ByRef $out)
	Local $1, $2, $i, $Path = $out
	$out = _FO_FileSearch($out, _FO_CorrectMask(StringReplace($Mask, ';', '|')), $TrInc, $TrSub, 0, 0)
	If @error Then Return SetError(1)
	
	$1 = StringSplit(StringReplace($out, '[', '*'), @CRLF, 1)
	$2 = StringSplit($out, @CRLF, 1)
	
	Dim $out[$2[0] + 1][5] = [[$2[0]]]
	For $i = 1 To $2[0]
		$out[$i][0] = $2[$i]
		$out[$i][1] = FileGetSize($Path & '\' & $2[$i])
		$out[$i][2] = FileGetTime($Path & '\' & $2[$i], 0, 1)
		$out[$i][3] = $1[$i]
	Next
	; _ArrayDisplay($out, 'Array')
EndFunc

Func _Compare1($1, $2, $mode = 0)
	Local $k = 1, $i, $tmp, $m = 1
	Assign('/', Eval('/') + 1, 1)

	Switch $mode
		Case 4 To 7
			$m = 2
			$mode -= 4
	EndSwitch

	Switch $mode
		Case 0 ; только путь
			; создаём переменные первого массива
			For $i = 1 To $1[0][0]
				$tmp = $1[$i][3] & '/'
				Assign($tmp, Eval($tmp) + 1, 1)
			Next
			For $i = 1 To $2[0][0]
				$tmp = $2[$i][3] & '/'
				Assign($tmp, Eval($tmp) + 1, 1)
				If Eval($tmp) = $m Then
					$2[$k][0] = $2[$i][0]
					$2[$k][1] = $2[$i][1]
					$2[$k][2] = $2[$i][2]
					$k += 1
				EndIf
			Next
		Case 1 ; путь и размер
			; создаём переменные первого массива
			For $i = 1 To $1[0][0]
				$tmp = $1[$i][3] & '/' & $1[$i][1] & '/'
				Assign($tmp, Eval($tmp) + 1, 1)
			Next
			For $i = 1 To $2[0][0]
				$tmp = $2[$i][3] & '/' & $2[$i][1] & '/'
				Assign($tmp, Eval($tmp) + 1, 1)
				If Eval($tmp) = $m Then
					$2[$k][0] = $2[$i][0]
					$2[$k][1] = $2[$i][1]
					$2[$k][2] = $2[$i][2]
					$k += 1
				EndIf
			Next
		Case 2 ; путь и дата
			; создаём переменные первого массива
			For $i = 1 To $1[0][0]
				$tmp = $1[$i][3] & '/' & $1[$i][2] & '/'
				Assign($tmp, Eval($tmp) + 1, 1)
			Next
			For $i = 1 To $2[0][0]
				$tmp = $2[$i][3] & '/' & $2[$i][2] & '/'
				Assign($tmp, Eval($tmp) + 1, 1)
				If Eval($tmp) = $m Then
					$2[$k][0] = $2[$i][0]
					$2[$k][1] = $2[$i][1]
					$2[$k][2] = $2[$i][2]
					$k += 1
				EndIf
			Next
		Case 3 ; путь, размер и дата
			; создаём переменные первого массива
			For $i = 1 To $1[0][0]
				$tmp = $1[$i][3] & '/' & $1[$i][1] & '/' & $1[$i][2] & '/'
				Assign($tmp, Eval($tmp) + 1, 1)
			Next
			For $i = 1 To $2[0][0]
				$tmp = $2[$i][3] & '/' & $2[$i][1] & '/' & $2[$i][2] & '/'
				Assign($tmp, Eval($tmp) + 1, 1)
				If Eval($tmp) = $m Then
					$2[$k][0] = $2[$i][0]
					$2[$k][1] = $2[$i][1]
					$2[$k][2] = $2[$i][2]
					$k += 1
				EndIf
			Next
		Case Else
			Return SetError(1, 0, 0)
	EndSwitch
	If $k = 1 Then Return SetError(1, 0, 0)
	ReDim $2[$k][5]
	$2[0][0] = $k - 1
	Return $2
EndFunc

Func _ConvertFileData($d)
	Local $a = StringSplit($d, '')
	If $a[0] = 14 Then
		Return $a[1] & $a[2] & $a[3] & $a[4] & '.' & $a[5] & $a[6] & '.' & $a[7] & $a[8] & ' ' & $a[9] & $a[10] & ':' & $a[11] & $a[12] & ':' & $a[13] & $a[14]
	Else
		Return $d
	EndIf
EndFunc

Func WM_SIZE($hWnd, $iMsg, $wParam, $lParam)
	; получаем координаты сторон окна
	If $hWnd = $Gui Then
		Local $aPos, $WinSizeX = BitAND($lParam, 0x0000FFFF), _
				$WinSizeY = BitShift($lParam, 16), _
				$h = $WinSizeY - 100, _
				$w = ($WinSizeX - 30) / 2
		GUICtrlSetPos($ListView1, 10, 50, $w, $h)
		GUICtrlSetPos($ListView2, $w + 20, 50, $w, $h)
		GUICtrlSetPos($Path1, 10, 20, $w - 25, 22)
		GUICtrlSetPos($Path2, $w + 20, 20, $w - 25, 22)
		GUICtrlSetPos($Open1, $w - 11, 20)
		GUICtrlSetPos($ComboM, 10, $WinSizeY - 44, $w - 80)
	EndIf
EndFunc

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	If $hWnd = $Gui Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 500) ; минимальные размеры окна
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 330)
	EndIf
EndFunc

Func _Exit()
	Exit
EndFunc

Func _About()
	$GP = _ChildCoor($Gui, 290, 190)
	GUIRegisterMsg(0x05, "")
	GUIRegisterMsg(0x0046, "")
	GUISetState(@SW_DISABLE, $Gui)
	$font = "Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	If Not @Compiled Then GUISetIcon($AutoItExe, 1)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit2")
	GUISetBkColor(0xE1E3E7)
	GUICtrlCreateLabel($LngTitle, 0, 0, 290, 63, 0x01 + 0x0200)
	GUICtrlSetFont(-1, 14, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, 64, 288, 1, 0x10)

	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer & ' 0.3  04.03.2013', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', 55, 115, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetOnEvent(-1, "_url")
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetOnEvent(-1, "_WbMn")
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2011-2013', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
EndFunc

Func _url()
	ShellExecute('http://azjio.ucoz.ru')
EndFunc

Func _WbMn()
	ClipPut('R939163939152')
EndFunc