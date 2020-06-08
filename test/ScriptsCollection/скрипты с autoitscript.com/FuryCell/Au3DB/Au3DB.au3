#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseX64=n
#AutoIt3Wrapper_Res_Comment=Au3DB
#AutoIt3Wrapper_Res_Description=Au3DB
#AutoIt3Wrapper_Res_Fileversion=0.5.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Michael Michta
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_Icon_Add=Script.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#NoAutoIt3Execute
Opt("GUIOnEventMode", 1)
Global Const $Const_Version="0.5"
Global $Opt_StorageDir = IniRead("Au3DB.ini", "Settings", "StorageDir",".\Data")
FileChangeDir(@ScriptDir)

If Not FileExists($Opt_StorageDir) Then DirCreate($Opt_StorageDir)
If Not _IsDir($Opt_StorageDir) Then
	MsgBox(0, "Au3DB:Error", "Failed to create the following directory:" & @CRLF & @CRLF & $Opt_StorageDir)
	Exit
EndIf

;Declare global variables
Global $G_CurrentFile = "", $G_CMenuArray, $G_FileText,$FormMain,$TreeView,$SciControl



;Include required files
#include <Array.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIMenu.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>
#include <File.au3>
#include <GUITreeView.au3>
#include <ButtonConstants.au3>

#include "_SciLexer\_SciLexer.au3"
#include "__Functions.au3"
#include "__Events.au3"

;Create GUI
$FormMain = GUICreate("Au3DB", 795, 438)
$MIFile = GUICtrlCreateMenu("&File")
$MISave = GUICtrlCreateMenuItem("&Save", $MIFile)
$MIExit = GUICtrlCreateMenuItem("&Exit", $MIFile)
$MIOptions = GUICtrlCreateMenu("&Options")
$MIChangeStore = GUICtrlCreateMenuItem("Change storage location", $MIOptions)
$MIDefaultStore = GUICtrlCreateMenuItem("Restore default storage location", $MIOptions)
$MIHelp = GUICtrlCreateMenu("&Help")
$MIAbout = GUICtrlCreateMenuItem("About...", $MIHelp)
$TreeView = GUICtrlCreateTreeView(8, 0, 169, 417)
$TVContext = GUICtrlCreateContextMenu($TreeView)
$MINewCategory=GUICtrlCreateMenuItem("New Category...", $TVContext)
$SciControl = Sci_CreateEditor($FormMain, 180, 0, 610, 417)

;Disable Scintilla control
ControlDisable($FormMain, "", $SciControl)
GUICtrlSetData(-1, "")

;Set up event handlers
GUISetOnEvent($GUI_EVENT_CLOSE, "GUI_EVENT_CLOSE")
GUICtrlSetOnEvent($MISave, "GUI_Event_Save")
GUICtrlSetOnEvent($MIExit, "GUI_EVENT_CLOSE")
GUICtrlSetOnEvent($MINewCategory, "GUI_Event_NewCategory")
GUICtrlSetOnEvent($MIChangeStore,"GUI_Event_ChangeStore")
GUICtrlSetOnEvent($MIDefaultStore, "GUI_Event_DefaultStore")
GUICtrlSetOnEvent($MIAbout, "GUI_Event_About")
GUISetState()

;Populate treeview
PopulateTree()

;Main loop
While 1
	Sleep(100)
WEnd