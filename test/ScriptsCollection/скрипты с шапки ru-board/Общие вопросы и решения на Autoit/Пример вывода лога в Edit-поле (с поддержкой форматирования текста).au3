#include <GUIConstants.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <GuiRichEdit.au3>
;

Opt("GUIOnEventMode", 1)

$hGUI = GUICreate("GUI Log Demo", 320, 200, -1, -1, BitOR($GUI_SS_DEFAULT_GUI, $WS_CLIPSIBLINGS))
GUISetOnEvent($GUI_EVENT_CLOSE, "_GUI_Events")

$hRichText = RichText_Create($hGUI, 0, 0, 320, 200)
RichText_SetReadOnly($hRichText, True)

GUISetState(@SW_SHOW, $hGUI)

Copy_Process()

While 1
    Switch GUIGetMsg()
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
WEnd

Func _GUI_Events()
    Switch @GUI_CtrlId
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
EndFunc

Func Copy_Process()
    For $i = 0 To 4
        _Write_GUI_Log("Копирую " & _FileGetRandomName(".ext") & "... ", 1, 0x666666)
        Sleep(1500)
        _Write_GUI_Log("Успешно!" & @CRLF & @CRLF, 1, 0x008000, True)

        Sleep(1000)

        _Write_GUI_Log("Архивирую " & _FileGetRandomName(".ext") & "... ", 1, 0x666666)
        Sleep(1500)
        _Write_GUI_Log("Ошибка!" & @CRLF & @CRLF, 1, 0x0000FF, True)

        Sleep(1000)
    Next

    For $i = 5 To 1 Step -1
        _Write_GUI_Log("Завершение работы через... ", 0)
        _Write_GUI_Log($i, 1, 0x0000FF, True)

        Sleep(1000)
    Next

    Exit
EndFunc

Func _Write_GUI_Log($sData, $iAppend = True, $iColor = 0, $iBold = False, $iItalic = False, $iUnderline = False, $iFontSize = 8)
    Local $sCurrent_Data = RichText_GetText($hRichText)

    If $iAppend Then
        RichText_AppendText($hRichText, $sData)
    Else
        RichText_SetText($hRichText, $sData)
    EndIf

    Local $iSelStart = StringLen($sCurrent_Data)
    Local $iSelLength = StringLen($sData)

    RichText_SetSel($hRichText, $iSelStart, $iSelStart + $iSelLength)

    RichText_SetColor($hRichText, $iColor, True)
    RichText_SetBold($hRichText, $iBold, True)
    RichText_SetItalic($hRichText, $iItalic, True)
    RichText_SetFontSize($hRichText, $iFontSize, True)
    RichText_SetUnderline($hRichText, $iUnderline)

    RichText_SetSel($hRichText, -1, -1); Set the selection to -1 (to scroll to the end)
EndFunc

Func _FileGetRandomName($sExt, $i_RandomLength=7)
    Local $s_TempName = ""

    While StringLen($s_TempName) < $i_RandomLength
        $s_TempName &= Chr(Random(97, 122, 1))
    WEnd

    Return $s_TempName & $sExt
EndFunc