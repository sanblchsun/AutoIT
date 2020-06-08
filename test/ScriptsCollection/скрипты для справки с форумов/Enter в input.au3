#include <ButtonConstants.au3> 
#include <EditConstants.au3> 
#include <GUIConstantsEx.au3> 
#include <StaticConstants.au3> 
#include <WindowsConstants.au3> 
#Region ### START Koda GUI section ### Form= 
$Form1 = GUICreate("Form1", 229, 112, 192, 124) 
$Input1 = GUICtrlCreateInput("", 40, 16, 121, 21) 
$Button1 = GUICtrlCreateButton("Button1", 1, 1, 1, 1, $BS_DEFPUSHBUTTON); дефолтная кнопка для нажатия по Enter) 
$Label1 = GUICtrlCreateLabel("Введите текст и Нажмите Enter", 24, 80, 172, 17) 
ControlFocus ($Form1, "", $Input1) 
GUISetState(@SW_SHOW) 
#EndRegion ### END Koda GUI section ### 
 
While 1 
    $nMsg = GUIGetMsg() 
    Switch $nMsg 
        Case $GUI_EVENT_CLOSE 
            Exit 
        Case $Button1 
            $text = GUICtrlRead ($Input1) 
            GUICtrlSetData ($Label1, "Введённый текст:" & $text) 
    EndSwitch 
WEnd 
