;Требуется AutoIt3Wrapper, ResHacker.exe, Resources.au3 для компилирования скрипта содержащего внутри себя ресурсы.

#Region AutoIt3Wrapper
#AutoIt3Wrapper_Icon=MyIcon.ico
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Res_Description=Resources Test Script
#AutoIt3Wrapper_Res_Fileversion=1.0.0.0
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Run_After=copy %autoitdir%\SciTE\ResHacker\ResHacker.exe %scriptdir%
#AutoIt3Wrapper_Run_After=ResHacker.exe -add %out%, %out%, MyPicture.jpg,  RCData, 400, 0
#AutoIt3Wrapper_Run_After=ResHacker.exe -add %out%, %out%, MySound.wav, SOUND, 200, 0
#AutoIt3Wrapper_Run_After=del %scriptdir%\ResHacker.exe
#AutoIt3Wrapper_Run_After=del %scriptdir%\ResHacker.ini
#AutoIt3Wrapper_Run_After=del %scriptdir%\ResHacker.log
#EndRegion AutoIt3Wrapper

#Include <Resources.au3>

$hForm = GUICreate('MyGUI', 512, 384)
GUICtrlCreatePic('', 0, 0, 512, 384)
_ResSetImageToCtrl(-1, '#400')
GUISetState()

_ResPlaySound('#200')

Do
Until GUIGetMsg() = -3
