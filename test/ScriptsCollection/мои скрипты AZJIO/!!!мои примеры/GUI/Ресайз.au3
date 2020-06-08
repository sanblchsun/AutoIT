#include <WindowsConstants.au3>
; При ресайзе важно использовать WM-сообщение WM_GETMINMAXINFO ограничивающее уменьшение окна менее установленного предела, а также макисмальное и развёрнутое.
; Подбором параметров GUICtrlSetResizing устанавливаем способ изменения позиции элементов.
; Режим GUIResizeMode устанавливает общие параметры для всех элементов, для которых не указан GUICtrlSetResizing
; Если требуется выполнить ресайз про правилам, которых не удаётся добится стандартным сопсобом, то используем WM_SIZE, которое срабатывают во время изменения размера окна и составляем правила по которым рассчитываются координаты и размеры некоторых элементов.

Opt("GUIResizeMode", 2 + 32 + 256 + 512) ; 802
GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")

$GUI=GUICreate("Ресайз", 300, 300, -1 , -1, $WS_OVERLAPPEDWINDOW)

$Button1=GUICtrlCreateButton('Левый-Верхний', 10, 10, 100, 22)
GUICtrlSetResizing(-1,  2 + 32 + 256 + 512)

$Button2=GUICtrlCreateButton('Правый-Верхний', 190, 10, 100, 22)
GUICtrlSetResizing(-1, 4 + 32 + 256 + 512)

$Button1=GUICtrlCreateButton('Левый-Нижний', 10, 268, 100, 22)
GUICtrlSetResizing(-1,  2 + 64 + 256 + 512)

$Button2=GUICtrlCreateButton('Правый-Нижний', 190, 268, 100, 22)
GUICtrlSetResizing(-1, 4 + 64 + 256 + 512)


$Edit1=GUICtrlCreateEdit('', 10, 40, 280, 90)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 512)

$Edit1=GUICtrlCreateEdit('', 10, 135, 280, 120)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 64 + 512)

GUISetState ()
While 1
   $msg = GUIGetMsg()
   Select
       Case $msg = -3
           Exit
   EndSelect
WEnd

Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	If $hWnd = $GUI Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MaxTrackSizeX", 600)
		DllStructSetData($tMINMAXINFO, "MaxTrackSizeY", 500)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 250)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 250)
		DllStructSetData($tMINMAXINFO, "MaxSizeX", 800)
		DllStructSetData($tMINMAXINFO, "MaxSizeY", 500)
		DllStructSetData($tMINMAXINFO, "MaxPositionX", @DesktopWidth/2-300)
		DllStructSetData($tMINMAXINFO, "MaxPositionY", 0)
	EndIf
EndFunc