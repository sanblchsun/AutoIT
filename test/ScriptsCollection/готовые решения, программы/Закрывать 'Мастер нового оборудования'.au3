#include "DeviceAPI.au3"

;����� ��������� � ���, ����� �������� ���� ������� ������ ������������,
; ��� ������� ���������� ����� �������� ���� � ���������� ��� ���-��
; � ������� ����������� ����������� ���������, � ����� ���-�� ���������
; ����� ����� ���������� �������� ���� (������� ��������� ��� ��� �����
; ����������), �� �������� ��������� ����������� ���������.
;
;����� ������� �� ���� ������� ������ ������������ �� WindowText �����
; ������������ ����������� ������������ ����������, ����� �������� ��� �
; ������� ������� � �������� �� "������", �� ��� ��� ������, ���� � ������.

$wcount = 0

;��������� ����, ��������� ���������� � ����� ����������
Do
    $var = WinList()
    For $i = 1 to $var[0][0]
        If $var[$i][0] <> "" AND BitAnd( WinGetState($var[$i][1]), 2 ) Then
            Select
                Case $var[$i][0] = "��������� ���������� �������"
                    WinClose("��������� ���������� �������")
                Case $var[$i][0] = "������ ������ ������������"
                    WinClose("������ ������ ������������")
                    $wcount+=1
            EndSelect
        EndIf
    Next
Until $wcount=GetCurrentUnknownDevicesCount()

;���� ��� ��������, �� ��������� ������
MsgBox(64,"","����������� ���������: " & $wcount)

;=======================================================================
; ������� �������� ����������� ��������� � ������ ������
;=======================================================================
Func GetCurrentUnknownDevicesCount()

    $i=0

    ;������ ������ ������� ���������
    _DeviceAPI_GetAllDevices()

    ;������������ ����������, ������� ���������� ��������� � ������� ������ � ���������������
    While _DeviceAPI_EnumDevices()
        $classname = _DeviceAPI_GetClassName(_DeviceAPI_GetDeviceRegistryProperty($SPDRP_CLASSGUID))
        $classGUID = _DeviceAPI_GetDeviceRegistryProperty($SPDRP_CLASSGUID)
        If $classname="" AND $classGUID="" Then $i+=1
    WEnd

    ;������� �� �����
    _DeviceAPI_DestroyDeviceInfoList()

    Return $i

EndFunc