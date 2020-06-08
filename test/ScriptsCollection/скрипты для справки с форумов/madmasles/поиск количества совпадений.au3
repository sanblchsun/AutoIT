
; Создание файла
; Dim $aArray[1000001] = [1000000]
; $sText = ''
; For $i = 1 To $aArray[0]
    ; $sText &= (Chr(Random(65, 90, 1)) & Chr(Random(97, 122, 1)) & @CRLF)
; Next
; $hFile = FileOpen(@ScriptDir & '\test.txt', 2)
; FileWrite($hFile, $sText)
; FileClose($hFile)


$sFind = 'Zz'

$hFile = FileOpen(@ScriptDir & '\test.txt')
$sText = FileRead($hFile)
FileClose($hFile)

$iStart = TimerInit()
StringReplace($sText, $sFind, '', 0, 1)
$iExt = @extended
$sTime = StringFormat('%.2f ms', TimerDiff($iStart))
MsgBox(0, 'StringReplace', $sTime & ', Совпадений: ' & $iExt)

$iStart = TimerInit()
$aRez = StringRegExp($sText, '\Q' & $sFind & '\E', 3)
$sTime = StringFormat('%.2f ms', TimerDiff($iStart))
MsgBox(0, 'StringRegExp', $sTime & ', Совпадений: ' & UBound($aRez))

$iStart = TimerInit()
StringRegExpReplace($sText, '\Q' & $sFind & '\E', '')
$iExt = @extended
$sTime = StringFormat('%.2f ms', TimerDiff($iStart))
MsgBox(0, 'StringRegExpReplace', $sTime & ', Совпадений: ' & $iExt)