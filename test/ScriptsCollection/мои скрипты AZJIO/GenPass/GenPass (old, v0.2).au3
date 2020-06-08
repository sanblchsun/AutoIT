#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=GenPass.exe
#AutoIt3Wrapper_icon=GenPass.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=GenPass.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Field=Version|0.1
#AutoIt3Wrapper_Res_Field=Build|2011.12.2
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

; AZJIO 2.12.2011 (AutoIt3_v3.3.6.1)

#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <String.au3>
#include <WinAPI.au3>
#include <StaticConstants.au3>
; #include <Misc.au3>

; En
$LngTitle='Password generator'
$LngAbout='About'
$LngVer='Version'
$LngSite='Site'
$LngCopy='Copy'
$LngEnPs='Will Enter key phrase'
$LngOut='Result'
$LngCopy='Copy'
$LngLm='Limit the number of characters'
$LngSmb='Symbols'
$LngSmbH='Will Enter symbols using in password'
$LngNoRe='without repeat'
$LngDef='Default'
$LngDefH='Options by default'
$LngChB='Hide password'
$LngIns='Insert'
$LngInsH='Insert in active window'&@CRLF&'Enter'
$LngCopyH='Copy password'&@CRLF&'Ctrl+Space'

$UserIntLang=DllCall('kernel32.dll', 'int', 'GetUserDefaultUILanguage')
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	; $LngTitle='Генератор пароля по ключевой фразе'
	$LngAbout='О программе'
	$LngVer='Версия'
	$LngCopy='Копировать'
	$LngSite='Сайт'
	$LngEnPs='Введите ключевую фразу'
	$LngOut='Результат'
	$LngCopy='Копировать'
	$LngLm='Лимит количества символов'
	$LngSmb='Символы'
	$LngSmbH='Введите символы использующиеся в пароле'
	$LngNoRe='без повторов'
	$LngDef='Сброс'
	$LngDefH='Восстановить стандартные настройки'
	$LngChB='Скрыть пароль'
	$LngIns='Вставить'
	$LngInsH='Вставить в активное окно'&@CRLF&'Enter'
	$LngCopyH='Копировать пароль'&@CRLF&'Ctrl+Пробел'
	; $Lng=''
EndIf
$LngEnPs='<'&$LngEnPs&'>'

#NoTrayIcon

$smb0='0123456789qwertyuiopasdfghjklzxcvbnm' ; -_~@%#$& символы участвующие в пароле /// characters involved in the password
$smb=$smb0
Global $limit0=8, $ini=@ScriptDir&'\GenPass.ini', $aSmb
$LenDef=StringLen($LngEnPs)

If Not FileExists($ini) Then
	$file = FileOpen($ini, 2)
	FileWrite($file, '[Set]' & @CRLF & _
			'Symbols='&$smb & @CRLF & _
			'delre=2' & @CRLF & _
			'Hide=0' & @CRLF & _
			'Limit=8')
	FileClose($file)
EndIf

Func _Exit()
	IniWrite($ini, 'Set', 'Symbols', $smb)
	IniWrite($ini, 'Set', 'Hide', $Hide)
	IniWrite($ini, 'Set', 'delre', GUICtrlRead($delre))
	IniWrite($ini, 'Set', 'Limit', GUICtrlRead($Limit))
EndFunc

$smb=IniRead($Ini, 'Set', 'Symbols', $smb)
_DelRe($smb)
$delre0=Number(IniRead($Ini, 'Set', 'delre', 2))
If $delre0>2 Or $limit0<0 Then $limit0=2
$limit0=Number(IniRead($Ini, 'Set', 'Limit', $limit0))
If $limit0>30 Or $limit0<1 Then $limit0=8
$Hide=Number(IniRead($Ini, 'Set', 'Hide', 0))

$aSmb=StringSplit($smb, '')

$Gui = GUICreate($LngTitle, 450, 120, -1, -1, -1, $WS_EX_ACCEPTFILES)
If Not @compiled Then GUISetIcon(@ScriptDir&'\GenPass.ico')

$keyN = GUICtrlCreateInput($LngEnPs, 10, 5, 430, 22)
GUICtrlSetFont(-1, -1, -1, 2)
GUICtrlSetColor(-1, 0x999999)
$keyP=GUICtrlCreateInput($LngEnPs, 10, 5, 430, 22, $ES_PASSWORD)
GUICtrlSetFont(-1, -1, -1, 2)
GUICtrlSetColor(-1, 0x999999)

$outN = GUICtrlCreateInput($LngOut, 10, 30, 340, 22)
GUICtrlSetFont(-1, -1, -1, 2)
GUICtrlSetColor(-1, 0x999999)
$outP = GUICtrlCreateInput($LngOut, 10, 30, 340, 22, $ES_PASSWORD)
GUICtrlSetFont(-1, -1, -1, 2)
GUICtrlSetColor(-1, 0x999999)

$ChPsHd=GUICtrlCreateCheckbox($LngChB, 120, 90, 100, 15)
If $Hide = 1 Then
	GUICtrlSetState($keyP, $GUI_FOCUS)
	GUICtrlSetState($keyN, $GUI_HIDE)
	$key=$keyP
	GUICtrlSetState($outN, $GUI_HIDE)
	$out=$outP
	GUICtrlSetState($ChPsHd, $GUI_CHECKED)
Else
	GUICtrlSetState($keyN, $GUI_FOCUS)
	GUICtrlSetState($keyP, $GUI_HIDE)
	$key=$keyN
	GUICtrlSetState($outP, $GUI_HIDE)
	$out=$outN
	GUICtrlSetState($ChPsHd, $GUI_UNCHECKED)
EndIf



$limit = GUICtrlCreateInput($limit0, 370, 30, 40, 22)
$updown = GUICtrlCreateUpdown($limit)
GUICtrlSetLimit(-1, 30, 1)
$LimitCur=GUICtrlCreateLabel('0', 350, 30, 20, 22, $SS_CENTERIMAGE+$SS_CENTER)

$About = GUICtrlCreateButton('@', 417, 30, 22, 22)
GUICtrlSetTip(-1, $LngAbout)

GUICtrlCreateLabel($LngNoRe, 120, 64, 80, 17)
$delre = GUICtrlCreateCombo('', 200, 61, 40, 23, 0x3)
GUICtrlSetData(-1,'0|1|2', $delre0)

$symb = GUICtrlCreateButton($LngSmb, 20, 90, 80, 24)
$def = GUICtrlCreateButton($LngDef, 20, 60, 80, 24)
GUICtrlSetTip(-1, $LngDefH)
$Insert = GUICtrlCreateButton($LngIns, 260, 65, 80, 44)
GUICtrlSetTip(-1, $LngInsH)
$copy = GUICtrlCreateButton($LngCopy, 360, 65, 80, 44)
GUICtrlSetTip(-1, $LngCopyH)

Dim $AccelKeys[2][2]=[["{Enter}", $Insert], ["^{SPACE}", $copy]]
GUISetAccelerators($AccelKeys)

GUISetState ()
Send('{home}')
GUIRegisterMsg(0x0111, "WM_COMMAND")
OnAutoItExitRegister("_Exit")
While 1
	$msg = GUIGetMsg()
	Switch $msg
		Case $Insert
			$out0=GUICtrlRead($out)
			If $LngOut=$out0 Then ContinueLoop
			WinSetState($Gui,'',@SW_MINIMIZE)
			ClipPut($out0)
			Sleep(100)
			Send('+{INS}')
			WinSetState($Gui,'',@SW_RESTORE)
		Case $ChPsHd
			If GUICtrlRead($ChPsHd)=$GUI_CHECKED Then
				If GUICtrlRead($key)=$LngEnPs Then
					GUICtrlSetFont($keyP, -1, -1, 2)
					GUICtrlSetColor($keyP, 0x999999)
					GUICtrlSetFont($outP, -1, -1, 2)
					GUICtrlSetColor($outP, 0x999999)
				Else
					GUICtrlSetFont($keyP, -1, -1, 0)
					GUICtrlSetColor($keyP, Default)
					GUICtrlSetFont($outP, -1, -1, 0)
					GUICtrlSetColor($outP, Default)
				EndIf
				GUICtrlSetData($keyP,GUICtrlRead($keyN))
				GUICtrlSetState($keyP, $GUI_SHOW)
				GUICtrlSetState($keyN, $GUI_HIDE)
				GUICtrlSetData($outP,GUICtrlRead($outN))
				GUICtrlSetState($outP, $GUI_SHOW)
				GUICtrlSetState($outN, $GUI_HIDE)
				$key=$keyP
				$out=$outP
				$Hide=$GUI_CHECKED
			Else
				If GUICtrlRead($key)=$LngEnPs Then
					GUICtrlSetFont($keyN, -1, -1, 2)
					GUICtrlSetColor($keyN, 0x999999)
					GUICtrlSetFont($outN, -1, -1, 2)
					GUICtrlSetColor($outN, 0x999999)
				Else
					GUICtrlSetFont($keyN, -1, -1, 0)
					GUICtrlSetColor($keyN, Default)
					GUICtrlSetFont($outN, -1, -1, 0)
					GUICtrlSetColor($outN, Default)
				EndIf
				GUICtrlSetData($keyN,GUICtrlRead($keyP))
				GUICtrlSetState($keyN, $GUI_SHOW)
				GUICtrlSetState($keyP, $GUI_HIDE)
				GUICtrlSetData($outN,GUICtrlRead($outP))
				GUICtrlSetState($outN, $GUI_SHOW)
				GUICtrlSetState($outP, $GUI_HIDE)
				$key=$keyN
				$out=$outN
				$Hide=$GUI_UNCHECKED
			EndIf
			GUICtrlSetState($key, $GUI_FOCUS)
		Case $def
			GUICtrlSetData($limit, 8)
			GUICtrlSetData($delre, 2)
			$delre0=2
			$limit0=8
			$smb=$smb0
			$aSmb=StringSplit($smb, '')
			Update()
		Case $limit
			$limit0=Number(GUICtrlRead($limit))
			$out0=GUICtrlRead($out)
			If StringLen($out0)>$limit0 Then
				GUICtrlSetData($out, StringLeft($out0, $limit0))
				GUICtrlSetData($LimitCur, $limit0)
			Else
				Update()
			EndIf
		Case $delre
			$delre0=Number(GUICtrlRead($delre, 1))
			Update()
		Case $symb
			$gp=WinGetPos($Gui)
			$tmp=InputBox($LngSmb, $LngSmbH, $smb, '', $gp[2], $gp[3], $gp[0], $gp[1], 0, $Gui)
			If Not @error Then
				_DelRe($tmp)
				$smb=$tmp
				$aSmb=StringSplit($tmp, '')
				Update()
			EndIf
		Case $copy
			ClipPut(GUICtrlRead($out, 1))
		Case $About
			 _About()
		Case -3
			 Exit
	EndSwitch
WEnd

Func Update()
	If GUICtrlRead($key)<>$LngEnPs Then WM_COMMAND($Gui, 0, _WinAPI_MakeLong($key, $EN_CHANGE), 0)
EndFunc

Func WM_COMMAND($hWnd, $imsg, $iwParam, $ilParam)
    Local $nNotifyCode, $nID, $key0
    $nNotifyCode = BitShift($iwParam, 16)
    $nID = BitAND($iwParam, 0xFFFF)
	Switch $nID
		Case $key
			Switch $nNotifyCode
				; Case $EN_SETFOCUS
					; If GUICtrlRead($key)=$LngEnPs Then AdlibRegister('_SetCursor', 10)
				Case $EN_CHANGE
					$key0 = GUICtrlRead($key, 1)
					Switch $key0
						Case $LngEnPs
							GUICtrlSetFont($nID, -1, -1, 2)
							GUICtrlSetColor($nID, 0x999999)
							GUICtrlSetData($out, $LngOut)
							GUICtrlSetFont($out, -1, -1, 2)
							GUICtrlSetColor($out, 0x999999)
						Case ''
							GUICtrlSetData($nID, $LngEnPs)
							GUICtrlSetFont($nID, -1, -1, 2)
							GUICtrlSetColor($nID, 0x999999)
							GUICtrlSetData($out, $LngOut)
							GUICtrlSetFont($out, -1, -1, 2)
							GUICtrlSetColor($out, 0x999999)
							GUICtrlSetData($LimitCur, '0')
							Send('{home}')
						Case Else
							; если хоть один символ не подсказочной фразы, то начинаем ввод и рассчёт
							If StringRight($key0, $LenDef)=$LngEnPs Then
								$key0=StringTrimRight($key0, $LenDef)
								GUICtrlSetData($key, $key0)
							ElseIf StringLeft($key0, $LenDef)=$LngEnPs Then
								$key0=StringTrimLeft($key0, $LenDef)
								GUICtrlSetData($key, $key0)
							ElseIf StringLeft($key0, 1)='<' And StringRight($key0, 1)='>' Then
								$tmpK1 = StringSplit($LngEnPs, '')
								$tmpK2 = StringSplit($key0, '')
								For $i = 1 to $tmpK1[0]
									If $tmpK1[$i]<>$tmpK2[$i] Then
										; $key0=$tmpK2[$i]
										$key0=StringMid($key0, $i, $tmpK2[0]-$LenDef)
										GUICtrlSetData($key, $key0)
										ExitLoop
									EndIf
								Next
							EndIf
							
							; устанавливаем дефолтные цвета и шрифт ввода
							GUICtrlSetColor($nID, Default)
							GUICtrlSetColor($out, Default)
							GUICtrlSetFont($nID, -1, -1, 0)
							GUICtrlSetFont($out, -1, -1, 0)
							; верхний лимит фразы 128 символов
							If StringLen($key0)>128 Then
								GUICtrlSetData($out, $LngLm)
								Return $GUI_RUNDEFMSG
							EndIf
							; нижний лимит фразы 2 символа
							If StringLen($key0)<2 Then
								If $Hide = 1 Then
									GUICtrlSetData($out, '')
								Else
									GUICtrlSetData($out, 'Введите не менее 2-х символов')
								EndIf
								Return $GUI_RUNDEFMSG
							EndIf
							
							; делим фразу на 2 куска
							$tmp = Int(StringLen($key0)/2)
							$tmpK1 = StringLeft($key0, $tmp)
							$tmpK2 = StringMid($key0, $tmp+1)
							; раздельно конвертируем каждый кусок фразы
							$tmpK1 = StringSplit(_Conv($tmpK1), '')
							$tmpK2 = StringSplit(_Conv($tmpK2), '')
							$tmp=''
							; сливаем символы двух кусков в один пароль, буквы поочерёдно
							If $tmpK2[0]>$tmpK1[0] Then
								For $i = 1 to $tmpK1[0]
									$tmp&=$tmpK1[$i]&$tmpK2[$i]
								Next
								$tmp&=$tmpK2[$tmpK2[0]]
							ElseIf $tmpK1[0]>$tmpK2[0] Then
								For $i = 1 to $tmpK2[0]
									$tmp&=$tmpK1[$i]&$tmpK2[$i]
								Next
								$tmp&=$tmpK1[$tmpK1[0]]
							Else
								For $i = 1 to $tmpK1[0]
									$tmp&=$tmpK1[$i]&$tmpK2[$i]
								Next
							EndIf
							If $delre0 Then
								$tmp=StringRegExpReplace($tmp,'(.)\1+','\1') ; удаляем слитный повтор
								If $delre0 = 2 Then _DelRe($tmp) ; удаляем любой повтор
							EndIf
							; $tmp=StringRegExpReplace(_Num_to_Txt($tmp), '^(.*?)(a{2,})$', '\1')
							
							; обрезаем пароль по лимиту
							If StringLen($tmp)>$limit0 Then
								$tmp=StringLeft($tmp, $limit0)
							EndIf
							GUICtrlSetData($out, $tmp)
							GUICtrlSetData($LimitCur, StringLen($tmp))
							; If StringInStr($tmp, '+') Then
								; GUICtrlSetData($out, $tmp)
							; Else
								;~ GUICtrlSetData($out, $tmp)
								; GUICtrlSetData($out, _Num_to_Txt($tmp))
							; EndIf
					EndSwitch
			EndSwitch
	EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

; попытка автоустановки курсора в начало фразы когда в фокусе
; Func _SetCursor()
	; $dll = DllOpen("user32.dll")
	; While _IsPressed("01", $dll)
		; Sleep(50)
	; WEnd
	; DllClose($dll)
	; Send('{home}')
	; AdlibUnRegister('_SetCursor')
; EndFunc

; удаление любого повтора
Func _DelRe(ByRef $tmp)
	Local $i, $data=StringSplit($tmp, '')
	If Not @error Then
		$tmp=''
		For $i = 1 To $data[0]
			If IsDeclared('/'&$data[$i]) <> -1 Then
				$tmp&=$data[$i]
				Assign('/'&$data[$i], '', 1)
			EndIf
		Next
		$k=0
		While 1
			$se=StringInStr($tmp, '[', 0, 2) ; индивидуальное удаление для символа [, который не воспринимается в Assign
			If $se Then
				$tmp=StringLeft($tmp, $se-1)&StringTrimLeft($tmp, $se)
			Else
				ExitLoop
			EndIf
			$k+=1
			If $k > 30 Then ExitLoop ; защита от зацикливания при непредвиденных ошибках
		WEnd
	Else
		$tmp=''
	EndIf
EndFunc

; конвертируем фразу в пароль
Func _Conv($k)
	; GUICtrlSetData($out, _StringEncrypt(1, $k, $k, 1))
	$tmp = _HexToDec(_StringEncrypt(1, $k, $k, 1))
	$posE = StringInStr($tmp, 'e')
	; при наличии мантисы и экспоненты избавляемся обрезкой и делением на 10  в 14 степени избавляясь от дроби
	If $posE  Then $tmp /= 10^(Number(StringTrimLeft($tmp, $posE+1))-14)
	$tmpTXT = _Num_to_Txt($tmp) ; конвертируем число в текст, вернее в разрядность набора символов
	$tmp = _Upper($tmpTXT, $tmp) ;переводим в верхний регистр буквы в позициях указаных в цифрах числа
	Return $tmp
EndFunc

Func _Upper($tmpTXT, $tmp)
	$a=StringSplit($tmpTXT, '')
	$n=StringSplit($tmp, '')
	$am=Int(StringLen(StringRegExpReplace($tmpTXT, '[^a-z]+', ''))/2) ; половина количества букв
	$k=0
	For $i = 1 to $n[0]
		If $n[$i]<=$a[0] And StringIsAlpha($a[$n[$i]]) Then
			$a[$n[$i]]=StringUpper($a[$n[$i]])
			$k+=1
			If $k >= $am Then ExitLoop ; закончили, если сделана половина замен
		EndIf
	Next
	$tmpTXT=''
	For $i = 1 to $a[0]
		$tmpTXT&=$a[$i]
	Next
	; MsgBox(0, 'Сообщение', $tmpTXT &@CRLF&$tmp  &@CRLF&$am)
	Return $tmpTXT
EndFunc

; конвертируем число в текст, вернее в разрядность набора символов
Func _Num_to_Txt($num)
	Local $text='', $ost
	While 1
		$ost=Mod($num, $aSmb[0])
		$num=($num-$ost)/$aSmb[0]
		$text=$aSmb[$ost+1]&$text
		If $num=0 Then ExitLoop
	WEnd
	Return $text
EndFunc

; конвертируем шестнадцатеричное в десятиричное
Func _HexToDec($H)
	Local $out = 0, $i, $aH = StringSplit(StringUpper($H), '')
	For $i = 1 to $aH[0]
		Switch $aH[$i]
			Case 'A'
				$aH[$i] = 10
			Case 'B'
				$aH[$i] = 11
			Case 'C'
				$aH[$i] = 12
			Case 'D'
				$aH[$i] = 13
			Case 'E'
				$aH[$i] = 14
			Case 'F'
				$aH[$i] = 15
		EndSwitch
		$out +=  $aH[$i] * 16 ^ ($aH[0] - $i)
	Next
	Return $out
EndFunc

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
	$GP=_ChildCoor($Gui, 220, 180)
	GUISetState(@SW_DISABLE, $Gui)
	$font="Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], $WS_CAPTION+$WS_SYSMENU, -1, $Gui)
	If Not @compiled Then GUISetIcon(@ScriptDir&'\GenPass.ico')
	GUISetBkColor (0xE1E3E7)
	GUICtrlCreateLabel($LngTitle, 0, 0, 220, 63, 0x01+0x0200)
	GUICtrlSetFont (-1,14, 600, -1, $font)
	GUICtrlSetColor(-1,0x3a6a7e)
	GUICtrlSetBkColor (-1, 0xF1F1EF)
	GUICtrlCreateLabel ("-", 2,64,220-2,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.2   2.12.2011', 15, 100, 220, 17)
	GUICtrlCreateLabel($LngSite&':', 15, 115, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', 52, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 15, 130, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', 90, 130, 125, 17)
	GUICtrlSetColor(-1,0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010-2011', 15, 145, 220, 17)
	GUISetState(@SW_SHOW, $Gui1)

	While 1
	  Switch GUIGetMsg()
		Case $url
			ShellExecute ('http://azjio.ucoz.ru')
		Case $WbMn
			ClipPut('R939163939152')
		Case -3
			GUISetState(@SW_ENABLE, $Gui)
			GUIDelete($Gui1)
			ExitLoop
		EndSwitch
    WEnd
EndFunc