
; http://www.script-coding.com/AutoIT.html

$startColor = 0xff0000
Const $WM_INITDIALOG            = 0x0110 
Const $CC_ANYCOLOR              = 0x100
Const $CC_RGBINIT               = 0x1
Const $CC_FULLOPEN              = 0x2
Const $CC_PREVENTFULLOPEN       = 0x4
Const $CC_SHOWHELP              = 0x8
Const $CC_ENABLEHOOK            = 0x10
Const $CC_ENABLETEMPLATE        = 0x20
Const $CC_ENABLETEMPLATEHANDLE  = 0x40
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;�������� ��������� CHOOSECOLOR
$CHOOSECOLOR = DllStructCreate( _
    'dword;' & _ ;������ ���������, ����
    'int;'   & _ ;���������� ���� ����������� ������
    'int;'   & _ ;����� ������� ������ ����������� ������
    'int;'   & _ ;��������� ����, ������ �� ���������� ������� ���������� �����
    'ptr;'   & _ ;��������� �� 16 ���������� ������ �������
    'dword;' & _ ;���������� ������
    'int;'   & _ ;������ ���������-�������
    'ptr;'   & _ ;��������� �� ��������� ������
    'ptr')       ;��������� �� ������-��� ������� �������
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;�������� ��������� ������ ������
$template = ''
for $i=1 to 16
    $template=$template & "int;"
next
$template = StringTrimRight($template, 1)
Local $palette = DllStructCreate($template)
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;���������� ��������� ������ ������
DllStructSetData($palette, 1, $startColor)
for $i=2 to 16
    DllStructSetData($palette, $i, 0xffffff)
next
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;���������� ��������� CHOOSECOLOR
DllStructSetData($CHOOSECOLOR, 1, DllStructGetSize($CHOOSECOLOR))
DllStructSetData($CHOOSECOLOR, 2, 0)
DllStructSetData($CHOOSECOLOR, 4, $startColor)
DllStructSetData($CHOOSECOLOR, 5, DllStructGetPtr($palette))
DllStructSetData($CHOOSECOLOR, 6, BitOR($CC_ANYCOLOR, $CC_FULLOPEN, $CC_RGBINIT))
DllStructSetData($CHOOSECOLOR, 7, $WM_INITDIALOG)
DllStructSetData($CHOOSECOLOR, 8, "CCHookProc")
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;����� �������
$result = DllCall('comdlg32.dll', 'long', 'ChooseColor', _
                  'ptr', DllStructGetPtr($CHOOSECOLOR))
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;��������� ��������� �����
if not $result[0] then return -1
    $color = DllStructGetData($CHOOSECOLOR, 4)
    $color = hex($color)
    $blue = StringMid ($color,3,2)
    $green = StringMid ($color,5,2)
    $red = StringMid ($color,7,2)
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;����������� ���������
msgbox(64, "��������� ����", _
       "�������: " & dec($red)        & @CRLF & _
       "�������: " & dec($green)    & @CRLF & _
       "�����: "   & dec($blue))
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$CHOOSECOLOR = 0
$palette = 0
