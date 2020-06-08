#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_OutFile=JumpToString_CMD.exe
#AutoIt3Wrapper_icon=JumpToString.ico
#AutoIt3Wrapper_Compression=n
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=JumpToString_CMD.exe
#AutoIt3Wrapper_Res_Fileversion=0.3.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=AZJIO
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Res_Field=Version|0.3
#AutoIt3Wrapper_Res_Field=Build|2011.10.30
#AutoIt3Wrapper_Res_Field=Coded by|AZJIO
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Res_Icon_Add=1.ico
#AutoIt3Wrapper_Res_Icon_Add=2.ico
#AutoIt3Wrapper_Res_Icon_Add=3.ico
#AutoIt3Wrapper_Res_Icon_Add=4.ico
#AutoIt3Wrapper_Run_Obfuscator=y
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
#AutoIt3Wrapper_Run_After=%autoitdir%\SciTE\upx\upx.exe -7 --compress-icons=0 "%out%"
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
; Ошибку обфускации функции Assign разрешаем кнопкой "continue" (продолжить)

;  @AZJIO 30.10.2011 (AutoIt3_v3.3.6.1)
#NoTrayIcon
#include <nppUDF.au3>
#include <Array.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiImageList.au3>
#include <GuiTreeView.au3>
#include <Misc.au3>

Opt("GUIResizeMode", 802)
Opt("GUIOnEventMode", 1)
;==========================================================
; En
$LngTitle='Jump to string'
$LngAbout='About'
$LngVer='Version'
$LngSite='Site'
$LngCopy='Copy'
$LngLVFN='Function name'
$LngMB1='Message'
$LngMB2='The program requires to run Notepad++ editor'
$LngMB3='Error'
$LngMB4='The label is not found, so removed'
$LngMB5='To apply the settings you must restart the utility.'&@CRLF&'Restart?'
$LngIB1='Add'
$LngIB2='Item name'
$LngDel='Delete selected'
$LngUsr='1 User'
$LngRgn='2 Regions'
$LngFnc='3 Functions'
$LngCmm='4 Comments'

$Lang_dll = DllOpen("kernel32.dll")
$UserIntLang=DllCall ( $Lang_dll, "int", "GetUserDefaultUILanguage" )
If Not @error Then $UserIntLang=Hex($UserIntLang[0],4)
DllClose($Lang_dll)

; Ru
; если русская локализация, то русский язык
If $UserIntLang = 0419 Then
	; $LngTitle='Перейти к строке'
	$LngAbout='О программе'
	$LngVer='Версия'
	$LngSite='Сайт'
	$LngCopy='Копировать'
	$LngLVFN='Имя функции'
	$LngMB1='Сообщение'
	$LngMB2='Для работы программы требуется запустить редактор Notepad++'
	$LngMB3='Ошибка'
	$LngMB4='Метка не найдена, поэтому удалена'
	$LngMB5='Для применения параметров необходим перезапуск утилиты. '&@CRLF&'Выполнить перезапуск?'
	$LngIB1='Добавить'
	$LngIB2='Название пункта'
	$LngDel='Удалить пункт'
	$LngUsr='1 Пользовательские'
	$LngRgn='2 Регион'
	$LngFnc='3 Функции'
	$LngCmm='4 Комментарии'
EndIf
;==========================================================

If Not WinExists('[CLASS:Notepad++]') Then
	MsgBox(262144, $LngMB1, $LngMB2)
	Exit
EndIf

Global $TabNameNP, $TabNameNP2, $aTabNameNP[1][2], $UserItem, $Funcitem, $Regionitem, $Commentsitem, $aFunc[1][4], $aRegion[1][4], $aComments[1][4], $aUser[1][4], $geUser, $geFunc, $geRegion, $geComments, $aFont[1]=[0]
Global $FileData=@ScriptDir&'\JumpToStringData.txt', $DelIItemI=-1, $DelIItemH=-1, $Tr7=0, $XYPos[4]
Global $Gui1, $TrSort=1, $OnTop=0, $Ini=@ScriptDir&'\JumpToString_CMD.ini'
Global $RedExp1='(?m)^(\h*:)([^:][^\r\n]*)', $RedExp2='(?mi)^\h*(\#Region\h*)([^\r\n]*)', $RedExp3='(?mi)^\h*(rem \h*|::\h*)([^\r\n]*)'
; Global $RedExp1='(?mi)^\h*(Func\h+)(\w+\W)', $RedExp2='(?mi)^\h*(\#Region\h*)([^\r\n]*)', $RedExp3='(?mi)^\h*[^''"]*?(?:''.*?''.*?|".*?".*?)*(;|#cs)([^\r\n]*)'

Switch @OSVersion
	Case 'WIN_VISTA', 'WIN_7'
		$Tr7=1
EndSwitch

If DriveStatus(StringLeft(@ScriptDir, 1))<>'NOTREADY' Then
	$DriveRead=1
Else
	$DriveRead=0
EndIf

If Not FileExists($Ini) And $DriveRead=1 Then
$file = FileOpen($Ini,2)
FileWrite($file, '[Set]' & @CRLF & _
'Sort=1' & @CRLF & _
'OnTop=0' & @CRLF & _
'RedExp1='&$RedExp1 & @CRLF & _
'RedExp2='&$RedExp2 & @CRLF & _
'HotKey=^{F11}' &@CRLF& _
'NameUser='&$LngUsr &@CRLF& _
'NameRegions='&$LngRgn &@CRLF& _
'NameFunctions='&$LngFnc &@CRLF& _
'NameComments='&$LngCmm &@CRLF& _
'geUser=1' &@CRLF& _
'geFunc=1' &@CRLF& _
'geRegion=1' &@CRLF& _
'geComments=1' &@CRLF& _
'BkColor=FFFFDD' &@CRLF& _
'TextColor=' &@CRLF& _
'LineColor=' &@CRLF& _
'W=230' &@CRLF& _
'H=420' &@CRLF& _
'X=' &@CRLF& _
'Y=')
FileClose($file)
EndIf
; 'Font=0,Arial,10,400' &@CRLF& _

$LngUsr=IniRead($Ini, 'Set', 'NameUser', $LngUsr)
$LngRgn=IniRead($Ini, 'Set', 'NameRegions', $LngRgn)
$LngFnc=IniRead($Ini, 'Set', 'NameFunctions', $LngFnc)
$LngCmm=IniRead($Ini, 'Set', 'NameComments', $LngCmm)

$TrOnTop=Number(IniRead($Ini, 'Set', 'OnTop', 0))
$TrSort=Number(IniRead($Ini, 'Set', 'Sort', 1))
$RedExp1=IniRead($Ini, 'Set', 'RedExp1', $RedExp1)
$RedExp2=IniRead($Ini, 'Set', 'RedExp2', $RedExp2)
$HotKey=IniRead($Ini, 'Set', 'HotKey', '^{F11}')


$iniFont=IniRead($Ini, 'Set', 'Font', '')

$geUser=Number(IniRead($Ini, 'Set', 'geUser', 1))
$geFunc=Number(IniRead($Ini, 'Set', 'geFunc', 1))
$geRegion=Number(IniRead($Ini, 'Set', 'geRegion', 1))
$geComments=Number(IniRead($Ini, 'Set', 'geComments', 1))

$XYPos[0]=Number(IniRead($Ini, 'Set', 'W', '230'))
$XYPos[1]=Number(IniRead($Ini, 'Set', 'H', '420'))
$XYPos[2]=IniRead($Ini, 'Set', 'X', '')
$XYPos[3]=IniRead($Ini, 'Set', 'Y', '')

$BkColor=IniRead($Ini, 'Set', 'BkColor', '')
$TextColor=IniRead($Ini, 'Set', 'TextColor', '')
$LineColor=IniRead($Ini, 'Set', 'LineColor', '')
If $BkColor = '' Then
	$BkColor = -1
Else
	$BkColor = Dec($BkColor)
EndIf
If $TextColor = '' Then
	$TextColor = -1
Else
	$TextColor = Dec($TextColor)
EndIf
If $LineColor = '' Then
	$LineColor = -1
Else
	$LineColor = Dec($LineColor)
EndIf

If BitAnd(WinGetState('[CLASS:Notepad++]'), 16) Then WinSetState('[CLASS:Notepad++]','',@SW_RESTORE)
$tmp = ControlGetPos('[CLASS:Notepad++]', "", "[CLASSNN:Scintilla1]")
If $XYPos[0]<230 Then $XYPos[0]=230
If $tmp[3]<150 Then
	$XYPos[1]=150
Else
	$XYPos[1]=$tmp[3]
EndIf
_SetCoor($XYPos)

_ReadData()

HotKeySet($HotKey, "_AddUserItem")
; HotKeySet("^1", "_FuncName")
$Gui = GUICreate($LngTitle, $XYPos[0], $XYPos[1], $XYPos[2], $XYPos[3], $WS_OVERLAPPEDWINDOW)
If @compiled Then
	$AutoItExe=@AutoItExe
Else
	$AutoItExe=@ScriptDir&'\JumpToString.dll'
	GUISetIcon($AutoItExe, 99)
EndIf
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
If $iniFont<>'' Then
	$aFont=StringSplit($iniFont, ',')
	If $aFont[0]=4 Then GUISetFont($aFont[3], $aFont[4], $aFont[1], $aFont[2])
EndIf

GUICtrlCreateButton("@", 4, 1, 20, 20)
GUICtrlSetResizing(-1, 2+32 + 256 + 512)
GUICtrlSetOnEvent(-1, "_About")

GUICtrlCreateButton("font", $XYPos[0]-65, 1, 35, 20)
GUICtrlSetResizing(-1, 4+32 + 256 + 512)
GUICtrlSetOnEvent(-1, "_SelFont")

GUICtrlCreateButton("+", $XYPos[0]-24, 1, 20, 20)
GUICtrlSetResizing(-1, 4+32 + 256 + 512)
GUICtrlSetOnEvent(-1, "_AddUserItem")

$ChSort=GUICtrlCreateCheckbox('Sort', 40, 2, 50, 17)
GUICtrlSetOnEvent(-1, "_Sort")
If $TrSort=1 Then GUICtrlSetState(-1, 1)

$ChOnTop=GUICtrlCreateCheckbox('on top', 90, 2, 70, 17)
GUICtrlSetOnEvent(-1, "_On_top")

$TreeView = GUICtrlCreateTreeView(5, 22, $XYPos[0]-10, $XYPos[1]-25)
GUICtrlSetResizing(-1, 2 + 4 + 32 + 64)
$hTreeView = GUICtrlGetHandle($TreeView)

If $BkColor <> -1 Then _GUICtrlTreeView_SetBkColor($hTreeView, $BkColor)
If $TextColor <> -1 Then _GUICtrlTreeView_SetTextColor($hTreeView, $TextColor)
If $LineColor <> -1 Then _GUICtrlTreeView_SetLineColor($hTreeView, $LineColor)

$hImage = _GUIImageList_Create (16, 16, 5)
_GUIImageList_AddIcon ( $hImage, $AutoItExe, -201 )
_GUIImageList_AddIcon ( $hImage, $AutoItExe, -202 )
_GUIImageList_AddIcon ( $hImage, $AutoItExe, -203 )
_GUIImageList_AddIcon ( $hImage, $AutoItExe, -204 )
_GUICtrlTreeView_SetNormalImageList ($hTreeView, $hImage)

Global $ContMenu = GUICtrlCreateContextMenu(GUICtrlCreateDummy())
GUICtrlCreateMenuItem($LngDel, $ContMenu)
GUICtrlSetOnEvent(-1, "_DelUserItem")

_FillingList()
GUISetState()
GUISetState(@SW_RESTORE)
Sleep(200)
WinSetOnTop($GUI, '', 1)
WinSetOnTop($GUI, '', 0)

If Not @error And $TrOnTop=1 Then
	WinSetOnTop($GUI, '', 1)
	GUICtrlSetState($ChOnTop, 1)
EndIf

GUIRegisterMsg(0x0024, "WM_GETMINMAXINFO")
GUIRegisterMsg(0x004E, 'WM_NOTIFY')
GUIRegisterMsg(0x0046 , "WM_WINDOWPOSCHANGING")
AdlibRegister("_NPPGetTitle", 400)
OnAutoItExitRegister("_Save_Exit")

While 1
	Sleep(100000)
WEnd

Func _SelFont()
	If $aFont[0]=4 Then
		$a_font = _ChooseFont($aFont[2], $aFont[3], 0, $aFont[4], False, False, False, $Gui)
	Else
		$a_font = _ChooseFont('Arial', 10, 0, 0, False, False, False, $Gui)
	EndIf
	If Not @error Then
		IniWrite($Ini, 'Set', 'Font', _ArrayToString($a_font, ',', 1, 4))
		If MsgBox (4, $LngMB1, $LngMB5, 0, $Gui)=6 Then _restart()
	EndIf
EndFunc

Func _restart()
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
EndFunc

; добавление пункта пользователя
Func _AddUserItem()
	Local $AllText, $CurLine, $gp, $i, $n, $sempl, $tmp, $word
	$word=_npp_GetText(0)
	If $word = '' Then
		$word=_npp_GetText(1)
		If $word = '' Then Return
	EndIf
	$gp=WinGetPos($Gui)
	$GP=_ChildCoor($Gui, 170, 150, 1) ; центрирование диалога в окне
	$sempl=InputBox($LngIB1, $LngIB2, StringLeft(StringStripWS ($word, 7 ), 19), '', $GP[2], $GP[3], $GP[0], $GP[1], -1, $Gui)
	If Not @error And $sempl<>'' Then
		; поиск номера совпадения, если образец повторяется многократно по тексту
		$AllText=_npp_GetText()
		$CurLine=_SendMessage(WinGetHandle('[CLASS:Notepad++]'), $NPPM_GETCURRENTLINE, 0, 0)
		$i=0
		Do
			$i+=1
			$tmp=StringInStr($AllText, $word, 1, $i)
			If $tmp = 0 Then Return
			; $tmp=StringSplit(StringLeft($AllText, $tmp), @LF)
			; $tmp=$tmp[0]-1
			$tmp=StringRegExp(StringLeft($AllText, $tmp), '(\r\n|\r|\n)', 3)
			$tmp=UBound($tmp)
		Until Abs($tmp-$CurLine)<2 ; выход из цикла если номер строки совпадает с найденным по количеству переносов строк
		;Добавляем пункт в дерево и атрибуты в массив
		$n=UBound($aUser)
		ReDim $aUser[$n+1][4]
		$aUser[$n][0]=$sempl
		$aUser[$n][1]=$word
		$aUser[$n][2]=_GUICtrlTreeView_GetItemHandle ($TreeView, _GUICtrlTreeView_AddChild ( $TreeView, $UserItem, $sempl, 2, 2 ))
		$aUser[$n][3]=$i
		; _GUICtrlTreeView_Expand ($TreeView)
		_GUICtrlTreeView_Expand($TreeView, $UserItem)
		$geUser = True
	EndIf
	WinActivate('[CLASS:Notepad++]')
EndFunc

; получить путь из заголовка редактора, проверка каждые 400 милисекунд
Func _NPPGetTitle()
    Local $Title = WinGetTitle('[CLASS:Notepad++]')
	If $Title = '0' Then
		AdlibUnRegister("_NPPGetTitle")
		MsgBox(0, $LngMB3, $LngMB2)
		Exit
	EndIf
    If $TabNameNP == $Title Then Return
	; индекс 2 ($Title2 и $TabNameNP2) избавляет зависимость от * в загловке
	If StringLeft($Title, 1)='*' Then
		$Title2=StringTrimLeft($Title, 1)
	Else
		$Title2=$Title
	EndIf
    If Not($TabNameNP2 == $Title2) Then
		If UBound($aUser)>1 Then
			$iItem = _ArraySearch($aTabNameNP, $TabNameNP2, 0, 0, 0, 0, 1, 0) ; поиск для сохранения имя+массив
			If @error Then
				$n=UBound($aTabNameNP)
				ReDim $aTabNameNP[$n+1][2]
				$aTabNameNP[$n][0]=$TabNameNP2
				$aTabNameNP[$n][1]=$aUser
			Else
				$aTabNameNP[$iItem][1]=$aUser
			EndIf
		EndIf
		$iItem = _ArraySearch($aTabNameNP, $Title2, 0, 0, 0, 0, 1, 0) ; поиск в сохранениях чтобы использовать
		If @error Then
			$aUser=''
			Dim $aUser[1][4]
		Else
			$aUser=$aTabNameNP[$iItem][1]
		EndIf
	EndIf
	$TabNameNP2 = $Title2
    $TabNameNP = $Title
	_FillingList()
    ; Local $path = StringRegExpReplace($tTitle, '^*?(.*?)([ ]-[ ]Notepad\+\+)','\1')
EndFunc

; пересоздание дерева
Func _FillingList()
	$err=0
	_GUICtrlTreeView_BeginUpdate ( $TreeView )
	If _GUICtrlTreeView_GetChildCount($TreeView, $UserItem)>0 Then $geUser=_GUICtrlTreeView_GetExpanded($TreeView, $UserItem)
	If _GUICtrlTreeView_GetChildCount($TreeView, $Funcitem)>0 Then $geFunc=_GUICtrlTreeView_GetExpanded($TreeView, $Funcitem)
	If _GUICtrlTreeView_GetChildCount($TreeView, $Regionitem)>0 Then $geRegion=_GUICtrlTreeView_GetExpanded($TreeView, $Regionitem)
	If _GUICtrlTreeView_GetChildCount($TreeView, $Commentsitem)>0 Then $geComments=_GUICtrlTreeView_GetExpanded($TreeView, $Commentsitem)
	_GUICtrlTreeView_DeleteAll ( $TreeView )
	$UserItem = _GUICtrlTreeView_Add ( $TreeView, 0, $LngUsr, 2, 2 )
	$Funcitem = _GUICtrlTreeView_Add ( $TreeView, 0, $LngFnc, 0, 0 )
	$Regionitem = _GUICtrlTreeView_Add ( $TreeView, 0, $LngRgn, 1, 1 )
	$Commentsitem = _GUICtrlTreeView_Add ( $TreeView, 0, $LngCmm, 3, 3 )
	; _GUICtrlTreeView_SetImageIndex ($TreeView, $UserItem, 1)
	$AllText=_npp_GetText()
	$aFunc=StringRegExp($AllText, $RedExp1, 3) ; добавляем функции скрипта
	If Not @error Then _AddItem($aFunc, $Funcitem, 0)
	$aRegion=StringRegExp($AllText, $RedExp2, 3) ; добавляем областей скрипта
	If Not @error Then _AddItem1($aRegion, $Regionitem, 1)
	_AddItem2($AllText)
	$n=UBound($aUser)
	If $n>1 Then
		For $i = 1 to $n-1
			$aUser[$i][2]=_GUICtrlTreeView_GetItemHandle ($TreeView, _GUICtrlTreeView_AddChild ( $TreeView, $UserItem, $aUser[$i][0], 2, 2 ))
		Next
	EndIf
	If $TrSort = 1 Then _GUICtrlTreeView_Sort ($TreeView)
	If $geUser = True Then _GUICtrlTreeView_Expand($TreeView, $UserItem)
	If $geFunc = True Then _GUICtrlTreeView_Expand($TreeView, $Funcitem)
	If $geRegion = True Then _GUICtrlTreeView_Expand($TreeView, $Regionitem)
	If $geComments = True Then _GUICtrlTreeView_Expand($TreeView, $Commentsitem)
	_GUICtrlTreeView_EndUpdate ( $TreeView )
EndFunc

; придаток к _FillingList, создаёт полноценный массив
Func _AddItem(ByRef $aFunc, $Parent, $x)
	$tmp=UBound($aFunc)
	Local $aTmp[$tmp/2][4]
	For $i = 0 to $tmp-1 Step 2
		$aTmp[$i/2][0]=$aFunc[$i+1]
		$aTmp[$i/2][1]=$aFunc[$i]&$aFunc[$i+1]
		$aTmp[$i/2][2]=_GUICtrlTreeView_GetItemHandle ($TreeView, _GUICtrlTreeView_AddChild ( $TreeView, $Parent, $aTmp[$i/2][0], $x, $x ))
		$aTmp[$i/2][3]=1
	Next
	$aFunc=$aTmp
EndFunc

Func _AddItem1(ByRef $aFunc, $Parent, $x)
	$tmp=UBound($aFunc)
	Local $aTmp[$tmp/2][4]
	For $i = 0 to $tmp-1 Step 2
		If $aFunc[$i]='#Region' And $aFunc[$i+1]='' Then $aFunc[$i+1]='#Region'
		$aTmp[$i/2][0]=$aFunc[$i+1]
		$aTmp[$i/2][1]=$aFunc[$i]&$aFunc[$i+1]
		$aTmp[$i/2][2]=_GUICtrlTreeView_GetItemHandle ($TreeView, _GUICtrlTreeView_AddChild ( $TreeView, $Parent, $aTmp[$i/2][0], $x, $x ))
		$aTmp[$i/2][3]=1
	Next
	$aFunc=$aTmp
EndFunc

Func _AddItem2($AllText)
	$TmpAll=StringRegExpReplace($AllText, '(?si)(\h*(?:rem |::)[^\r\n]*?[\r\n]+)(\h*(?:rem |::)[^\r\n]*?[\r\n]+)+', '\1') ; удаляет повторные строки комментариев
	$TmpAll=StringRegExpReplace($TmpAll, '(?mi)^(?!\h*rem |\h*::).*?[\r\n]+', '') ; удаляет строки без комментариев
	$aComments=StringRegExp($TmpAll, $RedExp3, 3) ; добавляем комментарии скрипта
	If Not @error Then
		$tmp=UBound($aComments)
		Local $aTmp[$tmp/2][4]
		For $i = 0 to $tmp-1 Step 2
			$aTmp[$i/2][0]=$aComments[$i+1]
			$aTmp[$i/2][1]=$aComments[$i]&$aComments[$i+1]
			$aTmp[$i/2][3]=1
		Next
; _ArrayDisplay($aTmp, 'Array')
		
		Assign('/', 1, 1) ;для исключения пустых строк и не совпадения с локальными переменными
		$k=0
		For $i = 0 To UBound($aTmp)-1
			Assign($aTmp[$i][0]&'/', Eval($aTmp[$i][0]&'/')+1, 1)
			If Eval($aTmp[$i][0]&'/') = 1 Then
				$aTmp[$k][0]=$aTmp[$i][0]
				$aTmp[$k][1]=$aTmp[$i][1]
				$aTmp[$k][2]=_GUICtrlTreeView_GetItemHandle ($TreeView, _GUICtrlTreeView_AddChild ( $TreeView, $Commentsitem, $aTmp[$i][0], 3, 3 ))
				$aTmp[$k][3]=$aTmp[$i][3]
				$k+=1
			EndIf
		Next
		If $k = 0 Then Return SetError(1, 0, 0)
		ReDim $aTmp[$k][4]
		
		$aComments=$aTmp
		
	EndIf
EndFunc

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $aTmp, $tmp, $tmp2

    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    Switch $hWndFrom
        Case $hTreeView
            Switch $iCode
                Case $NM_CLICK
					;http://www.autoitscript.com/forum/topic/64632-checked-all-and-treeview/page__view__findpost__p__481808
					; получение хэндла кликнутого пункта и поиск его в массиве
					Local $tMPos = _WinAPI_GetMousePos(True, $hWndFrom), $tHit = _GUICtrlTreeView_HitTestEx($hWndFrom, DllStructGetData($tMPos, 1), DllStructGetData($tMPos, 2))
					Local $hItem = DllStructGetData($tHit, "Item")
					$user_metka=0
					If $hItem <> -1 And $hItem<>0x0 Then
						$iItem = _ArraySearch($aFunc, $hItem, 0, 0, 0, 0, 1, 2)
						If $iItem=-1 Then
							$iItem = _ArraySearch($aRegion, $hItem, 0, 0, 0, 0, 1, 2)
							If $iItem=-1 Then
								$iItem = _ArraySearch($aComments, $hItem, 0, 0, 0, 0, 1, 2)
								If $iItem=-1 Then
									$iItem = _ArraySearch($aUser, $hItem, 0, 0, 0, 0, 1, 2)
									$user_metka=1
									If $iItem=-1 Then
										Return $GUI_RUNDEFMSG
									Else
										$aTmp=$aUser
									EndIf
								Else
									$aTmp=$aComments
								EndIf
							Else
								$aTmp=$aRegion
							EndIf
						Else
							$aTmp=$aFunc
						EndIf
					Else
						Return $GUI_RUNDEFMSG
					EndIf
					
					; Поиск найденного в тексте кода
					$AllText=_npp_GetText()
					If $user_metka Then
						$tmp=StringInStr($AllText, $aTmp[$iItem][1], 1 , $aTmp[$iItem][3])
					Else
						$tmp=StringInStr($AllText, @CRLF&$aTmp[$iItem][1]&@CRLF, 1 , $aTmp[$iItem][3])
					EndIf
					If $tmp = 0 Then
						$DelIItemH=$hItem
						$DelIItemI=$iItem
						_DelUserItem()
						MsgBox(8192+262144, $LngMB3, $LngMB4)
						WinActivate('[CLASS:Notepad++]')
						Return $GUI_RUNDEFMSG
					EndIf
					$tmp=StringRegExp(StringLeft($AllText, $tmp), '(\r\n|\r|\n)', 3)
					$tmp=UBound($tmp)
					; делаем поправку, чтоб передвинуть строку к центру окна
					$CurLine=_SendMessage(WinGetHandle('[CLASS:Notepad++]'), $NPPM_GETCURRENTLINE, 0, 0)
					$pos = ControlGetPos('[CLASS:Notepad++]', "", "[CLASSNN:Scintilla1]")
					$tmp2=$pos[3]/32
					If $tmp>$CurLine Then
						$tmp2=$tmp+$tmp2
					Else
						$tmp2=$tmp-$tmp2
					EndIf
					_npp_SetCurPos($tmp2)
					_npp_SetCurPos($tmp)
					WinActivate('[CLASS:Notepad++]')
                Case $NM_RCLICK
					Local $tMPos = _WinAPI_GetMousePos(True, $hWndFrom), $tHit = _GUICtrlTreeView_HitTestEx($hWndFrom, DllStructGetData($tMPos, 1), DllStructGetData($tMPos, 2))
					Local $hItem = DllStructGetData($tHit, "Item")
					If $hItem <> -1 And $hItem<>0x0 Then
						$iItem = _ArraySearch($aUser, $hItem, 0, 0, 0, 0, 1, 2)
						If $iItem<>-1 Then
							$DelIItemH=$hItem
							$DelIItemI=$iItem
							Local $hMenu = GUICtrlGetHandle($ContMenu)
							$x = MouseGetPos(0)
							$y = MouseGetPos(1)
							DllCall("user32.dll", "int", "TrackPopupMenuEx", "hwnd", $hMenu, "int", 0, "int", $x, "int", $y, "hwnd", $Gui, "ptr", 0)
						EndIf
					Else
						Return $GUI_RUNDEFMSG
					EndIf
            EndSwitch
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc

Func _DelUserItem()
	If $DelIItemI<>-1 Then
		_ArrayDelete($aUser, $DelIItemI)
		_GUICtrlTreeView_Delete($TreeView, $DelIItemH)
		$DelIItemI=-1
		$DelIItemH=-1
	EndIf
EndFunc

; Func _FuncName()
	; MsgBox(0, 'Message', $test)
; EndFunc

; ограничения размеров окна
Func WM_GETMINMAXINFO($hWnd, $iMsg, $wParam, $lParam)
	#forceref $iMsg, $wParam
	If $hWnd = $GUI Then
		Local $tMINMAXINFO = DllStructCreate("int;int;" & _
				"int MaxSizeX; int MaxSizeY;" & _
				"int MaxPositionX;int MaxPositionY;" & _
				"int MinTrackSizeX; int MinTrackSizeY;" & _
				"int MaxTrackSizeX; int MaxTrackSizeY", _
				$lParam)
		DllStructSetData($tMINMAXINFO, "MaxTrackSizeX", 500)
		DllStructSetData($tMINMAXINFO, "MaxTrackSizeY", @DesktopHeight-60)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeX", 235)
		DllStructSetData($tMINMAXINFO, "MinTrackSizeY", 150)
		DllStructSetData($tMINMAXINFO, "MaxSizeX", $XYPos[0])
		DllStructSetData($tMINMAXINFO, "MaxSizeY", @DesktopHeight-60)
		DllStructSetData($tMINMAXINFO, "MaxPositionX", 0)
		DllStructSetData($tMINMAXINFO, "MaxPositionY", 0)
	EndIf
EndFunc

; вычисление координат дочернего окна
; 1 - дескриптор родительского окна
; 2 - ширина дочернего окна
; 3 - высота дочернего окна
; 4 - тип 0 - по центру, или 0 - к левому верхнему родительского окна
; 5 - отступ от краёв
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

Func _Exit()
	Exit
EndFunc

Func _Sort()
	$TrSort=GUICtrlRead($ChSort)
	_FillingList()
EndFunc

Func _On_top()
	$TrOnTop=GUICtrlRead($ChOnTop)
	If $TrOnTop = 1 Then
		WinSetOnTop($GUI, '', 1)
	Else
		WinSetOnTop($GUI, '', 0)
	EndIf
EndFunc

; валидность координат проверяем при запуске
Func _SetCoor(ByRef $XYPos)
	$Xtmp=Number($XYPos[2])
	$Ytmp=Number($XYPos[3])
	If $Xtmp < 0 Then $Xtmp=0
	If $Xtmp > @DesktopWidth-$XYPos[0] Then $Xtmp=@DesktopWidth-$XYPos[0]
	If $XYPos[2]='' Then $Xtmp=0
	If $Ytmp < 0 And $Ytmp <>-1 Then $Ytmp=0
	If $Ytmp > @DesktopHeight-$XYPos[1] Then $Ytmp=@DesktopHeight-$XYPos[1]
	If $XYPos[3]='' Then $Ytmp=-1
	$XYPos[2]=$Xtmp
	$XYPos[3]=$Ytmp
EndFunc

Func WM_WINDOWPOSCHANGING($hWnd, $Msg, $wParam, $lParam)
	Local $sRect = DllStructCreate("Int[6]", $lparam)
	Switch $Tr7
		Case 1
			If DllStructGetData($sRect, 1, 5)<>0 And Not BitAnd(WinGetState($Gui), 16) Then
				$XYPos[2]=DllStructGetData($sRect, 1, 3)
				$XYPos[3]=DllStructGetData($sRect, 1, 4)
				$XYPos[0]=DllStructGetData($sRect, 1, 5)
			EndIf
		Case Else
			If DllStructGetData($sRect, 1, 2) And DllStructGetData($sRect, 1, 5)<>0 And Not BitAnd(WinGetState($Gui), 16) Then
				$XYPos[2]=DllStructGetData($sRect, 1, 3)
				$XYPos[3]=DllStructGetData($sRect, 1, 4)
				$XYPos[0]=DllStructGetData($sRect, 1, 5)
			EndIf
	EndSwitch
	Return 'GUI_RUNDEFMSG'
EndFunc

; сохранение пользовательских меток в файл
Func _Save_Exit()
	If $DriveRead=0 Then Exit
	IniWrite($Ini, 'Set', 'Sort', $TrSort)
	IniWrite($Ini, 'Set', 'OnTop', $TrOnTop)
	; сохранить координаты окна
	IniWrite($Ini, 'Set', 'X', $XYPos[2])
	IniWrite($Ini, 'Set', 'Y', $XYPos[3])
	IniWrite($Ini, 'Set', 'W', $XYPos[0])
	IniWrite($Ini, 'Set', 'H', $XYPos[1])
	

	If _GUICtrlTreeView_GetChildCount($TreeView, $UserItem)>0 Then $geUser=_GUICtrlTreeView_GetExpanded($TreeView, $UserItem)
	If _GUICtrlTreeView_GetChildCount($TreeView, $Funcitem)>0 Then $geFunc=_GUICtrlTreeView_GetExpanded($TreeView, $Funcitem)
	If _GUICtrlTreeView_GetChildCount($TreeView, $Regionitem)>0 Then $geRegion=_GUICtrlTreeView_GetExpanded($TreeView, $Regionitem)
	If _GUICtrlTreeView_GetChildCount($TreeView, $Commentsitem)>0 Then $geComments=_GUICtrlTreeView_GetExpanded($TreeView, $Commentsitem)
	IniWrite($Ini, 'Set', 'geUser', Number($geUser))
	IniWrite($Ini, 'Set', 'geFunc', Number($geFunc))
	IniWrite($Ini, 'Set', 'geRegion', Number($geRegion))
	IniWrite($Ini, 'Set', 'geComments', Number($geComments))
	
	Local $n
	; обновить последние данные об изменении
		$iItem = _ArraySearch($aTabNameNP, $TabNameNP2, 0, 0, 0, 0, 1, 0) ; поиск для сохранения имя+массив
		If @error Then
			If UBound($aUser)>1 Then
				$n=UBound($aTabNameNP)
				ReDim $aTabNameNP[$n+1][2]
				$aTabNameNP[$n][0]=$TabNameNP2
				$aTabNameNP[$n][1]=$aUser
			EndIf
		Else
			If UBound($aUser)>1 Then
				$aTabNameNP[$iItem][1]=$aUser
			Else
				$n=UBound($aTabNameNP)-1
				For $i = $iItem to $n-1
					$aTabNameNP[$i][0]=$aTabNameNP[$i+1][0]
					$aTabNameNP[$i][1]=$aTabNameNP[$i+1][1]
				Next
				ReDim $aTabNameNP[$n][2]
			EndIf
		EndIf
	; EndIf
	; сохранить, конвертируя данные в строку
	$n=UBound($aTabNameNP)
	If $n>1 Then
		$TextSaveFile=''
		For $i = 1 to $n-1
			$aTmp=$aTabNameNP[$i][1]
			$mTmp=''
			For $s = 1 to UBound($aTmp)-1
				$mTmp&=$aTmp[$s][0]&'<¤>'&$aTmp[$s][1]&'<¤><¤>'&$aTmp[$s][3]&'<|¤|>'
			Next
			If StringMid($aTabNameNP[$i][0], 2, 1)=':' And Not FileExists(StringRegExpReplace($aTabNameNP[$i][0], '(.*?)(?: - Notepad\+\+)', '\1')) Then ContinueLoop
			$TextSaveFile&=$aTabNameNP[$i][0]&'<|>'&StringTrimRight($mTmp, 5)&@CRLF&'//>>'
		Next
		$file = FileOpen($FileData,2)
		FileWrite($file, '//>>'&StringTrimRight($TextSaveFile, 6))
		FileClose($file)
	Else
		If FileExists($FileData) Then
			FileDelete($FileData)
		EndIf
	EndIf
EndFunc

; чтение пользовательских меток из файла
Func _ReadData()
	Local $tmp, $aTmp, $tmp1
	If FileExists($FileData) Then
		$tmp = FileRead($FileData)
		$tmp = StringTrimLeft($tmp, 4)
		$aTmp = StringSplit($tmp, @CRLF&'//>>', 1)
		If @error And $aTmp[1]='' Then
			MsgBox(0, $LngMB3, $FileData)
			Return
		EndIf
		ReDim $aTabNameNP[$aTmp[0]+1][2]
		Local $tmpUser[1][4]
		$d = 1 ; индекс исключающий сбойные строки в файле
		For $i = 1 to $aTmp[0]
			$tmp = StringRegExp($aTmp[$d], '(?s)^(.*?)<\|>(.*)$', 3)
			$aTabNameNP[$d][0]=$tmp[0]
			
			$tmp = StringSplit($tmp[1], '<|¤|>', 1)
			If @error And $tmp[1]='' Then ContinueLoop
			ReDim $tmpUser[$tmp[0]+1][4]
			For $j = 1 to $tmp[0]
				$tmp1 = StringSplit($tmp[$j], '<¤>', 1)
				If @error Or $tmp1[0]<>4 Then ContinueLoop 2
				For $s = 0 to 3
					$tmpUser[$j][$s]=$tmp1[$s+1]
				Next
			Next
			$aTabNameNP[$d][1]=$tmpUser
			$d += 1
		Next
		ReDim $aTabNameNP[$d][2]
	EndIf
EndFunc

Func _About()
	$GP=_ChildCoor($Gui, 270, 180)
	GUIRegisterMsg(0x05 , "")
	GUISetState(@SW_DISABLE, $Gui)
	$font="Arial"
	$Gui1 = GUICreate($LngAbout, $GP[2], $GP[3], $GP[0], $GP[1], BitOr($WS_CAPTION, $WS_SYSMENU, $WS_POPUP), -1, $Gui) ; WS_CAPTION+WS_SYSMENU
	If Not @compiled Then GUISetIcon($AutoItExe, 99)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit1")
	GUISetBkColor (0xE1E3E7)
	GUICtrlCreateLabel($LngTitle, 0, 0, 270, 63, 0x01+0x0200)
	GUICtrlSetFont (-1,14, 600, -1, $font)
	GUICtrlSetColor(-1,0x3a6a7e)
	GUICtrlSetBkColor (-1, 0xF1F1EF)
	GUICtrlCreateLabel ("-", 2,64,268,1,0x10)
	
	GUISetFont (9, 600, -1, $font)
	GUICtrlCreateLabel($LngVer&' 0.3   30.10.2011', 55, 100, 210, 17)
	GUICtrlCreateLabel($LngSite&':', 55, 115, 40, 17)
	$url=GUICtrlCreateLabel('http://azjio.ucoz.ru', 92, 115, 170, 17)
	GUICtrlSetOnEvent(-1, "_url")
	GUICtrlSetCursor(-1, 0)
	GUICtrlSetColor(-1, 0x0000ff)
	GUICtrlCreateLabel('WebMoney:', 55, 130, 85, 17)
	$WbMn=GUICtrlCreateLabel('R939163939152', 130, 130, 125, 17)
	GUICtrlSetOnEvent(-1, "_WbMn")
	GUICtrlSetColor(-1,0x3a6a7e)
	GUICtrlSetTip(-1, $LngCopy)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel('Copyright AZJIO © 2009-2011', 55, 145, 210, 17)
	GUISetState(@SW_SHOW, $Gui1)
EndFunc

Func _url()
	ShellExecute ('http://azjio.ucoz.ru')
EndFunc

Func _WbMn()
	ClipPut('R939163939152')
EndFunc

Func _Exit1()
	GUISetState(@SW_ENABLE, $Gui)
	GUIDelete($Gui1)
	GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")
	; GUIRegisterMsg(0x05 , "WM_SIZE")
EndFunc