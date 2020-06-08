#include <GUIConstantsEx.au3>
#include <ButtonConstants.au3>

GUICreate("Создание кнопок используя стили")  ; will create a dialog box that when displayed is centered

GUICtrlCreateLabel('Кнопка чекбокс имеющая два состояния', 10, 5, 250, 17)

GUICtrlCreateCheckbox("--", 10,25,40,40, $BS_PUSHLIKE+$BS_ICON)
GUICtrlSetImage (-1, "shell32.dll",48, 1)

GUICtrlCreateCheckbox("--", 60,25,24,24, $BS_PUSHLIKE+$BS_ICON)
GUICtrlSetImage (-1, "shell32.dll",24, 0)

GUICtrlCreateLabel('Трёхстатусный', 155, 35, 150, 17)
GUICtrlCreateCheckbox("--", 110,25,40,40, $BS_PUSHLIKE+$BS_ICON+$BS_AUTO3STATE)
GUICtrlSetImage (-1, "shell32.dll",7, 1)

GUICtrlCreateLabel('Радио-кнопка с переключением', 10, 75, 250, 17)

GUICtrlCreateRadio("--", 10, 95,40,40, $BS_PUSHLIKE+$BS_ICON)
GUICtrlSetImage (-1, "shell32.dll", 22)

GUICtrlCreateRadio("--", 60, 95,40,40, $BS_PUSHLIKE+$BS_ICON)
GUICtrlSetImage (-1, "shell32.dll", 23)

GUICtrlCreateRadio("--", 110,95,40,40, $BS_PUSHLIKE+$BS_BITMAP)
GUICtrlSetImage (-1, "oemlogo.bmp")

GUICtrlCreateLabel('Кнопка чекбокс, но использующая картинку, а не иконку', 10, 150, 290, 17)

GUICtrlCreateCheckbox("--", 10, 170,150,140, $BS_PUSHLIKE+$BS_BITMAP)
GUICtrlSetImage (-1, "oemlogo.bmp")

GUICtrlCreateLabel('Плоские кнопки', 110, 340, 150, 17)
GUICtrlCreateButton("--", 10, 320,40,40, $BS_ICON+$BS_FLAT)
GUICtrlSetImage (-1, "shell32.dll",46, 1)
GUICtrlCreateButton("--", 60, 320,40,40, $BS_ICON+$BS_FLAT)
GUICtrlSetImage (-1, "shell32.dll",47, 1)

GUISetState ()

Do
Until GUIGetMsg()=-3