#include <BigNum.au3>
#include <ConvertingNumbers.au3>

$md5 = '5DD66C671119146C30CC27FB9A138733'
$sSymbol = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ'
$timer = TimerInit()
$n =_DecToNum(_NumToDec($md5, '0123456789ABCDEF'), $sSymbol)
MsgBox(0, Round(TimerDiff($timer), 2) & ' msec', $n)