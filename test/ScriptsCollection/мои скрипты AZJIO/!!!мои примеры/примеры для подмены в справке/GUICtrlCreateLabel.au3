#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>

$Style='|SS_LEFT |SS_CENTER|SS_RIGHT|SS_CENTERIMAGE|SS_ETCHEDFRAME|SS_ETCHEDHORZ|SS_ETCHEDVERT|SS_GRAYFRAME|SS_GRAYRECT|SS_LEFTNOWORDWRAP|SS_NOPREFIX|SS_NOTIFY|SS_RIGHTJUST|SS_SIMPLE |SS_SUNKEN|SS_WHITEFRAME|SS_WHITERECT|SS_BLACKFRAME|SS_BLACKRECT'
$aStyle=StringSplit($Style, '|')

$Text='стандарт|слева|центр|справа|центр для рисунков (по вертикали для текста)|ящик|горизонтальная линия|вертикальная линия|серая кайма|серый фон|текст без авто-переноса|не подчёркивать амперсанд &|уведомление STN_CLICKED |фиксация по правому нижнему углу|в одну строку, игнорирует DISABLE|с углублением|белая кайма|белый фон|тёмная кайма|тёмный фон'
$aText=StringSplit($Text, '|')

$Gui = GUICreate("Стили Label и Graphic",  700, 410)
;GUISetBkColor (0x88dd88)
$l=10
$s=20
$h=17
$w=260

For $i = 1 to $aStyle[0]
	GUICtrlCreateLabel($aText[$i] , $l, $s*$i-$s, $w, $h, Eval($aStyle[$i]))
	GUICtrlCreateInput('$'&$aStyle[$i], $l+$w+10, $s*$i-$s, 136, $h+4)
	GUICtrlCreateInput(Eval($aStyle[$i]), $l+$w+145, $s*$i-$s, 40, $h+4)
	GUICtrlCreateLabel($aText[$i] , $l+$w+195, $s*$i-$s, $w-10, $h)
Next

GUISetState ()

Do
Until GUIGetMsg()=-3
