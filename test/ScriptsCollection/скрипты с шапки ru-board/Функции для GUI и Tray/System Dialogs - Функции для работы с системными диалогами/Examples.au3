#include <System_Dialogs.au3>
;

$hGUI_Parent = GUICreate("System_Dialogs_UDFs Demo GUI", 450, 100)

$MsgBox_Button = GUICtrlCreateButton("Message Box", 10, 20, 100)
$FileOpen_Button = GUICtrlCreateButton("File Open", 120, 20, 100)
$FileSave_Button = GUICtrlCreateButton("File Save", 230, 20, 100)
$SelectFolder_Button = GUICtrlCreateButton("Select Folder...", 340, 20, 100)

$OpenDialog_Button = GUICtrlCreateButton("Open Dialog (for *.lnk)", 10, 55, 120)
$PickIcon_Button = GUICtrlCreateButton("Pick Icon", 140, 55, 80)

GUISetState()

While 1
	Switch GUIGetMsg()
		Case $GUI_EVENT_CLOSE
			Exit
		Case $MsgBox_Button
			$sAsk = _MsgBox(36, "Title", "Message Text", $hGUI_Parent)
			If $sAsk = 6 Then MsgBox(0, "", $sAsk)
		Case $FileOpen_Button
			$sFileOpen = _FileOpenDialog("Open File", @ScriptDir, _
				"All (*.*)|*.*|Documents (*.DOC)|*.doc", 0, "File Name", "doc", 2, $hGUI_Parent)
			If Not @error Then _MsgBox(64, "Info", "Selected file:" & @CRLF & $sFileOpen, $hGUI_Parent)
		Case $FileSave_Button
			$sFileSave = _FileSaveDialog("Save as", "", _
				'Au3 Scripts (*.au3)|*.au3|All (*.*)|*.*', 0, "", "au3", 1, $hGUI_Parent)
			If Not @error Then _MsgBox(64, "Info", "Selected file:" & @CRLF & $sFileSave, $hGUI_Parent)
		Case $SelectFolder_Button
			;Basic example...
			$sFSF_Files_Filter = "" ;To erase the filter
			
			$sSelectFolder = _FileSelectFolder('Here the prompt', 0, _
				BitOR($BIF_NEWDIALOGSTYLE, $BIF_RETURNONLYFSDIRS), @HomeDrive, $hGUI_Parent)
			
			If Not @error Then _MsgBox(64, "Info", "Selected Folder:" & @CRLF & $sSelectFolder, $hGUI_Parent)
			
			;Advanced example (able to select only folder that includes specific files)...
			$sFSF_Files_Filter = "*.txt|*.doc"
			
			$sSelectFolder = _FileSelectFolder('Select folder that includes theese files: ' & $sFSF_Files_Filter, 0, _
				BitOR($BIF_NEWDIALOGSTYLE, $BIF_RETURNONLYFSDIRS))
			
			If Not @error Then _MsgBox(64, "Info", "Selected Folder:" & @CRLF & $sSelectFolder, $hGUI_Parent)
		Case $OpenDialog_Button
			Local $sFlags = BitOR($cdlOFNExplorer, $cdlOFNFileMustExist, $cdlOFNLongNames, _
				$cdlOFNPathMustExist, $cdlOFNNoChangeDir, $CdlOFNNoDereferenceLinks)
			Local $Init_Dir = @AppDataDir & "\Microsoft\Internet Explorer\Quick Launch"
			
			$sFileOpen = _FileDialog("Open File", $Init_Dir, "", "Shortcuts (*.lnk)|*.lnk", 1, $sFlags, 0)
			If Not @error Then _MsgBox(64, "Info", "Selected file:" & @CRLF & $sFileOpen, $hGUI_Parent)
		Case $PickIcon_Button
			$sIconFileName  = @SystemDir & "\User32.dll"
			
			$aRet = _PickIconDlg($sIconFileName, 1, $hGUI_Parent)
			
			If Not @error Then
				$sIconFileName = $aRet[0]
				$nIconFileIndex = $aRet[1]
				
				_MsgBox(64, "Info", "Selected file:" & @CRLF & $sIconFileName & @CRLF & @CRLF & _
					"Icon-Index:" & @CRLF & $nIconFileIndex, $hGUI_Parent)
			EndIf
	EndSwitch
WEnd
