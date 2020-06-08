#cs
	Пример генерации ключей, шифрования и расшифровки текста по открытому или закрытому ключу.
	Ключи, тексты для шифрования, зашифрованные тексты и расшифрованные тексты можно будет посмотреть в
	файлах Key.txt, Str.txt, EnCr.txt и DeCr.txt в папке с этим скриптом.
#ce
#include '_RSA_crypt.au3'
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <EditConstants.au3>
#include <ButtonConstants.au3>
#include <WindowsConstants.au3>
#include <WinAPIEx.au3>
#include <ComboConstants.au3>

Opt('MustDeclareVars', 1)
Opt('TrayMenuMode', 1)

Global $aInput[3] = ['Модуль N', 'Откр.эксп. E', 'Секр.эксп. D'], $sText = 'Текст, ', _
		$aCheckTextCrypt[2] = ['открытым ключом', 'секретным ключом'], $nCheckboxCrypt, _
		$aEdit[3] = ['Текст для шифрования:'], $aLabel[2], $aCrypt[2] = ['зашифрованный ', _
		'расшифрованный '], $aButton[3] = ['Генерировать ключи', 'Зашифровать текст', _
		'Расшифровать текст'], $aKey, $sString, $sEnCrypt, $sCrypt = 'Шифровать ', $iKey, _
		$nCheckboxType, $aCheckTextType[2] = ['Шифр.текст в строковом виде', 'Шифр.текст в бинарном виде'], _
		$iBin, $nComboBoxNumE, $nButtonReset, $hFile, $aFiles[4] = ['Str.txt', 'EnCr.txt', 'DeCr.txt', 'Key.txt']

GUICreate('_RSA_crypt GUI', 310, 480, -1, -1, -1, $WS_EX_TOPMOST)
$nCheckboxCrypt = GUICtrlCreateCheckbox($sCrypt & $aCheckTextCrypt[0], 10, 17, 180, 20)
$nCheckboxType = GUICtrlCreateCheckbox($aCheckTextType[0], 10, 45, 180, 20)
GUICtrlCreateLabel('Кол-во знаков в E', 195, 2, 110, 15, $SS_CENTER)
$nComboBoxNumE = GUICtrlCreateCombo('', 215, 17, 70, 20, $CBS_DROPDOWNLIST)
GUICtrlSetData(-1, '-1|3|4|5|6|7|8', '-1')
$nButtonReset = GUICtrlCreateButton('Сброс', 215, 42, 70, 25)
GUICtrlSetCursor(-1, 0)
FileDelete(@ScriptDir & '\' & $aFiles[3])
For $i = 0 To 2
	FileDelete(@ScriptDir & '\' & $aFiles[$i])
	GUICtrlCreateLabel($aInput[$i], 10 + 100 * $i, 75, 90, 15, $SS_CENTER)
	$aInput[$i] = GUICtrlCreateInput('', 10 + 100 * $i, 90, 90, 20, BitOR($ES_READONLY, $ES_CENTER))
	If $i Then
		$aLabel[$i - 1] = GUICtrlCreateLabel($sText & $aCrypt[$i - 1] & $aCheckTextCrypt[$i - 1] & ':', _
				10, 135 + 100 * $i, 290, 15, $SS_CENTER)
	Else
		GUICtrlCreateLabel($aEdit[$i], 10, 135 + 100 * $i, 290, 15, $SS_CENTER)
	EndIf
	$aEdit[$i] = GUICtrlCreateEdit('', 10, 150 + 100 * $i, 290, 75)
	$aButton[$i] = GUICtrlCreateButton($aButton[$i], 10 + 100 * $i, 435, 90, 35, $BS_MULTILINE)
	GUICtrlSetCursor(-1, 0)
Next
GUICtrlCreateLabel('({E,N} - открытый ключ, {D,N} - секретный ключ)', 10, 113, 260, 16, $SS_CENTER)
GUICtrlSetStyle($aEdit[1], BitOR($GUI_SS_DEFAULT_EDIT, $ES_READONLY))
GUISetState()
_WinAPI_EmptyWorkingSet()
While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
		Case $nCheckboxCrypt
			$iKey = BitAND(GUICtrlRead($nCheckboxCrypt), $GUI_CHECKED)
			GUICtrlSetData($nCheckboxCrypt, $sCrypt & $aCheckTextCrypt[$iKey])
			For $i = 0 To 1
				If $iKey Then
					GUICtrlSetData($aLabel[$i], $sText & $aCrypt[$i] & $aCheckTextCrypt[Not $i] & ':')
				Else
					GUICtrlSetData($aLabel[$i], $sText & $aCrypt[$i] & $aCheckTextCrypt[$i] & ':')
				EndIf
				GUICtrlSetData($aEdit[$i + 1], '')
			Next
		Case $nCheckboxType
			$iBin = BitAND(GUICtrlRead($nCheckboxType), $GUI_CHECKED)
			GUICtrlSetData($nCheckboxType, $aCheckTextType[$iBin])
			For $i = 1 To 2
				GUICtrlSetData($aEdit[$i], '')
			Next
		Case $aButton[0]
			$aKey = _RSA_GenerateKeys(GUICtrlRead($nComboBoxNumE))
			For $i = 0 To 2
				GUICtrlSetData($aInput[$i], $aKey[$i])
				If $i Then
					GUICtrlSetData($aEdit[$i], '')
				EndIf
			Next
			$hFile = FileOpen(@ScriptDir & '\' & $aFiles[3], 1)
			FileWrite($hFile, 'Открытый ключ {E,N}: {' & $aKey[1] & ',' & $aKey[0] & '}' & @CRLF & _
					'Секретный ключ {D,N}: {' & $aKey[2] & ',' & $aKey[0] & '}' & @CRLF & _
					'~+~+~+~+~+~+~+~+~+~+~+~+~+' & @CRLF)
			FileClose($hFile)
		Case $aButton[1]
			If Not IsArray($aKey) Then ContinueLoop
			$sString = GUICtrlRead($aEdit[0])
			If Not $sString Then ContinueLoop
			$sEnCrypt = _RSA_EnCrypt($sString, $aKey[1 + $iKey], $aKey[0], -1, $iBin)
			GUICtrlSetData($aEdit[1], $sEnCrypt)
			$hFile = FileOpen(@ScriptDir & '\' & $aFiles[0], 1)
			FileWrite($hFile, $sString & @CRLF & '~+~+~+~+~+~+~+~+~+~+~+~+~+' & @CRLF)
			FileClose($hFile)
			$hFile = FileOpen(@ScriptDir & '\' & $aFiles[1], 1)
			FileWrite($hFile, $sEnCrypt & @CRLF & '~+~+~+~+~+~+~+~+~+~+~+~+~+' & @CRLF)
			FileClose($hFile)
			$sString = ''
			$sEnCrypt = ''
		Case $aButton[2]
			If Not IsArray($aKey) Then ContinueLoop
			$sEnCrypt = GUICtrlRead($aEdit[1])
			If $iBin Then $sEnCrypt = Binary($sEnCrypt)
			If Not $sEnCrypt Then ContinueLoop
			$sString = _RSA_DeCrypt($sEnCrypt, $aKey[2 - $iKey], $aKey[0])
			GUICtrlSetData($aEdit[2], $sString)
			$hFile = FileOpen(@ScriptDir & '\' & $aFiles[2], 1)
			FileWrite($hFile, $sString & @CRLF & '~+~+~+~+~+~+~+~+~+~+~+~+~+' & @CRLF)
			FileClose($hFile)
			$sString = ''
			$sEnCrypt = ''
		Case $nButtonReset
			For $i = 0 To 2
				GUICtrlSetData($aInput[$i], '')
				GUICtrlSetData($aEdit[$i], '')
			Next
			$aKey = 0
	EndSwitch
WEnd