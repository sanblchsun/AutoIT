#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=FTP Easy-UP.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=Easily upload your files in one click !
#AutoIt3Wrapper_Res_Description=FTP Easy-UP
#AutoIt3Wrapper_Res_Fileversion=0.0.0.3
#AutoIt3Wrapper_Res_LegalCopyright=d3monCorp. All rights reserved.
#Obfuscator_Parameters=/striponly
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

	AutoIt Version: 3.3.4.0
	Author:         FireFox

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <GUITreeView.au3>
#include <INet.au3>
#include <String.au3>
#include <FTP_Ex.au3>
#include <Misc.au3>
#include <Sound.au3>

Opt("GUIOnEventMode", 1)

FileInstall("progress.bmp", @TempDir & "\progress.bmp", 1)
FileInstall("done.wav", @TempDir & "\done.wav", 1)

Dim $s_cfg = @TempDir & "\FTP Easy-UP.cfg"

#Region GUI
$GUI = GUICreate("FTP Easy-UP | Settings", 300, 421)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit", $GUI)

GUICtrlCreateGroup("Connection", 5, 5, 290, 145)

GUICtrlCreateLabel("*Server or Url :", 15, 30, 80)
GUICtrlSetFont(-1, 9, 400, 4)
$tb_serv = GUICtrlCreateInput("", 100, 25, 185, 20, $ES_AUTOHSCROLL)

GUICtrlCreateLabel("*User Name :", 15, 60, 75)
GUICtrlSetFont(-1, 9, 400, 4)
$tb_user = GUICtrlCreateInput("", 100, 55, 185, 20, $ES_AUTOHSCROLL)

GUICtrlCreateLabel("*Password :", 15, 90, 75)
GUICtrlSetFont(-1, 9, 400, 4)
$tb_pass = GUICtrlCreateInput("", 100, 85, 185, 20, $ES_AUTOHSCROLL + $ES_PASSWORD)

GUICtrlCreateButton("Check Connection", 99, 118, 110, 22)
GUICtrlSetOnEvent(-1, "_Settings_Connection")


GUICtrlCreateGroup("Configuration", 5, 160, 290, 218)

GUICtrlCreateLabel("*Default upload folder :", 15, 180, 270)
GUICtrlSetFont(-1, 9, 400, 4)

$tb_def = GUICtrlCreateEdit("", 15, 197, 275, 20, $ES_AUTOHSCROLL)
GUICtrlSetTip($tb_def, 'i.e "/www/myfolder/subfolder/" (must include root folder)')

GUICtrlCreateLabel('Url of the page "listdirs.php" :', 15, 230, 170)
GUICtrlSetFont(-1, 9, 400, 4)

$tb_url = GUICtrlCreateEdit("", 15, 247, 275, 20, $ES_AUTOHSCROLL)

GUICtrlCreateLabel("more infos...", 190, 231, 70, 15)
GUICtrlSetOnEvent(-1, "_ListDirsInfos")
GUICtrlSetCursor(-1, 0)
GUICtrlSetColor(-1, 0x0000FF)
GUICtrlSetFont(-1, 8.5, 400, 4)

GUICtrlCreateLabel('Root folder :', 15, 280, 70)
GUICtrlSetFont(-1, 9, 400, 4)

$tb_root = GUICtrlCreateEdit("", 15, 297, 275, 20, $ES_AUTOHSCROLL)
GUICtrlSetTip($tb_root, 'Enter the root folder if it''s not visible in the url (i.e "/www/")')

$cb_clip = GUICtrlCreateCheckbox("Copy download link of uploaded file to clipboard", 15, 330)

$cb_sound = GUICtrlCreateCheckbox("Play an advert sound when the upload is finished", 15, 350)

GUICtrlCreateButton("Save Settings", 99, 390, 110, 22)
GUICtrlSetOnEvent(-1, "_Settings_Save")
#EndRegion GUI


#Region GUI_2
$GUI_2 = GUICreate("FTP Easy-UP", 300, 320)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit", $GUI_2)

GUICtrlCreateLabel("Selected file :", 5, 5, 150)
GUICtrlSetFont(-1, 9, 400, 4)

$tb_file = GUICtrlCreateEdit("", 5, 22, 290, 20, $ES_AUTOHSCROLL + $ES_READONLY)

GUICtrlCreateLabel("Select the remote directory to upload it :", 5, 55, 220)
GUICtrlSetFont(-1, 9, 400, 4)

$tv_dirs = GUICtrlCreateTreeView(5, 75, 290, 200)
GUICtrlSetBkColor($tv_dirs, 0xF0F0F0)

GUICtrlCreateButton("Upload !", 90, 290, 120, 22)
GUICtrlSetOnEvent(-1, "_TreeView_Upload")
#EndRegion GUI_2


#Region GUI_3
Dim $f_wgp = WinGetPos("[CLASS:Shell_TrayWnd]")

$GUI_3 = GUICreate("FTP Easy-UP | Uploading", 300, 50, @DesktopWidth - 320, @DesktopHeight - $f_wgp[3] - 90)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit", $GUI_3)

GUICtrlCreateLabel("File :", 5, 5, 30)
GUICtrlSetFont(-1, 10)

$l_file = GUICtrlCreateEdit("", 45, 3, 250, 20, $ES_AUTOHSCROLL + $ES_READONLY)
GUICtrlSetFont(-1, 10)

GUICtrlCreateProgress(5, 25, 290, 20)
$p_percent = GUICtrlCreatePic(@TempDir & "\progress.bmp", 6, 26, 0, 18)
#EndRegion GUI_3


If @Compiled And $CmdLine[0] Then
	If StringInStr($CmdLine[1], '/cm-Create') Then
		RegWrite("HKEY_CLASSES_ROOT\*\shell") ;Create ContextMenu for files
		RegWrite("HKEY_CLASSES_ROOT\*\shell\FTP Easy-UP")
		RegWrite("HKEY_CLASSES_ROOT\*\shell\FTP Easy-UP\command")
		RegWrite("HKEY_CLASSES_ROOT\*\shell\FTP Easy-UP\command", "", "REG_SZ", @ScriptFullPath & " %1")
		_Exit()
	ElseIf StringInStr($CmdLine[1], '/cm-Remove') Then
		RegDelete("HKEY_CLASSES_ROOT\AllFilesystemObjects\shell\FTP Easy-UP")
		_Exit()
	ElseIf StringInStr($CmdLine[1], '/Settings') Then
		_Settings_Show()
	Else ;file
		_FTP_UploadFile(FileGetLongName($CmdLine[1]))
	EndIf
ElseIf Not @Compiled Then
	_Settings_Show()
Else
	_Exit()
EndIf

While Sleep(1000)

WEnd


Func _FTP_UploadFile($s_file)
	Local $s_save = _StringEncrypt(0, FileRead($s_cfg), "d3monCorp", 3)
	Local $a_save = StringSplit($s_save, @CRLF)

	If Not IsArray($a_save) Or Not (UBound($a_save) = 16) Then Return GUISetState(@SW_SHOW, $GUI)

	If _IsPressed("11") Then
		GUICtrlSetData($tb_file, $s_file)
		_FTP_RecursivelyListDirsToTreeView($tv_dirs, $a_save[9])
		_GUICtrlTreeView_SetFocused($tv_dirs, _GUICtrlTreeView_GetFirstItem($tv_dirs))
		GUISetState(@SW_SHOW, $GUI_2)
	Else
		Local $s_filename = StringTrimLeft($s_file, StringInStr($s_file, "\", 0, -1))
		GUICtrlSetData($l_file, $a_save[7] & $s_filename)
		GUISetState(@SW_SHOW, $GUI_3)

		$Open = _FTPOpen('MyFTP Control')
		$Conn = _FTPConnect($Open, $a_save[1], $a_save[3], $a_save[5])

		_FTP_UploadProgress($Conn, $s_file, $a_save[7] & $s_filename, "_Progress_Update")
		_FTPClose($Open)

		If ($a_save[13] = 1) Then
			Local $s_basefolder = StringLeft($a_save[9], StringInStr($a_save[9], "/", 0, -2))
			ClipPut(StringReplace($s_basefolder & StringReplace($a_save[7], $a_save[11], "") & $s_filename, " ", "%20"))
		EndIf

		If ($a_save[15] = 1) Then _SoundPlay(@TempDir & "\done.wav", 1)
		_Exit()
	EndIf
EndFunc   ;==>_FTP_UploadFile

Func _Settings_Save()
	Local $r_tbserv = GUICtrlRead($tb_serv), $r_tbuser = GUICtrlRead($tb_user), $r_tbpass = GUICtrlRead($tb_pass)
	Local $r_tbdef = GUICtrlRead($tb_def), $r_tburl = GUICtrlRead($tb_url), $r_tbroot = GUICtrlRead($tb_root)
	Local $r_cbclip = GUICtrlRead($cb_clip), $r_cbsound = GUICtrlRead($cb_sound)

	If ($r_tbserv = "") Or ($r_tbuser = "") Or ($r_tbpass = "") Or ($r_tbdef = "") Then
		Return MsgBox(48, "FTP Easy-UP", "One or more mandatory fields are not filled !")
	EndIf

	_FileClear($s_cfg)
	Local $s_save = $r_tbserv & _
			@CRLF & $r_tbuser & _
			@CRLF & $r_tbpass & _
			@CRLF & $r_tbdef & _
			@CRLF & $r_tburl & _
			@CRLF & $r_tbroot & _
			@CRLF & $r_cbclip & _
			@CRLF & $r_cbsound

	FileWrite($s_cfg, _StringEncrypt(1, $s_save, "d3monCorp", 3))
	_Exit()
EndFunc   ;==>_Settings_Save

Func _Settings_Show()
	Local $s_save = _StringEncrypt(0, FileRead($s_cfg), "d3monCorp", 3)
	Local $a_save = StringSplit($s_save, @CRLF)

	If IsArray($a_save) And (UBound($a_save) = 16) Then
		GUICtrlSetData($tb_serv, $a_save[1])
		GUICtrlSetData($tb_user, $a_save[3])
		GUICtrlSetData($tb_pass, $a_save[5])
		GUICtrlSetData($tb_def, $a_save[7])
		GUICtrlSetData($tb_url, $a_save[9])
		GUICtrlSetData($tb_root, $a_save[11])
		GUICtrlSetState($cb_clip, $a_save[13])
		GUICtrlSetState($cb_sound, $a_save[15])
	EndIf
	GUISetState(@SW_SHOW, $GUI)
EndFunc   ;==>_Settings_Show

Func _Settings_Connection()
	$Open = _FTPOpen('MyFTP Control')
	$Conn = _FTPConnect($Open, GUICtrlRead($tb_serv), GUICtrlRead($tb_user), GUICtrlRead($tb_pass))

	If ($Conn <> 0) Then
		MsgBox(64, "FTP Easy-UP", "Connection successfull !")
	Else
		MsgBox(48, "FTP Easy-UP", "Connection error !")
	EndIf

	_FTPClose($Open)
EndFunc   ;==>_Settings_Connection

Func _ListDirsInfos()
	$f_msg = MsgBox(65, "FTP Easy-UP", 'In order to recursively list directories on your FTP, you must have the page "listdirs.php" installed on it (only if you want to use this functionality)' & _
			@CRLF & @CRLF & 'Example for this field : "http://example.com/listdirs.php?pw=FTP_Easy-UP"' & _
			@CRLF & @CRLF & 'Click "OK" to download the page or "Cancel" to ignore.')

	If ($f_msg = 1) Then
		InetGet("http://sarlprorebat.com/listdirs.txt", "listdirs.php")
		MsgBox(64, "FTP Easy-UP", 'The page "listdirs.php" has been successfully downloaded !')
	EndIf
EndFunc   ;==>_ListDirsInfos

Func _FileClear($s_file)
	$hOpen = FileOpen($s_file, 2)
	FileClose($hOpen)
EndFunc   ;==>_FileClear

Func _TreeView_Upload()
	Local $s_save = _StringEncrypt(0, FileRead($s_cfg), "d3monCorp", 3)
	Local $a_save = StringSplit($s_save, @CRLF)

	Local $s_path = GUICtrlRead($tv_dirs, 1), $h_Prev = _GUICtrlTreeView_GetItemHandle($tv_dirs, GUICtrlRead($tv_dirs))
	Local $s_firstitem = _GUICtrlTreeView_GetText($tv_dirs, _GUICtrlTreeView_GetFirstItem($tv_dirs)), $s_itemtext

	While $s_itemtext <> $s_firstitem
		$h_Prev = _GUICtrlTreeView_GetPrev($tv_dirs, $h_Prev)
		$s_itemtext = _GUICtrlTreeView_GetText($tv_dirs, $h_Prev)
		$s_path = $s_itemtext & "/" & $s_path
	WEnd

	$s_path = StringReplace($s_path, "//", "/")
	GUISetState(@SW_HIDE, $GUI_2)

	Local $s_file = GUICtrlRead($tb_file), $s_filename = StringTrimLeft($s_file, StringInStr($s_file, "\", 0, -1))

	GUICtrlSetData($l_file, $s_path & "/" & $s_filename)
	GUISetState(@SW_SHOW, $GUI_3)


	$Open = _FTPOpen('MyFTP Control')
	$Conn = _FTPConnect($Open, $a_save[1], $a_save[3], $a_save[5])

	_FTP_UploadProgress($Conn, $s_file, $a_save[11] & $s_path & "/" & $s_filename, "_Progress_Update")

	_FTPClose($Open)

	If ($a_save[13] = 1) Then
		Local $s_basefolder = StringLeft($a_save[9], StringInStr($a_save[9], "/", 0, -2))
		ClipPut(StringReplace($s_basefolder & StringReplace($a_save[7], $a_save[11], "") & $s_filename, " ", "%20"))
	EndIf

	If ($a_save[15] = 1) Then _SoundPlay(@TempDir & "\done.wav", 1)
	_Exit()
EndFunc   ;==>_TreeView_Upload


Func _Progress_Update($i_percent)
	WinSetTitle($GUI_3, "", "FTP Easy-UP | Uploading : " & $i_percent & "%")

	GUICtrlSetPos($p_percent, 6, 26, $i_percent * 2.88, 18)

	Return 1
Endfunc

Func _Exit()
	FileDelete(@TempDir & "\done.wav")
	FileDelete(@TempDir & "\progress.bmp")
	Exit
EndFunc   ;==>_EXIT


; #FUNCTION# ====================================================================================================================
; Name...........: _FTP_RecursivelyListDirsToTreeView
; Description ...: Recursively list FTP dirs to TreeView
; Parameters ....: $h_TreeView	- Handle of the TreeView to list dirs
;				   $s_Url		- Url of the page "listdirs.php" including get contents
; Return values .: On Success - 1
;                  On Failure - -1
; Author ........: FireFox
; Remarks .......: "listdirs.php" available at : http://sarlprorebat.com/listdirs.txt
; ===============================================================================================================================
Func _FTP_RecursivelyListDirsToTreeView($h_TreeView, $s_Url)
	Local $s_php, $a_hrefname, $s_CurrentDir

	$s_php = StringTrimLeft(_INetGetSource($s_Url), 216)

	$a_hrefname = _StringBetween($s_php, '<a href="', "</a>")
	If Not IsArray($a_hrefname) Then Return -1

	Local $a_href[UBound($a_hrefname)], $a_name[UBound($a_hrefname)], $tv_item[UBound($a_hrefname)]

	For $i = 0 To UBound($a_hrefname) - 1
		$a_name[$i] = StringTrimLeft($a_hrefname[$i], StringInStr($a_hrefname[$i], '">') + 1)
		$a_href[$i] = StringLeft($a_hrefname[$i], StringInStr($a_hrefname[$i], '">') - 1)
	Next

	$s_CurrentDir = StringTrimLeft($s_Url, StringInStr($s_Url, "/", 0, -2) - 1)
	$s_CurrentDir = StringLeft($s_CurrentDir, StringInStr($s_CurrentDir, "/", 0, -1))

	$tv_item[0] = GUICtrlCreateTreeViewItem($s_CurrentDir, $h_TreeView)

	For $i = 1 To UBound($a_hrefname) - 1
		If (StringLeft($a_href[$i], StringLen($a_href[$i - 1])) = $a_href[$i - 1]) Then
			$tv_item[$i] = GUICtrlCreateTreeViewItem($a_name[$i], $tv_item[$i - 1])
		Else
			Local $bl_found = False

			For $i_prev = ($i - 1) To 1 Step -1
				If (StringLeft($a_href[$i], StringLen($a_href[$i_prev])) = $a_href[$i_prev]) Then
					$tv_item[$i] = GUICtrlCreateTreeViewItem($a_name[$i], $tv_item[$i_prev])
					$bl_found = True
					ExitLoop
				EndIf
			Next

			If $bl_found = False Then
				$tv_item[$i] = GUICtrlCreateTreeViewItem($a_name[$i], $tv_item[0])
			EndIf
		EndIf
	Next

	Return 1
EndFunc   ;==>_FTP_RecursivelyListDirsToTreeView
