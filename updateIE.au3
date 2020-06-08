;Проверим наличие конкурирующего процесса, что бы избежать конфликта
If WinExists(@ScriptName) Then Exit 1
AutoItWinSetTitle(@ScriptName)

#include <IE.au3>

#include <IE.au3>
$sUrl = "http://www.msn.com/ru-ru/?ocid=iehp"
$sUr2 = "http://www.yandex.ru"
	  $oIE1 = _IECreate($sUrl,$sUr2)

	  _IELoadWait($oIE1)



While 1
    ;If WinExists('[Class:IEFrame]') Then

	  _IEAction($oIE1, "refresh")

    ;EndIf
    Sleep(1000)
WEnd






