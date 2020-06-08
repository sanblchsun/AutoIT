#include <ScreenCapture.au3> 
 
; Capture full screen, скрин всего экрана
_ScreenCapture_Capture(@ScriptDir & "\GDIPlus_Image1.jpg") 
 
; Capture region, скрин указанного в координатах участка экрана
_ScreenCapture_Capture(@ScriptDir & "\GDIPlus_Image2.jpg", 0, 0, 796, 596) 