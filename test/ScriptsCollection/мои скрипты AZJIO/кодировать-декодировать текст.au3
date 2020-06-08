#include <Crypt.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>

; En
$LngEnc = 'Encrypt'
$LngDec = 'Decrypt'
$LngEnPs = 'Enter the password'
$LngEnPt = 'Enter the path or drag a file into the input field'
$LngSet1 = 'Disabled'
$LngSet2 = 'Auto Encoding'
$LngSet3 = 'Auto decoding'
$LngMs1 = 'Message'
$LngMs2 = 'The path does not exist'
$LngMs3 = 'No password'
$LngNFL='In a new file'
$LngScf='Successfully'
$LngFlr='Failure'

$UserIntLang = DllCall('kernel32.dll', 'int', 'GetUserDefaultUILanguage')
If Not @error Then $UserIntLang = Hex($UserIntLang[0], 4)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	$LngEnc = 'Кодировать'
	$LngDec = 'Декодировать'
	$LngEnPs = 'Введите пароль'
	$LngEnPt = 'Введите путь или перетащите файл в поле ввода'
	$LngSet1 = 'Отключено'
	$LngSet2 = 'Автокодирование'
	$LngSet3 = 'Автодекодирование'
	$LngMs1 = 'Сообщение'
	$LngMs2 = 'Путь не существует'
	$LngMs3 = 'Отсутствует пароль'
	$LngNFL='В новый файл'
	$LngScf='Успешно'
	$LngFlr='Неудачно'
EndIf

Global $LastPath=''

$Gui = GUICreate($LngEnc & ' / ' & $LngDec, 350, 110, -1, -1, -1, $WS_EX_ACCEPTFILES)
If Not @compiled Then GUISetIcon('shell32.dll', 48)
$StatusBar=GUICtrlCreateLabel('', 160, 60, 150, 17)

$Open37 = GUICtrlCreateButton('...', 313, 30, 26, 23)
GUICtrlSetFont(-1, 16)

$NewFile = GUICtrlCreateCheckbox($LngNFL, 10, 60, 120, 17)
GUICtrlSetState(-1, 1)

$key = GUICtrlCreateInput($LngEnPs, 10, 5, 330, 22)
GUICtrlSetFont(-1, -1, -1, 2)
$Path = GUICtrlCreateInput($LngEnPt, 10, 30, 304, 22)
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUICtrlSetFont(-1, -1, -1, 2)

$Auto = GUICtrlCreateCombo('', 10, 80, 140, 23, 0x3)
GUICtrlSetData(-1, $LngSet1 & '|' & $LngSet2 & '|' & $LngSet3, $LngSet1)

$enc = GUICtrlCreateButton($LngEnc, 160, 80, 80, 24)
$dec = GUICtrlCreateButton($LngDec, 250, 80, 90, 24)

GUISetState()
GUIRegisterMsg(0x0111, "WM_COMMAND")
_Crypt_Startup()

While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case -13
			If @GUI_DropId = $Path Then GUICtrlSetData($Path, @GUI_DragFile)
			Switch GUICtrlRead($Auto)
				Case $LngSet2
					_Enc(1)
				Case $LngSet3
					_Enc(0)
			EndSwitch
		Case $enc
			_Enc(1)
		Case $dec
			_Enc(0)
		Case $Open37
			If $LastPath='' Then $LastPath=@DesktopDir
			$OpenFile = FileOpenDialog('', $LastPath , '(*.*)', 3, '', $Gui)
			If @error Then ContinueLoop
			GUICtrlSetFont($Path, -1, -1, 0)
			GUICtrlSetData($Path, $OpenFile)
			$LastPath=StringLeft($OpenFile, StringInStr($OpenFile, "\", 0, -1)-1)
			Switch GUICtrlRead($Auto)
				Case $LngSet2
					_Enc(1)
				Case $LngSet3
					_Enc(0)
			EndSwitch
		Case -3
			_Crypt_Shutdown()
			Exit
	EndSwitch
WEnd

Func _Enc($type)
	Local $aPath, $ED, $i, $key0, $n, $Path0, $PathN
	$key0 = GUICtrlRead($key)
	$Path0 = GUICtrlRead($Path)
	
	If Not FileExists($Path0) Then Return MsgBox(0, $LngMs1, $LngMs2)
	If $key0 = '' Then Return MsgBox(0, $LngMs1, $LngMs3)
	
	If $type Then
		$ED = 'E'
	Else
		$ED = 'D'
	EndIf
	
	$aPath = StringRegExp($Path0, '^(.*\\[^\\]*?)(\.[^.]+)?$', 3)
	$n = UBound($aPath)
	$i = 0
	Do
		$i += 1
		If $n = 2 Then
			$PathN = $aPath[0] & '_' & $i & $ED & '.' & $aPath[1]
		Else
			$PathN = $aPath[0] & '_' & $i & $ED
		EndIf
	Until Not FileExists($PathN)
	
	If $type Then
		$yes=_Crypt_EncryptFile($Path0, $PathN, $key0, $CALG_RC4)
	Else
		$yes=_Crypt_DecryptFile($Path0, $PathN, $key0, $CALG_RC4)
	EndIf
	
	If GUICtrlRead($NewFile)=4 Then
		If $yes And FileMove($PathN, $Path0, 9) Then
			$i=$LngScf
		Else
			$i=$LngFlr
		EndIf
	Else
		If $yes Then
			$i=$LngScf
		Else
			$i=$LngFlr
		EndIf
	EndIf
	GUICtrlSetData($StatusBar, $i)
	AdlibRegister('_StatusBarAR', 2000)
EndFunc

Func _StatusBarAR()
	GUICtrlSetData($StatusBar, '')
	AdlibUnRegister('_StatusBarAR')
EndFunc

Func WM_COMMAND($hWnd, $msg, $wParam, $lParam)
    Local $nID = BitAND($wParam, 0x0000FFFF)

	Switch $nID
		Case $key
			Switch GUICtrlRead($nID, 1)
				Case $LngEnPs
					GUICtrlSetData($nID, '')
					GUICtrlSetFont($nID, -1, -1, 0)
				Case ''
					GUICtrlSetData($nID, $LngEnPs)
					GUICtrlSetFont($nID, -1, -1, 2)
			EndSwitch
		Case $Path
			Switch GUICtrlRead($nID, 1)
				Case $LngEnPt
					GUICtrlSetData($nID, '')
					GUICtrlSetFont($nID, -1, -1, 0)
				Case ''
					GUICtrlSetData($nID, $LngEnPt)
					GUICtrlSetFont($nID, -1, -1, 2)
			EndSwitch
	EndSwitch
    Return 'GUI_RUNDEFMSG'
EndFunc