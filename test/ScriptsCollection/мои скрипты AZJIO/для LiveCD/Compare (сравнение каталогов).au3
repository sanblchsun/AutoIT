#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=Compare.exe
#AutoIt3Wrapper_icon=Compare.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Compare.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 11.02.2010 (AutoIt3_v3.2.12.1...v3.3.6.1)
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#NoTrayIcon
$root11='общие2'
$root2='недостающие2'
$root3='общие1'
Global $Stack[50], $Stack1[50]

;создание оболочки
$Gui=GUICreate("Сравнение каталогов",500,228, -1, -1, -1, $WS_EX_ACCEPTFILES) ; размер окна
If @compiled=0 Then GUISetIcon('Compare.ico')
$About = GUICtrlCreateButton("@", 500-21, 2, 18, 20)
$tab=GUICtrlCreateTab (0,2, 500,204) ; размер вкладки
$hTab = GUICtrlGetHandle($tab) ; (1) устранение проблем интерфейса чекбоксов

GUICtrlCreateLabel ("используйте drag-and-drop", 250,5,200,18)

$tab3=GUICtrlCreateTabitem ("Сравнение") ; имя вкладки

GUICtrlCreateLabel ("Каталог 1 (меньший по количеству файлов)", 20,40,436,20)
$folder111=GUICtrlCreateInput ("", 20,60,436,22)
GUICtrlSetState(-1,8)
$filewim=GUICtrlCreateButton ("...", 455,60,26, 23)
GUICtrlSetFont (-1,14)
GUICtrlSetTip(-1, "Обзор...")

GUICtrlCreateLabel ("Каталог 2 (больший по количеству файлов, здесь файлы не достающие каталогу 1)", 20,100,436,20)
$folder222=GUICtrlCreateInput ("", 20,120,436,22)
GUICtrlSetState(-1,8)
$filezip=GUICtrlCreateButton ("...", 455,120,26, 23)
GUICtrlSetFont (-1,14)
GUICtrlSetTip(-1, "Обзор...")

$check=GUICtrlCreateCheckbox ("Создать структуру каталогов общих и недостающих файлов", 20,150,340,20)
GUICtrlSetTip(-1, "Структуры общих и недостающих файлов")

$checkroot=GUICtrlCreateCheckbox ("Источник общих файлов из каталога 1", 20,170,340,20)
GUICtrlSetTip(-1, "иначе копирование из второго каталога")
GuiCtrlSetState($checkroot, 1)
GUICtrlSetState($checkroot, $GUI_DISABLE)

$Upd=GUICtrlCreateButton ("Выполнить", 390,160,92,26)
GUICtrlSetTip(-1, "Начать создание списков")
$Label000=GUICtrlCreateLabel ('Строка состояния', 10,210,380,20)

$tab4=GUICtrlCreateTabitem ("    ?") ; имя вкладки

GUICtrlCreateLabel ("Цель скрипта - создать список общих и недостающих файлов при сравнении одного LiveCD с другим. Это позволит сравнить файловые обновления сборки без учёта размера. Это позволит создать дополнительный загрузочный том wim,а используя файлы оригинальной сборки и тем самым сэкономить на размере добавляемых файлов. Создав два каталога общих файлов можно увидеть разницу в обьёме.", 20,30, 460,80)


GUICtrlCreateTabitem ("")   ; конец вкладок

; (2) устранение проблем интерфейса, чекбоксов
Switch @OSVersion
    Case 'WIN_2000', 'WIN_XP', 'WIN_2003'
        $Part = 10
    Case Else
        $Part = 11
EndSwitch
$Color = _WinAPI_GetThemeColor($hTab, 'TAB', $Part, 1, 0x0EED)
If Not @error Then
	; перечисление элементов, для которых нужно исправить проблему цвета
    GUICtrlSetBkColor($check, $Color)
    GUICtrlSetBkColor($checkroot, $Color)
EndIf

GUISetState ()

While 1
   $msg = GUIGetMsg()
   Select
	  Case $msg = $Upd
		$root1=$root11
		GUICtrlSetColor($Label000,0x000000)
		GUICtrlSetFont($Label000,8.5, 400)
		 GUICtrlSetData($Label000, 'Выполняется ...')
		 ; Читаем поля, проверяем наличие каталогов
		 $folder100=GUICtrlRead ($folder111)
		 $folder200=GUICtrlRead ($folder222)
				If Not FileExists($folder100) Then
					MsgBox(0, "Мелкая ошибка", 'Не указан каталог 1')
					ContinueLoop
				EndIf
				If Not FileExists($folder200) Then
					MsgBox(0, "Мелкая ошибка", 'Не указан каталог 2')
					ContinueLoop
				EndIf
; поиск файлов
	  FileFindNextFirst($folder200)
   $filetxt1 = FileOpen(@ScriptDir&'\'&$root1&'_list1.txt', 2)
   $filetxt2 = FileOpen(@ScriptDir&'\'&$root2&'_list2.txt', 2)
	; проверка открытия файла для записи строки
	If $filetxt1 = -1 Then
	  MsgBox(0, "Ошибка", "Не возможно открыть файл.")
	  Exit
   EndIf
	If $filetxt2 = -1 Then
	  MsgBox(0, "Ошибка", "Не возможно открыть файл.")
	  Exit
   EndIf
	; добавление заголовка
   FileWrite($filetxt1, 'список присутствующих файлов'&@CRLF)
   FileWrite($filetxt2, 'список отсутствующих файлов'&@CRLF)
	  While 1 
		 $tempname = FileFindNext()
		 If $tempname = "" Then ExitLoop
		 ; начало сравнения каталогов
		  $Path2 = StringTrimLeft($tempname, StringLen($folder200))
		  If FileExists($folder100&$Path2) Then
		  ; если указан, то сменить имя каталога и источник общих файлов
			If GUICtrlRead ($checkroot)=1 Then
			$tempname=$folder100&'\'&$Path2
			$root1=$root3
			EndIf
			If GUICtrlRead ($check)=1 Then FileCopy($tempname, @ScriptDir&'\'&$root1&'\'&$Path2, 9)
			FileWrite($filetxt1, $folder100&$Path2&@CRLF)
			Else
			If GUICtrlRead ($check)=1 Then FileCopy($tempname, @ScriptDir&'\'&$root2&'\'&$Path2, 9)
			FileWrite($filetxt2, $folder100&$Path2&@CRLF)
		 EndIf
	  WEnd
	  FileClose($filetxt1)
	  FileClose($filetxt2)
   GUICtrlSetData($Label000, 'Выполнено !!!')
	GUICtrlSetColor($Label000,0xEE0000)
	GUICtrlSetFont($Label000,8.5, 700)
	
	
		; управление чекбоксом
	  Case $msg = $check
		 If GUICtrlRead ($check)=1 Then
		 GUICtrlSetState($checkroot, $GUI_ENABLE)
		 Else
		 GUICtrlSetState($checkroot, $GUI_DISABLE)
		 EndIf

		; кнопки "Обзор"
	  Case $msg = $filewim
		$tmp = FileSelectFolder ( "Указать каталог 1",'', 3,@WorkingDir, $Gui)
		If Not @error Then GUICtrlSetData($folder111, $tmp)
	  Case $msg = $filezip
		$tmp = FileSelectFolder ( "Указать каталог 2",'', 3,@WorkingDir, $Gui)
		If Not @error Then GUICtrlSetData($folder222, $tmp)
       Case $msg = $About
           _About()
	  Case $msg = -3
		Exit
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

; (3) устранение проблем интерфейса, чекбоксов
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


Func _ChildCoor($Gui, $w, $h, $c=0, $d=0)
	Local $aWA = _WinAPI_GetWorkingArea(), _
	$GP = WinGetPos($Gui), _
	$wgcs=WinGetClientSize($Gui)
	Local $dLeft=($GP[2]-$wgcs[0])/2, _
	$dTor=$GP[3]-$wgcs[1]-$dLeft
	If $c = 0 Then
		$GP[0]=$GP[0]+($GP[2]-$w)/2-$dLeft
		$GP[1]=$GP[1]+($GP[3]-$h-$dLeft-$dTor)/2
	EndIf
	If $d>($aWA[2]-$aWA[0]-$w-$dLeft*2)/2 Or $d>($aWA[3]-$aWA[1]-$h-$dLeft+$dTor)/2 Then $d=0
	If $GP[0]+$w+$dLeft*2+$d>$aWA[2] Then $GP[0]=$aWA[2]-$w-$d-$dLeft*2
	If $GP[1]+$h+$dLeft+$dTor+$d>$aWA[3] Then $GP[1]=$aWA[3]-$h-$dLeft-$dTor-$d
	If $GP[0]<=$aWA[0]+$d Then $GP[0]=$aWA[0]+$d
	If $GP[1]<=$aWA[1]+$d Then $GP[1]=$aWA[1]+$d
	$GP[2]=$w
	$GP[3]=$h
	Return $GP
EndFunc

Func _WinAPI_GetWorkingArea()
    Local Const $SPI_GETWORKAREA = 48
    Local $stRECT = DllStructCreate("long; long; long; long")

    Local $SPIRet = DllCall("User32.dll", "int", "SystemParametersInfo", "uint", $SPI_GETWORKAREA, "uint", 0, "ptr", DllStructGetPtr($stRECT), "uint", 0)
    If @error Then Return 0
    If $SPIRet[0] = 0 Then Return 0

    Local $sLeftArea = DllStructGetData($stRECT, 1)
    Local $sTopArea = DllStructGetData($stRECT, 2)
    Local $sRightArea = DllStructGetData($stRECT, 3)
    Local $sBottomArea = DllStructGetData($stRECT, 4)

    Local $aRet[4] = [$sLeftArea, $sTopArea, $sRightArea, $sBottomArea]
    Return $aRet
EndFunc

Func _About()
$LngTitle='Compare'
$LngAbout='О программе'
$LngVer='Версия'
$LngSite='Сайт'
$LngCopy='Копировать'

$GP=_ChildCoor($Gui, 270, 180)
GUISetState(@SW_DISABLE, $Gui)
$font="Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], 0x00C00000+0x00080000, -1, $Gui) ; WS_CAPTION+WS_SYSMENU
	GUISetBkColor (0xffca48)
	GUICtrlCreateLabel($LngTitle, 0, 0, 270, 63, 0x01+0x0200)
	GUICtrlSetFont (-1,15, 600, -1, $font)
	GUICtrlSetColor(-1,0xa13d00)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,64,268,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.2  11.02.2010', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite&':', 55, 115, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetColor(-1,0xa21a10)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
$msg = $Gui1
	While 1
	  $msg = GUIGetMsg()
	  Select
		Case $msg = $url
			ShellExecute ('http://azjio.ucoz.ru')
		Case $msg = $WbMn
			ClipPut('R939163939152')
		Case $msg = -3
			$msg = $Gui
			GUISetState(@SW_ENABLE, $Gui)
			GUIDelete($Gui1)
			ExitLoop
		EndSelect
    WEnd
EndFunc