#include <Array.au3>
#include <HSB_RGB_BGR.au3>
Global $data[4] = ['C738B9', 0xC738B9, 13056185, '199, 56, 185']
For $i = 3 To 3
	_ArrayDisplay(_ColorToArray($data[$i]), $data[$i])
Next

; �������� ���� ������, ������ ������ ���������� ����� �����
; $i = _ColorToArray($data[3])
; MsgBox(0, '���������', VarGetType($i[0]))