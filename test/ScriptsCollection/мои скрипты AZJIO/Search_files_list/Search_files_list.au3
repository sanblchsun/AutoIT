#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Search_files_list.exe
#AutoIt3Wrapper_Icon=Search_files_list.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Search_files_list.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.2.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.2.2
#AutoIt3Wrapper_Res_Field=Build|2013.02.27
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Res_Icon_Add=2.ico
#AutoIt3Wrapper_Res_Icon_Add=3.ico
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
;  @AZJIO 2010.10.08 - 2013.02.27

#NoTrayIcon

#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <FileOperations.au3>
#include <ForSearch_files_list.au3>
#include <ButtonConstants.au3>
#include <Array.au3>

; En
$LngTitle = 'Search files in the list'
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngCopy = 'Copy'
$LngSB1 = 'Use drag-and-drop'
$LngLB1 = 'Filelist (*.txt)'
$LngLB2 = 'The directory to search for'
$LngStr = 'Create a directory structure'
$LngLst = 'Create a list of found and not found'

$LngInD = 'Here only directories'
$LngInF = 'Here only the files-lists'
$LngMB2 = 'Error'
$LngMB3 = 'Search the directory path does not exist.'
$LngMB4 = 'The path of the list file does not exist.'
$LngSB2 = 'Count the number of files'
$LngSB3 = 'Files in the folder not found'
$LngSB4 = "Files according to the list it isn't found"
$LngSB5 = 'Done!  Found'
$LngSB6 = 'files per'
$LngSB7 = 'sec'
$LngFYs = 'List of found (path from the list)'
$LngFYR = 'List of found (path of real files)'
$LngFFP = 'found (the path from the list)'
$LngFFR = 'found (real) files'
$LngNFF = 'Not Found'
$LngFOD = 'Specify a file'
$LngAll = 'All'
$LngFSF = 'Open'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngTitle = 'Поиск файлов по списку'
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngSite = 'Сайт'
	$LngCopy = 'Копировать'
	$LngSB1 = 'Перетаскивайте список и папку в окно'
	$LngLB1 = 'Список файлов (*.txt)'
	$LngLB2 = 'Каталог для поиска'
	$LngStr = 'Создать структуру каталогов'
	$LngLst = 'Создать список найденных и не найденных'
	
	$LngInD = 'Сюда только каталоги'
	$LngInF = 'Сюда только файлы-списки'
	$LngMB2 = 'Ошибка'
	$LngMB3 = 'Путь каталога поиска не существует.'
	$LngMB4 = 'Путь файла списка не существует.'
	$LngSB2 = 'Подсчитываем количество файлов'
	$LngSB3 = 'Файлов в папке не найдено'
	$LngSB4 = 'Файлов по списку не найдено'
	$LngSB5 = 'Готово!  Найдено'
	$LngSB6 = 'файлов, за'
	$LngSB7 = 'сек'
	$LngFYs = 'Список найденных (пути из списка)'
	$LngFYR = 'Список найденных (пути реальных файлов)'
	$LngFFP = 'найденные (пути из списка)'
	$LngFFR = 'найденные(пути реальных файлов)'
	$LngNFF = 'НЕнайденные'
	$LngFOD = 'Указать файл'
	$LngAll = 'Все'
	$LngFSF = 'Открыть'
EndIf

$hGui = GUICreate($LngTitle, 420, 170, -1, -1, -1, $WS_EX_ACCEPTFILES)
If @Compiled Then
	$AutoItExe = @AutoItExe
Else
	$AutoItExe = @ScriptDir & '\Search_files_list.dll'
	GUISetIcon($AutoItExe, 1)
EndIf
$iAbout = GUICtrlCreateButton("@", 200, 1, 17, 20)
$iRestart = GUICtrlCreateButton("R", 220, 1, 17, 20)
$StatusBar = GUICtrlCreateLabel($LngSB1, 5, 170 - 17, 410, 15, 0xC)

GUICtrlCreateLabel($LngLB1, 10, 10, 186, 17)
$FileList = GUICtrlCreateInput("", 10, 26, 373, 22)
GUICtrlSetState(-1, 8)
$folder2 = GUICtrlCreateButton("...", 384, 26, 26, 23, $BS_ICON)
GUICtrlSetFont(-1, 16)
GUICtrlSetImage(-1, $AutoItExe, 201, 0)

GUICtrlCreateLabel($LngLB2, 10, 60, 186, 17)
$FindFolder = GUICtrlCreateInput("", 10, 76, 373, 22)
GUICtrlSetState(-1, 8)
$folder1 = GUICtrlCreateButton("...", 384, 76, 26, 23, $BS_ICON)
GUICtrlSetFont(-1, 16)
GUICtrlSetImage(-1, $AutoItExe, 202, 0)

$iChStructure = GUICtrlCreateCheckbox($LngStr, 50, 113, 175, 13)
GUICtrlSetState(-1, 1)
$iChOutLists = GUICtrlCreateCheckbox($LngLst, 50, 133, 245, 13)
GUICtrlSetState(-1, 1)
$iBtnFind = GUICtrlCreateButton("Поиск", 320, 118, 76, 33)

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_DROPPED
			Switch @GUI_DropId
				Case $FindFolder
					If _FO_IsDir(@GUI_DragFile) Then
						GUICtrlSetData($FindFolder, @GUI_DragFile)
					Else
						GUICtrlSetData($FindFolder, $LngInD)
					EndIf
				Case $FileList
					If _FO_IsDir(@GUI_DragFile) Then
						GUICtrlSetData($FileList, $LngInF)
					Else
						GUICtrlSetData($FileList, @GUI_DragFile)
					EndIf
			EndSwitch
			; кнопки обзор
		Case $iBtnFind
			$FindFolder0 = GUICtrlRead($FindFolder)
			$FileList0 = GUICtrlRead($FileList)
			If GUICtrlRead($iChStructure) = 4 Then
				$iChStructure0 = 0
			Else
				$iChStructure0 = 1
			EndIf
			If GUICtrlRead($iChOutLists) = 4 Then
				$iChOutLists0 = 0
			Else
				$iChOutLists0 = 1
			EndIf

			If $FindFolder0 = '' Or Not FileExists($FindFolder0) Then
				MsgBox(0, $LngMB2, $LngMB3)
				ContinueLoop
			EndIf

			If $FileList0 = '' Or Not FileExists($FileList0) Then
				MsgBox(0, $LngMB2, $LngMB4)
				ContinueLoop
			EndIf

			$sFindList = FileRead($FileList0)

			$timer = TimerInit()
			GUICtrlSetData($StatusBar, $LngSB2)
			$sFileList = _FO_FileSearch($FindFolder0, '*', True, 125, 0, 0) ; список файлов в виде текста
			If @error Then
				GUICtrlSetData($StatusBar, $LngSB3)
				ContinueLoop
			EndIf
			$sFileList2D = _SUnique($sFindList, $sFileList)
			If @error Then
				GUICtrlSetData($StatusBar, $LngSB4)
				ContinueLoop
			EndIf
			; _ArrayDisplay($sFileList2D, 'Array')

			$FindYes = $LngFYs & @CRLF
			$FindYesR = $LngFYR & @CRLF

			For $i = 1 To $sFileList2D[0][0]
				If $iChStructure0 And StringMid($sFileList2D[$i][2], 2, 1) = ':' Then
					FileCopy($FindFolder0 & '\' & $sFileList2D[$i][0], @ScriptDir & '\Search_results\' & StringReplace($sFileList2D[$i][2], ':', '\'), 8)
				Else
					FileCopy($FindFolder0 & '\' & $sFileList2D[$i][0], @ScriptDir & '\Search_results\' & $sFileList2D[$i][1], 8)
				EndIf
				If $iChOutLists0 Then
					$FindYes &= @CRLF & $sFileList2D[$i][2]
					$FindYesR &= @CRLF & $sFileList2D[$i][0]
					$sFindList = StringReplace(@CRLF & $sFindList & @CRLF, @CRLF & $sFileList2D[$i][2] & @CRLF, @CRLF)
				EndIf
				GUICtrlSetData($StatusBar, $sFileList2D[$i][0] & ' \ ' & $i)
			Next
			GUICtrlSetData($StatusBar, $LngSB5 & ' ' & $sFileList2D[0][0] & ' '&$LngSB6&' ' & Round(TimerDiff($timer) / 1000, 2) & ' ' & $LngSB7)

			If $iChOutLists0 Then
				$file = FileOpen(@ScriptDir & '\'&$LngFFP&'.log', 2)
				FileWrite($file, $FindYes)
				FileClose($file)

				$file = FileOpen(@ScriptDir & '\'&$LngFFR&'.log', 2)
				FileWrite($file, $FindYesR)
				FileClose($file)

				$file = FileOpen(@ScriptDir & '\'&$LngNFF&'.log', 2)
				FileWrite($file, $LngNFF & @CRLF & @CRLF & StringRegExpReplace($sFindList, '(\r\n|\r|\n){2,}', '\1'))
				FileClose($file)
			EndIf
			Run('Explorer.exe ' & @ScriptDir & '\Search_results')





		Case $folder2
			$tmp = FileOpenDialog($LngFOD, @WorkingDir, $LngAll&" (*.*)", 3, '', $hGui)
			If @error Then ContinueLoop
			GUICtrlSetData($FileList, $tmp)
		Case $folder1
			$tmp = FileSelectFolder($LngFSF, '', 6, @WorkingDir, $hGui)
			If @error Then ContinueLoop
			GUICtrlSetData($FindFolder, $tmp)
		Case $iRestart
			_Restart()
		Case $iAbout
			_About()
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd

Func _SUnique($sFindList, $sFileList)
	Local $Trg = 0, $sep = Chr(1)
	If $sFindList = '' Or $sFileList = '' Then Return SetError(1)
	$sFindList = StringReplace($sFindList, '[', $sep)
	$Trg += @extended
	$sFileList = StringReplace($sFileList, '[', $sep)
	$Trg += @extended
	If $Trg <> 2 Then $Trg = 0

	; Создаём массив файлов
	$sFindList = StringSplit(StringRegExpReplace($sFindList, '[\r\n]+', '|'), '|') ; создаём массив

	Local $aFindLShort[$sFindList[0] + 1] = [$sFindList[0]]
	Assign('/', '', 1)
	For $i = 1 To $sFindList[0] ; в цикле создаём переменные списка поиска
		If StringInStr($sFindList[$i], '\') Then
			$aFindLShort[$i] = StringRegExpReplace($sFindList[$i], '^.*\\(.*)$', '\1')
		Else
			$aFindLShort[$i] = $sFindList[$i]
		EndIf
		Assign($aFindLShort[$i] & '/', $i, 1)
	Next

	$sFileList = StringSplit($sFileList, @CRLF, 1) ; создаём массив
	; _ArrayDisplay($sFileList, 'sFileList')
	If $Trg Then
		$k0 = ''
		For $i = 1 To $sFileList[0] ; в цикле создаём переменные списка поиска
			$sFileName = StringRegExpReplace($sFileList[$i], '^.*\\(.*)$', '\1')
			If IsDeclared($sFileName & '/') Then
				$ind = Eval($sFileName & '/')
				$k0 &= $sFileList[$i] & '*' & $aFindLShort[$ind] & '*' & $sFindList[$ind] & '|'
			EndIf
		Next
		If $k0 = '' Then Return SetError(1)
		$k0 = StringTrimRight($k0, 1)
		$k0 = StringReplace($k0, $sep, '[')
		$sFindList = StringSplit($k0, '|') ; создаём массив
		Dim $sFileList2D[$sFindList[0] + 1][3] = [[$sFindList[0]]]
		For $i = 1 To $sFindList[0]
			$tmp = StringSplit($sFindList[$i], '*')
			$sFileList2D[$i][0] = $tmp[1]
			$sFileList2D[$i][1] = $tmp[2]
			$sFileList2D[$i][2] = $tmp[3]
		Next
	Else
		$k0 = 0
		Dim $sFileList2D[$sFileList[0] + 1][3] = [[$sFileList[0]]]
		For $i = 1 To $sFileList[0] ; в цикле создаём переменные списка поиска
			$sFileName = StringRegExpReplace($sFileList[$i], '^.*\\(.*)$', '\1')
			If IsDeclared($sFileName & '/') Then
				; MsgBox(0, 'Сообщение', $sFileList[$i] &@CRLF& $sFileName)
				$k0 += 1
				$ind = Eval($sFileName & '/')
				$sFileList2D[$k0][0] = $sFileList[$i]
				$sFileList2D[$k0][1] = $aFindLShort[$ind]
				$sFileList2D[$k0][2] = $sFindList[$ind]
			EndIf
		Next
		If Not $k0 Then
			Return SetError(1)
		Else
			ReDim $sFileList2D[$k0 + 1][3]
			$sFileList2D[0][0] = $k0
		EndIf
	EndIf
	Return $sFileList2D
EndFunc

Func _About()
	$GP = _ChildCoor($hGui, 270, 180)
	GUISetState(@SW_DISABLE, $hGui)
	$font = "Arial"
	$hGui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $hGui)
	GUISetBkColor(0xE1E3E7)
	GUICtrlCreateLabel($LngTitle, 0, 0, 270, 63, $SS_CENTER + $SS_CENTERIMAGE)
	GUICtrlSetFont(-1, 15, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, 64, 268, 1, 0x10)

	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer & ' 0.2.2  27.02.2013', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', 55, 115, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010-2013', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $hGui1)
	While 1
		Switch GUIGetMsg()
			Case $url
				ShellExecute('http://azjio.ucoz.ru')
			Case $WbMn
				ClipPut('R939163939152')
			Case -3
				GUISetState(@SW_ENABLE, $hGui)
				GUIDelete($hGui1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc