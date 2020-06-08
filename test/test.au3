#include <GUIConstantsEx.au3>
#include <Array.au3>

Local $user, $button, $msg
Local $button1[2], $Options1[2], $Options2[2]
$Options1[0] = -1
$Options1[1] = -1
$Options2[0] = -1
$Options2[1] = -1

GUICreate("Dummy - пустышка", 270, 500, 100, 200)

$button = GUICtrlCreateButton("Создать", 10, 160, 70, 28)
GUISetState()

Do
    $msg = GUIGetMsg()

    Switch $msg
		Case $button
			For $i=0 To 1
				$button1[$i] = GUICtrlCreateButton("Тут контекст", 190, ($i*35), 70, 28)
				$OptionsContext = GUICtrlCreateContextMenu($button1[$i])

				$Options1[$i] = GUICtrlCreateMenuItem("Удалить", $OptionsContext)
				$Options2[$i] = GUICtrlCreateMenuItem("Редактировать", $OptionsContext)
			Next

        Case $Options1[0]
			ConsoleWrite("!!!" & @CRLF)
		Case $Options1[1]
			ConsoleWrite("+++" & @CRLF)
		Case $Options2[0]
			ConsoleWrite("!!!___" & @CRLF)
		Case $Options2[1]
			ConsoleWrite("+++___" & @CRLF)
    EndSwitch
Until $msg = $GUI_EVENT_CLOSE