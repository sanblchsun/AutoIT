#include <BigNum.au3>
#include <ConvertingNumbers.au3>

; ѕример преобразовани€ с двоичными числами

$sBin = '101'
$sSymbol = '01'
MsgBox(0, '', $sBin & ' -> ' & _NumToDec($sBin, $sSymbol))

$sDec = '5'
$sSymbol = '01'
MsgBox(0, '', $sDec & ' -> ' & _DecToNum($sDec, $sSymbol))

; ѕример преобразовани€ с шестнадцатеричными числами

$sBin = 'AF'
$sSymbol = '0123456789ABCDEF'
MsgBox(0, '', $sBin & ' -> ' & _NumToDec($sBin, $sSymbol))

$sDec = '175'
$sSymbol = '0123456789ABCDEF'
MsgBox(0, '', $sDec & ' -> ' & _DecToNum($sDec, $sSymbol))