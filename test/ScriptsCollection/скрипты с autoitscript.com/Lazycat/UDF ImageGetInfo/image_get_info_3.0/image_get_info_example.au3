#include "image_get_info.au3"
Global $file, $time, $aInfo
$file = FileOpenDialog("Please select file", "", "Image files (*.jpg;*.tif;*.gif;*.bmp;*.png)");
If @error Then Exit
$time = TimerInit()
$aInfo = _ImageGetInfo($file)
Switch @error
    Case 0
        MsgBox (0, "All Picture Info (reading done in " & Round(TimerDiff($time), 2) & " ms.)", $aInfo)
        MsgBox (0, "Only Width and Height", _ImageGetParam($aInfo, "Width") & "x" & _ImageGetParam($aInfo, "Height"))
    Case 1
        MsgBox (0, "Error", "Can't open file.")
    Case 2
        MsgBox (0, "All Picture Info (can be partial, error occured while parsing)", $aInfo)
EndSwitch