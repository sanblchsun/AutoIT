#Region;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=readData.exe
#EndRegion;**** Directives created by AutoIt3Wrapper_GUI ****
; My first DLLCall
; ptrex

#include <GUIConstants.au3>
#include <GuiConstantsEx.au3>
#include <GUIedit.au3>
;Opt("WinTitleMatchMode", 4); Allow ClassName lookup

; Global Const $EM_GETLINE = 0xC4

Dim $LineCount
Dim $LineNum
Dim $Ret
Dim $LineLen
Dim $FirstCharPos
Dim $Buffer

Run("notepad")
WinActivate("[class:Notepad]", "")
WinWaitActive("[class:Notepad]", "")
Local $Applhandle = WinGetHandle(""); [class:Notepad]")
Local $Ctrlhandle = ControlGetHandle("", "", "Edit1")
ConsoleWrite("$Ctrlhandle " & $Ctrlhandle & @CRLF)


WinHandle()
Local $sFile = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt", "InstallDir") & "\include\changelog.txt"

; Create GUI
_GUICtrlEdit_SetText($Ctrlhandle, FileRead($sFile))

CtrlRead($Ctrlhandle)
$str = ControlGetText("", "", "[Class:Edit]")
;MsgBox(0,"Test",$str)

Func WinHandle(); tested = OK
    $result = DllCall("user32.dll", "int", "MessageBox", "hwnd", $Applhandle, "str", "Control Window Active " & $Ctrlhandle, "str", "Handle Test", "int", 0)
EndFunc   ;==>WinHandle

Func CtrlReadLineNum($Ctrlhandle); tested = OK

    $Ctrlread = _GUICtrlEdit_GetLineCount($Ctrlhandle)
    MsgBox(0, "Test", "Line #" & " " & $Ctrlread)
EndFunc   ;==>CtrlReadLineNum

Func LineIndex($Ctrlhandle); tested = OK
    $Ctrlread = _GUICtrlEdit_LineIndex($Ctrlhandle)
    MsgBox(0, "Test", "Line Index" & " " & $Ctrlread)
EndFunc   ;==>LineIndex

Func LineLenght($Ctrlhandle); tested = OK
    $Ctrlread = _GUICtrlEdit_LineLength($Ctrlhandle)
    MsgBox(0, "Test", "Line Lenght" & " " & $Ctrlread)
EndFunc   ;==>LineLenght

Func CtrlRead($Ctrlhandle); tested = OK
    $LineCount = _GUICtrlEdit_GetLineCount($Ctrlhandle)
    MsgBox(0, "Test", "Line #" & " " & $LineCount)
    For $LineNum = 0 To $LineCount - 1
        $return = MsgBox(1, "Test", "Text is =" & " " & _GUICtrlEdit_GetLine($Ctrlhandle, $LineNum))
        If $return = 2 Then ExitLoop
    Next
EndFunc   ;==>CtrlRead