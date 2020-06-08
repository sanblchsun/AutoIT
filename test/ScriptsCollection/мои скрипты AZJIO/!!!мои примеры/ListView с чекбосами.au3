#include <GUIConstantsEx.au3>
#include <GuiListView.au3>
#include <ListViewConstants.au3>
#include <WindowsConstants.au3>
$hGUI= GUICreate("Тест ListView", 220, 180)
; тире делает колонку шире, стили скрывают заголовок колонки, сохранять выделение при потери фокуса; дополнительные стили - подсветка всей выбранной строки, чекбоксы в списке
$hListView = GUICtrlCreateListView  ('---------------' ,5,5,210,70 , $LVS_NOCOLUMNHEADER + $LVS_SHOWSELALWAYS, $LVS_EX_FULLROWSELECT + $LVS_EX_CHECKBOXES+$WS_EX_CLIENTEDGE)
GUICtrlSetBkColor(-1,0xf0f0f0) ; 0xE0DFE3 - цвет стандартный серый
$item1=_GUICtrlListView_AddItem($hListView,'итем' ) ; создаём пункты
$item2=_GUICtrlListView_AddItem($hListView,'ха' )
$item3=_GUICtrlListView_AddItem($hListView,'новое' )
$item4=_GUICtrlListView_AddItem($hListView,'вот ещё' )
  
_GUICtrlListView_SetItemChecked($hListView,$item1) ; отмечаем галочкой чекбоксы
_GUICtrlListView_SetItemChecked($hListView, $item3)

$start=GUICtrlCreateButton ("жми", 135,95,55,22)
$Pos=GUICtrlCreateButton ("размер", 35,95,55,22)
GUICtrlCreateLabel ('В отличии от обычных чекбоксов в окне, в ListView есть прокрутка в ящике, если строки не вмещаются.', 5,125,210,50)

GUISetState   ()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $start ; проверяем галочки в чекбоксах
			If _GUICtrlListView_GetItemChecked($hListView,$item1)=1 Then MsgBox(0, "Сообщение",' "итем" отмечен.', 4)
			If _GUICtrlListView_GetItemChecked($hListView,$item2)=1 Then MsgBox(0, "Сообщение",' "ха" отмечен.', 4)
			If _GUICtrlListView_GetItemChecked($hListView,$item3)=1 Then MsgBox(0, "Сообщение",' "новое" отмечен.', 4)
			If _GUICtrlListView_GetItemChecked($hListView,$item4)=1 Then MsgBox(0, "Сообщение",' "вот ещё" отмечен.', 4)
		Case $msg = $Pos ; меняем размер для проверки скрола
			GUICtrlSetPos ($hListView, 5,5,210,80)
		Case $msg = -3
			ExitLoop
	EndSelect
WEnd