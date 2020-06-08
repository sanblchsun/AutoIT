#NoTrayIcon

#include <Misc.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#include <GuiEdit.au3>
#include <String.au3>

$WIDTH = 800
$HEIGHT = 600
$EXT1 = "|Text Documents (*.txt)"
$EXT2 = "|AutoIt Scripts (*.au3)"
$EXT3 = "|All Files(*.*)"
$EXT = $EXT1 & $EXT2 & $EXT3
$SETTINGS = "Settings.ini"

Global $FILESAVE, $FILEOPEN = "", $SAVES, $SAVE, $FILEOPENED = 0

$FONTSIZE = IniRead($SETTINGS, "font", "size", 10)
$FONTWEIGHT = IniRead($SETTINGS, "font", "weight", 500)
$FONTATTRIB = IniRead($SETTINGS, "font", "attrib", "")
$FONTSTYLE = IniRead($SETTINGS, "font", "font", "Lucida Console")

$MAINGUI = GUICreate("Text Editor", $WIDTH, $HEIGHT, -1, -1, $WS_OVERLAPPEDWINDOW + $WS_VISIBLE)

$EDITBOX = GUICtrlCreateEdit("", 0, 0, $WIDTH, $HEIGHT - 20, -1)

$FILE = GUICtrlCreateMenu("File")

$NEW = GUICtrlCreateMenuItem("New", $FILE)
$OPEN = GUICtrlCreateMenuItem("Open...", $FILE)
$SAVE = GUICtrlCreateMenuItem("Save", $FILE)
$SAVEAS = GUICtrlCreateMenuItem("Save As...", $FILE)
$PRINT = GUICtrlCreateMenuItem("Print...", $FILE)

GUICtrlCreateMenuItem("", $FILE)

$EXIT = GUICtrlCreateMenuItem("Exit", $FILE)

$EDIT = GUICtrlCreateMenu("Edit")
$UNDO = GUICtrlCreateMenuItem("Undo", $EDIT)

$FONT = GUICtrlCreateMenuItem("Font", $EDIT)

GUICtrlSetFont($EDITBOX, $FONTSIZE, $FONTWEIGHT, $FONTATTRIB, $FONTSTYLE)

GUISetState(@SW_SHOW & $GUI_ACCEPTFILES)

While 1
    $Msg = GUIGetMsg()
    Select

        Case $Msg = $GUI_EVENT_CLOSE
            If _GUICtrlEdit_CanUndo($EDITBOX) Then
                $SAVECHANGES = MsgBox(35, "Text Editor", "Your original file has been modified." & @CRLF & "Would you like to save changes to it?")
                If $SAVECHANGES = 6 And $FILEOPENED = 0 Then
                    SaveAs()
                    Exit
                EndIf
                If $SAVECHANGES = 6 And $FILEOPENED = 1 Then
                    FileDelete($FILEOPEN)
                    FileWrite($FILEOPEN, GUICtrlRead($EDITBOX))
                    Exit
                EndIf
                If $SAVECHANGES = 7 Then
                    ExitLoop
                    Exit
                EndIf
            EndIf
            If Not _GUICtrlEdit_CanUndo($EDITBOX) Then Exit

        Case $Msg = $OPEN
            $FILEOPEN = FileOpenDialog("Open", $FILEOPEN, $EXT)
            $TEXT = FileRead($FILEOPEN, FileGetSize($FILEOPEN))
            GUICtrlSetData($EDITBOX, $TEXT)
            $FILEOPENED = 1

        Case $Msg = $NEW
            If _GUICtrlEdit_CanUndo($EDITBOX) Then
                $SAVECHANGES = MsgBox(35, "Text Editor", "Your original file has been modified." & @CRLF & "Would you like to save changes to it?")
                If $SAVECHANGES = 6 And $FILEOPENED = 0 Then
                    SaveAs()
                EndIf
                If $SAVECHANGES = 6 And $FILEOPENED = 1 Then
                    FileDelete($FILEOPEN)
                    FileWrite($FILEOPEN, GUICtrlRead($EDITBOX))
                EndIf
                If $SAVECHANGES = 7 Then GUICtrlSetData($EDITBOX, "")
                If $SAVECHANGES = 2 Then Sleep(1)
            EndIf
            If Not _GUICtrlEdit_CanUndo($EDITBOX) Then GUICtrlSetData($EDITBOX, "")
            $FILEOPENED = 0

        Case $Msg = $EXIT
            If _GUICtrlEdit_CanUndo($EDITBOX) Then
                $SAVECHANGES = MsgBox(35, "Text Editor", "Your original file has been modified." & @CRLF & "Would you like to save changes to it?")
                If $SAVECHANGES = 6 And $FILEOPENED = 0 Then
                    SaveAs()
                    Exit
                EndIf
                If $SAVECHANGES = 6 And $FILEOPENED = 1 Then
                    FileDelete($FILEOPEN)
                    FileWrite($FILEOPEN, GUICtrlRead($EDITBOX))
                    Exit
                EndIf
                If $SAVECHANGES = 7 Then ExitLoop
                If $SAVECHANGES = 2 Then
                    Sleep(1)
                EndIf
            EndIf
            If Not _GUICtrlEdit_CanUndo($EDITBOX) Then Exit

        Case $Msg = $SAVEAS
            GUICtrlSetState($EDITBOX, $GUI_DISABLE)
            SaveAs()
            $FILEOPENED = 1
            GUICtrlSetState($EDITBOX, $GUI_ENABLE)

        Case $Msg = $SAVE And $FILEOPENED = 1
            FileDelete($FILEOPEN)
            FileWrite($FILEOPEN, GUICtrlRead($EDITBOX))
            _GUICtrlEdit_EmptyUndoBuffer($EDITBOX)

        Case $Msg = $SAVE And $FILEOPENED = 0
            GUICtrlSetState($EDITBOX, $GUI_DISABLE)
            SaveAs()
            $FILEOPENED = 1
            GUICtrlSetState($EDITBOX, $GUI_ENABLE)

        Case $Msg = $FONT
            $FONTCHOOSE = _ChooseFont($FONTSTYLE, $FONTSIZE, 0, $FONTWEIGHT)
            If Not @error Then
                GUICtrlSetFont($EDITBOX, $FONTCHOOSE[3], $FONTCHOOSE[4], $FONTCHOOSE[1], $FONTCHOOSE[2])
                IniWrite($SETTINGS, "font", "attrib", $FONTCHOOSE[1])
                IniWrite($SETTINGS, "font", "font", $FONTCHOOSE[2])
                IniWrite($SETTINGS, "font", "size", $FONTCHOOSE[3])
                IniWrite($SETTINGS, "font", "weight", $FONTCHOOSE[4])
            EndIf

        Case $Msg = $SAVE And $FILEOPENED = 0
            GUICtrlSetState($EDITBOX, $GUI_DISABLE)
            SaveAs()
            $FILEOPENED = 1
            GUICtrlSetState($EDITBOX, $GUI_ENABLE)

        Case $Msg = $PRINT
            $PRINTMSGBOX = MsgBox(35, "Text Editor", "Are you sure you want to print this page?")
            Select

                Case $PRINTMSGBOX = 6
                    If FileExists("Print.txt") Then
                        FileDelete("Print.txt")
                    EndIf
                    FileWrite("Print.txt", GUICtrlRead($EDITBOX))
                    $PRINTFILE = "Print.txt"
                    _FilePrint($PRINTFILE)
                    FileDelete($PRINTFILE)
            EndSelect

        Case $Msg = $UNDO
            _GUICtrlEdit_Undo($EDITBOX)

        Case _GUICtrlEdit_CanUndo($EDITBOX) And $SAVES = 1
            GUICtrlSetState($SAVE, $GUI_ENABLE)
            $SAVES = 0

        Case Not _GUICtrlEdit_CanUndo($EDITBOX) And $SAVES = 0
            GUICtrlSetState($SAVE, $GUI_DISABLE)
            $SAVES = 1
    EndSelect
WEnd
Exit

Func SaveAs()
    $FILESAVEAS = FileSaveDialog("Save As", "", "Text Document (*.txt)|All Files (*.*)")
    If Not @error Then
        $STRING = StringSplit($FILESAVEAS, ".")
        If $STRING[0] = 1 Then
            FileDelete($FILESAVEAS)
            FileWrite($FILESAVEAS & ".txt", GUICtrlRead($EDITBOX))
        Else
            FileWrite($FILESAVEAS, GUICtrlRead($EDITBOX))
        EndIf
    EndIf
EndFunc