#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ListboxConstants.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <EditConstants.au3>
#include <GUIMenu.au3>

Opt("TrayMenuMode", 1)

Global $message = "Выберите файл для измерения хеш-сумм."

$Form1 = GUICreate("Контрольные суммы файлов.", 420, 110, -1, -1, -1, $WS_EX_ACCEPTFILES)
GUISetBkColor(0xFFFFCC)
$List1 = GUICtrlCreateInput("", 5, 2, 375, 22, BitOR($GUI_SS_DEFAULT_INPUT, $ES_LEFT, $ES_READONLY))
GUICtrlSetState(-1, $GUI_DROPACCEPTED)
GUICtrlSetFont(-1, 8.5, 400, 0, "Tahoma")
GUICtrlSetTip(-1, "Перетащите сюда файл." & @CRLF & "или кликните по кнопке справа.")
$Button1 = GUICtrlCreateButton("...", 385, 1, 30, 24)
GUICtrlSetTip(-1, "Выбрать файл.")
GUICtrlSetFont(-1, 9, 700, 0, "Tahoma")
$Button2 = GUICtrlCreateButton("Очистить", 5, 27, 80, 25)
GUICtrlSetTip(-1, "Очистить строку выбора файла.")
GUICtrlSetFont(-1, 9, 700, 0, "Tahoma")
$Button3 = GUICtrlCreateButton("Вычислить", 180, 27, 80, 25)
GUICtrlSetTip(-1, "Вычислить контрольную сумму файла.")
GUICtrlSetFont(-1, 9, 700, 0, "Tahoma")
$Combo1 = GUICtrlCreateCombo("MD5", 360, 27, 55, 25)
GUICtrlSetFont(-1, 8.5, 700, 0, "Tahoma")
GUICtrlSetData(-1, "MD2|MD4|SHA1", "MD5")
GUICtrlSetTip(-1, "Выберите какую контрольную" & @CRLF & "сумму файла надо вычислить.")
$Progress1 = GUICtrlCreateProgress(5, 57, 410, 22)
GUICtrlSetState(-1, $GUI_HIDE)
$Input1 = GUICtrlCreateInput("", 5, 57, 50, 22, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_READONLY))
GUICtrlSetFont(-1, 9, 700, 0, "Tahoma")
GUICtrlSetState(-1, $GUI_HIDE)
$Input2 = GUICtrlCreateInput("", 60, 57, 285, 22, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER, $ES_READONLY))
GUICtrlSetFont(-1, 8.5, 400, 0, "Tahoma")
GUICtrlSetState(-1, $GUI_HIDE)
$Input3 = GUICtrlCreateInput("", 60, 83, 285, 22, BitOR($GUI_SS_DEFAULT_INPUT, $ES_CENTER))
GUICtrlSetFont(-1, 8.5, 400, 0, "Tahoma")
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetTip(-1, "Введите контрольную сумму для сравнения.")
$Button4 = GUICtrlCreateButton("Сравнить", 350, 83, 65, 23)
GUICtrlSetTip(-1, "Сравнить контрольные суммы.")
GUICtrlSetFont(-1, 8.5, 700, 0, "Tahoma")
GUICtrlSetState(-1, $GUI_HIDE)
GUISetState(@SW_SHOW)

While 1
    $nMsg = GUIGetMsg()
    Switch $nMsg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $GUI_EVENT_DROPPED
            GUICtrlSetData($List1, "")
            GUICtrlSetData($List1, @GUI_DragFile)
            If FileGetAttrib(@GUI_DragFile) = "D" Then
                ToolTip("Вы выбрали папку, а не файл.", Default, Default, "Контрольные суммы файлов.", 3, 1)
                GUICtrlSetData($List1, "")
                Sleep(2000)
                ToolTip("")
            Else
                GUICtrlSetTip($List1, @GUI_DragFile)
            EndIf
        Case $Button1
            _OpenFile()
        Case $Button2
            GUICtrlSetData($List1, "")
            GUICtrlSetData($Input1, "")
            GUICtrlSetData($Input2, "")
            GUICtrlSetData($Input3, "")
            GUICtrlSetState($Input1, $GUI_HIDE)
            GUICtrlSetState($Input2, $GUI_HIDE)
            GUICtrlSetState($Input3, $GUI_HIDE)
            GUICtrlSetState($Button4, $GUI_HIDE)
            GUICtrlSetTip($List1, "Перетащите сюда файл." & @CRLF & "или кликните по кнопке справа.")
        Case $Button3
            _Hash()
        Case $Button4
            _Compare()
    EndSwitch
WEnd

Func _OpenFile()
    Local $file
    $file = FileOpenDialog($message, @DesktopDir & "\", "Все файлы (*.*)", 1 + 2)
    If @error Then
        ToolTip("Вы не выбрали файл для вычисления.", Default, Default, "Контрольные суммы файлов.", 3, 1)
        Sleep(2000)
        Return ToolTip("")
    Else
        GUICtrlSetData($List1, "")
        GUICtrlSetData($List1, $file)
        GUICtrlSetTip($List1, $file)
    EndIf
EndFunc   ;==>_OpenFile

Func _Hash()
    Local $fileFromList1, $Percent
    GUICtrlSetData($Input1, "")
    GUICtrlSetData($Input2, "")
    GUICtrlSetData($Input3, "")
    GUICtrlSetState($Input1, $GUI_HIDE)
    GUICtrlSetState($Input2, $GUI_HIDE)
    GUICtrlSetState($Input3, $GUI_HIDE)
    GUICtrlSetState($Button1, $GUI_HIDE)
    GUICtrlSetState($Button2, $GUI_HIDE)
    GUICtrlSetState($Button3, $GUI_HIDE)
    GUICtrlSetState($Button4, $GUI_HIDE)
    GUICtrlSetState($Combo1, $GUI_HIDE)
    $hMenu = _GUICtrlMenu_GetSystemMenu($Form1)
    _GUICtrlMenu_EnableMenuItem($hMenu, $SC_CLOSE, 2)
    $algoritm = GUICtrlRead($Combo1, 1)
    $fileFromList1 = GUICtrlRead($List1, 1)
    If $fileFromList1 = "" Then
        ToolTip("Вы не выбрали файл для вычисления.", Default, Default, "Контрольные суммы файлов.", 3, 1)
        Sleep(2000)
        _GUICtrlMenu_EnableMenuItem($hMenu, $SC_CLOSE, 0)
        Return ToolTip("")
    EndIf
    GUICtrlSetState($Progress1, $GUI_SHOW)
    $files_size = Ceiling(FileGetSize($fileFromList1) / (1024 * 1024))
    If $algoritm = "MD5" Then
        $n = 3
    ElseIf $algoritm = "MD2" Then
        $n = 1
    ElseIf $algoritm = "MD4" Then
        $n = 2
    ElseIf $algoritm = "SHA1" Then
        $n = 0
    EndIf
    $HashedData = ObjCreate("CAPICOM.HashedData.1")
    $hFile = FileOpen($fileFromList1, 16)
    $HashedData.Algorithm() = $n
    $w = 0
    While 1
        $Buf = FileRead($hFile, 1024 * 1024)
        If @error = -1 Then ExitLoop
        $HashedData.Hash($Buf)
        $w += 1
        $Percent = $w * 100 / $files_size
        GUICtrlSetData($Progress1, $Percent)
        Sleep(2)
    WEnd
    FileClose($hFile)
    GUICtrlSetData($Progress1, "")
    GUICtrlSetState($Progress1, $GUI_HIDE)
    GUICtrlSetState($Input1, $GUI_SHOW)
    GUICtrlSetData($Input1, $algoritm)
    GUICtrlSetState($Input2, $GUI_SHOW)
    GUICtrlSetData($Input2, $HashedData.Value)
    GUICtrlSetState($Input3, $GUI_SHOW)
    GUICtrlSetState($Button1, $GUI_SHOW)
    GUICtrlSetState($Button2, $GUI_SHOW)
    GUICtrlSetState($Button3, $GUI_SHOW)
    GUICtrlSetState($Button4, $GUI_SHOW)
    GUICtrlSetState($Combo1, $GUI_SHOW)
    _GUICtrlMenu_EnableMenuItem($hMenu, $SC_CLOSE, 0)
EndFunc   ;==>_Hash

Func _Compare()
    $hash1 = GUICtrlRead($Input2, 1)
    $hash2 = GUICtrlRead($Input3, 1)
    If $hash2 = "" Then
        ToolTip("Вы не ввели сумму для сравнения.", Default, Default, "Контрольные суммы файлов.", 3, 1)
        Sleep(2000)
        Return ToolTip("")
    EndIf
    If $hash1 = $hash2 Then
        ToolTip("Контрольные суммы совпадают.", Default, Default, "Контрольные суммы файлов.", 1, 1)
        Sleep(2000)
        Return ToolTip("")
    Else
        ToolTip("Контрольные суммы не совпадают.", Default, Default, "Контрольные суммы файлов.", 3, 1)
        Sleep(2000)
        Return ToolTip("")
    EndIf
EndFunc   ;==>_Compare
 