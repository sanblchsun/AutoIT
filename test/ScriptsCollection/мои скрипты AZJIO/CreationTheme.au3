#AutoIt3Wrapper_Outfile=CreationTheme.exe
#AutoIt3Wrapper_Icon=CreationTheme.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=
#AutoIt3Wrapper_Res_Description=CreationTheme.exe
#AutoIt3Wrapper_Res_Fileversion=0.2.0.0
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_Au3check=n
#AutoIt3Wrapper_Run_Obfuscator=y
; #Obfuscator_Parameters=/StripOnly
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"

;  @AZJIO 28.05.2011 (AutoIt3_v3.3.6.1)
; !!! При редактировании скрипта сделайте батник для снятия задачи "taskkill.exe /F /IM AutoIt3.exe", иначе при вылете ошибки компьютер будет зависать.
; Из-за не выполнености команды GUIDelete() при выходе.
#NoTrayIcon
#include <GuiRichEdit.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Color.au3>
#include <GuiButton.au3>
OnAutoItExitRegister("Error")

$pathExample=@ScriptDir&'\Example.txt'
$pathColor=@ScriptDir&'\Color.txt'
$pathFunction=@ScriptDir&'\Function.txt'
$pathPosition=@ScriptDir&'\Position.txt'


If Not FileExists($pathExample) Then
	$file = FileOpen($pathExample,2)
	FileWrite($file, '; Return values .: Success - Index of last added item' & @CRLF & _
		'$Edit1=GUICtrlCreateEdit(''Any text'', 10, 10, 300, 200)' & @CRLF & _
		'GUICtrlSetResizing(-1, 2 + 4)' & @CRLF & _
		@CRLF & _
		'Func _funcname()' & @CRLF & _
		'    If @error Then Return $Curent & @MDAY & @YEAR' & @CRLF & _
		@CRLF & _
		'#Region' & @CRLF & _
		'Send("^{Enter}")' & @CRLF & _
		'#NoTrayIcon' & @CRLF & _
		'#include <GuiRichEdit.au3>' & @CRLF & _
		'#EndRegion' & @CRLF & _
		'$HashedData.Hash($Buf)' & @CRLF & _
		'_WinAPI_GetWindow ($hWnd, $iCmd)' & @CRLF)
	FileClose($file)
EndIf
If Not FileExists($pathColor) Then
	$file = FileOpen($pathColor,2)
	FileWrite($file, _
		'72ADC0' & @CRLF & _
		'71AE71' & @CRLF & _
		'71AE71' & @CRLF & _
		'C738B9' & @CRLF & _
		'AAA6DB' & @CRLF & _
		'0080FF' & @CRLF & _
		'FF46FF' & @CRLF & _
		'999999' & @CRLF & _
		'FF8080' & @CRLF & _
		'D29A6C' & @CRLF & _
		'EA9515' & @CRLF & _
		'F000FF' & @CRLF & _
		'0080C0' & @CRLF & _
		'7D8AE6' & @CRLF & _
		'0080FF' & @CRLF & _
		'485ADB' & @CRLF & _
		'3F3F3F')
	FileClose($file)
EndIf
If Not FileExists($pathFunction) Then
	$file = FileOpen($pathFunction,2)
	FileWrite($file, _
		'White space' & @CRLF & _
		'Comment line' & @CRLF & _
		'Comment block' & @CRLF & _
		'Number' & @CRLF & _
		'Function' & @CRLF & _
		'Keyword' & @CRLF & _
		'Macro' & @CRLF & _
		'String' & @CRLF & _
		'Operator' & @CRLF & _
		'Variable' & @CRLF & _
		'Sent keys' & @CRLF & _
		'Pre-Processor' & @CRLF & _
		'Special' & @CRLF & _
		'Abbrev-Expand' & @CRLF & _
		'Com Objects' & @CRLF & _
		'Standard UDF''s' & @CRLF & _
		'BackGround')
	FileClose($file)
EndIf
If Not FileExists($pathPosition) Then
	$file = FileOpen($pathPosition,2)
	FileWrite($file, _
		'145,154' & @CRLF & _
		'0,53' & @CRLF & _
		@CRLF & _
		'91,93\95,97\99,102\104,107\129,130\132,133\136,137' & @CRLF & _
		'61,78\109,127\216,220' & @CRLF & _
		'140,144\161,163\171,182' & @CRLF & _
		'164,170\193,198\201,206' & @CRLF & _
		'79,89\254,271' & @CRLF & _
		'60,61\78,79\89,90\93,94\97,98\102,103\107,108\127,129\130,131\134,135\137,138\154,156\191,192\199,200\220,221\231,232\294,295\299,300\304,305\324,325\330,331\337,338' & @CRLF & _
		'54,60\183,190\283,294\300,304\325,330\332,337' & @CRLF & _
		'222,230' & @CRLF & _
		'233,244\245,253' & @CRLF & _
		'208,215\272,282' & @CRLF & _
		@CRLF & _
		'295,299' & @CRLF & _
		'306,323' & @CRLF & _
		@CRLF)
	FileClose($file)
EndIf


; En
$LngTitle='CreationTheme'
$LngAbout='About'
$LngVer='Version'
$LngSite='Site'
$LngCopy='Copy'
$LngRe='Restart CreationTheme'
$LngAdd='Add'
$LngAddH='Select text and cell for insertion of the positions'&@CRLF&'Ctrl+Enter'
$LngSvP='Save to positions'
$LngClr='Clean to positions'
$LngSvC='Save palette'
$LngOpCl='Open palette'
$LngUdt='Update Theme'
$LngImpt='Import Theme'
$LngMsEr='Error'
$LngMs1='Can Not read the file, code of the error:'
$LngMs2='Message'
$LngMs3='It is Necessary to select text'
$LngMs4='Update Theme?'
$LngMs5='File is not found, want to save to another file?'
$LngSvS1='Save As...'
$LngApp='Apply'
$LngUdtH='Save colors to the SciTEUser.properties'
$LngImpH='Read the colors from the Themes.SciTEConfig or SciTEUser.properties'
$LngAppH='Apply the color specified in the input field'
$LngCSl='Click on the colored square'
$LngFnt='Font'

$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang=DllCall ( $Lang_dll, "int", "GetUserDefaultUILanguage" )
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)
DllClose($Lang_dll)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	$LngAbout='О программе'
	$LngVer='Версия'
	$LngCopy='Копировать'
	$LngSite='Сайт'
	$LngRe='Перезапуск утилиты'
	$LngAdd='Добавить'
	$LngAddH='Выделите текст и ячейку для вставки позиции'&@CRLF&'Ctrl+Enter'
	$LngSvP='Сохранить позиции'
	$LngClr='Очистить позиции'
	$LngSvC='Сохранить палитру'
	$LngOpCl='Открыть палитру'
	$LngUdt='Обновить тему'
	$LngImpt='Импорт темы'
	$LngMsEr='Ошибка'
	$LngMs1='Не могу прочитать файл,    код ошибки:'
	$LngMs2='Сообщение'
	$LngMs3='Нужно выделить текст'
	$LngMs4='Обновить цветовую схему скайта?'
	$LngMs5='Файл не найден, хотите сохранить в другой файл?'
	$LngSvS1='Сохранить как ...'
	$LngApp='Применить'
	$LngUdtH='Сохранить цвета в SciTEUser.properties'
	$LngImpH='Прочитать цвета из Themes.SciTEConfig или SciTEUser.properties'
	$LngAppH='Применить цвет указанный в поле ввода'
	$LngCSl='Кликни на цветном квадрате'
	$LngFnt='Шрифт'
EndIf

Global $CU=1, $b[18][5], $aColor, $aFunc, $aPos, $aHSB[3]=[0,0,0], $aRGB[3]=[Hex(0), Hex(0), Hex(0)]

; $hGui = GUICreate($LngTitle, 650, 490, -1 , -1, 0x00040000+0x00020000+0x00010000);, -1, 0)
$hGui = GUICreate($LngTitle, 650, 470);, -1, 0)

If Not @compiled Then GUISetIcon(@ScriptDir&'\CreationTheme.ico')
$restart=GUICtrlCreateButton ("R", 650-19,5,18,18)
GUICtrlSetTip(-1, $LngRe)
$About = GUICtrlCreateButton("@", 650-19, 25,18,18)
GUICtrlSetTip(-1,  'About')

$hRichEdit = _GUICtrlRichEdit_Create($hGui, "", 5, 5, 335, 300, $ES_MULTILINE+$WS_VSCROLL )
_GuiCtrlRichEdit_SetCharColor($hRichEdit, 0x999999)


$file = FileOpen($pathExample, 0)
$tmp = FileRead($file)
FileClose($file)

_GUICtrlRichEdit_SetText($hRichEdit, $tmp)

_GuiCtrlRichEdit_SetSel($hRichEdit,  0, -1)
_GUICtrlRichEdit_SetFont($hRichEdit, 10, "Arial")
_GUICtrlRichEdit_Deselect($hRichEdit)

$Add = GUICtrlCreateButton($LngAdd, 500, 410, 70, 25)
GUICtrlSetTip(-1, $LngAddH)
$lbl1 = GUICtrlCreateLabel('1', 579,411, 25, 19)
GUICtrlSetFont($lbl1,15, 700)

$save1 = GUICtrlCreateButton($LngSvP, 500, 350, 120, 25)
$Clear = GUICtrlCreateButton($LngClr, 500, 380, 120, 25)
$Open_Color = GUICtrlCreateButton($LngOpCl, 350, 350, 110, 25)
$save2 = GUICtrlCreateButton($LngSvC, 350, 380, 110, 25)
$Import = GUICtrlCreateButton($LngImpt, 350, 410, 110, 25)
GUICtrlSetTip(-1, $LngImpH)
$Udt_Theme = GUICtrlCreateButton($LngUdt, 350, 440, 110, 25)
GUICtrlSetTip(-1, $LngUdtH)


If Not _FileReadToArray($pathColor, $aColor) Then
   MsgBox(4096,$LngMsEr&' Color', $LngMs1 & @error)
   Exit
EndIf
If Not _FileReadToArray($pathFunction, $aFunc) Then
   MsgBox(4096,$LngMsEr&' Function', $LngMs1 & @error)
   Exit
EndIf
If Not _FileReadToArray($pathPosition, $aPos) Then
   MsgBox(4096,$LngMsEr&' Position', $LngMs1 & @error)
   Exit
EndIf

_GUICtrlRichEdit_SetBkColor($hRichEdit, _ColorConv($aColor[17]))

For $i = 1 to 17
	$b[$i][4]=GUICtrlCreateLabel($aFunc[$i], 350, 20*$i-15, 110, 20)
	GUICtrlSetColor(-1, Dec($aColor[$i]))
	GUICtrlSetBkColor(-1, Dec($aColor[17]))
	GUICtrlSetFont(-1, 10)
	If $i = 17 Then GUICtrlSetColor(-1, Dec($aColor[8]))
	$b[$i][0]=GUICtrlCreateButton($i, 469, 20*$i-15, 20, 19)
	GUICtrlSetBkColor(-1, 0xffff99)
	If $i<>17 Then $b[$i][1]=GUICtrlCreateInput('', 490, 20*$i-15, 140, 19)
	If $aPos[$i]<>'' And $i<>17 Then GUICtrlSetData(-1, $aPos[$i])
	$b[$i][2]=$aColor[$i]
	$b[$i][3]=$aFunc[$i]
Next
GUICtrlSetBkColor($b[1][0], 0x00aa00)

; Спектр
$aHSB[1]=100
$aHSB[2]=100
For $i = 0 to 51
$aHSB[0]=$i*7
$aRGB=_HSB_2_RGB($aHSB)
$NewColor=$aRGB[0]&$aRGB[1]&$aRGB[2]
GUICtrlCreateLabel('', $i*5+11, 310, 5, 5)
GUICtrlSetBkColor(-1, Dec($NewColor))
Next

$sliderRed = GUICtrlCreateSlider(0, 315, 282, 30)
		GUICtrlSetLimit(-1, 360, 0)
		$hSlider_Handle1 = GUICtrlGetHandle(-1)
$sliderGreen = GUICtrlCreateSlider(0, 345, 282, 30)
		GUICtrlSetLimit(-1, 100, 0)
		$hSlider_Handle2 = GUICtrlGetHandle(-1)
$sliderBlue = GUICtrlCreateSlider(0, 375, 282, 30)
		GUICtrlSetLimit(-1, 100, 0)
		$hSlider_Handle3 = GUICtrlGetHandle(-1)

$condition1 = GUICtrlCreateLabel('', 285, 320, 25, 17)
GUICtrlSetFont(-1,11)
$condition2 = GUICtrlCreateLabel('', 285, 350, 25, 17)
GUICtrlSetFont(-1,11)
$condition3 = GUICtrlCreateLabel('', 285, 380, 25, 17)
GUICtrlSetFont(-1,11)
GUICtrlCreateLabel('Hue', 313, 320, 30, 17)
GUICtrlCreateLabel('Satur', 313, 350, 30, 17)
GUICtrlCreateLabel('Bright', 313, 380, 30, 17)
$ColorTest = GUICtrlCreateLabel('', 120, 415, 40, 40)
GUICtrlCreateLabel($LngCSl, 165, 420, 110, 34)
$ColorCopy=GUICtrlCreateInput('', 7, 410, 70, 22)
$Apply = GUICtrlCreateButton($LngApp, 7, 435, 70, 25)
GUICtrlSetTip(-1, $LngAppH)
$SelFont = GUICtrlCreateButton($LngFnt, 275, 410, 60, 25)

GUIRegisterMsg(0x0114 , "WM_HSCROLL")

; HotKey
Dim $AccelKeys[18][2]
For $i = 1 to 9
	$AccelKeys[$i][0]='^'&$i
	$AccelKeys[$i][1]=$b[$i][0]
	GUICtrlSetTip($b[$i][0], 'Ctrl+'&$i)
Next
For $i = 10 to 17
	$AccelKeys[$i][0]='!'&$i-10
	$AccelKeys[$i][1]=$b[$i][0]
	GUICtrlSetTip($b[$i][0], 'Alt+'&$i-10)
Next
$AccelKeys[0][0]='^{Enter}'
$AccelKeys[0][1]=$Add
GUISetAccelerators($AccelKeys)

GUISetState()

For $i = 1 to 16
	$CU=$i
	If $aPos[$i]<>'' Then _ColorAuto($aPos[$i])
Next
$CU=1
_SetSlider(1)

While 1
	$iMsg = GUIGetMsg()
	
	For $i = 1 to 17
		If $iMsg = $b[$i][0] Then
			GUICtrlSetBkColor($b[$CU][0], 0xffff99)
			GUICtrlSetBkColor($b[$i][0], 0x00aa00)
			$CU=$i
			GUICtrlSetData($lbl1, $i)
			_SetSlider($i)
		EndIf
	Next

	Switch $iMsg
		Case -3
			Exit
			
		Case $SelFont
			$aRet =_GUICtrlRichEdit_GetFont($hRichEdit)
			$a=_GUICtrlRichEdit_GetSel($hRichEdit)
			If $a[0]=$a[1] Then
				_GuiCtrlRichEdit_SetSel($hRichEdit,  0, -1, True)
				$a[0]=0
				$a[1]=-1
			EndIf
			$aRet2 =_GUICtrlRichEdit_GetCharAttributes($hRichEdit)
			If StringInStr($aRet2, 'bo+') Then
				$bo=700
			Else
				$bo=400
			EndIf
			If StringInStr($aRet2, 'it+') Then
				$it=True
			Else
				$it=False
			EndIf
			$a_font = _ChooseFont($aRet[1], $aRet[0], 0, $bo, $it, 0, 0, $hGui)
			If Not @error Then
				 $atrb=''
				If $a_font[4]=700 Then
					$atrb&='+bo'
				ElseIf $a_font[4]=400 Then
					$atrb&='-bo'
				EndIf
				If BitAND($a_font[1], 2) Then
					$atrb&='+it'
				Else
					$atrb&='-it'
				EndIf
				_GuiCtrlRichEdit_SetSel($hRichEdit,  $a[0], $a[1], True)
				_GUICtrlRichEdit_SetFont($hRichEdit, $a_font[3], $a_font[2])
				_GUICtrlRichEdit_SetCharAttributes($hRichEdit,  $atrb)
				_GUICtrlRichEdit_Deselect($hRichEdit)
			EndIf
			
		Case $Import
			$WorkingDir=@UserProfileDir
			$curretPath = RegRead("HKLM\SOFTWARE\AutoIt v3\AutoIt","InstallDir")&'\SciTE\SciTEConfig'
			If FileExists($curretPath) Then $WorkingDir=$curretPath
			; $WorkingDir=@SystemDir
			; $WorkingDir=@WorkingDir
			
			$OpenFile = FileOpenDialog('Open', $WorkingDir , "Themes (*.properties;*.SciTEConfig)",  1, '', $hGui)
			If @error Then ContinueLoop
			
			$file = FileOpen($OpenFile, 0)
			$tmp = FileRead($file)
			FileClose($file)
			
			$ErrorList=''
			For $i = 1 to 16
				$b[$i][2]=StringRegExpReplace($tmp, '(?s)(^.*style\.au3\.'&$i-1&'=fore:#)([0-9A-Fa-f]{6})(.*)$', '\2')
				If @error Then
					$ErrorList&='style.au3.'&$i-1&'=fore:#'
					$b[$i][2]='FF000'
				EndIf
			Next
			$b[17][2]=StringRegExpReplace($tmp, '(?s)(^.*style\.au3\.32=style\.\*\.32.*?back:#)([0-9A-Fa-f]{6})(.*)$', '\2')
				If @error Then
					$ErrorList&='style.au3.32(?)back:#'
					$b[17][2]='FFFFFF'
				EndIf
			If $ErrorList <>'' Then MsgBox(0, 'ErrorList', $ErrorList)
			
			
			$tmp=$CU
			
			For $i = 1 to 17
				GUICtrlSetColor($b[$i][4], Dec($b[$i][2]))
				GUICtrlSetBkColor($b[$i][4], Dec($b[17][2]))
			Next
			GUICtrlSetColor($b[17][4], Dec($b[8][2]))

			For $i = 1 to 16
				$CU=$i
				If $aPos[$i]<>'' Then _ColorAuto($aPos[$i])
			Next
			$CU=1
			_SetSlider(1)
			_GUICtrlRichEdit_SetBkColor($hRichEdit, _ColorConv($b[17][2]))
			
			GUICtrlSetBkColor($b[$tmp][0], 0xffff99)
			GUICtrlSetBkColor($b[$CU][0], 0x00aa00)

		Case $Open_Color
			$OpenFile = FileOpenDialog('Open', @WorkingDir , "Color (*.txt)",  1, 'Color1.txt', $hGui)
			If @error Then ContinueLoop
			If StringRight($OpenFile, 4)<>'.txt' Then $OpenFile&='.txt'
			If Not FileExists($OpenFile) Then ContinueLoop
			
			If Not _FileReadToArray($OpenFile, $aColor) Then
			   MsgBox(4096,$LngMsEr&' Color', $LngMs1 & @error)
			   Exit
			EndIf
			
			For $i = 1 to 17
				If StringRegExp($aColor[$i],'^[0-9A-Fa-f]{6}$',0) = 0 Then
					MsgBox(0, $LngMsEr, 'Invalid palette')
					ContinueLoop 2
				EndIf
				GUICtrlSetColor($b[$i][4], Dec($aColor[$i]))
				GUICtrlSetBkColor($b[$i][4], Dec($aColor[17]))
				$b[$i][2]=$aColor[$i]
			Next
			GUICtrlSetColor($b[17][4], Dec($aColor[8]))
			
			$tmp=$CU

			For $i = 1 to 16
				$CU=$i
				If $aPos[$i]<>'' Then _ColorAuto($aPos[$i])
			Next
			$CU=1
			_SetSlider(1)
			_GUICtrlRichEdit_SetBkColor($hRichEdit, _ColorConv($b[17][2]))
			
			GUICtrlSetBkColor($b[$tmp][0], 0xffff99)
			GUICtrlSetBkColor($b[$CU][0], 0x00aa00)
			
		Case $ColorTest
			$b[$CU][2]=GUICtrlRead($ColorCopy)
			$tmp=_ChooseColor(2, Dec($b[$CU][2]), 2, $hGui)
			If $tmp = -1 Then ContinueLoop
			$b[$CU][2]=$tmp
			GUICtrlSetData($ColorCopy, Hex(Int($b[$CU][2]),6))
			ContinueCase
			
		Case $Apply
			$b[$CU][2]=GUICtrlRead($ColorCopy)
			_SetSlider($CU)
			; ControlClick($hGui, '', $sliderRed)
			_HSCROLL()
			
		Case $Add
			$a=_GUICtrlRichEdit_GetSel($hRichEdit)
			If $a[0]=$a[1] Then
				MsgBox(0, $LngMs2, $LngMs3)
				ContinueLoop
			EndIf
			If GUICtrlRead($b[$CU][1])='' Then 
				GUICtrlSetData($b[$CU][1], $a[0]&','&$a[1])
			Else
				GUICtrlSetData($b[$CU][1], GUICtrlRead($b[$CU][1])&'\'&$a[0]&','&$a[1])
			EndIf
			
		Case $save1
			$tmp=''
			For $i = 1 to 16
				$tmp&=GUICtrlRead($b[$i][1])&@CRLF
			Next
			$file = FileOpen($pathPosition,2)
			FileWrite($file, $tmp&@CRLF)
			FileClose($file)
			
		Case $save2

			$SaveFile = FileSaveDialog("Save ...", @WorkingDir , "Text file (*.txt)", 24, 'Color.txt', $hGui)
			If @error Then ContinueLoop
			If StringRight($SaveFile, 4) <> '.txt' Then $SaveFile&='.txt'

			$tmp=''
			For $i = 1 to 17
				$tmp&=$b[$i][2]&@CRLF
			Next
			$file = FileOpen($SaveFile,2)
			FileWrite($file, $tmp)
			FileClose($file)
			
		Case $Clear
			For $i = 1 to 16
				GUICtrlSetData($b[$i][1], '')
			Next
		Case $Udt_Theme
			$PathTxs=@UserProfileDir&'\SciTEUser.properties'
			If MsgBox(4, $LngMs2, $LngMs4)=7 Then ContinueLoop
			If Not FileExists($PathTxs) And MsgBox(0, $LngMsEr, $PathTxs&@CRLF&$LngMs5)=7 Then
				ContinueLoop
			Else
				$PathTxs = FileSaveDialog($LngSvS1, @UserProfileDir , '(*.properties)', 24, 'SciTEUser.properties', $hGui)
				If @error Then ContinueLoop
				If StringRight($PathTxs, 11) <> '.properties' Then $PathTxs&='.properties'
$text= _
'#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#' & @CRLF & _
'# START: DO NOT CHANGE ANYTHING AFTER THIS LINE     #-#-#-#-#' & @CRLF & _
'# Created by SciTEConfig' & @CRLF & _
'#------------------------------------------------------------' & @CRLF & _
'font.base=font:Verdana,size:10,$(font.override)' & @CRLF & _
'font.monospace=font:Courier New,size:10' & @CRLF & _
'proper.case=0' & @CRLF & _
'check.updates.scite4autoit3=0' & @CRLF & _
'use.tabs=1' & @CRLF & _
'indent.size=4' & @CRLF & _
'indent.size.*.au3=4' & @CRLF & _
'tabsize=4' & @CRLF & _
'#Background' & @CRLF & _
'style.au3.32=style.*.32=$(font.base),back:#'&$b[17][2] & @CRLF & _
'#CaretLineBackground' & @CRLF & _
'caret.line.back=#FFFED8' & @CRLF & _
'# Brace highlight' & @CRLF & _
'style.au3.34=fore:#0000FF,bold,back:#'&$b[17][2] & @CRLF & _
'# Brace incomplete highlight' & @CRLF & _
'style.au3.35=fore:#009933,italics,back:#'&$b[17][2] & @CRLF & _
'#White space' & @CRLF & _
'style.au3.0=fore:#'&$b[1][2]&',back:#'&$b[17][2] & @CRLF & _
'#Comment line' & @CRLF & _
'style.au3.1=fore:#'&$b[2][2]&',italics,back:#'&$b[17][2] & @CRLF & _
'#Comment block' & @CRLF & _
'style.au3.2=fore:#'&$b[3][2]&',italics,back:#'&$b[17][2] & @CRLF & _
'#Number' & @CRLF & _
'style.au3.3=fore:#'&$b[4][2]&',italics,bold,back:#'&$b[17][2] & @CRLF & _
'#Function' & @CRLF & _
'style.au3.4=fore:#'&$b[5][2]&',italics,bold,back:#'&$b[17][2] & @CRLF & _
'#Keyword' & @CRLF & _
'style.au3.5=fore:#'&$b[6][2]&',bold,back:#'&$b[17][2] & @CRLF & _
'#Macro' & @CRLF & _
'style.au3.6=fore:#'&$b[7][2]&',bold,back:#'&$b[17][2] & @CRLF & _
'#String' & @CRLF & _
'style.au3.7=fore:#'&$b[8][2]&',bold,back:#'&$b[17][2] & @CRLF & _
'#Operator' & @CRLF & _
'style.au3.8=fore:#'&$b[9][2]&',bold,back:#'&$b[17][2] & @CRLF & _
'#Variable' & @CRLF & _
'style.au3.9=fore:#'&$b[10][2]&',bold,back:#'&$b[17][2] & @CRLF & _
'#Sent keys' & @CRLF & _
'style.au3.10=fore:#'&$b[11][2]&',bold,back:#'&$b[17][2] & @CRLF & _
'#Pre-Processor' & @CRLF & _
'style.au3.11=fore:#'&$b[12][2]&',italics,back:#'&$b[17][2] & @CRLF & _
'#Special' & @CRLF & _
'style.au3.12=fore:#'&$b[13][2]&',italics,back:#'&$b[17][2] & @CRLF & _
'#Abbrev-Expand' & @CRLF & _
'style.au3.13=fore:#'&$b[14][2]&',bold,back:#'&$b[17][2] & @CRLF & _
'#Com Objects' & @CRLF & _
'style.au3.14=fore:#'&$b[15][2]&',italics,bold,back:#'&$b[17][2] & @CRLF & _
'#Standard UDF''s' & @CRLF & _
'style.au3.15=fore:#'&$b[16][2]&',italics,bold,back:#'&$b[17][2] & @CRLF & _
'# END => DO NOT CHANGE ANYTHING BEFORE THIS LINE  #-#-#-#-#-#' & @CRLF & _
'#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#'
				$file = FileOpen($PathTxs,2)
				FileWrite($file, $text)
				FileClose($file)
				ContinueLoop
			EndIf
			If Not FileExists(@UserProfileDir&'\SciTEUser.properties.BAK') Then FileCopy($PathTxs, @UserProfileDir&'\SciTEUser.properties.BAK', 0)
			
			$file = FileOpen($PathTxs, 0)
			$tmp = FileRead($file)
			FileClose($file)
			$ErrorList=''
			For $i = 1 to 16
				$tmp=StringRegExpReplace($tmp, '(style.au3.'&$i-1&'=)(fore:#[0-9A-Fa-f]{6})', '\1fore:#'&$b[$i][2])
				If @error Then $ErrorList&='style.au3.'&$i-1&'=fore:#(?)'&@CRLF
				$tmp=StringRegExpReplace($tmp, '(style.au3.'&$i-1&'=.*?)(,back:#[0-9A-Fa-f]{6})', '\1,back:#'&$b[17][2])
				If @error Then $ErrorList&='style.au3.'&$i-1&'=fore:#(?),back:#()?'&@CRLF
			Next
			$tmp=StringRegExpReplace($tmp, '(style.au3.32.*)(back:#[0-9A-Fa-f]{6})', '\1back:#'&$b[17][2])
			
			$file = FileOpen($PathTxs,2)
			FileWrite($file, $tmp)
			FileClose($file)
			If $ErrorList <>'' Then MsgBox(0, 'ErrorList', $ErrorList)
			
		
		
		; Case $btn2
			; $aPos  = _GuiCtrlRichEdit_GetSel($hRichEdit)
			; --------------
			
			; If $a[0]=$a[1] Then
				; MsgBox(0, 'Сообщение', 'Нужно выделить текст')
				; ContinueLoop
			; EndIf
			; _GuiCtrlRichEdit_SetCharBkColor($hRichEdit, 0x00FFFF)
			; --------------
			; _GUICtrlRichEdit_Deselect($hRichEdit)
			; --------------
			; _GUICtrlRichEdit_SetSel($hRichEdit, -1, -1)
			; _GuiCtrlRichEdit_SetCharBkColor($hRichEdit)
			; _GUICtrlRichEdit_SetCharColor($hRichEdit)
			; _GUICtrlRichEdit_Deselect($hRichEdit)
       Case $About
           _About()
		Case $restart
			_restart()
	EndSwitch
WEnd

Func WM_HSCROLL($hWnd, $Msg, $wParam, $lParam)
	#forceref $Msg, $wParam, $lParam
	Local $nScrollCode = BitAND($wParam, 0x0000FFFF)
	Local $value = BitShift($wParam, 16)
	
	Switch $lParam
		Case $hSlider_Handle1
		   If $nScrollCode = 5 Then
				GUICtrlSetData($condition1, $value)
				$aHSB[0]=$value
			EndIf
		Case $hSlider_Handle2
		   If $nScrollCode = 5 Then
				GUICtrlSetData($condition2, $value)
				$aHSB[1]=$value
			EndIf
		Case $hSlider_Handle3
		   If $nScrollCode = 5 Then
				GUICtrlSetData($condition3, $value)
				$aHSB[2]=$value
			EndIf
	EndSwitch
	 $aRGB=_HSB_2_RGB($aHSB)
$NewColor=$aRGB[0]&$aRGB[1]&$aRGB[2]
	GUICtrlSetBkColor($ColorTest, Dec($NewColor))
	$b[$CU][2]=$NewColor
	GUICtrlSetData($ColorCopy, $NewColor)
	
	If $CU = 17 Then
		_GUICtrlRichEdit_SetBkColor($hRichEdit, _ColorConv($b[$CU][2]))
		For $i = 1 to 17
			GUICtrlSetBkColor($b[$i][4], Dec($b[$CU][2]))
		Next
	Else
		_ColorAuto(GUICtrlRead($b[$CU][1]))
		GUICtrlSetColor($b[$CU][4], Dec($b[$CU][2]))
	EndIf
	
	Return 'GUI_RUNDEFMSG'
EndFunc

Func _HSCROLL()
	Local $value = GUICtrlRead($sliderRed)
	
	GUICtrlSetData($condition1, $value)
	$aHSB[0]=$value
				
	 $aRGB=_HSB_2_RGB($aHSB)
$NewColor=$aRGB[0]&$aRGB[1]&$aRGB[2]
	GUICtrlSetBkColor($ColorTest, Dec($NewColor))
	$b[$CU][2]=$NewColor
	GUICtrlSetData($ColorCopy, $NewColor)
	
	If $CU = 17 Then
		_GUICtrlRichEdit_SetBkColor($hRichEdit, _ColorConv($b[$CU][2]))
		For $i = 1 to 17
			GUICtrlSetBkColor($b[$i][4], Dec($b[$CU][2]))
		Next
	Else
		_ColorAuto(GUICtrlRead($b[$CU][1]))
		GUICtrlSetColor($b[$CU][4], Dec($b[$CU][2]))
	EndIf
EndFunc


Func _ColorAuto($select)
	$tmp1=StringSplit($select, '\')
	For $i = 1 to $tmp1[0]
		$tmp2=StringSplit($tmp1[$i], ',')
		If @error Then ExitLoop
		_GuiCtrlRichEdit_SetSel($hRichEdit, $tmp2[1], $tmp2[2], True)
		; _GUICtrlRichEdit_SetCharColor($hRichEdit, $b[$CU][2])
		_GUICtrlRichEdit_SetCharColor($hRichEdit, _ColorConv($b[$CU][2]))
		_GUICtrlRichEdit_Deselect($hRichEdit)
	Next
EndFunc

; Func _ColorConv($RGB)
	; Return Dec(StringMid($RGB, 5, 2)&StringMid($RGB, 3, 2)&StringMid($RGB, 1, 2))
; EndFunc

Func _ColorConv($RGB)
	Local $aRGB=StringRegExp($RGB,'x*([0-9A-Fa-f]{2})([0-9A-Fa-f]{2})([0-9A-Fa-f]{2})$', 3)
	If @error Then Return Dec('0000FF')
	Return Dec($aRGB[2]&$aRGB[1]&$aRGB[0])
EndFunc

Func Error()
	GUIDelete()
EndFunc

;#include <File.au3>
Func _FileReadToArray($sFilePath, ByRef $aArray)
	Local $hFile = FileOpen($sFilePath, 0)
	If $hFile = -1 Then Return SetError(1, 0, 0)
	Local $aFile = FileRead($hFile, FileGetSize($sFilePath))
	If StringRight($aFile, 1) = @LF Then $aFile = StringTrimRight($aFile, 1)
	If StringRight($aFile, 1) = @CR Then $aFile = StringTrimRight($aFile, 1)
	FileClose($hFile)
	If StringInStr($aFile, @LF) Then
		$aArray = StringSplit(StringStripCR($aFile), @LF)
	ElseIf StringInStr($aFile, @CR) Then
		$aArray = StringSplit($aFile, @CR)
	Else
		If StringLen($aFile) Then
			Dim $aArray[2] = [1, $aFile]
		Else
			Return SetError(2, 0, 0)
		EndIf
	EndIf
	Return 1
EndFunc


Func _SetSlider($i)
	$tmp1=Dec(StringLeft($b[$i][2], 2))
	$tmp2=Dec(StringMid($b[$i][2], 3, 2))
	$tmp3=Dec(StringRight($b[$i][2], 2))
	GUICtrlSetData($condition1, $tmp1)
	GUICtrlSetData($condition2, $tmp2)
	GUICtrlSetData($condition3, $tmp3)
	$aRGB[0]=Hex($tmp1, 2)
	$aRGB[1]=Hex($tmp2, 2)
	$aRGB[2]=Hex($tmp3, 2)
	$NewColor=$aRGB[0]&$aRGB[1]&$aRGB[2]
	$aHSB=_RGB_2_HSB($NewColor)
	GUICtrlSetData($sliderRed, $aHSB[0])
	GUICtrlSetData($sliderGreen, $aHSB[1])
	GUICtrlSetData($sliderBlue, $aHSB[2])
	GUICtrlSetData($condition1, $aHSB[0])
	GUICtrlSetData($condition2, $aHSB[1])
	GUICtrlSetData($condition3, $aHSB[2])
	GUICtrlSetBkColor($ColorTest, Dec($NewColor))
	GUICtrlSetData($ColorCopy, $NewColor)
EndFunc

Func _HSB_2_RGB($aHSB)
	Local $min, $max, $aRGB[3]
	
	$aHSB[2]/=100
	
	If $aHSB[1] = 0 Then
		$aRGB[0]=Hex(Round($aHSB[2]*255), 2)
		$aRGB[1]=$aRGB[0]
		$aRGB[2]=$aRGB[0]
		Return $aRGB
	EndIf
	
	While $aHSB[0]>=360
		$aHSB[0]-=360
	WEnd
	
	$aHSB[1]/=100
	$aHSB[0] /= 60
	$Sector=Int($aHSB[0])
	
	$f=$aHSB[0] - $Sector
	$p=$aHSB[2]*(1-$aHSB[1])
	$q=$aHSB[2]*(1-$aHSB[1]*$f)
	$t=$aHSB[2]*(1-$aHSB[1]*(1-$f))
	
	Switch $Sector
		Case 0
		   $aRGB[0]=$aHSB[2]
		   $aRGB[1]=$t
		   $aRGB[2]=$p
		Case 1
		   $aRGB[0]=$q
		   $aRGB[1]=$aHSB[2]
		   $aRGB[2]=$p
		Case 2
		   $aRGB[0]=$p
		   $aRGB[1]=$aHSB[2]
		   $aRGB[2]=$t
		Case 3
		   $aRGB[0]=$p
		   $aRGB[1]=$q
		   $aRGB[2]=$aHSB[2]
		Case 4
		   $aRGB[0]=$t
		   $aRGB[1]=$p
		   $aRGB[2]=$aHSB[2]
		Case Else
		   $aRGB[0]=$aHSB[2]
		   $aRGB[1]=$p
		   $aRGB[2]=$q
	EndSwitch
	
   $aRGB[0]=Hex(Round($aRGB[0]*255), 2)
   $aRGB[1]=Hex(Round($aRGB[1]*255), 2)
   $aRGB[2]=Hex(Round($aRGB[2]*255), 2)
	
	Return $aRGB
EndFunc


Func  _RGB_2_HSB($RGB)
	Local $aRGB, $min, $max, $pat='x*([0-9A-Fa-f]{2})([0-9A-Fa-f]{2})([0-9A-Fa-f]{2})$', $aHSB[3]
	If IsString($RGB) Then
		$aRGB=StringRegExp($RGB,$pat, 3)
		If @error Then Return SetError(1, 0, 0)
	Else
		$aRGB=StringRegExp(Hex($RGB),$pat, 3)
		If @error Then Return SetError(1, 0, 0)
	EndIf
	
	$aRGB[0]=Dec($aRGB[0])
	$aRGB[1]=Dec($aRGB[1])
	$aRGB[2]=Dec($aRGB[2])
	
	If $aRGB[0]<=$aRGB[1] Then
		$min=$aRGB[0]
		$max=$aRGB[1]
	Else
		$min=$aRGB[1]
		$max=$aRGB[0]
	EndIf
	If $min>$aRGB[2] Then $min=$aRGB[2]
	If $max<$aRGB[2] Then $max=$aRGB[2]
	
	If $max = $min Then
		$aHSB[0]=0
	ElseIf $max = $aRGB[0] And $aRGB[1]>=$aRGB[2] Then 
		$aHSB[0]=60*($aRGB[1]-$aRGB[2])/($max - $min)
	ElseIf $max = $aRGB[0] And $aRGB[1]<$aRGB[2] Then 
		$aHSB[0]=60*($aRGB[1]-$aRGB[2])/($max - $min)+360
	ElseIf $max = $aRGB[1] Then 
		$aHSB[0]=60*($aRGB[2]-$aRGB[0])/($max - $min)+120
	ElseIf $max = $aRGB[2] Then 
		$aHSB[0]=60*($aRGB[0]-$aRGB[1])/($max - $min)+240
	EndIf
	
	If $max = 0 Then
		$aHSB[1]=0
	Else
		$aHSB[1]=(1-$min/$max)*100
	EndIf
	
	$aHSB[2]=$max/255*100
	
	$aHSB[0]=Round($aHSB[0])
	$aHSB[1]=Round($aHSB[1])
	$aHSB[2]=Round($aHSB[2])
	
	Return $aHSB
EndFunc

Func _restart()
	GUIDelete()
    Local $sAutoIt_File = @TempDir & "\~Au3_ScriptRestart_TempFile.au3"
    Local $sRunLine, $sScript_Content, $hFile

    $sRunLine = @ScriptFullPath
    If Not @Compiled Then $sRunLine = @AutoItExe & ' /AutoIt3ExecuteScript ""' & $sRunLine & '""'
    If $CmdLine[0] > 0 Then $sRunLine &= ' ' & $CmdLineRaw

    $sScript_Content &= '#NoTrayIcon' & @CRLF & _
    'While ProcessExists(' & @AutoItPID & ')' & @CRLF & _
    '   Sleep(10)' & @CRLF & _
    'WEnd' & @CRLF & _
    'Run("' & $sRunLine & '")' & @CRLF & _
    'FileDelete(@ScriptFullPath)' & @CRLF

    $hFile = FileOpen($sAutoIt_File, 2)
    FileWrite($hFile, $sScript_Content)
    FileClose($hFile)

    Run(@AutoItExe & ' /AutoIt3ExecuteScript "' & $sAutoIt_File & '"', @ScriptDir, @SW_HIDE)
    Sleep(1000)
    Exit
EndFunc  ;==>_re


Func _ChildCoor($Gui, $w, $h, $c=0, $d=0)
	Local $aWA = _WinAPI_GetWorkingArea(), _
	$GP = WinGetPos($Gui), _
	$wgcs=WinGetClientSize($Gui)
	Local $dLeft=($GP[2]-$wgcs[0])/2, _
	$dTor=$GP[3]-$wgcs[1]-$dLeft
	If $c = 0 Then
		$GP[0]=$GP[0]+($GP[2]-$w)/2-$dLeft
		$GP[1]=$GP[1]+($GP[3]-$h-$dLeft-$dTor)/2
	EndIf
	If $d>($aWA[2]-$aWA[0]-$w-$dLeft*2)/2 Or $d>($aWA[3]-$aWA[1]-$h-$dLeft+$dTor)/2 Then $d=0
	If $GP[0]+$w+$dLeft*2+$d>$aWA[2] Then $GP[0]=$aWA[2]-$w-$d-$dLeft*2
	If $GP[1]+$h+$dLeft+$dTor+$d>$aWA[3] Then $GP[1]=$aWA[3]-$h-$dLeft-$dTor-$d
	If $GP[0]<=$aWA[0]+$d Then $GP[0]=$aWA[0]+$d
	If $GP[1]<=$aWA[1]+$d Then $GP[1]=$aWA[1]+$d
	$GP[2]=$w
	$GP[3]=$h
	Return $GP
EndFunc

Func _WinAPI_GetWorkingArea()
    Local Const $SPI_GETWORKAREA = 48
    Local $stRECT = DllStructCreate("long; long; long; long")

    Local $SPIRet = DllCall("User32.dll", "int", "SystemParametersInfo", "uint", $SPI_GETWORKAREA, "uint", 0, "ptr", DllStructGetPtr($stRECT), "uint", 0)
    If @error Then Return 0
    If $SPIRet[0] = 0 Then Return 0

    Local $sLeftArea = DllStructGetData($stRECT, 1)
    Local $sTopArea = DllStructGetData($stRECT, 2)
    Local $sRightArea = DllStructGetData($stRECT, 3)
    Local $sBottomArea = DllStructGetData($stRECT, 4)

    Local $aRet[4] = [$sLeftArea, $sTopArea, $sRightArea, $sBottomArea]
    Return $aRet
EndFunc


Func _About()
$GP=_ChildCoor($hGui, 210, 180)
GUISetState(@SW_DISABLE, $hGui)
$font="Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], 0x00C00000+0x00080000, -1, $hGui) ; WS_CAPTION+WS_SYSMENU
	GUISetBkColor (0xffca48)
	GUICtrlCreateLabel($LngTitle, 0, 0, 210, 63, 0x01+0x0200)
	GUICtrlSetFont (-1,14, 600, -1, $font)
	GUICtrlSetColor(-1,0xa13d00)
	GUICtrlSetBkColor (-1, 0xfbe13f)
	GUICtrlCreateLabel ("-", 2,64,208,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.2  28.05.2011', 15, 100, 210, 17)
	GUICtrlCreateLabel($LngSite&':', 15, 115, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', 52, 115, 170, 17)
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 15, 130, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', 90, 130, 125, 17)
	GUICtrlSetColor(-1,0xa21a10)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2010', 15, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
$msg = $Gui1
	While 1
	  $msg = GUIGetMsg()
	  Select
		Case $msg = $url
			ShellExecute ('http://azjio.ucoz.ru')
		Case $msg = $WbMn
			ClipPut('R939163939152')
		Case $msg = -3
			$msg = $hGui
			GUISetState(@SW_ENABLE, $hGui)
			GUIDelete($Gui1)
			ExitLoop
		EndSelect
    WEnd
EndFunc