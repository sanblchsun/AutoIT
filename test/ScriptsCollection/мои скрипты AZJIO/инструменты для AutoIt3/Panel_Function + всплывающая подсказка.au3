#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=Panel_Function.exe
#AutoIt3Wrapper_icon=Panel_Function.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Panel_Function.exe
#AutoIt3Wrapper_Res_Fileversion=0.4.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2.04.2011

If Not @compiled Then TraySetIcon(@ScriptDir&'\Panel_Function.ico')

; En
$LngTitle='Panel function'
$LngAbout='About'
$LngVer='Version'
$LngCopy='Copy'
$LngSite='Site'
$LngTop='Always on top'
$LngMsg1='Profitable offer'
$LngMsg2='Want to create Panel_Function.ini?'
$LngMsg3='Otherwise exit.'
$LngMsg4='Want to create example AU3.ini and BAT.ini?'
$LngMsg5='Caution'
$LngMsg6='One of the files (AU3.ini, BAT.ini) exist, overwrite them?'
$LngMsg7='Make a copy before you proceed. Otherwise exit.'
$LngMsg8='Unable to open file.'
$LngMsg9='Message'
$LngMsg10='Enter the name of the button,'&@CRLF&'preferably short'
$LngMsg11='Error on the sample'
$LngMsg12='Open the editor'
$LngMsg13='To change requires a restart Bar. Restart Bar?'
$LngMsg14='The library must have at least one sample'
$LngMsg15='You changed the library.'&@CRLF&'Continue without saving?'
$LngMsg16='The Library is faulty, you want to overwrite it, replacing all data on the test sample?'
$LngMenu='Menu'
$LngReP='Restart Bar'
$LngAdd='Add a sample from the Clipboard'
$LngSvSt='Save settings and library'
$LngSvPAs='Save the library as...'
$LngEdLd='Edit Library'
$LngHide='AutoHide'
$LngHTp='Sensitive edge'
$LngRd1='Top of the screen'
$LngRd2='On the right screen'
$LngRd3='Left of the screen'
$LngRd4='Bottom of the screen'
$LngDly='Delay, ms :'
$LngHlp='Help'
$LngEdt='The choice of Notepad'
$LngClb='Clipboard'
$LngDel='Delete'
$LngHnt='Hint'
$LngSvD1='Save the file.'
$LngSvD2='file samples'
$LngErr='Error'
$LngDrg='Drag'
$LngCnl='Change nested list'
$LngSmp='Library of the samples'
$LngMsH='To insert code into the editor Notepad++, SciTE.'&@CRLF&'Ctrl+F11 - add the selected text'&@CRLF&'Blue box is designed to drag the panel.'&@CRLF&'Click on the abbreviation adds code to the editor.'&@CRLF&'On the shortcut menu item, you can view the template'&@CRLF&'or remove the item.'

$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang=DllCall ( $Lang_dll, "int", "GetUserDefaultUILanguage" )
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)
DllClose($Lang_dll)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	$LngTitle='Панель функций'
	$LngAbout='О программе'
	$LngVer='Версия'
	$LngCopy='Копировать'
	$LngSite='Сайт'
	$LngTop='Поверх всех окон'
	$LngMsg1='Выгодное предложение'
	$LngMsg2='Хотите создать необходимый Panel_Function.ini?'
	$LngMsg3='Иначе выход.'
	$LngMsg4='Хотите создать необходимый файл примера AU3_Sample.ini и BAT_Sample.ini?'
	$LngMsg5='Предостережение'
	$LngMsg6='Один из файлов AU3_Sample.ini и BAT_Sample.ini существуют, перезаписать их?'
	$LngMsg7='Сделайте их копию перед продолжением. Иначе выход.'
	$LngMsg8='Невозможно открыть файл.'
	$LngMsg9='Сообщение'
	$LngMsg10='Введите имя кнопки' & @CRLF & 'желательно короткое'
	$LngMsg11='Ошибка на образце'
	$LngMsg12='Откройте редактор'
	$LngMsg13='Для изменения требуется перезапуск '&@CRLF&'программы. Перезапустить?'
	$LngMsg14='В библиотеке должен быть хотя бы один образец'
	$LngMsg15='Вы изменяли библиотеку.'&@CRLF&'Продолжить без сохранения?'
	$LngMsg16='Библиотека не исправна, хотите перезаписать её,'&@CRLF&' заменив все данные на тестовый образец?'
	$LngMenu='Меню'
	$LngReP='Перезапуск панели'
	$LngAdd='Добавить образец из буфера'
	$LngSvSt='Сохранить настройки и библиотеку'
	$LngSvPAs='Сохранить библиотеку как...'
	$LngEdLd='Редактировать библиотеку'
	$LngHide='Автоскрытие'
	$LngHTp='Чуствительный край'
	$LngRd1='Сверху экрана'
	$LngRd2='Справа экрана'
	$LngRd3='Слева экрана'
	$LngRd4='Снизу экрана'
	$LngDly='Задержка, мсек :'
	$LngHlp='Справка'
	$LngEdt='Выбор редактора'
	$LngClb='буфер обмена'
	$LngDel='Удалить'
	$LngHnt='Подсказка'
	$LngSvD1='Сохраняем в файл.'
	$LngSvD2='Файл-библиотека'
	$LngErr='Ошибка'
	$LngDrg='Тащи за эту область'
	$LngCnl='Изменить вложенность списка'
	$LngSmp='Библиотека образцов'
	$LngMsH='Панелька для вставки готовых конструкций'&@CRLF&'кода в окно редактора Notepad++ или SciTE.'&@CRLF&'Ctrl+F11 - добавить выделенный текст как образец на панель.'&@CRLF&'Синий прямоугольник предназначен для перетаскивания панели.'&@CRLF&'Клик по аббревиатуре добавляет код в редактор. '&@CRLF&'В контекстном меню пункта можно просмотреть'&@CRLF&'шаблон или удалить пункт.'
EndIf

#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

Global Const $LVS_NOCOLUMNHEADER = 0x4000
Global Const $LVS_SHOWSELALWAYS = 0x0008
Global Const $LVS_OWNERDRAWFIXED = 0x0400
Global Const $LVS_EX_FULLROWSELECT = 0x00000020
Global Const $LVM_FIRST = 0x1000
Global Const $LVM_SETEXTENDEDLISTVIEWSTYLE = ($LVM_FIRST + 54)
Global Const $LVM_SETCOLUMNWIDTH = ($LVM_FIRST + 30)

;#NoTrayIcon
; Opt('TrayMenuMode', 3)
TraySetToolTip ($LngTitle)

Global $kol, $aSet, $aPos, $TrEdLbr=0, $ind, $TrMn=0, $Gui_tr, $hd[5]
Global $Button[1][5], $aPattern, $lniPathID[2][2], $ListView
Global $Ini = @ScriptDir & '\Panel_Function.ini' ; путь к Panel_Function.ini
$Initext='53,255,9,61|Notepad++|AU3_Sample.ini|0|0|0|800|^{F11}'
;Проверка существования Panel_Function.ini
If Not FileExists($Ini) Then
	If MsgBox(4, $LngMsg1, $LngMsg2 & @CRLF & $LngMsg3) = 6 Then
		$file = FileOpen($Ini, 2)
		FileWrite($file, $Initext)
		FileClose($file)
	Else
		Exit
	EndIf
EndIf

$file = FileOpen($ini, 0) ; читаем настройки Panel_Function.ini
$setinitext = FileRead($file)
FileClose($file)
$aSet = StringSplit($setinitext, '|')
If $aSet[0]<8 Then $aSet = StringSplit($Initext, '|')

HotKeySet($aSet[8], "_HK")

If Not FileExists(@ScriptDir & '\' & $aSet[3]) Then ; проверяем наличие профильного ini-файла кнопок
	If MsgBox(4, $LngMsg1, $LngMsg4 & @CRLF & $LngMsg3) = 6 Then
		If FileExists(@ScriptDir & '\AU3_Sample.ini') Or FileExists(@ScriptDir & '\BAT_Sample.ini') Then
			If MsgBox(4, $LngMsg5, $LngMsg6 & @CRLF & $LngMsg7) = "6" Then
				_createfile()
			Else
				Exit
			EndIf
		Else
			_createfile()
		EndIf
	Else
		Exit
	EndIf
EndIf

; Global Const $GUI_WS_EX_PARENTDRAG = 0x00100000
GUIRegisterMsg(0x0084, 'WM_NCHITTEST') ; перетаскивание за панель
GUIRegisterMsg (0x011F, "WM_MENUSELECT") ; всплывающая подсказка при наведении в конт меню
GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO") ; ограничение уменьшения размера окна
GUIRegisterMsg(0x0214 , "WM_SIZING") ; синхронизация ширины колонки
GUIRegisterMsg(0x004E, "WM_NOTIFY")

$DWidth=@DesktopWidth
$DHeight=@DesktopHeight

If $aSet[6]<>0 Then
	_SetHide($DWidth, $DHeight, 1)
	$Gui_tr = GUICreate('', $hd[2], $hd[3], $hd[0], $hd[1], $WS_POPUP, $WS_EX_TOOLWINDOW + $WS_EX_TOPMOST + $WS_EX_LAYERED)
	_WinAPI_SetLayeredWindowAttributes($Gui_tr, 0x0, 1)
	GUISetState()
EndIf

$aPos = StringSplit($aSet[1], ',')
If $aPos[3]>$DWidth-40 Then $aPos[3]=0
If $aPos[4]>$DHeight-120 Then $aPos[4]=0
$Gui = GUICreate($LngTitle, $aPos[1], $aPos[2], $aPos[3], $aPos[4], BitOR($WS_POPUP, $WS_THICKFRAME, $WS_SIZEBOX, $WS_SYSMENU), $WS_EX_TOOLWINDOW+$WS_EX_LAYERED)
_WinAPI_SetLayeredWindowAttributes($Gui, 0x0, 255, 0x02, True)
$Exit=GUICtrlCreateButton('X', 0, $aPos[2]-41, 17, 17)
; GUICtrlSetColor(-1,0xffffff)
; GUICtrlSetBkColor(-1, 0xff0000)
; GUICtrlSetResizing(-1,  2 + 64 + 256 + 512)
; $minim=GUICtrlCreateButton('-', 18, $aPos[2]-41, 17, 17)
; GUICtrlSetResizing(-1,  2 + 64 + 256 + 512)
; $restart=GUICtrlCreateButton('R', 36, $aPos[2]-41, 17, 17)
; GUICtrlSetResizing(-1,  2 + 64 + 256 + 512)
; GUICtrlSetTip(-1, $LngReP)
GUICtrlCreateLabel('', 18, $aPos[2]-41, $aPos[1]-20, 17, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetResizing(-1,  2 + 4 + 64 + 512)
GUICtrlSetBkColor(-1, 0xABCDEF)
GUICtrlSetTip(-1, $LngDrg)

$menuGnr = GUICtrlCreateMenu($LngMenu)


If $aSet[5]=0 Then
	$menuLbr = GUICtrlCreateMenu($LngSmp, $menuGnr)
	$menuTmp=$menuLbr
	$ChngM = GUICtrlCreateMenuItem($LngCnl, $menuTmp)
Else
	$menuTmp=$menuGnr
	$ChngM = GUICtrlCreateMenuItem($LngCnl, $menuTmp)
	GUICtrlCreateMenuItem('', $menuGnr)
EndIf


$SelEdt = GUICtrlCreateMenuItem($LngEdt, $menuGnr)
$AddSmp = GUICtrlCreateMenuItem($LngAdd, $menuGnr)
$Saveini = GUICtrlCreateMenuItem($LngSvSt, $menuGnr)
$SaveLbr = GUICtrlCreateMenuItem($LngSvPAs, $menuGnr)
$EditLdr = GUICtrlCreateMenuItem($LngEdLd, $menuGnr)
$Topmost =GUICtrlCreateMenuitem($LngTop, $menuGnr)
$HideM =GUICtrlCreateMenuitem($LngHide, $menuGnr)
$help = GUICtrlCreateMenuItem($LngHlp, $menuGnr)
$About = GUICtrlCreateMenuItem($LngAbout, $menuGnr)
GUICtrlCreateMenuItem('', $menuGnr)
; $Quit1 = GUICtrlCreateMenuItem("Выход", $menuGnr)
$restart = GUICtrlCreateMenuItem($LngReP, $menuGnr)
If $aSet[6]<>0 Then GUICtrlSetState($HideM, $GUI_CHECKED)

$search = FileFindFirstFile(@ScriptDir & "\*_Sample.ini") ; поиск профильных ini с добавлением в меню ini
If $search <> -1 Then
	$vk=0
	$ind=0
	While 1
		$file = FileFindNextFile($search)
		If @error Then ExitLoop
		ReDim $lniPathID[$vk+1][2]
		$lniPathID[$vk][1]=$file
		$lniPathID[$vk][0]=GUICtrlCreateMenuItem(StringTrimRight($file, 11), $menuTmp, $vk, 1)
		If $file=$aSet[3] Then
			GUICtrlSetState($lniPathID[$vk][0],$GUI_CHECKED)
			$ind=$vk
		EndIf
		$vk+=1
	WEnd
EndIf
$vk-=1
FileClose($search)

_Create_LV_Item($ind)

GUISetState(@SW_SHOW, $Gui)
If $aSet[6]<>0 Then
	Sleep(200)	
	For $i = 245 to 1 Step -14
		_WinAPI_SetLayeredWindowAttributes($Gui, 0x0, $i, 0x02, True)
		Sleep(10)
	Next
	GUISetState(@SW_HIDE, $Gui)
EndIf


If $aSet[4]=1 Then
	WinSetOnTop($GUI, '', 1)
	GUICtrlSetState($Topmost, 1)
EndIf

While 1
	$msg = GUIGetMsg()
	If $msg = 0 Then
		Sleep(20)
		ContinueLoop
	EndIf
	
	For $i = 0 To $kol
		If $msg = $Button[$i][2] Then
			_Del_Item($i)
			ContinueLoop 2
		EndIf
		If $msg = $Button[$i][0] Then
			_Insert($i)
			ContinueLoop 2
		EndIf
	Next
	For $i = 0 To $vk
		If $msg = $lniPathID[$i][0] Then
			GUIRegisterMsg(0x004E, "")
			_Create_LV_Item($i)
			GUIRegisterMsg(0x004E, "WM_NOTIFY")
			ContinueLoop 2
		EndIf
	Next
	
	Switch $msg
       Case $SelEdt
			_SelEdit()
       Case $ChngM
			If $aSet[5] = 0 Then
				$aSet[5] = 1
			Else
				$aSet[5] = 0
			EndIf
			If MsgBox(4, $LngMsg9, $LngMsg13) = 6 Then _restart()
       Case $Topmost
			If $aSet[4] = 0 Then
				WinSetOnTop($GUI, '', 1)
				GUICtrlSetState($Topmost, 1)
				$aSet[4] = 1
			Else
				WinSetOnTop($GUI, '', 0)
				GUICtrlSetState($Topmost, 4)
				$aSet[4] = 0
			EndIf
       Case $HideM
			If $aSet[6]=0 Then
				_Hide()
			Else
				$aSet[6] = 0
			EndIf
			_restart()
		Case $help
			MsgBox(0, $LngHlp, $LngMsH)
		
		Case $SaveLbr
			$savefile = FileSaveDialog($LngSvD1, @ScriptDir, $LngSvD2&" (*_Sample.ini)", 2, "AU4")
			If @error Then ContinueLoop
			If StringRight($savefile, 11)<>'_Sample.ini' Then $savefile&='_Sample.ini'
			$initext=_ConvArInTx()
			$file = FileOpen($savefile, 2)
			If $file = -1 Then
				MsgBox(0, $LngErr, $LngMsg8)
			    ContinueLoop
			EndIf
			FileWrite($file, $initext)
			FileClose($file)
			$TrEdLbr=0
			
		Case $Saveini
			_Saveini()
		Case $EditLdr
			ShellExecute('"'&@ScriptDir & '\' & $lniPathID[$ind][1]&'"')
       Case $AddSmp
           _Add_Smp(0)
       Case $restart
           _restart()
       Case $About
           _About()
       ; Case $minim
           ; GUISetState(@SW_MINIMIZE)
		Case $Exit
			If $TrEdLbr=1 And MsgBox(4+8192, $LngMsg9, $LngMsg15)=7 Then ContinueLoop
			_SavePos()
		   Exit
	EndSwitch
WEnd

Func _Hide()
	Local $DelayInput, $Gui1, $i, $msg, $ok, $Radio0
	GUISetState(@SW_DISABLE, $Gui)
    $Gui1 = GUICreate($LngHTp, 180, 160, -1, -1, -1, $WS_EX_TOOLWINDOW,$Gui)
	GUICtrlCreateGroup('', 6, 3, 168, 128)
	Local $Radio[3]
	$Radio[1] = GUICtrlCreateRadio($LngRd3, 15, 20, 140, 17)
	GUICtrlSetState(-1, 1)
	$Radio[2] = GUICtrlCreateRadio($LngRd2, 15, 40, 140, 17)
	GUICtrlCreateLabel($LngDly, 15, 103, 90, 17)
	$DelayInput = GUICtrlCreateInput($aSet[7], 106, 101, 45, 20)
	$ok = GUICtrlCreateButton('OK', 60, 135, 60, 20)
	GUISetState(@SW_SHOW, $Gui1)
	While 1
		$msg = GUIGetMsg()
		Switch $msg
			Case -3, $ok
				$aSet[7] = GUICtrlRead($DelayInput)
				If $aSet[7]<400 Then $aSet[7]=400
				For $i = 1 to 2
					$Radio0 = GUICtrlRead($Radio[$i])
					If $Radio0 = 1 Then
						$aSet[6] = $i
						ExitLoop
					EndIf
				Next
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($Gui1)
				ExitLoop
		EndSwitch
    WEnd
EndFunc

Func WM_NCHITTEST($hWnd, $Msg, $wParam, $lParam)
	Local $MP = MouseGetPos()
	If $MP[0]<>$hd[0] Then Return
	
	Local $yClient = BitShift($lParam, 16)
	
	If $yClient Then
		If $hWnd = $Gui_tr Then
			If Not BitAnd(WinGetState($Gui), 2) Then 
			
				GUISetState(@SW_SHOW, $Gui)
				For $i = 15 to 235 Step 20
					_WinAPI_SetLayeredWindowAttributes($Gui, 0x0, $i, 0x02, True)
					Sleep(10)
				Next
			EndIf
			_WinAPI_SetLayeredWindowAttributes($Gui, 0x0, 255, 0x02, True)
			If $aSet[4]<>1 Then
				WinSetOnTop($GUI, '', 1)
				WinSetOnTop($GUI, '', 0)
			EndIf

			AdlibRegister('_DelayGui', $aSet[7])
			WinMove($Gui_tr, '', $hd[0]+$hd[4], Default)
		ElseIf $hWnd = $Gui Then
			Local $iProc = DllCall('user32.dll', 'int', 'DefWindowProc', 'hwnd', $hWnd, 'int', $Msg, 'wparam', $wParam, 'lparam', $lParam)
			If $iProc[0] = $HTCLIENT Then Return $HTCAPTION
		EndIf
	EndIf
EndFunc


Func _DelayGui()
	Local $MP = MouseGetPos()
	If $MP[0] = $hd[0] Then Return

	Local $WinPos = WinGetPos($Gui)
	If $MP[0] >= $WinPos[0] And $MP[0] <= $WinPos[0] + $WinPos[2] And $MP[1] >= $WinPos[1] And $MP[1] <= $WinPos[1] + $WinPos[3] Then Return
	
	If $TrMn Then Return
	
    AdlibUnRegister('_DelayGui')
	For $i = 245 to 1 Step -14
		_WinAPI_SetLayeredWindowAttributes($Gui, 0x0, $i, 0x02, True)
		Sleep(10)
	Next
	GUISetState(@SW_HIDE, $Gui)
	WinMove($Gui_tr, '', $hd[0], Default)
EndFunc

Func WM_MENUSELECT($hWnd, $Msg, $wParam, $lParam)
$TrMn = BitShift($lParam, 16)
$w = BitAND($wParam, 0x0000FFFF)
	For $i = 0 To $kol
		If $w=$Button[$i][3] Then
			ToolTip($Button[$i][1])
			ExitLoop
		Else
			ToolTip('')
		EndIf
	Next
EndFunc

Func _SetHide($xD, $yD, $Start=0)
	Switch $aSet[6]
		Case 1
		   $hd[0]=0
		   $hd[1]=0
		   $hd[2]=1
		   $hd[3]=$yD
		   $hd[4]=-2
		Case 2
		   $hd[0]=$xD-1
		   $hd[1]=0
		   $hd[2]=1
		   $hd[3]=$yD
		   $hd[4]=2
		Case Else
		   MsgBox(0, 'Message', $LngErr&' > ini > '&$LngHide)
		   Exit
	EndSwitch
	; If $Start = 0 Then WinMove($Gui_tr, '', $hd[0], $hd[1], $hd[2], $hd[3])
EndFunc

; #include <WINAPI.au3>
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

Func _SavePos()
	$GP = WinGetPos($Gui)
	If $GP[0] < 0 Then $GP[0]=0
	If $GP[1]< 0 Then $GP[1]=0
	$setinitext = $GP[2]-6 & ',' & $GP[3]-6 & ',' & $GP[0] & ',' & $GP[1] & '|' & $aSet[2] & '|' & $lniPathID[$ind][1] & '|' & $aSet[4] & '|' & $aSet[5] & '|' & $aSet[6] & '|' & $aSet[7] & '|' & $aSet[8]
	$file = FileOpen($Ini, 2)
	FileWrite($file, $setinitext)
	FileClose($file)
EndFunc


Func _Saveini()
	$GP = WinGetPos($Gui)
	$setinitext = $GP[2] & ',' & $GP[3] & ',' & $GP[0] & ',' & $GP[1] & '|' & $aSet[2] & '|' & $lniPathID[$ind][1] & '|' & $aSet[4] & '|' & $aSet[5] & '|' & $aSet[6] & '|' & $aSet[7] & '|' & $aSet[8]
	$file = FileOpen($Ini, 2)
	FileWrite($file, $setinitext)
	FileClose($file)
	Local $initext=_ConvArInTx()
	$file = FileOpen(@ScriptDir&'\'&$lniPathID[$ind][1], 2)
	FileWrite($file, $initext)
	FileClose($file)
	$TrEdLbr=0
EndFunc

Func _ConvArInTx()
	Local $initext='[z--z]'
	For $i = 0 To $kol
		$initext &= @CRLF & $Button[$i][4] & '<¤>' & $Button[$i][1] & @CRLF & '[z--z]'
	Next
	Return $initext
EndFunc

Func _Insert($d)
	If $aSet[2] = 'Clipboard' Then Return ClipPut($Button[$d][1])
	$NP = '[CLASS:' & $aSet[2] & ']' ; здесь можно указать другой редактор, или в ini
	If WinExists($NP) Then
		WinActivate($NP)
		If Not WinWaitActive($NP, '', 5) Then Return
		Local $byfertmp=ClipGet()
		ClipPut($Button[$d][1])
		Send("+{ins}")
		ClipPut($byfertmp)
	Else
		MsgBox(0, $LngErr, $LngMsg12&' - '&$NP)
	EndIf
EndFunc


Func _Del_Item($d)
	If $kol < 1 Then
		MsgBox(0, $LngMsg9, $LngMsg14)
		Return
	EndIf
; удаление итема
	GUICtrlDelete($Button[$d][0])
	GUICtrlDelete($Button[$d][2])
	GUICtrlDelete($Button[$d][3])
	$kol-=1
	For $i = $d To $kol
		For $j = 0 to 4
			$Button[$i][$j]=$Button[$i+1][$j]
		Next
	Next
	ReDim $Button[$kol+1][5]
	$TrEdLbr=1
EndFunc

Func _HK()
	_Add_Smp(1)
EndFunc

Func _Add_Smp($HK = 1)
	If $HK = 1 Then _SendEx("^{ins}")
	$newButtom = ClipGet()
	If $newButtom = '' Then Return
	$nameButt = StringRegExpReplace($newButtom, "(?sx).*?(\w{3}).*", '\1')
	If StringLen($nameButt)> 3 Then $nameButt= StringMid($nameButt, 1, 3)
	$GP = WinGetPos($Gui)
	$varnew = InputBox($LngMsg9, $LngMsg10, $nameButt, "", 170, 150, $GP[0]+$GP[2], $GP[1] )
	If $varnew = '' Then Return

	$kol += 1
	ReDim $Button[$kol+1][5]
	$Button[$kol][0]=GUICtrlCreateListViewItem($varnew,$ListView)
	$Button[$kol][1]= $newButtom
	$ContMenu = GUICtrlCreateContextMenu($Button[$kol][0])
	$Button[$kol][3]= GUICtrlCreateMenuitem($LngHnt, $ContMenu)
	$Button[$kol][2]= GUICtrlCreateMenuitem($LngDel&" - "&$varnew,$ContMenu)
	$Button[$kol][4]= $varnew
	$TrEdLbr=1
EndFunc

Func _SendEx($sSend_Data)
    Local $hUser32DllOpen = DllOpen("User32.dll")
    While _IsPressed("10", $hUser32DllOpen) Or _IsPressed("11", $hUser32DllOpen) Or _IsPressed("12", $hUser32DllOpen)
        Sleep(10)
    WEnd
    Send($sSend_Data)
    DllClose($hUser32DllOpen)
EndFunc

; UDF Misc.au3
Func _IsPressed($sHexKey, $vDLL = 'user32.dll')
	Local $a_R = DllCall($vDLL, "short", "GetAsyncKeyState", "int", '0x' & $sHexKey)
	If @error Then Return SetError(@error, @extended, False)
	Return BitAND($a_R[0], 0x8000) <> 0
EndFunc

Func _Create_LV_Item($z)
	If $TrEdLbr=1 And MsgBox(4+8192, $LngMsg9, $LngMsg15)=7 Then
		For $i = 0 To $vk
			GUICtrlSetState($lniPathID[$i][0],$GUI_UNCHECKED)
		Next
		GUICtrlSetState($lniPathID[$ind][0],$GUI_CHECKED)
		Return
	EndIf
	$TrEdLbr=0
	GUICtrlDelete($ListView)
	$GP = WinGetPos($Gui)
	$ListView=GUICtrlCreateListView('-', 2, 0, $GP[2]-10, $GP[3]-51, $LVS_NOCOLUMNHEADER+$LVS_SHOWSELALWAYS, $LVS_OWNERDRAWFIXED)
	GUICtrlSetResizing(-1, 2 + 4 + 32 + 64 + 512)
	GUICtrlSendMsg(-1, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_FULLROWSELECT, $LVS_EX_FULLROWSELECT)
	GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, $GP[2]-15)
	
	$file = FileOpen(@ScriptDir&'\'&$lniPathID[$z][1], 0) ; чтение первого найденного профиля или указанного в ini
	Local $initext = FileRead($file)
	FileClose($file)

	$aPattern = StringRegExp($initext, '(?s)z\]\r\n(.*?)(?=\r\n\[z)', 3)
	If @error Then
		If MsgBox(16+4+8192, $LngErr, $LngMsg16)=7 Then
			Return
		Else
			_CreateLbr($z)
			Return
		EndIf
	EndIf
	$kol = UBound($aPattern) - 1

	ReDim $Button[$kol+1][5]
	For $i = 0 To $kol
		$tmp = StringSplit($aPattern[$i], '<¤>', 1)
		If @error Then
			MsgBox(0, $LngMsg9, $LngMsg11&' '&$i)
			Exit
		EndIf
		$Button[$i][0]=GUICtrlCreateListViewItem($tmp[1],$ListView)
		$Button[$i][1]= $tmp[2]
		$ContMenu = GUICtrlCreateContextMenu($Button[$i][0])
		$Button[$i][3]= GUICtrlCreateMenuitem($LngHnt,$ContMenu)
		$Button[$i][2]= GUICtrlCreateMenuitem($LngDel&" - "&$tmp[1],$ContMenu)
		$Button[$i][4]= $tmp[1]
	Next
	$ind=$z
; 0 ID ListView
; 1 код-шаблон
; 2 ID конт меню Удалить
; 3 ID конт меню Подсказка
; 4 Имя пункта
EndFunc

Func _CreateLbr($z)
$file = FileOpen(@ScriptDir&'\'&$lniPathID[$z][1],2)
FileWrite($file, _
'[z--z]' & @CRLF & _
'Smp<¤>' & @CRLF & _
'Hello' & @CRLF & _
'[z--z]')
FileClose($file)
_Create_LV_Item($z)
EndFunc


Func _SelEdit()
	Local $Gui1, $i, $k, $msg, $ok, $ProcessPath, $window, $GuiHnl

	$GuiHnl=WinGetHandle($Gui)
	$window = WinList()
	Local $winClass[$window[0][0]+1][3]
	$k=0
	For $i = 1 to $window[0][0]
		If $window[$i][0] <> '' And BitAnd( WinGetState($window[$i][1]), 2) And BitAND(WinGetState($window[$i][1]), 4) And $window[$i][1]<>$GuiHnl Then
			$ProcessPath=_ProcessGetPath(WinGetProcess($window[$i][0]))
			If StringRight($ProcessPath, 13)<>'\explorer.exe' And $window[$i][0] <> "Program Manager" Then
				$k+=1
				$winClass[$k][0]=$ProcessPath
				$winClass[$k][1]= _WinAPI_GetClassName($window[$i][1])
				$winClass[$k][2]=StringRegExpReplace($window[$i][0], '(\w:\\)(.*)\.(.*?[ ])', '')
			EndIf
		EndIf
	Next
	If $k = 0 Then Return
	ReDim $winClass[$k+1][3]

	GUISetState(@SW_DISABLE, $Gui)
    $Gui1 = GUICreate($LngEdt&' ('&$aSet[2]&')', 500, $k*20+76, -1, -1, -1, $WS_EX_TOOLWINDOW,$Gui)
	GUICtrlCreateGroup('', 6, 3, 488, $k*20+36)
	Local $Radio[$k+1]
	$Radio[0] = GUICtrlCreateRadio($LngClb, 15, 15, 470, 17)
	$winClass[0][1]='Clipboard'
	If $aSet[2] == $winClass[0][1] Then
		GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetBkColor(-1, 0xbbbbbb)
	EndIf
	
	For $i = 1 to $k
		$Radio[$i] = GUICtrlCreateRadio($winClass[$i][2]&' ('&StringRegExpReplace($winClass[$i][0], '(^.*)\\(.*)$', '\2')&')', 15, $i*20+15, 470, 19)
		GUICtrlSetTip(-1, $winClass[$i][1]&@CRLF&$winClass[$i][0])
		If $aSet[2] == $winClass[$i][1] Then
			GUICtrlSetState(-1, $GUI_CHECKED)
			GUICtrlSetBkColor(-1, 0xbbbbbb)
		EndIf
	Next

	$ok = GUICtrlCreateButton('OK', 215, $k*20+45, 75, 26)
	GUISetState(@SW_SHOW, $Gui1)
	
	While 1
		$msg = GUIGetMsg()
		Switch $msg
			Case $ok
				For $i = 0 to $k
					If GUICtrlRead($Radio[$i]) = 1 Then
						$aSet[2] = $winClass[$i][1]
						ExitLoop
					EndIf
				Next
				ContinueCase
			Case -3
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($Gui1)
				ExitLoop
		EndSwitch
    WEnd
EndFunc

;извлечь путь процесса зная PID
Func _ProcessGetPath($PID)
	Local $dll, $handle1, $Path, $ret
    If IsString($PID) Then $PID = ProcessExists($PID)
    $Path = DllStructCreate('char[1000]')
    $dll = DllOpen('Kernel32.dll')
    $handle1 = DllCall($dll, 'int', 'OpenProcess', 'dword', 0x0400 + 0x0010, 'int', 0, 'dword', $PID)
    $ret = DllCall('Psapi.dll', 'long', 'GetModuleFileNameEx', 'long', $handle1[0], 'int', 0, 'ptr', DllStructGetPtr($Path), 'long', DllStructGetSize($Path))
    $ret = DllCall($dll, 'int', 'CloseHandle', 'hwnd', $handle1[0])
    DllClose($dll)
    Return DllStructGetData($Path, 1)
EndFunc  ;==>_ProcessGetPath


Func _WinAPI_GetClassName($hWnd)
	If Not IsHWnd($hWnd) Then $hWnd = GUICtrlGetHandle($hWnd)
	Local $aResult = DllCall("user32.dll", "int", "GetClassNameW", "hwnd", $hWnd, "wstr", "", "int", 4096)
	If @error Then Return SetError(@error, @extended, False)
	Return SetExtended($aResult[0], $aResult[2])
EndFunc

; координаты клиенской части окна
; Func WM_MOVE($hWnd, $Msg, $wParam, $lParam)
	; $aPos[3] = BitAND($lParam, 0x0000FFFF)
	; $aPos[4] = BitShift($lParam, 16)
; EndFunc

Func WM_SIZING($hWnd, $iMsg, $wparam, $lparam)
	; получаем координаты сторон окна
	Local $sRect = DllStructCreate("Int[4]", $lparam), _
	$Right = DllStructGetData($sRect, 1, 3), _
	$bottom = DllStructGetData($sRect, 1, 4)
	$aPos[1] = DllStructGetData($sRect, 1, 1)
	$aPos[2] = DllStructGetData($sRect, 1, 2)
	$aPos[3] = $Right-$aPos[1]
	$aPos[4] = $bottom-$aPos[2]

	GUICtrlSendMsg($ListView, $LVM_SETCOLUMNWIDTH, 0, $aPos[3]-11)
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
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 59) ; минимальные размеры окна
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 140)
	EndIf
EndFunc

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView, $tInfo, $hListView=$ListView, $iItemOld
	Local Const $tagNMHDR = "hwnd hWndFrom;uint_ptr IDFrom;INT Code"
	Local Const $tagPOINT = "long X;long Y"
	Local Const $tagNMITEMACTIVATE = $tagNMHDR & ";int Index;int SubItem;uint NewState;uint OldState;uint Changed;" & $tagPOINT & ";lparam lParam;uint KeyFlags"
	AdlibRegister('_DelayTTip', 400)

    If Not IsHWnd($hListView) Then $hListView = GUICtrlGetHandle($hListView)
    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, 'hWndFrom'))
    ; $iIDFrom = DllStructGetData($tNMHDR, 'IDFrom')
    $iCode = DllStructGetData($tNMHDR, 'Code')

    Switch $hWndFrom
        Case $hListView
            Switch $iCode
                Case -121
                    $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
                    $iItem = DllStructGetData($tInfo, 'Index')
                    If $iItem <> -1 Then
						ToolTip($Button[$iItem][1])
                    Else
                        ToolTip('')
						AdlibUnRegister('_DelayTTip')
                    EndIf
                Case Else
                    ToolTip('')
					AdlibUnRegister('_DelayTTip')
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

Func _DelayTTip()
	Local $MP = MouseGetPos()
	Local $WinPos = WinGetPos($Gui)
	If $MP[0] >= $WinPos[0] And $MP[0] <= $WinPos[0] + $WinPos[2] And $MP[1] >= $WinPos[1] And $MP[1] <= $WinPos[1] + $WinPos[3] Then Return
	
	AdlibUnRegister('_DelayTTip')
	ToolTip('')
EndFunc

Func _createfile()
$Ln1='Good Morning'
$Ln2='Good Afternoon'
$Ln3='Good Evening'
$Ln4='What are you still doing up?'
$Ln5='If'
$Ln6='Then'
$Ln7='Otherwise'
$Ln8='Title'
$Ln9='Message'
$Ln10='if the condition is true, then do not repeat the cycle'
$Ln11='Block comments'
$Ln12='path\filename'
$Ln13='path\folder" "new_path\new_folder'
$Ln14='This text should be in DOS - encoded'
$Ln15='Russian text should be in a dos - encoded'
$Ln16='Press the number of your choice on your keyboard'
$Ln17='Action first start'
$Ln18='Action second start Notepad'
$Ln19='Action third start Calculator'
$Ln20='Enter a number and press'

If $UserIntLang = 0419 Then
$Ln1='Доброе утро'
$Ln2='Доброго дня'
$Ln3='Добрый вечер'
$Ln4='Доброй ночи'
$Ln5='Если'
$Ln6='тогда'
$Ln7='Иначе'
$Ln8='Заголовок'
$Ln9='Сообщение'
$Ln10='если условие верно, то не повторять цикл'
$Ln11='Блок комментариев'
$Ln12='путь\имя_файла'
$Ln13='путь\папка" "новый_путь\новая_папка'
$Ln14='этот текст должен быть в дос-кодировке'
$Ln15='русский текст должен быть в дос-кодировке'
$Ln16='Нажмите номер вашего выбора на клавиатуре'
$Ln17='действие первое старт'
$Ln18='действие второе старт Блокнот'
$Ln19='действие третье старт Калькулятора'
$Ln20='Введите число и жмите'
EndIf

$file = FileOpen(@ScriptDir & '\AU3_Sample.ini', 2)
FileWrite($file, _
'[z--z]' & @CRLF & _
'GUI<¤>' & @CRLF & _
'GUICreate(''My Program'', 250, 260)' & @CRLF & _
'$Button1=GUICtrlCreateButton(''Start'', 10, 10, 120, 22)' & @CRLF & _
'$Label1=GUICtrlCreateLabel(''StatusBar'', 5, 260-20, 150, 17)' & @CRLF & _
'GUISetState ()' & @CRLF & _
'While 1' & @CRLF & _
'	$msg = GUIGetMsg()' & @CRLF & _
'	Switch $msg' & @CRLF & _
'		Case $Button1' & @CRLF & _
'			GUICtrlSetData($Label1,''Done'')' & @CRLF & _
'		Case -3' & @CRLF & _
'			 Exit' & @CRLF & _
'	EndSwitch' & @CRLF & _
'WEnd' & @CRLF & _
'[z--z]' & @CRLF & _
'FW<¤>' & @CRLF & _
'$file = FileOpen(@ScriptDir&''\file.txt'',2)' & @CRLF & _
'FileWrite($file, $text)' & @CRLF & _
'FileClose($file)' & @CRLF & _
'Exit' & @CRLF & _
'[z--z]' & @CRLF & _
'FR<¤>' & @CRLF & _
'$file = FileOpen(@ScriptDir&''\file.txt'', 0)' & @CRLF & _
'$text = FileRead($file)' & @CRLF & _
'FileClose($file)' & @CRLF & _
'[z--z]' & @CRLF & _
'If<¤>' & @CRLF & _
'If $var = 0 Then' & @CRLF & _
'	' & @CRLF & _
'Else' & @CRLF & _
'	' & @CRLF & _
'EndIf' & @CRLF & _
'[z--z]' & @CRLF & _
'Sw<¤>' & @CRLF & _
'Switch @HOUR' & @CRLF & _
'	Case 6 To 11' & @CRLF & _
'		$msg = "'&$Ln1&'"' & @CRLF & _
'	Case 12 To 17' & @CRLF & _
'		$msg = "'&$Ln2&'"' & @CRLF & _
'	Case 18 To 21' & @CRLF & _
'		$msg = "'&$Ln3&'"' & @CRLF & _
'	Case Else' & @CRLF & _
'		$msg = "'&$Ln4&'"' & @CRLF & _
'EndSwitch' & @CRLF & _
'[z--z]' & @CRLF & _
'Wh<¤>' & @CRLF & _
'While 1' & @CRLF & _
'	$msg = GUIGetMsg()' & @CRLF & _
'	Switch $msg' & @CRLF & _
'		Case -3' & @CRLF & _
'			Exit' & @CRLF & _
'	EndSwitch' & @CRLF & _
'WEnd' & @CRLF & _
'[z--z]' & @CRLF & _
'Se<¤>' & @CRLF & _
'Select' & @CRLF & _
'	Case $var = 1' & @CRLF & _
'		MsgBox(0, "", "'&$Ln5&' 1 '&$Ln6&'")' & @CRLF & _
'	Case $var2 = "test"' & @CRLF & _
'		MsgBox(0, "", "'&$Ln5&' test '&$Ln6&'")' & @CRLF & _
'	Case Else' & @CRLF & _
'		MsgBox(0, "", "'&$Ln7&'")' & @CRLF & _
'EndSelect' & @CRLF & _
'[z--z]' & @CRLF & _
'DU<¤>' & @CRLF & _
'Do' & @CRLF & _
'	MsgBox(0, "'&$Ln8&'", '''&$Ln9&''')' & @CRLF & _
'Until 0 ; '&$Ln10&'' & @CRLF & _
'[z--z]' & @CRLF & _
'cse<¤>' & @CRLF & _
'#cs' & @CRLF & _
$Ln11 & @CRLF & _
'#ce' & @CRLF & _
'[z--z]' & @CRLF & _
'FU<¤>' & @CRLF & _
'Func _FuncName()' & @CRLF & _
'	Return (@MON & "/" & @MDAY & "/" & @YEAR)' & @CRLF & _
'EndFunc' & @CRLF & _
'[z--z]' & @CRLF & _
'A3W<¤>' & @CRLF & _
'#Region ;**** Directives created by AutoIt3Wrapper_GUI ****' & @CRLF & _
'#AutoIt3Wrapper_OutFile=Program.exe' & @CRLF & _
'#AutoIt3Wrapper_icon=Program.ico' & @CRLF & _
'#AutoIt3Wrapper_Compression=4' & @CRLF & _
'#AutoIt3Wrapper_UseAnsi=y' & @CRLF & _
'#AutoIt3Wrapper_Res_Comment=-' & @CRLF & _
'#AutoIt3Wrapper_Res_Description=Program.exe' & @CRLF & _
'#AutoIt3Wrapper_Res_Fileversion=0.1.0.0' & @CRLF & _
'#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n' & @CRLF & _
'#AutoIt3Wrapper_Res_LegalCopyright=Author' & @CRLF & _
'#AutoIt3Wrapper_Res_Language=1033' & @CRLF & _
'#AutoIt3Wrapper_Run_AU3Check=n' & @CRLF & _
'#AutoIt3Wrapper_Run_Obfuscator=y' & @CRLF & _
'#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0' & @CRLF & _
'#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"' & @CRLF & _
'#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****' & @CRLF & _
'[z--z]' & @CRLF & _
'ArD<¤>' & @CRLF & _
'#include <Array.au3>' & @CRLF & _
'_ArrayDisplay($Array, ''Array'')' & @CRLF & _
'[z--z]')
		FileClose($file)

		$file = FileOpen(@ScriptDir & '\BAT_Sample.ini', 2)
		FileWrite($file, _
'[z--z]' & @CRLF & _
'ech<¤>@echo off' & @CRLF & _
'color 3b' & @CRLF & _
'title' & @CRLF & _
'[z--z]' & @CRLF & _
'xFi<¤>' & @CRLF & _
'xcopy "'&$Ln12&'" "%windir%\SYSTEM32\" /Q /H /Y /K /C' & @CRLF & _
'[z--z]' & @CRLF & _
'xFo<¤>' & @CRLF & _
'xcopy "'&$Ln13&'" /Q /H /Y /K /C /E /I' & @CRLF & _
'[z--z]' & @CRLF & _
'n-v<¤>' & @CRLF & _
'%var:~n%' & @CRLF & _
'[z--z]' & @CRLF & _
'IF<¤>' & @CRLF & _
'IF NOT EXIST ELSE' & @CRLF & _
'[z--z]' & @CRLF & _
'-1v<¤>' & @CRLF & _
'SET var=%~dp0' & @CRLF & _
'SET var=%var:~0,-1%' & @CRLF & _
'[z--z]' & @CRLF & _
'CLS<¤>' & @CRLF & _
'CLS' & @CRLF & _
'echo.' & @CRLF & _
'echo.' & @CRLF & _
'echo ================================================' & @CRLF & _
'echo '&$Ln14&' 866' & @CRLF & _
'echo ================================================' & @CRLF & _
'echo.' & @CRLF & _
'pause' & @CRLF & _
'[z--z]' & @CRLF & _
'MNU<¤>@echo off' & @CRLF & _
'color 3b' & @CRLF & _
'title MENU' & @CRLF & _
@CRLF & _
':: '&$Ln15&' 866' & @CRLF & _
':MENU' & @CRLF & _
'CLS' & @CRLF & _
'ECHO '&$Ln16&' (1,2,3)' & @CRLF & _
'echo.' & @CRLF & _
'ECHO 1 - '&$Ln17&' Paint' & @CRLF & _
'ECHO 2 - '&$Ln18& @CRLF & _
'ECHO 3 - '&$Ln19& @CRLF & _
'echo.' & @CRLF & _
'ECHO __________________________________________' & @CRLF & _
'SET /P Choice='&$Ln20&' Enter:' & @CRLF & _
'IF /I ''%Choice%''==''1'' GOTO 1' & @CRLF & _
'IF /I ''%Choice%''==''2'' GOTO 2' & @CRLF & _
'IF /I ''%Choice%''==''3'' GOTO 3' & @CRLF & _
'GOTO MENU' & @CRLF & _
@CRLF & _
':1' & @CRLF & _
'start mspaint.exe' & @CRLF & _
'GOTO end' & @CRLF & _
@CRLF & _
':2' & @CRLF & _
'start notepad.exe' & @CRLF & _
'GOTO end' & @CRLF & _
@CRLF & _
':3' & @CRLF & _
'start calc.exe' & @CRLF & _
'GOTO end' & @CRLF & _
@CRLF & _
':end' & @CRLF & _
'exit' & @CRLF & _
'[z--z]' & @CRLF & _
'%Pr<¤>%ProgramFiles%' & @CRLF & _
'[z--z]' & @CRLF & _
'%SR<¤>%SystemRoot%' & @CRLF & _
'[z--z]' & @CRLF & _
'%wd<¤>%windir%' & @CRLF & _
'[z--z]' & @CRLF & _
'%TM<¤>%TEMP%' & @CRLF & _
'[z--z]' & @CRLF & _
'%SD<¤>%SystemDrive%' & @CRLF & _
'[z--z]' & @CRLF & _
'%CP<¤>%COMMONPROGRAMFILES%' & @CRLF & _
'[z--z]' & @CRLF & _
'%AU<¤>%AllUsersProfile%' & @CRLF & _
'[z--z]' & @CRLF & _
'%UP<¤>%UserProfile%' & @CRLF & _
'[z--z]' & @CRLF & _
'%SS<¤>%SystemRoot%\SYSTEM32' & @CRLF & _
'[z--z]')
		FileClose($file)
EndFunc

Func _restart()
	If $TrEdLbr=1 And MsgBox(4+8192, $LngMsg9, $LngMsg15)=7 Then Return
	_SavePos()
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

Func _About()Local $msg, $url, $WbMn
Local $GP = WinGetPos($Gui)
GUISetState(@SW_DISABLE, $Gui)
Local $y=$GP[1]+$GP[3]/2-105
Local $x=$GP[0]+$GP[2]/2-105
If $y < 0 Then $y= 0
If $x < 0 Then $x= 0
If $y > $DHeight-180 Then $y = $DHeight-208
If $x > $DWidth-210 Then $x = $DWidth-216
Local $font="Arial"
    Local $Gui1 = GUICreate($LngAbout, 210, 180, $x, $y, -1, $WS_EX_TOOLWINDOW,$Gui)
	GUISetBkColor (0xffca48)
	GUICtrlCreateLabel($LngTitle, 0, 0, 210, 63, 0x01+0x0200)
	GUICtrlSetFont (-1,14, 600, -1, $font)
	GUICtrlSetColor(-1,0xa13d00)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,64,208,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.4   2.04.2011', 15, 100, 210, 17)
	GUICtrlCreateLabel($LngSite&':', 15, 115, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', 52, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 15, 130, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', 90, 130, 125, 17)
	GUICtrlSetColor(-1,0xa21a10)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010', 15, 145, 210, 17)
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