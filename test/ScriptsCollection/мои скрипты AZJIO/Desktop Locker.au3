#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=Desktop_Locker.exe
#AutoIt3Wrapper_icon=Desktop_Locker.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Desktop_Locker.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Field=Version|0.2
#AutoIt3Wrapper_Res_Field=Build|2012.02.22
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#Obfuscator_Ignore_Variables=$LngTitle, $LngAbout, $LngVer, $LngCopy, $LngSite, $LngLDP, $LngPsw, $LngChB, $LngErPw1, $LngErPw2, $LngERe, $LngDly, $LngMsB, $LngTrn, $LngDsc, $LngQLn, $LngMPr, $LngLnk, $LngSTp, $LngLnkH, $LngRgt, $LngRgtH, $LngMs2, $LngMs3, $LngMs4, $LngMs5, $LngMs6, $LngErr
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

;  @AZJIO 2011.05.08 - 2012.02.22    (AutoIt3_v3.3.6.1)

; HotKeySet("{ESC}", "_Exit")
; Func _Exit()
    ; Exit
; EndFunc

#NoTrayIcon
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <ComboConstants.au3>
#Include <String.au3>
#Include <Array.au3>

Global Const $ES_CENTER = 1
Global Const $ES_PASSWORD = 32
Global Const $tagRECT = "long Left;long Top;long Right;long Bottom"

Global $Password='', $k=0, $aSet, $Gui1, $ValSld
Global $DW=@DesktopWidth, $DH=@DesktopHeight

; En
$LngTitle='Desktop Locker'
$LngAbout='About'
$LngVer='Version'
$LngCopy='Copy'
$LngSite='Site'
$LngPsw='Password to unlock'
$LngChB='Hide password'
$LngErPw1='The password is incorrect ..try again.'
$LngErPw2='Please enter a password to unlock the screen'&@CRLF&'and press Enter.'
$LngERe='Display output and restart'
$LngDly='Delay'
$LngMsB='Block mouse'
$LngTrn='Transparency'
$LngDsc='Desktop'
$LngQLn='Quick Launch'
$LngMPr='Main Menu'
$LngLnk='Shortcut on'
$LngSTp='Lock desktop with password'
$LngLnkH='Create a shortcut with an encrypted password'
$LngRgt='Startup'
$LngRgtH='Losing a password will require professional help'
$LngMs2='Message'
$LngMs3='The key in the registry is missing, perhaps not right to write to the registry'
$LngMs4='Key successfully added'
$LngMs5='The key was successfully removed'
$LngMs6='The key is exists, maybe not the right to delete'
$LngErr='Error'

If FileExists(@ScriptDir & '\Lang.ini') Then
	$aLng = IniReadSection(@ScriptDir & '\Lang.ini', 'lng')
	If Not @error Then
		For $i = 1 To $aLng[0][0]
			If StringInStr($aLng[$i][1], '\n') Then $aLng[$i][1] = StringReplace($aLng[$i][1], '\n', @CRLF)
			If IsDeclared('Lng' & $aLng[$i][0]) Then Assign('Lng' & $aLng[$i][0], $aLng[$i][1])
		Next
	EndIf
Else
	If @OSLang = 0419 Then
	$LngAbout='О программе'
	$LngVer='Версия'
	$LngCopy='Копировать'
	$LngSite='Сайт'
	$LngPsw='Пароль для разблокировки'
	$LngChB='Скрыть пароль'
	$LngErPw1='Пароль неверный, попробуйте снова.'
	$LngErPw2='Пожалуйста, введите пароль для разблокировки экрана'&@CRLF&'и нажмите Enter.'
	$LngERe='Отображать выход и перезагрузка'
	$LngDly='Задержка'
	$LngMsB='Блокировать мышь'
	$LngTrn='Прозрачность'
	$LngDsc='Рабочий стол'
	$LngQLn='Быстрый запуск'
	$LngMPr='Главное меню'
	$LngLnk='Ярлык на'
	$LngSTp='Заблокировать рабочий стол с паролем'
	$LngLnkH='Создать ярлык с шифрованным паролем'
	$LngRgt='Автозагрузка'
	$LngRgtH='Потеря пароля потребует помощи профессионала'
	$LngMs2='Сообщение'
	$LngMs3='Ключ в реестре отсутствует, возможно нет прав на запись в реестр'
	$LngMs4='Ключ успешно добавлен'
	$LngMs5='Ключ успешно удалён'
	$LngMs6='Ключ существует, возможно нет прав на удаление'
	$LngErr='Ошибка'
	EndIf
EndIf

Global $Ini = @ScriptDir & '\DesktopLocker.ini'
If Not FileExists($Ini) And DriveStatus(StringLeft(@ScriptDir, 1))<>'NOTREADY' Then
	_FileW()
EndIf

Func _FileW($i='1|0|0|1|255')
	$file = FileOpen($Ini,2)
	FileWrite($file, $i)
	FileClose($file)
EndFunc

Func _MsgFile()
	$file = FileOpen($Ini, 0)
	$Initext = FileRead($file)
	FileClose($file)
	$aSet = StringSplit($Initext, '|')
	If $aSet[0]<>5 Then
		$Initext='1|0|0|1|255'
		_FileW($Initext)
		$aSet = StringSplit($Initext, '|')
	EndIf
	Local $ChPsHd, $Inp0, $Inp1, $Inp2, $msg, $OK, $Password=''
    $Gui1 = GUICreate($LngTitle, 290, 270, -1, -1, $WS_CAPTION+$WS_SYSMENU)
	If Not @compiled Then GUISetIcon(@ScriptDir&'\Desktop_Locker.ico')
	
	GUICtrlCreateGroup($LngPsw, 5, 5, 200, 72)
	; GUICtrlCreateLabel($LngPsw, 10, 13, 190, 17)
	$Inp1=GUICtrlCreateInput('', 10, 25, 190, 22)
	$Inp2=GUICtrlCreateInput('', 10, 25, 190, 22, $ES_PASSWORD)
	$ChPsHd=GUICtrlCreateCheckbox($LngChB, 10, 55, 170, 15)
	If $aSet[1] = $GUI_CHECKED Then
		GUICtrlSetState($Inp2, $GUI_FOCUS)
		GUICtrlSetState($Inp1, $GUI_HIDE)
		$Inp0=$Inp2
		GUICtrlSetState($ChPsHd, $GUI_CHECKED)
	Else
		GUICtrlSetState($Inp1, $GUI_FOCUS)
		GUICtrlSetState($Inp2, $GUI_HIDE)
		$Inp0=$Inp1
		GUICtrlSetState($ChPsHd, $GUI_UNCHECKED)
	EndIf
	
	GUICtrlCreateGroup('', 5, 78, 200, 79)
	$ShtDwn=GUICtrlCreateCheckbox($LngERe, 10, 90, 190, 15)
	If $aSet[2]=$GUI_CHECKED Then GUICtrlSetState(-1, 1)
	$DelayL=GUICtrlCreateLabel($LngDly&' :', 10, 113, 70, 17)
	$Delay=GUICtrlCreateCombo('', 80, 110, 60)
	GUICtrlSetData(-1,'0|1|10|30|60|120', '0')
	GUICtrlSetData(-1,$aSet[3], $aSet[3])
	$MsBloc=GUICtrlCreateCheckbox($LngMsB, 10, 137, 190, 15)
	If $aSet[4]=$GUI_CHECKED Then
		GUICtrlSetState($MsBloc, $GUI_CHECKED)
	Else
		GUICtrlSetState($MsBloc, $GUI_UNCHECKED)
	EndIf
	$About=GUICtrlCreateButton('@', 235, 30, 30, 30)
	GUICtrlSetTip(-1, $LngAbout)
	GUICtrlSetFont(-1,13)
	GUICtrlCreateIcon ("shell32.dll", 48, 230, 91, 48, 48)
	
	$OK=GUICtrlCreateButton('OK', 215, 190, 60, 50)
	GUICtrlSetState(-1, $GUI_DEFBUTTON)
	GUICtrlSetFont(-1,13)
	If GUICtrlRead($ShtDwn)=4 Then
		GUICtrlSetState($Delay, $GUI_DISABLE)
		GUICtrlSetState($DelayL, $GUI_DISABLE)
	EndIf
	
	GUICtrlCreateGroup($LngTrn, 5, 159, 200, 50)
	$slider1 = GUICtrlCreateSlider(6, 173, 163, 30)
	GUICtrlSetLimit(-1, 100, 0)
	GUICtrlSetTip(-1, $LngTrn)
	GUICtrlSetData(-1, 255-$aSet[5])
	$ValSld=GUICtrlCreateLabel(255-$aSet[5], 169, 178, 30, 17)
	GUICtrlSetFont(-1,12)
	WinSetTrans($Gui1,"",$aSet[5])
	
	GUICtrlCreateLabel($LngLnk&' :', 10, 218, 60, 17)
	$LinkCombo=GUICtrlCreateCombo('', 65, 215, 112, 22, $CBS_DROPDOWNLIST)
	GUICtrlSetData(-1, $LngDsc&'|'&$LngQLn&'|'&$LngMPr, $LngDsc)
	$CreateLnk=GUICtrlCreateButton('>', 180, 215, 22, 24)
	GUICtrlSetTip(-1, $LngLnkH)
	
	$Registry=GUICtrlCreateCheckbox($LngRgt, 10, 245, 180, 15)
	GUICtrlSetTip(-1, $LngRgtH)
	RegRead("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", 'Desktop_Locker_456')
	If Not @Error Then GUICtrlSetState($Registry, $GUI_CHECKED)
	
	GUISetState()
	While 1
		$msg = GUIGetMsg()
		Switch $msg
			Case $Registry ; Автозагрузка
				If GUICtrlRead($Registry)=$GUI_CHECKED Then
					$Password = GUICtrlRead($Inp0)
					If $Password = '' Then
						GUICtrlSetState($Registry, $GUI_UNCHECKED)
						_ColorError($Inp0)
						GUICtrlSetState($Inp0, $GUI_FOCUS)
						ContinueLoop
					EndIf
				
					$aSet[3] = GUICtrlRead($Delay)
					$aSet[4] = GUICtrlRead($MsBloc)
					$aSet[5]=255-GUICtrlRead($slider1)
					$Initext=$aSet[1]&'|'&$aSet[2]&'|'&$aSet[3]&'|'&$aSet[4]&'|'&$aSet[5]
				
					$bEncrypted = _StringEncrypt(1, $Password, $Password)&'J'&_StringEncrypt(1, $Initext, 'dk3wo6e9ru')
					RegWrite("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", 'Desktop_Locker_456', "REG_SZ", '"'&@ScriptFullPath&'" '&$bEncrypted)
					RegRead("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", 'Desktop_Locker_456')
					If @Error Then
						MsgBox(0, $LngErr, $LngMs3)
						GUICtrlSetState($Registry, $GUI_UNCHECKED)
					Else
						MsgBox(0, $LngMs2, $LngMs4)
					EndIf
				Else
					RegDelete("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", 'Desktop_Locker_456')
					RegRead("HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run", 'Desktop_Locker_456')
					If @Error Then
						MsgBox(0, $LngMs2, $LngMs5)
					Else
						MsgBox(0, $LngErr, $LngMs6)
						GUICtrlSetState($Registry, $GUI_CHECKED)
					EndIf
				EndIf
			Case $CreateLnk ; создание ярлыка
				$Password = GUICtrlRead($Inp0)
				If $Password = '' Then
					_ColorError($Inp0)
					GUICtrlSetState($Inp0, $GUI_FOCUS)
					ContinueLoop
				EndIf
				
				$aSet[3] = GUICtrlRead($Delay)
				$aSet[4] = GUICtrlRead($MsBloc)
				$aSet[5]=255-GUICtrlRead($slider1)
				$Initext=$aSet[1]&'|'&$aSet[2]&'|'&$aSet[3]&'|'&$aSet[4]&'|'&$aSet[5]
				
				$bEncrypted = _StringEncrypt(1, $Password, $Password)&'J'&_StringEncrypt(1, $Initext, 'dk3wo6e9ru')
				Switch GUICtrlRead($LinkCombo)
					Case $LngDsc
						$PathLnk=@DesktopDir & "\Desktop_Locker.lnk"
					Case $LngQLn
						$PathLnk=@AppDataDir&'\Microsoft\Internet Explorer\Quick Launch\Desktop_Locker.lnk'
					Case $LngMPr
						$PathLnk=@ProgramsDir & "\Desktop_Locker.lnk"
				EndSwitch
				FileCreateShortcut(@ScriptDir & "\Desktop_Locker.exe", $PathLnk, @ScriptDir, $bEncrypted, $LngSTp, @ScriptDir & "\Desktop_Locker.exe")
			Case $MsBloc, $Delay
				GUICtrlSetState($Inp0, $GUI_FOCUS)
			Case $OK ; Заблокировать рабочий стол
				$Password = GUICtrlRead($Inp0)
				If $Password = '' Then
					_ColorError($Inp0)
					GUICtrlSetState($Inp0, $GUI_FOCUS)
					ContinueLoop
				EndIf
				$Password=_StringEncrypt(1, $Password, $Password)
				$aSet[3] = GUICtrlRead($Delay)
				$aSet[4] = GUICtrlRead($MsBloc)
				$aSet[5]=255-GUICtrlRead($slider1)
				$Initext1=$aSet[1]&'|'&$aSet[2]&'|'&$aSet[3]&'|'&$aSet[4]&'|'&$aSet[5]
				If $Initext1<>$Initext Then _FileW($Initext1)
				GUIDelete($Gui1)
				ExitLoop
			Case $ShtDwn
				If GUICtrlRead($ShtDwn)=$GUI_CHECKED Then
					$stt=$GUI_ENABLE
					$aSet[2]=$GUI_CHECKED
				Else
					$stt=$GUI_DISABLE
					$aSet[2]=$GUI_UNCHECKED
				EndIf
				GUICtrlSetState($Delay, $stt)
				GUICtrlSetState($DelayL, $stt)
				GUICtrlSetState($Inp0, $GUI_FOCUS)
			Case $ChPsHd
				If GUICtrlRead($ChPsHd)=$GUI_CHECKED Then
					GUICtrlSetData($Inp2,GUICtrlRead($Inp1))
					GUICtrlSetState($Inp2, $GUI_SHOW)
					GUICtrlSetState($Inp1, $GUI_HIDE)
					$Inp0=$Inp2
					$aSet[1]=$GUI_CHECKED
				Else
					GUICtrlSetData($Inp1,GUICtrlRead($Inp2))
					GUICtrlSetState($Inp1, $GUI_SHOW)
					GUICtrlSetState($Inp2, $GUI_HIDE)
					$Inp0=$Inp1
					$aSet[1]=$GUI_UNCHECKED
				EndIf
				GUICtrlSetState($Inp0, $GUI_FOCUS)
			Case $About
			   _About()
			Case -3
				Exit
		EndSwitch
	WEnd
	Return $Password
EndFunc

GUIRegisterMsg(0x0114 , "WM_HSCROLL")

If $CmdLine[0]>0 Then
	$aTmp =  StringSplit($CmdLine[1], 'J')
	If @error Or $aTmp[0]<>2 Then
		MsgBox(0, $LngErr, $LngErr)
		Exit
	EndIf
	$Password =  $aTmp[1]
	$bEncrypted = _StringEncrypt(0, $aTmp[2], 'dk3wo6e9ru')
	$aSet =  StringSplit($bEncrypted, '|')
	If $aSet[0]<>5 Then
		$Initext='1|0|0|1|255'
		$aSet = StringSplit($Initext, '|')
	EndIf
Else
	$Password = _MsgFile()
EndIf

HotKeySet('{ENTER}', '_Enter')

$GuiLocked = GUICreate($LngTitle, $DW, $DH, 0, 0, $WS_POPUP, $WS_EX_TOPMOST)
GUISetBkColor (0x0)

GUICtrlCreateIcon ("shell32.dll", 48, $DW / 2 - 16, $DH / 2-190, 48, 48)

GUISetFont(12, 800)
$WrongPw = GUICtrlCreateLabel("", $DW / 2+155, $DH / 2 - 115, 30, 20)
GUICtrlSetColor(-1, 0xFF0000)
GUICtrlSetBkColor(-1, 0)

$LangKB = GUICtrlCreateLabel("", $DW / 2+195, $DH / 2 - 115, 50, 20)
GUICtrlSetColor(-1, 0x00FF00)
GUICtrlSetBkColor(-1, 0)
GUICtrlSetData($LangKB, GetLang())

GUICtrlCreateLabel($LngTitle, $DW / 2 - 150, $DH / 2 - 105, 300, 50, $ES_CENTER)
GUICtrlSetFont(-1, 30, 800)
_Color(-1)

GUICtrlCreateLabel($LngErPw2, $DW / 2 - 230, $DH / 2 - 50, 460, 40, $ES_CENTER)
_Color(-1)

$InputPw = GUICtrlCreateInput("", $DW / 2 - 100, $DH / 2 , 200, 20, BitOR($ES_CENTER, $ES_PASSWORD), 0)
_Color(-1)
GUICtrlSetFont(-1, 12, 800, 0, "MS Sans Serif")
GUICtrlSetState(-1, $GUI_FOCUS)

$ShtDw=GUICtrlCreateButton('1', $DW-200, $DH-100, 36, 32, 0x0040)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', 28, 1)
GUICtrlSetState(-1, $GUI_HIDE)
$ShtRe=GUICtrlCreateButton('1', $DW-140, $DH-97, 36, 26, 0x0040)
GUICtrlSetImage(-1, @SystemDir & '\shell32.dll', -113, 1)
GUICtrlSetState(-1, $GUI_HIDE)

If $aSet[2]=$GUI_CHECKED Then
	If $aSet[3]=0 Then
		_Button()
	Else
		AdlibRegister('_Delay', $aSet[3]*60000)
	EndIf
EndIf

WinSetState("[CLASS:Shell_TrayWnd]", "", @SW_HIDE)
WinSetTrans($GuiLocked, '', $aSet[5])
GUISetState(@SW_SHOW, $GuiLocked)
If $aSet[4] = 1 Then
	_MouseTrap($DW, $DH)
	GUISetCursor(16) 
EndIf

While 1
	Sleep(50)
	If Not WinActive($GuiLocked) Then
		If ProcessExists('taskmgr.exe') Then ProcessClose('taskmgr.exe')
		WinActivate($GuiLocked)
		If $aSet[4] = 1 Then _MouseTrap($DW, $DH)
	EndIf
	Switch GUIGetMsg()
		Case $ShtDw
		   Shutdown(1)
		Case $ShtRe
		   Shutdown(2)
	EndSwitch
WEnd

Func _ColorError($Inp0)
	For $i = 1 to 4
		GUICtrlSetBkColor ($Inp0, 0xff0000)
		Sleep(40)
		GUICtrlSetBkColor ($Inp0, -1 )
		Sleep(40)
	Next
EndFunc

Func _Enter()
	$tmp=GUICtrlRead($InputPw)
	If _StringEncrypt(0, $Password, $tmp) == $tmp Then
		WinSetState("[CLASS:Shell_TrayWnd]", "", @SW_SHOW)
		If $aSet[4] = 1 Then _MouseTrap()
		MouseMove($DW/2, $DH/2, 0)
		Exit
	Else
		$k+=1
		GUICtrlSetData($WrongPw, $k)
		GUICtrlSetData($InputPw, "")
		GUICtrlSetData($LangKB, GetLang())
		AdlibRegister('_Tip', 50)
	EndIf
EndFunc


Func GetLang()
	Local $h, $str
	; GetActiveKeyboardLayout(WinGetHandle(''))
	$h=GetActiveKeyboardLayout($GuiLocked)
	$str='0436=Af|041C=Sq|3801=Ar-Ae|3C01=Ar-Bh|1401=Ar-Dz|0C01=Ar-Eg|0801=Ar-Iq|2C01=Ar-Jo|3401=Ar-Kw|3001=Ar-Lb|1001=Ar-Ly|1801=Ar-Ma|2001=Ar-Om|4001=Ar-Qa|0401=Ar-Sa|2801=Ar-Sy|1C01=Ar-Tn|2401=Ar-Ye|042B=Hy|042C=Az-Az|082C=Az-Az|042D=Eu|0423=Be|0402=Bg|0403=Ca|0804=Zh-Cn|0C04=Zh-Hk|1404=Zh-Mo|1004=Zh-Sg|0404=Zh-Tw|041A=Hr|0405=Cs|0406=Da|0413=Nl-Nl|0813=Nl-Be|0C09=En-Au|2809=En-Bz|1009=En-Ca|2409=En-Cb|1809=En-Ie|2009=En-Jm|1409=En-Nz|3409=En-Ph|1C09=En-Za|2C09=En-Tt|0809=En-Gb|0409=En|0425=Et|0429=Fa|040B=Fi|0438=Fo|040C=Fr-Fr|080C=Fr-Be|0C0C=Fr-Ca|140C=Fr-Lu|100C=Fr-Ch|083C=Gd-Ie|043C=Gd|0407=De-De|0C07=De-At|1407=De-Li|1007=De-Lu|0807=De-Ch|0408=El|040D=He|0439=Hi|040E=Hu|040F=Is|0421=Id|0410=It-It|0810=It-Ch|0411=Ja|0412=Ko|0426=Lv|0427=Lt|042F=Mk|043E=Ms-My|083E=Ms-Bn|043A=Mt|044E=Mr|0414=No-No|0814=No-No|0415=Pl|0816=Pt-Pt|0416=Pt-Br|0417=Rm|0418=Ro|0818=Ro-Mo|0419=Ru|0819=Ru-Mo|044F=Sa|0C1A=Sr-Sp|081A=Sr-Sp|0432=Tn|0424=Sl|041B=Sk|042E=Sb|040A=Es-Es|2C0A=Es-Ar|400A=Es-Bo|340A=Es-Cl|240A=Es-Co|140A=Es-Cr|1C0A=Es-Do|300A=Es-Ec|100A=Es-Gt|480A=Es-Hn|080A=Es-Mx|4C0A=Es-Ni|180A=Es-Pa|280A=Es-Pe|500A=Es-Pr|3C0A=Es-Py|440A=Es-Sv|380A=Es-Uy|200A=Es-Ve|0430=St|0441=Sw|041D=Sv-Se|081D=Sv-Fi|0449=Ta|0444=Tt|041E=Th|041F=Tr|0431=Ts|0422=Uk|0420=Ur|0843=Uz-Uz|0443=Uz-Uz|042A=Vi|0434=Xh|043D=Yi|0435=Zu'
	$h=StringRegExp($str, $h&'=(.*?)\|', 3)
	If Not @error Then
		Return $h[0]
	Else
		Return ''
	EndIf
EndFunc

Func _Delay()
    AdlibUnRegister('_Delay')
	_Button()
EndFunc

Func _Button()
	GUICtrlSetState($ShtDw, $GUI_SHOW)
	GUICtrlSetState($ShtRe, $GUI_SHOW)
EndFunc

Func _Color($i)
	GUICtrlSetColor($i, 0xFFFFFF)
	GUICtrlSetBkColor($i, 0)
EndFunc

Func _Tip()
    AdlibUnRegister('_Tip')
	ToolTip($LngErPw1, $DW/2, $DH/2+20, "", 3, 3)
	Sleep(2000)
	ToolTip("")
EndFunc

; UDF GuiEdit.au3 + Misc.au3

Func _MouseTrap($iLeft = 0, $iTop = 0, $iRight = 0, $iBottom = 0)
	Local $aResult
	If @NumParams == 0 Then
		$aResult = DllCall("user32.dll", "bool", "ClipCursor", "ptr", 0)
		If @error Or Not $aResult[0] Then Return SetError(1, _WinAPI_GetLastError(), False)
	Else
		If @NumParams == 2 Then
			$iRight = $iLeft + 1
			$iBottom = $iTop + 1
		EndIf
		Local $tRect = DllStructCreate($tagRECT)
		DllStructSetData($tRect, "Left", $iLeft)
		DllStructSetData($tRect, "Top", $iTop)
		DllStructSetData($tRect, "Right", $iRight)
		DllStructSetData($tRect, "Bottom", $iBottom)
		$aResult = DllCall("user32.dll", "bool", "ClipCursor", "ptr", DllStructGetPtr($tRect))
		If @error Or Not $aResult[0] Then Return SetError(2, _WinAPI_GetLastError(), False)
	EndIf
	Return True
EndFunc   ;==>_MouseTrap

Func _WinAPI_GetLastError($curErr = @error, $curExt = @extended)
	Local $aResult = DllCall("kernel32.dll", "dword", "GetLastError")
	Return SetError($curErr, $curExt, $aResult[0])
EndFunc   ;==>_WinAPI_GetLastError

Func WM_HSCROLL($hWnd, $Msg, $wParam, $lParam)
	#forceref $Msg, $wParam, $lParam
	Local $nScrollCode = BitAND($wParam, 0x0000FFFF)
	$aSet[5] = 255-BitShift($wParam, 16)
	If $nScrollCode = 5 Then
		WinSetTrans($Gui1,"",$aSet[5])
		GUICtrlSetData($ValSld, 255-$aSet[5])
	EndIf
	Return 'GUI_RUNDEFMSG'
EndFunc

; #FUNCTION# ====================================================================================================================
; Name...........: GetActiveKeyboardLayout() Function
; Description ...: Get Active keyboard layout

; Author ........: Fredj A. Jad (DCCD)
; MSDN  .........: GetWindowThreadProcessId Function  ,http://msdn.microsoft.com/en-us/library/ms633522(VS.85).aspx
; MSDN  .........: GetKeyboardLayout Function         ,http://msdn.microsoft.com/en-us/library/ms646296(VS.85).aspx
; ===============================================================================================================================
Func GetActiveKeyboardLayout($hWnd)
    Local $aRet = DllCall('user32.dll', 'long', 'GetWindowThreadProcessId', 'hwnd', $hWnd, 'ptr', 0)
    $aRet = DllCall('user32.dll', 'long', 'GetKeyboardLayout', 'long', $aRet[0])
    ; Return '0000' & Hex($aRet[0], 4)
    Return Hex($aRet[0], 4) ; поправил для себя
EndFunc   ;==>GetActiveKeyboardLayout

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
	Local $GP=_ChildCoor($Gui1, 210, 180)
	GUISetState(@SW_DISABLE, $Gui1)
	Local $font="Arial", $msg
    Local $Gui2 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], 0x00C00000+0x00080000, -1, $Gui1) ; WS_CAPTION+WS_SYSMENU
	GUISetBkColor (0xffca48)
	GUICtrlCreateLabel($LngTitle, 0, 0, 210, 63, 0x01+0x0200)
	GUICtrlSetFont (-1,14, 600, -1, $font)
	GUICtrlSetColor(-1,0xa13d00)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,64,208,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.2   8.05.2011', 15, 100, 210, 17)
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
	GUISetState(@SW_SHOW, $Gui2)
	While 1
	  $msg = GUIGetMsg()
	  Select
		Case $msg = $url
			ShellExecute ('http://azjio.ucoz.ru')
		Case $msg = $WbMn
			ClipPut('R939163939152')
		Case $msg = -3
			GUISetState(@SW_ENABLE, $Gui1)
			GUIDelete($Gui2)
			ExitLoop
		EndSelect
    WEnd
EndFunc