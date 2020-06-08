;Based on an example by RazerM:

#include <BMP3.au3>
$BMP=_BMPCreate(150,150)

For $x=0 to 50
	For $y=0 to 50
		_PixelWrite($BMP,$x,$y,'0000FF') ;blue
	Next
Next
For $x=100 to 150
	For $y=0 to 50
		_PixelWrite($BMP,$x,$y,'ff0000') ;red
	Next
Next
For $x=100 to 150
	For $y=100 to 150
		_PixelWrite($BMP,$x,$y,'00ff00') ;green
	Next
Next
For $x=0 to 50
	For $y=100 to 150
		_PixelWrite($BMP,$x,$y,'000000') ;black
	Next
Next
For $x=50 to 100
	For $y=50 to 100
		_PixelWrite($BMP,$x,$y,'999999') ;grey
	Next
Next


_BMPWrite($BMP,@ScriptDir & "\MyBMP.bmp");Closes the BMP to a file

GUICreate("Example", 200, 200)
GUICtrlCreatePic(@ScriptDir & "\MyBMP.bmp", 10, 10, 150, 150)
GUISetState()

Do
    $msg = GUIGetMsg()
Until $msg = -3;$GUI_EVENT_CLOSE
