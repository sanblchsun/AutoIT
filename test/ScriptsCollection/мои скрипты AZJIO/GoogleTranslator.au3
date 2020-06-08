#AutoIt3Wrapper_Outfile=GoogleTranslator.exe
#AutoIt3Wrapper_Icon=GoogleTranslator.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=
#AutoIt3Wrapper_Res_Description=GoogleTranslator.exe
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Res_Field=Version|0.1
#AutoIt3Wrapper_Res_Field=Build|2012.08.17
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"

; параллельная разработка AZJIO, ViSiToR, UDF от Stephen Podhajecki, Google Functions от Beege
; ресайз, хоткей поддерживаются, автофокус поля Edit
#include <WindowsConstants.au3>
#include <Inet.au3>
#include <Encoding.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#NoTrayIcon
Opt("GUIResizeMode", 802)
Global $kolSimLimit=376

$GUI = GUICreate("Google - переводчик", 420, 390, -1, -1, $WS_OVERLAPPEDWINDOW+$WS_CLIPCHILDREN, $WS_EX_COMPOSITED)
If Not @compiled Then GUISetIcon('GoogleTranslator.ico', 0)
$StatusBar = GUICtrlCreateLabel("", 5, 390-20, 410-100, 17)
GUICtrlSetFont(-1, 10, 800)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetResizing(-1, 512 + 256 + 2)

GUICtrlCreateLabel("Выберите язык исходного текста:", 10, 12)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
$Lang_Combo1 = GUICtrlCreateCombo("", 190, 10, 200, 50, BitOr($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)

GUICtrlCreateLabel("Выберите язык перевода:", 10, 37)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
$Lang_Combo2 = GUICtrlCreateCombo("", 190, 35, 200, 50, BitOr($GUI_SS_DEFAULT_COMBO, $CBS_DROPDOWNLIST))
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
_SetCombo()


$nRe = GUICtrlCreateButton("^v", 395, 10, 20, 48)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetTip(-1,  'Инвертировать направление перевода.')

$nInv = GUICtrlCreateButton("^", 315, 210, 20, 20)
GUICtrlSetTip(-1,  'Переместить текст, иногда'&@CRLF&'полезно не zh>ru, а zh>en>ru.'&@CRLF&'Ctrl+Стрелка вниз')

$Test = GUICtrlCreateButton("Проверка", 340, 210, 70, 20)
GUICtrlSetTip(-1,  'Проверка обратным'&@CRLF&'переводом текста.'&@CRLF&'Ctrl+Стрелка вверх')

; $SelFunc= GUICtrlCreateCheckbox('Другой метод', 164, 210, 120, 17)
; GUICtrlSetState(-1, 1)

$Clr = GUICtrlCreateButton("Очистить", 145, 60, 70, 20)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetTip(-1,  'Ctrl+Delete')

$Translate1 = GUICtrlCreateButton("Очистить > Вставить > Перевести", 220, 60, 190, 20)
GUICtrlSetResizing(-1, 512 + 256 + 32 + 4)
GUICtrlSetTip(-1,  'Ctrl+Enter')

$Edit1 = GUICtrlCreateEdit('', 10, 80, 400, 130, BitOr($ES_MULTILINE, $ES_AUTOVSCROLL, $ES_WANTRETURN, $WS_VSCROLL))
GUICtrlSetData(-1, 'Переводчик имеет ограничение по количеству символов: 350-376.'&@CRLF&'Есть возможность выполнить обратный перевод для проверки качества.') ; закомментировать эту строку, она для теста
GUICtrlSetState(-1, 256)
GUICtrlCreateLabel("Исходный текст:", 10, 64, -1, 17)

$Edit2 = GUICtrlCreateEdit("", 10, 230, 400, 130, BitOr($ES_MULTILINE, $ES_AUTOVSCROLL, $ES_WANTRETURN, $WS_VSCROLL))
$L2=GUICtrlCreateLabel("Результат перевода:", 10, 214, -1, 17)

; GUICtrlSetFont (-1,-1, -1, -1, 'Arial')

$Translate = GUICtrlCreateButton("Перевести", 340, 360, 70, 25)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetTip(-1,  'Ctrl+Enter')

$nDummy = GUICtrlCreateDummy()
Dim $AccelKeys[5][2] = [["^{Enter}", $Translate],["^{UP}", $Test],["^{DEL}", $Clr],["^{DOWN}", $nInv], ["^a", $nDummy]]
; если раскладка не совпадает с англ. яз. то временно переключаем в неё, чтобы зарегистрировать горячие клавиши
$tmp=0
$KeyLayout = RegRead("HKCU\Keyboard Layout\Preload", 1)
If Not @error And $KeyLayout <> 00000409 Then
	_WinAPI_LoadKeyboardLayout(0x0409)
	$tmp=1
EndIf
GUISetAccelerators($AccelKeys)
If $tmp=1 Then _WinAPI_LoadKeyboardLayout(Dec($KeyLayout)) ; восстанавливаем раскладку по умолчанию

GUISetState()

GUIRegisterMsg(0x05 , "WM_SIZE")
GUIRegisterMsg($WM_GETMINMAXINFO, "WM_GETMINMAXINFO")
; GUIRegisterMsg($WM_WINDOWPOSCHANGING , "WM_WINDOWPOSCHANGING")

ControlSend($GUI, '', $Edit1, '^+{HOME}') ; выделяем текст чтобы сразу печатать свой текст

While 1
    $nMsg = GUIGetMsg()

    Switch $nMsg
        Case -3
            Exit
        Case $nDummy
			Switch ControlGetFocus($GUI)
				Case 'Edit1'
					$tmp = $Edit1
				Case 'Edit2'
					$tmp = $Edit2
			EndSwitch
			GUICtrlSendMsg($tmp, $EM_SETSEL, 0, -1)
        Case $Clr
            GUICtrlSetData($Edit1, '')
			GUICtrlSetState($Edit1, 256)
			
        Case $nRe
            $Lang_Combo01=GUICtrlRead($Lang_Combo1)
            $Lang_Combo02=GUICtrlRead($Lang_Combo2)
            GUICtrlSetData($Lang_Combo1, $Lang_Combo02)
            GUICtrlSetData($Lang_Combo2, $Lang_Combo01)
			
        Case $Test
			If GUICtrlRead($Test)='Проверка' Then
				$Text = GUICtrlRead($Edit2)
				$Lang1 = StringRegExpReplace(GUICtrlRead($Lang_Combo2), " - .*$", '')
				$Lang2 = StringRegExpReplace(GUICtrlRead($Lang_Combo1), " - .*$", '')
				If $Text = '' Then
					MsgBox(0, 'Message', 'Нечего переводить.')
					ContinueLoop
				EndIf
				If $Lang1 = $Lang2 Then
					MsgBox(0, 'Сообщение', 'Укажите разные направления перевода.')
					ContinueLoop
				EndIf
				GUICtrlSetBkColor($Edit2, 0xffd7d7)
				GUICtrlSetState($Translate, 128)
				GUICtrlSetState($Test, 128)
				GUICtrlSetData($StatusBar, "Пожалуйста подождите...")
				
				; If GUICtrlRead($SelFunc)=1 Then
					; $Result = _GoogleTranslate($Text, $Lang1, $Lang2)
				; Else
					$Result = _GoogleTranslateString($Text, $Lang1 & "|" & $Lang2, True)
				; EndIf
				
				GUICtrlSetData($Edit2, $Result)
				GUICtrlSetState($Translate, 64)
				GUICtrlSetState($Test, 64)
				GUICtrlSetData($StatusBar, "Готово")
				GUICtrlSetData($Test, 'Отмена')
				GUICtrlSetBkColor($Edit2, 0xffffff)
			Else
				GUICtrlSetData($Edit2, $Text)
				GUICtrlSetData($Test, 'Проверка')
			EndIf
			
			
        Case $nInv
            GUICtrlSetData($Edit1, GUICtrlRead($Edit2))
			
        Case $Translate1
            GUICtrlSetData($Edit1, '')
			GUICtrlSetState($Edit1, 256)
			Send('+{INS}')
			Sleep(100)
			ContinueCase
			
        Case $Translate
            $Text = GUICtrlRead($Edit1)
            $Lang1 = StringRegExpReplace(GUICtrlRead($Lang_Combo1), " - .*$", '')
            $Lang2 = StringRegExpReplace(GUICtrlRead($Lang_Combo2), " - .*$", '')
			If $Text = '' Then
				MsgBox(0, 'Message', 'Нечего переводить.')
				ContinueLoop
			EndIf
			If $Lang1 = $Lang2 Then
				MsgBox(0, 'Сообщение', 'Укажите разные направления перевода.')
				ContinueLoop
			EndIf
			$kolSim =StringLen($text)
			If $Lang1='en' Then
				$kolSimLimit=1250
			Else
				$kolSimLimit=376
			EndIf
			If $kolSim>$kolSimLimit And MsgBox(4, 'Сообщение', 'Превышено максимальное количество символов, обрезать?'&@CRLF&'Допустимо '&$kolSimLimit-16&'-'&$kolSimLimit&' (текущее: ' & $kolSim & ')')=6 Then $text=StringMid($text, 1, $kolSimLimit)
			 
			GUICtrlSetBkColor($Edit2, 0xffd7d7)
            GUICtrlSetState($Translate, 128)
			GUICtrlSetState($Test, 128)
            GUICtrlSetData($StatusBar, "Пожалуйста подождите...")
			
			; If GUICtrlRead($SelFunc)=1 Then
				; $Result = _GoogleTranslate($Text, $Lang1, $Lang2)
			; Else
				$Result = _GoogleTranslateString($Text, $Lang1 & "|" & $Lang2, True)
			; EndIf
            
            GUICtrlSetData($Edit2, $Result)
            GUICtrlSetState($Translate, 64)
			GUICtrlSetState($Test, 64)
			GUICtrlSetData($Test, 'Проверка')
            GUICtrlSetData($StatusBar, "Готово")
			GUICtrlSetBkColor($Edit2, 0xffffff)
			If GUICtrlRead($Edit2)='' Then
				$Ping=Ping('translate.google.ru', 250)
				If $Ping Then
					MsgBox(0, 'Сообщение', 'Интернет доступен, возможно количество'&@CRLF&'символов близко к максимальному ('&$kolSimLimit-16&'-'&$kolSimLimit&')')
				Else
					MsgBox(0, 'Сообщение', 'Отсутствует доступ к интернету')
				EndIf
			EndIf
    EndSwitch
WEnd

Func _SetCombo()
	Local $vTest = InetRead('http://translate.google.ru/?q=#ru|en|')
	If @error Then MsgBox(0, 'Сообщение', 'Возможно интернет отключен')
	$vTest = BinaryToString($vTest)
	; $vTest=StringRegExp($vTest, '(&#8212;</option><option  value="az.*?</select></div>)', 3)
	$vTest=StringRegExp($vTest, '(<option value=az.*?</select>)', 3)
	If UBound($vTest)<2 Then
		$vTest=$vTest[0]
	Else
		$vTest=$vTest[1]
	EndIf
	$vTest = _Encoding_CyrillicTo1251($vTest)
	; If StringInStr($vTest, 'value=en>БОЗМЙКУЛЙК<') Then $vTest= _Encoding_KOI8To1251($vTest)
	$vTest=StringRegExp($vTest, 'value=(.*?)>(.*?)</option>', 3)
	Local $lng = ""
	For $i = 0 To UBound($vTest)-1 Step  2
			$lng &= $vTest[$i] & " - " & StringUpper(StringLeft($vTest[$i+1], 1)) & StringTrimLeft($vTest[$i+1], 1) & "|"
	Next
	$vTest = ""
	$lng=StringTrimRight($lng, 1)
	GUICtrlSetData($Lang_Combo1, 'auto - Определить язык|'&$lng, "en - Английский")
	GUICtrlSetData($Lang_Combo2, $lng, "ru - Русский")
EndFunc

; Google Functions от Beege
; http://www.autoitscript.com/forum/topic/98504-google-functions/page__view__findpost__p__708636
; Func _GoogleTranslate($sText, $sFrom = "en", $sTo = "ru")
    ; Local $sTranslation, $sUrl, $sSource
    ; $sUrl = StringFormat("http://ajax.googleapis.com/ajax/services/language/translate?v=1.0&q=%s&langpair=%s%%7C%s", $sText, $sFrom, $sTo)
    ; $sSource = _INetGetSource($sUrl)
    ; $sTranslation = StringRegExp(BinaryToString($sSource, 4), '"translatedText":"([^"]+)"', 1)
	; If @error Then Return ''
	; $sTranslation[0]= _URLDecode($sTranslation[0])
    ; Return $sTranslation[0]
; EndFunc

Func _GoogleTranslateString($sText, $sLangPair = -1, $bEncodeURL = False)
	If $sLangPair = -1 Then $sLangPair = "auto|en"
	
	If $bEncodeURL Then $sText = _Encoding_URLToHex($sText)
	
	$sResult = BinaryToString(InetRead('http://google.ru/translate_t?langpair=' & $sLangPair & '&text=' & $sText))
	
	; If StringRight($sLangPair, 2) = "ru" Or StringRight($sLangPair, 4) = "auto" Then $sResult = _Encoding_KOI8To1251($sResult)
	$sResult = _Encoding_CyrillicTo1251($sResult)
	
	$aResult = StringRegExp($sResult, '(?si)(?:onmouseout=".*?>)(.*?)(?=</SPAN>)', 3)
	$sResult = ''
	
	For $i = 0 To UBound($aResult)-1
		$sResult &= $aResult[$i]
	Next
	
	$sResult = StringReplace($sResult, '<br>', @CRLF)
	
	If _Encoding_IsUTF8Format($sResult) Then $sResult = _Encoding_UTF8ToANSI($sResult)
	
	If $bEncodeURL Then $sResult = _URLDecode($sResult)
	
	Return $sResult
EndFunc

; #FUNCTION# ==============================================
; Description ...: Decodeds text for use in URLs
; Parameters ....: $sURL - IN - The text to decode
; Return values .: The decoded text
; Author ........: Stephen Podhajecki {gehossafats at netmdc. com}
; Remarks .......: Replaces escaped hex values for url encoding with ascII characters.
;                  Decoding based on information provided here: http://www.blooberry.com/indexdot/html/topics/urlencoding.htm
; Related .......: _URLEncode
; =========================================================
Func _URLDecode($sURL)
    Local $aEncodable[13] = ['"',"'","<",">","\","^","[","]","`","+","$",",","#"]
    ;decode non-printable and space
    Local $sTemp = $sURL
	
    For $x = 0 To 32
        $sTemp = StringReplace($sTemp,"%"&Hex($x,2),Chr($x))
    Next
	
    ;decode "unsafe"
    For $x = 0 To UBound($aEncodable)-1
        $sTemp = StringReplace($sTemp,"%"&Hex(Asc($aEncodable[$x]),2),$aEncodable[$x])
    Next
	
    ;decode upper ascii and {}|~_
    For $x = 123 To 255
        $sTemp = StringReplace($sTemp,"%"&Hex($x,2),Chr($x))
    Next
	
    ;decode % last 
    $sTemp = StringReplace($sTemp,"%25","%")
    $sTemp = _ConvertEntities($sTemp)
	
    Return $sTemp
EndFunc

; #FUNCTION# =====================================================================================================================
; Description ...: _ConvertEntities
; Parameters ....: $sURL - IN - The Text to convert
; Return values .: Success - Converted string
; Author ........: Stephen Podhajecki {gehossafats at netmdc. com}
; Remarks .......: Replaces HTML escape sequences with character representation
;                  Based on information found here: http://www.theukwebdesigncompany.com/articles/entity-escape-characters.php
;                  nbsp is changed to 32 instead of 160
; Related .......: 
; ================================================================================================================================
Func _ConvertEntities($sURL)
    Local $sTemp = $sUrl
    Local $aEntities[96][2]=[["&quot;",34],["&amp;",38],["&lt;",60],["&gt;",62],["&nbsp;",3],["&nbsp;",32] _
        ,["&iexcl;",161],["&cent;",162],["&pound;",163],["&curren;",164],["&yen;",165],["&brvbar;",166] _
        ,["&sect;",167],["&uml;",168],["&copy;",169],["&ordf;",170],["&not;",172],["&shy;",173] _
        ,["&reg;",174],["&macr;",175],["&deg;",176],["&plusmn;",177],["&sup2;",178],["&sup3;",179] _
        ,["&acute;",180],["&micro;",181],["&para;",182],["&middot;",183],["&cedil;",184],["&sup1;",185] _
        ,["&ordm;",186],["&raquo;",187],["&frac14;",188],["&frac12;",189],["&frac34;",190],["&iquest;",191] _
        ,["&Agrave;",192],["&Aacute;",193],["&Atilde;",195],["&Auml;",196],["&Aring;",197],["&AElig;",198] _
        ,["&Ccedil;",199],["&Egrave;",200],["&Eacute;",201],["&Ecirc;",202],["&Igrave;",204],["&Iacute;",205] _
        ,["&Icirc;",206],["&Iuml;",207],["&ETH;",208],["&Ntilde;",209],["&Ograve;",210],["&Oacute;",211] _
        ,["&Ocirc;",212],["&Otilde;",213],["&Ouml;",214],["&times;",215],["&Oslash;",216],["&Ugrave;",217] _
        ,["&Uacute;",218],["&Ucirc;",219],["&Uuml;",220],["&Yacute;",221],["&THORN;",222],["&szlig;",223] _
        ,["&agrave;",224],["&aacute;",225],["&acirc;",226],["&atilde;",227],["&auml;",228],["&aring;",229] _
        ,["&aelig;",230],["&ccedil;",231],["&egrave;",232],["&eacute;",233],["&ecirc;",234],["&euml;",235] _
        ,["&igrave;",236],["&iacute;",237],["&icirc;",238],["&iuml;",239],["&eth;",240],["&ntilde;",241] _
        ,["&ograve;",242],["&oacute;",243],["&ocirc;",244],["&otilde;",245],["&ouml;",246],["&divide;",247] _
        ,["&oslash;",248],["&ugrave;",249],["&uacute;",250],["&ucirc;",251],["&uuml;",252],["&thorn;",254]]
   
	For $x = 0 To Ubound($aEntities)-1
        $sTemp = StringReplace($sTemp,$aEntities[$x][0],Chr($aEntities[$x][1]))
    Next
	
    For $x = 32 To 255
        $sTemp = StringReplace($sTemp,"&#"&$x&";",chr($x))
    Next
	
	For $x = 256 To 10000
        $sTemp = StringReplace($sTemp,"&#"&$x&";",chrw($x))
    Next
	
    Return $sTemp
EndFunc

Func WM_SIZE($hWnd, $Msg, $wParam, $lParam)
	; #forceref $Msg, $wParam
	Local $xClient, $yClient

	; Координаты области клиенской части.
	$xClient = BitAND($lParam, 0x0000FFFF)
	$yClient = BitShift($lParam, 16)
	
	$w=$xClient-20
	$h=($yClient-80)/2-25
	GUICtrlSetPos($Edit1, 10, 80, $w, $h)
	GUICtrlSetPos($Edit2, 10, 80+$h+20, $w, $h)
	GUICtrlSetPos($L2, 10, $h+84)
	GUICtrlSetPos($nInv, $w-85, $h+80)
	GUICtrlSetPos($Test, $w-60, $h+80)
	; GUICtrlSetPos($SelFunc, 164, $h+80)
	Return 'GUI_RUNDEFMSG'
EndFunc

; Func WM_WINDOWPOSCHANGING($hWnd, $Msg, $wParam, $lParam)
	; Local $sRect = DllStructCreate("Int[6]", $lparam)
	; Local $WinSizeX = DllStructGetData($sRect, 1, 5), $WinSizeY = DllStructGetData($sRect, 1, 6)
	; If DllStructGetData($sRect, 1, 5)<>0 And Not BitAnd(WinGetState($Gui), 16) Then
		; $w=$WinSizeX-20
		; $h=($WinSizeY-80)/2-43
		; GUICtrlSetPos($Edit1, 10, 80, $w, $h)
		; GUICtrlSetPos($Edit2, 10, 80+$h+20, $w, $h)
		; GUICtrlSetPos($L2, 10, $h+84)
		; GUICtrlSetPos($nInv, $w-100, $h+81)
		; GUICtrlSetPos($Test, $w-70, $h+81)
		; Return 'GUI_RUNDEFMSG'
	; EndIf
; EndFunc

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	If $hWnd = $GUI Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 420) ; минимальные размеры окна
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 420)
	EndIf
EndFunc

Func _WinAPI_LoadKeyboardLayout($sLayoutID, $hWnd = 0)
    Local Const $WM_INPUTLANGCHANGEREQUEST = 0x50
    Local $aRet = DllCall("user32.dll", "long", "LoadKeyboardLayoutW", "wstr", Hex($sLayoutID, 8), "int", 0)

    If Not @error And $aRet[0] Then
        If $hWnd = 0 Then
            $hWnd = WinGetHandle(AutoItWinGetTitle())
        EndIf

        DllCall("user32.dll", "ptr", "SendMessage", "hwnd", $hWnd, "int", $WM_INPUTLANGCHANGEREQUEST, "int", 1, "int", $aRet[0])
        Return 1
    EndIf

    Return SetError(1)
EndFunc