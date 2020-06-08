#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=Create_list_files.exe
#AutoIt3Wrapper_icon=Create_list_files.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Create_list_files.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 4.11.2010
$HelpTxt='Утилитка предназначена для составления списка файлов или списка копирования/обработки файлов указанного каталога. Список может быть регистрацией библиотек dll, перевода в верхний регистр, копирование, удаление. Сама утилита не выполняет никаких действий над файлами, кроме создания списка. Содержимое списка определяется шаблоном строки. Редактируйте шесть строк шаблона считая их одной последовательной строкой.'
#NoTrayIcon
Global $aTypInp0[1], $TypInp0, $TT='\*.'


$PosW=370
$Gui = GUICreate("Создать список файлов",  $PosW, 400, -1, -1, -1, 0x00000010)
If @compiled=0 Then GUISetIcon('Create_list_files.ico')

$Help = GUICtrlCreateButton("?", $PosW-62, 2, 18, 20)
GUICtrlSetTip(-1, 'Справка')

$About = GUICtrlCreateButton("@", $PosW-41, 2, 18, 20)
GUICtrlSetTip(-1, 'О программе')
$restart = GUICtrlCreateButton("R", $PosW-20, 2, 18, 20)
GUICtrlSetTip(-1, 'Перезапуск утилиты')

$Label1 = GUICtrlCreateLabel("Путь поиска файлов	(drag-and-drop)", 20, 10, 226, 17)
$Input1 = GUICtrlCreateInput("", 20, 27, 305, 23)
GUICtrlSetState(-1, 8)
$folder1 = GUICtrlCreateButton("...", 324, 27, 26, 24)
GUICtrlSetFont (-1,16)

$Label2 = GUICtrlCreateLabel("Типы файлов:", 24, 70, 76, 17)
$Combo2 = GUICtrlCreateCombo("", 100, 67, 224, 21)
GUICtrlSetData(-1, '*|inf;reg;txt;au3|bak;gid;log;tmp|htm;html;css;js;php|bmp;gif;jpg;jpeg;png;tif;tiff|exe;msi;scr;dll;cpl;ax|com;sys;bat;cmd', '*')

GUICtrlCreateLabel("Создаваемый Файл-Список", 20, 95, 186, 17)
$Input3 = GUICtrlCreateCombo("", 20, 112, 305, 23, 0x0003)
GUICtrlSetData(-1, '1. file.bat (в текущей папке)|2. file.cmd (в текущей папке)|3. file.txt (в текущей папке)|4. другой путь', '3. file.txt (в текущей папке)')
$folder3 = GUICtrlCreateButton("...", 324, 112, 26, 24)
GUICtrlSetFont (-1,16)



$specsymbol = GUICtrlCreateButton("Tab", 290, 190, 44, 24)
GUICtrlSetTip(-1, 'Вставить табуляцию в шаблон для деления'&@CRLF&'на колонки в табличном редакторе')

; GUICtrlCreateLabel("Спецсимвол в буфер", 260, 165, 110, 17)
; $specsymbol = GUICtrlCreateCombo("", 290, 183, 44, 24)
; GUICtrlSetData(-1, '|'&ChrW(0x9)&'|'&ChrW(0x00A9)&'|'&ChrW(0x00AE)&'|'&ChrW(0x00AB)&'|'&ChrW(0x00BB)&'|'&ChrW(0x2030)&'|'&ChrW(0x00A7)&'|'&ChrW(0x00B5)&'|'&ChrW(0x20AC)&'|'&ChrW(0x2122), '')
; GUICtrlSetTip(-1, 'Копировать спецсимвол в буфер'&@CRLF&'обмена для вставки в шаблон'&@CRLF&'первый символ (квадрат) - табуляция')

GUICtrlCreateGroup ("Шаблон добавляемой строчки", 15, 160, 240, 220)

GUICtrlCreateLabel("Перфикс", 24, 190, 53, 17)
$Inp1 = GUICtrlCreateInput("", 75, 190, 160, 21)
GUICtrlSetData(-1, 'xcopy /q /h /y /k /c "')

$Com1 = GUICtrlCreateCombo("", 75, 220, 160, 20, 0x0003)
GUICtrlSetData(-1, '1. Полный путь|2. Относительный путь|3. Имя файла|4. Ничего', '1. Полный путь')

GUICtrlCreateLabel("Средина", 24, 250, 53, 17)
$Inp2 = GUICtrlCreateInput("", 75, 250, 160, 21)
GUICtrlSetData(-1, '" "B:\')

$Com2 = GUICtrlCreateCombo("", 75, 280, 160, 20, 0x0003)
GUICtrlSetData(-1, '1. Полный путь|2. Относительный путь|3. Имя файла|4. Ничего', '2. Относительный путь')

GUICtrlCreateLabel("Суфикс", 24, 310, 53, 17)
$Inp3 = GUICtrlCreateInput("", 75, 310, 160, 21)
GUICtrlSetData(-1, '"')

$Com3 = GUICtrlCreateCombo("", 75, 340, 160, 20, 0x0003)
GUICtrlSetData(-1, '1. Размер|2. Дата|3. Ничего', '3. Ничего')

$Start=GUICtrlCreateButton("Создать", 270, 340, 77, 40)


GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
			Case $msg = $Start
				$Inp01=GUICtrlRead ($Inp1)
				$Inp02=GUICtrlRead ($Inp2)
				$Inp03=GUICtrlRead ($Inp3)
				$PatInp0=GUICtrlRead ($Input1)
				$TypInp0=GUICtrlRead ($Combo2)
				$Input03=StringLeft (GUICtrlRead ($Input3), 1)
				$Com01=StringLeft (GUICtrlRead ($Com1), 1)
				$Com02=StringLeft (GUICtrlRead ($Com2), 1)
				$Com03=StringLeft (GUICtrlRead ($Com3), 1)
				
				Switch $Input03
					Case 1
						$Input03=@ScriptDir&'\file.bat'
					Case 2
						$Input03=@ScriptDir&'\file.cmd'
					Case 3
						$Input03=@ScriptDir&'\file.txt'
					Case Else
						$Input03=GUICtrlRead ($Input3)
						If Not FileExists($Input03) Then
							MsgBox(0, 'Сообщение', 'Отсутсвует выходной файл')
							ContinueLoop
						EndIf
				EndSwitch
				
				; проверки-защиты
				If Not FileExists($PatInp0) Or StringInStr(FileGetAttrib($PatInp0), "D") = 0 Then
					MsgBox(0, 'Сообщение', 'Путь неверный')
					ContinueLoop
				EndIf
				
				If StringInStr(';1;2;3;4;', ';'&$Com01&';')=0 Or StringInStr(';1;2;3;4;', ';'&$Com02&';')=0 Or StringInStr(';1;2;3;', ';'&$Com03&';')=0 Then
					MsgBox(0, 'Сообщение', 'Неправильно заполнены раскрывающиеся списки')
					ContinueLoop
				EndIf
				
				If Not FileExists($PatInp0) Or StringInStr(FileGetAttrib($PatInp0), "D") = 0 Then
					MsgBox(0, 'Сообщение', 'Путь неверный')
					ContinueLoop
				EndIf
				
				If $TypInp0 = '' Then
					$TypInp0='*'
					$TT='\'
				Else
					$TT='\*.'
				EndIf
				; создаём массив типов файлов
				If StringInStr($TypInp0, ';') Then
					$aTypInp0=StringSplit($TypInp0, ';')
				Else
					ReDim $aTypInp0[2]
					Dim $aTypInp0[2]=[1, $TypInp0]
				EndIf
				
				
				$file10 = FileOpen($Input03,2)
				
				$PatInp00=''
				$PatInp01=''
				$t=''
				$Com030=''
				
				If $Com01 = 1 Or $Com01 = 4 Then
					$PatInp00=$PatInp0&'\'
				Else
					$PatInp00=''
				EndIf
				
				If $Com02 = 1 Or $Com02 = 4 Then
					$PatInp01=$PatInp0&'\'
				Else
					$PatInp01=''
				EndIf
				
				If $Com03 = 3 Then $Com03=''
				
				For $i = 1 to $aTypInp0[0]
					$search = _FileFindFirstFile($PatInp0&$TT&$aTypInp0[$i],1)
					If $search = -1 Then ExitLoop
					While 1
						$file = _FileFindNextFile($search)
						If @error Then ExitLoop
						$file1=$file
						If $Com03 = 1 Then $Com030='	'&FileGetSize($PatInp0&'\'&$file)
						If $Com03 = 2 Then
							$t=FileGetTime($PatInp0&'\'&$file)
							If Not @error Then $Com030='	'&$t[0] & "." & $t[1] & "." & $t[2]
						EndIf

						If $Com01 = 3 Then $file=StringRegExpReplace($file, '(^.*)\\(.*)$', '\2')
						If $Com02 = 3 Then $file1=StringRegExpReplace($file1, '(^.*)\\(.*)$', '\2')
						If $Com01 = 4 Then
							$file=''
							$PatInp00=''
						EndIf
						If $Com02 = 4 Then
							$file1=''
							$PatInp01=''
						EndIf
						
						FileWrite($file10, $Inp01&$PatInp00&$file&$Inp02&$PatInp01&$file1&$Inp03&$Com030& @CRLF)
					WEnd
					_FileFindClose($search)
				Next
				FileClose($file10)


			Case $msg = $About
				_About()
			Case $msg = $restart
				_restart()
			Case $msg = $Help
				MsgBox(0, 'Справка', $HelpTxt)
			Case $msg = $specsymbol
				GUICtrlSetData($Inp1, GUICtrlRead ($Inp1)&ChrW(0x9))
				GUICtrlSetData($Inp2, GUICtrlRead ($Inp2)&ChrW(0x9))
				GUICtrlSetData($Inp3, GUICtrlRead ($Inp3)&ChrW(0x9))
			Case $msg =  -13
				If @GUI_DropID=$Input1 Then
					If StringInStr(FileGetAttrib(@GUI_DRAGFILE), "D") =0 Then
						GUICtrlSetData($Input1, '')
						ContinueLoop
					Else
						GUICtrlSetData($Input1, @GUI_DRAGFILE)
					EndIf
				EndIf
				; If @GUI_DropID=$Input2 Then GUICtrlSetData($Input2, @GUI_DRAGFILE)
				; If @GUI_DropID=$Input3 Then GUICtrlSetData($Input3, @GUI_DRAGFILE)
				; кнопки обзор
			Case $msg = $folder1
				$folder01 = FileSelectFolder ( "Указать папку",'','3',@WorkingDir & '')
				If @error Then ContinueLoop
				GUICtrlSetData($Input1, $folder01)
			Case $msg = $Input3
				$Input03=StringLeft (GUICtrlRead ($Input3), 1)
				If $Input03 <> 4 Then ContinueLoop
				ContinueCase
			Case $msg = $folder3
				$folder03 = FileOpenDialog("Указать файл", @WorkingDir & "", "Любой (*.*)", 2 )
				If @error Then ContinueLoop
				If StringRegExpReplace($folder03, '.*\.(\S+)', '\1')=@error Then $folder03&='.txt'
				GUICtrlSetData($Input3, $folder03)
				GUICtrlSetData($Input3, $folder03)
				$file = FileOpen($folder03,2)
				FileClose($file)
			Case $msg = -3
				Exit
		EndSelect
	WEnd

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
EndFunc   ;==>_restart



;Title .........: FileFind
;Author(s) .....: Nikzzzz (_FileFindFirstFile + _FileFindNextFile + _FileFindClose)
;http://forum.ru-board.com/topic.cgi?forum=5&topic=33902&start=129&limit=1&m=1#1
Func _FileFindFirstFile($sFile,$iMode=3)
    Local $avStack[5]
    $avStack[0] = 0
    $avStack[1] = StringMid($sFile, StringInStr($sFile, "\", 0, -1) + 1)
    $avStack[1] = StringRegExpReplace($avStack[1], "[\\\(\)\{\}\+\$\.]", "\\\0")
    $avStack[1] = StringReplace($avStack[1], "*", ".*")
    $avStack[1] = StringReplace($avStack[1], "?", ".")
    $avStack[2] = $iMode
    $avStack[3] = StringLeft($sFile, StringInStr($sFile, "\", 0, -1) - 1)
    $avStack[4] = FileFindFirstFile($avStack[3] & "\*.*")
    If $avStack[4] = -1 Then
        SetError(1)
        Return -1
    EndIf
    Return $avStack
EndFunc   ;==>_FileFindFirstFile

Func _FileFindNextFile(ByRef $avStack)
    Local $sFindFile
    While 1
        $sFindFile = FileFindNextFile($avStack[$avStack[0] + 4])
        If Not @error Then
            If StringInStr(FileGetAttrib($avStack[$avStack[0] + 3] & "\" & $sFindFile), "D") > 0 Then
                $avStack[0] += 2
                ReDim $avStack[$avStack[0] + 5]
                $avStack[$avStack[0] + 3] = $avStack[$avStack[0]+1] & "\" & $sFindFile
                $avStack[$avStack[0] + 4] = FileFindFirstFile($avStack[$avStack[0] + 3] & "\*.*")
                If BitAND($avStack[2],2) Then Return StringMid($avStack[$avStack[0] + 3], StringLen($avStack[3]) + 2)
                ContinueLoop
            Else
                If StringRegExpReplace($sFindFile, $avStack[1], "") = "" Then
                    SetError(0)
                    If BitAND($avStack[2],1) Then Return StringMid($avStack[$avStack[0] + 3] & "\" & $sFindFile, StringLen($avStack[3]) + 2)
                Else
                    ContinueLoop
                EndIf
            EndIf
        Else
            If $avStack[0] = 0 Then
                SetError(-1)
                Return ""
            Else
                FileClose($avStack[$avStack[0] + 4])
                $avStack[0] -= 2
                ReDim $avStack[$avStack[0] + 5]
            EndIf
        EndIf
    WEnd
EndFunc   ;==>_FileFindNextFile

Func _FileFindClose(ByRef $avStack)
    Local $iRetVaue
    While $avStack[0] >= 0
        $iRetVaue=FileClose($avStack[$avStack[0] + 4])
        $avStack[0] -= 2
    WEnd
    ReDim $avStack[1]
    Return $iRetVaue
EndFunc   ;==>_FileFindClose

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
$LngTitle='Создание списка файлов'
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
	GUICtrlSetFont (-1,14, 600, -1, $font)
	GUICtrlSetColor(-1,0xa13d00)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,64,268,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.2  4.11.2010', 55, 100, 210, 17)
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