#include "DeviceAPI.au3"

;—мысл программы в том, чтобы закрыва€ окна ћастера Ќового ќборудовани€,
; она считала количество таких закрытых окон и сравнивала это кол-во
; с текущим количеством неизвестных устройств, а когда кол-во последних
; будет равно количеству закрытых окон (система установит все что может
; установить), мы запустим установку неизвестных устройств.
;
;ћожно конечно из окна ћастера нового оборудовани€ из WindowText брать
; наименование конкретного неизвестного устройства, затем находить его в
; текущем массиве и выбивать из "обоймы", но это уже лишнее, хот€ и точнее.

$wcount = 0

;ѕеребира€ окна, закрываем паразитные и ведем статистику
Do
    $var = WinList()
    For $i = 1 to $var[0][0]
        If $var[$i][0] <> "" AND BitAnd( WinGetState($var[$i][1]), 2 ) Then
            Select
                Case $var[$i][0] = "»зменение параметров системы"
                    WinClose("»зменение параметров системы")
                Case $var[$i][0] = "ћастер нового оборудовани€"
                    WinClose("ћастер нового оборудовани€")
                    $wcount+=1
            EndSelect
        EndIf
    Next
Until $wcount=GetCurrentUnknownDevicesCount()

;≈сли все сходитс€, то завершаем работу
MsgBox(64,"","Ќеизвестных устройств: " & $wcount)

;=======================================================================
; ‘ункци€ подсчета неизвестных устройств в данный момент
;=======================================================================
Func GetCurrentUnknownDevicesCount()

    $i=0

    ;—троим список классов устройств
    _DeviceAPI_GetAllDevices()

    ;ѕросматрива€ устройства, считаем количество устройств с пустымы класом и идентификатором
    While _DeviceAPI_EnumDevices()
        $classname = _DeviceAPI_GetClassName(_DeviceAPI_GetDeviceRegistryProperty($SPDRP_CLASSGUID))
        $classGUID = _DeviceAPI_GetDeviceRegistryProperty($SPDRP_CLASSGUID)
        If $classname="" AND $classGUID="" Then $i+=1
    WEnd

    ;ќчищаем за собой
    _DeviceAPI_DestroyDeviceInfoList()

    Return $i

EndFunc