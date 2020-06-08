#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=ReplaceTemplate.exe
#AutoIt3Wrapper_icon=ReplaceTemplate.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=ReplaceTemplate.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Field=Version|0.2
#AutoIt3Wrapper_Res_Field=Build|2011.07.23
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 23.07.2011 AutoIt3_v3.3.7.14

#NoTrayIcon
#include <ZIP.au3>
#include <GUIConstantsEx.au3>
#include <File.au3>
#include <WindowsConstants.au3>
; #include <Array.au3>

Opt('GUIResizeMode', 802)

$LngAbout='О программе'
$LngVer='Версия'
$LngCopy='Копировать'
$LngSite='Сайт'

Global $IniReplace[1], $Gui
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
    $k+=1
    If $k = 1 Then $curent=$file
	$List&=$file&'|'
WEnd
$List=StringTrimRight($List, 1)
FileClose($search)

$Gui=GUICreate('Форма заполнения шаблона docx', 780, 40)
If Not @compiled Then GUISetIcon(@ScriptDir&'\ReplaceTemplate.ico')
$About=GUICtrlCreateButton ("@", 1,1,18,18)
GUICtrlSetTip(-1, $LngAbout)
GUICtrlCreateLabel('Шаблон :', 120, 10, 60, 17)
$hTemplate=GUICtrlCreateCombo('', 170, 7, 260)
GUICtrlSetData(-1, $List, $curent)
$Replace=GUICtrlCreateButton('Создать', 640, 3, 130, 34)
$Fill=GUICtrlCreateButton('Заполнить', 480, 8, 70, 24)
$Save=GUICtrlCreateButton('Сохранить', 560, 8, 70, 24)
_SetItem($curent)
GUISetState ()

; GUICtrlSetData($IniReplace[1][2],'Анастасия Владимировна Мурашкина')
; GUICtrlSetData($IniReplace[2][2],'20586194')
; GUICtrlSetData($IniReplace[3][2],'ул. Каштанова д.4 кв.9')

While 1
	$msg = GUIGetMsg()
	Switch $msg
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
			_SetItem($curent)
		Case $Replace
			$SelFolder = FileSelectFolder('Открыть', '', 3,@WorkingDir, $Gui) ; указываем выходную папку
			If @error Then ContinueLoop

			GUICtrlSetData($Replace,'Обработка')
			GUICtrlSetState($Replace, $GUI_DISABLE)
			
			$searchDOCX = FileFindFirstFile(@ScriptDir&'\template\'&$curent&'\*.docx') ; поиск файлов docx и их обработка по очереди
			If $searchDOCX = -1 Then
				MsgBox(0, "Ошибка", "Не найдены docx-файлы, отмена операции.")
				GUICtrlSetData($Replace,'Создать')
				GUICtrlSetState($Replace, $GUI_ENABLE)
				ContinueLoop
			EndIf
			While 1
				$fileDOCX = FileFindNextFile($searchDOCX) 
				If @error Then ExitLoop
				
				If FileExists($SelFolder&'\'&$fileDOCX) And MsgBox(4+8192+262144, 'Сообщение', 'Файл "'&$fileDOCX&'" уже существует, заменить?')=7 Then
					ContinueLoop
				Else

					$s_TempFile = _TempFile()
					FileCopy(@ScriptDir&'\template\'&$curent&'\'&$fileDOCX, $s_TempFile & "\", 9)
					FileMove($s_TempFile & "\"&$fileDOCX, $s_TempFile & "\template.zip", 9)
					_Zip_UnzipAll($s_TempFile&'\template.zip', $s_TempFile&'\TMP') ; распаковка
					$file = FileOpen($s_TempFile&'\TMP\word\document.xml', 256) ; открытие
					$text = FileRead($file)
					FileClose($file)
					; замена текста текущего файла
					For $i = 1 to $IniReplace[0][0]
						$text = StringReplace($text, $IniReplace[$i][1], GUICtrlRead($IniReplace[$i][2]))
					Next
					$file = FileOpen($s_TempFile&'\TMP\word\document.xml',2+256) ; запись нового
					FileWrite($file, $text)
					FileClose($file)
					$Zip = _Zip_Create($s_TempFile & "\template_New.zip")
					
					$search = FileFindFirstFile($s_TempFile & "\TMP\*") ; все файлы запаковываем в zip
					If $search = -1 Then
						MsgBox(0, "Ошибка", "Не найдены файлы составляющие docx-файл, отмена операции.")
						GUICtrlSetData($Replace,'Создать')
						GUICtrlSetState($Replace, $GUI_ENABLE)
						ContinueLoop
					EndIf
					While 1
						$file = FileFindNextFile($search) 
						If @error Then ExitLoop
						_Zip_AddItem($Zip, $s_TempFile & "\TMP\"&$file) ; добавление по одному файлу
					WEnd
					FileClose($search)
				
				
					FileMove($s_TempFile & "\template_New.zip", $SelFolder&'\'&$fileDOCX, 9) ; перемещаем упакованный файл в выходную папку без замены
				EndIf
				If FileExists($s_TempFile) Then DirRemove($s_TempFile, 1)
				
				
			WEnd
			FileClose($searchDOCX)


			
			GUICtrlSetData($Replace,'Создать')
			GUICtrlSetState($Replace, $GUI_ENABLE)
		Case $About
			_About()
		Case -3
			 Exit
	EndSwitch
WEnd


Func _SetItem($curent)
	$IniReplace = IniReadSection(@ScriptDir&'\template\'&$curent&'\template.ini', 'Set')
	ReDim $IniReplace[$IniReplace[0][0]+1][4]
	
	For $i = 1 to $IniReplace[0][0]
		$tmp = StringSplit($IniReplace[$i][1], '|')
		If $tmp[0]<2 Then
			MsgBox(0, 'Сообщение', 'Неверные данные в ini-файле')
			Exit
		EndIf
		$IniReplace[$i][0]=$tmp[1]
		$IniReplace[$i][1]=$tmp[2]
		$IniReplace[$i][3]=GUICtrlCreateLabel($tmp[1], 10, $i*25+15, 160, 17)
		$IniReplace[$i][2]=GUICtrlCreateInput('', 170, $i*25+15, 600, 20)
	Next
	WinMove($Gui, '', Default, Default, 780, $IniReplace[0][0]*25+80)
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
	GUISetBkColor (0xffca48)
	GUICtrlCreateLabel('Форма заполнения'&@CRLF&'шаблона docx', 0, 0, 210, 63, 0x01)
	GUICtrlSetFont (-1,14, 600, -1, $font)
	GUICtrlSetColor(-1,0xa13d00)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,64,208,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.2  23.07.2011', 15, 100, 210, 17)
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