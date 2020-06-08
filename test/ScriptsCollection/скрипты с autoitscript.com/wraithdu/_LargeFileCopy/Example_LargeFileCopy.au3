#NoTrayIcon
#AutoIt3Wrapper_Au3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <_LargeFileCopy.au3>

_Main()

Func _Main()
    Local $msg, $timer, $ret
    Local $src = "D:\Large\file.avi" ; <---- path to a really large file goes here, recommended 600MB+
    Local $destpath ="C:\testdir" ; <---- destination path goes here
    GUICreate("File Copy Test", 250, 150)
    GUICtrlCreateLabel("Try to interact with the GUI during file copy...", 20, 15)
    Local $go = GUICtrlCreateButton("Copy Large File", 50, 50, 150, 50)
    Local $doing = GUICtrlCreateLabel("Ready...", 20, 120, 200)
    GUISetState()

    Do
        $msg = GUIGetMsg()
        If $msg = $go Then
            ; create destination path
            DirCreate($destpath)
            ; internal FileCopy() function
            GUICtrlSetData($doing, "FileCopy()...")
            $timer = TimerInit()
            ConsoleWrite("FileCopy:" & @CRLF)
            $ret = FileCopy($src, $destpath, 1)
            ConsoleWrite("return: " & $ret & @CRLF & "error: " & @error & @CRLF & "time: " & TimerDiff($timer) & " ms" & @CRLF)
            ConsoleWrite("====================" & @CRLF)
            ; _LargeFileCopy() UDF function
            GUICtrlSetData($doing, "_LargeFileCopy()...")
            $timer = TimerInit()
            ConsoleWrite("_LargeFileCopy:" & @CRLF)
            $ret = _LargeFileCopy($src, $destpath, 1)
            ConsoleWrite("return: " & $ret & @CRLF & "error: " & @error & @CRLF & "time: " & TimerDiff($timer) & " ms" & @CRLF)
            ConsoleWrite("====================" & @CRLF)
            GUICtrlSetData($doing, "Ready...")
        EndIf
    Until $msg = -3
EndFunc