#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=Color_marking_resistor.exe
#AutoIt3Wrapper_icon=Color_marking_resistor.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Color_marking_resistor.exe
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; AZJIO 14.03.2011 (AutoIt3_v3.3.6.1)

#NoTrayIcon
#include <StaticConstants.au3>

; En
$LngTitle='Color marking resistor'
$LngAbout='About'
$LngVer='Version'
$LngSite='Site'
$LngCopy='Copy'
$aLngCol='Silver|Gold|Black|Brown|Red|Orange|Yellow|Green|Blue|Purple|Gray|White'
$LngCle='Clear'
$LngOhm='Ohm'
$LngCcl='Choose color'

$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang=DllCall ( $Lang_dll, "int", "GetUserDefaultUILanguage" )
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)
DllClose($Lang_dll)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	$LngTitle='Цветовая маркировка резисторов'
	$LngAbout='О программе'
	$LngVer='Версия'
	$LngSite='Сайт'
	$LngCopy='Копировать'
	$aLngCol='Серебристый|Золотистый|Чёрный|Коричневый|Красный|Оранжевый|Жёлтый|Зелёный|Голубой|Фиолетовый|Серый|Белый'
	$LngCle='Очистить'
	$LngOhm='Ом'
	$LngCcl='Выберите цвет'
EndIf
$aLngCol=StringSplit($aLngCol, '|')

Global $Table[13][4] = _
[[12,0,0,0], _
[-2,'+/-10',0xBBBBBB,0], _
[-1,'+/-5',0xEDCE32,0], _
[0,'',0x0,0], _
[1,'+/-1',0x844200,0], _
[2,'+/-2',0xFF0000,0], _
[3,'',0xFF8400,0], _
[4,'',0xFFFF00,0], _
[5,'+0.5',0x00DD00,0], _
[6,'+0.25',0x3B5BFF,0], _
[7,'+0.1',0x9E3DFF,0], _
[8,'',0x999999,0], _
[9,'',0xFFFFFF,0]]
;0 - number - число или множитель
;1 - infelicity - допуск, погрешность
;2 - color - цвет
;3 - control ID

$Gui = GUICreate($LngTitle, 380, 180)
If Not @compiled Then GUISetIcon(@ScriptDir&'\Color_marking_resistor.ico')
Global $But[5][2]=[[0,0],[0,0],[0,0],[0,0],[0,0]]

GUISetFont(13)
For $i = 1 to $Table[0][0]
	 $Table[$i][3]=GUICtrlCreateLabel($Table[$i][0], 30*$i-20, 10, 30, 30, $SS_CENTER+$SS_CENTERIMAGE)
	GUICtrlSetBkColor(-1, $Table[$i][2])
	GUICtrlSetTip(-1,$aLngCol[$i])
	GUICtrlSetCursor(-1, 0)
Next
GUICtrlSetColor($Table[3][3], 0x999999)

; GUICtrlCreateLabel('', 30,60,220,60,$SS_BLACKFRAME)
GUICtrlCreateLabel('', 29,59,220,62)
GUICtrlSetState(-1, 128)
GUICtrlSetBkColor(-1, 0x0)
GUICtrlCreateLabel('', 30,60,220,60)
GUICtrlSetState(-1, 128)
GUICtrlSetBkColor(-1, 0xEAEAAC)

GUICtrlCreateLabel('', 29,56,22,68)
GUICtrlSetBkColor(-1, 0x0)

GUICtrlCreateLabel('', 30,57,20,66)
GUICtrlSetBkColor(-1, 0xEAEAAC)

GUICtrlCreateLabel('', 229,56,22,68)
GUICtrlSetBkColor(-1, 0x0)

GUICtrlCreateLabel('', 230,57,20,66)
GUICtrlSetBkColor(-1, 0xEAEAAC)

GUICtrlCreateLabel('', 15,88,15,4)
GUICtrlSetBkColor(-1, 0x222222)

GUICtrlCreateLabel('', 251,88,13,4)
GUICtrlSetBkColor(-1, 0x222222)

For $i = 1 to 4
	$But[$i][0]=GUICtrlCreateLabel('', 40*$i+30, 60, 20, 60, $SS_CENTER+$SS_CENTERIMAGE)
	GUICtrlSetBkColor(-1, -2)
	; GUICtrlSetColor(-1, 0x990099)
	GUICtrlSetCursor(-1, 0)
Next

$Out2=GUICtrlCreateLabel('', 270, 75, 200, 25)
GUICtrlSetFont(-1,18)
$Out=GUICtrlCreateLabel($LngCcl, 70, 140, 200, 25)
GUICtrlSetFont(-1,15)
$Clear=GUICtrlCreateButton($LngCle, 290, 140, 80, 35)
GUICtrlSetFont(-1,9)
$About=GUICtrlCreateButton('@', 0, 160, 20, 20)
GUICtrlSetFont(-1,8.5)
$indLab=GUICtrlCreateLabel('', 77, 53, 5, 5)
GUICtrlSetBkColor(-1, 0xAA0000)
$ind=0
_ind($ind+1)

GUISetState ()

While 1
	$msg = GUIGetMsg()
	For $i = 1 to 4
		If $msg=$But[$i][0] Then
			$ind=$i-1
			$But[$i][1]=0
			GUICtrlSetBkColor($But[$i][0], -2)
			_ind($ind+1)
		EndIf
	Next
	For $i = 1 to $Table[0][0]
		If $msg=$Table[$i][3] Then
			$ind+=1
			If $ind>4 Then $ind=1
			If (($ind = 1 Or $ind=2)And($i=1 Or $i=2))Or($ind = 1 And $i=3)Or(($i = 3 Or $i=6 Or $i=7 Or $i=11 Or $i=12) And $ind=4) Then
				$ind-=1
				ContinueLoop 2
			EndIf

			GUICtrlSetBkColor($But[$ind][0], $Table[$i][2])
			GUICtrlSetData($But[$ind][0], $Table[$i][0])
			$But[$ind][1]=$Table[$i][0]
			$tmp=Execute($But[1][1]&$But[2][1])&' * 10^'&$But[3][1]
			
			Switch Execute($tmp)
				Case 0 To 999
				   $tmp2 = Execute($tmp)&' '&$LngOhm
				Case 1000 To 999999
				   $tmp2 = Execute($tmp)/1000&' K'
				Case 1000000 To 1000000000
				   $tmp2 = Execute($tmp)/10^6&' M'
				Case Else
				   $tmp2 = $tmp
			EndSwitch
			GUICtrlSetData($Out2, $tmp2)
			
			If $ind>3 And $Table[$i][1] Then $tmp&='   '&$Table[$i][1]&'%'
			GUICtrlSetData($Out,$tmp)
			_ind($ind+1)
		EndIf
	Next
	Switch $msg
		Case $Clear
			For $i = 1 to 4
				GUICtrlSetBkColor($But[$i][0], -2)
				GUICtrlSetData($Out,$LngCcl)
				GUICtrlSetData($Out2,'')
				GUICtrlSetData($But[$i][0], '')
				$But[$i][1]=0
			Next
			$ind=0
			_ind(1)
		Case $About
			_About()
		Case -3
			Exit
	EndSwitch
WEnd

Func _ind($indT)
	For $i = 1 to $Table[0][0]
		Switch $indT
			Case 1, 5
				Switch $i
					Case 1,2,3
					   GUICtrlSetCursor($Table[$i][3], 7)
					   GUICtrlSetState($Table[$i][3], 32)
					Case Else
					   GUICtrlSetCursor($Table[$i][3], 0)
					   GUICtrlSetState($Table[$i][3], 16)
				EndSwitch
				GUICtrlSetPos($indLab, 77, 53)
			Case 2
				Switch $i
					Case 1,2
					   GUICtrlSetCursor($Table[$i][3], 7)
					   GUICtrlSetState($Table[$i][3], 32)
					Case Else
					   GUICtrlSetCursor($Table[$i][3], 0)
					   GUICtrlSetState($Table[$i][3], 16)
				EndSwitch
				GUICtrlSetPos($indLab, 77+40, 53)
			Case 3
				GUICtrlSetCursor($Table[$i][3], 0)
				GUICtrlSetState($Table[$i][3], 16)
				GUICtrlSetPos($indLab, 77+40*2, 53)
			Case 4
				Switch $i
					Case 3,6,7,11,12
					   GUICtrlSetCursor($Table[$i][3], 7)
					   GUICtrlSetState($Table[$i][3], 32)
					Case Else
					   GUICtrlSetCursor($Table[$i][3], 0)
					   GUICtrlSetState($Table[$i][3], 16)
				EndSwitch
				GUICtrlSetPos($indLab, 77+40*3, 53)
		EndSwitch
	Next
EndFunc

Func _About()
$GuiPos = WinGetPos($Gui)
GUISetState(@SW_DISABLE, $Gui)
$font="Arial"
    $Gui1 = GUICreate($LngAbout, 270, 180,$GuiPos[0]+$GuiPos[2]/2-135, $GuiPos[1]+$GuiPos[3]/2-90, -1, 0x00000080,$Gui)
	GUISetBkColor (0xffca48)
	GUICtrlCreateLabel('', 0, 0, 270, 63)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel($LngTitle, 0, 10, 270, 63, 0x01)
	GUICtrlSetFont (-1,15, 600, -1, $font)
	GUICtrlSetColor(-1,0xa13d00)
	GUICtrlSetBkColor (-1, -2)
	GUICtrlCreateLabel ("-", 2,64,268,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.1  14.03.2011', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite&':', 55, 115, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetColor(-1,0xa21a10)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010-2011', 55, 145, 210, 17)
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