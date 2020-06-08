#include <GDIP.au3>
Opt("GUIResizeMode", 0x0322)
_GDIPlus_Startup()

$hGUI = GUICreate("Пример", 500, 310, -1, -1,0x00040000+0x00020000)
$hButton=GUICtrlCreateButton('Вертим', 380, 10, 55, 25)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$hClear=GUICtrlCreateButton('Очистка', 440, 10, 55, 25)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$hLabel=GUICtrlCreateLabel('время', 410, 40, 80, 17)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlCreateLabel('плотность', 380, 62, 60, 17)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$hInput=GUICtrlCreateCombo('', 440, 60, 50)
GUICtrlSetData(-1,'0.1|0.5|1|3', '1')
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlCreateLabel('Диаметр', 385, 92, 55, 17)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$hD=GUICtrlCreateCombo('', 440, 90, 50)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetData(-1,'10|20|30|40', '20')
GUICtrlCreateLabel('Высота', 395, 122, 45, 17)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$hH=GUICtrlCreateCombo('', 440, 120, 50)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetData(-1,'70|100|160|200', '160')
GUICtrlCreateLabel('задержка', 385, 152, 55, 17)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
$input2=GUICtrlCreateCombo('', 440, 150, 50)
GUICtrlSetResizing(-1, 512 + 256 + 64 + 4)
GUICtrlSetData(-1,'0|10|20', '0')
GUISetState()
$hPen = _GDIPlus_PenCreate (0xFF0000FF, 1)
$n=0.0174532925199433

While 1
   $msg = GUIGetMsg()
   Select
       Case $msg =$hClear
			$GP=WinGetPos($hGUI)
			WinMove($hGUI, '', $GP[0], $GP[1], $GP[2]+1, $GP[3])
			WinMove($hGUI, '', $GP[0], $GP[1], $GP[2], $GP[3])
       Case $msg =$hButton
			$hGraphics = _GDIPlus_GraphicsCreateFromHWND($hGUI)
			$input02=Int(GUICtrlRead($input2))
			$GP=WinGetPos($hGUI)
			$k=GUICtrlRead($hInput)
			$d=GUICtrlRead($hD)
			$h=GUICtrlRead($hH)
			$Time=TimerInit()
           For $i = 1 to 360*$k
 _GDIPlus_GraphicsDrawLine($hGraphics, Round(Sin($i*$n/$k)*$d*3+$GP[2]/2-40), Round(Cos($i*$n/$k)*$d+$GP[3]/2-$h*3/4), Round(Sin($i*$n/$k)*$d*9+$GP[2]/2-40), Round(Cos($i*$n/$k)*$d*3+$h+$GP[3]/2-$h*3/4), $hPen)
				_GDIPlus_PenSetColor($hPen, Dec('FF'&Hex(Random(0, 255, 1), 2) & Hex(Random(0, 255, 1), 2) & Hex(Random(0, 255, 1), 2)))
				If $input02<>0 Then Sleep($input02)
		   Next
		   GUICtrlSetData($hLabel, 'за '&Round(TimerDiff($Time)/1000, 3)&' сек')
			TimerDiff($Time)
			

       Case $msg = -3
           Exit
   EndSelect
WEnd

_GDIPlus_PenDispose($hPen)
_GDIPlus_GraphicsDispose($hGraphics)
_GDIPlus_Shutdown()