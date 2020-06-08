#include <_GUIEditSetDefault.au3>

GUICreate ("Testing")

$hEdit = GUICtrlCreateInput ("", 2, 2, 100, 20)
_GUIEditSetDefault ($hEdit, "This is the test")

$hEdit2 = GUICtrlCreateInput ("", 2, 24, 80, 20)
_GUIEditSetDefault ($hEdit2, "Take 2.")

GUISetState ()

While GUIGetMsg () <> -3
    Sleep (10)
WEnd