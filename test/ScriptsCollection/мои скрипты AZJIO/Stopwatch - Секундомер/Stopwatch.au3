#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Stopwatch.exe
#AutoIt3Wrapper_Icon=Stopwatch.ico
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Stopwatch.exe
#AutoIt3Wrapper_Res_Fileversion=0.8.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.8
#AutoIt3Wrapper_Res_Field=Build|2013.02.27
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=CompanyName|AZJIO_Soft
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Res_Icon_Add=icons\1.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\2.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\3.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\4.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\5.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\6.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\7.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\8.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\9.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\10.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\11.ico
#AutoIt3Wrapper_Res_Icon_Add=icons\12.ico
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\upx\upx.exe -7 --compress-icons=0 "%out%"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2010 - 2013.02.27 (AutoIt3_v3.3.6.1)
#NoTrayIcon

#include <GuiButton.au3>
#include <GuiImageList.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListBoxConstants.au3>
#include <ComboConstants.au3>
#include <ScrollBarConstants.au3>
#include <GuiEdit.au3>
#include <ForStopwatch.au3>
#include <Array.au3>

; En
$LngTitle = 'Stopwatch'
$LngStart = 'Start'
$LngSp = 'Stop'
$LngPs = 'Pause'
$LngRe = 'Reset'
$LngMem = 'Memory'
$LngSig = 'Signal'
$LngAbout = 'About'
$LngVer = 'Version'
$LngSite = 'Site'
$LngCopy = 'Copy'
$LngHK = 'HotKey'
$LngHKMsg = 'Start - Enter, UP' & @CRLF & 'Pause - Down, Pause-Break' & @CRLF & 'Reset - Delete, 0, Numpad0' & @CRLF & 'Memory - Space' & @CRLF & 'Signal - Numpad., Alt+.'
$LngSgTx = 'Will Enter time, in which' & @CRLF & 'must sound signal'
$LngTm = 'Hour       |  Minute  |  Seconds'
$LngSpk = '1. Speaker'
$LngMSpk = '2. Tune Speaker'
; $LngCn = 'Cancel'
$LngErr = 'Error'
$LngErrMsg = 'Time must be not installed in 0,' & @CRLF & 'a name of the conservation must be incorporated,' & @CRLF & 'in name must not be a symbol "|"'
$LngErrMsg2 = 'Path not exist.'
$LngErrMsg3 = 'Choose other name of the save'
$LngErrMsg4 = 'Time must be not installed in 0'
$LngSl = "Select File"
$LngType = "Media-File"
$LngNx = 'Next'
$LngCm = '3. Select path'
$LngMP = 'internal device for mp3'
$LngScrollAbt = 'Stopwatch' & @CRLF & @CRLF & _
		'Stopwatch with the ability to make timestamp at a certain event, put a melody on playback after a certain ' & _
		'time interval. Instead of ringing can be any associated file, or the built-in music speaker PC' & @CRLF & _
		'It supports hot keys. ' & @CRLF & _
		'In the minimized state appears on the taskbar. There the ability to save set an alarm. ' & @CRLF & @CRLF & _
		'The utility is written in AutoIt3' & @CRLF & _
		'autoitscript.com'
$LngOpI = 'Open ini'
$LngSav = 'Save'
$LngPly = 'Play'
$LngStp = 'Stop'
$LngDel = 'Delete'
$LngIB1 = 'Name of item'
$LngIB2 = 'Enter the name of the item'

; Ru
; если русская локализация, то русский язык
If @OSLang = 0419 Then
	$LngTitle = 'Секундомер'
	$LngStart = 'Старт'
	$LngSp = 'Стоп'
	$LngPs = 'Пауза'
	$LngRe = 'Сброс'
	$LngMem = 'Память'
	$LngSig = 'Сигнал'
	$LngAbout = 'О программе'
	$LngVer = 'Версия'
	$LngSite = 'Сайт'
	$LngCopy = 'Копировать'
	$LngHK = 'Горячие клавиши'
	$LngHKMsg = 'Старт - Enter, UP' & @CRLF & 'Пауза - Down, Pause-Break' & @CRLF & 'Сброс - Delete, 0, Numpad0' & @CRLF & 'Память - Space' & @CRLF & 'Сигнал - Numpad., Alt+.'
	$LngSgTx = 'Введите время, в которое' & @CRLF & 'должен прозвучать сигнал'
	$LngTm = 'Часы       |  Минуты  |  Секунды'
	$LngSpk = '1. Динамик ПК'
	$LngMSpk = '2. Мелодия динамика ПК'
	; $LngCn = 'Отмена'
	$LngErr = 'Ошибка'
	$LngErrMsg = 'Время не должно быть установлено в 0,' & @CRLF & 'должно быть введено имя сохранения,' & @CRLF & 'в имени не должно быть символа "|"'
	$LngErrMsg2 = 'Путь не существует.'
	$LngErrMsg3 = 'Запись с таким именем уже существует'
	$LngErrMsg4 = 'Время не должно быть установлено в 0'
	$LngSl = "Указать файл"
	$LngType = "Медиа-файл"
	$LngNx = 'Далее'
	$LngCm = '3. Укажите путь'
	$LngMP = 'внутренее устройство для mp3'
	$LngScrollAbt = 'Секундомер' & @CRLF & @CRLF & _
			'Секундомер с возможностью сделать ' & _
			'отметки времени при определённом ' & _
			'событии, поставить мелодию на ' & _
			'воспроизведение через определённый ' & _
			'интервал времени. Вместо мелодии ' & _
			'может быть любой ассоциированный ' & _
			'файл, либо встроенная музыка динамика ' & _
			'ПК.  ' & @CRLF & _
			'Поддерживаются горячие клавиши. ' & @CRLF & _
			'В свёрнутом состоянии отсчёт времени ' & _
			'отображается на панели задач. Есть ' & _
			'возможность сохранять установки сигнала.' & @CRLF & @CRLF & _
			'Утилита написана на AutoIt3' & @CRLF & _
			'autoitscript.com'
	$LngOpI = 'Открыть ini'
	$LngSav = 'Сохранить'
	$LngPly = 'Воспроизвести'
	$LngStp = 'Остановить'
	$LngDel = 'Удалить'
	$LngIB1 = 'Название пункта'
	$LngIB2 = 'Введите название пункта'
EndIf

Global $Active = 1

Global $Pause, $iTime, $i_dPause = 0, $iStart, $TrSignal = 0, $iTimeSig, $nSig0, $combo = $LngCm, $Bold = 700, $TrBtnShow
Global $TrStart = 0, $Tr2 = 0, $Tr3 = 0, $iPID, $sLabel, $trMp = 0
Global $IniText, $aIniText, $ini = @ScriptDir & '\Stopwatch.ini'
If FileExists($ini) Then
	$file = FileOpen($ini, 0)
	$IniText = FileRead($file)
	FileClose($file)
EndIf

; Case 'WIN_2000', 'WIN_XP', 'WIN_2003'
Switch @OSVersion
	Case 'WIN_VISTA', 'WIN_7'
		$Bold = 400
EndSwitch

$Gui = GUICreate($LngTitle, 241, 185)

If @Compiled Then
	$AutoItExe = @AutoItExe
Else
	$AutoItExe = @ScriptDir & '\Stopwatch.dll'
	GUISetIcon($AutoItExe, 99)
EndIf

GUICtrlCreateLabel("", 3, 3, 144, 34, 0x12)

$hLabel1 = GUICtrlCreateLabel(' 00', 5, 5, 35, 30, $SS_LEFTNOWORDWRAP)
_bk()
GUICtrlCreateLabel(':', 40, 5, 10, 30, $SS_CENTER)
_bk()
$hLabel2 = GUICtrlCreateLabel('00', 50, 5, 28, 30, $SS_LEFTNOWORDWRAP)
_bk()
GUICtrlCreateLabel(':', 78, 5, 10, 30, $SS_CENTER)
_bk()
$hLabel3 = GUICtrlCreateLabel('00', 88, 5, 33, 30, $SS_LEFTNOWORDWRAP)
_bk()
GUICtrlCreateLabel('.', 116, 5, 7, 30, $SS_CENTER)
_bk()
$hLabel4 = GUICtrlCreateLabel('0', 123, 5, 22, 30, $SS_LEFTNOWORDWRAP)
_bk()

Global $iMemTime
$iMemTime = GUICtrlCreateEdit("", 5, 45, 140, 115, $WS_VSCROLL + $ES_MULTILINE + $ES_WANTRETURN + $ES_AUTOVSCROLL)
GUICtrlSetBkColor(-1, 0xECE9D8)

$iSgLabel = GUICtrlCreateLabel('', 30, 163, 110, 24)
GUICtrlSetFont(-1, 10, $Bold)
GUICtrlSetColor(-1, 0x3db03a)

Global $aImgLst[13] = [12]
For $i = 1 To $aImgLst[0]
	$aImgLst[$i] = _GUIImageList_Create(16, 16, 5, 1 + 4, 0, 1)
	_GUIImageList_AddIcon($aImgLst[$i], $AutoItExe, -200 - $i)
Next

$Start = GUICtrlCreateButton($LngStart, 161, 5, 70, 25)
GUICtrlSetTip(-1, 'Enter' & @CRLF & 'Up')
_GUICtrlButton_SetImageList(-1, $aImgLst[1], 0)
$Pause0 = GUICtrlCreateButton($LngPs, 161, 35, 70, 25)
GUICtrlSetState(-1, 128)
GUICtrlSetTip(-1, 'Down' & @CRLF & 'Pause')
_GUICtrlButton_SetImageList(-1, $aImgLst[11], 0)
$Reset = GUICtrlCreateButton($LngRe, 161, 65, 70, 25)
GUICtrlSetTip(-1, 'NumPad 0' & @CRLF & 'Del' & @CRLF & '0')
_GUICtrlButton_SetImageList(-1, $aImgLst[3], 0)
$iAddedLabel = GUICtrlCreateButton($LngMem, 161, 95, 70, 25)
GUICtrlSetTip(-1, 'Space')
_GUICtrlButton_SetImageList(-1, $aImgLst[4], 0)
$Signal = GUICtrlCreateButton($LngSig, 161, 125, 70, 25)
GUICtrlSetTip(-1, 'Alt+.' & @CRLF & 'NumPad Del')
_GUICtrlButton_SetImageList(-1, $aImgLst[5], 0)
$About = GUICtrlCreateButton("", 161, 155, 32, 25)
_GUICtrlButton_SetImageList(-1, $aImgLst[6], 4)
$HotKey = GUICtrlCreateButton("", 198, 155, 32, 25)
_GUICtrlButton_SetImageList(-1, $aImgLst[7], 4)
$nStop1 = GUICtrlCreateButton($LngSp, 2, 160, 70, 25)
_GUICtrlButton_SetImageList(-1, $aImgLst[12], 0)
GUICtrlSetState($nStop1, $GUI_HIDE)

$sLabel = ' 00:00:00.0'
$iHour = '00'
$iMin = '00'
$iSec = '00'
$iMsec = '0'

Global $AccelKeys[9][2] = [["{UP}", $Start],["{SPACE}", $iAddedLabel],["{DEL}", $Reset],["0", $Reset],["{NUMPAD0}", $Reset],["{DOWN}", $Pause0],["{PAUSE}", $Pause0],["!{.}", $Signal],["{NUMPADDOT}", $Signal]]

GUISetAccelerators($AccelKeys)

GUISetState()
GUIRegisterMsg($WM_ACTIVATE, "WM_ACTIVATE")

$iHourTmp = ''
$iMinTmp = ''
$iSecTmp = ''
$iMsecTmp = ''
$iTimerDiff_Tmp = -1000

While 1
	If $TrStart Then
		$iTimerDiff = TimerDiff($iStart) - $i_dPause
		If $iTimerDiff - $iTimerDiff_Tmp > 100 Then ; установка только если разница превысит на 1 миллисек. предыдущее установленное время
			$iTime = Int($iTimerDiff / 100) / 10 ; в секундах, например 366.3
			$iHour = Int($iTime / 3600)
			$iMin = Int(($iTime - $iHour * 3600) / 60)
			$iSec = Int($iTime) - $iHour * 3600 - $iMin * 60
			$iMsec = Int(($iTime - Int($iTime)) * 10)
			If $iHour < 10 Then $iHour = '0' & $iHour
			If $iMin < 10 Then $iMin = '0' & $iMin
			If $iSec < 10 Then $iSec = '0' & $iSec
			;If $iMsec < 10 Then $iMsec='0'&$iMsec
			If $iHourTmp <> $iHour Then
				$iHourTmp = $iHour
				GUICtrlSetData($hLabel1, " " & $iHour)
			EndIf
			If $iMinTmp <> $iMin Then
				$iMinTmp = $iMin
				GUICtrlSetData($hLabel2, $iMin)
			EndIf
			If $iSecTmp <> $iSec Then
				$iSecTmp = $iSec
				GUICtrlSetData($hLabel3, $iSec)
				If Not $Active Then WinSetTitle($Gui, '', $iHour & ':' & $iMin & ':' & $iSec)
			EndIf
			If $iMsecTmp <> $iMsec Then
				$iMsecTmp = $iMsec
				GUICtrlSetData($hLabel4, $iMsec)
				$iTimerDiff_Tmp = $iTime * 1000
			EndIf
			;Sleep(20)
		EndIf
	EndIf
	If $TrSignal And $iTimeSig <= $iTime Then ; если сигнал установлен и время сигнала меньше текущего, то
		$TrSignal = 0
		GUICtrlSetData($iSgLabel, '')
		Switch StringLeft($nSig0, 1)
			Case 1
				Beep(500, 1000)
			Case 2
				_melodia()
			Case Else
				;ShellExecute(StringTrimLeft($nSig0, 3))
				If $trMp = 1 And StringInStr(';mp3;wav;wma;', ';' & StringRegExpReplace($nSig0, '.*\.(\S+)', '\1') & ';') Then
					_MP($nSig0)
				Else
					_StartFile($nSig0)
				EndIf
			Case Else
				_melodia()
		EndSwitch
	EndIf

	If $iPID And ProcessExists($iPID) Then
		If Not $TrBtnShow Then
			GUICtrlSetState($nStop1, $GUI_SHOW)
			GUICtrlSetState($iSgLabel, $GUI_HIDE)
			$TrBtnShow = 1
		EndIf
	Else
		If $TrBtnShow Then
			GUICtrlSetState($nStop1, $GUI_HIDE)
			GUICtrlSetState($iSgLabel, $GUI_SHOW)
			$TrBtnShow = 0
			$iPID = 0
		EndIf
	EndIf

	Switch GUIGetMsg()
		Case $HotKey
			MsgBox(0, $LngHK, $LngHKMsg, 0, $Gui)
		Case $nStop1
			If $iPID And ProcessExists($iPID) Then
				ProcessClose($iPID)
				$iPID = 0
			EndIf
		Case $Start
			_Start()
		Case $Pause0
			If $Tr3 = 0 Then ContinueLoop
			If $TrStart Then
				$TrStart = 0
				$Tr2 = 1
				GUICtrlSetData($Pause0, $LngNx)
				GUICtrlSetState($Start, 128)
				_GUICtrlButton_SetImageList($Pause0, $aImgLst[8], 0)
				_GUICtrlButton_SetImageList($Start, $aImgLst[10], 0)
			Else
				$i_dPause = TimerDiff($iStart) - $iTimerDiff
				$TrStart = 1
				$Tr2 = 2
				GUICtrlSetData($Pause0, $LngPs)
				GUICtrlSetState($Start, 64)
				_GUICtrlButton_SetImageList($Pause0, $aImgLst[2], 0)
				_GUICtrlButton_SetImageList($Start, $aImgLst[9], 0)
			EndIf
		Case $iAddedLabel
			GUICtrlSetData($iMemTime, " " & $iHour & " : " & $iMin & " : " & $iSec & "." & $iMsec & @CRLF, 1)
			_GUICtrlEdit_Scroll($iMemTime, $SB_BOTTOM)
		Case $Reset
			_Reset()
		Case $Signal
			_GUI_SetSignal()
		Case $About
			_About()
		Case $GUI_EVENT_CLOSE
			Exit
	EndSwitch
WEnd

Func _GUI_SetSignal()
	$GP = _ChildCoor($Gui, 393, 240)
	GUISetState(@SW_DISABLE, $Gui)
	$Gui1 = GUICreate($LngSig, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	GUISetIcon($AutoItExe, 205)

	$nSection = GUICtrlCreateList("", 10, 10, 180, 180, $WS_VSCROLL + $LBS_NOINTEGRALHEIGHT)
	GUICtrlCreateLabel($LngSgTx, 220, 5, 200, 34)

	GUICtrlCreateLabel($LngTm, 215, 38, 170, 17)
	$nHour = GUICtrlCreateInput("0", 210, 55, 50, 22, $ES_NUMBER)
	GUICtrlCreateUpdown(-1)
	GUICtrlSetLimit(-1, 24, 0)
	$nMin = GUICtrlCreateInput("0", 265, 55, 50, 22, $ES_NUMBER)
	GUICtrlCreateUpdown(-1)
	GUICtrlSetLimit(-1, 60, 0)
	$nSec = GUICtrlCreateInput("0", 320, 55, 50, 22, $ES_NUMBER)
	GUICtrlCreateUpdown(-1)
	GUICtrlSetLimit(-1, 60, 0)

	$nSig = GUICtrlCreateCombo('', 210, 83, 160, 25)
	GUICtrlSetData(-1, $LngSpk & '|' & $LngMSpk & '|' & $combo)
	GUICtrlSendMsg(-1, $CB_SETDROPPEDWIDTH, 400, 0)
	$nPlayStop = GUICtrlCreateButton($LngPly, 210, 113, 100, 25)
	_GUICtrlButton_SetImageList(-1, $aImgLst[5], 0)

	$nMP = GUICtrlCreateCheckbox($LngMP, 210, 142, 180, 17)
	If $trMp = 1 Then GUICtrlSetState(-1, 1)

	$nSave = GUICtrlCreateButton($LngSav, 210, 164, 80, 25)
	$nOpen = GUICtrlCreateButton($LngOpI, 300, 164, 70, 25)
	If Not FileExists($ini) Then GUICtrlSetState($nOpen, $GUI_HIDE)
	$aIni2D = _IniText()

	If $aIni2D[0][0] Then
		For $i = 1 To $aIni2D[0][0]
			GUICtrlSetData($nSection, $aIni2D[$i][0])
			Switch $aIni2D[$i][4]
				Case $LngSpk, $LngMSpk, $combo
				Case Else
					GUICtrlSetData($nSig, $aIni2D[$i][4])
			EndSwitch
		Next
	EndIf
	GUICtrlSetData($nSig, $LngSpk, $LngSpk)

	$nOK = GUICtrlCreateButton("OK", 170, 200, 100, 32)
	$iPID = 0

	$iDummy = GUICtrlCreateDummy()
	$ContMenu = GUICtrlCreateContextMenu($iDummy)
	$hMenu = GUICtrlGetHandle($ContMenu)
	$iCM_Del = GUICtrlCreateMenuItem($LngDel, $ContMenu)

	GUISetState(@SW_SHOW, $Gui1)

	While 1
		If $iPID And ProcessExists($iPID) Then
			If Not $TrBtnShow Then
				GUICtrlSetData($nPlayStop, $LngStp)
				_GUICtrlButton_SetImageList($nPlayStop, $aImgLst[12], 0)
				$TrBtnShow = 1
			EndIf
		Else
			If $TrBtnShow Then
				GUICtrlSetData($nPlayStop, $LngPly)
				_GUICtrlButton_SetImageList($nPlayStop, $aImgLst[5], 0)
				$TrBtnShow = 0
				$iPID = 0
			EndIf
		EndIf
		Switch GUIGetMsg()
			Case $GUI_EVENT_SECONDARYDOWN
				$a = GUIGetCursorInfo()
				If $a[4] = $nSection Then
					$x = MouseGetPos(0)
					$y = MouseGetPos(1)
					DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $Gui1, "ptr", 0)
				EndIf
			Case $iCM_Del
				$sText = GUICtrlRead($nSection)
				$iIndex = GUICtrlSendMsg($nSection, $LB_GETCURSEL, 0, 0)
				If $iIndex <> -1 Then
					GUICtrlSendMsg($nSection, $LB_DELETESTRING, $iIndex, 0)
					IniDelete($ini, $sText)
					$iIndex = _ArraySearch($aIni2D, $sText, 1)
					If $iIndex <> -1 Then _ArrayDelete($aIni2D, $iIndex)
				EndIf
			Case $nSig
				If GUICtrlRead($nSig) = $LngCm Then
					$tmp = FileOpenDialog($LngSl, @WorkingDir, $LngType & " (*.*)", 1 + 4)
					If Not @error Then GUICtrlSetData($nSig, $tmp & "|", $tmp)
				EndIf
			Case $nMP
				If GUICtrlRead($nMP) = 1 Then
					$trMp = 1
				Else
					$trMp = 0
				EndIf
			Case $nOpen
				ShellExecute($ini)

			Case $nPlayStop
				If GUICtrlRead($nPlayStop) = $LngPly Then
					$nSi0 = GUICtrlRead($nSig)
					Switch StringLeft($nSi0, 1)
						Case 1
							Beep(500, 1000)
						Case 2
							_melodia()
						Case Else
							If Not (StringMid($nSi0, 2, 2) = ':\' And FileExists($nSi0)) Then
								MsgBox(0, $LngErr, $LngErrMsg2, 0, $Gui1)
								ContinueLoop
							EndIf
							If GUICtrlRead($nMP) = 1 And StringInStr(';mp3;wav;wma;', ';' & StringRegExpReplace($nSi0, '.*\.(\S+)', '\1') & ';') Then
								_MP($nSi0)
							Else
								_StartFile($nSi0)
							EndIf
					EndSwitch
				Else
					If $iPID And ProcessExists($iPID) Then
						ProcessClose($iPID)
						$iPID = 0
					EndIf
				EndIf

			Case $nSection
				$nSection0 = GUICtrlRead($nSection)
				For $i = 1 To $aIni2D[0][0]
					If $aIni2D[$i][0] = $nSection0 Then
						GUICtrlSetData($nHour, $aIni2D[$i][1])
						GUICtrlSetData($nMin, $aIni2D[$i][2])
						GUICtrlSetData($nSec, $aIni2D[$i][3])
						GUICtrlSetData($nSig, $aIni2D[$i][4])
						ExitLoop
					EndIf
				Next
				If StringMid($aIni2D[$i][4], 2, 2) = ':\' Then
					GUICtrlSetData($nSig, $aIni2D[$i][4])
					If Not FileExists($aIni2D[$i][4]) Then MsgBox(0, $LngErr, $LngErrMsg2 & @CRLF & $aIni2D[$i][4], 0, $Gui1)
				EndIf

			Case $nSave
				$GP = _ChildCoor($Gui1, 270, 130)
				$nSection0 = InputBox($LngIB1, $LngIB2, '', '', $GP[2], $GP[3], $GP[0], $GP[1])
				If @error Or $nSection0 = '' Then ContinueLoop
				$nHour0 = GUICtrlRead($nHour)
				$nMin0 = GUICtrlRead($nMin)
				$nSec0 = GUICtrlRead($nSec)
				$nSi0 = GUICtrlRead($nSig)
				If $nHour0 + $nMin0 + $nSec0 = 0 Then
					MsgBox(0, $LngErr, $LngErrMsg, 0, $Gui1)
					ContinueLoop
				EndIf
				If StringMid($nSi0, 2, 2) = ':\' And Not FileExists($nSi0) Then
					MsgBox(0, $LngErr, $LngErrMsg2, 0, $Gui1)
					ContinueLoop
				EndIf
				If GUICtrlSendMsg($nSection, $LB_FINDSTRINGEXACT, 0, $nSection0) <> -1 Then ; пункт уже существует
					MsgBox(0, $LngErr, $LngErrMsg3, 0, $Gui1)
					ContinueLoop
				EndIf
				ReDim $aIni2D[$aIni2D[0][0] + 2][5]
				$aIni2D[0][0] += 1
				$j = $aIni2D[0][0]
				$aIni2D[$j][0] = $nSection0
				$aIni2D[$j][1] = $nHour0
				$aIni2D[$j][2] = $nMin0
				$aIni2D[$j][3] = $nSec0
				$aIni2D[$j][4] = $nSi0
				; $ReadTmp = $nSection0 & '|' & $nHour0 & '|' & $nMin0 & '|' & $nSec0 & '|' & $nSi0 & @CRLF
				IniWriteSection($ini, $nSection0, 'Name=' & $nSection0 & @LF & 'Time=' & $nHour0 & ':' & $nMin0 & ':' & $nSec0 & @LF & 'Execute=' & $nSi0)
				; If StringLeft($nSi0, 1) = '3' Then GUICtrlSetData($nSig, $nSi0, $nSi0)
				GUICtrlSetData($nSection, $nSection0)
				GUICtrlSetState($nOpen, $GUI_SHOW)

			Case $nOK
				$TrSignal = 1
				$nHour0 = GUICtrlRead($nHour)
				$nMin0 = GUICtrlRead($nMin)
				$nSec0 = GUICtrlRead($nSec)
				$nSig0 = GUICtrlRead($nSig)
				If $nHour0 + $nMin0 + $nSec0 = 0 Then
					MsgBox(0, $LngErr, $LngErrMsg4, 0, $Gui1)
					ContinueLoop
				EndIf
				$iTimeSig = $nHour0 * 3600 + $nMin0 * 60 + $nSec0
				If $nHour0 < 10 Then $nHour0 = '0' & $nHour0
				If $nMin0 < 10 Then $nMin0 = '0' & $nMin0
				If $nSec0 < 10 Then $nSec0 = '0' & $nSec0
				GUICtrlSetData($iSgLabel, 'Sg - ' & $nHour0 & ':' & $nMin0 & ':' & $nSec0 & '.0')
				_Reset()
				_Start()
				ContinueCase
			Case $GUI_EVENT_CLOSE
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($Gui1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>_GUI_SetSignal

Func _IniText()
	$aIni = IniReadSectionNames($ini)
	If Not @error Then
		Local $aIni
		Local $aIni2D[$aIni[0] + 1][5], $tmp, $j = 1
		For $i = 1 To $aIni[0]
			If $aIni[$i] = 'Setting' Then ContinueLoop
			$tmp = IniRead($ini, $aIni[$i], 'Name', '')
			If Not $tmp Then ContinueLoop
			$aIni2D[$j][0] = $tmp
			$tmp = IniRead($ini, $aIni[$i], 'Time', '')
			If Not $tmp Then ContinueLoop
			$tmp = StringSplit($tmp, ':')
			If Not ($tmp[0] = 3 And StringIsDigit($tmp[1]) And StringIsDigit($tmp[2]) And StringIsDigit($tmp[3])) Then ContinueLoop
			; If Not (UBound($tmp)<>3 Or Not StringIsDigit($tmp[0]) Or Not StringIsDigit($tmp[1]) Or Not StringIsDigit($tmp[2])) Then
			$aIni2D[$j][1] = $tmp[1]
			$aIni2D[$j][2] = $tmp[2]
			$aIni2D[$j][3] = $tmp[3]
			$tmp = IniRead($ini, $aIni[$i], 'Execute', '')
			If Not $tmp Then ContinueLoop
			$aIni2D[$j][4] = $tmp
			$j += 1
		Next
		ReDim $aIni2D[$j][5]
		$aIni2D[0][0] = $j - 1
	Else
		Local $aIni2D[1][5] = [[0]]
	EndIf
	Return $aIni2D
EndFunc   ;==>_IniText

Func _bk()
	GUICtrlSetFont(-1, 20, $Bold, -1, 'Arial')
	GUICtrlSetColor(-1, 0xc03d3a)
	GUICtrlSetBkColor(-1, 0xffffff)
EndFunc   ;==>_bk

Func _Start()
	$iTimerDiff_Tmp = -1000
	If $Tr2 = 1 Then Return
	If $TrStart = 0 Then
		$TrStart = 1
		$Tr3 = 1
		$i_dPause = 0
		GUICtrlSetData($Start, $LngSp)
		GUICtrlSetState($Pause0, 64)
		$iStart = TimerInit()
		_GUICtrlButton_SetImageList($Start, $aImgLst[9], 0)
		_GUICtrlButton_SetImageList($Pause0, $aImgLst[2], 0)
	Else
		$TrStart = 0
		$Tr3 = 0
		GUICtrlSetData($Start, $LngStart)
		GUICtrlSetState($Pause0, 128)
		_GUICtrlButton_SetImageList($Start, $aImgLst[1], 0)
		_GUICtrlButton_SetImageList($Pause0, $aImgLst[11], 0)
	EndIf
EndFunc   ;==>_Start

Func _Reset()
	$iTimerDiff_Tmp = -1000
	$sLabel = ' 00:00:00.0'
	$TrStart = 0
	$Tr2 = 0
	$Tr3 = 0
	$iTime = 0
	$i_dPause = 0
	GUICtrlSetData($hLabel1, ' 00')
	GUICtrlSetData($hLabel2, '00')
	GUICtrlSetData($hLabel3, '00')
	GUICtrlSetData($hLabel4, '0')
	GUICtrlSetData($iMemTime, '')
	GUICtrlSetData($Start, $LngStart)
	GUICtrlSetState($Start, 64)
	GUICtrlSetData($Pause0, $LngPs)
	GUICtrlSetState($Pause0, 128)
	_GUICtrlButton_SetImageList($Start, $aImgLst[1], 0)
	_GUICtrlButton_SetImageList($Pause0, $aImgLst[11], 0)
EndFunc   ;==>_Reset

Func _MP($nSi2)
	$melod = '#NoTrayIcon' & @CRLF & _
			'SoundPlay("' & $nSi2 & '", 0)' & @CRLF & _
			'MsgBox(0, "' & StringRegExpReplace($nSi2, '^.*\\(.*)$', '\1') & '", "' & $LngStp & '?")'
	$file = FileOpen(@TempDir & '\Beepfile.au3', 2)
	FileWrite($file, $melod)
	FileClose($file)
	$iPID = Run('"' & @AutoItExe & '" /AutoIt3ExecuteScript "' & @TempDir & '\Beepfile.au3"', '', @SW_HIDE)
EndFunc   ;==>_MP

Func _StartFile($sPath)
	$type = StringRegExpReplace($sPath, '.*(\.\S+)', '\1')
	$Editor = _FileAssociation($type)
	If @error Or Not FileExists($Editor) Then ShellExecute($sPath)
	$iPID = Run('"' & $Editor & '" "' & $sPath & '"')
	; $Editor = _WinAPI_FindExecutable($sPath)
	; If Not @error Then $iPID = Run('"' & $Editor & '" "' & $sPath & '"')
EndFunc   ;==>_StartFile

Func _melodia()
	$melod = '#NoTrayIcon' & @CRLF & _
			'Global $nTempo=0.8' & @CRLF & 'Global $iTone=0' & @CRLF & 'HotKeySet("{ESC}", "_Quit")' & @CRLF & '_Beep(8,4,100)' & @CRLF & _
			'_Beep(7,4,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & '_Beep(9,4,100)' & @CRLF & '_Beep(8,4,100,100)' & @CRLF & _
			'_Beep(1,5,100,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & '_Beep(7,4,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & _
			'_Beep(9,4,100)' & @CRLF & '_Beep(8,4,100,100)' & @CRLF & '_Beep(12,4,100,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & _
			'_Beep(7,4,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & '_Beep(9,4,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & _
			'_Beep(6,5,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & '_Beep(12,4,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & _
			'_Beep(6,4,100)' & @CRLF & '_Beep(5,4,100)' & @CRLF & '_Beep(4,4,200,300)' & @CRLF & '_Beep(1,5,100)' & @CRLF & _
			'_Beep(12,4,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & '_Beep(9,4,100)' & @CRLF & '_Beep(1,5,100,100)' & @CRLF & _
			'_Beep(6,5,100,100)' & @CRLF & '_Beep(4,5,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & '_Beep(1,5,100)' & @CRLF & _
			'_Beep(8,4,100)' & @CRLF & '_Beep(1,5,100,100)' & @CRLF & '_Beep(4,5,100,100)' & @CRLF & '_Beep(4,5,100)' & @CRLF & _
			'_Beep(3,5,100)' & @CRLF & '_Beep(1,5,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & '_Beep(3,4,100)' & @CRLF & _
			'_Beep(7,4,100)' & @CRLF & '_Beep(10,4,100)' & @CRLF & '_Beep(1,5,100)' & @CRLF & '_Beep(4,5,100)' & @CRLF & _
			'_Beep(3,5,100)' & @CRLF & '_Beep(1,5,100)' & @CRLF & '_Beep(3,5,250,250)' & @CRLF & '_Beep(8,4,100)' & @CRLF & _
			'_Beep(7,4,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & '_Beep(9,4,100)' & @CRLF & '_Beep(8,4,100,100)' & @CRLF & _
			'_Beep(1,5,100,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & '_Beep(7,4,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & _
			'_Beep(9,4,100)' & @CRLF & '_Beep(8,4,100,100)' & @CRLF & '_Beep(12,4,100,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & _
			'_Beep(7,4,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & '_Beep(9,4,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & _
			'_Beep(6,5,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & '_Beep(12,4,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & _
			'_Beep(6,4,100)' & @CRLF & '_Beep(5,4,100)' & @CRLF & '_Beep(4,4,200,300)' & @CRLF & '_Beep(1,5,100)' & @CRLF & _
			'_Beep(12,4,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & '_Beep(9,4,100)' & @CRLF & '_Beep(1,5,100,100)' & @CRLF & _
			'_Beep(6,5,100,100)' & @CRLF & '_Beep(4,5,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & '_Beep(1,5,100)' & @CRLF & _
			'_Beep(8,4,100)' & @CRLF & '_Beep(1,5,100,100)' & @CRLF & '_Beep(4,5,100,100)' & @CRLF & '_Beep(4,5,100)' & @CRLF & _
			'_Beep(3,5,100)' & @CRLF & '_Beep(1,5,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & _
			'_Beep(12,4,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & '_Beep(8,5,100)' & @CRLF & '_Beep(6,5,100)' & @CRLF & _
			'_Beep(4,5,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & '_Beep(1,5,300,200)' & @CRLF & '_Beep(3,5,100)' & @CRLF
	$melod &= _
			'_Beep(1,5,100)' & @CRLF & '_Beep(12,4,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & '_Beep(4,4,100)' & @CRLF & _
			'_Beep(8,4,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & '_Beep(4,4,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & _
			'_Beep(11,4,100)' & @CRLF & '_Beep(12,4,100)' & @CRLF & '_Beep(1,5,150,150)' & @CRLF & '_Beep(9,4,200,100)' & @CRLF & _
			'_Beep(3,5,100)' & @CRLF & '_Beep(1,5,100)' & @CRLF & '_Beep(12,4,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & _
			'_Beep(3,4,100)' & @CRLF & '_Beep(6,4,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & '_Beep(3,4,100)' & @CRLF & _
			'_Beep(6,4,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & '_Beep(12,4,100)' & @CRLF & '_Beep(1,5,150,150)' & @CRLF & _
			'_Beep(8,4,200,100)' & @CRLF & '_Beep(4,5,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & '_Beep(6,5,100)' & @CRLF & _
			'_Beep(4,5,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & '_Beep(1,5,100)' & @CRLF & '_Beep(4,5,100)' & @CRLF & _
			'_Beep(3,5,100)' & @CRLF & '_Beep(1,5,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & '_Beep(3,5,150,150)' & @CRLF & _
			'_Beep(11,4,300,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & '_Beep(1,5,100)' & @CRLF & '_Beep(4,5,100)' & @CRLF & _
			'_Beep(3,5,100)' & @CRLF & '_Beep(1,5,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & _
			'_Beep(1,5,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & '_Beep(9,4,100)' & @CRLF & '_Beep(11,4,400,100)' & @CRLF & _
			'_Beep(3,5,100)' & @CRLF & '_Beep(1,5,100)' & @CRLF & '_Beep(12,4,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & _
			'_Beep(4,4,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & '_Beep(4,4,100)' & @CRLF & _
			'_Beep(8,4,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & '_Beep(12,4,100)' & @CRLF & '_Beep(1,5,150,150)' & @CRLF & _
			'_Beep(9,4,200,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & '_Beep(1,5,100)' & @CRLF & '_Beep(12,4,100)' & @CRLF & _
			'_Beep(11,4,100)' & @CRLF & '_Beep(3,4,100)' & @CRLF & '_Beep(6,4,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & _
			'_Beep(3,4,100)' & @CRLF & '_Beep(6,4,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & '_Beep(12,4,100)' & @CRLF & _
			'_Beep(1,5,150,150)' & @CRLF & '_Beep(8,4,150,150)' & @CRLF & '_Beep(4,5,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & _
			'_Beep(2,5,100)' & @CRLF & '_Beep(1,5,100)' & @CRLF & '_Beep(12,4,100)' & @CRLF & '_Beep(1,5,100)' & @CRLF & _
			'_Beep(3,5,100)' & @CRLF & '_Beep(6,5,100)' & @CRLF & '_Beep(4,5,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & _
			'_Beep(1,5,100)' & @CRLF & '_Beep(4,5,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & '_Beep(4,5,100)' & @CRLF & _
			'_Beep(8,5,100)' & @CRLF & '_Beep(11,5,100)' & @CRLF & '_Beep(10,5,100)' & @CRLF & '_Beep(9,5,100)' & @CRLF & _
			'_Beep(8,5,100)' & @CRLF & '_Beep(6,5,100)' & @CRLF & '_Beep(4,5,100)' & @CRLF & '_Beep(3,5,100)' & @CRLF & _
			'_Beep(1,5,100)' & @CRLF & '_Beep(11,4,100)' & @CRLF & '_Beep(9,4,100)' & @CRLF & '_Beep(8,4,100)' & @CRLF & _
			'_Beep(6,4,100)' & @CRLF & '_Beep(4,4,200)' & @CRLF & _
			'Func _Beep($iNote,$iOctave=4,$iDuration=200,$iPause=0)' & @CRLF & _
			'	$iFrequency=440*2^(($iNote+$iTone)/12+$iOctave+1/6-4)' & @CRLF & _
			'	Beep($iFrequency, $iDuration/$nTempo)' & @CRLF & _
			'	If $iPause<>0 Then Sleep($iPause/$nTempo)' & @CRLF & _
			'EndFunc' & @CRLF & _
			'Func _Quit()' & @CRLF & _
			'    Exit' & @CRLF & _
			'EndFunc'
	$file = FileOpen(@TempDir & '\Beepfile.au3', 2)
	FileWrite($file, $melod)
	FileClose($file)
	$iPID = Run('"' & @AutoItExe & '" /AutoIt3ExecuteScript "' & @TempDir & '\Beepfile.au3"', '', @SW_HIDE)
EndFunc   ;==>_melodia

Func WM_ACTIVATE($hWnd, $Msg, $wParam, $lParam)
	; $Minimized = BitShift($wParam, 16)
	$Active = BitAND($wParam, 0xFFFF)
	If $Active Then WinSetTitle($Gui, '', $LngTitle)
EndFunc   ;==>WM_ACTIVATE

Func _About()
	Global $iScroll_Pos, $Gui1, $nLAbt, $hAbt, $wAbtBt
	; If Not IsDeclared('LngTitle') Then $LngTitle = 'New Program'
	; If Not IsDeclared('LngAbout') Then $LngAbout = 'About'
	; If Not IsDeclared('LngVer') Then $LngVer = 'Version'
	; If Not IsDeclared('LngSite') Then $LngSite = 'Site'
	; If Not IsDeclared('LngCopy') Then $LngCopy = 'Copy'
	$wAbt = 270
	$hAbt = 180
	$wAbtBt = 20
	$wA = $wAbt / 2 - 80
	$wB = $hAbt / 3 * 2
	$iScroll_Pos = -$hAbt
	$TrAbt1 = 0
	$TrAbt2 = 0
	$BkCol1 = 0xE1E3E7
	$BkCol2 = 0
	$GuiPos = WinGetPos($Gui)
	$GP = _ChildCoor($Gui, 270, 180)
	GUISetState(@SW_DISABLE, $Gui)
	$font = "Arial"

	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOR($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui)
	If Not @Compiled Then GUISetIcon($AutoItExe, 99)
	GUISetBkColor($BkCol1)
	GUISetFont(-1, -1, -1, $font)
	$vk1 = GUICtrlCreateButton(ChrW('0x25BC'), 0, $hAbt - 20, $wAbtBt, 20)

	GUICtrlCreateTab($wAbtBt, 0, $wAbt - $wAbtBt, $hAbt + 35, 0x0100 + 0x0004 + 0x0002)
	$tabAbt0 = GUICtrlCreateTabItem("0")

	GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt - $wAbtBt, $hAbt)
	GUICtrlSetState(-1, 128)
	GUICtrlSetBkColor(-1, $BkCol1)

	GUICtrlCreateLabel($LngTitle, 0, 0, $wAbt, $hAbt / 3, 0x01 + 0x0200)
	GUICtrlSetFont(-1, 15, 600, -1, $font)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetBkColor(-1, 0xF1F1EF)
	GUICtrlCreateLabel("-", 2, $hAbt / 3, $wAbt - 2, 1, 0x10)

	GUISetFont(9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer & ' 0.8  27.02.2013', $wA, $wB - 30, 210, 17)
	GUICtrlCreateLabel($LngSite & ':', $wA, $wB - 15, 40, 17)
	$url = GUICtrlCreateLabel('http://azjio.ucoz.ru', $wA + 37, $wB - 15, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', $wA, $wB, 85, 17)
	$WbMn = GUICtrlCreateLabel('R939163939152', $wA + 75, $wB, 125, 17)
	GUICtrlSetColor(-1, 0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010-2013', $wA, $wB + 15, 210, 17)

	$tabAbt1 = GUICtrlCreateTabItem("1")

	GUICtrlCreateLabel('', $wAbtBt, 0, $wAbt - $wAbtBt, $hAbt)
	GUICtrlSetState(-1, 128)
	GUICtrlSetBkColor(-1, 0x0)

	$StopPlay = GUICtrlCreateButton(ChrW('0x25A0'), 0, $hAbt - 41, $wAbtBt, 20)
	GUICtrlSetState(-1, 32)

	$nLAbt = GUICtrlCreateLabel($LngScrollAbt, $wAbtBt, $hAbt, $wAbt - $wAbtBt, 360, 0x1) ; центр
	GUICtrlSetFont(-1, 9, 400, 2, $font)
	GUICtrlSetColor(-1, 0x99A1C0)
	GUICtrlSetBkColor(-1, -2) ; прозрачный
	GUICtrlCreateTabItem('')
	GUISetState(@SW_SHOW, $Gui1)

	While 1
		Switch GUIGetMsg()
			Case $vk1
				If $TrAbt1 = 0 Then
					GUICtrlSetState($tabAbt1, 16)
					GUICtrlSetState($nLAbt, 16)
					GUICtrlSetState($StopPlay, 16)
					GUICtrlSetData($vk1, ChrW('0x25B2'))
					GUISetBkColor($BkCol2)
					If $TrAbt2 = 0 Then AdlibRegister('_ScrollAbtText', 40)
					$TrAbt1 = 1
				Else
					GUICtrlSetState($tabAbt0, 16)
					GUICtrlSetState($nLAbt, 32)
					GUICtrlSetState($StopPlay, 32)
					GUICtrlSetData($vk1, ChrW('0x25BC'))
					GUISetBkColor($BkCol1)
					AdlibUnRegister('_ScrollAbtText')
					$TrAbt1 = 0
				EndIf
			Case $StopPlay
				If $TrAbt2 = 0 Then
					AdlibUnRegister('_ScrollAbtText')
					GUICtrlSetData($StopPlay, ChrW('0x25BA'))
					$TrAbt2 = 1
				Else
					AdlibRegister('_ScrollAbtText', 40)
					GUICtrlSetData($StopPlay, ChrW('0x25A0'))
					$TrAbt2 = 0
				EndIf
			Case $url
				ShellExecute('http://azjio.ucoz.ru')
			Case $WbMn
				ClipPut('R939163939152')
			Case $GUI_EVENT_CLOSE
				AdlibUnRegister('_ScrollAbtText')
				GUISetState(@SW_ENABLE, $Gui)
				GUIDelete($Gui1)
				ExitLoop
		EndSwitch
	WEnd
EndFunc   ;==>_About

Func _ScrollAbtText()
	$iScroll_Pos += 1
	ControlMove($Gui1, "", $nLAbt, $wAbtBt, -$iScroll_Pos)
	If $iScroll_Pos > 360 Then $iScroll_Pos = -$hAbt
EndFunc   ;==>_ScrollAbtText