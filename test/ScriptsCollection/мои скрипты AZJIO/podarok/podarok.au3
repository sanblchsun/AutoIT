#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=podarok.exe
#AutoIt3Wrapper_icon=podarok.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=podarok.exe
#AutoIt3Wrapper_Res_Fileversion=0.0.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AutoIt3
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

Opt('TrayIconHide', 1)
#include <File.au3>
#include <GDIPlus.au3>
#include <WindowsConstants.au3>


If $CmdLine[0]>0 Then
	Global $aDate[2]=[8,3]
	If $CmdLine[0]>1 Then
		$aDate=StringRegExp($CmdLine[2], '^/(\d{1,2})\.(\d{1,2})(\.\d{1,2}:\d{1,2})*$', 3)
		If @error Then Dim $aDate[2]=[8,3]
	EndIf

	$Run='HKCU\Software\Microsoft\Windows\CurrentVersion\Run'
	$RunTr='HKCU\Software\podarok_AutoIt3'
	$RunVal='"'&@ScriptFullPath&'" /s /'&$aDate[0]&'.'&$aDate[1]

; En
$LngMsg='Added Startup'&@CRLF&'Month: '&$aDate[1]&', day: '&$aDate[0]
$LngMsg2= 'Key already exists'&@CRLF&'Overwrite the force?'
$LngMsg3= 'Message'
$LngTm= 'Time'
$LngMsgD= 'The key is missing,'&@CRLF&'the removal is not required'
$LngMsgDS= 'The key is removed'
$LngHlp= 'Supported keys: '& @CRLF&'/a - add startup. By default, March 8, but if needed for another holiday, please specify the date, eg /a /25.2'& @CRLF&'During the holiday starts each time the computer boots, the next day is automatically removed of startup'&@CRLF&'/а /25.2.12:45 - Same as previous, but with the addition of time (hours: minutes).  Note that the translation does not affect hours, the script expects the period of time as the difference between the time of booting the computer and a specified time.  And also after this time (the difference is less than zero), the script will be executed every time the computer boots up.'&@CRLF&'/b - usual Startup'& @CRLF&'/d - the forced removal of startup'& @CRLF& '/s - the system key, which the program uses to startup'

$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang=DllCall ( $Lang_dll, "int", "GetUserDefaultUILanguage" )
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)
DllClose($Lang_dll)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	$LngMsg='Добавлено в автозагрузку'&@CRLF&'для указанной даты, месяц: '&$aDate[1]&', день: '&$aDate[0]
	$LngMsg2= 'Ключ уже существует'&@CRLF&'Перезаписать принудительно?'
	$LngMsg3= 'Сообщение'
	$LngTm= 'время'
	$LngMsgD= 'Ключ отсутствует'&@CRLF&'удаление не требуется'
	$LngMsgDS= 'Ключ удалён'
	$LngHlp= 'Поддерживаются ключи:'&@CRLF&'/a - регистрация в автозагрузке. По умолчанию для 8 марта, но если нужно для другого праздника, то укажите дату, например /а /25.2'&@CRLF&'В течении праздника подарок запускается при каждой загрузке компьютера, на следующий день автоматически удаляется из автозагрузки'&@CRLF&'/а /25.2.12:45 - тоже что предыдущее, но с добавлением времени (часы:минуты). Учтите что перевод часов не влияет, скрипт ожидает промежуток времени в виде разницы между временем загрузки компьютера и указанным временем. А также после указанного времени (разница меньше нуля) скрипт будет выполнятся сразу при загрузке компьютера.'&@CRLF&'/b - автозагрузка без учёта даты (на постоянно)'&@CRLF&'/d - принудительное удаление регистрации в автозагрузке'&@CRLF&'/s - системный ключ, который программа использует для автозагрузки'
EndIf

	$scsf=0
	If UBound($aDate)=3 Then
		$aTime=StringRegExp($aDate[2], '^\.(\d{1,2}):(\d{1,2})$', 3)
		If Not @error Then
			$difference=(($aTime[0]-Execute(@HOUR))*60+$aTime[1]-Execute(@MIN))*60000
			$scsf=1
			$LngMsg&=', '&$LngTm&' - '&$aTime[0]&':'&$aTime[1]
			$RunVal&='.'&$aTime[0]&':'&$aTime[1]
		EndIf
	EndIf

	Switch $CmdLine[1]
		Case '/a'
			RegRead($Run, @ScriptName)
			If @Error Then
				RegWrite($Run, @ScriptName, 'REG_SZ', $RunVal)
				RegWrite($RunTr, @ScriptName, 'REG_SZ', '0')
				MsgBox(0, $LngMsg3, $LngMsg)
			Else
				If MsgBox(4, $LngMsg3, $LngMsg2)=6 Then
					RegWrite($Run, @ScriptName, 'REG_SZ', $RunVal)
					RegWrite($RunTr, @ScriptName, 'REG_SZ', '0')
					MsgBox(0, $LngMsg3, $LngMsg)
				EndIf
			EndIf
			Exit

		Case '/b'
			RegRead($Run, @ScriptName)
			If @Error Then
				RegWrite($Run, @ScriptName, 'REG_SZ', '"'&@ScriptFullPath&'"')
				MsgBox(0, $LngMsg3, $LngMsg)
			Else
				If MsgBox(4, $LngMsg3, $LngMsg2)=6 Then
					RegWrite($Run, @ScriptName, 'REG_SZ', '"'&@ScriptFullPath&'"')
					MsgBox(0, $LngMsg3, $LngMsg)
				EndIf
			EndIf
			Exit

		Case '/d'
			RegRead($Run, @ScriptName)
			If @Error Then
				MsgBox(0, $LngMsg3, $LngMsgD)
			Else
				RegDelete($Run, @ScriptName)
				RegDelete($RunTr, @ScriptName)
				MsgBox(0, $LngMsg3, $LngMsgDS)
			EndIf
			Exit
			
		Case '/s'
			If $CmdLine[0]<2 Then
				; MsgBox(0, $LngMsg3, 'Системный ключ')
				Exit
			EndIf
			If Execute(@MON)=$aDate[1] And Execute(@MDAY)=$aDate[0] Then
				If RegRead($RunTr, @ScriptName)='0' Then RegWrite($RunTr, @ScriptName, 'REG_SZ', '1')
			Else
				If RegRead($RunTr, @ScriptName)='1' Then
					RegDelete($Run, @ScriptName)
					RegDelete($RunTr, @ScriptName)
				EndIf
				Exit
			EndIf
			
		Case Else; Or '/?' Or '/h' Or '/help'
			MsgBox(0, $LngMsg3, $LngHlp)
			Exit
	EndSwitch

	If $scsf And $difference>0 Then Sleep($difference) ; ожидание времени, равное разнице между началом загрузки и указанным временем

EndIf

DirCreate(@TempDir&'\podarok')
FileInstall("1.png", @TempDir&'\podarok\1.png')
FileInstall("2.png", @TempDir&'\podarok\2.png')
FileInstall("3.png", @TempDir&'\podarok\3.png')
FileInstall("4.png", @TempDir&'\podarok\4.png')
FileInstall("5.png", @TempDir&'\podarok\5.png')
FileInstall("6.png", @TempDir&'\podarok\6.png')
FileInstall("7.png", @TempDir&'\podarok\7.png')
FileInstall("8.png", @TempDir&'\podarok\8.png')
FileInstall("9.png", @TempDir&'\podarok\9.png')
FileInstall("10.png", @TempDir&'\podarok\10.png')
FileInstall("11.png", @TempDir&'\podarok\11.png')
FileInstall("12.png", @TempDir&'\podarok\12.png')
FileInstall("13.png", @TempDir&'\podarok\13.png')
FileInstall("14.png", @TempDir&'\podarok\14.png')
FileInstall("15.png", @TempDir&'\podarok\15.png')
FileInstall("16.png", @TempDir&'\podarok\16.png')
FileInstall("17.png", @TempDir&'\podarok\17.png')
FileInstall("18.png", @TempDir&'\podarok\18.png')
FileInstall("19.png", @TempDir&'\podarok\19.png')
FileInstall("20.png", @TempDir&'\podarok\20.png')
FileInstall("21.png", @TempDir&'\podarok\21.png')
FileInstall("22.png", @TempDir&'\podarok\22.png')
FileInstall("23.png", @TempDir&'\podarok\23.png')
FileInstall("24.png", @TempDir&'\podarok\24.png')
FileInstall("25.png", @TempDir&'\podarok\25.png')
FileInstall("26.png", @TempDir&'\podarok\26.png')
FileInstall("27.png", @TempDir&'\podarok\27.png')
FileInstall("28.png", @TempDir&'\podarok\28.png')
FileInstall("29.png", @TempDir&'\podarok\29.png')
FileInstall("30.png", @TempDir&'\podarok\30.png')
FileInstall("31.png", @TempDir&'\podarok\31.png')
FileInstall("32.png", @TempDir&'\podarok\32.png')
FileInstall("33.png", @TempDir&'\podarok\33.png')
FileInstall("34.png", @TempDir&'\podarok\34.png')
FileInstall("35.png", @TempDir&'\podarok\35.png')
FileInstall("36.png", @TempDir&'\podarok\36.png')
FileInstall("37.png", @TempDir&'\podarok\37.png')
FileInstall("38.png", @TempDir&'\podarok\38.png')
FileInstall("39.png", @TempDir&'\podarok\39.png')
FileInstall("40.png", @TempDir&'\podarok\40.png')
FileInstall("41.png", @TempDir&'\podarok\41.png')

HotKeySet('{ESC}', '_Quit')
Func _Quit()
	Exit
EndFunc

;Mouse
GUIRegisterMsg(0x0202, "_Quit")
GUIRegisterMsg(0x0205, "_Quit")

If @compiled Then
	$Path=@TempDir&'\podarok'
Else
	$Path=@ScriptDir
EndIf

$aPic= _FileListToArray($Path, '*.png', 1)
If @error Then _Quit()

Opt('TrayIconHide', 0)

For $i= 1 To 150
    $Width=Random(0, @DesktopWidth-100, 1)
    $Height=Random(0, @DesktopHeight-100, 1)
    $NImage=Random(1, $aPic[0], 1)
    image($Width, $Height, $Path&'\'&$aPic[$NImage])
next
Sleep(10000)


;где размещено gui окно на робочем столе, там будет и рисунок
Func image($Left, $Top, $Picture)
$yGUI = GUICreate("", 100, 100, $Left, $Top, $WS_POPUP , $WS_EX_LAYERED + $WS_EX_TOOLWINDOW+$WS_EX_TOPMOST)
_GDIPlus_Startup()
$yImage = _GDIPlus_ImageLoadFromFile($picture)

$iOpacity=255
 For $i = 0 To $iOpacity Step 10
    SetBitmap($yGUI, $yImage, 255)
    Sleep(10)
Next
GUISetState(@SW_SHOW,$yGUI)
EndFunc

Func SetBitmap($hGUI, $hImage, $iOpacity)
Local $hScrDC, $hMemDC, $hBitmap, $hOld, $pSize, $tSize, $pSource, $tSource, $pBlend, $tBlend

$hScrDC = _WinAPI_GetDC(0)
$hMemDC = _WinAPI_CreateCompatibleDC($hScrDC)
$hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
$hOld = _WinAPI_SelectObject($hMemDC, $hBitmap)
$tSize = DllStructCreate($tagSIZE)
$pSize = DllStructGetPtr($tSize )
DllStructSetData($tSize, "X", _GDIPlus_ImageGetWidth($hImage))
DllStructSetData($tSize, "Y", _GDIPlus_ImageGetHeight($hImage))
$tSource = DllStructCreate($tagPOINT)
$pSource = DllStructGetPtr($tSource)
$tBlend = DllStructCreate($tagBLENDFUNCTION)
$pBlend = DllStructGetPtr($tBlend)
DllStructSetData($tBlend, "Alpha" , $iOpacity )
DllStructSetData($tBlend, "Format", 1)
_WinAPI_UpdateLayeredWindow($hGUI, $hScrDC, 0, $pSize, $hMemDC, $pSource, 0, $pBlend, $ULW_ALPHA)
_WinAPI_ReleaseDC(0, $hScrDC)
_WinAPI_SelectObject($hMemDC, $hOld)
_WinAPI_DeleteObject($hBitmap)
_WinAPI_DeleteDC($hMemDC)
EndFunc ;==>SetBitmap