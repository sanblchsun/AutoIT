
; http://www.script-coding.com/AutoIT.html

;�������� ����� ���������� �������
$sFileName = FileOpenDialog('�������� ����, ���������� ������', _
                            @SystemDir , '����� �������(*.dll;*.ocx)', _
                            1, 'SHELL32.DLL')
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$stIcon = DllStructCreate('int') ;��������� ��� ������ ������
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;�������������� ������ ����� ����� � Unicode
$nBuffersize = DllCall('KERNEL32.DLL', _
                       'int','MultiByteToWideChar', _
                       'int', 0, _
                       'int', 0x00000001, _
                       'str', $sFileName, _
                       'int', -1, _
                       'ptr', 0, _
                       'int', 0)
$stString = DLLStructCreate("byte[" & 2 * $nBuffersize[0] & "]")
DllCall('KERNEL32.DLL', _
        'int', 'MultiByteToWideChar', _
        'int', 0, _
        'int', 0x00000001, _
        'str', $sFileName, _
        'int', -1, _
        'ptr', DllStructGetPtr($stString), _
        'int', $nBuffersize[0])
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;����� ������� ������� ������ �������
DllCall('SHELL32.DLL', _
        'none', 62, _
        'hwnd', 0, _
        'ptr', DllStructGetPtr($stString), _
        'int', DllStructGetSize($stString), _
        'ptr', DllStructGetPtr($stIcon))
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;�������� �������������� ������ ����� ����� � ����������� ���������
$nBuffersize = DllCall('KERNEL32.DLL', _
                       'int', 'WideCharToMultiByte', _
                       'int', 0, _
                       'int', 0x00000200, _
                       'ptr', DllStructGetPtr($stString), _
                       'int', -1, _
                       'ptr', 0, _
                       'int', 0, _
                       'ptr', 0, _
                       'ptr', 0)
$stFile = DLLStructCreate('char[' & $nBuffersize[0] & ']')
DllCall('KERNEL32.DLL', _
        'int', 'WideCharToMultiByte', _
        'int', 0, _
        'int', 0x00000200, _
        'ptr', DllStructGetPtr($stString), _
        'int', -1, _
        'ptr', DllStructGetPtr($stFile), _
        'int', $nBuffersize[0], _
        'ptr', 0, _
        'ptr', 0)
$sFileName = DllStructGetData($stFile, 1)
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$nIconIndex = DllStructGetData($stIcon, 1) ;��������� ������ ������
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;����������� ���������
Msgbox(262192, 'Info', _
       '������ ����: ' & $sFileName & @CR & _
       '������: ' & $nIconIndex)
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
$stBuffer = 0
$stFile   = 0
$stIcon   = 0
