#cs ----------------------------------------------------------------------------
	AutoIt Version: 3.3.8.0
#ce ----------------------------------------------------------------------------
#include <GUIListBox.au3>
#include "Misc.au3"
#include <EditConstants.au3>
#include <StaticConstants.au3 >
#include <WindowsConstants.au3>
#include 'GUIConstantsEx.au3'
#include <TabConstants.au3>
#include <GuiTreeView.au3>
#include <Array.au3>
#include <GuiListView.au3>
#include <Constants.au3>
#include <inet.au3>
;#include 'myFileListToArray_AllFiles.au3'
Opt("WinSearchChildren", 1)
Opt('MustDeclareVars', 1)
;##############################
Global Const $tvPARAM_is_COLOR = Random(65537, 100000, 1)
Global $SciTECmd, $Old_SciTECmd, $msg, $Title = "SciTE Helper", $Version = " v.1.2 (3.3.8.0)"
Global $ContextMenu, $CtrlMenuitem[3], $DllUser32 = DllOpen("user32.dll"), $tab, $tabitem[5], $iStyle, $imput_down
Global $dTimer = TimerInit(), $FilePatchAU3, $Old_FilePatch, $FileSize, $Old_FileSize, $FileTime, $Old_FileTime
Global $tree_user_func, $tree_global_const, $tree_Local_const, $tree_String, $tree_user_comments
Global $tree_user_var, $tree_user_var_all, $tree_user_var_unique, $tree_macro_pink, $tree_autoit_opt
Global $tree_func, $tree_func_Func_UDF, $tree_func_Func_BLACK, $tree_func_Func_AU3, $tree_func_Func_FREE
Global $tree_macro_gren, $tree_include, $tree_region, $FilePatch_Full_Text, $FilePatch_Full_Text_GreenTEXT
Global $tree_number, $tree_hexy, $tree_run, $tree_HK, $tree_net, $tree_RegKey, $tree_FileWritte
Global $SCITE_FUNC_keywords, $SCITE_FUNC_functions, $SCITE_FUNC_macros, $SCITE_FUNC_udfs
;Global $SCITE_FUNC_preprocessor, $SCITE_FUNC_special, $SCITE_FUNC_abbrev, $SCITE_FUNC_sendkeys
Global $SCITE_COLOR_White_space, $SCITE_COLOR_Comment_line, $SCITE_COLOR_Comment_block, $SCITE_COLOR_Number
Global $SCITE_COLOR_Function, $SCITE_COLOR_Macro, $SCITE_COLOR_String, $SCITE_COLOR_Operator, $SCITE_COLOR_Variable
Global $SCITE_COLOR_Sent_keys_in_string, $SCITE_COLOR_Pre_Processor, $SCITE_COLOR_Special, $SCITE_COLOR_Standard_UDF
;Global $SCITE_COLOR_Keyword, $SCITE_COLOR_Background, $SCITE_COLOR_Expad_abbreviations, Global $SCITE_COLOR_ComObjects
Global $COLOR_declared_func
;##############################
Global $TreeView_Item_Script, $TreeView_Item_Include
Global $test_duble_dec_functions, $test_duble_global_const, $test_duble_Local_const, $test_duble_String
Global $test_duble_Operatory, $test_duble_Func_UDF, $test_duble_Func_BLACK, $test_duble_Func_AU3
Global $test_duble_Free_functions, $test_duble_run, $test_duble_HK, $test_duble_net, $test_duble_RegKey, $test_duble_FileWritte
Global $test_duble_include, $test_duble_macro, $test_duble_autoit_opt, $test_duble_number, $test_duble_hex
Global $test_duble_variable, $test_duble_variable_multi, $test_duble_variable_unique, $test_duble_region, $test_duble_coments
Global $steep_Update_TreeView = 0, $Test_Include, $AutoitDir, $FilePatch_Full_Text_Include, $next, $ile3, $ile4, $ile_color
;##############################
Global $gui, $label, $bution, $listview, $Chex_Ignore1, $Chex_Licz2, $Input_1, $radio[2], $Input_2, $bution_2
Global $ContextMenuSearch, $ContextMenuSearch2, $CtrlMenuitemSearch[2], $progress, $Visible_OLD_TEXT = '', $Visible_ITEM = -1
Global $Chex_String3, $Chex_DelTab4, $group1, $imput_down_2, $i
Global $edit_2, $label_GT, $CheckboxLangGT, $comboLangGogle[3]
Global $GoogleTranslate = False, $TranslateText, $OldTranslateText, $TextForTrans, $GTlang1, $GTlang2, $GTlang3, $newTranslateText
Global $inifile = @ScriptDir & "\" & $Title & "[Config].ini"
Global $DirFileHelper = @ScriptDir & "\" & $Title & "[Helper].ini"
Global $DirFileTreeViewList = @ScriptDir & "\" & $Title & "[TreeViewList].ini"
Global $myAlvaysTop = IniRead($inifile, "funkcje au3", "alvays top", '1')
Global $myhexConsole = IniRead($inifile, "funkcje au3", "Console", '0')
Global $mySavePos = IniRead($inifile, "funkcje au3", "save pos", '0')
Global $pos_x = IniRead($inifile, "funkcje au3", "pos_x", @DesktopWidth - 285)
Global $pos_y = IniRead($inifile, "funkcje au3", "pos_y", '0')
Global $pos_w = IniRead($inifile, "funkcje au3", "pos_w", '280')
Global $pos_h = IniRead($inifile, "funkcje au3", "pos_h", '550')
Global $myInput = IniRead($inifile, "funkcje au3", "search", '$GUI_EVENT_CLOSE')
Global $myInput_2 = IniRead($inifile, "funkcje au3", "search_2", '')
Global $myInput_dw = IniRead($inifile, "funkcje au3", "imput_dw", '')
Global $myInput_dw_2 = IniRead($inifile, "funkcje au3", "imput_dw_2", '')
Global $myChex = IniRead($inifile, "funkcje au3", "Chex", '0')
Global $myChex_2 = IniRead($inifile, "funkcje au3", "Chex_2", '1')
Global $myChex_3 = IniRead($inifile, "funkcje au3", "Chex_3", '1')
Global $myChex_4 = IniRead($inifile, "funkcje au3", "Chex_4", '0')
Global $myRadio = IniRead($inifile, "funkcje au3", "radio", '0')
Global $myTab = IniRead($inifile, "funkcje au3", "tab", '0')
Global $myChexLang = IniRead($inifile, "funkcje au3", "ChexLang", '0')
Global $myLang1 = IniRead($inifile, "funkcje au3", "Language1", '')
Global $myLang2 = IniRead($inifile, "funkcje au3", "Language2", '')
Global $myLang3 = IniRead($inifile, "funkcje au3", "Language3", '')
Global $dw = 150 ; gui size
;################################
If $mySavePos = 1 Or $mySavePos = 257 Then
	If $pos_x > @DesktopWidth - 200 Then $pos_x = $pos_x - 200
	If $pos_x < 0 Then $pos_x = 0
	If $pos_y > @DesktopHeight - 200 Then $pos_y = $pos_y - 200
	If $pos_y < 0 Then $pos_y = 0
Else
	$pos_x = @DesktopWidth - 285
	$pos_y = 0
EndIf
;################################
If WinExists($Title & $Version) Then Exit
Global $gui = GUICreate($Title & $Version, $pos_w, $pos_h + $dw, $pos_x, $pos_y, $WS_OVERLAPPEDWINDOW + $WS_VISIBLE + $WS_CLIPSIBLINGS)
GUISetFont(8.5, 400, -1, "Arial")
;GUISetBkColor(0xF0F4F9)
Global $label = GUICtrlCreateLabel('', 5, 5, 270, 20)
GUICtrlSetFont(-1, 9, 600)

Global $edit = GUICtrlCreateEdit('', 5, 25, 270, 120, $ES_AUTOVSCROLL + $WS_VSCROLL)

$tab = GUICtrlCreateTab(5, 152, 270 + $dw, 20)
Global $hWndTab = GUICtrlGetHandle($tab)
;##############################
$tabitem[0] = GUICtrlCreateTabItem(" Helper ")
;##############################
Global $myGUICtrlList = GUICtrlCreateList('', 5, 175, 270, 350 + $dw, BitOR($WS_BORDER, $WS_VSCROLL, $LBS_NOTIFY, $LBS_DISABLENOSCROLL, $WS_HSCROLL))
Global $file = FileOpen($DirFileHelper); "[Helper].ini"
Opt("GUIDataSeparatorChar", @CR)
GUICtrlSetData($myGUICtrlList, StringReplace(StringRegExpReplace(FileRead($file), '[\r\n]+', @CR), '=', " = "))
Opt("GUIDataSeparatorChar", "|")
FileClose($file)

GUICtrlSendMsg($myGUICtrlList, $LB_SETHORIZONTALEXTENT, 1000, 0)
;##############################
$tabitem[1] = GUICtrlCreateTabItem(" Organizer ")
;##############################
$iStyle = BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS)
Global $TreeView = GUICtrlCreateTreeView(5, 175, 270, 350 - 20 + $dw, $iStyle, $WS_EX_CLIENTEDGE)
Global $hWndTreeview = GUICtrlGetHandle($TreeView)

$imput_down = GUICtrlCreateInput($myInput_dw, 5, 508 + $dw, 270, 17)

;##############################
$tabitem[2] = GUICtrlCreateTabItem("  Find  ")
;##############################
$group1 = GUICtrlCreateGroup("search", 5, 20, 270, 75 + 5)
$radio[0] = GUICtrlCreateRadio('funkcja', 10, 35, 70, 20)
$radio[1] = GUICtrlCreateRadio('text', 10, 57, 70, 20)
GUICtrlSetState($radio[$myRadio], $GUI_CHECKED)

$Chex_Ignore1 = GUICtrlCreateCheckbox('Ignore UDF Func', 80, 35, 170, 20)
GUICtrlSetState(-1, $myChex)

$Input_1 = GUICtrlCreateInput($myInput, 80, 55, 190, 20)

$Chex_Licz2 = GUICtrlCreateCheckbox('+ licz linie', 30, 80, 70, 15)
GUICtrlSetState(-1, $myChex_2)

$Chex_String3 = GUICtrlCreateCheckbox('+ full string', 110, 80, 70, 15)
GUICtrlSetState(-1, $myChex_3)

$Chex_DelTab4 = GUICtrlCreateCheckbox('+ del @tab', 180, 80, 70, 15)
GUICtrlSetState(-1, $myChex_4)

$bution = GUICtrlCreateButton("Search", 5, 104, 270, 20)

$Input_2 = GUICtrlCreateInput($myInput_2, 5, 125, 155, 20)

$bution_2 = GUICtrlCreateButton("search in list", 165, 125, 110, 20)

$listview = GUICtrlCreateListView("No|Funkcja|Files|Lokalizacja||", 5, 175, 270, 350 - 20 + $dw, -1, $LVS_EDITLABELS);,$LVS_LIST)
Global $hWndListView = GUICtrlGetHandle($listview)
GUICtrlSendMsg($listview, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_GRIDLINES, $LVS_EX_GRIDLINES)
GUICtrlSendMsg($listview, $LVM_SETEXTENDEDLISTVIEWSTYLE, $LVS_EX_FULLROWSELECT, $LVS_EX_FULLROWSELECT)
GUICtrlSendMsg($listview, 0x101E, 0, 40)
GUICtrlSendMsg($listview, 0x101E, 1, 310)
GUICtrlSendMsg($listview, 0x101E, 2, 150)
GUICtrlSendMsg($listview, 0x101E, 3, 310)
GUICtrlSendMsg($listview, 0x101E, 4, 0)

GUICtrlSetResizing($listview, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKRIGHT)

$imput_down_2 = GUICtrlCreateInput($myInput_dw_2, 5, 508 + $dw, 270, 17)

$ContextMenuSearch = GUICtrlCreateContextMenu($listview)
GUICtrlCreateMenuItem("", $ContextMenuSearch)
$ContextMenuSearch2 = GUICtrlCreateMenu("    Open    ", $ContextMenuSearch)
GUICtrlSetState(-1, $GUI_DEFBUTTON)
$CtrlMenuitemSearch[0] = GUICtrlCreateMenuItem("", $ContextMenuSearch2)
$CtrlMenuitemSearch[0] = GUICtrlCreateMenuItem("    Open File    ", $ContextMenuSearch2)
$CtrlMenuitemSearch[1] = GUICtrlCreateMenuItem("    Open Folder    ", $ContextMenuSearch2)

For $i = $group1 To $bution_2
	GUICtrlSetResizing($i, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKSIZE)
Next
GUICtrlSetResizing($imput_down_2, $GUI_DOCKLEFT + $GUI_DOCKSTATEBAR + $GUI_DOCKRIGHT)
check_imput_disable_enable()
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
GUIRegisterMsg($WM_COMMAND, "WM_COMMAND")
;##############################
$tabitem[3] = GUICtrlCreateTabItem(" Trans ")
;##############################

$edit_2 = GUICtrlCreateEdit('', 5, 175, 270, 220 + $dw, $ES_AUTOVSCROLL + $WS_VSCROLL)
;Global $edit_2 = GUICtrlCreateEdit('', 5, 175, 270, 250 + $dw)

$label_GT = GUICtrlCreateLabel('Google Translator.', 5, 405 + $dw, 270, 20)
GUICtrlSetFont(-1, 9, 600)

GUICtrlSetResizing($edit_2, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKRIGHT)
GUICtrlSetResizing($label_GT, $GUI_DOCKLEFT + $GUI_DOCKSTATEBAR + $GUI_DOCKRIGHT)

Global $language = ''
;$language &= "auto Detect Language|"
$language &= "af Afrikaans|"
$language &= "sq Albanian|"
$language &= "ar Arabic|"
$language &= "hy Armenian|"
$language &= "az Azeri|"
$language &= "eu Basque|"
$language &= "bn Bengali|"
$language &= "be Belarusian|"
$language &= "bg Bulgarian|"
$language &= "zh CN Chinese|"
$language &= "hr Croatian|"
$language &= "cs Czech|"
$language &= "da Danish|"
$language &= "en English|"
$language &= "et Estonian|"
$language &= "tl Filipino|"
$language &= "fi Finnish|"
$language &= "fr French|"
$language &= "gl Galician|"
$language &= "de German|"
$language &= "el Greek|"
$language &= "ka Georgian|"
$language &= "gu Gujarati|"
$language &= "iw Hebrew|"
$language &= "hi Hindi|"
$language &= "hu Hungarian|"
$language &= "id Indonesian|"
$language &= "it Italian|"
$language &= "ga Irish|"
$language &= "is Icelandic|"
$language &= "ja Japanese|"
$language &= "yi Yiddish|"
$language &= "kn Kannada|"
$language &= "ca Catalan|"
$language &= "ko Korean|"
$language &= "ht Haitian Creole|"
$language &= "lt Lithuanian|"
$language &= "la Latin|"
$language &= "lv Latvian|"
$language &= "mk Macedonian|"
$language &= "ms Malay|"
$language &= "mt Maltese|"
$language &= "nl Netherlands|"
$language &= "no Norwegian|"
$language &= "fa Persian|"
$language &= "pl Polish|"
$language &= "pt Portuguese|"
$language &= "ru Russian|"
$language &= "ro Romanian|"
$language &= "sr Serbian|"
$language &= "sk Slovak|"
$language &= "sl Slovenian|"
$language &= "sw Swahili|"
$language &= "sv Swedish|"
$language &= "es Spanish|"
$language &= "th Thai|"
$language &= "ta Tamil|"
$language &= "te Telugu|"
$language &= "tr Turkish|"
$language &= "uk Ukrainian|"
$language &= "ur Urdu|"
$language &= "cy Welsh|"
$language &= "vi Vietnamese"

$CheckboxLangGT = GUICtrlCreateCheckbox('use "translate.google.com"', 5, 425 + $dw, 180, 18)
GUICtrlSetState(-1, $myChexLang)
GUICtrlSetResizing($CheckboxLangGT, $GUI_DOCKLEFT + $GUI_DOCKSTATEBAR + $GUI_DOCKRIGHT)

$comboLangGogle[0] = GUICtrlCreateCombo($myLang1, 5, 450 + $dw, 120, 18)
GUICtrlSetData(-1, $language, $myLang1)
GUICtrlSetResizing($comboLangGogle[0], $GUI_DOCKLEFT + $GUI_DOCKSTATEBAR + $GUI_DOCKRIGHT)

$comboLangGogle[1] = GUICtrlCreateCombo($myLang2, 5, 475 + $dw, 120, 18)
GUICtrlSetData(-1, $language, $myLang2)
GUICtrlSetResizing($comboLangGogle[1], $GUI_DOCKLEFT + $GUI_DOCKSTATEBAR + $GUI_DOCKRIGHT)

$comboLangGogle[2] = GUICtrlCreateCombo($myLang3, 5, 500 + $dw, 120, 18)
GUICtrlSetData(-1, $language, $myLang3)
GUICtrlSetResizing($comboLangGogle[2], $GUI_DOCKLEFT + $GUI_DOCKSTATEBAR + $GUI_DOCKRIGHT)

GUICtrlCreateLabel('translate from...', 135, 453 + $dw, 120, 18)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKSTATEBAR + $GUI_DOCKRIGHT)

GUICtrlCreateLabel('translate to...', 135, 478 + $dw, 120, 18)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKSTATEBAR + $GUI_DOCKRIGHT)

GUICtrlCreateLabel('base language...', 135, 503 + $dw, 120, 18)
GUICtrlSetResizing(-1, $GUI_DOCKLEFT + $GUI_DOCKSTATEBAR + $GUI_DOCKRIGHT)

check_google_disable_enable()

;##############################
$tabitem[4] = GUICtrlCreateTabItem(" Settings ")
;##############################
$iStyle = BitOR($TVS_CHECKBOXES, $TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS)
Global $TreeView_setings = GUICtrlCreateTreeView(5, 175, 270, 350 + $dw, $iStyle, $WS_EX_CLIENTEDGE)
Global $TreeView_setings_2 = GUICtrlCreateTreeViewItem('USTAWINIEA GLOBALNE', $TreeView_setings)
Global $hexAlvaysTop = GUICtrlCreateTreeViewItem('Always On Top', $TreeView_setings_2)
GUICtrlSetState($hexAlvaysTop, $myAlvaysTop)
Global $SavePos = GUICtrlCreateTreeViewItem('Save Position', $TreeView_setings_2)
GUICtrlSetState($SavePos, $mySavePos)
Global $TreeView_setings_3 = GUICtrlCreateTreeViewItem('ORGANIZER', $TreeView_setings)
;#############################
Global $TVtext = StringSplit('Stringi,Variable (all var),Variable (unique),Macro,AutoItSetOption,' & _
		'Include,Comments,Region,Number,Hexy,HotKey,Run / Process Close/ Dll Open,Net,RegKey,File Write / Dell / Move', ',', 3)
Global $TVhex[17]
For $i = 0 To 14
	$TVhex[$i] = GUICtrlCreateTreeViewItem('search: ' & $TVtext[$i], $TreeView_setings_3)
	GUICtrlSetState($TVhex[$i], IniRead($inifile, "funkcje au3", "TVhex[" & $i & "]", '1'))
Next
$TVhex[15] = GUICtrlCreateTreeViewItem('search: #sc / #ce full text comments', $TVhex[6])
GUICtrlSetState($TVhex[15], IniRead($inifile, "funkcje au3", "TVhex[15]", '1'))
$TVhex[16] = GUICtrlCreateTreeViewItem('search: ;~  full text comments', $TVhex[6])
GUICtrlSetState($TVhex[16], IniRead($inifile, "funkcje au3", "TVhex[16]", '1'))

;#############################
Global $TreeView_setings_4 = GUICtrlCreateTreeViewItem('FIND', $TreeView_setings)
Global $hexConsole = GUICtrlCreateTreeViewItem('use ConsoleWrite', $TreeView_setings_4)
GUICtrlSetState($hexConsole, $myhexConsole)

GUICtrlSetState($TreeView_setings_2, BitOR($GUI_EXPAND, $GUI_DEFBUTTON))
GUICtrlSetState($TreeView_setings_3, BitOR($GUI_EXPAND, $GUI_DEFBUTTON))
;GUICtrlSetState($TVhex[6], $GUI_EXPAND);, $GUI_DEFBUTTON))
GUICtrlSetState($TreeView_setings_4, BitOR($GUI_EXPAND, $GUI_DEFBUTTON))
;#############################
GUICtrlCreateTabItem("")
;#############################
$progress = GUICtrlCreateProgress(5, 544 + $dw, 270, 7)
GUICtrlSetState($progress, $GUI_HIDE)
Global $Label_2 = GUICtrlCreateLabel($Title, 5, 528 + $dw, 270, 17, $SS_SUNKEN + $SS_RIGHT)
GUICtrlSetFont(-1, 7, 400)
GUICtrlSetResizing($label, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKSIZE + $GUI_DOCKRIGHT)
GUICtrlSetResizing($edit, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKSIZE + $GUI_DOCKRIGHT)
GUICtrlSetResizing($tab, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKSIZE + $GUI_DOCKRIGHT)
GUICtrlSetResizing($myGUICtrlList, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKRIGHT)
GUICtrlSetResizing($TreeView, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKRIGHT)
GUICtrlSetResizing($imput_down, $GUI_DOCKLEFT + $GUI_DOCKSTATEBAR + $GUI_DOCKRIGHT)
GUICtrlSetResizing($TreeView_setings, $GUI_DOCKLEFT + $GUI_DOCKTOP + $GUI_DOCKBOTTOM + $GUI_DOCKRIGHT)
GUICtrlSetResizing($Label_2, $GUI_DOCKLEFT + $GUI_DOCKHCENTER + $GUI_DOCKHEIGHT + $GUI_DOCKRIGHT)
GUICtrlSetResizing($progress, $GUI_DOCKLEFT + $GUI_DOCKSTATEBAR + $GUI_DOCKRIGHT)
$ContextMenu = GUICtrlCreateContextMenu($myGUICtrlList)
$CtrlMenuitem[0] = GUICtrlCreateMenuItem("open help", $ContextMenu)
$CtrlMenuitem[1] = GUICtrlCreateMenuItem("open include (and find string)", $ContextMenu)
$CtrlMenuitem[2] = GUICtrlCreateMenuItem("paste to SciTE (copy)", $ContextMenu)

GUICtrlSetState($tabitem[$myTab], $GUI_SHOW)
If $myTab = 2 Then GUICtrlSetState($edit, $GUI_HIDE)
GUISetState()
If IsChecked($hexAlvaysTop) Then
	WinSetOnTop($gui, "", 1)
EndIf
GUIRegisterMsg($WM_COPYDATA, "WM_COPYDATA")
OnAutoItExitRegister("OnAutoItExit")
While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $GUI_EVENT_CLOSE
			Exit
		Case $msg = $bution
			Search_Func()
		Case $msg = $bution_2
			GUICtrlSetState($bution_2, $GUI_DISABLE)
			FindText_LV_Find()
			GUICtrlSetState($bution_2, $GUI_ENABLE)
		Case $msg = $radio[0]
			check_imput_disable_enable()
		Case $msg = $radio[1]
			check_imput_disable_enable()
		Case $msg = $CtrlMenuitemSearch[0]
			open_file()
		Case $msg = $CtrlMenuitemSearch[1]
			open_folder()
		Case $msg = $myGUICtrlList
			Click_GUICtrlList_Update_Text()
		Case _IsPressed('01', $DllUser32)
			If GUICtrlRead($tab) <> 2 Then
				Click_Scite_Update_Text()
				Sleep(200)
				If (GUICtrlRead($CheckboxLangGT) = $GUI_CHECKED) Then
					$GoogleTranslate = True
				EndIf
			EndIf
		Case $GoogleTranslate
			If GUICtrlRead($tab) = 3 Then
				If Not _IsPressed('01', $DllUser32) Then
					$GoogleTranslate = False
					$TranslateText = GUICtrlRead($edit)
					If ($TranslateText <> $OldTranslateText) And ($TranslateText <> "") Then
						$OldTranslateText = $TranslateText
						GUICtrlSetData($edit_2, "...%")
						$TextForTrans = GUICtrlRead($edit)
						$GTlang1 = GUICtrlRead($comboLangGogle[0])
						$GTlang2 = GUICtrlRead($comboLangGogle[1])
						$GTlang3 = GUICtrlRead($comboLangGogle[2])
						If $GTlang1 And $GTlang2 And $GTlang3 Then
							$newTranslateText = myGoogleTranslate($TextForTrans, $GTlang1, $GTlang2, $GTlang3)
							GUICtrlSetData($edit_2, $newTranslateText)
						Else
							GUICtrlSetData($edit_2, "")
						EndIf
					EndIf
				EndIf
			Else
				$GoogleTranslate = False
			EndIf
		Case $msg = $CtrlMenuitem[0]
			Open_Help()
		Case $msg = $CtrlMenuitem[1]
			Open_Include()
		Case $msg = $CtrlMenuitem[2]
			Copy_To_SciTE()
		Case $msg = $hexAlvaysTop
			If IsChecked($hexAlvaysTop) Then
				WinSetOnTop($gui, "", 1)
			Else
				WinSetOnTop($gui, "", 0)
			EndIf
	EndSelect

	If TimerDiff($dTimer) >= 2000 Then

		$FilePatchAU3 = scite_get_open_FilePathAU3()

		If $FilePatchAU3 <> '' Then
			$FileSize = FileGetSize($FilePatchAU3)
			$FileTime = FileGetTime($FilePatchAU3, 0, 1)
			If $FileSize Then
				If ($FilePatchAU3 <> $Old_FilePatch) Or ($FileSize <> $Old_FileSize) Or ($FileTime <> $Old_FileTime) Then
					$Old_FilePatch = $FilePatchAU3
					$Old_FileSize = $FileSize
					$Old_FileTime = $FileTime
					$FilePatch_Full_Text = FileRead($FilePatchAU3)
					$FilePatch_Full_Text = Test_Text_and_Convert_CRLF($FilePatch_Full_Text)

					If $FilePatch_Full_Text Then
						$steep_Update_TreeView = 1
					EndIf
				EndIf
			EndIf
		EndIf
		$dTimer = TimerInit()
	Else
		If $steep_Update_TreeView Then
			uTV_OPEN_and_UPDATE()
		EndIf
	EndIf
	Sleep(20)
WEnd

Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg, $iwParam, $ilParam
	Switch $iwParam
		Case $Chex_Licz2, $Chex_String3
			check_imput_disable_enable()
		Case $CheckboxLangGT
			check_google_disable_enable()
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COMMAND

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
	#forceref $hWnd, $iMsg, $iwParam
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $tInfo
	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hWndTab ;  Tab
			Switch $iCode
				Case $TCN_SELCHANGE, $NM_CLICK
					If GUICtrlRead($tab) = 2 Then
						GUICtrlSetState($edit, $GUI_HIDE)
					Else
						GUICtrlSetState($edit, $GUI_SHOW)
					EndIf
			EndSwitch
		Case $hWndListView ;  ListView
			Switch $iCode
				Case $LVN_COLUMNCLICK ; A column was clicked
					$tInfo = DllStructCreate($tagNMLISTVIEW, $ilParam)
					Local $B_DESCENDING[_GUICtrlListView_GetColumnCount($listview)]
					_GUICtrlListView_SimpleSort($hWndListView, $B_DESCENDING, DllStructGetData($tInfo, "SubItem"))
				Case $NM_CLICK
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					GUICtrlSetData($imput_down_2, _GUICtrlListView_GetItemText($listview, DllStructGetData($tInfo, "Index"), DllStructGetData($tInfo, "SubItem")))
					IniWrite($inifile, "funkcje au3", "imput_dw_2", GUICtrlRead($imput_down_2))
			EndSwitch
		Case $hWndTreeview ;  TreeView
			Switch $iCode
				Case $NM_CUSTOMDRAW
					Local $tCustDraw = DllStructCreate($tagNMTVCUSTOMDRAW, $ilParam)
					Local $iDrawStage, $hDC;, $iItem, $iSubitem, $tRect
					$iDrawStage = DllStructGetData($tCustDraw, 'DrawStage')
					Switch $iDrawStage
						Case $CDDS_ITEMPREPAINT
							#region (1.) tree view color item
							Local $ItemParam = DllStructGetData($tCustDraw, 'ItemParam')
							If $ItemParam >= $tvPARAM_is_COLOR Then
								updateColorTV($tCustDraw, $ItemParam)
							EndIf
							#endregion (1.) tree view color item
							;Return $CDRF_NEWFONT
					EndSwitch
				Case $TVN_SELCHANGEDW, $NM_CLICK; select tree item
					;Local $info = _GUICtrlTreeView_GetText($TreeView, _GUICtrlTreeView_GetSelection($TreeView))
					Local $info = GUICtrlRead($TreeView, 1)
					GUICtrlSetData($imput_down, $info)
					If $info <> '' Then Update_Text($info, False)
				Case $NM_DBLCLK
					;Local $info = _GUICtrlTreeView_GetText($TreeView, _GUICtrlTreeView_GetSelection($TreeView))
					Local $info = GUICtrlRead($TreeView, 1)
					GUICtrlSetData($imput_down, $info)
					If $info <> '' Then
						If StringInStr($info, '#comments-start line = ') Or StringInStr($info, '#comments-end   line = ') Then ; find comments
							scite_send_command("goto:" & StringTrimLeft($info, 23))
						ElseIf GUICtrlRead($TreeView) - $tvPARAM_is_COLOR = $COLOR_declared_func Then ; find func
							Local $Find_DecFunc
							$Find_DecFunc = Test_Text_and_Convert_CRLF(FileRead($FilePatchAU3))
							$Find_DecFunc = StringRegExpReplace($Find_DecFunc, '((?ims)^\s*Func\s+\Q' & $info & '\E\s*[(].*)', @CRLF)
							$Find_DecFunc = StringRegExp($Find_DecFunc, @CRLF, 3)
							If IsArray($Find_DecFunc) Then
								Local $GoToLine = UBound($Find_DecFunc)
								scite_send_command("goto:" & $GoToLine + 100)
								scite_send_command("goto:" & $GoToLine)
								scite_send_command("find:" & $info); find declared func
							EndIf
						Else ; find string
							$info = StringReplace($info, '\', '\\')
							scite_send_command("find:" & $info)
						EndIf
					EndIf
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY

#region (2.) tree view color item
#cs ########################
	$hwnd_Tree = tree id
	$id_Item = item id
	$New_Color = color
#ce ########################

Func addColor4TV($hwnd_Tree, $id_Item, $New_Color) ; tree id, item id, color
	$New_Color += $tvPARAM_is_COLOR
	;Local $tItem = DllStructCreate($tagTVITEMEX)
	;DllStructSetData($tItem, "Mask", BitOR($TVIF_HANDLE, $TVIF_PARAM))
	;DllStructSetData($tItem, "hItem", GUICtrlGetHandle($id_Item))
	;DllStructSetData($tItem, "Param", $New_Color)
	;GUICtrlSendMsg($hwnd_Tree, $TVM_SETITEMW, 0, DllStructGetPtr($tItem))
	_GUICtrlTreeView_SetItemParam($hwnd_Tree, $id_Item, $New_Color)
EndFunc   ;==>addColor4TV

Func updateColorTV($tCustDraw, $ItemParam); item id, color
	$ItemParam -= $tvPARAM_is_COLOR
	DllStructSetData($tCustDraw, 'ClrText', StringRegExpReplace(Hex($ItemParam, 6), '(.{2})(.{2})(.{2})', '0x\3\2\1'))
EndFunc   ;==>updateColorTV

#endregion (2.) tree view color item

Func scite_send_command($sCmd)
	If Not ProcessExists("SciTE.exe") Then Return 0
	Local $My_Dec_Hwnd = Dec(StringTrimLeft($gui, 2))
	$sCmd = ':' & $My_Dec_Hwnd & ':' & $sCmd ;
	Local $CmdStruct = DllStructCreate("Char[" & StringLen($sCmd) + 1 & ']')
	DllStructSetData($CmdStruct, 1, $sCmd)
	Local $COPYDATA = DllStructCreate("Ptr; DWord; Ptr")
	DllStructSetData($COPYDATA, 1, 1)
	DllStructSetData($COPYDATA, 2, StringLen($sCmd) + 1)
	DllStructSetData($COPYDATA, 3, DllStructGetPtr($CmdStruct))
	Local $Scite_hwnd = WinGetHandle("DirectorExtension") ; Get SciTE Director Handle
	_SendMessage($Scite_hwnd, $WM_COPYDATA, $gui, DllStructGetPtr($COPYDATA), 0, "hwnd", "ptr")
EndFunc   ;==>scite_send_command

Func WM_COPYDATA($hWnd, $msg, $wParam, $lParam)
	#forceref $hWnd, $msg, $wParam, $lParam
	Local $COPYDATA = DllStructCreate("Ptr; DWord; Ptr", $lParam)
	Local $SciTECmdLen = DllStructGetData($COPYDATA, 2)
	Local $CmdStruct = DllStructCreate("Char[" & $SciTECmdLen + 1 & "]", DllStructGetData($COPYDATA, 3))
	$SciTECmd = StringLeft(DllStructGetData($CmdStruct, 1), $SciTECmdLen)
	If StringInStr($SciTECmd, "macro:stringinfo:") Then
		$SciTECmd = StringTrimLeft($SciTECmd, StringInStr($SciTECmd, "macro:stringinfo:") + 16)
	EndIf
	;ConsoleWrite($SciTECmd & @CRLF)
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_COPYDATA

Func OnAutoItExit()
	save()
	DllClose($DllUser32)
EndFunc   ;==>OnAutoItExit

#region Google Translate

Func myGoogleTranslate($sText, $sTo = "en", $sFrom = "pl", $sCode = "en")
	$sTo = StringRegExpReplace($sTo, '(\w+)|(.*)', '\1')
	$sFrom = StringRegExpReplace($sFrom, '(\w+)|(.*)', '\1')
	$sCode = StringRegExpReplace($sCode, '(\w+)|(.*)', '\1')

	If (Not $sText) Or (Not $sTo) Or (Not $sFrom) Or (Not $sCode) Then Return SetError(1, 0, 0)

	If StringRegExpReplace($sText, '([a-zA-Z0-9]+)', '') Then
		$sText = StringToBinary($sText)
		$sText = StringTrimLeft($sText, 2)
		$sText = StringRegExpReplace($sText, '(.{2})', '%\1')
	EndIf

	Local $GoogleURL = 'http://translate.google.com/translate_a/t?client=t&text=' & $sText & '&hl=' & $sCode & '&sl=' & $sTo & '&tl=' & $sFrom & '&multires=1&ssel=0&tsel=0&sc=1'
	;ConsoleWrite($GoogleURL & @CRLF)
	Local $sSource = _INetGetSource($GoogleURL)
	;If @error Then
	;  Local $TempFileDir = @ScriptDir & "\t.js"
	;  Local $hDownload = InetGet($GoogleURL, $TempFileDir, 1, 1)
	;  Local $begin = TimerInit()
	;  Do
	;  Until (InetGetInfo($hDownload, 2)) Or (TimerDiff($begin) >= 4000)
	;  InetClose($hDownload)
	;  $sSource = FileRead($TempFileDir)
	;  FileDelete($TempFileDir)
	;EndIf
	;ConsoleWrite($sSource & @CRLF)
	If (Not $sSource) Then Return SetError(2, 0, 0)

	Local $s_saveSource = $sSource
	Local $sPattern = '],,"' & $sTo & '",,['

	$sSource = StringLeft($sSource, StringInStr($sSource, $sPattern))
	If $sSource Then ; jesli to cale zdanie
		$sSource = StringRegExpReplace($sSource, '[[]["](.*?)["][,]["]|(.*?)', '\1')
		$sSource = myGoogleTranslate_Hex_to_ChrW($sSource)
	Else ; jesli to pojedynczy wyraz
		$sPattern = '],"' & $sTo & '",,['
		$sSource = StringLeft($s_saveSource, StringInStr($s_saveSource, $sPattern))
		$sSource = StringRegExpReplace($sSource, '[,][[][[]?(.*?)[[](.*?)[]]|(.*?)', '\1\2')
		$sSource = myGoogleTranslate_Hex_to_ChrW($sSource)

		$sSource = StringReplace($sSource, '","', @CRLF & @TAB)
		$sSource = StringReplace($sSource, '"', @CRLF)
	EndIf
	$sSource = StringReplace($sSource, '\"', '"')
	$sSource = StringFormat($sSource)

	If (Not $sSource) Then Return SetError(3, 0, 0)
	Return $sSource
EndFunc   ;==>myGoogleTranslate


Func myGoogleTranslate_Hex_to_ChrW($sText)
	Local $searchHex, $aText
	Do
		$searchHex = StringInStr($sText, '\u')
		If $searchHex Then
			$aText = StringRegExp($sText, '(.{' & ($searchHex - 1) & '})(.{2})(.{4})(.*)', 3)
			;_ArrayDisplay($aText)
			If IsArray($aText) Then
				$sText = $aText[0] & ChrW(Dec($aText[2])) & $aText[3]
			EndIf
		EndIf
	Until $searchHex <= 0
	Return $sText
EndFunc   ;==>myGoogleTranslate_Hex_to_ChrW

#endregion Google Translate

#region update treewiew

Func Test_Text_and_Convert_CRLF($mString)
	If Not StringInStr($mString, @CRLF) Then $mString = StringReplace($mString, @LF, @CRLF)
	If Not StringInStr($mString, @CRLF) Then $mString = StringReplace($mString, @CR, @CRLF)
	Return $mString
EndFunc   ;==>Test_Text_and_Convert_CRLF

Func uTV_OPEN_and_UPDATE()
	Switch $steep_Update_TreeView
		Case 1
			uTV_START()
		Case 2
			If IsChecked($TVhex[6]) Or IsChecked($TVhex[7]) Then
				uTV_Text_Comments_and_Region($FilePatch_Full_Text)
			EndIf
		Case 3
			If IsChecked($TVhex[6]) And IsChecked($TVhex[16]) Then
;~ 				uTV_Text_Green_Text($FilePatch_Full_Text)
				$FilePatch_Full_Text_GreenTEXT = $FilePatch_Full_Text
			EndIf
		Case 4
			$FilePatch_Full_Text = uTV_Delete_Green_Text($FilePatch_Full_Text)
		Case 5
			uTV_Text_Deklarowane_Funkcje($FilePatch_Full_Text)
		Case 6
			uTV_Text_Global_Const($FilePatch_Full_Text)
		Case 7
			uTV_Text_Local_Const($FilePatch_Full_Text)
		Case 8
			If IsChecked($TVhex[5]) Then
				uTV_Text_Include($FilePatch_Full_Text, True)
			EndIf
		Case 9
			If IsChecked($TVhex[3]) Then
				uTV_Text_Macro($FilePatch_Full_Text)
			EndIf
		Case 10
			If IsChecked($TVhex[4]) Then
				uTV_Text_Opt($FilePatch_Full_Text)
			EndIf
		Case 11
			If IsChecked($TVhex[10]) Then
				uTV_Text_HotKeySet($FilePatch_Full_Text)
			EndIf
		Case 12
			If IsChecked($TVhex[11]) Then
				uTV_Text_Run($FilePatch_Full_Text)
			EndIf
		Case 13
			If IsChecked($TVhex[12]) Then
				uTV_Text_Net($FilePatch_Full_Text)
			EndIf
		Case 14
			If IsChecked($TVhex[13]) Then
				uTV_Text_RegKey($FilePatch_Full_Text)
			EndIf
		Case 15
			If IsChecked($TVhex[14]) Then
				uTV_Text_FileWrite($FilePatch_Full_Text)
			EndIf
		Case 16
			$FilePatch_Full_Text = uTV_Text_Var_Func_Hex_etc($FilePatch_Full_Text)
			If $FilePatch_Full_Text <> '' Then
				$steep_Update_TreeView -= 1
			EndIf
		Case 17
			uTV_Text_Free_Funkc()
		Case 18
			If IsChecked($TVhex[1]) And IsChecked($TVhex[2]) Then
				uTV_Text_Free_Var()
			EndIf
		Case 19
			$next = 0
			$ile_color = UBound(StringSplit($test_duble_include, @CRLF, 3)) - 4
			$ile3 = 0
			$ile4 = 0
		Case 20
			Local $idViewItem
			Local $InclAdress
			$Test_Include = StringSplit($test_duble_include, @CRLF, 3)
			$Test_Include = ArrayDelete_FindTxT_AndDeleteMulti($Test_Include, '')

			If IsArray($Test_Include) And UBound($Test_Include) > $next Then
				;Switch $next_test
				;Case 1
				$idViewItem = GUICtrlCreateTreeViewItem('#include<' & $Test_Include[$next] & ">(0)(0)", $TreeView_Item_Include)
				If $ile_color >= 0 Then addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Pre_Processor)
				$ile_color -= 1
				GUICtrlSetState(-1, $GUI_DEFBUTTON)
				$InclAdress = uTV_Open_Next_File_Include($Test_Include[$next])
				If Not $InclAdress Then addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Comment_line)
				$FilePatch_Full_Text_Include = uTV_Delete_Green_Text($FilePatch_Full_Text_Include)
				uTV_Text_Include($FilePatch_Full_Text_Include, False)
				;case 2
				Local $tree_Next_File_2 = GUICtrlCreateTreeViewItem('Global Const  (0)', $idViewItem)
				GUICtrlSetState(-1, $GUI_DEFBUTTON)
				Local $ile1 = uTV_Text_Global_Const_2($FilePatch_Full_Text_Include, $tree_Next_File_2)
				;case 3
				Local $tree_Next_File_3 = GUICtrlCreateTreeViewItem('Funkcje  (0)', $idViewItem)
				GUICtrlSetState(-1, $GUI_DEFBUTTON)
				Local $ile2 = uTV_Text_Deklarowane_Funkcje_2($FilePatch_Full_Text_Include, $tree_Next_File_3)

				GUICtrlSetData($idViewItem, StringFormat('#include<' & $Test_Include[$next] & ">(%s)(%s)", $ile1, $ile2))

				$ile3 += $ile1
				$ile4 += $ile2
				GUICtrlSetData($TreeView_Item_Include, StringFormat("@ INCLUDE  [%s][%s]", $ile3, $ile4))

				$next += 1
				$steep_Update_TreeView -= 1
				;endswitch
			EndIf
		Case 21
			$Test_Include = 0
			$FilePatch_Full_Text_Include = 0
		Case 22
			If IsChecked($TVhex[6]) And IsChecked($TVhex[16]) Then
				$FilePatch_Full_Text_GreenTEXT = uTV_Text_Green_Text($FilePatch_Full_Text_GreenTEXT)
				If $FilePatch_Full_Text_GreenTEXT <> '' Then
					$steep_Update_TreeView -= 1
				EndIf
			EndIf
		Case 23
			uTV_Create_File_TXT()
		Case 24
			uTV_END()
		Case Else
			$steep_Update_TreeView = 0
			Return
	EndSwitch
	$steep_Update_TreeView += 1
EndFunc   ;==>uTV_OPEN_and_UPDATE


Func IsChecked($hex)
	If BitAND(GUICtrlRead($hex), $GUI_CHECKED) = $GUI_CHECKED Then Return True
	Return False
EndFunc   ;==>IsChecked


Func uTV_Open_Next_File_Include($Open_Include)
	$FilePatch_Full_Text_Include = ''

	Local $mFileDir = StringRegExpReplace($FilePatchAU3, '(.*[\\])(.*)', '\1')

	If FileExists($mFileDir & $Open_Include) Then
		$FilePatch_Full_Text_Include = FileRead($mFileDir & $Open_Include)
		$FilePatch_Full_Text_Include = Test_Text_and_Convert_CRLF($FilePatch_Full_Text_Include)
		Return 0
	Else
		If $AutoitDir = '' Then $AutoitDir = scite_get_AutoitDir()

		$FilePatch_Full_Text_Include = FileRead($AutoitDir & '\Include\' & $Open_Include)
		$FilePatch_Full_Text_Include = Test_Text_and_Convert_CRLF($FilePatch_Full_Text_Include)
		Return 1
	EndIf
EndFunc   ;==>uTV_Open_Next_File_Include

Func uTV_START()

	uTV_Reset_Var_Test_Duble()

	Local $iDel
	For $iDel = $TreeView_Item_Script To _GUICtrlTreeView_GetCount($TreeView)
		GUICtrlDelete($iDel)
	Next
	_GUICtrlTreeView_DeleteAll($TreeView)

	If $SCITE_COLOR_White_space = '' Then Scite_Color_Text('White_space')
	If $SCITE_COLOR_Comment_line = '' Then Scite_Color_Text('Comment_line')
	If $SCITE_COLOR_Comment_block = '' Then Scite_Color_Text('Comment_block')
	If $SCITE_COLOR_Number = '' Then Scite_Color_Text('Number')
	If $SCITE_COLOR_Function = '' Then Scite_Color_Text('Function')
	;If $SCITE_COLOR_Keyword = '' then  Scite_Color_Text('Keyword') ; for, to , next ect
	If $SCITE_COLOR_Macro = '' Then Scite_Color_Text('Macro')
	If $SCITE_COLOR_String = '' Then Scite_Color_Text('String')
	If $SCITE_COLOR_Operator = '' Then Scite_Color_Text('Operator')
	If $SCITE_COLOR_Variable = '' Then Scite_Color_Text('Variable')
	If $SCITE_COLOR_Sent_keys_in_string = '' Then Scite_Color_Text('Sent_keys_in_string') ; pomarancz w klamrach {}
	If $SCITE_COLOR_Pre_Processor = '' Then Scite_Color_Text('Pre_Processor') ; rozowy kolor include
	If $SCITE_COLOR_Special = '' Then Scite_Color_Text('Special'); rozowy #endregion #forceref #region
	;If $SCITE_COLOR_Expad_abbreviations = '' Then Scite_Color_Text('Expad_abbreviations')
	;If $SCITE_COLOR_ComObjects = '' then  Scite_Color_Text('ComObjects')
	If $SCITE_COLOR_Standard_UDF = '' Then Scite_Color_Text('Standard_UDF')
	If $COLOR_declared_func = '' Then $COLOR_declared_func = COLOR_declared_func($SCITE_COLOR_White_space)
	;if $SCITE_COLOR_Background = '' then Scite_Color_Text('Background') ; kolor tla edytora

	;_GUICtrlTreeView_SetBkColor($TreeView, $SCITE_COLOR_Background)
	$TreeView_Item_Script = GUICtrlCreateTreeViewItem("@ SCRIPT  [0]", $TreeView)
	$tree_user_func = GUICtrlCreateTreeViewItem("Func (declared func)  (0)", $TreeView_Item_Script)
	If IsChecked($TVhex[0]) Then $tree_String = GUICtrlCreateTreeViewItem("String  (0)", $TreeView_Item_Script)
	$tree_func = GUICtrlCreateTreeViewItem("Urzyte funkcje  (0)", $TreeView_Item_Script)

	$tree_func_Func_UDF = GUICtrlCreateTreeViewItem("UDF   Func  (0)", $tree_func)
	$tree_func_Func_BLACK = GUICtrlCreateTreeViewItem("Black  Func  (0)", $tree_func)
	$tree_func_Func_AU3 = GUICtrlCreateTreeViewItem("Autoit Func  (0)", $tree_func)
	$tree_func_Func_FREE = GUICtrlCreateTreeViewItem("Free   Func  (0)", $tree_func)

	$tree_user_var = GUICtrlCreateTreeViewItem("Variable  [0]", $TreeView_Item_Script)
	$tree_global_const = GUICtrlCreateTreeViewItem("Global Const  (0)", $tree_user_var)
	$tree_Local_const = GUICtrlCreateTreeViewItem("Local Const  (0)", $tree_user_var)
	If IsChecked($TVhex[1]) Then $tree_user_var_all = GUICtrlCreateTreeViewItem("Variable (all var)  (0)", $tree_user_var)
	If IsChecked($TVhex[2]) And IsChecked($TVhex[1]) Then $tree_user_var_unique = GUICtrlCreateTreeViewItem("Variable (unique)  (0)", $tree_user_var)
	If IsChecked($TVhex[3]) Then $tree_macro_pink = GUICtrlCreateTreeViewItem("Macro  (0)", $TreeView_Item_Script)
	If IsChecked($TVhex[4]) Then $tree_autoit_opt = GUICtrlCreateTreeViewItem("AutoItSetOption  (0)", $TreeView_Item_Script)
	If IsChecked($TVhex[5]) Then $tree_include = GUICtrlCreateTreeViewItem("Include", $TreeView_Item_Script)
	If IsChecked($TVhex[6]) Then $tree_macro_gren = GUICtrlCreateTreeViewItem("Comments  (0)", $TreeView_Item_Script)
	If IsChecked($TVhex[6]) And IsChecked($TVhex[16]) Then $tree_user_comments = GUICtrlCreateTreeViewItem(";~  Comments  (0)", $tree_macro_gren)
	If IsChecked($TVhex[7]) Then $tree_region = GUICtrlCreateTreeViewItem("Region  (0)", $TreeView_Item_Script)
	If IsChecked($TVhex[8]) Then $tree_number = GUICtrlCreateTreeViewItem("Number  (0)", $TreeView_Item_Script)
	If IsChecked($TVhex[9]) Then $tree_hexy = GUICtrlCreateTreeViewItem("Hexy  (0)", $TreeView_Item_Script)
	If IsChecked($TVhex[10]) Then $tree_HK = GUICtrlCreateTreeViewItem("HotKey  (0)", $TreeView_Item_Script)
	If IsChecked($TVhex[11]) Then $tree_run = GUICtrlCreateTreeViewItem("Run  (0)", $TreeView_Item_Script)
	If IsChecked($TVhex[12]) Then $tree_net = GUICtrlCreateTreeViewItem("Net  (0)", $TreeView_Item_Script)
	If IsChecked($TVhex[13]) Then $tree_RegKey = GUICtrlCreateTreeViewItem("RegKey  (0)", $TreeView_Item_Script)
	If IsChecked($TVhex[14]) Then $tree_FileWritte = GUICtrlCreateTreeViewItem("File Write  (0)", $TreeView_Item_Script)
	If IsChecked($TVhex[5]) Then $TreeView_Item_Include = GUICtrlCreateTreeViewItem("@ INCLUDE  [0][0]", $TreeView)

	GUICtrlSetState($TreeView_Item_Script, $GUI_EXPAND)
	GUICtrlSetState($tree_func, $GUI_EXPAND)
	GUICtrlSetState($tree_user_var, $GUI_EXPAND)
	GUICtrlSetState($TreeView_Item_Include, $GUI_EXPAND)
	;_GUICtrlTreeView_Sort($TreeView)
EndFunc   ;==>uTV_START


Func uTV_Create_File_TXT()
	Local $Create_File_TXT
	$Create_File_TXT &= "[Func (declared func)]" & $test_duble_dec_functions
	$Create_File_TXT &= "[Global Const]" & $test_duble_global_const
	$Create_File_TXT &= "[Local Const]" & $test_duble_Local_const
	$Create_File_TXT &= "[String]" & $test_duble_String
	;$Create_File_TXT &= "[Operatory]" & $test_duble_Operatory
	$Create_File_TXT &= "[UDF   Func]" & $test_duble_Func_UDF
	$Create_File_TXT &= "[Black  Func]" & $test_duble_Func_BLACK
	$Create_File_TXT &= "[Autoit Func]" & $test_duble_Func_AU3
	$Create_File_TXT &= "[Free   Func]" & $test_duble_Free_functions
	$Create_File_TXT &= "[Run]" & $test_duble_run
	$Create_File_TXT &= "[HotKeySet]" & $test_duble_HK
	$Create_File_TXT &= "[Net]" & $test_duble_net
	$Create_File_TXT &= "[RegKey]" & $test_duble_RegKey
	$Create_File_TXT &= "[FileWrite]" & $test_duble_FileWritte
	$Create_File_TXT &= "[Include]" & $test_duble_include
	$Create_File_TXT &= "[Macro]" & $test_duble_macro
	$Create_File_TXT &= "[Opt]" & $test_duble_autoit_opt
	$Create_File_TXT &= "[Number]" & $test_duble_number
	$Create_File_TXT &= "[Hexy]" & $test_duble_hex
	$Create_File_TXT &= "[Variable (all var)]" & $test_duble_variable
	$Create_File_TXT &= "[Variable (unique)]" & $test_duble_variable_unique
	$Create_File_TXT &= "[Region]" & $test_duble_region
	$Create_File_TXT &= "[Comments]" & $test_duble_coments
	$Create_File_TXT = StringRegExpReplace($Create_File_TXT, "(\r\n){2,}", @CRLF)
	Local $file = FileOpen($DirFileTreeViewList, 2) ; "[TreeViewList].ini"
	FileWrite($file, $Create_File_TXT)
	FileClose($file)
	StringReplace($Create_File_TXT, @CRLF, @CRLF)
	Local $ile = @extended - 21
	GUICtrlSetData($TreeView_Item_Script, StringFormat("@ SCRIPT  [%s]", $ile))
EndFunc   ;==>uTV_Create_File_TXT


Func uTV_Reset_Var_Test_Duble()
	$test_duble_dec_functions = @CRLF & @CRLF
	$test_duble_global_const = @CRLF & @CRLF
	$test_duble_Local_const = @CRLF & @CRLF
	$test_duble_String = @CRLF & @CRLF
	$test_duble_Operatory = @CRLF & @CRLF
	$test_duble_Func_UDF = @CRLF & @CRLF
	$test_duble_Func_BLACK = @CRLF & @CRLF
	$test_duble_Func_AU3 = @CRLF & @CRLF
	$test_duble_Free_functions = @CRLF & @CRLF
	$test_duble_run = @CRLF & @CRLF
	$test_duble_HK = @CRLF & @CRLF
	$test_duble_net = @CRLF & @CRLF
	$test_duble_RegKey = @CRLF & @CRLF
	$test_duble_FileWritte = @CRLF & @CRLF
	$test_duble_include = @CRLF & @CRLF
	$test_duble_macro = @CRLF & @CRLF
	$test_duble_autoit_opt = @CRLF & @CRLF
	$test_duble_number = @CRLF & @CRLF
	$test_duble_hex = @CRLF & @CRLF
	$test_duble_variable = @CRLF & @CRLF
	$test_duble_variable_multi = @CRLF & @CRLF
	$test_duble_variable_unique = @CRLF & @CRLF
	$test_duble_region = @CRLF & @CRLF
	$test_duble_coments = @CRLF & @CRLF
EndFunc   ;==>uTV_Reset_Var_Test_Duble

Func uTV_END()
	uTV_Reset_Var_Test_Duble()
	GUICtrlSetState($TreeView_Item_Script, BitOR($GUI_EXPAND, $GUI_DEFBUTTON))
	GUICtrlSetState($tree_user_func, $GUI_DEFBUTTON)
	If IsChecked($TVhex[0]) Then GUICtrlSetState($tree_String, $GUI_DEFBUTTON)
	GUICtrlSetState($tree_global_const, $GUI_DEFBUTTON)
	GUICtrlSetState($tree_Local_const, $GUI_DEFBUTTON)
	GUICtrlSetState($tree_func, BitOR($GUI_EXPAND, $GUI_DEFBUTTON))

	GUICtrlSetState($tree_func_Func_UDF, $GUI_DEFBUTTON)
	GUICtrlSetState($tree_func_Func_BLACK, $GUI_DEFBUTTON)
	GUICtrlSetState($tree_func_Func_AU3, $GUI_DEFBUTTON)
	GUICtrlSetState($tree_func_Func_FREE, $GUI_DEFBUTTON)

	GUICtrlSetState($tree_user_var, BitOR($GUI_EXPAND, $GUI_DEFBUTTON))
	If IsChecked($TVhex[1]) Then GUICtrlSetState($tree_user_var_all, $GUI_DEFBUTTON)
	If IsChecked($TVhex[2]) And IsChecked($TVhex[1]) Then GUICtrlSetState($tree_user_var_unique, $GUI_DEFBUTTON)
	If IsChecked($TVhex[3]) Then GUICtrlSetState($tree_macro_pink, $GUI_DEFBUTTON)
	If IsChecked($TVhex[4]) Then GUICtrlSetState($tree_autoit_opt, $GUI_DEFBUTTON)
	If IsChecked($TVhex[5]) Then GUICtrlSetState($tree_include, $GUI_DEFBUTTON)
	If IsChecked($TVhex[6]) Then GUICtrlSetState($tree_macro_gren, $GUI_DEFBUTTON)
	If IsChecked($TVhex[6]) And IsChecked($TVhex[16]) Then GUICtrlSetState($tree_user_comments, $GUI_DEFBUTTON)
	If IsChecked($TVhex[7]) Then GUICtrlSetState($tree_region, $GUI_DEFBUTTON)
	If IsChecked($TVhex[8]) Then GUICtrlSetState($tree_number, $GUI_DEFBUTTON)
	If IsChecked($TVhex[9]) Then GUICtrlSetState($tree_hexy, $GUI_DEFBUTTON)
	If IsChecked($TVhex[10]) Then GUICtrlSetState($tree_HK, $GUI_DEFBUTTON)
	If IsChecked($TVhex[11]) Then GUICtrlSetState($tree_run, $GUI_DEFBUTTON)
	If IsChecked($TVhex[12]) Then GUICtrlSetState($tree_net, $GUI_DEFBUTTON)
	If IsChecked($TVhex[13]) Then GUICtrlSetState($tree_RegKey, $GUI_DEFBUTTON)
	If IsChecked($TVhex[14]) Then GUICtrlSetState($tree_FileWritte, $GUI_DEFBUTTON)
	If IsChecked($TVhex[5]) Then GUICtrlSetState($TreeView_Item_Include, $GUI_DEFBUTTON)
EndFunc   ;==>uTV_END

#comments-start
	Func ______________func_not_exist()
	aaaaa()
	bbbb()
	EndFunc
#comments-end

#cs
	Func ______________func_not_exist_2()
	aaaaa()
	bbbb()
	EndFunc
#ce

Func uTV_Text_Comments_and_Region($myFilePatch)
	Local $search_coments = False
	Local $search_coments_full_string = False
	Local $search_region = False

	If IsChecked($TVhex[6]) Then $search_coments = True
	If IsChecked($TVhex[15]) Then $search_coments_full_string = True
	If IsChecked($TVhex[7]) Then $search_region = True

	Local $idViewItem, $idViewItem2
	$myFilePatch = @CRLF & $myFilePatch & @CRLF
	;$myFilePatch = StringRegExpReplace($myFilePatch, "\r\n([[:space:]]+)", @CRLF) ; del white space
	Local $array = StringSplit($myFilePatch, @CRLF, 3)
	$myFilePatch = 0
	Local $ile_coments = 0
	Local $ile_region = 0
	Local $green_text = False
	For $i = 0 To UBound($array) - 1
		$array[$i] = StringStripWS($array[$i], 1)
		If $search_coments Then
			If (StringInStr($array[$i], '#cs') = 1) Or (StringInStr($array[$i], '#comments-start') = 1) Then
				$ile_coments += 1
				$green_text = True
				GUICtrlSetData($tree_macro_gren, StringFormat("Comments (%s)", $ile_coments))
				$idViewItem = GUICtrlCreateTreeViewItem('#comments-start line = ' & $i, $tree_macro_gren)
				addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Comment_block)
			ElseIf (StringInStr($array[$i], '#ce') = 1) Or (StringInStr($array[$i], '#comments-end') = 1) Then
				$green_text = False
				$idViewItem = GUICtrlCreateTreeViewItem('#comments-end   line = ' & $i, $tree_macro_gren)
				addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Comment_block)

			ElseIf $green_text And $search_coments_full_string And $array[$i] Then
				$idViewItem2 = GUICtrlCreateTreeViewItem($array[$i], $idViewItem)
				addColor4TV($TreeView, $idViewItem2, $SCITE_COLOR_Comment_block)
			EndIf
		EndIf

		If $search_region Then
			If (StringInStr($array[$i], '#region') = 1) Then
				If Not $green_text Then
					$ile_region += 1
					GUICtrlSetData($tree_region, StringFormat("Region (%s)", $ile_region))
					$idViewItem = GUICtrlCreateTreeViewItem($array[$i], $tree_region)
					addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Special)
				EndIf
			ElseIf (StringInStr($array[$i], '#endregion') = 1) Then
				If Not $green_text Then
					$idViewItem = GUICtrlCreateTreeViewItem($array[$i], $tree_region)
					addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Special)
				EndIf
			EndIf
		EndIf
	Next
EndFunc   ;==>uTV_Text_Comments_and_Region


Func uTV_Text_Green_Text($myFilePatch, $max_lini = 120)
	Local $ReturnFilePatch
	Local $result = StringInStr($myFilePatch, @CRLF, 0, $max_lini)

	StringReplace($myFilePatch, @CRLF, @CRLF)
	If @extended <= $max_lini Then
		$ReturnFilePatch = ''
	Else
		$ReturnFilePatch = StringTrimLeft($myFilePatch, $result)
		$myFilePatch = StringLeft($myFilePatch, $result)
	EndIf

	$myFilePatch = @CRLF & $myFilePatch & @CRLF
	$myFilePatch = StringRegExpReplace($myFilePatch, "\r\n([[:space:]]+)", @CRLF) ; del white space

	Local $PatternDel = ''
	$PatternDel &= '(?ims)^\s*(#cs\b.*?\r\n[\s]*#ce\b.*?)\r\n'
	$PatternDel &= '|'
	$PatternDel &= '(?ims)^\s*(#comments-start\b.*?\r\n[\s]*#comments-end\b.*?)\r\n'
	$PatternDel &= '|'
	$PatternDel &= '(?ims)^\s*(#Region.*?)\r\n'
	$PatternDel &= '|'
	$PatternDel &= '(?ims)^\s*(#EndRegion.*?)\r\n'
	$PatternDel &= '|'
	$PatternDel &= '(?ims)^\s*(#AutoIt3Wrapper.*?)\r\n'
	$PatternDel &= '|'
	$PatternDel &= '(?ims)^\s*(#include-once)\b'
	$PatternDel &= '|'
	$PatternDel &= '("")'
	$PatternDel &= '|'
	$PatternDel &= '(".*?")'
	$PatternDel &= '|'
	$PatternDel &= "('')"
	$PatternDel &= '|'
	$PatternDel &= "('.*?')"
	$PatternDel &= '|'
	$PatternDel &= '([;].*?)(\r\n)'
	$PatternDel &= '|'
	$PatternDel &= '(.*?)'

	$myFilePatch = StringRegExpReplace($myFilePatch, $PatternDel, '\11\12')

	$myFilePatch = StringRegExpReplace($myFilePatch, "\r\n([[:space:]]+)", @CRLF) ; del white space

	Local $idViewItem
	Local $i
	Local $add_coments = StringSplit($myFilePatch, @CRLF, 3)
	For $i = 0 To UBound($add_coments) - 1
		If Not StringInStr($test_duble_coments, @CRLF & $add_coments[$i] & @CRLF) Then
			$idViewItem = GUICtrlCreateTreeViewItem($add_coments[$i], $tree_user_comments)
			addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Comment_block)
			$test_duble_coments &= $add_coments[$i] & @CRLF
		EndIf
	Next;
	Local $ile = UBound(StringSplit($test_duble_coments, @CRLF, 3)) - 3
	GUICtrlSetData($tree_user_comments, StringFormat(";~  Comments  (%s)", $ile))
	GUICtrlSetData($tree_macro_gren, StringFormat("%s  (%s)", StringRegExpReplace(GUICtrlRead($tree_macro_gren, 1), "(.*[)])\s*([(].*)", "\1"), $ile))

	Return $ReturnFilePatch
EndFunc   ;==>uTV_Text_Green_Text



Func uTV_Delete_Green_Text($myFilePatch)

	$myFilePatch = @CRLF & $myFilePatch & @CRLF

	$myFilePatch = StringRegExpReplace($myFilePatch, "\r\n([[:space:]]+)", @CRLF) ; del white space
	;$myFilePatch = StringRegExpReplace($myFilePatch, "([\r\n[:space:]]+)", @CRLF) ; del white space

	Local $PatternDel = ''
	$PatternDel &= '(?ims)^\s*(#cs\b.*?\r\n[\s]*#ce\b.*?)\r\n'
	$PatternDel &= '|'
	$PatternDel &= '(?ims)^\s*(#comments-start\b.*?\r\n[\s]*#comments-end\b.*?)\r\n'
	$PatternDel &= '|'
	$PatternDel &= '(?ims)^\s*(#Region.*?)\r\n'
	$PatternDel &= '|'
	$PatternDel &= '(?ims)^\s*(#EndRegion.*?)\r\n'
	$PatternDel &= '|'
	$PatternDel &= '(?ims)^\s*(#AutoIt3Wrapper.*?)\r\n'
	$PatternDel &= '|'
	$PatternDel &= '(?ims)^\s*(#include-once)\b'
	$PatternDel &= '|'
	$PatternDel &= '("")'
	$PatternDel &= '|'
	$PatternDel &= '(".*?")'
	$PatternDel &= '|'
	$PatternDel &= "('')"
	$PatternDel &= '|'
	$PatternDel &= "('.*?')"
	$PatternDel &= '|'
	$PatternDel &= '(\s*;.*?)(\r\n)'
	$myFilePatch = StringRegExpReplace($myFilePatch, $PatternDel, '\7\8\9\10\12')

	$myFilePatch = StringRegExpReplace($myFilePatch, "\r\n([[:space:]]+)", @CRLF) ; del white space

	;ConsoleWrite($myFilePatch & @CRLF)
	Return $myFilePatch
EndFunc   ;==>uTV_Delete_Green_Text


Func uTV_Text_Deklarowane_Funkcje($myFilePatch)
	Local $idViewItem
	Local $i
	Local $add_func = StringRegExp($myFilePatch, '(?ims)^\s*Func\s+(\w+)\s*[(]', 3)
	For $i = 0 To UBound($add_func) - 1
		;If Not StringInStr($test_duble_dec_functions, @CRLF & $add_func[$i] & @CRLF) Then
		$idViewItem = GUICtrlCreateTreeViewItem($add_func[$i], $tree_user_func)
		;addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_White_space)
		addColor4TV($TreeView, $idViewItem, $COLOR_declared_func)
		$test_duble_dec_functions &= $add_func[$i] & @CRLF
		;EndIf
	Next
	GUICtrlSetData($tree_user_func, StringFormat("Func (declared func)  (%s)", UBound(StringSplit($test_duble_dec_functions, @CRLF, 3)) - 3))
EndFunc   ;==>uTV_Text_Deklarowane_Funkcje

Func uTV_Text_Deklarowane_Funkcje_2($myFilePatch, $aTree)
	Local $idViewItem
	Local $i
	Local $many = 0
	Local $add_func = StringRegExp($myFilePatch, '(?ims)^\s*Func\s+(\w+)\s*[(]', 3)
	For $i = 0 To UBound($add_func) - 1
		$idViewItem = GUICtrlCreateTreeViewItem($add_func[$i], $aTree)
		addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_White_space)
		$many += 1
	Next
	GUICtrlSetData($aTree, StringFormat("Funkcje  (%s)", $many))
	Return $many
EndFunc   ;==>uTV_Text_Deklarowane_Funkcje_2

Func uTV_Text_Global_Const($myFilePatch)
	Local $idViewItem
	Local $i

	Local $add_global_const = StringRegExp($myFilePatch, '(?ims)^\s*Global\s+Const\s+([$]\w+)', 3)
	For $i = 0 To UBound($add_global_const) - 1
		;If Not StringInStr($test_duble_global_const, @CRLF & $add_global_const[$i] & @CRLF) Then
		$idViewItem = GUICtrlCreateTreeViewItem($add_global_const[$i], $tree_global_const)
		addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Variable)
		$test_duble_global_const &= $add_global_const[$i] & @CRLF
		;EndIf
	Next
	GUICtrlSetData($tree_global_const, StringFormat("Global Const  (%s)", UBound(StringSplit($test_duble_global_const, @CRLF, 3)) - 3))
EndFunc   ;==>uTV_Text_Global_Const

Func uTV_Text_Global_Const_2($myFilePatch, $aTree)
	Local $idViewItem
	Local $hDC

	Local $i
	Local $many = 0
	Local $add_global_const = StringRegExp($myFilePatch, '(?ims)^\s*Global\s+Const\s+([$]\w+)', 3)
	;Local $add_global_const = StringRegExp($myFilePatch, '(?ims)^\s*Global\s+Const\s+(.*?)\r\n', 3)
	For $i = 0 To UBound($add_global_const) - 1
		$idViewItem = GUICtrlCreateTreeViewItem($add_global_const[$i], $aTree)
		addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Variable)
		$many += 1
	Next
	GUICtrlSetData($aTree, StringFormat("Global Const  (%s)", $many))
	Return $many
EndFunc   ;==>uTV_Text_Global_Const_2

Func uTV_Text_Local_Const($myFilePatch)
	Local $idViewItem
	Local $i
	Local $add_Local_const = StringRegExp($myFilePatch, '(?ims)^\s*Local\s+Const\s+([$]\w+)', 3)
	For $i = 0 To UBound($add_Local_const) - 1
		If Not StringInStr($test_duble_Local_const, @CRLF & $add_Local_const[$i] & @CRLF) Then
			$idViewItem = GUICtrlCreateTreeViewItem($add_Local_const[$i], $tree_Local_const)
			addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Variable)
			$test_duble_Local_const &= $add_Local_const[$i] & @CRLF
		EndIf
	Next
	GUICtrlSetData($tree_Local_const, StringFormat("Local Const  (%s)", UBound(StringSplit($test_duble_Local_const, @CRLF, 3)) - 3))
EndFunc   ;==>uTV_Text_Local_Const

Func uTV_Text_Include($myFilePatch, $update = True)
	Local $idViewItem
	Local $i
	;################################## (?ims)^\s*#include*['"< ]*(.*?)['">]
	Local $add_include = StringRegExp(StringReplace($myFilePatch, '#include-once', @CRLF), "(?ims)^\s*#include\s*(['" & '"<].*?["' & "'>])", 3)
	For $i = 0 To UBound($add_include) - 1
		If Not StringInStr($test_duble_include, @CRLF & StringRegExpReplace($add_include[$i], '[><"' & "']", '') & @CRLF) Then
			If $update Then
				$idViewItem = GUICtrlCreateTreeViewItem('#include ' & $add_include[$i], $tree_include)
				addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Pre_Processor)
			EndIf
			$test_duble_include &= StringRegExpReplace($add_include[$i], '[><"' & "']", '') & @CRLF
		EndIf
	Next
	If $update Then GUICtrlSetData($tree_include, StringFormat("Include  (%s)", UBound(StringSplit($test_duble_include, @CRLF, 3)) - 3))
EndFunc   ;==>uTV_Text_Include

Func uTV_Text_Macro($myFilePatch)
	Local $idViewItem
	Local $i
	Local $add_macro_pink = StringRegExp($myFilePatch, '[@]\w+', 3)
	If $SCITE_FUNC_macros = '' Then Scite_Operator_Macro_Func_Udf('macros')
	For $i = 0 To UBound($add_macro_pink) - 1
		If Not StringInStr($test_duble_macro, @CRLF & $add_macro_pink[$i] & @CRLF) Then
			If StringInStr($SCITE_FUNC_macros, @CRLF & $add_macro_pink[$i] & @CRLF) Then
				$idViewItem = GUICtrlCreateTreeViewItem($add_macro_pink[$i], $tree_macro_pink)
				addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Macro)
				$test_duble_macro &= $add_macro_pink[$i] & @CRLF
			EndIf
		EndIf
	Next
	GUICtrlSetData($tree_macro_pink, StringFormat("Macro  (%s)", UBound(StringSplit($test_duble_macro, @CRLF, 3)) - 3))
EndFunc   ;==>uTV_Text_Macro


Func uTV_Text_Opt($myFilePatch)
	Local $idViewItem
	Local $i

	Local $pathern = ''
	$pathern &= '(?i)[^"' & "']\s*\bOpt\b\s*[(]\s*(.*?)[)]"
	$pathern &= "|"
	$pathern &= "(?i)[^'" & '"]\s*\bAutoItSetOption\b\s*[(]\s*(.*?)[)]'
	Local $add_autoit_opt = StringRegExp($myFilePatch, $pathern, 3)
	$add_autoit_opt = ArrayDelete_FindTxT_AndDeleteMulti($add_autoit_opt, '')
	For $i = 0 To UBound($add_autoit_opt) - 1
		If Not StringInStr($test_duble_autoit_opt, @CRLF & $add_autoit_opt[$i] & @CRLF) Then
			$idViewItem = GUICtrlCreateTreeViewItem($add_autoit_opt[$i], $tree_autoit_opt)
			addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_String)
			$test_duble_autoit_opt &= $add_autoit_opt[$i] & @CRLF
		EndIf
	Next
	GUICtrlSetData($tree_autoit_opt, StringFormat("AutoItSetOption  (%s)", UBound(StringSplit($test_duble_autoit_opt, @CRLF, 3)) - 3))
EndFunc   ;==>uTV_Text_Opt


Func uTV_Text_Run($myFilePatch)
	Local $idViewItem
	Local $i
	Local $pathern
	Local $searchList
	$searchList &= 'Shutdown,BlockInput,'
	$searchList &= 'PluginOpen,PluginClose,'
	$searchList &= 'Run,RunWait,RunAs,RunAsWait,ShellExecute,ShellExecuteWait,'
	$searchList &= 'ProcessClose,WinKill,WinClose,'
	$searchList &= 'DllOpen,DllCall,DllStructCreate,DllCallAddress,DllCallbackRegister,'
	$searchList &= 'ObjCreate,GUICtrlCreateObj,ObjCreateInterface'
	;$searchList &= '_SendMessage,_SendMessageA' ;ect

	Local $aSearch = StringSplit($searchList, ',', 3)
	For $i = 0 To UBound($aSearch) - 1
		$pathern &= "(?i)[^'" & '"]\s*(\b' & $aSearch[$i] & '\b\s*[(]\s*.*?[)])'
		If $i < (UBound($aSearch) - 1) Then $pathern &= "|"
	Next

	Local $add_run = StringRegExp($myFilePatch, $pathern, 3)
	$add_run = ArrayDelete_FindTxT_AndDeleteMulti($add_run, '')

	For $i = 0 To UBound($add_run) - 1
		If Not StringInStr($test_duble_run, @CRLF & $add_run[$i] & @CRLF) Then
			$idViewItem = GUICtrlCreateTreeViewItem($add_run[$i], $tree_run)
			addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Function)
			$test_duble_run &= $add_run[$i] & @CRLF
		EndIf
	Next
	GUICtrlSetData($tree_run, StringFormat("Run  (%s)", UBound(StringSplit($test_duble_run, @CRLF, 3)) - 3))
EndFunc   ;==>uTV_Text_Run

Func uTV_Text_HotKeySet($myFilePatch)
	Local $idViewItem
	Local $i
	Local $pathern
	Local $searchList
	$searchList &= 'HotKeySet,'
	$searchList &= '_IsPressed,'
	$searchList &= '_WinAPI_GetAsyncKeyState,'
	$searchList &= 'GUISetAccelerators'

	Local $aSearch = StringSplit($searchList, ',', 3)
	For $i = 0 To UBound($aSearch) - 1
		$pathern &= '(?i)\s*(\b' & $aSearch[$i] & '\b\s*[(].*[)])'
		If $i < (UBound($aSearch) - 1) Then $pathern &= "|"
	Next

	$searchList = ''
	$searchList &= '$WM_HOTKEY,0x0312,'
	$searchList &= '$WM_KEYDOWN,0x0100,'
	$searchList &= '$WM_KEYFIRST,';0x0100,'
	$searchList &= '$WM_KEYLAST,0x0108,'
	$searchList &= '$WM_KEYLAST,0x0109,'
	$searchList &= '$WM_KEYUP,0x0101'

	$pathern &= "|"

	Local $aSearch = StringSplit($searchList, ',', 3)
	For $i = 0 To UBound($aSearch) - 1
		$pathern &= '(?i)\s*(\bGUIRegisterMsg\b\s*[(]\s*\Q' & $aSearch[$i] & '\E.*[)])'
		If $i < (UBound($aSearch) - 1) Then $pathern &= "|"
	Next


	Local $add_HK = StringRegExp($myFilePatch, $pathern, 3)
	$add_HK = ArrayDelete_FindTxT_AndDeleteMulti($add_HK, '')

	For $i = 0 To UBound($add_HK) - 1
		If Not StringInStr($test_duble_HK, @CRLF & $add_HK[$i] & @CRLF) Then
			$idViewItem = GUICtrlCreateTreeViewItem($add_HK[$i], $tree_HK)
			;addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Sent_keys_in_string)
			addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Function)
			$test_duble_HK &= $add_HK[$i] & @CRLF
		EndIf
	Next
	GUICtrlSetData($tree_HK, StringFormat("HotKey  (%s)", UBound(StringSplit($test_duble_HK, @CRLF, 3)) - 3))
EndFunc   ;==>uTV_Text_HotKeySet


Func uTV_Text_Net($myFilePatch)
	Local $idViewItem
	Local $i
	Local $pathern
	Local $searchList
	$searchList &= 'InetRead,InetGet,HttpSetProxy,FtpSetProxy,Ping,'
	$searchList &= 'TCPConnect,TCPNameToIP,TCPListen,TCPRecv,TCPSend,UDPBind,UDPOpen,UDPRecv,UDPSend,'
	$searchList &= '_FTP_Command,_FTP_Connect,_FTP_DirPutContents,_FTP_FileGet,_FTP_FileOpen,_FTP_FilePut,_FTP_Open,'
	$searchList &= '_INetGetSource,_INetMail,_INetSmtpMail,'
	$searchList &= '_WinNet_AddConnection,_WinNet_AddConnection2,_WinNet_AddConnection3,'
	$searchList &= '_IE_Example,_IEAction,_IEAttach,_IECreate,_IECreateEmbedded'

	Local $aSearch = StringSplit($searchList, ',', 3)
	For $i = 0 To UBound($aSearch) - 1
		$pathern &= '(?i)\s*\b(' & $aSearch[$i] & '\b\s*[(]\s*.*?[)])'
		If $i < (UBound($aSearch) - 1) Then $pathern &= "|"
	Next
	$pathern &= "|"
	$pathern &= '(?i)\s*\b(ObjCreate\b\s*[(][\s"' & "']+InternetExplorer.*?[)])"
	$pathern &= "|"
	$pathern &= '(?i)\s*\b(ObjCreate\b\s*[(][\s"' & "']+WiniNet[.].*?[)])"
	$pathern &= "|"
	$pathern &= '(?i)\s*\b(ObjCreate\b\s*[(][\s"' & "']+WinHttp[.].*?[)])"
	$pathern &= "|"
	$pathern &= '(?i)\s*\b(DllOpen\b\s*[(][\s"' & "']+\QWiniNet.dll\E['" & '"]\s*[)])'
	$pathern &= "|"
	$pathern &= '(?i)\s*\b(DllOpen\b\s*[(][\s"' & "']+\QWinHttp.dll\E['" & '"]\s*[)])'


	Local $add_net = StringRegExp($myFilePatch, $pathern, 3)
	$add_net = ArrayDelete_FindTxT_AndDeleteMulti($add_net, '')

	For $i = 0 To UBound($add_net) - 1
		If Not StringInStr($test_duble_net, @CRLF & $add_net[$i] & @CRLF) Then
			$idViewItem = GUICtrlCreateTreeViewItem($add_net[$i], $tree_net)
			addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Function)
			$test_duble_net &= $add_net[$i] & @CRLF
		EndIf
	Next
	GUICtrlSetData($tree_net, StringFormat("Net  (%s)", UBound(StringSplit($test_duble_net, @CRLF, 3)) - 3))
EndFunc   ;==>uTV_Text_Net


Func uTV_Text_RegKey($myFilePatch)
	Local $idViewItem
	Local $i
	Local $pathern

	Local $aSearch = StringSplit('RegWrite,RegRead,RegEnumVal,RegEnumKey,RegDelete', ',', 3)
	For $i = 0 To UBound($aSearch) - 1
		$pathern &= "(?i)[^'" & '"]\s*\b(' & $aSearch[$i] & '\b\s*[(]\s*.*?[)])'
		If $i < (UBound($aSearch) - 1) Then $pathern &= "|"
	Next

	Local $add_regkey = StringRegExp($myFilePatch, $pathern, 3)
	$add_regkey = ArrayDelete_FindTxT_AndDeleteMulti($add_regkey, '')

	For $i = 0 To UBound($add_regkey) - 1
		If Not StringInStr($test_duble_RegKey, @CRLF & $add_regkey[$i] & @CRLF) Then
			$idViewItem = GUICtrlCreateTreeViewItem($add_regkey[$i], $tree_RegKey)
			addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Function)
			$test_duble_RegKey &= $add_regkey[$i] & @CRLF
		EndIf
	Next
	GUICtrlSetData($tree_RegKey, StringFormat("RegKey  (%s)", UBound(StringSplit($test_duble_RegKey, @CRLF, 3)) - 3))
EndFunc   ;==>uTV_Text_RegKey


Func uTV_Text_FileWrite($myFilePatch)
	Local $idViewItem
	Local $i
	Local $pathern
	Local $searchLiist
	$searchLiist &= 'FileWrite,FileWriteLine,'
	$searchLiist &= 'FileOpen,FileDelete,FileRecycle,FileRecycleEmpty,FileMove,FileCopy,'
	$searchLiist &= 'FileInstall,'
	$searchLiist &= 'DirRemove,DirCreate,DirCopy,DirMove,'
	$searchLiist &= 'IniWrite,IniDelete,IniWriteSection,IniRenameSection,'
	$searchLiist &= 'FileSetAttrib,'
	$searchLiist &= 'FileInstall,'
	$searchLiist &= '_FileWriteFromArray,_FileWriteLog,_ReplaceStringInFile,'
	$searchLiist &= '_WinAPI_CreateFile,_WinAPI_WriteFile'

	Local $aSearch = StringSplit($searchLiist, ',', 3)
	For $i = 0 To UBound($aSearch) - 1
		$pathern &= "(?i)[^'" & '"]\s*\b(' & $aSearch[$i] & '\b\s*[(]\s*.*?[)])'
		If $i < (UBound($aSearch) - 1) Then $pathern &= "|"
	Next

	Local $add_FW = StringRegExp($myFilePatch, $pathern, 3)
	$add_FW = ArrayDelete_FindTxT_AndDeleteMulti($add_FW, '')

	For $i = 0 To UBound($add_FW) - 1
		If Not StringInStr($test_duble_FileWritte, @CRLF & $add_FW[$i] & @CRLF) Then
			$idViewItem = GUICtrlCreateTreeViewItem($add_FW[$i], $tree_FileWritte)
			addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Function)
			$test_duble_FileWritte &= $add_FW[$i] & @CRLF
		EndIf
	Next
	GUICtrlSetData($tree_FileWritte, StringFormat("File Write  (%s)", UBound(StringSplit($test_duble_FileWritte, @CRLF, 3)) - 3))
EndFunc   ;==>uTV_Text_FileWrite


Func uTV_Text_Free_Funkc()
	Local $idViewItem
	Local $i

	Local $ur_declare_func = StringSplit($test_duble_dec_functions, @CRLF, 3)
	$ur_declare_func = ArrayDelete_FindTxT_AndDeleteMulti($ur_declare_func, '')
	Local $ur_use_func = $test_duble_Func_BLACK & @CRLF & $test_duble_Func_UDF

	For $i = 0 To UBound($ur_declare_func) - 1
		If Not StringInStr($ur_use_func, @CRLF & $ur_declare_func[$i] & @CRLF) Then
			$idViewItem = GUICtrlCreateTreeViewItem($ur_declare_func[$i], $tree_func_Func_FREE)
			addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_White_space)
			$test_duble_Free_functions &= $ur_declare_func[$i] & @CRLF
		EndIf
	Next
	GUICtrlSetData($tree_func_Func_FREE, StringFormat("Free   Func  (%s)", UBound(StringSplit($test_duble_Free_functions, @CRLF, 3)) - 3))
EndFunc   ;==>uTV_Text_Free_Funkc


Func uTV_Text_Free_Var()
	Local $idViewItem
	Local $i

	Local $sprawdzane = StringSplit($test_duble_variable, @CRLF, 3)
	For $i = 0 To UBound($sprawdzane) - 1
		If Not StringInStr($test_duble_variable_multi, @CRLF & $sprawdzane[$i] & @CRLF) Then
			$test_duble_variable_unique &= $sprawdzane[$i] & @CRLF
			$idViewItem = GUICtrlCreateTreeViewItem($sprawdzane[$i], $tree_user_var_unique)
			addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Variable)
		EndIf
	Next
	GUICtrlSetData($tree_user_var_unique, StringFormat("Variable (unique)  (%s)", UBound(StringSplit($test_duble_variable_unique, @CRLF, 3)) - 3))
EndFunc   ;==>uTV_Text_Free_Var


Func uTV_Text_Var_Func_Hex_etc($myFilePatch, $max_lini = 65);
	Local $idViewItem, $ReturnFilePatch, $i

	Local $result = StringInStr($myFilePatch, @CRLF, 0, $max_lini)

	StringReplace($myFilePatch, @CRLF, @CRLF)
	If @extended <= $max_lini Then
		$ReturnFilePatch = ''
	Else
		$ReturnFilePatch = StringTrimLeft($myFilePatch, $result)
		$myFilePatch = StringLeft($myFilePatch, $result)
	EndIf

	If $SCITE_FUNC_functions = '' Then $SCITE_FUNC_functions = Scite_Operator_Macro_Func_Udf('functions')
	If $SCITE_FUNC_udfs = '' Then $SCITE_FUNC_udfs = Scite_Operator_Macro_Func_Udf('udfs')
	If $SCITE_FUNC_keywords = '' Then $SCITE_FUNC_keywords = Scite_Operator_Macro_Func_Udf('keywords')

	$myFilePatch = StringRegExpReplace($myFilePatch, '(_\r\n)', ' ')

	Local $PatternDel = ''
	;$PatternDel &= '(?ims)#c[^#]+#c'
	;$PatternDel &= '|'
	$PatternDel &= '("")'
	$PatternDel &= '|'
	$PatternDel &= '(".*?")'
	$PatternDel &= '|'
	$PatternDel &= "('')"
	$PatternDel &= '|'
	$PatternDel &= "('.*?')"
	$PatternDel &= '|'
	;$PatternDel &= '(\s*;.*?)(\r\n)'
	;$PatternDel &= '|'
	;$PatternDel &= '(?ims)^\s*(#include-once)\b'
	;$PatternDel &= '|'
	;$PatternDel &= '(?ims)^\s*(#Region\s*.+?)\r\n'
	;$PatternDel &= '|'
	;$PatternDel &= '(?ims)^\s*(#EndRegion\s*.+?)\r\n'
	;$PatternDel &= '|'
	;$PatternDel &= '(?ims)^\s*(#AutoIt3Wrapper.+?)\r\n'
	;$PatternDel &= '|'
	$PatternDel &= '([<{@$#.]\w+)'
	$PatternDel &= '|'
	$PatternDel &= '(\b\d+\b)'
	$PatternDel &= '|'
	$PatternDel &= '(0x\w+)'
	$PatternDel &= '|'
	$PatternDel &= '(?ims)^\s*Func\s+(\w+)\s*[(]'
	Local $add_use_func = StringRegExp(StringRegExpReplace($myFilePatch, $PatternDel, ' '), '(\w+\s*)[(]', 3)

	;local $var = '[$]\w+\b'  										 ; $var
	;local $arr = '[$]\w+(?:\s*[[]\s*(?:[$]\w+|\d*)\s*[]]){1,5}'     ; array
	Local $var = '[$]\w+(?:(?:\s*[[]\s*(?:[$]\w+|\d*)\s*[]]){1,5}|)' ; $var + array[x]
	Local $num = '\s*[-]\s*\b\d+\b' ; cyfra / number / -1
	Local $hex = '\b[0][x][[:xdigit:]]+\b' ; hex
	Local $str = '(?:".*"|' & "'.*')" ; string
	;Local $all = StringFormat("\s*(?:%s|%s|%s|%s)\s*", $var, $num, $hex, $str)
	Local $all = '(?:[$]\w+(?:(?:\s*[[]\s*(?:[$]\w+|\d*)\s*[]]){1,5}|)|\s*[-]\s*\b\d+\b|\b[0][x][[:xdigit:]]+\b|(?:".*"|' & "'.*'))"
	Local $all_2 = '(?:["' & "'](\w+)['" & '"]|(' & $var & '))' ; var or string (no " . " )

	Local $sSearch = ''
	$sSearch &= 'GUIRegisterMsg,' ;GUIRegisterMsg ( msgID, "function" )
	$sSearch &= 'GUISetOnEvent,' ;GUISetOnEvent ( specialID, "function" [, winhandle] )
	$sSearch &= 'GUICtrlSetOnEvent,' ;GUICtrlSetOnEvent ( controlID, "function" )
	$sSearch &= 'TrayItemSetOnEvent,' ;TrayItemSetOnEvent ( itemID, "function" )
	$sSearch &= 'TraySetOnEvent,' ;TraySetOnEvent ( specialID, "function" )
	$sSearch &= 'GUICtrlRegisterListViewSort,' ;GUICtrlRegisterListViewSort ( controlID, "function" )
	$sSearch &= 'HotKeySet' ;HotKeySet ( "key" [, "function"] )

	Local $Pattern = ''

	Local $aSearch = StringSplit($sSearch, ',', 3)
	For $i = 0 To UBound($aSearch) - 1
		$Pattern &= '(?i)\s*\b' & $aSearch[$i] & '\b\s*[(]\s*' & $all & '\s*[,]\s*' & $all_2 ;& '\s*[)]'
		If $i < (UBound($aSearch) - 1) Then $Pattern &= "|"
	Next

	Local $sSearch = ''
	$sSearch &= 'DllCallbackRegister,' ;DllCallbackRegister ( "function", "return type", "params" )
	$sSearch &= 'AdlibRegister,' ;AdlibRegister ( "function" [, time] )
	$sSearch &= 'Call,' ;Call ( "function" [, param1 [, param2 [, paramN]]] )
	$sSearch &= 'OnAutoItExitRegister' ;OnAutoItExitRegister ( "function" )

	$Pattern &= '|'

	Local $aSearch = StringSplit($sSearch, ',', 3)
	For $i = 0 To UBound($aSearch) - 1
		$Pattern &= '(?i)\s*\b' & $aSearch[$i] & '\b\s*[(]\s*' & $all_2 ;& '\s*[,)]'
		If $i < (UBound($aSearch) - 1) Then $Pattern &= "|"
	Next

	$Pattern &= '|'
	$Pattern &= '(?i)\s*#OnAutoItStartRegister\b\s*[(]\s*' & $all_2 ;& '\s*[)]'  ;#OnAutoItStartRegister "function"
	;$Pattern &= '|'
	;$Pattern &= '(?i)\s*\bHotKeySet\b\s*[(]\s*.*\s*[,]\s*' & $all_2  ;& '\s*[)]'

	;ConsoleWrite($Pattern & @CRLF)

	Local $add_use_func_2 = StringRegExp($myFilePatch, $Pattern, 3) ; patern wyszukuje jakie funkcje zostaly zarejestrowne

	If IsArray($add_use_func_2) Then
		;_ArrayDisplay($add_use_func_2)
		$add_use_func_2 = ArrayDelete_FindTxT_AndDeleteMulti($add_use_func_2, '')
		_ArrayConcatenate($add_use_func, $add_use_func_2)
	EndIf

	For $i = 0 To UBound($add_use_func) - 1
		$add_use_func[$i] = StringStripWS($add_use_func[$i], 8)
		If Not StringInStr($test_duble_Operatory, @CRLF & $add_use_func[$i] & @CRLF) Then
			If Not StringInStr($SCITE_FUNC_keywords, @CRLF & $add_use_func[$i] & @CRLF) Then; ;<===;standard keywords
				If StringInStr($SCITE_FUNC_functions, @CRLF & $add_use_func[$i] & @CRLF) Then; ;<===;standard func scite

					$idViewItem = GUICtrlCreateTreeViewItem($add_use_func[$i], $tree_func_Func_AU3)
					addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Function)
					$test_duble_Func_AU3 &= $add_use_func[$i] & @CRLF
					GUICtrlSetData($tree_func_Func_AU3, StringFormat("Autoit Func (%s)", UBound(StringSplit($test_duble_Func_AU3, @CRLF, 3)) - 3))
				ElseIf StringInStr($SCITE_FUNC_udfs, @CRLF & $add_use_func[$i] & @CRLF) Then; ;<===;standard UDF func

					$idViewItem = GUICtrlCreateTreeViewItem($add_use_func[$i], $tree_func_Func_UDF)
					addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Standard_UDF)
					$test_duble_Func_UDF &= $add_use_func[$i] & @CRLF
					GUICtrlSetData($tree_func_Func_UDF, StringFormat("UDF   Func  (%s)", UBound(StringSplit($test_duble_Func_UDF, @CRLF, 3)) - 3))

				Else ;<===;black func
					If StringInStr($add_use_func[$i], '$') Then
						;$idViewItem = GUICtrlCreateTreeViewItem('##:var:## ' & $add_use_func[$i], $tree_func_Func_BLACK)
						$idViewItem = GUICtrlCreateTreeViewItem($add_use_func[$i], $tree_func_Func_BLACK)
						addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Variable)
						;GUICtrlSetState($idViewItem, $GUI_DEFBUTTON)
					ElseIf Not StringInStr($test_duble_dec_functions, @CRLF & $add_use_func[$i] & @CRLF) Then
						$idViewItem = GUICtrlCreateTreeViewItem($add_use_func[$i], $tree_func_Func_BLACK)
						addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Comment_line)
						;addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Pre_Processor)
						;GUICtrlSetState($idViewItem, $GUI_DEFBUTTON)
					Else
						$idViewItem = GUICtrlCreateTreeViewItem($add_use_func[$i], $tree_func_Func_BLACK)
						addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_White_space)
					EndIf
					$test_duble_Func_BLACK &= $add_use_func[$i] & @CRLF
					$idViewItem = GUICtrlSetData($tree_func_Func_BLACK, StringFormat("Black  Func (%s)", UBound(StringSplit($test_duble_Func_BLACK, @CRLF, 3)) - 3))

				EndIf
				;GUICtrlCreateTreeViewItem($add_use_func[$i], $tree_func)
				$test_duble_Operatory &= $add_use_func[$i] & @CRLF
			EndIf
		EndIf
	Next
	GUICtrlSetData($tree_func, StringFormat("Urzyte funkcje  (%s)", UBound(StringSplit($test_duble_Operatory, @CRLF, 3)) - 3))

	;##################################
	;##################################	string
	;##################################(?ims)\s*(".*?")|\s*('.*?')

	If IsChecked($TVhex[0]) Then

		Local $add_string = StringRegExp($myFilePatch, '\s*(".*?")|' & "\s*('.*?')", 3)
		For $i = 0 To UBound($add_string) - 1
			If Not StringInStr($test_duble_String, @CRLF & $add_string[$i] & @CRLF) Then
				$idViewItem = GUICtrlCreateTreeViewItem($add_string[$i], $tree_String)
				addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_String)
				$test_duble_String &= $add_string[$i] & @CRLF
			EndIf
		Next
		GUICtrlSetData($tree_String, StringFormat("String  (%s)", UBound(StringSplit($test_duble_String, @CRLF, 3)) - 3))

	EndIf

	;##################################
	;################################## number zwykle
	;##################################

	If IsChecked($TVhex[8]) Then

		Local $add_number = StringRegExp(StringRegExpReplace($myFilePatch, "([.]){2,}|(0x\w+)|[$]\w+", ' '), '\b([.\d]+)\b', 3)

		For $i = 0 To UBound($add_number) - 1
			If Not StringInStr($test_duble_number, @CRLF & $add_number[$i] & @CRLF) Then
				$test_duble_number &= String($add_number[$i] & @CRLF)
				$idViewItem = GUICtrlCreateTreeViewItem($add_number[$i], $tree_number)
				addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Number)
			EndIf
		Next
		GUICtrlSetData($tree_number, StringFormat("Number  (%s)", UBound(StringSplit($test_duble_number, @CRLF, 3)) - 3))

	EndIf

	;##################################
	;################################## number hexy
	;##################################

	If IsChecked($TVhex[9]) Then

		Local $add_hexy = StringRegExp($myFilePatch, '\b(0x[[:xdigit:]]+)\b', 3)

		For $i = 0 To UBound($add_hexy) - 1
			If Not StringInStr($test_duble_hex, @CRLF & $add_hexy[$i] & @CRLF) Then
				$test_duble_hex &= $add_hexy[$i] & @CRLF
				$idViewItem = GUICtrlCreateTreeViewItem($add_hexy[$i], $tree_hexy)
				addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Number)

			EndIf
		Next
		GUICtrlSetData($tree_hexy, StringFormat("Hexy  (%s)", UBound(StringSplit($test_duble_hex, @CRLF, 3)) - 3))

	EndIf

	;##################################
	;################################## variable
	;##################################

	If IsChecked($TVhex[1]) Then
		;Local $PatternDel = ''
		;$PatternDel &= '("")'
		;$PatternDel &= '|'
		;$PatternDel &= '(".*?")'
		;$PatternDel &= '|'
		;$PatternDel &= "('')"
		;$PatternDel &= '|'
		;$PatternDel &= "('.*?')"
		;Local $add_zmiene = StringRegExp(StringRegExpReplace($myFilePatch, $PatternDel, ' '), '[$]\w+', 3)
		Local $add_zmiene = StringRegExp($myFilePatch, '[$]\w+', 3)

		For $i = 0 To UBound($add_zmiene) - 1
			If Not StringInStr($test_duble_variable, @CRLF & $add_zmiene[$i] & @CRLF) Then
				$test_duble_variable &= $add_zmiene[$i] & @CRLF
				$idViewItem = GUICtrlCreateTreeViewItem($add_zmiene[$i], $tree_user_var_all)
				addColor4TV($TreeView, $idViewItem, $SCITE_COLOR_Variable)
			Else
				If Not StringInStr($test_duble_variable_multi, @CRLF & $add_zmiene[$i] & @CRLF) Then
					$test_duble_variable_multi &= $add_zmiene[$i] & @CRLF
				EndIf
			EndIf
		Next
		GUICtrlSetData($tree_user_var_all, StringFormat("Variable (all var)  (%s)", UBound(StringSplit($test_duble_variable, @CRLF, 3)) - 3))
		GUICtrlSetData($tree_user_var, StringFormat("Variable  [%s]", UBound(StringSplit($test_duble_variable, @CRLF, 3)) - 3))
	EndIf


	Return $ReturnFilePatch

EndFunc   ;==>uTV_Text_Var_Func_Hex_etc

#endregion update treewiew

Func scite_get_open_FilePathAU3()
	Local $IsOpenFilePatch
	scite_send_command("askproperty:FilePath")
	$IsOpenFilePatch = StringReplace($SciTECmd, '\\', '\')
	$SciTECmd = ''
	If FileExists($IsOpenFilePatch) Then
		Return $IsOpenFilePatch
	EndIf

	$IsOpenFilePatch = WinGetTitle(WinGetHandle("[CLASS:SciTEWindow]"))
	$IsOpenFilePatch = StringRegExpReplace($IsOpenFilePatch, '(?i)(.*)[ ][-*][ ]SciTE(4AutoIt3)?(.*)?\z', '\1')
	If FileExists($IsOpenFilePatch) Then
		Return $IsOpenFilePatch
	EndIf

	Return ''
EndFunc   ;==>scite_get_open_FilePathAU3

Func scite_get_AutoitDir()
	Local $returnAutoitDir = ''

	scite_send_command("askproperty:autoit3dir")
	$returnAutoitDir = StringRegExpReplace($SciTECmd, '(.*)([\\])*\z', '\1')
	$returnAutoitDir = StringReplace($returnAutoitDir, '\\', '\')

	If FileExists($returnAutoitDir) Then
		$SciTECmd = ''
		Return $returnAutoitDir
	EndIf
	$SciTECmd = ''

	scite_send_command("askproperty:SciteDefaultHome")
	$returnAutoitDir = StringRegExpReplace($SciTECmd, '(.*)([\\].*)', '\1')
	$returnAutoitDir = StringReplace($returnAutoitDir, '\\', '\')

	If FileExists($returnAutoitDir) Then
		$SciTECmd = ''
		Return $returnAutoitDir
	EndIf
	$SciTECmd = ''

	Local $Wow64 = ""
	If @AutoItX64 Then $Wow64 = "\Wow6432Node"
	$returnAutoitDir = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE" & $Wow64 & "\AutoIt v3\AutoIt", "InstallDir")

	If FileExists($returnAutoitDir) Then
		Return $returnAutoitDir
	EndIf

	Return ''
EndFunc   ;==>scite_get_AutoitDir

Func Copy_To_SciTE()
	Local $CopyTextToScite = StringRegExp(GUICtrlRead($myGUICtrlList), '(?ims)^\s*([$#@]?\w*)\s*[=]+\s*([(]?)', 3) ;aray[ "first word, "(" ]
	If Not IsArray($CopyTextToScite) Then Return 0
	WinActivate("[CLASS:SciTEWindow]")
	Switch $CopyTextToScite[1]
		Case '('
			scite_send_command("insert: " & $CopyTextToScite[0] & '(   )')
		Case Else
			scite_send_command("insert: " & $CopyTextToScite[0])
	EndSwitch
	MyToolTip('Copy To SciTE: ' & @CRLF & $CopyTextToScite[0])
	ToolTip('')
EndFunc   ;==>Copy_To_SciTE

Func Open_Include()
	Local $Open_Include = StringRegExpReplace(GUICtrlRead($myGUICtrlList), '(?ims)(.*)#Include\s*[<"' & "'](.*)[.]au3[>'" & '"](.*)', "\2")
	If (Not @extended) Or $Open_Include = '' Then
		MyToolTip('Include not exist')
		Return 0
	EndIf
	WinActivate("[CLASS:SciTEWindow]")
	If $AutoitDir = '' Then $AutoitDir = scite_get_AutoitDir()

	Local $timer = TimerInit()
	Local $aFileName = $AutoitDir & '\Include\' & $Open_Include & '.au3'

	If ProcessExists("SciTE.exe") And Not StringRegExpReplace($aFileName, '([:\\.\w ]*)', "") Then ; test unicode
		scite_send_command("open:" & StringReplace($aFileName, '\', '\\'))
	Else
		ShellExecute($aFileName, "", '', "open")
	EndIf
	Do
		Sleep(500)
		scite_send_command("askproperty:FileName")
	Until ($SciTECmd = $Open_Include) Or (TimerDiff($timer) >= 3500)

	Local $SelectString = StringRegExpReplace(GUICtrlRead($myGUICtrlList), '([$]*\w*)(.*)', "\1") ;first word
	Local $Find_DecFunc = StringRegExpReplace(FileRead($aFileName), '((?ims)^\s*Func\s+\Q' & $SelectString & '\E\s*[(].*)', @CRLF)
	If @extended Then $Find_DecFunc = StringRegExp($Find_DecFunc, @CRLF, 3) ;create array
	If IsArray($Find_DecFunc) Then
		Local $GoToLine = UBound($Find_DecFunc)
		scite_send_command("goto:" & $GoToLine + 100)
		scite_send_command("goto:" & $GoToLine)
		scite_send_command("find:" & $SelectString); find declared func
	Else
		scite_send_command("find:" & $SelectString)
	EndIf
	$SciTECmd = ''
EndFunc   ;==>Open_Include

Func MyToolTip($text, $time = 3000)
	Local $timer = TimerInit()
	Do
		ToolTip($text)
		Sleep(100)
	Until TimerDiff($timer) >= $time
	ToolTip('')
EndFunc   ;==>MyToolTip

Func String_Fragment_Miedzy($string, $poczatek, $koniec, $poz_pocz = 1, $poz_koniec = 1, $litery = 0)
	Return StringTrimLeft(StringLeft($string, StringInStr($string, $koniec, $litery, $poz_koniec) - 1), StringInStr($string, $poczatek, $litery, $poz_pocz) + StringLen($poczatek) - 1)
EndFunc   ;==>String_Fragment_Miedzy

Func Open_Help()
	Local $AddTextToScite = StringSplit(StringReplace(GUICtrlRead($myGUICtrlList), ' ', ''), '=', 3)
	If $AutoitDir = '' Then $AutoitDir = scite_get_AutoitDir()
	ShellExecute("Autoit3Help.exe", $AddTextToScite[0], $AutoitDir)
	WinActivate("AutoIt Help")
EndFunc   ;==>Open_Help
Func Click_GUICtrlList_Update_Text()
	GUICtrlSetData($label, '================')
	GUICtrlSetData($Label_2, '')
	Local $new_text = StringSplit(StringReplace(GUICtrlRead($myGUICtrlList), ' ', ''), '=')
	If $new_text[0] = 1 Then Return 0
	Update_Text($new_text[1], False)
EndFunc   ;==>Click_GUICtrlList_Update_Text
Func Click_Scite_Update_Text()
	scite_send_command("askproperty:CurrentWord")

	;consolewrite($SciTECmd & @CRLF)

	If GUICtrlRead($tab) <> 3 Then
		If $SciTECmd <> '' And Not StringRegExpReplace(StringRegExpReplace($SciTECmd, '[@#$]', ''), '\w', '') And $SciTECmd <> $Old_SciTECmd Then
			$Old_SciTECmd = $SciTECmd
			Update_Text($SciTECmd)
		EndIf
	Else
		If $SciTECmd <> $Old_SciTECmd Then
			$Old_SciTECmd = $SciTECmd
			Update_Text($SciTECmd, False, True)
		EndIf
	EndIf
EndFunc   ;==>Click_Scite_Update_Text
Func Update_Text($Loc_SciTECmd, $FindString = True, $GoogleTransalte = False)
	Local $myIniRead = IniRead($DirFileHelper, 'Lista', $Loc_SciTECmd, ""); "[Helper].ini"
	If $myIniRead Then ; standard
		GUICtrlSetData($label, $Loc_SciTECmd)
		GUICtrlSetData($Label_2, $Loc_SciTECmd)
		Switch StringLeft($Loc_SciTECmd, 1)
			Case '@' ; macro
				GUICtrlSetData($edit, 'MACRO: ' & @CRLF & @CRLF & $Loc_SciTECmd & ' = ' & $myIniRead)
			Case '#' ;macro
				GUICtrlSetData($edit, 'SCITE MACRO: ' & @CRLF & @CRLF & $Loc_SciTECmd & ' = ' & $myIniRead)
			Case '$' ;$var
				GUICtrlSetData($edit, 'UDF VARIABLE: ' & @CRLF & @CRLF & $myIniRead)
			Case Else ; func & operator
				If StringInStr($myIniRead, '[NO_DOC_FUNCTION]') Then
					GUICtrlSetData($edit, 'NO DOCUMENTED FUNCTION:' & @CRLF & @CRLF & $Loc_SciTECmd & ' ( )' & @CRLF & @CRLF & $myIniRead)
				ElseIf StringInStr($myIniRead, '[OPTION_TO_CHANGE]') Then
					$myIniRead = StringReplace($myIniRead, '[OPTION_TO_CHANGE]', '')
					GUICtrlSetData($edit, '[OPTION_TO_CHANGE]' & @CRLF & @CRLF & 'Opt( ' & $Loc_SciTECmd & ' )' & @CRLF & @CRLF & $myIniRead)
				ElseIf StringInStr($myIniRead, '[IS OLD NAME. NEW IS: /===>]') Then
					$myIniRead = StringReplace($myIniRead, '[IS OLD NAME. NEW IS: /===>]', '')
					Local $ar_old = StringRegExp($myIniRead, '([#]*\w+)', 3)
					GUICtrlSetData($edit, '[IS OLD NAME]' & @CRLF & @CRLF & 'is old name: ' & $Loc_SciTECmd & @CRLF & _
							'new name:  ' & $ar_old[1] & @CRLF & @CRLF & String_Fragment_Miedzy($myIniRead, '(', ')'))
				Else
					GUICtrlSetData($edit, $Loc_SciTECmd & ' ' & $myIniRead)
				EndIf
		EndSwitch
		If $FindString Then
			Local $iIndex = _GUICtrlListBox_FindString($myGUICtrlList, $Loc_SciTECmd)
			_GUICtrlListBox_SetCurSel($myGUICtrlList, $iIndex)
		EndIf
	ElseIf $GoogleTransalte Then ; google translate
		$Loc_SciTECmd = StringFormat($Loc_SciTECmd)
		;$Loc_SciTECmd = StringRegExpReplace(@CRLF & $Loc_SciTECmd, "\r\n([[:space:]]+)", @CRLF)
		GUICtrlSetData($edit, $Loc_SciTECmd)
	EndIf
EndFunc   ;==>Update_Text
Func Scite_Operator_Macro_Func_Udf($type)
	Local $return

	Switch $type
		Case 'keywords'
			scite_send_command("askproperty:au3.keywords.keywords")
			$return = $SciTECmd
		Case 'functions'
			scite_send_command("askproperty:au3.keywords.functions")
			$return = $SciTECmd
		Case 'macros'
			scite_send_command("askproperty:au3.keywords.macros")
			$return = $SciTECmd
		Case 'sendkeys'
			scite_send_command("askproperty:au3.keywords.sendkeys")
			$return = $SciTECmd
		Case 'preprocessor'
			scite_send_command("askproperty:au3.keywords.preprocessor")
			$return = $SciTECmd
		Case 'special'
			scite_send_command("askproperty:au3.keywords.special")
			$return = $SciTECmd
			scite_send_command("askproperty:autoit3wrapper.keywords.special")
			$return &= @CRLF & $SciTECmd
		Case 'abbrev'
			scite_send_command("askproperty:au3.keywords.abbrev")
			$return = $SciTECmd
		Case 'udfs'
			scite_send_command("askproperty:au3.keywords.udfs")
			$return = $SciTECmd
			scite_send_command("askproperty:au3.keywords.user.udfs")
			$return &= @CRLF & $SciTECmd
	EndSwitch
	$return = StringReplace($return, '\t', '')
	$return = StringReplace($return, ' ', @CRLF)
	$return = @CRLF & $return & @CRLF
	$return = StringRegExpReplace($return, '([[:space:]]+)', @CRLF)
	Assign("SCITE_FUNC_" & $type, $return)
	Return $return
EndFunc   ;==>Scite_Operator_Macro_Func_Udf

Func Scite_Color_Text($type)
	Local $style, $rColor

	Switch $type
		Case 'White_space'
			$style = 0
		Case 'Comment_line'
			$style = 1
		Case 'Comment_block'
			$style = 2
		Case 'Number'
			$style = 3
		Case 'Function'
			$style = 4
		Case 'Keyword'
			$style = 5
		Case 'Macro'
			$style = 6
		Case 'String'
			$style = 7
		Case 'Operator'
			$style = 8
		Case 'Variable'
			$style = 9
		Case 'Sent_keys_in_string'
			$style = 10
		Case 'Pre_Processor'
			$style = 11
		Case 'Special'
			$style = 12
		Case 'Expad_abbreviations'
			$style = 13
		Case 'ComObjects'
			$style = 14
		Case 'Standard_UDF'
			$style = 15
		Case 'Background'
			$style = 32
	EndSwitch

	scite_send_command("askproperty:style.au3." & $style)
	$rColor = $SciTECmd
	$rColor = StringRegExp($rColor, '#([[:xdigit:]]{6})', 3)
	If $type = 'Background' Then $rColor[0] = $rColor[1]
	;ConsoleWrite('0x' & $rColor[0] & @CRLF)
	Assign("SCITE_COLOR_" & $type, '0x' & $rColor[0])
	Return $rColor
EndFunc   ;==>Scite_Color_Text

Func COLOR_declared_func($color_up)
	;Local
	$color_up += 1;
	While 1
		Switch $color_up
			Case $SCITE_COLOR_White_space
				$color_up += 1
			Case $SCITE_COLOR_Comment_line
				$color_up += 1
			Case $SCITE_COLOR_Comment_block
				$color_up += 1
			Case $SCITE_COLOR_Number
				$color_up += 1
			Case $SCITE_COLOR_Function
				$color_up += 1
				;Case $SCITE_COLOR_Keyword
				;$color_up += 1
			Case $SCITE_COLOR_Macro
				$color_up += 1
			Case $SCITE_COLOR_String
				$color_up += 1
			Case $SCITE_COLOR_Operator
				$color_up += 1
			Case $SCITE_COLOR_Variable
				$color_up += 1
			Case $SCITE_COLOR_Sent_keys_in_string
				$color_up += 1
			Case $SCITE_COLOR_Pre_Processor
				$color_up += 1
			Case $SCITE_COLOR_Special
				$color_up += 1
				;Case $SCITE_COLOR_Expad_abbreviations
				;$color_up += 1
				;Case $SCITE_COLOR_ComObjects
				;$color_up += 1
			Case $SCITE_COLOR_Standard_UDF
				$color_up += 1
				;Case $SCITE_COLOR_Background
				;$color_up += 1
			Case Else
				;$COLOR_declared_func = '0x' & Hex($SCITE_COLOR_White_space + $color_up, 6)
				Return $color_up
		EndSwitch
	WEnd
EndFunc   ;==>COLOR_declared_func

Func Search_Func()
	Local $mySave = IniRead($inifile, "funkcje au3", "FileSelect", @ScriptDir)
	Local $var = FileSelectFolder("", '', "", $mySave, $gui)
	If @error Then Return
	IniWrite($inifile, "funkcje au3", "FileSelect", $var)

	Local $FileList, $ile = 0, $Skrucona_Nazwa, $all_extended = 0, $array, $i, $bingo, $all_bingo = 0
	Local $n, $standard = '', $myFileRead, $linia = '', $hMany, $policz, $policz_2, $ktory, $use_arra_del
	Local $SEARCH_TXT = GUICtrlRead($Input_1)
	Local $use_console = False
	;if GUICtrlRead($hexConsole) = $GUI_CHECKED then $use_console = true
	If IsChecked($hexConsole) Then $use_console = True

	GUICtrlSetData($label, $var)
	GUICtrlSetState($progress, $GUI_SHOW)
	GUICtrlSetState($bution, $GUI_DISABLE)
	GUICtrlSetState($Input_2, $GUI_DISABLE)
	GUICtrlSetState($bution_2, $GUI_DISABLE)
	WinSetTitle($gui, "", 'Baza fukcji w plikach     [ 0 / 0 / 0 ]')
	_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($listview))

	$FileList = myFileListToArray_AllFiles($var, '*.au3')
	$all_extended = @extended

	Switch okresl_radio($radio)

		Case 0 ; SEARCH FUNC

			GUICtrlSetData($listview, "No|Funkcja|Files|Lokalizacja| |")
			GUICtrlSendMsg($listview, 0x101E, 0, 40)
			GUICtrlSendMsg($listview, 0x101E, 1, 180)
			GUICtrlSendMsg($listview, 0x101E, 2, 150)
			GUICtrlSendMsg($listview, 0x101E, 3, 400)
			GUICtrlSendMsg($listview, 0x101E, 4, 0)
			If (GUICtrlRead($Chex_Ignore1) = $GUI_CHECKED) Then
				If $SCITE_FUNC_udfs = '' Or ($SCITE_FUNC_udfs = @CRLF & @CRLF & @CRLF) Then
					Scite_Operator_Macro_Func_Udf('udfs')
					If ($SCITE_FUNC_udfs = '') Or ($SCITE_FUNC_udfs = @CRLF) Then
						If $AutoitDir = '' Then $AutoitDir = scite_get_AutoitDir()
						$SCITE_FUNC_udfs = FileRead($AutoitDir & '\SciTE\Properties\au3.keywords.properties')
						$SCITE_FUNC_udfs = String_Fragment_Miedzy($SCITE_FUNC_udfs, 'au3.keywords.udfs=', 'au3.keywords.keywords')
						$SCITE_FUNC_udfs &= FileRead($AutoitDir & '\SciTE\Properties\au3.userudfs.properties')
						$SCITE_FUNC_udfs = StringReplace($SCITE_FUNC_udfs, 'au3.keywords.user.udfs=', @CRLF)
						$SCITE_FUNC_udfs = StringRegExpReplace($SCITE_FUNC_udfs, '([[:space:]\\]+)', @CRLF)
						$SCITE_FUNC_udfs = @CRLF & $SCITE_FUNC_udfs & @CRLF
						;ConsoleWrite($SCITE_FUNC_udfs)
					EndIf
				EndIf
				$standard = $SCITE_FUNC_udfs
			EndIf

			If IsArray($FileList) Then
				For $id = 1 To $FileList[0]
					If $use_console Then ConsoleWrite('+' & $FileList[$id] & @CRLF)
					WinSetTitle($gui, "", StringFormat(' [%s / [ %s / %s ] / %s ] %s', $ile, $id, $FileList[0], $all_extended, $FileList[$id]))
					$Skrucona_Nazwa = StringRegExpReplace($FileList[$id], "((?:.*?[\\/]+)*)(.*?\z)", "$2")
					;$array = StringRegExp(FileRead($FileList[$id]), '(?ims)^\s*Func\s+(\w+)\s*[(]', 3)
					$myFileRead = Test_Text_and_Convert_CRLF(FileRead($FileList[$id]))
					$array = StringRegExp(StringRegExpReplace($myFileRead, '(?ims)^\s*(#cs\b.*?\r\n[\s]*#ce\b.*?)\r\n', ''), '(?ims)^\s*Func\s+(\w+)\s*[(]', 3)
					If Not IsArray($array) Then ContinueLoop
					Local $array_AD[UBound($array)][4]
					$use_arra_del = False
					If (GUICtrlRead($Chex_Ignore1) = $GUI_CHECKED) Then ;IGNORE STANDARD FUNC (UDF)
						For $n = 0 To UBound($array) - 1
							If Not StringInStr($standard, @CRLF & $array[$n] & @CRLF) Then
								$ile += 1
								If $use_console Then ConsoleWrite($array[$n] & @CRLF)
								;If $use_console Then ConsoleWrite($array[$n] & '=  [NO_DOC_FUNCTION] or [INTERNAL_USE_ONLY]   (Requires: #include <' & $Skrucona_Nazwa & '>)'& @CRLF)
								$array_AD[$n][0] = $ile
								$array_AD[$n][1] = $array[$n] & ' ()'
								$array_AD[$n][2] = $Skrucona_Nazwa
								$array_AD[$n][3] = $FileList[$id]
							Else
								$use_arra_del = True
							EndIf
						Next
						If $use_arra_del Then
							$array_AD = ArrayDelete_FindTxT_AndDeleteMulti($array_AD, '')
						EndIf
						_GUICtrlListView_AddArray($listview, $array_AD)
					Else ; NO IGNORE STANDARD FUNC (UDF)
						If $use_console Then ConsoleWrite($array[$n] & @CRLF)
						For $n = 0 To UBound($array) - 1
							$ile += 1
							If $use_console Then ConsoleWrite($array[$n] & @CRLF)
							$array_AD[$n][0] = $ile
							$array_AD[$n][1] = $array[$n] & ' ()'
							$array_AD[$n][2] = $Skrucona_Nazwa
							$array_AD[$n][3] = $FileList[$id]
						Next
						;$array_AD = ArrayDelete_FindTxT_AndDeleteMulti($array_AD , '')
						_GUICtrlListView_AddArray($listview, $array_AD)
					EndIf
					GUICtrlSetData($progress, (100 / $FileList[0]) * $id)
				Next
				$standard = 0
				WinSetTitle($gui, "", StringFormat(' [ %s / [ %s ] / %s ]     [ func / files au3 / all files ]', $ile, $FileList[0], $all_extended))
			EndIf

		Case 1 ;SEARCH STRING

			GUICtrlSetData($listview, "No|Sukces|Linia|Files|Lokalizacja|")
			GUICtrlSendMsg($listview, 0x101E, 0, 40)
			GUICtrlSendMsg($listview, 0x101E, 1, 60)
			GUICtrlSendMsg($listview, 0x101E, 2, 150)
			If (GUICtrlRead($Chex_Licz2) = $GUI_CHECKED) And (GUICtrlRead($Chex_String3) = $GUI_CHECKED) Then
				GUICtrlSendMsg($listview, 0x101E, 1, 90)
				GUICtrlSendMsg($listview, 0x101E, 2, 400)
			EndIf
			GUICtrlSendMsg($listview, 0x101E, 3, 150)
			GUICtrlSendMsg($listview, 0x101E, 4, 400)

			If IsArray($FileList) Then
				For $id = 1 To $FileList[0]
					WinSetTitle($gui, "", StringFormat(' [ [%s / %s ] / [ %s / %s ] / %s ] %s', $ile, $all_bingo, $id, $FileList[0], $all_extended, $FileList[$id]))
					$Skrucona_Nazwa = StringRegExpReplace($FileList[$id], "((?:.*?[\\/]+)*)(.*?\z)", "$2")
					$myFileRead = FileRead($FileList[$id])
					$myFileRead = Test_Text_and_Convert_CRLF($myFileRead)
					StringReplace($myFileRead, $SEARCH_TXT, '')
					$bingo = @extended
					$all_bingo += $bingo
					If $bingo Then
						If $use_console Then ConsoleWrite('+' & $FileList[$id] & @CRLF)
						$ile += 1
						$linia = ''

						If (GUICtrlRead($Chex_Licz2) = $GUI_CHECKED) Then

							If Not (GUICtrlRead($Chex_String3) = $GUI_CHECKED) Then ; NO FULL STRING

								For $i = $bingo To 1 Step -1
									If $i > 30 Then
										$i = 30
										$linia = '...   [ sorry. max 30 lini. is = 30 / ' & $bingo & ' ] '
									EndIf
									$myFileRead = StringLeft($myFileRead, StringInStr($myFileRead, $SEARCH_TXT, 0, $i))
									$myFileRead = StringReplace($myFileRead, @CRLF, @CRLF)
									$linia = @extended + 1 & ',' & $linia
								Next
								$linia = StringTrimRight($linia, 1)

							Else ; YES FULL STRING

								$myFileRead = @CRLF & $myFileRead & @CRLF
								$ile -= 1
								If $bingo < 15 Then

									Local $array_AD[$bingo][5]

									For $i = 1 To $bingo
										$ile += 1

										StringReplace(StringLeft($myFileRead, StringInStr($myFileRead, $SEARCH_TXT, 0, $i)), @CRLF, @CRLF)
										$ktory = @extended + 1

										$linia = StringTrimLeft(StringLeft($myFileRead, StringInStr($myFileRead, @CRLF, 0, $ktory) - 1), StringInStr($myFileRead, @CRLF, 0, $ktory - 1) + 1)

										If (GUICtrlRead($Chex_DelTab4) = $GUI_CHECKED) Then ; usuwaj @tab
											$linia = StringReplace($linia, @TAB, ' ')
										EndIf
										If $use_console Then ConsoleWrite($linia & @CRLF)
										$array_AD[$i - 1][0] = $ile
										$array_AD[$i - 1][1] = '[' & $i & '/' & $bingo & ']  L = ' & ($ktory - 1)
										$array_AD[$i - 1][2] = $linia
										$array_AD[$i - 1][3] = $Skrucona_Nazwa
										$array_AD[$i - 1][4] = $FileList[$id]
									Next
									WinSetTitle($gui, "", StringFormat(' [ [%s / %s ] / [ %s / %s ] / %s ] %s', $ile, $all_bingo, $id, $FileList[0], $all_extended, $FileList[$id]))
									;$array_AD = ArrayDelete_FindTxT_AndDeleteMulti($array_AD , '')
									_GUICtrlListView_AddArray($listview, $array_AD)

								ElseIf $bingo >= 15 Then

									$myFileRead = StringReplace($myFileRead, @CRLF, @CR)
									$myFileRead = StringReplace($myFileRead, @LF, @CR)
									$array = StringSplit($myFileRead, @CR)
									$policz = 0

									Local $array_AD[UBound($array) - 1][5]

									For $ktory = 1 To $array[0]

										If StringInStr($array[$ktory], $SEARCH_TXT) Then
											$ile += 1
											$linia = $array[$ktory]
											If (GUICtrlRead($Chex_DelTab4) = $GUI_CHECKED) Then
												$linia = StringReplace($linia, @TAB, ' ')
											EndIf

											StringReplace($array[$ktory], $SEARCH_TXT, '')
											$hMany = @extended

											If $hMany = 1 Then
												$policz += 1
												If $use_console Then ConsoleWrite($linia & @CRLF)
												$array_AD[$ktory - 1][0] = $ile
												$array_AD[$ktory - 1][1] = '[' & $policz & '/' & $bingo & ']  L = ' & ($ktory - 1)
												$array_AD[$ktory - 1][2] = $linia
												$array_AD[$ktory - 1][3] = $Skrucona_Nazwa
												$array_AD[$ktory - 1][4] = $FileList[$id]
											Else
												$policz_2 = ''
												For $n = 1 To $hMany
													$policz += 1
													$policz_2 &= $policz & ','
												Next
												$policz_2 = StringTrimRight($policz_2, 1)
												If $use_console Then ConsoleWrite($linia & @CRLF)
												$array_AD[$ktory - 1][0] = $ile
												$array_AD[$ktory - 1][1] = '[' & $policz_2 & '/' & $bingo & ']  L = ' & ($ktory - 1)
												$array_AD[$ktory - 1][2] = $linia
												$array_AD[$ktory - 1][3] = $Skrucona_Nazwa
												$array_AD[$ktory - 1][4] = $FileList[$id]
											EndIf

											If $policz = $bingo Then
												$ktory = $array[0]
											EndIf
										EndIf

									Next
									WinSetTitle($gui, "", StringFormat(' [ [%s / %s ] / [ %s / %s ] / %s ] %s', $ile, $all_bingo, $id, $FileList[0], $all_extended, $FileList[$id]))
									$array_AD = ArrayDelete_FindTxT_AndDeleteMulti($array_AD, '')
									_GUICtrlListView_AddArray($listview, $array_AD)
								EndIf
								GUICtrlSetData($progress, (100 / $FileList[0]) * $id)
								ContinueLoop
							EndIf

						EndIf
						If $use_console Then ConsoleWrite($linia & @CRLF)
						Local $array_AD[1][5]
						$array_AD[0][0] = $ile
						$array_AD[0][1] = $bingo
						$array_AD[0][2] = $linia
						$array_AD[0][3] = $Skrucona_Nazwa
						$array_AD[0][4] = $FileList[$id]
						;$array_AD = ArrayDelete_FindTxT_AndDeleteMulti($array_AD , '')
						_GUICtrlListView_AddArray($listview, $array_AD)
					EndIf
					GUICtrlSetData($progress, (100 / $FileList[0]) * $id)
				Next

				WinSetTitle($gui, "", StringFormat(' [ [ %s / %s ] / [ %s ] / %s ]     [ [ sukces / all ] / files au3 / all files ]' _
						, $ile, $all_bingo, $FileList[0], $all_extended))
			EndIf

	EndSwitch

	GUICtrlSetData($progress, 0)
	GUICtrlSetState($progress, $GUI_HIDE)
	GUICtrlSetState($bution, $GUI_ENABLE)
	GUICtrlSetState($Input_2, $GUI_ENABLE)
	GUICtrlSetState($bution_2, $GUI_ENABLE)
	GUICtrlSetData($label, '=========== lista gotowa ===========')

EndFunc   ;==>Search_Func


Func ArrayDelete_FindTxT_AndDeleteMulti(ByRef $avArray, $aDelete = '')

	If Not IsArray($avArray) Then Return 0
	Local $iUBound = UBound($avArray)

	Local $idx = 0

	Switch UBound($avArray, 0)
		Case 1
			For $i = 0 To $iUBound - 1
				If $avArray[$i] = $aDelete Then
					$idx += 1
				EndIf
			Next

			If $idx = 0 Then Return $avArray
			If $iUBound - $idx = 0 Then Return 0
			If $idx = $iUBound Then
				$avArray = 0
				Return $avArray
			EndIf

			Local $nowArray[$iUBound - $idx]
			$idx = 0
			For $i = 0 To $iUBound - 1
				If $avArray[$i] <> $aDelete Then
					$nowArray[$idx] = $avArray[$i]
					$idx += 1
				EndIf
			Next

		Case 2
			For $i = 0 To $iUBound - 1
				If $avArray[$i][0] = $aDelete Then
					$idx += 1

				EndIf
			Next

			If $idx = 0 Then Return $avArray
			If $iUBound - $idx = 0 Then Return 0
			If $idx = $iUBound Then
				$avArray = 0
				Return $avArray
			EndIf

			Local $iSubMax = UBound($avArray, 2) - 1
			Local $nowArray[$iUBound - $idx][$iSubMax + 1]
			$idx = 0

			For $i = 0 To $iUBound - 1
				If $avArray[$i][0] <> $aDelete Then
					For $j = 0 To $iSubMax
						$nowArray[$idx][$j] = $avArray[$i][$j]
					Next
					$idx += 1
				EndIf
			Next

		Case Else
			Return 0
	EndSwitch

	Return $nowArray
EndFunc   ;==>ArrayDelete_FindTxT_AndDeleteMulti


Func okresl_radio($dec_radio)
	Local $i
	For $i = 0 To UBound($dec_radio) - 1
		If (GUICtrlRead($dec_radio[$i]) = $GUI_CHECKED) Then Return $i
	Next
	Return 0
EndFunc   ;==>okresl_radio


Func open_file()
	Local $text = '', $wys
	$wys = _GUICtrlListView_GetSelectionMark($listview)
	Switch okresl_radio($radio)
		Case 0
			$text = _GUICtrlListView_GetItemText($listview, $wys, 3)
		Case 1
			$text = _GUICtrlListView_GetItemText($listview, $wys, 4)
	EndSwitch
	If $text <> '' Then
		If ProcessExists("SciTE.exe") And Not StringRegExpReplace($text, '([:\\.\w ]*)', "") Then ; test unicode
			scite_send_command("open:" & StringReplace($text, '\', '\\'))
		Else
			ShellExecute($text, "", '', "open")
		EndIf
	EndIf
EndFunc   ;==>open_file

Func open_folder()
	Local $text = '', $wys
	$wys = _GUICtrlListView_GetSelectionMark($listview)
	Switch okresl_radio($radio)
		Case 0
			$text = _GUICtrlListView_GetItemText($listview, $wys, 3)
		Case 1
			$text = _GUICtrlListView_GetItemText($listview, $wys, 4)
	EndSwitch
	$text = StringRegExpReplace($text, "((?:.*?[\\/]+)*)(.*?\z)", "\1")
	If $text <> '' Then ShellExecute($text, "", '', "open")
EndFunc   ;==>open_folder

Func FindText_LV_Find()
	Local $text = GUICtrlRead($Input_2)
	If $text = '' Then Return
	If $Visible_OLD_TEXT <> $text Then
		$Visible_ITEM = -1
		$Visible_OLD_TEXT = $text
	EndIf
	$Visible_ITEM = _GUICtrlListView_FindInText($listview, $text, $Visible_ITEM)
	_GUICtrlListView_EnsureVisible($listview, $Visible_ITEM)
	_GUICtrlListView_SetItemSelected($listview, $Visible_ITEM)
EndFunc   ;==>FindText_LV_Find

Func save()
	Local $size = WinGetPos($gui)
	IniWrite($inifile, "funkcje au3", "pos_x", $size[0])
	IniWrite($inifile, "funkcje au3", "pos_y", $size[1])
	IniWrite($inifile, "funkcje au3", "search", GUICtrlRead($Input_1))
	IniWrite($inifile, "funkcje au3", "search_2", GUICtrlRead($Input_2))
	IniWrite($inifile, "funkcje au3", "imput_dw", GUICtrlRead($imput_down))
	IniWrite($inifile, "funkcje au3", "Chex", GUICtrlRead($Chex_Ignore1))
	IniWrite($inifile, "funkcje au3", "Chex_2", GUICtrlRead($Chex_Licz2))
	IniWrite($inifile, "funkcje au3", "Chex_3", GUICtrlRead($Chex_String3))
	IniWrite($inifile, "funkcje au3", "Chex_4", GUICtrlRead($Chex_DelTab4))
	IniWrite($inifile, "funkcje au3", "radio", okresl_radio($radio))
	IniWrite($inifile, "funkcje au3", "tab", GUICtrlRead($tab))
	IniWrite($inifile, "funkcje au3", "alvays top", GUICtrlRead($hexAlvaysTop))
	IniWrite($inifile, "funkcje au3", "save pos", GUICtrlRead($SavePos))
	For $i = 0 To UBound($TVhex) - 1
		IniWrite($inifile, "funkcje au3", "TVhex[" & $i & "]", GUICtrlRead($TVhex[$i]))
	Next
	IniWrite($inifile, "funkcje au3", "Console", GUICtrlRead($hexConsole))
	IniWrite($inifile, "funkcje au3", "ChexLang", GUICtrlRead($CheckboxLangGT))
	IniWrite($inifile, "funkcje au3", "Language1", GUICtrlRead($comboLangGogle[0]))
	IniWrite($inifile, "funkcje au3", "Language2", GUICtrlRead($comboLangGogle[1]))
	IniWrite($inifile, "funkcje au3", "Language3", GUICtrlRead($comboLangGogle[2]))
EndFunc   ;==>save

Func check_imput_disable_enable()
	Switch okresl_radio($radio)
		Case 0
			GUICtrlSetState($Input_1, $GUI_DISABLE)
			GUICtrlSetState($Chex_Ignore1, $GUI_ENABLE)
			GUICtrlSetState($Chex_Licz2, $GUI_DISABLE)
			GUICtrlSetState($Chex_String3, $GUI_DISABLE)
			GUICtrlSetState($Chex_DelTab4, $GUI_DISABLE)
		Case 1
			GUICtrlSetState($Input_1, $GUI_ENABLE)
			GUICtrlSetState($Chex_Ignore1, $GUI_DISABLE)
			GUICtrlSetState($Chex_Licz2, $GUI_ENABLE)
			If (GUICtrlRead($Chex_Licz2) = $GUI_CHECKED) Then
				GUICtrlSetState($Chex_String3, $GUI_ENABLE)
				If (GUICtrlRead($Chex_String3) = $GUI_CHECKED) Then
					GUICtrlSetState($Chex_DelTab4, $GUI_ENABLE)
				Else
					GUICtrlSetState($Chex_DelTab4, $GUI_DISABLE)
				EndIf
			Else
				GUICtrlSetState($Chex_String3, $GUI_DISABLE)
				GUICtrlSetState($Chex_DelTab4, $GUI_DISABLE)
			EndIf
	EndSwitch
EndFunc   ;==>check_imput_disable_enable

Func check_google_disable_enable()
	If (GUICtrlRead($CheckboxLangGT) = $GUI_CHECKED) Then
		GUICtrlSetState($comboLangGogle[0], $GUI_ENABLE)
		GUICtrlSetState($comboLangGogle[1], $GUI_ENABLE)
		GUICtrlSetState($comboLangGogle[2], $GUI_ENABLE)
	Else
		GUICtrlSetState($comboLangGogle[0], $GUI_DISABLE)
		GUICtrlSetState($comboLangGogle[1], $GUI_DISABLE)
		GUICtrlSetState($comboLangGogle[2], $GUI_DISABLE)
	EndIf
EndFunc   ;==>check_google_disable_enable

#region 'myFileListToArray_AllFiles.au3'


; #FUNCTION# ====================================================================================================================
; Name...........: myFileListToArray_AllFiles
; Description ...: Lists files and\or folders in a specified path
; Syntax.........: myFileListToArray_AllFiles($sPath[, $sFilter = "*.*"[, $iFlag = 1[, $full_adress = True[, $methody = 0[, $size_min = 0[, $size_max = 0[, $Accept_Attribute = 0[, $NO_Accept_Attribute = 0[, $LevelTooDown = 0]]]]\]]]])
; Parameters ....: 	$sPath - Path to generate filelist for.
;					$sFilter = [default is "*.*"]. The filter to use. Search the Autoit3 manual for the word "WildCards" For details, support now for multiple searches
;                           			Example "*.exe; *.txt" will find all "*.exe" and "*.txt" files.
;										'*' = 0 or more. '?' = 0 or 1.
;					$iFlag = Optional: specifies whether to return files folders or both
;                  						|$iFlag=0 Return both files and folders
;                  						|$iFlag=1 (Default)Return files only
;                  						|$iFlag=2 Return Folders only
;					$full_adress = Optional: [default is true]
;										|True - Return full adress for file
;										|False - Return only file name
;					$methody = Optional:[default is 1] search methody
;										|$methody = 0 - simple
;										|$methody = 1 - is full pattern
;					$size_min = Optional:[default is 0] Minimal file size [MB]
;					$size_max = Optional:[default is 0] Max file size [MB]
;					$Accept_Attribute = Optional:[default is ""] Acccept only is file haw attributes.
;										|"R" = READONLY
;										|"A" = ARCHIVE
;										|"S" = SYSTEM
;										|"H" = HIDDEN
;										|"N" = NORMAL
;										|"D" = DIRECTORY
;										|"O" = OFFLINE
;										|"C" = COMPRESSED (NTFS compression, not ZIP compression)
;										|"T" = TEMPORARY
;					$NO_Accept_Attribute = Optional:[default is ""] NO acccept is file haw attributes.
;										|"R" = READONLY
;										|"A" = ARCHIVE
;										|"S" = SYSTEM
;										|"H" = HIDDEN
;										|"N" = NORMAL
;										|"D" = DIRECTORY
;										|"O" = OFFLINE
;										|"C" = COMPRESSED (NTFS compression, not ZIP compression)
;										|"T" = TEMPORARY
;					$LevelTooDown = Optional:[default is 0] how many level too down/up
;										|0 = full tree (all files)
;										|1 = search only one folder.
;										|2 = 2 level down
;										|3 = 3 level down
;										|x = x level down
;										|-1 = 1 level up (+ full tree)
;										|-2 = 2 level up (+ full tree)
;										|-x = x level up (+ full tree)
; Return values . : On Success - The array returned is one-dimensional and is made up as follows:
;                                		$array[0] = Number of Files\Folders returned
;                                		$array[1] = 1st File\Folder
;                                		$array[2] = 2nd File\Folder
;                                		$array[3] = 3rd File\Folder
;                                		$array[n] = nth File\Folder
;								 		@extended = How many files test
;					On Failure - @Error = 1 - Path not found or invalid
;                  				 @Error = 2 - No File(s) Found
;								 @extended = How many files test
; ===============================================================================================================================


; #FUNCTION# ====================================================================================================================
; Name...........: myFileListToArray_AllFiles
; Description ...: Zwraca liste plikow i/lub fodlderow
; Syntax.........: myFileListToArray_AllFiles($sPath[, $sFilter = "*.*"[, $iFlag = 1[, $full_adress = True[, $methody = 0[, $size_min = 0[, $size_max = 0[, $Accept_Attribute = 0[, $NO_Accept_Attribute = 0[, $LevelTooDown = 0]]]]]]]]])
; Parameters ....: 	$sPath - Sciezka dostempu do pliku
;					$sFilter = [default is "*.*"]. Filtr uzywany przy wyszukiwaniu. Mozna uzyc ich kilka oddzielajac kolejne znakiem ";"
;                           			Naprzyklad skrut "*.exe; *.txt" zastapi dwa wyszukiwania "*.exe" i "*.txt".
;										'*' = 0 lub wiecej. '?' = 0 lub 1.
;					$iFlag = Optional: parametr ustalajacy czy zwracac tylko pliki, foldery, czy oba na raz.
;                  						|$iFlag=0 Zwracaj wszystko
;                  						|$iFlag=1 (Default)Zwracaj tylko pliki
;                  						|$iFlag=2 Zwracaj tylko foldery
;					$full_adress = [default is true]
;										|True - Zwracaj pe³ny adress
;										|False - Zwracaj tylko nazwe pliku
;					$methody = [default is 1] - metoda szukania
;										|$methody = 0 - metoda prosta (szukaj plik zawierajacy czesc podanej nazwy)
;										|$methody = 1 - pelny pattern (to jest caly pattern)
;					$size_min = [default is 0] Minimalny rozmiar pliku [MB]
;					$size_max = [default is 0] maksymalny rozmiar pliku [MB]
;					$Accept_Attribute = [default is ""] Akceptuj tylko te pliki co maja te atrybuty.
;										|"R" = READONLY
;										|"A" = ARCHIVE
;										|"S" = SYSTEM
;										|"H" = HIDDEN
;										|"N" = NORMAL
;										|"D" = DIRECTORY
;										|"O" = OFFLINE
;										|"C" = COMPRESSED (NTFS compression, not ZIP compression)
;										|"T" = TEMPORARY
;					$NO_Accept_Attribute = [default is ""] Nie akceptuj plikow z tymi atrybutami.
;										|"R" = READONLY
;										|"A" = ARCHIVE
;										|"S" = SYSTEM
;										|"H" = HIDDEN
;										|"N" = NORMAL
;										|"D" = DIRECTORY
;										|"O" = OFFLINE
;										|"C" = COMPRESSED (NTFS compression, not ZIP compression)
;										|"T" = TEMPORARY
;					$LevelTooDown = [default is 0] = Jak gleboko (poziom) szukac w dol/gore.
;										|0 = cale drzewo (all files).
;										|1 = Szukaj tylko w 1 folderze.
;										|2 = 2 poziomy w dol.
;										|3 = 3 poziomy w dol.
;										|x = x poziomy w dol.
;										|-1 = 1 poziom w gore (+ cale drzewo)
;										|-2 = 2 poziom w gore (+ cale drzewo)
;										|-x = x poziom w gore (+ cale drzewo)
; Return values . : On Success - Zwraca tablice wyników:
;                                		$array[0] = Liczba znalezionych plikow i folderow
;                                		$array[1] = 1st File\Folder
;                                		$array[2] = 2nd File\Folder
;                                		$array[3] = 3rd File\Folder
;                                		$array[n] = nth File\Folder
;									   @extended  = Ile plikow przeszukano na dysku
;					On Niepowodzenie - @Error = 1 - Sciezka do katalogu jest bledna lub katalog nie istnieje ($sPath)
;                  				 	   @Error = 2 - Nie znaleziono plikow
;								 	   @extended  = Ile plikow przeszukano na dysku
; ===============================================================================================================================

Func myFileListToArray_AllFiles($sPath, $sFilter = "*.*", $iFlag = 1, $full_adress = 1, $methody = 1, $size_min = 0, $size_max = 0, $Accept_Attribute = 0, $NO_Accept_Attribute = 0, $LevelTooDown = 0)

	Local $hSearch, $sFile, $sFileList, $sDelim = "|", $HowManyFiles = 0, $aReturn
	$sPath = StringRegExpReplace($sPath, "[\\/]+\z", "") & "\" ; ensure single trailing backslash
	Local $c, $is_ok, $attrib, $FileSize, $lev, $levPath
	Local $foldery = '', $newFoldersSearch = '', $array_foldery, $extended, $a_Attribute, $NO_a_Attribute

	$iFlag = Number($iFlag)
	$full_adress = Number($full_adress)
	If $full_adress <> 0 Then $full_adress = 1
	$methody = Number($methody)
	If $methody <> 0 Then $methody = 1
	$size_min = Number($size_min * 100) / 100
	$size_max = Number($size_max * 100) / 100
	If $size_max - $size_min < 0 Then $size_max = 0
	If $Accept_Attribute = Default Or $Accept_Attribute = -1 Or $Accept_Attribute = '' Or $Accept_Attribute = '0' Then $Accept_Attribute = 0
	If $NO_Accept_Attribute = Default Or $NO_Accept_Attribute = -1 Or $NO_Accept_Attribute = '' Or $NO_Accept_Attribute = '0' Then $NO_Accept_Attribute = 0
	If $Accept_Attribute Then $a_Attribute = StringSplit(StringRegExpReplace($Accept_Attribute, "[;, ]", ""), "", 3)
	If $NO_Accept_Attribute Then $NO_a_Attribute = StringSplit(StringRegExpReplace($NO_Accept_Attribute, "[;, ]", ""), "", 3)

	$LevelTooDown = Number($LevelTooDown) ; TREE - level up/down
	If $LevelTooDown > 0 Then
		StringReplace($sPath, '\', '\')
		$levPath = @extended - 2
	ElseIf $LevelTooDown < 0 Then
		StringReplace($sPath, '\', '\')
		$levPath = @extended
		If $LevelTooDown <= $levPath Then
			$LevelTooDown = $levPath + $LevelTooDown
			If $LevelTooDown <= 0 Then $LevelTooDown = 1
			$sPath = StringLeft($sPath, StringInStr($sPath, '\', 0, $LevelTooDown))
			$LevelTooDown = 0
		EndIf
	EndIf

	If Not FileExists($sPath) Then Return SetError(1, 0, '')

	$sFilter = StringRegExpReplace($sFilter, "\s*;\s*", "|")
	If ($sFilter = Default) Or ($sFilter = -1) Or StringInStr("|" & $sFilter & "|", "|*.*|") Or StringInStr("|" & $sFilter & "|", "||") Then
		$sFilter = '(?i).*'
	Else
		If $methody = 0 Then ;$methody = 0 - "simple"
			$sFilter = StringReplace($sFilter, '*', '\E*\Q')
			$sFilter = StringReplace($sFilter, '?', '\E?\Q')
			$sFilter = StringReplace($sFilter, '.', '\E*[.]*\Q')
			$sFilter = StringReplace($sFilter, '|', '\E*|*\Q')
			$sFilter = '\Q' & $sFilter & '\E'
			$sFilter = StringReplace($sFilter, '\Q\E', '')
			$sFilter = StringReplace($sFilter, '*', '.*')
			$sFilter = StringReplace($sFilter, '?', '.?')
			$sFilter = '(?i).*' & $sFilter & '.*'
			$sFilter = StringRegExpReplace($sFilter, '([.][*]){2,}', '.*')
		Else ;$methody = 1 - "is full pattern"
			$sFilter = StringReplace($sFilter, '*', '\E*\Q')
			$sFilter = StringReplace($sFilter, '?', '\E?\Q')
			$sFilter = StringReplace($sFilter, '.', '\E[.]\Q')
			$sFilter = StringReplace($sFilter, '|', '\E|\Q')
			$sFilter = '\Q' & $sFilter & '\E'
			$sFilter = StringReplace($sFilter, '\Q\E', '')
			$sFilter = StringReplace($sFilter, '*', '.*')
			$sFilter = StringReplace($sFilter, '?', '.?')
			$sFilter = '(?i)' & $sFilter
			$sFilter = StringRegExpReplace($sFilter, '([.][*]){2,}', '.*')
		EndIf
	EndIf
	;ConsoleWrite($sFilter & @CRLF)

	While 1
		$hSearch = FileFindFirstFile($sPath & '*')
		If Not @error Then
			While 1
				$sFile = FileFindNextFile($hSearch)
				If @error Then ExitLoop
				$extended = @extended
				$HowManyFiles += 1
				If $extended = 1 Then ;folder
					;If $Accept_Attribute Or $NO_Accept_Attribute Then
					;$attrib = FileGetAttrib($sPath & $sFile & '\')
					;$is_ok = True
					;If $Accept_Attribute Then ; test atrybutow - akceptowane
					;For $c = 0 To UBound($a_Attribute) - 1
					;If Not StringInStr($attrib, $a_Attribute[$c]) Then $is_ok = False
					;Next
					;EndIf
					;If $NO_Accept_Attribute Then ; test atrybutow - nie akceptowane
					;For $c = 0 To UBound($NO_a_Attribute) - 1
					;If StringInStr($attrib, $NO_a_Attribute[$c]) Then $is_ok = False
					;Next
					;EndIf
					;If $is_ok = False Then ContinueLoop
					;EndIf
					If Not $LevelTooDown Then
						$newFoldersSearch &= $sPath & $sFile & '\' & $sDelim ;nowe foldery do szukania
					Else
						StringReplace($sPath & $sFile, '\', '\')
						$lev = @extended - $levPath
						If $LevelTooDown >= $lev Then
							$newFoldersSearch &= $sPath & $sFile & '\' & $sDelim
						EndIf
					EndIf
				EndIf
				If ($iFlag + $extended = 2) Then ContinueLoop

				$is_ok = Not StringRegExpReplace($sFile, $sFilter, '') ; test pattern

				If ($Accept_Attribute Or $NO_Accept_Attribute) And $is_ok Then ;test atrybutow
					$attrib = FileGetAttrib($sPath & $sFile)
					If $Accept_Attribute Then ; test atrybutow - akceptowane
						For $c = 0 To UBound($a_Attribute) - 1
							If Not StringInStr($attrib, $a_Attribute[$c]) Then $is_ok = False
						Next
					EndIf
					If $NO_Accept_Attribute Then ; test atrybutow - nie akceptowane
						For $c = 0 To UBound($NO_a_Attribute) - 1
							If StringInStr($attrib, $NO_a_Attribute[$c]) Then $is_ok = False
						Next
					EndIf
				EndIf

				If ($size_min Or $size_max) And $is_ok Then ; test size
					$FileSize = Round(FileGetSize($sPath & $sFile) / 1048576, 2) ; size = MB
					If $size_min And $size_min > $FileSize Then $is_ok = False
					If $size_max And $size_max < $FileSize Then $is_ok = False
				EndIf

				If $full_adress And $is_ok Then
					$sFileList &= $sDelim & $sPath & $sFile
				ElseIf Not $full_adress And $is_ok Then
					$sFileList &= $sDelim & $sFile
				EndIf

			WEnd
		EndIf
		FileClose($hSearch)
		$foldery = $newFoldersSearch & $foldery
		$newFoldersSearch = ''
		$array_foldery = StringSplit($foldery, $sDelim, 3)
		If UBound($array_foldery) <= 1 Then ExitLoop
		$foldery = StringTrimLeft($foldery, StringInStr($foldery, $sDelim))
		$sPath = $array_foldery[0]
	WEnd
	If Not $sFileList Then Return SetError(2, $HowManyFiles, "")

	$aReturn = StringSplit(StringTrimLeft($sFileList, 1), $sDelim)
	$sFileList = 0
	SetExtended($HowManyFiles)
	Return $aReturn
EndFunc   ;==>myFileListToArray_AllFiles



;##############################################################
;					version 2 (only 4 parameters)
;##############################################################

Func myFileListToArray_AllFilesEx($sPath, $sFilter = "*.*", $iFlag = 1, $full_adress = 1)

	Local $hSearch, $sFile, $sFileList, $sDelim = "|", $HowManyFiles = 0, $aReturn
	$sPath = StringRegExpReplace($sPath, "[\\/]+\z", "") & "\" ; ensure single trailing backslash
	Local $is_ok, $foldery = '', $newFoldersSearch = '', $array_foldery, $extended

	$iFlag = Number($iFlag)
	$full_adress = Number($full_adress)
	If $full_adress <> 0 Then $full_adress = 1

	If Not FileExists($sPath) Then Return SetError(1, 0, '')

	$sFilter = StringRegExpReplace($sFilter, "\s*;\s*", "|")
	If ($sFilter = Default) Or ($sFilter = -1) Or StringInStr("|" & $sFilter & "|", "|*.*|") Or StringInStr("|" & $sFilter & "|", "||") Then
		$sFilter = '(?i).*'
	Else
		$sFilter = StringReplace($sFilter, '*', '\E*\Q')
		$sFilter = StringReplace($sFilter, '?', '\E?\Q')
		$sFilter = StringReplace($sFilter, '.', '\E[.]\Q')
		$sFilter = StringReplace($sFilter, '|', '\E|\Q')
		$sFilter = '\Q' & $sFilter & '\E'
		$sFilter = StringReplace($sFilter, '\Q\E', '')
		$sFilter = StringReplace($sFilter, '*', '.*')
		$sFilter = StringReplace($sFilter, '?', '.?')
		$sFilter = '(?i)' & $sFilter
		$sFilter = StringRegExpReplace($sFilter, '([.][*]){2,}', '.*')
	EndIf
	;ConsoleWrite($sFilter &@CRLF)

	While 1
		$hSearch = FileFindFirstFile($sPath & '*')
		If Not @error Then
			While 1
				$sFile = FileFindNextFile($hSearch)
				If @error Then ExitLoop
				$extended = @extended
				$HowManyFiles += 1
				If $extended = 1 Then ;folder
					$newFoldersSearch &= $sPath & $sFile & '\' & $sDelim ;nowe foldery do szukania
				EndIf
				If ($iFlag + $extended = 2) Then ContinueLoop

				$is_ok = Not StringRegExpReplace($sFile, $sFilter, '') ; test pattern

				If $full_adress And $is_ok Then
					$sFileList &= $sDelim & $sPath & $sFile
				ElseIf Not $full_adress And $is_ok Then
					$sFileList &= $sDelim & $sFile
				EndIf

			WEnd
		EndIf
		FileClose($hSearch)
		$foldery = $newFoldersSearch & $foldery
		$newFoldersSearch = ''
		$array_foldery = StringSplit($foldery, $sDelim, 3)
		If UBound($array_foldery) <= 1 Then ExitLoop
		$foldery = StringTrimLeft($foldery, StringInStr($foldery, $sDelim))
		$sPath = $array_foldery[0]
	WEnd
	If Not $sFileList Then Return SetError(2, $HowManyFiles, "")

	$aReturn = StringSplit(StringTrimLeft($sFileList, 1), $sDelim)
	$sFileList = 0
	SetExtended($HowManyFiles)
	Return $aReturn
EndFunc   ;==>myFileListToArray_AllFilesEx

#endregion 'myFileListToArray_AllFiles.au3'

