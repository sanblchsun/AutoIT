; Viktor1703
; http://autoit-script.ru/index.php/topic,7471.msg69611.html#msg69611

#Include <GUIConstantsEx.au3>
#Include <WindowsConstants.au3>
#NoTrayIcon

Global $SkinDll, $LockState = 0, $iHandle = WinGetTitle("[ACTIVE]"), $Apportion = "RU", $LangStatus = 0

LoadSkin(@ScriptDir & "\SkinToolkit.dll")
$hVKeyboard = GUICreate("Virtual Keyboard v2.0.6.1", 375, 150)
InitializeSkin($hVKeyboard, @ScriptDir & "\skin.skf")
WinSetOnTop($hVKeyboard, "", 1)
$Button00 = GUICtrlCreateButton("Esc", 0, 0, 25, 25)
$Button01 = GUICtrlCreateButton("F1", 25, 0, 25, 25)
$Button02 = GUICtrlCreateButton("F2", 50, 0, 25, 25)
$Button03 = GUICtrlCreateButton("F3", 75, 0, 25, 25)
$Button04 = GUICtrlCreateButton("F4", 100, 0, 25, 25)
$Button05 = GUICtrlCreateButton("F5", 125, 0, 25, 25)
$Button06 = GUICtrlCreateButton("F6", 150, 0, 25, 25)
$Button07 = GUICtrlCreateButton("F7", 175, 0, 25, 25)
$Button08 = GUICtrlCreateButton("F8", 200, 0, 25, 25)
$Button09 = GUICtrlCreateButton("F9", 225, 0, 25, 25)
$Button10 = GUICtrlCreateButton("F10", 250, 0, 25, 25)
$Button11 = GUICtrlCreateButton("F11", 275, 0, 25, 25)
$Button12 = GUICtrlCreateButton("F12", 300, 0, 25, 25)
$Button13 = GUICtrlCreateButton("RU", 325, 0, 25, 25)
$Button14 = GUICtrlCreateButton("EN", 350, 0, 25, 25)
$Button15 = GUICtrlCreateButton("¸", 0, 25, 25, 25)
$Button16 = GUICtrlCreateButton("1", 25, 25, 25, 25)
$Button17 = GUICtrlCreateButton("2", 50, 25, 25, 25)
$Button18 = GUICtrlCreateButton("3", 75, 25, 25, 25)
$Button19 = GUICtrlCreateButton("4", 100, 25, 25, 25)
$Button20 = GUICtrlCreateButton("5", 125, 25, 25, 25)
$Button21 = GUICtrlCreateButton("6", 150, 25, 25, 25)
$Button22 = GUICtrlCreateButton("7", 175, 25, 25, 25)
$Button23 = GUICtrlCreateButton("8", 200, 25, 25, 25)
$Button24 = GUICtrlCreateButton("9", 225, 25, 25, 25)
$Button25 = GUICtrlCreateButton("0", 250, 25, 25, 25)
$Button26 = GUICtrlCreateButton("-", 275, 25, 25, 25)
$Button27 = GUICtrlCreateButton("=", 300, 25, 25, 25)
$Button28 = GUICtrlCreateButton("Bksp", 325, 25, 50, 25)
$Button29 = GUICtrlCreateButton("Tab", 0, 50, 40, 25)
$Button30 = GUICtrlCreateButton("é", 40, 50, 25, 25)
$Button31 = GUICtrlCreateButton("ö", 65, 50, 25, 25)
$Button32 = GUICtrlCreateButton("ó", 90, 50, 25, 25)
$Button33 = GUICtrlCreateButton("ê", 115, 50, 25, 25)
$Button34 = GUICtrlCreateButton("å", 140, 50, 25, 25)
$Button35 = GUICtrlCreateButton("í", 165, 50, 25, 25)
$Button36 = GUICtrlCreateButton("ã", 190, 50, 25, 25)
$Button37 = GUICtrlCreateButton("ø", 215, 50, 25, 25)
$Button38 = GUICtrlCreateButton("ù", 240, 50, 25, 25)
$Button39 = GUICtrlCreateButton("ç", 265, 50, 25, 25)
$Button40 = GUICtrlCreateButton("õ", 290, 50, 25, 25)
$Button41 = GUICtrlCreateButton("ú", 315, 50, 25, 25)
$Button42 = GUICtrlCreateButton("\", 340, 50, 35, 25)
$Button43 = GUICtrlCreateButton("Lock", 0, 75, 40, 25)
$Button44 = GUICtrlCreateButton("ô", 40, 75, 25, 25)
$Button45 = GUICtrlCreateButton("û", 65, 75, 25, 25)
$Button46 = GUICtrlCreateButton("â", 90, 75, 25, 25)
$Button47 = GUICtrlCreateButton("à", 115, 75, 25, 25)
$Button48 = GUICtrlCreateButton("ï", 140, 75, 25, 25)
$Button49 = GUICtrlCreateButton("ð", 165, 75, 25, 25)
$Button50 = GUICtrlCreateButton("î", 190, 75, 25, 25)
$Button51 = GUICtrlCreateButton("ë", 215, 75, 25, 25)
$Button52 = GUICtrlCreateButton("ä", 240, 75, 25, 25)
$Button53 = GUICtrlCreateButton("æ", 265, 75, 25, 25)
$Button54 = GUICtrlCreateButton("ý", 290, 75, 25, 25)
$Button55 = GUICtrlCreateButton("Enter", 315, 75, 60, 25)
$Button56 = GUICtrlCreateButton("PrtScr", 0, 100, 40, 25)
$Button57 = GUICtrlCreateButton("ÿ", 40, 100, 25, 25)
$Button58 = GUICtrlCreateButton("÷", 65, 100, 25, 25)
$Button59 = GUICtrlCreateButton("ñ", 90, 100, 25, 25)
$Button60 = GUICtrlCreateButton("ì", 115, 100, 25, 25)
$Button61 = GUICtrlCreateButton("è", 140, 100, 25, 25)
$Button62 = GUICtrlCreateButton("ò", 165, 100, 25, 25)
$Button63 = GUICtrlCreateButton("ü", 190, 100, 25, 25)
$Button64 = GUICtrlCreateButton("á", 215, 100, 25, 25)
$Button65 = GUICtrlCreateButton("þ", 240, 100, 25, 25)
$Button66 = GUICtrlCreateButton(".", 265, 100, 25, 25)
$Button67 = GUICtrlCreateButton("Break", 290, 100, 35, 25)
$Button68 = GUICtrlCreateButton("Hm", 325, 100, 25, 25)
$Button69 = GUICtrlCreateButton("End", 350, 100, 25, 25)
$Button70 = GUICtrlCreateButton("Pg Up", 0, 125, 50, 25)
$Button71 = GUICtrlCreateButton("Pg Dn", 50, 125, 50, 25)
$Button72 = GUICtrlCreateButton("", 100, 125, 180, 25)
$Button73 = GUICtrlCreateButton("Win", 280, 125, 45, 25)
$Button74 = GUICtrlCreateButton("Ins", 325, 125, 25, 25)
$Button75 = GUICtrlCreateButton("Del", 350, 125, 25, 25)
GUISetState()

AdlibRegister("GetActive") 

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
		Case $Button00
			SendKey($iHandle, "{ESC}")
		Case $Button01
			SendKey($iHandle, "{F1}")	
		Case $Button02
			SendKey($iHandle, "{F2}")	
		Case $Button03
			SendKey($iHandle, "{F3}")	
		Case $Button04
			SendKey($iHandle, "{F4}")
		Case $Button05
			SendKey($iHandle, "{F5}")
		Case $Button06
			SendKey($iHandle, "{F6}")
		Case $Button07
			SendKey($iHandle, "{F7}")	
		Case $Button08
			SendKey($iHandle, "{F8}")	
		Case $Button09
			SendKey($iHandle, "{F9}")
		Case $Button10
			SendKey($iHandle, "{F10}")	
		Case $Button11
			SendKey($iHandle, "{F11}")
		Case $Button12
			SendKey($iHandle, "{F12}")		
		Case $Button13
            $Apportion = "RU"
			LANG_KEYBOARD()
		Case $Button14
			$Apportion = "EN"
			LANG_KEYBOARD()
		Case $Button15
			SendKey($iHandle, GUICtrlRead($Button15))
		Case $Button16
			If $LangStatus = 0 Then
			    SendKey($iHandle, GUICtrlRead($Button16))
			ElseIf $LangStatus = 1 Then	
				SendKey($iHandle, "+{1}")
			ElseIf $LangStatus = 2 Then		
			    SendKey($iHandle, "+{1}")
			EndIf	
		Case $Button17
			If $LangStatus = 0 Then
			    SendKey($iHandle, GUICtrlRead($Button17))
			ElseIf $LangStatus = 1 Then	
				SendKey($iHandle, "+{2}")
			ElseIf $LangStatus = 2 Then		
			    SendKey($iHandle, "+{2}")
			EndIf	
		Case $Button18
			If $LangStatus = 0 Then
			    SendKey($iHandle, GUICtrlRead($Button18))
			ElseIf $LangStatus = 1 Then	
				SendKey($iHandle, "+{3}")
			ElseIf $LangStatus = 2 Then		
			    SendKey($iHandle, "+{3}")
			EndIf
		Case $Button19
			If $LangStatus = 0 Then
			    SendKey($iHandle, GUICtrlRead($Button19))
			ElseIf $LangStatus = 1 Then	
				SendKey($iHandle, "+{4}")
			ElseIf $LangStatus = 2 Then		
			    SendKey($iHandle, "+{4}")
			EndIf
		Case $Button20
			If $LangStatus = 0 Then
			    SendKey($iHandle, GUICtrlRead($Button20))
			ElseIf $LangStatus = 1 Then	
				SendKey($iHandle, "+{5}")
			ElseIf $LangStatus = 2 Then		
			    SendKey($iHandle, "+{5}")
			EndIf
		Case $Button21
			If $LangStatus = 0 Then
			    SendKey($iHandle, GUICtrlRead($Button21))
			ElseIf $LangStatus = 1 Then	
				SendKey($iHandle, "+{6}")
			ElseIf $LangStatus = 2 Then		
			    SendKey($iHandle, "+{6}")
			EndIf
		Case $Button22
			If $LangStatus = 0 Then
			    SendKey($iHandle, GUICtrlRead($Button22))
			ElseIf $LangStatus = 1 Then	
				SendKey($iHandle, "+{7}")
			ElseIf $LangStatus = 2 Then		
			    SendKey($iHandle, "+{7}")
			EndIf
		Case $Button23
			If $LangStatus = 0 Then
			    SendKey($iHandle, GUICtrlRead($Button23))
			ElseIf $LangStatus = 1 Then	
				SendKey($iHandle, "+{8}")
			ElseIf $LangStatus = 2 Then		
			    SendKey($iHandle, "+{8}")
			EndIf
		Case $Button24
			If $LangStatus = 0 Then
			    SendKey($iHandle, GUICtrlRead($Button24))
			ElseIf $LangStatus = 1 Then	
				SendKey($iHandle, "+{9}")
			ElseIf $LangStatus = 2 Then		
			    SendKey($iHandle, "+{9}")
			EndIf	
		Case $Button25
			If $LangStatus = 0 Then
			    SendKey($iHandle, GUICtrlRead($Button25))
			ElseIf $LangStatus = 1 Then	
				SendKey($iHandle, "+{0}")
			ElseIf $LangStatus = 2 Then		
			    SendKey($iHandle, "+{0}")
			EndIf
		Case $Button26
			SendKey($iHandle, GUICtrlRead($Button26))	
		Case $Button27
			If $LangStatus = 0 Then
			    SendKey($iHandle, "{=}")
			ElseIf $LangStatus = 1 Then	
				SendKey($iHandle, "+{=}")
			ElseIf $LangStatus = 2 Then		
			    SendKey($iHandle, "+{=}")
			EndIf
		Case $Button28
			SendKey($iHandle, "{BACKSPACE}")
		Case $Button29
			SendKey($iHandle, "{TAB}")	
		Case $Button30
			SendKey($iHandle, GUICtrlRead($Button30))
		Case $Button31
			SendKey($iHandle, GUICtrlRead($Button31))	
		Case $Button32
			SendKey($iHandle, GUICtrlRead($Button32))
		Case $Button33
			SendKey($iHandle, GUICtrlRead($Button33))
		Case $Button34
			SendKey($iHandle, GUICtrlRead($Button34))
		Case $Button35
			SendKey($iHandle, GUICtrlRead($Button35))
		Case $Button36
			SendKey($iHandle, GUICtrlRead($Button36))
		Case $Button37
			SendKey($iHandle, GUICtrlRead($Button37))
		Case $Button38
			SendKey($iHandle, GUICtrlRead($Button38))
		Case $Button39
			SendKey($iHandle, GUICtrlRead($Button39))	
		Case $Button40
			SendKey($iHandle, GUICtrlRead($Button40))
		Case $Button41
			SendKey($iHandle, GUICtrlRead($Button41))
		Case $Button42
			If $LangStatus = 0 Then
			    SendKey($iHandle, "{\}")
			ElseIf $LangStatus = 1 Then
				SendKey($iHandle, "+{\}")
			ElseIf $LangStatus = 2 Then		
			    SendKey($iHandle, "+{\}")
			EndIf		
		Case $Button43
			If $LockState = 0 Then
				$LockState = 1
				LOCK_KEYBOARD()
			ElseIf $LockState = 1 Then
				$LockState = 0
				LANG_KEYBOARD()
			EndIf
		Case $Button44
			SendKey($iHandle, GUICtrlRead($Button44))
		Case $Button45
			SendKey($iHandle, GUICtrlRead($Button45))
		Case $Button46
			SendKey($iHandle, GUICtrlRead($Button46))
		Case $Button47
			SendKey($iHandle, GUICtrlRead($Button47))
		Case $Button48
			SendKey($iHandle, GUICtrlRead($Button48))
		Case $Button49
			SendKey($iHandle, GUICtrlRead($Button49))
		Case $Button50
			SendKey($iHandle, GUICtrlRead($Button50))	
		Case $Button51
			SendKey($iHandle, GUICtrlRead($Button51))
		Case $Button52
			SendKey($iHandle, GUICtrlRead($Button52))
		Case $Button53
			SendKey($iHandle, GUICtrlRead($Button53))
		Case $Button54
			SendKey($iHandle, GUICtrlRead($Button54))
		Case $Button55
			SendKey($iHandle, "{ENTER}")
		Case $Button56
			SendKey($iHandle, "{PRINTSCREEN}")
		Case $Button57
			SendKey($iHandle, GUICtrlRead($Button57))
		Case $Button58
			SendKey($iHandle, GUICtrlRead($Button58))	
		Case $Button59
			SendKey($iHandle, GUICtrlRead($Button59))
		Case $Button60
			SendKey($iHandle, GUICtrlRead($Button60))	
		Case $Button61
			SendKey($iHandle, GUICtrlRead($Button61))	
		Case $Button62
			SendKey($iHandle, GUICtrlRead($Button62))
		Case $Button63
			SendKey($iHandle, GUICtrlRead($Button63))
		Case $Button64
			SendKey($iHandle, GUICtrlRead($Button64))
		Case $Button65
			SendKey($iHandle, GUICtrlRead($Button65))
		Case $Button66
			If $LangStatus = 0 Then
			    SendKey($iHandle, "/")
			ElseIf $LangStatus = 1 Then
				SendKey($iHandle, "/")
			ElseIf $LangStatus = 2 Then		
			    SendKey($iHandle, "+{/}")
			EndIf				
		Case $Button67
			SendKey($iHandle, "{BREAK}")	
		Case $Button68
			SendKey($iHandle, "{HOME}")	
		Case $Button69
			SendKey($iHandle, "{END}")	
		Case $Button70
			SendKey($iHandle, "{PGUP}")	
		Case $Button71
			SendKey($iHandle, "{PGDN}")	
		Case $Button72
			SendKey($iHandle, " ")	
		Case $Button73
			SendKey($iHandle, "{LWIN}")		
		Case $Button74
			SendKey($iHandle, "{INSERT}")
		Case $Button75
			SendKey($iHandle, "{DELETE}")
	EndSwitch
WEnd

Func GetActive()
	$hGetHandle = WinGetHandle("[ACTIVE]")
	If $hGetHandle <> $hVKeyboard And $hGetHandle <> WinGetHandle("[CLASS:SCALPHAWINDOW]") Then
		$iHandle = $hGetHandle
	EndIf	
EndFunc

Func LANG_KEYBOARD()
	If $Apportion = "RU" Then
		GUICtrlSetData($Button15, "¸")
		GUICtrlSetData($Button16, "1")
		GUICtrlSetData($Button17, "2")
		GUICtrlSetData($Button18, "3")
		GUICtrlSetData($Button19, "4")
		GUICtrlSetData($Button20, "5")
		GUICtrlSetData($Button21, "6")
		GUICtrlSetData($Button22, "7")
		GUICtrlSetData($Button23, "8")
		GUICtrlSetData($Button24, "9")
		GUICtrlSetData($Button25, "0")
		GUICtrlSetData($Button26, "-")
		GUICtrlSetData($Button27, "=")		
		GUICtrlSetData($Button30, "é")
		GUICtrlSetData($Button31, "ö")
		GUICtrlSetData($Button32, "ó")
		GUICtrlSetData($Button33, "ê")
		GUICtrlSetData($Button34, "å")
		GUICtrlSetData($Button35, "í")
		GUICtrlSetData($Button36, "ã")
		GUICtrlSetData($Button37, "ø")
		GUICtrlSetData($Button38, "ù")
		GUICtrlSetData($Button39, "ç")
		GUICtrlSetData($Button40, "õ")
		GUICtrlSetData($Button41, "ú")
		GUICtrlSetData($Button42, "\")
		GUICtrlSetData($Button44, "ô")
		GUICtrlSetData($Button45, "û")
		GUICtrlSetData($Button46, "â")
		GUICtrlSetData($Button47, "à")
		GUICtrlSetData($Button48, "ï")
		GUICtrlSetData($Button49, "ð")
		GUICtrlSetData($Button50, "î")
		GUICtrlSetData($Button51, "ë")
		GUICtrlSetData($Button52, "ä")
		GUICtrlSetData($Button53, "æ")
		GUICtrlSetData($Button54, "ý")
		GUICtrlSetData($Button57, "ÿ")
		GUICtrlSetData($Button58, "÷")
		GUICtrlSetData($Button59, "ñ")
		GUICtrlSetData($Button60, "ì")
		GUICtrlSetData($Button61, "è")
		GUICtrlSetData($Button62, "ò")
		GUICtrlSetData($Button63, "ü")
		GUICtrlSetData($Button64, "á")
		GUICtrlSetData($Button65, "þ")
		GUICtrlSetData($Button66, ".")	
        $LangStatus = 0		
	ElseIf $Apportion = "EN" Then
		GUICtrlSetData($Button15, "`")
		GUICtrlSetData($Button16, "1")
		GUICtrlSetData($Button17, "2")
		GUICtrlSetData($Button18, "3")
		GUICtrlSetData($Button19, "4")
		GUICtrlSetData($Button20, "5")
		GUICtrlSetData($Button21, "6")
		GUICtrlSetData($Button22, "7")
		GUICtrlSetData($Button23, "8")
		GUICtrlSetData($Button24, "9")
		GUICtrlSetData($Button25, "0")
		GUICtrlSetData($Button26, "-")
		GUICtrlSetData($Button27, "=")				
		GUICtrlSetData($Button30, "q")
		GUICtrlSetData($Button31, "w")
		GUICtrlSetData($Button32, "e")
		GUICtrlSetData($Button33, "r")
		GUICtrlSetData($Button34, "t")
		GUICtrlSetData($Button35, "y")
		GUICtrlSetData($Button36, "u")
		GUICtrlSetData($Button37, "i")
		GUICtrlSetData($Button38, "o")
		GUICtrlSetData($Button39, "p")
		GUICtrlSetData($Button40, "[")
		GUICtrlSetData($Button41, "]")
		GUICtrlSetData($Button42, "\")
		GUICtrlSetData($Button44, "a")
		GUICtrlSetData($Button45, "s")
		GUICtrlSetData($Button46, "d")
		GUICtrlSetData($Button47, "f")
		GUICtrlSetData($Button48, "g")
		GUICtrlSetData($Button49, "h")
		GUICtrlSetData($Button50, "j")
		GUICtrlSetData($Button51, "k")
		GUICtrlSetData($Button52, "l")
		GUICtrlSetData($Button53, ";")
		GUICtrlSetData($Button54, "'")
		GUICtrlSetData($Button57, "z")
		GUICtrlSetData($Button58, "x")
		GUICtrlSetData($Button59, "c")
		GUICtrlSetData($Button60, "v")
		GUICtrlSetData($Button61, "b")
		GUICtrlSetData($Button62, "n")
		GUICtrlSetData($Button63, "m")
		GUICtrlSetData($Button64, ",")
		GUICtrlSetData($Button65, ".")
		GUICtrlSetData($Button66, "/")
		$LangStatus = 0	
	EndIf
EndFunc 

Func LOCK_KEYBOARD()
	If $Apportion = "RU" Then
		GUICtrlSetData($Button15, "¨")
		GUICtrlSetData($Button16, "!")
		GUICtrlSetData($Button17, '"')
		GUICtrlSetData($Button18, "¹")
		GUICtrlSetData($Button19, ";")
		GUICtrlSetData($Button20, "%")
		GUICtrlSetData($Button21, ":")
		GUICtrlSetData($Button22, "?")
		GUICtrlSetData($Button23, "*")
		GUICtrlSetData($Button24, "(")
		GUICtrlSetData($Button25, ")")
		GUICtrlSetData($Button26, "_")
		GUICtrlSetData($Button27, "+")
		GUICtrlSetData($Button30, "É")
		GUICtrlSetData($Button31, "Ö")
		GUICtrlSetData($Button32, "Ó")
		GUICtrlSetData($Button33, "Ê")
		GUICtrlSetData($Button34, "Å")
		GUICtrlSetData($Button35, "Í")
		GUICtrlSetData($Button36, "Ã")
		GUICtrlSetData($Button37, "Ø")
		GUICtrlSetData($Button38, "Ù")
		GUICtrlSetData($Button39, "Ç")
		GUICtrlSetData($Button40, "Õ")
		GUICtrlSetData($Button41, "Ú")
		GUICtrlSetData($Button42, "/")
		GUICtrlSetData($Button44, "Ô")
		GUICtrlSetData($Button45, "Û")
		GUICtrlSetData($Button46, "Â")
		GUICtrlSetData($Button47, "À")
		GUICtrlSetData($Button48, "Ï")
		GUICtrlSetData($Button49, "Ð")
		GUICtrlSetData($Button50, "Î")
		GUICtrlSetData($Button51, "Ë")
		GUICtrlSetData($Button52, "Ä")
		GUICtrlSetData($Button53, "Æ")
		GUICtrlSetData($Button54, "Ý")
		GUICtrlSetData($Button57, "ß")
		GUICtrlSetData($Button58, "×")
		GUICtrlSetData($Button59, "Ñ")
		GUICtrlSetData($Button60, "Ì")
		GUICtrlSetData($Button61, "È")
		GUICtrlSetData($Button62, "Ò")
		GUICtrlSetData($Button63, "Ü")
		GUICtrlSetData($Button64, "Á")
		GUICtrlSetData($Button65, "Þ")
        $LangStatus = 1		
	ElseIf $Apportion = "EN" Then
		GUICtrlSetData($Button15, "~")
		GUICtrlSetData($Button16, "!")
		GUICtrlSetData($Button17, "@")
		GUICtrlSetData($Button18, "#")
		GUICtrlSetData($Button19, "$")
		GUICtrlSetData($Button20, "%")
		GUICtrlSetData($Button21, "^")
		GUICtrlSetData($Button22, "And")
		GUICtrlSetData($Button23, "*")
		GUICtrlSetData($Button24, "(")
		GUICtrlSetData($Button25, ")")
		GUICtrlSetData($Button26, "_")
		GUICtrlSetData($Button27, "+")		
		GUICtrlSetData($Button30, "Q") 
		GUICtrlSetData($Button31, "W")
		GUICtrlSetData($Button32, "E")
		GUICtrlSetData($Button33, "R")
		GUICtrlSetData($Button34, "T")
		GUICtrlSetData($Button35, "Y")
		GUICtrlSetData($Button36, "U")
		GUICtrlSetData($Button37, "I")
		GUICtrlSetData($Button38, "O")
		GUICtrlSetData($Button39, "P")
		GUICtrlSetData($Button40, "{")
		GUICtrlSetData($Button41, "}")
		GUICtrlSetData($Button42, "|")
		GUICtrlSetData($Button44, "A")
		GUICtrlSetData($Button45, "S")
		GUICtrlSetData($Button46, "D")
		GUICtrlSetData($Button47, "F")
		GUICtrlSetData($Button48, "G")
		GUICtrlSetData($Button49, "H")
		GUICtrlSetData($Button50, "J")
		GUICtrlSetData($Button51, "K")
		GUICtrlSetData($Button52, "L")
		GUICtrlSetData($Button53, ":")
		GUICtrlSetData($Button54, '"')
		GUICtrlSetData($Button57, "Z")
		GUICtrlSetData($Button58, "X")
		GUICtrlSetData($Button59, "C")
		GUICtrlSetData($Button60, "V")
		GUICtrlSetData($Button61, "B")
		GUICtrlSetData($Button62, "N")
		GUICtrlSetData($Button63, "M")
		GUICtrlSetData($Button64, "<")
		GUICtrlSetData($Button65, ">")
		GUICtrlSetData($Button66, "?")	
		$LangStatus = 2
	EndIf
EndFunc 

Func LoadSkin($nDLL)
    $SkinDll = DllOpen($nDLL)
    If Not FileExists($nDLL) Then
        SetError(1)
        Return 0
    EndIf
    If $SkinDll = -1 Then
        SetError(2)
        Return 0
    EndIf
    DllCall($SkinDll, "int:cdecl", "InitLicenKeys", "wstr","SkinCrafter", "wstr","DMSoft", "wstr", "support@skincrafter.com","wstr","RCXKV7Q47VYJTB18D1ET4UEJ8NOBP")
    DllCall($SkinDll, "int:cdecl", "DefineLanguage", "int", 0)
    Return 1
EndFunc

Func InitializeSkin($nHWND, $nSkin)
    If Not WinExists($nHWND) Then
        SetError(1)
        Return 0
    EndIf
    If Not FileExists($nSkin) Then
        SetError(2)
        Return 0
    EndIf
    DllCall($SkinDll, "int:cdecl", "InitDecoration", "int", 1)
    DllCall($SkinDll, "int:cdecl", "LoadSkinFromFile", "wstr", $nSkin)
    DllCall($SkinDll, "int:cdecl", "ApplySkin")
    DllCall($SkinDll, "int:cdecl", "DecorateAs","long",$nHWND,"long",1)
    Return 1
EndFunc

Func SendKey($hWnd, $iKey)
	If $Apportion = "RU" Then
		_WinAPI_LoadKeyboardLayout(0x0419, $hWnd)
	ElseIf $Apportion = "EN" Then
		_WinAPI_LoadKeyboardLayout(0x0409, $hWnd)
	EndIf	
	WinActivate($hWnd, "")
	Send($iKey)
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