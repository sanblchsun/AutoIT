#Include <GUIConstants.Au3>
Opt ('GUIOnEventMode','1')

Global $Display_String = '', $Real_String = ''

GUICreate("VAT Calculator v2.0", 317, 400, 278, 166)
GUISetOnEvent ($GUI_EVENT_CLOSE, '_Exit')
$Display = GUICtrlCreateInput("", 24, 32, 265, 35)
GUICtrlSetState ($Display, $GUI_DISABLE)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")

_Set_Text ()
GUISetState (@SW_SHOW)

While ('1')
Sleep ('750')
WEnd

Func _Set_Text ()

$Button1 = GUICtrlCreateButton("1", 32, 104, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($Button1, '_Set_1')

$Button2 = GUICtrlCreateButton("2", 92, 104, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($Button2, '_Set_2')

$Button3 = GUICtrlCreateButton("3", 152, 104, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($Button3, '_Set_3')

$Button4 = GUICtrlCreateButton("4", 32, 164, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($Button4, '_Set_4')

$Button5 = GUICtrlCreateButton("5", 92, 164, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($Button5, '_Set_5')

$Button6 = GUICtrlCreateButton("6", 152, 164, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($Button6, '_Set_6')

$Button7 = GUICtrlCreateButton("7", 32, 223, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($Button7, '_Set_7')

$Button8 = GUICtrlCreateButton("8", 92, 223, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($Button8, '_Set_8')

$Button9 = GUICtrlCreateButton("9", 152, 223, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($Button9, '_Set_9')

$Button0 = GUICtrlCreateButton("0", 92, 282, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($Button0, '_Set_0')

$ButtonADD = GUICtrlCreateButton("+", 231, 104, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($ButtonADD, '_Add')

$ButtonMINUS = GUICtrlCreateButton("-", 231, 164, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($ButtonMINUS, '_Minus')

$ButtonDIVIDE = GUICtrlCreateButton("?", 231, 282, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($ButtonDIVIDE, '_Divide')

$ButtonTIMES = GUICtrlCreateButton("x", 231, 223, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($ButtonTIMES, '_Times')

$ButtonEqual = GUICtrlCreateButton("=", 231, 341, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($ButtonEqual, '_Equal')

$ButtonDecimal = GUICtrlCreateButton(".", 152, 282, 49, 49)
GUICtrlSetFont(-1, 14, 800, 0, "Arial")
GUICtrlSetOnEvent ($ButtonDecimal, '_Decimal')

$ButtonVAT = GUICtrlCreateButton("+VAT", 32, 282, 49, 49)
GUICtrlSetFont(-1, 8, 800, 0, "Arial")
GUICtrlSetOnEvent ($ButtonVAT, '_VAT')

$ClearButton = GUICtrlCreateButton("Clear", 2, 2, 43, 25)
GUICtrlSetOnEvent ($ClearButton, '_Clear')
EndFunc

Func _Set_0 ()
_Set_Number ('0')
EndFunc

Func _Set_1 ()
_Set_Number ('1')
EndFunc

Func _Set_2 ()
_Set_Number ('2')
EndFunc

Func _Set_3 ()
_Set_Number ('3')
EndFunc

Func _Set_4 ()
_Set_Number ('4')
EndFunc

Func _Set_5 ()
_Set_Number ('5')
EndFunc

Func _Set_6 ()
_Set_Number ('6')
EndFunc

Func _Set_7 ()
_Set_Number ('7')
EndFunc

Func _Set_8 ()
_Set_Number ('8')
EndFunc

Func _Set_9 ()
_Set_Number ('9')
EndFunc

Func _Clear()
    GUICtrlSetData($Display, '')
    $Real_String = ''
    $Display_String = ''
EndFunc

Func _Divide ()
$Display_String = ($Display_String & ' ? ')
$Real_String = ($Real_String & ' / ')
GUICtrlSetData ($Display, $Display_String)
GUICtrlSetState ($Display, $GUI_FOCUS)
EndFunc

Func _Times ()
$Display_String = ($Display_String & ' ? ')
$Real_String = ($Real_String & ' * ')
GUICtrlSetData ($Display, $Display_String)
GUICtrlSetState ($Display, $GUI_FOCUS)
EndFunc

Func _Minus ()
$Display_String = ($Display_String & ' - ')
$Real_String = ($Real_String & ' - ')
GUICtrlSetData ($Display, $Display_String)
GUICtrlSetState ($Display, $GUI_FOCUS)
EndFunc

Func _Add ()
$Display_String = ($Display_String & ' + ')
$Real_String = ($Real_String & ' + ')
GUICtrlSetData ($Display, $Display_String)
GUICtrlSetState ($Display, $GUI_FOCUS)
EndFunc

Func _VAT ()
$Display_String = ($Display_String & ' +VAT ')
$Real_String = ($Real_String & ' * 1.175')
GUICtrlSetData ($Display, $Display_String)
GUICtrlSetState ($Display, $GUI_FOCUS)
EndFunc

Func _Equal ()
$Equal = Execute ($Real_String)
GUICtrlSetData ($Display, $Equal)
$Display_String = ($Equal)
$Real_String = ($Equal)
GUICtrlSetState ($Display, $GUI_FOCUS)
EndFunc

Func _Decimal ()
$Display_String = ($Display_String & ' . ')
$Real_String = ($Real_String & ' ????? ')
GUICtrlSetData ($Display, $Display_String)
GUICtrlSetState ($Display, $GUI_FOCUS)
EndFunc

Func _Set_Number ($Number)
$Display_String = ($Display_String & $Number)
$Real_String = ($Real_String & $Number)
GUICtrlSetData ($Display, $Display_String)
GUICtrlSetState ($Display, $GUI_FOCUS)
EndFunc

Func _Exit ()
Exit
EndFunc
 