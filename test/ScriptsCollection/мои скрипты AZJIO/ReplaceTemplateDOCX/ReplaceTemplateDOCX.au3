#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=ReplaceTemplateDOCX.exe
#AutoIt3Wrapper_icon=ReplaceTemplateDOCX.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=ReplaceTemplateDOCX.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Field=Version|0.3
#AutoIt3Wrapper_Res_Field=Build|2011.07.29
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
; #AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 29.07.2011 AutoIt3_v3.3.7.14

#NoTrayIcon
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#include <ZIP.au3>

#include <StructureConstants.au3>
#include <GUIScrollBars.au3>
#include <ScrollBarConstants.au3>

#include <ComboConstants.au3>
#include <StaticConstants.au3>
#Include <Misc.au3>
#include <Array.au3>

Opt('GUIResizeMode', 802)

$LngAbout='О программе'
$LngVer='Версия'
$LngCopy='Копировать'
$LngSite='Сайт'

Global $IniReplace[1], $Gui, $DH=@DesktopHeight, $tmpZ, $hTemplate
Global $Ini = @ScriptDir & '\ReplaceTemplateDOCX.ini'

If Not FileExists($Ini) And DriveStatus(StringLeft(@ScriptDir, 1))<>'NOTREADY' Then
$file = FileOpen($Ini,2)
FileWrite($file, '[Setting]' & @CRLF & _
'Font=10' & @CRLF & _
'LastFolder=' & @CRLF & _
'LastTemplate=')
FileClose($file)
EndIf


$Font=IniRead($Ini, 'Setting', 'Font', '10')
$LastFolder=IniRead($Ini, 'Setting', 'LastFolder', '')
$LastTemplate=IniRead($Ini, 'Setting', 'LastTemplate', '')


HotKeySet("{ESC}", "_Quit")
Func _Quit()
    Exit
EndFunc
OnAutoItExitRegister("_Exit")
Func _Exit()
	IniWrite($Ini, 'Setting', 'LastFolder', $LastFolder)
	IniWrite($Ini, 'Setting', 'Font', $Font)
	$hTemplate0=GUICtrlRead($hTemplate)
	If Not @error And $hTemplate0<>'' Then IniWrite($Ini, 'Setting', 'LastTemplate', $hTemplate0)
EndFunc

$search = FileFindFirstFile(@ScriptDir&'\template\*')

If $search = -1 Then
    MsgBox(0, "Ошибка", "Шаблоны не найдены, завершаем работу")
    Exit
EndIf

$k=0
$List=''
While 1
    $file = FileFindNextFile($search)
    If @error Then ExitLoop
	If FileExists(@ScriptDir&'\template\'&$file&'\template.ini') Then
		$k+=1
		If $k = 1 Then $curent=$file
		$List&=$file&'|'
	EndIf
WEnd
$List=StringTrimRight($List, 1)
FileClose($search)

If FileExists(@ScriptDir&'\template\'&$LastTemplate) And $LastTemplate<>'' Then $curent=$LastTemplate

$Gui=GUICreate('Форма заполнения шаблона docx', 810, 40, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU, $WS_SIZEBOX))
If Not @compiled Then GUISetIcon(@ScriptDir&'\ReplaceTemplateDOCX.ico')
If $Font<>'' Then
	$aRet=StringSplit($Font, ',')
	If $aRet[0]<4 Then
		$aRet=4-$aRet[0]
		For $i = 1 to $aRet
			$Font&=','
		Next
		$aRet =StringSplit($Font, ',')
	EndIf
	GUISetFont($aRet[1], $aRet[2], $aRet[3], $aRet[4])
	If $aRet[1]>9 Then
		$SizeIn=Int($aRet[1]*2.5)
	Else
		$SizeIn=Int($aRet[1]*3)
	EndIf
Else
	$SizeIn=25
EndIf
$Save=GUICtrlCreateButton('Сохранить', 535, 7, 95, 26)
GUICtrlSetTip(-1, 'Сохранить заполненные '&@CRLF&'поля в файл')
$Replace=GUICtrlCreateButton('Создать', 640, 3, 130, 34)
GUICtrlSetTip(-1, 'Выполнить создание'&@CRLF&'документа(ов) docx')
$Fill=GUICtrlCreateButton('Заполнить', 435, 7, 95, 26)
GUICtrlSetTip(-1, 'Загрузить заполненные '&@CRLF&'поля из файла')
$About=GUICtrlCreateButton ("@", 1,1,23,23)
GUICtrlSetTip(-1, $LngAbout)
$Restart=GUICtrlCreateButton ("R", 25,1,23,23)
$SelFont=GUICtrlCreateButton ("S", 49,1,23,23)
GUICtrlCreateLabel('Шаблон :', 85, 10, 82, 17, $SS_RIGHT)
$hTemplate=GUICtrlCreateCombo('', 170, 7, 260, 23, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, $List, $curent)

$StatusBar=GUICtrlCreateLabel('Строка состояния', 170, 37, 640, 20)

GUISetState ()
_Test($curent)
_SetItem($curent)
GUIRegisterMsg($WM_SIZE, "WM_SIZE")
GUIRegisterMsg($WM_VSCROLL, "WM_VSCROLL")
GUIRegisterMsg($WM_HSCROLL, "WM_HSCROLL")
GUIRegisterMsg(0x020A , "WM_MOUSEWHEEL")
_GUIScrollBars_Init($Gui)

; GUICtrlSetData($IniReplace[1][2],'Анастасия Владимировна Мурашкина')
; GUICtrlSetData($IniReplace[2][2],'20586194')
; GUICtrlSetData($IniReplace[3][2],'ул. Каштанова д.4 кв.9')

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $Restart
			_restart()
		Case $SelFont
			If $Font = '' Then $Font = '9,400,0,Arial'
			$aRet =StringSplit($Font, ',')
			If $aRet[0]<4 Then
				$aRet=4-$aRet[0]
				For $i = 1 to $aRet
					$Font&=','
				Next
				$aRet =StringSplit($Font, ',')
			EndIf
			; MsgBox(0, 'Message', $aRet[0]&@CRLF&$aRet[1]&@CRLF&$bo&@CRLF&$it)
			$a_font = _ChooseFont($aRet[4], $aRet[1], 0, $aRet[2], False, 0, 0, $Gui)
			If Not @error Then
				$Font = $a_font[3]&','&$a_font[4]&','&$a_font[1]&','&$a_font[2]
				If MsgBox(4+256+8192+262144, 'Сообщение', 'Чтобы увидеть изменения требуется перезапустить програму.'&@CRLF&'	Перезапустить?')=6 Then _restart()
			EndIf
			
		Case $Fill
			$OpenFile = FileOpenDialog('Открыть', @WorkingDir , 'Текстовый документ (*.txt)', 3, '', $Gui)
			If @error Then ContinueLoop
			If StringRight($OpenFile, 4)<>'.txt' Then $OpenFile&='.txt'
			Dim $aListText
			If Not _FileReadToArray($OpenFile, $aListText) Then
			   MsgBox(0,"Ошибка", 'Невозможно прочитать файл')
			   ContinueLoop
			EndIf
			If $aListText[0]>$IniReplace[0][0] Then
				ReDim $aListText[$IniReplace[0][0]+1]
				$aListText[0]=$IniReplace[0][0]
			EndIf
			For $i = 1 to $aListText[0]
				GUICtrlSetData($IniReplace[$i][2], $aListText[$i])
			Next

		Case $Save
			$SaveFile = FileSaveDialog('Сохранить как ...', @WorkingDir , 'Текстовый файл (*.txt)', 24, '', $Gui)
			If @error Then ContinueLoop
			If StringRight($SaveFile, 4) <> '.txt' Then $SaveFile&='.txt'
			$SvText=''
			For $i = 1 to $IniReplace[0][0]
				$SvText&=GUICtrlRead($IniReplace[$i][2])&@CRLF
			Next
			$SvText=StringTrimRight($SvText, 2)
			$file = FileOpen($SaveFile, 2)
			FileWrite($file, $SvText)
			FileClose($file)


		Case $hTemplate
			For $i = 1 to $IniReplace[0][0]
				GUICtrlDelete($IniReplace[$i][2])
				GUICtrlDelete($IniReplace[$i][3])
			Next
			$curent = GUICtrlRead($hTemplate)
			_Test($curent)
			
			_SetItem($curent)
		Case $Replace
			If $LastFolder='' Or Not FileExists($LastFolder) Then $LastFolder=@WorkingDir
			$SelFolder = FileSelectFolder('Открыть', '', 3, $LastFolder, $Gui) ; указываем выходную папку
			If @error Then ContinueLoop
			$LastFolder=$SelFolder

			GUICtrlSetData($StatusBar,'Обработка...')
			GUICtrlSetState($Replace, $GUI_DISABLE)
			GUICtrlSetState($Fill, $GUI_DISABLE)
			GUICtrlSetState($Save, $GUI_DISABLE)

			$searchDOCX = FileFindFirstFile(@ScriptDir&'\template\'&$curent&'\*.docx') ; поиск файлов docx и их обработка по очереди
			If $searchDOCX = -1 Then
				MsgBox(0, "Ошибка", "Не найдены docx-файлы, отмена операции.")
				GUICtrlSetData($StatusBar,'Не найдены docx-файлы, отмена операции.')
				GUICtrlSetState($Replace, $GUI_ENABLE)
				GUICtrlSetState($Fill, $GUI_ENABLE)
				GUICtrlSetState($Save, $GUI_ENABLE)
				ContinueLoop
			EndIf
			$fileDOCX=''
			While 1
				$tmp=FileFindNextFile($searchDOCX)
				If @error Then ExitLoop
				; And StringInStr(FileGetAttrib($SelFolder&'\'&$tmp), 'H')
				If StringLeft($tmp, 2)='~$' Then
					If MsgBox(4+256+8192+262144, 'Сообщение', 'Возможно открыт файл шаблона "'&$tmp&'" в Word 2007, что может привести к ошибке и закрытию программы. Рекомендуется закрыть документ. Продолжить?')=7 Then
						GUICtrlSetState($Replace, $GUI_ENABLE)
						GUICtrlSetState($Fill, $GUI_ENABLE)
						GUICtrlSetState($Save, $GUI_ENABLE)
						ContinueLoop 2
					EndIf
				Else
					$fileDOCX &= $tmp&'|'
				EndIf
			WEnd
			$fileDOCX = StringTrimRight($fileDOCX, 1)
			$fileDOCX = StringSplit($fileDOCX, '|') ; массив найденных docx-файлов
			
			$timer = TimerInit()
			$KolRe =0
			$timer0 =0
			
			For $i = 1 to $fileDOCX[0]

				GUICtrlSetData($StatusBar, $i&' / '&$fileDOCX[0]&'	замен: '&$KolRe& '	время: '&Round($timer0 / 1000, 1)& ' сек'&'	"'&$fileDOCX[$i]&'"')
				$timer0 = TimerInit()
				If FileExists($SelFolder&'\'&$fileDOCX[$i]) And MsgBox(4+8192+262144, 'Сообщение', 'Файл "'&$fileDOCX[$i]&'" уже существует, заменить?')=7 Then
					ContinueLoop
				Else

					; обработка каждого docx-файла
					$s_TempFile = _TempFile()
					FileCopy(@ScriptDir&'\template\'&$curent&'\'&$fileDOCX[$i], $s_TempFile & "\", 9)
					FileMove($s_TempFile & "\"&$fileDOCX[$i], $s_TempFile & "\template.zip", 9)
					_Zip_UnzipAll($s_TempFile&'\template.zip', $s_TempFile&'\TMP') ; распаковка
					$file = FileOpen($s_TempFile&'\TMP\word\document.xml', 256) ; открытие
					$text = FileRead($file)
					FileClose($file)
					; замена текста текущего файла
					For $j = 1 to $IniReplace[0][0]
						$text = StringReplace($text, $IniReplace[$j][1], GUICtrlRead($IniReplace[$j][2]))
						$KolRe+=@extended
					Next
					$file = FileOpen($s_TempFile&'\TMP\word\document.xml',2+256) ; запись нового
					FileWrite($file, $text)
					FileClose($file)
					$Zip = _Zip_Create($s_TempFile & "\template_New.zip")

					$search = FileFindFirstFile($s_TempFile & "\TMP\*") ; все файлы запаковываем в zip
					If $search = -1 Then
						MsgBox(0, "Ошибка", "Не найдены файлы составляющие docx-файл, отмена операции.")
						GUICtrlSetData($StatusBar,'Не найдены файлы составляющие docx-файл, отмена операции.')
						GUICtrlSetState($Replace, $GUI_ENABLE)
						GUICtrlSetState($Fill, $GUI_ENABLE)
						GUICtrlSetState($Save, $GUI_ENABLE)
						ContinueLoop
					EndIf
					While 1
						$file = FileFindNextFile($search)
						If @error Then ExitLoop
						_Zip_AddItem($Zip, $s_TempFile & "\TMP\"&$file) ; добавление по одному файлу
					WEnd
					FileClose($search)


					FileMove($s_TempFile & "\template_New.zip", $SelFolder&'\'&$fileDOCX[$i], 9) ; перемещаем упакованный файл в выходную папку без замены
				EndIf
				If FileExists($s_TempFile) Then DirRemove($s_TempFile, 1)
				$timer0=TimerDiff($timer0)


			Next
			FileClose($searchDOCX)


			GUICtrlSetData($StatusBar,'Выполнено! Всего: '&$fileDOCX[0]&' файлов за '&Round(TimerDiff($timer) / 1000, 1) & ' сек, количество замен: '&$KolRe)
			GUICtrlSetState($Replace, $GUI_ENABLE)
			GUICtrlSetState($Fill, $GUI_ENABLE)
			GUICtrlSetState($Save, $GUI_ENABLE)
		Case $About
			_About()
		Case -3
			Exit
	EndSwitch
WEnd

Func _Test($curent)
	; проверка валидности template.ini
	; $timer = TimerInit() ; достаточно бытро проверяет, 70 элементов за 9 мсек, поэтому отключил
	$file = FileOpen(@ScriptDir&'\template\'&$curent&'\template.ini', 0)
	$tmp = FileRead($file)
	FileClose($file)
	
	_Test_Key($tmp)
	$tmp=StringRegExp($tmp, '(?m)^[^;#]*?=.*?\|(.+?)(?:\|.*?$|$)', 3)
	$tmp1=''
	If Not @error Then
		For $i = 0 to UBound($tmp)-1
			$ind = _ArraySearch($tmp, $tmp[$i], $i+1, 0, 0, 1, 1)
			If $ind>-1 Then $tmp1&=@CRLF&$tmp[$i]&' в '&$tmp[$ind]
		Next
		If $tmp1<>'' Then MsgBox(8192+262144, 'Ошибка', 'Найдены повторы текста в значениях замены'&$tmp1)
	EndIf
	; GUICtrlSetData($StatusBar,'template.ini проверен за '&Round(TimerDiff($timer), 1) & ' мсек')
EndFunc

Func _Test_Key($tmp)
	Local $a=StringRegExp($tmp, '(?m)(^[^;#\r\n]*?)=.*?\|.+?(?:\|.*?$|$)', 3)
	If Not @error Then
		$k=0
		For $i = 0 To UBound($a) -1
			Assign($a[$i]&'_//', Eval($a[$i]&'_//')+1, 1)
			If Eval($a[$i]&'_//') = 2 Then
				$a[$k]=$a[$i]
				$k+=1
			EndIf
		Next
		If $k = 0 Then Return
		ReDim $a[$k]
		$tmp=''
		For $i = 0 to UBound($a)-1
			$tmp&='Параметр: '&$a[$i]&', количество повторов: '&Eval($a[$i]&'_//')&@CRLF
		Next
		If $tmp<>'' Then MsgBox(8192+262144, 'Ошибка', 'Избавтесь от повторов параметров в template.ini'&@CRLF&$tmp)
	Else
		MsgBox(8192+262144, 'Ошибка', 'Проверте формат записей в template.ini')
	EndIf
EndFunc

Func _SetItem($curent)
	$IniReplace = IniReadSection(@ScriptDir&'\template\'&$curent&'\template.ini', 'Set')
	ReDim $IniReplace[$IniReplace[0][0]+1][4]

	For $i = 1 to $IniReplace[0][0]
		$tmp = StringSplit($IniReplace[$i][1], '|')
		If $tmp[0]<2 Then
			MsgBox(8192+262144, 'Ошибка', 'Неверные данные в ini-файле')
			Exit
		EndIf
		$IniReplace[$i][0]=$tmp[1]
		$IniReplace[$i][1]=$tmp[2]
		$IniReplace[$i][3]=GUICtrlCreateLabel($tmp[1], 10, $i*$SizeIn+28+$SizeIn/3, 160, $SizeIn-5, $SS_LEFTNOWORDWRAP)
		$IniReplace[$i][2]=GUICtrlCreateInput('', 170, $i*$SizeIn+35, 600, $SizeIn-5)
		If $tmp[0]>2 Then
			If $tmp[3]<>'' Then GUICtrlSetBkColor(-1, _ColorBG($tmp[3]))
			If $tmp[0]>3 Then
				If $tmp[4]<>'' Then GUICtrlSetColor(-1, _ColorF($tmp[4]))
				If $tmp[0]>4 And $tmp[5]<>'' Then GUICtrlSetData(-1, $tmp[5])
			EndIf
		EndIf
	Next
	$tmp=$IniReplace[0][0]*$SizeIn+100
	$tmpZ=$tmp

	$aCoor=_WinAPI_GetWorkingArea()
	$DR=$aCoor[3]-$aCoor[1]
	If $tmp>$DR Then $tmp=$DR
	$tmp2=$aCoor[1]+($DR-$tmp)/2
	WinMove($Gui, '', Default, $tmp2, 810, $tmp)
	WM_SIZE($Gui, '', '', '') ; добавил чтоб сработал пересчёт даже если окно не изменилось
EndFunc

Func _ColorBG($c)
	Switch $c
		Case 'Red', 'Красный'
			$c = 0xffeeee
		Case 'Blue', 'Синий'
			$c = 0xeeeeff
		Case 'Green', 'Зелёный'
			$c = 0xeeffee
		Case 'Yellow', 'Жёлтый', 'Оранжевый'
			$c = 0xfefedd
		Case 'Turquoise', 'Бирюзовый', 'Голубой'
			$c = 0xddffff
		Case 'Mauve', 'Лиловый', 'Розовый'
			$c = 0xF9dfFF
		Case Else
			$c = '0x'&$c
	EndSwitch
	Return $c
EndFunc

Func _ColorF($c)
	Switch $c
		Case 'Red', 'Красный'
			$c = 0xff0000
		Case 'Blue', 'Синий'
			$c = 0x0000ff
		Case 'Green', 'Зелёный'
			$c = 0x00bb00
		Case 'Yellow', 'Жёлтый', 'Оранжевый'
			$c = 0xff9d00
		Case 'Turquoise', 'Бирюзовый', 'Голубой'
			$c = 0x00A1a6
		Case 'Mauve', 'Лиловый', 'Розовый'
			$c = 0xF200FF
		Case Else
			$c = '0x'&$c
	EndSwitch
	Return $c
EndFunc

Func WM_SIZE($hWnd, $Msg, $wParam, $lParam)
    #forceref $Msg, $wParam
    Local $index = -1, $yChar, $xChar, $xClientMax, $xClient, $yClient, $ivMax
    For $x = 0 To UBound($aSB_WindowInfo) - 1
        If $aSB_WindowInfo[$x][0] = $hWnd Then
            $index = $x
            $xClientMax = $aSB_WindowInfo[$index][1]
            $xChar = $aSB_WindowInfo[$index][2]
            $yChar = $aSB_WindowInfo[$index][3]
            $ivMax = $tmpZ/16-3
            ExitLoop
        EndIf
    Next
    If $index = -1 Then Return 0

    Local $tSCROLLINFO = DllStructCreate($tagSCROLLINFO)
    
    ; Retrieve the dimensions of the client area.
    $xClient = BitAND($lParam, 0x0000FFFF)
    $yClient = BitShift($lParam, 16)
    $aSB_WindowInfo[$index][4] = $xClient
    $aSB_WindowInfo[$index][5] = $yClient
    
    ; Set the vertical scrolling range and page size
    DllStructSetData($tSCROLLINFO, "fMask", BitOR($SIF_RANGE, $SIF_PAGE))
    DllStructSetData($tSCROLLINFO, "nMin", 0)
    DllStructSetData($tSCROLLINFO, "nMax", $ivMax)
    DllStructSetData($tSCROLLINFO, "nPage", $yClient / $yChar)
    _GUIScrollBars_SetScrollInfo($hWnd, $SB_VERT, $tSCROLLINFO)
    
    ; Set the horizontal scrolling range and page size
    DllStructSetData($tSCROLLINFO, "fMask", BitOR($SIF_RANGE, $SIF_PAGE))
    DllStructSetData($tSCROLLINFO, "nMin", 0)
    DllStructSetData($tSCROLLINFO, "nMax", 2 + $xClientMax / $xChar)
    DllStructSetData($tSCROLLINFO, "nPage", $xClient / $xChar)
    _GUIScrollBars_SetScrollInfo($hWnd, $SB_HORZ, $tSCROLLINFO)

    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_SIZE

Func WM_HSCROLL($hWnd, $Msg, $wParam, $lParam)
    #forceref $Msg, $lParam
    Local $nScrollCode = BitAND($wParam, 0x0000FFFF)

    Local $index = -1, $xChar, $xPos
    Local $Min, $Max, $Page, $Pos, $TrackPos

    For $x = 0 To UBound($aSB_WindowInfo) - 1
        If $aSB_WindowInfo[$x][0] = $hWnd Then
            $index = $x
            $xChar = $aSB_WindowInfo[$index][2]
            ExitLoop
        EndIf
    Next
    If $index = -1 Then Return 0
    
;~  ; Get all the horizontal scroll bar information
    Local $tSCROLLINFO = _GUIScrollBars_GetScrollInfoEx($hWnd, $SB_HORZ)
    $Min = DllStructGetData($tSCROLLINFO, "nMin")
    $Max = DllStructGetData($tSCROLLINFO, "nMax")
    $Page = DllStructGetData($tSCROLLINFO, "nPage")
    ; Save the position for comparison later on
    $xPos = DllStructGetData($tSCROLLINFO, "nPos")
    $Pos = $xPos
    $TrackPos = DllStructGetData($tSCROLLINFO, "nTrackPos")
    #forceref $Min, $Max
    Switch $nScrollCode

        Case $SB_LINELEFT ; user clicked left arrow
            DllStructSetData($tSCROLLINFO, "nPos", $Pos - 1)

        Case $SB_LINERIGHT ; user clicked right arrow
            DllStructSetData($tSCROLLINFO, "nPos", $Pos + 1)

        Case $SB_PAGELEFT ; user clicked the scroll bar shaft left of the scroll box
            DllStructSetData($tSCROLLINFO, "nPos", $Pos - $Page)

        Case $SB_PAGERIGHT ; user clicked the scroll bar shaft right of the scroll box
            DllStructSetData($tSCROLLINFO, "nPos", $Pos + $Page)

        Case $SB_THUMBTRACK ; user dragged the scroll box
            DllStructSetData($tSCROLLINFO, "nPos", $TrackPos)
    EndSwitch

;~    // Set the position and then retrieve it.  Due to adjustments
;~    //   by Windows it may not be the same as the value set.

    DllStructSetData($tSCROLLINFO, "fMask", $SIF_POS)
    _GUIScrollBars_SetScrollInfo($hWnd, $SB_HORZ, $tSCROLLINFO)
    _GUIScrollBars_GetScrollInfo($hWnd, $SB_HORZ, $tSCROLLINFO)
    ;// If the position has changed, scroll the window and update it
    $Pos = DllStructGetData($tSCROLLINFO, "nPos")
    If ($Pos <> $xPos) Then _GUIScrollBars_ScrollWindow($hWnd, $xChar * ($xPos - $Pos), 0)
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_HSCROLL

Func WM_VSCROLL($hWnd, $Msg, $wParam, $lParam)
    #forceref $Msg, $wParam, $lParam
    Local $nScrollCode = BitAND($wParam, 0x0000FFFF)
    Local $index = -1, $yChar, $yPos
    Local $Min, $Max, $Page, $Pos, $TrackPos

    For $x = 0 To UBound($aSB_WindowInfo) - 1
        If $aSB_WindowInfo[$x][0] = $hWnd Then
            $index = $x
            $yChar = $aSB_WindowInfo[$index][3]
            ExitLoop
        EndIf
    Next
    If $index = -1 Then Return 0


    ; Get all the vertial scroll bar information
    Local $tSCROLLINFO = _GUIScrollBars_GetScrollInfoEx($hWnd, $SB_VERT)
    $Min = DllStructGetData($tSCROLLINFO, "nMin")
    $Max = DllStructGetData($tSCROLLINFO, "nMax")
    $Page = DllStructGetData($tSCROLLINFO, "nPage")
    ; Save the position for comparison later on
    $yPos = DllStructGetData($tSCROLLINFO, "nPos")
    $Pos = $yPos
    $TrackPos = DllStructGetData($tSCROLLINFO, "nTrackPos")

    Switch $nScrollCode
        Case $SB_TOP ; user clicked the HOME keyboard key
            DllStructSetData($tSCROLLINFO, "nPos", $Min)

        Case $SB_BOTTOM ; user clicked the END keyboard key
            DllStructSetData($tSCROLLINFO, "nPos", $Max)

        Case $SB_LINEUP ; user clicked the top arrow
            DllStructSetData($tSCROLLINFO, "nPos", $Pos - 1)

        Case $SB_LINEDOWN ; user clicked the bottom arrow
            DllStructSetData($tSCROLLINFO, "nPos", $Pos + 1)

        Case $SB_PAGEUP ; user clicked the scroll bar shaft above the scroll box
            DllStructSetData($tSCROLLINFO, "nPos", $Pos - $Page)

        Case $SB_PAGEDOWN ; user clicked the scroll bar shaft below the scroll box
            DllStructSetData($tSCROLLINFO, "nPos", $Pos + $Page)

        Case $SB_THUMBTRACK ; user dragged the scroll box
            DllStructSetData($tSCROLLINFO, "nPos", $TrackPos)
    EndSwitch
    
;~    // Set the position and then retrieve it.  Due to adjustments
;~    //   by Windows it may not be the same as the value set.

    DllStructSetData($tSCROLLINFO, "fMask", $SIF_POS)
    _GUIScrollBars_SetScrollInfo($hWnd, $SB_VERT, $tSCROLLINFO)
    _GUIScrollBars_GetScrollInfo($hWnd, $SB_VERT, $tSCROLLINFO)
    ;// If the position has changed, scroll the window and update it
    $Pos = DllStructGetData($tSCROLLINFO, "nPos")

    If ($Pos <> $yPos) Then
        _GUIScrollBars_ScrollWindow($hWnd, 0, $yChar * ($yPos - $Pos))
        $yPos = $Pos
    EndIf

    Return $GUI_RUNDEFMSG

EndFunc   ;==>WM_VSCROLL

; прокручивание GUI мышкой
Func WM_MOUSEWHEEL($hWndGui, $MsgId, $wParam, $lParam)
    If $MsgId = $WM_MOUSEWHEEL And BitAND($wParam, 0xFFFF) = 0 Then ; только без клавиш-модификаторов
        $Delta = BitShift($wParam, 16)
		$tmp=_GUIScrollBars_GetScrollInfoPos($GUI, $SB_VERT)
			If $Delta > 0 Then
				_GUIScrollBars_SetScrollInfoPos($GUI, $SB_VERT, $tmp-5)
			Else
				_GUIScrollBars_SetScrollInfoPos($GUI, $SB_VERT, $tmp+5)
			EndIf
    EndIf
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
EndFunc

; вычисление координат дочернего окна
Func _ChildCoor($Gui, $w, $h, $c=0, $d=0)
	Local $aWA = _WinAPI_GetWorkingArea(), _
	$GP = WinGetPos($Gui), _
	$wgcs=WinGetClientSize($Gui), _
	$dLeft=($GP[2]-$wgcs[0])/2, _
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
Local $font, $GP, $Gui1, $msg, $url, $WbMn
$GP=_ChildCoor($Gui, 210, 180)
GUISetState(@SW_DISABLE, $Gui)
$font="Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], $WS_CAPTION + $WS_SYSMENU + $WS_POPUP, -1, $Gui)
	If Not @compiled Then GUISetIcon(@ScriptDir&'\ReplaceTemplateDOCX.ico')
	GUISetBkColor (0xffca48)
	GUICtrlCreateLabel('Форма заполнения'&@CRLF&'шаблона docx', 0, 0, 210, 63, 0x01)
	GUICtrlSetFont (-1,14, 600, -1, $font)
	GUICtrlSetColor(-1,0xa13d00)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,64,208,1,0x10)

	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.3  29.07.2011', 15, 100, 210, 17)
	GUICtrlCreateLabel($LngSite&':', 15, 115, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', 52, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 15, 130, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', 90, 130, 125, 17)
	GUICtrlSetColor(-1,0xa21a10)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2011', 15, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
	While 1
	  $msg = GUIGetMsg()
	  Select
		Case $msg = $url
			ShellExecute ('http://azjio.ucoz.ru')
		Case $msg = $WbMn
			ClipPut('R939163939152')
		Case $msg = -3
			GUISetState(@SW_ENABLE, $Gui)
			GUIDelete($Gui1)
			ExitLoop
		EndSelect
    WEnd
EndFunc