#include <GUIConstantsEx.au3>
#include <ProgressConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>

$file = FileOpen("links.txt", 0)
If $file = -1 Then
MsgBox(0, "Error", "Unable to open file.")
Exit
EndIf

$1 = FileReadLine($file, 1)
$2 = FileReadLine($file, 2)
$3 = FileReadLine($file, 3)
$4 = FileReadLine($file, 4)
$5 = FileReadLine($file, 5)
$6 = FileReadLine($file, 6)
$7 = FileReadLine($file, 7)
$8 = FileReadLine($file, 8)
$9 = FileReadLine($file, 9)
$10 = FileReadLine($file, 10)
$11 = FileReadLine($file, 11)
$12 = FileReadLine($file, 12)
$13 = FileReadLine($file, 13)
$14 = FileReadLine($file, 14)
$15 = FileReadLine($file, 15)
$16 = FileReadLine($file, 16)
$17 = FileReadLine($file, 17)
$18 = FileReadLine($file, 18)
$19 = FileReadLine($file, 19)
$20 = FileReadLine($file, 20)



Dim $Array , $complete = False
DownloadserMultiFiles($Array, $1, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $2, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $3, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $4, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $5, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $6, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $7, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $8, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $9, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $10, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $11, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $12, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $13, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $14, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $15, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $16, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $17, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $18, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $19, @ScriptDir & "\Downloads")
DownloadserMultiFiles($Array, $20, @ScriptDir & "\Downloads")

While 1
if $complete = False Then
$complete = ProgressLoop($Array,$complete)
Else
MsgBox(0,"","Downloads is complete")
Exit
EndIf
WEnd

Func ProgressLoop($Array,$complete = False)
if $complete = False Then
Dim $TempArray[1][7]
$complete = True
For $i = 0 To UBound($Array) - 1
Sleep(250)
$read = InetGetInfo($Array[$i][5],0)
$Size = InetGetInfo($Array[$i][5],1)
$Array[$i][6] += $read
$CompBool = InetGetInfo($Array[$i][5],2)
$error = @error
GUICtrlSetData($Array[$i][3],(100 / $Size) * $read)
GUICtrlSetData($Array[$i][4],"( " & StringLeft(int($read / 1024) / 1000 ,8) _
& " OF " & StringLeft(int($Size /1024) / 1000 ,8) & " ) MB")
if $CompBool = False And Not $error Then
$complete = False
$TempArray[UBound($TempArray) -1][0] = $Array[$i][0]
$TempArray[UBound($TempArray) -1][1] = $Array[$i][1]
$TempArray[UBound($TempArray) -1][2] = $Array[$i][2]
$TempArray[UBound($TempArray) -1][3] = $Array[$i][3]
$TempArray[UBound($TempArray) -1][4] = $Array[$i][4]
$TempArray[UBound($TempArray) -1][5] = $Array[$i][5]
$TempArray[UBound($TempArray) -1][6] = $Array[$i][6]
ReDim $TempArray[UBound($TempArray) +1][7]
Else
InetClose($Array[$i][5])
EndIf
Next
if $complete Then GUIDelete($Array[0][2])
if UBound($TempArray) > 1 Then
ReDim $TempArray[UBound($TempArray) - 1][7]
Else
$TempArray = 0
EndIf
$Array = $TempArray
Return $complete
EndIf
EndFunc

Func DownloadserMultiFiles(ByRef $Array,$link,$OutDir)
if Not IsArray($Array) Then
Dim $Array[1][7]
$Array[0][2] = GUICreate("QDownloader", 590, 140, 100, 200, _
BitOR($WS_MINIMIZEBOX,$WS_SYSMENU,$WS_CAPTION,$WS_POPUP,$WS_POPUPWINDOW _
,$WS_GROUP,$WS_BORDER,$WS_CLIPSIBLINGS))
GUISetState(@SW_SHOW)
Else
ReDim $Array[UBound($Array) + 1][7]
EndIf
if StringRight($OutDir,1) == "\" Then $OutDir = StringTrimRight($OutDir,1)
if Not FileExists($OutDir) Then DirCreate($OutDir)
$FileName = StringSplit($link,"/")
$FileName = $FileName[$FileName[0]]
$OutDir &= "\" & $FileName
$Array[UBound($Array) - 1][0] = $link
$Array[UBound($Array) - 1][1] = $OutDir
$Array[UBound($Array) - 1][3] = GUICtrlCreateProgress(190, 10 + ((UBound($Array) - 1) * 30), 200, 20)
GUICtrlCreateLabel($FileName, 10, 10 + ((UBound($Array) - 1) * 30), 170, 20, BitOR($SS_CENTER,$WS_BORDER))
GUICtrlSetFont(-1, 10, 600, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Array[UBound($Array) - 1][4] = GUICtrlCreateLabel("", 400, 10 + ((UBound($Array) - 1) * 30), 170, 20,BitOR($SS_CENTER,$WS_BORDER))
GUICtrlSetFont(-1, 10, 600, 0, "MS Sans Serif")
GUICtrlSetBkColor(-1, 0xFFFFFF)
$Array[UBound($Array) - 1][5]  = InetGet($Array[UBound($Array) - 1][0],$Array[UBound($Array) - 1][1], 1, 1)
Sleep(1500)
EndFunc


 