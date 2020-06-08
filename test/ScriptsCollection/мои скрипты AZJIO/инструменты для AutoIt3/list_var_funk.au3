;  @AZJIO 25.10.2010 - 11.04.2011
#Include <File.au3>

; En
$LngTitle='Variables and Functions'
$LngFO1='Select File.'
$LngFO2='Script'
$LngMs1='Message'
$LngMs2='No variables.'&@CRLF&'Continue?'
$LngLVr='Variables'
$LngLFu='Functions'
$LngLPc='pieces'
$LngCb1='> clipboard'
$LngCbH1='Copy the list of variables'&@CRLF&'to the clipboard'
$LngCb2='clipboard >'
$LngCbH2='Import from the clipboard'&@CRLF&'and show a list of variables'
$LngLcH='List as a local'&@CRLF&'variable declaration'
$LngCbHF='Copy the list of functions'&@CRLF&'to the clipboard'
$LngInc='See all the functions'&@CRLF&'in the directory "Include"'
$LngLt1='Done in'
$LngLt2='sec'
$LngUse='Use'
$LngRep='Counting the number '&@CRLF&'of repetitions of variables'
$LngOpi='Open the file folder "Include"'
$helpmsg='Hotkeys'&@CRLF&@CRLF& _
'Ctrl + Left Arrow - a list of variables to copy to clipboard'&@CRLF& _
'Ctrl + Right Arrow - a list of functions to copy to clipboard'&@CRLF& _
'Ctrl + Down Arrow - imported from Clipboard'&@CRLF& _
'Ctrl + Up Arrow - a list of variables to copy to the clipboard as a local variable declaration'&@CRLF&@CRLF& _
'Can throw the script out the window or directory scripts.  In the latter case, the output only functions.  Also specify the path to the script at the command prompt, which is convenient when working in a text editor.'&@CRLF&@CRLF& _
'The script is designed to show the variables and functions in the scripts, to avoid duplication, to be able to fearlessly copy of the code of one script to another. Allows you to keep track of variable names to avoid duplication when you want to rename a variable, eg $Path and $PathName. When replacing the $Path will damage $PathName, so you need to temporarily rename $PathName, then rename $Path, and then restore the $PathName. Variables and functions are displayed in one instance and sorted. The window supports drag-and-drop, and resize. The time counter shows the reading of the script or scripts directory.'

$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang=DllCall ( $Lang_dll, "int", "GetUserDefaultUILanguage" )
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)
DllClose($Lang_dll)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	$LngTitle='Переменные и функции'
	$LngFO1='Выбор файла.'
	$LngFO2='Скрипт'
	$LngMs1='Сообщение'
	$LngMs2='Нет переменных.'&@CRLF&'Продолжить?'
	$LngLVr='Переменные'
	$LngLFu='Функции'
	$LngLPc='шт'
	$LngCb1='в буфер'
	$LngCbH1='Скопировать список переменных '&@CRLF&'в буфер обмена'
	$LngCb2='из буфера'
	$LngCbH2='Прочитать код из буфера'&@CRLF&'и показать список переменных'
	$LngLcH='Список в виде локального'&@CRLF&'объявления переменных'
	$LngCbHF='Скопировать список функций '&@CRLF&'в буфер обмена'
	$LngInc='Показать все функции'&@CRLF&'каталога Include'
	$LngLt1='Выполнено за'
	$LngLt2='сек'
	$LngUse='Используйте'
	$LngRep='Подсчитывать количество'&@CRLF&'повторов переменных'
	$LngOpi='Открыть файл папки Include'
	$helpmsg='Горячие клавиши'&@CRLF&@CRLF& _
'Ctrl+стрелка влево - список переменных скопировать в буфер обмена'&@CRLF& _
'Ctrl+стрелка вправо - список функций скопировать в буфер обмена'&@CRLF& _
'Ctrl+стрелка вниз - обработать буфер обмена'&@CRLF& _
'Ctrl+стрелка вверх - список переменных скопировать в буфер обмена в виде локального объявления переменных'&@CRLF&@CRLF& _
'Можете кинуть скрипт в окно или каталог скриптов. В последнем случае вывод только функций. Также указать путь к скрипту в ком-строке, что удобно при работе в текстовом редакторе имеющего вызов других утилит.'&@CRLF&@CRLF& _
'Скрипт предназначен для просмотра переменных и функций в скриптах на предмет пересечения, для возможности безбоязненно копировать часть кода одного скрипта в другой. Также позволяет визуально отследить что при выполнении замены имени переменной не произойдёт порча близкой по имени переменной, например $Path и $PathName. При замене $Path испортится $PathName, поэтому можно временно переименовать сначала $PathName, а потом $Path и далее восстановить $PathName. Переменные и функции читаются из скрипта в одном экзэмпляре и сортируются. Окно поддерживает drag-and-drop, и изменение размера окна. Счётчик времени показывает время считывания скрипта или каталога скриптов.'
EndIf



#Include<Array.au3>
Opt("GUIResizeMode", 0x0322)
$bufer_read33 = 0 ; если 1 то читаем из буфера, если 0 то диалог выбора файла
Global $k, $kf, $text01, $text02, $text0, $text, $Info_Edit1, $Info_Edit2, $Time, $timer, $FileName='', $FilePath

If $CmdLine[0]=0 Then
	If $bufer_read33 = 1 Then
		$text = ClipGet()
	Else
		$Path = FileOpenDialog($LngFO1, @WorkingDir & "", $LngFO2&" (*.au3)", 1 + 4)
		If @error Then Exit
		$FileName=StringRegExpReplace($Path, '(^.*)\\(.*)$', '\2')
		$file = FileOpen($Path, 0)
		$text = FileRead($file)
		FileClose($file)
		$FilePath=$Path
	EndIf
Else
	If FileExists($CmdLine[1]) Then
		$file = FileOpen($CmdLine[1], 0)
		$text = FileRead($file)
		FileClose($file)
		$FileName=StringRegExpReplace($CmdLine[1], '(^.*)\\(.*)$', '\2')
		$FilePath=$CmdLine[1]
	EndIf
EndIf

Global $TrChe = 0
_ReadAU3($text)

If $k = 0 And MsgBox(4, $LngMs1, $LngMs2)=7 Then Exit
If $k < 25 Then
	$pos = $k
	If $k = 0 Then $pos=5
Else
	$pos = 25
EndIf


$Gui = GUICreate($LngTitle, 410, $pos * 17 + 140, -1, -1, 0x00040000+0x00020000+0x00010000, 0x00000010)
$CatchDrop = GUICtrlCreateLabel("", 0, 0, 410, $pos * 17 + 120)
GUICtrlSetState(-1, 128 + 8)
GUICtrlSetResizing(-1, 1)
$per=GUICtrlCreateLabel($LngLVr&' - '&$k&' '&$LngLPc, 8, 3, 190, 17)
GUICtrlSetResizing(-1, 1+2+32+512)
$fun=GUICtrlCreateLabel($LngLFu&' - '&$kf&' '&$LngLPc, 208, 3, 190, 17)
GUICtrlSetResizing(-1, 1+4+32+512)
$Info_Edit1 = GUICtrlCreateEdit($text01, 8, 22, 190, $pos * 17 + 40)
GUICtrlSetResizing(-1, 1+2+32+64)
$Info_Edit2 = GUICtrlCreateEdit($text02, 208, 22, 190, $pos * 17 + 40)
GUICtrlSetResizing(-1, 1+4+32+64)
$byf1 = GUICtrlCreateButton($LngCb1, 8, $pos * 17 + 67, 61, 22)
GUICtrlSetResizing(-1, 1+2+64+256+512)
GUICtrlSetTip(-1, $LngCbH1)
$Openbyf = GUICtrlCreateButton($LngCb2, 72, $pos * 17 + 67, 61, 22)
GUICtrlSetResizing(-1, 1+2+64+256+512)
GUICtrlSetTip(-1, $LngCbH2)
$Locbyf = GUICtrlCreateButton('Local', 136, $pos * 17 + 67, 61, 22)
GUICtrlSetResizing(-1, 1+2+64+256+512)
GUICtrlSetTip(-1, $LngLcH)
$byf2 = GUICtrlCreateButton($LngCb1, 208, $pos * 17 + 67, 61, 22)
GUICtrlSetResizing(-1, 1+4+64+256+512)
GUICtrlSetTip(-1, $LngCbHF)
$Include = GUICtrlCreateButton('Include', 272, $pos * 17 + 67, 61, 22)
GUICtrlSetResizing(-1, 1+4+64+256+512)
GUICtrlSetTip(-1, $LngInc)
$help = GUICtrlCreateButton('?', 336, $pos * 17 + 67, 61, 22)
GUICtrlSetResizing(-1, 1+4+64+256+512)
$Time = GUICtrlCreateLabel($LngLt1&' '&Round($timer/1000, 1)&' '&$LngLt2, 8, $pos * 17 + 93, 160, 17)
GUICtrlSetResizing(-1, 1+64+512)
GUICtrlCreateLabel($LngUse&' drag-and-drop', 178, $pos * 17 + 93, 160, 17)
GUICtrlSetResizing(-1, 1+64+512)
If $FileName<>'' Then WinSetTitle($Gui, '', $FileName&' - '&$LngTitle)

$Che = GUICtrlCreateCheckbox('N', 340, $pos * 17 + 67+24, 25, 17)
GUICtrlSetResizing(-1, 1+4+64+256+512)
GUICtrlSetTip(-1, $LngRep)
$OpInc= GUICtrlCreateButton('Open', 369, $pos * 17 + 67+24, 36, 18)
GUICtrlSetResizing(-1, 1+4+64+256+512)
GUICtrlSetTip(-1, $LngOpi)

Dim $AccelKeys[4][2]=[["^{LEFT}", $byf1], ["^{RIGHT}", $byf2], ["^{DOWN}", $Openbyf], ["^{UP}", $Locbyf]]

GUISetAccelerators($AccelKeys)

GUISetState()
GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")
Send('^{HOME}')

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $OpInc
			$curretPath = RegRead("HKLM\SOFTWARE\AutoIt v3\AutoIt","InstallDir")&'\Include'
			If @error Or Not FileExists($curretPath) Then $curretPath=@WorkingDir
			$OpenFile = FileOpenDialog('Open', $curretPath, 'Script (*.au3)', 1, '', $Gui)
			If @error Then ContinueLoop
			$FilePath=$OpenFile
			_OpenFile($FilePath)
		Case $msg = $help
			_MsgFile()
		Case $msg = $Include
			$curretPath = RegRead("HKLM\SOFTWARE\AutoIt v3\AutoIt","InstallDir")&'\Include'
			If @error Or Not FileExists($curretPath) Then ContinueLoop
			_Include($curretPath)
		Case $msg = $Locbyf
			$tmp1 = StringRegExpReplace(GUICtrlRead($Info_Edit1), @CRLF&'\$', ', $')
			$tmp1 = StringReplace($tmp1, @CRLF, '')&', '
			$tmp = ClipGet()
			$aTmp=StringRegExp($tmp, '(?m)^Func\h+\w+?\((.*).$', 3)
			If Not @error And StringInStr($aTmp[0], '$') Then
				$aTmp1=StringRegExp($aTmp[0], '(?m)(\$\w+)', 3)
				If Not @error Then
					For $i = 0 to UBound($aTmp1)-1
						$tmp1 = StringReplace($tmp1, $aTmp1[$i]&', ', '')
					Next
				EndIf
			EndIf
			While StringRight($tmp1, 2)=', '
				$tmp1 = StringTrimRight($tmp1, 2)
			WEnd
			ClipPut(@CRLF&@Tab&'Local '&$tmp1)
		Case $msg = $Openbyf
			$text=ClipGet()
			_ReadAU3($text)
			GUICtrlSetData($per, $LngLVr&' - '&$k&' '&$LngLPc)
			GUICtrlSetData($fun, $LngLFu&' - '&$kf&' '&$LngLPc)
			WinSetTitle($Gui, '', $LngCb2&' - '&$LngTitle)
		Case $msg = $byf1
			ClipPut(GUICtrlRead($Info_Edit1))
		Case $msg = $byf2
			ClipPut(GUICtrlRead($Info_Edit2))
		Case $msg = $Che
			If GUICtrlRead($Che)=1 Then
				$TrChe = 1
			Else
				$TrChe = 0
			EndIf
			If FileExists($FilePath) Then
				_OpenFile($FilePath)
			EndIf
		Case $msg = -13
			$FilePath=@GUI_DragFile
			_OpenFile(@GUI_DragFile)
		Case $msg = -3
			Exit
	EndSelect
WEnd


Func _OpenFile($OpenPath)
	If StringInStr(FileGetAttrib($OpenPath), "D") Then
		_Include($OpenPath)
	ElseIf StringRight($OpenPath, 4)='.au3' Then
		$file = FileOpen($OpenPath, 0)
		$text = FileRead($file)
		FileClose($file)
		_ReadAU3($text)
		GUICtrlSetData($per, $LngLVr&' - '&$k&' '&$LngLPc)
		GUICtrlSetData($fun, $LngLFu&' - '&$kf&' '&$LngLPc)
		WinSetTitle($Gui, '', StringRegExpReplace($OpenPath, '(^.*)\\(.*)$', '\2')&' - '&$LngTitle)
	EndIf
EndFunc


Func _Include($curretPath)
	$search = _FileListToArray($curretPath, '*.au3', 1)
	If @Error Then
		MsgBox (0,"Сообщение","Не найдено.")
		Return
	EndIf
	$textAll=''
	$timer = TimerInit()
	$kf2=0
	For $i = 1 to $search[0]
		$text = FileRead($curretPath&'\'&$search[$i])

		$aText2 = StringRegExp($text, '(?:\sFunc)\s+(\w*)', 3)
		If Not  @error Then
			$kf2+=UBound($aText2)
			$textAll &= @CRLF& @CRLF& @CRLF&'+++++ '&$search[$i]&' +++++'& @CRLF & @CRLF
			GUICtrlSetData($Time, $search[$i])
			For $j In $aText2
				$textAll &= $j & @CRLF
			Next
		Else
			$textAll &= @CRLF&'- - - - '&$search[$i]&' - - - -'
		EndIf
	Next
	WinSetTitle($Gui, '', StringRegExpReplace($curretPath, '(^.*)\\(.*)$', '\2')&' - '&$LngTitle)
	GUICtrlSetData($Info_Edit2, $textAll)
	GUICtrlSetData($Info_Edit1, '')
	GUICtrlSetData($per, $LngLVr)
	GUICtrlSetData($fun, $LngLFu&' - '&$kf&' '&$LngLPc)
	$timer=TimerDiff($timer)
	GUICtrlSetData($Time, $LngLt1&' '&Round($timer/1000, 2)&' '&$LngLt2)
EndFunc

Func _ReadAU3($text)
	$timer = TimerInit() ; засекаем время
	; начинаем поиск переменных
	$aT1 = StringRegExp($text & @CRLF, '(?<=\$)\w+', 3) ; детектируем переменные в массив
	If Not  @error Then
		$k=0
		For $i = 0 To UBound($aT1) -1
			Assign($aT1[$i]&'_3j5d2f8k_', Eval($aT1[$i]&'_3j5d2f8k_')+1, 1)
			If Eval($aT1[$i]&'_3j5d2f8k_') = 1 Then
				; $aT1[$k]= "$" &$aT1[$i]
				$aT1[$k]=$aT1[$i]
				$k+=1
			EndIf
		Next
		ReDim $aT1[$k]
		_ArraySort($aT1) ; сортировка массива
		Dim $aT134[$k]
		
		If $TrChe=1 Then
			For $i = 0 To UBound($aT1) -1
					$aT1[$i]= "$" &$aT1[$i]&' - '&Eval($aT1[$i]&'_3j5d2f8k_')
			Next
		Else
			For $i = 0 To UBound($aT1) -1
					$aT1[$i]= "$" &$aT1[$i]
			Next
		EndIf

		$text01 = ''
		For $i In $aT1 ; объединение массива в многостроковый текст
			$text01 &= $i & @CRLF
		Next

		GUICtrlSetData($Info_Edit1, $text01)
	Else
		$k=0
	EndIf

	; начинаем поиск функций
	$aText2 = StringRegExp($text, '(?:\sFunc)\s+(\w*)', 3) ; детектируем функции в массив
	If Not  @error Then
		_ArraySort($aText2) ; сортировка массива

		$text02 = ''
		$kf=UBound($aText2)
		For $i In $aText2 ; объединение массива в многостроковый текст
			$text02 &= $i & @CRLF
		Next
		; конец поиск функций
		GUICtrlSetData($Info_Edit2, $text02)
	Else
		$kf=0
	EndIf
	$timer=TimerDiff($timer)
	GUICtrlSetData($Time, $LngLt1&' '&Round($timer/1000, 2)&' '&$LngLt2)
EndFunc

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)

    Local $aWorkArea = _WinAPI_GetWorkingArea()

    If $hWnd = $GUI Then
        Local $tMINMAXINFO = DllStructCreate("int;int;" & _
                "int MaxSizeX; int MaxSizeY;" & _
                "int MaxPositionX;int MaxPositionY;" & _
                "int MinTrackSizeX; int MinTrackSizeY;" & _
                "int MaxTrackSizeX; int MaxTrackSizeY", _
                $lParam)
        DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 410) ; минимальные размеры окна
        DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 200)
        DllStructSetData($tMINMAXINFO, "MaxPositionX", $aWorkArea[0])
        DllStructSetData($tMINMAXINFO, "MaxPositionY", $aWorkArea[1])
        DllStructSetData($tMINMAXINFO, "MaxSizeX", 600) ; размеры развёрнутого состояния ( просто удали строку, чтоб игнорировать критерий)
        DllStructSetData($tMINMAXINFO, "MaxSizeY", $aWorkArea[3]-$aWorkArea[1])
    EndIf
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


Func _MsgFile()
	GUISetState(@SW_DISABLE, $Gui)
    $Gui1 = GUICreate('Сообщение', 500, 340, -1, -1, -1, 0x00000080, $Gui)
	GUICtrlCreateLabel($helpmsg, 15, 10, 480, 330)
	GUISetState(@SW_SHOW, $Gui1)
	While 1
		$msg = GUIGetMsg()
		If $msg = -3 Then
			$msg = $Gui
			GUISetState(@SW_ENABLE, $Gui)
			GUIDelete($Gui1)
			ExitLoop
		EndIf
    WEnd
EndFunc