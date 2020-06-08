#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=CreationGui.exe
#AutoIt3Wrapper_icon=CreationGui.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=CreationGui.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 20.10.2010
#NoTrayIcon
#include <WindowsConstants.au3>

Opt("MouseCoordMode", 2)
Opt("GUIResizeMode", 0x0322)

Global $Label, $aE[1][6], $ECU, $w=120, $h=22, $AllWin[2][1]
GUIRegisterMsg(0x0112 , "WM_SYSCOMMAND")
GUIRegisterMsg(0x0115 , 'WM_VSCROLL')
GUIRegisterMsg(0x0114 , "WM_HSCROLL")

; En
$LngTitle='Creation Gui'
$LngAbout='About'
$LngVer='Version'
$LngSite='Site'
$LngCopy='Copy'
$LngSBH='Click to send coordinates to the clipboard'
$LngAcR='active red'
$LngAcRH='no context menu items'
$LngMltH='width*k'
$LngHEH='Width of the element'
$LngVEH='Height of the element'
$LngTH='Transparency'
$LngLH1='Ctrl+Left'
$LngRH1='Ctrl+Right'
$LngVH1='Ctrl+Up'
$LngNH1='Ctrl+Down'
$LngLH='Left'
$LngRH='Right'
$LngVH='Up'
$LngNH='Down'
$LngCpH='Copy item to the clipboard'&@CRLF&'PageDown'
$LngAdH='Add'&@CRLF&'Space'
$LngDlH='Delete'&@CRLF&'Del'
$LngSvH='Save the script'&@CRLF&'End'
$LngNmB='Button'
$LngNmCh='Checkbox'
$LngNmEd='Editable'
$LngNmGr='Group'
$LngNmLb='Label'
$LngNmIn='Input field'
$LngNmC1='List'
$LngNmC2='Dropdown'
$LngNmR='Radio'
$LngEH='This element can be moved'
$LngSel='Select'
$LngSPH='changing (x, y) from the previous'
$LngRS='reset'
$LngDlM='Delete'
$LngCpM='Copy'
$LngSCD='Set (w,h) the current default'
$LngTrs='Make transparent client area'

$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang=DllCall ( $Lang_dll, "int", "GetUserDefaultUILanguage" )
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)
DllClose($Lang_dll)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	$LngAbout='О программе'
	$LngVer='Версия'
	$LngSite='Сайт'
	$LngCopy='Копировать'
	$LngSBH='Кликни для отправки координат в буфер обмена'
	$LngAcR='Выделять активный'
	$LngAcRH='Не рекомендуется, так как перестаёт'&@CRLF&'работать контекст. меню у элементов'
	$LngMltH='Множитель элемента'
	$LngHEH='Ширина элемента'
	$LngVEH='Высота элемента'
	$LngTH='Прозрачность'
	$LngLH1='Ctrl+Стрелка влево'
	$LngRH1='Ctrl+Стрелка вправо'
	$LngVH1='Ctrl+Стрелка вверх'
	$LngNH1='Ctrl+Стрелка вниз'
	$LngLH='Стрелка влево'
	$LngRH='Стрелка вправо'
	$LngVH='Стрелка вверх'
	$LngNH='Стрелка вниз'
	$LngCpH='Копировать элемент в буфер обмена'&@CRLF&'PageDown'
	$LngAdH='Добавить элемент'&@CRLF&'Space'
	$LngDlH='Удалить элемент'&@CRLF&'Del'
	$LngSvH='Сохранить в скрипт'&@CRLF&'End'
	$LngNmB='Кнопка'
	$LngNmCh='Чекбокс'
	$LngNmEd='Редактируемое'
	$LngNmGr='Группа'
	$LngNmLb='Лэйбл'
	$LngNmIn='Поле ввода'
	$LngNmC1='Список'
	$LngNmC2='Раскрывающийся'
	$LngNmR='Радиокнопка'
	$LngEH='Этот элемент можно перемещать'
	$LngSel='Указать файл'
	$LngSPH='Установить элемент (x,y), сместив'&@CRLF&'относительно предыдущего'
	$LngRS='Сброс'
	$LngDlM='Удалить элемент'
	$LngCpM='Копировать элемент'
	$LngSCD='Установить размеры w,h текущими'
	$LngTrs='Сделать прозрачным клиентскую область'
EndIf

$aE[0][0]=0
$GUI = GUICreate($LngTitle, 440, 370, -1, -1, $WS_OVERLAPPEDWINDOW, $WS_EX_LAYERED)
$StatusBar = GUICtrlCreateLabel('00,00,00,00', 270, 5, 140, 19, 0xC)
GUICtrlSetTip(-1, $LngSBH)
GUICtrlSetFont (-1,11)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)

$About = GUICtrlCreateButton("@", 2, 284, 18, 20)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$restart = GUICtrlCreateButton("R", 22, 284, 18, 20)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)


$lineV=GUICtrlCreateLabel ("-------", 250,0,1, 260,0x10)
GUICtrlSetResizing(-1, 64+32 +4)
$lineH=GUICtrlCreateLabel ("|||||||", 0,260,250,1,0x11)
GUICtrlSetResizing(-1, 64+2+4)

$lg=GUICtrlCreateLabel('', 0, 0, 250, 260)
GUICtrlSetBkColor(-1, 0xd4d5d6)
GUICtrlSetState(-1, 128)
GUICtrlSetResizing(-1, 102+256)
_WinAPI_SetLayeredWindowAttributes($GUI, 0x041523, 255)

$ChKm = GUICtrlCreateCheckbox ($LngAcR, 310, 314, 135, 20)
GUICtrlSetTip(-1, $LngAcRH)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$kaima = GUICtrlCreateLabel ("", -20, -20, 5, 5)
GUICtrlSetBkColor (-1, 0xff0000)

$input1= GUICtrlCreateInput ("1",45, 284, 45, 22)
GUICtrlSetTip(-1, $LngMltH)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$Check1 = GUICtrlCreateUpdown($input1)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$Check01=1

; горизонтальный
$Slider1 = GUICtrlCreateSlider(90, 280, 192, 30)
GUICtrlSetTip(-1, $LngHEH)
GUICtrlSetData(-1,"50")
GUICtrlSetLimit(-1, 200, 8)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$slider01=GUICtrlRead($slider1)

$input = GUICtrlCreateInput ("1",288, 133, 45, 22)
GUICtrlSetTip(-1, $LngMltH)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$Check = GUICtrlCreateUpdown($input)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$Check0=1

; вертикальный
$slider2 = GUICtrlCreateSlider(290, 155, 30, 150, 0x0002)
GUICtrlSetTip(-1, $LngVEH)
GUICtrlSetData(-1,"50")
GUICtrlSetLimit(-1, 150, 38)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$slider02=GUICtrlRead($slider2)

; прозрачность
$slider3 = GUICtrlCreateSlider(320, 155, 30, 150, 0x0002)
GUICtrlSetTip(-1, $LngTH)
GUICtrlSetLimit(-1, 185, 0)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$slider03=GUICtrlRead($slider3)

$sL1 = GUICtrlCreateButton('<', 290, 50, 20, 20)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngLH1)
$sR1 = GUICtrlCreateButton('>', 330, 50, 20, 20)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngRH1)
$sV1 = GUICtrlCreateButton('^', 310, 30, 20, 20)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngVH1)
$sN1 = GUICtrlCreateButton('v', 310, 70, 20, 20)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngNH1)
; GUICtrlSetColor (-1, 0xff0000)

$sL = GUICtrlCreateButton(ChrW(0x25C4), 290, 70, 20, 20)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetFont (-1,-1, -1, -1, 'Arial')
GUICtrlSetTip(-1, $LngLH)

$sR = GUICtrlCreateButton(ChrW(0x25BA), 330, 70, 20, 20)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetFont (-1,-1, -1, -1, 'Arial')
GUICtrlSetTip(-1, $LngRH)

$sV = GUICtrlCreateButton(ChrW(0x25B2), 310, 50, 20, 20)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetFont (-1,-1, -1, -1, 'Arial')
GUICtrlSetTip(-1, $LngVH)

$sN = GUICtrlCreateButton(ChrW(0x25BC), 310, 90, 20, 20)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetFont (-1,-1, -1, -1, 'Arial')
GUICtrlSetTip(-1, $LngNH)

; $Add = GUICtrlCreateButton("Add", 145, 320, 40, 23)
; GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
; GUICtrlSetTip(-1, $LngAdH)

$Copy = GUICtrlCreateButton("Copy", 355, 255, 35, 23)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngCpH)

$Del = GUICtrlCreateButton("Del", 355, 280, 35, 23)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngDlH)

$save = GUICtrlCreateButton("save", 395, 255, 35, 23)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngSvH)

$Trans = GUICtrlCreateCheckbox("Trns", 395, 280, 37, 23)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
; GUICtrlSetState(-1, 1)
GUICtrlSetTip(-1, $LngTrs)

$Combo = GUICtrlCreateList('',370, 27, 55, 170)
GUICtrlSetData(-1,"Button|Checkbox|Edit|Group|Label|Input|List|ListView|Combo|Radio","Button")
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

GUICtrlCreateGroup('', 365, 180, 65, 71)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

$reset = GUICtrlCreateButton($LngRS, 370, 190, 55, 17)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

GUICtrlCreateLabel ("w=", 369,211,15, 17,0xC)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$WInp = GUICtrlCreateInput("", 385, 210, 40, 19)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetData(-1,120)

GUICtrlCreateLabel ("h=", 370,229,15, 17,0xC)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$HInp = GUICtrlCreateInput("", 385, 228, 40, 19)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetData(-1,22)

GUICtrlCreateGroup('', 146, 303, 154, 34)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)

GUICtrlCreateLabel ("x=+", 150,314,19, 17,0xC)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$WPos = GUICtrlCreateInput("", 172, 314, 30, 19)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetData(-1,0)

GUICtrlCreateLabel ("y=+", 210,314,19, 17,0xC)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$HPos = GUICtrlCreateInput("", 231, 314, 30, 19)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetData(-1,5)

$SetPos = GUICtrlCreateButton("Pos", 265, 313, 30, 22)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1, $LngSPH &@CRLF&'SPACE')

$ko=''
$Win=''

Dim $AccelKeys[12][2]=[["{LEFT}", $sL], ["{RIGHT}", $sR], ["{UP}", $sV], ["{DOWN}", $sN], ["^{LEFT}", $sL1], ["^{RIGHT}", $sR1], ["^{UP}", $sV1], ["^{DOWN}", $sN1], ["{DEL}", $Del], ["{SPACE}", $SetPos], ["{END}", $save], ["{PGDN}", $Copy]]
GUISetAccelerators($AccelKeys)

GUISetState()
$GP = WinGetPos($Gui)
$delta=$GP[3]-370

Global Const $SPI_GETWORKAREA = 0x30
Global $nGap = 15, $nEdge = BitOR(1, 2, 4, 8); Left, Top, Right, Bottom
GUIRegisterMsg(0x0046, "WM_WINDOWPOSCHANGING")
GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")

While 1
    $msg = GUIGetMsg()
	
    For $i = 1 to $aE[0][0]
        If $aE[$i][3]<>'' And $msg = $aE[$i][3] Then
            GUICtrlDelete ($aE[$i][0])
            GUICtrlDelete ($aE[$i][3])
            GUICtrlDelete ($aE[$i][4])
            $aE[$i][0]=''
            $aE[$i][3]=''
            $aE[$i][4]=''
            GUICtrlSetPos($kaima,-20, -20, 5, 5)
        EndIf
        If $aE[$i][4]<>'' And $msg = $aE[$i][4] Then
            ClipPut('$element='&$aE[$ECU][1]&'('''', '&GUICtrlRead($StatusBar)&')')
            _SB()
        EndIf
        If $aE[$i][5]<>'' And $msg = $aE[$i][5] Then
			$aID0 = ControlGetPos($GUI, "", $aE[$ECU][0])
			GUICtrlSetData($WInp,$aID0[2])
			GUICtrlSetData($HInp,$aID0[3])
        EndIf
    Next
    Select
		Case $msg = $About
			_About()
		Case $msg = $restart
			_restart()
        Case $msg =  $sL
            _sLR(-1)
        Case $msg =  $sR
            _sLR(1)
        Case $msg =  $sV
            _sVN(-1)
        Case $msg =  $sN
            _sVN(1)
        Case $msg =  $sL1
            _sLR1(-1)
        Case $msg =  $sR1
            _sLR1(1)
        Case $msg =  $sV1
            _sVN1(-1)
        Case $msg =  $sN1
            _sVN1(1)
        Case $msg =  $Copy
            ClipPut('$element='&$aE[$ECU][1]&'('''', '&GUICtrlRead($StatusBar)&')')
            _SB()
        Case $msg =  $Trans
            If GUICtrlRead($Trans)=1 Then
				_WinAPI_SetLayeredWindowAttributes($GUI, 0xd4d5d6, 255-$slider03)
			Else
				_WinAPI_SetLayeredWindowAttributes($GUI, 0x041523, 255-$slider03)
			EndIf
        Case $msg =  $Check
            $slider02+=1
			WM_VSCROLL()
        Case $msg =  $Check1
            $slider01+=1
			WM_HSCROLL()
        Case $msg =  $StatusBar ; в буфер
            ClipPut(GUICtrlRead($StatusBar))
            _SB()
        Case $msg =  $save
                $body=''
                $aV = ControlGetPos($GUI, "", $lineV)
                $aH = ControlGetPos($GUI, "", $lineH)
            For $i = 1 to $aE[0][0]
                If $aE[$i][0]<>'' Then
                    $aID0 = ControlGetPos($GUI, "", $aE[$i][0])
                    $body&='$element'&$i&'='&$aE[$i][1]&'('''', '&$aID0[0] & ", " & $aID0[1] & ", " & $aID0[2] & ", " & $aID0[3]&')'&@CRLF
                EndIf
            Next
            
                $folder03 = FileSaveDialog($LngSel, @WorkingDir & "", "AutoIt3 (*.au3)", 24, 'New_script.au3')
                If @error Then ContinueLoop
                If StringRegExp($folder03,'(^.*)\.(.*)$',3)=@error Then $folder03&='.au3'
                
            $file = FileOpen($folder03,2)
            FileWrite($file, _
'$Gui = GUICreate("My Program", '&$aH[2]&', '&$aV[3]&')' & @CRLF & $body & _
'GUISetState ()' & @CRLF & _
'While 1' & @CRLF & _
'   $msg = GUIGetMsg()' & @CRLF & _
'   Select' & @CRLF & _
'       Case $msg = -3' & @CRLF & _
'           Exit' & @CRLF & _
'   EndSelect' & @CRLF & _
'WEnd')
            FileClose($file)
        Case $msg =  $Combo
            _Add(GUICtrlRead($Combo))
        Case $msg =  $reset
			$w=120
			$h=22
			GUICtrlSetData($WInp,'120')
			GUICtrlSetData($HInp,'22')
        Case $msg =  $SetPos
            If $ECU< 2 Then ContinueLoop
			For $zn = 1 to $aE[$ECU][0]
				If $aE[$ECU-$zn][0]<>'' Then ExitLoop
			Next
			$XPos=GUICtrlRead($WPos)
			$YPos=GUICtrlRead($HPos)
			$GP = WinGetPos($Gui)
            $aID0 = ControlGetPos($GUI, "", $aE[$ECU-$zn][0])
			$x01=$aID0[0]+$XPos
			$y01=$aID0[1]+$aID0[3]+$YPos
; MsgBox(0, 'Сообщение', $GP[2]&@CRLF&$GP[3]-$delta-40&@CRLF&$x01&@CRLF&$y01)
			If $x01>$GP[2]-20 Or $y01>$GP[3]-$delta-40 Then ContinueLoop
			GUICtrlSetPos($aE[$ECU][0],$x01, $y01)
			If GUICtrlRead($ChKm) = 1 Then
				$aID0 = ControlGetPos($GUI, "", $aE[$ECU][0])
				GUICtrlSetPos($kaima,$aID0[0]-1, $aID0[1]-1, $aID0[2]+2, $aID0[3]+2)
			Else
				GUICtrlSetPos($kaima,-20, -20, 5, 5)
			EndIf
        Case $msg =  $Del
            GUICtrlDelete ($aE[$ECU][0])
            GUICtrlDelete ($aE[$ECU][3])
            GUICtrlDelete ($aE[$ECU][4])
            $aE[$ECU][0]=''
            $aE[$ECU][3]=''
            $aE[$ECU][4]=''
            GUICtrlSetPos($kaima,-20, -20, 5, 5)
			
            If $ECU> 1 Then
				$Label=$aE[$ECU-1][0]
				$ECU-=1
			EndIf
        Case $msg =  -7
            $aCur_Info = GUIGetCursorInfo($GUI)
            If $aCur_Info[4]<43 Then ContinueLoop ; не перетаскивать другие элементы
            $Label=$aCur_Info[4]
            For $i = 1 to $aE[0][0]
                If $aE[$i][0]=$aCur_Info[4] Then $ECU=$i
            Next
            $aID=$aCur_Info[4] ; ID-элемента
            $aID_Pos = ControlGetPos($GUI, "", $aID)
            ; высчитываем разницу координат
            $dX= $aID_Pos[0]-$aCur_Info[0]
            $dY= $aID_Pos[1]-$aCur_Info[1]
            
            While 1
                $aCur_Info = GUIGetCursorInfo($GUI) ; получаем новую инфу
                GUICtrlSetPos($aID, $aCur_Info[0]+$dX, $aCur_Info[1]+$dY) ; устанавливаем новые координаты
                If $aCur_Info[2] = 0 Then ExitLoop ; выход если курсор отпущен
                If $ko<>$aCur_Info[0]+$dX & ", " & $aCur_Info[1]+$dY & ", " & $aID_Pos[2] & ", " & $aID_Pos[3] Then ; добавляем в статистику
                    $ko=$aCur_Info[0]+$dX & ", " & $aCur_Info[1]+$dY & ", " & $aID_Pos[2] & ", " & $aID_Pos[3]
                    ; $GP = WinGetPos($Gui)
                    ; ToolTip($ko, $GP[0], $GP[1]-25 )
                    GUICtrlSetData($StatusBar,$ko)
                EndIf
                If GUICtrlRead($ChKm) = 1 Then
                    GUICtrlSetPos($kaima,$aCur_Info[0]+$dX-1, $aCur_Info[1]+$dY-1, $aID_Pos[2]+2, $aID_Pos[3]+2)
                Else
                    GUICtrlSetPos($kaima,-20, -20, 5, 5)
                EndIf
            WEnd
        Case $msg = -3
            Exit
    EndSelect
WEnd
            
Func _sLR($1)
    $aID0 = ControlGetPos($GUI, "", $Label)
    GUICtrlSetPos($Label, $aID0[0]+$1, $aID0[1], $aID0[2], $aID0[3])
    $ko=$aID0[0]+$1 & ", " & $aID0[1] & ", " & $aID0[2] & ", " & $aID0[3]
    ; ToolTip($ko)
    GUICtrlSetData($StatusBar,$ko)
    
    If GUICtrlRead($ChKm) = 1 Then
        GUICtrlSetPos($kaima,$aID0[0]-1+$1, $aID0[1]-1, $aID0[2]+2, $aID0[3]+2)
    Else
        GUICtrlSetPos($kaima,-20, -20, 5, 5)
    EndIf
EndFunc
            
Func _sVN($1)
    $aID0 = ControlGetPos($GUI, "", $Label)
    GUICtrlSetPos($Label, $aID0[0], $aID0[1]+$1, $aID0[2], $aID0[3])
    $ko=$aID0[0] & ", " & $aID0[1]+$1 & ", " & $aID0[2] & ", " & $aID0[3]
    ; ToolTip($ko)
    GUICtrlSetData($StatusBar,$ko)
    
    If GUICtrlRead($ChKm) = 1 Then
        GUICtrlSetPos($kaima,$aID0[0]-1, $aID0[1]-1+$1, $aID0[2]+2, $aID0[3]+2)
    Else
        GUICtrlSetPos($kaima,-20, -20, 5, 5)
    EndIf
EndFunc

Func _sLR1($1)
    $aID0 = ControlGetPos($GUI, "", $Label)
    GUICtrlSetPos($Label, $aID0[0], $aID0[1], $aID0[2]+$1, $aID0[3])
    $ko=$aID0[0] & ", " & $aID0[1] & ", " & $aID0[2]+$1 & ", " & $aID0[3]
    ; ToolTip($ko)
    GUICtrlSetData($StatusBar,$ko)
    
    If GUICtrlRead($ChKm) = 1 Then
        GUICtrlSetPos($kaima,$aID0[0]-1, $aID0[1]-1, $aID0[2]+2+$1, $aID0[3]+2)
    Else
        GUICtrlSetPos($kaima,-20, -20, 5, 5)
    EndIf
EndFunc

Func _sVN1($1)
    $aID0 = ControlGetPos($GUI, "", $Label)
    GUICtrlSetPos($Label, $aID0[0], $aID0[1], $aID0[2], $aID0[3]+$1)
    $aID0 = ControlGetPos($GUI, "", $Label)
    $ko=$aID0[0] & ", " & $aID0[1] & ", " & $aID0[2] & ", " & $aID0[3]
    ; ToolTip($ko)
    GUICtrlSetData($StatusBar,$ko)
    
    If GUICtrlRead($ChKm) = 1 Then
        GUICtrlSetPos($kaima,$aID0[0]-1, $aID0[1]-1, $aID0[2]+2, $aID0[3]+2)
    Else
        GUICtrlSetPos($kaima,-20, -20, 5, 5)
    EndIf
EndFunc

Func _SB()
    For $i = 1 to 4
        GUICtrlSetBkColor ($StatusBar, 0xff0000 )
        GUICtrlSetColor ($StatusBar, 0xffffff)
        Sleep(40)
        GUICtrlSetBkColor ($StatusBar, -1 )
        GUICtrlSetColor ($StatusBar, 0xff0000)
        Sleep(40)
    Next
    GUICtrlSetColor ($StatusBar, 0x000000)
EndFunc

Func _Add($1)
   $h=GUICtrlRead($HInp)
   $w=GUICtrlRead($WInp)
    $GP = WinGetPos($Gui)
    $GP[3]-=$delta
    $GP[3]-=60
    If $aE[0][0]= 0 Then $GP[3]=50
    $aE[0][0]+=1
    $k=$aE[0][0]
    ReDim $aE[$aE[0][0]+1][6]
    GUICtrlSetData($slider2,"50")
    GUICtrlSetData($Slider1,"50")
    Switch $1
        Case 'Button'
            $aE[$k][0]=GUICtrlCreateButton($k&' '&$LngNmB, 10, $GP[3], $w, $h)
            $aE[$k][1]='GUICtrlCreateButton'
            $aE[$k][2] = GUICtrlCreateContextMenu($aE[$k][0])
            $aE[$k][3]  = GUICtrlCreateMenuitem ($LngDlM,$aE[$k][2] )
            $aE[$k][4]  = GUICtrlCreateMenuitem ($LngCpM,$aE[$k][2] )
            $aE[$k][5]  = GUICtrlCreateMenuitem ($LngSCD,$aE[$k][2] )
        Case 'Checkbox'
            $aE[$k][0]=GUICtrlCreateCheckbox($k&' '&$LngNmCh, 10, $GP[3], $w, $h)
            GUICtrlSetBkColor ($aE[$k][0], 0xbbbbbb )
            $aE[$k][1]='GUICtrlCreateCheckbox'
            $aE[$k][2] = GUICtrlCreateContextMenu($aE[$k][0])
            $aE[$k][3]  = GUICtrlCreateMenuitem ($LngDlM,$aE[$k][2] )
            $aE[$k][4]  = GUICtrlCreateMenuitem ($LngCpM,$aE[$k][2] )
            $aE[$k][5]  = GUICtrlCreateMenuitem ($LngSCD,$aE[$k][2] )
        Case 'Edit' ;одна строка
            $aE[$k][0]=GUICtrlCreateEdit($k&' '&$LngNmEd, 10, $GP[3], $w, $h)
            $aE[$k][1]='GUICtrlCreateEdit'
        Case 'Group' ;одна строка
            $aE[$k][0]=GUICtrlCreateGroup($k&' '&$LngNmGr, 10, $GP[3], $w, $h)
            $aE[$k][1]='GUICtrlCreateGroup'
        Case 'Label'
            $aE[$k][0]=GUICtrlCreateLabel($k&' '&$LngNmLb, 10, $GP[3], $w, $h)
            GUICtrlSetBkColor ($aE[$k][0], 0xbbbbbb )
            $aE[$k][1]='GUICtrlCreateLabel'
            $aE[$k][2] = GUICtrlCreateContextMenu($aE[$k][0])
            $aE[$k][3]  = GUICtrlCreateMenuitem ($LngDlM,$aE[$k][2] )
            $aE[$k][4]  = GUICtrlCreateMenuitem ($LngCpM,$aE[$k][2] )
            $aE[$k][5]  = GUICtrlCreateMenuitem ($LngSCD,$aE[$k][2] )
        Case 'Input' ;одна строка
            $aE[$k][0]=GUICtrlCreateInput($k&' '&$LngNmIn, 10, $GP[3], $w, $h)
            $aE[$k][1]='GUICtrlCreateInput'
        Case 'List'
            $aE[$k][0]=GUICtrlCreateList($k&"List", 10, $GP[3], $w, $h)
            $aE[$k][1]='GUICtrlCreateList'
            $aE[$k][2] = GUICtrlCreateContextMenu($aE[$k][0])
            $aE[$k][3]  = GUICtrlCreateMenuitem ($LngDlM,$aE[$k][2] )
            $aE[$k][4]  = GUICtrlCreateMenuitem ($LngCpM,$aE[$k][2] )
            $aE[$k][5]  = GUICtrlCreateMenuitem ($LngSCD,$aE[$k][2] )
        Case 'ListView'
            $aE[$k][0]=GUICtrlCreateListView($k&"ListView", 10, $GP[3], $w, $h)
            $aE[$k][1]='GUICtrlCreateListView'
            $aE[$k][2] = GUICtrlCreateContextMenu($aE[$k][0])
            $aE[$k][3]  = GUICtrlCreateMenuitem ($LngDlM,$aE[$k][2] )
            $aE[$k][4]  = GUICtrlCreateMenuitem ($LngCpM,$aE[$k][2] )
            $aE[$k][5]  = GUICtrlCreateMenuitem ($LngSCD,$aE[$k][2] )
        Case 'Combo'
            $aE[$k][0]=GUICtrlCreateCombo("", 10, $GP[3], $w, $h, 0x3)
            GUICtrlSetData($aE[$k][0],$k&' '&$LngNmC1&"|"&$k&' '&$LngNmC2,$k&' '&$LngNmC1)
            $aE[$k][1]='GUICtrlCreateCombo'
            $aE[$k][2] = GUICtrlCreateContextMenu($aE[$k][0])
            $aE[$k][3]  = GUICtrlCreateMenuitem ($LngDlM,$aE[$k][2] )
            $aE[$k][4]  = GUICtrlCreateMenuitem ($LngCpM,$aE[$k][2] )
            $aE[$k][5]  = GUICtrlCreateMenuitem ($LngSCD,$aE[$k][2] )
			$aID0 = ControlGetPos($GUI, "", $aE[$k][0])
			GUICtrlSetPos($kaima,$aID0[0], $aID0[1], $aID0[2], $aID0[3])
        Case 'Radio'
            $aE[$k][0]=GUICtrlCreateRadio($k&' '&$LngNmR, 10, $GP[3], $w, $h)
            GUICtrlSetBkColor ($aE[$k][0], 0xbbbbbb )
            $aE[$k][1]='GUICtrlCreateRadio'
            $aE[$k][2] = GUICtrlCreateContextMenu($aE[$k][0])
            $aE[$k][3]  = GUICtrlCreateMenuitem ($LngDlM,$aE[$k][2] )
            $aE[$k][4]  = GUICtrlCreateMenuitem ($LngCpM,$aE[$k][2] )
            $aE[$k][5]  = GUICtrlCreateMenuitem ($LngSCD,$aE[$k][2] )
        Case Else
            $aE[$k][0]=GUICtrlCreateButton($k&' '&$LngNmB, 10, $GP[3], $w, $h)
            $aE[$k][1]='GUICtrlCreateButton'
            $aE[$k][2] = GUICtrlCreateContextMenu($aE[$k][0])
            $aE[$k][3]  = GUICtrlCreateMenuitem ($LngDlM,$aE[$k][2] )
            $aE[$k][4]  = GUICtrlCreateMenuitem ($LngCpM,$aE[$k][2] )
            $aE[$k][5]  = GUICtrlCreateMenuitem ($LngSCD,$aE[$k][2] )
    EndSwitch
    GUICtrlSetTip($aE[$k][0], $LngEH)
    $Label=$aE[$k][0]
    $ECU=$k
EndFunc

Func WM_SYSCOMMAND()
Global $Win
$Win0 = ''
	$AllWin = WinList()
	For $i = 1 To $AllWin[0][0]
		If _IsVisible($AllWin[$i][1]) And $AllWin[$i][0] <> "" And $AllWin[$i][0] <> "Program Manager" And $AllWin[$i][0] <> $LngTitle And StringRight(_ProcessGetPath(WinGetProcess($AllWin[$i][0])), 12)<>'explorer.exe' Then
			$Win = WinGetPos($AllWin[$i][1])
			$Win0&=$Win[0]&'|'&$Win[1] &'|'
		EndIf
	Next
	$Win = StringSplit(StringTrimRight($Win0, 1), '|')
EndFunc

; магнитить к окнам при сближении 15 пиксел
Func __WM_MOVE()
If $Win = '' Then Return
	For $i = 1 To $Win[0] Step 2
			$GP = WinGetPos($Gui)
			If Abs($GP[0]-$Win[$i]) < 15 And Abs($GP[1]-$Win[$i+1]) < 15 Then WinMove($Gui, "", $Win[$i], $Win[$i+1], $GP[2], $GP[3])
	Next
EndFunc

; http://www.autoitscript.com/forum/topic/24342-form-snap/page__view__findpost__p__170144
Func WM_WINDOWPOSCHANGING($hWnd, $Msg, $wParam, $lParam)
	If $Win = '' Then Return
	Local $stRect = DllStructCreate("int;int;int;int")
	Local $stWinPos = DllStructCreate("uint;uint;int;int;int;int;uint", $lParam)
	DllCall("User32.dll", "int", "SystemParametersInfo", "int", $SPI_GETWORKAREA, "int", 0, "ptr", DllStructGetPtr($stRect), "int", 0)
	For $i = 1 To $Win[0] Step 2
		If Abs(DllStructGetData($stWinPos, 3)-$Win[$i]) < $nGap And Abs(DllStructGetData($stWinPos, 4)-$Win[$i+1]) < $nGap Then
			DllStructSetData($stWinPos, 3, $Win[$i])
			DllStructSetData($stWinPos, 4, $Win[$i+1])
		EndIf
	Next
    Return 0
EndFunc

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	If $hWnd = $GUI Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 370)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 440) 
	EndIf
EndFunc

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

Func WM_VSCROLL()
    If GUICtrlRead($slider3)<>$slider03 Then
        $slider03=GUICtrlRead($slider3)
		    If GUICtrlRead($Trans)=1 Then  ; прозрачность
				_WinAPI_SetLayeredWindowAttributes($GUI, 0xd4d5d6, 255-$slider03)
			Else
				_WinAPI_SetLayeredWindowAttributes($GUI, 0x041523, 255-$slider03)
			EndIf
    EndIf
    If GUICtrlRead($slider2)<>$slider02 Then ; вертикальный
	   $aID0 = ControlGetPos($GUI, "", $Label)
	   If Not @error Then
           $slider02=GUICtrlRead($slider2)
            $Check0=GUICtrlRead($input)
            $slid2=Int($h*$slider02/50)*$Check0
            GUICtrlSetPos($Label, $aID0[0], $aID0[1], $aID0[2], $slid2)
           $aID0 = ControlGetPos($GUI, "", $Label)
            $ko=$aID0[0] & ", " & $aID0[1] & ", " & $aID0[2] & ", " & $aID0[3]
                    ; $GP = WinGetPos($Gui)
            ; ToolTip($ko, $GP[0], $GP[1]-25 )
            GUICtrlSetData($StatusBar,$ko)
            If GUICtrlRead($ChKm) = 1 Then
                GUICtrlSetPos($kaima,$aID0[0]-1, $aID0[1]-1, $aID0[2]+2, $aID0[3]+2)
            Else
                GUICtrlSetPos($kaima,-20, -20, 5, 5)
            EndIf
        EndIf
    EndIf
EndFunc

Func WM_HSCROLL()
    If GUICtrlRead($slider1)<>$slider01 Then ; горизонтальный
	   $aID0 = ControlGetPos($GUI, "", $Label)
	   If Not @error Then
           $slider01=GUICtrlRead($slider1)
            $Check01=GUICtrlRead($input1)
            $slid1=Int($w*$slider01/50)*$Check01
            GUICtrlSetPos($Label, $aID0[0], $aID0[1], $slid1, $aID0[3])
           $aID0 = ControlGetPos($GUI, "", $Label)
            $ko=$aID0[0] & ", " & $aID0[1] & ", " & $aID0[2] & ", " & $aID0[3]
                    ; $GP = WinGetPos($Gui)
            ; ToolTip($ko, $GP[0], $GP[1]-25 )
            GUICtrlSetData($StatusBar,$ko)
            If GUICtrlRead($ChKm) = 1 Then
                GUICtrlSetPos($kaima,$aID0[0]-1, $aID0[1]-1, $aID0[2] +2, $aID0[3]+2)
            Else
                GUICtrlSetPos($kaima,-20, -20, 5, 5)
            EndIf
         EndIf
    EndIf
EndFunc

Func _WinAPI_SetLayeredWindowAttributes($hWnd, $i_transcolor, $Transparency = 255, $dwFlags = 0x03, $isColorRef = False)
If $dwFlags = Default Or $dwFlags = "" Or $dwFlags < 0 Then $dwFlags = 0x03
If Not $isColorRef Then
$i_transcolor = Hex(String($i_transcolor), 6)
$i_transcolor = Execute('0x00' & StringMid($i_transcolor, 5, 2) & StringMid($i_transcolor, 3, 2) & StringMid($i_transcolor, 1, 2))
EndIf
Local $aResult = DllCall("user32.dll", "bool", "SetLayeredWindowAttributes", "hwnd", $hWnd, "dword", $i_transcolor, "byte", $Transparency, "dword", $dwFlags)
If @error Then Return SetError(@error, @extended, False)
Return $aResult[0]
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
EndFunc   ;==>_restart


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
Local $msg
$GP=_ChildCoor($Gui, 270, 180)
GUISetState(@SW_DISABLE, $Gui)
$font="Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOr($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui) ; WS_CAPTION+WS_SYSMENU
	GUISetBkColor (0xffca48)
	GUICtrlCreateLabel($LngTitle, 0, 0, 270, 63, 0x01+0x0200)
	GUICtrlSetFont (-1,15, 600, -1, $font)
	GUICtrlSetColor(-1,0xa13d00)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,64,268,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.3  20.10.2010', 55, 100, 210, 17)
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