#include <GUIConstants.au3>
#include <WindowsConstants.au3>

$chars1=''
$chars2=''
$chars3=''

$Gui = GUICreate("Кинь в меня SETUPLDR.BIN", 340, 100, -1, -1, -1, $WS_EX_ACCEPTFILES)
$CatchDrop = GUICtrlCreateLabel("", -1, -1, 340, 100)
GUICtrlSetState(-1, $GUI_DISABLE + $GUI_DROPACCEPTED)
GUICtrlCreateLabel("Кинь сюда SETUPLDR.BIN, чтобы увидеть его параметры", 10, 3, 340, 20)

$Label1=GUICtrlCreateLabel ('', 5,25,75,20)
$Label2=GUICtrlCreateLabel ('', 5,50,75,20)
$Label3=GUICtrlCreateLabel ('', 5,75,75,20)
$Label4=GUICtrlCreateLabel ('', 160,25,190,20)
$byfer1=GUICtrlCreateButton ("в буфер", 370,20,55,22)
$byfer2=GUICtrlCreateButton ("в буфер", 370,45,55,22)
$byfer3=GUICtrlCreateButton ("в буфер", 370,70,55,22)

$Label5=GUICtrlCreateLabel ('', 150,75,180,20)

GUISetState(@SW_SHOW, $Gui)

While 1
    $msg = GUIGetMsg()
    Switch $msg
        Case $byfer1
            ClipPut($chars1)
            GUICtrlCreateGroup("", 145, 65, 190, 30)
            GUICtrlSetData($Label5, 'Скопировано в буфер '&$chars1)
        Case $byfer2
            ClipPut($chars2)
            GUICtrlCreateGroup("", 145, 65, 190, 30)
            GUICtrlSetData($Label5, 'Скопировано в буфер '&$chars2)
        Case $byfer3
            ClipPut($chars3)
            GUICtrlCreateGroup("", 145, 65, 190, 30)
            GUICtrlSetData($Label5, 'Скопировано в буфер '&$chars3)
        Case $GUI_EVENT_DROPPED
                AddDropedFiles(@GUI_DRAGFILE)
        Case $GUI_EVENT_CLOSE
            Exit
    EndSwitch
WEnd

;=============================================================
Func AddDropedFiles($gaDropFiles)
$gaDropFiles1=FileGetSize ( $gaDropFiles )
If $gaDropFiles1=298096 Or $gaDropFiles1=302192 Or $gaDropFiles1=314480 Or $gaDropFiles1=318576 Then
$file = FileOpen($gaDropFiles,16)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
 EndIf
 
 ; Read in 1 character at a time until the EOF is reached
While 1
    $chars = FileRead($file)
    If @error = -1 Then ExitLoop
	   $chars1 = BinaryToString('0x'&StringMid($chars, 383701, 8))
	   $chars2 = BinaryToString('0x'&StringMid($chars, 345775, 18))
	   $chars3 = BinaryToString('0x'&StringMid($chars, 346631, 24))
       $size1 = Round($gaDropFiles1/1024, 0)
Wend

FileClose($file)
EndIf



If $gaDropFiles1=261376 Then
$file = FileOpen($gaDropFiles,16)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
 EndIf
 
 ; Read in 1 character at a time until the EOF is reached
While 1
    $chars = FileRead($file)
    If @error = -1 Then ExitLoop
	   $chars1 = BinaryToString('0x'&StringMid($chars, 314041, 8))
	   $chars2 = BinaryToString('0x'&StringMid($chars, 281287, 18))
	   $chars3 = BinaryToString('0x'&StringMid($chars, 281807, 24))
       $size1 = Round($gaDropFiles1/1024, 0)
Wend

FileClose($file)
EndIf



If $gaDropFiles1=247024 Then
$file = FileOpen($gaDropFiles,16)

; Check if file opened for reading OK
If $file = -1 Then
    MsgBox(0, "Error", "Unable to open file.")
    Exit
 EndIf
 
 ; Read in 1 character at a time until the EOF is reached
While 1
    $chars = FileRead($file)
    If @error = -1 Then ExitLoop
	   $chars1 = BinaryToString('0x'&StringMid($chars, 246473, 8))
	   $chars2 = BinaryToString('0x'&StringMid($chars, 265063, 18))
	   $chars3 = BinaryToString('0x'&StringMid($chars, 265583, 24))
       $size1 = Round($gaDropFiles1/1024, 0)
Wend

FileClose($file)
EndIf
If $gaDropFiles1=298096 Or $gaDropFiles1=302192 Or $gaDropFiles1=314480 Or $gaDropFiles1=318576 Or $gaDropFiles1=261376 Or $gaDropFiles1=247024 Then
	GUICtrlSetData($Label1, $chars1)
	GUICtrlSetData($Label2, $chars2)
	GUICtrlSetData($Label3, $chars3)
	GUICtrlSetData($Label4, 'Размер: '&$gaDropFiles1&' байт     ('&$size1&'кб)')
GUICtrlSetPos($byfer1, 80,20)
GUICtrlSetPos($byfer2, 80,45)
GUICtrlSetPos($byfer3, 80,70)
Else
    MsgBox(0, "Левый файл", 'Невозможно угадать файл.')
EndIf
EndFunc 