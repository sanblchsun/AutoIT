#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global $Init = 0

AutoItSetOption("GUIOnEventMode", 1)
$Form1 = GUICreate("Form1", 255, 87, 320, 174)
$Button1 = GUICtrlCreateButton("Старт", 88, 48, 75, 25)
GUICtrlSetOnEvent(-1, "start")
GUISetOnEvent($GUI_EVENT_CLOSE, "FExit")
GUISetState(@SW_SHOW)

While 1
    Sleep(10)
    If $Init Then
        Progress()
        $Init = 0
    EndIf
WEnd

Func FExit()
    Exit
EndFunc   ;==>FExit

Func Progress()
    $ProgressBar = GUICreate("Отправка сообщений", 327, 133, -1, -1)
    $Progress1 = GUICtrlCreateProgress(8, 29, 262, 16)
    $ButtonCancelProg = GUICtrlCreateButton("Отмена", 194, 99, 75, 25)
    GUICtrlSetOnEvent(-1, "FunctionButtonCancel")
    GUISetState(@SW_SHOW, $ProgressBar)
    For $n = 1 To 10
        Sleep(1000)
        $ProgressProcent = Floor($n * 100 / 10)
        GUICtrlSetData($Progress1, $ProgressProcent)
    Next
    GUIDelete($ProgressBar)
EndFunc   ;==>Progress

Func start()
    $Init = 1
EndFunc   ;==>start

Func FunctionButtonCancel()
    MsgBox(0, '', 'Нажата клавиша Отмена')
    Exit
EndFunc   ;==>FunctionButtonCancel