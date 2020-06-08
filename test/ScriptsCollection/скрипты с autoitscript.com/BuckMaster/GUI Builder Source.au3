#region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=Icons\NewIcon.ico
#AutoIt3Wrapper_Res_Description=GUI Builder beta
#AutoIt3Wrapper_Res_Fileversion=1.0
#AutoIt3Wrapper_Res_LegalCopyright=© Cameron Wilson 2012. All Rights reserved.
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Res_File_Add=Images\AlignBottom.bmp, rt_bitmap, Align_Bottom
#AutoIt3Wrapper_Res_File_Add=Images\AlignCenterHoriz.bmp, rt_bitmap, Align_CenterHoriz
#AutoIt3Wrapper_Res_File_Add=Images\AlignCenterVert.bmp, rt_bitmap, Align_CenterVert
#AutoIt3Wrapper_Res_File_Add=Images\AlignLeft.bmp, rt_bitmap, Align_Left
#AutoIt3Wrapper_Res_File_Add=Images\AlignRight.bmp, rt_bitmap, Align_Right
#AutoIt3Wrapper_Res_File_Add=Images\AlignTop.bmp, rt_bitmap, Align_Top
#AutoIt3Wrapper_Res_File_Add=Images\SpaceHeight.bmp, rt_bitmap, Space_Height
#AutoIt3Wrapper_Res_File_Add=Images\SpaceHeightCenter.bmp, rt_bitmap, Space_HeightCenter
#AutoIt3Wrapper_Res_File_Add=Images\SpaceLeft.bmp, rt_bitmap, Space_Left
#AutoIt3Wrapper_Res_File_Add=Images\SpaceWidth.bmp, rt_bitmap, Space_Width
#AutoIt3Wrapper_Res_File_Add=Images\SpaceWidthCenter.bmp, rt_bitmap, Space_WidthCenter
#AutoIt3Wrapper_Res_File_Add=Images\ResizeAuto.bmp, rt_bitmap, Resize_Auto
#AutoIt3Wrapper_Res_File_Add=Images\ResizeAuto_Disable.bmp, rt_bitmap, Resize_Auto_Disable
#AutoIt3Wrapper_Res_File_Add=Images\ResizeAuto_Selected.bmp, rt_bitmap, Resize_Auto_Selected
#AutoIt3Wrapper_Res_File_Add=Images\ResizeBottom.bmp, rt_bitmap, Resize_Bottom
#AutoIt3Wrapper_Res_File_Add=Images\ResizeBottom_Disable.bmp, rt_bitmap, Resize_Bottom_Disable
#AutoIt3Wrapper_Res_File_Add=Images\ResizeBottom_Selected.bmp, rt_bitmap, Resize_Bottom_Selected
#AutoIt3Wrapper_Res_File_Add=Images\ResizeHCenter.bmp, rt_bitmap, Resize_HCenter
#AutoIt3Wrapper_Res_File_Add=Images\ResizeHCenter_Disable.bmp, rt_bitmap, Resize_HCenter_Disable
#AutoIt3Wrapper_Res_File_Add=Images\ResizeHCenter_Selected.bmp, rt_bitmap, Resize_HCenter_Selected
#AutoIt3Wrapper_Res_File_Add=Images\ResizeLeft.bmp, rt_bitmap, Resize_Left
#AutoIt3Wrapper_Res_File_Add=Images\ResizeLeft_Disable.bmp, rt_bitmap, Resize_Left_Disable
#AutoIt3Wrapper_Res_File_Add=Images\ResizeLeft_Selected.bmp, rt_bitmap, Resize_Left_Selected
#AutoIt3Wrapper_Res_File_Add=Images\ResizeLockHeight.bmp, rt_bitmap, Resize_LockHeight
#AutoIt3Wrapper_Res_File_Add=Images\ResizeLockHeight_Disable.bmp, rt_bitmap, Resize_LockHeight_Disable
#AutoIt3Wrapper_Res_File_Add=Images\ResizeLockHeight_Selected.bmp, rt_bitmap, Resize_LockHeight_Selected
#AutoIt3Wrapper_Res_File_Add=Images\ResizeLockWidth.bmp, rt_bitmap, Resize_LockWidth
#AutoIt3Wrapper_Res_File_Add=Images\ResizeLockWidth_Disable.bmp, rt_bitmap, Resize_LockWidth_Disable
#AutoIt3Wrapper_Res_File_Add=Images\ResizeLockWidth_Selected.bmp, rt_bitmap, Resize_LockWidth_Selected
#AutoIt3Wrapper_Res_File_Add=Images\ResizeRight.bmp, rt_bitmap, Resize_Right
#AutoIt3Wrapper_Res_File_Add=Images\ResizeRight_Disable.bmp, rt_bitmap, Resize_Right_Disable
#AutoIt3Wrapper_Res_File_Add=Images\ResizeRight_Selected.bmp, rt_bitmap, Resize_Right_Selected
#AutoIt3Wrapper_Res_File_Add=Images\ResizeTop.bmp, rt_bitmap, Resize_Top
#AutoIt3Wrapper_Res_File_Add=Images\ResizeTop_Disable.bmp, rt_bitmap, Resize_Top_Disable
#AutoIt3Wrapper_Res_File_Add=Images\ResizeTop_Selected.bmp, rt_bitmap, Resize_Top_Selected
#AutoIt3Wrapper_Res_File_Add=Images\ResizeVCenter.bmp, rt_bitmap, Resize_VCenter
#AutoIt3Wrapper_Res_File_Add=Images\ResizeVCenter_Disable.bmp, rt_bitmap, Resize_VCenter_Disable
#AutoIt3Wrapper_Res_File_Add=Images\ResizeVCenter_Selected.bmp, rt_bitmap, Resize_VCenter_Selected
#AutoIt3Wrapper_Res_File_Add=Images\AutoAlign.bmp, rt_bitmap, AutoAlign
#AutoIt3Wrapper_Res_File_Add=Images\AutoAlign_Disable.bmp, rt_bitmap, AutoAlign_Disable
#AutoIt3Wrapper_Res_File_Add=Images\Grid.bmp, rt_bitmap, Grid
#AutoIt3Wrapper_Res_File_Add=Images\Grid_Disable.bmp, rt_bitmap, Grid_Disable
#AutoIt3Wrapper_Res_File_Add=Images\Up.bmp, rt_bitmap, UpArrow
#AutoIt3Wrapper_Res_File_Add=Images\Down.bmp, rt_bitmap, DownArrow
#AutoIt3Wrapper_Res_File_Add=Images\CloseBtn.bmp, rt_bitmap, CloseBtn
#AutoIt3Wrapper_Res_File_Add=Images\CloseBtn_Hover.bmp, rt_bitmap, CloseBtnHover
#AutoIt3Wrapper_Res_File_Add=Images\MenuGradient.bmp, rt_bitmap, MenuGradient
#AutoIt3Wrapper_Res_File_Add=Images\Menu_Left.bmp, rt_bitmap, Menu_Left
#AutoIt3Wrapper_Res_File_Add=Images\Menu_Middle.bmp, rt_bitmap, Menu_Middle
#AutoIt3Wrapper_Res_File_Add=Images\Menu_Right.bmp, rt_bitmap, Menu_Right
#AutoIt3Wrapper_Res_File_Add=Images\Dot.bmp, rt_bitmap, Dot
#AutoIt3Wrapper_Res_File_Add=Images\Grey.bmp, rt_bitmap, Grey
#AutoIt3Wrapper_Res_File_Add=Images\Grey_Gradient.bmp, rt_bitmap, Gradient
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=Y
#endregion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <ScrollBarConstants.au3>
#include <DateTimeConstants.au3>
#include <WindowsConstants.au3>
#include <GUIScrollbars_Ex.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiIPAddress.au3>
#include <GUIListView.au3>
#include <GuiComboBox.au3>
#include <GuiTreeView.au3>
#include <GuiRichEdit.au3>
#include <GuiComboBoxEx.au3>
#Include <IconChooser.au3>
#include <GuiListBox.au3>
#include <Constants.au3>
#include <GuiButton.au3>
#include <Resources.au3>
#include <GuiSlider.au3>
#include <GuiMenu.au3>
#include <GuiEdit.au3>
#include <GuiTab.au3>
#include <String.au3>
#include <WinAPI.au3>
#include <Array.au3>
#include <Misc.au3>
#include <Math.au3>
#include <INet.au3>
#include <RESH.au3>
#NoTrayIcon

_GDIPlus_Startup()
$dll = DllOpen("user32.dll")
Opt("MouseCoordMode", 2)
Opt("WinTitleMatchMode", 2)

#Region Declared Vars
Global $hKeyTimer = TimerInit()
Global $WritingCtrlData = '', $WritingLine, $ScriptColorScheme
Global $IncludeRange, $GUIRange, $StateRange, $WhileRange, $EndSwitchRange, $WEndRange, $LineCount
Global $hScriptTimer, $hTypeTimer, $NoErrorColor = 0x009F00, $ErrorColor = 0xFF0000, $ProblemColor = 0xFF8B10, $hDebugList, $hScriptData = ""
Global $Pi = 3.14159265359, $hHook, $hStub_KeyProc, $buffer = "", $KeyRecord, $ChildCount = 0, $AutoItDir, $WhileData = "1", $ExtraIncludeData = "", $hGDIPlusQuality = 2
Global $VersionURL = "", $CurrentVersion = "v1.0 beta"
Global $SnapLineX, $SnapLineY, $SnapLineW, $SnapLineH
Global $CurPosX = 0, $CurPosY = 0, $hSelectBoarder, $CurrentItem, $Mouse, $SelectedGraphic, $GUIFocusIndex = 0, $UndoLog = "", $UndoTemp = "", $RedoLog = "", $Debug = "False", $hDebugList
Global $GraphicX, $GraphicY, $GraphicBkColor, $GraphicCOlor, $GraphicData, $GraphicItems, $Dot, $ExtraWhileData = "", $BCount = 0, $Cursor = 2, $StartY, $hRightTop, $hRightBottom, $hLeftTop, $hLeftBottom, $NextPos
Global $SelectedTool = 0, $Count = 0, $ResizeSelect = "NULL", $StartX, $ContextGraphic, $WhileComment, $AfterComment, $MenuString, $AfterGUIData = ""
Global $BCount = 0, $Cursor = 2, $StartY, $hRightTop, $hRightBottom, $hLeftTop, $hLeftBottom, $NextPos, $ControlNum = 0, $RefNum = 0, $LastColor, $MultiStartInfo, $Dot_1, $Dot_2, $Dot_3
Global $hGUI, $gcSizingFrom, $gcSizingCoord, $ScriptData, $CopyData, $MultiHover, $ClickTimer, $ClickDiff, $GridSpace = 10, $hGrid, $SavePos = 0, $SavePosY = 0, $NextX, $SpaceAmnt = 8, $NextY, $PreviousResizeDiv, $PreviousResizeHeight, $PreviousResizeWidth
Global $SaveName, $WinTitle = "New Window", $EditWidth = 500, $EditHeight = 400, $LayerCount = 0, $DefaultFont, $aGrid, $ScriptName = "", $GUIHandle = "hGUI", $GUIBkColor, $HoverMouse = 0
Global $StartDrag, $DragL, $DragR, $DragT, $DragB, $SelectedTab = 0, $TabTop, $TabBottom, $TabLeft, $TabRight, $Variance = 0, $ControlColumn, $AlignColumn, $SpaceColumn, $LayerColumn, $BottomLine
Global $hBoarder, $hInside, $hDotBtn, $hPixelBtn, $hLineBtn, $hRectBtn, $hEllipseBtn, $hPieBtn, $hBezierBtn, $BoarderL, $BoarderR, $BoarderB, $BoarderT, $Dot, $hTopBoarder, $hBottomBoarder, $hLeftBoarder, $hRightBoarder
Global $hControlX[1] = [0], $hControlY[1] = [0], $hControlW[1] = [0], $hControlH[1] = [0], $GraphicCtrls[1] = [0], $GUISetStateData[1] = [0], $ControlIndexes[1] = [0], $hChildWins[1] = [0], $ParentGUIS[1] = [0], $GUIPlus[1] = [0], $ModeGroup[1] = [0], $GridHandles[1] = [0]
Global $GUIs[1] = [0], $GUIColors[1] = [0], $GUIVars[1] = [0], $FunctionTrees[1] = [0], $GUIScript[1] = [0], $GUIStyle[1] = [0], $GUIComment[1] = [0], $GroupItems[1] = [0], $GUIMenus[1] = [0], $GUIProperties[1] = [0], $Locked[1] = [0], $Parents[1] = [0], $GUIX[1] = [0], $GUIY[1] = [0], $GUIParent[1] = [0], $GUISnapLineX[1] = [0], $GUISnapLineY[1] = [0]
Global $Colors[1] = [0], $BkColors[1] = [0], $Data[1] = [0], $States[1] = [0], $Styles[1] = [0], $Label[1] = [0], $Input[1] = [0], $Edit[1] = [0], $Check[1] = [0], $Radio[1] = [0], $GUITrees[1] = [0], $GUIGroups[1] = [0], $GraphicTrees[1] = [0]
Global $Controls[1] = [0], $Names[1] = [0], $Slider[1] = [0], $Graphic[1] = [0], $Types[1] = [0], $SelectedControl, $ResizeTabs[1] = [0], $Font[1] = [0], $FontInfo[1] = [0], $Attributes[1] = [0], $WinTitles[1] = [0], $Functions[1] = [0], $ControlGroup1[1] = [0], $ControlGroup2[1] = [0], $ControlGroup3[1] = [0], $ControlGroup4[1] = [0]
Global $FontSize[1] = [0], $MultiControls[1] = [0], $MultiLastPositions[2] = [0, 0], $Resize[1] = [0], $TreeItems[1] = [0], $LastPositions[2] = [0, 0], $Layers[1] = [0], $Images[1] = [0], $Cursors[1] = [0], $GUIHandles[1] = [0], $Comments[1] = [0], $Used[1] = [0]
Global $Beta = True, $WritingControl = False, $ControlExpand = True, $AlignExpand = True, $SpaceExpand = True, $LayerExpand = True, $ClickTimer = False, $hCtrlClicked = False, $GraphicStarted = False, $BoarderPresent = False, $ModeHighlight = False, $SnapLinePresent = False, $SnapLinePresX = False, $SnapLinePresY = False, $SnapLinePresW = False, $SnapLinePresH = False
Global $MouseDown = False, $ResizeOn = False, $GraphicCreated = False, $Resizing = False, $Created = False, $Read = False, $MultiResizeOn = False, $Hidden = False, $Adding = False, $GridEnabled = False, $Snap = False, $MultiSelect = False, $Aligned = False, $BoarderPresent = False, $Dragging = False, $GUISelected = False
Global $AddingControl = False, $CreatingMenu = False, $GUISelected = False, $Dragging = False, $CreatingLayer = False, $AddingStyle = False, $GraphicEnabled = False, $TabEnabled = False, $ShowResizeCursor = False, $WasMax = False, $ControlCreated = False, $Snap = False, $ClickTimer = False, $Clicked = False, $MaximizeControls = False
Global $SelectColor, $GridLineColor, $ActiveColor = 0x70CFF4, $InactiveColor = 0xE0E0E0, $NotifyColor = 0xFF7533, $CornerColor = 0x000000, $SelectColor = 0x00C113, $InsertColor = 0x53D9E3, $DragColor = 0x3399FF, $ActiveColor = 0x70CFF4, $InactiveColor = 0xE0E0E0, $CornerColor = 0x000000
Global $SelectedTool = 0, $SelectedControl = 0, $GridSpace = 10, $Cursor = 2, $Variance = 0, $DefaultFont = "MS Shell Dlg", $LayerCount = 0, $NewControlLayer = "Bottom"
Global $Width = 1000, $Height = 730, $GraphicMode, $TabTop, $TabBottom, $TabLeft, $TabRight, $GUIMINWID = 1000, $GUIMINHT = 728, $CreatePos, $ResizeSelect = "NULL", $GUITab, $DragColor, $InsertColor, $EditWidth, $EditHeight
Global $Fonts = $DefaultFont & "|Arial|Arial Black|Comic Sans MS|Courier|Courier New|Estrangelo Edessa|Franklin Gothic Medium|Gautami|Georgia|Georgia Italic Impact|Impact|Latha|Lucida Console|Lucida Sans Console|Lucida Sans Unicode|Marlett|Modern|Modern MS Sans Serif|MS Sans Serif|MS Serif|MV Boli|Palatino Linotype|Roman|Segoe UI|Script|Small Fonts|Symbol|Tahoma|Times New Roman|Trebuchet|Verdana|Webdings|Wingdings"
#EndRegion
#Region hGUI
$hGUI = GUICreate("GUI Builder beta", 1000, 730, -1, -1, 0x00010000+0x00020000+0x00040000)
$HandleLabel = GUICtrlCreateLabel("Handle:", 807, 308, 45, 15, -1, -1)
$HandleInput = GUICtrlCreateInput("", 855, 304, 140, 20, -1, 512)
$XPosInput = GUICtrlCreateInput("", 875, 328, 50, 20, -1, 512)
$YPosInput = GUICtrlCreateInput("", 945, 328, 50, 20, -1, 512)
$XLabel = GUICtrlCreateLabel("X:", 861, 332, 13, 15, -1, -1)
$YLabel = GUICtrlCreateLabel("Y:", 931, 332, 13, 15, -1, -1)
$WInput = GUICtrlCreateInput("", 875, 352, 50, 20, 0x2000, 512)
$HInput = GUICtrlCreateInput("", 945, 352, 50, 20, 0x2000, 512)
$WLabel = GUICtrlCreateLabel("W:", 857, 355, 13, 15, -1, -1)
$HLabel = GUICtrlCreateLabel("H:", 930, 355, 13, 15, -1, -1)
$ColorInput = GUICtrlCreateInput("", 855, 376, 100, 20, -1, 512)
$BkColorInput = GUICtrlCreateInput("", 855, 400, 100, 20, -1, 512)
$ImageInput = GUICtrlCreateInput("", 855, 424, 100, 20, -1, 512)
$StyleInput = GUICtrlCreateInput("", 855, 448, 100, 20, -1, 512)
$DataInput = GUICtrlCreateInput("", 855, 472, 100, 20, -1, 512)
$StateInput = GUICtrlCreateCombo("", 855, 495, 140, 21, 3, -1)
GUICtrlSetData(-1, "")
$CursorInput = GUICtrlCreateCombo("", 855, 519, 140, 21, 3, -1)
GUICtrlSetData(-1, "")
$FontInput = GUICtrlCreateCombo("", 855, 543, 140, 20, 3, -1)
GUICtrlSetData(-1, "")
$PositionLabel = GUICtrlCreateLabel("Position:", 807, 332, 43, 15, -1, -1)
$ColorLabel = GUICtrlCreateLabel("Color:", 807, 380, 45, 15, -1, -1)
$BkColorLabel = GUICtrlCreateLabel("Bk Color:", 807, 404, 45, 15, -1, -1)
$ImageLabel = GUICtrlCreateLabel("Image:", 807, 428, 48, 15, -1, -1)
$StateLabel = GUICtrlCreateLabel("State:", 807, 500, 45, 15, -1, -1)
$StyleLabel = GUICtrlCreateLabel("Style:", 807, 454, 45, 15, -1, -1)
$CursorLabel = GUICtrlCreateLabel("Cursor:", 807, 524, 45, 15, -1, -1)
$DataLabel = GUICtrlCreateLabel("Data:", 807, 476, 45, 15, -1, -1)
$FontLabel = GUICtrlCreateLabel("Font:", 807, 548, 45, 15, -1, -1)
$SizeInput = GUICtrlCreateInput("", 876, 567, 30, 20, -1, 512)
$SizeLabel = GUICtrlCreateLabel("Size:", 848, 570, 24, 15, -1, -1)
$BoldButton = GUICtrlCreateButton("B", 909, 567, 20, 20, -1, -1)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$ItalicButton = GUICtrlCreateButton("i", 931, 567, 20, 20, -1, -1)
GUICtrlSetFont(-1, 10, 400, 2, "MS Serif")
$UnderlineButton = GUICtrlCreateButton("U", 953, 567, 20, 20, -1, -1)
GUICtrlSetFont(-1, 8, 400, 4, "MS Sans Serif")
$StrikeButton = GUICtrlCreateButton("ab", 975, 567, 20, 20, -1, -1)
GUICtrlSetFont(-1, 8, 400, 8, "MS Sans Serif")
$ResizingBoarder = GUICtrlCreateGroup("Resizing", 807, 587, 187, 88, -1, -1)
GUICtrlSetBkColor(-1, "0xF0F0F0")
$ResizeAuto = GUICtrlCreateButton("A", 818, 605, 28, 28, -1, -1)
$ResizeLeft = GUICtrlCreateButton("L", 852, 605, 28, 28, -1, -1)
$ResizeRight = GUICtrlCreateButton("R", 886, 605, 28, 28, -1, -1)
$ResizeTop = GUICtrlCreateButton("T", 920, 605, 28, 29, -1, -1)
$ResizeBottom = GUICtrlCreateButton("B", 954, 605, 28, 28, -1, -1)
$ResizeHC = GUICtrlCreateButton("HC", 818, 638, 28, 28, -1, -1)
$ResizeVC = GUICtrlCreateButton("VC", 852, 638, 28, 28, -1, -1)
$ResizeW = GUICtrlCreateButton("W", 886, 638, 28, 28, -1, -1)
$ResizeH = GUICtrlCreateButton("H", 920, 638, 28, 28, -1, -1)
GUICtrlSetData($CursorInput, "DEFAULT|APPSTARTING|ARROW|CROSS|HELP|IBEAM|ICON|NO|SIZE|SIZEALL|SIZENESW|SIZENS|SIZENWSE|SIZEWE|UPARROW|WAIT|HAND", "Default")
GUICtrlSetData($StateInput, "$GUI_UNCHECKED|$GUI_CHECKED|$GUI_INDETERMINATE|$GUI_AVISTART|$GUI_AVISTOP|$GUI_AVICLOSE|$GUI_DROPACCEPTED|$GUI_NODROPACCEPTED|$GUI_SHOW|$GUI_HIDE|$GUI_ENABLE|$GUI_DISABLE|$GUI_FOCUS|$GUI_NOFOCUS|$GUI_DEFBUTTON|$GUI_EXPAND|$GUI_ONTOP", "$GUI_SHOW")
$TopFill = GUICtrlCreatePic("", 0, 1, 1000, 30)
_ResourceSetImageToCtrl($TopFill, "Gradient", $RT_BITMAP)
$TopLine = GUICtrlCreateLabel("", 0, 30, 1000, 1, -1, -1)
GUICtrlSetBkColor(-1, "0xDADADA")
$RightLine = GUICtrlCreateLabel("", 150, 31, 1, 670, -1, -1)
GUICtrlSetBkColor(-1, "0xDADADA")
$cButton = GUICtrlCreateButton("", 10, 56, 30, 30, -1, -1)
$cCheckbox = GUICtrlCreateButton("", 44, 56, 30, 30, -1, -1)
$cCombo = GUICtrlCreateButton("", 78, 56, 30, 30, -1, -1)
$cDate = GUICtrlCreateButton("", 112, 56, 30, 30, -1, -1)
$cDummy = GUICtrlCreateButton("", 10, 91, 30, 30, -1, -1)
$cEdit = GUICtrlCreateButton("", 44, 91, 30, 30, -1, -1)
$cGroup = GUICtrlCreateButton("", 112, 91, 30, 30, -1, -1)
$cGraphic = GUICtrlCreateButton("", 78, 91, 30, 30, -1, -1)
$cIcon = GUICtrlCreateButton("", 10, 126, 30, 30, -1, -1)
$cInput = GUICtrlCreateButton("", 44, 126, 30, 30, -1, -1)
$cLabel = GUICtrlCreateButton("", 78, 126, 30, 30, -1, -1)
$cList = GUICtrlCreateButton("", 112, 126, 30, 30, -1, -1)
$cListView = GUICtrlCreateButton("", 10, 161, 30, 30, -1, -1)
$cMenu = GUICtrlCreateButton("", 44, 161, 30, 30, -1, -1)
$cPicture = GUICtrlCreateButton("", 78, 161, 30, 30, -1, -1)
$cProgress = GUICtrlCreateButton("", 112, 161, 30, 30, -1, -1)
$LeftLine = GUICtrlCreateLabel("", 799, 31, 1, 670, -1, -1)
GUICtrlSetBkColor(-1, "0xDADADA")
$ControlBoarder = GUICtrlCreateGroup("", 4, 28, 143, 275, -1, -1)
$BottomLine = GUICtrlCreateLabel("", 151, 522, 649, 1, -1, -1)
GUICtrlSetBkColor(-1, "0xDADADA")
$LeftLine_2 = GUICtrlCreateLabel("", 800, 299, 200, 1, -1, -1)
GUICtrlSetBkColor(-1, "0xF4F4F4")
$LeftLine_1 = GUICtrlCreateLabel("", 800, 298, 200, 1, -1, -1)
GUICtrlSetBkColor(-1, "0xC3C3C3")
$cRadio = GUICtrlCreateButton("", 10, 196, 30, 30, -1, -1)
$cUpDown = GUICtrlCreateButton("", 10, 231, 30, 30, -1, -1)
$ControlLine = GUICtrlCreateLabel("", 14, 45, 122, 1, -1, -1)
GUICtrlSetBkColor(-1, "0xB7B7B7")
$ControlLabel = GUICtrlCreateLabel("Controls", 52, 39, 48, 15, 1, -1)
$cSlider = GUICtrlCreateButton("", 44, 196, 30, 30, -1, -1)
$cTab = GUICtrlCreateButton("", 78, 196, 30, 30, -1, -1)
$cTreeView = GUICtrlCreateButton("", 112, 196, 30, 30, -1, -1)
$AlignmentBoarder = GUICtrlCreateGroup("", 4, 301, 143, 104, -1, -1)
$AlignmentLine = GUICtrlCreateLabel("", 14, 318, 122, 1, -1, -1)
GUICtrlSetBkColor(-1, "0xB7B7B7")
$AlignmentLabel = GUICtrlCreateLabel("Alignment", 48, 313, 57, 15, 1, -1)
$AlignLeft = GUICtrlCreateButton("", 10, 332, 30, 30, -1, -1)
$AlignRight = GUICtrlCreateButton("", 44, 332, 30, 30, -1, -1)
$AlignTop = GUICtrlCreateButton("", 78, 332, 30, 30, -1, -1)
$AlignBottom = GUICtrlCreateButton("", 112, 332, 30, 30, -1, -1)
$AlignCentHoriz = GUICtrlCreateButton("", 10, 366, 30, 30, -1, -1)
$AlignCentVert = GUICtrlCreateButton("", 44, 366, 30, 30, -1, -1)
$SpacingBoarder = GUICtrlCreateGroup("", 4, 404, 143, 92, -1, -1)
$SpacingLine = GUICtrlCreateLabel("", 14, 422, 122, 1, -1, -1)
GUICtrlSetBkColor(-1, "0xB7B7B7")
$SpacingLabel = GUICtrlCreateLabel("Spacing", 50, 415, 51, 15, 1, -1)
$Spacing_1 = GUICtrlCreateButton("", 10, 435, 30, 30, -1, -1)
$Spacing_2 = GUICtrlCreateButton("", 44, 435, 30, 30, -1, -1)
$Spacing_3 = GUICtrlCreateButton("", 78, 435, 30, 30, -1, -1)
$Spacing_4 = GUICtrlCreateButton("", 112, 435, 30, 30, -1, -1)
$AutoAlignButton = GUICtrlCreateButton("", 149, 1, 26, 26, -1, -1)
GUICtrlSetTip(-1, "Auto Align Controls")
$GridButton = GUICtrlCreateButton("", 178, 1, 26, 26, -1, -1)
$SnapLabel = GUICtrlCreateLabel("Snap to Grid", 227, 1, 60, 14, -1, -1)
GUICtrlSetFont(-1, 8)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
$GridLabel = GUICtrlCreateLabel("Spacing:", 211, 15, 45, 13, -1, -1)
GUICtrlSetFont(-1, 8)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
$GridSnap = GUICtrlCreateCheckbox("", 211, 2, 13, 12, -1, -1)
GUICtrlSetFont(-1, 8)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
$GridInput = GUICtrlCreateInput("10", 256, 14, 25, 14, -1, 512)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
$ColorExBack = GUICtrlCreateLabel("", 960, 376, 30, 20, -1, -1)
GUICtrlSetBkColor(-1, 0x000000)
GUICtrlSetState(-1, $GUI_DISABLE)
$ColorEx = GUICtrlCreateLabel("", 961, 377, 28, 18, -1, -1)
GUICtrlSetBkColor(-1, 0xF0F0F0)
$BkColorExBack = GUICtrlCreateLabel("", 960, 400, 30, 20, -1, -1)
GUICtrlSetBkColor(-1, 0x000000)
GUICtrlSetState(-1, $GUI_DISABLE)
$BkColorEx = GUICtrlCreateLabel("", 961, 401, 28, 18, -1, -1)
GUICtrlSetBkColor(-1, 0xF0F0F0)
$DataEx = GUICtrlCreateButton("...", 960, 472, 30, 20, -1, -1)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
$ImageEx = GUICtrlCreateButton("...", 960, 424, 30, 20, -1, -1)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
$StyleEx = GUICtrlCreateButton("...", 960, 448, 30, 20, -1, -1)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
$CopyScript = GUICtrlCreateButton("", 156, 526, 28, 28, -1, -1)
$SaveScript = GUICtrlCreateButton("", 156, 558, 28, 28, -1, -1)
$LayerBoarder = GUICtrlCreateGroup("", 4, 495, 143, 184, -1, -1)
$LayerLine = GUICtrlCreateLabel("", 14, 512, 122, 1, -1, -1)
GUICtrlSetBkColor(-1, "0xB7B7B7")
$LayerLabel = GUICtrlCreateLabel("Layering", 50, 505, 51, 15, 1, -1)
$AddLayer = GUICtrlCreateButton("+", 11, 524, 22, 22, -1, -1)
$SubLayer = GUICtrlCreateButton("-", 11, 549, 22, 22, -1, -1)
$UpLayer = GUICtrlCreateButton("Up", 11, 624, 22, 22, -1, -1)
$DownLayer = GUICtrlCreateButton("Dn", 11, 649, 22, 22, -1, -1)
$LayerList = GUICtrlCreateListView("0", 37, 524, 103, 147, -1, 512)
$PlayButton = GUICtrlCreateButton("", 3, 2, 25, 25, -1, -1)
$StopButton = GUICtrlCreateButton("", 30, 2, 25, 25, -1, -1)
$AddGUIButton = GUICtrlCreateButton("", 62, 2, 25, 25, -1, -1)
$DelGUIButton = GUICtrlCreateButton("", 89, 2, 25, 25, -1, -1)
$InsertButton = GUICtrlCreateButton("", 116, 2, 25, 25, -1, -1)
$Line_1 = GUICtrlCreateLabel("", 58, 0, 1, 30, -1, -1)
GUICtrlSetBkColor(-1, "0xD0D0D0")
$Line_2 = GUICtrlCreateLabel("", 59, 1, 1, 29, -1, -1)
GUICtrlSetBkColor(-1, "0xF4F4F4")
$Line_3 = GUICtrlCreateLabel("", 144, 0, 1, 30, -1, -1)
GUICtrlSetBkColor(-1, "0xD0D0D0")
$Line_4 = GUICtrlCreateLabel("", 145, 0, 1, 29, -1, -1)
GUICtrlSetBkColor(-1, "0xF4F4F4")
$TopLine_2 = GUICtrlCreateLabel("", 0, 29, 1000, 1, -1, -1)
GUICtrlSetBkColor(-1, "0xF4F4F4")
$Line_6 = GUICtrlCreateLabel("", 295, 0, 1, 29, -1, -1)
GUICtrlSetBkColor(-1, "0xF4F4F4")
$Line_5 = GUICtrlCreateLabel("", 294, 0, 1, 29, -1, -1)
GUICtrlSetBkColor(-1, "0xD0D0D0")
$GraphicMode = GUICtrlCreateButton("", 299, 2, 24, 24, -1, -1)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
$GroupButton = GUICtrlCreateButton("", 44, 231, 30, 30, -1, -1)
$ScrollButton = GUICtrlCreateButton("", 78, 231, 30, 30)
$RichEditButton = GUICtrlCreateButton("", 112, 231, 30, 30)
$ObjectButton = GUICtrlCreateButton("", 10, 266, 30, 30)
$GDIPlusButton = GUICtrlCreateButton("", 44, 266, 30, 30)
$DistanceLabel = GUICtrlCreateLabel("Distance:", 18, 473, 50, 15, -1, -1)
$SpaceInput = GUICtrlCreateInput("8", 73, 467, 70, 22, -1, 512)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
$GDIPlusMode = GUICtrlCreateButton("", 326, 2, 24, 24, $BS_ICON, -1)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
GUICtrlSetResizing($GDIPlusMode, 2 + 32 + 512 + 256)
GUICtrlSetImage($GDIPlusMode, @ScriptDir & "\Resources.dll", 292, 0)
$FuncMode = GUICtrlCreateButton("", 353, 2, 24, 24, -1, -1)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
$ScriptDevelopBtn = GUICtrlCreateButton("", 387, 2, 24, 24, -1, -1)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
$Line_7 = GUICtrlCreateLabel("", 382, 0, 1, 29, -1, -1)
GUICtrlSetBkColor(-1, "0xF4F4F4")
$Line_8 = GUICtrlCreateLabel("", 381, 0, 1, 29, -1, -1)
GUICtrlSetBkColor(-1, "0xD0D0D0")
$GroupControlButton = GUICtrlCreateButton("", 414, 2, 24, 24, $BS_ICON, -1)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
GUICtrlSetImage(-1, @ScriptDir & "\Resources.dll", 109, 0)
GUICtrlSetTip(-1, "Group Controls")
GUICtrlSetState(-1, $GUI_DISABLE)
$UnGroupControlButton = GUICtrlCreateButton("", 441, 2, 24, 24, $BS_ICON, -1)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
GUICtrlSetImage(-1, @ScriptDir & "\Resources.dll", 110, 0)
GUICtrlSetTip(-1, "UnGroup Controls")
GUICtrlSetState(-1, $GUI_DISABLE)
$LockControlButton = GUICtrlCreateButton("", 473, 2, 24, 24, $BS_ICON, -1)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
GUICtrlSetImage(-1, @ScriptDir & "\Resources.dll", 125, 0)
GUICtrlSetTip(-1, "Lock Control")
GUICtrlSetState(-1, $GUI_DISABLE)
$Line_9 = GUICtrlCreateLabel("", 468, 0, 1, 29, -1, -1)
GUICtrlSetBkColor(-1, "0xF4F4F4")
$Line_10 = GUICtrlCreateLabel("", 469, 0, 1, 29, -1, -1)
GUICtrlSetBkColor(-1, "0xD0D0D0")
$UndoButton = GUICtrlCreateButton("", 500, 2, 24, 24, $BS_ICON, -1)
_WinAPI_SetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle(-1), $GWL_STYLE), BitNOT($WS_TABSTOP)))
GUICtrlSetImage(-1, @ScriptDir & "\Resources.dll", 287, 0)
GUICtrlSetTip(-1, "Undo ( Ctrl + Z )")
_ArrayAdd($ControlGroup1, $cButton)
_ArrayAdd($ControlGroup1, $cCheckbox)
_ArrayAdd($ControlGroup1, $cCombo)
_ArrayAdd($ControlGroup1, $cDate)
_ArrayAdd($ControlGroup1, $cDummy)
_ArrayAdd($ControlGroup1, $cEdit)
_ArrayAdd($ControlGroup1, $cGroup)
_ArrayAdd($ControlGroup1, $cGraphic)
_ArrayAdd($ControlGroup1, $cIcon)
_ArrayAdd($ControlGroup1, $cInput)
_ArrayAdd($ControlGroup1, $cLabel)
_ArrayAdd($ControlGroup1, $cList)
_ArrayAdd($ControlGroup1, $cListView)
_ArrayAdd($ControlGroup1, $cMenu)
_ArrayAdd($ControlGroup1, $cPicture)
_ArrayAdd($ControlGroup1, $cProgress)
_ArrayAdd($ControlGroup1, $cRadio)
_ArrayAdd($ControlGroup1, $cUpDown)
_ArrayAdd($ControlGroup1, $cSlider)
_ArrayAdd($ControlGroup1, $cTab)
_ArrayAdd($ControlGroup1, $cTreeView)
_ArrayAdd($ControlGroup1, $GroupButton)
_ArrayAdd($ControlGroup1, $ScrollButton)
_ArrayAdd($ControlGroup1, $RichEditButton)
_ArrayAdd($ControlGroup1, $ObjectButton)
_ArrayAdd($ControlGroup1, $GDIPlusButton)
$ControlGroup1[0] += 26
_ArrayAdd($ControlGroup2, $AlignmentLabel)
_ArrayAdd($ControlGroup2, $AlignmentLine)
_ArrayAdd($ControlGroup2, $AlignLeft)
_ArrayAdd($ControlGroup2, $AlignRight)
_ArrayAdd($ControlGroup2, $AlignTop)
_ArrayAdd($ControlGroup2, $AlignBottom)
_ArrayAdd($ControlGroup2, $AlignCentHoriz)
_ArrayAdd($ControlGroup2, $AlignCentVert)
$ControlGroup2[0] += 8
_ArrayAdd($ControlGroup3, $SpacingLabel)
_ArrayAdd($ControlGroup3, $SpacingLine)
_ArrayAdd($ControlGroup3, $Spacing_1)
_ArrayAdd($ControlGroup3, $Spacing_2)
_ArrayAdd($ControlGroup3, $Spacing_3)
_ArrayAdd($ControlGroup3, $Spacing_4)
_ArrayAdd($ControlGroup3, $DistanceLabel)
_ArrayAdd($ControlGroup3, $SpaceInput)
$ControlGroup3[0] += 8
_ArrayAdd($ControlGroup4, $LayerLabel)
_ArrayAdd($ControlGroup4, $LayerLine)
_ArrayAdd($ControlGroup4, $AddLayer)
_ArrayAdd($ControlGroup4, $SubLayer)
_ArrayAdd($ControlGroup4, $UpLayer)
_ArrayAdd($ControlGroup4, $DownLayer)
_ArrayAdd($ControlGroup4, $LayerList)
$ControlGroup4[0] += 7
$FontData = _CtrlGetFont($SpacingLabel)
$DefaultFont = $FontData[4]
Global $Fonts = $DefaultFont & "|Arial|Arial Black|Comic Sans MS|Courier|Courier New|Estrangelo Edessa|Franklin Gothic Medium|Gautami|Georgia|Georgia Italic Impact|Impact|Latha|Lucida Console|Lucida Sans Console|Lucida Sans Unicode|Marlett|Modern|Modern MS Sans Serif|MS Sans Serif|MS Serif|MV Boli|Palatino Linotype|Roman|Segoe UI|Script|Small Fonts|Symbol|Tahoma|Times New Roman|Trebuchet|Verdana|Webdings|Wingdings"
GUICtrlSetData($FontInput, $Fonts, $DefaultFont)
_ArrayAdd($WinTitles, "New Window")
_ArrayAdd($GUIHandles, "hGUI")
$WinTitles[0] += 1
$GUIHandles[0] += 1
$ConfigX = IniRead(@ScriptDir & "/Config.ini", "Window", "XPosition", "-1")
$ConfigY = IniRead(@ScriptDir & "/Config.ini", "Window", "YPosition", "-1")
$ConfigW = IniRead(@ScriptDir & "/Config.ini", "Window", "WPosition", "1000")
$ConfigH = IniRead(@ScriptDir & "/Config.ini", "Window", "HPosition", "700")
Global $ResizeDivider = $Height - 162
$SelectColor = "0x" & IniRead(@ScriptDir & "/Config.ini", "Colors", "SelectedColor", "00C113")
$GridLineColor = "0x" & IniRead(@ScriptDir & "/Config.ini", "Colors", "GridLineColor", "D0D0D0")
$DragColor = "0x" & IniRead(@ScriptDir & "/Config.ini", "Colors", "DragColor", "3399FF")
$InsertColor = "0x" & IniRead(@ScriptDir & "/Config.ini", "Colors", "InsertColor", "0094FF")
$ControlFont = IniRead(@ScriptDir & "/Config.ini", "Font", "ControlFont", "MS Shell Dlg")
$ApplicationFont = IniRead(@ScriptDir & "/Config.ini", "Font", "AppFont", "MS Shell Dlg")
$TreeFontSize = IniRead(@ScriptDir & "/Config.ini", "Font", "TreeSize", "8")
$ScriptFontSize = IniRead(@ScriptDir & "/Config.ini", "Font", "ScriptSize", "8")
$DefaultSaveDir = IniRead(@ScriptDir & "/Config.ini", "Vars", "SaveDir", @ScriptDir & "\Forms\")
$NewWindowW = IniRead(@ScriptDir & "/Config.ini", "Vars", "NewWindowW", "500")
$NewWindowH = IniRead(@ScriptDir & "/Config.ini", "Vars", "NewWindowH", "400")
$GridSpace = IniRead(@ScriptDir & "/Config.ini", "Vars", "GridSpacing", "10")
$LastLoaded = IniRead(@ScriptDir & "/Config.ini", "Vars", "LastFile", "")
$LoadLast = IniRead(@ScriptDir & "/Config.ini", "Vars", "LoadLast", "False")
$UpdateVars = IniRead(@ScriptDir & "/Config.ini", "Vars", "AutoUpdateVars", "True")
$AutoCheckUpdate = IniRead(@ScriptDir & "/Config.ini", "Vars", "CheckUpdate", "True")
$NewControlLayer = IniRead(@ScriptDir & "/Config.ini", "Vars", "NewControls", "Bottom")
$ControlColumn = IniRead(@ScriptDir & "/Config.ini", "Vars", "ControlColumn", "True")
$AlignColumn = IniRead(@ScriptDir & "/Config.ini", "Vars", "AlignColumn", "True")
$SpaceColumn = IniRead(@ScriptDir & "/Config.ini", "Vars", "SpaceColumn", "True")
$LayerColumn = IniRead(@ScriptDir & "/Config.ini", "Vars", "LayerColumn", "True")
$AutoSnapSensitivity = IniRead(@ScriptDir & "/Config.ini", "Vars", "AutoAlignSensitivity", "3")
$AutoAlign = IniRead(@ScriptDir & "/Config.ini", "Vars", "AutoAlign", "True")
$AutoItDir = IniRead(@ScriptDir & "/Config.ini", "Vars", "AutoItExeDir", "C:\Program Files\AutoIt3\AutoIt3.exe")
$ScriptOutputMode = IniRead(@ScriptDir & "/Config.ini", "Vars", "ScriptMode", "GUIMsg")
$ScriptColorScheme = IniRead(@ScriptDir & "/Config.ini", "Vars", "ScriptScheme", "Default")
$Debug = IniRead(@ScriptDir & "/Config.ini", "Vars", "Debug", "False")
GUICtrlSetData($GridInput, $GridSpace)
$Snap = IniRead(@ScriptDir & "/Config.ini", "Vars", "GridSnap", "False")
If $Snap = "True" Then
	$Snap = True
	GUICtrlSetState($GridSnap, $GUI_CHECKED)
Else
	$Snap = False
EndIf

If $AutoCheckUpdate = "True" Then
	If $VersionURL <> "" Then
		$hSource = _INetGetSource($VersionURL)
		If Not @error Then
			If StringInStr($hSource, "|") Then
				$hSplit = StringSplit($hSource, "|")
				If $hSplit[1] <> $CurrentVersion Then
					$hMsg = MsgBox(0x4, "New Update " & $hSplit[1], "Update " & $hSplit[1] & " is Availible, Do you want to update now?")
					If $hMsg = 6 Then
						DllClose($dll)
						$hFile = FileOpen(@ScriptDir & "/Update.tmp", 2)
						FileWrite($hFile, @ScriptFullPath & "|" & $hSplit[2])
						FileClose($hFile)
						_WinAPI_UnhookWindowsHookEx($hHook)
						DllCallbackFree($hStub_KeyProc)
						Run(@ScriptDir & "/Updater.exe")
						Exit
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
EndIf


Dim $File
GUICtrlSetFont($GridInput, 7, 400, 0, "Tahoma", 5)
$FileMenu = _GUICtrlMenu_CreateMenu()
$File = GUICtrlCreateMenu("File")
$Settings = GUICtrlCreateMenu("Settings")
$Help = GUICtrlCreateMenu("Help")
$New = GUICtrlCreateMenuItem("New GUI", $File, 1)
GUICtrlCreateMenuItem("", $File, 2)
$Open = GUICtrlCreateMenuItem("Open", $File, 3)
$hOpenRecent = GUICtrlCreateMenu("Open Recent", $File, 4)
$hLastFile_1 = IniRead(@ScriptDir & "/Config.ini", "Vars", "LastFile_1", "")
If $hLastFile_1 <> "" Then
	$aDirSplit = StringSplit($hLastFile_1, "\")
	$hLastFileMenu_1 = GUICtrlCreateMenuItem($aDirSplit[$aDirSplit[0]], $hOpenRecent, 1)
Else
	$hLastFileMenu_1 = GUICtrlCreateMenuItem(" ", $hOpenRecent, 1)
EndIf
$hLastFile_2 = IniRead(@ScriptDir & "/Config.ini", "Vars", "LastFile_2", "")
If $hLastFile_2 <> "" Then
	$aDirSplit = StringSplit($hLastFile_2, "\")
	$hLastFileMenu_2 = GUICtrlCreateMenuItem($aDirSplit[$aDirSplit[0]], $hOpenRecent, 2)
Else
	$hLastFileMenu_2 = GUICtrlCreateMenuItem(" ", $hOpenRecent, 2)
EndIf
$hLastFile_3 = IniRead(@ScriptDir & "/Config.ini", "Vars", "LastFile_3", "")
If $hLastFile_3 <> "" Then
	$aDirSplit = StringSplit($hLastFile_3, "\")
	$hLastFileMenu_3 = GUICtrlCreateMenuItem($aDirSplit[$aDirSplit[0]], $hOpenRecent, 3)
Else
	$hLastFileMenu_3 = GUICtrlCreateMenuItem(" ", $hOpenRecent, 3)
EndIf
$hLastFile_4 = IniRead(@ScriptDir & "/Config.ini", "Vars", "LastFile_4", "")
If $hLastFile_4 <> "" Then
	$aDirSplit = StringSplit($hLastFile_4, "\")
	$hLastFileMenu_4 = GUICtrlCreateMenuItem($aDirSplit[$aDirSplit[0]], $hOpenRecent, 4)
Else
	$hLastFileMenu_4 = GUICtrlCreateMenuItem(" ", $hOpenRecent, 4)
EndIf
$hLastFile_5 = IniRead(@ScriptDir & "/Config.ini", "Vars", "LastFile_5", "")
If $hLastFile_5 <> "" Then
	$aDirSplit = StringSplit($hLastFile_5, "\")
	$hLastFileMenu_5 = GUICtrlCreateMenuItem($aDirSplit[$aDirSplit[0]], $hOpenRecent, 5)
Else
	$hLastFileMenu_5 = GUICtrlCreateMenuItem(" ", $hOpenRecent, 5)
EndIf
$Import = GUICtrlCreateMenuItem("Import Script", $File, 5)
GUICtrlCreateMenuItem("", $File, 6)
$SaveAs = GUICtrlCreateMenuItem("Save As", $File, 7)
$Save = GUICtrlCreateMenuItem("Save", $File, 8)
GUICtrlSetState($Save, $GUI_DISABLE)
GUICtrlCreateMenuItem("", $File, 9)
$Exit = GUICtrlCreateMenuItem("Exit", $File, 10)
$HelpMenu = GUICtrlCreateMenuItem("Help", $Help, 1)
$HelpAutoIt = GUICtrlCreateMenuItem("AutoIt Help", $Help, 2)
$SettingsMenu = GUICtrlCreateMenuItem("Settings", $Settings, 1)
GUICtrlCreateMenuItem("", $Settings, 2)
$Update = GUICtrlCreateMenuItem("Check for Updates", $Settings, 3)
GUICtrlSetBkColor($BoldButton, $InactiveColor)
GUICtrlSetBkColor($ItalicButton, $InactiveColor)
GUICtrlSetBkColor($UnderlineButton, $InactiveColor)
GUICtrlSetBkColor($StrikeButton, $InactiveColor)
GUICtrlSetState($TopFill, $GUI_DISABLE)
GUICtrlSetState($TopLine_2, $GUI_DISABLE)
GUICtrlSetResizing($TopFill, 2 + 4 + 32 + 512)
GUICtrlSetResizing($TopLine, 2 + 4 + 32 + 512)
GUICtrlSetResizing($TopLine_2, 2 + 4 + 32 + 512)
GUICtrlSetTip($AddGUIButton, "Child Window")
GUICtrlSetTip($DelGUIButton, "Close Current Window")
GUICtrlSetTip($InsertButton, "Insert Child Window")
GUICtrlSetResizing($ScriptDevelopBtn, 2 + 32 + 512 + 256)
GUICtrlSetResizing($Line_7, 2 + 32 + 512 + 256)
GUICtrlSetResizing($Line_8, 2 + 32 + 512 + 256)
GUICtrlSetResizing($GroupControlButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($UnGroupControlButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($LockControlButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($GraphicMode, 2 + 32 + 512 + 256)
GUICtrlSetResizing($AutoAlignButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($GridButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($GridLabel, 2 + 32 + 512 + 256)
GUICtrlSetResizing($SnapLabel, 2 + 32 + 512 + 256)
GUICtrlSetResizing($GridInput, 2 + 32 + 512 + 256)
GUICtrlSetResizing($GridSnap, 2 + 32 + 512 + 256)
GUICtrlSetResizing($RightLine, 2 + 32 + 64 + 256)
GUICtrlSetResizing($ControlLine, 2 + 32 + 512 + 256)
GUICtrlSetResizing($ControlBoarder, 2 + 32 + 512 + 256)
GUICtrlSetResizing($ControlLabel, 2 + 32 + 512 + 256)
GUICtrlSetResizing($AlignmentLine, 2 + 32 + 512 + 256)
GUICtrlSetResizing($AlignmentLabel, 2 + 32 + 512 + 256)
GUICtrlSetResizing($AlignmentBoarder, 2 + 32 + 512 + 256)
GUICtrlSetResizing($AlignCentHoriz, 2 + 32 + 512 + 256)
GUICtrlSetResizing($AlignCentVert, 2 + 32 + 512 + 256)
GUICtrlSetResizing($AlignLeft, 2 + 32 + 512 + 256)
GUICtrlSetResizing($AlignRight, 2 + 32 + 512 + 256)
GUICtrlSetResizing($AlignBottom, 2 + 32 + 512 + 256)
GUICtrlSetResizing($AlignTop, 2 + 32 + 512 + 256)
GUICtrlSetResizing($SpacingLine, 2 + 32 + 512 + 256)
GUICtrlSetResizing($SpacingBoarder, 2 + 32 + 512 + 256)
GUICtrlSetResizing($SpacingLabel, 2 + 32 + 512 + 256)
GUICtrlSetResizing($Spacing_1, 2 + 32 + 512 + 256)
GUICtrlSetResizing($Spacing_2, 2 + 32 + 512 + 256)
GUICtrlSetResizing($Spacing_3, 2 + 32 + 512 + 256)
GUICtrlSetResizing($Spacing_4, 2 + 32 + 512 + 256)
GUICtrlSetResizing($PlayButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($StopButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($Line_1, 2 + 32 + 512 + 256)
GUICtrlSetResizing($Line_2, 2 + 32 + 512 + 256)
GUICtrlSetResizing($Line_3, 2 + 32 + 512 + 256)
GUICtrlSetResizing($Line_4, 2 + 32 + 512 + 256)
GUICtrlSetResizing($Line_5, 2 + 32 + 512 + 256)
GUICtrlSetResizing($Line_6, 2 + 32 + 512 + 256)
GUICtrlSetResizing($AddGUIButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($DelGUIButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($InsertButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($FuncMode, 2 + 32 + 512 + 256)
GUICtrlSetResizing($LayerBoarder, 2 + 32 + 512 + 256)
GUICtrlSetResizing($LayerLabel, 2 + 32 + 512 + 256)
GUICtrlSetResizing($LayerLine, 2 + 32 + 512 + 256)
GUICtrlSetResizing($AddLayer, 2 + 32 + 512 + 256)
GUICtrlSetResizing($SubLayer, 2 + 32 + 512 + 256)
GUICtrlSetResizing($LayerList, 2 + 32 + 512 + 256)
GUICtrlSetResizing($UpLayer, 2 + 32 + 512 + 256)
GUICtrlSetResizing($DownLayer, 2 + 32 + 512 + 256)
GUICtrlSetResizing($DistanceLabel, 2 + 32 + 512 + 256)
GUICtrlSetResizing($SpaceInput, 2 + 32 + 512 + 256)
GUICtrlSetResizing($GroupButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($ScrollButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($RichEditButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($ObjectButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($GDIPlusButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cButton, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cCheckbox, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cCombo, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cDate, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cDummy, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cEdit, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cGroup, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cGraphic, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cIcon, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cInput, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cLabel, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cList, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cListView, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cMenu, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cPicture, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cSlider, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cTab, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cTreeView, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cProgress, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cRadio, 2 + 32 + 512 + 256)
GUICtrlSetResizing($cUpDown, 2 + 32 + 512 + 256)
GUICtrlSetResizing($LeftLine, 4 + 32 + 64 + 256)
GUICtrlSetResizing($LeftLine_1, 4 + 64 + 256 + 512)
GUICtrlSetResizing($LeftLine_2, 4 + 64 + 256 + 512)
GUICtrlSetResizing($HandleLabel, 4 + 64 + 256 + 512)
GUICtrlSetResizing($HandleInput, 4 + 64 + 256 + 512)
GUICtrlSetResizing($PositionLabel, 4 + 64 + 256 + 512)
GUICtrlSetResizing($XLabel, 4 + 64 + 256 + 512)
GUICtrlSetResizing($YLabel, 4 + 64 + 256 + 512)
GUICtrlSetResizing($WLabel, 4 + 64 + 256 + 512)
GUICtrlSetResizing($HLabel, 4 + 64 + 256 + 512)
GUICtrlSetResizing($XPosInput, 4 + 64 + 256 + 512)
GUICtrlSetResizing($YPosInput, 4 + 64 + 256 + 512)
GUICtrlSetResizing($WInput, 4 + 64 + 256 + 512)
GUICtrlSetResizing($HInput, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ColorLabel, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ColorInput, 4 + 64 + 256 + 512)
GUICtrlSetResizing($BkColorLabel, 4 + 64 + 256 + 512)
GUICtrlSetResizing($BkColorInput, 4 + 64 + 256 + 512)
GUICtrlSetResizing($FontLabel, 4 + 64 + 256 + 512)
GUICtrlSetResizing($FontInput, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ImageLabel, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ImageInput, 4 + 64 + 256 + 512)
GUICtrlSetResizing($CursorLabel, 4 + 64 + 256 + 512)
GUICtrlSetResizing($CursorInput, 4 + 64 + 256 + 512)
GUICtrlSetResizing($StyleLabel, 4 + 64 + 256 + 512)
GUICtrlSetResizing($StyleInput, 4 + 64 + 256 + 512)
GUICtrlSetResizing($StateLabel, 4 + 64 + 256 + 512)
GUICtrlSetResizing($StateInput, 4 + 64 + 256 + 512)
GUICtrlSetResizing($BoldButton, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ItalicButton, 4 + 64 + 256 + 512)
GUICtrlSetResizing($UnderlineButton, 4 + 64 + 256 + 512)
GUICtrlSetResizing($StrikeButton, 4 + 64 + 256 + 512)
GUICtrlSetResizing($DataLabel, 4 + 64 + 256 + 512)
GUICtrlSetResizing($DataInput, 4 + 64 + 256 + 512)
GUICtrlSetResizing($SizeInput, 4 + 64 + 256 + 512)
GUICtrlSetResizing($SizeLabel, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ResizingBoarder, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ResizeAuto, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ResizeBottom, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ResizeH, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ResizeVC, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ResizeHC, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ResizeTop, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ResizeRight, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ResizeLeft, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ResizeW, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ResizeH, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ColorEx, 4 + 64 + 256 + 512)
GUICtrlSetResizing($BkColorEx, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ColorExBack, 4 + 64 + 256 + 512)
GUICtrlSetResizing($BkColorExBack, 4 + 64 + 256 + 512)
GUICtrlSetResizing($ImageEx, 4 + 64 + 256 + 512)
GUICtrlSetResizing($StyleEx, 4 + 64 + 256 + 512)
GUICtrlSetResizing($DataEx, 4 + 64 + 256 + 512)
GUICtrlSetResizing($BottomLine, 2 + 4 + 64 + 512)
GUICtrlSetResizing($Line_9, 802)
GUICtrlSetResizing($Line_10, 802)
GUICtrlSetResizing($UndoButton, 802)
GUICtrlSetStyle($ResizeAuto, $BS_BITMAP)
GUICtrlSetStyle($ResizeLeft, $BS_BITMAP)
GUICtrlSetStyle($ResizeRight, $BS_BITMAP)
GUICtrlSetStyle($ResizeTop, $BS_BITMAP)
GUICtrlSetStyle($ResizeBottom, $BS_BITMAP)
GUICtrlSetStyle($ResizeHC, $BS_BITMAP)
GUICtrlSetStyle($ResizeVC, $BS_BITMAP)
GUICtrlSetStyle($ResizeW, $BS_BITMAP)
GUICtrlSetStyle($ResizeH, $BS_BITMAP)
$hTree = GUICtrlCreateTreeView(800, 32, 200, 266, BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS, $TVS_FULLROWSELECT))
_WinAPI_SetWindowLong(GUICtrlGetHandle($hTree), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle($hTree), $GWL_STYLE), BitNOT($WS_TABSTOP)))
_GUICtrlTreeView_BeginUpdate($hTree)
$hFileTree = _GUICtrlTreeView_Add($hTree, 0, "Untitled.gui")
_GUICtrlTreeView_SetIcon($hTree, $hFileTree, @ScriptDir & "\Resources.dll", -279)
$hTreeGUI = _GUICtrlTreeView_AddChild($hTree, $hFileTree, "hGUI")
_GUICtrlTreeView_SetIcon($hTree, $hTreeGUI, @ScriptDir & "\Resources.dll", -119)
_GUICtrlTreeView_EndUpdate($hTree)
_ArrayAdd($GUITrees, $hTreeGUI)
$GUITrees[0] += 1
GUICtrlSetResizing($hTree, 4 + 32 + 64 + 256)
GUICtrlSetFont($hTree, $TreeFontSize)
$TreeContext = GUICtrlCreateContextMenu($hTree)
$hTreeCopy = GUICtrlCreateMenuItem("Copy", $TreeContext)
$hTreePaste = GUICtrlCreateMenuItem("Paste", $TreeContext)
$hTreeDuplicate = GUICtrlCreateMenuItem("Duplicate", $TreeContext)
GUICtrlCreateMenuItem("", $TreeContext)
$hTreeDelete = GUICtrlCreateMenuItem("Delete", $TreeContext)
GUICtrlCreateMenuItem("", $TreeContext)
$hTreeImport = GUICtrlCreateMenuItem("Import Clipboard", $TreeContext)
$hTreeProp = GUICtrlCreateMenuItem("Properties", $TreeContext)
$ScriptEdit = _GUICtrlRichEdit_Create($hGUI, "", 189, 523, 610, 160, BitOR($ES_MULTILINE, $WS_VSCROLL, $WS_HSCROLL, $ES_AUTOVSCROLL))

_WinAPI_SetWindowLong(GUICtrlGetHandle($ScriptEdit), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle($ScriptEdit), $GWL_STYLE), BitNOT($WS_TABSTOP)))

GUICtrlSetFont($ScriptEdit, $ScriptFontSize, 400, 0, $ApplicationFont)
GUICtrlSetStyle($GroupButton, $BS_ICON)
GUICtrlSetTip($GroupButton, "Group")
GUICtrlSetStyle($ScrollButton, $BS_ICON)
GUICtrlSetTip($ScrollButton, "GUI Scrollbars")
GUICtrlSetStyle($RichEditButton, $BS_ICON)
GUICtrlSetTip($RichEditButton, "Rich Edit")
GUICtrlSetStyle($ObjectButton, $BS_ICON)
GUICtrlSetTip($ObjectButton, "Object Control")
GUICtrlSetStyle($GDIPlusButton, $BS_ICON)
GUICtrlSetTip($GDIPlusButton, "GDI +")
GUICtrlSetStyle($cButton, $BS_ICON)
GUICtrlSetTip($cButton, "Label")
GUICtrlSetStyle($cCheckbox, $BS_ICON)
GUICtrlSetTip($cCheckbox, "Button")
GUICtrlSetStyle($cCombo, $BS_ICON)
GUICtrlSetTip($cCombo, "Input")
GUICtrlSetStyle($cDate, $BS_ICON)
GUICtrlSetTip($cDate, "Edit")
GUICtrlSetStyle($cDummy, $BS_ICON)
GUICtrlSetTip($cDummy, "Checkbox")
GUICtrlSetStyle($cEdit, $BS_ICON)
GUICtrlSetTip($cEdit, "Radio")
GUICtrlSetStyle($cGroup, $BS_ICON)
GUICtrlSetTip($cGroup, "Combo")
GUICtrlSetStyle($cGraphic, $BS_ICON)
GUICtrlSetTip($cGraphic, "List")
GUICtrlSetStyle($cIcon, $BS_ICON)
GUICtrlSetTip($cIcon, "Date")
GUICtrlSetStyle($cInput, $BS_ICON)
GUICtrlSetTip($cInput, "Picture")
GUICtrlSetStyle($cLabel, $BS_ICON)
GUICtrlSetTip($cLabel, "Icon")
GUICtrlSetStyle($cList, $BS_ICON)
GUICtrlSetTip($cList, "Progress")
GUICtrlSetStyle($cListView, $BS_ICON)
GUICtrlSetTip($cListView, "Tab")
GUICtrlSetStyle($cMenu, $BS_ICON)
GUICtrlSetTip($cMenu, "UpDown")
GUICtrlSetStyle($cPicture, $BS_ICON)
GUICtrlSetTip($cPicture, "Menu")
GUICtrlSetStyle($cProgress, $BS_ICON)
GUICtrlSetTip($cProgress, "TreeView")
GUICtrlSetStyle($cRadio, $BS_ICON)
GUICtrlSetTip($cRadio, "Slider")
GUICtrlSetStyle($cSlider, $BS_ICON)
GUICtrlSetTip($cSlider, "ListView")
GUICtrlSetStyle($cTab, $BS_ICON)
GUICtrlSetTip($cTab, "Graphic")
GUICtrlSetStyle($cTreeView, $BS_ICON)
GUICtrlSetTip($cTreeView, "Dummy")
GUICtrlSetStyle($cUpDown, $BS_ICON)
GUICtrlSetTip($cUpDown, "Calendar")
GUICtrlSetStyle($ScriptDevelopBtn, $BS_ICON)
;GUICtrlSetImage($ScriptDevelopBtn, @ScriptDir & "\Resources.dll", 130, 0)
GUICtrlSetTip($ScriptDevelopBtn, "")
GUICtrlSetState($ScriptDevelopBtn, $GUI_DISABLE)
GUICtrlSetStyle($FuncMode, $BS_ICON)
GUICtrlSetImage($FuncMode, @ScriptDir & "\Resources.dll", 115, 0)
GUICtrlSetState($FuncMode, $GUI_DISABLE)
GUICtrlSetTip($FuncMode, "Control Function")
GUICtrlSetTip($PlayButton, "Test Script")
GUICtrlSetTip($StopButton, "Kill Script")
GUICtrlSetStyle($PlayButton, $BS_ICON)
GUICtrlSetStyle($StopButton, $BS_ICON)
GUICtrlSetImage($PlayButton, @ScriptDir & "\Resources.dll", 241, 0)
GUICtrlSetImage($StopButton, @ScriptDir & "\Resources.dll", 244, 0)
GUICtrlSetState($StopButton, $GUI_DISABLE)
GUICtrlSetStyle($AutoAlignButton, $BS_ICON)
GUICtrlSetStyle($AddGUIButton, $BS_ICON)
GUICtrlSetStyle($DelGUIButton, $BS_ICON)
GUICtrlSetStyle($InsertButton, $BS_ICON)
GUICtrlSetImage($AddGUIButton, @ScriptDir & "\Resources.dll", 134, 0)
GUICtrlSetImage($DelGUIButton, @ScriptDir & "\Resources.dll", 112, 0)
GUICtrlSetImage($InsertButton, @ScriptDir & "\Resources.dll", -94, 0)
GUICtrlSetStyle($Spacing_1, $BS_BITMAP)
GUICtrlSetStyle($Spacing_2, $BS_BITMAP)
GUICtrlSetStyle($Spacing_3, $BS_BITMAP)
GUICtrlSetStyle($Spacing_4, $BS_BITMAP)
GUICtrlSetTip($Spacing_1, "Space Horizontally")
GUICtrlSetTip($Spacing_2, "Space Vertically")
GUICtrlSetTip($Spacing_3, "Space Centers Horizontally")
GUICtrlSetTip($Spacing_4, "Space Centers Vertically")
GUICtrlSetStyle($GraphicMode, $BS_ICON)
GUICtrlSetImage($GraphicMode, @ScriptDir & "\Resources.dll", 116, 0)
GUICtrlSetState($GraphicMode, $GUI_DISABLE)
GUICtrlSetTip($GraphicMode, "Switch to Graphic Mode")
GUICtrlSetStyle($AddLayer, $BS_ICON)
GUICtrlSetStyle($SubLayer, $BS_ICON)
GUICtrlSetStyle($UpLayer, $BS_BITMAP)
GUICtrlSetStyle($DownLayer, $BS_BITMAP)
GUICtrlSetImage($AddLayer, @ScriptDir & "\Resources.dll", 191, 0)
GUICtrlSetImage($SubLayer, @ScriptDir & "\Resources.dll", 238, 0)
GUICtrlSetStyle($GridButton, $BS_BITMAP)
GUICtrlSetImage($GroupButton, @ScriptDir & "\Resources.dll", 118, 0)
GUICtrlSetImage($ScrollButton, @ScriptDir & "\Resources.dll", 288, 0)
GUICtrlSetImage($RichEditButton, @ScriptDir & "\Resources.dll", 289, 0)
GUICtrlSetImage($ObjectButton, @ScriptDir & "\Resources.dll", 291, 0)
GUICtrlSetImage($GDIPlusButton, @ScriptDir & "\Resources.dll", 292, 0)
GUICtrlSetImage($cButton, @ScriptDir & "\Resources.dll", 122, 0)
GUICtrlSetImage($cCheckbox, @ScriptDir & "\Resources.dll", 103, 0)
GUICtrlSetImage($cCombo, @ScriptDir & "\Resources.dll", 121, 0)
GUICtrlSetImage($cDate, @ScriptDir & "\Resources.dll", 114, 0)
GUICtrlSetImage($cDummy, @ScriptDir & "\Resources.dll", 105, 0)
GUICtrlSetImage($cEdit, @ScriptDir & "\Resources.dll", 129, 0)
GUICtrlSetImage($cGroup, @ScriptDir & "\Resources.dll", 107, 0)
GUICtrlSetImage($cGraphic, @ScriptDir & "\Resources.dll", 123, 0)
GUICtrlSetImage($cIcon, @ScriptDir & "\Resources.dll", 111, 0)
GUICtrlSetImage($cInput, @ScriptDir & "\Resources.dll", 127, 0)
GUICtrlSetImage($cLabel, @ScriptDir & "\Resources.dll", 120, 0)
GUICtrlSetImage($cList, @ScriptDir & "\Resources.dll", 128, 0)
GUICtrlSetImage($cListView, @ScriptDir & "\Resources.dll", 135, 0)
GUICtrlSetImage($cMenu, @ScriptDir & "\Resources.dll", 138, 0)
GUICtrlSetImage($cPicture, @ScriptDir & "\Resources.dll", 126, 0)
GUICtrlSetImage($cProgress, @ScriptDir & "\Resources.dll", 136, 0)
GUICtrlSetImage($cRadio, @ScriptDir & "\Resources.dll", 133, 0)
GUICtrlSetImage($cSlider, @ScriptDir & "\Resources.dll", 124, 0)
GUICtrlSetImage($cTab, @ScriptDir & "\Resources.dll", 116, 0)
GUICtrlSetImage($cTreeView, @ScriptDir & "\Resources.dll", 113, 0)
GUICtrlSetImage($cUpDown, @ScriptDir & "\Resources.dll", 104, 0)
GUICtrlSetStyle($AlignLeft, $BS_BITMAP)
GUICtrlSetStyle($AlignRight, $BS_BITMAP)
GUICtrlSetStyle($AlignTop, $BS_BITMAP)
GUICtrlSetStyle($AlignBottom, $BS_ICON)
GUICtrlSetStyle($AlignCentHoriz, $BS_BITMAP)
GUICtrlSetStyle($AlignCentVert, $BS_BITMAP)
GUICtrlSetTip($AlignLeft, "Align Left")
GUICtrlSetTip($AlignRight, "Align Right")
GUICtrlSetTip($AlignTop, "Align Top")
GUICtrlSetTip($AlignBottom, "Align Bottom")
GUICtrlSetTip($AlignCentHoriz, "Align Horizontal Centers")
GUICtrlSetTip($AlignCentVert, "Align Vertical Centers")
GUICtrlSetStyle($CopyScript, $BS_ICON)
GUICtrlSetImage($CopyScript, @ScriptDir & "\Resources.dll", 106, 0)
GUICtrlSetTip($CopyScript, "Copy Script")
GUICtrlSetResizing($CopyScript, 2 + 64 + 512 + 256)
GUICtrlSetStyle($SaveScript, $BS_ICON)
GUICtrlSetImage($SaveScript, @ScriptDir & "\Resources.dll", 131, 0)
GUICtrlSetTip($SaveScript, "Save Script")
GUICtrlSetResizing($SaveScript, 2 + 64 + 512 + 256)
GUICtrlSetData($LayerList, "          ")
_GUICtrlListView_SetColumnWidth($LayerList, 0, 99)
_GUICtrlListView_AddItem($LayerList, "Layer 0")
GUICtrlSetState($LayerList, BitOR($LVS_SHOWSELALWAYS, $LVS_SINGLESEL, $GUI_DISABLE))
_GUICtrlListView_SetExtendedListViewStyle($LayerList, $LVS_EX_FULLROWSELECT)
$GUITab = GUICtrlCreateTab(151, 31, 650, 492)
_WinAPI_SetWindowLong(GUICtrlGetHandle($GUITab), $GWL_STYLE, BitAND(_WinAPI_GetWindowLong(GUICtrlGetHandle($GUITab), $GWL_STYLE), BitNOT($WS_TABSTOP)))
GUICtrlCreateTabItem("Untitled.gui")
GUICtrlSetResizing($GUITab, 2 + 4 + 32 + 64)
GUISetState(@SW_SHOW, $hGUI)
If $ControlColumn = "False" Then
	_CollapseControls()
EndIf
If $AlignColumn = "False" Then
	_CollapseAlign()
EndIf
If $SpaceColumn = "False" Then
	_CollapseSpacing()
EndIf
If $LayerColumn = "False" Then
	_CollapseLayering()
EndIf
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
#EndRegion
#Region GUIRegion
$GUIHolder = GUICreate("", 646, 469, 152, 52, $WS_POPUP)
GUISetBkColor(0xBDE2FD, $GUIHolder)
$BkLabelThing = GUICtrlCreateLabel("", -500, -500, 1000, 1000)
GUICtrlSetState(-1, $GUI_HIDE)
$1 = GUICtrlCreateLabel("", 0, 0, 2013, 21)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetBkColor(-1, 0xD3DAED)
GUICtrlSetResizing(-1, 802)
$2 = GUICtrlCreateLabel("Graphic Mode", 25, 3, 200, 18)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetFont(-1, 9, 800, 0, "", 5)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetResizing(-1, 802)
$3 = GUICtrlCreateIcon(@ScriptDir & "/Resources.dll", 117, 5, 3, 16, 16)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$4 = GUICtrlCreateLabel("", 0, 21, 2012, 1)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetBkColor(-1, 0x979797)
GUICtrlSetResizing(-1, 802)
$5 = GUICtrlCreateLabel("", 0, 22, 130, 2012)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetBkColor(-1, 0xF0F0F0)
GUICtrlSetResizing(-1, 802)
GUICtrlSetState(-1, $GUI_DISABLE)
$6 = GUICtrlCreateLabel("", 131, 22, 1, 2012)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetBkColor(-1, 0x979797)
GUICtrlSetResizing(-1, 802)
$7 = GUICtrlCreateLabel("", 12, 276, 107, 1)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetBkColor(-1, 0x979797)
GUICtrlSetResizing(-1, 802)
$8 = GUICtrlCreateLabel(" Tools " , 50, 269, 32, 17, $SS_CENTER)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetBkColor(-1, 0xF0F0F0)
GUICtrlSetResizing(-1, 802)
$9 = GUICtrlCreateLabel("", 12, 37, 107, 1)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetBkColor(-1, 0x979797)
GUICtrlSetResizing(-1, 802)
$10 = GUICtrlCreateLabel("Properties", 38, 30, 58, 18, $SS_CENTER)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetBkColor(-1, 0xF0F0F0)
GUICtrlSetResizing(-1, 802)
$PropBoarder = GUICtrlCreateGroup("", 5, 20, 123, 238)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hDotBtn = GUICtrlCreateButton("D", 17, 288, 30, 30, $BS_ICON)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
GUICtrlSetImage(-1, @ScriptDir & "\Resources.dll", 280, 0)
GUICtrlSetTip(-1, "Dot")
$hPixelBtn = GUICtrlCreateButton("", 51, 288, 30, 30, $BS_ICON)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
GUICtrlSetImage(-1, @ScriptDir & "\Resources.dll", 281, 0)
GUICtrlSetTip(-1, "Pixel")
$hLineBtn = GUICtrlCreateButton("", 86, 288, 30, 30, $BS_ICON)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
GUICtrlSetImage(-1, @ScriptDir & "\Resources.dll", 282, 0)
GUICtrlSetTip(-1, "Line")
$hBezierBtn = GUICtrlCreateButton("", 17, 324, 30, 30, $BS_ICON)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
GUICtrlSetImage(-1, @ScriptDir & "\Resources.dll", 283, 0)
GUICtrlSetTip(-1, "Bezier")
$hRectBtn = GUICtrlCreateButton("", 51, 324, 30, 30, $BS_ICON)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
GUICtrlSetImage(-1, @ScriptDir & "\Resources.dll", 284, 0)
GUICtrlSetTip(-1, "Rectangle")
$hEllipseBtn = GUICtrlCreateButton("", 86, 324, 30, 30, $BS_ICON)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
GUICtrlSetImage(-1, @ScriptDir & "\Resources.dll", 285, 0)
GUICtrlSetTip(-1, "Ellipse")
$hPieBtn = GUICtrlCreateButton("", 17, 359, 30, 30, $BS_ICON)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
GUICtrlSetImage(-1, @ScriptDir & "\Resources.dll", 286, 0)
GUICtrlSetTip(-1, "Pie")
GUISetBkColor(0xFFFFFF, $GUIHolder)
$ModeCloseBtn = GUICtrlCreatePic("", 626, 3, 17, 17)
GUICtrlSetState(-1, $GUI_HIDE)
$hTopBoarder = GUICtrlCreateLabel("", 0, 0, 0, 0)
GUICtrlSetBkColor(-1, 0x000000)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hBottomBoarder = GUICtrlCreateLabel("", 0, 0, 0, 0)
GUICtrlSetBkColor(-1, 0x000000)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hLeftBoarder = GUICtrlCreateLabel("", 0, 0, 0, 0)
GUICtrlSetBkColor(-1, 0x000000)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hRightBoarder = GUICtrlCreateLabel("", 0, 0, 0, 0)
GUICtrlSetBkColor(-1, 0x000000)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$BoarderL = GUICtrlCreateLabel("", 1, 1, 1, 1)
GUICtrlSetBkColor(-1, 0x3DAEFF)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$BoarderR = GUICtrlCreateLabel("", 1, 1, 1, 1)
GUICtrlSetBkColor(-1, 0x3DAEFF)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$BoarderT = GUICtrlCreateLabel("", 1, 1, 1, 1)
GUICtrlSetBkColor(-1, 0x3DAEFF)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$BoarderB = GUICtrlCreateLabel("", 1, 1, 1, 1)
GUICtrlSetBkColor(-1, 0x3DAEFF)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$SaveGraphicButton = GUICtrlCreateButton("Save Graphic", 9, 449, 111, 24)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$Dot = GUICtrlCreatePic("", 0, 0, 5, 5)
GUICtrlSetState($Dot, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$11 = GUICtrlCreateLabel("Color:", 12, 396, 42, 18)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$NewGraphicColor = GUICtrlCreateInput("000000", 55, 394, 43, 20)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$NewChangeColor = GUICtrlCreateButton("", 100, 394, 19, 19)
GUICtrlSetBkColor(-1, 0x000000)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$12 = GUICtrlCreateLabel("BkColor:", 12, 419, 42, 18)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$NewGraphicBkColor = GUICtrlCreateInput("", 55, 416, 43, 20)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$GraphicBoarder = GUICtrlCreateGroup("", 5, 256, 123, 190)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$NewChangeBkColor = GUICtrlCreateButton("", 100, 416, 19, 19)
GUICtrlSetBkColor(-1, 0xF0F0F0)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamLbl1 = GUICtrlCreateLabel("( Param 1 )", 7, 50, 67, 18, $SS_RIGHT)
GUICtrlSetBkColor(-1, 0xF0F0F0)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamInput1 = GUICtrlCreateInput("", 78, 46, 42, 20)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamLbl2 = GUICtrlCreateLabel("( Param 2 )", 7, 73, 67, 18, $SS_RIGHT)
GUICtrlSetBkColor(-1, 0xF0F0F0)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamInput2 = GUICtrlCreateInput("", 78, 69, 42, 20)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamLbl3 = GUICtrlCreateLabel("( Param 3 )", 7, 96, 67, 18, $SS_RIGHT)
GUICtrlSetBkColor(-1, 0xF0F0F0)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamInput3 = GUICtrlCreateInput("", 78, 92, 42, 20)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamLbl4 = GUICtrlCreateLabel("( Param 4 )", 7, 119, 67, 18, $SS_RIGHT)
GUICtrlSetBkColor(-1, 0xF0F0F0)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamInput4 = GUICtrlCreateInput("", 78, 115, 42, 20)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamLbl5 = GUICtrlCreateLabel("( Param 5 )", 7, 142, 67, 18, $SS_RIGHT)
GUICtrlSetBkColor(-1, 0xF0F0F0)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamInput5 = GUICtrlCreateInput("", 78, 138, 42, 20)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamLbl6 = GUICtrlCreateLabel("( Param 6 )", 7, 165, 67, 18, $SS_RIGHT)
GUICtrlSetBkColor(-1, 0xF0F0F0)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamInput6 = GUICtrlCreateInput("", 78, 161, 42, 20)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamLbl7 = GUICtrlCreateLabel("Color:", 7, 188, 45, 18, $SS_RIGHT)
GUICtrlSetBkColor(-1, 0xF0F0F0)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamColor = GUICtrlCreateButton("", 103, 184, 20, 20)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
GUICtrlSetBkColor(-1, 0xF0F0F0)
$hParamInput7 = GUICtrlCreateInput("", 55, 184, 47, 20)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamLbl8 = GUICtrlCreateLabel("BkColor:", 7, 211, 45, 18, $SS_RIGHT)
GUICtrlSetBkColor(-1, 0xF0F0F0)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamInput8 = GUICtrlCreateInput("", 55, 207, 47, 20)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$hParamBkColor = GUICtrlCreateButton("", 103, 207, 20, 20)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
GUICtrlSetBkColor(-1, 0xF0F0F0)
$hUpdateGraphic = GUICtrlCreateButton("Update Graphic", 11, 230, 110, 23)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
GUISetState()

_ResourceSetImageToCtrl($AlignBottom, "Align_Bottom", $RT_BITMAP)
_ResourceSetImageToCtrl($AlignCentHoriz, "Align_CenterHoriz", $RT_BITMAP)
_ResourceSetImageToCtrl($AlignCentVert, "Align_CenterVert", $RT_BITMAP)
_ResourceSetImageToCtrl($AlignLeft, "Align_Left", $RT_BITMAP)
_ResourceSetImageToCtrl($AlignRight, "Align_Right", $RT_BITMAP)
_ResourceSetImageToCtrl($AlignTop, "Align_Top", $RT_BITMAP)
_ResourceSetImageToCtrl($Spacing_1, "Space_Width", $RT_BITMAP)
_ResourceSetImageToCtrl($Spacing_2, "Space_Height", $RT_BITMAP)
_ResourceSetImageToCtrl($Spacing_3, "Space_WidthCenter", $RT_BITMAP)
_ResourceSetImageToCtrl($Spacing_4, "Space_HeightCenter", $RT_BITMAP)
_ResourceSetImageToCtrl($ResizeAuto, "Resize_Auto_Disable", $RT_BITMAP)
_ResourceSetImageToCtrl($ResizeBottom, "Resize_Bottom_Disable", $RT_BITMAP)
_ResourceSetImageToCtrl($ResizeTop, "Resize_Top_Disable", $RT_BITMAP)
_ResourceSetImageToCtrl($ResizeLeft, "Resize_Left_Disable", $RT_BITMAP)
_ResourceSetImageToCtrl($ResizeRight, "Resize_Right_Disable", $RT_BITMAP)
_ResourceSetImageToCtrl($ResizeVC, "Resize_VCenter_Disable", $RT_BITMAP)
_ResourceSetImageToCtrl($ResizeHC, "Resize_HCenter_Disable", $RT_BITMAP)
_ResourceSetImageToCtrl($ResizeH, "Resize_LockHeight_Disable", $RT_BITMAP)
_ResourceSetImageToCtrl($ResizeW, "Resize_LockWidth_Disable", $RT_BITMAP)
_ResourceSetImageToCtrl($UpLayer, "UpArrow", $RT_BITMAP)
_ResourceSetImageToCtrl($DownLayer, "DownArrow", $RT_BITMAP)
_ResourceSetImageToCtrl($ModeCloseBtn, "CloseBtn", $RT_BITMAP)
_ResourceSetImageToCtrl($Dot, "Dot", $RT_BITMAP)
If $AutoAlign = "True" Then
	_ResourceSetImageToCtrl($AutoAlignButton, "AutoAlign", $RT_BITMAP)
Else
	_ResourceSetImageToCtrl($AutoAlignButton, "AutoAlign_Disable", $RT_BITMAP)
EndIf
_ResourceSetImageToCtrl($GridButton, "Grid_Disable", $RT_BITMAP)

_ArrayAdd($ModeGroup, $hParamLbl1)
_ArrayAdd($ModeGroup, $hParamLbl2)
_ArrayAdd($ModeGroup, $hParamLbl3)
_ArrayAdd($ModeGroup, $hParamLbl4)
_ArrayAdd($ModeGroup, $hParamLbl5)
_ArrayAdd($ModeGroup, $hParamLbl6)
_ArrayAdd($ModeGroup, $hParamLbl7)
_ArrayAdd($ModeGroup, $hParamLbl8)
_ArrayAdd($ModeGroup, $hParamInput1)
_ArrayAdd($ModeGroup, $hParamInput2)
_ArrayAdd($ModeGroup, $hParamInput3)
_ArrayAdd($ModeGroup, $hParamInput4)
_ArrayAdd($ModeGroup, $hParamInput5)
_ArrayAdd($ModeGroup, $hParamInput6)
_ArrayAdd($ModeGroup, $hParamInput7)
_ArrayAdd($ModeGroup, $hParamInput8)
_ArrayAdd($ModeGroup, $PropBoarder)
_ArrayAdd($ModeGroup, $1)
_ArrayAdd($ModeGroup, $2)
_ArrayAdd($ModeGroup, $3)
_ArrayAdd($ModeGroup, $4)
_ArrayAdd($ModeGroup, $5)
_ArrayAdd($ModeGroup, $6)
_ArrayAdd($ModeGroup, $7)
_ArrayAdd($ModeGroup, $8)
_ArrayAdd($ModeGroup, $9)
_ArrayAdd($ModeGroup, $10)
_ArrayAdd($ModeGroup, $11)
_ArrayAdd($ModeGroup, $12)
_ArrayAdd($ModeGroup, $GraphicBoarder)
_ArrayAdd($ModeGroup, $NewGraphicColor)
_ArrayAdd($ModeGroup, $NewChangeColor)
_ArrayAdd($ModeGroup, $NewGraphicBkColor)
_ArrayAdd($ModeGroup, $NewChangeBkColor)
_ArrayAdd($ModeGroup, $hDotBtn)
_ArrayAdd($ModeGroup, $hPixelBtn)
_ArrayAdd($ModeGroup, $hLineBtn)
_ArrayAdd($ModeGroup, $hBezierBtn)
_ArrayAdd($ModeGroup, $hRectBtn)
_ArrayAdd($ModeGroup, $hEllipseBtn)
_ArrayAdd($ModeGroup, $hPieBtn)
_ArrayAdd($ModeGroup, $ModeCloseBtn)
_ArrayAdd($ModeGroup, $hTopBoarder)
_ArrayAdd($ModeGroup, $hBottomBoarder)
_ArrayAdd($ModeGroup, $hLeftBoarder)
_ArrayAdd($ModeGroup, $hRightBoarder)
_ArrayAdd($ModeGroup, $hUpdateGraphic)
_ArrayAdd($ModeGroup, $hParamColor)
_ArrayAdd($ModeGroup, $hParamBkColor)
_ArrayAdd($ModeGroup, $SaveGraphicButton)
$ModeGroup[0] += 50
_GUIScrollbars_Generate($GUIHolder, 2000, 1500)
DllCall($dll, "int", "SetParent", "hwnd", WinGetHandle($GUIHolder), "hwnd", WinGetHandle($hGUI))
#EndRegion
#Region Edit GUI
$EditGUI = GUICreate("New Window", 1000, 1000, 75, 40, BitOR($WS_CAPTION, $WS_SIZEBOX))
$TabTop = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
GUICtrlSetBkColor(-1, $InsertColor)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$TabBottom = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
GUICtrlSetBkColor(-1, $InsertColor)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$TabLeft = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
GUICtrlSetBkColor(-1, $InsertColor)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$TabRight = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
GUICtrlSetBkColor(-1, $InsertColor)
GUICtrlSetState(-1, $GUI_HIDE)
GUICtrlSetResizing(-1, 802)
$SnapLineX = GUICtrlCreateLabel("", -5, -5, 1, 1)
GUICtrlSetBkColor(-1, 0xFF00FF)
$SnapLineY = GUICtrlCreateLabel("", -5, -5, 1, 1)
GUICtrlSetBkColor(-1, 0xFF00FF)
$SnapLineW = GUICtrlCreateLabel("", -5, -5, 1, 1)
GUICtrlSetBkColor(-1, 0xFF00FF)
$SnapLineH = GUICtrlCreateLabel("", -5, -5, 1, 1)
GUICtrlSetBkColor(-1, 0xFF00FF)
GUISetState(@SW_HIDE, $EditGUI)
GUIRegisterMsg($WM_SIZING, "WM_SIZING")
GUIRegisterMsg($WM_SYSCOMMAND, "WM_SYSCOMMAND")

Global $hPen, $hBrush

$hGraphic = _GDIPlus_GraphicsCreateFromHWND($EditGUI)
$hPen = _GDIPlus_PenCreate(0xFF3399FF)
$hBrush = _GDIPlus_BrushCreateSolid(0x113399FF)
WinMove($EditGUI, "", 50, 50, 484, 362)

_ArrayAdd($GUIPlus, $hGraphic)
$GUIPlus[0] += 1
_ArrayAdd($GUIScript, "")
_ArrayAdd($GUIVars, "")
_ArrayAdd($GUIs, $EditGUI)
_ArrayAdd($GUIColors, "")
_ArrayAdd($GUIComment, "")
_ArrayAdd($GUIStyle, "")
_ArrayAdd($GUIMenus, "")
_ArrayAdd($GUIProperties, "P1")
_ArrayAdd($GUIX, "-1")
_ArrayAdd($GUIY, "-1")
_ArrayAdd($GUISnapLineX, $SnapLineX)
_ArrayAdd($GUISnapLineY, $SnapLineY)
_ArrayAdd($GUISetStateData, "")
_ArrayAdd($GUIParent, "0")
$GUIParent[0] += 1
$GUISetStateData[0] += 1
$GUIStyle[0] += 1
$GUISnapLineX[0] += 1
$GUISnapLineY[0] += 1
$GUIX[0] += 1
$GUIY[0] += 1
$GUIProperties[0] += 1
$GUIMenus[0] += 1
$GUIComment[0] += 1
$GUIScript[0] += 1
$GUIVars[0] += 1
$GUIColors[0] += 1
$GUIs[0] += 1
Global $CurrentWindow = 1, $WindowCount = 1
Global $WindowNum = 1
DllCall($dll, "int", "SetParent", "hwnd", WinGetHandle($EditGUI), "hwnd", WinGetHandle($GUIHolder))
GUISetState(@SW_SHOW, $EditGUI)
#EndRegion
If $ScriptColorScheme <> "Default" Then
	_SetRESHAutoItColors()
EndIf
_ClearControlData()
_SetScriptData()

$hStub_KeyProc = DllCallbackRegister("_KeyProc", "long", "int;wparam;lparam")
$hmod = _WinAPI_GetModuleHandle(0)
$hHook = _WinAPI_SetWindowsHookEx($WH_KEYBOARD_LL, DllCallbackGetPtr($hStub_KeyProc), $hmod)

If $Debug = "True" Then
	$hDebugWin = GUICreate( "Debug", 623, 127, 0, 297)
	$hBkGround = GUICtrlCreateLabel("", 4, 4, 615, 120)
	GUICtrlSetState( -1, $GUI_DISABLE)
	GUICtrlSetBkColor( -1, 0xD0D0D0)
	$hDebugList = GUICtrlCreateListView( "[                   ]", 5, 5, 613, 118, bitor($LVS_NOCOLUMNHEADER, $LVS_SHOWSELALWAYS))
	_GUICtrlListView_AddColumn($hDebugList, "DEBUG LIST VIEW               ", 550)
	_GUICtrlListView_SetColumnWidth($hDebugList, 0, 70)
	_GUICtrlListView_SetColumnWidth($hDebugList, 1, 500)
	GUISetState(@SW_HIDE)
	DllCall($dll, "int", "SetParent", "hwnd", WinGetHandle($hDebugWin), "hwnd", WinGetHandle($GUIHolder))
	GUISetState(@SW_SHOW)
	_DebugAdd("Debug Started", $NoErrorColor)
EndIf
$hDirCut = StringSplit($AutoItDir, "\")
Dim $hHelpDir = ""
For $i = 1 to $hDirCut[0]-1 Step 1
	$hHelpDir &= $hDirCut[$i]&"\"
Next
$hHelpDir &= "AutoIt3.chm"
GUISetHelp($hHelpDir, $hGUI)
If $LoadLast = "True" Then
	_OpenScript($LastLoaded, -1)
EndIf

$hScriptTimer = TimerInit()
$hTypeTimer = TimerInit()

While 1
	If TimerDiff($hKeyTimer) > 1500 Then
		$hUserTyping = False
	Else
		If _WinAPI_GetFocus() = $ScriptEdit Then
			$hUserTyping = True
		EndIf
	EndIf
	If _IsPressed("01") Then
		$hMousePos = GUIGetCursorInfo($hGUI)
		If $hMousePos[0] >= 191 and $hMousePos[1] >= $ResizeDivider+3 and $hMousePos[0] <= $Width-215 and $hMousePos[1] <= $Height Then
			If GUICtrlGetState($HandleInput) <> $GUI_DISABLE Then
				_HideAllResizeTabs()
				$SelectedControl = 0
				$MultiSelect = False
				Dim $MultiControls[1] = [0]
				_ClearControlData()
				_DeselectControls()
				_WinAPI_SetFocus($ScriptEdit)
			EndIf
		EndIf
	EndIf
	#Region RichEdit Manipulation
	If _IsPressed("09") Then ; Tab
		_GUICtrlRichEdit_InsertText($ScriptEdit, "	")
		Do
			Sleep(50)
		Until Not _IsPressed(09)
		_WinAPI_SetFocus($ScriptEdit)
	EndIf
	If _IsPressed("08") Then ; Backspace
		If _WinAPI_GetFocus() = $ScriptEdit Then
			$hSel = _GUICtrlRichEdit_GetSel($ScriptEdit)
			$hDeletedLine = _GUICtrlRichEdit_GetLineNumberFromCharPos($ScriptEdit, $hSel[0])+1
			If $LineCount <> _GUICtrlRichEdit_GetLineCount($ScriptEdit)-1 Then
				If $hDeletedLine <= $IncludeRange Then
					Send('{ENTER}')
				EndIf
				If $hDeletedLine > $IncludeRange and $hDeletedLine <= $GUIRange Then
					$GUIRange -= 1
					$StateRange -= 1
					$WhileRange -= 1
					$EndSwitchRange -= 1
					$WEndRange -= 1
				ElseIf $hDeletedLine > $StateRange and $hDeletedLine <= $WhileRange Then
					$WhileRange -= 1
					$EndSwitchRange -= 1
					$WEndRange -= 1
				ElseIf $hDeletedLine > $EndSwitchRange and $hDeletedLine <= $WEndRange Then
					$WEndRange -= 1
				EndIf
				_WinAPI_SetFocus($hGUI)
				Do
					Sleep(50)
				Until Not _IsPressed("08")
				_WinAPI_SetFocus($ScriptEdit)
			EndIf
		EndIf
	EndIf
	If _IsPressed("0D") Then ; Enter
		If _WinAPI_GetFocus() = $ScriptEdit Then
			$hSel = _GUICtrlRichEdit_GetSel($ScriptEdit)
			$hAddedLine = _GUICtrlRichEdit_GetLineNumberFromCharPos($ScriptEdit, $hSel[0])
			If Not @Error Then
				If _GUICtrlRichEdit_GetLineLength($ScriptEdit, $hAddedLine) <> 0 Then
					If _GUICtrlRichEdit_GetLineLength($ScriptEdit, $hAddedLine-1) = 0 Then
						$hAddedLine -= 1
					EndIf
				EndIf
				If $hAddedLine > $IncludeRange and $hAddedLine <= $GUIRange Then
					$GUIRange += 1
					$StateRange += 1
					$WhileRange += 1
					$EndSwitchRange += 1
					$WEndRange += 1
				ElseIf $hAddedLine > $StateRange and $hAddedLine <= $WhileRange Then
					$WhileRange += 1
					$EndSwitchRange += 1
					$WEndRange += 1
				ElseIf $hAddedLine > $EndSwitchRange and $hAddedLine <= $WEndRange Then
					$WEndRange += 1
					_GUICtrlRichEdit_InsertText($ScriptEdit, "	")
				ElseIf $hAddedLine = $StateRange Then
					$StateRange += 1
					$WhileRange += 1
					$EndSwitchRange += 1
					$WEndRange += 1
					$WritingLine = $hAddedLine
					$WritingControl = True
				Else
					If BitAnd(WinGetState($hGUI), 8) Then
						_GUICtrlRichEdit_SetSel($ScriptEdit, $hSel-1, $hSel, True)
						Send('{DELETE}')
					EndIf
				EndIf
			EndIf
			Do
				Sleep(50)
			Until Not _IsPressed("0D")
		EndIf
	EndIf
	If _WinAPI_GetFocus() = $ScriptEdit Then
		If $hUserTyping = False Then
			$hCodeRead = StringTrimRight(_GUICtrlRichEdit_GetText($ScriptEdit, True), 2)
			If $hScriptData <> $hCodeRead Then
				$hBeforeSplit = StringSplit($hScriptData, @CRLF, 1)
				$hAfterSplit = StringSplit($hCodeRead, @CRLF, 1)
				$hScriptData = $hCodeRead
				Dim $ItemIndex = 0
				Dim $hGUILine = 0
				Dim $hCtrlId = 0, $hGUIId = 0
				Dim $SetStateWait = False
				For $i = 1 to $hAfterSplit[0] Step 1
					If $hBeforeSplit[0] >= $i Then
						If $hBeforeSplit[$i] <> $hAfterSplit[$i] Then
							If StringinStr($hAfterSplit[$i], "GUICreate") Then
								If StringinStr($hAfterSplit[$i], "(") and StringinStr($hAfterSplit[$i], ")") Then
									Dim $hGUIId = 0
									For $b = 1 to $i Step 1
										If StringinStr($hAfterSplit[$b], "GUICreate") Then
											$hGUIId += 1
										EndIf
									Next
									If $hGUIId <> 0 Then
										$hBeforeCommaSplit = StringSplit($hBeforeSplit[$i], ", ", 1)
										$hCommaSplit = StringSplit($hAfterSplit[$i], ", ", 1)
										If $hCommaSplit[0] = 5 Then
											$hCtrlPos = WinGetClientSize( $GUIS[$hGUIId] )
											$hHolderPos = WinGetPos($GUIHolder)
											$hCtrlDataSplit = StringSplit($hCommaSplit[1], "( ", 1)
											If StringinStr($hCommaSplit[1], "=") Then
												$hEqualSplit = StringSplit($hCommaSplit[1], " = ", 1)
												If StringTrimLeft($hEqualSplit[1], 1) <> $GUIHandles[$hGUIId] Then
													For $b = 1 to $Parents[0] Step 1
														If $Parents[$b] = $GUIHandles[$hGUIId] Then
															$Parents[$b] = StringTrimLeft($hEqualSplit[1], 1)
														EndIf
													Next
													$GUIHandles[$hGUIId] = StringTrimLeft($hEqualSplit[1], 1)
													_GUICtrlTreeView_SetText($hTree, $GUITrees[$hGUIId], $GUIHandles[$hGUIId])
												EndIf
											EndIf
											If StringTrimRight(StringTrimLeft($hCtrlDataSplit[2], 1), 1) <> $WinTitles[$hGUIId] Then
												$WinTitles[$hGUIId] = StringTrimRight(StringTrimLeft($hCtrlDataSplit[2], 1), 1)
												WinSetTitle($GUIS[$hGUIId], "", $WinTitles[$hGUIId])
											EndIf
											If $GUIX[$hGUIId] <> $hCommaSplit[4] Then
												$GUIX[$hGUIId] = $hCommaSplit[4]
											ElseIf $GUIY[$hGUIId] <> StringTrimRight($hCommaSplit[5], 1) Then
												$GUIY[$hGUIId] = StringTrimRight($hCommaSplit[5], 1)
											ElseIf $hCtrlPos[0] <> $hCommaSplit[2] Then
												WinMove( $GUIS[$hGUIId], "", $hCtrlPos[0]-$hHolderPos[0], $hCtrlPos[1]-$hHolderPos[1], $hCommaSplit[2], $hCtrlPos[1])
											ElseIf $hCtrlPos[1] <> $hCommaSplit[3] Then
												WinMove( $GUIS[$hGUIId], "", $hCtrlPos[0]-$hHolderPos[0], $hCtrlPos[1]-$hHolderPos[1], $hCtrlPos[0], $hCommaSplit[3])
											EndIf
										EndIf
									EndIf
								EndIf
							EndIf
							If StringinStr($hAfterSplit[$i], "GUICtrlCreate") or StringinStr($hAfterSplit[$i], "_GDIPlus_GraphicsCreateFromHWND") or StringinStr($hAfterSplit[$i], "_GUICtrlRichEdit_Create") or StringinStr($hAfterSplit[$i], "_GUIScrollBars_Create") Then
								If StringinStr($hAfterSplit[$i], "(") and StringinStr($hAfterSplit[$i], ")") Then
									Dim $hCtrlId = 0
									For $b = 1 to $i Step 1
										If StringinStr($hAfterSplit[$b], "GUICtrlCreate") or StringinStr($hAfterSplit[$b], "_GDIPlus_GraphicsCreateFromHWND") or StringinStr($hAfterSplit[$b], "_GUICtrlRichEdit_Create") or StringinStr($hAfterSplit[$b], "_GUIScrollBars_Create") Then
											$hCtrlId += 1
										EndIf
									Next
									If $hCtrlId <> 0 Then
										If $Types[$hCtrlId] = 26 Then
											If StringinStr($hAfterSplit[$i], " = ") Then
												$hEqualSplit = StringSplit($hAfterSplit[$i], " = ", 1)
												If StringTrimLeft($hEqualSplit[1], 1) <> $Names[$hCtrlId] Then
													$Names[$hCtrlId] = StringTrimLeft($hEqualSplit[1], 1)
													_GUICtrlTreeView_SetText($hTree, $TreeItems[$hCtrlId], $Names[$hCtrlId])
												EndIf
											EndIf
										EndIf
										$hBeforeCommaSplit = StringSplit($hBeforeSplit[$i], ", ", 1)
										$hCommaSplit = StringSplit($hAfterSplit[$i], ", ", 1)
										If $hCommaSplit[0] = 5 Then
											If $hCtrlId <= $Controls[0] Then
												$hCtrlPos = ControlGetPos( "", "", $Controls[$hCtrlId])
												If Not @Error Then
													$hCtrlDataSplit = StringSplit($hCommaSplit[1], "( ", 1)
													If StringinStr($hCommaSplit[1], " = ") Then
														$hEqualSplit = StringSplit($hCommaSplit[1], " = ", 1)
														If StringTrimLeft($hEqualSplit[1], 1) <> $Names[$hCtrlId] Then
															$Names[$hCtrlId] = StringTrimLeft($hEqualSplit[1], 1)
															_GUICtrlTreeView_SetText($hTree, $TreeItems[$hCtrlId], $Names[$hCtrlId])
														EndIf
													EndIf
													If StringTrimRight(StringTrimLeft($hCtrlDataSplit[2], 1), 1) <> $Data[$hCtrlId] Then
														$Data[$hCtrlId] = StringTrimRight(StringTrimLeft($hCtrlDataSplit[2], 1), 1)
														GUICtrlSetData($Controls[$hCtrlId], $Data[$hCtrlId])
													EndIf
													If $hCtrlPos[0] <> $hCommaSplit[2] Then
														ControlMove( "", "", $Controls[$hCtrlId], $hCommaSplit[2], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
													ElseIf $hCtrlPos[1] <> $hCommaSplit[3] Then
														ControlMove( "", "", $Controls[$hCtrlId], $hCtrlPos[0], $hCommaSplit[3], $hCtrlPos[2], $hCtrlPos[3])
													ElseIf $hCtrlPos[2] <> $hCommaSplit[4] Then
														ControlMove( "", "", $Controls[$hCtrlId], $hCtrlPos[0], $hCtrlPos[1], $hCommaSplit[4], $hCtrlPos[3])
													ElseIf $hCtrlPos[3] <> StringTrimRight($hCommaSplit[5], 1) Then
														ControlMove( "", "", $Controls[$hCtrlId], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], StringTrimRight($hCommaSplit[5], 1))
													EndIf
													_MoveResizeTabs($Controls[$hCtrlId])
													If $SelectedControl <> 0 Then
														_SetControlData($Controls[$hCtrlId])
													EndIf
												EndIf
											EndIf
										ElseIf $hCommaSplit[0] = 4 Then
											If $hCtrlId <= $Controls[0] Then
												$hCtrlPos = ControlGetPos( "", "", $Controls[$hCtrlId])
												If Not @Error Then

													If StringinStr($hAfterSplit[$i], " = ") Then
														$hEqualSplit = StringSplit($hAfterSplit[$i], " = ", 1)
														If StringTrimLeft($hEqualSplit[1], 1) <> $Names[$hCtrlId] Then
															$Names[$hCtrlId] = StringTrimLeft($hEqualSplit[1], 1)
															_GUICtrlTreeView_SetText($hTree, $TreeItems[$hCtrlId], $Names[$hCtrlId])
														EndIf
													EndIf
													$hCtrlDataSplit = StringSplit($hCommaSplit[1], "( ", 1)
													If $hCtrlPos[0] <> $hCtrlDataSplit[2] Then
														ControlMove( "", "", $Controls[$hCtrlId], $hCtrlDataSplit[2], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
													ElseIf $hCtrlPos[1] <> $hCommaSplit[2] Then
														ControlMove( "", "", $Controls[$hCtrlId], $hCtrlPos[0], $hCommaSplit[2], $hCtrlPos[2], $hCtrlPos[3])
													ElseIf $hCtrlPos[2] <> $hCommaSplit[3] Then
														ControlMove( "", "", $Controls[$hCtrlId], $hCtrlPos[0], $hCtrlPos[1], $hCommaSplit[3], $hCtrlPos[3])
													ElseIf $hCtrlPos[3] <> StringTrimRight($hCommaSplit[4], 1) Then
														ControlMove( "", "", $Controls[$hCtrlId], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], StringTrimRight($hCommaSplit[4], 1))
													EndIf
													_MoveResizeTabs($Controls[$hCtrlId])
													_SetControlData($Controls[$hCtrlId])
												EndIf
											EndIf
										EndIf
									EndIf
								EndIf
							EndIf
							If StringinStr($hAfterSplit[$i], "GUICtrlSetData( -1,") Then
								Dim $hCtrlId = 0
								For $c = $i to 1 Step -1
									If StringinStr($hAfterSplit[$c], "GUICtrlCreate") Then
										For $b = 1 to $ControlIndexes[0] Step 1
											$hSplit = StringSplit($ControlIndexes[$b], "|")
											If $hSplit[2] = $c Then
												$hCtrlId = $hSplit[1]
											EndIf
										Next
									EndIf
								Next
							EndIf
							If StringinStr($hAfterSplit[$i], "GUISetState(") Then
								Dim $hGUIID = 0
								For $c = 1 to $i Step 1
									If StringinStr($hAfterSplit[$c], "GUICreate(") Then
										$hGUIID += 1
									EndIf
								Next
								$GUISetStateData[$hGUIID] = StringTrimRight(StringTrimLeft( $hAfterSplit[$i], 12), 1)
							EndIf
							If StringinStr($hAfterSplit[$i], "While ") Then
								$WhileData = StringTrimLeft($hAfterSplit[$i], 6)
							EndIf
							If $WritingControl = True Then
								If $i = $WritingLine Then
									$WritingCtrlData = $hAfterSplit[$i]
								EndIf
								If StringinStr($WritingCtrlData, "GUICtrlCreate") and StringinStr($WritingCtrlData, "(") and StringinStr($WritingCtrlData, ")") Then
									;$StateRange += 1
									;$WhileRange += 1
									;$EndSwitchRange += 1
									;$WEndRange += 1
									dim $ParentCount = 0
									For $c = $i to 1 Step -1
										If StringinStr($hAfterSplit[$c], "GUICreate") Then
											$ParentCount += 1
										EndIf
									Next
									_ImportClipboard($WritingCtrlData&@CRLF, $ParentCount)
									$WritingControl = False
									$WritingLine = 0
									$WritingCtrlData = ''
									_SetScriptData()
								EndIf
							EndIf
						EndIf
					EndIf
				Next
				For $i = 1 to $hAfterSplit[0] Step 1
					If StringLeft($hAfterSplit[$i], 6) = "While " Then
						$WhileRange = $i
					EndIf
				Next
				Dim $AfterData = ''
				For $c = $StateRange+1 to $WhileRange-1 Step 1
					If $c <> $WhileRange-1 Then
						$AfterData &= $hAfterSplit[$c]&@CRLF
					Else
						$AfterData &= $hAfterSplit[$c]
					EndIf
				Next
				$AfterGUIData = $AfterData

				Dim $BeforeData = ''
				For $c = $IncludeRange+1 to $GUIRange-1 Step 1
					If $c <> $GUIRange-1 Then
						$BeforeData &= $hAfterSplit[$c]&@CRLF
					Else
						$BeforeData &= $hAfterSplit[$c]
					EndIf
				Next
				$ExtraIncludeData = $BeforeData

				Dim $BeforeData = ''
				For $c = $EndSwitchRange+1 to $WEndRange-1 Step 1
					If $hAfterSplit[$c] <> "" Then
						If $c <> $WEndRange-1 Then
							$BeforeData &= $hAfterSplit[$c]&@CRLF
						Else
							$BeforeData &= $hAfterSplit[$c]
						EndIf
					EndIf
				Next
				$ExtraWhileData = $BeforeData&@CRLF
				#cs
				Dim $BeforeData = ''
				For $c = $WEndRange+1 to $hAfterSplit[0] Step 1
					If $c <> $hAfterSplit[0] Then
						$BeforeData &= $hAfterSplit[$c]&@CRLF
					Else
						$BeforeData &= $hAfterSplit[$c]
					EndIf
				Next
				$GUIScript[$CurrentWindow] = $BeforeData
				#ce
				_GUICtrlRichEdit_PauseRedraw($ScriptEdit)
				$hScroll = _GUICtrlRichEdit_GetScrollPos($ScriptEdit)
				$hSel = _GUICtrlRichEdit_GetSel($ScriptEdit)
				$hScriptData = _GenerateCode()
				_GUICtrlRichEdit_SetText($ScriptEdit, $hScriptData)
				_RESH_SyntaxHighlight($ScriptEdit, '_UpdateStats')
				_GUICtrlRichEdit_SetSel($ScriptEdit, $hSel[0], $hSel[1])
				_GUICtrlRichEdit_SetScrollPos($ScriptEdit, $hScroll[0], $hScroll[1])
				_GUICtrlRichEdit_ResumeRedraw($ScriptEdit)
				_WinAPI_SetFocus($ScriptEdit)
			EndIf
		EndIf
	EndIf
	#EndRegion
	For $i = 1 to $GUIS[0] Step 1
		If BitAnd(WinGetState($GUIS[$i]), 8) Then
			$CurrentWindow = $i
		EndIf
	Next
	If $UndoLog <> $UndoTemp Then
		$UndoTemp = $UndoLog
	EndIf
	$hLinePos = ControlGetPos($hGUI, "", $BottomLine)
	$ResizeDivider = $hLinePos[1]
	If $WasMax = False And BitAND(WinGetState($hGUI), 32) Then
		$MaximizeControls = True
	EndIf
	If $MaximizeControls = True Then ; Script Divider Resize
		$MaximizeControls = False
		If $WasMax = True Then
			$PreviousResizeDiv = $ResizeDivider
			$wPos = WinGetPos($hGUI)
			$PreviousResizeWidth = $Width
			$PreviousResizeHeight = $Height
			$hPos = ControlGetPos("", "", $ScriptEdit)
			$hLinePos = ControlGetPos($hGUI, "", $BottomLine)
			_WinAPI_SetWindowPos($ScriptEdit, 0, $hPos[0], $hLinePos[1] + 2, $hLinePos[2] - 38, $hPos[3], $SWP_NOZORDER)
			$ResizeDivider = $hLinePos[1]
			$Width = @DesktopWidth
			$Height = @DesktopHeight
			WinMove($GUIHolder, "", 152, 52, $Width - 352, $hLinePos[1] - 52)
		Else
			$WasMax = True
			$wPos = WinGetPos($hGUI)
			$hPos = ControlGetPos("", "", $ScriptEdit)
			$hLinePos = ControlGetPos($hGUI, "", $BottomLine)
			_WinAPI_SetWindowPos($ScriptEdit, 0, $hPos[0], $hLinePos[1] + 2, $hLinePos[2] - 38, $hPos[3], $SWP_NOZORDER)
			$ResizeDivider = $hLinePos[1]
			$Width = $PreviousResizeWidth
			$Height = $PreviousResizeHeight
			WinMove($GUIHolder, "", 152, 52, $hLinePos[2], $hLinePos[1] - 52)
			WinMove($GUIs[$CurrentWindow], "", 20, 20)
		EndIf
	EndIf
	#Region Hotkeys
	If _IsPressed("0D") Then ; Enter
		If $GUIFocusIndex <> 0 Then
			$ClientPos = WinGetClientSize($GUIs[$GUIFocusIndex])
			$ControlInfo = WinGetPos($GUIs[$GUIFocusIndex])
			$ClientW = ($ControlInfo[2] - $ClientPos[0])
			$ClientH = ($ControlInfo[3] - $ClientPos[1])
			$GUIXPos = GUICtrlRead($XPosInput)
			$GUIYPos = GUICtrlRead($YPosInput)
			$wPos = GUICtrlRead($WInput)
			$hPos = GUICtrlRead($HInput)
			$Color = GUICtrlRead($ColorInput)
			$BkColor = GUICtrlRead($BkColorInput)
			$Name = GUICtrlRead($HandleInput)
			$rData = GUICtrlRead($DataInput)
			If $wPos <> $ClientPos[0] And $hPos <> $ClientPos[1] Then
				If $GUIParent[$GUIFocusIndex] <> "0" Then
					WinMove($GUIs[$GUIFocusIndex], "", $GUIXPos, $GUIYPos, $wPos + $ClientW, $hPos + $ClientH)
				Else
					WinMove($GUIs[$GUIFocusIndex], "", 50, 50, $wPos + $ClientW, $hPos + $ClientH)
				EndIf
			ElseIf $wPos <> $ClientPos[0] Then
				If $GUIParent[$GUIFocusIndex] <> "0" Then
					WinMove($GUIs[$GUIFocusIndex], "", $GUIXPos, $GUIYPos, $wPos + $ClientW, $hPos + $ClientH)
				Else
					WinMove($GUIs[$GUIFocusIndex], "", 50, 50, $wPos + $ClientW, $ControlInfo[3])
				EndIf
			ElseIf $hPos <> $ClientPos[1] Then
				If $GUIParent[$GUIFocusIndex] <> "0" Then
					WinMove($GUIs[$GUIFocusIndex], "", $GUIXPos, $GUIYPos, $wPos + $ClientW, $hPos + $ClientH)
				Else
					WinMove($GUIs[$GUIFocusIndex], "", 50, 50, $ControlInfo[2], $hPos + $ClientH)
				EndIf
			EndIf
			If $BkColor <> $GUIColors[$GUIFocusIndex] Then
				GUISetBkColor('0x' & $BkColor, $GUIs[$GUIFocusIndex])
				$GUIColors[$GUIFocusIndex] = $BkColor
			EndIf
			If $GUIHandles[$GUIFocusIndex] <> $Name Then
				Dim $Exists = False
				For $i = 1 to $GUIHandles[0] Step 1
					If $GUIHandles[$i] = $Name Then
						$Exists = True
					EndIf
				Next
				If $Exists = False Then
					For $i = 1 to $Parents[0] Step 1
						If $Parents[$i] = $GUIHandles[$GUIFocusIndex] Then
							$Parents[$i] = $Name
						EndIf
					Next
					$GUIHandles[$GUIFocusIndex] = $Name
					_GUICtrlTreeView_SetText($hTree, $hTreeGUI, $Name)
				Else
					MsgBox( 0, "GUI Handle", "GUI Handles must be Unique.")
				EndIf
			EndIf
			If $WinTitles[$GUIFocusIndex] <> $rData Then
				WinSetTitle($GUIs[$GUIFocusIndex], "", $rData)
				$WinTitles[$GUIFocusIndex] = $rData
			EndIf
			If $GUIX[$GUIFocusIndex] <> $GUIXPos and $GUIY[$GUIFocusIndex] <> $GUIYPos Then
				$GUIX[$GUIFocusIndex] = $GUIXPos
				$GUIY[$GUIFocusIndex] = $GUIYPos
				If $GUIParent[$GUIFocusIndex] <> "0" Then
					WinMove($GUIS[$GUIFocusIndex], "", $GUIX[$GUIFocusIndex], $GUIY[$GUIFocusIndex])
				EndIf
			ElseIf $GUIX[$GUIFocusIndex] <> $GUIXPos Then
				$GUIX[$GUIFocusIndex] = $GUIXPos
				If $GUIParent[$GUIFocusIndex] <> "0" Then
					WinMove($GUIS[$GUIFocusIndex], "", $GUIX[$GUIFocusIndex], $GUIY[$GUIFocusIndex])
				EndIf
			ElseIf $GUIY[$GUIFocusIndex] <> $GUIYPos Then
				$GUIY[$GUIFocusIndex] = $GUIYPos
				If $GUIParent[$GUIFocusIndex] <> "0" Then
					WinMove($GUIS[$GUIFocusIndex], "", $GUIX[$GUIFocusIndex], $GUIY[$GUIFocusIndex])
				EndIf
			EndIf
			_SetScriptData()
			Sleep(100)
		EndIf
	EndIf
	If _IsPressed("2E") Then ; Delete
		If BitAND(WinGetState($GUIs[$CurrentWindow]), 8) or BitAND(WinGetState($hGUI), 8) Then
			If $SelectedControl <> 0 Then
				$hIndex = _GetIndex($SelectedControl)
				_DebugAdd("Control["&$hIndex&"] Deleted", $NoErrorColor)
				$hPos = ControlGetPos($GUIS[$CurrentWindow], "", $Controls[$hIndex])
				If Not @Error Then
					$UndoLog &= "ß" & "D" &$Names[$hIndex]&"¿"&$Types[$hIndex]&"¿"&$hPos[0]&"¿"&$hPos[1]&"¿"&$hPos[2]&"¿"&$hPos[3]&"¿"&$Colors[$hIndex]&"¿"&$BkColors[$hIndex]&"¿"&$Styles[$hIndex]&"¿"&$States[$hIndex]&"¿"&$Data[$hIndex]&"¿"&$Resize[$hIndex]&"¿"&$Font[$hIndex]&"¿"&$FontInfo[$hIndex]&"¿"&$FontSize[$hIndex]&"¿"&$Layers[$hIndex]&"¿"&$Attributes[$hIndex]&"¿"&$Images[$hIndex]&"¿"&$Cursors[$hIndex]&"¿"&$Functions[$hIndex]&"¿"&$Comments[$hIndex]&"¿"&$Locked[$hIndex]&"¿"&$Parents[$hIndex]
				Else
					_DebugAdd("Undo Log Writing Error, Control["&$hIndex&"], ["&$Controls[0]&"]", $ErrorColor)
				EndIf
				GUICtrlDelete($SelectedControl)
				_DeleteResizeTabs($SelectedControl)
				_DeleteControl($hIndex)
				_GUICtrlTreeView_Delete($hTree, $TreeItems[$hIndex])
				_ArrayDelete($TreeItems, $hIndex)
				$TreeItems[0] -= 1
				_HideAllResizeTabs()
				_ClearControlData()
				$SelectedControl = 0
				_SetScriptData()
			ElseIf $MultiSelect = True Then
				For $i = 1 To $MultiControls[0] Step 1
					$hIndex = _GetIndex($MultiControls[$i])
					_DebugAdd("Control["&$hIndex&"] Deleted", $NoErrorColor)
					_DeleteResizeTabs($Controls[$hIndex])
					_DeleteControl($hIndex)
					_GUICtrlTreeView_Delete($hTree, $TreeItems[$hIndex])
					_ArrayDelete($TreeItems, $hIndex)
					$TreeItems[0] -= 1
				Next
				_HideAllResizeTabs()
				Dim $MultiSelect = False, $MultiControls[1] = [0]
				_SetScriptData()
			ElseIf StringinStr($SelectedControl, "Scroll") Then
				For $i = $Controls[0] to 1 Step -1
					If $Controls[$i] = "Scroll"&$CurrentWindow Then
						$hIndex = $i
						_DebugAdd("Control["&$hIndex&"] Deleted", $NoErrorColor)
						$hPos = ControlGetPos($GUIS[$CurrentWindow], "", $Controls[$hIndex])
						If Not @Error Then
							$UndoLog &= "ß" & "D" &$Names[$hIndex]&"¿"&$Types[$hIndex]&"¿"&$hPos[0]&"¿"&$hPos[1]&"¿"&$hPos[2]&"¿"&$hPos[3]&"¿"&$Colors[$hIndex]&"¿"&$BkColors[$hIndex]&"¿"&$Styles[$hIndex]&"¿"&$States[$hIndex]&"¿"&$Data[$hIndex]&"¿"&$Resize[$hIndex]&"¿"&$Font[$hIndex]&"¿"&$FontInfo[$hIndex]&"¿"&$FontSize[$hIndex]&"¿"&$Layers[$hIndex]&"¿"&$Attributes[$hIndex]&"¿"&$Images[$hIndex]&"¿"&$Cursors[$hIndex]&"¿"&$Functions[$hIndex]&"¿"&$Comments[$hIndex]&"¿"&$Locked[$hIndex]&"¿"&$Parents[$hIndex]
						Else
							_DebugAdd("Undo Log Writing Error, Control["&$hIndex&"], ["&$Controls[0]&"]", $ErrorColor)
						EndIf
						_DeleteResizeTabs($SelectedControl)
						_DeleteControl($hIndex)
						_GUICtrlTreeView_Delete($hTree, $TreeItems[$hIndex])
						_ArrayDelete($TreeItems, $hIndex)
						$TreeItems[0] -= 1
						_HideAllResizeTabs()
						_ClearControlData()
						$SelectedControl = 0
						_SetScriptData()
						ExitLoop
					EndIf
				Next
			ElseIf StringinStr($SelectedControl, "GDI+") Then
				For $i = $Controls[0] to 1 Step -1
					If $Controls[$i] = "GDI+"&$CurrentWindow Then
						$hIndex = $i
						_DebugAdd("Control["&$hIndex&"] Deleted", $NoErrorColor)
						$hPos = ControlGetPos($GUIS[$CurrentWindow], "", $Controls[$hIndex])
						If Not @Error Then
							$UndoLog &= "ß" & "D" &$Names[$hIndex]&"¿"&$Types[$hIndex]&"¿"&$hPos[0]&"¿"&$hPos[1]&"¿"&$hPos[2]&"¿"&$hPos[3]&"¿"&$Colors[$hIndex]&"¿"&$BkColors[$hIndex]&"¿"&$Styles[$hIndex]&"¿"&$States[$hIndex]&"¿"&$Data[$hIndex]&"¿"&$Resize[$hIndex]&"¿"&$Font[$hIndex]&"¿"&$FontInfo[$hIndex]&"¿"&$FontSize[$hIndex]&"¿"&$Layers[$hIndex]&"¿"&$Attributes[$hIndex]&"¿"&$Images[$hIndex]&"¿"&$Cursors[$hIndex]&"¿"&$Functions[$hIndex]&"¿"&$Comments[$hIndex]&"¿"&$Locked[$hIndex]&"¿"&$Parents[$hIndex]
						Else
							_DebugAdd("Undo Log Writing Error, Control["&$hIndex&"], ["&$Controls[0]&"]", $ErrorColor)
						EndIf
						_DeleteResizeTabs($SelectedControl)
						_DeleteControl($hIndex)
						_GUICtrlTreeView_Delete($hTree, $TreeItems[$hIndex])
						_ArrayDelete($TreeItems, $hIndex)
						$TreeItems[0] -= 1
						_HideAllResizeTabs()
						_ClearControlData()
						$SelectedControl = 0
						_SetScriptData()
						ExitLoop
					EndIf
				Next
			EndIf
		EndIf
	EndIf
	If _IsPressed("11") And _IsPressed("41") Then ; Ctrl + A
		If BitAND(WinGetState($GUIs[$CurrentWindow]), 8) or BitAND(WinGetState($hGUI), 8) Then
			$MultiSelect = True
			For $i = 1 To $Controls[0] Step 1
				If _ArraySearch($MultiControls, $Controls[$i]) = -1 Then
					_ArrayAdd($MultiControls, $Controls[$i])
					$MultiControls[0] += 1
					_MoveResizeTabs($Controls[$i])
					_ShowResizeTabs($Controls[$i])
				EndIf
			Next
		EndIf
	EndIf
	If _IsPressed("11") And _IsPressed("44") Then ; Ctrl + D
		If BitAND(WinGetState($GUIs[$CurrentWindow]), 8) or BitAND(WinGetState($hGUI), 8) Then
			_DeselectControls()
		EndIf
	EndIf
	If _IsPressed("11") and _IsPressed("5A") Then ; Ctrl + Z
		If BitAND(WinGetState($GUIs[$CurrentWindow]), 8) or BitAND(WinGetState($hGUI), 8) Then
			If $UndoLog <> "" Then
				$UndoData = $UndoLog
				$hSplit = StringSplit($UndoLog, "ß")
				If IsArray($hSplit) Then
					$UndoLog = StringTrimRight($UndoData, (StringLen($hSplit[$hSplit[0]]) + 1))
					$hDataSplit = StringSplit($hSplit[$hSplit[0]], "¿")
					$hCommand = StringLeft($hSplit[$hSplit[0]], 1)
					Switch $hCommand
						Case "R"
							$hCtrlPos = ControlGetPos( $GUIS[$CurrentWindow], "", $Controls[$hDataSplit[2]])
							$XCompare = $hDataSplit[3]-$hCtrlPos[0]
							$YCompare = $hDataSplit[4]-$hCtrlPos[1]
							GUICtrlSetPos($Controls[$hDataSplit[2]], $hDataSplit[3], $hDataSplit[4], $hDataSplit[5], $hDataSplit[6])
							If $Controls[$hDataSplit[2]] = $SelectedControl Then
								_MoveResizeTabs($SelectedControl)
							EndIf
							If $Types[$hDataSplit[2]] = 13 Then ; Tab Control
								For $i = 1 to $Controls[0] Step 1
									If StringinStr($Attributes[$i],  $Names[$hDataSplit[2]]&"ø") Then
										$hPos = ControlGetPos($GUIS[$CurrentWindow], "", $Controls[$i])
										If Not @Error Then
											GUICtrlSetPos($Controls[$i], $hPos[0]+$xCompare, $hPos[1]+$YCompare)
										Else
											_DebugAdd("Undo Tab Control Error, Control["&$i&"], ["&$Controls[0]&"]", $ErrorColor)
										EndIf
									EndIf
								Next
							ElseIf $Types[$hDataSplit[2]] = 21 Then ; Group Control
								For $i = 1 to $Controls[0] Step 1
									If $Attributes[$i] = $Names[$hDataSplit[2]]&"Ð" Then
										$hPos = ControlGetPos($GUIS[$CurrentWindow], "", $Controls[$i])
										If Not @Error Then
											GUICtrlSetPos($Controls[$i], $hPos[0]+$xCompare, $hPos[1]+$YCompare)
										Else
											_DebugAdd("Undo Group Control Error, Control["&$i&"], ["&$Controls[0]&"]", $ErrorColor)
										EndIf
									EndIf
								Next
							EndIf
						Case "C"
							GUICtrlDelete($Controls[$hDataSplit[2]])
							_DeleteResizeTabs($Controls[$hDataSplit[2]])
							_DeleteControl($hDataSplit[2])
							_GUICtrlTreeView_Delete($hTree, $TreeItems[$hDataSplit[2]])
							_ArrayDelete($TreeItems, $hDataSplit[2])
							$TreeItems[0] -= 1
							_HideAllResizeTabs()
							_ClearControlData()
							$SelectedControl = 0
						Case "D"
							$hDeleteSplit = StringSplit($hSplit[$hSplit[0]], "¿")
							$hCtrlNum = _CreateControl($hDeleteSplit)
						Case "M"
							For $i = 2 to $hDataSplit[0] Step 1
								If StringinStr($hDataSplit[$i], "Ü") Then
									$hCtrlSplit = StringSplit($hDataSplit[$i], "Ü")
									GUICtrlSetPos($Controls[$hCtrlSplit[1]], $hCtrlSplit[2], $hCtrlSplit[3])
									_MoveResizeTabs($Controls[$hCtrlSplit[1]])
								EndIf
							Next
					EndSwitch
				EndIf
			EndIf
			_SetScriptData()
			Sleep(100)
		EndIf
	EndIf
	#EndRegion
	For $i = 1 to $GUIS[0] Step 1
		If $GUIParent[$i] <> "0" Then
			For $b = 1 to $GUIS[0] Step 1
				If $GUIParent[$i] = $GUIHandles[$b] Then
					$hhIndex = $b
				EndIf
			Next
			$hParentPos = WinGetPos($GUIS[$hhIndex])
			$hWinPos = WinGetPos($GUIS[$i])
			If Not @Error Then
				$hParentClient = WinGetClientSize($GUIS[$hhIndex])
				$hClientX = ($hParentPos[2]-$hParentClient[0])/2
				$hClientY = ($hParentPos[3]-$hParentClient[1])-$hClientX
				If $GUIX[$i] <> $hWinPos[0]-$hParentPos[0]-$hClientX or $GUIY[$i] <> $hWinPos[1]-$hParentPos[1]-$hClientY Then
					$GUIX[$i] = $hWinPos[0]-$hParentPos[0]-$hClientX
					$GUIY[$i] = $hWinPos[1]-$hParentPos[1]-$hClientY
					If $GUISelected = True Then
						GUICtrlSetData($XPosInput, $hWinPos[0]-$hParentPos[0]-$hClientX)
						GUICtrlSetData($YPosInput, $hWinPos[1]-$hParentPos[1]-$hClientY)
					EndIf
					_SetScriptData()
				EndIf
			EndIf
		EndIf
	Next
	#Region Case Statements
	$hMsg = GUIGetMsg()
	Switch $hMsg
		Case $hLastFileMenu_1
			$hIniRead = IniRead(@ScriptDir&"/Config.ini", "Vars", "LastFile_1", "")
			If $hIniRead <> "" Then
				_OpenScript($hIniRead, 0)
			EndIf
		Case $hLastFileMenu_2
			$hIniRead = IniRead(@ScriptDir&"/Config.ini", "Vars", "LastFile_2", "")
			If $hIniRead <> "" Then
				_OpenScript($hIniRead, 0)
			EndIf
		Case $hLastFileMenu_3
			$hIniRead = IniRead(@ScriptDir&"/Config.ini", "Vars", "LastFile_3", "")
			If $hIniRead <> "" Then
				_OpenScript($hIniRead, 0)
			EndIf
		Case $hLastFileMenu_4
			$hIniRead = IniRead(@ScriptDir&"/Config.ini", "Vars", "LastFile_4", "")
			If $hIniRead <> "" Then
				_OpenScript($hIniRead, 0)
			EndIf
		Case $hLastFileMenu_5
			$hIniRead = IniRead(@ScriptDir&"/Config.ini", "Vars", "LastFile_5", "")
			If $hIniRead <> "" Then
				_OpenScript($hIniRead, 0)
			EndIf
		Case $GDIPlusMode
			Dim $HasGDIPlus = False
			Dim $hGDIIndex = 0
			For $i = 1 to $Controls[0] Step 1
				If $Types[$i] = 26 and $Parents[$i] = $GUIHandles[$CurrentWindow] Then
					$HasGDIPlus = True
					$hGDIIndex = $i
					ExitLoop
				EndIf
			Next
			If $HasGDIPlus = True Then
				_DebugAdd("GDI+ Mode Started", $NoErrorColor)
				Dim $hSelectControl = $SelectedControl
				_ClearControlData()
				$hClientSize = WinGetClientSize($GUIS[$CurrentWindow])
				$SelectedControl = $hSelectControl
				Dim $ActiveWindows[1] = [0]
				For $i = $GUIS[0] To 1 Step -1
					If BitAND(WinGetState($GUIs[$i]), 2) Then
						WinSetState($GUIs[$i], "", @SW_HIDE)
						_ArrayAdd($ActiveWindows, $i)
						$ActiveWindows[0] += 1
					EndIf
				Next
				For $i = 1 to $Controls[0] Step 1
					If $Controls[$i] = "GDI+"&$CurrentWindow Then
						$hGDIIndex = $i
					EndIf
				Next
				GUICtrlSetState($ModeGroup[18], $GUI_SHOW)
				GUICtrlSetState($ModeGroup[19], $GUI_SHOW)
				GUICtrlSetBkColor($ModeGroup[18], 0xFFA700)
				GUICtrlSetData($ModeGroup[19], "GDI+ Mode")
				_GDIPlusMode($hClientSize[0], $hClientSize[1], $hGDIIndex)
				GUICtrlSetBkColor($ModeGroup[18], 0xD3DAED)
				GUICtrlSetData($ModeGroup[19], "Graphic Mode")
				GUICtrlSetState($ModeGroup[18], $GUI_HIDE)
				GUICtrlSetState($ModeGroup[19], $GUI_HIDE)
				For $i = 1 To $ActiveWindows[0] Step 1
					WinSetState($GUIs[$ActiveWindows[$i]], "", @SW_SHOW)
				Next
				_DrawGDIPlusData( $hGDIIndex, $Data[$hGDIIndex], $GUIS[$CurrentWindow])
				_SetScriptData()
				_GUIScrollbars_EnableScrollBar( $GUIHolder, $SB_BOTH, $ESB_ENABLE_BOTH)
			EndIf
		Case $UndoButton
			If $UndoLog <> "" Then
				$UndoData = $UndoLog
				$hSplit = StringSplit($UndoLog, "ß")
				If IsArray($hSplit) Then
					$hDataSplit = StringSplit($hSplit[$hSplit[0]], "¿")
					$hCommand = StringLeft($hSplit[$hSplit[0]], 1)
					$UndoLog = StringTrimRight($UndoData, (StringLen($hSplit[$hSplit[0]]) + 1))
					Switch $hCommand
						Case "R"
							GUICtrlSetPos($Controls[$hDataSplit[2]], $hDataSplit[3], $hDataSplit[4], $hDataSplit[5], $hDataSplit[6])
							If $Controls[$hDataSplit[2]] = $SelectedControl Then
								_MoveResizeTabs($SelectedControl)
							EndIf
						Case "C"
							GUICtrlDelete($Controls[$hDataSplit[2]])
							_DeleteResizeTabs($Controls[$hDataSplit[2]])
							_DeleteControl($hDataSplit[2])
							_GUICtrlTreeView_Delete($hTree, $TreeItems[$hDataSplit[2]])
							_ArrayDelete($TreeItems, $hDataSplit[2])
							$TreeItems[0] -= 1
							_HideAllResizeTabs()
							_ClearControlData()
							$SelectedControl = 0
						Case "D"
							$hDeleteSplit = StringSplit(StringTrimLeft($hSplit[$hSplit[0]], 1), "¿")
							$hCtrlNum = _CreateControl($hDeleteSplit)
						Case "M"
							For $i = 2 to $hDataSplit[0] Step 1
								If StringinStr($hDataSplit[$i], "Ü") Then
									$hCtrlSplit = StringSplit($hDataSplit[$i], "Ü")
									GUICtrlSetPos($Controls[$hCtrlSplit[1]], $hCtrlSplit[2], $hCtrlSplit[3])
									_MoveResizeTabs($Controls[$hCtrlSplit[1]])
								EndIf
							Next
					EndSwitch
				EndIf
				_SetScriptData()
			EndIf
		Case $hTreeCopy
			GUISetState(@SW_ENABLE, $GUIs[$CurrentWindow])
			Dim $CopyData = ''
			If $MultiSelect = False Then
				If $SelectedControl <> 0 Then
					$ControlInfo = ControlGetPos("", "", $SelectedControl)
					$hIndex = _GetIndex($SelectedControl)
					$hNameText = _TypeToName($Types[$hIndex])
					If Not @error Then
						$CopyData = " "&$hNameText&"¿"&$Types[$hIndex]&"¿"&$ControlInfo[0]&"¿"&$ControlInfo[1]+$ControlInfo[3]+4&"¿"&$ControlInfo[2]&"¿"&$ControlInfo[3]&"¿"&$Colors[$hIndex]&"¿"&$BkColors[$hIndex]&"¿"&$Styles[$hIndex]&"¿"&$States[$hIndex]&"¿"&$Data[$hIndex]&"¿"&$Resize[$hIndex]&"¿"&$Font[$hIndex]&"¿"&$FontInfo[$hIndex]&"¿"&$FontSize[$hIndex]&"¿"&$Layers[$hIndex]&"¿"&$Attributes[$hIndex]&"¿"&$Images[$hIndex]&"¿"&$Cursors[$hIndex]&"¿"&$Functions[$hIndex]&"¿"&$Comments[$hIndex]&"¿"&$Locked[$hIndex]&"¿"&$Parents[$hIndex]
					Else
						_DebugAdd("Copy Error, Control["&$hIndex&"], ["&$Controls[0]&"]", $ErrorColor)
					EndIf
				EndIf
			Else
				For $i = 1 To $MultiControls[0] Step 1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						$hIndex = _GetIndex($MultiControls[$i])
						$hNameText = _TypeToName($Types[$hIndex])
						$CopyData &= "Ö "&$hNameText&"¿"&$Types[$hIndex]&"¿"&$ControlInfo[0]&"¿"&$ControlInfo[1]+$ControlInfo[3]+4&"¿"&$ControlInfo[2]&"¿"&$ControlInfo[3]&"¿"&$Colors[$hIndex]&"¿"&$BkColors[$hIndex]&"¿"&$Styles[$hIndex]&"¿"&$States[$hIndex]&"¿"&$Data[$hIndex]&"¿"&$Resize[$hIndex]&"¿"&$Font[$hIndex]&"¿"&$FontInfo[$hIndex]&"¿"&$FontSize[$hIndex]&"¿"&$Layers[$hIndex]&"¿"&$Attributes[$hIndex]&"¿"&$Images[$hIndex]&"¿"&$Cursors[$hIndex]&"¿"&$Functions[$hIndex]&"¿"&$Comments[$hIndex]&"¿"&$Locked[$hIndex]&"¿"&$Parents[$hIndex]

						;$CopyData &= $Types[$hRef] & "|" & $Names[$hRef] & "|" & $ControlInfo[0] & "|" & $ControlInfo[1] & "|" & $ControlInfo[2] & "|" & $ControlInfo[3] & "|" & $Colors[$hRef] & "|" & $BkColors[$hRef] & "|" & StringReplace($Data[$hRef], "|", "Ç") & "Ö"
					Else
						_DebugAdd("Copy Error, Control["&$hIndex&"], ["&$Controls[0]&"]", $ErrorColor)
					EndIf
				Next
			EndIf
		Case $hTreePaste
			GUISetState(@SW_ENABLE, $GUIs[$CurrentWindow])
			If $CopyData <> "" Then
				_DeselectControls()
				If StringInStr($CopyData, "Ö") Then
					$cSplit = StringSplit($CopyData, "Ö")
					For $i = 1 To $cSplit[0] Step 1
						$hSplit = StringSplit($cSplit[$i], "¿")
						If $hSplit[0] = 23 Then

						EndIf
					Next
					$MultiSelect = True
				Else
					If StringInStr($CopyData, "¿") Then
						$hSplit = StringSplit($CopyData, "¿")
						If $hSplit[0] = 23 Then
							$hSplit[1] = " "&_TypeToName($hSplit[2])&($Controls[0]+1)
							WinSetState($GUIS[$CurrentWindow], "", @SW_ENABLE)
							_CreateControl($hSplit)
							$hSplit[4] = $hSplit[4] + $hSplit[6] + 4
							$CopyData = _ArrayToString($hSplit, "¿", 1, $hSplit[0])
							If $Attributes[$ControlNum] = "0" Then ; Add Treeview control items
								$tItem = _AddTreeItem($Names[$ControlNum], $Types[$ControlNum], $Parents[$ControlNum])
								_GUICtrlTreeView_SelectItem($hTree, $tItem)
							Else
								If StringInStr($Attributes[$ControlNum], "ø") Then
									$hSplit = StringSplit($Attributes[$ControlNum], "ø")
									$hIndex = _ArraySearch($Names, $hSplit[1])
									_GUICtrlTreeView_BeginUpdate($hTree)
									$ItemHandle = _GUICtrlTreeView_FindItem($hTree, "hTabItem" & $hSplit[2], False, 0)
									If $ItemHandle = 0 Then
										$hTabItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "hTabItem" & $hSplit[2])
										_GUICtrlTreeView_SetIcon($hTree, $hTabItem, @ScriptDir & "\Resources.dll", _GetIcon(13))
										$hItem = _GUICtrlTreeView_AddChild($hTree, $hTabItem, $Names[$ControlNum])
										_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$ControlNum]))
									Else
										$hItem = _GUICtrlTreeView_AddChild($hTree, $ItemHandle, $Names[$ControlNum])
										_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$ControlNum]))
									EndIf
									_GUICtrlTreeView_EndUpdate($hTree)
									_ArrayAdd($TreeItems, $hItem)
									$TreeItems[0] += 1
									_GUICtrlTreeView_SelectItem($hTree, $hItem)
								EndIf
								If StringInStr($Attributes[$ControlNum], "Ð") Then
									$hSplit = StringTrimRight($Attributes[$ControlNum], 1)
									$hIndex = _NameToIndex($hSplit)
									_GUICtrlTreeView_BeginUpdate($hTree)
									$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], $Names[$ControlNum])
									_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$ControlNum]))
									_GUICtrlTreeView_EndUpdate($hTree)
									_GUICtrlTreeView_Expand($hTree, $TreeItems[$hIndex], True)
									_ArrayAdd($TreeItems, $hItem)
									$TreeItems[0] += 1
								EndIf
							EndIf
							$SelectedControl = $Controls[$ControlNum]
							_ShowResizeTabs($SelectedControl)
							_SetScriptData()
						EndIf
					EndIf
				EndIf
			EndIf
		Case $hTreeDuplicate
			GUISetState(@SW_ENABLE, $GUIs[$CurrentWindow])
			Dim $DuplicateData = '', $hStartY, $HStartX, $hStartW, $hStartH
			If $MultiSelect = False Then
				If $SelectedControl <> 0 Then
					$hIndex = _GetIndex($SelectedControl)
					$hNameText = _TypeToName($Types[$hIndex])
					$ControlInfo = ControlGetPos("", "", $SelectedControl)
					If Not @error Then
						$DuplicateData = " "&$hNameText&"¿"&$Types[$hIndex]&"¿"&$ControlInfo[0]&"¿"&$ControlInfo[1]&"¿"&$ControlInfo[2]&"¿"&$ControlInfo[3]&"¿"&$Colors[$hIndex]&"¿"&$BkColors[$hIndex]&"¿"&$Styles[$hIndex]&"¿"&$States[$hIndex]&"¿"&$Data[$hIndex]&"¿"&$Resize[$hIndex]&"¿"&$Font[$hIndex]&"¿"&$FontInfo[$hIndex]&"¿"&$FontSize[$hIndex]&"¿"&$Layers[$hIndex]&"¿"&$Attributes[$hIndex]&"¿"&$Images[$hIndex]&"¿"&$Cursors[$hIndex]&"¿"&$Functions[$hIndex]&"¿"&$Comments[$hIndex]&"¿"&$Locked[$hIndex]&"¿"&$Parents[$hIndex]
						$hStartX = $ControlInfo[0]
						$hStartY = $ControlInfo[1]
						$hStartW = $ControlInfo[2]
						$hStartH = $ControlInfo[3]
					EndIf
				EndIf
			EndIf


			Dim $hDupUp = False, $hDupDown = True, $hDupLeft = False, $hDupRight = False
			Dim $TreeDuplicating = True
			$hDuplicateGUI = GUICreate( "Duplicate", 207, 174, -1, -1)
			GUICtrlCreateLabel( "Duplicate Ammount:", 8, 11, 102, 15)
			$hDupAmnt = GUICtrlCreateInput( "1", 120, 7, 64, 19)
			GUICtrlCreateUpDown( $hDupAmnt )
			GUICtrlCreateLabel( "Duplicate Spacing:", 13, 37, 102, 15)
			$hDupSpace = GUICtrlCreateInput( "5", 120, 33, 64, 19)
			GUICtrlCreateUpDown( $hDupSpace )
			GUICtrlCreateLabel( "Direction:", 46, 64, 50, 15)
			$hTopArrow = GUICtrlCreateButton( "5", 141, 59, 24, 24)
			GUICtrlSetFont( -1, 12, 400, 0, "Webdings")
			GUICtrlSetBkColor( -1, 0xE0E0E0)
			$hRightArrow = GUICtrlCreateButton( "4", 165, 84, 24, 24)
			GUICtrlSetFont( -1, 12, 400, 0, "Webdings")
			GUICtrlSetBkColor( -1, 0xE0E0E0)
			$hBottomArrow = GUICtrlCreateButton( "6", 141, 109, 24, 24)
			GUICtrlSetFont( -1, 12, 400, 0, "Webdings")
			GUICtrlSetBkColor( -1, 0x66B3FF)
			$hLeftArrow = GUICtrlCreateButton( "3", 117, 84, 24, 24)
			GUICtrlSetFont( -1, 12, 400, 0, "Webdings")
			GUICtrlSetBkColor( -1, 0xE0E0E0)
			$hDuplicateBtn = GUICtrlCreateButton( "Duplicate", 119, 144, 80, 24)
			$hDupCancel = GUICtrlCreateButton( "Cancel", 8, 144, 80, 25)
			GUISetState()

			While $TreeDuplicating = True
				$hMsg = GUIGetMsg()
				Switch $hMsg
					Case $GUI_EVENT_CLOSE
						$TreeDuplicating = False
						GUIDelete($hDuplicateGUI)
					Case $hDupCancel
						$TreeDuplicating = False
						GUIDelete($hDuplicateGUI)
					Case $hDuplicateBtn
						$hDupCount = GUICtrlRead($hDupAmnt)
						$hDupSpacing = GUICtrlRead($hDupSpace)
						$TreeDuplicating = False
						GUIDelete($hDuplicateGUI)
						Dim $dSplit
						$dSplit = StringSplit($DuplicateData, "¿")
						For $i = 1 to $GUIHandles[0] Step 1
							If $dSplit[23] = $GUIHandles[$i] Then
								$gIndex = $i
							EndIf
						Next
						WinSetState($GUIS[$gIndex], "", @SW_ENABLE)
						GUISwitch( $GUIS[$gIndex] )
						For $b = 1 to $hDupCount Step 1
							If $dSplit[0] = 23 Then
								$dSplit[1] = " "&_TypeToName($dSplit[2])&($Controls[0]+1)
								WinSetState($GUIS[$gIndex], "", @SW_ENABLE)

								If $hDupDown = True Then
									$dSplit[4] += $dSplit[6] + $hDupSpacing
								ElseIf $hDupUp = True Then
									$dSplit[4] -= $dSplit[6] + $hDupSpacing
								ElseIf $hDupLeft = True Then
									$dSplit[3] -= $dSplit[5] + $hDupSpacing
								ElseIf $hDupRight = True Then
									$dSplit[3] += $dSplit[5] + $hDupSpacing
								EndIf

								_CreateControl($dSplit)
								If $Attributes[$ControlNum] = "0" Then ; Add Treeview control items
									$tItem = _AddTreeItem($Names[$ControlNum], $Types[$ControlNum], $Parents[$ControlNum])
									_GUICtrlTreeView_SelectItem($hTree, $tItem)
								Else
									If StringInStr($Attributes[$ControlNum], "ø") Then
										$aSplit = StringSplit($Attributes[$ControlNum], "ø")
										$hIndex = _ArraySearch($Names, $aSplit[1])
										_GUICtrlTreeView_BeginUpdate($hTree)
										$ItemHandle = _GUICtrlTreeView_FindItem($hTree, "hTabItem" & $aSplit[2], False, 0)
										If $ItemHandle = 0 Then
											$hTabItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "hTabItem" & $aSplit[2])
											_GUICtrlTreeView_SetIcon($hTree, $hTabItem, @ScriptDir & "\Resources.dll", _GetIcon(13))
											$hItem = _GUICtrlTreeView_AddChild($hTree, $hTabItem, $Names[$ControlNum])
											_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$ControlNum]))
										Else
											$hItem = _GUICtrlTreeView_AddChild($hTree, $ItemHandle, $Names[$ControlNum])
											_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$ControlNum]))
										EndIf
										_GUICtrlTreeView_EndUpdate($hTree)
										_ArrayAdd($TreeItems, $hItem)
										$TreeItems[0] += 1
										_GUICtrlTreeView_SelectItem($hTree, $hItem)
									EndIf
									If StringInStr($Attributes[$ControlNum], "Ð") Then
										$aSplit = StringTrimRight($Attributes[$ControlNum], 1)
										$hIndex = _NameToIndex($aSplit)
										_GUICtrlTreeView_BeginUpdate($hTree)
										$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], $Names[$ControlNum])
										_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$ControlNum]))
										_GUICtrlTreeView_EndUpdate($hTree)
										_GUICtrlTreeView_Expand($hTree, $TreeItems[$hIndex], True)
										_ArrayAdd($TreeItems, $hItem)
										$TreeItems[0] += 1
									EndIf
								EndIf
							EndIf
							$SelectedControl = $Controls[$ControlNum]
						Next
						_ShowResizeTabs($SelectedControl)
						_SetScriptData()
					Case $hTopArrow
						If $hDupUp = False Then
							GUICtrlSetBkColor($hTopArrow, 0x66B3FF)
							GUICtrlSetBkColor($hRightArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hLeftArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hBottomArrow, 0xE0E0E0)
							$hDupUp = True
							$hDupDown = False
							$hDupLeft = False
							$hDupRight = False
						Else
							$hDupUp = False
							$hDupDown = False
							$hDupLeft = False
							$hDupRight = False
							GUICtrlSetBkColor($hRightArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hLeftArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hTopArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hBottomArrow, 0xE0E0E0)
						EndIf
					Case $hBottomArrow
						If $hDupDown = False Then
							GUICtrlSetBkColor($hBottomArrow, 0x66B3FF)
							GUICtrlSetBkColor($hRightArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hLeftArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hTopArrow, 0xE0E0E0)
							$hDupDown = True
							$hDupUp = False
							$hDupLeft = False
							$hDupRight = False
						Else
							$hDupDown = False
							$hDupUp = False
							$hDupLeft = False
							$hDupRight = False
							GUICtrlSetBkColor($hRightArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hLeftArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hTopArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hBottomArrow, 0xE0E0E0)
						EndIf
					Case $hLeftArrow
						If $hDupLeft = False Then
							GUICtrlSetBkColor($hLeftArrow, 0x66B3FF)
							GUICtrlSetBkColor($hRightArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hTopArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hBottomArrow, 0xE0E0E0)
							$hDupLeft = True
							$hDupUp = False
							$hDupDown = False
							$hDupRight = False
						Else
							$hDupLeft = False
							$hDupUp = False
							$hDupDown = False
							$hDupRight = False
							GUICtrlSetBkColor($hRightArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hLeftArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hTopArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hBottomArrow, 0xE0E0E0)
						EndIf
					Case $hRightArrow
						If $hDupRight = False Then
							GUICtrlSetBkColor($hRightArrow, 0x66B3FF)
							GUICtrlSetBkColor($hTopArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hLeftArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hBottomArrow, 0xE0E0E0)
							$hDupRight = True
							$hDupUp = False
							$hDupDown = False
							$hDupLeft = False
						Else
							$hDupRight = False
							$hDupUp = False
							$hDupDown = False
							$hDupLeft = False
							GUICtrlSetBkColor($hRightArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hLeftArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hTopArrow, 0xE0E0E0)
							GUICtrlSetBkColor($hBottomArrow, 0xE0E0E0)
						EndIf
				EndSwitch
			WEnd
		Case $hTreeDelete
			If $SelectedControl <> 0 Then
				$hIndex = _GetIndex($SelectedControl)
				_DebugAdd("Control["&$hIndex&"] Deleted", $NoErrorColor)
				$hPos = ControlGetPos($GUIS[$CurrentWindow], "", $Controls[$hIndex])
				If Not @Error Then
					$UndoLog &= "ß" & "D" &$Names[$hIndex]&"¿"&$Types[$hIndex]&"¿"&$hPos[0]&"¿"&$hPos[1]&"¿"&$hPos[2]&"¿"&$hPos[3]&"¿"&$Colors[$hIndex]&"¿"&$BkColors[$hIndex]&"¿"&$Styles[$hIndex]&"¿"&$States[$hIndex]&"¿"&$Data[$hIndex]&"¿"&$Resize[$hIndex]&"¿"&$Font[$hIndex]&"¿"&$FontInfo[$hIndex]&"¿"&$FontSize[$hIndex]&"¿"&$Layers[$hIndex]&"¿"&$Attributes[$hIndex]&"¿"&$Images[$hIndex]&"¿"&$Cursors[$hIndex]&"¿"&$Functions[$hIndex]&"¿"&$Comments[$hIndex]&"¿"&$Locked[$hIndex]&"¿"&$Parents[$hIndex]
				Else
					_DebugAdd("Undo Log Writing Error, Control["&$hIndex&"], ["&$Controls[0]&"]", $ErrorColor)
				EndIf
				GUICtrlDelete($SelectedControl)
				_DeleteResizeTabs($SelectedControl)
				_DeleteControl($hIndex)
				_GUICtrlTreeView_Delete($hTree, $TreeItems[$hIndex])
				_ArrayDelete($TreeItems, $hIndex)
				$TreeItems[0] -= 1
				_HideAllResizeTabs()
				_ClearControlData()
				$SelectedControl = 0
				_SetScriptData()
			EndIf
		Case $hTreeProp
			If $SelectedControl <> 0 Then
				Dim $ControlProp = True
				$hIndex = _GetIndex($SelectedControl)
				$hItemType = _TypeToName($Types[$hIndex])
				$hItemParent = $Parents[$hIndex]
				$hPropGUI = GUICreate( "Properties", 199, 131, -1, -1)
				GUICtrlCreateLabel( "Index:", 6, 16, 45, 15)
				GUICtrlSetStyle( -1, $SS_RIGHT)
				GUICtrlCreateLabel( "Type:", 6, 43, 45, 15)
				GUICtrlSetStyle( -1, $SS_RIGHT)
				GUICtrlCreateLabel( "Parent:", 6, 70, 45, 15)
				GUICtrlSetStyle( -1, $SS_RIGHT)
				$hIndexInput = GUICtrlCreateInput( $hIndex, 71, 12, 118, 21, $ES_READONLY)
				GUICtrlSetStyle( -1, $ES_CENTER)
				GUICtrlSetState( -1, $GUI_DISABLE)
				$hTypeCombo = GUICtrlCreateCombo( "", 71, 41, 118, 21, 0x003)
				GUICtrlSetData( -1, "Label|Button|Input|Edit|Checkbox|Radio|List|Combo|Date|Image|Icon|Progress|Tab|Updown|Menu|TreeView|Slider|ListView|Graphic|Dummy|MonthCal|Group|GUI Scrollbars|Rich Edit|Object", $hItemType)
				$hParentCombo = GUICtrlCreateCombo( "", 71, 67, 118, 21, 0x003)
				Dim $hGUIList = ''
				For $i = 1 to $GUIHandles[0] Step 1
					If $hGUIList = '' Then
						$hGUIList &= $GUIHandles[$i]
					Else
						$hGUIList &= "|"&$GUIHandles[$i]
					EndIf
				Next
				GUICtrlSetData( -1, $hGUIList, $Parents[$hIndex])
				$hPropSave = GUICtrlCreateButton( "Save", 101, 101, 90, 25)
				$hPropCancel = GUICtrlCreateButton( "Cancel", 6, 101, 90, 25)
				GUISetState()

				While $ControlProp = True
					$hMsg = GUIGetMsg()
					Switch $hMsg
						Case $GUI_EVENT_CLOSE
							GUIDelete($hPropGUI)
							$ControlProp = False
						Case $hPropCancel
							GUIDelete($hPropGUI)
							$ControlProp = False
						Case $hPropSave
							$hNewType = GUICtrlRead($hTypeCombo)
							$hNewTypeIndex = _GUICtrlComboBox_GetCurSel($hTypeCombo)+1
							$hNewParent = GUICtrlRead($hParentCombo)
							GUIDelete($hPropGUI)
							$ControlProp = False
							If $hNewParent <> $hItemParent Then ; Switch Parent GUI
								Dim $hGUIIndx
								For $i = 1 to $GUIHandles[0] Step 1
									If $hNewParent = $GUIHandles[$i] Then
										$hGUIIndx = $i
									EndIf
								Next
								$hCtrlPos = ControlGetPos( "", "", $Controls[$hIndex])
								GUICtrlDelete($Controls[$hIndex])
								WinSetState($GUIS[$hGUIIndx], "", @SW_ENABLE)
								GUISwitch($GUIS[$hGUIIndx])
								If $hNewTypeIndex = 1 Then
									$hControl = GUICtrlCreateLabel($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 2 Then
									$hControl = GUICtrlCreateButton($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 3 Then
									$hControl = GUICtrlCreateInput($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 4 Then
									$hControl = GUICtrlCreateEdit($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 5 Then
									$hControl = GUICtrlCreateCheckBox($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 6 Then
									$hControl = GUICtrlCreateRadio($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 7 Then
									$hControl = GUICtrlCreateList($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 8 Then
									$hControl = GUICtrlCreateCombo($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 9 Then
									$hControl = GUICtrlCreateDate($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 10 Then
									$hControl = GUICtrlCreatePic($Images[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 11 Then
									$hControl = GUICtrlCreateIcon($Data[$hIndex], "", $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 12 Then
									$hControl = GUICtrlCreateProgress($hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									GUICtrlSetData(-1, $Data[$hIndex])
								ElseIf $hNewTypeIndex = 13 Then
									$hControl = GUICtrlCreateTab($hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									GUICtrlCreateTabItem($Data[$hIndex])
									GUISwitch($GUIS[$CurrentWindow])
								ElseIf $hNewTypeIndex = 16 Then
									$hControl = GUICtrlCreateTreeView($hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 17 Then
									$hControl = GUICtrlCreateSlider($hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									GUICtrlSetData(-1, $Data[$hIndex])
								ElseIf $hNewTypeIndex = 18 Then
									$hControl = GUICtrlCreateListView($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 19 Then
									$hControl = GUICtrlCreateGraphic($hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 20 Then
									$hControl = GUICtrlCreateDummy()
								ElseIf $hNewTypeIndex = 21 Then
									$hControl = GUICtrlCreateMonthCal($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 22 Then
									$hControl = GUICtrlCreateGroup($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
								ElseIf $hNewTypeIndex = 24 Then
									$hControl = GUICtrlCreateEdit("", $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3], $ES_READONLY)
								ElseIf $hNewTypeIndex = 25 Then
									$hControl = GUICtrlCreateEdit("", $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3], $ES_READONLY)
									GUICtrlSetState(-1, $GUI_DISABLE)
								EndIf
								For $i = 1 to $ResizeTabs[0] Step 1
									$hRSplit = StringSplit($ResizeTabs[$i], "|")
									If $hRSplit[1] = $Controls[$hIndex] Then
										StringReplace($ResizeTabs[$i], $Controls[$hIndex]&"|", $hControl&"|")
									EndIf
								Next
								If $Colors[$hIndex] <> "" Then
									GUICtrlSetColor($hControl, "0x"&$Colors[$hIndex])
								EndIf
								If $BkColors[$hIndex] <> "" Then
									GUICtrlSetBkColor($hControl, "0x"&$BkColors[$hIndex])
								EndIf
								$Controls[$hIndex] = $hControl
								$Types[$hIndex] = $hNewTypeIndex
								$Parents[$hIndex] = $GUIHandles[$hGUIIndx]
								$hResizeSplit = StringSplit($ResizeTabs[$hIndex], "|")
								For $i = 2 to $hResizeSplit[0] Step 1
									GUICtrlDelete($hResizeSplit[$i])
								Next
								WinSetState($GUIs[$hGUIIndx], "", @SW_ENABLE)
								GUISwitch($GUIS[$hGUIIndx])
								$ControlPos = ControlGetPos($GUIs[$hGUIIndx], "", $hControl)
								If Not @error Then
									$hRightTop = GUICtrlCreateLabel("", $ControlPos[0] - 3, $ControlPos[1] - 3, 3, 3, $GUI_ONTOP)
									GUICtrlSetBkColor(-1, $CornerColor)
									GUICtrlSetState(-1, $GUI_HIDE)
									GUICtrlSetResizing(-1, 802)
									$hRightBottom = GUICtrlCreateLabel("", $ControlPos[0] - 3, $ControlPos[1] + $ControlPos[3], 3, 3, $GUI_ONTOP)
									GUICtrlSetBkColor(-1, $CornerColor)
									GUICtrlSetState(-1, $GUI_HIDE)
									GUICtrlSetResizing(-1, 802)
									$hLeftTop = GUICtrlCreateLabel("", $ControlPos[0] + $ControlPos[2], $ControlPos[1] - 3, 3, 3, $GUI_ONTOP)
									GUICtrlSetBkColor(-1, $CornerColor)
									GUICtrlSetState(-1, $GUI_HIDE)
									GUICtrlSetResizing(-1, 802)
									$hLeftBottom = GUICtrlCreateLabel("", $ControlPos[0] + $ControlPos[2], $ControlPos[1] + $ControlPos[3], 3, 3, $GUI_ONTOP)
									GUICtrlSetBkColor(-1, $CornerColor)
									GUICtrlSetState(-1, $GUI_HIDE)
									GUICtrlSetResizing(-1, 802)
									$hTop = GUICtrlCreateLabel("", $ControlPos[0], $ControlPos[1] - 2, $ControlPos[2], 1, $GUI_ONTOP)
									GUICtrlSetBkColor(-1, $SelectColor)
									GUICtrlSetState(-1, $GUI_HIDE)
									GUICtrlSetResizing(-1, 802)
									$hRight = GUICtrlCreateLabel("", $ControlPos[0] + $ControlPos[2] + 1, $ControlPos[1], 1, $ControlPos[3], $GUI_ONTOP)
									GUICtrlSetBkColor(-1, $SelectColor)
									GUICtrlSetState(-1, $GUI_HIDE)
									GUICtrlSetResizing(-1, 802)
									$hLeft = GUICtrlCreateLabel("", $ControlPos[0] - 2, $ControlPos[1], 1, $ControlPos[3], $GUI_ONTOP)
									GUICtrlSetBkColor(-1, $SelectColor)
									GUICtrlSetState(-1, $GUI_HIDE)
									GUICtrlSetResizing(-1, 802)
									$hBottom = GUICtrlCreateLabel("", $ControlPos[0], $ControlPos[1] + $ControlPos[3] + 1, $ControlPos[2], 1, $GUI_ONTOP)
									GUICtrlSetBkColor(-1, $SelectColor)
									GUICtrlSetState(-1, $GUI_HIDE)
									GUICtrlSetResizing(-1, 802)
									GUISetState()
									$ResizeTabs[$hIndex] = String($hControl) & "|" & String($hRightTop) & "|" & String($hRightBottom) & "|" & String($hLeftTop) & "|" & String($hLeftBottom) & "|" & String($hTop) & "|" & String($hBottom) & "|" & String($hLeft) & "|" & String($hRight)
								EndIf
								_GUICtrlTreeView_BeginUpdate($hTree)
								_GUICtrlTreeView_Delete($hTree, $TreeItems[$hIndex])
								$hNewTree = _GUICtrlTreeView_AddChild($hTree, $GUITrees[$hGUIIndx], $Names[$hIndex])
								$TreeItems[$hIndex] = $hNewTree
								_GUICtrlTreeView_SetIcon($hTree, $TreeItems[$hIndex], @ScriptDir & "\Resources.dll", _GetIcon($Types[$hIndex]))
								_GUICtrlTreeView_EndUpdate($hTree)
							Else
								If $hNewType <> $hItemType Then ; Change Control Type
									$hCtrlPos = ControlGetPos( "", "", $Controls[$hIndex])
									GUICtrlDelete($Controls[$hIndex])
									WinSetState($GUIS[$CurrentWindow], "", @SW_ENABLE)
									GUISwitch($GUIS[$CurrentWindow])
									If $hNewTypeIndex = 1 Then
										$hControl = GUICtrlCreateLabel($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 2 Then
										$hControl = GUICtrlCreateButton($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 3 Then
										$hControl = GUICtrlCreateInput($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 4 Then
										$hControl = GUICtrlCreateEdit($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 5 Then
										$hControl = GUICtrlCreateCheckBox($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 6 Then
										$hControl = GUICtrlCreateRadio($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 7 Then
										$hControl = GUICtrlCreateList($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 8 Then
										$hControl = GUICtrlCreateCombo($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 9 Then
										$hControl = GUICtrlCreateDate($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 10 Then
										$hControl = GUICtrlCreatePic($Images[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 11 Then
										$hControl = GUICtrlCreateIcon($Data[$hIndex], "", $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 12 Then
										$hControl = GUICtrlCreateProgress($hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
										GUICtrlSetData(-1, $Data[$hIndex])
									ElseIf $hNewTypeIndex = 13 Then
										$hControl = GUICtrlCreateTab($hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
										GUICtrlCreateTabItem($Data[$hIndex])
										GUISwitch($GUIS[$CurrentWindow])
									ElseIf $hNewTypeIndex = 16 Then
										$hControl = GUICtrlCreateTreeView($hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 17 Then
										$hControl = GUICtrlCreateSlider($hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
										GUICtrlSetData(-1, $Data[$hIndex])
									ElseIf $hNewTypeIndex = 18 Then
										$hControl = GUICtrlCreateListView($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 19 Then
										$hControl = GUICtrlCreateGraphic($hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 20 Then
										$hControl = GUICtrlCreateDummy()
									ElseIf $hNewTypeIndex = 21 Then
										$hControl = GUICtrlCreateMonthCal($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 22 Then
										$hControl = GUICtrlCreateGroup($Data[$hIndex], $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
									ElseIf $hNewTypeIndex = 24 Then
										$hControl = GUICtrlCreateEdit("", $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3], $ES_READONLY)
									ElseIf $hNewTypeIndex = 25 Then
										$hControl = GUICtrlCreateEdit("", $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3], $ES_READONLY)
										GUICtrlSetState(-1, $GUI_DISABLE)
									EndIf
									For $i = 1 to $ResizeTabs[0] Step 1
										$hRSplit = StringSplit($ResizeTabs[$i], "|")
										If $hRSplit[1] = $Controls[$hIndex] Then
											StringReplace($ResizeTabs[$i], $Controls[$hIndex]&"|", $hControl&"|")
										EndIf
									Next
									If $Colors[$hIndex] <> "" Then
										GUICtrlSetColor($hControl, "0x"&$Colors[$hIndex])
									EndIf
									If $BkColors[$hIndex] <> "" Then
										GUICtrlSetBkColor($hControl, "0x"&$BkColors[$hIndex])
									EndIf
									$Controls[$hIndex] = $hControl
									$Types[$hIndex] = $hNewTypeIndex
									_GUICtrlTreeView_SetIcon($hTree, $TreeItems[$hIndex], @ScriptDir & "\Resources.dll", _GetIcon($Types[$hIndex]))
								EndIf
							EndIf
							_SetScriptData()
					EndSwitch
				WEnd
			EndIf

		Case $hTreeImport
			_ImportClipboard(ClipGet(), $CurrentWindow)
			_SetScriptData()
		Case $DataEx
			If $SelectedControl <> 0 And $MultiSelect = False Then
				$hIndex = _GetIndex($SelectedControl)
				Dim $DataMode = True
				$hDataGUI = GUICreate("Data Edit", 493, 296, -1, -1)
				$hlbl = GUICtrlCreateLabel("Control Data:", 9, 8, 74, 15)
				$hDataEdit = GUICtrlCreateEdit($Data[$hIndex], 9, 27, 469, 229, $WS_VSCROLL)
				$hDataSaveBtn = GUICtrlCreateButton("Save", 341, 263, 144, 26)
				$hDataCancel = GUICtrlCreateButton("Cancel", 190, 263, 144, 26)
				GUISetState()

				While $DataMode = True
					$hMsg = GUIGetMsg()
					Switch $hMsg
						Case $GUI_EVENT_CLOSE
							GUIDelete($hDataGUI)
							$DataMode = False
						Case $hDataCancel
							GUIDelete($hDataGUI)
							$DataMode = False
						Case $hDataSaveBtn
							$Data[$hIndex] = GUICtrlRead($hDataEdit)
							GUIDelete($hDataGUI)
							$DataMode = False
					EndSwitch
				WEnd
			EndIf

		Case $StateInput
			If $SelectedControl <> 0 And $MultiSelect = False Then
				$RefNum = _GetIndex($SelectedControl)
				If GUICtrlRead($StateInput) <> $States[$RefNum] Then
					$States[$RefNum] = GUICtrlRead($StateInput)
					If $States[$RefNum] = "$GUI_SHOW" Then
						GUICtrlSetState($SelectedControl, $GUI_SHOW + $GUI_ENABLE)
					ElseIf $States[$RefNum] = "$GUI_HIDE" Then
						GUICtrlSetState($SelectedControl, $GUI_HIDE)
					ElseIf $States[$RefNum] = "$GUI_DISABLE" Then
						GUICtrlSetState($SelectedControl, $GUI_DISABLE)
					ElseIf $States[$RefNum] = "$GUI_ENABLE" Then
						GUICtrlSetState($SelectedControl, $GUI_ENABLE)
					ElseIf $States[$RefNum] = "$GUI_ONTOP" Then
						GUICtrlSetState($SelectedControl, $GUI_ONTOP)
					ElseIf $States[$RefNum] = "$GUI_CHECKED" Then
						GUICtrlSetState($SelectedControl, $GUI_CHECKED)
					ElseIf $States[$RefNum] = "$GUI_UNCHECKED" Then
						GUICtrlSetState($SelectedControl, $GUI_UNCHECKED)
					EndIf
					_SetScriptData()
				EndIf
			EndIf
		Case $CursorInput
			If $SelectedControl <> 0 And $MultiSelect = False Then
				$RefNum = _GetIndex($SelectedControl)
				If _GUICtrlComboBox_GetCurSel($CursorInput) <> $Cursors[$RefNum] Then
					$Cursors[$RefNum] = _GUICtrlComboBox_GetCurSel($CursorInput)
					_SetScriptData()
				EndIf
			EndIf
		Case $FontInput
			If $SelectedControl <> 0 And $MultiSelect = False Then
				$RefNum = _GetIndex($SelectedControl)
				If GUICtrlRead($FontInput) <> $Font[$RefNum] Then
					$Font[$RefNum] = GUICtrlRead($FontInput)
					Dim $AttributeVal = ""
					$aSplit = StringSplit($FontInfo[$RefNum], "+")
					For $i = $aSplit[0] To 1 Step -1
						If $aSplit[$i] <> "" Then
							If $i = 2 Then
								$AttributeVal &= $aSplit[$i]
							Else
								$AttributeVal &= $aSplit[$i] & "+"
							EndIf
						EndIf
					Next
					If StringInStr($FontInfo[$RefNum], "+0+") Then
						GUICtrlSetFont($SelectedControl, GUICtrlRead($SizeInput), 800, $AttributeVal, $Font[$RefNum])
					Else
						GUICtrlSetFont($SelectedControl, GUICtrlRead($SizeInput), 400, $AttributeVal, $Font[$RefNum])
					EndIf
					_SetScriptData()
				EndIf
			EndIf
		Case $AutoAlignButton
			If $AutoAlign = "True" Then
				$AutoAlign = "False"
				IniWrite(@ScriptDir & "/Config.ini", "Vars", "AutoAlign", $AutoAlign)
				_ResourceSetImageToCtrl($AutoAlignButton, "AutoAlign_Disable", $RT_BITMAP)
			Else
				$AutoAlign = "True"
				IniWrite(@ScriptDir & "/Config.ini", "Vars", "AutoAlign", $AutoAlign)
				_ResourceSetImageToCtrl($AutoAlignButton, "AutoAlign", $RT_BITMAP)
			EndIf
		Case $Exit
			$hMsgbox = MsgBox(0x4, "Exit?", "Are you sure you want to Exit?" & @CRLF & "Any unsaved data will be lost.")
			If $hMsgbox = 6 Then
				_GDIPlus_Shutdown()
				_GUICtrlRichEdit_Destroy($ScriptEdit)
				_WinAPI_UnhookWindowsHookEx($hHook)
				DllCallbackFree($hStub_KeyProc)
				_CleanUp()
				DllClose($dll)
				Exit
			EndIf
		Case $GUI_EVENT_CLOSE
			$State = WinGetState($hGUI)
			If BitAND($State, 8) Then
				$hMsgbox = MsgBox(0x4, "Exit?", "Are you sure you want to Exit?" & @CRLF & "Any unsaved data will be lost.")
				If $hMsgbox = 6 Then
					_GDIPlus_Shutdown()
					_GUICtrlRichEdit_Destroy($ScriptEdit)
					_WinAPI_UnhookWindowsHookEx($hHook)
					DllCallbackFree($hStub_KeyProc)
					_CleanUp()
					DllClose($dll)
					Exit
				EndIf
			Else
				$hMsgbox = Msgbox( 0x3, "Delete "&$GUIHandles[$CurrentWindow], "Are you sure you want to delete Window "&$GUIHandles[$CurrentWindow]&"?"&@CRLF&"This action cannot be undone.")
				If $hMsgbox = 6 Then
					_HideAllResizeTabs()
					_ClearControlData()
					_GUICtrlTreeView_BeginUpdate($hTree)
					For $i = $Controls[0] to 1 Step -1
						If $Parents[$i] = $GUIHandles[$CurrentWindow] Then
							_ArrayDelete($TreeItems, $i)
							$TreeItems[0] -= 1
							_DeleteResizeTabs($Controls[$i])
							_DeleteControl($i)
						EndIf
					Next
					_GUICtrlTreeView_Expand($hTree, $hFileTree)
					_GUICtrlTreeView_Delete($hTree, $GUITrees[$CurrentWindow])
					_GDIPlus_GraphicsDispose($GUIPlus[$CurrentWindow])
					GUIDelete($GUIs[$CurrentWindow])
					_ArrayDelete($GUIs, $CurrentWindow)
					_ArrayDelete($GUIHandles, $CurrentWindow)
					_ArrayDelete($WinTitles, $CurrentWindow)
					_ArrayDelete($GUITrees, $CurrentWindow)
					_ArrayDelete($GUIColors, $CurrentWindow)
					_ArrayDelete($GUIVars, $CurrentWindow)
					_ArrayDelete($GUIScript, $CurrentWindow)
					_ArrayDelete($GUIComment, $CurrentWindow)
					_ArrayDelete($GUIStyle, $CurrentWindow)
					_ArrayDelete($GUIMenus, $CurrentWindow)
					_ArrayDelete($GUIProperties, $CurrentWindow)
					_ArrayDelete($GUIX, $CurrentWindow)
					_ArrayDelete($GUIY, $CurrentWindow)
					_ArrayDelete($GUISnapLineX, $CurrentWindow)
					_ArrayDelete($GUISnapLineY, $CurrentWindow)
					_ArrayDelete($GUISetStateData, $CurrentWindow)
					_ArrayDelete($GUIPlus, $CurrentWindow)
					_ArrayDelete($GUIParent, $CurrentWindow)
					$GUIParent[0] -= 1
					$GUIPlus[0] -= 1
					$GUISetStateData[0] -= 1
					$GUISnapLineX[0] -= 1
					$GUISnapLineY[0] -= 1
					$GUIX[0] -= 1
					$GUIY[0] -= 1
					$GUIProperties[0] -= 1
					$GUIMenus[0] -= 1
					$GUIComment[0] -= 1
					$GUIStyle[0] -= 1
					$GUIScript[0] -= 1
					$GUIVars[0] -= 1
					$GUIColors[0] -= 1
					$GUITrees[0] -= 1
					$GUIHandles[0] -= 1
					$WinTitles[0] -= 1
					$GUIs[0] -= 1
					$ChildCount -= 1
					_GUICtrlTreeView_EndUpdate($hTree)
					$CurrentWindow -= 1
					_SetScriptData()
				EndIf
			EndIf
		Case $ControlLabel
			If $ControlExpand = True Then
				$ControlExpand = False
				IniWrite(@ScriptDir & "/Config.ini", "Vars", "ControlColumn", "False")
				For $i = 1 To $ControlGroup1[0] Step 1
					GUICtrlSetState($ControlGroup1[$i], $GUI_HIDE)
				Next
				GUICtrlSetPos($ControlBoarder, 4, 28, 143, 30)
				$hCurPos = ControlGetPos("", "", $AlignmentBoarder)
				GUICtrlSetPos($AlignmentBoarder, $hCurPos[0], $hCurPos[1] - 245, $hCurPos[2], $hCurPos[3])
				$hCurPos1 = ControlGetPos("", "", $SpacingBoarder)
				GUICtrlSetPos($SpacingBoarder, $hCurPos1[0], $hCurPos1[1] - 245, $hCurPos1[2], $hCurPos1[3])
				$hCurPos2 = ControlGetPos("", "", $LayerBoarder)
				GUICtrlSetPos($LayerBoarder, $hCurPos2[0], $hCurPos2[1] - 245, $hCurPos2[2], $hCurPos2[3])
				For $i = 1 To $ControlGroup2[0] Step 1
					$hCurPos = ControlGetPos("", "", $ControlGroup2[$i])
					GUICtrlSetPos($ControlGroup2[$i], $hCurPos[0], $hCurPos[1] - 245, $hCurPos[2], $hCurPos[3])
				Next
				For $i = 1 To $ControlGroup3[0] Step 1
					$hCurPos = ControlGetPos("", "", $ControlGroup3[$i])
					GUICtrlSetPos($ControlGroup3[$i], $hCurPos[0], $hCurPos[1] - 245, $hCurPos[2], $hCurPos[3])
				Next
				For $i = 1 To $ControlGroup4[0] Step 1
					$hCurPos = ControlGetPos("", "", $ControlGroup4[$i])
					GUICtrlSetPos($ControlGroup4[$i], $hCurPos[0], $hCurPos[1] - 245, $hCurPos[2], $hCurPos[3])
				Next
			Else
				$ControlExpand = True
				IniWrite(@ScriptDir & "/Config.ini", "Vars", "ControlColumn", "True")
				GUICtrlSetPos($ControlBoarder, 4, 28, 143, 275)
				$hCurPos = ControlGetPos("", "", $AlignmentBoarder)
				GUICtrlSetPos($AlignmentBoarder, $hCurPos[0], $hCurPos[1] + 245, $hCurPos[2], $hCurPos[3])
				$hCurPos1 = ControlGetPos("", "", $SpacingBoarder)
				GUICtrlSetPos($SpacingBoarder, $hCurPos1[0], $hCurPos1[1] + 245, $hCurPos1[2], $hCurPos1[3])
				$hCurPos2 = ControlGetPos("", "", $LayerBoarder)
				GUICtrlSetPos($LayerBoarder, $hCurPos2[0], $hCurPos2[1] + 245, $hCurPos2[2], $hCurPos2[3])
				For $i = 1 To $ControlGroup1[0] Step 1
					GUICtrlSetState($ControlGroup1[$i], $GUI_SHOW)
				Next
				For $i = 1 To $ControlGroup2[0] Step 1
					$hCurPos = ControlGetPos("", "", $ControlGroup2[$i])
					GUICtrlSetPos($ControlGroup2[$i], $hCurPos[0], $hCurPos[1] + 245, $hCurPos[2], $hCurPos[3])
				Next
				For $i = 1 To $ControlGroup3[0] Step 1
					$hCurPos = ControlGetPos("", "", $ControlGroup3[$i])
					GUICtrlSetPos($ControlGroup3[$i], $hCurPos[0], $hCurPos[1] + 245, $hCurPos[2], $hCurPos[3])
				Next
				For $i = 1 To $ControlGroup4[0] Step 1
					$hCurPos = ControlGetPos("", "", $ControlGroup4[$i])
					GUICtrlSetPos($ControlGroup4[$i], $hCurPos[0], $hCurPos[1] + 245, $hCurPos[2], $hCurPos[3])
				Next
			EndIf
		Case $AlignmentLabel
			If $AlignExpand = True Then
				$AlignExpand = False
				IniWrite(@ScriptDir & "/Config.ini", "Vars", "AlignColumn", "False")
				For $i = 1 To $ControlGroup2[0] Step 1
					If $ControlGroup2[$i] <> $AlignmentLabel And $ControlGroup2[$i] <> $AlignmentLine Then
						GUICtrlSetState($ControlGroup2[$i], $GUI_HIDE)
					EndIf
				Next
				$hCurPos = ControlGetPos("", "", $AlignmentBoarder)
				GUICtrlSetPos($AlignmentBoarder, $hCurPos[0], $hCurPos[1], $hCurPos[2], 30)
				$hCurPos1 = ControlGetPos("", "", $SpacingBoarder)
				GUICtrlSetPos($SpacingBoarder, $hCurPos1[0], $hCurPos1[1] - 74, $hCurPos1[2], $hCurPos1[3])
				$hCurPos2 = ControlGetPos("", "", $LayerBoarder)
				GUICtrlSetPos($LayerBoarder, $hCurPos2[0], $hCurPos2[1] - 74, $hCurPos2[2], $hCurPos2[3])
				For $i = 1 To $ControlGroup3[0] Step 1
					$hCurPos = ControlGetPos("", "", $ControlGroup3[$i])
					GUICtrlSetPos($ControlGroup3[$i], $hCurPos[0], $hCurPos[1] - 74, $hCurPos[2], $hCurPos[3])
				Next
				For $i = 1 To $ControlGroup4[0] Step 1
					$hCurPos = ControlGetPos("", "", $ControlGroup4[$i])
					GUICtrlSetPos($ControlGroup4[$i], $hCurPos[0], $hCurPos[1] - 74, $hCurPos[2], $hCurPos[3])
				Next
			Else
				$AlignExpand = True
				IniWrite(@ScriptDir & "/Config.ini", "Vars", "AlignColumn", "True")
				$hCurPos = ControlGetPos("", "", $AlignmentBoarder)
				GUICtrlSetPos($AlignmentBoarder, $hCurPos[0], $hCurPos[1], $hCurPos[2], 104)
				$hCurPos1 = ControlGetPos("", "", $SpacingBoarder)
				GUICtrlSetPos($SpacingBoarder, $hCurPos1[0], $hCurPos1[1] + 74, $hCurPos1[2], $hCurPos1[3])
				$hCurPos2 = ControlGetPos("", "", $LayerBoarder)
				GUICtrlSetPos($LayerBoarder, $hCurPos2[0], $hCurPos2[1] + 74, $hCurPos2[2], $hCurPos2[3])
				For $i = 1 To $ControlGroup2[0] Step 1
					GUICtrlSetState($ControlGroup2[$i], $GUI_SHOW)
				Next
				For $i = 1 To $ControlGroup3[0] Step 1
					$hCurPos = ControlGetPos("", "", $ControlGroup3[$i])
					GUICtrlSetPos($ControlGroup3[$i], $hCurPos[0], $hCurPos[1] + 74, $hCurPos[2], $hCurPos[3])
				Next
				For $i = 1 To $ControlGroup4[0] Step 1
					$hCurPos = ControlGetPos("", "", $ControlGroup4[$i])
					GUICtrlSetPos($ControlGroup4[$i], $hCurPos[0], $hCurPos[1] + 74, $hCurPos[2], $hCurPos[3])
				Next
			EndIf
		Case $SpacingLabel
			If $SpaceExpand = True Then
				$SpaceExpand = False
				IniWrite(@ScriptDir & "/Config.ini", "Vars", "SpaceColumn", "False")
				For $i = 1 To $ControlGroup3[0] Step 1
					If $ControlGroup3[$i] <> $SpacingLabel And $ControlGroup3[$i] <> $SpacingLine Then
						GUICtrlSetState($ControlGroup3[$i], $GUI_HIDE)
					EndIf
				Next
				$hCurPos1 = ControlGetPos("", "", $SpacingBoarder)
				GUICtrlSetPos($SpacingBoarder, $hCurPos1[0], $hCurPos1[1], $hCurPos1[2], 30)
				$hCurPos2 = ControlGetPos("", "", $LayerBoarder)
				GUICtrlSetPos($LayerBoarder, $hCurPos2[0], $hCurPos2[1] - 62, $hCurPos2[2], $hCurPos2[3])
				For $i = 1 To $ControlGroup4[0] Step 1
					$hCurPos = ControlGetPos("", "", $ControlGroup4[$i])
					GUICtrlSetPos($ControlGroup4[$i], $hCurPos[0], $hCurPos[1] - 62, $hCurPos[2], $hCurPos[3])
				Next
			Else
				$SpaceExpand = True
				IniWrite(@ScriptDir & "/Config.ini", "Vars", "SpaceColumn", "True")
				$hCurPos1 = ControlGetPos("", "", $SpacingBoarder)
				GUICtrlSetPos($SpacingBoarder, $hCurPos1[0], $hCurPos1[1], $hCurPos1[2], 92)
				$hCurPos2 = ControlGetPos("", "", $LayerBoarder)
				GUICtrlSetPos($LayerBoarder, $hCurPos2[0], $hCurPos2[1] + 62, $hCurPos2[2], $hCurPos2[3])
				For $i = 1 To $ControlGroup3[0] Step 1
					GUICtrlSetState($ControlGroup3[$i], $GUI_SHOW)
				Next
				For $i = 1 To $ControlGroup4[0] Step 1
					$hCurPos = ControlGetPos("", "", $ControlGroup4[$i])
					GUICtrlSetPos($ControlGroup4[$i], $hCurPos[0], $hCurPos[1] + 62, $hCurPos[2], $hCurPos[3])
				Next
			EndIf
		Case $LayerLabel
			If $LayerExpand = True Then
				$LayerExpand = False
				IniWrite(@ScriptDir & "/Config.ini", "Vars", "LayerColumn", "False")
				For $i = 1 To $ControlGroup4[0] Step 1
					If $ControlGroup4[$i] <> $LayerLabel And $ControlGroup4[$i] <> $LayerLine Then
						GUICtrlSetState($ControlGroup4[$i], $GUI_HIDE)
					EndIf
				Next
				$hCurPos2 = ControlGetPos("", "", $LayerBoarder)
				GUICtrlSetPos($LayerBoarder, $hCurPos2[0], $hCurPos2[1], $hCurPos2[2], 30)
			Else
				$LayerExpand = True
				IniWrite(@ScriptDir & "/Config.ini", "Vars", "LayerColumn", "True")
				$hCurPos2 = ControlGetPos("", "", $LayerBoarder)
				GUICtrlSetPos($LayerBoarder, $hCurPos2[0], $hCurPos2[1], $hCurPos2[2], 184)
				For $i = 1 To $ControlGroup4[0] Step 1
					GUICtrlSetState($ControlGroup4[$i], $GUI_SHOW)
				Next
			EndIf
		Case $LockControlButton
			If $SelectedControl <> 0 Then
				$hIndex = _GetIndex($SelectedControl)
				_DebugAdd("Control["&$hIndex&"] Locked", $ProblemColor)
				If $Locked[$hIndex] = "0" Then
					$Locked[$hIndex] = "1"
					$rSplit = StringSplit($ResizeTabs[$hIndex], "|")
					For $i = 2 To $rSplit[0] Step 1
						GUICtrlSetBkColor($rSplit[$i], 0xE7C200)
					Next
				Else
					$Locked[$hIndex] = "0"
					$rSplit = StringSplit($ResizeTabs[$hIndex], "|")
					For $i = 2 To $rSplit[0] Step 1
						If $i >= 2 And $i <= 5 Then
							GUICtrlSetBkColor($rSplit[$i], 0x000000)
						Else
							GUICtrlSetBkColor($rSplit[$i], $SelectColor)
						EndIf
					Next
				EndIf
			EndIf
		Case $GroupControlButton
			If $Beta = False Then
				If $MultiSelect = True Then
					$hArray = _ArrayToString($MultiControls, "|", 1, $MultiControls[0])
					_ArrayAdd($GUIGroups, $hArray)
					$GUIGroups[0] += 1
					_GUICtrlTreeView_BeginUpdate($hTree)
					$hItem = _GUICtrlTreeView_AddChild($hTree, $GUITrees[$CurrentWindow], "[ Group " & $GUIGroups[0] & " ]")
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -109)
					_ArrayAdd($GroupItems, $hItem)
					$GroupItems[0] += 1
					For $i = 1 To $MultiControls[0] Step 1
						$hIndex = _GetIndex($MultiControls[$i])
						_GUICtrlTreeView_Delete($hTree, $TreeItems[$hIndex])
						$TreeItems[$hIndex] = _GUICtrlTreeView_AddChild($hTree, $hItem, $Names[$hIndex])
						_GUICtrlTreeView_SetIcon($hTree, $TreeItems[$hIndex], @ScriptDir & "\Resources.dll", _GetIcon($Types[$hIndex]))
					Next
					_GUICtrlTreeView_EndUpdate($hTree)
				EndIf
			EndIf
		Case $Update
			If $VersionURL <> "" Then
				$hSource = _INetGetSource($VersionURL)
				If Not @error Then
					If StringInStr($hSource, "|") Then
						$hSplit = StringSplit($hSource, "|")
						If $hSplit[1] <> $CurrentVersion Then
							$hMsg = MsgBox(0x4, "New Update " & $hSplit[1], "Update " & $hSplit[1] & " is Availible, Do you want to update now?")
							If $hMsg = 6 Then
								$hFile = FileOpen(@ScriptDir & "/Update.tmp", 2)
								FileWrite($hFile, @ScriptFullPath & "|" & $hSplit[2])
								FileClose($hFile)
								Run(@ScriptDir & "/Updater.exe")
								_GUICtrlRichEdit_Destroy($ScriptEdit)
								_WinAPI_UnhookWindowsHookEx($hHook)
								DllCallbackFree($hStub_KeyProc)
								DllClose($dll)
								Exit
							EndIf
						Else
							MsgBox(0, "No Update", "No Update is Availible.")
						EndIf
					EndIf
				Else
					_DebugAdd("Check Update Site Error", $ErrorColor)
				EndIf
			EndIf
		Case $Import
			$hFile = FileOpenDialog("Import Au3 Script", @ScriptDir, "Autoit v3 Script (*.au3)", 1)
			If Not @error Then
				$Message = _CustomMsg("Close Project?", "Close Current Project before Opening?")
				If $Message = 6 Then
					_ImportFile($hFile)
				EndIf
			EndIf
		Case $FuncMode
			If $SelectedControl <> 0 Then
				_FuncMode()
			EndIf
		Case $GraphicMode
			If $Types[_GetIndex($SelectedControl)] = 19 Then
				_DebugAdd("Graphic Mode Started", $NoErrorColor)
				Dim $hSelectControl = $SelectedControl
				_ClearControlData()
				$SelectedControl = $hSelectControl
				Dim $ActiveWindows[1] = [0]
				For $i = 1 To $GUIs[0] Step 1
					If BitAND(WinGetState($GUIs[$i]), 2) Then
						WinSetState($GUIs[$i], "", @SW_HIDE)
						_ArrayAdd($ActiveWindows, $i)
						$ActiveWindows[0] += 1
					EndIf
				Next
				For $i = 1 To $ModeGroup[0] Step 1
					GUICtrlSetState($ModeGroup[$i], $GUI_SHOW)
				Next
				_GraphicMode()
				_GUICtrlTreeView_BeginUpdate($hTree)
				For $i = $GraphicTrees[0] To 1 Step -1
					_GUICtrlTreeView_Delete($hTree, $GraphicTrees[$i])
				Next
				_GUICtrlTreeView_EndUpdate($hTree)
				Dim $GraphicTrees[1] = [0]
				GUICtrlSetState($Dot_1, $GUI_HIDE)
				GUICtrlSetState($Dot_2, $GUI_HIDE)
				GUICtrlSetState($Dot_3, $GUI_HIDE)
				GUICtrlSetState($Dot, $GUI_HIDE)
				GUICtrlSetState($hTopBoarder, $GUI_HIDE)
				GUICtrlSetState($hBottomBoarder, $GUI_HIDE)
				GUICtrlSetState($hLeftBoarder, $GUI_HIDE)
				GUICtrlSetState($hRightBoarder, $GUI_HIDE)
				For $i = 1 To $ModeGroup[0] Step 1
					GUICtrlSetState($ModeGroup[$i], $GUI_HIDE)
				Next
				For $i = 1 To $ActiveWindows[0] Step 1
					WinSetState($GUIs[$ActiveWindows[$i]], "", @SW_SHOW)
				Next
				_SetScriptData()
			Else
				_DebugAdd("Control["&_GetIndex($SelectedControl)&"] Selected is not a Graphic Control", $ErrorColor)
			EndIf
		Case $HelpAutoIt
			$hDirCut = StringSplit($AutoItDir, "\")
			Dim $hHelpDir = ""
			For $i = 1 to $hDirCut[0]-1 Step 1
				$hHelpDir &= $hDirCut[$i]&"\"
			Next
			$hHelpDir &= "AutoIt3.chm"
			Run($hHelpDir)
		Case $SettingsMenu
			$hSelColor = StringTrimLeft(Hex($SelectColor, 8), 2)
			$hGrdColor = StringTrimLeft(Hex($GridLineColor, 8), 2)
			$hInsColor = StringTrimLeft(Hex($InsertColor, 8), 2)
			$hDrgColor = StringTrimLeft(Hex($DragColor, 8), 2)
			$hHover = 0
			$EditSettings = True
			$CurrentSelection = 1
			$sSettingsGUI = GUICreate("Settings", 550, 351, -1, -1)
			GUICtrlCreateLabel("", 140, 1, 1, 350)
			GUICtrlSetBkColor(-1, 0xC0C0C0)
			GUICtrlCreateLabel("", 141, 0, 1, 350)
			GUICtrlSetBkColor(-1, 0xFFFFFF)
			$sDefaults = GUICtrlCreateLabel("Display", 1, 1, 138, 16)
			GUICtrlSetStyle(-1, $SS_CENTER)
			GUICtrlSetFont(-1, 9, 800, 0)
			GUICtrlSetBkColor(-1, 0x57B4F9)
			GUICtrlCreateLabel("", 0, 18, 140, 1)
			GUICtrlSetBkColor(-1, 0xC0C0C0)
			$sOptions = GUICtrlCreateLabel("Options", 1, 20, 138, 16)
			GUICtrlSetStyle(-1, $SS_CENTER)
			GUICtrlSetFont(-1, 9, 800, 0)
			GUICtrlSetBkColor(-1, 0xE0E0E0)
			$sScriptLabel = GUICtrlCreateLabel("Script", 1, 39, 138, 16)
			GUICtrlSetStyle(-1, $SS_CENTER)
			GUICtrlSetFont(-1, 9, 800, 0)
			GUICtrlSetBkColor(-1, 0xE0E0E0)
			GUICtrlCreateLabel("", 0, 37, 140, 1)
			GUICtrlSetBkColor(-1, 0xC0C0C0)
			GUICtrlCreateLabel("", 0, 56, 140, 1)
			GUICtrlSetBkColor(-1, 0xC0C0C0)
			GUICtrlCreateLabel("ver. 1.0 beta", 5, 338, 60, 15)
			GUICtrlSetFont(-1, 7)
			$sItem1 = GUICtrlCreateGroup(" Colors ", 152, 11, 385, 157)
			$sItem2 = GUICtrlCreateLabel("Selected Color:", 194, 43, 84, 15)
			$sItem3 = GUICtrlCreateLabel("Grid Line Color:", 194, 68, 84, 15)
			$sItem4 = GUICtrlCreateLabel("Inserting Color:", 194, 93, 84, 15)
			$sItem5 = GUICtrlCreateLabel("Drag Color:", 194, 118, 84, 15)
			$sSchemeLabel = GUICtrlCreateLabel("Script Color Scheme:", 195, 142, 104, 17)
			$sSchemeCombo = GUICtrlCreateCombo("", 320, 140, 130, 21, 0x003)
			GUICtrlSetData(-1, "Default|New SciTE Scheme", $ScriptColorScheme)
			$sSelInput = GUICtrlCreateInput($hSelColor, 320, 36, 60, 22)
			$sCorInput = GUICtrlCreateInput($hGrdColor, 320, 62, 60, 22)
			$sInsInput = GUICtrlCreateInput($hInsColor, 320, 88, 60, 22)
			$sDrgInput = GUICtrlCreateInput($hDrgColor, 320, 114, 60, 22)
			$sItem6 = GUICtrlCreateLabel("", 393, 36, 22, 22)
			GUICtrlSetBkColor(-1, 0x000000)
			GUICtrlSetState(-1, $GUI_DISABLE)
			$sItem7 = GUICtrlCreateLabel("", 393, 61, 22, 22)
			GUICtrlSetBkColor(-1, 0x000000)
			GUICtrlSetState(-1, $GUI_DISABLE)
			$sItem8 = GUICtrlCreateLabel("", 393, 87, 22, 22)
			GUICtrlSetBkColor(-1, 0x000000)
			GUICtrlSetState(-1, $GUI_DISABLE)
			$sItem9 = GUICtrlCreateLabel("", 393, 113, 22, 22)
			GUICtrlSetBkColor(-1, 0x000000)
			GUICtrlSetState(-1, $GUI_DISABLE)
			$sSelectDisplay = GUICtrlCreateLabel("", 394, 37, 20, 20)
			GUICtrlSetBkColor(-1, $SelectColor)
			$sCornerDisplay = GUICtrlCreateLabel("", 394, 62, 20, 20)
			GUICtrlSetBkColor(-1, $GridLineColor)
			$sInsertDisplay = GUICtrlCreateLabel("", 394, 88, 20, 20)
			GUICtrlSetBkColor(-1, $InsertColor)
			$sDragDisplay = GUICtrlCreateLabel("", 394, 114, 20, 20)
			GUICtrlSetBkColor(-1, $DragColor)
			$sItem10 = GUICtrlCreateGroup(" Font ", 152, 172, 385, 137)
			$sSaveButton = GUICtrlCreateButton("Save", 448, 316, 94, 26)
			$sItem11 = GUICtrlCreateLabel("Control Font:", 194, 194, 84, 15)
			$sItem12 = GUICtrlCreateLabel("Application Font:", 194, 220, 84, 15)
			$sItem13 = GUICtrlCreateLabel("Tree Font Size:", 194, 246, 84, 15)
			$sItem14 = GUICtrlCreateLabel("Script Font Size:", 194, 272, 84, 15)
			$sControlFontCombo = GUICtrlCreateCombo("", 320, 188, 170, 22, 0x083)
			GUICtrlSetData(-1, $Fonts, $ControlFont)
			$sAppFontCombo = GUICtrlCreateCombo("", 320, 215, 170, 22, 0x083)
			GUICtrlSetData(-1, $Fonts, $ApplicationFont)
			$sTreeSizeInput = GUICtrlCreateInput($TreeFontSize, 320, 241, 100, 22)
			$sTreeUpDown = GUICtrlCreateUpdown($sTreeSizeInput)
			$sScriptSizeInput = GUICtrlCreateInput($ScriptFontSize, 320, 268, 100, 22)
			$sScriptUpDown = GUICtrlCreateUpdown($sScriptSizeInput)
			$sItem15 = GUICtrlCreateGroup(" Settings ", 152, 11, 385, 298)
			$sItem16 = GUICtrlCreateLabel("Default Save Dir:", 194, 43, 84, 15)
			$sItem17 = GUICtrlCreateLabel("Default Window Size:", 194, 70, 120, 15)
			$sItem18 = GUICtrlCreateLabel("W:", 312, 70, 20, 15)
			$sItem19 = GUICtrlCreateLabel("H:", 402, 70, 20, 15)
			$sDirInput = GUICtrlCreateInput($DefaultSaveDir, 300, 36, 180, 22)
			$sWInput = GUICtrlCreateInput($NewWindowW, 332, 64, 60, 22)
			$sHInput = GUICtrlCreateInput($NewWindowH, 420, 64, 60, 22)
			$sItem20 = GUICtrlCreateLabel("Auto Align Sensitivity:", 194, 97)
			$sAlignSensitivity = GUICtrlCreateSlider(320, 93, 140, 26, 0x0001)
			GUICtrlSetData(-1, $AutoSnapSensitivity * 10)
			$sAlignLabel = GUICtrlCreateLabel($AutoSnapSensitivity, 465, 100, 50, 18)
			GUICtrlSetFont(-1, 9, 800)
			$sStartupCheckbox = GUICtrlCreateCheckbox("  Load Last Project on Startup", 210, 134, 200, 15)
			$sUpdateCheckbox = GUICtrlCreateCheckbox("  Check for Updates on Startup", 210, 161, 200, 15)
			$sAutoCheckbox = GUICtrlCreateCheckbox("  Auto Update Variables", 210, 188, 200, 15)
			$sTopCheckbox = GUICtrlCreateRadio("  Apply New Controls to Top Layer", 210, 215, 200, 15)
			$sBottomCheckbox = GUICtrlCreateRadio("  Apply New Controls to Bottom Layer", 210, 242, 200, 15)
			$sDebugMode = GUICtrlCreateCheckbox("  Debug Mode", 210, 269, 200, 15)
			$sSettingsGroup = GUICtrlCreateGroup(" Script Settings ", 152, 11, 383, 298)
			$sScriptOutLabel = GUICtrlCreateLabel("Script Output:", 192, 46, 86, 15)
			$sGUIMsgMode = GUICtrlCreateRadio(" GUIMsg Mode", 322, 44, 172, 19)
			$sGUIOnEventMode = GUICtrlCreateRadio("GUIOnEvent Mode", 322, 71, 187, 23)
			$sDefaultlabel = GUICtrlCreateLabel("Default Includes:", 192, 108, 100, 17)
			$sIncludeEdit = GUICtrlCreateEdit("", 176, 131, 331, 153)
			GUICtrlSetState($sSettingsGroup, $GUI_HIDE)
			GUICtrlSetState($sScriptOutLabel, $GUI_HIDE)
			GUICtrlSetState($sGUIMsgMode, $GUI_HIDE)
			GUICtrlSetState($sGUIOnEventMode, $GUI_HIDE)
			GUICtrlSetState($sDefaultlabel, $GUI_HIDE)
			GUICtrlSetState($sIncludeEdit, $GUI_HIDE)
			GUICtrlSetState($sItem15, $GUI_HIDE)
			GUICtrlSetState($sItem16, $GUI_HIDE)
			GUICtrlSetState($sItem17, $GUI_HIDE)
			GUICtrlSetState($sItem18, $GUI_HIDE)
			GUICtrlSetState($sItem19, $GUI_HIDE)
			GUICtrlSetState($sItem20, $GUI_HIDE)
			GUICtrlSetState($sAlignSensitivity, $GUI_HIDE)
			GUICtrlSetState($sAlignLabel, $GUI_HIDE)
			GUICtrlSetState($sDirInput, $GUI_HIDE)
			GUICtrlSetState($sWInput, $GUI_HIDE)
			GUICtrlSetState($sHInput, $GUI_HIDE)
			GUICtrlSetState($sStartupCheckbox, $GUI_HIDE)
			GUICtrlSetState($sUpdateCheckbox, $GUI_HIDE)
			GUICtrlSetState($sAutoCheckbox, $GUI_HIDE)
			GUICtrlSetState($sTopCheckbox, $GUI_HIDE)
			GUICtrlSetState($sBottomCheckbox, $GUI_HIDE)
			GUICtrlSetState($sDebugMode, $GUI_HIDE)
			GUISetState()
			If $LoadLast = "True" Then
				GUICtrlSetState($sStartupCheckbox, $GUI_CHECKED)
			EndIf
			If $AutoCheckUpdate = "True" Then
				GUICtrlSetState($sUpdateCheckbox, $GUI_CHECKED)
			EndIf
			If $UpdateVars = "True" Then
				GUICtrlSetState($sAutoCheckbox, $GUI_CHECKED)
			EndIf
			If $NewControlLayer = "Bottom" Then
				GUICtrlSetState($sBottomCheckbox, $GUI_CHECKED)
			Else
				GUICtrlSetState($sTopCheckbox, $GUI_CHECKED)
			EndIf
			If $ScriptOutputMode = "GUIOnEvent" Then
				GUICtrlSetState($sGUIOnEventMode, $GUI_CHECKED)
				GUICtrlSetState($sGUIMsgMode, $GUI_UNCHECKED)
			Else
				$ScriptOutputMode = "GUIMsg"
				GUICtrlSetState($sGUIOnEventMode, $GUI_UNCHECKED)
				GUICtrlSetState($sGUIMsgMode, $GUI_CHECKED)
			EndIf
			If $Debug = "True" Then
				GUICtrlSetState($sDebugMode, $GUI_CHECKED)
			Else
				GUICtrlSetState($sDebugMode, $GUI_UNCHECKED)
			EndIf
			While $EditSettings = True
				If GUICtrlRead($sAlignSensitivity) <> $AutoSnapSensitivity Then
					$AutoSnapSensitivity = Round(GUICtrlRead($sAlignSensitivity) / 10)
					IniWrite(@ScriptDir & "/Config.ini", "Vars", "AutoAlignSensitivity", $AutoSnapSensitivity)
					GUICtrlSetData($sAlignLabel, $AutoSnapSensitivity)
				EndIf
				If GUICtrlRead($sSelInput) <> $hSelColor Then
					$hSelColor = GUICtrlRead($sSelInput)
					GUICtrlSetBkColor($sSelectDisplay, "0x" & $hSelColor)
				EndIf
				If GUICtrlRead($sCorInput) <> $hGrdColor Then
					$hGrdColor = GUICtrlRead($sCorInput)
					GUICtrlSetBkColor($sCornerDisplay, "0x" & $hGrdColor)
				EndIf
				If GUICtrlRead($sInsInput) <> $hInsColor Then
					$hInsColor = GUICtrlRead($sInsInput)
					GUICtrlSetBkColor($sInsertDisplay, "0x" & $hInsColor)
				EndIf
				If GUICtrlRead($sDrgInput) <> $hDrgColor Then
					$hDrgColor = GUICtrlRead($sDrgInput)
					GUICtrlSetBkColor($sDragDisplay, "0x" & $hDrgColor)
				EndIf
				$hMsg = GUIGetMsg()
				Switch $hMsg
					Case $GUI_EVENT_CLOSE
						GUIDelete($sSettingsGUI)
						$EditSettings = False
					Case $sSelectDisplay
						$hGetColor = _ChooseColor(2, "0x" & $hSelColor)
						If $hGetColor <> -1 Then
							$hSelColor = Hex($hGetColor, 6)
							GUICtrlSetBkColor($sSelectDisplay, $hGetColor)
							GUICtrlSetData($sSelInput, $hSelColor)
						EndIf
					Case $sCornerDisplay
						$hGetColor = _ChooseColor(2, "0x" & $hGrdColor)
						If $hGetColor <> -1 Then
							$hGrdColor = Hex($hGetColor, 6)
							GUICtrlSetBkColor($sCornerDisplay, $hGetColor)
							GUICtrlSetData($sCorInput, $hGrdColor)
						EndIf
					Case $sInsertDisplay
						$hGetColor = _ChooseColor(2, "0x" & $hInsColor)
						If $hGetColor <> -1 Then
							$hInsColor = Hex($hGetColor, 6)
							GUICtrlSetBkColor($sInsertDisplay, $hGetColor)
							GUICtrlSetData($sInsInput, $hInsColor)
						EndIf
					Case $sDragDisplay
						$hGetColor = _ChooseColor(2, "0x" & $hDrgColor)
						If $hGetColor <> -1 Then
							$hDrgColor = Hex($hGetColor, 6)
							GUICtrlSetBkColor($sDragDisplay, $hGetColor)
							GUICtrlSetData($sDrgInput, $hDrgColor)
						EndIf
					Case $sSaveButton
						$SelectColor = "0x" & $hSelColor
						$GridLineColor = "0x" & $hGrdColor
						$InsertColor = "0x" & $hInsColor
						$DragColor = "0x" & $hDrgColor
						$hColorScheme = GUICtrlRead($sSchemeCombo)
						$ControlFont = GUICtrlRead($sControlFontCombo)
						$hApplicationFont = GUICtrlRead($sAppFontCombo)
						$TreeFontSize = GUICtrlRead($sTreeSizeInput)
						$hScriptFontSize = GUICtrlRead($sScriptSizeInput)
						GUICtrlSetFont($hTree, $TreeFontSize)
						GUICtrlSetFont($ScriptEdit, $ScriptFontSize, 400, 0, $ApplicationFont)
						$DefaultSaveDir = GUICtrlRead($sDirInput)
						$NewWindowW = GUICtrlRead($sWInput)
						$NewWindowH = GUICtrlRead($sHInput)
						If $hScriptFontSize <> $ScriptFontSize and $hApplicationFont <> $ApplicationFont Then
							$ScriptFontSize = $hScriptFontSize
							$ApplicationFont = $hApplicationFont
							_GUICtrlRichEdit_SetFont($ScriptEdit, $ScriptFontSize, $ApplicationFont)
						ElseIf $hScriptFontSize <> $ScriptFontSize Then
							ConsoleWrite("New font Size: "&$hScriptFontSize&@CRLF)
							$ScriptFontSize = $hScriptFontSize
							_GUICtrlRichEdit_SetFont($ScriptEdit, $ScriptFontSize, $ApplicationFont)
						ElseIf $hApplicationFont <> $ApplicationFont Then
							$ApplicationFont = $hApplicationFont
							_GUICtrlRichEdit_SetFont($ScriptEdit, $ScriptFontSize, $ApplicationFont)
						EndIf
						If $hColorScheme <> $ScriptColorScheme Then
							$ScriptColorScheme = $hColorScheme
							If $ScriptColorScheme = "Default" Then
								_SetReshDefaultColors()
							ElseIf $ScriptColorScheme = "New SciTE Scheme" Then
								_SetReshAutoItColors()
							EndIf
						EndIf
						If GUICtrlRead($sGUIOnEventMode) = $GUI_CHECKED Then
							$ScriptOutputMode = "GUIOnEvent"
						Else
							$ScriptOutputMode = "GUIMsg"
						EndIf
						If GUICtrlRead($sStartupCheckbox) = $GUI_CHECKED Then
							$LoadLast = "True"
						Else
							$LoadLast = "False"
						EndIf
						If GUICtrlRead($sUpdateCheckbox) = $GUI_CHECKED Then
							$UpdateVars = "True"
						Else
							$UpdateVars = "False"
						EndIf
						If GUICtrlRead($sAutoCheckbox) = $GUI_CHECKED Then
							$AutoCheckUpdate = "True"
						Else
							$AutoCheckUpdate = "False"
						EndIf
						If GUICtrlRead($sBottomCheckbox) = $GUI_CHECKED Then
							$NewControlLayer = "Bottom"
						Else
							$NewControlLayer = "Top"
						EndIf
						If GUICtrlRead($sDebugMode) = $GUI_CHECKED Then
							If $Debug = "False" Then
								$Debug = "True"
								$hDebugWin = GUICreate( "Debug", 623, 127, 0, 297)
								$hBkGround = GUICtrlCreateLabel("", 4, 4, 615, 120)
								GUICtrlSetState( -1, $GUI_DISABLE)
								GUICtrlSetBkColor( -1, 0xD0D0D0)
								$hDebugList = GUICtrlCreateListView( "[                   ]", 5, 5, 613, 118, bitor($LVS_NOCOLUMNHEADER, $LVS_SHOWSELALWAYS))
								_GUICtrlListView_AddColumn($hDebugList, "DEBUG LIST VIEW               ", 550)
								_GUICtrlListView_SetColumnWidth($hDebugList, 0, 70)
								_GUICtrlListView_SetColumnWidth($hDebugList, 1, 500)
								GUISetState(@SW_HIDE)
								DllCall($dll, "int", "SetParent", "hwnd", WinGetHandle($hDebugWin), "hwnd", WinGetHandle($GUIHolder))
								GUISetState(@SW_SHOW)
								_DebugAdd("Debug Started", $NoErrorColor)
							Else
								$Debug = "True"
							EndIf
						Else
							If $Debug = "True" Then
								GUIDelete($hDebugWin)
							EndIf
							$Debug = "False"
						EndIf
						IniWrite(@ScriptDir & "/Config.ini", "Colors", "SelectedColor", $hSelColor)
						IniWrite(@ScriptDir & "/Config.ini", "Colors", "GridLineColor", $hGrdColor)
						IniWrite(@ScriptDir & "/Config.ini", "Colors", "DragColor", $hDrgColor)
						IniWrite(@ScriptDir & "/Config.ini", "Colors", "InsertColor", $hInsColor)
						IniWrite(@ScriptDir & "/Config.ini", "Font", "ControlFont", $ControlFont)
						IniWrite(@ScriptDir & "/Config.ini", "Font", "AppFont", $ApplicationFont)
						IniWrite(@ScriptDir & "/Config.ini", "Font", "TreeSize", $TreeFontSize)
						IniWrite(@ScriptDir & "/Config.ini", "Font", "ScriptSize", $ScriptFontSize)
						IniWrite(@ScriptDir & "/Config.ini", "Vars", "SaveDir", $DefaultSaveDir)
						IniWrite(@ScriptDir & "/Config.ini", "Vars", "NewWindowW", $NewWindowW)
						IniWrite(@ScriptDir & "/Config.ini", "Vars", "NewWindowH", $NewWindowH)
						IniWrite(@ScriptDir & "/Config.ini", "Vars", "LoadLast", $LoadLast)
						IniWrite(@ScriptDir & "/Config.ini", "Vars", "AutoUpdateVars", $UpdateVars)
						IniWrite(@ScriptDir & "/Config.ini", "Vars", "CheckUpdate", $AutoCheckUpdate)
						IniWrite(@ScriptDir & "/Config.ini", "Vars", "NewControls", $NewControlLayer)
						IniWrite(@ScriptDir & "/Config.ini", "Vars", "ScriptMode", $ScriptOutputMode)
						IniWrite(@ScriptDir & "/Config.ini", "Vars", "ScriptScheme", $ScriptColorScheme)
						IniWrite(@ScriptDir & "/Config.ini", "Vars", "Debug", $Debug)
						GUICtrlSetBkColor($TabTop, "0x" & $hInsColor)
						GUICtrlSetBkColor($TabBottom, "0x" & $hInsColor)
						GUICtrlSetBkColor($TabLeft, "0x" & $hInsColor)
						GUICtrlSetBkColor($TabRight, "0x" & $hInsColor)
						GUIDelete($sSettingsGUI)
						$EditSettings = False
						_SetScriptData()
				EndSwitch
				If _IsPressed("01") Then
					If $hHover <> 0 Then
						Switch $hHover
							Case $sDefaults
								$CurrentSelection = 1
								GUICtrlSetBkColor($sDefaults, 0x57B4F9)
								GUICtrlSetBkColor($sOptions, 0xE0E0E0)
								GUICtrlSetBkColor($sScriptLabel, 0xE0E0E0)
								GUICtrlSetState($sSchemeLabel, $GUI_SHOW)
								GUICtrlSetState($sSchemeCombo, $GUI_SHOW)
								GUICtrlSetState($sItem1, $GUI_SHOW)
								GUICtrlSetState($sItem2, $GUI_SHOW)
								GUICtrlSetState($sItem3, $GUI_SHOW)
								GUICtrlSetState($sItem4, $GUI_SHOW)
								GUICtrlSetState($sItem5, $GUI_SHOW)
								GUICtrlSetState($sItem6, $GUI_SHOW)
								GUICtrlSetState($sItem7, $GUI_SHOW)
								GUICtrlSetState($sItem8, $GUI_SHOW)
								GUICtrlSetState($sItem9, $GUI_SHOW)
								GUICtrlSetState($sItem10, $GUI_SHOW)
								GUICtrlSetState($sItem11, $GUI_SHOW)
								GUICtrlSetState($sItem12, $GUI_SHOW)
								GUICtrlSetState($sItem13, $GUI_SHOW)
								GUICtrlSetState($sItem14, $GUI_SHOW)
								GUICtrlSetState($sSelInput, $GUI_SHOW)
								GUICtrlSetState($sCorInput, $GUI_SHOW)
								GUICtrlSetState($sInsInput, $GUI_SHOW)
								GUICtrlSetState($sDrgInput, $GUI_SHOW)
								GUICtrlSetState($sSelectDisplay, $GUI_SHOW)
								GUICtrlSetState($sCornerDisplay, $GUI_SHOW)
								GUICtrlSetState($sInsertDisplay, $GUI_SHOW)
								GUICtrlSetState($sDragDisplay, $GUI_SHOW)
								GUICtrlSetState($sTreeSizeInput, $GUI_SHOW)
								GUICtrlSetState($sScriptSizeInput, $GUI_SHOW)
								GUICtrlSetState($sControlFontCombo, $GUI_SHOW)
								GUICtrlSetState($sAppFontCombo, $GUI_SHOW)
								GUICtrlSetState($sTreeUpDown, $GUI_SHOW)
								GUICtrlSetState($sScriptUpDown, $GUI_SHOW)
								GUICtrlSetState($sItem15, $GUI_HIDE)
								GUICtrlSetState($sItem16, $GUI_HIDE)
								GUICtrlSetState($sItem17, $GUI_HIDE)
								GUICtrlSetState($sItem18, $GUI_HIDE)
								GUICtrlSetState($sItem19, $GUI_HIDE)
								GUICtrlSetState($sDirInput, $GUI_HIDE)
								GUICtrlSetState($sWInput, $GUI_HIDE)
								GUICtrlSetState($sHInput, $GUI_HIDE)
								GUICtrlSetState($sStartupCheckbox, $GUI_HIDE)
								GUICtrlSetState($sUpdateCheckbox, $GUI_HIDE)
								GUICtrlSetState($sAutoCheckbox, $GUI_HIDE)
								GUICtrlSetState($sTopCheckbox, $GUI_HIDE)
								GUICtrlSetState($sBottomCheckbox, $GUI_HIDE)
								GUICtrlSetState($sItem20, $GUI_HIDE)
								GUICtrlSetState($sAlignSensitivity, $GUI_HIDE)
								GUICtrlSetState($sAlignLabel, $GUI_HIDE)
								GUICtrlSetState($sSettingsGroup, $GUI_HIDE)
								GUICtrlSetState($sScriptOutLabel, $GUI_HIDE)
								GUICtrlSetState($sGUIMsgMode, $GUI_HIDE)
								GUICtrlSetState($sGUIOnEventMode, $GUI_HIDE)
								GUICtrlSetState($sDefaultlabel, $GUI_HIDE)
								GUICtrlSetState($sIncludeEdit, $GUI_HIDE)
								GUICtrlSetState($sDebugMode, $GUI_HIDE)
							Case $sOptions
								$CurrentSelection = 2
								GUICtrlSetBkColor($sOptions, 0x57B4F9)
								GUICtrlSetBkColor($sDefaults, 0xE0E0E0)
								GUICtrlSetBkColor($sScriptLabel, 0xE0E0E0)
								GUICtrlSetState($sSchemeLabel, $GUI_HIDE)
								GUICtrlSetState($sSchemeCombo, $GUI_HIDE)
								GUICtrlSetState($sItem1, $GUI_HIDE)
								GUICtrlSetState($sItem2, $GUI_HIDE)
								GUICtrlSetState($sItem3, $GUI_HIDE)
								GUICtrlSetState($sItem4, $GUI_HIDE)
								GUICtrlSetState($sItem5, $GUI_HIDE)
								GUICtrlSetState($sItem6, $GUI_HIDE)
								GUICtrlSetState($sItem7, $GUI_HIDE)
								GUICtrlSetState($sItem8, $GUI_HIDE)
								GUICtrlSetState($sItem9, $GUI_HIDE)
								GUICtrlSetState($sItem10, $GUI_HIDE)
								GUICtrlSetState($sItem11, $GUI_HIDE)
								GUICtrlSetState($sItem12, $GUI_HIDE)
								GUICtrlSetState($sItem13, $GUI_HIDE)
								GUICtrlSetState($sItem14, $GUI_HIDE)
								GUICtrlSetState($sSelInput, $GUI_HIDE)
								GUICtrlSetState($sCorInput, $GUI_HIDE)
								GUICtrlSetState($sInsInput, $GUI_HIDE)
								GUICtrlSetState($sDrgInput, $GUI_HIDE)
								GUICtrlSetState($sSelectDisplay, $GUI_HIDE)
								GUICtrlSetState($sCornerDisplay, $GUI_HIDE)
								GUICtrlSetState($sInsertDisplay, $GUI_HIDE)
								GUICtrlSetState($sDragDisplay, $GUI_HIDE)
								GUICtrlSetState($sTreeSizeInput, $GUI_HIDE)
								GUICtrlSetState($sScriptSizeInput, $GUI_HIDE)
								GUICtrlSetState($sControlFontCombo, $GUI_HIDE)
								GUICtrlSetState($sAppFontCombo, $GUI_HIDE)
								GUICtrlSetState($sTreeUpDown, $GUI_HIDE)
								GUICtrlSetState($sScriptUpDown, $GUI_HIDE)
								GUICtrlSetState($sItem15, $GUI_SHOW)
								GUICtrlSetState($sItem16, $GUI_SHOW)
								GUICtrlSetState($sItem17, $GUI_SHOW)
								GUICtrlSetState($sItem18, $GUI_SHOW)
								GUICtrlSetState($sItem19, $GUI_SHOW)
								GUICtrlSetState($sDirInput, $GUI_SHOW)
								GUICtrlSetState($sWInput, $GUI_SHOW)
								GUICtrlSetState($sHInput, $GUI_SHOW)
								GUICtrlSetState($sStartupCheckbox, $GUI_SHOW)
								GUICtrlSetState($sUpdateCheckbox, $GUI_SHOW)
								GUICtrlSetState($sAutoCheckbox, $GUI_SHOW)
								GUICtrlSetState($sTopCheckbox, $GUI_SHOW)
								GUICtrlSetState($sBottomCheckbox, $GUI_SHOW)
								GUICtrlSetState($sItem20, $GUI_SHOW)
								GUICtrlSetState($sAlignSensitivity, $GUI_SHOW)
								GUICtrlSetState($sAlignLabel, $GUI_SHOW)
								GUICtrlSetState($sDebugMode, $GUI_SHOW)
								GUICtrlSetState($sSettingsGroup, $GUI_HIDE)
								GUICtrlSetState($sScriptOutLabel, $GUI_HIDE)
								GUICtrlSetState($sGUIMsgMode, $GUI_HIDE)
								GUICtrlSetState($sGUIOnEventMode, $GUI_HIDE)
								GUICtrlSetState($sDefaultlabel, $GUI_HIDE)
								GUICtrlSetState($sIncludeEdit, $GUI_HIDE)
							Case $sScriptLabel
								$CurrentSelection = 3
								GUICtrlSetBkColor($sScriptLabel, 0x57B4F9)
								GUICtrlSetBkColor($sOptions, 0xE0E0E0)
								GUICtrlSetBkColor($sDefaults, 0xE0E0E0)
								GUICtrlSetState($sItem1, $GUI_HIDE)
								GUICtrlSetState($sItem2, $GUI_HIDE)
								GUICtrlSetState($sItem3, $GUI_HIDE)
								GUICtrlSetState($sItem4, $GUI_HIDE)
								GUICtrlSetState($sItem5, $GUI_HIDE)
								GUICtrlSetState($sItem6, $GUI_HIDE)
								GUICtrlSetState($sItem7, $GUI_HIDE)
								GUICtrlSetState($sItem8, $GUI_HIDE)
								GUICtrlSetState($sItem9, $GUI_HIDE)
								GUICtrlSetState($sItem10, $GUI_HIDE)
								GUICtrlSetState($sItem11, $GUI_HIDE)
								GUICtrlSetState($sItem12, $GUI_HIDE)
								GUICtrlSetState($sItem13, $GUI_HIDE)
								GUICtrlSetState($sItem14, $GUI_HIDE)
								GUICtrlSetState($sSchemeLabel, $GUI_HIDE)
								GUICtrlSetState($sSchemeCombo, $GUI_HIDE)
								GUICtrlSetState($sSelInput, $GUI_HIDE)
								GUICtrlSetState($sCorInput, $GUI_HIDE)
								GUICtrlSetState($sInsInput, $GUI_HIDE)
								GUICtrlSetState($sDrgInput, $GUI_HIDE)
								GUICtrlSetState($sSelectDisplay, $GUI_HIDE)
								GUICtrlSetState($sCornerDisplay, $GUI_HIDE)
								GUICtrlSetState($sInsertDisplay, $GUI_HIDE)
								GUICtrlSetState($sDragDisplay, $GUI_HIDE)
								GUICtrlSetState($sTreeSizeInput, $GUI_HIDE)
								GUICtrlSetState($sScriptSizeInput, $GUI_HIDE)
								GUICtrlSetState($sControlFontCombo, $GUI_HIDE)
								GUICtrlSetState($sAppFontCombo, $GUI_HIDE)
								GUICtrlSetState($sTreeUpDown, $GUI_HIDE)
								GUICtrlSetState($sScriptUpDown, $GUI_HIDE)
								GUICtrlSetState($sItem15, $GUI_HIDE)
								GUICtrlSetState($sItem16, $GUI_HIDE)
								GUICtrlSetState($sItem17, $GUI_HIDE)
								GUICtrlSetState($sItem18, $GUI_HIDE)
								GUICtrlSetState($sItem19, $GUI_HIDE)
								GUICtrlSetState($sDirInput, $GUI_HIDE)
								GUICtrlSetState($sWInput, $GUI_HIDE)
								GUICtrlSetState($sHInput, $GUI_HIDE)
								GUICtrlSetState($sDebugMode, $GUI_HIDE)
								GUICtrlSetState($sStartupCheckbox, $GUI_HIDE)
								GUICtrlSetState($sUpdateCheckbox, $GUI_HIDE)
								GUICtrlSetState($sAutoCheckbox, $GUI_HIDE)
								GUICtrlSetState($sTopCheckbox, $GUI_HIDE)
								GUICtrlSetState($sBottomCheckbox, $GUI_HIDE)
								GUICtrlSetState($sItem20, $GUI_HIDE)
								GUICtrlSetState($sAlignSensitivity, $GUI_HIDE)
								GUICtrlSetState($sAlignLabel, $GUI_HIDE)
								GUICtrlSetState($sSettingsGroup, $GUI_SHOW)
								GUICtrlSetState($sScriptOutLabel, $GUI_SHOW)
								GUICtrlSetState($sGUIMsgMode, $GUI_SHOW)
								GUICtrlSetState($sGUIOnEventMode, $GUI_SHOW)
								GUICtrlSetState($sDefaultlabel, $GUI_SHOW)
								GUICtrlSetState($sIncludeEdit, $GUI_SHOW)
						EndSwitch
					EndIf
					Do
						Sleep(50)
					Until _IsPressed("01") = False
				EndIf
				$hMouse = GUIGetCursorInfo($sSettingsGUI)
				If IsArray($hMouse) Then
					If $hMouse[4] <> $hHover Then
						$hHover = $hMouse[4]
						Switch $hMouse[4]
							Case $sDefaults
								Switch $CurrentSelection
									Case 1
										GUICtrlSetBkColor($sOptions, 0xE0E0E0)
										GUICtrlSetBkColor($sScriptLabel, 0xE0E0E0)
									Case 2
										GUICtrlSetBkColor($sDefaults, 0x74D9FA)
										GUICtrlSetBkColor($sScriptLabel, 0xE0E0E0)
									Case 3
										GUICtrlSetBkColor($sOptions, 0xE0E0E0)
										GUICtrlSetBkColor($sDefaults, 0x74D9FA)
								EndSwitch
							Case $sOptions
								Switch $CurrentSelection
									Case 1
										GUICtrlSetBkColor($sOptions, 0x74D9FA)
										GUICtrlSetBkColor($sScriptLabel, 0xE0E0E0)
									Case 2
										GUICtrlSetBkColor($sScriptLabel, 0xE0E0E0)
										GUICtrlSetBkColor($sDefaults, 0xE0E0E0)
									Case 3
										GUICtrlSetBkColor($sDefaults, 0xE0E0E0)
										GUICtrlSetBkColor($sOptions, 0x74D9FA)
								EndSwitch
							Case $sScriptLabel
								Switch $CurrentSelection
									Case 1
										GUICtrlSetBkColor($sOptions, 0xE0E0E0)
										GUICtrlSetBkColor($sScriptLabel, 0x74D9FA)
									Case 2
										GUICtrlSetBkColor($sScriptLabel, 0x74D9FA)
										GUICtrlSetBkColor($sDefaults, 0xE0E0E0)
									Case 3
										GUICtrlSetBkColor($sDefaults, 0xE0E0E0)
										GUICtrlSetBkColor($sOptions, 0xE0E0E0)
								EndSwitch
							Case 0
								Switch $CurrentSelection
									Case 1
										GUICtrlSetBkColor($sOptions, 0xE0E0E0)
										GUICtrlSetBkColor($sScriptLabel, 0xE0E0E0)
									Case 2
										GUICtrlSetBkColor($sScriptLabel, 0xE0E0E0)
										GUICtrlSetBkColor($sDefaults, 0xE0E0E0)
									Case 3
										GUICtrlSetBkColor($sOptions, 0xE0E0E0)
										GUICtrlSetBkColor($sDefaults, 0xE0E0E0)
								EndSwitch
						EndSwitch
					EndIf
				EndIf
				Sleep(50)
			WEnd
		Case $InsertButton
			If $GUIHandles[0] > 1 Then
				$InsertMode = True

				$hInsertGUI = GUICreate( "Set GUI Parent", 269, 100, -1, -1)
				$hLabel = GUICtrlCreateLabel( "Parent Window:", 10, 11, 90, 18)
				$hLabel1 = GUICtrlCreateLabel( "Child Window:", 18, 41, 70, 18)
				$hInsertParents = GUICtrlCreateCombo( "", 102, 7, 155, 21, 0x003)
				GUICtrlSetData($hInsertParents, "|"&_ArrayToString($GUIHandles, "|", 1, $GUIHandles[0]), $GUIHandles[1])
				$hInsertChildren = GUICtrlCreateCombo( "", 102, 37, 155, 21, 0x003)
				GUICtrlSetData($hInsertChildren, "|"&_ArrayToString($GUIHandles, "|", 1, $GUIHandles[0]), $GUIHandles[$GUIHandles[0]])
				$hInsApply = GUICtrlCreateButton( "Apply", 169, 71, 95, 25)
				$hInsCancel = GUICtrlCreateButton( "Cancel", 62, 71, 95, 25)
				GUISetState()

				While $InsertMode = True
					$hMsg = GUIGetMsg()
					Switch $hMsg
						Case $GUI_EVENT_CLOSE
							$InsertMode = False
							GUIDelete($hInsertGUI)
						Case $hInsApply
							$hParent = GUICtrlRead($hInsertParents)
							$hChildName = GUICtrlRead($hInsertChildren)
							$hParentIndex = "0"
							$hChildIndex = "0"
							If $hParent <> $hChildName Then
								For $i = 1 to $GUIHandles[0] Step 1
									If $hParent = $GUIHandles[$i] Then
										$hParentIndex = $i
									ElseIf $hChildName = $GUIHandles[$i] Then
										$hChildIndex = $i
									EndIf
								Next
								$GUIParent[$hChildIndex] = $GUIHandles[$hParentIndex]
								GUISetState(@SW_HIDE, $GUIS[$hChildIndex])
								DllCall($dll, "int", "SetParent", "hwnd", WinGetHandle($GUIS[$hChildIndex]), "hwnd", WinGetHandle($GUIS[$hParentIndex]))
								GUISetState(@SW_SHOW, $GUIS[$hChildIndex])
								WinMove($GUIS[$hChildIndex], "", 100, 100)
								$GUIX[$hChildIndex] = 100
								$GUIY[$hChildIndex] = 100
							EndIf
							$InsertMode = False
							GUIDelete($hInsertGUI)
							_SetScriptData()
					EndSwitch
				WEnd
			EndIf


		Case $DelGUIButton
			If $CurrentWindow <> 0 and $GUIS[0] > 0 Then
				$hMsgbox = Msgbox( 0x3, "Delete "&$GUIHandles[$CurrentWindow], "Are you sure you want to delete Window "&$GUIHandles[$CurrentWindow]&"?"&@CRLF&"This action cannot be undone.")
				If $hMsgbox = 6 Then
					_HideAllResizeTabs()
					_ClearControlData()
					_GUICtrlTreeView_BeginUpdate($hTree)
					For $i = $Controls[0] to 1 Step -1
						If $Parents[$i] = $GUIHandles[$CurrentWindow] Then
							_ArrayDelete($TreeItems, $i)
							$TreeItems[0] -= 1
							_DeleteResizeTabs($Controls[$i])
							_DeleteControl($i)
						EndIf
					Next
					_GUICtrlTreeView_Expand($hTree, $hFileTree)
					_GUICtrlTreeView_Delete($hTree, $GUITrees[$CurrentWindow])
					_GDIPlus_GraphicsDispose($GUIPlus[$CurrentWindow])
					GUIDelete($GUIs[$CurrentWindow])
					_ArrayDelete($GUIs, $CurrentWindow)
					_ArrayDelete($GUIHandles, $CurrentWindow)
					_ArrayDelete($WinTitles, $CurrentWindow)
					_ArrayDelete($GUITrees, $CurrentWindow)
					_ArrayDelete($GUIColors, $CurrentWindow)
					_ArrayDelete($GUIVars, $CurrentWindow)
					_ArrayDelete($GUIScript, $CurrentWindow)
					_ArrayDelete($GUIComment, $CurrentWindow)
					_ArrayDelete($GUIStyle, $CurrentWindow)
					_ArrayDelete($GUIMenus, $CurrentWindow)
					_ArrayDelete($GUIProperties, $CurrentWindow)
					_ArrayDelete($GUIX, $CurrentWindow)
					_ArrayDelete($GUIY, $CurrentWindow)
					_ArrayDelete($GUISnapLineX, $CurrentWindow)
					_ArrayDelete($GUISnapLineY, $CurrentWindow)
					_ArrayDelete($GUISetStateData, $CurrentWindow)
					_ArrayDelete($GUIPlus, $CurrentWindow)
					_ArrayDelete($GUIParent, $CurrentWindow)
					$GUIParent[0] -= 1
					$GUIPlus[0] -= 1
					$GUISetStateData[0] -= 1
					$GUISnapLineX[0] -= 1
					$GUISnapLineY[0] -= 1
					$GUIX[0] -= 1
					$GUIY[0] -= 1
					$GUIProperties[0] -= 1
					$GUIMenus[0] -= 1
					$GUIComment[0] -= 1
					$GUIStyle[0] -= 1
					$GUIScript[0] -= 1
					$GUIVars[0] -= 1
					$GUIColors[0] -= 1
					$GUITrees[0] -= 1
					$GUIHandles[0] -= 1
					$WinTitles[0] -= 1
					$GUIs[0] -= 1
					$ChildCount -= 1
					_GUICtrlTreeView_EndUpdate($hTree)
					$CurrentWindow -= 1
					_SetScriptData()
				EndIf
			EndIf
		Case $AddGUIButton
			_HideAllResizeTabs()
			_ClearControlData()
			$ChildCount += 1
			Dim $SelectedControl = 0, $MultiSelect = False, $MultiControls[1] = [0]
			_GUICtrlTreeView_Expand($hTree, $hFileTree)
			_GUICtrlTreeView_BeginUpdate($hTree)
			If $ChildCount = 0 Then
				$hTreeGUI = _GUICtrlTreeView_AddChild($hTree, $hFileTree, "hGUI")
				$NewGUI = GUICreate("New Window", 1000, 1000, 50, 50, BitOR($WS_CAPTION, $WS_SIZEBOX, $WS_SYSMENU))
			Else
				$hTreeGUI = _GUICtrlTreeView_AddChild($hTree, $hFileTree, "hChild_" & $ChildCount)
				$NewGUI = GUICreate("New Child", 1000, 1000, 50, 50, BitOR($WS_CAPTION, $WS_SIZEBOX, $WS_SYSMENU))
			EndIf
			_GUICtrlTreeView_SetIcon($hTree, $hTreeGUI, @ScriptDir & "\Resources.dll", -119)
			_ArrayAdd($GUITrees, $hTreeGUI)
			$GUITrees[0] += 1
			$TabTop = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
			GUICtrlSetBkColor(-1, $InsertColor)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetResizing(-1, 802)
			$TabBottom = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
			GUICtrlSetBkColor(-1, $InsertColor)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetResizing(-1, 802)
			$TabLeft = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
			GUICtrlSetBkColor(-1, $InsertColor)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetResizing(-1, 802)
			$TabRight = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
			GUICtrlSetBkColor(-1, $InsertColor)
			GUICtrlSetState(-1, $GUI_HIDE)
			GUICtrlSetResizing(-1, 802)
			$SnapLineX = GUICtrlCreateLabel("", -5, -5, 1, 1)
			GUICtrlSetBkColor(-1, 0xFF00FF)
			$SnapLineY = GUICtrlCreateLabel("", -5, -5, 1, 1)
			GUICtrlSetBkColor(-1, 0xFF00FF)
			$SnapLineW = GUICtrlCreateLabel("", -5, -5, 1, 1)
			GUICtrlSetBkColor(-1, 0xFF00FF)
			$SnapLineH = GUICtrlCreateLabel("", -5, -5, 1, 1)
			GUICtrlSetBkColor(-1, 0xFF00FF)
			GUISetState(@SW_HIDE, $NewGUI)
			DllCall($dll, "int", "SetParent", "hwnd", WinGetHandle($NewGUI), "hwnd", WinGetHandle($GUIHolder))
			GUISetState(@SW_SHOW, $NewGUI)

			$hGraphic = _GDIPlus_GraphicsCreateFromHWND($NewGUI)
			WinMove($NewGUI, "", 80, 80, 400, 300)
			_ArrayAdd($GUIs, $NewGUI)
			If $ChildCount = 0 Then
				_ArrayAdd($GUIHandles, "hGUI")
				_ArrayAdd($WinTitles, "New Window")
			Else
				_ArrayAdd($GUIHandles, "hChild_" & $ChildCount)
				_ArrayAdd($WinTitles, "New Child")
			EndIf
			_ArrayAdd($GUIColors, "")
			_ArrayAdd($GUIVars, "")
			_ArrayAdd($GUIScript, "")
			_ArrayAdd($GUIComment, "")
			_ArrayAdd($GUIStyle, "")
			_ArrayAdd($GUIMenus, "")
			_ArrayAdd($GUIProperties, $CurrentWindow)
			_ArrayAdd($GUIX, "-1")
			_ArrayAdd($GUIY, "-1")
			_ArrayAdd($GUISnapLineX, $SnapLineX)
			_ArrayAdd($GUISnapLineY, $SnapLineY)
			_ArrayAdd($GUISetStateData, "")
			_ArrayAdd($GUIParent, "0")
			_ArrayAdd($GUIPlus, $hGraphic)
			$GUIParent[0] += 1
			$GUIPlus[0] += 1
			$GUISetStateData[0] += 1
			$GUISnapLineX[0] += 1
			$GUISnapLineY[0] += 1
			$GUIX[0] += 1
			$GUIY[0] += 1
			$GUIProperties[0] += 1
			$GUIMenus[0] += 1
			$GUIComment[0] += 1
			$GUIStyle[0] += 1
			$GUIScript[0] += 1
			$GUIVars[0] += 1
			$GUIColors[0] += 1
			$GUIs[0] += 1
			$WinTitles[0] += 1
			$GUIHandles[0] += 1
			_GUICtrlTreeView_EndUpdate($hTree)
			_SetScriptData()
		Case $PlayButton
			$Playing = True
			$hTemp = FileOpen("temp.au3", 2)
			FileWrite($hTemp, _GenerateCode())
			FileClose($hTemp)
			$hPID = Run($AutoItDir & " temp.au3")
			GUICtrlSetImage($PlayButton, @ScriptDir & "\Resources.dll", 242, 0)
			GUICtrlSetState($PlayButton, $GUI_DISABLE)
			GUICtrlSetImage($StopButton, @ScriptDir & "\Resources.dll", 243, 0)
			GUICtrlSetState($StopButton, $GUI_ENABLE)
			GUISetState(@SW_DISABLE, $GUIS[$CurrentWindow])
			_DebugAdd("Script Started", $NoErrorColor)
			While $Playing = True
				$hMsg = GUIGetMsg()
				Switch $hMsg
					Case $StopButton
						$Playing = False
						ProcessClose($hPID)
						GUICtrlSetImage($StopButton, @ScriptDir & "\Resources.dll", 244, 0)
						GUICtrlSetState($StopButton, $GUI_DISABLE)
						GUICtrlSetImage($PlayButton, @ScriptDir & "\Resources.dll", 241, 0)
						GUICtrlSetState($PlayButton, $GUI_ENABLE)
				EndSwitch
				If ProcessExists($hPID) = False Then
					$Playing = False
					GUICtrlSetImage($StopButton, @ScriptDir & "\Resources.dll", 244, 0)
					GUICtrlSetState($StopButton, $GUI_DISABLE)
					GUICtrlSetImage($PlayButton, @ScriptDir & "\Resources.dll", 241, 0)
					GUICtrlSetState($PlayButton, $GUI_ENABLE)
				EndIf
			WEnd
			GUISetState(@SW_ENABLE, $GUIS[$CurrentWindow])
			FileDelete("temp.au3")
			_DebugAdd("Script Closed", $NoErrorColor)
		Case $StopButton
			$Playing = False
			ProcessClose($hPID)
			GUICtrlSetImage($StopButton, @ScriptDir & "\Resources.dll", 244, 0)
			GUICtrlSetState($StopButton, $GUI_DISABLE)
			GUICtrlSetImage($PlayButton, @ScriptDir & "\Resources.dll", 241, 0)
			GUICtrlSetState($PlayButton, $GUI_ENABLE)
			FileDelete("temp.au3")
			_DebugAdd("Script Closed", $NoErrorColor)
		Case $UpLayer
			If $SelectedControl <> 0 And $MultiSelect = False Then
				$RefNum = _GetIndex($SelectedControl)
				$CurrentIndex = $LayerCount - $Layers[$RefNum]
				If $CurrentIndex > 0 Then
					ControlShow("", "", $SelectedControl)
					_WinAPI_RedrawWindow($GUIs[$CurrentWindow])
					_GUICtrlListView_SetItemSelected($LayerList, $CurrentIndex - 1, True)
					$Layers[$RefNum] += 1
					_DebugAdd("Control["&$RefNum&"] Layer set to "&$Layers[$RefNum], $NoErrorColor)
				EndIf
				_SetScriptData()
			EndIf
		Case $DownLayer
			If $SelectedControl <> 0 And $MultiSelect = False Then
				$RefNum = _GetIndex($SelectedControl)
				$CurrentIndex = $LayerCount - $Layers[$RefNum]
				If $CurrentIndex < $LayerCount Then
					_GUICtrlListView_SetItemSelected($LayerList, $CurrentIndex + 1, True)
					$Layers[$RefNum] -= 1
					_DebugAdd("Control["&$RefNum&"] Layer set to "&$Layers[$RefNum], $NoErrorColor)
				EndIf
				_SetScriptData()
			EndIf
		Case $SubLayer
			If $LayerCount >= 1 Then
				Dim $LayerDel = True
				$hDelLayer = GUICreate( "Delete Layer", 263, 71, -1, -1)
				$hLayerCombo = GUICtrlCreateCombo( "", 97, 9, 150, 21, 0x003)
				$Label2 = GUICtrlCreateLabel( "Delete Layer:", 15, 15, 82, 15)
				$hDelete = GUICtrlCreateButton( "Delete", 156, 39, 100, 25)
				$hCancel = GUICtrlCreateButton( "Cancel", 48, 39, 100, 25)
				Dim $hText = '', $hFirst = ''
				For $i = $LayerCount to 1 Step -1
					If $hText = '' Then
						$hText &= _GUICtrlListView_GetItemText($LayerList, $i-1)
						$hFirst = $hText
					Else
						$hText &= "|"&_GUICtrlListView_GetItemText($LayerList, $i-1)
					EndIf
				Next
				GUICtrlSetData($hLayerCombo, $hText, $hFirst)
				GUISetState()

				While $LayerDel = True
					$hMsg = GUIGetMsg()
					Switch $hMsg
						Case $GUI_EVENT_CLOSE
							$LayerDel = False
							GUIDelete($hDelLayer)
						Case $hDelete
							$hLayerCount = _GUICtrlListView_GetItemCount($LayerList)-1
							$hLayerDel = GUICtrlRead($hLayerCombo)
							$hLayerIndex = _GUICtrlListView_FindText($LayerList, $hLayerDel, -1, False)
							_GUICtrlListView_BeginUpdate($LayerList)
							_GUICtrlListView_DeleteItem($LayerList, $hLayerIndex)
							_GUICtrlListView_EndUpdate($LayerList)
							$hLayerNum = $hLayerCount-$hLayerIndex
							For $i = 1 to $Controls[0] Step 1
								If $Layers[$i] = $hLayerNum Then
									$Layers[$i] = "0"
								EndIf
							Next
							$LayerDel = False
							GUIDelete($hDelLayer)
					EndSwitch
				WEnd


			EndIf
		Case $AddLayer
			$CreatingLayer = True
			$LayerGUI = GUICreate("Add Layer", 205, 112, -1, -1)
			GUICtrlCreateLabel("Layer Name:", 10, 11, 65, 15)
			$LayerInput = GUICtrlCreateInput("Layer " & $LayerCount + 1, 77, 5, 120, 21)
			$OnTop = GUICtrlCreateRadio("Add Layer on Top", 74, 34, 142, 16)
			GUICtrlSetState(-1, $GUI_CHECKED)
			$OnBottom = GUICtrlCreateRadio("Add Layer on Bottom", 74, 55, 142, 16)
			$AddButton = GUICtrlCreateButton("Add", 95, 80, 100, 24)
			GUISetState()
			While $CreatingLayer = True
				$hMsg = GUIGetMsg()
				Switch $hMsg
					Case $GUI_EVENT_CLOSE
						GUIDelete($LayerGUI)
						$CreatingLayer = False
					Case $AddButton
						If GUICtrlRead($OnTop) = $GUI_CHECKED Then
							_GUICtrlListView_InsertItem($LayerList, GUICtrlRead($LayerInput), 0)
						Else
							_GUICtrlListView_InsertItem($LayerList, GUICtrlRead($LayerInput), $LayerCount)
						EndIf
						$LayerCount += 1
						GUIDelete($LayerGUI)
						$CreatingLayer = False
				EndSwitch
			WEnd
		Case $ColorEx
			If $SelectedControl <> 0 And $MultiSelect = False Then
				$RefNum = _GetIndex($SelectedControl)
				$hColor = _ChooseColor(2, '0x' & GUICtrlRead($ColorInput), 2, $hGUI)
				If $hColor <> -1 Then
					$Colors[$RefNum] = StringTrimLeft($hColor, 2)
					GUICtrlSetData($ColorInput, StringTrimLeft($hColor, 2))
					GUICtrlSetColor($SelectedControl, $hColor)
					GUICtrlSetBkColor($ColorEx, $hColor)
					_SetScriptData()
				EndIf
			EndIf
		Case $BkColorEx
			If $SelectedControl <> 0 And $MultiSelect = False Then
				$RefNum = _GetIndex($SelectedControl)
				$hBkColor = _ChooseColor(2, '0x' & GUICtrlRead($BkColorInput), 2, $hGUI)
				If $hBkColor <> -1 Then
					$BkColors[$RefNum] = StringTrimLeft($hBkColor, 2)
					GUICtrlSetData($BkColorInput, StringTrimLeft($hBkColor, 2))
					GUICtrlSetBkColor($SelectedControl, $hBkColor)
					GUICtrlSetBkColor($BkColorEx, $hBkColor)
					_SetScriptData()
				EndIf
			ElseIf $GUISelected = True Then
				$hBkColor = _ChooseColor(2, '0x' & GUICtrlRead($BkColorInput), 2, $hGUI)
				If $hBkColor <> -1 Then
					$GUIColors[$CurrentWindow] = StringTrimLeft($hBkColor, 2)
					GUICtrlSetData($BkColorInput, StringTrimLeft($hBkColor, 2))
					GUISetBkColor($hBkColor, $GUIs[$CurrentWindow])
					GUICtrlSetBkColor($BkColorEx, $hBkColor)
					_SetScriptData()
				EndIf
			EndIf
		Case $ImageEx
			If $SelectedControl <> 0 And $MultiSelect = False Then
				$RefNum = _GetIndex($SelectedControl)
				$hFile = FileOpenDialog("Open Image", $Images[$RefNum], "Images (*.jpg;*.bmp;*.gif;*.ico;*.dll)", 1)
				If Not @Error Then
					If StringinStr($hFile, ".dll") Then
						$hIconData = _WinAPI_PickIconDlg($hFile, 0, $hGUI)
						If Not @Error Then
							GUICtrlSetImage($SelectedControl, $hFile, -(1 + $hIconData[1]), 0)
							GUICtrlSetData($ImageInput, $hFile&"|"&-(1 + $hIconData[1])&"|0")
							$Images[$RefNum] = $hFile&"|"&-(1 + $hIconData[1])&"|0"
						EndIf
					Else
						GUICtrlSetImage($SelectedControl, $hFile)
						GUICtrlSetData($ImageInput, $hFile)
						$Images[$RefNum] = $hFile
					EndIf
					GUISetState()
					_SetScriptData()
				EndIf
			EndIf
		Case $StyleEx
			If $GUISelected = True Then
				$hIndex = $GUIFocusIndex
				$SelStyles = "$GUI_SS_DEFAULT_GUI|$WS_BORDER|$WS_POPUP|$WS_CAPTION|$WS_CLIPCHILDREN|$WS_CLIPSIBLINGS|$WS_DISABLED|$WS_DLGFRAME|$WS_HSCROLL|$WS_MAXIMIZE|$WS_MAXIMIZEBOX|$WS_MINIMIZE|$WS_MINIMIZEBOX|$WS_OVERLAPPED|$WS_OVERLAPPEDWINDOW|$WS_POPUPWINDOW|$WS_SIZEBOX|$WS_SYSMENU|$WS_THICKFRAME|$WS_VSCROLL|$WS_VISIBLE|$WS_CHILD|$WS_GROUP|$WS_TABSTOP|$DS_MODALFRAME|$DS_SETFOREGROUND|$DS_CONTEXTHELP|$WS_EX_ACCEPTFILES|$WS_EX_APPWINDOW|$WS_EX_CLIENTEDGE|$WS_EX_CONTEXTHELP|$WS_EX_DLGMODALFRAME|$WS_EX_MDICHILD|$WS_EX_OVERLAPPEDWINDOW|$WS_EX_STATICEDGE|$WS_EX_TOPMOST|$WS_EX_TRANSPARENT|$WS_EX_TOOLWINDOW|$WS_EX_WINDOWEDGE|$WS_EX_LAYERED"
				$AddingStyle = True
				$StyleGUI = GUICreate("Add Style", 313, 363, -1, -1)
				GUICtrlCreateLabel("Styles:", 6, 10, 38, 13)
				$StyleCombo = GUICtrlCreateCombo("", 45, 5, 230, 21, 0x0003)
				GUICtrlSetData($StyleCombo, $SelStyles, "")
				_GUICtrlComboBox_SetCurSel($StyleCombo, 0)
				$AddStyleButton = GUICtrlCreateButton("+", 281, 3, 25, 25)
				GUICtrlSetFont($AddStyleButton, 12, 800, 0)
				$StyleListView = GUICtrlCreateListView("Control Style", 34, 31, 271, 300, 0x00280000)
				_GUICtrlListView_SetColumnWidth($StyleListView, 0, 220)
				$StyleSave = GUICtrlCreateButton("Save", 227, 334, 80, 25)
				$hCancel = GUICtrlCreateButton("Cancel", 144, 334, 80, 25)
				$DeleteStyleButton = GUICtrlCreateButton("-", 5, 55, 25, 25)
				GUICtrlSetFont($DeleteStyleButton, 8.5, 800, 0)
				If $GUIStyle[$hIndex] <> "" Then
					If StringInStr($GUIStyle[$hIndex], "|") Then
						$hSplit = StringSplit($GUIStyle[$hIndex], "|")
						For $i = 1 To $hSplit[0] Step 1
							_GUICtrlListView_AddItem($StyleListView, $hSplit[$i])
						Next
					Else
						_GUICtrlListView_AddItem($StyleListView, $GUIStyle[$hIndex])
					EndIf
				EndIf
				GUISetState()
				While $AddingStyle = True
					$hMsg = GUIGetMsg()
					Switch $hMsg
						Case $GUI_EVENT_CLOSE
							GUIDelete($StyleGUI)
							$AddingStyle = False
						Case $AddStyleButton
							$hSelect = GUICtrlRead($StyleCombo)
							If $hSelect <> "" Then
								_GUICtrlListView_AddItem($StyleListView, $hSelect)
								$GUIStyle[$hIndex] &= "|" & $hSelect
							EndIf
						Case $DeleteStyleButton
							_GUICtrlListView_DeleteItemsSelected(GUICtrlGetHandle($StyleListView))
						Case $hCancel
							GUIDelete($StyleGUI)
							$AddingStyle = False
						Case $StyleSave
							Dim $hStyles = ''
							$hCount = _GUICtrlListView_GetItemCount($StyleListView)
							For $i = 1 To $hCount Step 1
								If $i <> $hCount Then
									$hStyles &= _GUICtrlListView_GetItemText($StyleListView, $i - 1) & "|"
								Else
									$hStyles &= _GUICtrlListView_GetItemText($StyleListView, $i - 1)
								EndIf
							Next
							If StringinStr($GUIStyle[$hIndex], "$WS_POPUP") = True and StringinStr($hStyles, "$WS_POPUP") = False Then
								GUISetStyle(BitOr($WS_CAPTION, $WS_SIZEBOX, $WS_SYSMENU), -1, $GUIS[$hIndex])
							EndIf
							$GUIStyle[$hIndex] = $hStyles
							GUICtrlSetData($StyleInput, $hStyles)
							GUIDelete($StyleGUI)
							$AddingStyle = False
							If StringinStr($hStyles, "$WS_POPUP") Then
								GUISetStyle($WS_POPUP, -1, $GUIS[$hIndex])
								If $GUIParent[$hIndex] <> 0 Then
									For $i = 1 to $Controls[0] Step 1
										If $Controls[$i] = "Scroll"&$hIndex Then
											$Split = StringSplit($Data[$i], "|")
											_GUIScrollBars_SetScrollInfoMax($GUIS[$hIndex], $SB_HORZ, $Split[1])
											_GUIScrollBars_SetScrollInfoMax($GUIS[$hIndex], $SB_VERT, $Split[2])
											ExitLoop
										EndIf
									Next
								EndIf
							EndIf
							_SetScriptData()
					EndSwitch
				WEnd
			Else
				$Continue = False
				If $SelectedControl <> 0 And $MultiSelect = False And $AddingStyle = False  Then
					$Continue = True
				ElseIf StringinStr($SelectedControl,"Scroll") Then
					$Continue = True
				EndIf
				If $Continue = True Then
					$RefNum = _GetIndex($SelectedControl)
					$SelStyles = _GetStyles($Types[$RefNum])
					$AddingStyle = True
					$StyleGUI = GUICreate("Add Style", 313, 363, -1, -1)
					GUICtrlCreateLabel("Styles:", 6, 10, 38, 13)
					$StyleCombo = GUICtrlCreateCombo("", 45, 5, 230, 21, 0x0003)
					GUICtrlSetData($StyleCombo, $SelStyles, "")
					_GUICtrlComboBox_SetCurSel($StyleCombo, 0)
					$AddStyleButton = GUICtrlCreateButton("+", 281, 3, 25, 25)
					GUICtrlSetFont($AddStyleButton, 12, 800, 0)
					$StyleListView = GUICtrlCreateListView("Control Style", 34, 31, 271, 300, 0x0008)
					_GUICtrlListView_SetColumnWidth($StyleListView, 0, 220)
					$StyleSave = GUICtrlCreateButton("Save", 227, 334, 80, 25)
					$hCancel = GUICtrlCreateButton("Cancel", 144, 334, 80, 25)
					$DeleteStyleButton = GUICtrlCreateButton("-", 5, 55, 25, 25)
					GUICtrlSetFont($DeleteStyleButton, 8.5, 800, 0)
					If $Styles[$RefNum] <> "" Then
						If StringInStr($Styles[$RefNum], "|") Then
							$hSplit = StringSplit($Styles[$RefNum], "|")
							For $i = 1 To $hSplit[0] Step 1
								_GUICtrlListView_AddItem($StyleListView, $hSplit[$i])
							Next
						Else
							_GUICtrlListView_AddItem($StyleListView, $Styles[$RefNum])
						EndIf
					EndIf
					GUISetState()
					While $AddingStyle = True
						$hMsg = GUIGetMsg()
						Switch $hMsg
							Case $GUI_EVENT_CLOSE
								GUIDelete($StyleGUI)
								$AddingStyle = False
							Case $AddStyleButton
								$hSelect = GUICtrlRead($StyleCombo)
								If $hSelect <> "" Then
									_GUICtrlListView_AddItem($StyleListView, $hSelect)
									$Styles[$RefNum] &= "|" & $hSelect
								EndIf
							Case $DeleteStyleButton
								_GUICtrlListView_DeleteItemsSelected(GUICtrlGetHandle($StyleListView))
							Case $hCancel
								GUIDelete($StyleGUI)
								$AddingStyle = False
							Case $StyleSave
								Dim $hStyles = ''
								$hCount = _GUICtrlListView_GetItemCount($StyleListView)
								For $i = 1 To $hCount Step 1
									If $i <> $hCount Then
										$hStyles &= _GUICtrlListView_GetItemText($StyleListView, $i - 1) & "|"
									Else
										$hStyles &= _GUICtrlListView_GetItemText($StyleListView, $i - 1)
									EndIf
								Next
								If $Types[$RefNum] = 17 Then
									If StringInStr($hStyles, "$TBS_VERT") Then
										GUICtrlSetStyle($Controls[$RefNum], $TBS_VERT)
									ElseIf StringInStr($hStyles, "$TBS_HORZ") Then
										GUICtrlSetStyle($Controls[$RefNum], $TBS_HORZ)
									EndIf
								EndIf
								If StringinStr($hStyles, "|") Then
									$hSplit = StringSplit($hStyles, "|")
									Dim $ExStyles = ''
									Dim $StyleList = ''
									For $i = 1 to $hSplit[0] Step 1
										If StringinStr($hSplit[$i], "_EX_") Then
											If $ExStyles = '' Then
												$ExStyles += Eval($hSplit[$i])
											Else
												$ExStyles += ","&Eval($hSplit[$i])
											EndIf
										Else
											If $StyleList = '' Then
												$StyleList += Eval($hSplit[$i])
											Else
												$StyleList += ","&Eval($hSplit[$i])
											EndIf
										EndIf
									Next
									If $ExStyles = '' Then
										$ExStyles = -1
									ElseIf $StyleList = '' Then
										$StyleList = -1
									EndIf
									GUICtrlSetStyle($SelectedControl, $StyleList, $ExStyles)
								Else
									If $hStyles <> "" Then
										If StringinStr($hStyles, "_EX_") Then
											GUICtrlSetStyle($SelectedControl, -1, $hStyles)
										Else
											GUICtrlSetStyle($SelectedControl, $hStyles, -1)
										EndIf
									EndIf
								EndIf
								$Styles[$RefNum] = $hStyles
								GUICtrlSetData($StyleInput, $hStyles)
								GUIDelete($StyleGUI)
								If $Types[$RefNum] = 2 Then
									If StringinStr($hStyles, "$BS_ICON") Then
										GUICtrlSetStyle($Controls[$RefNum], $BS_ICON)
									ElseIf StringinStr($hStyles, "$BS_BITMAP") Then
										GUICtrlSetStyle($Controls[$RefNum], $BS_BITMAP)
									EndIf
								EndIf
								$AddingStyle = False
								_SetScriptData()
						EndSwitch
					WEnd
				EndIf
			EndIf
		Case $SaveScript
			$SaveDialoge = FileSaveDialog("Save Script", @ScriptDir & "\Forms\", "AutoIt Script (*.au3)", "", $ScriptName, $hGUI)
			If Not @error Then
				$ScriptText = _GenerateCode()
				$hFile = FileOpen($SaveDialoge & ".au3", 2)
				FileWrite($hFile, $ScriptText)
				FileClose($hFile)
				_DebugAdd("AutoIt Script Saved: "&$SaveDialoge&".au3", $NoErrorColor)
			EndIf

		Case $CopyScript
			ClipPut(_GUICtrlRichEdit_GetText($ScriptEdit))
		Case $New
			$hMsgbox = _CustomMsg("Close Project?", "Do you want to close the Current Project before creating a New Window?")
			If $hMsgbox = 6 Then
				_GUICtrlTab_DeleteItem($GUITab, 0)
				For $i = $GUIS[0] to 1 Step -1
					If BitAnd(WinGetState($GUIS[$i]), 2) Then
						_GDIPlus_GraphicsDispose($GUIPlus[$i])
						GUIDelete($GUIs[$i])
						_ArrayDelete($GUIs, $i)
						_ArrayDelete($GUIHandles, $i)
						_ArrayDelete($WinTitles, $i)
						_ArrayDelete($GUITrees, $i)
						_ArrayDelete($GUIColors, $i)
						_ArrayDelete($GUIVars, $i)
						_ArrayDelete($GUIScript, $i)
						_ArrayDelete($GUIComment, $i)
						_ArrayDelete($GUIStyle, $i)
						_ArrayDelete($GUIMenus, $i)
						_ArrayDelete($GUIProperties, $i)
						_ArrayDelete($GUIX, $i)
						_ArrayDelete($GUIY, $i)
						_ArrayDelete($GUISnapLineX, $i)
						_ArrayDelete($GUISnapLineY, $i)
						_ArrayDelete($GUISetStateData, $i)
						_ArrayDelete($GUIPlus, $i)
						_ArrayDelete($GUIParent, $i)
						$GUIParent[0] -= 1
						$GUIPlus[0] -= 1
						$GUISetStateData[0] -= 1
						$GUISnapLineX[0] -= 1
						$GUISnapLineY[0] -= 1
						$GUIX[0] -= 1
						$GUIY[0] -= 1
						$GUIProperties[0] -= 1
						$GUIMenus[0] -= 1
						$GUIComment[0] -= 1
						$GUIStyle[0] -= 1
						$GUIScript[0] -= 1
						$GUIVars[0] -= 1
						$GUIColors[0] -= 1
						$GUITrees[0] -= 1
						$GUIHandles[0] -= 1
						$WinTitles[0] -= 1
						$GUIs[0] -= 1
						$CurrentWindow = $i
						$ExtraWhileData = ""
						$ExtraIncludeData = ""
						$WhileData = "1"
						$AfterGUIData = ""

					EndIf
				Next
				_GUICtrlTab_InsertItem($GUITab, 0, "Untitled.gui")
				_GUICtrlTab_SetCurSel($GUITab, 0)
			;ElseIf $hMsgbox = 7 Then
			;	_SaveScript(@ScriptDir & "\Temp_" & $CurrentWindow & ".tmp")
			;	GUIDelete($GUIs[$CurrentWindow])
			;	$hCount = _GUICtrlTab_GetItemCount($GUITab)
			;	_GUICtrlTab_InsertItem($GUITab, $hCount, "Untitled.gui")
			;	_GUICtrlTab_SetCurSel($GUITab, $hCount)
			EndIf
			If $hMsgbox <> 2 Then
				_HideAllResizeTabs()
				_ClearControlData()
				For $i = $Controls[0] To 1 Step -1
					_DeleteResizeTabs($Controls[$i])
					_DeleteControl($i)
				Next

				_ClearData()
				$LayerCount = 0
				_GUICtrlListView_BeginUpdate($LayerList)
				_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($LayerList))
				_GUICtrlListView_AddItem($LayerList, "Layer 0")
				_GUICtrlListView_EndUpdate($LayerList)
				Dim $SelectedControl = 0, $MultiSelect = False, $MultiControls[1] = [0], $TreeItems[1] = [0]
				Dim $WhileData = "1", $ExtraWhileData = "", $ExtraIncludeData = ""
				_GUICtrlTreeView_BeginUpdate($hTree)
				_GUICtrlTreeView_DeleteAll($hTree)
				$hFileTree = _GUICtrlTreeView_AddChild($hTree, 0, "Untitled.gui")
				_GUICtrlTreeView_SetIcon($hTree, $hFileTree, @ScriptDir & "\Resources.dll", -279)
				$hTreeGUI = _GUICtrlTreeView_AddChild($hTree, $hFileTree, "hGUI")
				_GUICtrlTreeView_SetIcon($hTree, $hTreeGUI, @ScriptDir & "\Resources.dll", -119)
				_ArrayAdd($GUITrees, $hTreeGUI)
				$GUITrees[0] += 1
				$CurrentWindow += 1
				$NewGUI = GUICreate("New Window", 1000, 1000, 30, 30, BitOR($WS_CAPTION, $WS_SIZEBOX, $WS_SYSMENU))
				$TabTop = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
				GUICtrlSetBkColor(-1, $InsertColor)
				GUICtrlSetState(-1, $GUI_HIDE)
				GUICtrlSetResizing(-1, 802)
				$TabBottom = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
				GUICtrlSetBkColor(-1, $InsertColor)
				GUICtrlSetState(-1, $GUI_HIDE)
				GUICtrlSetResizing(-1, 802)
				$TabLeft = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
				GUICtrlSetBkColor(-1, $InsertColor)
				GUICtrlSetState(-1, $GUI_HIDE)
				GUICtrlSetResizing(-1, 802)
				$TabRight = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
				GUICtrlSetBkColor(-1, $InsertColor)
				GUICtrlSetState(-1, $GUI_HIDE)
				GUICtrlSetResizing(-1, 802)
				$SnapLineX = GUICtrlCreateLabel("", -5, -5, 1, 1)
				GUICtrlSetBkColor(-1, 0xFF00FF)
				$SnapLineY = GUICtrlCreateLabel("", -5, -5, 1, 1)
				GUICtrlSetBkColor(-1, 0xFF00FF)
				GUISetState(@SW_HIDE, $NewGUI)
				DllCall($dll, "int", "SetParent", "hwnd", WinGetHandle($NewGUI), "hwnd", WinGetHandle($GUIHolder))
				GUISetState(@SW_SHOW, $NewGUI)
				$hGraphic = _GDIPlus_GraphicsCreateFromHWND($NewGUI)
				WinMove($NewGUI, "", 50, 50, 484, 362)
				_ArrayAdd($GUIs, $NewGUI)
				_ArrayAdd($WinTitles, "New Window")
				_ArrayAdd($GUIHandles, "hGUI")
				_ArrayAdd($GUIColors, "")
				_ArrayAdd($GUIVars, "")
				_ArrayAdd($GUIScript, "")
				_ArrayAdd($GUIComment, "")
				_ArrayAdd($GUIStyle, "")
				_ArrayAdd($GUIMenus, "")
				_ArrayAdd($GUIProperties, "P" & $CurrentWindow)
				_ArrayAdd($GUIX, "-1")
				_ArrayAdd($GUIY, "-1")
				_ArrayAdd($GUISnapLineX, $SnapLineX)
				_ArrayAdd($GUISnapLineY, $SnapLineY)
				_ArrayAdd($GUISetStateData, "")
				_ArrayAdd($GUIParent, "0")
				_ArrayAdd($GUIPlus, $hGraphic)
				$GUIParent[0] += 1
				$GUIPlus[0] += 1
				$GUISetStateData[0] += 1
				$GUISnapLineX[0] += 1
				$GUISnapLineY[0] += 1
				$GUIX[0] += 1
				$GUIY[0] += 1
				$GUIProperties[0] += 1
				$GUIMenus[0] += 1
				$GUIComment[0] += 1
				$GUIStyle[0] += 1
				$GUIScript[0] += 1
				$GUIVars[0] += 1
				$GUIColors[0] += 1
				$GUIs[0] += 1
				$WinTitles[0] += 1
				$GUIHandles[0] += 1
				$WindowNum += 1
				_GUICtrlTreeView_EndUpdate($hTree)
				$ControlNum = 0
				$CurrentWindow = $GUIS[0]
			EndIf
			_SetScriptData()
		Case $SaveAs
			$SaveDialoge = FileSaveDialog("Save GUI", @ScriptDir & "\Forms\", "GUI Design File (*.gui)", 0, $SaveName, $hGUI)
			If Not @error Then
				$hDirSplit = StringSplit($SaveDialoge, "\")
				If Not StringInStr($SaveDialoge, ".gui") Then
					_SaveScript($SaveDialoge & ".gui")
					_GUICtrlTab_SetItemText($GUITab, _GUICtrlTab_GetCurSel($GUITab), $hDirSplit[$hDirSplit[0]] & ".gui")
					_DebugAdd("Script Saved: "&$SaveDialoge&".gui", $NoErrorColor)
				Else
					_SaveScript($SaveDialoge)
					_GUICtrlTab_SetItemText($GUITab, _GUICtrlTab_GetCurSel($GUITab), $hDirSplit[$hDirSplit[0]])
					_DebugAdd("Script Saved: "&$SaveDialoge, $NoErrorColor)
				EndIf
			EndIf
		Case $Save
			_SaveScript($SaveName)
			_DebugAdd("Script Saved: "&$SaveName, $NoErrorColor)
		Case $Open
			$OpenDialoge = FileOpenDialog("Open GUI", @ScriptDir & "\Forms\", "GUI Design File (*.gui)", 0, "", $hGUI)
			If Not @error Then
				_DebugAdd("Opening Script: "&$OpenDialoge, $NoErrorColor)
				_OpenScript($OpenDialoge, 0)
			Else
				_DebugAdd("Error Opening File @ERRORCODE: "&@Error, $ErrorColor)
			EndIf
		Case $GridButton
			If $GridEnabled = False Then
				$GridSpace = GUICtrlRead($GridInput)
				$GridEnabled = True
				_ResourceSetImageToCtrl($GridButton, "Grid", $RT_BITMAP)
				GUICtrlSetTip($GridButton, "Disable Grid")
				$hGrid = _DrawGrid($GridSpace, $GridLineColor)
			Else
				$GridEnabled = False
				_ResourceSetImageToCtrl($GridButton, "Grid_Disable", $RT_BITMAP)
				GUICtrlSetTip($GridButton, "Enable Grid")
				For $g = $GridHandles[0] to 1 Step -1
					GUICtrlDelete($GridHandles[$g])
				Next
				Dim $GridHandles[1] = [0]
			EndIf
		Case $GridSnap
			If GUICtrlRead($GridSnap) = $GUI_CHECKED Then
				IniWrite(@ScriptDir & "/Config.ini", "Vars", "GridSnap", "True")
				$Snap = True
				$GridSpace = GUICtrlRead($GridInput)
			Else
				IniWrite(@ScriptDir & "/Config.ini", "Vars", "GridSnap", "False")
				$Snap = False
			EndIf
		Case $Spacing_1
			If $MultiSelect = True Then
				Dim $ControlPos[1] = [0]
				For $i = $MultiControls[0] To 1 Step -1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						_ArrayAdd($ControlPos, $ControlInfo[0])
						$ControlPos[0] += 1
					EndIf
				Next
				$SortArray = $ControlPos
				_ArraySort($SortArray, 0, 1, $ControlPos[0])
				$LastWidth = 0
				For $b = 1 To $SortArray[0] Step 1
					For $i = $MultiControls[0] To 1 Step -1
						$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
						If Not @error Then
							If $SortArray[$b] = $ControlInfo[0] Then
								If $b <> 1 Then
									GUICtrlSetPos($MultiControls[$i], $NextPos, $ControlInfo[1], $ControlInfo[2], $ControlInfo[3])
									_MoveResizeTabs($MultiControls[$i])
									$NextPos = $NextPos + $ControlInfo[2] + $SpaceAmnt
								Else
									$NextPos = $ControlInfo[0] + $ControlInfo[2] + $SpaceAmnt
								EndIf
							EndIf
						EndIf
					Next
				Next
				_SetScriptData()
			EndIf
		Case $Spacing_2
			If $MultiSelect = True Then
				Dim $ControlPos[1] = [0]
				For $i = $MultiControls[0] To 1 Step -1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						_ArrayAdd($ControlPos, $ControlInfo[1])
						$ControlPos[0] += 1
					EndIf
				Next
				$SortArray = $ControlPos
				_ArraySort($SortArray, 0, 1, $ControlPos[1])
				$LastWidth = 0
				For $b = 1 To $SortArray[0] Step 1
					For $i = $MultiControls[0] To 1 Step -1
						$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
						If Not @error Then
							If $SortArray[$b] = $ControlInfo[1] Then
								If $b <> 1 Then
									GUICtrlSetPos($MultiControls[$i], $ControlInfo[0], $NextPos, $ControlInfo[2], $ControlInfo[3])
									_MoveResizeTabs($MultiControls[$i])
									$NextPos = $NextPos + $ControlInfo[3] + $SpaceAmnt
								Else
									$NextPos = $ControlInfo[1] + $ControlInfo[3] + $SpaceAmnt
								EndIf
							EndIf
						EndIf
					Next
				Next
				_SetScriptData()
			EndIf
		Case $Spacing_3
			If $MultiSelect = True Then
				Dim $ControlPos[1] = [0]
				For $i = $MultiControls[0] To 1 Step -1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						_ArrayAdd($ControlPos, $ControlInfo[0])
						$ControlPos[0] += 1
					EndIf
				Next
				$SortArray = $ControlPos
				_ArraySort($SortArray, 0, 1, $ControlPos[0])
				$LastWidth = 0
				For $b = 1 To $SortArray[0] Step 1
					For $i = $MultiControls[0] To 1 Step -1
						$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
						If Not @error Then
							If $SortArray[$b] = $ControlInfo[0] Then
								If $b <> 1 Then
									GUICtrlSetPos($MultiControls[$i], $NextPos, $ControlInfo[1], $ControlInfo[2], $ControlInfo[3])
									_MoveResizeTabs($MultiControls[$i])
									$NextPos = $NextPos + ($ControlInfo[2] / 2) + $SpaceAmnt
								Else
									$NextPos = $ControlInfo[0] + ($ControlInfo[2] / 2) + $SpaceAmnt
								EndIf
							EndIf
						EndIf
					Next
				Next
				_SetScriptData()
			EndIf
		Case $Spacing_4
		Case $AlignLeft
			If $MultiSelect = True Then
				$RecordedX = 9999
				For $i = $MultiControls[0] To 1 Step -1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						If $ControlInfo[0] < $RecordedX Then
							$RecordedX = $ControlInfo[0]
						EndIf
					EndIf
				Next
				For $i = $MultiControls[0] To 1 Step -1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						GUICtrlSetPos($MultiControls[$i], $RecordedX, $ControlInfo[1], $ControlInfo[2], $ControlInfo[3])
						_MoveResizeTabs($MultiControls[$i])
					EndIf
				Next
				_SetScriptData()
			EndIf
		Case $AlignRight
			If $MultiSelect = True Then
				$RecordedX = 0
				For $i = $MultiControls[0] To 1 Step -1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						If $ControlInfo[0] + $ControlInfo[2] > $RecordedX Then
							$RecordedX = $ControlInfo[0] + $ControlInfo[2]
						EndIf
					EndIf
				Next
				For $i = $MultiControls[0] To 1 Step -1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						GUICtrlSetPos($MultiControls[$i], $RecordedX - $ControlInfo[2], $ControlInfo[1], $ControlInfo[2], $ControlInfo[3])
						_MoveResizeTabs($MultiControls[$i])
					EndIf
				Next
				_SetScriptData()
			EndIf
		Case $AlignCentVert
			If $MultiSelect = True Then
				$RecordedX = 0
				For $i = $MultiControls[0] To 1 Step -1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						If $ControlInfo[0] + ($ControlInfo[2] / 2) > $RecordedX Then
							$RecordedX = $ControlInfo[0] + ($ControlInfo[2] / 2)
						EndIf
					EndIf
				Next
				For $i = $MultiControls[0] To 1 Step -1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						GUICtrlSetPos($MultiControls[$i], $RecordedX - ($ControlInfo[2] / 2), $ControlInfo[1], $ControlInfo[2], $ControlInfo[3])
						_MoveResizeTabs($MultiControls[$i])
					EndIf
				Next
				_SetScriptData()
			EndIf
		Case $AlignTop
			If $MultiSelect = True Then
				$RecordedX = 9999
				For $i = $MultiControls[0] To 1 Step -1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						If $ControlInfo[0] < $RecordedX Then
							$RecordedX = $ControlInfo[1]
						EndIf
					EndIf
				Next
				For $i = $MultiControls[0] To 1 Step -1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						GUICtrlSetPos($MultiControls[$i], $ControlInfo[0], $RecordedX, $ControlInfo[2], $ControlInfo[3])
						_MoveResizeTabs($MultiControls[$i])
					EndIf
				Next
				_SetScriptData()
			EndIf
		Case $AlignCentHoriz
			If $MultiSelect = True Then
				$RecordedX = 0
				For $i = $MultiControls[0] To 1 Step -1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						If $ControlInfo[1] + ($ControlInfo[3] / 2) > $RecordedX Then
							$RecordedX = $ControlInfo[1] + ($ControlInfo[3] / 2)
						EndIf
					EndIf
				Next
				For $i = $MultiControls[0] To 1 Step -1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						GUICtrlSetPos($MultiControls[$i], $ControlInfo[0], $RecordedX - ($ControlInfo[3] / 2), $ControlInfo[2], $ControlInfo[3])
						_MoveResizeTabs($MultiControls[$i])
					EndIf
				Next
				_SetScriptData()
			EndIf
		Case $AlignBottom
			If $MultiSelect = True Then
				$RecordedX = 0
				For $i = $MultiControls[0] To 1 Step -1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						If $ControlInfo[1] + $ControlInfo[3] > $RecordedX Then
							$RecordedX = $ControlInfo[1] + $ControlInfo[3]
						EndIf
					EndIf
				Next
				For $i = $MultiControls[0] To 1 Step -1
					$ControlInfo = ControlGetPos("", "", $MultiControls[$i])
					If Not @error Then
						GUICtrlSetPos($MultiControls[$i], $ControlInfo[0], $RecordedX - $ControlInfo[3], $ControlInfo[2], $ControlInfo[3])
						_MoveResizeTabs($MultiControls[$i])
					EndIf
				Next
				_SetScriptData()
			EndIf
		Case $BoldButton
			Dim $AttributeVal = ""
			$aSplit = StringSplit($FontInfo[$RefNum], "+")
			For $i = $aSplit[0] To 1 Step -1
				If $aSplit[$i] <> "" Then
					If $i = 2 Then
						$AttributeVal &= $aSplit[$i]
					Else
						$AttributeVal &= $aSplit[$i] & "+"
					EndIf
				EndIf
			Next
			If StringInStr($FontInfo[$RefNum], "+0+") Then
				GUICtrlSetBkColor($BoldButton, $InactiveColor)
				$FontInfo[$RefNum] = StringReplace($FontInfo[$RefNum], "+0+", "")
				GUICtrlSetFont($SelectedControl, $FontSize[$RefNum], 400, $AttributeVal, $Font[$RefNum])
			Else
				GUICtrlSetBkColor($BoldButton, $ActiveColor)
				$FontInfo[$RefNum] &= "+0+"
				GUICtrlSetFont($SelectedControl, $FontSize[$RefNum], 800, $AttributeVal, $Font[$RefNum])
			EndIf
			_SetScriptData()
		Case $ItalicButton
			If StringInStr($FontInfo[$RefNum], "+2+") Then
				GUICtrlSetBkColor($ItalicButton, $InactiveColor)
				$FontInfo[$RefNum] = StringReplace($FontInfo[$RefNum], "+2+", "")
			Else
				GUICtrlSetBkColor($ItalicButton, $ActiveColor)
				$FontInfo[$RefNum] &= "+2+"
			EndIf
			Dim $AttributeVal = ""
			$aSplit = StringSplit($FontInfo[$RefNum], "+")
			For $i = $aSplit[0] To 1 Step -1
				If $aSplit[$i] <> "" Then
					If $i = 2 Then
						$AttributeVal &= $aSplit[$i]
					Else
						$AttributeVal &= $aSplit[$i] & "+"
					EndIf
				EndIf
			Next
			If StringInStr($FontInfo[$RefNum], "+0+") Then
				GUICtrlSetFont($SelectedControl, $FontSize[$RefNum], 800, $AttributeVal, $Font[$RefNum])
			Else
				GUICtrlSetFont($SelectedControl, $FontSize[$RefNum], 400, $AttributeVal, $Font[$RefNum])
			EndIf
			_SetScriptData()
		Case $StrikeButton
			If StringInStr($FontInfo[$RefNum], "+8+") Then
				GUICtrlSetBkColor($StrikeButton, $InactiveColor)
				$FontInfo[$RefNum] = StringReplace($FontInfo[$RefNum], "+8+", "")
			Else
				GUICtrlSetBkColor($StrikeButton, $ActiveColor)
				$FontInfo[$RefNum] &= "+8+"
			EndIf
			Dim $AttributeVal = ""
			$aSplit = StringSplit($FontInfo[$RefNum], "+")
			For $i = $aSplit[0] To 1 Step -1
				If $aSplit[$i] <> "" Then
					If $i = 2 Then
						$AttributeVal &= $aSplit[$i]
					Else
						$AttributeVal &= $aSplit[$i] & "+"
					EndIf
				EndIf
			Next
			If StringInStr($FontInfo[$RefNum], "+0+") Then
				GUICtrlSetFont($SelectedControl, $FontSize[$RefNum], 800, $AttributeVal, $Font[$RefNum])
			Else
				GUICtrlSetFont($SelectedControl, $FontSize[$RefNum], 400, $AttributeVal, $Font[$RefNum])
			EndIf
			_SetScriptData()
		Case $UnderlineButton
			If StringInStr($FontInfo[$RefNum], "+4+") Then
				GUICtrlSetBkColor($UnderlineButton, $InactiveColor)
				$FontInfo[$RefNum] = StringReplace($FontInfo[$RefNum], "+4+", "")
			Else
				GUICtrlSetBkColor($UnderlineButton, $ActiveColor)
				$FontInfo[$RefNum] &= "+4+"
			EndIf
			Dim $AttributeVal = ""
			$aSplit = StringSplit($FontInfo[$RefNum], "+")
			For $i = $aSplit[0] To 1 Step -1
				If $aSplit[$i] <> "" Then
					If $i = 2 Then
						$AttributeVal &= $aSplit[$i]
					Else
						$AttributeVal &= $aSplit[$i] & "+"
					EndIf
				EndIf
			Next
			If StringInStr($FontInfo[$RefNum], "+0+") Then
				GUICtrlSetFont($SelectedControl, $FontSize[$RefNum], 800, $AttributeVal, $Font[$RefNum])
			Else
				GUICtrlSetFont($SelectedControl, $FontSize[$RefNum], 400, $AttributeVal, $Font[$RefNum])
			EndIf
			_SetScriptData()
		Case $ResizeRight
			If $SelectedControl <> 0 Then
				If StringInStr($Resize[$RefNum], "+4+") Then
					$Resize[$RefNum] = StringReplace($Resize[$RefNum], "+4+", "")
					_ResourceSetImageToCtrl($ResizeRight, "Resize_Right", $RT_BITMAP)
				Else
					$Resize[$RefNum] &= "+4+"
					_ResourceSetImageToCtrl($ResizeRight, "Resize_Right_Selected", $RT_BITMAP)
				EndIf
				$hResizeValue = _GetResizeValue($RefNum)
				GUICtrlSetResizing($Controls[$RefNum], $hResizeValue)
				_SetScriptData()
			EndIf
		Case $ResizeLeft
			If $SelectedControl <> 0 Then
				If StringInStr($Resize[$RefNum], "+2+") Then
					$Resize[$RefNum] = StringReplace($Resize[$RefNum], "+2+", "")
					_ResourceSetImageToCtrl($ResizeLeft, "Resize_Left", $RT_BITMAP)
				Else
					$Resize[$RefNum] &= "+2+"
					_ResourceSetImageToCtrl($ResizeLeft, "Resize_Left_Selected", $RT_BITMAP)
				EndIf
				$hResizeValue = _GetResizeValue($RefNum)
				GUICtrlSetResizing($Controls[$RefNum], $hResizeValue)
				_SetScriptData()
			EndIf
		Case $ResizeTop
			If $SelectedControl <> 0 Then
				If StringInStr($Resize[$RefNum], "+32+") Then
					$Resize[$RefNum] = StringReplace($Resize[$RefNum], "+32+", "")
					_ResourceSetImageToCtrl($ResizeTop, "Resize_Top", $RT_BITMAP)
				Else
					$Resize[$RefNum] &= "+32+"
					_ResourceSetImageToCtrl($ResizeTop, "Resize_Top_Selected", $RT_BITMAP)
				EndIf
				$hResizeValue = _GetResizeValue($RefNum)
				GUICtrlSetResizing($Controls[$RefNum], $hResizeValue)
				_SetScriptData()
			EndIf
		Case $ResizeBottom
			If $SelectedControl <> 0 Then
				If StringInStr($Resize[$RefNum], "+64+") Then
					$Resize[$RefNum] = StringReplace($Resize[$RefNum], "+64+", "")
					_ResourceSetImageToCtrl($ResizeBottom, "Resize_Bottom", $RT_BITMAP)
				Else
					$Resize[$RefNum] &= "+64+"
					_ResourceSetImageToCtrl($ResizeBottom, "Resize_Bottom_Selected", $RT_BITMAP)
				EndIf
				$hResizeValue = _GetResizeValue($RefNum)
				GUICtrlSetResizing($Controls[$RefNum], $hResizeValue)
				_SetScriptData()
			EndIf
		Case $ResizeH
			If $SelectedControl <> 0 Then
				If StringInStr($Resize[$RefNum], "+512+") Then
					$Resize[$RefNum] = StringReplace($Resize[$RefNum], "+512+", "")
					_ResourceSetImageToCtrl($ResizeH, "Resize_LockHeight", $RT_BITMAP)
				Else
					$Resize[$RefNum] &= "+512+"
					_ResourceSetImageToCtrl($ResizeH, "Resize_LockHeight_Selected", $RT_BITMAP)
				EndIf
				$hResizeValue = _GetResizeValue($RefNum)
				GUICtrlSetResizing($Controls[$RefNum], $hResizeValue)
				_SetScriptData()
			EndIf
		Case $ResizeW
			If $SelectedControl <> 0 Then
				If StringInStr($Resize[$RefNum], "+256+") Then
					$Resize[$RefNum] = StringReplace($Resize[$RefNum], "+256+", "")
					_ResourceSetImageToCtrl($ResizeW, "Resize_LockWidth", $RT_BITMAP)
				Else
					$Resize[$RefNum] &= "+256+"
					_ResourceSetImageToCtrl($ResizeW, "Resize_LockWidth_Selected", $RT_BITMAP)
				EndIf
				$hResizeValue = _GetResizeValue($RefNum)
				GUICtrlSetResizing($Controls[$RefNum], $hResizeValue)
				_SetScriptData()
			EndIf
		Case $ResizeHC
			If $SelectedControl <> 0 Then
				If StringInStr($Resize[$RefNum], "+8+") Then
					$Resize[$RefNum] = StringReplace($Resize[$RefNum], "+8+", "")
					_ResourceSetImageToCtrl($ResizeHC, "Resize_HCenter", $RT_BITMAP)
				Else
					$Resize[$RefNum] &= "+8+"
					_ResourceSetImageToCtrl($ResizeHC, "Resize_HCenter_Selected", $RT_BITMAP)
				EndIf
				$hResizeValue = _GetResizeValue($RefNum)
				GUICtrlSetResizing($Controls[$RefNum], $hResizeValue)
				_SetScriptData()
			EndIf
		Case $ResizeVC
			If $SelectedControl <> 0 Then
				If StringInStr($Resize[$RefNum], "+128+") Then
					$Resize[$RefNum] = StringReplace($Resize[$RefNum], "+128+", "")
					_ResourceSetImageToCtrl($ResizeVC, "Resize_VCenter", $RT_BITMAP)
				Else
					$Resize[$RefNum] &= "+128+"
					_ResourceSetImageToCtrl($ResizeVC, "Resize_VCenter_Selected", $RT_BITMAP)
				EndIf
				$hResizeValue = _GetResizeValue($RefNum)
				GUICtrlSetResizing($Controls[$RefNum], $hResizeValue)
				_SetScriptData()
			EndIf
		Case $cButton
			_DeselectControls()
			$SelectedTool = 1
		Case $cCheckbox
			_DeselectControls()
			$SelectedTool = 2
		Case $cCombo
			_DeselectControls()
			$SelectedTool = 3
		Case $cDate
			_DeselectControls()
			$SelectedTool = 4
		Case $cDummy
			_DeselectControls()
			$SelectedTool = 5
		Case $cEdit
			_DeselectControls()
			$SelectedTool = 6
		Case $cGroup
			_HideAllResizeTabs()
			_ClearControlData()
			$SelectedTool = 7
		Case $cGraphic
			_DeselectControls()
			$SelectedTool = 8
		Case $cIcon
			_DeselectControls()
			$SelectedTool = 9
		Case $cInput
			_DeselectControls()
			$SelectedTool = 10
		Case $cLabel
			_DeselectControls()
			$SelectedTool = 11
		Case $cList
			_DeselectControls()
			$SelectedTool = 12
		Case $cListView
			_DeselectControls()
			$SelectedTool = 13
		Case $cMenu
			If $SelectedControl <> 0 Then
				$hIndex = _GetIndex($SelectedControl)
				If $Types[$hIndex] = 3 Then
					$ControlNum += 1
					$hControl = GUICtrlCreateUpdown($SelectedControl)
					GUISetState()
					_ArrayAdd($Data, $Names[$hIndex])
					_ArrayAdd($Names, "Updown" & $ControlNum)
					_ArrayAdd($Controls, $hControl)
					_ArrayAdd($BkColors, "")
					_ArrayAdd($Colors, "")
					_ArrayAdd($Comments, "")
					_ArrayAdd($Images, "")
					_ArrayAdd($Resize, "")
					_ArrayAdd($Types, 14)
					_ArrayAdd($States, "$GUI_SHOW")
					_ArrayAdd($Font, $DefaultFont)
					_ArrayAdd($FontInfo, "")
					_ArrayAdd($FontSize, 8.5)
					If $SelectedTool <> 7 Then
						_ArrayAdd($Styles, "")
					Else
						_ArrayAdd($Styles, "$CBS_DROPDOWNLIST")
					EndIf
					If $NewControlLayer = "Bottom" Then
						_ArrayAdd($Layers, "0")
					ElseIf $NewControlLayer = "Top" Then
						_ArrayAdd($Layers, $LayerCount)
					EndIf
					_ArrayAdd($Cursors, "0")
					_ArrayAdd($Functions, "")
					_ArrayAdd($Attributes, "0")
					_ArrayAdd($Locked, "0")
					_ArrayAdd($Parents, $GUIHandles[_GetCurrentWin()])
					$Parents[0] += 1
					$Locked[0] += 1
					$Attributes[0] += 1
					$Data[0] += 1
					$Names[0] += 1
					$Controls[0] += 1
					$BkColors[0] += 1
					$Colors[0] += 1
					$Comments[0] += 1
					$Images[0] += 1
					$Resize[0] += 1
					$Types[0] += 1
					$States[0] += 1
					$Font[0] += 1
					$FontInfo[0] += 1
					$FontSize[0] += 1
					$Styles[0] += 1
					$Layers[0] += 1
					$Cursors[0] += 1
					$Functions[0] += 1
					$hIndex = _GetIndex($SelectedControl)

					;_AddTreeItem($Names[$ControlNum], 14)
					_GUICtrlTreeView_BeginUpdate($hTree)
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "UpDown" & $ControlNum)
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon(14))
					_GUICtrlTreeView_EndUpdate($hTree)
					_ArrayAdd($TreeItems, $hItem)
					$TreeItems[0] += 1
					_GUICtrlTreeView_Expand($hTree, $TreeItems[$hIndex], True)
					_CreateResizeTabs($Controls[$Controls[0]])
					_SetScriptData()
				EndIf
			EndIf
		Case $cPicture
			$MenuSelecting = True
			$MenuSelectGUI = GUICreate("Menu Type", 255, 103, -1, -1)
			$MenuTypeLV = GUICtrlCreateListView("", 6, 6, 243, 63, BitOR($LVS_NOCOLUMNHEADER, $LVS_SINGLESEL))
			GUICtrlSetFont($MenuTypeLV, 9, 800)
			_GUICtrlListView_AddColumn($MenuTypeLV, "", 235, 2)
			_GUICtrlListView_AddItem($MenuTypeLV, "Menu")
			_GUICtrlListView_AddItem($MenuTypeLV, "Context Menu")
			_GUICtrlListView_AddItem($MenuTypeLV, "Tray Menu")
			_GUICtrlListView_SetItemSelected($MenuTypeLV, 0, True, True)
			$MenuCreateBtn = GUICtrlCreateButton("Create", 151, 74, 100, 24)
			$MenuCancelBtn = GUICtrlCreateButton("Cancel", 47, 74, 100, 24)
			GUISetState()
			While $MenuSelecting = True
				$hMsg = GUIGetMsg()
				Switch $hMsg
					Case $GUI_EVENT_CLOSE
						GUIDelete($MenuSelectGUI)
						$MenuSelecting = False
					Case $MenuCancelBtn
						GUIDelete($MenuSelectGUI)
						$MenuSelecting = False
					Case $MenuCreateBtn
						Dim $hIndexSel
						For $i = 0 To 2 Step 1
							If _GUICtrlListView_GetItemSelected($MenuTypeLV, $i) = True Then
								$hIndexSel = $i
							EndIf
						Next
						GUIDelete($MenuSelectGUI)
						Switch $hIndexSel
							Case 0 ; Menu
								If @Compiled = 1 Then
									_MenuMode()
									$MenuSelecting = False
								Else
									MsgBox( 0, "", "Must be complied to run menu builder.")
								EndIf
							Case 1 ; Context Menu
								$MenuSelecting = False
							Case 2 ; Tray Menu
								$MenuSelecting = False
						EndSwitch
				EndSwitch
			WEnd
		Case $cProgress
			_DeselectControls()
			$SelectedTool = 16
		Case $cRadio
			_DeselectControls()
			$SelectedTool = 17
		Case $cSlider
			_DeselectControls()
			$SelectedTool = 18
		Case $cTab
			_DeselectControls()
			$SelectedTool = 19
		Case $cTreeView
			_DeselectControls()
			$SelectedTool = 20
		Case $GroupButton
			_DeselectControls()
			$SelectedTool = 21
		Case $cUpDown
			_DeselectControls()
			$SelectedTool = 22
		Case $ScrollButton
			_DeselectControls()
			$SelectedTool = 23
		Case $RichEditButton
			_DeselectControls()
			Dim $AddRich = True
			For $i = 1 to $Controls[0] Step 1
				If $Types[$i] = 24 Then
					$AddRich = False
					ExitLoop
				EndIf
			Next
			If $AddRich = True Then
				$SelectedTool = 24
			EndIf
		Case $ObjectButton
			_DeselectControls()
			$SelectedTool = 25
		Case $GDIPlusButton
			_DeselectControls()
			$SelectedTool = 26
	EndSwitch
	#EndRegion
	#Region Control Creation & Management
	If $SelectedTool <> 0 Then ; Creating Control
		If _IsPressed("01") = True Then
			Dim $hCurWindow
			$hCurWindow = _GetCurrentWin()
			$hState = WinGetState($GUIs[$hCurWindow])
			If BitAND($hState, 8) Then
				Dim $AddScroll = True
				If $SelectedTool = 23 Then
					For $i = 1 to $Controls[0] Step 1
						If $Types[$i] = 23 Then
							If $Parents[$i] = $GUIHandles[$hCurWindow] Then
								$AddScroll = False
							EndIf
						EndIf
					Next
				EndIf
				If $SelectedTool = 26 Then
					For $i = 1 to $Controls[0] Step 1
						If $Types[$i] = 26 Then
							If $Parents[$i] = $GUIHandles[$hCurWindow] Then
								$AddScroll = False
							EndIf
						EndIf
					Next
				EndIf
				If $AddScroll = True Then
					GUISwitch($GUIs[$hCurWindow])
					$hMouse = GUIGetCursorInfo($GUIs[$hCurWindow])
					$ControlNum += 1
					_ArrayAdd($Attributes, "0")
					$Attributes[0] += 1
					Dim $TabCheck = False, $TabIndex = 0
					For $i = 1 To $Controls[0] Step 1 ; Apply Tab and Group Properties
						If $Parents[$i] = $GUIHandles[$hCurWindow] Then
							If $Types[$i] = 13 Then
								$ControlData = ControlGetPos("", "", $Controls[$i])
								If $hMouse[0] > $ControlData[0] And $hMouse[0] < $ControlData[0] + $ControlData[2] And $hMouse[1] > $ControlData[1] And $hMouse[1] < $ControlData[1] + $ControlData[3] Then
									If $BoarderPresent = True Then
										GUICtrlDelete($TabTop)
										GUICtrlDelete($TabBottom)
										GUICtrlDelete($TabLeft)
										GUICtrlDelete($TabRight)
									EndIf
									$BoarderPresent = True
									$TabTop = GUICtrlCreateLabel("", $ControlData[0] - 3, $ControlData[1] - 3, $ControlData[2] + 4, 2)
									GUICtrlSetBkColor(-1, $InsertColor)
									$TabBottom = GUICtrlCreateLabel("", $ControlData[0] - 3, $ControlData[1] + $ControlData[3], $ControlData[2] + 5, 2)
									GUICtrlSetBkColor(-1, $InsertColor)
									$TabLeft = GUICtrlCreateLabel("", $ControlData[0] - 3, $ControlData[1] - 3, 2, $ControlData[3] + 4)
									GUICtrlSetBkColor(-1, $InsertColor)
									$TabRight = GUICtrlCreateLabel("", $ControlData[0] + $ControlData[2], $ControlData[1] - 3, 2, $ControlData[3] + 4)
									GUICtrlSetBkColor(-1, $InsertColor)
									GUISetState()
									$SelectedTab = _GUICtrlTab_GetCurSel($Controls[$i]) + 1
									$Attributes[$Attributes[0]] = $Names[$i] & "ø" & $SelectedTab
									_GUICtrlTab_ActivateTab($Controls[$i], $SelectedTab - 1)
									GUISwitch($GUIs[$hCurWindow], GUICtrlRead($Controls[$i], 1))
									$TabCheck = True
									$TabIndex = $SelectedTab
								EndIf
							ElseIf $Types[$i] = 21 Then
								$ControlData = ControlGetPos("", "", $Controls[$i])
								If $hMouse[0] > $ControlData[0] And $hMouse[0] < $ControlData[0] + $ControlData[2] And $hMouse[1] > $ControlData[1] And $hMouse[1] < $ControlData[1] + $ControlData[3] Then
									Dim $ShowBoarder = True
									If $TabCheck = True Then
										$AttributeSplit = StringSplit($Attributes[$i], "ø")
										If $TabIndex <> $AttributeSplit[2] Then
											$ShowBoarder = False
										EndIf
									EndIf
									If $ShowBoarder = True Then
										If $BoarderPresent = True Then
											GUICtrlDelete($TabTop)
											GUICtrlDelete($TabBottom)
											GUICtrlDelete($TabLeft)
											GUICtrlDelete($TabRight)
										EndIf
										$BoarderPresent = True
										$TabTop = GUICtrlCreateLabel("", $ControlData[0] - 3, $ControlData[1] - 3, $ControlData[2] + 4, 2)
										GUICtrlSetBkColor(-1, $InsertColor)
										$TabBottom = GUICtrlCreateLabel("", $ControlData[0] - 3, $ControlData[1] + $ControlData[3], $ControlData[2] + 5, 2)
										GUICtrlSetBkColor(-1, $InsertColor)
										$TabLeft = GUICtrlCreateLabel("", $ControlData[0] - 3, $ControlData[1] - 3, 2, $ControlData[3] + 4)
										GUICtrlSetBkColor(-1, $InsertColor)
										$TabRight = GUICtrlCreateLabel("", $ControlData[0] + $ControlData[2], $ControlData[1] - 3, 2, $ControlData[3] + 4)
										GUICtrlSetBkColor(-1, $InsertColor)
										GUISetState()
										$Attributes[$Attributes[0]] = $Names[$i] & "Ð"
									EndIf
								EndIf
							EndIf
						EndIf
					Next
					If $TabCheck = False Then
						GUICtrlCreateTabItem("")
					EndIf
					If $Snap = True Then
						$hMouse[0] = Round($hMouse[0] / $GridSpace) * $GridSpace
						$hMouse[1] = Round($hMouse[1] / $GridSpace) * $GridSpace
					ElseIf $AutoAlign = "True" Then
						$hMouse[0] = _CheckAutoAlignX($hMouse[0])
						$hMouse[1] = _CheckAutoAlignY($hMouse[1])
					EndIf
					If $SelectedTool = 1 Then
						$hControl = GUICtrlCreateLabel("Label", $hMouse[0], $hMouse[1], 5, 5)
						GUISetState()
						_ArrayAdd($Data, "Label")
						_ArrayAdd($Names, "Label" & $ControlNum)
					ElseIf $SelectedTool = 2 Then
						$hControl = GUICtrlCreateButton("Button", $hMouse[0], $hMouse[1], 5, 5)
						GUISetState()
						_ArrayAdd($Data, "Button")
						_ArrayAdd($Names, "Button" & $ControlNum)
					ElseIf $SelectedTool = 3 Then
						$hControl = GUICtrlCreateInput("Input", $hMouse[0], $hMouse[1], 5, 5, $ES_READONLY)
						GUICtrlSetBkColor(-1, 0xFFFFFF)
						GUISetState()
						_ArrayAdd($Data, "Input")
						_ArrayAdd($Names, "Input" & $ControlNum)
					ElseIf $SelectedTool = 4 Then
						$hControl = GUICtrlCreateEdit("Edit", $hMouse[0], $hMouse[1], 5, 5, $ES_READONLY)
						GUICtrlSetBkColor(-1, 0xFFFFFF)
						GUISetState()
						_ArrayAdd($Data, "Edit")
						_ArrayAdd($Names, "Edit" & $ControlNum)
					ElseIf $SelectedTool = 5 Then
						$hControl = GUICtrlCreateCheckbox("Checkbox", $hMouse[0], $hMouse[1], 5, 5)
						GUICtrlSetBkColor($hControl, $GUI_BKCOLOR_TRANSPARENT)
						GUISetState()
						_ArrayAdd($Data, "Checkbox")
						_ArrayAdd($Names, "Checkbox" & $ControlNum)
					ElseIf $SelectedTool = 6 Then
						$hControl = GUICtrlCreateRadio("Radio", $hMouse[0], $hMouse[1], 5, 5)
						GUICtrlSetBkColor($hControl, $GUI_BKCOLOR_TRANSPARENT)
						GUISetState()
						_ArrayAdd($Data, "Radio")
						_ArrayAdd($Names, "Radio" & $ControlNum)
					ElseIf $SelectedTool = 7 Then
						$hControl = GUICtrlCreateCombo("Combo", $hMouse[0], $hMouse[1], 5, 5, 0x0003)
						GUISetState()
						_ArrayAdd($Data, "Combo")
						_ArrayAdd($Names, "Combo" & $ControlNum)
					ElseIf $SelectedTool = 8 Then
						$hControl = GUICtrlCreateList("List", $hMouse[0], $hMouse[1], 5, 5)
						GUISetState()
						_ArrayAdd($Data, "List")
						_ArrayAdd($Names, "List" & $ControlNum)
					ElseIf $SelectedTool = 9 Then
						$hControl = GUICtrlCreateDate("1/1/2012", $hMouse[0], $hMouse[1], 5, 5)
						GUISetState()
						_ArrayAdd($Data, "1/1/2012")
						_ArrayAdd($Names, "Date" & $ControlNum)
					ElseIf $SelectedTool = 10 Then
						$hControl = GUICtrlCreatePic("", $hMouse[0], $hMouse[1], 5, 5)
						GUISetState()
						_ResourceSetImageToCtrl($hControl, "Grey", $RT_BITMAP)
						_ArrayAdd($Data, "")
						_ArrayAdd($Names, "Picture" & $ControlNum)
					ElseIf $SelectedTool = 11 Then
						$hControl = GUICtrlCreateIcon("Resources\Icons\NoIcon.ico", "", $hMouse[0], $hMouse[1], 5, 5)
						GUISetState()
						_ArrayAdd($Data, "Resources\NoIcon.ico")
						_ArrayAdd($Names, "Icon" & $ControlNum)
					ElseIf $SelectedTool = 12 Then
						$hControl = GUICtrlCreateProgress($hMouse[0], $hMouse[1], 5, 5)
						GUISetState()
						_ArrayAdd($Data, 0)
						_ArrayAdd($Names, "Progress" & $ControlNum)
					ElseIf $SelectedTool = 13 Then
						$hControl = GUICtrlCreateTab($hMouse[0], $hMouse[1], 5, 5)
						GUICtrlCreateTabItem("Tab")
						GUICtrlCreateTabItem("") ; GUISwitch()
						GUISetState()
						GUICtrlSetState($hControl, $GUI_ONTOP)
						_ArrayAdd($Data, "Tab")
						_ArrayAdd($Names, "Tab" & $ControlNum)
					ElseIf $SelectedTool = 16 Then
						$hControl = GUICtrlCreateTreeView($hMouse[0], $hMouse[1], 5, 5)
						GUICtrlCreateTreeViewItem("Tree", $hControl)
						GUISetState()
						_ArrayAdd($Data, "Tree")
						_ArrayAdd($Names, "TreeView" & $ControlNum)
					ElseIf $SelectedTool = 17 Then
						$hControl = GUICtrlCreateSlider($hMouse[0], $hMouse[1], 5, 5)
						GUICtrlSetState($hControl, $GUI_DISABLE)
						GUISetState()
						_ArrayAdd($Data, "0")
						_ArrayAdd($Names, "Slider" & $ControlNum)
					ElseIf $SelectedTool = 18 Then
						$hControl = GUICtrlCreateListView("", $hMouse[0], $hMouse[1], 5, 5)
						_GUICtrlListView_AddColumn($hControl, "ListView", 100)
						GUISetState()
						GUICtrlSetState($hControl, $GUI_DISABLE)
						_ArrayAdd($Data, "ListView")
						_ArrayAdd($Names, "ListView" & $ControlNum)
					ElseIf $SelectedTool = 19 Then
						$hControl = GUICtrlCreateGraphic($hMouse[0], $hMouse[1], 5, 5)
						GUICtrlSetColor(-1, 0x00)
						GUISetState()
						_ArrayAdd($Data, "")
						_ArrayAdd($Names, "Graphic" & $ControlNum)
						GUICtrlSetState($GraphicMode, $GUI_ENABLE)
					ElseIf $SelectedTool = 20 Then
						$hControl = GUICtrlCreateDummy()
						GUISetState()
						_ArrayAdd($Data, "")
						_ArrayAdd($Names, "Dummy" & $ControlNum)
					ElseIf $SelectedTool = 21 Then
						$hControl = GUICtrlCreateGroup("Group", $hMouse[0], $hMouse[1], 5, 5)
						GUISetState()
						_ArrayAdd($Data, "Group")
						_ArrayAdd($Names, "Group" & $ControlNum)
					ElseIf $SelectedTool = 22 Then
						$hControl = GUICtrlCreateMonthCal(@YEAR & "/" & @MON & "/" & @MDAY, $hMouse[0], $hMouse[1], 5, 5)
						GUISetState()
						_ArrayAdd($Data, @YEAR & "/" & @MON & "/" & @MDAY)
						_ArrayAdd($Names, "MonthCal" & $ControlNum)
					ElseIf $SelectedTool = 23 Then
						$hControl = _GUIScrollBars_Generate($GUIS[$CurrentWindow], 300, 500)
						_ArrayAdd($Data, "300|500")
						_ArrayAdd($Names, "Scrollbar"&$ControlNum)
					ElseIf $SelectedTool = 24 Then
						$hControl = GUICtrlCreateEdit("", $hMouse[0], $hMouse[1], 5, 5)
						_ArrayAdd($Data, "")
						_ArrayAdd($Names, "RichEdit"&$ControlNum)
					ElseIf $SelectedTool = 25 Then
						$hControl = GUICtrlCreateEdit("", $hMouse[0], $hMouse[1], 5, 5, $ES_READONLY)
						GUICtrlSetState($hControl, $GUI_DISABLE)
						_ArrayAdd($Data, "Shell.Explorer.2")
						_ArrayAdd($Names, "Object"&$ControlNum)
					ElseIf $SelectedTool = 26 Then
						$hControl = "GDI+"&$hCurWindow
						_ArrayAdd($Data, "")
						_ArrayAdd($Names, "GDIPlus")
					EndIf
					GUICtrlSetState($hControl, BitAND($GUI_SHOW, $GUI_ONTOP))
					GUICtrlSetResizing($hControl, 802)
					GUICtrlSetCursor($hControl, 9)
					If $SelectedTool = 23 Then
						_ArrayAdd($Controls, "Scroll"&$hCurWindow)
						_ArrayAdd($Colors, $hControl)
						$hControl = "Scroll"&$hCurWindow
					Else
						_ArrayAdd($Controls, $hControl)
						_ArrayAdd($Colors, "")
					EndIf
					_ArrayAdd($BkColors, "")
					_ArrayAdd($Comments, "")
					_ArrayAdd($Images, "")
					_ArrayAdd($Resize, "")
					_ArrayAdd($Types, $SelectedTool)
					_ArrayAdd($States, "$GUI_SHOW")
					_ArrayAdd($Font, $DefaultFont)
					_ArrayAdd($FontInfo, "")
					_ArrayAdd($FontSize, 8.5)
					If $SelectedTool <> 7 Then
						_ArrayAdd($Styles, "")
					Else
						_ArrayAdd($Styles, "$CBS_DROPDOWNLIST")
					EndIf
					If $NewControlLayer = "Bottom" Then
						_ArrayAdd($Layers, "0")
					ElseIf $NewControlLayer = "Top" Then
						_ArrayAdd($Layers, $LayerCount)
					EndIf
					_ArrayAdd($Cursors, "0")
					_ArrayAdd($Functions, "")
					_ArrayAdd($Locked, "0")
					_ArrayAdd($Parents, $GUIHandles[$hCurWindow])
					$Parents[0] += 1
					$Locked[0] += 1
					$Data[0] += 1
					$Names[0] += 1
					$Controls[0] += 1
					$BkColors[0] += 1
					$Colors[0] += 1
					$Comments[0] += 1
					$Images[0] += 1
					$Resize[0] += 1
					$Types[0] += 1
					$States[0] += 1
					$Font[0] += 1
					$FontInfo[0] += 1
					$FontSize[0] += 1
					$Styles[0] += 1
					$Layers[0] += 1
					$Cursors[0] += 1
					$Functions[0] += 1
					$SelectedControl = $hControl
					_CreateResizeTabs($hControl)
					_ShowResizeTabs($hControl)
					$ControlNum = $Controls[0]
					If $Attributes[0] >= $ControlNum Then
						If $Attributes[$ControlNum] = "0" Then ; Add Treeview control items
							$tItem = _AddTreeItem($Names[$ControlNum], $Types[$ControlNum], $Parents[$ControlNum])
							_GUICtrlTreeView_SelectItem($hTree, $tItem)
						Else
							If StringInStr($Attributes[$ControlNum], "ø") Then
								$hSplit = StringSplit($Attributes[$ControlNum], "ø")
								$hIndex = _ArraySearch($Names, $hSplit[1])
								_GUICtrlTreeView_BeginUpdate($hTree)
								$ItemHandle = _GUICtrlTreeView_FindItem($hTree, "hTabItem" & $hSplit[2], False, 0)
								If $ItemHandle = 0 Then
									$hTabItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "hTabItem" & $hSplit[2])
									_GUICtrlTreeView_SetIcon($hTree, $hTabItem, @ScriptDir & "\Resources.dll", _GetIcon(13))
									$hItem = _GUICtrlTreeView_AddChild($hTree, $hTabItem, $Names[$ControlNum])
									_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$ControlNum]))
								Else
									$hItem = _GUICtrlTreeView_AddChild($hTree, $ItemHandle, $Names[$ControlNum])
									_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$ControlNum]))
								EndIf
								_GUICtrlTreeView_EndUpdate($hTree)
								_ArrayAdd($TreeItems, $hItem)
								$TreeItems[0] += 1
								_GUICtrlTreeView_SelectItem($hTree, $hItem)
							EndIf
							If StringInStr($Attributes[$ControlNum], "Ð") Then
								$hSplit = StringTrimRight($Attributes[$ControlNum], 1)
								$hIndex = _NameToIndex($hSplit)
								_GUICtrlTreeView_BeginUpdate($hTree)
								$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], $Names[$ControlNum])
								_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$ControlNum]))
								_GUICtrlTreeView_EndUpdate($hTree)
								_GUICtrlTreeView_Expand($hTree, $TreeItems[$hIndex], True)
								_ArrayAdd($TreeItems, $hItem)
								$TreeItems[0] += 1
								_GUICtrlTreeView_SelectItem($hTree, $hItem)
							EndIf
						EndIf
						If StringInStr($Attributes[$ControlNum], "ø") = True Then
							GUICtrlCreateTabItem("")
						EndIf
						If StringInStr($Attributes[$ControlNum], "Ð") Then
							If StringInStr($Attributes[_NameToIndex(StringTrimRight($Attributes[$ControlNum], 1))], "ø") = True Then
								GUICtrlCreateTabItem("")
							EndIf
						EndIf
					EndIf
					_SetControlData($hControl)
					If $AutoAlign = "True" Then
						Dim $BlankArray[1] = [0]
						_PrepareAutoAlign($BlankArray)
					EndIf
					_DebugAdd("Control["&$ControlNum&"] Created", $NoErrorColor)
					$hCtrlPos = ControlGetPos("", "", $SelectedControl)
					If Not @Error Then
						While _IsPressed("01")
							$hPos = GUIGetCursorInfo($GUIs[$hCurWindow])
							If Not @Error Then
								If $Snap = False Then
									If $AutoAlign = "True" Then
										$hW = $hCtrlPos[2] + ($hPos[0] - $hMouse[0])
										$hH = $hCtrlPos[3] + ($hPos[1] - $hMouse[1])
										$AlignedPosW = _CheckAutoAlignX($hCtrlPos[0] + $hW)
										$AlignedPosH = _CheckAutoAlignY($hCtrlPos[1] + $hH)
										GUICtrlSetPos($SelectedControl, $hMouse[0], $hMouse[1], $AlignedPosW - $hCtrlPos[0], $AlignedPosH - $hCtrlPos[1])
										_MoveResizeTabs($SelectedControl)
										_SetPositionData($hMouse[0], $hMouse[1], $AlignedPosW - $hCtrlPos[0], $AlignedPosH - $hCtrlPos[1])
									Else
										GUICtrlSetPos($hControl, $hMouse[0], $hMouse[1], $hPos[0] - $hMouse[0], $hPos[1] - $hMouse[1])
										_MoveResizeTabs($hControl)
										_SetPositionData($hMouse[0], $hMouse[1], $hPos[0] - $hMouse[0], $hPos[1] - $hMouse[1])
									EndIf
								ElseIf $Snap = True Then
									$hW = ($hPos[0] - $hMouse[0])
									$hH = ($hPos[1] - $hMouse[1])
									$GridNumW = Round($hW / $GridSpace)
									$GridNumH = Round($hH / $GridSpace)
									GUICtrlSetPos($SelectedControl, $hMouse[0], $hMouse[1], ($GridNumW * $GridSpace), ($GridNumH * $GridSpace))
									_MoveResizeTabs($SelectedControl)
									_SetPositionData($hMouse[0], $hMouse[1], ($GridNumW * $GridSpace), ($GridNumH * $GridSpace))
								EndIf
								Sleep(20)
							EndIf
						WEnd
					EndIf
					$UndoLog &= "ß" & "C¿" & $Controls[0]
					_SetScriptData()
					_WinAPI_SetFocus($GUIS[$CurrentWindow])
					$SelectedTool = 0
				EndIf
			EndIf
		EndIf
	Else
		If _IsPressed("01") = True Then
			If $ClickTimer = False Then
				$hClickTimer = TimerInit()
				$ClickTimer = True
			Else
				$ClickDiff = TimerDiff($hClickTimer)
				If $ClickDiff < 20 Then
					$hCurWindow = _GetCurrentWin()
					$hState = WinGetState($GUIs[$hCurWindow])
					If BitAND($hState, 8) Then
						$hCtrlClicked = False
						$hMouse = GUIGetCursorInfo($GUIs[$hCurWindow])
						For $i = $Controls[0] To 1 Step -1
							$hCtrlPos = ControlGetPos("", "", $Controls[$i])
							If Not @error Then
								If $SelectedControl <> 0 Then ; Allow control resizing when 1 control is selected
									$Variance = 4
								Else
									$Variance = 0
								EndIf
								If $hMouse[0] > $hCtrlPos[0] - $Variance And $hMouse[1] > $hCtrlPos[1] - $Variance And $hMouse[0] < $hCtrlPos[0] + $hCtrlPos[2] + $Variance And $hMouse[1] < $hCtrlPos[1] + $hCtrlPos[3] + $Variance and $Parents[$i] = $GUIHandles[$hCurWindow] Then
									_HideAutoSnapLines()
									If StringInStr($Attributes[$i], "ø") Then
										$PropSplit = StringSplit($Attributes[$i], "ø")
										$hIndex = _NameToIndex($PropSplit[1])
										$hTabSelect = _GUICtrlTab_GetCurSel($Controls[$hIndex]) + 1
										If $hTabSelect = $PropSplit[2] Then
											$hCtrlClicked = True
											If _IsPressed("11") Then
												If $MultiSelect = False Then
													_ClearControlData()
												EndIf
												_MoveResizeTabs($Controls[$i])
												_ShowResizeTabs($Controls[$i])
												_DebugAdd("Control["&$i&"] Added to Control Selection", $NotifyColor)
												If $SelectedControl <> 0 Then
													_ArrayAdd($MultiControls, $SelectedControl)
													$MultiControls[0] += 1
												EndIf
												_ArrayAdd($MultiControls, $Controls[$i])
												$MultiControls[0] += 1
												$SelectedControl = 0
												$MultiSelect = True
												GUICtrlSetState($GroupControlButton, $GUI_ENABLE)
											Else
												$MultiControlClick = False
												If $MultiSelect = True Then
													For $b = 1 To $MultiControls[0] Step 1
														If $MultiControls[$b] = $Controls[$i] Then
															$MultiControlClick = True
														EndIf
													Next
												EndIf
												If $MultiControlClick = False Then
													_ClearMultiControls()
													_HideAllResizeTabs()
													_MoveResizeTabs($Controls[$i])
													_ShowResizeTabs($Controls[$i])
													_SetControlData($Controls[$i])
													$SelectedControl = $Controls[$i]
													GUICtrlSetState($GroupControlButton, $GUI_DISABLE)
													_DebugAdd("Control["&$i&"] Selected", $NotifyColor)
												EndIf
											EndIf
											ExitLoop
										EndIf
									Else
										$hCtrlClicked = True
										If _IsPressed("11") Then
											If $MultiSelect = False Then
												_ClearControlData()
											EndIf
											_MoveResizeTabs($Controls[$i])
											_ShowResizeTabs($Controls[$i])
											_DebugAdd("Control["&$i&"] Added to Control Selection", $NotifyColor)
											If $SelectedControl <> 0 Then
												_ArrayAdd($MultiControls, $SelectedControl)
												$MultiControls[0] += 1
											EndIf
											_ArrayAdd($MultiControls, $Controls[$i])
											$MultiControls[0] += 1
											$SelectedControl = 0
											$MultiSelect = True
											GUICtrlSetState($GroupControlButton, $GUI_ENABLE)
										Else
											$MultiControlClick = False
											If $MultiSelect = True Then
												For $b = 1 To $MultiControls[0] Step 1
													If $MultiControls[$b] = $Controls[$i] Then
														$MultiControlClick = True
													EndIf
												Next
											EndIf
											If $MultiControlClick = False Then
												_ClearMultiControls()
												_HideAllResizeTabs()
												_MoveResizeTabs($Controls[$i])
												_ShowResizeTabs($Controls[$i])
												_SetControlData($Controls[$i])
												$SelectedControl = $Controls[$i]
												GUICtrlSetState($GroupControlButton, $GUI_DISABLE)
												_DebugAdd("Control["&$i&"] Selected", $NotifyColor)
											EndIf
										EndIf
										ExitLoop
									EndIf
								EndIf
							Else
								_DebugAdd("Control Position Error, Control["&$i&"], ["&$Controls[0]&"], "&@Error, $ErrorColor)
							EndIf
						Next
						If $hCtrlClicked = False Then
							_ClearControlData()
							_DeselectControls()
						EndIf
					EndIf
				Else
					If $SelectedControl <> 0 Then
						$hCurWindow = _GetCurrentWin()
						$hMouse = GUIGetCursorInfo($GUIs[$hCurWindow])
						$hGroupMouse = GUIGetCursorInfo($GUIs[$hCurWindow])
						$hCtrlPos = ControlGetPos($GUIs[$hCurWindow], "", $SelectedControl)
						If Not @error Then
							$hIndex = _GetIndex($SelectedControl)
							If $Locked[$hIndex] = "0" Then
								Dim $GroupedInfo[1] = [0]
								Dim $GroupedControls = False
								If $Types[$hIndex] = 13 Then
									$hChildCount = _GUICtrlTreeView_GetChildCount($hTree, $TreeItems[$hIndex])
									For $i = 1 To $Controls[0] Step 1
										If StringInStr($Attributes[$i], $Names[$hIndex] & "ø") Then
											$hInfo = ControlGetPos("", "", $Controls[$i])
											If Not @Error Then
												_ArrayAdd($GroupedInfo, $i & "|" & $hInfo[0] & "|" & $hInfo[1])
												$GroupedInfo[0] += 1
											Else
												_DebugAdd("Control Group Error, Control["&$i&"], ["&$Controls[0]&"], "&@Error, $ErrorColor)
											EndIf
										EndIf
									Next
								ElseIf $Types[$hIndex] = 21 Then
									$hChildCount = _GUICtrlTreeView_GetChildCount($hTree, $TreeItems[$hIndex])
									For $i = 1 To $Controls[0] Step 1
										If $Attributes[$i] = $Names[$hIndex] & "Ð" Then
											$hInfo = ControlGetPos("", "", $Controls[$i])
											If Not @Error Then
												_ArrayAdd($GroupedInfo, $i & "|" & $hInfo[0] & "|" & $hInfo[1])
												$GroupedInfo[0] += 1
											Else
												_DebugAdd("Control Group Error, Control["&$i&"], ["&$Controls[0]&"], "&@Error, $ErrorColor)
											EndIf
										EndIf
									Next
								EndIf

								If IsArray($GroupedInfo) Then
									If $GroupedInfo[0] > 1 Then
										$GroupedControls = True
									EndIf
								EndIf

								If $hMouse[0] > $hCtrlPos[0] And $hMouse[1] > $hCtrlPos[1] And $hMouse[0] < $hCtrlPos[0] + $hCtrlPos[2] And $hMouse[1] < $hCtrlPos[1] + $hCtrlPos[3] Then
									$UndoLog &= "ß" & "R¿" & $hIndex & "¿" & $hCtrlPos[0] & "¿" & $hCtrlPos[1] & "¿" & $hCtrlPos[2] & "¿" & $hCtrlPos[3]
									If $AutoAlign = "True" Then
										_PrepareAutoAlign($GroupedInfo)
									EndIf
									_DebugAdd("Moving Control["&$i&"]", $NotifyColor)
									While _IsPressed("01")
										$hCurPos = GUIGetCursorInfo($GUIs[$hCurWindow])
										If $hCurPos[0] <> $CurPosX Or $hCurPos[1] <> $CurPosY Then
											$CurPosX = $hCurPos[0]
											$CurPosY = $hCurPos[1]
											If $Snap = False Then
												$LastDiff = $hCurPos[0] - $hMouse[0]
												If $AutoAlign = "True" Then
													$hXPos = $hCtrlPos[0] + $hCurPos[0] - $hMouse[0]
													$hYPos = $hCtrlPos[1] + $hCurPos[1] - $hMouse[1]
													$AlignedPos = _CheckAutoAlign($hXPos, $hYPos, $hCtrlPos)
													GUICtrlSetPos($SelectedControl, $AlignedPos[0], $AlignedPos[1], $hCtrlPos[2], $hCtrlPos[3])
													_MoveResizeTabs($SelectedControl)
													_SetPositionData($AlignedPos[0], $AlignedPos[1], $hCtrlPos[2], $hCtrlPos[3])
													If $GroupedControls = True Then
														For $i = 1 To $GroupedInfo[0] Step 1
															$gInfo = StringSplit($GroupedInfo[$i], "|")
															$gPos = ControlGetPos("", "", $Controls[$gInfo[1]])
															GUICtrlSetPos($Controls[$gInfo[1]], $gInfo[2] + $hCurPos[0] - $hMouse[0] + ($AlignedPos[0] - $hXPos), $gInfo[3] + $hCurPos[1] - $hMouse[1] + ($AlignedPos[1] - $hYPos))
														Next
													EndIf
												Else
													GUICtrlSetPos($SelectedControl, $hCtrlPos[0] + $hCurPos[0] - $hMouse[0], $hCtrlPos[1] + $hCurPos[1] - $hMouse[1], $hCtrlPos[2], $hCtrlPos[3])
													_MoveResizeTabs($SelectedControl)
													_SetPositionData($hCtrlPos[0] + $hCurPos[0] - $hMouse[0], $hCtrlPos[1] + $hCurPos[1] - $hMouse[1], $hCtrlPos[2], $hCtrlPos[3])
													If $GroupedControls = True Then
														For $i = 1 To $GroupedInfo[0] Step 1
															$gInfo = StringSplit($GroupedInfo[$i], "|")
															$gPos = ControlGetPos("", "", $Controls[$gInfo[1]])
															GUICtrlSetPos($Controls[$gInfo[1]], $gInfo[2] + $hCurPos[0] - $hMouse[0], $gInfo[3] + $hCurPos[1] - $hMouse[1])
														Next
													EndIf
												EndIf
											Else
												$XDiff = $hMouse[0] - $hCurPos[0]
												$YDiff = $hMouse[1] - $hCurPos[1]
												If Abs($XDiff) >= $GridSpace Or Abs($YDiff) >= $GridSpace Then
													$GridNumW = Round($XDiff / $GridSpace)
													$GridNumH = Round($YDiff / $GridSpace)
													GUICtrlSetPos($SelectedControl, (Round($hCtrlPos[0] / $GridSpace) * $GridSpace) - ($GridNumW * $GridSpace), (Round($hCtrlPos[1] / $GridSpace) * $GridSpace) - ($GridNumH * $GridSpace), $hCtrlPos[2], $hCtrlPos[3])
													_MoveResizeTabs($SelectedControl)
													_SetPositionData((Round($hCtrlPos[0] / $GridSpace) * $GridSpace) - ($GridNumW * $GridSpace), (Round($hCtrlPos[1] / $GridSpace) * $GridSpace) - ($GridNumH * $GridSpace), $hCtrlPos[2], $hCtrlPos[3])
													If $GroupedControls = True Then
														For $i = 1 To $GroupedInfo[0] Step 1
															$gInfo = StringSplit($GroupedInfo[$i], "|")
															$gPos = ControlGetPos("", "", $Controls[$gInfo[1]])
															GUICtrlSetPos($Controls[$gInfo[1]], (Round($gInfo[2] / $GridSpace) * $GridSpace) - ($GridNumW * $GridSpace), (Round($gInfo[3] / $GridSpace) * $GridSpace) - ($GridNumH * $GridSpace))
														Next
													EndIf
												EndIf
											EndIf
										EndIf
										Sleep(20)
									WEnd
									_SetScriptData()
									If $GroupedControls = True Then
										For $i = 1 To $GroupedInfo[0] Step 1
											$gInfo = StringSplit($GroupedInfo[$i], "|")
											_MoveResizeTabs($Controls[$gInfo[1]])
										Next
									EndIf
								EndIf
								If $hMouse[0] >= ($hCtrlPos[0] - 3) And $hMouse[0] <= ($hCtrlPos[0] + 2) And $hMouse[1] >= ($hCtrlPos[1] - 3) And $hMouse[1] <= ($hCtrlPos[1] + 2) Then ; Top Left
									$UndoLog &= "ß" & "R¿" & $hIndex & "¿" & $hCtrlPos[0] & "¿" & $hCtrlPos[1] & "¿" & $hCtrlPos[2] & "¿" & $hCtrlPos[3]
									GUISetCursor(12, 1, $GUIs[$hCurWindow])
									While _IsPressed("01")
										$hCurPos = GUIGetCursorInfo($GUIs[$hCurWindow])
										$hX = $hCtrlPos[0] + ($hCurPos[0] - $hMouse[0])
										$hY = $hCtrlPos[1] + ($hCurPos[1] - $hMouse[1])
										$hW = $hCtrlPos[2] - ($hCurPos[0] - $hMouse[0])
										$hH = $hCtrlPos[3] - ($hCurPos[1] - $hMouse[1])
										If $Snap = False Then
											If $AutoAlign = "True" Then
												$AlignedPosX = _CheckAutoAlignX($hX)
												$AlignedPosY = _CheckAutoAlignY($hY)
												GUICtrlSetPos($SelectedControl, $AlignedPosX, $AlignedPosY, $hW + ($hX - $AlignedPosX), $hH + ($hY - $AlignedPosY))
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($AlignedPosX, $AlignedPosY, $hW + ($hX - $AlignedPosX), $hH + ($hY - $AlignedPosY))
											Else
												GUICtrlSetPos($SelectedControl, $hX, $hY, $hW, $hH)
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($hX, $hY, $hW, $hH)
											EndIf
										Else
											$XDiff = $hMouse[0] - $hCurPos[0]
											$YDiff = $hMouse[1] - $hCurPos[1]
											$GridNumX = Round($hX / $GridSpace)
											$GridNumY = Round($hY / $GridSpace)
											GUICtrlSetPos($SelectedControl, ($GridNumX * $GridSpace), ($GridNumY * $GridSpace), $hCtrlPos[2] + ($hCtrlPos[0] - ($GridNumX * $GridSpace)), $hCtrlPos[3] + ($hCtrlPos[1] - ($GridNumY * $GridSpace)))
											_MoveResizeTabs($SelectedControl)
											_SetPositionData(($GridNumX * $GridSpace), ($GridNumY * $GridSpace), $hCtrlPos[2] + ($hCtrlPos[0] - ($GridNumX * $GridSpace)), $hCtrlPos[3] + ($hCtrlPos[1] - ($GridNumY * $GridSpace)))
										EndIf
										Sleep(20)
									WEnd
									_SetScriptData()
									GUISetCursor(2, 1, $GUIs[$hCurWindow])
								ElseIf $hMouse[0] >= ($hCtrlPos[0] - 3) And $hMouse[0] <= $hCtrlPos[0] And $hMouse[1] >= ($hCtrlPos[1] + $hCtrlPos[3]) And $hMouse[1] <= $hCtrlPos[1] + $hCtrlPos[3] + 3 Then ; Bottom Left
									$UndoLog &= "ß" & "R¿" & $hIndex & "¿" & $hCtrlPos[0] & "¿" & $hCtrlPos[1] & "¿" & $hCtrlPos[2] & "¿" & $hCtrlPos[3]
									GUISetCursor(10, 1, $GUIs[$hCurWindow])
									While _IsPressed("01")
										$hCurPos = GUIGetCursorInfo($GUIs[$hCurWindow])
										$hX = $hCtrlPos[0] + ($hCurPos[0] - $hMouse[0])
										$hW = $hCtrlPos[2] - ($hCurPos[0] - $hMouse[0])
										$hH = $hCtrlPos[3] + ($hCurPos[1] - $hMouse[1])
										If $Snap = False Then
											If $AutoAlign = "True" Then
												$AlignedPosX = _CheckAutoAlignX($hX)
												$AlignedPosH = _CheckAutoAlignY($hCtrlPos[1] + $hH)
												GUICtrlSetPos($SelectedControl, $AlignedPosX, $hCtrlPos[1], $hW + ($hX - $AlignedPosX), $AlignedPosH - $hCtrlPos[1])
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($AlignedPosX, $hCtrlPos[1], $hW + ($hX - $AlignedPosX), $AlignedPosH - $hCtrlPos[1])
											Else
												GUICtrlSetPos($SelectedControl, $hX, $hCtrlPos[1], $hW, $hH)
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($hX, $hCtrlPos[1], $hW, $hH)
											EndIf
										Else
											$XDiff = $hMouse[0] - $hCurPos[0]
											$YDiff = $hMouse[1] - $hCurPos[1]
											$GridNumX = Round($hX / $GridSpace)
											$GridNumH = Round($hH / $GridSpace)
											GUICtrlSetPos($SelectedControl, ($GridNumX * $GridSpace), $hCtrlPos[1], $hCtrlPos[2] + ($hCtrlPos[0] - ($GridNumX * $GridSpace)), ($GridNumH * $GridSpace))
											_MoveResizeTabs($SelectedControl)
											_SetPositionData(($GridNumX * $GridSpace), $hCtrlPos[1], $hCtrlPos[2] + ($hCtrlPos[0] - ($GridNumX * $GridSpace)), ($GridNumH * $GridSpace))
										EndIf
										Sleep(20)
									WEnd
									_SetScriptData()
									GUISetCursor(2, 1, $GUIs[$hCurWindow])
								ElseIf $hMouse[0] >= ($hCtrlPos[0] + $hCtrlPos[2]) And $hMouse[0] <= $hCtrlPos[0] + $hCtrlPos[2] + 3 And $hMouse[1] >= $hCtrlPos[1] - 3 And $hMouse[1] <= $hCtrlPos[1] Then ; Top Right
									$UndoLog &= "ß" & "R¿" & $hIndex & "¿" & $hCtrlPos[0] & "¿" & $hCtrlPos[1] & "¿" & $hCtrlPos[2] & "¿" & $hCtrlPos[3]
									GUISetCursor(10, 1, $GUIs[$hCurWindow])
									While _IsPressed("01")
										$hCurPos = GUIGetCursorInfo($GUIs[$hCurWindow])
										$hY = $hCtrlPos[1] + ($hCurPos[1] - $hMouse[1])
										$hW = $hCtrlPos[2] + ($hCurPos[0] - $hMouse[0])
										$hH = $hCtrlPos[3] - ($hCurPos[1] - $hMouse[1])
										If $Snap = False Then
											If $AutoAlign = "True" Then
												$AlignedPosW = _CheckAutoAlignX($hCtrlPos[0] + $hW)
												$AlignedPosH = _CheckAutoAlignY($hY)
												GUICtrlSetPos($SelectedControl, $hCtrlPos[0], $AlignedPosH, $AlignedPosW - $hCtrlPos[0], $hH + ($hY - $AlignedPosH))
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($hCtrlPos[0], $AlignedPosH, $AlignedPosW - $hCtrlPos[0], $hH + ($hY - $AlignedPosH))
											Else
												GUICtrlSetPos($SelectedControl, $hCtrlPos[0], $hY, $hW, $hH)
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($hCtrlPos[0], $hY, $hW, $hH)
											EndIf
										Else
											$XDiff = $hMouse[0] - $hCurPos[0]
											$YDiff = $hMouse[1] - $hCurPos[1]
											$GridNumY = Round($hY / $GridSpace)
											$GridNumW = Round($hW / $GridSpace)
											GUICtrlSetPos($SelectedControl, $hCtrlPos[0], ($GridNumY * $GridSpace), ($GridNumW * $GridSpace), $hCtrlPos[3] + ($hCtrlPos[1] - ($GridNumY * $GridSpace)))
											_MoveResizeTabs($SelectedControl)
											_SetPositionData($hCtrlPos[0], ($GridNumY * $GridSpace), ($GridNumW * $GridSpace), $hCtrlPos[3] + ($hCtrlPos[1] - ($GridNumY * $GridSpace)))
										EndIf
										Sleep(20)
									WEnd
									_SetScriptData()
									GUISetCursor(2, 1, $GUIs[$hCurWindow])
								ElseIf $hMouse[0] >= ($hCtrlPos[0] + $hCtrlPos[2]) And $hMouse[0] <= $hCtrlPos[0] + $hCtrlPos[2] + 3 And $hMouse[1] >= $hCtrlPos[1] + $hCtrlPos[3] And $hMouse[1] <= $hCtrlPos[1] + $hCtrlPos[3] + 3 Then ; Bottom Right
									$UndoLog &= "ß" & "R¿" & $hIndex & "¿" & $hCtrlPos[0] & "¿" & $hCtrlPos[1] & "¿" & $hCtrlPos[2] & "¿" & $hCtrlPos[3]
									GUISetCursor(12, 1, $GUIs[$hCurWindow])
									While _IsPressed("01")
										$hCurPos = GUIGetCursorInfo($GUIs[$hCurWindow])
										$hW = $hCtrlPos[2] + ($hCurPos[0] - $hMouse[0])
										$hH = $hCtrlPos[3] + ($hCurPos[1] - $hMouse[1])
										If $Snap = False Then
											If $AutoAlign = "True" Then
												$AlignedPosW = _CheckAutoAlignX($hCtrlPos[0] + $hW)
												$AlignedPosH = _CheckAutoAlignY($hCtrlPos[1] + $hH)
												GUICtrlSetPos($SelectedControl, $hCtrlPos[0], $hCtrlPos[1], $AlignedPosW - $hCtrlPos[0], $AlignedPosH - $hCtrlPos[1])
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($hCtrlPos[0], $hCtrlPos[1], $AlignedPosW - $hCtrlPos[0], $AlignedPosH - $hCtrlPos[1])
											Else
												GUICtrlSetPos($SelectedControl, $hCtrlPos[0], $hCtrlPos[1], $hW, $hH)
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($hCtrlPos[0], $hCtrlPos[1], $hW, $hH)
											EndIf
										Else
											$GridNumW = Round($hW / $GridSpace)
											$GridNumH = Round($hH / $GridSpace)
											GUICtrlSetPos($SelectedControl, $hCtrlPos[0], $hCtrlPos[1], ($GridNumW * $GridSpace), ($GridNumH * $GridSpace))
											_MoveResizeTabs($SelectedControl)
											_SetPositionData($hCtrlPos[0], $hCtrlPos[1], ($GridNumW * $GridSpace), ($GridNumH * $GridSpace))
										EndIf
										Sleep(20)
									WEnd
									_SetScriptData()
									GUISetCursor(2, 1, $GUIs[$hCurWindow])
								ElseIf $hMouse[0] >= ($hCtrlPos[0] + 2) And $hMouse[0] <= $hCtrlPos[0] + $hCtrlPos[2] - 3 And $hMouse[1] >= ($hCtrlPos[1] - 3) And $hMouse[1] < $hCtrlPos[1] Then ; Top
									$UndoLog &= "ß" & "R¿" & $hIndex & "¿" & $hCtrlPos[0] & "¿" & $hCtrlPos[1] & "¿" & $hCtrlPos[2] & "¿" & $hCtrlPos[3]
									GUISetCursor(11, 1, $GUIs[$hCurWindow])
									While _IsPressed("01")
										$hCurPos = GUIGetCursorInfo($GUIs[$hCurWindow])
										$hY = $hCtrlPos[1] + ($hCurPos[1] - $hMouse[1])
										$hH = $hCtrlPos[3] - ($hCurPos[1] - $hMouse[1])
										If $Snap = False Then
											If $AutoAlign = "True" Then
												$AlignedPos = _CheckAutoAlignY($hY)
												GUICtrlSetPos($SelectedControl, $hCtrlPos[0], $AlignedPos, $hCtrlPos[2], $hH + ($hY - $AlignedPos))
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($hCtrlPos[0], $AlignedPos, $hCtrlPos[2], $hH + ($hY - $AlignedPos))
											Else
												GUICtrlSetPos($SelectedControl, $hCtrlPos[0], $hY, $hCtrlPos[2], $hH)
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($hCtrlPos[0], $hY, $hCtrlPos[2], $hH)
											EndIf
										Else
											$XDiff = $hMouse[0] - $hCurPos[0]
											$YDiff = $hMouse[1] - $hCurPos[1]
											$GridNumY = Round($hY / $GridSpace)
											GUICtrlSetPos($SelectedControl, $hCtrlPos[0], ($GridNumY * $GridSpace), $hCtrlPos[2], $hCtrlPos[3] + ($hCtrlPos[1] - ($GridNumY * $GridSpace)))
											_MoveResizeTabs($SelectedControl)
											_SetPositionData($hCtrlPos[0], ($GridNumY * $GridSpace), $hCtrlPos[2], $hCtrlPos[3] + ($hCtrlPos[1] - ($GridNumY * $GridSpace)))
										EndIf
										Sleep(20)
									WEnd
									_SetScriptData()
									GUISetCursor(2, 1, $GUIs[$hCurWindow])
								ElseIf $hMouse[0] >= ($hCtrlPos[0] + 2) And $hMouse[0] <= $hCtrlPos[0] + $hCtrlPos[2] - 3 And $hMouse[1] > $hCtrlPos[1] + $hCtrlPos[3] And $hMouse[1] <= ($hCtrlPos[1] + $hCtrlPos[3] + 3) Then ; Bottom
									$UndoLog &= "ß" & "R¿" & $hIndex & "¿" & $hCtrlPos[0] & "¿" & $hCtrlPos[1] & "¿" & $hCtrlPos[2] & "¿" & $hCtrlPos[3]
									GUISetCursor(11, 1, $GUIs[$hCurWindow])
									While _IsPressed("01")
										$hCurPos = GUIGetCursorInfo($GUIs[$hCurWindow])
										$hH = $hCtrlPos[3] + ($hCurPos[1] - $hMouse[1])
										If $Snap = False Then
											If $AutoAlign = "True" Then
												$AlignedPos = _CheckAutoAlignY($hCtrlPos[1] + $hH)
												GUICtrlSetPos($SelectedControl, $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $AlignedPos - $hCtrlPos[1])
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $AlignedPos - $hCtrlPos[1])
											Else
												GUICtrlSetPos($SelectedControl, $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hH)
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hH)
											EndIf
										Else
											$XDiff = $hMouse[0] - $hCurPos[0]
											$YDiff = $hMouse[1] - $hCurPos[1]
											$GridNumH = Round($hH / $GridSpace)
											GUICtrlSetPos($SelectedControl, $hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], ($GridNumH * $GridSpace))
											_MoveResizeTabs($SelectedControl)
											_SetPositionData($hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], ($GridNumH * $GridSpace))
										EndIf
										Sleep(20)
									WEnd
									_SetScriptData()
									GUISetCursor(2, 1, $GUIs[$hCurWindow])
								ElseIf $hMouse[0] >= ($hCtrlPos[0] - 3) And $hMouse[0] < $hCtrlPos[0] And $hMouse[1] >= ($hCtrlPos[1] + 2) And $hMouse[1] <= ($hCtrlPos[1] + $hCtrlPos[3] - 2) Then ; Left
									$UndoLog &= "ß" & "R¿" & $hIndex & "¿" & $hCtrlPos[0] & "¿" & $hCtrlPos[1] & "¿" & $hCtrlPos[2] & "¿" & $hCtrlPos[3]
									GUISetCursor(13, 1, $GUIs[$hCurWindow])
									While _IsPressed("01")
										$hCurPos = GUIGetCursorInfo($GUIs[$hCurWindow])
										$hX = $hCtrlPos[0] + ($hCurPos[0] - $hMouse[0])
										$hW = $hCtrlPos[2] - ($hCurPos[0] - $hMouse[0])
										If $Snap = False Then
											If $AutoAlign = "True" Then
												$AlignedPos = _CheckAutoAlignX($hX)
												GUICtrlSetPos($SelectedControl, $AlignedPos, $hCtrlPos[1], $hW + ($hX - $AlignedPos), $hCtrlPos[3])
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($AlignedPos, $hCtrlPos[1], $hW + ($hX - $AlignedPos), $hCtrlPos[3])
											Else
												GUICtrlSetPos($SelectedControl, $hX, $hCtrlPos[1], $hW, $hCtrlPos[3])
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($hX, $hCtrlPos[1], $hW, $hCtrlPos[3])
											EndIf
										Else
											$XDiff = $hMouse[0] - $hCurPos[0]
											$YDiff = $hMouse[1] - $hCurPos[1]
											$GridNumX = Round($hX / $GridSpace)
											GUICtrlSetPos($SelectedControl, ($GridNumX * $GridSpace), $hCtrlPos[1], $hCtrlPos[2] + ($hCtrlPos[0] - ($GridNumX * $GridSpace)), $hCtrlPos[3])
											_MoveResizeTabs($SelectedControl)
											_SetPositionData(($GridNumX * $GridSpace), $hCtrlPos[1], $hCtrlPos[2] + ($hCtrlPos[0] - ($GridNumX * $GridSpace)), $hCtrlPos[3])
										EndIf
										Sleep(20)
									WEnd
									_SetScriptData()
									GUISetCursor(2, 1, $GUIs[$hCurWindow])
								ElseIf $hMouse[0] > $hCtrlPos[0] + $hCtrlPos[2] And $hMouse[0] <= ($hCtrlPos[0] + $hCtrlPos[2] + 3) And $hMouse[1] >= ($hCtrlPos[1] + 2) And $hMouse[1] <= ($hCtrlPos[1] + $hCtrlPos[3] - 2) Then ; Right
									$UndoLog &= "ß" & "R¿" & $hIndex & "¿" & $hCtrlPos[0] & "¿" & $hCtrlPos[1] & "¿" & $hCtrlPos[2] & "¿" & $hCtrlPos[3]
									GUISetCursor(13, 1, $GUIs[$hCurWindow])
									While _IsPressed("01")
										$hCurPos = GUIGetCursorInfo($GUIs[$hCurWindow])
										$hW = $hCtrlPos[2] + ($hCurPos[0] - $hMouse[0])
										If $Snap = False Then
											If $AutoAlign = "True" Then
												$AlignedPos = _CheckAutoAlignX($hCtrlPos[0] + $hW)
												GUICtrlSetPos($SelectedControl, $hCtrlPos[0], $hCtrlPos[1], $AlignedPos - $hCtrlPos[0], $hCtrlPos[3])
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($hCtrlPos[0], $hCtrlPos[1], $AlignedPos - $hCtrlPos[0], $hCtrlPos[3])
											Else
												GUICtrlSetPos($SelectedControl, $hCtrlPos[0], $hCtrlPos[1], $hW, $hCtrlPos[3])
												_MoveResizeTabs($SelectedControl)
												_SetPositionData($hCtrlPos[0], $hCtrlPos[1], $hW, $hCtrlPos[3])
											EndIf
										Else
											$XDiff = $hMouse[0] - $hCurPos[0]
											$YDiff = $hMouse[1] - $hCurPos[1]
											$GridNumW = Round($hW / $GridSpace)
											GUICtrlSetPos($SelectedControl, $hCtrlPos[0], $hCtrlPos[1], ($GridNumW * $GridSpace), $hCtrlPos[3])
											_MoveResizeTabs($SelectedControl)
											_SetPositionData($hCtrlPos[0], $hCtrlPos[1], ($GridNumW * $GridSpace), $hCtrlPos[3])
										EndIf
										Sleep(20)
									WEnd
									_SetScriptData()
									GUISetCursor(2, 1, $GUIs[$hCurWindow])
								EndIf
							EndIf
						Else
							_DebugAdd("Control Move Error, Control["&_GetIndex($SelectedControl)&"], ["&$Controls[0]&"], "&@Error, $ErrorColor)
						EndIf
					Else
						If $MultiSelect = True Then
							$InsideControl = False
							$hMouse = GUIGetCursorInfo($GUIs[$hCurWindow])
							$ClickTime = TimerInit()
							$StopTiming = False
							For $i = 1 To $MultiControls[0] Step 1
								$hCtrlPos = ControlGetPos($GUIs[$hCurWindow], "", $MultiControls[$i])
								If $hMouse[0] > $hCtrlPos[0] And $hMouse[1] > $hCtrlPos[1] And $hMouse[0] < $hCtrlPos[0] + $hCtrlPos[2] And $hMouse[1] < $hCtrlPos[1] + $hCtrlPos[3] Then
									$InsideControl = True
								EndIf
							Next
							If $InsideControl = True Then
								_HideAllResizeTabs_MultiExclude()
								Dim $StartPositionsX[1] = [0], $StartPositionsY[1] = [0]
								;   ß¿
								$UndoLog = "ßM¿"
								For $i = 1 To $MultiControls[0] Step 1
									$hCtrlPos = ControlGetPos($GUIs[$hCurWindow], "", $MultiControls[$i])
									_ArrayAdd($StartPositionsX, $hCtrlPos[0])
									_ArrayAdd($StartPositionsY, $hCtrlPos[1])
									$StartPositionsX[0] += 1
									$StartPositionsY[0] += 1
									$UndoLog &= _GetIndex($MultiControls[$i])&"Ü"&$hCtrlPos[0]&"Ü"&$hCtrlPos[1]&"¿"
								Next
								While _IsPressed("01")
									If TimerDiff($ClickTime) > 50 And $StopTiming = False Then
										_HideAllResizeTabs()
										$StopTiming = True
									EndIf
									$hCurPos = GUIGetCursorInfo($GUIs[$hCurWindow])
									If $Snap = False Then
										For $i = 1 To $MultiControls[0] Step 1
											$hCtrlPos = ControlGetPos($GUIs[$hCurWindow], "", $MultiControls[$i])
											GUICtrlSetPos($MultiControls[$i], $StartPositionsX[$i] + $hCurPos[0] - $hMouse[0], $StartPositionsY[$i] + $hCurPos[1] - $hMouse[1], $hCtrlPos[2], $hCtrlPos[3])
										Next
									Else
										$XDiff = $hMouse[0] - $hCurPos[0]
										$YDiff = $hMouse[1] - $hCurPos[1]
										If Abs($XDiff) >= $GridSpace Or Abs($YDiff) >= $GridSpace Then
											$GridNumW = Round($XDiff / $GridSpace)
											$GridNumH = Round($YDiff / $GridSpace)
											For $i = 1 To $MultiControls[0] Step 1
												$hCtrlPos = ControlGetPos($GUIs[$hCurWindow], "", $MultiControls[$i])
												GUICtrlSetPos($MultiControls[$i], Round(($StartPositionsX[$i] + $hCurPos[0] - $hMouse[0]) / $GridSpace) * $GridSpace, Round(($StartPositionsY[$i] + $hCurPos[1] - $hMouse[1]) / $GridSpace) * $GridSpace, $hCtrlPos[2], $hCtrlPos[3])
											Next
										EndIf
									EndIf
									Sleep(20)
								WEnd
								_SetScriptData()
								For $i = 1 To $MultiControls[0] Step 1
									_MoveResizeTabs($MultiControls[$i])
									_ShowResizeTabs($MultiControls[$i])
								Next
								Dim $StartPositionsX[1] = [0], $StartPositionsY[1] = [0]
							EndIf
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	If _IsPressed("01") = False Then
		$ClickTimer = False
	EndIf
	If $SelectedTool = 0 And $MultiSelect = False Then
		If _IsPressed("01") Then
			If $Dragging = True Then
				$hMouse = $StartDrag
				$mX = $hMouse[0]
				$mY = $hMouse[1]
				Dim $GDIPlusExists = False, $GDIPlusIndex = 0
				For $i = 1 to $Controls[0] Step 1
					If $Controls[$i] = "GDI+"&$CurrentWindow Then
						$GDIPlusExists = True
						$GDIPlusIndex = $i
					EndIf
				Next
				While _IsPressed("01") = True
					$hPos = GUIGetCursorInfo($GUIS[$CurrentWindow])
					If $mX <> $hPos[0] or $mY <> $hPos[1] Then
						$mX = $hPos[0]
						$mY = $hPos[1]
						If $GDIplusExists = True Then
							_GDIPlus_GraphicsClear($GUIPlus[$CurrentWindow], 0xFFF0F0F0)
							_WinAPI_RedrawWindow($GUIS[$CurrentWindow])
							_DrawGDIplusData( $GDIPlusIndex, $Data[$GDIPlusIndex], $GUIS[$CurrentWindow])
						Else
							_GDIPlus_GraphicsClear($GUIPlus[$CurrentWindow], 0xFFF0F0F0)
							_WinAPI_RedrawWindow($GUIS[$CurrentWindow])
						EndIf
						If $hPos[0] < $hMouse[0] and $hPos[1] < $hMouse[1] Then
							_GDIPlus_GraphicsFillRect($GUIPlus[$CurrentWindow], $hMouse[0]-Abs($hPos[0]-$hMouse[0])+2, $hMouse[1]-Abs($hPos[1]-$hMouse[1])+2, Abs($hPos[0]-$hMouse[0])-3, Abs($hPos[1]-$hMouse[1])-3, $hBrush)
							_GDIPlus_GraphicsDrawRect($GUIPlus[$CurrentWindow], $hMouse[0]-Abs($hPos[0]-$hMouse[0]), $hMouse[1]-Abs($hPos[1]-$hMouse[1]), Abs($hPos[0]-$hMouse[0]), Abs($hPos[1]-$hMouse[1]), $hPen)
						ElseIf $hPos[0] < $hMouse[0] and $hPos[1] > $hMouse[1] Then
							_GDIPlus_GraphicsFillRect($GUIPlus[$CurrentWindow], $hMouse[0]-Abs($hPos[0]-$hMouse[0])+2, $hMouse[1]+2, Abs($hPos[0]-$hMouse[0])-3, ($hPos[1]-$hMouse[1])-3, $hBrush)
							_GDIPlus_GraphicsDrawRect($GUIPlus[$CurrentWindow], $hMouse[0]-Abs($hPos[0]-$hMouse[0]), $hMouse[1], Abs($hPos[0]-$hMouse[0]), $hPos[1]-$hMouse[1], $hPen)
						ElseIf $hPos[0] > $hMouse[0] and $hPos[1] < $hMouse[1] Then
							_GDIPlus_GraphicsFillRect($GUIPlus[$CurrentWindow], $hMouse[0]+2, $hMouse[1]-Abs($hPos[1]-$hMouse[1])+2, ($hPos[0]-$hMouse[0])-3, Abs($hPos[1]-$hMouse[1])-3, $hBrush)
							_GDIPlus_GraphicsDrawRect($GUIPlus[$CurrentWindow], $hMouse[0], $hMouse[1]-Abs($hPos[1]-$hMouse[1]), $hPos[0]-$hMouse[0], Abs($hPos[1]-$hMouse[1]), $hPen)
						ElseIf $hPos[0] > $hMouse[0] and $hPos[1] > $hMouse[1] Then
							_GDIPlus_GraphicsFillRect($GUIPlus[$CurrentWindow], $hMouse[0]+2, $hMouse[1]+2, ($hPos[0]-$hMouse[0])-3, ($hPos[1]-$hMouse[1])-3, $hBrush)
							_GDIPlus_GraphicsDrawRect($GUIPlus[$CurrentWindow], $hMouse[0], $hMouse[1], $hPos[0]-$hMouse[0], $hPos[1]-$hMouse[1], $hPen)
						EndIf
					EndIf
					Sleep(80)
				WEnd
				If $GDIplusExists = True Then
					_GDIPlus_GraphicsClear($GUIPlus[$CurrentWindow], 0xFFF0F0F0)
					_WinAPI_RedrawWindow($GUIS[$CurrentWindow])
					_DrawGDIplusData( $GDIPlusIndex, $Data[$GDIPlusIndex], $GUIS[$CurrentWindow])
				Else
					_GDIPlus_GraphicsClear($GUIPlus[$CurrentWindow], 0xFFF0F0F0)
					_WinAPI_RedrawWindow($GUIS[$CurrentWindow])
				EndIf
			EndIf
			If $GUIs[0] >= $CurrentWindow Then
				$hState = WinGetState($GUIs[$CurrentWindow])
				If $SelectedControl = 0 And $SelectedTool = 0 And $MultiSelect = False And $Dragging = False And BitAND($hState, 8) Then
					$StartDrag = GUIGetCursorInfo($GUIs[$CurrentWindow])
					$Dragging = True
				EndIf
			EndIf
			$mPos = GUIGetCursorInfo($hGUI)
			If Not @error Then
				If $mPos[0] > 151 And $mPos[0] < $Width - 206 And $mPos[1] >= $ResizeDivider And $mPos[1] <= $ResizeDivider + 3 Then
					$CurrentDiff = 0
					GUISetCursor(11, 1, $hGUI)
					While _IsPressed("01") = True
						$cPos = GUIGetCursorInfo($hGUI)
						If $mPos[1] <> $cPos[1] + $CurrentDiff Then
							$CurrentDiff += ($cPos[1] - $mPos[1])
							$hPos = ControlGetPos("", "", $ScriptEdit)
							$tPos = ControlGetPos("", "", $GUITab)
							$lPos = ControlGetPos("", "", $BottomLine)
							$sPos = ControlGetPos("", "", $SaveScript)
							$bPos = ControlGetPos("", "", $CopyScript)
							GUICtrlSetPos($GUITab, $tPos[0], $tPos[1], $tPos[2], $tPos[3] + ($cPos[1] - $mPos[1]))
							GUICtrlSetPos($BottomLine, $lPos[0], $lPos[1] + ($cPos[1] - $mPos[1]), $lPos[2], $lPos[3])
							GUICtrlSetPos($SaveScript, $sPos[0], $sPos[1] + ($cPos[1] - $mPos[1]), $sPos[2], $sPos[3])
							GUICtrlSetPos($CopyScript, $bPos[0], $bPos[1] + ($cPos[1] - $mPos[1]), $bPos[2], $bPos[3])
							_WinAPI_SetWindowPos($ScriptEdit, 0, $hPos[0], $hPos[1] + ($cPos[1] - $mPos[1]), $hPos[2], $hPos[3] + ($mPos[1] - $cPos[1]), $SWP_NOZORDER)
							$mPos = $cPos
							$ResizeDivider = $lPos[1]
							WinMove($GUIHolder, "", $tPos[0] + 1, $tPos[1] + 21, $tPos[2] - 4, $tPos[3] + ($cPos[1] - $mPos[1]) - 23)
						EndIf
						Sleep(50)
					WEnd
					GUISetCursor(2, 1, $hGUI)
				EndIf
			Else
				_DebugAdd("Cursor Position Error, "&@Error, $ErrorColor)
			EndIf
		Else
			$hCurWin = $CurrentWindow
			$mPos = GUIGetCursorInfo($hGUI)
			If Not @error Then
				If $mPos[0] > 151 And $mPos[0] < $Width - 206 And $mPos[1] >= $ResizeDivider And $mPos[1] <= $ResizeDivider + 3 Then
					GUISetCursor(11, 1, $hGUI)
					$ShowResizeCursor = True
				Else
					If $ShowResizeCursor = True Then
						GUISetCursor(2, 1, $hGUI)
						$ShowResizeCursor = False
					EndIf
				EndIf
			EndIf
			$mPos = GUIGetCursorInfo($GUIs[$hCurWin])
			If Not @Error Then
				If $Dragging = True Then
					Dim $dX, $dY, $dW, $dH
					$mPos = GUIGetCursorInfo($GUIs[$hCurWin])
					If Not @error Then
						$dWidth = $mPos[0] - $StartDrag[0]
						$dHeight = $mPos[1] - $StartDrag[1]
						If $dWidth < 0 And $dHeight < 0 Then
							$dX = $StartDrag[0] - Abs($dWidth)
							$dY = $StartDrag[1] - Abs($dHeight)
							$dW = Abs($dWidth)
							$dH = Abs($dHeight)
						ElseIf $dHeight < 0 Then
							$dX = $StartDrag[0]
							$dY = $StartDrag[1] - Abs($dHeight)
							$dW = $dWidth
							$dH = Abs($dHeight)
						ElseIf $dWidth < 0 Then
							$dX = $StartDrag[0] - Abs($dWidth)
							$dY = $StartDrag[1]
							$dW = Abs($dWidth)
							$dH = $dHeight
						Else
							$dX = $StartDrag[0]
							$dY = $StartDrag[1]
							$dW = $dWidth
							$dH = $dHeight
						EndIf
						Dim $SelectedControl = 0
						Dim $MultiSelect = True
						Dim $MultiControls[1] = [0]
						For $i = 1 To $Controls[0] Step 1
							$ControlInfo = ControlGetPos("", "", $Controls[$i])
							If Not @error Then
								If $Parents[$i] = $GUIHandles[$hCurWin] Then
									If $ControlInfo[0] > $dX and $ControlInfo[1] > $dY and $ControlInfo[0] < $dX+$dW and $ControlInfo[1] < $dY+$dH Then ; Top Left
										_ArrayAdd($MultiControls, $Controls[$i])
										$MultiControls[0] += 1
										_ShowResizeTabs($Controls[$i])
									ElseIf $ControlInfo[0]+$ControlInfo[2] > $dX and $ControlInfo[1] > $dY and $ControlInfo[0]+$ControlInfo[2] < $dx+$dW and $ControlInfo[1] < $dY+$dH Then ; Top Right
										_ArrayAdd($MultiControls, $Controls[$i])
										$MultiControls[0] += 1
										_ShowResizeTabs($Controls[$i])
									ElseIf $ControlInfo[0] > $dX and $ControlInfo[1]+$ControlInfo[3] > $dY and $ControlInfo[0] < $dx+$dW and $ControlInfo[1]+$ControlInfo[3] < $dY+$dH Then ; Bottom Left
										_ArrayAdd($MultiControls, $Controls[$i])
										$MultiControls[0] += 1
										_ShowResizeTabs($Controls[$i])
									ElseIf $ControlInfo[0]+$ControlInfo[2] > $dX and $ControlInfo[1]+$ControlInfo[3] > $dY and $ControlInfo[0]+$ControlInfo[2] < $dx+$dW and $ControlInfo[1]+$ControlInfo[3] < $dY+$dH Then ; Bottom Right
										_ArrayAdd($MultiControls, $Controls[$i])
										$MultiControls[0] += 1
										_ShowResizeTabs($Controls[$i])
									ElseIf $ControlInfo[0] < $dX and $ControlInfo[0]+$ControlInfo[2] > $dX+$dW and $ControlInfo[1] > $dY and $ControlInfo[1]+$ControlInfo[3] < $dY+$dH Then ; Through Vertical
										_ArrayAdd($MultiControls, $Controls[$i])
										$MultiControls[0] += 1
										_ShowResizeTabs($Controls[$i])
									ElseIf $ControlInfo[0] > $dX and $ControlInfo[0]+$ControlInfo[2] < $dX+$dW and $ControlInfo[1] < $dY and $ControlInfo[1]+$ControlInfo[3] > $dY+$dH Then ; Through Horizontal
										_ArrayAdd($MultiControls, $Controls[$i])
										$MultiControls[0] += 1
										_ShowResizeTabs($Controls[$i])
									EndIf
								EndIf
							Else
								_DebugAdd("Drag Select Error, Control["&$i&"], ["&$Controls[0]&"], "&@Error, $ErrorColor)
							EndIf
						Next
						$Dragging = False
						If $MultiControls[0] = 1 Then
							$SelectedControl = $MultiControls[1]
							Dim $MultiSelect = False
							Dim $MultiControls[1] = [0]
							_SetControlData($SelectedControl)
						EndIf
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
	If $SelectedControl <> 0 And $MultiSelect = False Then
		$hCurWin = _GetCurrentWin()
		$hPos = GUIGetCursorInfo($GUIs[$hCurWin])
		$ControlPos = ControlGetPos("", "", $SelectedControl)
		If Not @error Then
			If $hPos[0] >= ($ControlPos[0] - 3) And $hPos[0] <= ($ControlPos[0] + 2) And $hPos[1] >= ($ControlPos[1] - 3) And $hPos[1] <= ($ControlPos[1] + 2) Then
				GUISetCursor(12, 1, $GUIs[$hCurWin])
				$Cursor = 12
			ElseIf $hPos[0] >= ($ControlPos[0] - 3) And $hPos[0] <= $ControlPos[0] And $hPos[1] >= ($ControlPos[1] + $ControlPos[3]) And $hPos[1] <= $ControlPos[1] + $ControlPos[3] + 3 Then
				GUISetCursor(10, 1, $GUIs[$hCurWin])
				$Cursor = 10
			ElseIf $hPos[0] >= ($ControlPos[0] + $ControlPos[2]) And $hPos[0] <= $ControlPos[0] + $ControlPos[2] + 3 And $hPos[1] >= $ControlPos[1] - 3 And $hPos[1] <= $ControlPos[1] Then
				GUISetCursor(10, 1, $GUIs[$hCurWin])
				$Cursor = 10
			ElseIf $hPos[0] >= ($ControlPos[0] + $ControlPos[2]) And $hPos[0] <= $ControlPos[0] + $ControlPos[2] + 3 And $hPos[1] >= $ControlPos[1] + $ControlPos[3] And $hPos[1] <= $ControlPos[1] + $ControlPos[3] + 3 Then
				GUISetCursor(12, 1, $GUIs[$hCurWin])
				$Cursor = 12
			ElseIf $hPos[0] >= ($ControlPos[0] + 2) And $hPos[0] <= $ControlPos[0] + $ControlPos[2] - 3 And $hPos[1] >= ($ControlPos[1] - 3) And $hPos[1] <= $ControlPos[1] Then ; Top
				GUISetCursor(11, 1, $GUIs[$hCurWin])
				$Cursor = 11
			ElseIf $hPos[0] >= ($ControlPos[0] + 2) And $hPos[0] <= $ControlPos[0] + $ControlPos[2] - 3 And $hPos[1] >= $ControlPos[1] + $ControlPos[3] And $hPos[1] <= ($ControlPos[1] + $ControlPos[3] + 3) Then ; Bottom
				GUISetCursor(11, 1, $GUIs[$hCurWin])
				$Cursor = 11
			ElseIf $hPos[0] >= ($ControlPos[0] - 3) And $hPos[0] <= $ControlPos[0] And $hPos[1] >= ($ControlPos[1] + 2) And $hPos[1] <= ($ControlPos[1] + $ControlPos[3] - 2) Then ; Left
				GUISetCursor(13, 1, $GUIs[$hCurWin])
				$Cursor = 13
			ElseIf $hPos[0] >= $ControlPos[0] + $ControlPos[2] And $hPos[0] <= ($ControlPos[0] + $ControlPos[2] + 3) And $hPos[1] >= ($ControlPos[1] + 2) And $hPos[1] <= ($ControlPos[1] + $ControlPos[3] - 2) Then ; Right
				GUISetCursor(13, 1, $GUIs[$hCurWin])
				$Cursor = 13
			ElseIf $Cursor <> 2 Then
				GUISetCursor(2, 1, $GUIs[$hCurWin])
				$Cursor = 2
			EndIf
		EndIf
	EndIf
	If StringinStr($SelectedControl, "Scroll") Then
		If _IsPressed("0D") Then ; Enter
			$RefNum = 0
			For $i = 1 to $Controls[0] Step 1
				If $Controls[$i] = "Scroll"&$CurrentWindow Then
					$RefNum = $i
				EndIf
			Next

			$Name = StringStripWS(GUICtrlRead($HandleInput), 8)
			$wPos = GUICtrlRead($WInput)
			$hPos = GUICtrlRead($HInput)
			$rData = $wPos&"|"&$hPos

			If $Name <> $Names[$RefNum] Then
				$Names[$RefNum] = $Name
				_GUICtrlTreeView_SetText($hTree, $TreeItems[$RefNum], $Name)
			EndIf
			If $rData <> $Data[$RefNum] Then ; Update Data
				If $Types[$RefNum] = 23 Then ; GUI ScrollBars
					If StringinStr($rData, "|") Then
						$Split = StringSplit($rData, "|")
						If $Split[1] <> "" and $Split[2] <> "" Then
							_GUIScrollBars_SetScrollInfoMax($GUIS[$CurrentWindow], $SB_HORZ, $Split[1])
							_GUIScrollBars_SetScrollInfoMax($GUIS[$CurrentWindow], $SB_VERT, $Split[2])
							$Data[$RefNum] = $Split[1]&"|"&$Split[2]
						Else
							_GUIScrollBars_SetScrollInfoMax($GUIS[$CurrentWindow], $SB_HORZ, 300)
							_GUIScrollBars_SetScrollInfoMax($GUIS[$CurrentWindow], $SB_VERT, 500)
							$Data[$RefNum] = "300|500"
						EndIf
					EndIf
				EndIf
			EndIf
			_SetScriptData()
		EndIf
	ElseIf StringinStr($SelectedControl, "GDI+") Then
		If _IsPressed("0D") Then ; Enter
			$RefNum = 0
			For $i = 1 to $Controls[0] Step 1
				If $Controls[$i] = "GDI+"&$CurrentWindow Then
					$RefNum = $i
				EndIf
			Next

			$Name = StringStripWS(GUICtrlRead($HandleInput), 8)

			If $Name <> $Names[$RefNum] Then
				$Names[$RefNum] = $Name
				_GUICtrlTreeView_SetText($hTree, $TreeItems[$RefNum], $Name)
				_SetScriptData()
			EndIf
		EndIf
	EndIf
	If $SelectedControl <> 0 And $MultiSelect = False Then ; Control Selected
		If _IsPressed("0D") Then ; Enter
			$XPos = GUICtrlRead($XPosInput)
			$YPos = GUICtrlRead($YPosInput)
			$wPos = GUICtrlRead($WInput)
			$hPos = GUICtrlRead($HInput)
			$Color = GUICtrlRead($ColorInput)
			$BkColor = GUICtrlRead($BkColorInput)
			$Name = StringStripWS(GUICtrlRead($HandleInput), 8)
			$Image = GUICtrlRead($ImageInput)
			$rData = GUICtrlRead($DataInput)
			$rStyle = GUICtrlRead($StyleInput)
			$RefNum = _GetIndex($SelectedControl)
			$ControlInfo = ControlGetPos("", "", $SelectedControl)
			If Not @error Then
				If $XPos <> $ControlInfo[0] Or $YPos <> $ControlInfo[1] Or $wPos <> $ControlInfo[2] Or $hPos <> $ControlInfo[3] Then
					GUICtrlSetPos($SelectedControl, $XPos, $YPos, $wPos, $hPos)
					_MoveResizeTabs($SelectedControl)
				EndIf
			EndIf
			If $Color <> $Colors[$RefNum] Then
				GUICtrlSetColor($SelectedControl, "0x" & $Color)
				$Colors[$RefNum] = $Color
			EndIf
			If $BkColor <> $BkColors[$RefNum] Then
				$BkColors[$RefNum] = $BkColor
				If $BkColor = "Trans" Then
					GUICtrlSetBkColor($SelectedControl, $GUI_BKCOLOR_TRANSPARENT)
				Else
					GUICtrlSetBkColor($SelectedControl, "0x" & $BkColor)
				EndIf
			EndIf
			If $Image <> $Images[$RefNum] Then
				If StringinStr($Image, "|") Then
					$hImageSplit = StringSplit($Image, "|")
					If $hImageSplit[0] = 3 Then
						GUICtrlSetImage($SelectedControl, $hImageSplit[1], $hImageSplit[2], $hImageSplit[3])
					EndIf
				Else
					GUICtrlSetImage($SelectedControl, $Image)
				EndIf
				$Images[$RefNum] = $Image
			EndIf
			If $Name <> $Names[$RefNum] Then
				If $Types[$RefNum] = 13 Then
					For $i = 1 To $Attributes[0] Step 1
						If StringInStr($Attributes[$i], $Names[$RefNum] & "ø") Then
							$Attributes[$i] = StringReplace($Attributes[$i], $Names[$RefNum], $Name)
						EndIf
					Next
				ElseIf $Types[$RefNum] = 21 Then
					For $i = 1 To $Attributes[0] Step 1
						If $Attributes[$i] = $Names[$RefNum] & "Ð" Then
							$Attributes[$i] = StringReplace($Attributes[$i], $Names[$RefNum], $Name)
						EndIf
					Next
				EndIf
				$Names[$RefNum] = $Name
				If $Name = "" Then
					_GUICtrlTreeView_SetText($hTree, $TreeItems[$RefNum], "[ No Handle ]")
				Else
					_GUICtrlTreeView_SetText($hTree, $TreeItems[$RefNum], $Name)
				EndIf
			EndIf
			If $rStyle <> $Styles[$RefNum] Then
				$Styles[$RefNum] = $rStyle
			EndIf
			If $rData <> $Data[$RefNum] Then ; Update Data
				$Data[$RefNum] = $rData
				If $Types[$RefNum] = 10 Then ; Pic
					GUICtrlSetImage($SelectedControl, $Data[$RefNum])
				ElseIf $Types[$RefNum] = 18 Then ; ListView
					If StringInStr($rData, "|") Then
						$Split = StringSplit($rData, "|")
						$ColumnCount = _GUICtrlListView_GetColumnCount($SelectedControl)
						If $Split[0] > $ColumnCount Then
							$ColumnData = _GUICtrlListView_GetColumn($SelectedControl, $i - 1)
							For $i = $Split[0] To $ColumnCount + 1 Step -1
								_GUICtrlListView_AddColumn($SelectedControl, $Split[$i], 70)
							Next
						EndIf
						For $i = $ColumnCount To 1 Step -1
							$ColumnData = _GUICtrlListView_GetColumn($SelectedControl, $i - 1)
							If $i < $Split[0] Then
								If $ColumnData[5] <> $Split[$i] Then
									_GUICtrlListView_SetColumn($SelectedControl, $i, $Split[$i])
								EndIf
							Else
								_GUICtrlListView_DeleteColumn($SelectedControl, $i)
							EndIf
						Next
					Else
						_GUICtrlListView_SetColumn($SelectedControl, 0, $rData)
					EndIf
				ElseIf $Types[$RefNum] = 8 Or $Types[$RefNum] = 7 Then ; List
					If StringInStr($rData, "|") Then
						$Split = StringSplit($rData, "|")
						GUICtrlSetData($SelectedControl, "|" & $rData, $Split[1])
					Else
						GUICtrlSetData($SelectedControl, "|" & $rData, $rData)
					EndIf
				ElseIf $Types[$RefNum] = 13 Then ; Tab
					If StringInStr($rData, "|") Then
						$Split = StringSplit($rData, "|")
						$ColumnCount = _GUICtrlTab_GetItemCount($SelectedControl)
						If $Split[0] > $ColumnCount Then
							For $i = $ColumnCount + 1 To $Split[0] Step 1
								_GUICtrlTab_DeselectAll($Controls[$RefNum])
								GUICtrlCreateTabItem($Split[$i])
								GUISetState()
								_GUICtrlTab_ActivateTab($SelectedControl, 0)
								_GUICtrlTab_ActivateTab($SelectedControl, $i - 1)
							Next
						EndIf
						For $i = 1 To $ColumnCount Step -1
							$ItemData = _GUICtrlTab_GetItem($SelectedControl, $i - 1)
							If $i < $Split[0] Then
								_GUICtrlTab_SetItemText($SelectedControl, $i - 1, $Split[$i])
							Else
								_GUICtrlTab_DeleteItem($SelectedControl, $i - 1)
							EndIf
						Next
					Else
						_GUICtrlTab_SetItemText($SelectedControl, 0, $rData)
					EndIf
				ElseIf $Types[$RefNum] = 16 Then ; Tree
					If StringInStr($rData, "|") Then
						$Split = StringSplit($rData, "|")
						$ItemCount = _GUICtrlTreeView_GetCount($SelectedControl)
						If $Split[0] > $ItemCount Then
							For $i = $Split[0] To $ItemCount + 1 Step -1
								_GUICtrlTreeView_Add($SelectedControl, 0, $Split[$i])
							Next
						EndIf
						For $i = 1 To $ItemCount Step -1
							If $i < $Split[0] Then
								_GUICtrlTreeView_SetText($SelectedControl, $i, $Split[$i])
							Else
								_GUICtrlTreeView_Delete($SelectedControl, $i)
							EndIf
						Next
					Else
						_GUICtrlTreeView_SetText($SelectedControl, $i, $rData)
					EndIf
				ElseIf $Types[$RefNum] = 19 Then ; Graphic
					_SetControlGraphic($SelectedControl, $rData)
				Else
					If $Types[$RefNum] <> 25 Then
						GUICtrlSetData($SelectedControl, $rData)
					EndIf
				EndIf
			EndIf
			_SetControlData($SelectedControl)
			_SetScriptData()
		EndIf
		$RefNum = _GetIndex($SelectedControl)
		If GUICtrlRead($SizeInput) <> $FontSize[$RefNum] Then
			If GUICtrlRead($SizeInput) <> "" Then
				Sleep(1000)
				$FontSize[$RefNum] = GUICtrlRead($SizeInput)
				Dim $AttributeVal = ""
				$aSplit = StringSplit($FontInfo[$RefNum], "+")
				For $i = $aSplit[0] To 1 Step -1
					If $aSplit[$i] <> "" Then
						If $i = 2 Then
							$AttributeVal &= $aSplit[$i]
						Else
							$AttributeVal &= $aSplit[$i] & "+"
						EndIf
					EndIf
				Next
				If StringInStr($FontInfo[$RefNum], "+0+") Then
					GUICtrlSetFont($SelectedControl, $FontSize[$RefNum], 800, $AttributeVal, $Font[$RefNum])
				Else
					GUICtrlSetFont($SelectedControl, $FontSize[$RefNum], 400, $AttributeVal, $Font[$RefNum])
				EndIf
				_SetScriptData()
			EndIf
		EndIf
	EndIf
	#EndRegion
	$WinPos = WinGetPos($hGUI)
	If Not @error Then
		If $Width <> $WinPos[2] Or $Height <> $WinPos[3] Then
			$Width = $WinPos[2]
			$Height = $WinPos[3]
		EndIf
	EndIf
	If $GUIs[0] >= $CurrentWindow Then
		$EditPos = WinGetPos($GUIs[$CurrentWindow])
		If Not @error Then
			If $EditWidth <> $EditPos[2] Or $EditHeight <> $EditPos[3] Then
				$EditWidth = $EditPos[2]
				$EditHeight = $EditPos[3]
				_SetScriptData()
			EndIf
		EndIf
	EndIf
	If GUICtrlRead($SpaceInput) <> $SpaceAmnt Then
		$SpaceAmnt = GUICtrlRead($SpaceInput)
	EndIf
	If GUICtrlRead($GridInput) <> $GridSpace Then
		Sleep(1500)
		If GUICtrlRead($GridInput) = "" or GUICtrlRead($GridInput) = "0" Then
			$GridSpace = "2"
		Else
			$GridSpace = GUICtrlRead($GridInput)
		EndIf
		IniWrite(@ScriptDir & "/Config.ini", "Vars", "GridSpacing", $GridSpace)
		$hGrid = _DrawGrid($GridSpace, $GridLineColor)
	EndIf
WEnd

Func _DeselectControls()
	If $SnapLinePresent = True Then
		_HideAutoSnapLines()
	EndIf
	If $BoarderPresent = True Then
		GUICtrlDelete($TabTop)
		GUICtrlDelete($TabBottom)
		GUICtrlDelete($TabLeft)
		GUICtrlDelete($TabRight)
		$BoarderPresent = False
	EndIf
	_HideAllResizeTabs()
	Dim $MultiControls[1] = [0], $SelectedTool = 0, $SelectedControl = 0, $MultiSelect = False
EndFunc   ;==>_DeselectControls
Func _ClearMultiControls()
	$MultiSelect = False
	If IsArray($MultiControls) Then
		Dim $MultiControls[1] = [0]
	EndIf
EndFunc   ;==>_ClearMultiControls
Func _CreateResizeTabs($hControl)
	Local $hRightTop, $hRightBottom, $hLeftTop, $hLeftBottom, $hTop, $hRight, $hLeft, $hBottom
	WinSetState($GUIs[$CurrentWindow], "", @SW_ENABLE)
	$ControlPos = ControlGetPos($GUIs[$CurrentWindow], "", $hControl)
	If Not @error Then
		$hRightTop = GUICtrlCreateLabel("", $ControlPos[0] - 3, $ControlPos[1] - 3, 3, 3, $GUI_ONTOP)
		GUICtrlSetBkColor(-1, $CornerColor)
		GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlSetResizing(-1, 802)
		$hRightBottom = GUICtrlCreateLabel("", $ControlPos[0] - 3, $ControlPos[1] + $ControlPos[3], 3, 3, $GUI_ONTOP)
		GUICtrlSetBkColor(-1, $CornerColor)
		GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlSetResizing(-1, 802)
		$hLeftTop = GUICtrlCreateLabel("", $ControlPos[0] + $ControlPos[2], $ControlPos[1] - 3, 3, 3, $GUI_ONTOP)
		GUICtrlSetBkColor(-1, $CornerColor)
		GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlSetResizing(-1, 802)
		$hLeftBottom = GUICtrlCreateLabel("", $ControlPos[0] + $ControlPos[2], $ControlPos[1] + $ControlPos[3], 3, 3, $GUI_ONTOP)
		GUICtrlSetBkColor(-1, $CornerColor)
		GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlSetResizing(-1, 802)
		$hTop = GUICtrlCreateLabel("", $ControlPos[0], $ControlPos[1] - 2, $ControlPos[2], 1, $GUI_ONTOP)
		GUICtrlSetBkColor(-1, $SelectColor)
		GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlSetResizing(-1, 802)
		$hRight = GUICtrlCreateLabel("", $ControlPos[0] + $ControlPos[2] + 1, $ControlPos[1], 1, $ControlPos[3], $GUI_ONTOP)
		GUICtrlSetBkColor(-1, $SelectColor)
		GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlSetResizing(-1, 802)
		$hLeft = GUICtrlCreateLabel("", $ControlPos[0] - 2, $ControlPos[1], 1, $ControlPos[3], $GUI_ONTOP)
		GUICtrlSetBkColor(-1, $SelectColor)
		GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlSetResizing(-1, 802)
		$hBottom = GUICtrlCreateLabel("", $ControlPos[0], $ControlPos[1] + $ControlPos[3] + 1, $ControlPos[2], 1, $GUI_ONTOP)
		GUICtrlSetBkColor(-1, $SelectColor)
		GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlSetResizing(-1, 802)
		GUISetState()
		_ArrayAdd($ResizeTabs, String($hControl) & "|" & String($hRightTop) & "|" & String($hRightBottom) & "|" & String($hLeftTop) & "|" & String($hLeftBottom) & "|" & String($hTop) & "|" & String($hBottom) & "|" & String($hLeft) & "|" & String($hRight))
		$ResizeTabs[0] += 1
	Else
		_DebugAdd("Resize Tab Creation Error Control["&$hControl&"]", $ErrorColor)
		_ArrayAdd($ResizeTabs, "")
		$ResizeTabs[0] += 1
	EndIf
EndFunc   ;==>_CreateResizeTabs
Func _ShowResizeTabs($hControl)
	$hIndex = _GetIndex($hControl)
	If $hIndex <= $ResizeTabs[0] Then
		$hSplit = StringSplit($ResizeTabs[$hIndex], "|")
		If $hSplit[0] = 9 Then
			GUICtrlSetState($hSplit[2], BitOR($GUI_SHOW, $GUI_ENABLE))
			GUICtrlSetState($hSplit[3], BitOR($GUI_SHOW, $GUI_ENABLE))
			GUICtrlSetState($hSplit[4], BitOR($GUI_SHOW, $GUI_ENABLE))
			GUICtrlSetState($hSplit[5], BitOR($GUI_SHOW, $GUI_ENABLE))
			GUICtrlSetState($hSplit[6], BitOR($GUI_SHOW, $GUI_ENABLE))
			GUICtrlSetState($hSplit[7], BitOR($GUI_SHOW, $GUI_ENABLE))
			GUICtrlSetState($hSplit[8], BitOR($GUI_SHOW, $GUI_ENABLE))
			GUICtrlSetState($hSplit[9], BitOR($GUI_SHOW, $GUI_ENABLE))
		EndIf
	EndIf
EndFunc   ;==>_ShowResizeTabs
Func _HideResizeTabs($hControl)
	$hIndex = _ArraySearch($ResizeTabs, $hControl)
	If Not @error And $hControl <> 0 Then
		$hSplit = StringSplit($ResizeTabs[$hIndex], "|")
		If $hSplit[0] = 9 Then
			GUICtrlSetState($hSplit[2], $GUI_HIDE)
			GUICtrlSetState($hSplit[3], $GUI_HIDE)
			GUICtrlSetState($hSplit[4], $GUI_HIDE)
			GUICtrlSetState($hSplit[5], $GUI_HIDE)
			GUICtrlSetState($hSplit[6], $GUI_HIDE)
			GUICtrlSetState($hSplit[7], $GUI_HIDE)
			GUICtrlSetState($hSplit[8], $GUI_HIDE)
			GUICtrlSetState($hSplit[9], $GUI_HIDE)
		EndIf
	EndIf
EndFunc   ;==>_HideResizeTabs
Func _HideAllResizeTabs()
	If $BoarderPresent = True Then
		GUICtrlDelete($TabTop)
		GUICtrlDelete($TabBottom)
		GUICtrlDelete($TabLeft)
		GUICtrlDelete($TabRight)
		$BoarderPresent = False
	EndIf
	For $i = 1 To $ResizeTabs[0] Step 1
		$hSplit = StringSplit($ResizeTabs[$i], "|")
		If $hSplit[0] = 9 Then
			GUICtrlSetState($hSplit[2], $GUI_HIDE)
			GUICtrlSetState($hSplit[3], $GUI_HIDE)
			GUICtrlSetState($hSplit[4], $GUI_HIDE)
			GUICtrlSetState($hSplit[5], $GUI_HIDE)
			GUICtrlSetState($hSplit[6], $GUI_HIDE)
			GUICtrlSetState($hSplit[7], $GUI_HIDE)
			GUICtrlSetState($hSplit[8], $GUI_HIDE)
			GUICtrlSetState($hSplit[9], $GUI_HIDE)
		EndIf
	Next
EndFunc   ;==>_HideAllResizeTabs
Func _HideAllResizeTabs_MultiExclude()
	For $b = 1 To $Controls[0] Step 1
		Dim $MultiUsed = False
		For $c = 1 To $MultiControls[0] Step 1
			If $Controls[$b] = $MultiControls[$c] Then
				$MultiUsed = True
			EndIf
		Next
		If $MultiUsed = False Then
			$hSplit = StringSplit($ResizeTabs[$b], "|")
			If $hSplit[0] = 9 Then
				GUICtrlSetState($hSplit[2], $GUI_HIDE)
				GUICtrlSetState($hSplit[3], $GUI_HIDE)
				GUICtrlSetState($hSplit[4], $GUI_HIDE)
				GUICtrlSetState($hSplit[5], $GUI_HIDE)
				GUICtrlSetState($hSplit[6], $GUI_HIDE)
				GUICtrlSetState($hSplit[7], $GUI_HIDE)
				GUICtrlSetState($hSplit[8], $GUI_HIDE)
				GUICtrlSetState($hSplit[9], $GUI_HIDE)
			EndIf
		EndIf
	Next
EndFunc   ;==>_HideAllResizeTabs_MultiExclude
Func _MoveResizeTabs($hControl)
	$hIndex = _ArraySearch($ResizeTabs, $hControl)
	If $hIndex <> -1 Then
		$hSplit = StringSplit($ResizeTabs[$hIndex], "|")
		$ControlPos = ControlGetPos("", "", $hControl)
		If Not @error Then
			GUICtrlSetPos($hSplit[2], $ControlPos[0] - 3, $ControlPos[1] - 3, 3, 3)
			GUICtrlSetPos($hSplit[3], $ControlPos[0] - 3, $ControlPos[1] + $ControlPos[3], 3, 3)
			GUICtrlSetPos($hSplit[4], $ControlPos[0] + $ControlPos[2], $ControlPos[1] - 3, 3, 3)
			GUICtrlSetPos($hSplit[5], $ControlPos[0] + $ControlPos[2], $ControlPos[1] + $ControlPos[3], 3, 3)
			GUICtrlSetPos($hSplit[6], $ControlPos[0], $ControlPos[1] - 2, $ControlPos[2], 1) ;top
			GUICtrlSetPos($hSplit[7], $ControlPos[0], $ControlPos[1] + $ControlPos[3] + 1, $ControlPos[2], 1) ;bottom
			GUICtrlSetPos($hSplit[8], $ControlPos[0] - 2, $ControlPos[1], 1, $ControlPos[3]) ;left
			GUICtrlSetPos($hSplit[9], $ControlPos[0] + $ControlPos[2] + 1, $ControlPos[1], 1, $ControlPos[3]) ;right
		EndIf
	EndIf
EndFunc   ;==>_MoveResizeTabs
Func _SetControlData($hControl)
	If StringinStr($hControl,"Scroll") Then
		Dim $hIndex = 0
		For $i = 1 to $Controls[0] Step 1
			If StringinStr($Controls[$i],"Scroll") Then
				If $Controls[$i] = "Scroll"&$CurrentWindow Then
					$hIndex = $i
				EndIf
			EndIf
		Next
		If BitAND(GUICtrlGetState($BkColorInput), $GUI_DISABLE) = 0 Then
			GUICtrlSetState($HandleInput, $GUI_ENABLE)
			GUICtrlSetState($XPosInput, $GUI_DISABLE)
			GUICtrlSetState($YPosInput, $GUI_DISABLE)
			GUICtrlSetState($WInput, $GUI_ENABLE)
			GUICtrlSetState($HInput, $GUI_ENABLE)
			GUICtrlSetState($FuncMode, $GUI_DISABLE)
			GUICtrlSetState($ColorInput, $GUI_DISABLE)
			GUICtrlSetState($ImageInput, $GUI_DISABLE)
			GUICtrlSetState($BkColorInput, $GUI_DISABLE)
			GUICtrlSetState($StateInput, $GUI_DISABLE)
			GUICtrlSetState($StyleInput, $GUI_DISABLE)
			GUICtrlSetState($FontInput, $GUI_DISABLE)
			GUICtrlSetState($DataInput, $GUI_DISABLE)
			GUICtrlSetState($CursorInput, $GUI_DISABLE)
			GUICtrlSetState($SizeInput, $GUI_DISABLE)
			GUICtrlSetState($BoldButton, $GUI_DISABLE)
			GUICtrlSetState($ItalicButton, $GUI_DISABLE)
			GUICtrlSetState($UnderlineButton, $GUI_DISABLE)
			GUICtrlSetState($StrikeButton, $GUI_DISABLE)
			GUICtrlSetState($FuncMode, $GUI_DISABLE)
			GUICtrlSetState($LockControlButton, $GUI_DISABLE)
		EndIf
		GUICtrlSetData($XPosInput, "")
		GUICtrlSetData($YPosInput, "")
		GUICtrlSetData($ColorInput, "")
		GUICtrlSetData($BkColorInput, "")
		GUICtrlSetData($ImageInput, "")
		GUICtrlSetData($StyleInput, "")
		GUICtrlSetData($DataInput, "")
		GUICtrlSetBkColor($ColorEx, 0xF0F0F0)
		GUICtrlSetBkColor($BkColorEx, 0xF0F0F0)
		GUICtrlSetState($StyleInput, $GUI_DISABLE)
		GUICtrlSetState($HandleInput, $GUI_ENABLE)
		GUICtrlSetState($WInput, $GUI_ENABLE)
		GUICtrlSetState($HInput, $GUI_ENABLE)
		GUICtrlSetState($DataInput, $GUI_DISABLE)
		If $hIndex <> 0 Then
			$ScrollSplit = StringSplit($Data[$hIndex], "|")
			GUICtrlSetData($HandleInput, $Names[$hIndex])
			GUICtrlSetData($WInput, $ScrollSplit[1])
			GUICtrlSetData($HInput, $ScrollSplit[2])
			GUICtrlSetData($StyleInput, $Styles[$hIndex])
		EndIf
	Else
		$hIndex = _GetIndex($hControl)
		If BitAND(GUICtrlGetState($ColorInput), $GUI_DISABLE) <> 0 Then
			GUICtrlSetState($HandleInput, $GUI_ENABLE)
			GUICtrlSetState($XPosInput, $GUI_ENABLE)
			GUICtrlSetState($YPosInput, $GUI_ENABLE)
			GUICtrlSetState($WInput, $GUI_ENABLE)
			GUICtrlSetState($HInput, $GUI_ENABLE)
			GUICtrlSetState($FuncMode, $GUI_ENABLE)
			GUICtrlSetState($ColorInput, $GUI_ENABLE)
			GUICtrlSetState($ImageInput, $GUI_ENABLE)
			GUICtrlSetState($BkColorInput, $GUI_ENABLE)
			GUICtrlSetState($StateInput, $GUI_ENABLE)
			GUICtrlSetState($StyleInput, $GUI_ENABLE)
			GUICtrlSetState($FontInput, $GUI_ENABLE)
			GUICtrlSetState($DataInput, $GUI_ENABLE)
			GUICtrlSetState($CursorInput, $GUI_ENABLE)
			GUICtrlSetState($SizeInput, $GUI_ENABLE)
			GUICtrlSetState($BoldButton, $GUI_ENABLE)
			GUICtrlSetState($ItalicButton, $GUI_ENABLE)
			GUICtrlSetState($UnderlineButton, $GUI_ENABLE)
			GUICtrlSetState($StrikeButton, $GUI_ENABLE)
			GUICtrlSetState($FuncMode, $GUI_ENABLE)
			GUICtrlSetState($LockControlButton, $GUI_ENABLE)
		EndIf
		GUICtrlSetData($HandleInput, $Names[$hIndex])
		$ControlInfo = ControlGetPos("", "", $hControl)
		If Not @error Then
			GUICtrlSetData($XPosInput, $ControlInfo[0])
			GUICtrlSetData($YPosInput, $ControlInfo[1])
			GUICtrlSetData($WInput, $ControlInfo[2])
			GUICtrlSetData($HInput, $ControlInfo[3])
		EndIf
		GUICtrlSetState($FuncMode, $GUI_ENABLE)
		GUICtrlSetData($ColorInput, $Colors[$hIndex])
		If $Colors[$hIndex] = "" Then
			GUICtrlSetBkColor($ColorEx, 0xF0F0F0)
		Else
			GUICtrlSetBkColor($ColorEx, "0x"&$Colors[$hIndex])
		EndIf
		GUICtrlSetData($ImageInput, $Images[$hIndex])
		GUICtrlSetData($BkColorInput, $BkColors[$hIndex])
		If $BkColors[$hIndex] = "" Then
			GUICtrlSetBkColor($BkColorEx, 0xF0F0F0)
		Else
			GUICtrlSetBkColor($BkColorEx, "0x"&$BkColors[$hIndex])
		EndIf
		GUICtrlSetData($StateInput, $States[$hIndex])
		GUICtrlSetData($StyleInput, $Styles[$hIndex])
		GUICtrlSetData($FontInput, $Font[$hIndex])
		GUICtrlSetData($DataInput, $Data[$hIndex])
		GUICtrlSetData($SizeInput, $FontSize[$hIndex])
		_ResourceSetImageToCtrl($ResizeAuto, "Resize_Auto", $RT_BITMAP)
		_ResourceSetImageToCtrl($ResizeBottom, "Resize_Bottom", $RT_BITMAP)
		_ResourceSetImageToCtrl($ResizeTop, "Resize_Top", $RT_BITMAP)
		_ResourceSetImageToCtrl($ResizeLeft, "Resize_Left", $RT_BITMAP)
		_ResourceSetImageToCtrl($ResizeRight, "Resize_Right", $RT_BITMAP)
		_ResourceSetImageToCtrl($ResizeVC, "Resize_VCenter", $RT_BITMAP)
		_ResourceSetImageToCtrl($ResizeHC, "Resize_HCenter", $RT_BITMAP)
		_ResourceSetImageToCtrl($ResizeW, "Resize_LockWidth", $RT_BITMAP)
		_ResourceSetImageToCtrl($ResizeH, "Resize_LockHeight", $RT_BITMAP)
		_GUICtrlListView_SetItemSelected($LayerList, $LayerCount - $Layers[$hIndex], True)
		_GUICtrlComboBox_SetCurSel($CursorInput, $Cursors[$hIndex])
		If StringInStr($FontInfo[$hIndex], "+0+") Then
			GUICtrlSetBkColor($BoldButton, $ActiveColor)
		Else
			GUICtrlSetBkColor($BoldButton, $InactiveColor)
		EndIf
		If StringInStr($FontInfo[$hIndex], "+2+") Then
			GUICtrlSetBkColor($ItalicButton, $ActiveColor)
		Else
			GUICtrlSetBkColor($ItalicButton, $InactiveColor)
		EndIf
		If StringInStr($FontInfo[$hIndex], "+4+") Then
			GUICtrlSetBkColor($UnderlineButton, $ActiveColor)
		Else
			GUICtrlSetBkColor($UnderlineButton, $InactiveColor)
		EndIf
		If StringInStr($FontInfo[$hIndex], "+8+") Then
			GUICtrlSetBkColor($StrikeButton, $ActiveColor)
		Else
			GUICtrlSetBkColor($StrikeButton, $InactiveColor)
		EndIf
		If StringInStr($Resize[$hIndex], "+2+") Then
			_ResourceSetImageToCtrl($ResizeLeft, "Resize_Left_Selected", $RT_BITMAP)
		EndIf
		If StringInStr($Resize[$hIndex], "+4+") Then
			_ResourceSetImageToCtrl($ResizeRight, "Resize_Right_Selected", $RT_BITMAP)
		EndIf
		If StringInStr($Resize[$hIndex], "+8+") Then
			_ResourceSetImageToCtrl($ResizeHC, "Resize_HCenter_Selected", $RT_BITMAP)
		EndIf
		If StringInStr($Resize[$hIndex], "+32+") Then
			_ResourceSetImageToCtrl($ResizeTop, "Resize_Top_Selected", $RT_BITMAP)
		EndIf
		If StringInStr($Resize[$hIndex], "+64+") Then
			_ResourceSetImageToCtrl($ResizeBottom, "Resize_Bottom_Selected", $RT_BITMAP)
		EndIf
		If StringInStr($Resize[$hIndex], "+128+") Then
			_ResourceSetImageToCtrl($ResizeVC, "Resize_VCenter_Selected", $RT_BITMAP)
		EndIf
		If StringInStr($Resize[$hIndex], "+256+") Then
			_ResourceSetImageToCtrl($ResizeW, "Resize_LockWidth_Selected", $RT_BITMAP)
		EndIf
		If StringInStr($Resize[$hIndex], "+512+") Then
			_ResourceSetImageToCtrl($ResizeH, "Resize_LockHeight_Selected", $RT_BITMAP)
		EndIf
		If $Types[$hIndex] = 19 Then
			GUICtrlSetState($GraphicMode, $GUI_ENABLE)
		Else
			GUICtrlSetState($GraphicMode, $GUI_DISABLE)
		EndIf
	EndIf
	_GUICtrlTreeView_SelectItem($hTree, $TreeItems[$hIndex])
EndFunc   ;==>_SetControlData
Func _ClearControlData()
	GUICtrlSetState($GroupControlButton, $GUI_DISABLE)
	GUICtrlSetState($UnGroupControlButton, $GUI_DISABLE)
	GUICtrlSetState($LockControlButton, $GUI_DISABLE)
	GUICtrlSetState($HandleInput, $GUI_DISABLE)
	GUICtrlSetState($XPosInput, $GUI_DISABLE)
	GUICtrlSetState($YPosInput, $GUI_DISABLE)
	GUICtrlSetState($WInput, $GUI_DISABLE)
	GUICtrlSetState($HInput, $GUI_DISABLE)
	GUICtrlSetState($FuncMode, $GUI_DISABLE)
	GUICtrlSetState($ColorInput, $GUI_DISABLE)
	GUICtrlSetState($ImageInput, $GUI_DISABLE)
	GUICtrlSetState($BkColorInput, $GUI_DISABLE)
	GUICtrlSetState($StateInput, $GUI_DISABLE)
	GUICtrlSetState($StyleInput, $GUI_DISABLE)
	GUICtrlSetState($FontInput, $GUI_DISABLE)
	GUICtrlSetState($DataInput, $GUI_DISABLE)
	GUICtrlSetState($CursorInput, $GUI_DISABLE)
	GUICtrlSetState($SizeInput, $GUI_DISABLE)
	GUICtrlSetState($BoldButton, $GUI_DISABLE)
	GUICtrlSetState($ItalicButton, $GUI_DISABLE)
	GUICtrlSetState($UnderlineButton, $GUI_DISABLE)
	GUICtrlSetState($StrikeButton, $GUI_DISABLE)
	GUICtrlSetState($GraphicMode, $GUI_DISABLE)
	GUICtrlSetState($FuncMode, $GUI_DISABLE)
	GUICtrlSetState($UnGroupControlButton, $GUI_DISABLE)
	GUICtrlSetState($GroupControlButton, $GUI_DISABLE)
	GUICtrlSetState($LockControlButton, $GUI_DISABLE)
	GUICtrlSetData($HandleInput, "")
	GUICtrlSetData($XPosInput, "")
	GUICtrlSetData($YPosInput, "")
	GUICtrlSetData($WInput, "")
	GUICtrlSetData($HInput, "")
	GUICtrlSetData($ColorInput, "")
	GUICtrlSetBkColor($ColorEx, 0xF0F0F0)
	GUICtrlSetBkColor($BkColorEx, 0xF0F0F0)
	GUICtrlSetData($BkColorInput, "")
	GUICtrlSetData($ImageInput, "")
	GUICtrlSetData($StateInput, "$GUI_SHOW")
	GUICtrlSetData($StyleInput, "")
	GUICtrlSetData($FontInput, $DefaultFont)
	GUICtrlSetData($DataInput, "")
	GUICtrlSetData($SizeInput, "")
	GUICtrlSetData($CursorInput, "DEFAULT")
	GUICtrlSetBkColor($BoldButton, $InactiveColor)
	GUICtrlSetBkColor($ItalicButton, $InactiveColor)
	GUICtrlSetBkColor($UnderlineButton, $InactiveColor)
	GUICtrlSetBkColor($StrikeButton, $InactiveColor)
	_ResourceSetImageToCtrl($ResizeAuto, "Resize_Auto_Disable", $RT_BITMAP)
	_ResourceSetImageToCtrl($ResizeBottom, "Resize_Bottom_Disable", $RT_BITMAP)
	_ResourceSetImageToCtrl($ResizeTop, "Resize_Top_Disable", $RT_BITMAP)
	_ResourceSetImageToCtrl($ResizeLeft, "Resize_Left_Disable", $RT_BITMAP)
	_ResourceSetImageToCtrl($ResizeRight, "Resize_Right_Disable", $RT_BITMAP)
	_ResourceSetImageToCtrl($ResizeVC, "Resize_VCenter_Disable", $RT_BITMAP)
	_ResourceSetImageToCtrl($ResizeHC, "Resize_HCenter_Disable", $RT_BITMAP)
	_ResourceSetImageToCtrl($ResizeW, "Resize_LockWidth_Disable", $RT_BITMAP)
	_ResourceSetImageToCtrl($ResizeH, "Resize_LockHeight_Disable", $RT_BITMAP)
	For $i = 0 To $LayerCount Step 1
		_GUICtrlListView_SetItemSelected($LayerList, $i, False)
	Next
	_GUICtrlTreeView_SelectItem($hTree, 0)
EndFunc   ;==>_ClearControlData
Func _GetIndex($hControl)
	For $i = 1 To $Controls[0] Step 1
		If $Controls[$i] = $hControl Then
			Return $i
		EndIf
	Next
	Return 0
EndFunc   ;==>_GetIndex
Func _NameToIndex($hControlName)
	For $i = 1 To $Names[0] Step 1
		If $Names[$i] = $hControlName Then
			Return $i
		EndIf
	Next
	Return 0
EndFunc   ;==>_NameToIndex
Func _SetPositionData($aX, $aY, $aW, $aH)
	GUICtrlSetData($XPosInput, $aX)
	GUICtrlSetData($YPosInput, $aY)
	GUICtrlSetData($WInput, $aW)
	GUICtrlSetData($HInput, $aH)
EndFunc   ;==>_SetPositionData
Func _CtrlGetFont($hWnd)
	;Author G.Sandler a.k.a MrCreatoR
	Local $Ret, $hDC, $hFont, $tFont
	Local $aFont[1] = [0]
	If IsHWnd($hWnd) = 0 Then $hWnd = GUICtrlGetHandle($hWnd)
	$hDC = _WinAPI_GetDC($hWnd)
	$hFont = _SendMessage($hWnd, $WM_GETFONT)
	$tFont = DllStructCreate($tagLOGFONT)
	$Ret = DllCall('gdi32.dll', 'int', 'GetObjectW', 'ptr', $hFont, 'int', DllStructGetSize($tFont), 'ptr', DllStructGetPtr($tFont))
	If (Not @error) And ($Ret[0]) Then
		Dim $aFont[6] = [5]
		$aFont[1] = -Round(DllStructGetData($tFont, 'Height') / _WinAPI_GetDeviceCaps($hDC, $LOGPIXELSY) * 72, 1)
		$aFont[2] = DllStructGetData($tFont, 'Weight')
		$aFont[3] = BitOR(2 * (DllStructGetData($tFont, 'Italic') <> 0), 4 * (DllStructGetData($tFont, 'Underline') <> 0), 8 * (DllStructGetData($tFont, 'Strikeout') <> 0))
		$aFont[4] = DllStructGetData($tFont, 'FaceName')
		$aFont[5] = DllStructGetData($tFont, 'Quality')
	EndIf
	_WinAPI_ReleaseDC($hWnd, $hDC)
	Return $aFont
EndFunc   ;==>_CtrlGetFont
Func _GenerateCode()
	Dim $ControlIndexes[1] = [0]
	Dim $AllNames[1] = [0]
	Dim $CurerntTab = 0
	Dim $TabCount = 0
	Local $Code = ""
	Dim $Used = $Controls
	For $i = 1 To $Controls[0] Step 1
		$Used[$i] = False
	Next
	$Code &= _GetExtraIncludes()
	$Code &= '#include <GUIConstantsEx.au3>' & @CRLF
	$Code &= '#include <WindowsConstants.au3>' & @CRLF
	$Code &= '#include <Constants.au3>' & @CRLF
	If _UsedType(7) = True Then
		$Code &= '#include <GuiComboBox.au3>' & @CRLF
	EndIf
	$hCodeSplit = StringSplit($Code, @CRLF, 1)
	$IncludeRange = $hCodeSplit[0]-1
	If $ExtraIncludeData <> "" Then
		$Code &= $ExtraIncludeData & @CRLF
	Else
		$Code &= @CRLF
	EndIf
	Dim $GUIDiff = 0
	Dim $NoFunc = True
	For $i = 1 To $Names[0] Step 1
		If StringInStr($Functions[$i], "Þ") Then
			$Code &= 'Dim $' & $Names[$i] & 'Data = "' & $Data[$i] & '"' & @CRLF
			$GUIDIff += 1
		EndIf
	Next

	Dim $hChildWins[1] = [0]
	For $i = 1 To $GUIs[0] Step 1
		If BitAND(WinGetState($GUIs[$i]), 2) Then
			_ArrayAdd($hChildWins, $i)
			$hChildWins[0] += 1
		EndIf
	Next

	For $i = 1 To $hChildWins[0] Step 1
		If $GUIParent[$hChildWins[$i]] <> "0" Then
			$Code &= '$dll = DllOpen("user32.dll")'&@CRLF
			$GUIDIff += 1
			ExitLoop
		EndIf
	Next

	For $i = 1 to $Controls[0] Step 1
		If $Types[$i] = 26 Then
			$Code &= '_GDIPlus_Startup()'&@CRLF
			$GUIDIff += 1
			ExitLoop
		EndIf
	Next
	Dim $GDIExist = False
	Dim $VarsUsed = False
	Dim $GUIRangeUsed = False
	If $ScriptOutputMode = "GUIMsg" Then
		For $i = 1 To $hChildWins[0] Step 1
			Dim $WinCode = ""
			$hSize = WinGetClientSize($GUIs[$hChildWins[$i]])
			Dim $Scrollbars = False
			For $c = 1 to $Controls[0] Step 1
				If $Types[$c] = 23 Then
					If $Parents[$c] = $GUIHandles[$hChildWins[$i]] Then
						$Scrollbars = True
					EndIf
				EndIf
			Next
			For $c = 1 to $Types[0] Step 1
				If $Types[$c] = 25 Then
					$WinCode &= '$'&$Names[$c]&' = ObjCreate("'&$Data[$c]&'")'&@CRLF
					$GUIDIff += 1
				EndIf
			Next
			If $GUIMenus[$hChildWins[$i]] <> "" Then
				If $Scrollbars = False Then
					$WinCode &= '$' & $GUIHandles[$hChildWins[$i]] & ' = GUICreate( "' & $WinTitles[$hChildWins[$i]] & '", ' & $hSize[0] & ', ' & $hSize[1] + 19 & ', ' & $GUIX[$hChildWins[$i]] & ', ' & $GUIY[$hChildWins[$i]] & ')' & $GUIComment[$hChildWins[$i]] & @CRLF
				Else
					$WinCode &= '$' & $GUIHandles[$hChildWins[$i]] & ' = GUICreate( "' & $WinTitles[$hChildWins[$i]] & '", ' & $hSize[0]+11 & ', ' & $hSize[1] + 19-11 & ', ' & $GUIX[$hChildWins[$i]] & ', ' & $GUIY[$hChildWins[$i]] & ')' & $GUIComment[$hChildWins[$i]] & @CRLF
				EndIf
				$hCodeSplit = StringSplit($Code&$WinCode, @CRLF, 1)
				If $GUIRangeUsed = False Then
					$GUIRange = $hCodeSplit[0]-1-$GUIDiff
					$GUIRangeUsed = True
				EndIf
			Else
				If $Scrollbars = False Then
					$WinCode &= '$' & $GUIHandles[$hChildWins[$i]] & ' = GUICreate( "' & $WinTitles[$hChildWins[$i]] & '", ' & $hSize[0] & ', ' & $hSize[1] & ', ' & $GUIX[$hChildWins[$i]] & ', ' & $GUIY[$hChildWins[$i]] & ')' & $GUIComment[$hChildWins[$i]] & @CRLF
				Else
					$WinCode &= '$' & $GUIHandles[$hChildWins[$i]] & ' = GUICreate( "' & $WinTitles[$hChildWins[$i]] & '", ' & $hSize[0]+11 & ', ' & $hSize[1]-11 & ', ' & $GUIX[$hChildWins[$i]] & ', ' & $GUIY[$hChildWins[$i]] & ')' & $GUIComment[$hChildWins[$i]] & @CRLF
				EndIf
				$hCodeSplit = StringSplit($Code&$WinCode, @CRLF, 1)
				If $GUIRangeUsed = False Then
					$GUIRange = $hCodeSplit[0]-1-$GUIDiff
					$GUIRangeUsed = True
				EndIf
			EndIf
			If $GUIStyle[$hChildWins[$i]] <> "" Then
				If StringInStr($GUIStyle[$hChildWins[$i]], "WS_EX_") Then
					$hSplit = StringSplit($GUIStyle[$hChildWins[$i]], "|")
					Dim $StyleTemp = ""
					Dim $ExStyleTemp = ""
					For $b = 1 To $hSplit[0] Step 1
						If StringInStr($hSplit[$b], "WS_EX_") Then
							If $ExStyleTemp <> "" Then
								$ExStyleTemp &= "|" & $hSplit[$b]
							Else
								$ExStyleTemp &= $hSplit[$b]
							EndIf
						Else
							If $StyleTemp <> "" Then
								$StyleTemp &= "|" & $hSplit[$b]
							Else
								$StyleTemp &= $hSplit[$b]
							EndIf
						EndIf
					Next
					If $StyleTemp = "" Then
						$StyleTemp = "0"
					EndIf
					If StringInStr($StyleTemp, "|") And StringInStr($ExStyleTemp, "|") Then
						$WinCode &= 'GUISetStyle( BitOr( ' & StringReplace($StyleTemp, "|", ", ") & '), BitOr( ' & StringReplace($ExStyleTemp, "|", ", ") & '), $' & $GUIHandles[$hChildWins[$i]] & ')' & @CRLF
					ElseIf StringInStr($StyleTemp, "|") And StringInStr($ExStyleTemp, "|") = False Then
						$WinCode &= 'GUISetStyle( BitOr( ' & StringReplace($StyleTemp, "|", ", ") & '), ' & $ExStyleTemp & ', $' & $GUIHandles[$hChildWins[$i]] & ')' & @CRLF
					ElseIf StringInStr($StyleTemp, "|") = False And StringInStr($ExStyleTemp, "|") Then
						$WinCode &= 'GUISetStyle( ' & $StyleTemp & ', BitOr( ' & StringReplace($ExStyleTemp, "|", ", ") & '), $' & $GUIHandles[$hChildWins[$i]] & ')' & @CRLF
					ElseIf StringInStr($StyleTemp, "|") = False And StringInStr($ExStyleTemp, "|") = False Then
						$WinCode &= 'GUISetStyle( ' & $StyleTemp & ', ' & $ExStyleTemp & ', $' & $GUIHandles[$hChildWins[$i]] & ')' & @CRLF
					EndIf
				Else
					If StringInStr($GUIStyle[$hChildWins[$i]], "|") Then
						$WinCode &= 'GUISetStyle( BitOr( ' & StringReplace($GUIStyle[$hChildWins[$i]], "|", ", ") & '), -1, $' & $GUIHandles[$hChildWins[$i]] & ')' & @CRLF
					Else
						$WinCode &= 'GUISetStyle( ' & $GUIStyle[$hChildWins[$i]] & ', -1, $' & $GUIHandles[$hChildWins[$i]] & ')' & @CRLF
					EndIf
				EndIf
			EndIf
			If $GUIColors[$hChildWins[$i]] <> "" Then
				$WinCode &= "GUISetBkColor( 0x" & $GUIColors[$hChildWins[$i]] & ", $" & $GUIHandles[$hChildWins[$i]] & ")" & @CRLF
			EndIf
			If $GUIMenus[$hChildWins[$i]] <> "" Then
				$hMenuCode = _GetMenuCode($GUIMenus[$hChildWins[$i]])
				$WinCode &= $hMenuCode & @CRLF
			EndIf
			For $e = 0 To $LayerCount Step 1
				For $c = 1 To $Controls[0] Step 1
					If $e = $Layers[$c] And $Used[$c] = False Then
						If $Parents[$c] = $GUIHandles[$hChildWins[$i]] Then
							$WinCode &= _GetControlCode($Controls[$c], $c, $GUIs[$hChildWins[$i]])
							$Used[$c] = True
							$hCodeSplit = StringSplit($Code&$WinCode, @CRLF, 1)
							_ArrayAdd($ControlIndexes, $c&"|"&$hCodeSplit[0]-1)
							$ControlIndexes[0] += 1
						EndIf
					EndIf
				Next
			Next
			If $WritingControl = True Then
				$WinCode &= $WritingCtrlData&@CRLF
			EndIf
			$WinCode &= 'GUISetState(' & $GUISetStateData[$hChildWins[$i]] & ')' & @CRLF
			$Code &= $WinCode
			$hCodeSplit = StringSplit($Code, @CRLF, 1)
			$StateRange = $hCodeSplit[0]-1
		Next
		For $i = 1 to $hChildWins[0] Step 1
			If $GUIParent[$hChildWins[$i]] <> "0" Then
				$Code &= 'DllCall($dll, "int", "SetParent", "hwnd", WinGetHandle($'&$GUIHandles[$hChildWins[$i]]&'), "hwnd", WinGetHandle($'&$GUIParent[$hChildWins[$i]]&'))'&@CRLF
				$Code &= 'GUISetState(@SW_SHOW)'&@CRLF
				$StateRange += 1
			EndIf
		Next
		For $c = 1 to $Types[0] Step 1
			If $Types[$c] = 26 Then
				$hGDICode = _GetGDIPlusCode($c)
				$Code &= $hGDICode
				$hCodeSplit = StringSplit($hGDICode, @CRLF, 1)
				$StateRange += $hCodeSplit[0]
			EndIf
		Next
		If $AfterGUIData <> "" Then
			$Code &= $AfterGUIData&@CRLF
		Else
			$Code &= @CRLF
		EndIf
		$Code &= 'While ' & $WhileData & $WhileComment & @CRLF
		$hCodeSplit = StringSplit($Code, @CRLF, 1)
		$WhileRange = $hCodeSplit[0]-1
		$Code &= '	$hMsg = GUIGetMsg()' & @CRLF
		$Code &= '	Switch $hMsg' & @CRLF
		$Code &= '		Case $GUI_EVENT_CLOSE' & @CRLF
		For $i = 1 to $hChildWins[0] Step 1
			If $GUIParent[$hChildWins[$i]] <> "0" Then
				$Code &= '			DllClose($dll)' & @CRLF
				ExitLoop
			EndIf
		Next
		$GDIExist = False
		For $i = 1 to $Types[0] Step 1
			If $Types[$i] = 24 Then
				$Code &= '			_GUICtrlRichEdit_Destroy($'&$Names[$i]&')'&@CRLF
				ExitLoop
			ElseIf $Types[$i] = 26 Then
				$GDIExist = True
				If StringinStr($Code, "$hPen = ") Then
					$Code &= '			_GDIPlus_PenDispose($hPen)'&@CRLF
					$Code &= '			_GDIPlus_BrushDispose($hBrush)'&@CRLF
				EndIf
				$Code &= '			_GDIPlus_GraphicsDispose($'&$Names[$i]&')'&@CRLF
			EndIf
		Next
		If $GdIExist = True Then
			$Code &= '			_GDIPlus_Shutdown()'&@CRLF
		EndIf
		$Code &= '			Exit' & @CRLF
		For $i = 1 To $Names[0] Step 1
			If $Functions[$i] <> "" And StringInStr($Functions[$i], "à") Then
				$Code &= '		Case $' & $Names[$i] & @CRLF
				$Code &= '			' & StringReplace(StringTrimLeft($Functions[$i], 1), @CRLF, @CRLF & '			') & @CRLF
				$hCodeSplit = StringSplit($Functions[$i], @CRLF, 1)
			EndIf
		Next
		$Code &= '	EndSwitch' & @CRLF
		$hCodeSplit = StringSplit($Code, @CRLF, 1)
		$EndSwitchRange = $hCodeSplit[0]-1
		For $i = 1 To $Names[0] Step 1
			If $Functions[$i] <> "" And StringInStr($Functions[$i], "Þ") Then
				$Code &= '	If GUICtrlRead($' & $Names[$i] & ') <> $' & $Names[$i] & 'Data Then' & @CRLF
				$Code &= '		$' & $Names[$i] & 'Data = GUICtrlRead($' & $Names[$i] & ')' & @CRLF
				$Code &= '		' & StringReplace(StringTrimLeft($Functions[$i], 1), @CRLF, @CRLF & '		') & @CRLF
				$Code &= '	EndIf' & @CRLF
			EndIf
		Next
		If $ExtraWhileData <> "" Then
			$Code &= $ExtraWhileData
		Else
			$Code &= @TAB&@CRLF
		EndIf
		$Code &= 'WEnd' & @CRLF
		$hCodeSplit = StringSplit($Code, @CRLF, 1)
		$WEndRange = $hCodeSplit[0]-1
	ElseIf $ScriptOutputMode = "GUIOnEvent" Then
		$Code &= 'Opt("GUIOnEventMode", 1)' & @CRLF & @CRLF
		For $i = 1 To $hChildWins[0] Step 1
			Dim $WinCode = ""
			$hSize = WinGetClientSize($GUIs[$hChildWins[$i]])
			If $GUIVars[$hChildWins[$i]] <> "" Then
				$WinCode &= $GUIVars[$hChildWins[$i]] & @CRLF & @CRLF
			EndIf
			If $GUIMenus[$hChildWins[$i]] <> "" Then
				$WinCode &= '$' & $GUIHandles[$hChildWins[$i]] & ' = GUICreate( "' & $WinTitles[$hChildWins[$i]] & '", ' & $hSize[0] & ', ' & $hSize[1] + 19 & ', ' & $GUIX[$hChildWins[$i]] & ', ' & $GUIY[$hChildWins[$i]] & ')' & $GUIComment[$hChildWins[$i]] & @CRLF
			Else
				$WinCode &= '$' & $GUIHandles[$hChildWins[$i]] & ' = GUICreate( "' & $WinTitles[$hChildWins[$i]] & '", ' & $hSize[0] & ', ' & $hSize[1] & ', ' & $GUIX[$hChildWins[$i]] & ', ' & $GUIY[$hChildWins[$i]] & ')' & $GUIComment[$hChildWins[$i]] & @CRLF
			EndIf
			If $GUIStyle[$hChildWins[$i]] <> "" Then
				If StringInStr($GUIStyle[$hChildWins[$i]], "WS_EX_") Then
					$hSplit = StringSplit($GUIStyle[$hChildWins[$i]], "|")
					Dim $StyleTemp = ""
					Dim $ExStyleTemp = ""
					For $b = 1 To $hSplit[0] Step 1
						If StringInStr($hSplit[$b], "WS_EX_") Then
							If $ExStyleTemp <> "" Then
								$ExStyleTemp &= "|" & $hSplit[$b]
							Else
								$ExStyleTemp &= $hSplit[$b]
							EndIf
						Else
							If $StyleTemp <> "" Then
								$StyleTemp &= "|" & $hSplit[$b]
							Else
								$StyleTemp &= $hSplit[$b]
							EndIf
						EndIf
					Next
					If $StyleTemp = "" Then
						$StyleTemp = "0"
					EndIf
					If StringInStr($StyleTemp, "|") And StringInStr($ExStyleTemp, "|") Then
						$WinCode &= 'GUISetStyle( BitOr( ' & StringReplace($StyleTemp, "|", ", ") & '), BitOr( ' & StringReplace($ExStyleTemp, "|", ", ") & '), $' & $GUIHandles[$hChildWins[$i]] & ')' & @CRLF
					ElseIf StringInStr($StyleTemp, "|") And StringInStr($ExStyleTemp, "|") = False Then
						$WinCode &= 'GUISetStyle( BitOr( ' & StringReplace($StyleTemp, "|", ", ") & '), ' & $ExStyleTemp & ', $' & $GUIHandles[$hChildWins[$i]] & ')' & @CRLF
					ElseIf StringInStr($StyleTemp, "|") = False And StringInStr($ExStyleTemp, "|") Then
						$WinCode &= 'GUISetStyle( ' & $StyleTemp & ', BitOr( ' & StringReplace($ExStyleTemp, "|", ", ") & '), $' & $GUIHandles[$hChildWins[$i]] & ')' & @CRLF
					ElseIf StringInStr($StyleTemp, "|") = False And StringInStr($ExStyleTemp, "|") = False Then
						$WinCode &= 'GUISetStyle( ' & $StyleTemp & ', ' & $ExStyleTemp & ', $' & $GUIHandles[$hChildWins[$i]] & ')' & @CRLF
					EndIf
				Else
					If StringInStr($GUIStyle[$hChildWins[$i]], "|") Then
						$WinCode &= 'GUISetStyle( BitOr( ' & StringReplace($GUIStyle[$hChildWins[$i]], "|", ", ") & '), 0, $' & $GUIHandles[$hChildWins[$i]] & ')' & @CRLF
					Else
						$WinCode &= 'GUISetStyle( ' & $GUIStyle[$hChildWins[$i]] & ', 0, $' & $GUIHandles[$hChildWins[$i]] & ')' & @CRLF
					EndIf
				EndIf
			EndIf
			If $GUIColors[$hChildWins[$i]] <> "" Then
				$WinCode &= "GUISetBkColor( 0x" & $GUIColors[$hChildWins[$i]] & ", $" & $GUIHandles[$hChildWins[$i]] & ")" & @CRLF
			EndIf
			If $GUIMenus[$hChildWins[$i]] <> "" Then
				$WinCode &= _GetMenuCode($GUIMenus[$hChildWins[$i]]) & @CRLF
			EndIf
			$WinCode &= 'GUISetOnEvent($GUI_EVENT_CLOSE, "GUI_CLOSE")' & @CRLF
			For $e = 0 To $LayerCount Step 1
				For $c = 1 To $Controls[0] Step 1
					If $e = $Layers[$c] And $Used[$c] = False Then
						If $Parents[$c] = $GUIHandles[$hChildWins[$i]] Then
							$WinCode &= _GetControlCode($Controls[$c], $c, $GUIs[$hChildWins[$i]])
							$Used[$c] = True
						EndIf
					EndIf
				Next
			Next
			$WinCode &= 'GUISetState(' & $GUISetStateData[$hChildWins[$i]] & ')' & @CRLF
			$Code &= $WinCode
		Next

		$Code &= 'While ' & $WhileData & $WhileComment & @CRLF
		$Code &= '	Sleep(50)' & @CRLF
		$Code &= 'WEnd' & @CRLF & @CRLF

		$Code &= 'Func GUI_CLOSE()' & @CRLF
		$Code &= '	Exit' & @CRLF
		$Code &= 'EndFunc' & @CRLF
	EndIf
	If $GUIScript[$CurrentWindow] <> "" Then
		$Code &= $GUIScript[$CurrentWindow]
	EndIf
	$hLineSplit = StringSplit($Code, @CRLF, 1)
	$LineCount = $hLineSplit[0]
	Return $Code
EndFunc   ;==>_GenerateCode
Func _GetControlCode($xControl, $i, $hHandle)
	Local $Code = ''
	$hControl = ControlGetPos($hHandle, "", $xControl)
	If Not @error Then
		If $Names[$i] <> "" Then
			If $Types[$i] <> 25 Then
				$Code &= '$' & $Names[$i] & ' = '
			EndIf
		EndIf
		If $Types[$i] = 1 Then
			$Code &= 'GUICtrlCreateLabel( "' & $Data[$i] & '", ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 2 Then
			$Code &= 'GUICtrlCreateButton( "' & $Data[$i] & '", ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 3 Then
			$Code &= 'GUICtrlCreateInput( "' & $Data[$i] & '", ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 4 Then
			$Code &= 'GUICtrlCreateEdit( "' & $Data[$i] & '", ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 5 Then
			$Code &= 'GUICtrlCreateCheckbox( "' & $Data[$i] & '", ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 6 Then
			$Code &= 'GUICtrlCreateRadio( "' & $Data[$i] & '", ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 7 Then
			$Code &= 'GUICtrlCreateCombo( "", ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 8 Then
			If StringInStr($Data[$i], "|") Then
				$Code &= 'GUICtrlCreateList( "", ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
				$Code &= 'GUICtrlSetData( -1, "' & $Data[$i] & '")' & @CRLF
			Else
				$Code &= 'GUICtrlCreateList( "' & $Data[$i] & '", ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
			EndIf
		ElseIf $Types[$i] = 9 Then
			$Code &= 'GUICtrlCreateDate( "' & $Data[$i] & '", ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 10 Then
			$Code &= 'GUICtrlCreatePic( "' & $Data[$i] & '", ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 11 Then ; To be Implimented
			;$Code &= '$'&$Names[$i]&' = GUICtrlCreateIcon( "'&$Data[$i]&', '&$hControl[0]&', '&$hControl[1]&', '&$hControl[2]&', '&$hControl[3]&')'&@CRLF
		ElseIf $Types[$i] = 12 Then
			$Code &= 'GUICtrlCreateProgress( ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
			If $Data[$i] <> 0 Then
				$Code &= 'GUICtrlSetData( $' & $Names[$i] & ', ' & $Data[$i] & ')' & @CRLF
			EndIf
		ElseIf $Types[$i] = 13 Then
			$Code &= 'GUICtrlCreateTab( ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 14 Then
			$Code &= 'GUICtrlCreateUpDown( $' & $Data[$i] & ' )' & @CRLF
		ElseIf $Types[$i] = 16 Then
			$Code &= 'GUICtrlCreateTreeView( ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 17 Then
			$Code &= 'GUICtrlCreateSlider( ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
			If $Data[$i] <> "0" Then
				$Code &= "GUICtrlSetData( -1, " & $Data[$i] & ")" & @CRLF
			EndIf
		ElseIf $Types[$i] = 18 Then
			$Code &= 'GUICtrlCreateListView( "' & $Data[$i] & '", ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 19 Then
			If IsArray($hControl) Then
				$Code &= 'GUICtrlCreateGraphic( ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
				$RefNum = _GetIndex($SelectedControl)
				If StringInStr($Data[$i], ":") Then
					$ControlSplit = StringSplit($Data[$i], ":")
					For $g = 2 To $ControlSplit[0] Step 1
						$DataSplit = StringSplit($ControlSplit[$g], ",")
						Switch $DataSplit[1]
							Case "D" ; Dot
								If $DataSplit[0] = 5 Then
									If $DataSplit[5] <> "" Then
										$Code &= 'GUICtrlSetGraphic( -1, $GUI_GR_MOVE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_COLOR, 0x' & $DataSplit[4] & ", 0x" & $DataSplit[5] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_DOT, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF
									Else
										$Code &= 'GUICtrlSetGraphic( -1, $GUI_GR_MOVE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_COLOR, 0x' & $DataSplit[4] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_DOT, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF
									EndIf
								EndIf
							Case "P" ; Pixel
								If $DataSplit[0] = 5 Then
									If $DataSplit[5] <> "" Then
										$Code &= 'GUICtrlSetGraphic( -1, $GUI_GR_MOVE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_COLOR, 0x' & $DataSplit[4] & ", 0x" & $DataSplit[5] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_PIXEL, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF
									Else
										$Code &= 'GUICtrlSetGraphic( -1, $GUI_GR_MOVE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_COLOR, 0x' & $DataSplit[4] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_PIXEL, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF
									EndIf
								EndIf
							Case "L" ; Line
								If $DataSplit[0] = 7 Then
									If $DataSplit[7] <> "" Then
										$Code &= 'GUICtrlSetGraphic( -1, $GUI_GR_MOVE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_COLOR, 0x' & $DataSplit[6] & ", 0x" & $DataSplit[7] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_LINE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_LINE, ' & $DataSplit[4] & ", " & $DataSplit[5] & ")" & @CRLF
									Else
										$Code &= 'GUICtrlSetGraphic( -1, $GUI_GR_MOVE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_COLOR, 0x' & $DataSplit[6] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_LINE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_LINE, ' & $DataSplit[4] & ", " & $DataSplit[5] & ")" & @CRLF
									EndIf
								EndIf
							Case "R" ; Rect
								If $DataSplit[0] = 7 Then
									If $DataSplit[7] <> "" Then
										$Code &= 'GUICtrlSetGraphic( -1, $GUI_GR_MOVE, ' & $DataSplit[2] & ', ' & $DataSplit[3] & ')' & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_COLOR, 0x' & $DataSplit[6] & ', 0x' & $DataSplit[7] & ')' & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_RECT, ' & $DataSplit[2] & ', ' & $DataSplit[3] & ', ' & ($DataSplit[4] - $DataSplit[2]) & ", " & ($DataSplit[5] - $DataSplit[3]) & ")" & @CRLF
									Else
										$Code &= 'GUICtrlSetGraphic( -1, $GUI_GR_MOVE, ' & $DataSplit[2] & ', ' & $DataSplit[3] & ')' & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_COLOR, 0x' & $DataSplit[6] & ')' & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_RECT, ' & $DataSplit[2] & ', ' & $DataSplit[3] & ', ' & ($DataSplit[4] - $DataSplit[2]) & ", " & ($DataSplit[5] - $DataSplit[3]) & ")" & @CRLF
									EndIf
								EndIf
							Case "E" ; Ellipse
								If $DataSplit[0] = 7 Then
									If $DataSplit[7] <> "" Then
										$Code &= 'GUICtrlSetGraphic( -1, $GUI_GR_MOVE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_COLOR, 0x' & $DataSplit[6] & ', 0x' & $DataSplit[7] & ')' & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_ELLIPSE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ", " & ($DataSplit[4] - $DataSplit[2]) & ", " & ($DataSplit[5] - $DataSplit[3]) & ")" & @CRLF
									Else
										$Code &= 'GUICtrlSetGraphic( -1, $GUI_GR_MOVE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_COLOR, 0x' & $DataSplit[6] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_ELLIPSE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ", " & ($DataSplit[4] - $DataSplit[2]) & ", " & ($DataSplit[5] - $DataSplit[3]) & ")" & @CRLF
									EndIf
								EndIf
							Case "B"
								If $DataSplit[0] = 9 Then
									If $DataSplit[9] <> "" Then
										$Code &= 'GUICtrlSetGraphic( -1, $GUI_GR_MOVE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_COLOR, 0x' & $DataSplit[8] & ', 0x' & $DataSplit[9] & ')' & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_BEZIER, ' & $DataSplit[2] & ", " & $DataSplit[3] & ", " & $DataSplit[4] & ", " & $DataSplit[5] & ", " & $DataSplit[6] & ", " & $DataSplit[7] & ")" & @CRLF
									Else
										$Code &= 'GUICtrlSetGraphic( -1, $GUI_GR_MOVE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_COLOR, 0x' & $DataSplit[8] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_BEZIER, ' & $DataSplit[2] & ", " & $DataSplit[3] & ", " & $DataSplit[4] & ", " & $DataSplit[5] & ", " & $DataSplit[6] & ", " & $DataSplit[7] & ")" & @CRLF
									EndIf
								EndIf
							Case "i"
								If $DataSplit[0] = 8 Then
									If $DataSplit[8] <> "" Then
										$Code &= 'GUICtrlSetGraphic( -1, $GUI_GR_MOVE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_COLOR, 0x' & $DataSplit[7] & ', 0x' & $DataSplit[8] & ')' & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_PIE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ", " & $DataSplit[4] & ", " & $DataSplit[5] & ", " & $DataSplit[6] & ")" & @CRLF
									Else
										$Code &= 'GUICtrlSetGraphic( -1, $GUI_GR_MOVE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_COLOR, 0x' & $DataSplit[7] & ")" & @CRLF & _
												'GUICtrlSetGraphic( -1, $GUI_GR_PIE, ' & $DataSplit[2] & ", " & $DataSplit[3] & ", " & $DataSplit[4] & ", " & $DataSplit[5] & ", " & $DataSplit[6] & ")" & @CRLF
									EndIf
								EndIf
						EndSwitch
					Next
				EndIf
			EndIf
		ElseIf $Types[$i] = 20 Then
			$Code &= 'GUICtrlCreateDummy( )' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 21 Then
			$Code &= 'GUICtrlCreateGroup( "' & $Data[$i] & '", ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 22 Then
			$Code &= 'GUICtrlCreateMonthCal( "' & $Data[$i] & '", ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 24 Then
			$Code &= '_GUICtrlRichEdit_Create( $' &$Parents[$i]& ',"' & $Data[$i] & '", ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 25 Then
			$Code &= 'GUICtrlCreateObj( $'&$Names[$i]&', ' & $hControl[0] & ', ' & $hControl[1] & ', ' & $hControl[2] & ', ' & $hControl[3] & ')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 26 Then
			$Code &= '$' & $Names[$i] & ' = _GDIPlus_GraphicsCreateFromHWND($' &$Parents[$i]& ')'&@CRLF
		EndIf
		If $Styles[$i] <> "" and $Types[$i] <> 25 Then
			$hSplit = StringSplit($Styles[$i], "|")
			If StringInStr($Styles[$i], "_EX_") Then
				Dim $EXStylestmp = "", $Styletmp = ""
				For $c = 1 To $hSplit[0] Step 1
					If StringInStr($hSplit[$c], "_EX_") Then
						If $EXStylestmp = "" Then
							$EXStylestmp &= $hSplit[$c]
						Else
							$EXStylestmp &= "|" & $hSplit[$c]
						EndIf
					Else
						If $Styletmp = "" Then
							$Styletmp &= $hSplit[$c]
						Else
							$Styletmp &= "|" & $hSplit[$c]
						EndIf
					EndIf
				Next
				If $Styletmp = "" Then
					$Styletmp = "0"
				EndIf
				If StringInStr($EXStylestmp, "|") And StringInStr($Styletmp, "|") Then
					$Code &= 'GUICtrlSetStyle( -1, BitOr(' & StringReplace($Styletmp, "|", ", ") & '), BitOr(' & StringReplace($EXStylestmp, "|", ", ") & '))' & @CRLF
				ElseIf StringInStr($EXStylestmp, "|") And StringInStr($Styletmp, "|") = False Then
					$Code &= 'GUICtrlSetStyle( -1, ' & $Styletmp & ', BitOr(' & StringReplace($EXStylestmp, "|", ", ") & '))' & @CRLF
				ElseIf StringInStr($EXStylestmp, "|") = False And StringInStr($Styletmp, "|") Then
					$Code &= 'GUICtrlSetStyle( -1, BitOr(' & StringReplace($Styletmp, "|", ", ") & '), ' & $EXStylestmp & ')' & @CRLF
				ElseIf StringInStr($EXStylestmp, "|") = False And StringInStr($Styletmp, "|") = False Then
					$Code &= 'GUICtrlSetStyle( -1, ' & $Styletmp & ', ' & $EXStylestmp & ')' & @CRLF
				EndIf
			Else
				If $hSplit[0] > 2 Then
					$Code &= 'GUICtrlSetStyle( -1, BitOr(' & StringReplace(StringTrimRight($Styles[$i], 1), "|", ", ") & '))' & @CRLF
				Else
					$Code &= 'GUICtrlSetStyle( -1, ' & $hSplit[1] & ')' & @CRLF
				EndIf
			EndIf
		EndIf
		If $Types[$i] = 7 Then
			$Code &= 'GUICtrlSetData( -1, "' & $Data[$i] & '")'&@CRLF
		EndIf
		If $States[$i] <> "$GUI_SHOW" Then
			$Code &= 'GUICtrlSetState( -1, ' & $States[$i] & ')' & @CRLF
		EndIf
		If $Cursors[$i] <> "0" And $Cursors[$i] <> "2" Then
			$Code &= 'GUICtrlSetCursor( -1, ' & $Cursors[$i] & ')' & @CRLF
		EndIf
		Dim $AttributeVal = "0"
		$aSplit = StringSplit($FontInfo[$i], "+")
		For $c = $aSplit[0] To 1 Step -1
			If $aSplit[$c] <> "" Then
				$AttributeVal += $aSplit[$c]
			EndIf
		Next
		If StringInStr($FontInfo[$i], "+0+") Then
			If $Font[$i] <> $DefaultFont Then
				$Code &= 'GUICtrlSetFont( -1, ' & $FontSize[$i] & ', 800, ' & $AttributeVal & ', "' & $Font[$i] & '")' & @CRLF
			Else
				$Code &= 'GUICtrlSetFont( -1, ' & $FontSize[$i] & ', 800, ' & $AttributeVal & ')' & @CRLF
			EndIf
		Else
			If $Font[$i] <> $DefaultFont Then
				If $AttributeVal = "0" Then
					$Code &= 'GUICtrlSetFont( -1, ' & $FontSize[$i] & ', 400, 0, "' & $Font[$i] & '")' & @CRLF
				Else
					$Code &= 'GUICtrlSetFont( -1, ' & $FontSize[$i] & ', 400, ' & $AttributeVal & ', "' & $Font[$i] & '")' & @CRLF
				EndIf
			Else
				If $AttributeVal <> "0" Then
					$Code &= 'GUICtrlSetFont( -1, ' & $FontSize[$i] & ', 400, ' & $AttributeVal & ')' & @CRLF
				ElseIf $Font[$i] = $DefaultFont And $FontSize[$i] <> "8.5" And $FontSize[$i] <> "" Then
					$Code &= 'GUICtrlSetFont( -1, ' & $FontSize[$i] & ')' & @CRLF
				EndIf
			EndIf
		EndIf
		If $Colors[$i] <> "" Then
			$Code &= 'GUICtrlSetColor( -1, 0x' & $Colors[$i] & ')' & @CRLF
		EndIf
		If $BkColors[$i] = "Trans" Then
			$Code &= 'GUICtrlSetBkColor( -1, $GUI_BKCOLOR_TRANSPARENT)' & @CRLF
		Else
			If $BkColors[$i] <> "" Then
				$Code &= 'GUICtrlSetBkColor( -1, 0x' & $BkColors[$i] & ')' & @CRLF
			EndIf
		EndIf
		If $Images[$i] <> "" Then
			If StringinStr($Images[$i], "|") Then
				$tSplit = StringSplit($Images[$i], "|")
				If $tSplit[0] = 3 Then
					$Code &= 'GUICtrlSetImage( -1, "' & $tSplit[1] & '", '&$tSplit[2]&', '&$tSplit[3]&')' & @CRLF
				EndIf
			Else
				$Code &= 'GUICtrlSetImage( -1, "' & $Images[$i] & '")' & @CRLF
			EndIf
		EndIf
		If $Resize[$i] <> "" Then
			Dim $ResizeValue = ""
			$aSplit = StringSplit($Resize[$i], "+")
			For $c = $aSplit[0] To 1 Step -1
				If $aSplit[$c] <> "" Then
					If $c = 2 Then
						$ResizeValue &= $aSplit[$c]
					Else
						$ResizeValue &= $aSplit[$c] & "+"
					EndIf
				EndIf
			Next
			$Code &= 'GUICtrlSetResizing( -1, ' & Execute($ResizeValue) & ')' & @CRLF
		EndIf
		If $Types[$i] = 13 Then
			If StringInStr($Data[$i], "|") Then
				$hSplit = StringSplit($Data[$i], "|")
				For $a = 1 To $hSplit[0] Step 1
					$Code &= '$hTabItem' & $a & ' = GUICtrlCreateTabItem( "' & $hSplit[$a] & '" )' & @CRLF
					For $b = 1 To $Controls[0] Step 1
						If $Attributes[$b] = $Names[$i] & "ø" & $a Then
							If $Used[$b] = False Then
								$Code &= _GetControlCode($Controls[$b], $b, $hHandle)
								$Used[$b] = True
							EndIf
						EndIf
					Next
				Next
				$Code &= 'GUICtrlCreateTabItem( "" )' & @CRLF
			ElseIf $Data[$i] <> "" Then
				$Code &= '$hTabItem = GUICtrlCreateTabItem( "' & $Data[$i] & '" )' & @CRLF
				For $b = 1 To $Controls[0] Step 1
					If StringInStr($Attributes[$b], $Names[$i] & "ø") Then
						If $Used[$b] = False Then
							$Code &= _GetControlCode($Controls[$b], $b, $hHandle)
							$Used[$b] = True
						EndIf
					EndIf
				Next
				$Code &= 'GUICtrlCreateTabItem( "" )' & @CRLF
			EndIf
		ElseIf $Types[$i] = 21 Then
			For $b = 1 To $Controls[0] Step 1
				If $Attributes[$b] = $Names[$i] & "Ð" Then
					If $Used[$b] = False And StringInStr($Attributes[$b], "ø") = False And $Types[$b] <> 13 Then
						$Code &= _GetControlCode($Controls[$b], $b, $hHandle)
						$Used[$b] = True
					EndIf
				EndIf
			Next
		EndIf
	Else
		If $Types[$i] = 14 Then
			$Code &= "$UpDown" & $i & ' = GUICtrlCreateUpDown( $' & $Data[$i] & ' )' & @CRLF
		ElseIf $Types[$i] = 20 Then
			$Code &= '$' & $Names[$i] & ' = GUICtrlCreateDummy( )' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 23 Then
			Dim $hSizeSplit = StringSplit($Data[$i], "|")
			$Code &= '$' & $Names[$i] & ' = _GUIScrollbars_Generate( $' &$Parents[$i]& ', '&$hSizeSplit[1]&', '&$hSizeSplit[2]&')' & $Comments[$i] & @CRLF
		ElseIf $Types[$i] = 26 Then
			$Code &= '$' & $Names[$i] & ' = _GDIPlus_GraphicsCreateFromHWND($' &$Parents[$i]& ')'&@CRLF
		Else
			_DebugAdd("Script Writing Error Control Position Not Found, Control["&_GetIndex($xControl)&"], ["&$Controls[0]&"], "&@Error, $ErrorColor)
		EndIf
	EndIf
	Return $Code
EndFunc   ;==>_GetControlCode
Func _ControlToName($hCtrl)
	For $i = 1 To $Controls[0] Step 1
		If $hCtrl = $Controls[$i] Then
			Return $Names[$i]
		EndIf
	Next
	Return 0
EndFunc   ;==>_ControlToName
Func _UsedType($hType)
	For $i = 1 To $Types[0] Step 1
		If $Types[$i] = $hType Then
			Return True
		EndIf
	Next
	Return False
EndFunc   ;==>_UsedType
Func _GetExtraIncludes()
	$ExtraStyles = ''
	For $i = 1 To $Controls[0] Step 1
		If $Types[$i] = 1 Or $Types[$i] = 10 Or $Types[$i] = 11 Or $Types[$i] = 19 Then
			If $Styles[$i] <> "" And Not StringInStr($ExtraStyles, "#include <StaticConstants.au3>") Then
				$ExtraStyles &= "#include <StaticConstants.au3>" & @CRLF
			EndIf
		ElseIf $Types[$i] = 2 Or $Types[$i] = 5 Or $Types[$i] = 6 Then
			If $Styles[$i] <> "" And Not StringInStr($ExtraStyles, "#include <ButtonConstants.au3>") Then
				$ExtraStyles &= "#include <ButtonConstants.au3>" & @CRLF
			EndIf
		ElseIf $Types[$i] = 3 or $Types[$i] = 4  Then
			If $Styles[$i] <> "" And Not StringInStr($ExtraStyles, "#include <EditConstants.au3>") Then
				$ExtraStyles &= "#include <EditConstants.au3>" & @CRLF
			EndIf
		ElseIf $Types[$i] = 7 Then
			If $Styles[$i] <> "" And Not StringInStr($ExtraStyles, "#include <ComboConstants.au3>") Then
				$ExtraStyles &= "#include <ComboConstants.au3>" & @CRLF
			EndIf
		ElseIf $Types[$i] = 8 Then
			If $Styles[$i] <> "" And Not StringInStr($ExtraStyles, "#include <ListboxConstants.au3>") Then
				$ExtraStyles &= "#include <ListboxConstants.au3>" & @CRLF
			EndIf
		ElseIf $Types[$i] = 9 Then
			If $Styles[$i] <> "" And Not StringInStr($ExtraStyles, "#include <DateTimeConstants.au3>") Then
				$ExtraStyles &= "#include <DateTimeConstants.au3>" & @CRLF
			EndIf
		ElseIf $Types[$i] = 12 Then
			If $Styles[$i] <> "" And Not StringInStr($ExtraStyles, "#include <ProgressConstants.au3>") Then
				$ExtraStyles &= "#include <ProgressConstants.au3>" & @CRLF
			EndIf
		ElseIf $Types[$i] = 13 Then
			If $Styles[$i] <> "" And Not StringInStr($ExtraStyles, "#include <TabConstants.au3>") Then
				$ExtraStyles &= "#include <TabConstants.au3>" & @CRLF
			EndIf
		ElseIf $Types[$i] = 14 Then
			If $Styles[$i] <> "" And Not StringInStr($ExtraStyles, "#include <UpdownConstants.au3>") Then
				$ExtraStyles &= "#include <UpdownConstants.au3>" & @CRLF
			EndIf
		ElseIf $Types[$i] = 16 Then
			If $Styles[$i] <> "" And Not StringInStr($ExtraStyles, "#include <TreeviewConstants.au3>") Then
				$ExtraStyles &= "#include <TreeviewConstants.au3>" & @CRLF
			EndIf
		ElseIf $Types[$i] = 17 Then
			If $Styles[$i] <> "" And Not StringInStr($ExtraStyles, "#include <SliderConstants.au3>") Then
				$ExtraStyles &= "#include <SliderConstants.au3>" & @CRLF
			EndIf
		ElseIf $Types[$i] = 18 Then
			If $Styles[$i] <> "" And Not StringInStr($ExtraStyles, "#include <ListviewConstants.au3>") Then
				$ExtraStyles &= "#include <ListviewConstants.au3>" & @CRLF
			EndIf
		ElseIf $Types[$i] = 23 Then
			If StringInStr($ExtraStyles, "#include <GuiScrollBars_Ex.au3>") = False Then
				$ExtraStyles &= "#include <GuiScrollBars_Ex.au3>"&@CRLF&"#include <GUIScrollbars.au3>"&@CRLF
			EndIf
		ElseIf $Types[$i] = 24 Then
			If StringInStr($ExtraStyles, "#include <GuiRichEdit.au3>") = False Then
				$ExtraStyles &= "#include <GuiRichEdit.au3>" & @CRLF
			EndIf
		ElseIf $Types[$i] = 26 Then
			If StringInStr($ExtraStyles, "#include <GDIPlus.au3>") = False Then
				$ExtraStyles &= "#include <GDIPlus.au3>" & @CRLF
			EndIf
		EndIf
	Next
	Return $ExtraStyles
EndFunc   ;==>_GetExtraIncludes
Func _SaveScript($hDir)
	IniWrite(@ScriptDir & "/Config.ini", "Vars", "LastFile", $hDir)
	Local $hData = ''
	Dim $SaveName = $hDir
	$hFile = FileOpen($hDir, 2)
	$DirSplit = StringSplit($hDir, "\")
	_GUICtrlTreeView_SetText($hTree, $hFileTree, $DirSplit[$DirSplit[0]])
	Dim $OpenGUIS[1] = [0]
	For $g = 1 To $GUIs[0] Step 1
		If BitAND(WinGetState($GUIs[$g]), 2) Then
			$hPos = WinGetPos($GUIs[$g])
			$hData &= "ð" & $hPos[2] & "§" & $hPos[3] & "§" & $WinTitles[$g] & "§" & $GUIHandles[$g] & "§" & $GUIColors[$g] & "§" & $GUIVars[$g] & "§" & $GUIScript[$g] & "§" & $GUIComment[$g] & "§" & $GUIMenus[$g] & "§" & $GUIProperties[$g] & "§" & $GUIX[$g] & "§" & $GUIY[$g] & "§" & $GUIStyle[$g] & "§" & $ExtraIncludeData & "§" & $GUISetStateData[$g] & "§" & $WhileData & "§" & $GUIParent[$g] & "§" & $ExtraWhileData & "§" & $AfterGUIData & "§"
			For $i = 1 To $Controls[0] Step 1
				If $Parents[$i] = $GUIHandles[$g] Then
					$ControlData = ControlGetPos($GUIs[$g], "", GUICtrlGetHandle($Controls[$i]))
					If Not @error Then
						$hData &= "š" & $Names[$i] & "Ÿ" & $Types[$i] & "Ÿ" & $ControlData[0] & "Ÿ" & $ControlData[1] & "Ÿ" & $ControlData[2] & "Ÿ" & $ControlData[3] & "Ÿ" & $Colors[$i] & "Ÿ" & $BkColors[$i] & "Ÿ" & $Styles[$i] & "Ÿ" & $States[$i] & "Ÿ" & $Data[$i] & "Ÿ" & $Resize[$i] & "Ÿ" & $Font[$i] & "Ÿ" & $FontInfo[$i] & "Ÿ" & $FontSize[$i] & "Ÿ" & $Layers[$i] & "Ÿ" & $Attributes[$i] & "Ÿ" & $Images[$i] & "Ÿ" & $Cursors[$i] & "Ÿ" & $Functions[$i] & "Ÿ" & $Comments[$i] & "Ÿ" & $Locked[$i] & "Ÿ" & $Parents[$i] & "§"
					Else
						_DebugAdd("Save Control Error Control Position Not Found, Control["&$i&"], ["&$Controls[0]&"], "&@Error, $ErrorColor)
					EndIf
				EndIf
			Next
		EndIf
	Next
	For $i = _GUICtrlListView_GetItemCount($LayerList) To 1 Step -1
		$hData &= "ë" & _GUICtrlListView_GetItemText($LayerList, $i - 1)
	Next
	GUICtrlSetState($Save, $GUI_ENABLE)
	FileWrite($hFile, _HexToString(_StringEncrypt(1, $hData, "GUI420", 1)))
	FileClose($hFile)
EndFunc   ;==>_SaveScript
Func _SaveTemp($hDir)
	Dim $hData = ''
	$hFile = FileOpen($hDir, 2)
	For $g = 1 To $GUIs[0] Step 1
		If BitAND(WinGetState($GUIs[$g]), 2) Then
			$hPos = WinGetPos($GUIs[$g])
			$hData &= "ð" & $hPos[2] & "§" & $hPos[3] & "§" & $WinTitles[$g] & "§" & $GUIHandles[$g] & "§" & $GUIColors[$g] & "§" & $GUIVars[$g] & "§" & $GUIScript[$g] & "§" & $GUIComment[$g] & "§" & $GUIMenus[$g] & "§" & $GUIProperties[$g] & "§" & $GUIX[$g] & "§" & $GUIY[$g] & "§" & $GUIStyle[$g] & "§" & $ExtraIncludeData & "§" & $GUISetStateData[$g] & "§" & $WhileData & "§" & $GUIParent[$g] & "§"
			For $i = 1 To $Controls[0] Step 1
				$ControlData = ControlGetPos("", "", $Controls[$i])
				If Not @error Then
					$hData &= "š" & $Names[$i] & "Ÿ" & $Types[$i] & "Ÿ" & $ControlData[0] & "Ÿ" & $ControlData[1] & "Ÿ" & $ControlData[2] & "Ÿ" & $ControlData[3] & "Ÿ" & $Colors[$i] & "Ÿ" & $BkColors[$i] & "Ÿ" & $Styles[$i] & "Ÿ" & $States[$i] & "Ÿ" & $Data[$i] & "Ÿ" & $Resize[$i] & "Ÿ" & $Font[$i] & "Ÿ" & $FontInfo[$i] & "Ÿ" & $FontSize[$i] & "Ÿ" & $Layers[$i] & "Ÿ" & $Attributes[$i] & "Ÿ" & $Images[$i] & "Ÿ" & $Cursors[$i] & "Ÿ" & $Functions[$i] & "Ÿ" & $Comments[$i] & "Ÿ" & $Locked[$i] & "Ÿ" & $Controls[$i] & "Ÿ" & $Parents[$i] & "§"
				Else
					_DebugAdd("Error Saving Control["&$i&"] @ERRORCODE: "&@Error, $ErrorColor)
				EndIf
			Next
		EndIf
	Next
	For $i = _GUICtrlListView_GetItemCount($LayerList) To 1 Step -1
		$hData &= "ë" & _GUICtrlListView_GetItemText($LayerList, $i - 1)
	Next
	GUICtrlSetState($Save, $GUI_ENABLE)
	FileWrite($hFile, _HexToString(_StringEncrypt(1, $hData, "GUI420", 1)))
	FileClose($hFile)
EndFunc   ;==>_SaveTemp
Func _OpenTemp($hDir)
	_GUICtrlTreeView_DeleteAll($hTree)
	_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($LayerList))
	Dim $TreeItems[1] = [0], $hData = ""
	_ClearData()
	$LayerCount = 0
	$ControlNum = 0

	$hFileTree = _GUICtrlTreeView_AddChild($hTree, 0, _GUICtrlTab_GetItemText($GUITab, _GUICtrlTab_GetCurSel($GUITab)))
	_GUICtrlTreeView_SetIcon($hTree, $hFileTree, @ScriptDir & "\Resources.dll", -279)

	GUICtrlSetState($Save, $GUI_ENABLE)
	$hFile = FileOpen($hDir, 0)
	$hData = _StringEncrypt(0, _StringToHex(FileRead($hFile)), "GUI420", 1)
	FileClose($hFile)
	If StringInStr($hData, "ð") Then
		$SelectedControl = 0
		$WindowSplit = StringSplit($hData, "ð")
		_GUICtrlTreeView_BeginUpdate($hTree)
		$CurrentWindow = _GUICtrlTab_GetCurSel($GUITab) + 1
		GUISetCursor(15, 1, $GUIs[$CurrentWindow])
		$DataSplit = StringSplit($WindowSplit[2], "§")
		$hTreeGUI = _GUICtrlTreeView_AddChild($hTree, $hFileTree, $DataSplit[4])
		_GUICtrlTreeView_SetIcon($hTree, $hTreeGUI, @ScriptDir & "\Resources.dll", -119)
		$GUITrees[$CurrentWindow] = $hTreeGUI
		$ControlNum = 0

		GUISetState(@SW_SHOW, $GUIs[$CurrentWindow])
		GUISetState(@SW_ENABLE, $GUIs[$CurrentWindow])
		GUISwitch($GUIs[$CurrentWindow])

		For $i = 15 To $DataSplit[0] Step 1
			Dim $InsideTab = False
			If StringInStr($DataSplit[$i], "š") Then
				$ControlSplit = StringSplit($DataSplit[$i], "Ÿ") ; ADD Items
				_ArrayAdd($Names, StringTrimLeft($ControlSplit[1], 1))
				_ArrayAdd($Types, $ControlSplit[2])
				_ArrayAdd($Colors, $ControlSplit[7])
				_ArrayAdd($BkColors, $ControlSplit[8])
				_ArrayAdd($Styles, $ControlSplit[9])
				_ArrayAdd($States, $ControlSplit[10])
				_ArrayAdd($Data, $ControlSplit[11])
				_ArrayAdd($Resize, $ControlSplit[12])
				_ArrayAdd($Controls, $ControlSplit[23])
				_ArrayAdd($Font, $ControlSplit[13])
				_ArrayAdd($FontInfo, $ControlSplit[14])
				_ArrayAdd($FontSize, $ControlSplit[15])
				_ArrayAdd($Layers, $ControlSplit[16])
				_ArrayAdd($Attributes, $ControlSplit[17])
				_ArrayAdd($Images, $ControlSplit[18])
				_ArrayAdd($Functions, $ControlSplit[20])
				_ArrayAdd($Comments, $ControlSplit[21])
				_ArrayAdd($Locked, $ControlSplit[22])
				_ArrayAdd($Cursors, $ControlSplit[19])
				_ArrayAdd($Parents, $ControlSplit[24])
				$Parents[0] += 1
				$Cursors[0] += 1
				$Locked[0] += 1
				$Comments[0] += 1
				$Functions[0] += 1
				$Images[0] += 1
				$Attributes[0] += 1
				$Layers[0] += 1
				$Font[0] += 1
				$FontInfo[0] += 1
				$FontSize[0] += 1
				$Controls[0] += 1
				$Names[0] += 1
				$Types[0] += 1
				$Colors[0] += 1
				$BkColors[0] += 1
				$Styles[0] += 1
				$States[0] += 1
				$Data[0] += 1
				$Resize[0] += 1
				$ControlNum += 1
				_CreateResizeTabs($Controls[$Controls[0]])
			EndIf
		Next
		$LayerSplit = StringSplit($hData, "ë")
		For $i = $LayerSplit[0] To 3 Step -1
			_GUICtrlListView_AddItem($LayerList, $LayerSplit[$i])
			$LayerCount += 1
		Next
		For $i = 1 To $Controls[0] Step 1
			If StringInStr($Attributes[$i], "ø") Then
				$hSplit = StringSplit($Attributes[$i], "ø")
				$hIndex = _ArraySearch($Names, $hSplit[1])
				$ItemHandle = _GUICtrlTreeView_FindItem($hTree, "hTabItem" & $hSplit[2], False, 0)
				If $ItemHandle = 0 Then
					$hTabItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "hTabItem" & $hSplit[2])
					_GUICtrlTreeView_SetIcon($hTree, $hTabItem, @ScriptDir & "\Resources.dll", _GetIcon(13))
					$hItem = _GUICtrlTreeView_AddChild($hTree, $hTabItem, $Names[$i])
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$i]))
				Else
					$hItem = _GUICtrlTreeView_AddChild($hTree, $ItemHandle, $Names[$i])
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$i]))
				EndIf
				_ArrayAdd($TreeItems, $hItem)
				$TreeItems[0] += 1
			EndIf
			If StringInStr($Attributes[$i], "Ð") Then
				$hSplit = StringTrimRight($Attributes[$i], 1)
				$hIndex = _ArraySearch($Names, $hSplit)
				$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], $Names[$i])
				_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$i]))
				_ArrayAdd($TreeItems, $hItem)
				$TreeItems[0] += 1
			EndIf
			If StringInStr($Attributes[$i], "ø") = False And StringInStr($Attributes[$i], "Ð") = False Then
				_AddTreeItem($Names[$i], $Types[$i], $Parents[$i])
			EndIf
		Next
		_GUICtrlListView_AddItem($LayerList, "Layer 0")
		If $GUIMenus[$CurrentWindow] <> "" Then
			$hTreeMenu = _GUICtrlTreeView_AddChild($hTree, $GUITrees[$CurrentWindow], "hMenu")
			_GUICtrlTreeView_SetIcon($hTree, $hTreeMenu, @ScriptDir & "\Resources.dll", -126)
			_SetMenuData($GUIMenus[$CurrentWindow])
		EndIf
		$AddingControl = False
		_GUICtrlTreeView_EndUpdate($hTree)
		_GUICtrlTreeView_Expand($hTree, $GUITrees[$CurrentWindow], True)
		_SetScriptData()
	EndIf
	GUISetCursor(2, 1, $GUIs[$CurrentWindow])
EndFunc   ;==>_OpenTemp
Func _OpenScript($hDir, $hPrompt = 0)
	If $hPrompt <> 2 Then
		IniWrite(@ScriptDir & "/Config.ini", "Vars", "LastFile", $hDir)
		Dim $LastFile_1, $LastFile_2, $LastFile_3, $LastFile_4
		$LastFile_1 = IniRead(@ScriptDir & "/Config.ini", "Vars", "LastFile_1", "")
		$LastFile_2 = IniRead(@ScriptDir & "/Config.ini", "Vars", "LastFile_2", "")
		$LastFile_3 = IniRead(@ScriptDir & "/Config.ini", "Vars", "LastFile_3", "")
		$LastFile_4 = IniRead(@ScriptDir & "/Config.ini", "Vars", "LastFile_4", "")
		IniWrite(@ScriptDir & "/Config.ini", "Vars", "LastFile_1", $hDir)
		IniWrite(@ScriptDir & "/Config.ini", "Vars", "LastFile_2", $LastFile_1)
		IniWrite(@ScriptDir & "/Config.ini", "Vars", "LastFile_3", $LastFile_2)
		IniWrite(@ScriptDir & "/Config.ini", "Vars", "LastFile_4", $LastFile_3)
		IniWrite(@ScriptDir & "/Config.ini", "Vars", "LastFile_5", $LastFile_4)
		$hDirSplit_1 = StringSplit($hDir, "\")
		GUICtrlSetData($hLastFileMenu_1, $hDirSplit_1[$hDirSplit_1[0]])
		If $LastFile_1 <> "" Then
			$hDirSplit_10 = StringSplit($LastFile_1, "\")
			GUICtrlSetData( $hLastFileMenu_2, $hDirSplit_10[$hDirSplit_10[0]])
		Else
			GUICtrlSetData( $hLastFileMenu_2, " ")
		EndIf
		If $LastFile_2 <> "" Then
			$hDirSplit_2 = StringSplit($LastFile_2, "\")
			GUICtrlSetData( $hLastFileMenu_3, $hDirSplit_2[$hDirSplit_2[0]])
		Else
			GUICtrlSetData( $hLastFileMenu_3, " ")
		EndIf
		If $LastFile_3 <> "" Then
			$hDirSplit_3 = StringSplit($LastFile_3, "\")
			GUICtrlSetData( $hLastFileMenu_4, $hDirSplit_3[$hDirSplit_3[0]])
		Else
			GUICtrlSetData( $hLastFileMenu_4, " ")
		EndIf
		If $LastFile_4 <> "" Then
			$hDirSplit_4 = StringSplit($LastFile_4, "\")
			GUICtrlSetData( $hLastFileMenu_5, $hDirSplit_4[$hDirSplit_4[0]])
		Else
			GUICtrlSetData( $hLastFileMenu_5, " ")
		EndIf
	EndIf
	GUISetCursor(15, 1, $hGUI)
	Dim $Message = 0

	$Message = _CustomMsg("Close Project?", "Close Current Project before Opening?")
	If $Message = 6 Then
		Dim $LastGUI = 0
		For $i = $GUIS[0] to 1 Step -1
			If BitAnd(WinGetState($GUIS[$i]), 2) Then
				_GDIPlus_GraphicsDispose($GUIPlus[$i])
				GUIDelete($GUIs[$i])
				_ArrayDelete($GUIs, $i)
				_ArrayDelete($GUIHandles, $i)
				_ArrayDelete($WinTitles, $i)
				_ArrayDelete($GUITrees, $i)
				_ArrayDelete($GUIColors, $i)
				_ArrayDelete($GUIVars, $i)
				_ArrayDelete($GUIScript, $i)
				_ArrayDelete($GUIComment, $i)
				_ArrayDelete($GUIStyle, $i)
				_ArrayDelete($GUIMenus, $i)
				_ArrayDelete($GUIProperties, $i)
				_ArrayDelete($GUIX, $i)
				_ArrayDelete($GUIY, $i)
				_ArrayDelete($GUISnapLineX, $i)
				_ArrayDelete($GUISnapLineY, $i)
				_ArrayDelete($GUISetStateData, $i)
				_ArrayDelete($GUIPlus, $i)
				_ArrayDelete($GUIParent, $i)
				$GUIParent[0] -= 1
				$GUIPlus[0] -= 1
				$GUISetStateData[0] -= 1
				$GUISnapLineX[0] -= 1
				$GUISnapLineY[0] -= 1
				$GUIX[0] -= 1
				$GUIY[0] -= 1
				$GUIProperties[0] -= 1
				$GUIMenus[0] -= 1
				$GUIComment[0] -= 1
				$GUIStyle[0] -= 1
				$GUIScript[0] -= 1
				$GUIVars[0] -= 1
				$GUIColors[0] -= 1
				$GUITrees[0] -= 1
				$GUIHandles[0] -= 1
				$WinTitles[0] -= 1
				$GUIs[0] -= 1
				$CurrentWindow = $i
			EndIf
		Next
		_GUICtrlTab_DeleteItem($GUITab, $CurrentWindow - 1)
	Else
		If $Message <> 2 Then
			_SaveScript(@ScriptDir & "\Temp_" & $CurrentWindow & ".tmp")
			GUIDelete($GUIs[$CurrentWindow])
		EndIf
	EndIf
	If $Message <> 2 Then
		_GUICtrlTreeView_DeleteAll($hTree)
		For $i = $Controls[0] To 1 Step -1
			_ArrayDelete($TreeItems, $i)
			$TreeItems[0] -= 1
		Next

		_ClearData()
		_GUICtrlListView_BeginUpdate($LayerList)
		_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($LayerList))
		_GUICtrlListView_EndUpdate($LayerList)
		_GUICtrlListView_AddItem($LayerList, "Layer 0")
		$DirSplit = StringSplit($hDir, "\")
		$hWinSize = WinGetClientSize($hGUI)
		$hOpenProgress = GUICreate("Opening " & $DirSplit[$DirSplit[0]], 440, 72, ($hWinSize[0]-440)/2-20, ($hWinSize[1]-72)/2-150, BitOR($WS_CAPTION, $WS_SIZEBOX, $WS_SYSMENU))
		$hProgressBar = GUICtrlCreateProgress(5, 8, 430, 30)
		$hCancelBn = GUICtrlCreateButton("Cancel", 338, 44, 96, 23)
		GUISetState()
		DllCall($dll, "int", "SetParent", "hwnd", WinGetHandle($hOpenProgress), "hwnd", WinGetHandle($hGUI))
		$hCount = _GUICtrlTab_GetItemCount($GUITab)
		If $hPrompt <> 3 Then
			If $hPrompt <> 5 Then
				_GUICtrlTab_InsertItem($GUITab, $hCount, $DirSplit[$DirSplit[0]])
				_GUICtrlTab_SetCurSel($GUITab, $hCount)
			EndIf
		EndIf
		If $hPrompt = 5 Then
			$hTempIndex = StringTrimRight(StringTrimLeft($DirSplit[$DirSplit[0]], 5), 4)
			_GUICtrlTab_SetCurSel($GUITab, $hTempIndex - 1)
		EndIf
		Dim $LayerCount = 0
		Dim $ControlNum = 0
		$hFile = FileOpen($hDir, 0)
		$SaveName = $hDir
		GUICtrlSetState($Save, $GUI_ENABLE)
		$hData = _StringEncrypt(0, _StringToHex(FileRead($hFile)), "GUI420", 1)
		FileClose($hFile)
		If StringInStr($hData, "§") Then
			GUICtrlSetData($hProgressBar, 5)
			$SelectedControl = 0
			$WindowSplit = StringSplit($hData, "ð")
			$ControlCount = 0
			_GUICtrlTreeView_BeginUpdate($hTree)
			If $hPrompt <> 5 Then
				$hFileTree = _GUICtrlTreeView_Add($hTree, 0, $DirSplit[$DirSplit[0]])
			Else
				$hFileTree = _GUICtrlTreeView_Add($hTree, 0, _GUICtrlTab_GetItemText($GUITab, $hTempIndex - 1))
			EndIf
			_GUICtrlTreeView_SetIcon($hTree, $hFileTree, @ScriptDir & "\Resources.dll", -279)
			For $w = 2 To $WindowSplit[0]
				$DataSplit = StringSplit($WindowSplit[$w], "§")
				$ControlCount = $DataSplit[0] - 6
				$CurrentWindow = _GUICtrlTab_GetCurSel($GUITab) + 1
				$hTreeGUI = _GUICtrlTreeView_AddChild($hTree, $hFileTree, $DataSplit[4])
				_GUICtrlTreeView_SetIcon($hTree, $hTreeGUI, @ScriptDir & "\Resources.dll", -119)
				If $hPrompt = 5 Then
					$GUITrees[$CurrentWindow] = $hTreeGUI
				Else
					_ArrayAdd($GUITrees, $hTreeGUI)
					$GUITrees[0] += 1
				EndIf
				Dim $NewGUI
				$NewGUI = GUICreate($DataSplit[3], 1000, 1000, 50, 50, BitOR($WS_CAPTION, $WS_SIZEBOX, $WS_SYSMENU))
				$TabTop = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
				GUICtrlSetBkColor(-1, $InsertColor)
				GUICtrlSetState(-1, $GUI_HIDE)
				GUICtrlSetResizing(-1, 802)
				$TabBottom = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
				GUICtrlSetBkColor(-1, $InsertColor)
				GUICtrlSetState(-1, $GUI_HIDE)
				GUICtrlSetResizing(-1, 802)
				$TabLeft = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
				GUICtrlSetBkColor(-1, $InsertColor)
				GUICtrlSetState(-1, $GUI_HIDE)
				GUICtrlSetResizing(-1, 802)
				$TabRight = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
				GUICtrlSetBkColor(-1, $InsertColor)
				GUICtrlSetState(-1, $GUI_HIDE)
				GUICtrlSetResizing(-1, 802)
				$SnapLineX = GUICtrlCreateLabel("", -5, -5, 1, 1)
				GUICtrlSetBkColor(-1, 0xFF00FF)
				$SnapLineY = GUICtrlCreateLabel("", -5, -5, 1, 1)
				GUICtrlSetBkColor(-1, 0xFF00FF)
				$SnapLineW = GUICtrlCreateLabel("", -5, -5, 1, 1)
				GUICtrlSetBkColor(-1, 0xFF00FF)
				$SnapLineH = GUICtrlCreateLabel("", -5, -5, 1, 1)
				GUICtrlSetBkColor(-1, 0xFF00FF)
				GUISetState(@SW_HIDE, $NewGUI)
				DllCall($dll, "int", "SetParent", "hwnd", WinGetHandle($NewGUI), "hwnd", WinGetHandle($GUIHolder))
				GUISetState(@SW_SHOW, $NewGUI)


				$hGraphic = _GDIPlus_GraphicsCreateFromHWND($NewGUI)
				WinMove($NewGUI, "", 50, 50, $DataSplit[1], $DataSplit[2])

				If $hPrompt <> 5 Then
					_ArrayAdd($GUIPlus, $hGraphic)
					_ArrayAdd($GUIs, $NewGUI)
					_ArrayAdd($WinTitles, $DataSplit[3])
					_ArrayAdd($GUIHandles, $DataSplit[4])
					_ArrayAdd($GUIColors, $DataSplit[5])
					_ArrayAdd($GUIVars, $DataSplit[6])
					_ArrayAdd($GUIScript, $DataSplit[7])
					_ArrayAdd($GUIComment, $DataSplit[8])
					_ArrayAdd($GUIMenus, $DataSplit[9])
					_ArrayAdd($GUIProperties, $DataSplit[10])
					_ArrayAdd($GUIX, $DataSplit[11])
					_ArrayAdd($GUIY, $DataSplit[12])
					_ArrayAdd($GUIStyle, $DataSplit[13])
					_ArrayAdd($GUISnapLineX, $SnapLineX)
					_ArrayAdd($GUISnapLineY, $SnapLineY)
					$ExtraIncludeData = $DataSplit[14]
					_ArrayAdd($GUISetStateData, $DataSplit[15])
					$WhileData = $DataSplit[16]
					_ArrayAdd($GUIParent, $DataSplit[17])
					$ExtraWhileData = $DataSplit[18]
					$AfterGUIData = $DataSplit[19]
					$GUIPlus[0] += 1
					$GUIParent[0] += 1
					$GUISetStateData[0] += 1
					$GUISnapLineX[0] += 1
					$GUISnapLineY[0] += 1
					$GUIX[0] += 1
					$GUIY[0] += 1
					$GUIProperties[0] += 1
					$GUIMenus[0] += 1
					$GUIComment[0] += 1
					$GUIScript[0] += 1
					$GUIStyle[0] += 1
					$GUIVars[0] += 1
					$GUIColors[0] += 1
					$GUIs[0] += 1
					$WinTitles[0] += 1
					$GUIHandles[0] += 1
					$CurrentWindow = $GUIS[0]
					If StringinStr($DataSplit[13], "$WS_POPUP") Then
						GUISetStyle($WS_POPUP, -1, $NewGUI)
					EndIf
				EndIf

				If $DataSplit[17] <> "0" Then
					Dim $hPIndex = 0
					For $i = 1 to $GUIHandles[0] Step 1
						If $GUIHandles[$i] = $DataSplit[17] Then
							$hPIndex = $i
						EndIf
					Next
					DllCall($dll, "int", "SetParent", "hwnd", WinGetHandle($NewGUI), "hwnd", WinGetHandle($GUIS[$hPIndex]))
					WinMove($NewGUI, "", $DataSplit[11], $DataSplit[12])
				EndIf

				Dim $UsedControls[1] = [0]
				For $i = 1 To $ControlCount Step 1
					_ArrayAdd($UsedControls, False)
					$UsedControls[0] += 1
				Next

				If $DataSplit[5] <> "" Then
					GUISetBkColor("0x" & $DataSplit[5], $NewGUI)
				EndIf
				If $DataSplit[17] = "0" Then
					WinMove($NewGUI, "", 50, 50, $DataSplit[1], $DataSplit[2])
				EndIf
				$AddingControl = True
				Dim $ActiveTab
				Dim $TreeItems[1] = [0]
				For $i = 10 To $DataSplit[0] Step 1
					Dim $InsideTab = False
					If StringInStr($DataSplit[$i], "š") Then
						$ControlSplit = StringSplit($DataSplit[$i], "Ÿ") ; ADD Items
						If StringInStr($ControlSplit[17], "ø") Then
							$hSplit = StringSplit($ControlSplit[17], "ø")
							$hIndex = _ArraySearch($Names, $hSplit[1])
							_GUICtrlTab_ActivateTab($Controls[$hIndex], $hSplit[2]-1)
							GUISwitch($Controls[$hIndex], GUICtrlRead($Controls[$hIndex], 1))
							$ActiveTab = $hSplit[1]
							$InsideTab = True
						Else
							If StringinStr($ControlSplit[17], "Ð") Then
								$hTrimName = StringTrimRight($ControlSplit[17], 1)
								$hIndex = _ArraySearch($Names, $hTrimName)
								If Not @Error Then
									If $Types[$hIndex] = 13 Then
										_GUICtrlTab_ActivateTab($Controls[$hIndex], $hSplit[2]-1)
										GUISwitch($Controls[$hIndex], GUICtrlRead($Controls[$hIndex], 1))
										$ActiveTab = $hSplit[1]
									EndIf
								EndIf
							Else
								GUICtrlCreateTabItem("")
								GUISwitch($GUIS[$w - 1])
							EndIf
						EndIf
						If $ControlSplit[23] = $GUIHandles[$w - 1] Then
							$UsedControls[$i - 5] = True
							_CreateControl($ControlSplit, -1)
							GUICtrlSetData($hProgressBar, 10+($i*2))
						EndIf
						If StringInStr($ControlSplit[17], "ø") Then
							GUISwitch($GUIs[$w - 1])
						EndIf
					EndIf
				Next
				For $i = 1 To $Controls[0] Step 1
					If $States[$i] = "$GUI_HIDE" Then
						GUICtrlSetState($Controls[$i], $GUI_HIDE)
					ElseIf $States[$i] = "$GUI_ONTOP" Then
						GUICtrlSetState($Controls[$i], $GUI_ONTOP)
					ElseIf $States[$i] = "$GUI_DISABLE" Then
						GUICtrlSetState($Controls[$i], $GUI_DISABLE)
					ElseIf $States[$i] = "$GUI_CHECKED" Then
						GUICtrlSetState($Controls[$i], $GUI_CHECKED)
					EndIf
				Next
			Next
			$LayerSplit = StringSplit($hData, "ë")
			For $i = $LayerSplit[0] To 3 Step -1
				If StringinStr($LayerSplit[$i], "š") = False Then
					If $LayerSplit[$i] <> "Layer 0" Then
						_GUICtrlListView_AddItem($LayerList, $LayerSplit[$i])
						$LayerCount += 1
					Else
						_GUICtrlListView_AddItem($LayerList, $LayerSplit[$i])
					EndIf
				EndIf
			Next
			For $i = 1 to $Controls[0] Step 1
				If StringInStr($Attributes[$i], "ø") Then
					$hSplit = StringSplit($Attributes[$i], "ø")
					$hIndex = _ArraySearch($Names, $hSplit[1])
					$ItemHandle = _GUICtrlTreeView_FindItem($hTree, "hTabItem" & $hSplit[2], False, 0)
					If $ItemHandle = 0 Then
						$hTabItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "hTabItem" & $hSplit[2])
						_GUICtrlTreeView_SetIcon($hTree, $hTabItem, @ScriptDir & "\Resources.dll", _GetIcon(13))
						$hItem = _GUICtrlTreeView_AddChild($hTree, $hTabItem, $Names[$i])
						_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$i]))
					Else
						$hItem = _GUICtrlTreeView_AddChild($hTree, $ItemHandle, $Names[$i])
						_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$i]))
					EndIf
					_ArrayAdd($TreeItems, $hItem)
					$TreeItems[0] += 1
				EndIf
				If StringInStr($Attributes[$i], "Ð") Then
					$hSplit = StringTrimRight($Attributes[$i], 1)
					$hIndex = _ArraySearch($Names, $hSplit)
					If Not @ERROR Then
						$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], $Names[$i])
						_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$i]))
						_ArrayAdd($TreeItems, $hItem)
						$TreeItems[0] += 1
					EndIf
				EndIf
				If StringInStr($Attributes[$i], "ø") = False And StringInStr($Attributes[$i], "Ð") = False Then
					_AddTreeItem($Names[$i], $Types[$i], $Parents[$i])
				EndIf
				If $Functions[$i] <> "" Then
					If StringinStr($Functions[$i], "à") Then
						If $Types[$i] = 3 or $Types[$i] = 4 Then
							$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$i], "On Submit")
						Else
							$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$i], "On Click")
						EndIf
					ElseIf StringinStr($Functions[$i], "Þ") Then
						$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$i], "Data Changed")
					EndIf
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -115)
					_ArrayAdd($FunctionTrees, $Controls[$i] & "|" & $hItem)
					$FunctionTrees[0] -= 1
				EndIf
			Next
			If $GUIMenus[$CurrentWindow] <> "" Then
				$hTreeMenu = _GUICtrlTreeView_AddChild($hTree, $GUITrees[$CurrentWindow], "hMenu")
				_GUICtrlTreeView_SetIcon($hTree, $hTreeMenu, @ScriptDir & "\Resources.dll", -126)
				_SetMenuData($GUIMenus[$CurrentWindow])
			EndIf
			$AddingControl = False
			_GUICtrlTreeView_EndUpdate($hTree)
			_GUICtrlTreeView_Expand($hTree, $GUITrees[$CurrentWindow], True)
			GUIDelete($hOpenProgress)
			For $i = 1 to $Controls[0] Step 1
				If $Types[$i] = 26 Then
					If $Data[$i] <> "" Then
						_DrawGDIPlusData( $i, $Data[$i], $GUIS[$CurrentWindow])
					EndIf
				EndIf
			Next
			_SetScriptData()
		Else
			GUIDelete($hOpenProgress)
			MsgBox(0, "Corrupted File", "The File is in a Incorrect or Outdated format," & @CRLF & "The File could not be read.")
		EndIf
	EndIf
	GUISetCursor(2, 1, $hGUI)
EndFunc   ;==>_OpenScript
Func _CreateControl(ByRef $ControlData, $InsertType = 0)
	Dim $hControl
	If $ControlData[2] = 1 Then
		$hControl = GUICtrlCreateLabel($ControlData[11], $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
	ElseIf $ControlData[2] = 2 Then
		$hControl = GUICtrlCreateButton($ControlData[11], $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
	ElseIf $ControlData[2] = 3 Then
		$hControl = GUICtrlCreateInput($ControlData[11], $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6], $ES_READONLY)
		GUICtrlSetBkColor($hControl, 0xFFFFFF)
	ElseIf $ControlData[2] = 4 Then
		$hControl = GUICtrlCreateEdit($ControlData[11], $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6], $ES_READONLY)
		GUICtrlSetBkColor($hControl, 0xFFFFFF)
	ElseIf $ControlData[2] = 5 Then
		$hControl = GUICtrlCreateCheckbox($ControlData[11], $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
	ElseIf $ControlData[2] = 6 Then
		$hControl = GUICtrlCreateRadio($ControlData[11], $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
	ElseIf $ControlData[2] = 7 Then
		$hControl = GUICtrlCreateCombo("", $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6], 0x0003)
		If $ControlData[11] <> "" Then
			GUICtrlSetData($hControl, $ControlData[11])
		EndIf
	ElseIf $ControlData[2] = 8 Then
		$hControl = GUICtrlCreateList($ControlData[11], $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
		If $ControlData[11] <> "" Then
			GUICtrlSetData($hControl, "|" & $ControlData[11])
		EndIf
	ElseIf $ControlData[2] = 9 Then
		$hControl = GUICtrlCreateDate($ControlData[11], $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
		If $ControlData[11] <> "" Then
			GUICtrlSetData($hControl, $ControlData[11])
		EndIf
	ElseIf $ControlData[2] = 10 Then
		$hControl = GUICtrlCreatePic($ControlData[11], $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
		If $ControlData[11] <> "" Then
			GUICtrlSetData($hControl, $ControlData[11])
		Else
			_ResourceSetImageToCtrl($hControl, "Grey", $RT_BITMAP)
		EndIf
	ElseIf $ControlData[2] = 11 Then
		$hControl = GUICtrlCreateIcon($ControlData[11], 0, $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
		If $ControlData[11] <> "" Then
			GUICtrlSetData($hControl, $ControlData[11])
		EndIf
	ElseIf $ControlData[2] = 12 Then
		$hControl = GUICtrlCreateProgress($ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
		If $ControlData[11] <> "0" Then
			GUICtrlSetData($hControl, $ControlData[11])
		EndIf
	ElseIf $ControlData[2] = 13 Then
		$hControl = GUICtrlCreateTab($ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6], $GUI_ONTOP)
		If $ControlData[11] <> "" And StringInStr($ControlData[11], "|") Then
			$hSplit = StringSplit($ControlData[11], "|")
			For $c = 1 To $hSplit[0] Step 1
				GUICtrlCreateTabItem($hSplit[$c])
			Next
			GUISetState()
		EndIf
	ElseIf $ControlData[2] = 14 Then
		$hControl = GUICtrlCreateUpdown($Controls[_NameToIndex($ControlData[11])])
		GUISetState()
	ElseIf $ControlData[2] = 15 Then ; To Be Implimented
		;$hControl = GUICtrlCreateLabel($ControlData[11], $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
		;GUISetState()
	ElseIf $ControlData[2] = 16 Then
		$hControl = GUICtrlCreateTreeView($ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
		If $ControlData[11] <> "" And StringInStr($ControlData[11], "|") Then
			$hSplit = StringSplit($ControlData[11], "|")
			For $c = 1 To $hSplit[0] Step 1
				GUICtrlCreateTreeViewItem($hSplit[$c], $hControl)
			Next
		EndIf
	ElseIf $ControlData[2] = 17 Then
		$hControl = GUICtrlCreateSlider($ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
		If $ControlData[11] <> "" Then
			GUICtrlSetData($hControl, $ControlData[11])
		EndIf
		If StringInStr($ControlData[9], "$TBS_VERT") Then
			GUICtrlSetStyle($hControl, $TBS_VERT)
		EndIf
		GUICtrlSetState($hControl, $GUI_DISABLE)
	ElseIf $ControlData[2] = 18 Then
		$hControl = GUICtrlCreateListView($ControlData[11], $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
	ElseIf $ControlData[2] = 19 Then
		$hControl = GUICtrlCreateGraphic($ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
		If $ControlData[11] <> "" Then
			_SetControlGraphic($hControl, $ControlData[11])
		Else
			GUICtrlSetColor(-1, 0x00)
		EndIf
	ElseIf $ControlData[2] = 20 Then
		$hControl = GUICtrlCreateDummy()
	ElseIf $ControlData[2] = 21 Then
		$hControl = GUICtrlCreateGroup($ControlData[11], $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
	ElseIf $ControlData[2] = 22 Then
		$hControl = GUICtrlCreateMonthCal($ControlData[11], $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
	ElseIf $ControlData[2] = 23 Then
		For $i = 1 to $GUIHandles[0] Step 1
			If $GUIHandles[$i] = $ControlData[23] Then
				If StringinStr($ControlData[11], "|") Then
					$hDataSplit = StringSplit($ControlData[11], "|")
					$hControl = _GUIScrollBars_Generate($GUIS[$i], $hDataSplit[1], $hDataSplit[2])
					$ControlData[7] = $hControl
					$hControl = "Scroll"&$i
				EndIf
			EndIf
		Next
	ElseIf $ControlData[2] = 24 Then
		$hControl = GUICtrlCreateEdit("", $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6])
	ElseIf $ControlData[2] = 25 Then
		$hControl = GUICtrlCreateEdit("", $ControlData[3], $ControlData[4], $ControlData[5], $ControlData[6], $ES_READONLY)
		GUICtrlSetState($hControl, $GUI_DISABLE)
	ElseIf $ControlData[2] = 26 Then
		$hControl = "GDI+"&$CurrentWindow
	EndIf
	GUICtrlSetCursor($hControl, 9)
	_ArrayAdd($Names, StringTrimLeft($ControlData[1], 1))
	_ArrayAdd($Types, $ControlData[2])
	_ArrayAdd($Colors, $ControlData[7])
	_ArrayAdd($BkColors, $ControlData[8])
	_ArrayAdd($Styles, $ControlData[9])
	_ArrayAdd($States, $ControlData[10])
	_ArrayAdd($Data, $ControlData[11])
	_ArrayAdd($Resize, $ControlData[12])
	_ArrayAdd($Controls, $hControl)
	_ArrayAdd($Font, $ControlData[13])
	_ArrayAdd($FontInfo, $ControlData[14])
	_ArrayAdd($FontSize, $ControlData[15])
	_ArrayAdd($Layers, $ControlData[16])
	_ArrayAdd($Attributes, $ControlData[17])
	_ArrayAdd($Images, $ControlData[18])
	_ArrayAdd($Functions, $ControlData[20])
	_ArrayAdd($Comments, $ControlData[21])
	If $ControlData[0] = 22 Then
		_ArrayAdd($Locked, $ControlData[22])
		$Locked[0] += 1
	Else
		_ArrayAdd($Locked, "0")
		$Locked[0] += 1
	EndIf
	$Comments[0] += 1
	$Functions[0] += 1
	If $ControlData[0] < 19 Then
		_ArrayAdd($Cursors, "2")
		$Cursors[0] += 1
	Else
		_ArrayAdd($Cursors, $ControlData[19])
		$Cursors[0] += 1
	EndIf
	_ArrayAdd($Parents, $ControlData[23])
	$Parents[0] += 1
	$Images[0] += 1
	$Attributes[0] += 1
	$Layers[0] += 1
	$Font[0] += 1
	$FontInfo[0] += 1
	$FontSize[0] += 1
	$Controls[0] += 1
	$Names[0] += 1
	$Types[0] += 1
	$Colors[0] += 1
	$BkColors[0] += 1
	$Styles[0] += 1
	$States[0] += 1
	$Data[0] += 1
	$Resize[0] += 1
	Dim $AttributeVal = ""
	$ControlNum += 1
	$aSplit = StringSplit($FontInfo[$ControlNum], "+")
	For $c = $aSplit[0] To 1 Step -1
		If $aSplit[$c] <> "" Then
			$AttributeVal += $aSplit[$c]
		EndIf
	Next
	If StringInStr($FontInfo[$ControlNum], "+0+") Then
		If $Font[$ControlNum] <> $DefaultFont Then
			GUICtrlSetFont($Controls[$ControlNum], $FontSize[$ControlNum], 800, $AttributeVal, $Font[$ControlNum])
		Else
			GUICtrlSetFont($Controls[$ControlNum], $FontSize[$ControlNum], 800, $AttributeVal)
		EndIf
	Else
		If $Font[$ControlNum] <> $DefaultFont Then
			If $AttributeVal = "" Then
				GUICtrlSetFont($Controls[$ControlNum], $FontSize[$ControlNum], 400, 0, $Font[$ControlNum])
			Else
				GUICtrlSetFont($Controls[$ControlNum], $FontSize[$ControlNum], 400, $AttributeVal, $Font[$ControlNum])
			EndIf
		Else
			If $AttributeVal <> "" Then
				GUICtrlSetFont($Controls[$ControlNum], $FontSize[$ControlNum], 400, $AttributeVal)
			Else
				If $FontSize[$ControlNum] <> "8.5" Then
					GUICtrlSetFont($Controls[$ControlNum], $FontSize[$ControlNum])
				EndIf
			EndIf
		EndIf
	EndIf
	If $BkColors[$ControlNum] = "Trans" Then
		GUICtrlSetBkColor($hControl, $GUI_BKCOLOR_TRANSPARENT)
	Else
		If $BkColors[$ControlNum] <> "" And StringLen($BkColors[$ControlNum]) = 6 Then
			GUICtrlSetBkColor($hControl, "0x" & $BkColors[$ControlNum])
		EndIf
	EndIf
	If StringinStr($Styles[$ControlNum], "$BS_ICON") Then
		GUICtrlSetStyle($Controls[$ControlNum], $BS_ICON)
	ElseIf StringinStr($Styles[$ControlNum], "$BS_BITMAP") Then
		GUICtrlSetStyle($Controls[$ControlNum], $BS_BITMAP)
	EndIf
	If $Images[$ControlNum] <> "" Then
		GUICtrlSetImage($hControl, $Images[$ControlNum])
	EndIf
	If $Colors[$ControlNum] <> "" Then
		GUICtrlSetColor($hControl, "0x" & $Colors[$ControlNum])
	EndIf
	If $Resize[$ControlNum] <> "" Then
		Dim $ResizeValue = ""
		$aSplit = StringSplit($Resize[$ControlNum], "+")
		For $c = $aSplit[0] To 1 Step -1
			If $aSplit[$c] <> "" Then
				If $c = 2 Then
					$ResizeValue &= $aSplit[$c]
				Else
					$ResizeValue &= $aSplit[$c] & "+"
				EndIf
			EndIf
		Next
		GUICtrlSetResizing($Controls[$ControlNum], Execute($ResizeValue))
	Else
		GUICtrlSetResizing($hControl, 802)
	EndIf
	$RefNum = $ControlNum
	For $i = 1 To $ResizeTabs[0] Step 1
		If $Locked[$i] = "1" Then
			$rSplit = StringSplit($ResizeTabs[$i], "|")
			For $b = 2 To $rSplit[0] Step 1
				GUICtrlSetBkColor($rSplit[$b], 0xE7C200)
			Next
		EndIf
	Next
	GUICtrlSetState($hControl, $GUI_SHOW)
	_CreateResizeTabs($hControl)
	Return $ControlNum
EndFunc   ;==>_CreateControl
Func _ClearData()
	_DeselectControls()
	_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($LayerList))
	For $i = 1 To $Controls[0] Step 1
		_DeleteResizeTabs($Controls[$i])
	Next
	Dim $ChildCount = 0
	Dim $Controls[1] = [0], $Colors[1] = [0], $BkColors[1] = [0], $Names[1] = [0], $Types[1] = [0], $Data[1] = [0], $Cursors[1] = [0]
	Dim $Resize[1] = [0], $Font[1] = [0], $FontInfo[1] = [0], $FontSize[1] = [0], $Attributes[1] = [0], $Layers[1] = [0]
	Dim $Images[1] = [0], $Comments[1] = [0], $ResizeTabs[1] = [0], $Locked[1] = [0], $Styles[1] = [0], $Functions[1] = [0], $Parents[1] = [0]
	$SelectedTool = 0
	$SelectedControl = 0
EndFunc   ;==>_ClearData
Func _ClearGUIData()
	For $i = $GUIs[0] To 1 Step -1
		GUIDelete($GUIs[$i])
	Next
	Dim $GUIColors[1] = [0]
	Dim $TreeItems[1] = [0]
	Dim $GUIHandles[1] = [0]
	Dim $WinTitles[1] = [0]
	Dim $Attributes[1] = [0]
	Dim $GUIVars[1] = [0]
	Dim $GUISetStateData[1] = [0]
	Dim $GUIScript[1] = [0]
	Dim $GUIComment[1] = [0]
	Dim $GUIStyle[1] = [0]
	Dim $GUIMenus[1] = [0]
	Dim $GUIProperties[1] = [0]
	Dim $GUIX[1] = [0]
	Dim $GUIY[1] = [0]
	Dim $ExtraIncludeData = ""
	Dim $WhileData = "1"
	Dim $GUIParent[1] = [0]
EndFunc   ;==>_ClearGUIData
Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam) ; Notify TreeView Events
	#forceref $hWnd, $iMsg, $iwParam
	Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndTreeview
	$hWndTreeview = $hTree
	$hWndTab = $GUITab
	If Not IsHWnd($hTree) Then $hWndTreeview = GUICtrlGetHandle($hTree)
	If Not IsHWnd($GUITab) Then $hWndTab = GUICtrlGetHandle($GUITab)
	$tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
	$hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
	$iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
	$iCode = DllStructGetData($tNMHDR, "Code")
	Switch $hWndFrom
		Case $hWndTreeview
			Switch $iCode
				Case $TVN_SELCHANGEDA, $TVN_SELCHANGEDW
					For $i = 1 To $GUITrees[0] Step 1
						If _GUICtrlTreeView_GetSelection($hTree) = $GUITrees[$i] Then
							_HideAllResizeTabs()
							_ClearControlData()
							Dim $MultiControls[1] = [0], $MultiSelect = False, $SelectedControl = 0
							If BitAND(GUICtrlGetState($HandleInput), $GUI_DISABLE) <> 0 Then
								GUICtrlSetState($HandleInput, $GUI_ENABLE)
								GUICtrlSetState($XPosInput, $GUI_ENABLE)
								GUICtrlSetState($YPosInput, $GUI_ENABLE)
								GUICtrlSetState($WInput, $GUI_ENABLE)
								GUICtrlSetState($HInput, $GUI_ENABLE)
								GUICtrlSetState($BkColorInput, $GUI_ENABLE)
								GUICtrlSetState($StyleInput, $GUI_ENABLE)
								GUICtrlSetState($DataInput, $GUI_ENABLE)
								GUICtrlSetState($CursorInput, $GUI_ENABLE)
							EndIf
							GUICtrlSetData($HandleInput, $GUIHandles[$i])
							GUICtrlSetData($XPosInput, $GUIX[$i])
							GUICtrlSetData($YPosInput, $GUIY[$i])
							$WinPos = WinGetClientSize($GUIs[$i])
							If Not @error Then
								GUICtrlSetData($WInput, $WinPos[0])
								GUICtrlSetData($HInput, $WinPos[1])
							Else
								GUICtrlSetData($WInput, 500)
								GUICtrlSetData($HInput, 400)
							EndIf
							GUICtrlSetData($BkColorInput, $GUIColors[$i])
							If $GUIColors[$i] = "" Then
								GUICtrlSetBkColor($BkColorEx, "0xF0F0F0")
							Else
								GUICtrlSetBkColor($BkColorEx, "0x"&$GUIColors[$i])
							EndIf
							GUICtrlSetData($DataInput, $WinTitles[$i])
							GUICtrlSetData($StyleInput, $GUIStyle[$i])
							$GUISelected = True
							$GUIFocusIndex = $i
							$CurrentWindow = $i
							_GUICtrlTreeView_SetSelected($hTree, $GUITrees[$i], True)
							GUISetState()
							ExitLoop
						Else
							$GUISelected = False
							$GUIFocusIndex = 0
						EndIf
					Next
					If $GUISelected = False Then
						If $AddingControl = False Then
							$GUIFocusIndex = 0
							For $i = 1 To $Controls[0] Step 1
								If $TreeItems[0] >= $i Then
									If _GUICtrlTreeView_GetSelection($hTree) = $TreeItems[$i] Then
										If $Types[$i] <> 14 Then
											If _IsPressed("11") Then
												If StringInStr($Attributes[$i], "ø") Then
													$hTabSplit = StringSplit($Attributes[$i], "ø")
													$hTabIndex = _NameToIndex($hTabSplit[1])
													$hCurIndex = _GUICtrlTab_GetCurSel($Controls[$hTabIndex]) + 1
													If $hTabSplit[2] <> $hCurIndex Then
														_GUICtrlTab_ActivateTab($Controls[$hTabIndex], $hTabSplit[2] - 1)
													EndIf
												EndIf
												If $MultiSelect = True And $SelectedControl = 0 Then ; Multi Controls Selected
													_MoveResizeTabs($Controls[$i])
													_ShowResizeTabs($Controls[$i])
													_ArrayAdd($MultiControls, $Controls[$i])
													$MultiControls[0] += 1
												EndIf
												If $SelectedControl <> 0 And $MultiSelect = False Then ; One Control Selected
													_MoveResizeTabs($Controls[$i])
													_ShowResizeTabs($Controls[$i])
													_ClearControlData()
													_ArrayAdd($MultiControls, $SelectedControl)
													_ArrayAdd($MultiControls, $Controls[$i])
													$MultiControls[0] += 2
													$SelectedControl = 0
													$MultiSelect = True
												EndIf
												If $SelectedControl = 0 And $MultiSelect = False Then ; No Controls Selected
													_MoveResizeTabs($Controls[$i])
													_ShowResizeTabs($Controls[$i])
													_SetControlData($Controls[$i])
													$SelectedControl = $Controls[$i]
												EndIf
											Else
												If StringInStr($Attributes[$i], "ø") Then
													$hTabSplit = StringSplit($Attributes[$i], "ø")
													$hTabIndex = _NameToIndex($hTabSplit[1])
													$hCurIndex = _GUICtrlTab_GetCurSel($Controls[$hTabIndex]) + 1
													If $hTabSplit[2] <> $hCurIndex Then
														_GUICtrlTab_ActivateTab($Controls[$hTabIndex], $hTabSplit[2] - 1)
													EndIf
												EndIf
												If $MultiSelect = True And $SelectedControl = 0 Then ; Multi Controls Selected
													For $b = 1 To $MultiControls[0] Step 1
														_HideResizeTabs($MultiControls[$b])
													Next
													$MultiSelect = False
													Dim $MultiControls[1] = [0]
													_MoveResizeTabs($Controls[$i])
													_ShowResizeTabs($Controls[$i])
													_SetControlData($Controls[$i])
													$SelectedControl = $Controls[$i]
												EndIf
												If $SelectedControl <> 0 And $MultiSelect = False Then ; One Control Selected
													If $SelectedControl <> $Controls[$i] Then
														_HideResizeTabs($SelectedControl)
														_MoveResizeTabs($Controls[$i])
														_ShowResizeTabs($Controls[$i])
														_SetControlData($Controls[$i])
														$SelectedControl = $Controls[$i]
													EndIf
												EndIf
												If $SelectedControl = 0 And $MultiSelect = False Then ; No Controls Selected
													_MoveResizeTabs($Controls[$i])
													_ShowResizeTabs($Controls[$i])
													_SetControlData($Controls[$i])
													$SelectedControl = $Controls[$i]
												EndIf
											EndIf
										EndIf
									EndIf
								EndIf
							Next
						EndIf
					EndIf
			EndSwitch
		Case $hWndTab
			Switch $iCode
				Case $NM_CLICK ; The user has clicked the left mouse button within the control
					$CurrentTab = _GUICtrlTab_GetCurSel($GUITab)
					If $CurrentWindow - 1 <> $CurrentTab Then
						_SaveScript(@ScriptDir & "\Temp_" & $CurrentWindow & ".tmp")
						GUIDelete($GUIs[$CurrentWindow])
						$CurrentWindow = $CurrentTab + 1

						Sleep(100)
						If FileExists(@ScriptDir & "\Temp_" & $CurrentWindow & ".tmp") Then
							_OpenScript(@ScriptDir & "\Temp_" & $CurrentWindow & ".tmp", 5)
						EndIf
					EndIf
			EndSwitch
	EndSwitch
	Return $GUI_RUNDEFMSG
EndFunc   ;==>WM_NOTIFY
Func _ArrayClear(ByRef $aArray)
	Local $iCols = UBound($aArray, 2)
	Local $iDim = UBound($aArray, 0)
	Local $iRows = UBound($aArray, 1)
	If $iDim = 1 Then
		Local $aArray1D[$iRows]
		$aArray = $aArray1D
	Else
		Local $aArray2D[$iRows][$iCols]
		$aArray = $aArray2D
	EndIf
EndFunc   ;==>_ArrayClear
Func WM_GETMINFINFO($hWnd, $Msg, $wParam, $lParam)
	If $hWnd = $hGUI Then
		$tagMaxinfo = DllStructCreate("int;int;int;int;int;int;int;int;int;int", $lParam)
		DllStructSetData($tagMaxinfo, 7, $GUIMINWID) ; min X
		DllStructSetData($tagMaxinfo, 8, $GUIMINHT) ; min Y
	EndIf
	Return 0
EndFunc   ;==>WM_GETMINFINFO
Func _MenuMode()
	Local $MenuItems[1] = [0], $MenuX = 1, $MenuRight[1] = [0], $MenuLeft[1] = [0], $MenuMiddle[1] = [0], $MenuHover = 0, $MenuSelect = 0, $TitleInputs[1] = [0], $MenuTitles[1] = [0], $MenuState[1] = [0], $AddingTitle = False
	Local $MenuData[1] = [0], $MenuInputs[1] = [0], $MenuLabels[1] = [0], $ControlGroups[1] = [0], $MenuItemCounts[1] = [0]
	Local $MenuBack, $MenuFront, $AddSubItem = 1, $DisplayMenu = True
	$hMenuGUI = GUICreate("Menu Builder", 689, 350, -1, -1)
	$Picture1 = GUICtrlCreatePic("", 0, 0, 690, 19)
	$hContext = GUICtrlCreateContextMenu($Picture1)
	$hNewMenu = GUICtrlCreateMenuItem("New Menu Item", $hContext)
	$MenuBack = GUICtrlCreateLabel("", 1, 19, 170, 30)
	GUICtrlSetBkColor(-1, 0x979797)
	GUICtrlSetState(-1, BitOR($GUI_DISABLE, $GUI_HIDE))
	$MenuFront = GUICtrlCreateLabel("", 0, 20, 168, 28)
	GUICtrlSetBkColor(-1, 0xF1F1F1)
	GUICtrlSetState(-1, BitOR($GUI_DISABLE, $GUI_HIDE))
	$MenuLine1 = GUICtrlCreateLabel("", 28, 22, 1, 1)
	GUICtrlSetBkColor(-1, 0xE2E3E3)
	GUICtrlSetState(-1, $GUI_HIDE)
	$MenuLine2 = GUICtrlCreateLabel("", 29, 22, 1, 1)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUICtrlSetState(-1, $GUI_HIDE)
	$SubItemBtn = GUICtrlCreateButton("Add Sub Item", -500, -500, 158, 22)
	GUICtrlSetState(-1, $GUI_HIDE)
	$SaveMenuBtn = GUICtrlCreateButton("Save", 559, 320, 120, 24)
	$CancelMenuBtn = GUICtrlCreateButton("Cancel", 429, 320, 120, 24)
	GUISetState()

	_ResourceSetImageToCtrl($Picture1, "MenuGradient", $RT_BITMAP)

	While $DisplayMenu = True
		$hCursor = GUIGetCursorInfo($hMenuGUI)
		$MenuHover = 0
		For $i = 1 To $MenuItems[0] Step 1
			$hItemPos = ControlGetPos("", "", $MenuItems[$i])
			If Not @error Then
				If $hCursor[0] > $hItemPos[0] And $hCursor[1] > $hItemPos[1] And $hCursor[0] < $hItemPos[0] + $hItemPos[2] And $hCursor[1] < $hItemPos[1] + $hItemPos[3] Then
					If $MenuState[$i] = "0" Then
						$MenuState[$i] = "1"
						GUICtrlSetState($MenuRight[$i], $GUI_SHOW)
						GUICtrlSetState($MenuMiddle[$i], $GUI_SHOW)
						GUICtrlSetState($MenuLeft[$i], $GUI_SHOW)
					EndIf
					$MenuHover = $i
				Else
					If $MenuState[$i] = "1" Then
						$MenuState[$i] = "0"
						GUICtrlSetState($MenuRight[$i], $GUI_HIDE)
						GUICtrlSetState($MenuMiddle[$i], $GUI_HIDE)
						GUICtrlSetState($MenuLeft[$i], $GUI_HIDE)
					EndIf
				EndIf
			EndIf
		Next
		If _IsPressed("01") Then
			If $MenuHover <> 0 Then
				If $MenuHover <> $MenuSelect Then
					$hControlSplit = StringSplit($ControlGroups[$MenuSelect], "|")
					For $i = 1 To $hControlSplit[0] Step 1
						If $hControlSplit[$i] <> "" Then
							$hState = GUICtrlGetState($hControlSplit[$i])
							If $hState = 80 Then
								GUICtrlSetState($hControlSplit[$i], $GUI_HIDE)
							EndIf
						EndIf
					Next
					$MenuSelect = $MenuHover
					$hDataSplit = StringSplit($MenuData[$MenuSelect], "|")
					$hMenuPos = ControlGetPos("", "", $MenuItems[$MenuHover])
					If $MenuItemCounts[$MenuSelect] = "0" Then
						GUICtrlSetPos($MenuBack, $hMenuPos[0] - 1, 19, 170, 30)
						GUICtrlSetPos($MenuFront, $hMenuPos[0], 20, 168, 28)
						GUICtrlSetPos($MenuLine1, $hMenuPos[0] + 28, 22, 1, 1)
						GUICtrlSetPos($MenuLine2, $hMenuPos[0] + 29, 22, 1, 1)
						GUICtrlSetPos($SubItemBtn, $hMenuPos[0] + 5, 23, 158, 22)
					Else
						GUICtrlSetPos($MenuBack, $hMenuPos[0] - 1, 19, 170, 30 + (25 * $MenuItemCounts[$MenuSelect]))
						GUICtrlSetPos($MenuFront, $hMenuPos[0], 20, 168, 28 + (25 * $MenuItemCounts[$MenuSelect]))
						GUICtrlSetPos($MenuLine1, $hMenuPos[0] + 28, 22, 1, 1 + (25 * $MenuItemCounts[$MenuSelect]))
						GUICtrlSetPos($MenuLine2, $hMenuPos[0] + 29, 22, 1, 1 + (25 * $MenuItemCounts[$MenuSelect]))
						GUICtrlSetPos($SubItemBtn, $hMenuPos[0] + 5, 23 + (25 * $MenuItemCounts[$MenuSelect]), 158, 22)
					EndIf
					GUICtrlSetState($MenuBack, $GUI_SHOW)
					GUICtrlSetState($MenuFront, $GUI_SHOW)
					GUICtrlSetState($MenuLine1, $GUI_SHOW)
					GUICtrlSetState($MenuLine2, $GUI_SHOW)
					GUICtrlSetState($SubItemBtn, $GUI_SHOW)
					$hControlSplit = StringSplit($ControlGroups[$MenuSelect], "|")
					For $i = 1 To $hControlSplit[0] Step 1
						If $hControlSplit[$i] <> "" Then
							$hState = GUICtrlGetState($hControlSplit[$i])
							If $hState = 96 Then
								GUICtrlSetState($hControlSplit[$i], $GUI_SHOW)
							EndIf
						EndIf
					Next
				EndIf
			EndIf
			Sleep(50)
		EndIf
		If _IsPressed("0D") Then
			$hMsg = GUIGetMsg()
			If $AddingTitle = True Then
				For $i = 1 To $TitleInputs[0] Step 1
					If $hMsg = $TitleInputs[$i] Then
						$hLeft = GUICtrlCreatePic("", $MenuX, 1, 3, 18)
						GUICtrlSetState(-1, $GUI_HIDE)
						$hMiddle = GUICtrlCreatePic("", $MenuX + 3, 1, 56, 18)
						GUICtrlSetState(-1, $GUI_HIDE)
						$hRight = GUICtrlCreatePic("", $MenuX + 59, 1, 3, 18)
						GUICtrlSetState(-1, $GUI_HIDE)
						$hMenuItem = GUICtrlCreateLabel(GUICtrlRead($TitleInputs[$i]), $MenuX, 3, 60, 18)
						GUICtrlSetBkColor($hMenuItem, $GUI_BKCOLOR_TRANSPARENT)
						GUICtrlSetStyle($hMenuItem, BitOR($GUI_ONTOP, 0x01))
						GUISetState()
						_ResourceSetImageToCtrl($hLeft, "Menu_Left", $RT_BITMAP)
						_ResourceSetImageToCtrl($hMiddle, "Menu_Middle", $RT_BITMAP)
						_ResourceSetImageToCtrl($hRight, "Menu_Right", $RT_BITMAP)
						_ArrayAdd($MenuTitles, GUICtrlRead($TitleInputs[$i]))
						_ArrayAdd($MenuItemCounts, "0")
						_ArrayAdd($MenuRight, $hRight)
						_ArrayAdd($MenuMiddle, $hMiddle)
						_ArrayAdd($MenuLeft, $hLeft)
						_ArrayAdd($MenuItems, $hMenuItem)
						_ArrayAdd($MenuData, "")
						_ArrayAdd($ControlGroups, "")
						_ArrayAdd($MenuState, "0")
						$MenuState[0] += 1
						$MenuTitles[0] += 1
						$MenuItemCounts[0] += 1
						$ControlGroups[0] += 1
						$MenuData[0] += 1
						$MenuItems[0] += 1
						$MenuRight[0] += 1
						$MenuMiddle[0] += 1
						$MenuLeft[0] += 1
						$MenuX += 64
						GUICtrlSetState($Picture1, $GUI_ENABLE)
						GUICtrlDelete($TitleInputs[$i])
						$AddingTitle = False
						ExitLoop
					EndIf
				Next
			Else
				For $i = 1 To $MenuInputs[0] Step 1
					If $hMsg = $MenuInputs[$i] Then
						$MenuPos = ControlGetPos("", "", $MenuInputs[$i])
						If Not @error Then
							If GUICtrlRead($MenuInputs[$i]) <> "" Then
								$hMenuLabel = GUICtrlCreateLabel(GUICtrlRead($MenuInputs[$i]), $MenuPos[0] + 3, $MenuPos[1] + 3, $MenuPos[2], $MenuPos[3])
								GUICtrlDelete($MenuInputs[$i])
								GUISetState()
								$ControlGroups[$MenuSelect] &= $hMenuLabel & "|"
							Else
								$hMenuLabel = GUICtrlCreateLabel("", $MenuPos[0] - 5, $MenuPos[1] + 7, $MenuPos[2] + 16, 1)
								GUICtrlSetBkColor(-1, 0xE2E3E3)
								$hMenuLabel2 = GUICtrlCreateLabel("", $MenuPos[0] - 5, $MenuPos[1] + 8, $MenuPos[2] + 16, 1)
								GUICtrlSetBkColor(-1, 0xFFFFFF)
								GUICtrlDelete($MenuInputs[$i])
								GUISetState()
								$ControlGroups[$MenuSelect] &= $hMenuLabel & "|" & $hMenuLabel2 & "|"
							EndIf
							_ArrayAdd($MenuLabels, $hMenuLabel)
							$MenuLabels[0] += 1
						EndIf
						Dim $hMenuData = ""
						$hControlSplit = StringSplit($ControlGroups[$MenuSelect], "|")
						For $i = 1 To $MenuLabels[0] Step 1
							If _ArraySearch($hControlSplit, $MenuLabels[$i], 1, $hControlSplit[0]) <> -1 Then
								If $i <> $MenuLabels[0] Then
									$hMenuData &= GUICtrlRead($MenuLabels[$i]) & "|"
								Else
									$hMenuData &= GUICtrlRead($MenuLabels[$i])
								EndIf
							EndIf
						Next
						$MenuData[$MenuSelect] = $hMenuData
					EndIf
				Next
			EndIf
			Sleep(500)
		EndIf
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hMenuGUI)
				$DisplayMenu = False
			Case $SaveMenuBtn
				$hMenuOutput = ""
				For $i = 1 To $MenuData[0] Step 1
					$hMenuOutput &= $MenuTitles[$i] & "*_%" & $MenuData[$i] & "[`;]"
				Next
				GUIDelete($hMenuGUI)
				$DisplayMenu = False
				_SetMenuData($hMenuOutput)
				$GUIMenus[$CurrentWindow] = $hMenuOutput
				_GUICtrlTreeView_BeginUpdate($hTree)
				$hMenuTree = _GUICtrlTreeView_AddChild($hTree, $GUITrees[$CurrentWindow], "hMenu")
				_GUICtrlTreeView_SetIcon($hTree, $hMenuTree, @ScriptDir & "\Resources.dll", -126)
				_GUICtrlTreeView_EndUpdate($hTree)
				_SetScriptData()
			Case $SubItemBtn
				$hMenuPos = ControlGetPos("", "", $MenuBack)
				$hLinePos = ControlGetPos("", "", $MenuLine1)
				GUICtrlSetPos($MenuBack, $hMenuPos[0], $hMenuPos[1], $hMenuPos[2], $hMenuPos[3] + 25)
				GUICtrlSetPos($MenuFront, $hMenuPos[0] + 1, $hMenuPos[1] + 1, $hMenuPos[2] - 2, $hMenuPos[3] + 23)
				GUICtrlSetPos($SubItemBtn, $hMenuPos[0] + 5, $hMenuPos[3] + 19, 158, 22)
				$hMenuInput = GUICtrlCreateInput("New Item", $hMenuPos[0] + 36, $hMenuPos[3] - 5, 120, 20, 0x0001)
				GUICtrlSetStyle(-1, $ES_LEFT)
				GUICtrlSetPos($MenuLine1, $hLinePos[0], $hLinePos[1], $hLinePos[2], $hLinePos[3] + 28)
				GUICtrlSetPos($MenuLine2, $hLinePos[0] + 1, $hLinePos[1], $hLinePos[2], $hLinePos[3] + 28)
				GUISetState()
				_ArrayAdd($MenuInputs, $hMenuInput)
				$MenuInputs[0] += 1
				$ControlGroups[$MenuSelect] &= $hMenuInput & "|"
				$MenuItemCounts[$MenuSelect] += 1
			Case $hNewMenu
				$AddingTitle = True
				$NewInput = GUICtrlCreateInput("New", $MenuX, 1, 60, 17, $BS_DEFPUSHBUTTON)
				GUISetState()
				_ArrayAdd($TitleInputs, $NewInput)
				$TitleInputs[0] += 1
				GUICtrlSetState($Picture1, $GUI_DISABLE)
		EndSwitch
	WEnd
EndFunc   ;==>_MenuMode
Func _GraphicMode() ; Builds graphics
	GUISwitch($GUIHolder)
	$Dot_1 = GUICtrlCreatePic("", -5, -5, 5, 5)
	$Dot_2 = GUICtrlCreatePic("", -5, -5, 5, 5)
	$Dot_3 = GUICtrlCreatePic("", -5, -5, 5, 5)
	$GraphicX = 150
	$GraphicY = 45
	$SelectedGraphic = 0
	$GraphicData = ""
	$CurrentColor = "000000"
	$CurrentBkColor = ''
	$GraphicStarted = True
	$hInfo = ControlGetPos("", "", $SelectedControl)
	Dim $GraphicX, $GraphicY
	Dim $GraphicTrees[1] = [0]
	Dim $GraphicCtrls[1] = [0]
	Dim $GraphicItems[1] = [0]
	Local $hBackground
	$hBackground = GUICtrlCreateGraphic($GraphicX, $GraphicY, $hInfo[2], $hInfo[3])
	GUICtrlSetBkColor(-1, 0xF0F0F0)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetPos($hTopBoarder, $GraphicX - 1, $GraphicY - 1, $hInfo[2] + 2, 1)
	GUICtrlSetPos($hBottomBoarder, $GraphicX - 1, $GraphicY + 1 + $hInfo[3], $hInfo[2] + 2, 1)
	GUICtrlSetPos($hLeftBoarder, $GraphicX - 1, $GraphicY - 1, 1, $hInfo[3] + 2)
	GUICtrlSetPos($hRightBoarder, $GraphicX + $hInfo[2], $GraphicY - 1, 1, $hInfo[3] + 2)
	GUICtrlSetState($hTopBoarder, $GUI_SHOW)
	GUICtrlSetState($hBottomBoarder, $GUI_SHOW)
	GUICtrlSetState($hLeftBoarder, $GUI_SHOW)
	GUICtrlSetState($hRightBoarder, $GUI_SHOW)
	GUISetState()
	_ResourceSetImageToCtrl($Dot_1, "Dot", $RT_BITMAP)
	_ResourceSetImageToCtrl($Dot_2, "Dot", $RT_BITMAP)
	_ResourceSetImageToCtrl($Dot_3, "Dot", $RT_BITMAP)
	$RefNum = _GetIndex($SelectedControl)
	If StringInStr($Data[$RefNum], ":") Then
		$ControlSplit = StringSplit($Data[$RefNum], ":")
		_GUICtrlTreeView_BeginUpdate($hTree)
		For $i = 2 To $ControlSplit[0] Step 1
			$DataSplit = StringSplit($ControlSplit[$i], ",")
			$hGraphic = GUICtrlCreateGraphic($GraphicX, $GraphicY, $hInfo[2], $hInfo[3])
			Switch $DataSplit[1]
				Case "D" ; Dot
					GUICtrlSetGraphic($hGraphic, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					If $DataSplit[5] <> "" Then
						GUICtrlSetGraphic($hGraphic, $GUI_GR_COLOR, "0x" & $DataSplit[4], "0x" & $DataSplit[5])
					Else
						GUICtrlSetGraphic($hGraphic, $GUI_GR_COLOR, "0x" & $DataSplit[4])
					EndIf
					GUICtrlSetGraphic($hGraphic, $GUI_GR_DOT, $DataSplit[2], $DataSplit[3])
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$RefNum], "Dot " & $GraphicItems[0])
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -280)
					_ArrayAdd($GraphicTrees, $hItem)
					$GraphicTrees[0] += 1
				Case "P" ; Pixel
					GUICtrlSetGraphic($hGraphic, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					If $DataSplit[5] <> "" Then
						GUICtrlSetGraphic($hGraphic, $GUI_GR_COLOR, "0x" & $DataSplit[4], "0x" & $DataSplit[5])
					Else
						GUICtrlSetGraphic($hGraphic, $GUI_GR_COLOR, "0x" & $DataSplit[4])
					EndIf
					GUICtrlSetGraphic($hGraphic, $GUI_GR_PIXEL, $DataSplit[2], $DataSplit[3])
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$RefNum], "Pixel " & $GraphicItems[0])
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -281)
					_ArrayAdd($GraphicTrees, $hItem)
					$GraphicTrees[0] += 1
				Case "L" ; Line
					GUICtrlSetGraphic($hGraphic, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					If $DataSplit[7] <> "" Then
						GUICtrlSetGraphic($hGraphic, $GUI_GR_COLOR, "0x" & $DataSplit[6], "0x" & $DataSplit[7])
					Else
						GUICtrlSetGraphic($hGraphic, $GUI_GR_COLOR, "0x" & $DataSplit[6])
					EndIf
					GUICtrlSetGraphic($hGraphic, $GUI_GR_LINE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($hGraphic, $GUI_GR_LINE, $DataSplit[4], $DataSplit[5])
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$RefNum], "Line " & $GraphicItems[0])
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -282)
					_ArrayAdd($GraphicTrees, $hItem)
					$GraphicTrees[0] += 1
				Case "R" ; Rect
					GUICtrlSetGraphic($hGraphic, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					If $DataSplit[7] <> "" Then
						GUICtrlSetGraphic($hGraphic, $GUI_GR_COLOR, "0x" & $DataSplit[6], "0x" & $DataSplit[7])
					Else
						GUICtrlSetGraphic($hGraphic, $GUI_GR_COLOR, "0x" & $DataSplit[6])
					EndIf
					GUICtrlSetGraphic($hGraphic, $GUI_GR_RECT, $DataSplit[2], $DataSplit[3], $DataSplit[4] - $DataSplit[2], $DataSplit[5] - $DataSplit[3])
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$RefNum], "Rect " & $GraphicItems[0])
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -283)
					_ArrayAdd($GraphicTrees, $hItem)
					$GraphicTrees[0] += 1
				Case "E" ; Ellipse
					GUICtrlSetGraphic($hGraphic, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					If $DataSplit[7] <> "" Then
						GUICtrlSetGraphic($hGraphic, $GUI_GR_COLOR, "0x" & $DataSplit[6], "0x" & $DataSplit[7])
					Else
						GUICtrlSetGraphic($hGraphic, $GUI_GR_COLOR, "0x" & $DataSplit[6])
					EndIf
					GUICtrlSetGraphic($hGraphic, $GUI_GR_ELLIPSE, $DataSplit[2], $DataSplit[3], $DataSplit[4] - $DataSplit[2], $DataSplit[5] - $DataSplit[3])
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$RefNum], "Ellipse " & $GraphicItems[0])
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -284)
					_ArrayAdd($GraphicTrees, $hItem)
					$GraphicTrees[0] += 1
				Case "B"
					GUICtrlSetGraphic($hGraphic, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					If $DataSplit[9] <> "" Then
						GUICtrlSetGraphic($hGraphic, $GUI_GR_COLOR, "0x" & $DataSplit[8], "0x" & $DataSplit[9])
					Else
						GUICtrlSetGraphic($hGraphic, $GUI_GR_COLOR, "0x" & $DataSplit[8])
					EndIf
					GUICtrlSetGraphic($hGraphic, $GUI_GR_BEZIER, $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5], $DataSplit[6], $DataSplit[7])
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$RefNum], "Bezier " & $GraphicItems[0])
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -285)
					_ArrayAdd($GraphicTrees, $hItem)
					$GraphicTrees[0] += 1
				Case "i"
					GUICtrlSetGraphic($hGraphic, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					If $DataSplit[8] <> "" Then
						GUICtrlSetGraphic($hGraphic, $GUI_GR_COLOR, "0x" & $DataSplit[7], "0x" & $DataSplit[8])
					Else
						GUICtrlSetGraphic($hGraphic, $GUI_GR_COLOR, "0x" & $DataSplit[7])
					EndIf
					GUICtrlSetGraphic($hGraphic, $GUI_GR_PIE, $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5], $DataSplit[6])
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$RefNum], "Pie " & $GraphicItems[0])
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -286)
					_ArrayAdd($GraphicTrees, $hItem)
					$GraphicTrees[0] += 1
			EndSwitch
			GUICtrlSetResizing($hGraphic, 802)
			GUICtrlSetState($hGraphic, $GUI_ONTOP)
			_ArrayAdd($GraphicCtrls, $hGraphic)
			$GraphicCtrls[0] += 1
			_ArrayAdd($GraphicItems, $hGraphic & "," & $ControlSplit[$i])
			$GraphicItems[0] += 1
		Next
		_GUICtrlTreeView_EndUpdate($hTree)
		GUISetState()
		$GraphicData = $Data[$RefNum]
		_WinAPI_RedrawWindow($GUIHolder)
	EndIf
	_GUICtrlTreeView_Expand($hTree, $TreeItems[$RefNum], True)
	$hIndex = _GetIndex($SelectedControl)
	$InsideIndex = 0
	Dim $CurrentItem = -1
	Dim $SelectedGraphic = 0
	Dim $SelectedColor, $SelectedBkColor
	While $GraphicStarted = True
		$Mouse = 2
		Dim $Selected = False
		Dim $gSplit
		For $i = 1 To $GraphicTrees[0] Step 1
			If _GUICtrlTreeView_GetSelection($hTree) = $GraphicTrees[$i] Then
				$Selected = True
				$gSplit = StringSplit($GraphicItems[$i], ",")
				$hMouse = GUIGetCursorInfo($GUIHolder)
				If $gSplit[2] = "R" Or $gSplit[2] = "E" Or $gSplit[2] = "L" Or $gSplit[2] = "B" Or $gSplit[2] = "i" Then
					If $CurrentItem <> $i Then
						$CurrentItem = $i
						If $gSplit[2] = "R" Or $gSplit[2] = "E" Or $gSplit[2] = "L" Then
							GUICtrlSetData($hParamLbl1, "1X:")
							GUICtrlSetData($hParamLbl2, "1Y:")
							GUICtrlSetData($hParamLbl3, "2X:")
							GUICtrlSetData($hParamLbl4, "2Y:")
							GUICtrlSetData($hParamLbl5, "( Param 5 )")
							GUICtrlSetData($hParamLbl6, "( Param 6 )")
							GUICtrlSetData($hParamInput1, $gSplit[3])
							GUICtrlSetData($hParamInput2, $gSplit[4])
							GUICtrlSetData($hParamInput3, $gSplit[5])
							GUICtrlSetData($hParamInput4, $gSplit[6])
							GUICtrlSetData($hParamInput5, "")
							GUICtrlSetData($hParamInput6, "")
							GUICtrlSetData($hParamInput7, $gSplit[7])
							GUICtrlSetData($hParamInput8, $gSplit[8])
							GUICtrlSetBkColor($hParamColor, "0x" & $gSplit[7])
							GUICtrlSetBkColor($hParamBkColor, "0x" & $gSplit[8])
							GUICtrlSetPos($Dot_1, $GraphicX + $gSplit[3] - 2, $GraphicY + $gSplit[4] - 2, 5, 5)
							GUICtrlSetPos($Dot_2, $GraphicX + $gSplit[5] - 2, $GraphicY + $gSplit[6] - 2, 5, 5)
							GUICtrlSetPos($Dot_3, -5, -5, 5, 5)
						ElseIf $gSplit[2] = "B" Then
							GUICtrlSetData($hParamLbl1, "X:")
							GUICtrlSetData($hParamLbl2, "Y:")
							GUICtrlSetData($hParamLbl3, "1X:")
							GUICtrlSetData($hParamLbl4, "1Y:")
							GUICtrlSetData($hParamLbl5, "2X:")
							GUICtrlSetData($hParamLbl6, "2Y:")
							GUICtrlSetData($hParamInput1, $gSplit[3])
							GUICtrlSetData($hParamInput2, $gSplit[4])
							GUICtrlSetData($hParamInput3, $gSplit[5])
							GUICtrlSetData($hParamInput4, $gSplit[6])
							GUICtrlSetData($hParamInput5, $gSplit[7])
							GUICtrlSetData($hParamInput6, $gSplit[8])
							GUICtrlSetData($hParamInput7, $gSplit[9])
							GUICtrlSetData($hParamInput8, $gSplit[10])
							GUICtrlSetBkColor($hParamColor, "0x" & $gSplit[9])
							GUICtrlSetBkColor($hParamBkColor, "0x" & $gSplit[10])
							GUICtrlSetPos($Dot_1, $GraphicX + $gSplit[3] - 2, $GraphicY + $gSplit[4] - 2, 5, 5)
							GUICtrlSetPos($Dot_2, $GraphicX + $gSplit[5] - 2, $GraphicY + $gSplit[6] - 2, 5, 5)
							GUICtrlSetPos($Dot_3, $GraphicX + $gSplit[7] - 2, $GraphicY + $gSplit[8] - 2, 5, 5)
						ElseIf $gSplit[2] = "i" Then
							GUICtrlSetData($hParamLbl1, "X:")
							GUICtrlSetData($hParamLbl2, "Y:")
							GUICtrlSetData($hParamLbl3, "Radius:")
							GUICtrlSetData($hParamLbl4, "Start Angle:")
							GUICtrlSetData($hParamLbl5, "Sweep Angle:")
							GUICtrlSetData($hParamLbl6, "( Param 6 )")
							GUICtrlSetData($hParamInput1, $gSplit[3])
							GUICtrlSetData($hParamInput2, $gSplit[4])
							GUICtrlSetData($hParamInput3, $gSplit[5])
							GUICtrlSetData($hParamInput4, $gSplit[6])
							GUICtrlSetData($hParamInput5, $gSplit[7])
							GUICtrlSetData($hParamInput6, "")
							GUICtrlSetData($hParamInput7, $gSplit[8])
							GUICtrlSetData($hParamInput8, $gSplit[9])
							GUICtrlSetBkColor($hParamColor, "0x" & $gSplit[7])
							GUICtrlSetBkColor($hParamBkColor, "0x" & $gSplit[8])
							GUICtrlSetPos($Dot_1, -5, -5, 5, 5)
							GUICtrlSetPos($Dot_2, -5, -5, 5, 5)
							GUICtrlSetPos($Dot_3, -5, -5, 5, 5)
						EndIf
					EndIf
					If $hMouse[0] > $GraphicX + $gSplit[3] - 2 And $hMouse[0] < $GraphicX + $gSplit[3] + ($gSplit[5] - $gSplit[3]) + 2 And $hMouse[1] > $GraphicY + $gSplit[4] - 2 And $hMouse[1] < $GraphicY + $gSplit[4] + ($gSplit[6] - $gSplit[4]) + 2 Then
						If $Mouse = 2 Then
							$InsideIndex = $i
							$Mouse = 9
							GUICtrlSetCursor($hInside, 9)
						EndIf
					ElseIf $hMouse[0] < $GraphicX + $gSplit[3] - 2 And $hMouse[0] > $GraphicX + $gSplit[3] + ($gSplit[5] - $gSplit[3]) + 2 And $hMouse[1] > $GraphicY + $gSplit[4] - 2 And $hMouse[1] < $GraphicY + $gSplit[4] + ($gSplit[6] - $gSplit[4]) + 2 Then
						If $Mouse = 2 Then
							$InsideIndex = $i
							$Mouse = 9
							GUICtrlSetCursor($hInside, 9)
						EndIf
					ElseIf $hMouse[0] < $GraphicX + $gSplit[3] - 2 And $hMouse[0] > $GraphicX + $gSplit[3] + ($gSplit[5] - $gSplit[3]) + 2 And $hMouse[1] < $GraphicY + $gSplit[4] - 2 And $hMouse[1] > $GraphicY + $gSplit[4] + ($gSplit[6] - $gSplit[4]) + 2 Then
						If $Mouse = 2 Then
							$InsideIndex = $i
							$Mouse = 9
							GUICtrlSetCursor($hInside, 9)
						EndIf
					ElseIf $hMouse[0] > $GraphicX + $gSplit[3] - 2 And $hMouse[0] < $GraphicX + $gSplit[3] + ($gSplit[5] - $gSplit[3]) + 2 And $hMouse[1] < $GraphicY + $gSplit[4] - 2 And $hMouse[1] > $GraphicY + $gSplit[4] + ($gSplit[6] - $gSplit[4]) + 2 Then
						If $Mouse = 2 Then
							$InsideIndex = $i
							$Mouse = 9
							GUICtrlSetCursor($hInside, 9)
						EndIf
					Else
						$InsideIndex = 0
						$Mouse = 2
						GUICtrlSetCursor($hInside, 3)
					EndIf
				ElseIf $gSplit[2] = "P" Or $gSplit[2] = "D" Then
					If $hMouse[0] > $GraphicX + $gSplit[3] - 2 And $hMouse[0] < $GraphicX + $gSplit[3] + 2 And $hMouse[1] > $GraphicY + $gSplit[4] - 2 And $hMouse[1] < $GraphicY + $gSplit[4] + 2 Then
						If $Mouse = 2 Then
							$InsideIndex = $i + 1
							$Mouse = 9
							GUICtrlSetCursor($hInside, 9)
						EndIf
					Else
						$InsideIndex = 0
						$Mouse = 2
						GUICtrlSetCursor($hInside, 3)
					EndIf
				ElseIf $gSplit[2] = "i" Then
					If $CurrentItem <> $i Then
						$CurrentItem = $i
						GUICtrlSetData($hParamLbl1, "1X:")
						GUICtrlSetData($hParamLbl2, "1Y:")
						GUICtrlSetData($hParamLbl3, "2X:")
						GUICtrlSetData($hParamLbl4, "2Y:")
						GUICtrlSetData($hParamInput1, $gSplit[3])
						GUICtrlSetData($hParamInput2, $gSplit[4])
						GUICtrlSetData($hParamInput3, $gSplit[5])
						GUICtrlSetData($hParamInput4, $gSplit[6])
					EndIf
				EndIf
				If _IsPressed("2E") And $Selected = True Then
					$hSplit = StringSplit($GraphicItems[$InsideIndex], ",")
					If IsArray($hSplit) Then
						;_ArrayDelete
					EndIf
				EndIf
				If _IsPressed("01") And $InsideIndex <> 0 Then
					GUICtrlDelete($hSelectBoarder)
					$DifferenceX = 0
					$DifferenceY = 0
					$StartPos = GUIGetCursorInfo($GUIHolder)
					$Moving = True
					$hSplit = StringSplit($GraphicItems[$InsideIndex], ",")
					$hHandle = GUICtrlGetHandle($hSplit[1])
					$hPos = ControlGetPos($GUIHolder, "", $hHandle)
					While $Moving = True
						$mPos = GUIGetCursorInfo($GUIHolder)
						ControlMove($GUIHolder, "", $hHandle, $hPos[0] + ($mPos[0] - $StartPos[0]), $hPos[1] + ($mPos[1] - $StartPos[1]))
						If $DifferenceX <> ($mPos[0] - $StartPos[0]) Or $DifferenceY <> ($mPos[1] - $StartPos[1]) Then
							$DifferenceX = ($mPos[0] - $StartPos[0])
							$DifferenceY = ($mPos[1] - $StartPos[1])
							_WinAPI_RedrawWindow($GUIHolder)
						EndIf
						If _IsPressed("01") = False Then
							Switch $hSplit[2]
								Case "R" Or "E" Or "L"
									$GraphicItems[$InsideIndex] = StringReplace($GraphicItems[$InsideIndex], $hSplit[2] & "," & $hSplit[3] & "," & $hSplit[4] & "," & $hSplit[5] & "," & $hSplit[6], $hSplit[2] & "," & $gSplit[3] + ($mPos[0] - $StartPos[0]) & "," & $gSplit[4] + ($mPos[1] - $StartPos[1]) & "," & $gSplit[5] + ($mPos[0] - $StartPos[0]) & "," & $gSplit[6] + ($mPos[1] - $StartPos[1]))
									$GraphicData = StringReplace($GraphicData, $hSplit[2] & "," & $hSplit[3] & "," & $hSplit[4] & "," & $hSplit[5] & "," & $hSplit[6], $hSplit[2] & "," & $gSplit[3] + ($mPos[0] - $StartPos[0]) & "," & $gSplit[4] + ($mPos[1] - $StartPos[1]) & "," & $gSplit[5] + ($mPos[0] - $StartPos[0]) & "," & $gSplit[6] + ($mPos[1] - $StartPos[1]))
									$gSplit[3] = $gSplit[3] + ($mPos[0] - $StartPos[0])
									$gSplit[4] = $gSplit[4] + ($mPos[1] - $StartPos[1])
									$gSplit[5] = $gSplit[5] + ($mPos[0] - $StartPos[0])
									$gSplit[6] = $gSplit[6] + ($mPos[1] - $StartPos[1])
								Case "P"
									$GraphicItems[$InsideIndex] = StringReplace($GraphicItems[$InsideIndex], $hSplit[2] & "," & $hSplit[3] & "," & $hSplit[4], $hSplit[2] & "," & $gSplit[3] + ($hPos[0] + ($mPos[0] - $StartPos[0])) - $GraphicX & "," & $gSplit[4] + ($hPos[1] + ($mPos[1] - $StartPos[1]) - $GraphicY))
									$GraphicData = StringReplace($GraphicData, $hSplit[2] & "," & $hSplit[3] & "," & $hSplit[4], $hSplit[2] & "," & $gSplit[3] + ($hPos[0] + ($mPos[0] - $StartPos[0])) - $GraphicX & "," & $gSplit[4] + ($hPos[1] + ($mPos[1] - $StartPos[1]) - $GraphicY))
								Case "D"
									$GraphicItems[$InsideIndex] = StringReplace($GraphicItems[$InsideIndex], $hSplit[2] & "," & $hSplit[3] & "," & $hSplit[4], $hSplit[2] & "," & $gSplit[3] + ($hPos[0] + ($mPos[0] - $StartPos[0])) - $GraphicX & "," & $gSplit[4] + ($hPos[1] + ($mPos[1] - $StartPos[1]) - $GraphicY))
									$GraphicData = StringReplace($GraphicData, $hSplit[2] & "," & $hSplit[3] & "," & $hSplit[4], $hSplit[2] & "," & $gSplit[3] + ($hPos[0] + ($mPos[0] - $StartPos[0])) - $GraphicX & "," & $gSplit[4] + ($hPos[1] + ($mPos[1] - $StartPos[1]) - $GraphicY))
								Case "B"
									$GraphicItems[$InsideIndex] = StringReplace($GraphicItems[$InsideIndex], $hSplit[2] & "," & $hSplit[3] & "," & $hSplit[4] & "," & $hSplit[5] & "," & $hSplit[6], $hSplit[2] & "," & $gSplit[3] + ($mPos[0] - $StartPos[0]) & "," & $gSplit[4] + ($mPos[1] - $StartPos[1]) & "," & $gSplit[5] + ($mPos[0] - $StartPos[0]) & "," & $gSplit[6] + ($mPos[1] - $StartPos[1]) & "," & $gSplit[7] + ($mPos[0] - $StartPos[0]))
									$GraphicData = StringReplace($GraphicData, $hSplit[2] & "," & $hSplit[3] & "," & $hSplit[4] & "," & $hSplit[5] & "," & $hSplit[6], $hSplit[2] & "," & $gSplit[3] + ($mPos[0] - $StartPos[0]) & "," & $gSplit[4] + ($mPos[1] - $StartPos[1]) & "," & $gSplit[5] + ($mPos[0] - $StartPos[0]) & "," & $gSplit[6] + ($mPos[1] - $StartPos[1]) & "," & $gSplit[7] + ($mPos[0] - $StartPos[0]))
									$gSplit[3] = $gSplit[3] + ($mPos[0] - $StartPos[0])
									$gSplit[4] = $gSplit[4] + ($mPos[1] - $StartPos[1])
									$gSplit[5] = $gSplit[5] + ($mPos[0] - $StartPos[0])
									$gSplit[6] = $gSplit[6] + ($mPos[1] - $StartPos[1])
									$gSplit[7] = $gSplit[7] + ($mPos[1] - $StartPos[1])
							EndSwitch
							$Moving = False
						EndIf
						Sleep(@DesktopRefresh)
					WEnd
					Switch $hSplit[2]
						Case "R" Or "E" Or "L" Or "i"
							GUISwitch($GUIHolder)
							Dim $XLoc = 0, $YLoc = 0
							If Number($gSplit[3]) < Number($gSplit[5]) Then
								$XLoc = $gSplit[3]
							Else
								$XLoc = $gSplit[5]
							EndIf
							If Number($gSplit[4]) < Number($gSplit[6]) Then
								$YLoc = $gSplit[4]
							Else
								$YLoc = $gSplit[6]
							EndIf
							$hSelectBoarder = GUICtrlCreateGraphic($GraphicX, $GraphicY, $hInfo[2], $hInfo[3] + 1)
							GUICtrlSetGraphic($hSelectBoarder, $GUI_GR_COLOR, 0xFF)
							GUICtrlSetGraphic($hSelectBoarder, $GUI_GR_RECT, $XLoc - 2, $YLoc - 2, Abs($gSplit[5] - $gSplit[3]) + 4, Abs($gSplit[6] - $gSplit[4]) + 4)
							GUISetState()
							GUICtrlSetResizing($hSelectBoarder, 802)
							GUICtrlSetState($hSelectBoarder, $GUI_ONTOP)
							GUICtrlSetState($hSelectBoarder, $GUI_SHOW)
						Case "D" Or "P"

					EndSwitch
				EndIf
				If $SelectedGraphic <> $i Then
					$SelectedGraphic = $i
					Switch $gSplit[2]
						Case "R" Or "E" Or "L" Or "B"
							GUISwitch($GUIHolder)
							Dim $XLoc = 0, $YLoc = 0
							If Number($gSplit[3]) < Number($gSplit[5]) Then
								$XLoc = $gSplit[3]
							Else
								$XLoc = $gSplit[5]
							EndIf
							If Number($gSplit[4]) < Number($gSplit[6]) Then
								$YLoc = $gSplit[4]
							Else
								$YLoc = $gSplit[6]
							EndIf
							If $hSelectBoarder <> 0 Then
								GUICtrlDelete($hSelectBoarder)
							EndIf

							$hSelectBoarder = GUICtrlCreateGraphic($GraphicX, $GraphicY, $hInfo[2], $hInfo[3] + 1)
							GUICtrlSetGraphic($hSelectBoarder, $GUI_GR_COLOR, 0xFF)
							GUICtrlSetGraphic($hSelectBoarder, $GUI_GR_RECT, $XLoc - 2, $YLoc - 2, Abs($gSplit[5] - $gSplit[3]) + 4, Abs($gSplit[6] - $gSplit[4]) + 4)
							GUISetState()
							GUICtrlSetResizing($hSelectBoarder, 802)
							GUICtrlSetState($hSelectBoarder, $GUI_ONTOP)
						Case "P"
							GUICtrlSetPos($BoarderL, $GraphicX + $gSplit[3] - 1, $GraphicY + $gSplit[4] - 1, 1, 3)
							GUICtrlSetPos($BoarderR, $GraphicX + $gSplit[3] + 1, $GraphicY + $gSplit[4] - 1, 1, 3)
							GUICtrlSetPos($BoarderT, $GraphicX + $gSplit[3] - 1, $GraphicY + $gSplit[4] - 1, 3, 1)
							GUICtrlSetPos($BoarderB, $GraphicX + $gSplit[3] - 1, $GraphicY + $gSplit[4] + 1, 3, 1)
							#cs
								GUICtrlSetData($NewGraphicColor, $gSplit[5])
								GUICtrlSetBkColor($NewChangeColor, "0x" & $gSplit[5])
								$SelectedColor = $gSplit[5]
							#ce
						Case "D"
							GUICtrlSetPos($BoarderL, $GraphicX + $gSplit[3] - 3, $GraphicY + $gSplit[4] - 3, 1, 7)
							GUICtrlSetPos($BoarderR, $GraphicX + $gSplit[3] + 3, $GraphicY + $gSplit[4] - 3, 1, 7)
							GUICtrlSetPos($BoarderT, $GraphicX + $gSplit[3] - 3, $GraphicY + $gSplit[4] - 3, 7, 1)
							GUICtrlSetPos($BoarderB, $GraphicX + $gSplit[3] - 3, $GraphicY + $gSplit[4] + 3, 7, 1)
							#cs
								GUICtrlSetData($NewGraphicColor, $gSplit[5])
								GUICtrlSetBkColor($NewChangeColor, "0x" & $gSplit[5])
								$SelectedColor = $gSplit[5]
								If $gSplit[0] = 6 Then
								GUICtrlSetData($NewGraphicBkColor, $gSplit[6])
								If $gSplit[6] <> "" Then
								GUICtrlSetBkColor($NewChangeBkColor, "0x" & $gSplit[6])
								Else
								GUICtrlSetBkColor($NewChangeBkColor, "0xF0F0F0")
								EndIf
								$SelectedBkColor = $gSplit[6]
								EndIf
							#ce

					EndSwitch
					GUICtrlSetState($hSelectBoarder, $GUI_SHOW)
				EndIf
			EndIf
		Next
		If $Selected = False And $SelectedGraphic <> 0 Then
			$SelectedGraphic = 0
			GUICtrlDelete($hSelectBoarder)
		EndIf
		If GUICtrlRead($NewGraphicColor) <> $SelectedColor Then
			$SelectedColor = GUICtrlRead($NewGraphicColor)
			GUICtrlSetBkColor($NewChangeColor, "0x" & $SelectedColor)
		EndIf
		If GUICtrlRead($NewGraphicBkColor) <> $SelectedBkColor Then
			$SelectedBkColor = GUICtrlRead($NewGraphicBkColor)
			If $SelectedBkColor = "" Then
				GUICtrlSetBkColor($NewChangeBkColor, 0xF0F0F0)
			Else
				GUICtrlSetBkColor($NewChangeBkColor, "0x" & $SelectedBkColor)
			EndIf
		EndIf
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				$hMsgbox = MsgBox(0x4, "Exit?", "Are you sure you want to Exit?" & @CRLF & "Any unsaved data will be lost.")
				If $hMsgbox = 6 Then
					_GDIPlus_Shutdown()
					_GUICtrlRichEdit_Destroy($ScriptEdit)
					_WinAPI_UnhookWindowsHookEx($hHook)
					DllCallbackFree($hStub_KeyProc)
					_CleanUp()
					DllClose($dll)
					Exit
				EndIf
			Case $NewChangeBkColor
				$hColor = _ChooseColor(2, "0x" & GUICtrlRead($NewGraphicBkColor), 2, $GUIHolder)
				GUICtrlSetData($NewGraphicBkColor, StringTrimLeft(Hex($hColor, 8), 2))
				GUICtrlSetBkColor($NewChangeBkColor, $hColor)
			Case $NewChangeColor
				$hColor = _ChooseColor(2, "0x" & GUICtrlRead($NewGraphicColor), 2, $GUIHolder)
				GUICtrlSetData($NewGraphicColor, StringTrimLeft(Hex($hColor, 8), 2))
				GUICtrlSetBkColor($NewChangeColor, $hColor)
			Case $hDotBtn
				$SelectedGraphic = "D"
				_AddGraphicControl($SelectedGraphic, $SelectedControl)
			Case $hPixelBtn
				$SelectedGraphic = "P"
				_AddGraphicControl($SelectedGraphic, $SelectedControl)
			Case $hLineBtn
				$SelectedGraphic = "L"
				_AddGraphicControl($SelectedGraphic, $SelectedControl)
			Case $hBezierBtn
				$SelectedGraphic = "B"
				_AddGraphicControl($SelectedGraphic, $SelectedControl)
			Case $hRectBtn
				$SelectedGraphic = "R"
				_AddGraphicControl($SelectedGraphic, $SelectedControl)
			Case $hPieBtn
				$SelectedGraphic = "i"
				_AddGraphicControl($SelectedGraphic, $SelectedControl)
			Case $hEllipseBtn
				$SelectedGraphic = "E"
				_AddGraphicControl($SelectedGraphic, $SelectedControl)
			Case $SaveGraphicButton
				GUICtrlDelete($hSelectBoarder)
				$RefNum = _GetIndex($SelectedControl)
				$Data[$RefNum] = $GraphicData
				GUICtrlSetData($DataInput, $Data[$RefNum])
				$GraphicStarted = False
				GUISetState(@SW_ENABLE, $GUIs[$CurrentWindow])
				$hCtrlPos = ControlGetPos("", "", $Controls[$RefNum])
				GUICtrlDelete($Controls[$RefNum])
				If StringInStr($Attributes[$RefNum], "ø") Then
					$hTabSplit = StringSplit($Attributes[$RefNum], "ø")
					GUISwitch($GUIs[$CurrentWindow], GUICtrlRead($Controls[_NameToIndex($hTabSplit[1])], 1))
				Else
					GUISwitch($GUIs[$CurrentWindow])
				EndIf
				$Controls[$RefNum] = GUICtrlCreateGraphic($hCtrlPos[0], $hCtrlPos[1], $hCtrlPos[2], $hCtrlPos[3])
				GUISetState()
				GUICtrlSetResizing(-1, 802)
				If StringInStr($Attributes[$RefNum], "ø") Then
					GUICtrlCreateTabItem("")
				EndIf
				_SetControlGraphic($Controls[$RefNum], $GraphicData)
				_SetScriptData()
		EndSwitch
		$hCursor = GUIGetCursorInfo($GUIHolder)
		If $hCursor[4] = $ModeCloseBtn Then
			If $ModeHighlight = False Then
				_ResourceSetImageToCtrl($ModeCloseBtn, "CloseBtnHover", $RT_BITMAP)
				$ModeHighlight = True
			EndIf
		Else
			If $ModeHighlight = True Then
				_ResourceSetImageToCtrl($ModeCloseBtn, "CloseBtn", $RT_BITMAP)
				$ModeHighlight = False
			EndIf
		EndIf
		If _IsPressed("01") And $ModeHighlight = True Then
			$GraphicStarted = False
		EndIf
		Sleep(10)
	WEnd
	GUICtrlDelete($hTopBoarder)
	GUICtrlDelete($hBottomBoarder)
	GUICtrlDelete($hLeftBoarder)
	GUICtrlDelete($hRightBoarder)
	For $i = 1 To $GraphicCtrls[0] Step 1
		GUICtrlDelete($GraphicCtrls[$i])
	Next
	GUICtrlDelete($hBackground)
	GUISwitch($GUIs[$CurrentWindow])
EndFunc   ;==>_GraphicMode
Func _AddGraphicControl($hType, $hControl)
	$SelectedGraphic = 0
	GUICtrlSetState($hSelectBoarder, $GUI_HIDE)
	GUICtrlSetPos($Dot_1, -5, -5, 5, 5)
	GUICtrlSetPos($Dot_2, -5, -5, 5, 5)
	GUICtrlSetPos($Dot_3, -5, -5, 5, 5)
	$GraphicX = 150
	$GraphicY = 45
	$CurrentData = ''
	$Step1 = False
	$Step2 = False
	$Stop = False
	$Step = 1
	$StartX = 0
	$StartY = 0
	$AddingGraphic = True
	$hInfo = ControlGetPos("", "", $hControl)
	While $AddingGraphic = True
		$mPos = GUIGetCursorInfo($GUIHolder)
		If $hType = "L" Then
			If $Step = 1 Then
				ToolTip("Select Start Position" & @CRLF & "X: " & ($mPos[0] - $GraphicX) & "Y: " & ($mPos[1] - $GraphicY))
			ElseIf $Step = 2 Then
				ToolTip("Start Position  X: " & $StartX & "Y: " & $StartY & @CRLF & "End Position  X: " & ($mPos[0] - $GraphicX) & "Y: " & ($mPos[1] - $GraphicY))
			EndIf
		ElseIf $hType = "R" Or $hType = "E" Then
			If $Step = 1 Then
				ToolTip("Select Start Position" & @CRLF & "X: " & ($mPos[0] - $GraphicX) & "Y: " & ($mPos[1] - $GraphicY))
			ElseIf $Step = 2 Then
				ToolTip("Start Position  X: " & $StartX & "Y: " & $StartY & @CRLF & "End Position  X: " & ($mPos[0] - $GraphicX) & "Y: " & ($mPos[1] - $GraphicY) & @CRLF & "Width: " & ($mPos[0] - $GraphicX) - $StartX & " Height: " & ($mPos[1] - $GraphicY) - $StartY)
			EndIf
		EndIf
		Switch $hType
			Case "D"
				ToolTip("Select Position")
				If Not @error Then
					If $mPos[0] >= 150 And $mPos[1] >= 45 And $mPos[0] <= $GraphicX + $hInfo[2] And $mPos[1] <= $GraphicY + $hInfo[3] Then
						If _IsPressed("01") Then
							$hBkColor = GUICtrlRead($NewGraphicBkColor)
							$hColor = GUICtrlRead($NewGraphicColor)
							$GraphicData &= ":D," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY) & "," & $hColor & "," & $hBkColor
							$hGraphic = GUICtrlCreateGraphic($GraphicX, $GraphicY, $hInfo[2], $hInfo[3])
							GUICtrlSetState(-1, $GUI_ONTOP)
							GUICtrlSetGraphic(-1, $GUI_GR_MOVE, ($mPos[0] - $GraphicX), ($mPos[1] - $GraphicY))
							If $hBkColor <> "" Then
								GUICtrlSetGraphic(-1, $GUI_GR_COLOR, "0x" & $hColor, "0x" & $hBkColor)
							Else
								GUICtrlSetGraphic(-1, $GUI_GR_COLOR, "0x" & $hColor)
							EndIf
							GUICtrlSetGraphic(-1, $GUI_GR_DOT, ($mPos[0] - $GraphicX), ($mPos[1] - $GraphicY))
							GUISetState()
							GUICtrlSetState($hGraphic, $GUI_SHOW)
							GUICtrlSetResizing($hGraphic, 802)
							_WinAPI_RedrawWindow($GUIHolder)
							$AddingGraphic = False
							_GUICtrlTreeView_BeginUpdate($hTree)
							$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$RefNum], "Dot " & $GraphicItems[0])
							_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -280)
							_GUICtrlTreeView_EndUpdate($hTree)
							_ArrayAdd($GraphicTrees, $hItem)
							$GraphicTrees[0] += 1
							_ArrayAdd($GraphicItems, $hGraphic & ",D," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY) & "," & $hColor & "," & $hBkColor)
							$GraphicItems[0] += 1
							_ArrayAdd($GraphicCtrls, $hGraphic)
							$GraphicCtrls[0] += 1
							ToolTip("")
						EndIf
					EndIf
				EndIf
				Sleep(100)
			Case "P"
				ToolTip("Select Position")
				If Not @error Then
					If $mPos[0] >= $GraphicX And $mPos[1] >= $GraphicY And $mPos[0] <= $GraphicX + $hInfo[2] And $mPos[1] <= $GraphicY + $hInfo[3] Then
						If _IsPressed("01") Then
							$hBkColor = GUICtrlRead($NewGraphicBkColor)
							$hColor = GUICtrlRead($NewGraphicColor)
							$GraphicData &= ":P," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY) & "," & $hColor & "," & $hBkColor
							$hGraphic = GUICtrlCreateGraphic($GraphicX, $GraphicY, $hInfo[2], $hInfo[3])
							GUICtrlSetState(-1, $GUI_ONTOP)
							GUICtrlSetGraphic(-1, $GUI_GR_MOVE, ($mPos[0] - $GraphicX), ($mPos[1] - $GraphicY))
							If $hBkColor <> "" Then
								GUICtrlSetGraphic(-1, $GUI_GR_COLOR, "0x" & $hColor, "0x" & $hBkColor)
							Else
								GUICtrlSetGraphic(-1, $GUI_GR_COLOR, "0x" & $hColor)
							EndIf
							GUICtrlSetGraphic(-1, $GUI_GR_PIXEL, ($mPos[0] - $GraphicX), ($mPos[1] - $GraphicY))
							GUISetState()
							GUICtrlSetState($hGraphic, $GUI_SHOW)
							GUICtrlSetResizing($hGraphic, 802)
							_WinAPI_RedrawWindow($GUIHolder)
							$AddingGraphic = False
							_GUICtrlTreeView_BeginUpdate($hTree)
							$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$RefNum], "Pixel " & $GraphicItems[0])
							_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -281)
							_GUICtrlTreeView_EndUpdate($hTree)
							_ArrayAdd($GraphicTrees, $hItem)
							$GraphicTrees[0] += 1
							_ArrayAdd($GraphicItems, $hGraphic & ",P," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY) & "," & $hColor)
							$GraphicItems[0] += 1
							_ArrayAdd($GraphicCtrls, $hGraphic)
							$GraphicCtrls[0] += 1
							ToolTip("")
						EndIf
					EndIf
				EndIf
			Case "L"
				If Not @error Then
					If $mPos[0] >= $GraphicX And $mPos[1] >= $GraphicY And $mPos[0] <= $GraphicX + $hInfo[2] And $mPos[1] <= $GraphicY + $hInfo[3] Then
						If _IsPressed("01") Then
							If $Step1 = True Then
								ToolTip("")
								$Step1 = False
								$hBkColor = GUICtrlRead($NewGraphicBkColor)
								$hColor = GUICtrlRead($NewGraphicColor)
								$GraphicData &= "," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY) & "," & $hColor & "," & $hBkColor
								$CurrentData &= "," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
								$AddingGraphic = False
								$hSplit = StringSplit($CurrentData, ",")
								$hGraphic = GUICtrlCreateGraphic($GraphicX, $GraphicY, $hInfo[2], $hInfo[3])
								GUICtrlSetState(-1, $GUI_ONTOP)
								GUICtrlSetGraphic(-1, $GUI_GR_MOVE, $hSplit[1], $hSplit[2])
								If $hBkColor <> "" Then
									GUICtrlSetGraphic(-1, $GUI_GR_COLOR, "0x" & $hColor, "0x" & $hBkColor)
								Else
									GUICtrlSetGraphic(-1, $GUI_GR_COLOR, "0x" & $hColor)
								EndIf
								GUICtrlSetGraphic(-1, $GUI_GR_LINE, $hSplit[1], $hSplit[2])
								GUICtrlSetGraphic(-1, $GUI_GR_LINE, $hSplit[3], $hSplit[4])
								GUISetState()
								GUICtrlSetState($hGraphic, $GUI_SHOW)
								GUICtrlSetResizing($hGraphic, 802)
								GUICtrlSetState($Dot, $GUI_HIDE)
								_WinAPI_RedrawWindow($GUIHolder)
								_GUICtrlTreeView_BeginUpdate($hTree)
								$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$RefNum], "Line " & $GraphicItems[0])
								_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -282)
								_GUICtrlTreeView_EndUpdate($hTree)
								_ArrayAdd($GraphicTrees, $hItem)
								$GraphicTrees[0] += 1
								_ArrayAdd($GraphicItems, $hGraphic & ",L," & $CurrentData & "," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY) & "," & $hColor)
								$GraphicItems[0] += 1
								_ArrayAdd($GraphicCtrls, $hGraphic)
								$GraphicCtrls[0] += 1
							ElseIf $Step1 = False Then
								$StartX = ($mPos[0] - $GraphicX)
								$StartY = ($mPos[1] - $GraphicY)
								$Step1 = True
								$Step += 1
								$GraphicData &= ":L," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
								$CurrentData = ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
								GUICtrlSetPos($Dot, $mPos[0] - 2, $mPos[1] - 2, 5, 5)
								GUICtrlSetState($Dot, $GUI_SHOW)
								Sleep(100)
							EndIf
						EndIf
					EndIf
				EndIf
			Case "B"
				If $mPos[0] >= $GraphicX And $mPos[1] >= $GraphicY And $mPos[0] <= $GraphicX + $hInfo[2] And $mPos[1] <= $GraphicY + $hInfo[3] Then
					If _IsPressed("01") Then
						If $Step2 = True Then
							$hBkColor = GUICtrlRead($NewGraphicBkColor)
							$hColor = GUICtrlRead($NewGraphicColor)
							$GraphicData &= "," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY) & "," & $hColor & "," & $hBkColor
							$CurrentData &= "," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
							$AddingGraphic = False
							$hSplit = StringSplit($CurrentData, ",")
							$hGraphic = GUICtrlCreateGraphic($GraphicX, $GraphicY, $hInfo[2], $hInfo[3])
							GUICtrlSetState(-1, $GUI_ONTOP)
							GUICtrlSetGraphic(-1, $GUI_GR_MOVE, $hSplit[1], $hSplit[2])
							If $hBkColor <> "" Then
								GUICtrlSetGraphic(-1, $GUI_GR_COLOR, "0x" & $hColor, "0x" & $hBkColor)
							Else
								GUICtrlSetGraphic(-1, $GUI_GR_COLOR, "0x" & $hColor)
							EndIf
							GUICtrlSetGraphic(-1, $GUI_GR_BEZIER, $hSplit[1], $hSplit[2], $hSplit[3], $hSplit[4], $hSplit[5], $hSplit[6])
							GUICtrlSetState($Dot, $GUI_HIDE)
							GUISetState()
							GUICtrlSetState($hGraphic, $GUI_SHOW)
							GUICtrlSetResizing($hGraphic, 802)
							_WinAPI_RedrawWindow($GUIHolder)
							_GUICtrlTreeView_BeginUpdate($hTree)
							$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$RefNum], "Bezier " & $GraphicItems[0])
							_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -283)
							_GUICtrlTreeView_EndUpdate($hTree)
							_ArrayAdd($GraphicTrees, $hItem)
							$GraphicTrees[0] += 1
							_ArrayAdd($GraphicItems, $hGraphic & ",B," & $CurrentData & "," & $hColor & "," & $hBkColor)
							$GraphicItems[0] += 1
							_ArrayAdd($GraphicCtrls, $hGraphic)
							$GraphicCtrls[0] += 1
							$Step2 = False
							$Step1 = False
							$Stop = True
						EndIf
						If $Step1 = True Then
							ToolTip("")
							$Step1 = False
							$Step2 = True
							$hBkColor = GUICtrlRead($NewGraphicBkColor)
							$hColor = GUICtrlRead($NewGraphicColor)
							$GraphicData &= "," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
							$CurrentData &= "," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
							GUICtrlSetPos($Dot, $mPos[0] - 2, $mPos[1] - 2, 5, 5)
							GUICtrlSetState($Dot, $GUI_SHOW)
							Sleep(100)
						ElseIf $Step1 = False And $Stop = False Then
							$StartX = ($mPos[0] - $GraphicX)
							$StartY = ($mPos[1] - $GraphicY)
							$Step1 = True
							$Step += 1
							$GraphicData &= ":B," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
							$CurrentData = ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
							GUICtrlSetPos($Dot, $mPos[0] - 2, $mPos[1] - 2, 5, 5)
							GUICtrlSetState($Dot, $GUI_SHOW)
							Sleep(100)
						Else
							$Stop = False
						EndIf
					EndIf
				EndIf
			Case "R"
				If Not @error Then
					If $mPos[0] >= $GraphicX And $mPos[1] >= $GraphicY And $mPos[0] <= $GraphicX + $hInfo[2] And $mPos[1] <= $GraphicY + $hInfo[3] Then
						If _IsPressed("01") Then
							If $Step1 = True Then
								ToolTip("")
								$Step1 = False
								$hBkColor = GUICtrlRead($NewGraphicBkColor)
								$hColor = GUICtrlRead($NewGraphicColor)
								$GraphicData &= "," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY) & "," & $hColor & "," & $hBkColor
								$CurrentData &= "," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
								$AddingGraphic = False
								$hSplit = StringSplit($CurrentData, ",")
								$hGraphic = GUICtrlCreateGraphic($GraphicX, $GraphicY, $hInfo[2], $hInfo[3])
								GUICtrlSetState(-1, $GUI_ONTOP)
								GUICtrlSetGraphic(-1, $GUI_GR_MOVE, $hSplit[1], $hSplit[2])
								If $hBkColor <> "" Then
									GUICtrlSetGraphic(-1, $GUI_GR_COLOR, "0x" & $hColor, "0x" & $hBkColor)
								Else
									GUICtrlSetGraphic(-1, $GUI_GR_COLOR, "0x" & $hColor)
								EndIf
								GUICtrlSetGraphic(-1, $GUI_GR_RECT, $hSplit[1], $hSplit[2], $hSplit[3] - $hSplit[1], $hSplit[4] - $hSplit[2])
								GUICtrlSetState($Dot, $GUI_HIDE)
								GUISetState()
								GUICtrlSetState($hGraphic, $GUI_SHOW)
								GUICtrlSetResizing($hGraphic, 802)
								_WinAPI_RedrawWindow($GUIHolder)
								_GUICtrlTreeView_BeginUpdate($hTree)
								$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$RefNum], "Rect " & $GraphicItems[0])
								_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -284)
								_GUICtrlTreeView_EndUpdate($hTree)
								_ArrayAdd($GraphicTrees, $hItem)
								$GraphicTrees[0] += 1
								_ArrayAdd($GraphicItems, $hGraphic & ",R," & $CurrentData & "," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY) & "," & $hColor & "," & $hBkColor)
								$GraphicItems[0] += 1
								_ArrayAdd($GraphicCtrls, $hGraphic)
								$GraphicCtrls[0] += 1
							ElseIf $Step1 = False Then
								$StartX = ($mPos[0] - $GraphicX)
								$StartY = ($mPos[1] - $GraphicY)
								$Step1 = True
								$Step += 1
								$GraphicData &= ":R," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
								$CurrentData = ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
								GUICtrlSetPos($Dot, $mPos[0] - 2, $mPos[1] - 2, 5, 5)
								GUICtrlSetState($Dot, $GUI_SHOW)
								Sleep(100)
							EndIf
						EndIf
					EndIf
				EndIf
			Case "E"
				If Not @error Then
					If $mPos[0] >= $GraphicX And $mPos[1] >= $GraphicY And $mPos[0] <= $GraphicX + $hInfo[2] And $mPos[1] <= $GraphicY + $hInfo[3] Then
						If _IsPressed("01") Then
							If $Step1 = True Then
								ToolTip("")
								$Step1 = False
								$hBkColor = GUICtrlRead($NewGraphicBkColor)
								$hColor = GUICtrlRead($NewGraphicColor)
								$GraphicData &= "," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY) & "," & $hColor & "," & $hBkColor
								$CurrentData &= "," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
								$AddingGraphic = False
								$hSplit = StringSplit($CurrentData, ",")
								$hGraphic = GUICtrlCreateGraphic($GraphicX, $GraphicY, $hInfo[2], $hInfo[3])
								GUICtrlSetState(-1, $GUI_ONTOP)
								GUICtrlSetGraphic(-1, $GUI_GR_MOVE, $hSplit[1], $hSplit[2])
								If $hBkColor <> "" Then
									GUICtrlSetGraphic(-1, $GUI_GR_COLOR, "0x" & $hColor, "0x" & $hBkColor)
								Else
									GUICtrlSetGraphic(-1, $GUI_GR_COLOR, "0x" & $hColor)
								EndIf
								GUICtrlSetGraphic(-1, $GUI_GR_ELLIPSE, $hSplit[1], $hSplit[2], $hSplit[3] - $hSplit[1], $hSplit[4] - $hSplit[2])
								GUISetState()
								GUICtrlSetState($hGraphic, $GUI_SHOW)
								GUICtrlSetResizing($hGraphic, 802)
								GUICtrlSetState($Dot, $GUI_HIDE)
								_WinAPI_RedrawWindow($GUIHolder)
								_GUICtrlTreeView_BeginUpdate($hTree)
								$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$RefNum], "Ellipse " & $GraphicItems[0])
								_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -285)
								_GUICtrlTreeView_EndUpdate($hTree)
								_ArrayAdd($GraphicTrees, $hItem)
								$GraphicTrees[0] += 1
								_ArrayAdd($GraphicItems, $hGraphic & ",E," & $CurrentData & "," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY) & "," & $hColor & "," & $hBkColor)
								$GraphicItems[0] += 1
								_ArrayAdd($GraphicCtrls, $hGraphic)
								$GraphicCtrls[0] += 1
							ElseIf $Step1 = False Then
								$StartX = ($mPos[0] - $GraphicX)
								$StartY = ($mPos[1] - $GraphicY)
								$Step1 = True
								$Step += 1
								$GraphicData &= ":E," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
								$CurrentData = ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
								GUICtrlSetPos($Dot, $mPos[0] - 2, $mPos[1] - 2, 5, 5)
								GUICtrlSetState($Dot, $GUI_SHOW)
								Sleep(100)
							EndIf
						EndIf
					EndIf
				EndIf
			Case "i"
				If Not @error Then
					If $mPos[0] >= $GraphicX And $mPos[1] >= $GraphicY And $mPos[0] <= $GraphicX + $hInfo[2] And $mPos[1] <= $GraphicY + $hInfo[3] Then
						If _IsPressed("01") Then
							If $Step1 = True Then
								ToolTip("")
								$Step1 = False
								$hBkColor = GUICtrlRead($NewGraphicBkColor)
								$hColor = GUICtrlRead($NewGraphicColor)
								$StartAngle = 90
								$SweepAngle = 0
								$GraphicData &= "," & (($mPos[0] - $GraphicX) - $StartX) / 2 & "," & $SweepAngle & "," & $StartAngle & "," & $hColor & "," & $hBkColor
								$CurrentData &= "," & (($mPos[0] - $GraphicX) - $StartX) / 2 & "," & $SweepAngle & "," & $StartAngle
								$AddingGraphic = False
								$hSplit = StringSplit($CurrentData, ",")
								$hGraphic = GUICtrlCreateGraphic($GraphicX, $GraphicY, $hInfo[2], $hInfo[3])
								GUICtrlSetState(-1, $GUI_ONTOP)
								GUICtrlSetGraphic(-1, $GUI_GR_MOVE, $hSplit[1], $hSplit[2])
								If $hBkColor <> "" Then
									GUICtrlSetGraphic(-1, $GUI_GR_COLOR, "0x" & $hColor, "0x" & $hBkColor)
								Else
									GUICtrlSetGraphic(-1, $GUI_GR_COLOR, "0x" & $hColor)
								EndIf
								GUICtrlSetGraphic(-1, $GUI_GR_PIE, $hSplit[1] + ($hSplit[3] / 2), $hSplit[2] + ($hSplit[3] / 2), $hSplit[3], $hSplit[4], $hSplit[5])
								GUISetState()
								GUICtrlSetState($hGraphic, $GUI_SHOW)
								GUICtrlSetResizing($hGraphic, 802)
								GUICtrlSetState($Dot, $GUI_HIDE)
								_WinAPI_RedrawWindow($GUIHolder)
								_GUICtrlTreeView_BeginUpdate($hTree)
								$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$RefNum], "Pie " & $GraphicItems[0])
								_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -286)
								_GUICtrlTreeView_EndUpdate($hTree)
								_ArrayAdd($GraphicTrees, $hItem)
								$GraphicTrees[0] += 1
								_ArrayAdd($GraphicItems, $hGraphic & ",i," & $CurrentData & "," & $hColor & "," & $hBkColor)
								$GraphicItems[0] += 1
								_ArrayAdd($GraphicCtrls, $hGraphic)
								$GraphicCtrls[0] += 1
							ElseIf $Step1 = False Then
								$StartX = ($mPos[0] - $GraphicX)
								$StartY = ($mPos[1] - $GraphicY)
								$Step1 = True
								$Step += 1
								$GraphicData &= ":i," & ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
								$CurrentData = ($mPos[0] - $GraphicX) & "," & ($mPos[1] - $GraphicY)
								GUICtrlSetPos($Dot, $mPos[0] - 2, $mPos[1] - 2, 5, 5)
								GUICtrlSetState($Dot, $GUI_SHOW)
								Sleep(100)
							EndIf
						EndIf
					EndIf
				EndIf
		EndSwitch
		If _IsPressed("23") Then
			$AddingGraphic = False
			ToolTip("")
		EndIf
		Sleep(10)
	WEnd
EndFunc   ;==>_AddGraphicControl
Func _SetControlGraphic($Control, $hData) ; Applies a graphic to a graphic control
	WinSetState($GUIs[$CurrentWindow], "", @SW_ENABLE)
	GUICtrlSetGraphic($Control, $GUI_GR_REFRESH)
	If StringInStr($hData, ":") Then
		$hPos = ControlGetPos("", "", $Control)
		$ControlSplit = StringSplit($hData, ":")
		For $i = 2 To $ControlSplit[0] Step 1
			$DataSplit = StringSplit($ControlSplit[$i], ",")
			If $DataSplit[1] = "D" Then ; Dot
				If $DataSplit[5] <> "" Then
					GUICtrlSetGraphic($Control, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_COLOR, "0x" & $DataSplit[4], "0x" & $DataSplit[5])
					GUICtrlSetGraphic($Control, $GUI_GR_DOT, $DataSplit[2], $DataSplit[3])
				Else
					GUICtrlSetGraphic($Control, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_COLOR, "0x" & $DataSplit[4], $GUI_GR_NOBKCOLOR)
					GUICtrlSetGraphic($Control, $GUI_GR_DOT, $DataSplit[2], $DataSplit[3])
				EndIf
			ElseIf $DataSplit[1] = "P" Then ; Pixel
				If $DataSplit[5] <> "" Then
					GUICtrlSetGraphic($Control, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_COLOR, "0x" & $DataSplit[4], "0x" & $DataSplit[5])
					GUICtrlSetGraphic($Control, $GUI_GR_PIXEL, $DataSplit[2], $DataSplit[3])
				Else
					GUICtrlSetGraphic($Control, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_COLOR, "0x" & $DataSplit[4], $GUI_GR_NOBKCOLOR)
					GUICtrlSetGraphic($Control, $GUI_GR_PIXEL, $DataSplit[2], $DataSplit[3])
				EndIf
			ElseIf $DataSplit[1] = "L" Then ; Line
				If $DataSplit[7] <> "" Then
					GUICtrlSetGraphic($Control, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_COLOR, "0x" & $DataSplit[6], "0x" & $DataSplit[7])
					GUICtrlSetGraphic($Control, $GUI_GR_LINE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_LINE, $DataSplit[4], $DataSplit[5])
				Else
					GUICtrlSetGraphic($Control, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_COLOR, "0x" & $DataSplit[6], $GUI_GR_NOBKCOLOR)
					GUICtrlSetGraphic($Control, $GUI_GR_LINE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_LINE, $DataSplit[4], $DataSplit[5])
				EndIf
			ElseIf $DataSplit[1] = "R" Then ; Rect
				If $DataSplit[7] <> "" Then
					GUICtrlSetGraphic($Control, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_COLOR, "0x" & $DataSplit[6], "0x" & $DataSplit[7])
					GUICtrlSetGraphic($Control, $GUI_GR_RECT, $DataSplit[2], $DataSplit[3], $DataSplit[4] - $DataSplit[2], $DataSplit[5] - $DataSplit[3])
				Else
					GUICtrlSetGraphic($Control, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_COLOR, "0x" & $DataSplit[6], $GUI_GR_NOBKCOLOR)
					GUICtrlSetGraphic($Control, $GUI_GR_RECT, $DataSplit[2], $DataSplit[3], $DataSplit[4] - $DataSplit[2], $DataSplit[5] - $DataSplit[3])
				EndIf
			ElseIf $DataSplit[1] = "E" Then ; Ellipse
				If $DataSplit[7] <> "" Then
					GUICtrlSetGraphic($Control, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_COLOR, "0x" & $DataSplit[6], "0x" & $DataSplit[7])
					GUICtrlSetGraphic($Control, $GUI_GR_ELLIPSE, $DataSplit[2], $DataSplit[3], $DataSplit[4] - $DataSplit[2], $DataSplit[5] - $DataSplit[3])
				Else
					GUICtrlSetGraphic($Control, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_COLOR, "0x" & $DataSplit[6], $GUI_GR_NOBKCOLOR)
					GUICtrlSetGraphic($Control, $GUI_GR_ELLIPSE, $DataSplit[2], $DataSplit[3], $DataSplit[4] - $DataSplit[2], $DataSplit[5] - $DataSplit[3])
				EndIf
			ElseIf $DataSplit[1] = "B" Then ; Bezier
				If $DataSplit[9] <> "" Then
					GUICtrlSetGraphic($Control, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_COLOR, "0x" & $DataSplit[8], "0x" & $DataSplit[9])
					GUICtrlSetGraphic($Control, $GUI_GR_BEZIER, $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5], $DataSplit[6], $DataSplit[7])
				Else
					GUICtrlSetGraphic($Control, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_COLOR, "0x" & $DataSplit[8], $GUI_GR_NOBKCOLOR)
					GUICtrlSetGraphic($Control, $GUI_GR_BEZIER, $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5], $DataSplit[6], $DataSplit[7])
				EndIf
			ElseIf $DataSplit[1] = "i" Then ; Pie
				If $DataSplit[8] <> "" Then
					GUICtrlSetGraphic($Control, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_COLOR, "0x" & $DataSplit[7], "0x" & $DataSplit[8])
					GUICtrlSetGraphic($Control, $GUI_GR_PIE, $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5], $DataSplit[6])
				Else
					GUICtrlSetGraphic($Control, $GUI_GR_MOVE, $DataSplit[2], $DataSplit[3])
					GUICtrlSetGraphic($Control, $GUI_GR_COLOR, "0x" & $DataSplit[7], $GUI_GR_NOBKCOLOR)
					GUICtrlSetGraphic($Control, $GUI_GR_PIE, $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5], $DataSplit[6])
				EndIf
			EndIf
		Next
		GUISetState()
		_WinAPI_RedrawWindow($hGUI)
	EndIf
EndFunc   ;==>_SetControlGraphic
Func _FuncMode()
	$FunctionMode = True
	$RefNum = _GetIndex($SelectedControl)
	$FuncType = ''
	$FunctionGUI = GUICreate("Create Function", 461, 468, -1, -1)
	GUICtrlCreateLabel("Event:", 260, 13, 60, 17)

	$TypeCombo = GUICtrlCreateCombo("", 299, 8, 100, 21, 0x0003)
	$iStyle = _WinAPI_GetWindowLong(GUICtrlGetHandle($TypeCombo), $GWL_STYLE)
	GUICtrlSetStyle($TypeCombo, BitXOR($iStyle, $WS_TABSTOP))
	$FuncEdit = GUICtrlCreateEdit(StringTrimLeft($Functions[$RefNum], 1), 13, 35, 435, 398)
	$iStyle = _WinAPI_GetWindowLong(GUICtrlGetHandle($FuncEdit), $GWL_STYLE)
	GUICtrlSetStyle($FuncEdit, BitXOR($iStyle, $WS_TABSTOP))
	$SaveButton = GUICtrlCreateButton("Save", 315, 438, 140, 26)
	$iStyle = _WinAPI_GetWindowLong(GUICtrlGetHandle($SaveButton), $GWL_STYLE)
	GUICtrlSetStyle($SaveButton, BitXOR($iStyle, $WS_TABSTOP))
	GUISetIcon(@ScriptDir & "\Resources.dll", 115, $FunctionGUI)
	GUISetState()
	If $Types[$RefNum] = 1 Or $Types[$RefNum] = 2 Or $Types[$RefNum] = 5 Or $Types[$RefNum] = 6 Or $Types[$RefNum] = 8 Or $Types[$RefNum] = 10 Or $Types[$RefNum] = 13 Or $Types[$RefNum] = 18 Then
		$FuncType &= "On Click"
	EndIf
	If $Types[$RefNum] = 3 Or $Types[$RefNum] = 4 Then
		If $FuncType <> "" Then
			$FuncType &= "|On Submit"
		Else
			$FuncType &= "On Submit"
		EndIf
	EndIf
	If $Types[$RefNum] = 3 Or $Types[$RefNum] = 4 Or $Types[$RefNum] = 7 Or $Types[$RefNum] = 8 Or $Types[$RefNum] = 9 Or $Types[$RefNum] = 16 Or $Types[$RefNum] = 17 Then
		If $FuncType <> "" Then
			$FuncType &= "|Data Changed"
		Else
			$FuncType &= "Data Changed"
		EndIf
	EndIf
	If $FuncType = "" Then
		GUICtrlSetState($TypeCombo, $GUI_DISABLE)
	EndIf
	If StringInStr($FuncType, "|") Then
		$FuncSplit = StringSplit($FuncType, "|")
		If StringInStr($Functions[$RefNum], "Þ") Then
			GUICtrlSetData($TypeCombo, $FuncType, $FuncSplit[2])
		Else
			GUICtrlSetData($TypeCombo, $FuncType, $FuncSplit[1])
		EndIf
	Else
		GUICtrlSetData($TypeCombo, $FuncType, $FuncType)
	EndIf
	While $FunctionMode = True
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($FunctionGUI)
				$FunctionMode = False
			Case $SaveButton
				$Existing = False
				If $Functions[$RefNum] <> "" Then
					$Existing = True
				EndIf
				$RefNum = _GetIndex($SelectedControl)
				$FuncType = GUICtrlRead($TypeCombo)
				Switch $FuncType
					Case "On Click"
						$Functions[$RefNum] = "à" & GUICtrlRead($FuncEdit)
					Case "On Submit"
						$Functions[$RefNum] = "à" & GUICtrlRead($FuncEdit)
					Case "Data Changed"
						$Functions[$RefNum] = "Þ" & GUICtrlRead($FuncEdit)
				EndSwitch
				GUIDelete($FunctionGUI)
				$FunctionMode = False
				If $Existing = False Then
					_GUICtrlTreeView_BeginUpdate($hTree)
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$RefNum], $FuncType)
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", -115)
					_GUICtrlTreeView_EndUpdate($hTree)
					_ArrayAdd($FunctionTrees, $SelectedControl & "|" & $hItem)
					$FunctionTrees[0] -= 1
				ElseIf $Existing = True And $Functions[$RefNum] = "" Then
					$hSearch = _ArraySearch($FunctionTrees, $SelectedControl, 1, $FunctionTrees[0], 0, 1)
					$Split = StringSplit($FunctionTrees[$hSearch], "|")
					_GUICtrlTreeView_BeginUpdate($hTree)
					$dELETE = _GUICtrlTreeView_Delete($hTree, $Split[2])
					_GUICtrlTreeView_EndUpdate($hTree)
					_ArrayDelete($FunctionTrees, $hSearch)
					$FunctionTrees[0] -= 1
				EndIf
				_SetScriptData()
		EndSwitch
		If _IsPressed("09") Then
			_GUICtrlEdit_InsertText($FuncEdit, @TAB, 0)
			Sleep(100)
		EndIf
	WEnd
EndFunc   ;==>_FuncMode
Func _ImportFile($hDir)
	Local $hSplit
	$hFile = FileOpen($hDir, 0)
	$hScript = FileRead($hFile)
	$hSplit = StringSplit($hScript, @CRLF, 1)
	FileClose($hFile)
	Dim $GUIList = ""
	$ImportMessage = True
	$ImportGUI = GUICreate("Script Import", 260, 282, -1, -1)
	$Label1 = GUICtrlCreateLabel("Select GUI's to Import:", 8, 6, 227, 15)
	$List2 = GUICtrlCreateListView("Handle|Title", 11, 22, 239, 227, $LVS_REPORT)
	_GUICtrlListView_SetColumnWidth($List2, 0, 100)
	_GUICtrlListView_SetColumnWidth($List2, 1, 100)
	$Button3 = GUICtrlCreateButton("Import", 151, 253, 104, 25)
	GUISetState()
	Dim $Count = 0, $SelectedGUIS[1] = [0]
	For $i = 1 To $hSplit[0] Step 1
		If StringInStr($hSplit[$i], "GUICreate(") Then
			If StringInStr($hSplit[$i], "=") Then
				$VarSplit = StringSplit($hSplit[$i], "=")
				_GUICtrlListView_AddItem($List2, StringStripWS($VarSplit[1], 8))
			Else
				_GUICtrlListView_AddItem($List2, " ")
			EndIf
			$ParSplit = StringSplit($hSplit[$i], "(")
			$ComSplit = StringSplit($ParSplit[2], ",")
			_GUICtrlListView_AddSubItem($List2, $Count, StringTrimRight(StringTrimLeft(StringStripWS($ComSplit[1], 3), 1), 1), 1)
			$Count += 1
		EndIf
	Next
	If $Count = 0 Then
		GUIDelete($ImportGUI)
		$ImportMessage = False
		MsgBox(0, "Import Error", "File failed to import, no GUI found.")
	Else
		While $ImportMessage = True
			$hMsg = GUIGetMsg()
			Switch $hMsg
				Case $GUI_EVENT_CLOSE
					GUIDelete($ImportGUI)
					$ImportMessage = False
					$ImportFile = False
				Case $Button3
					For $i = 0 To _GUICtrlListView_GetItemCount($List2)
						If _GUICtrlListView_GetItemSelected($List2, $i) = True Then
							_ArrayAdd($SelectedGUIS, _GUICtrlListView_GetItemText($List2, $i))
							$SelectedGUIS[0] += 1
						EndIf
					Next
					GUIDelete($ImportGUI)
					$ImportMessage = False
					$ImportFile = True
			EndSwitch
		WEnd
		If $ImportFile = True Then

			For $i = $GUIS[0] to 1 Step -1
				If BitAnd(WinGetState($GUIS[$i]), 2) Then
					_GDIPlus_GraphicsDispose($GUIPlus[$i])
					GUIDelete($GUIs[$i])
					_ArrayDelete($GUIs, $i)
					_ArrayDelete($GUIHandles, $i)
					_ArrayDelete($WinTitles, $i)
					_ArrayDelete($GUITrees, $i)
					_ArrayDelete($GUIColors, $i)
					_ArrayDelete($GUIVars, $i)
					_ArrayDelete($GUIScript, $i)
					_ArrayDelete($GUIComment, $i)
					_ArrayDelete($GUIStyle, $i)
					_ArrayDelete($GUIMenus, $i)
					_ArrayDelete($GUIProperties, $i)
					_ArrayDelete($GUIX, $i)
					_ArrayDelete($GUIY, $i)
					_ArrayDelete($GUISnapLineX, $i)
					_ArrayDelete($GUISnapLineY, $i)
					_ArrayDelete($GUISetStateData, $i)
					_ArrayDelete($GUIPlus, $i)
					_ArrayDelete($GUIParent, $i)
					$GUIParent[0] -= 1
					$GUIPlus[0] -= 1
					$GUISetStateData[0] -= 1
					$GUISnapLineX[0] -= 1
					$GUISnapLineY[0] -= 1
					$GUIX[0] -= 1
					$GUIY[0] -= 1
					$GUIProperties[0] -= 1
					$GUIMenus[0] -= 1
					$GUIComment[0] -= 1
					$GUIStyle[0] -= 1
					$GUIScript[0] -= 1
					$GUIVars[0] -= 1
					$GUIColors[0] -= 1
					$GUITrees[0] -= 1
					$GUIHandles[0] -= 1
					$WinTitles[0] -= 1
					$GUIs[0] -= 1
					$CurrentWindow = $i
				EndIf
			Next

			_GUICtrlTreeView_DeleteAll($hTree)
			_GUICtrlListView_BeginUpdate($LayerList)
			_GUICtrlListView_DeleteAllItems(GUICtrlGetHandle($LayerList))
			For $i = $Controls[0] To 1 Step -1
				_ArrayDelete($TreeItems, $i)
				$TreeItems[0] -= 1
			Next

			_ClearData()
			GUISetCursor(15, 1, $hGUI)

			$WindowNum = 1
			$LayerCount = 0
			$ControlNum = 1
			$DirSplit = StringSplit($hDir, "\")
			Dim $ScriptDir = ""
			For $i = 1 To $DirSplit[0] - 1 Step 1
				$ScriptDir &= $DirSplit[$i] & "\"
			Next
			$SaveName = $hDir
			GUICtrlSetState($Save, $GUI_ENABLE)

			_GUICtrlTreeView_BeginUpdate($hTree)

			$hFileTree = _GUICtrlTreeView_Add($hTree, 0, StringReplace($DirSplit[$DirSplit[0]], ".au3", ".gui"))
			_GUICtrlTreeView_SetIcon($hTree, $hFileTree, @ScriptDir & "\Resources.dll", -279)

			$hWinSize = WinGetClientSize($hGUI)
			$hImportProgress = GUICreate("Importing " & $DirSplit[$DirSplit[0]], 440, 72, ($hWinSize[0]-440)/2-20, ($hWinSize[1]-72)/2-150, BitOR($WS_CAPTION, $WS_SIZEBOX, $WS_SYSMENU))
			$hProgressBar = GUICtrlCreateProgress(5, 8, 430, 30)
			$hCancelBn = GUICtrlCreateButton("Cancel", 338, 44, 96, 23)
			GUISetState()
			DllCall($dll, "int", "SetParent", "hwnd", WinGetHandle($hImportProgress), "hwnd", WinGetHandle($hGUI))
			$GUIIndex = 0
			Dim $NoGUI = True
			$TabEnabled = False
			$AddingControl = True
			$AddingGUI = False
			$ControlNum = 1
			_GUICtrlTab_DeleteItem($GUITab, 0)
			$hCount = _GUICtrlTab_GetItemCount($GUITab)
			_GUICtrlTab_InsertItem($GUITab, 0, StringReplace($DirSplit[$DirSplit[0]], ".au3", ".gui"))
			_GUICtrlTab_SetCurSel($GUITab, $hCount)
			_GUICtrlListView_AddItem($LayerList, "Layer 0")
			_GUICtrlListView_EndUpdate($LayerList)
			Dim $GUIHandler, $ControlHandler, $CurrentRef, $Controls[1] = [0], $CurrentTab, $CurrentGroup, $GUIIndex = 0, $ExtraVars, $FuncRef, $AddingFunction = False, $AddingScript = False, $TabCount = 0, $ResizeTabs[1] = [0]
			$GUICount = $SelectedGUIS[0]
			For $i = 1 To $hSplit[0] Step 1
				If StringInStr($hSplit[$i], "GUICreate(") Then
					If StringInStr($hSplit[$i], "=") Then
						$VarSplit = StringSplit(StringReplace($hSplit[$i], @TAB, ""), "=")
						$hWinHandle = StringStripWS($VarSplit[1], 8)
					Else
						$hWinHandle = " "
					EndIf
					$NoGUI = False
					For $c = 1 To $SelectedGUIS[0] Step 1
						If $hWinHandle = $SelectedGUIS[$c] Then
							$AddingGUI = True
							$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
							$DataSplit = StringSplit($ComSplit[1], "(")
							$TempData = StringTrimLeft(StringTrimRight(StringStripWS($DataSplit[2], 3), 1), 1)
							$GUIHandler = GUICreate($TempData, 1000, 1000, 170, 100, BitOR($WS_CAPTION, $WS_SIZEBOX, $WS_SYSMENU))
							$TabTop = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
							GUICtrlSetBkColor(-1, $InsertColor)
							GUICtrlSetState(-1, $GUI_HIDE)
							GUICtrlSetResizing(-1, 802)
							$TabBottom = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
							GUICtrlSetBkColor(-1, $InsertColor)
							GUICtrlSetState(-1, $GUI_HIDE)
							GUICtrlSetResizing(-1, 802)
							$TabLeft = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
							GUICtrlSetBkColor(-1, $InsertColor)
							GUICtrlSetState(-1, $GUI_HIDE)
							GUICtrlSetResizing(-1, 802)
							$TabRight = GUICtrlCreateLabel("", 1, 1, 1, 1, $GUI_ONTOP)
							GUICtrlSetBkColor(-1, $InsertColor)
							GUICtrlSetState(-1, $GUI_HIDE)
							GUICtrlSetResizing(-1, 802)
							$SnapLineX = GUICtrlCreateLabel("", -5, -5, 1, 1)
							GUICtrlSetBkColor(-1, 0xFF00FF)
							$SnapLineY = GUICtrlCreateLabel("", -5, -5, 1, 1)
							GUICtrlSetBkColor(-1, 0xFF00FF)
							GUISetState(@SW_HIDE, $GUIHandler)
							DllCall($dll, "int", "SetParent", "hwnd", WinGetHandle($GUIHandler), "hwnd", WinGetHandle($GUIHolder))
							GUISetState(@SW_SHOW, $GUIHandler)

							$hGraphic = _GDIPlus_GraphicsCreateFromHWND($GUIHandler)
							WinMove($GUIHandler, "", 50, 50, $ComSplit[2]+9, $ComSplit[3]+34)

							$aName = _GetName($hSplit[$i])
							$hTreeGUI = _GUICtrlTreeView_AddChild($hTree, $hFileTree, $aName)
							_GUICtrlTreeView_SetIcon($hTree, $hTreeGUI, @ScriptDir & "\Resources.dll", -119)
							_ArrayAdd($GUIs, $GUIHandler)
							_ArrayAdd($GUIHandles, $aName)
							_ArrayAdd($GUIColors, "")
							_ArrayAdd($WinTitles, $TempData)
							_ArrayAdd($GUIVars, "")
							_ArrayAdd($GUITrees, $hTreeGUI)
							_ArrayAdd($GUIScript, "")
							_ArrayAdd($GUIComment, "")
							_ArrayAdd($GUIStyle, "")
							_ArrayAdd($GUIMenus, "")
							_ArrayAdd($GUIProperties, $CurrentWindow)
							_ArrayAdd($GUIX, "-1")
							_ArrayAdd($GUIY, "-1")
							_ArrayAdd($GUISetStateData, "")
							_ArrayAdd($GUISnapLineX, $SnapLineX)
							_ArrayAdd($GUISnapLineY, $SnapLineY)
							_ArrayAdd($GUIPlus, $hGraphic)
							_ArrayAdd($GUIParent, "0")
							$GUIParent[0] += 1
							$GUIPlus[0] += 1
							$GUISnapLineX[0] += 1
							$GUISnapLineY[0] += 1
							$GUISetStateData[0] += 1
							$GUIX[0] += 1
							$GUIY[0] += 1
							$GUIProperties[0] += 1
							$GUIMenus[0] += 1
							$GUIComment[0] += 1
							$GUIStyle[0] += 1
							$GUIScript[0] += 1
							$GUITrees[0] += 1
							$GUIVars[0] += 1
							$GUIs[0] += 1
							$GUIColors[0] += 1
							$WinTitles[0] += 1
							$GUIHandles[0] += 1
							$GUIIndex = $GUIs[0]
							$CurrentWindow = $GUIs[0]
						EndIf
					Next
				EndIf
				If $GUIIndex <> 0 Then
					If StringInStr($hSplit[$i], "GUICtrlCreateLabel(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringTrimLeft(StringTrimRight(StringStripWS($DataSplit[2], 3), 1), 1)
						$ComSplit = _ControlParameters($ComSplit, 5)
						$ControlHandler = GUICtrlCreateLabel($TempData, $ComSplit[2], $ComSplit[3], $ComSplit[4], $ComSplit[5])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, $TempData)
						_ArrayAdd($Types, 1)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateButton(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringTrimLeft(StringTrimRight(StringStripWS($DataSplit[2], 3), 1), 1)
						$ComSplit = _ControlParameters($ComSplit, 5)
						$ControlHandler = GUICtrlCreateButton($TempData, $ComSplit[2], $ComSplit[3], $ComSplit[4], $ComSplit[5])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, $TempData)
						_ArrayAdd($Types, 2)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateInput(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringTrimLeft(StringTrimRight(StringStripWS($DataSplit[2], 3), 1), 1)
						$ComSplit = _ControlParameters($ComSplit, 5)
						$ControlHandler = GUICtrlCreateInput($TempData, $ComSplit[2], $ComSplit[3], $ComSplit[4], $ComSplit[5])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, $TempData)
						_ArrayAdd($Types, 3)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateEdit(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringTrimLeft(StringTrimRight(StringStripWS($DataSplit[2], 3), 1), 1)
						$ComSplit = _ControlParameters($ComSplit, 5)
						$ControlHandler = GUICtrlCreateEdit($TempData, $ComSplit[2], $ComSplit[3], $ComSplit[4], $ComSplit[5])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, $TempData)
						_ArrayAdd($Types, 4)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateCheckbox(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringTrimLeft(StringTrimRight(StringStripWS($DataSplit[2], 3), 1), 1)
						$ComSplit = _ControlParameters($ComSplit, 5)
						$ControlHandler = GUICtrlCreateCheckbox($TempData, $ComSplit[2], $ComSplit[3], $ComSplit[4], $ComSplit[5])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, $TempData)
						_ArrayAdd($Types, 5)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateRadio(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringTrimLeft(StringTrimRight(StringStripWS($DataSplit[2], 3), 1), 1)
						$ComSplit = _ControlParameters($ComSplit, 5)
						$ControlHandler = GUICtrlCreateRadio($TempData, $ComSplit[2], $ComSplit[3], $ComSplit[4], $ComSplit[5])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, $TempData)
						_ArrayAdd($Types, 6)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateCombo(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringTrimLeft(StringTrimRight(StringStripWS($DataSplit[2], 3), 1), 1)
						$ComSplit = _ControlParameters($ComSplit, 5)
						$ControlHandler = GUICtrlCreateCombo($TempData, $ComSplit[2], $ComSplit[3], $ComSplit[4], $ComSplit[5])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, $TempData)
						_ArrayAdd($Types, 7)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateList(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringTrimLeft(StringTrimRight(StringStripWS($DataSplit[2], 3), 1), 1)
						$ComSplit = _ControlParameters($ComSplit, 5)
						$ControlHandler = GUICtrlCreateList($TempData, $ComSplit[2], $ComSplit[3], $ComSplit[4], $ComSplit[5])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, $TempData)
						_ArrayAdd($Types, 8)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateDate(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringTrimLeft(StringTrimRight(StringStripWS($DataSplit[2], 3), 1), 1)
						$ComSplit = _ControlParameters($ComSplit, 5)
						$ControlHandler = GUICtrlCreateDate($TempData, $ComSplit[2], $ComSplit[3], $ComSplit[4], $ComSplit[5])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, $TempData)
						_ArrayAdd($Types, 9)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreatePic(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringTrimLeft(StringTrimRight(StringStripWS($DataSplit[2], 3), 1), 1)
						$ComSplit = _ControlParameters($ComSplit, 5)
						$ControlHandler = GUICtrlCreatePic($TempData, $ComSplit[2], $ComSplit[3], $ComSplit[4], $ComSplit[5])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, $TempData)
						_ArrayAdd($Types, 10)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateIcon(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						_ArrayDisplay($ComSplit)
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringTrimLeft(StringTrimRight(StringStripWS($DataSplit[2], 3), 1), 1)
						$ComSplit = _ControlParameters($ComSplit, 6)
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, $TempData)
						_ArrayAdd($Types, 11)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateProgress(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$ComSplit = _ControlParameters($ComSplit, 4)
						$ControlHandler = GUICtrlCreateProgress($DataSplit[2], $ComSplit[2], $ComSplit[3], $ComSplit[4])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, "")
						_ArrayAdd($Types, 12)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateTab(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$ComSplit = _ControlParameters($ComSplit, 4)
						$ControlHandler = GUICtrlCreateTab($DataSplit[2], $ComSplit[2], $ComSplit[3], $ComSplit[4])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, "")
						_ArrayAdd($Types, 13)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						$CurrentRef = $ControlNum
						$CurrentTab = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateTreeView(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringStripWS($DataSplit[2], 3)
						$ComSplit = _ControlParameters($ComSplit, 4)
						$ControlHandler = GUICtrlCreateTreeView($TempData, $ComSplit[2], $ComSplit[3], $ComSplit[4])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, $TempData)
						_ArrayAdd($Types, 16)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateSlider(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringStripWS($DataSplit[2], 3)
						$ComSplit = _ControlParameters($ComSplit, 4)
						$ControlHandler = GUICtrlCreateSlider($TempData, $ComSplit[2], $ComSplit[3], $ComSplit[4])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, "0")
						_ArrayAdd($Types, 17)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateListView(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringTrimLeft(StringTrimRight(StringStripWS($DataSplit[2], 3), 1), 1)
						$ComSplit = _ControlParameters($ComSplit, 5)
						$ControlHandler = GUICtrlCreateListView($TempData, $ComSplit[2], $ComSplit[3], $ComSplit[4], $ComSplit[5])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, $TempData)
						_ArrayAdd($Types, 18)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateGraphic(") Then
						$ComSplit = StringSplit(StringTrimRight($hSplit[$i], 1), ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringStripWS($DataSplit[2], 3)
						$ComSplit = _ControlParameters($ComSplit, 4)
						$ControlHandler = GUICtrlCreateGraphic($TempData, $ComSplit[2], $ComSplit[3], $ComSplit[4])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, $TempData)
						_ArrayAdd($Types, 19)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateDummy(") Then
						$ComSplit = StringSplit($hSplit[$i], ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$ControlHandler = GUICtrlCreateDummy()
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, StringTrimLeft(StringTrimRight($DataSplit[2], 1), 1))
						_ArrayAdd($Types, 20)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						$CurrentRef = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateGroup(") Then
						$ComSplit = StringSplit($hSplit[$i], ",")
						$DataSplit = StringSplit($ComSplit[1], "(")
						$TempData = StringTrimLeft(StringTrimRight(StringStripWS($DataSplit[2], 3), 1), 1)
						$ComSplit = _ControlParameters($ComSplit, 5)
						$ControlHandler = GUICtrlCreateGroup($TempData, $ComSplit[2], $ComSplit[3], $ComSplit[4], $ComSplit[5])
						GUICtrlSetResizing(-1, 802)
						GUISetState()
						$aName = _GetName($hSplit[$i])
						_ArrayAdd($Controls, $ControlHandler)
						_ArrayAdd($Data, $TempData)
						_ArrayAdd($Types, 21)
						_ArrayAdd($Names, $aName)
						$Names[0] += 1
						$Controls[0] += 1
						$Data[0] += 1
						$Types[0] += 1
						_ImportDefaultVars($GUIIndex)
						_CreateResizeTabs($ControlHandler)
						_ApplyTab($ControlNum, $CurrentTab)
						$CurrentRef = $ControlNum
						$CurrentGroup = $ControlNum
						$ControlNum += 1
					EndIf
					If StringInStr($hSplit[$i], "GUICtrlCreateTabItem(") Then
						$VarSplit = StringSplit(StringStripWS($hSplit[$i], 8), "(")
						GUICtrlCreateTabItem(StringTrimRight(StringStripWS(StringTrimLeft($VarSplit[2], 1),3), 2))
						If $Data[$CurrentTab] = "" Then
							$Data[$CurrentTab] = StringTrimRight(StringStripWS(StringTrimLeft($VarSplit[2], 1),3), 2)
						Else
							$Data[$CurrentTab] &= "|" & StringTrimRight(StringStripWS(StringTrimLeft($VarSplit[2], 1),3), 2)
						EndIf
						GUICtrlSetResizing(-1, 802)
						GUICtrlSetState(-1, $GUI_SHOW)
						$TabEnabled = True
					EndIf
					If $AddingScript = True Then
						If $hSplit[$i] = "EndFunc" Then
							$AddingScript = False
						EndIf
						$GUIScript[$GUIIndex] &= $hSplit[$i] & @CRLF
					EndIf
					If StringLeft($hSplit[$i], 4) = "Func" And StringInStr($hSplit[$i], "(") And StringInStr($hSplit[$i], ")") Then
						$AddingScript = True
						$GUIScript[$GUIIndex] &= @CRLF & $hSplit[$i] & @CRLF
					EndIf
					If StringInStr(StringStripWS($hSplit[$i], 8), "GUICtrlSetBkColor(-1,") Then
						If StringInStr($hSplit[$i], "$GUI_BKCOLOR_TRANSPARENT") Then
							$BkColors[$CurrentRef] = "Trans"
						Else
							$VarSplit = StringSplit(StringReplace(StringReplace(StringStripWS($hSplit[$i], 8), "'", ""), '"', ""), ",")
							$BkColors[$CurrentRef] = StringTrimRight(StringTrimLeft($VarSplit[2], 2), 1)
							GUICtrlSetBkColor($Controls[$CurrentRef], "0x" & $BkColors[$CurrentRef])
						EndIf
					EndIf
					If StringInStr(StringStripWS($hSplit[$i], 8), "GUICtrlSetData(-1,") Then
						Dim $DataVar = ""
						$VarSplit = StringSplit($hSplit[$i], ",")
						If $VarSplit[0] = 2 Then
							$DataVar = StringTrimRight($VarSplit[2], 1)
						Else
							For $d = 2 To $VarSplit[0] Step 1
								If $d = $VarSplit[0] Then
									$DataVar &= StringTrimRight($VarSplit[$d], 1)
								Else
									$DataVar &= $VarSplit[$d]
								EndIf
							Next
						EndIf
						If StringLeft(StringStripWS($DataVar, 3), 1) = "'" Or StringLeft(StringStripWS($DataVar, 3), 1) = '"' Then
							$Data[$CurrentRef] = StringTrimLeft(StringTrimRight(StringStripWS($DataVar, 3), 1), 1)
						Else
							$Data[$CurrentRef] = StringStripWS($DataVar, 3)
						EndIf
						GUICtrlSetData($Controls[$CurrentRef], $Data[$CurrentRef])
					EndIf
					If StringInStr(StringStripWS($hSplit[$i], 8), "GUICtrlSetFont(-1,") Then
						$ComSplit = StringSplit($hSplit[$i], ",")
						$ComSplit[$ComSplit[0]] = StringTrimRight($ComSplit[$ComSplit[0]], 1)
						$FontSize[$CurrentRef] = $ComSplit[2]
						If $ComSplit[0] >= 3 Then
							If StringStripWS($ComSplit[3], 8) <> "400" Then
								$FontInfo[$CurrentRef] &= "+0+"
							EndIf
						EndIf
						If $ComSplit[0] >= 4 Then
							$ComSplit[4] = StringStripWS($ComSplit[4], 8)
							Dim $FontAttributes = "0"
							If BitAND($ComSplit[4], 2) Then
								$FontInfo[$CurrentRef] &= "+2+"
								$FontAttributes += 2
							EndIf
							If BitAND($ComSplit[4], 4) Then
								$FontInfo[$CurrentRef] &= "+4+"
								$FontAttributes += 4
							EndIf
							If BitAND($ComSplit[4], 8) Then
								$FontInfo[$CurrentRef] &= "+8+"
								$FontAttributes += 8
							EndIf
						EndIf
						If $ComSplit[0] >= 5 Then
							$Font[$CurrentRef] = StringReplace(StringReplace($ComSplit[5], "'", ""), '"', "")
						EndIf
						If StringInStr($FontInfo[$CurrentRef], "+0+") Then
							GUICtrlSetFont($Controls[$CurrentRef], $FontSize[$CurrentRef], "800", $FontAttributes, $Font[$CurrentRef])
						Else
							GUICtrlSetFont($Controls[$CurrentRef], $FontSize[$CurrentRef], "400", $FontAttributes, $Font[$CurrentRef])
						EndIf
					EndIf
					If StringInStr(StringStripWS($hSplit[$i], 8), "GUICtrlSetImage(-1,") Then
						$ComSplit = StringSplit($hSplit[$i], ",")
						$VarSplit = StringReplace(StringReplace(StringStripWS($ComSplit[2], 3), "'", ""), '"', "")
						$Images[$CurrentRef] = StringTrimRight($VarSplit, 1)
						GUICtrlSetImage($Controls[$CurrentRef], $Images[$CurrentRef])
					EndIf
					If StringInStr(StringStripWS($hSplit[$i], 8), "GUICtrlSetColor(-1,") Then
						$VarSplit = StringSplit(StringReplace(StringReplace(StringStripWS($hSplit[$i], 8), "'", ""), '"', ""), ",")
						$Colors[$CurrentRef] = StringTrimRight(StringTrimLeft($VarSplit[2], 2), 1)
						GUICtrlSetColor($Controls[$CurrentRef], "0x" & $Colors[$CurrentRef])
					EndIf
					If StringInStr(StringStripWS($hSplit[$i], 8), "GUICtrlSetStyle(-1,") Then
						$VarSplit = StringSplit(StringStripWS($hSplit[$i], 8), ",")
						$Styles[$CurrentRef] = StringTrimRight($VarSplit[2], 1)
						If StringInStr($Styles[$CurrentRef], "$TBS_VERT") Then
							GUICtrlSetStyle($Controls[$CurrentRef], $TBS_VERT)
						EndIf
					EndIf
				EndIf
				If StringInStr($hSplit[$i], "#include <") = False And $NoGUI = True Then
					If $ExtraVars = "" Then
						$ExtraVars = $hSplit[$i] & @CRLF
					Else
						If $hSplit[$i] <> @CRLF Then
							$ExtraVars &= $hSplit[$i] & @CRLF
						EndIf
					EndIf
				EndIf
				If StringInStr($hSplit[$i], "GUISetState(") Then
					If $AddingGUI = True Then
						$AddingGUI = False
						If $GUICount = 1 Then
							ExitLoop
						EndIf
						$GUICount -= 1
					EndIf
				EndIf
				GUICtrlSetData($hProgressBar, ($i / $hSplit[0]) * 50)
			Next
			Dim $AddFunc = False, $FuncIndex = 0
			For $i = 1 To $hSplit[0] Step 1
				For $c = 1 To $Names[0] Step 1
					If StringInStr(StringStripWS($hSplit[$i], 8), "GUICtrlSetImage($" & $Names[$c] & ",") = True Then
						$VarSplit = StringSplit(StringStripWS($hSplit[$i], 8), ",")
						$VarSplit[$VarSplit[0]] = StringReplace($VarSplit[$VarSplit[0]], ")", "")
						$Images[$c] = StringReplace(StringReplace(StringTrimRight($VarSplit[2], 1), "'", ""), '"', "")
						If StringInStr($Images[$c], "@ScriptDir") Then
							$Images[$c] = StringReplace($Images[$c], "@ScriptDir&\", $ScriptDir)
						EndIf
						$TypeSplit = StringSplit($Images[$c], ".")
						If $TypeSplit[2] = "jpg" Or $TypeSplit[2] = "bmp" Or $TypeSplit[2] = "gif" Then
							If $Types[$c] = 2 Then
								GUICtrlSetStyle($Controls[$c], $BS_BITMAP)
								$Styles[$c] = "$BS_BITMAP"
							EndIf
						ElseIf $TypeSplit[2] = "ico" Then
							If $Types[$c] = 2 Then
								GUICtrlSetStyle($Controls[$c], $BS_ICON)
								$Styles[$c] = "$BS_ICON"
							EndIf
						ElseIf $TypeSplit[2] = "dll" Then
							If $Types[$c] = 2 Then
								GUICtrlSetStyle($Controls[$c], $BS_ICON)
								$Styles[$c] = "$BS_ICON"
							EndIf
						EndIf
						If $VarSplit[0] = 4 Then
							GUICtrlSetImage($Controls[$c], $Images[$c], $VarSplit[3], $VarSplit[4])
							$Images[$c] = $Images[$c]&"|"&$VarSplit[3]&"|"&$VarSplit[4]
						Else
							GUICtrlSetImage($Controls[$c], $Images[$c])
						EndIf
					EndIf
				Next
				If $AddFunc = True and StringinStr($hSplit[$i], "Switch") Then
					$ExtraSwitch = True
				EndIf
				If $AddFunc = True and StringinStr($hSplit[$i], "Case") Then
					$AddFunc = False
					$hCtrlName = StringTrimLeft(StringReplace($hSplit, @TAB, ""), 6)
					$hIndex = _NameToIndex($hCtrlName)
					If $hIndex <> 0 Then
						$AddFunc = True
						$FuncIndex = $hIndex
					EndIf
				ElseIf $AddFunc = True and StringinStr($hSplit[$i], "EndSwitch") Then
					$AddFunc = False
					$FuncIndex = 0
				ElseIf $AddFunc = True and StringinStr($hSplit[$i], "EndSwitch") = False and StringinStr($hSplit[$i], "Case") = False Then
					$Functions[$FuncIndex] &= $hSplit[$i]&@CRLF
				EndIf
				If StringinStr($hSplit[$i], "Case") Then
					$hCtrlName = StringTrimLeft(StringReplace($hSplit, @TAB, ""), 6)
					$hIndex = _NameToIndex($hCtrlName)
					If $hIndex <> 0 Then
						$AddFunc = True
						$FuncIndex = $hIndex
					EndIf
				EndIf
				GUICtrlSetData($hProgressBar, 50 + (($i / $hSplit[0]) * 50))
			Next
			GUISetState(@SW_ENABLE, $GUIS[$CurrentWindow])
			For $i = 1 to $Controls[0] Step 1
				If $Types[$i] = 21 Then
					$hPoint = ControlGetPos($GUIS[$CurrentWindow], "", $Controls[$i])
					If Not @error Then
						For $c = 1 to $Controls[0] Step 1
							$hPos = ControlGetPos($GUIS[$CurrentWindow], "", $Controls[$c])
							If Not @error Then
								If $hPos[0] > $hPoint[0] And $hPos[1] > $hPoint[1] And $hPos[0] < $hPoint[0] + $hPoint[2] And $hPos[1] < $hPoint[1] + $hPoint[3] Then
									$Attributes[$c] = $Names[$i] & "Ð"
								EndIf
							EndIf
						Next
					EndIf
				EndIf
			Next
			$GUIVars[$GUIIndex] = $ExtraVars
			Dim $TreeItems[1] = [0]
			Dim $MoveAfter[1] = [0]
			For $i = 1 To $Controls[0] Step 1
				If $Attributes[$i] = "0" Then
					$tItem = _AddTreeItem($Names[$i], $Types[$i], $Parents[$i])
				Else
					If StringInStr($Attributes[$i], "ø") Then
						$hSplit = StringSplit($Attributes[$i], "ø")
						$hIndex = _ArraySearch($Names, $hSplit[1])
						$ItemHandle = _GUICtrlTreeView_FindItem($hTree, "hTabItem" & $hSplit[2], False, 0)
						If $ItemHandle = 0 Then
							$hTabItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "hTabItem" & $hSplit[2])
							_GUICtrlTreeView_SetIcon($hTree, $hTabItem, @ScriptDir & "\Resources.dll", _GetIcon(13))
							$hItem = _GUICtrlTreeView_AddChild($hTree, $hTabItem, $Names[$i])
							_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$i]))
						Else
							$hItem = _GUICtrlTreeView_AddChild($hTree, $ItemHandle, $Names[$i])
							_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$i]))
						EndIf
						_ArrayAdd($TreeItems, $hItem)
						$TreeItems[0] += 1
					EndIf
					If StringInStr($Attributes[$i], "Ð") Then
						$hSplit = StringTrimRight($Attributes[$i], 1)
						$hIndex = _ArraySearch($Names, $hSplit)
						$hItemHandle = _GUICtrlTreeView_FindItem($hTree, $Names[$hIndex])
						If $hItemHandle = 0 Then
							$hItem = _GUICtrlTreeView_AddChild($hTree, $GUITrees[$CurrentWindow], $Names[$i])
							_ArrayAdd($MoveAfter, $hItem)
							$MoveAfter[0] += 1
						Else
							$hItem = _GUICtrlTreeView_AddChild($hTree, $hItemHandle, $Names[$i])
						EndIf
						_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$i]))
						_ArrayAdd($TreeItems, $hItem)
						$TreeItems[0] += 1
					EndIf
				EndIf
			Next
			If $MoveAfter[0] >= 1 Then
				For $i = 1 to $TreeItems[0] Step 1
					For $b = 1 to $MoveAfter[0] Step 1
						If $MoveAfter[$b] = $TreeItems[$i] Then
							_GUICtrlTreeView_Delete($hTree, $TreeItems[$i])
							$hSplit = StringTrimRight($Attributes[$i], 1)
							$hIndex = _ArraySearch($Names, $hSplit)
							$hItemHandle = _GUICtrlTreeView_FindItem($hTree, $Names[$hIndex])
							$hItem = _GUICtrlTreeView_AddChild($hTree, $hItemHandle, $Names[$i])
							_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$i]))
							$TreeItems[$i] = $hItem
						EndIf
					Next
				Next
			EndIf
			$AddingControl = False
			GUISetState(@SW_SHOW, $GUIHandler)
			GUIDelete($hImportProgress)
			_GUICtrlTreeView_EndUpdate($hTree)
			_SetScriptData()
		EndIf
	EndIf
	GUISetCursor(2, 1, $hGUI)
EndFunc   ;==>_ImportFile
Func _ApplyTab($hNum, $hTab) ; Apply controls to Tabs while Importing
	If $TabEnabled = True Then
		$SelectedTab = _GUICtrlTab_GetCurSel($Controls[$hTab]) + 1
		$Attributes[$hNum] = $Names[$hTab] & "ø" & $SelectedTab
		_GUICtrlTab_ActivateTab($Controls[$hTab], $SelectedTab - 1)
		GUISwitch($GUIs[$CurrentWindow], GUICtrlRead($Controls[$hTab], 1))
	EndIf
EndFunc   ;==>_ApplyTab
Func _ApplyGroups($hNum, $hGroup)
	If $hGroup <> "" Then
		$hPos = ControlGetPos("", "", $Controls[$hGroup])
		If Not @error Then
			$hPoint = ControlGetPos("", "", $Controls[$hNum])
			If Not @error Then
				If $hPoint[0] > $hPos[0] And $hPoint[1] > $hPos[1] And $hPoint[0] < $hPos[0] + $hPos[2] And $hPoint[1] < $hPos[1] + $hPos[3] Then
					$Attributes[$hNum] = $Names[$hGroup] & "Ð"
				EndIf
			EndIf
		EndIf
	EndIf
EndFunc   ;==>_ApplyGroup
Func _GetName($hName)
	If StringInStr($hName, "=") Then
		$hSplit = StringSplit($hName, "=")
		Return StringStripWS(StringReplace($hSplit[1], "$", ""), 8)
	Else
		Return "Control" & $ControlNum
	EndIf
EndFunc   ;==>_GetName
Func _AddDefaultVars()
	_ArrayAdd($BkColors, "")
	_ArrayAdd($Images, "")
	_ArrayAdd($Resize, "")
	_ArrayAdd($States, "$GUI_SHOW")
	_ArrayAdd($Font, $DefaultFont)
	_ArrayAdd($FontInfo, "")
	_ArrayAdd($FontSize, 8.5)
	_ArrayAdd($Colors, "")
	_ArrayAdd($Layers, "0")
	_ArrayAdd($Cursors, "2")
	_ArrayAdd($Functions, "")
	_ArrayAdd($Styles, "")
	_ArrayAdd($Attributes, "0")
	_ArrayAdd($Comments, "")
	_ArrayAdd($Locked, "0")
	_ArrayAdd($Parents, $GUIHandles[_GetCurrentWin()])
	$Parents[0] += 1
	$Locked[0] += 1
	$Comments[0] += 1
	$Attributes[0] += 1
	$Styles[0] += 1
	$Images[0] += 1
	$Resize[0] += 1
	$States[0] += 1
	$Font[0] += 1
	$FontInfo[0] += 1
	$FontSize[0] += 1
	$Colors[0] += 1
	$Layers[0] += 1
	$Cursors[0] += 1
	$Functions[0] += 1
	$BkColors[0] += 1
EndFunc   ;==>_AddDefaultVars
Func _ImportDefaultVars($hCurrentWindow)
	_ArrayAdd($BkColors, "")
	_ArrayAdd($Images, "")
	_ArrayAdd($Resize, "")
	_ArrayAdd($States, "$GUI_SHOW")
	_ArrayAdd($Font, $DefaultFont)
	_ArrayAdd($FontInfo, "")
	_ArrayAdd($FontSize, 8.5)
	_ArrayAdd($Colors, "")
	_ArrayAdd($Layers, "0")
	_ArrayAdd($Cursors, "2")
	_ArrayAdd($Functions, "")
	_ArrayAdd($Styles, "")
	_ArrayAdd($Attributes, "0")
	_ArrayAdd($Comments, "")
	_ArrayAdd($Locked, "0")
	_ArrayAdd($Parents, $GUIHandles[$hCurrentWindow])
	$Parents[0] += 1
	$Locked[0] += 1
	$Comments[0] += 1
	$Attributes[0] += 1
	$Styles[0] += 1
	$Images[0] += 1
	$Resize[0] += 1
	$States[0] += 1
	$Font[0] += 1
	$FontInfo[0] += 1
	$FontSize[0] += 1
	$Colors[0] += 1
	$Layers[0] += 1
	$Cursors[0] += 1
	$Functions[0] += 1
	$BkColors[0] += 1
EndFunc   ;==>_ImportDefaultVars
Func WM_SYSCOMMAND($hWnd, $Msg, $wParam, $lParam)
	Switch BitAND($wParam, 0x0000FFFF)
		Case 0xF120
			If $WasMax = True Then
				$WasMax = False
				$MaximizeControls = True
			EndIf
		Case 0xF030
			$WasMax = True
			$MaximizeControls = True
	EndSwitch
	Return "GUI_RUNDEFMSG"
EndFunc   ;==>WM_SYSCOMMAND
Func WM_SIZING($hWndGUI, $MsgID, $wParam, $lParam)
	If BitAND(WinGetState($hGUI), 8) Then
		$wPos = WinGetPos($hGUI)
		$hSize = WinGetClientSize($hGUI)
		$tRect = DllStructCreate($tagRect, $lParam)
		$left = DllStructGetData($tRect, "left")
		$top = DllStructGetData($tRect, "top")
		$right = DllStructGetData($tRect, "right")
		$bottom = DllStructGetData($tRect, "bottom")
		$hLinePos = ControlGetPos($hGUI, "", $BottomLine)
		$ResizeDivider = $hLinePos[1]
		If ($right - $left) <> $Width And ($bottom - $top) <> $Height Then
			$hPos = ControlGetPos("", "", $ScriptEdit)
			_WinAPI_SetWindowPos($ScriptEdit, 0, $hPos[0], $hPos[1] + (($bottom - $top) - $Height), $hPos[2] + (($right - $left) - $Width), $hPos[3], $SWP_NOZORDER)
			$Width = ($right - $left)
			$Height = ($bottom - $top)
			WinMove($GUIHolder, "", 152, 52, $Width - 368, $ResizeDivider - 52)
		ElseIf ($right - $left) <> $Width Then
			$hPos = ControlGetPos("", "", $ScriptEdit)
			_WinAPI_SetWindowPos($ScriptEdit, 0, 0, 0, $hPos[2] + (($right - $left) - $Width), $hPos[3], BitOR($SWP_NOMOVE, $SWP_NOZORDER))
			$Width = ($right - $left)
			$Height = ($bottom - $top)
			WinMove($GUIHolder, "", 152, 52, $Width - 368, $ResizeDivider - 52)
		ElseIf ($bottom - $top) <> $Height Then
			$hPos = ControlGetPos("", "", $ScriptEdit)
			_WinAPI_SetWindowPos($ScriptEdit, 0, $hPos[0], $hPos[1] + (($bottom - $top) - $Height), $hPos[2], $hPos[3], $SWP_NOZORDER)
			$Width = ($right - $left)
			$Height = ($bottom - $top)
			WinMove($GUIHolder, "", 152, 52, $Width - 368, $ResizeDivider - 52)
		EndIf
	EndIf
EndFunc   ;==>WM_SIZING
Func _SetScriptData()
	$WritingLine = 0
	$WritingControl = False
	$WritingCtrlData = ''
	Global $hScriptData
	_GUICtrlRichEdit_PauseRedraw($ScriptEdit)
	$hScroll = _GUICtrlRichEdit_GetScrollPos($ScriptEdit)
	$hScriptData = _GenerateCode()
	_GUICtrlRichEdit_SetText($ScriptEdit, $hScriptData)
	_RESH_SyntaxHighlight($ScriptEdit, '_UpdateStats')
	_GUICtrlRichEdit_SetScrollPos($ScriptEdit, $hScroll[0], $hScroll[1])
	_GUICtrlRichEdit_ResumeRedraw($ScriptEdit)
EndFunc   ;==>_SetScriptData
Func _GetIcon($Type)
	Switch $Type
		Case 1
			Return -122
		Case 2
			Return -103
		Case 3
			Return -121
		Case 4
			Return -114
		Case 5
			Return -105
		Case 6
			Return -129
		Case 7
			Return -107
		Case 8
			Return -123
		Case 9
			Return -111
		Case 10
			Return -127
		Case 11
			Return -120
		Case 12
			Return -128
		Case 13
			Return -135
		Case 14
			Return -138
		Case 15
			Return -126
		Case 16
			Return -136
		Case 17
			Return -133
		Case 18
			Return -124
		Case 19
			Return -116
		Case 20
			Return -113
		Case 21
			Return -118
		Case 22
			Return -104
		Case 23
			Return -288
		Case 24
			Return -289
		Case 25
			Return -291
		Case 26
			Return -292
	EndSwitch
EndFunc   ;==>_GetIcon


Func _GetStyles($hRef)
	If $hRef = 1 Then
		Return "$GUI_SS_DEFAULT_LABEL|$SS_BLACKFRAME|$SS_BLACKRECT|$SS_CENTER|$SS_CENTERIMAGE|$SS_ETCHEDFRAME|$SS_ETCHEDHORZ|$SS_ETCHEDVERT|$SS_GRAYFRAME|$SS_GRAYRECT|$SS_LEFT|$SS_LEFTNOWORDWRAP|$SS_NOPREFIX|$SS_NOTIFY|$SS_RIGHT|$SS_RIGHTJUST|$SS_SIMPLE|$SS_SUNKEN|$SS_WHITEFRAME|$SS_WHITERECT"
	ElseIf $hRef = 2 Then
		Return "$GUI_SS_DEFAULT_BUTTON|$BS_BOTTOM|$BS_CENTER|$BS_DEFPUSHBUTTON|$BS_MULTILINE|$BS_TOP|$BS_VCENTER|$BS_ICON|$BS_BITMAP|$BS_FLAT|$BS_NOTIFY"
	ElseIf $hRef = 3 Then
		Return "$GUI_SS_DEFAULT_INPUT|$ES_AUTOHSCROLL|$ES_AUTOVSCROLL|$ES_CENTER|$ES_LOWERCASE|$ES_NOHIDESEL|$ES_NUMBER|$ES_OEMCONVERT|$ES_MULTILINE|$ES_PASSWORD|$ES_READONLY|$ES_RIGHT|$ES_UPPERCASE|$ES_WANTRETURN"
	ElseIf $hRef = 4 Then
		Return "$GUI_SS_DEFAULT_EDIT|$GUI_SS_DEFAULT_INPUT|$ES_AUTOHSCROLL|$ES_AUTOVSCROLL|$ES_CENTER|$ES_LOWERCASE|$ES_NOHIDESEL|$ES_NUMBER|$ES_OEMCONVERT|$ES_MULTILINE|$ES_PASSWORD|$ES_READONLY|$ES_RIGHT|$ES_UPPERCASE|$ES_WANTRETURN"
	ElseIf $hRef = 5 Then
		Return "$GUI_SS_DEFAULT_CHECKBOX|$BS_3STATE|$BS_AUTO3STATE|$BS_AUTOCHECKBOX|$BS_CHECKBOX|$BS_LEFT|$BS_PUSHLIKE|$BS_RIGHT|$BS_RIGHTBUTTON|$BS_GROUPBOX|$BS_AUTORADIOBUTTON"
	ElseIf $hRef = 6 Then
		Return "$GUI_SS_DEFAULT_CHECKBOX|$BS_3STATE|$BS_AUTO3STATE|$BS_AUTOCHECKBOX|$BS_CHECKBOX|$BS_LEFT|$BS_PUSHLIKE|$BS_RIGHT|$BS_RIGHTBUTTON|$BS_GROUPBOX|$BS_AUTORADIOBUTTON"
	ElseIf $hRef = 7 Then
		Return "$GUI_SS_DEFAULT_COMBO|$CBS_AUTOHSCROLL|$CBS_DISABLENOSCROLL|$CBS_DROPDOWN|$CBS_DROPDOWNLIST|$CBS_LOWERCASE|$CBS_NOINTEGRALHEIGHT|$CBS_OEMCONVERT|$CBS_SIMPLE|$CBS_SORT|$CBS_UPPERCASE"
	ElseIf $hRef = 8 Then
		Return "$GUI_SS_DEFAULT_LIST|$LBS_DISABLENOSCROLL|$LBS_NOINTEGRALHEIGHT|$LBS_NOSEL|$LBS_NOTIFY|$LBS_SORT|$LBS_STANDARD|$LBS_USETABSTOPS"
	ElseIf $hRef = 9 Then
		Return "$GUI_SS_DEFAULT_DATE|$DTS_UPDOWN|$DTS_SHOWNONE|$DTS_LONGDATEFORMAT|$DTS_TIMEFORMAT|$DTS_RIGHTALIGN|$DTS_SHORTDATEFORMAT"
	ElseIf $hRef = 10 Then
		Return "$GUI_SS_DEFAULT_PIC|$SS_BLACKFRAME|$SS_BLACKRECT|$SS_CENTER|$SS_CENTERIMAGE|$SS_ETCHEDFRAME|$SS_ETCHEDHORZ|$SS_ETCHEDVERT|$SS_GRAYFRAME|$SS_GRAYRECT|$SS_LEFT|$SS_LEFTNOWORDWRAP|$SS_NOPREFIX|$SS_NOTIFY|$SS_RIGHT|$SS_RIGHTJUST|$SS_SIMPLE|$SS_SUNKEN|$SS_WHITEFRAME|$SS_WHITERECT"
	ElseIf $hRef = 11 Then
		Return "$GUI_SS_DEFAULT_ICON|$SS_BLACKFRAME|$SS_BLACKRECT|$SS_CENTER|$SS_CENTERIMAGE|$SS_ETCHEDFRAME|$SS_ETCHEDHORZ|$SS_ETCHEDVERT|$SS_GRAYFRAME|$SS_GRAYRECT|$SS_LEFT|$SS_LEFTNOWORDWRAP|$SS_NOPREFIX|$SS_NOTIFY|$SS_RIGHT|$SS_RIGHTJUST|$SS_SIMPLE|$SS_SUNKEN|$SS_WHITEFRAME|$SS_WHITERECT"
	ElseIf $hRef = 12 Then
		Return "$GUI_SS_DEFAULT_PROGRESS|$PBS_SMOOTH|$PBS_VERTICAL"
	ElseIf $hRef = 13 Then
		Return "$GUI_SS_DEFAULT_TAB|$TCS_SCROLLOPPOSITE|$TCS_BOTTOM|$TCS_RIGHT|$TCS_MULTISELECT|$TCS_FLATBUTTONS|$TCS_FORCEICONLEFT|$TCS_FORCELABELLEFT|$TCS_HOTTRACK|$TCS_VERTICAL|$TCS_TABS|$TCS_BUTTONS|$TCS_SINGLELINE|$TCS_MULTILINE|$TCS_RIGHTJUSTIFY|$TCS_FIXEDWIDTH|$TCS_RAGGEDRIGHT|$TCS_FOCUSONBUTTONDOWN|$TCS_OWNERDRAWFIXED|$TCS_TOOLTIPS|$TCS_FOCUSNEVER"
	ElseIf $hRef = 14 Then
		Return "$GUI_SS_DEFAULT_UPDOWN|$UDS_ALIGNLEFT|$UDS_ALIGNRIGHT|$UDS_ARROWKEYS|$UDS_HORZ|$UDS_NOTHOUSANDS|$UDS_WRAP"
	ElseIf $hRef = 16 Then
		Return "$GUI_SS_DEFAULT_TREEVIEW|$TVS_HASBUTTONS|$TVS_HASLINES|$TVS_LINESATROOT|$TVS_DISABLEDRAGDROP|$TVS_SHOWSELALWAYS|$TVS_RTLREADING|$TVS_NOTOOLTIPS|$TVS_CHECKBOXES|$TVS_TRACKSELECT|$TVS_SINGLEEXPAND|$TVS_FULLROWSELECT|$TVS_NOSCROLL|$TVS_NONEVENHEIGHT"
	ElseIf $hRef = 17 Then
		Return "$GUI_SS_DEFAULT_SLIDER|$TBS_AUTOTICKS|$TBS_BOTH|$TBS_BOTTOM|$TBS_HORZ|$TBS_VERT|$TBS_NOTHUMB|$TBS_NOTICKS|$TBS_LEFT|$TBS_RIGHT|$TBS_TOP"
	ElseIf $hRef = 18 Then
		Return "$GUI_SS_DEFAULT_LISTVIEW|$LVS_ICON|$LVS_REPORT|$LVS_SMALLICON|$LVS_LIST|$LVS_EDITLABELS|$LVS_NOCOLUMNHEADER|$LVS_NOSORTHEADER|$LVS_SINGLESEL|$LVS_SHOWSELALWAYS|$LVS_SORTASCENDING|$LVS_SORTDESCENDING|$LVS_NOLABELWRAP|$LVS_EX_FULLROWSELECT|$LVS_EX_GRIDLINES|$LVS_EX_HEADERDRAGDROP|$LVS_EX_TRACKSELECT|$LVS_EX_CHECKBOXES|$LVS_EX_BORDERSELECT|$LVS_EX_DOUBLEBUFFER|$LVS_EX_FLATSB|$LVS_EX_MULTIWORKAREAS|$LVS_EX_SNAPTOGRID|$LVS_EX_SUBITEMIMAGES"
	ElseIf $hRef = 19 Then
		Return "$GUI_SS_DEFAULT_LABEL|$SS_BLACKFRAME|$SS_BLACKRECT|$SS_CENTER|$SS_CENTERIMAGE|$SS_ETCHEDFRAME|$SS_ETCHEDHORZ|$SS_ETCHEDVERT|$SS_GRAYFRAME|$SS_GRAYRECT|$SS_LEFT|$SS_LEFTNOWORDWRAP|$SS_NOPREFIX|$SS_NOTIFY|$SS_RIGHT|$SS_RIGHTJUST|$SS_SIMPLE|$SS_SUNKEN|$SS_WHITEFRAME|$SS_WHITERECT"
	ElseIf $hRef = 21 Then
		Return "$GUI_SS_DEFAULT_GUI|$WS_BORDER|$WS_POPUP|$WS_CAPTION|$WS_CLIPCHILDREN|$WS_CLIPSIBLINGS|$WS_DISABLED|$WS_DLGFRAME|$WS_HSCROLL|$WS_MAXIMIZE|$WS_MAXIMIZEBOX|$WS_MINIMIZE|$WS_MINIMIZEBOX|$WS_OVERLAPPED|$WS_OVERLAPPEDWINDOW|$WS_POPUPWINDOW|$WS_SIZEBOX|$WS_SYSMENU|$WS_THICKFRAME|$WS_VSCROLL|$WS_VISIBLE|$WS_CHILD|$WS_GROUP|$WS_TABSTOP|$DS_MODALFRAME|$DS_SETFOREGROUND|$DS_CONTEXTHELP|$WS_EX_ACCEPTFILES|$WS_EX_APPWINDOW|$WS_EX_CLIENTEDGE|$WS_EX_CONTEXTHELP|$WS_EX_DLGMODALFRAME|$WS_EX_MDICHILD|$WS_EX_OVERLAPPEDWINDOW|$WS_EX_STATICEDGE|$WS_EX_TOPMOST|$WS_EX_TRANSPARENT|$WS_EX_TOOLWINDOW|$WS_EX_WINDOWEDGE|$WS_EX_LAYERED"
	ElseIf $hRef = 22 Then
		Return "$MCS_NOTODAY|$MCS_NOTODAYCIRCLE|$MCS_WEEKNUMBERS"
	ElseIf $hRef = 23 Then
		Return "$SB_BOTH|$SB_CTL|$SB_HORZ|$SB_VERT"
	ElseIf $hRef = 24 Then
		Return "$ES_AUTOHSCROLL|$ES_AUTOVSCROLL|$WS_HSCROLL|$WS_VSCROLL|$ES_CENTER|$ES_LEFT|$ES_MULTILINE|$ES_NOHIDESEL|$ES_NUMBER|$ES_READONLY|$ES_RIGHT|$ES_WANTRETURN|$ES_PASSWORD"
	EndIf
EndFunc   ;==>_GetStyles
Func _DeleteResizeTabs($hControl)
	If IsArray($ResizeTabs) Then
		$hIndex = _ArraySearch($ResizeTabs, $hControl, 1, $ResizeTabs[0], 0, 1)
		If $hIndex <> -1 Then
			$hSplit = StringSplit($ResizeTabs[$hIndex], "|")
			GUICtrlDelete($hSplit[2])
			GUICtrlDelete($hSplit[3])
			GUICtrlDelete($hSplit[4])
			GUICtrlDelete($hSplit[5])
			GUICtrlDelete($hSplit[6])
			GUICtrlDelete($hSplit[7])
			GUICtrlDelete($hSplit[8])
			GUICtrlDelete($hSplit[9])
		Else
			For $i = 1 to $Controls[0] Step 1
				If $hControl = $Controls[$i] Then
					$hIndex = $i
					ExitLoop
				EndIf
			Next
		EndIf
		_ArrayDelete($ResizeTabs, $hIndex)
		$ResizeTabs[0] -= 1
	EndIf
EndFunc   ;==>_DeleteResizeTabs
Func _DrawGrid($Length, $GridColor)
	For $g = $GridHandles[0] to 1 Step -1
		GUICtrlDelete($GridHandles[$g])
	Next
	Dim $GridHandles[1] = [0]
	For $g = 1 To $GUIs[0] Step 1
		If BitAND(WinGetState($GUIs[$g]), 2) Then
			GUISwitch($GUIs[$g])
			WinSetState($GUIs[$g], "", @SW_ENABLE)
			$hPos = WinGetPos($GUIs[$g])
			$hWidth = $hPos[2]
			$hHeight = $hPos[3]
			$aGrid = GUICtrlCreateGraphic(0, 0, $hWidth, $hHeight)
			For $i = $Length To @DesktopWidth Step $Length
				GUICtrlSetGraphic($aGrid, $GUI_GR_COLOR, $GridColor)
				GUICtrlSetGraphic($aGrid, $GUI_GR_MOVE, $i, 0)
				GUICtrlSetGraphic($aGrid, $GUI_GR_LINE, $i, 0)
				GUICtrlSetGraphic($aGrid, $GUI_GR_LINE, $i, @DesktopHeight)
			Next
			For $i = $Length To @DesktopHeight Step $Length
				GUICtrlSetGraphic($aGrid, $GUI_GR_COLOR, $GridColor)
				GUICtrlSetGraphic($aGrid, $GUI_GR_MOVE, 0, $i)
				GUICtrlSetGraphic($aGrid, $GUI_GR_LINE, 0, $i)
				GUICtrlSetGraphic($aGrid, $GUI_GR_LINE, @DesktopWidth, $i)
			Next
			GUISetState()
			GUICtrlSetState($aGrid, $GUI_DISABLE)
			_ArrayAdd($GridHandles, $aGrid)
			$GridHandles[0] += 1
		EndIf
	Next
	Return $aGrid
EndFunc   ;==>_DrawGrid
Func _DeleteGrid($Grid)
	GUICtrlDelete($Grid)
EndFunc   ;==>_DeleteGrid
Func _AddTreeItem($aName, $aType, $GUIParent = "")
	$hCurWindow = _GetCurrentWin()
	_GUICtrlTreeView_BeginUpdate($hTree)
	If $Types[$Types[0]] = 14 Then
		$NameIndex = _NameToIndex($Data[$Data[0]])
		$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$NameIndex], "UpDown" & $ControlNum)
		_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon(14))
	Else
		If $GUIParent <> "" Then
			Dim $hGUIID = 0
			For $i = 1 to $GUIHandles[0] Step 1
				If $GUIParent = $GUIHandles[$i] Then
					$hGUIID = $i
				EndIf
			Next
			If $hGUIID <> 0 Then
				$hItem = _GUICtrlTreeView_AddChild($hTree, $GUITrees[$hGUIID], $aName)
				_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($aType))
			EndIf
		Else
			$hItem = _GUICtrlTreeView_AddChild($hTree, $GUITrees[$hCurWindow], $aName)
			_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($aType))
		EndIf
	EndIf
	_GUICtrlTreeView_EndUpdate($hTree)
	_ArrayAdd($TreeItems, $hItem)
	$TreeItems[0] += 1
	Return $hItem
EndFunc   ;==>_AddTreeItem
Func _DeleteControl($Num)
	If $Types[$Num] <> 23 Then
		GUICtrlDelete($Controls[$Num])
	Else
		_GUIScrollBars_ShowScrollBar($GUIS[$CurrentWindow], $SB_HORZ, False)
		_GUIScrollBars_ShowScrollBar($GUIS[$CurrentWindow], $SB_VERT, False)
	EndIf
	_ArrayDelete($Controls, $Num)
	_ArrayDelete($Colors, $Num)
	_ArrayDelete($BkColors, $Num)
	_ArrayDelete($Images, $Num)
	_ArrayDelete($Names, $Num)
	_ArrayDelete($Types, $Num)
	_ArrayDelete($Data, $Num)
	_ArrayDelete($Resize, $Num)
	_ArrayDelete($FontSize, $Num)
	_ArrayDelete($Font, $Num)
	_ArrayDelete($FontInfo, $Num)
	_ArrayDelete($Attributes, $Num)
	_ArrayDelete($Cursors, $Num)
	_ArrayDelete($Functions, $Num)
	_ArrayDelete($Comments, $Num)
	_ArrayDelete($Parents, $Num)
	_ArrayDelete($Styles, $Num)
	_ArrayDelete($States, $Num)
	_ArrayDelete($Layers, $Num)
	_ArrayDelete($Locked, $Num)
	$Locked[0] -= 1
	$Layers[0] -= 1
	$States[0] -= 1
	$Styles[0] -= 1
	$Parents[0] -= 1
	$Comments[0] -= 1
	$Functions[0] -= 1
	$Cursors[0] -= 1
	$Images[0] -= 1
	$FontInfo[0] -= 1
	$Font[0] -= 1
	$FontSize[0] -= 1
	$BkColors[0] -= 1
	$Controls[0] -= 1
	$Check[0] -= 1
	$Names[0] -= 1
	$Resize[0] -= 1
	$Types[0] -= 1
	$Data[0] -= 1
	$Attributes[0] -= 1
	$ControlNum -= 1
EndFunc   ;==>_DeleteControl
Func _CollapseControls()
	Dim $ControlExpand = False
	For $i = 1 To $ControlGroup1[0] Step 1
		GUICtrlSetState($ControlGroup1[$i], $GUI_HIDE)
	Next
	GUICtrlSetPos($ControlBoarder, 4, 28, 143, 30)
	$hCurPos = ControlGetPos("", "", $AlignmentBoarder)
	GUICtrlSetPos($AlignmentBoarder, $hCurPos[0], $hCurPos[1] - 211, $hCurPos[2], $hCurPos[3])
	$hCurPos1 = ControlGetPos("", "", $SpacingBoarder)
	GUICtrlSetPos($SpacingBoarder, $hCurPos1[0], $hCurPos1[1] - 211, $hCurPos1[2], $hCurPos1[3])
	$hCurPos2 = ControlGetPos("", "", $LayerBoarder)
	GUICtrlSetPos($LayerBoarder, $hCurPos2[0], $hCurPos2[1] - 211, $hCurPos2[2], $hCurPos2[3])
	For $i = 1 To $ControlGroup2[0] Step 1
		$hCurPos = ControlGetPos("", "", $ControlGroup2[$i])
		GUICtrlSetPos($ControlGroup2[$i], $hCurPos[0], $hCurPos[1] - 211, $hCurPos[2], $hCurPos[3])
	Next
	For $i = 1 To $ControlGroup3[0] Step 1
		$hCurPos = ControlGetPos("", "", $ControlGroup3[$i])
		GUICtrlSetPos($ControlGroup3[$i], $hCurPos[0], $hCurPos[1] - 211, $hCurPos[2], $hCurPos[3])
	Next
	For $i = 1 To $ControlGroup4[0] Step 1
		$hCurPos = ControlGetPos("", "", $ControlGroup4[$i])
		GUICtrlSetPos($ControlGroup4[$i], $hCurPos[0], $hCurPos[1] - 211, $hCurPos[2], $hCurPos[3])
	Next
EndFunc   ;==>_CollapseControls
Func _CollapseAlign()
	Dim $AlignExpand = False
	For $i = 1 To $ControlGroup2[0] Step 1
		If $ControlGroup2[$i] <> $AlignmentLabel And $ControlGroup2[$i] <> $AlignmentLine Then
			GUICtrlSetState($ControlGroup2[$i], $GUI_HIDE)
		EndIf
	Next
	$hCurPos = ControlGetPos("", "", $AlignmentBoarder)
	GUICtrlSetPos($AlignmentBoarder, $hCurPos[0], $hCurPos[1], $hCurPos[2], 30)
	$hCurPos1 = ControlGetPos("", "", $SpacingBoarder)
	GUICtrlSetPos($SpacingBoarder, $hCurPos1[0], $hCurPos1[1] - 74, $hCurPos1[2], $hCurPos1[3])
	$hCurPos2 = ControlGetPos("", "", $LayerBoarder)
	GUICtrlSetPos($LayerBoarder, $hCurPos2[0], $hCurPos2[1] - 74, $hCurPos2[2], $hCurPos2[3])
	For $i = 1 To $ControlGroup3[0] Step 1
		$hCurPos = ControlGetPos("", "", $ControlGroup3[$i])
		GUICtrlSetPos($ControlGroup3[$i], $hCurPos[0], $hCurPos[1] - 74, $hCurPos[2], $hCurPos[3])
	Next
	For $i = 1 To $ControlGroup4[0] Step 1
		$hCurPos = ControlGetPos("", "", $ControlGroup4[$i])
		GUICtrlSetPos($ControlGroup4[$i], $hCurPos[0], $hCurPos[1] - 74, $hCurPos[2], $hCurPos[3])
	Next
EndFunc   ;==>_CollapseAlign
Func _CollapseSpacing()
	Dim $SpaceExpand = False
	For $i = 1 To $ControlGroup3[0] Step 1
		If $ControlGroup3[$i] <> $SpacingLabel And $ControlGroup3[$i] <> $SpacingLine Then
			GUICtrlSetState($ControlGroup3[$i], $GUI_HIDE)
		EndIf
	Next
	$hCurPos1 = ControlGetPos("", "", $SpacingBoarder)
	GUICtrlSetPos($SpacingBoarder, $hCurPos1[0], $hCurPos1[1], $hCurPos1[2], 30)
	$hCurPos2 = ControlGetPos("", "", $LayerBoarder)
	GUICtrlSetPos($LayerBoarder, $hCurPos2[0], $hCurPos2[1] - 62, $hCurPos2[2], $hCurPos2[3])
	For $i = 1 To $ControlGroup4[0] Step 1
		$hCurPos = ControlGetPos("", "", $ControlGroup4[$i])
		GUICtrlSetPos($ControlGroup4[$i], $hCurPos[0], $hCurPos[1] - 62, $hCurPos[2], $hCurPos[3])
	Next
EndFunc   ;==>_CollapseSpacing
Func _CollapseLayering()
	Dim $LayerExpand = False
	For $i = 1 To $ControlGroup4[0] Step 1
		If $ControlGroup4[$i] <> $LayerLabel And $ControlGroup4[$i] <> $LayerLine Then
			GUICtrlSetState($ControlGroup4[$i], $GUI_HIDE)
		EndIf
	Next
	$hCurPos2 = ControlGetPos("", "", $LayerBoarder)
	GUICtrlSetPos($LayerBoarder, $hCurPos2[0], $hCurPos2[1], $hCurPos2[2], 30)
EndFunc   ;==>_CollapseLayering
Func _SetMenuData($hCtrlData)
	GUISwitch($GUIs[$CurrentWindow])
	If StringInStr($hCtrlData, "[`;]") Then
		$hFirstSplit = StringSplit($hCtrlData, "[`;]")
		For $i = 1 To $hFirstSplit[0] Step 1
			If $i <> $hFirstSplit[0] Then
				If StringInStr($hFirstSplit[$i], "*_%") Then
					Dim $hTitleItem
					$hTitleSplit = StringSplit($hFirstSplit[$i], "*_%", 1)
					$hTitleItem = GUICtrlCreateMenu($hTitleSplit[1])
					$hItemSplit = StringSplit($hTitleSplit[2], "|")
					For $b = 1 To $hItemSplit[0] Step 1
						GUICtrlCreateMenuItem($hItemSplit[$b], $hTitleItem)
					Next
				EndIf
			EndIf
		Next
		GUISetState()
	EndIf
EndFunc   ;==>_SetMenuData
Func _GetMenuCode($hCtrlData)
	$hCtrlCode = ""
	If StringInStr($hCtrlData, "[`;]") Then
		$hFirstSplit = StringSplit($hCtrlData, "[`;]")
		$hMenuCount = 0
		For $i = 1 To $hFirstSplit[0] Step 1
			If $i <> $hFirstSplit[0] Then
				If StringInStr($hFirstSplit[$i], "*_%") Then
					$hMenuCount += 1
					Dim $hTitleItem
					$hTitleSplit = StringSplit($hFirstSplit[$i], "*_%", 1)
					$hCtrlCode &= "$hMenu" & $hMenuCount & ' = GUICtrlCreateMenu("' & $hTitleSplit[1] & '")' & @CRLF
					$hItemSplit = StringSplit($hTitleSplit[2], "|")
					$hItemCount = 0
					For $b = 1 To $hItemSplit[0] Step 1
						$hItemCount += 1
						$hCtrlCode &= "$hMenu" & $hMenuCount & "Item" & $b & ' = GUICtrlCreateMenuItem("' & $hItemSplit[$b] & '", $hMenu' & $hMenuCount & ')' & @CRLF
					Next
				EndIf
			EndIf
		Next
	EndIf
	Return $hCtrlCode
EndFunc   ;==>_GetMenuCode
Func _PrepareAutoAlign(ByRef $GroupInfo)
	Dim $hControlX[1] = [0], $hControlY[1] = [0], $hControlW[1] = [0], $hControlH[1] = [0]
	For $i = 1 To $Controls[0] Step 1
		Dim $IsGroupedControl = False
		If IsArray($GroupInfo) Then
			For $b = 1 To $GroupInfo[0] Step 1
				$hSplit = StringSplit($GroupInfo[$b], "|")
				If $hSplit[1] = $i Then
					$IsGroupedControl = True
				EndIf
			Next
		EndIf
		If $Controls[$i] <> $SelectedControl And $IsGroupedControl = False Then
			If $Parents[$i] = $GUIHandles[_GetCurrentWin()]Then
				$hControlPos = ControlGetPos("", "", $Controls[$i])
				If Not @error Then
					_ArrayAdd($hControlX, $hControlPos[0])
					_ArrayAdd($hControlY, $hControlPos[1])
					_ArrayAdd($hControlW, $hControlPos[2])
					_ArrayAdd($hControlH, $hControlPos[3])
					$hControlX[0] += 1
					$hControlY[0] += 1
					$hControlW[0] += 1
					$hControlH[0] += 1
				Else
					_DebugAdd("Auto Align Error, "&@Error, $ErrorColor)
				EndIf
			EndIf
		EndIf
	Next
EndFunc   ;==>_PrepareAutoAlign
Func _CheckAutoAlign($hCtrlX, $hCtrlY, ByRef $hCtrlPos)
	Dim $CloseToControlX = False, $CloseToControlY = False
	$hCurWin = _GetCurrentWin()
	For $i = 1 To $hControlX[0] Step 1
		If $hCtrlX >= $hControlX[$i] + $hControlW[$i] - $AutoSnapSensitivity And $hCtrlX <= $hControlX[$i] + $hControlW[$i] + $AutoSnapSensitivity Then
			GUICtrlSetPos($GUISnapLineX[$hCurWin], $hControlX[$i] + $hControlW[$i], 0, 1, @DesktopHeight)
			GUICtrlSetState($GUISnapLineX[$hCurWin], $GUI_SHOW)
			$SnapLinePresent = True
			$SnapLinePresX = True
			$hCtrlX = $hControlX[$i] + $hControlW[$i]
			Dim $CloseToControlX = True
		EndIf
		If $hCtrlX + $hCtrlPos[2] >= $hControlX[$i] + $hControlW[$i] - 3 And $hCtrlX + $hCtrlPos[2] <= $hControlX[$i] + $hControlW[$i] + 3 Then
			GUICtrlSetPos($GUISnapLineX[$hCurWin], $hControlX[$i] + $hControlW[$i], 0, 1, @DesktopHeight)
			GUICtrlSetState($GUISnapLineX[$hCurWin], $GUI_SHOW)
			$SnapLinePresent = True
			$SnapLinePresX = True
			$hCtrlX = $hControlX[$i] + $hControlW[$i] - $hCtrlPos[2]
			Dim $CloseToControlX = True
		EndIf
		If $hCtrlX + $hCtrlPos[2] >= $hControlX[$i] - $AutoSnapSensitivity And $hCtrlX + $hCtrlPos[2] <= $hControlX[$i] + $AutoSnapSensitivity Then ; Bottom
			GUICtrlSetPos($GUISnapLineX[$hCurWin], $hControlX[$i], 0, 1, @DesktopHeight)
			GUICtrlSetState($GUISnapLineX[$hCurWin], $GUI_SHOW)
			$SnapLinePresent = True
			$SnapLinePresX = True
			$hCtrlX = $hControlX[$i] - $hCtrlPos[2]
			Dim $CloseToControlX = True
		EndIf
		If $hCtrlY >= $hControlY[$i] + $hControlH[$i] - $AutoSnapSensitivity And $hCtrlY <= $hControlY[$i] + $hControlH[$i] + $AutoSnapSensitivity Then
			GUICtrlSetPos($GUISnapLineY[$hCurWin], 0, $hControlY[$i] + $hControlH[$i], @DesktopWidth, 1)
			GUICtrlSetState($GUISnapLineY[$hCurWin], $GUI_SHOW)
			$SnapLinePresent = True
			$SnapLinePresY = True
			$hCtrlY = $hControlY[$i] + $hControlH[$i]
			Dim $CloseToControlY = True
		EndIf
		If $hCtrlY + $hCtrlPos[3] >= $hControlY[$i] + $hControlH[$i] - $AutoSnapSensitivity And $hCtrlY + $hCtrlPos[3] <= $hControlY[$i] + $hControlH[$i] + $AutoSnapSensitivity Then
			GUICtrlSetPos($GUISnapLineY[$hCurWin], 0, $hControlY[$i] + $hControlH[$i], @DesktopWidth, 1)
			GUICtrlSetState($GUISnapLineY[$hCurWin], $GUI_SHOW)
			$SnapLinePresent = True
			$SnapLinePresY = True
			$hCtrlY = $hControlY[$i] + $hControlH[$i] - $hCtrlPos[3]
			Dim $CloseToControlY = True
		EndIf
		If $hCtrlY + $hCtrlPos[3] >= $hControlY[$i] - $AutoSnapSensitivity And $hCtrlY + $hCtrlPos[3] <= $hControlY[$i] + $AutoSnapSensitivity Then
			GUICtrlSetPos($SnapLineY, 0, $hControlY[$i], @DesktopWidth, 1)
			GUICtrlSetState($SnapLineY, $GUI_SHOW)
			$SnapLinePresent = True
			$SnapLinePresY = True
			$hCtrlY = $hControlY[$i] - $hCtrlPos[3]
			Dim $CloseToControlY = True
		EndIf
		If $hCtrlX >= $hControlX[$i] - $AutoSnapSensitivity And $hCtrlX <= $hControlX[$i] + $AutoSnapSensitivity Then
			GUICtrlSetPos($GUISnapLineX[$hCurWin], $hControlX[$i] - 1, 0, 1, @DesktopHeight)
			GUICtrlSetState($GUISnapLineX[$hCurWin], $GUI_SHOW)
			$SnapLinePresent = True
			$SnapLinePresX = True
			$hCtrlX = $hControlX[$i]
			Dim $CloseToControlX = True
		EndIf
		If $hCtrlY >= $hControlY[$i] - $AutoSnapSensitivity And $hCtrlY <= $hControlY[$i] + $AutoSnapSensitivity Then
			GUICtrlSetPos($GUISnapLineY[$hCurWin], 0, $hControlY[$i] - 1, @DesktopWidth, 1)
			GUICtrlSetState($GUISnapLineY[$hCurWin], $GUI_SHOW)
			$SnapLinePresent = True
			$SnapLinePresY = True
			$hCtrlY = $hControlY[$i]
			Dim $CloseToControlY = True
		EndIf
	Next
	If $CloseToControlX = False Then
		If $SnapLinePresX = True Then
			GUICtrlSetState($GUISnapLineX[$hCurWin], $GUI_HIDE)
			$SnapLinePresent = False
			$SnapLinePresX = False
		EndIf
	EndIf
	If $CloseToControlY = False Then
		If $SnapLinePresY = True Then
			GUICtrlSetState($GUISnapLineY[$hCurWin], $GUI_HIDE)
			$SnapLinePresent = False
			$SnapLinePresY = False
		EndIf
	EndIf
	Dim $hArray[2] = [$hCtrlX, $hCtrlY]
	Return $hArray
EndFunc   ;==>_CheckAutoAlign
Func _CheckAutoAlignX($hCtrlX)
	Dim $CloseToControlX = False
	$hCurWin = _GetCurrentWin()
	For $i = 1 To $hControlX[0] Step 1
		If $hCtrlX >= $hControlX[$i] - $AutoSnapSensitivity And $hCtrlX <= $hControlX[$i] + $AutoSnapSensitivity Then
			GUICtrlSetPos($GUISnapLineX[$hCurWin], $hControlX[$i] - 1, 0, 1, @DesktopHeight)
			GUICtrlSetState($GUISnapLineX[$hCurWin], $GUI_SHOW)
			$SnapLinePresent = True
			$SnapLinePresX = True
			$hCtrlX = $hControlX[$i]
			$CloseToControlX = True
			ExitLoop
		EndIf
		If $hCtrlX >= $hControlX[$i] + $hControlW[$i] - $AutoSnapSensitivity And $hCtrlX <= $hControlX[$i] + $hControlW[$i] + $AutoSnapSensitivity Then
			GUICtrlSetPos($GUISnapLineX[$hCurWin], $hControlX[$i] + $hControlW[$i], 0, 1, @DesktopHeight)
			GUICtrlSetState($GUISnapLineX[$hCurWin], $GUI_SHOW)
			$SnapLinePresent = True
			$SnapLinePresX = True
			$hCtrlX = $hControlX[$i] + $hControlW[$i]
			Dim $CloseToControlX = True
			ExitLoop
		EndIf
	Next
	If $CloseToControlX = False Then
		If $SnapLinePresX = True Then
			GUICtrlSetState($SnapLineX, $GUI_HIDE)
			$SnapLinePresent = False
			$SnapLinePresX = False
		EndIf
	EndIf
	Return $hCtrlX
EndFunc   ;==>_CheckAutoAlignX
Func _CheckAutoAlignY($hCtrlY)
	Dim $CloseToControlY = False
	$hCurWin = _GetCurrentWin()
	For $i = 1 To $hControlY[0] Step 1
		If $hCtrlY >= $hControlY[$i] - $AutoSnapSensitivity And $hCtrlY <= $hControlY[$i] + $AutoSnapSensitivity Then
			GUICtrlSetPos($GUISnapLineY[$hCurWin], 0, $hControlY[$i] - 1, @DesktopWidth, 1)
			GUICtrlSetState($GUISnapLineY[$hCurWin], $GUI_SHOW)
			$SnapLinePresent = True
			$SnapLinePresY = True
			$hCtrlY = $hControlY[$i]
			Dim $CloseToControlY = True
			ExitLoop
		EndIf
		If $hCtrlY >= $hControlY[$i] + $hControlH[$i] - $AutoSnapSensitivity And $hCtrlY <= $hControlY[$i] + $hControlH[$i] + $AutoSnapSensitivity Then
			GUICtrlSetPos($GUISnapLineY[$hCurWin], 0, $hControlY[$i] + $hControlH[$i], @DesktopWidth, 1)
			GUICtrlSetState($GUISnapLineY[$hCurWin], $GUI_SHOW)
			$SnapLinePresent = True
			$SnapLinePresY = True
			$hCtrlY = $hControlY[$i] + $hControlH[$i]
			Dim $CloseToControlY = True
			ExitLoop
		EndIf
	Next
	If $CloseToControlY = False Then
		If $SnapLinePresY = True Then
			GUICtrlSetState($GUISnapLineY[$hCurWin], $GUI_HIDE)
			$SnapLinePresent = False
			$SnapLinePresY = False
		EndIf
	EndIf
	Return $hCtrlY
EndFunc   ;==>_CheckAutoAlignY
Func _HideAutoSnapLines()
	$SnapLinePresent = False
	$hCurWin = _GetCurrentWin()
	If $SnapLinePresX = True Then
		For $i = 1 to $GUISnapLineX[0] Step 1
			GUICtrlSetState($GUISnapLineX[$i], $GUI_HIDE)
		Next
		$SnapLinePresX = False
	EndIf
	If $SnapLinePresY = True Then
		For $i = 1 to $GUISnapLineY[0] Step 1
			GUICtrlSetState($GUISnapLineY[$i], $GUI_HIDE)
		Next
		$SnapLinePresY = False
	EndIf
EndFunc   ;==>_HideAutoSnapLines
Func _GetCurrentWin()
	Dim $hCurWindow = $CurrentWindow
	For $i = 1 To $GUIS[0] Step 1
		$hState = WinGetState($GUIs[$i])
		If BitAND($hState, 8) Then
			$CurrentWindow = $i
		EndIf
	Next
	Return $CurrentWindow
EndFunc   ;==>_GetCurrentWin
Func _GetResizeValue($hVal)
	Dim $ResizeValue = ""
	$aSplit = StringSplit($Resize[$hVal], "+")
	For $c = $aSplit[0] To 1 Step -1
		If $aSplit[$c] <> "" Then
			If $c = 2 Then
				$ResizeValue &= $aSplit[$c]
			Else
				$ResizeValue &= $aSplit[$c] & "+"
			EndIf
		EndIf
	Next
	Return Execute($ResizeValue)
EndFunc   ;==>_GetResizeValue
Func _ImportClipboard($hClip, $hGUIIndex)
	$ClipSplit = StringSplit($hClip, @CRLF, 1)
	GUISwitch($GUIs[$hGUIIndex])
	Dim $AddCtrl = False
	Dim $StartIndex = $Controls[0]
	For $i = 1 To $ClipSplit[0] Step 1
		If StringInStr($ClipSplit[$i], "GUICtrlCreateLabel(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateLabel(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			EndIf
			$hControl = GUICtrlCreateLabel(_RemoveQuotes($DataSplit[1]), $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5])
			_ArrayAdd($Types, 1)
			_ArrayAdd($Data, _RemoveQuotes($DataSplit[1]))
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateButton(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateButton(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			EndIf
			$hControl = GUICtrlCreateButton(_RemoveQuotes($DataSplit[1]), $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5])
			_ArrayAdd($Types, 2)
			_ArrayAdd($Data, _RemoveQuotes($DataSplit[1]))
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateInput(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateInput(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			EndIf
			$hControl = GUICtrlCreateInput(_RemoveQuotes($DataSplit[1]), $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5])
			_ArrayAdd($Types, 3)
			_ArrayAdd($Data, _RemoveQuotes($DataSplit[1]))
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateEdit(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateEdit(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			EndIf
			$hControl = GUICtrlCreateEdit(_RemoveQuotes($DataSplit[1]), $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5])
			_ArrayAdd($Types, 4)
			_ArrayAdd($Data, _RemoveQuotes($DataSplit[1]))
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateCheckbox(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateCheckbox(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			EndIf
			$hControl = GUICtrlCreateCheckbox(_RemoveQuotes($DataSplit[1]), $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5])
			_ArrayAdd($Types, 5)
			_ArrayAdd($Data, _RemoveQuotes($DataSplit[1]))
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateRadio(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateRadio(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			EndIf
			$hControl = GUICtrlCreateRadio(_RemoveQuotes($DataSplit[1]), $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5])
			_ArrayAdd($Types, 6)
			_ArrayAdd($Data, _RemoveQuotes($DataSplit[1]))
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateCombo(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateCombo(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			EndIf
			$hControl = GUICtrlCreateCombo(_RemoveQuotes($DataSplit[1]), $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5])
			_ArrayAdd($Types, 7)
			_ArrayAdd($Data, _RemoveQuotes($DataSplit[1]))
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateList(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateList(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			EndIf
			$hControl = GUICtrlCreateList(_RemoveQuotes($DataSplit[1]), $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5])
			_ArrayAdd($Types, 8)
			_ArrayAdd($Data, _RemoveQuotes($DataSplit[1]))
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateDate(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateDate(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			EndIf
			$hControl = GUICtrlCreateDate(_RemoveQuotes($DataSplit[1]), $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5])
			_ArrayAdd($Types, 9)
			_ArrayAdd($Data, _RemoveQuotes($DataSplit[1]))
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreatePic(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreatePic(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			EndIf
			$hControl = GUICtrlCreatePic(_RemoveQuotes($DataSplit[1]), $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5])
			_ArrayAdd($Types, 10)
			_ArrayAdd($Data, _RemoveQuotes($DataSplit[1]))
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateIcon(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateIcon(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 6)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 6)
			EndIf
			$hControl = GUICtrlCreateIcon(_RemoveQuotes($DataSplit[1]), $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5], $DataSplit[6])
			_ArrayAdd($Types, 11)
			_ArrayAdd($Data, _RemoveQuotes($DataSplit[1]))
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateProgress(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateProgress(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 4)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 4)
			EndIf
			$hControl = GUICtrlCreateProgress($DataSplit[1], $DataSplit[2], $DataSplit[3], $DataSplit[4])
			_ArrayAdd($Types, 12)
			_ArrayAdd($Data, "0")
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateTab(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateTab(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 4)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 4)
			EndIf
			$hControl = GUICtrlCreateTab($DataSplit[1], $DataSplit[2], $DataSplit[3], $DataSplit[4])
			_ArrayAdd($Types, 13)
			_ArrayAdd($Data, "")
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateUpdown(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateUpdown(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 2)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 2)
			EndIf
			$hControl = GUICtrlCreateUpdown(_RemoveQuotes($DataSplit[1]), $DataSplit[2])
			_ArrayAdd($Types, 14)
			_ArrayAdd($Data, _RemoveQuotes($DataSplit[1]))
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateTreeView(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateTreeView(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 4)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 4)
			EndIf
			$hControl = GUICtrlCreateTreeView($DataSplit[1], $DataSplit[2], $DataSplit[3], $DataSplit[4])
			_ArrayAdd($Types, 16)
			_ArrayAdd($Data, "")
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateSlider(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateSlider(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 4)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 4)
			EndIf
			$hControl = GUICtrlCreateSlider($DataSplit[1], $DataSplit[2], $DataSplit[3], $DataSplit[4])
			_ArrayAdd($Types, 17)
			_ArrayAdd($Data, "")
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateListView(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateListView(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			EndIf
			$hControl = GUICtrlCreateListView(_RemoveQuotes($DataSplit[1]), $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5])
			_ArrayAdd($Types, 18)
			_ArrayAdd($Data, _RemoveQuotes($DataSplit[1]))
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateGraphic(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateGraphic(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 4)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 4)
			EndIf
			$hControl = GUICtrlCreateGraphic($DataSplit[1], $DataSplit[2], $DataSplit[3], $DataSplit[4])
			GUICtrlSetColor(-1, 0x00)
			_ArrayAdd($Types, 19)
			_ArrayAdd($Data, "")
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateDummy(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateDummy()", 1)
			$HandleSplit = StringSplit($ControlSplit[1], "$")
			$hControl = GUICtrlCreateDummy()
			_ArrayAdd($Types, 20)
			_ArrayAdd($Data, "")
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateGroup(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateGroup(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			EndIf
			$hControl = GUICtrlCreateGroup(_RemoveQuotes($DataSplit[1]), $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5])
			_ArrayAdd($Types, 21)
			_ArrayAdd($Data, _RemoveQuotes($DataSplit[1]))
			$AddCtrl = True
		ElseIf StringInStr($ClipSplit[$i], "GUICtrlCreateMonthCal(") Then
			$ControlSplit = StringSplit($ClipSplit[$i], "GUICtrlCreateMonthCal(", 1)
			If StringinStr($ControlSplit[1], "=") Then
				$hHandleSplit = StringSplit($ControlSplit[1], "=")
				$HandleSplit = StringSplit(StringstripWS($hHandleSplit[1], 8), "$")
			Else
				Dim $HandleSplit[1] = [0]
				_ArrayAdd($HandleSplit, "")
				_ArrayAdd($HandleSplit, "")
				$HandleSplit[0] = 2
			EndIf
			If StringinStr($ControlSplit[1], ",") Then
				$DataSplit = StringSplit($ControlSplit[1], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			ElseIf StringinStr($ControlSplit[2], ",") Then
				$DataSplit = StringSplit($ControlSplit[2], ",")
				$DataSplit = _ControlParameters($DataSplit, 5)
			EndIf
			$hControl = GUICtrlCreateMonthCal(_RemoveQuotes($DataSplit[1]), $DataSplit[2], $DataSplit[3], $DataSplit[4], $DataSplit[5])
			_ArrayAdd($Types, 22)
			_ArrayAdd($Data, _RemoveQuotes($DataSplit[1]))
			$AddCtrl = True
		EndIf
		If $AddCtrl = True Then
			$AddCtrl = False
			GUISetState()
			GUICtrlSetResizing($hControl, 802)
			GUICtrlSetState($hControl, $GUI_SHOW)
			GUICtrlSetCursor($hControl, 9)
			_ArrayAdd($Names, $HandleSplit[2])
			_ArrayAdd($Colors, "")
			_ArrayAdd($BkColors, "")
			_ArrayAdd($Styles, "")
			_ArrayAdd($States, "$GUI_SHOW")
			_ArrayAdd($Resize, "")
			_ArrayAdd($Controls, $hControl)
			_ArrayAdd($Font, $DefaultFont)
			_ArrayAdd($FontInfo, "")
			_ArrayAdd($FontSize, "8.5")
			_ArrayAdd($Layers, "0")
			_ArrayAdd($Attributes, "")
			_ArrayAdd($Images, "")
			_ArrayAdd($Functions, "")
			_ArrayAdd($Comments, "")
			_ArrayAdd($Locked, "0")
			_ArrayAdd($Cursors, "2")
			_ArrayAdd($Parents, $GUIHandles[$CurrentWindow])
			$Locked[0] += 1
			$Comments[0] += 1
			$Functions[0] += 1
			$Cursors[0] += 1
			$Parents[0] += 1
			$Images[0] += 1
			$Attributes[0] += 1
			$Layers[0] += 1
			$Font[0] += 1
			$FontInfo[0] += 1
			$FontSize[0] += 1
			$Controls[0] += 1
			$Names[0] += 1
			$Types[0] += 1
			$Colors[0] += 1
			$BkColors[0] += 1
			$Styles[0] += 1
			$States[0] += 1
			$Data[0] += 1
			$Resize[0] += 1
			$ControlNum += 1

			$hCtrlPos = ControlGetPos($GUIs[$hGUIIndex], "", $hControl)
			If Not @error Then
				For $b = 1 To $Controls[0] Step 1
					If $Types[$b] = 13 Then ; Tab
						$hItemPos = ControlGetPos($GUIs[$hGUIIndex], "", $Controls[$b])
						If Not @error Then
							If $hCtrlPos[0] > $hItemPos[0] And $hCtrlPos[1] > $hItemPos[1] And $hCtrlPos[0] < $hItemPos[0] + $hItemPos[2] And $hCtrlPos[1] < $hItemPos[1] + $hItemPos[3] Then
								$Attributes[$Attributes[0]] = $HandleSplit[2] & "ø1"
							EndIf
						EndIf
					ElseIf $Types[$b] = 21 Then ; Group
						$hItemPos = ControlGetPos($GUIs[$hGUIIndex], "", $Controls[$b])
						If Not @error Then
							If $hCtrlPos[0] > $hItemPos[0] And $hCtrlPos[1] > $hItemPos[1] And $hCtrlPos[0] < $hItemPos[0] + $hItemPos[2] And $hCtrlPos[1] < $hItemPos[1] + $hItemPos[3] Then
								$Attributes[$Attributes[0]] = $HandleSplit[2] & "Ð"
							EndIf
						EndIf
					EndIf
				Next
			EndIf
			_CreateResizeTabs($hControl)
		EndIf
		#cs
			If StringinStr($ClipSplit[$i], "GUICtrlSetImage(") Then
			$hSplit = StringSplit($ClipSplit[$i], "GUICtrlSetImage(", 1)
			$hDataSplit = StringSplit($hSplit[2], ",")
			If StringinStr($hDataSplit[1], "-1") Then
			$Images[$ControlNum] = _RemoveQuotes(StringTrimRight($hDataSplit[2], 1))
			GUICtrlSetImage($Controls[$ControlNum], $Images[$ControlNum])
			Else
			$hCtrlIndex = _NameToIndex(StringTrimLeft(StringStripWS($hDataSplit[1], 8), 1))
			$Images[$hCtrlIndex] = _RemoveQuotes(StringTrimRight($hDataSplit[2], 1))
			GUICtrlSetImage($Controls[$hCtrlIndex], $Images[$hCtrlIndex])
			EndIf
			ElseIf StringinStr($ClipSplit[$i], "GUICtrlSetData(") Then
			$hSplit = StringSplit($ClipSplit[$i], "GUICtrlSetData(", 1)
			$hDataSplit = StringSplit($hSplit[2], ",")
			If StringinStr($hDataSplit[1], "-1") Then
			$Data[$ControlNum] = _RemoveQuotes(StringTrimRight($hDataSplit[2], 1))
			GUICtrlSetData($Controls[$ControlNum], $Data[$ControlNum])
			Else
			$hCtrlIndex = _NameToIndex(StringTrimLeft(StringStripWS($hDataSplit[1], 8), 1))
			$Data[$hCtrlIndex] = _RemoveQuotes(StringTrimRight($hDataSplit[2], 1))
			GUICtrlSetData($Controls[$hCtrlIndex], $Data[$hCtrlIndex])
			EndIf
			ElseIf StringinStr($ClipSplit[$i], "GUICtrlSetColor(") Then
			$hSplit = StringSplit($ClipSplit[$i], "GUICtrlSetColor(", 1)
			$hDataSplit = StringSplit($hSplit[2], ",")
			If StringinStr($hDataSplit[1], "-1") Then
			$Colors[$ControlNum] = StringTrimLeft(StringTrimRight($hDataSplit[2], 1), 2)
			GUICtrlSetColor($Controls[$ControlNum], "0x"&$Colors[$ControlNum])
			Else
			$hCtrlIndex = _NameToIndex(StringTrimLeft(StringStripWS($hDataSplit[1], 8), 1))
			$Colors[$hCtrlIndex] = StringTrimLeft(StringTrimRight(StringStripWS($hDataSplit[2], 8), 1), 2)
			GUICtrlSetColor($Controls[$hCtrlIndex], "0x"&$Colors[$hCtrlIndex])
			EndIf
			ElseIf StringinStr($ClipSplit[$i], "GUICtrlSetBkColor(") Then
			$hSplit = StringSplit($ClipSplit[$i], "GUICtrlSetBkColor(", 1)
			$hDataSplit = StringSplit($hSplit[2], ",")
			If StringinStr($hDataSplit[1], "-1") Then
			$BkColors[$ControlNum] = StringTrimLeft(StringTrimRight($hDataSplit[2], 1), 2)
			GUICtrlSetBkColor($Controls[$ControlNum], "0x"&$BkColors[$ControlNum])
			Else
			$hCtrlIndex = _NameToIndex(StringTrimLeft(StringStripWS($hDataSplit[1], 8), 1))
			$BkColors[$hCtrlIndex] = StringTrimLeft(StringTrimRight(StringStripWS($hDataSplit[2], 8), 1), 2)
			GUICtrlSetBkColor($Controls[$hCtrlIndex], "0x"&$BkColors[$hCtrlIndex])
			EndIf
			EndIf
		#ce
	Next
	GUISetState()
	_GUICtrlTreeView_BeginUpdate($hTree)
	If $StartIndex + 1 <= $Controls[0] Then
		For $i = $StartIndex + 1 To $Controls[0] Step 1
			If StringInStr($Attributes[$i], "ø") Then
				$hSplit = StringSplit($Attributes[$i], "ø")
				$hIndex = _ArraySearch($Names, $hSplit[1], 1, $Names[0])
				If $hIndex <> -1 Then
					_ArrayAdd($TreeItems, "")
					$TreeItems[0] += 1
				Else
					$ItemHandle = _GUICtrlTreeView_FindItem($hTree, "hTabItem" & $hSplit[2], False, 0)
					If $ItemHandle = 0 Then
						$hTabItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "hTabItem" & $hSplit[2])
						_GUICtrlTreeView_SetIcon($hTree, $hTabItem, @ScriptDir & "\Resources.dll", _GetIcon(13))
						$hItem = _GUICtrlTreeView_AddChild($hTree, $hTabItem, $Names[$i])
						_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$i]))
					Else
						$hItem = _GUICtrlTreeView_AddChild($hTree, $ItemHandle, $Names[$i])
						_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$i]))
					EndIf
					_ArrayAdd($TreeItems, $hItem)
					$TreeItems[0] += 1
				EndIf
			EndIf
			If StringInStr($Attributes[$i], "Ð") Then
				$hSplit = StringTrimRight($Attributes[$i], 1)
				$hIndex = _ArraySearch($Names, $hSplit, 1, $Names[0])
				If $hIndex <> -1 Then
					_ArrayAdd($TreeItems, "0")
					$TreeItems[0] += 1
				Else
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], $Names[$i])
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir & "\Resources.dll", _GetIcon($Types[$i]))
					_ArrayAdd($TreeItems, $hItem)
					$TreeItems[0] += 1
				EndIf
			EndIf
			If StringInStr($Attributes[$i], "ø") = False And StringInStr($Attributes[$i], "Ð") = False Then
				If $Names[$i] = "" Then
					_AddTreeItem("[ No Handle ]", $Types[$i], $Parents[$i])
				Else
					_AddTreeItem($Names[$i], $Types[$i], $Parents[$i])
				EndIf
			EndIf
		Next
		_GUICtrlTreeView_EndUpdate($hTree)
	EndIf
	;_SetScriptData()
EndFunc   ;==>_ImportClipboard
Func _RemoveQuotes($hString)
	If StringRight($hString, 1) = '"' Or StringRight($hString, 1) = "'" Then
		Return StringTrimRight(StringTrimLeft(StringStripWS($hString, 3), 1), 1)
	Else
		Return StringStripWS($hString, 3)
	EndIf
EndFunc   ;==>_RemoveQuotes
Func _ControlParameters(ByRef $DataSplit, $ParamNum)
	If $DataSplit[0] < $ParamNum Then
		For $i = $DataSplit[0] To $ParamNum Step 1
			_ArrayAdd($DataSplit, "-1")
			$DataSplit[0] += 1
		Next
	EndIf
	For $i = 3 To $DataSplit[0] Step 1
		If StringRight($DataSplit[$i], 1) = ")" Then
			$DataSplit[$i] = StringTrimRight($DataSplit[$i], 1)
		EndIf
	Next
	Return $DataSplit
EndFunc   ;==>_ControlParameters
Func _CleanUp()
	If FileExists(@ScriptDir & "\temp.au3") Then
		FileDelete(@ScriptDir & "\temp.au3")
	EndIf
EndFunc   ;==>_CleanUp
Func _CustomMsg($hTitle, $hMsg)
	Dim $CustomMsg = True
	$hMsgGUI = GUICreate($hTitle, 450, 116, -1, -1)
	$hBkLabel = GUICtrlCreateLabel("", 0, 0, 452, 67)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	$hYes = GUICtrlCreateButton("Yes", 146, 80, 86, 24)
	$hNo = GUICtrlCreateButton("No", 243, 80, 86, 24)
	GUICtrlSetState(-1, $GUI_DISABLE)
	$hMsgCancel = GUICtrlCreateButton("Cancel", 341, 80, 86, 24)
	$hMsgLabel = GUICtrlCreateLabel($hMsg, 12, 28, 380, 17)
	GUICtrlSetBkColor(-1, 0xFFFFFF)
	GUISetState()

	While $CustomMsg = True
		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				GUIDelete($hMsgGUI)
				$CustomMsg = False
				Return 2
			Case $hMsgCancel
				GUIDelete($hMsgGUI)
				$CustomMsg = False
				Return 2
			Case $hYes
				GUIDelete($hMsgGUI)
				$CustomMsg = False
				Return 6
			Case $hNo
				GUIDelete($hMsgGUI)
				$CustomMsg = False
				Return 7
		EndSwitch
	WEnd
EndFunc   ;==>_CustomMsg
Func _DebugAdd($hData, $hColor, $hBkColor = -1)
	If $Debug = "True" Then
		$hListHandle = GUICtrlCreateListViewItem("["&@HOUR&":"&@MIN&":"&@SEC&"]", $hDebugList)
		GUICtrlSetColor($hListHandle, $hColor)
		If $hBkColor <> -1 Then
			GUICtrlSetBkColor($hListHandle, $hBkColor)
		EndIf
		$hCount = _GUICtrlListView_GetItemCount($hDebugList)
		$hListHandle = _GUICtrlListView_AddSubItem($hDebugList, $hCount-1, $hData, 1)
		GUICtrlSetColor($hListHandle, $hColor)
		If $hBkColor <> -1 Then
			GUICtrlSetBkColor($hListHandle, $hBkColor)
		EndIf
		_GUICtrlListView_Scroll($hDebugList, 0, 5000)
	EndIf
EndFunc
Func _CtrlNameToType($hCtrlName)
	If $hCtrlName = "Label" Then
		Return 1
	ElseIf $hCtrlName = "Button" Then
		Return 2
	ElseIf $hCtrlName = "Input" Then
		Return 3
	ElseIf $hCtrlName = "Edit" Then
		Return 4
	ElseIf $hCtrlName = "Checkbox" Then
		Return 5
	ElseIf $hCtrlName = "Radio" Then
		Return 6
	ElseIf $hCtrlName = "Combo" Then
		Return 7
	ElseIf $hCtrlName = "List" Then
		Return 8
	ElseIf $hCtrlName = "Date" Then
		Return 9
	ElseIf $hCtrlName = "Pic" Then
		Return 10
	ElseIf $hCtrlName = "Icon" Then
		Return 11
	ElseIf $hCtrlName = "Progress" Then
		Return 12
	ElseIf $hCtrlName = "Tab" Then
		Return 13
	ElseIf $hCtrlName = "Updown" Then
		Return 14
	ElseIf $hCtrlName = "Menu" Then
		Return 15
	ElseIf $hCtrlName = "TreeView" Then
		Return 16
	ElseIf $hCtrlName = "Slider" Then
		Return 17
	ElseIf $hCtrlName = "ListView" Then
		Return 18
	ElseIf $hCtrlName = "Graphic" Then
		Return 19
	ElseIf $hCtrlName = "Dummy" Then
		Return 20
	ElseIf $hCtrlName = "Group" Then
		Return 21
	ElseIf $hCtrlName = "MonthCal" Then
		Return 22
	ElseIf $hCtrlName = "Scrollbar" Then
		Return 23
	ElseIf $hCtrlName = "RichEdit" Then
		Return 24
	ElseIf $hCtrlName = "Obj" Then
		Return 25
	EndIf
	Return 0
EndFunc
Func _TypeToName($hType)
	If $hType = 1 Then
		Return "Label"
	ElseIf $hType = 2 Then
		Return "Button"
	ElseIf $hType = 3 Then
		Return "Input"
	ElseIf $hType = 4 Then
		Return "Edit"
	ElseIf $hType = 5 Then
		Return "Checkbox"
	ElseIf $hType = 6 Then
		Return "Radio"
	ElseIf $hType = 7 Then
		Return "Combo"
	ElseIf $hType = 8 Then
		Return "List"
	ElseIf $hType = 9 Then
		Return "Date"
	ElseIf $hType = 10 Then
		Return "Pic"
	ElseIf $hType = 11 Then
		Return "Icon"
	ElseIf $hType = 12 Then
		Return "Progress"
	ElseIf $hType = 13 Then
		Return "Tab"
	ElseIf $hType = 14 Then
		Return "UpDown"
	ElseIf $hType = 15 Then
		Return "Menu"
	ElseIf $hType = 16 Then
		Return "TreeView"
	ElseIf $hType = 17 Then
		Return "Slider"
	ElseIf $hType = 18 Then
		Return "ListView"
	ElseIf $hType = 19 Then
		Return "Graphic"
	ElseIf $hType = 20 Then
		Return "Dummy"
	ElseIf $hType = 21 Then
		Return "Group"
	ElseIf $hType = 22 Then
		Return "MonthCal"
	ElseIf $hType = 23 Then
		Return "ScrollBar"
	ElseIf $hType = 24 Then
		Return "RichEdit"
	ElseIf $hType = 25 Then
		Return "Object"
	EndIf
EndFunc
Func _GDIPlusMode($hGDIWidth, $hGDIHeight, $hIndex)
	Dim $SelectedItem = 0
	Global $GDITrees[1] = [0]
	Global $hGDIPen, $hGDIBrush, $hGDIPlus
	Dim $GDIPlusData[1] = [0]
	Dim $BrushSmooth = 2
	Dim $BrushType = "0"
	Dim $BrushSize = "1"
	Dim $BrushColor = "FF000000"
	Dim $BrushBkColor = ""
	Dim $GUIElements[1] = [0]
	Dim $GDIPlusRunning = True
	WinSetState($GUIHolder, "", @SW_ENABLE)
	GUISwitch($GUIHolder)
	$hBrushType = _GUICtrlComboBoxEx_Create($GUIHolder, "", 9, 30, 39, 100)
	$hImage = _GUIImageList_Create(16, 16, 5, 3)
	_GUIImageList_AddIcon($hImage, @ScriptDir&"\Resources.dll", 111)
	_GUIImageList_AddIcon($hImage, @ScriptDir&"\Resources.dll", 112)
	_GUIImageList_AddIcon($hImage, @ScriptDir&"\Resources.dll", 113)
	_GUICtrlComboBoxEx_SetImageList($hBrushType, $hImage)

	_GUICtrlComboBoxEx_BeginUpdate($hBrushType)
	_GUICtrlComboBoxEx_AddString($hBrushType, "", 0, 0)
	_GUICtrlComboBoxEx_AddString($hBrushType, "", 1, 1)
	_GUICtrlComboBoxEx_AddString($hBrushType, "", 2, 2)
	_GUICtrlComboBoxEx_EndUpdate($hBrushType)
	_GUICtrlComboBoxEx_SetCurSel($hBrushType, 0)

	$hBrushSmooth = _GUICtrlComboBoxEx_Create($GUIHolder, "", 53, 30, 38, 100)
	$hImage2 = _GUIImageList_Create(16, 16, 5, 3)
	_GUIImageList_AddIcon($hImage2, @ScriptDir&"\Resources.dll", 114)
	_GUIImageList_AddIcon($hImage2, @ScriptDir&"\Resources.dll", 115)
	_GUIImageList_AddIcon($hImage2, @ScriptDir&"\Resources.dll", 116)
	_GUICtrlComboBoxEx_SetImageList($hBrushSmooth, $hImage2)

	_GUICtrlComboBoxEx_BeginUpdate($hBrushSmooth)
	_GUICtrlComboBoxEx_AddString($hBrushSmooth, "", 0, 0)
	_GUICtrlComboBoxEx_AddString($hBrushSmooth, "", 1, 1)
	_GUICtrlComboBoxEx_AddString($hBrushSmooth, "", 2, 2)
	_GUICtrlComboBoxEx_EndUpdate($hBrushSmooth)
	_GUICtrlComboBoxEx_SetCurSel($hBrushSmooth, $hGDIPlusQuality)
	$BrushSmooth = $hGDIPlusQuality

	$hBrushInput = GUICtrlCreateInput( "1", 11, 59, 35, 22)
	GUICtrlSetResizing(-1, 802)
	$hBrushUpdown = GUICtrlCreateUpdown($hBrushInput)
	$hBrushBk = GUICtrlCreateLabel( "", 56, 58, 15, 24)
	GUICtrlSetBkColor( -1, 0x000000)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetResizing(-1, 802)
	$hBrushColor = GUICtrlCreateLabel( "", 57, 59, 13, 22)
	GUICtrlSetBkColor( -1, 0x000000)
	GUICtrlSetTip(-1, "Color")
	GUICtrlSetResizing(-1, 802)
	$hBrushBkBk = GUICtrlCreateLabel( "", 72, 58, 15, 24)
	GUICtrlSetBkColor( -1, 0x000000)
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlSetResizing(-1, 802)
	$hBrushBkColor = GUICtrlCreateLabel( "", 73, 59, 13, 22)
	GUICtrlSetBkColor( -1, 0xFFFFFF)
	GUICtrlSetTip(-1, "Background Color")
	GUICtrlSetResizing(-1, 802)

	$hBtn1 = GUICtrlCreateButton( "", 17, 88, 30, 30)
	GUICtrlSetStyle( -1, $BS_ICON)
	GUICtrlSetImage( -1, @ScriptDir&"\Resources.dll", -108, 0)
	GUICtrlSetTip(-1, "Arc")
	GUICtrlSetResizing(-1, 802)
	$hBtn2 = GUICtrlCreateButton( "", 52, 88, 30, 30)
	GUICtrlSetStyle( -1, $BS_ICON)
	GUICtrlSetImage( -1, @ScriptDir&"\Resources.dll", -99, 0)
	GUICtrlSetTip(-1, "Bezier")
	GUICtrlSetResizing(-1, 802)
	$hBtn3 = GUICtrlCreateButton( "", 17, 123, 30, 30)
	GUICtrlSetStyle( -1, $BS_ICON)
	GUICtrlSetImage( -1, @ScriptDir&"\Resources.dll", -109, 0)
	GUICtrlSetTip(-1, "Curve")
	GUICtrlSetResizing(-1, 802)
	$hBtn4 = GUICtrlCreateButton( "", 52, 123, 30, 30)
	GUICtrlSetStyle( -1, $BS_ICON)
	GUICtrlSetImage( -1, @ScriptDir&"\Resources.dll", -101, 0)
	GUICtrlSetTip(-1, "Ellipse")
	GUICtrlSetResizing(-1, 802)
	$hBtn5 = GUICtrlCreateButton( "", 52, 158, 30, 30)
	GUICtrlSetStyle( -1, $BS_ICON)
	GUICtrlSetImage( -1, @ScriptDir&"\Resources.dll", -27, 0)
	GUICtrlSetTip(-1, "Image")
	GUICtrlSetResizing(-1, 802)
	$hBtn6 = GUICtrlCreateButton( "", 17, 158, 30, 30)
	GUICtrlSetStyle( -1, $BS_ICON)
	GUICtrlSetImage( -1, @ScriptDir&"\Resources.dll", -98, 0)
	GUICtrlSetTip(-1, "Line")
	GUICtrlSetResizing(-1, 802)
	$hBtn7 = GUICtrlCreateButton( "", 17, 193, 30, 30)
	GUICtrlSetStyle( -1, $BS_ICON)
	GUICtrlSetImage( -1, @ScriptDir&"\Resources.dll", -102, 0)
	GUICtrlSetTip(-1, "Pie")
	GUICtrlSetResizing(-1, 802)
	$hBtn8 = GUICtrlCreateButton( "", 52, 193, 30, 30)
	GUICtrlSetStyle( -1, $BS_ICON)
	GUICtrlSetImage( -1, @ScriptDir&"\Resources.dll", -110, 0)
	GUICtrlSetTip(-1, "Polygon")
	GUICtrlSetResizing(-1, 802)
	$hBtn9 = GUICtrlCreateButton( "", 52, 228, 30, 30)
	GUICtrlSetStyle( -1, $BS_ICON)
	GUICtrlSetImage( -1, @ScriptDir&"\Resources.dll", -100, 0)
	GUICtrlSetTip(-1, "Rectangle")
	GUICtrlSetResizing(-1, 802)
	$hBtn10 = GUICtrlCreateButton( "", 17, 228, 30, 30)
	GUICtrlSetStyle( -1, $BS_ICON)
	GUICtrlSetImage( -1, @ScriptDir&"\Resources.dll", -22, 0)
	GUICtrlSetTip(-1, "String")
	GUICtrlSetResizing(-1, 802)
	$hBtn11 = GUICtrlCreateButton( "", 17, 263, 30, 30)
	GUICtrlSetStyle( -1, $BS_ICON)
	GUICtrlSetImage( -1, @ScriptDir&"\Resources.dll", -111, 0)
	GUICtrlSetTip(-1, "Closed Curve")
	GUICtrlSetResizing(-1, 802)
	$hLine_1 = GUICtrlCreateLabel( "", 101, 21, 1, 2000)
	GUICtrlSetBkColor( -1, 0xB0B0B0)
	GUICtrlSetResizing(-1, 802)
	$hLine_2 = GUICtrlCreateLabel( "", 102, 21, 1, 2000)
	GUICtrlSetBkColor( -1, 0xFFFFFF)
	GUICtrlSetResizing(-1, 802)
	$hLine_3 = GUICtrlCreateLabel( "", 0, 21, 2000, 1)
	GUICtrlSetBkColor( -1, 0xB0B0B0)
	GUICtrlSetResizing(-1, 802)
	$hLine_4 = GUICtrlCreateLabel( "", 101, 69, 2000, 1)
	GUICtrlSetBkColor( -1, 0xB0B0B0)
	GUICtrlSetResizing(-1, 802)
	$hLine_5 = GUICtrlCreateLabel( "", 102, 70, 2000, 1)
	GUICtrlSetBkColor( -1, 0xFFFFFF)
	GUICtrlSetResizing(-1, 802)

	$hP1Label = GUICtrlCreateLabel( "X:", 110, 25, 10, 10)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)
	$hP2Label = GUICtrlCreateLabel( "Y:", 155, 25, 10, 10)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)
	$hP3Label = GUICtrlCreateLabel( "W:", 106, 37, 12, 10)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)
	$hP4Label = GUICtrlCreateLabel( "H:", 155, 37, 12, 10)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)
	$hP1Display = GUICtrlCreateLabel( "100", 125, 26, 20, 10)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)
	$hP2Display = GUICtrlCreateLabel( "100", 170, 26, 20, 10)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)
	$hP3Display = GUICtrlCreateLabel( "200", 125, 38, 20, 10)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)
	$hP4Display = GUICtrlCreateLabel( "100", 170, 38, 20, 10)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)
	$hP5Label = GUICtrlCreateLabel( "Sweep Angle:", 194, 25, 58, 11)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)
	$hP5Display = GUICtrlCreateLabel( "65°", 264, 26, 20, 10)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)
	$hP6Label = GUICtrlCreateLabel( "Rotation Angle:", 195, 37, 65, 11)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)
	$hP6Display = GUICtrlCreateLabel( "360°", 264, 38, 20, 10)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)

	$hP7Label = GUICtrlCreateLabel( "X4:", 294, 25, 58, 10)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)
	$hP7Display = GUICtrlCreateLabel( "100", 364, 26, 20, 10)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)
	$hP8Label = GUICtrlCreateLabel( "Y4:", 295, 37, 65, 11)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)
	$hP8Display = GUICtrlCreateLabel( "100", 364, 38, 20, 10)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_HIDE)


	$hColorLabel = GUICtrlCreateLabel( "Color:", 107, 52, 27, 10)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	$hFillLabel = GUICtrlCreateLabel( "Fill Color:", 210, 52, 40, 10)
	GUICtrlSetFont( -1, 7, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	$hColorInput = GUICtrlCreateInput( "", 136, 51, 50, 14)
	GUICtrlSetStyle( -1, $ES_CENTER)
	GUICtrlSetFont( -1, 6, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	$hFillInput = GUICtrlCreateInput( "", 258, 51, 50, 14)
	GUICtrlSetStyle( -1, $ES_CENTER)
	GUICtrlSetFont( -1, 6, 400, 0, "Arial")
	GUICtrlSetResizing(-1, 802)
	$hColorBk = GUICtrlCreateLabel( "", 189, 51, 14, 14)
	GUICtrlSetBkColor( -1, 0x000000)
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_DISABLE)
	$hColorPick = GUICtrlCreateLabel( "", 190, 52, 12, 12)
	GUICtrlSetBkColor( -1, 0xFFFFFF)
	GUICtrlSetResizing(-1, 802)
	$hBkColorBk = GUICtrlCreateLabel( "", 311, 51, 14, 14)
	GUICtrlSetBkColor( -1, 0x000000)
	GUICtrlSetResizing(-1, 802)
	GUICtrlSetState(-1, $GUI_DISABLE)
	$hBkColorPick = GUICtrlCreateLabel( "", 312, 52, 12, 12)
	GUICtrlSetBkColor( -1, 0xFFFFFF)
	GUICtrlSetResizing(-1, 802)

	$hAsking = GUICtrlCreateLabel( "", 115, 72, 250, 13)
	GUICtrlSetFont( -1, 8.5, 400, 0, "Verdana")
	GUICtrlSetColor( -1, 0x01A3A3)
	GUICtrlSetResizing(-1, 802)

	$hGDIBoarderT = GUICtrlCreateLabel("", 113, 87, $hGDIWidth+2, 1)
	GUICtrlSetBkColor( -1, 0xB0B0B0)
	GUICtrlSetResizing(-1, 802)
	$hGDIBoarderB = GUICtrlCreateLabel("", 113, 87+$hGDIHeight+2, $hGDIWidth+2, 1)
	GUICtrlSetBkColor( -1, 0xB0B0B0)
	GUICtrlSetResizing(-1, 802)
	$hGDIBoarderL = GUICtrlCreateLabel("", 113, 87, 1, $hGDIHeight+2)
	GUICtrlSetBkColor( -1, 0xB0B0B0)
	GUICtrlSetResizing(-1, 802)
	$hGDIBoarderR = GUICtrlCreateLabel("", 113+$hGDIWidth+2, 87, 1, $hGDIHeight+3)
	GUICtrlSetBkColor( -1, 0xB0B0B0)
	GUICtrlSetResizing(-1, 802)

	$hModeWidth = WinGetClientSize($GUIHolder)
	;$RotateButton = GUICtrlCreateButton("Rotate", $hModeWidth[0]-210, 43, 90, 23)
	;GUICtrlSetResizing(-1, 4+32+256+512)
	$SaveGDIButton = GUICtrlCreateButton("Save", $hModeWidth[0]-105, 43, 100, 23)
	GUICtrlSetResizing(-1, 4+32+256+512)

	GUISetState()

	_ArrayAdd($GUIElements, $hBrushInput)
	_ArrayAdd($GUIElements, $hBrushColor)
	_ArrayAdd($GUIElements, $hBrushBkColor)
	_ArrayAdd($GUIElements, $hBtn1)
	_ArrayAdd($GUIElements, $hBtn2)
	_ArrayAdd($GUIElements, $hBtn3)
	_ArrayAdd($GUIElements, $hBtn4)
	_ArrayAdd($GUIElements, $hBtn5)
	_ArrayAdd($GUIElements, $hBtn6)
	_ArrayAdd($GUIElements, $hBtn7)
	_ArrayAdd($GUIElements, $hBtn8)
	_ArrayAdd($GUIElements, $hBtn9)
	_ArrayAdd($GUIElements, $hBtn10)
	_ArrayAdd($GUIElements, $hBtn11)
	_ArrayAdd($GUIElements, $hLine_1)
	_ArrayAdd($GUIElements, $hLine_2)
	_ArrayAdd($GUIElements, $hLine_3)
	_ArrayAdd($GUIElements, $hLine_4)
	_ArrayAdd($GUIElements, $hLine_5)
	_ArrayAdd($GUIElements, $hGDIBoarderT)
	_ArrayAdd($GUIElements, $hGDIBoarderB)
	_ArrayAdd($GUIElements, $hGDIBoarderR)
	_ArrayAdd($GUIElements, $hGDIBoarderL)
	_ArrayAdd($GUIElements, $hBrushBk)
	_ArrayAdd($GUIElements, $hP1Label)
	_ArrayAdd($GUIElements, $hP2Label)
	_ArrayAdd($GUIElements, $hP3Label)
	_ArrayAdd($GUIElements, $hP4Label)
	_ArrayAdd($GUIElements, $hP5Label)
	_ArrayAdd($GUIElements, $hP6Label)
	_ArrayAdd($GUIElements, $hP7Label)
	_ArrayAdd($GUIElements, $hP8Label)
	_ArrayAdd($GUIElements, $hP1Display)
	_ArrayAdd($GUIElements, $hP2Display)
	_ArrayAdd($GUIElements, $hP3Display)
	_ArrayAdd($GUIElements, $hP4Display)
	_ArrayAdd($GUIElements, $hP5Display)
	_ArrayAdd($GUIElements, $hP6Display)
	_ArrayAdd($GUIElements, $hP7Display)
	_ArrayAdd($GUIElements, $hP8Display)
	_ArrayAdd($GUIElements, $hColorLabel)
	_ArrayAdd($GUIElements, $hColorPick)
	_ArrayAdd($GUIElements, $hFillLabel)
	_ArrayAdd($GUIElements, $hColorBk)
	_ArrayAdd($GUIElements, $hBkColorBk)
	_ArrayAdd($GUIElements, $hBkColorPick)
	_ArrayAdd($GUIElements, $hColorInput)
	_ArrayAdd($GUIElements, $hFillInput)
	_ArrayAdd($GUIElements, $hAsking)
	_ArrayAdd($GUIElements, $hBrushBkBk)
	_ArrayAdd($GUIElements, $hBrushBk)
	_ArrayAdd($GUIElements, $hBrushUpdown)
	_ArrayAdd($GUIElements, $SaveGDIButton)
	;_ArrayAdd($GUIElements, $RotateButton)
	$GUIElements[0] = 53
	$hGDIGUI = GUICreate("", $hGDIWidth, $hGDIHeight, 114, 88, $WS_POPUP)
	$hGDIPlus = _GDIPlus_GraphicsCreateFromHWND($hGDIGUI)
	$hGDIPen = _GDIPlus_PenCreate(0xFF000000, $BrushSize)
	$hGDIBrush = _GDIPlus_BrushCreateSolid(0xFF000000)
	_GDIPlus_GraphicsSetSmoothingMode($hGDIPlus, 2)
	DllCall($dll, "int", "SetParent", "hwnd", WinGetHandle($hGDIGUI), "hwnd", WinGetHandle($GUIHolder))
	GUISetState(@SW_SHOW)

	_DrawGDIPlusData( $hIndex, $Data[$hIndex], $hGDIGUI, True)

	If $GDITrees[0] > 0 Then
		$hParent = _GUICtrlTreeView_GetParentHandle($hTree, $GDITrees[1])
		_GUICtrlTreeView_BeginUpdate($hTree)
		_GUICtrlTreeView_SetChildren($hTree, $hParent, True)
		_GUICtrlTreeView_Expand($hTree, $hParent, True)
		_GUICtrlTreeView_EndUpdate($hTree)
	EndIf

	If $Data[$hIndex] <> "" Then
		$GDIPlusData = StringSplit($Data[$hIndex], ";")
	EndIf

	Dim $SelectedX[1] = [0], $SelectedY[1] = [0], $SelectedItem = 0

	While $GDIPlusRunning = True
		Dim $Selected = False
		For $i = 1 To $GDITrees[0] Step 1
			If _GUICtrlTreeView_GetSelected($hTree,$GDITrees[$i]) = True Then
				If $SelectedItem <> $i Then
					_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
					_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
					$Selected = True
					$SelectedItem = $i
					$hDataSplit = StringSplit($GDIPlusData[$i], ":")
					Switch $hDataSplit[1]
						Case "A"
							GUICtrlSetState($hP1Label, $GUI_SHOW)
							GUICtrlSetState($hP1Display, $GUI_SHOW)
							GUICtrlSetState($hP2Label, $GUI_SHOW)
							GUICtrlSetState($hP2Display, $GUI_SHOW)
							GUICtrlSetState($hP3Label, $GUI_SHOW)
							GUICtrlSetState($hP4Label, $GUI_SHOW)
							GUICtrlSetState($hP3Display, $GUI_SHOW)
							GUICtrlSetState($hP4Display, $GUI_SHOW)
							GUICtrlSetState($hP5Label, $GUI_SHOW)
							GUICtrlSetState($hP6Label, $GUI_SHOW)
							GUICtrlSetState($hP5Display, $GUI_SHOW)
							GUICtrlSetState($hP6Display, $GUI_SHOW)
							GUICtrlSetState($hP7Label, $GUI_HIDE)
							GUICtrlSetState($hP8Label, $GUI_HIDE)
							GUICtrlSetState($hP7Display, $GUI_HIDE)
							GUICtrlSetState($hP8Display, $GUI_HIDE)
							GUICtrlSetData($hP5Label, "Sweep Angle:")
							GUICtrlSetData($hP6Label, "Rotation Angle:")
							GUICtrlSetPos($hP5Label, 194, 25, 60, 11)
							GUICtrlSetPos($hP6Label, 194, 37, 65, 11)
							GUICtrlSetPos($hP5Display, 264, 26, 20, 10)
							GUICtrlSetPos($hP6Display, 264, 38, 20, 10)
							GUICtrlSetData($hP1Label, "X:")
							GUICtrlSetData($hP2Label, "Y:")
							GUICtrlSetData($hP3Label, "W:")
							GUICtrlSetData($hP4Label, "H:")
							GUICtrlSetData($hP5Display, "-")
							GUICtrlSetData($hP6Display, "-")
							GUICtrlSetData($hFillInput, "")
							GUICtrlSetState($hFillInput, $GUI_DISABLE)
							GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
							GUICtrlSetData($hP1Display, $hDataSplit[2])
							GUICtrlSetData($hP2Display, $hDataSplit[3])
							GUICtrlSetData($hP3Display, $hDataSplit[4])
							GUICtrlSetData($hP4Display, $hDataSplit[5])
							GUICtrlSetData($hP5Display, $hDataSplit[7]&"°")
							GUICtrlSetData($hP6Display, $hDataSplit[6]&"°")
							GUICtrlSetData($hColorInput, $hDataSplit[8])
							GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($hDataSplit[8], 2))
						Case "B"
							GUICtrlSetState($hP1Label, $GUI_SHOW)
							GUICtrlSetState($hP1Display, $GUI_SHOW)
							GUICtrlSetState($hP2Label, $GUI_SHOW)
							GUICtrlSetState($hP2Display, $GUI_SHOW)
							GUICtrlSetState($hP3Label, $GUI_SHOW)
							GUICtrlSetState($hP4Label, $GUI_SHOW)
							GUICtrlSetState($hP3Display, $GUI_SHOW)
							GUICtrlSetState($hP4Display, $GUI_SHOW)
							GUICtrlSetState($hP5Label, $GUI_SHOW)
							GUICtrlSetState($hP6Label, $GUI_SHOW)
							GUICtrlSetState($hP5Display, $GUI_SHOW)
							GUICtrlSetState($hP6Display, $GUI_SHOW)
							GUICtrlSetState($hP7Label, $GUI_SHOW)
							GUICtrlSetState($hP8Label, $GUI_SHOW)
							GUICtrlSetState($hP7Display, $GUI_SHOW)
							GUICtrlSetState($hP8Display, $GUI_SHOW)
							GUICtrlSetData($hP1Label, "X¹:")
							GUICtrlSetData($hP2Label, "Y¹:")
							GUICtrlSetData($hP3Label, "X²:")
							GUICtrlSetData($hP4Label, "Y²:")
							GUICtrlSetData($hP5Label, "X³:")
							GUICtrlSetData($hP6Label, "Y³:")
							GUICtrlSetData($hP7Label, "X³:")
							GUICtrlSetData($hP8Label, "Y³:")
							GUICtrlSetPos($hP5Label, 194, 25, 20, 11)
							GUICtrlSetPos($hP6Label, 192, 37, 20, 11)
							GUICtrlSetPos($hP5Display, 214, 26, 20, 10)
							GUICtrlSetPos($hP6Display, 214, 38, 20, 10)
							GUICtrlSetPos($hP7Label, 244, 25, 20, 11)
							GUICtrlSetPos($hP8Label, 242, 37, 20, 11)
							GUICtrlSetPos($hP7Display, 264, 26, 20, 10)
							GUICtrlSetPos($hP8Display, 264, 38, 20, 10)
							GUICtrlSetData($hFillInput, "")
							GUICtrlSetState($hFillInput, $GUI_DISABLE)
							GUICtrlSetData($hP1Display, $hDataSplit[2])
							GUICtrlSetData($hP2Display, $hDataSplit[3])
							GUICtrlSetData($hP3Display, $hDataSplit[4])
							GUICtrlSetData($hP4Display, $hDataSplit[5])
							GUICtrlSetData($hP5Display, $hDataSplit[6])
							GUICtrlSetData($hP6Display, $hDataSplit[7])
							GUICtrlSetData($hP7Display, $hDataSplit[8])
							GUICtrlSetData($hP8Display, $hDataSplit[9])
							GUICtrlSetData($hColorInput, $hDataSplit[10])
							GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($hDataSplit[10], 2))
							GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
						Case "C"
							GUICtrlSetState($hP1Label, $GUI_HIDE)
							GUICtrlSetState($hP1Display, $GUI_HIDE)
							GUICtrlSetState($hP2Label, $GUI_HIDE)
							GUICtrlSetState($hP2Display, $GUI_HIDE)
							GUICtrlSetState($hP3Label, $GUI_HIDE)
							GUICtrlSetState($hP4Label, $GUI_HIDE)
							GUICtrlSetState($hP3Display, $GUI_HIDE)
							GUICtrlSetState($hP4Display, $GUI_HIDE)
							GUICtrlSetState($hP5Label, $GUI_HIDE)
							GUICtrlSetState($hP6Label, $GUI_HIDE)
							GUICtrlSetState($hP5Display, $GUI_HIDE)
							GUICtrlSetState($hP6Display, $GUI_HIDE)
							GUICtrlSetState($hP7Label, $GUI_HIDE)
							GUICtrlSetState($hP8Label, $GUI_HIDE)
							GUICtrlSetState($hP7Display, $GUI_HIDE)
							GUICtrlSetState($hP8Display, $GUI_HIDE)
							GUICtrlSetData($hP1Display, ($hDataSplit[0]/2)-4&"/20")
							GUICtrlSetData($hColorInput, $hDataSplit[$hDataSplit[0]-2])
							GUICtrlSetData($hFillInput, "")
							GUICtrlSetState($hFillInput, $GUI_DISABLE)
							GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($hDataSplit[$hDataSplit[0]-2], 2))
							GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
						Case "E"
							GUICtrlSetState($hP1Label, $GUI_SHOW)
							GUICtrlSetState($hP1Display, $GUI_SHOW)
							GUICtrlSetState($hP2Label, $GUI_SHOW)
							GUICtrlSetState($hP2Display, $GUI_SHOW)
							GUICtrlSetState($hP3Label, $GUI_SHOW)
							GUICtrlSetState($hP4Label, $GUI_SHOW)
							GUICtrlSetState($hP3Display, $GUI_SHOW)
							GUICtrlSetState($hP4Display, $GUI_SHOW)
							GUICtrlSetState($hP5Label, $GUI_HIDE)
							GUICtrlSetState($hP6Label, $GUI_HIDE)
							GUICtrlSetState($hP5Display, $GUI_HIDE)
							GUICtrlSetState($hP6Display, $GUI_HIDE)
							GUICtrlSetState($hP7Label, $GUI_HIDE)
							GUICtrlSetState($hP8Label, $GUI_HIDE)
							GUICtrlSetState($hP7Display, $GUI_HIDE)
							GUICtrlSetState($hP8Display, $GUI_HIDE)
							GUICtrlSetState($hFillInput, $GUI_ENABLE)
							GUICtrlSetData($hP1Display, $hDataSplit[2])
							GUICtrlSetData($hP2Display, $hDataSplit[3])
							GUICtrlSetData($hP3Display, $hDataSplit[4])
							GUICtrlSetData($hP4Display, $hDataSplit[5])
							GUICtrlSetData($hColorInput, $hDataSplit[6])
							GUICtrlSetData($hFillInput, $hDataSplit[7])
							GUICtrlSetData($hP1Label, "X:")
							GUICtrlSetData($hP2Label, "Y:")
							GUICtrlSetData($hP3Label, "W:")
							GUICtrlSetData($hP4Label, "H:")
							If $hDataSplit[6] = "" Then
								GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
							Else
								GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($hDataSplit[6], 2))
							EndIf
							If $hDataSplit[7] = "" Then
								GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
							Else
								GUICtrlSetBkColor($hBkColorPick, "0x"&StringTrimLeft($hDataSplit[7], 2))
							EndIf
						Case "I"
							GUICtrlSetState($hP1Label, $GUI_SHOW)
							GUICtrlSetState($hP1Display, $GUI_SHOW)
							GUICtrlSetState($hP2Label, $GUI_SHOW)
							GUICtrlSetState($hP2Display, $GUI_SHOW)
							GUICtrlSetState($hP3Label, $GUI_SHOW)
							GUICtrlSetState($hP4Label, $GUI_SHOW)
							GUICtrlSetState($hP3Display, $GUI_SHOW)
							GUICtrlSetState($hP4Display, $GUI_SHOW)
							GUICtrlSetState($hP5Label, $GUI_HIDE)
							GUICtrlSetState($hP6Label, $GUI_HIDE)
							GUICtrlSetState($hP5Display, $GUI_HIDE)
							GUICtrlSetState($hP6Display, $GUI_HIDE)
							GUICtrlSetState($hP7Label, $GUI_HIDE)
							GUICtrlSetState($hP8Label, $GUI_HIDE)
							GUICtrlSetState($hP7Display, $GUI_HIDE)
							GUICtrlSetState($hP8Display, $GUI_HIDE)
							GUICtrlSetData($hP1Label, "X:")
							GUICtrlSetData($hP2Label, "Y:")
							GUICtrlSetData($hP3Label, "W:")
							GUICtrlSetData($hP4Label, "H:")
							GUICtrlSetData($hP1Display, $hDataSplit[3])
							GUICtrlSetData($hP2Display, $hDataSplit[4])
							GUICtrlSetData($hP3Display, $hDataSplit[5])
							GUICtrlSetData($hP4Display, $hDataSplit[6])
							GUICtrlSetData($hFillInput, "")
							GUICtrlSetState($hFillInput, $GUI_DISABLE)
							GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
						Case "L"
							GUICtrlSetState($hP1Label, $GUI_SHOW)
							GUICtrlSetState($hP1Display, $GUI_SHOW)
							GUICtrlSetState($hP2Label, $GUI_SHOW)
							GUICtrlSetState($hP2Display, $GUI_SHOW)
							GUICtrlSetState($hP3Label, $GUI_SHOW)
							GUICtrlSetState($hP4Label, $GUI_SHOW)
							GUICtrlSetState($hP3Display, $GUI_SHOW)
							GUICtrlSetState($hP4Display, $GUI_SHOW)
							GUICtrlSetState($hP5Label, $GUI_HIDE)
							GUICtrlSetState($hP6Label, $GUI_HIDE)
							GUICtrlSetState($hP5Display, $GUI_HIDE)
							GUICtrlSetState($hP6Display, $GUI_HIDE)
							GUICtrlSetState($hP7Label, $GUI_HIDE)
							GUICtrlSetState($hP8Label, $GUI_HIDE)
							GUICtrlSetState($hP7Display, $GUI_HIDE)
							GUICtrlSetState($hP8Display, $GUI_HIDE)
							GUICtrlSetData($hFillInput, "")
							GUICtrlSetData($hP1Label, "X¹:")
							GUICtrlSetData($hP2Label, "Y¹:")
							GUICtrlSetData($hP3Label, "X²:")
							GUICtrlSetData($hP4Label, "Y²:")
							GUICtrlSetState($hFillInput, $GUI_DISABLE)
							GUICtrlSetData($hP1Display, $hDataSplit[2])
							GUICtrlSetData($hP2Display, $hDataSplit[3])
							GUICtrlSetData($hP3Display, $hDataSplit[4])
							GUICtrlSetData($hP4Display, $hDataSplit[5])
							GUICtrlSetData($hColorInput, $hDataSplit[6])
							GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($hDataSplit[6], 2))
							GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
						Case "P"
							GUICtrlSetState($hP1Label, $GUI_SHOW)
							GUICtrlSetState($hP1Display, $GUI_SHOW)
							GUICtrlSetState($hP2Label, $GUI_SHOW)
							GUICtrlSetState($hP2Display, $GUI_SHOW)
							GUICtrlSetState($hP3Label, $GUI_SHOW)
							GUICtrlSetState($hP4Label, $GUI_SHOW)
							GUICtrlSetState($hP3Display, $GUI_SHOW)
							GUICtrlSetState($hP4Display, $GUI_SHOW)
							GUICtrlSetState($hP5Label, $GUI_SHOW)
							GUICtrlSetState($hP6Label, $GUI_SHOW)
							GUICtrlSetState($hP5Display, $GUI_SHOW)
							GUICtrlSetState($hP6Display, $GUI_SHOW)
							GUICtrlSetState($hP7Label, $GUI_HIDE)
							GUICtrlSetState($hP8Label, $GUI_HIDE)
							GUICtrlSetState($hP7Display, $GUI_HIDE)
							GUICtrlSetState($hP8Display, $GUI_HIDE)
							GUICtrlSetState($hFillInput, $GUI_ENABLE)
							GUICtrlSetData($hP1Label, "X:")
							GUICtrlSetData($hP2Label, "Y:")
							GUICtrlSetData($hP3Label, "W:")
							GUICtrlSetData($hP4Label, "H:")
							GUICtrlSetData($hP5Label, "Sweep Angle:")
							GUICtrlSetData($hP6Label, "Rotation Angle:")
							GUICtrlSetData($hP1Display, $hDataSplit[2])
							GUICtrlSetData($hP2Display, $hDataSplit[3])
							GUICtrlSetData($hP3Display, $hDataSplit[4])
							GUICtrlSetData($hP4Display, $hDataSplit[5])
							GUICtrlSetData($hP5Display, $hDataSplit[7]&"°")
							GUICtrlSetData($hP6Display, $hDataSplit[6]&"°")
							GUICtrlSetData($hColorInput, $hDataSplit[8])
							GUICtrlSetData($hFillInput, $hDataSplit[9])
							If $hDataSplit[8] = "" Then
								GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
							Else
								GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($hDataSplit[8], 2))
							EndIf
							If $hDataSplit[9] = "" Then
								GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
							Else
								GUICtrlSetBkColor($hBkColorPick, "0x"&StringTrimLeft($hDataSplit[9], 2))
							EndIf
						Case "Po"
							GUICtrlSetState($hP1Label, $GUI_HIDE)
							GUICtrlSetState($hP1Display, $GUI_HIDE)
							GUICtrlSetState($hP2Label, $GUI_HIDE)
							GUICtrlSetState($hP2Display, $GUI_HIDE)
							GUICtrlSetState($hP3Label, $GUI_HIDE)
							GUICtrlSetState($hP4Label, $GUI_HIDE)
							GUICtrlSetState($hP3Display, $GUI_HIDE)
							GUICtrlSetState($hP4Display, $GUI_HIDE)
							GUICtrlSetState($hP5Label, $GUI_HIDE)
							GUICtrlSetState($hP6Label, $GUI_HIDE)
							GUICtrlSetState($hP5Display, $GUI_HIDE)
							GUICtrlSetState($hP6Display, $GUI_HIDE)
							GUICtrlSetState($hP7Label, $GUI_HIDE)
							GUICtrlSetState($hP8Label, $GUI_HIDE)
							GUICtrlSetState($hP7Display, $GUI_HIDE)
							GUICtrlSetState($hP8Display, $GUI_HIDE)
							GUICtrlSetState($hFillInput, $GUI_ENABLE)
							GUICtrlSetData($hP1Display, ($hDataSplit[0]/2)-4&"/20")
							GUICtrlSetData($hColorInput, $hDataSplit[$hDataSplit[0]-3])
							GUICtrlSetData($hFillInput, $hDataSplit[$hDataSplit[0]-2])
							If $hDataSplit[$hDataSplit[0]-3] = "" Then
								GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
							Else
								GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($hDataSplit[$hDataSplit[0]-3], 2))
							EndIf
							If $hDataSplit[$hDataSplit[0]-2] = "" Then
								GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
							Else
								GUICtrlSetBkColor($hBkColorPick, "0x"&StringTrimLeft($hDataSplit[$hDataSplit[0]-2], 2))
							EndIf
						Case "R"
							GUICtrlSetState($hP1Label, $GUI_SHOW)
							GUICtrlSetState($hP1Display, $GUI_SHOW)
							GUICtrlSetState($hP2Label, $GUI_SHOW)
							GUICtrlSetState($hP2Display, $GUI_SHOW)
							GUICtrlSetState($hP3Label, $GUI_SHOW)
							GUICtrlSetState($hP4Label, $GUI_SHOW)
							GUICtrlSetState($hP3Display, $GUI_SHOW)
							GUICtrlSetState($hP4Display, $GUI_SHOW)
							GUICtrlSetState($hP5Label, $GUI_HIDE)
							GUICtrlSetState($hP6Label, $GUI_HIDE)
							GUICtrlSetState($hP5Display, $GUI_HIDE)
							GUICtrlSetState($hP6Display, $GUI_HIDE)
							GUICtrlSetState($hP7Label, $GUI_HIDE)
							GUICtrlSetState($hP8Label, $GUI_HIDE)
							GUICtrlSetState($hP7Display, $GUI_HIDE)
							GUICtrlSetState($hP8Display, $GUI_HIDE)
							GUICtrlSetState($hFillInput, $GUI_ENABLE)
							GUICtrlSetData($hP1Display, $hDataSplit[2])
							GUICtrlSetData($hP2Display, $hDataSplit[3])
							GUICtrlSetData($hP3Display, $hDataSplit[4])
							GUICtrlSetData($hP4Display, $hDataSplit[5])
							GUICtrlSetData($hColorInput, $hDataSplit[6])
							GUICtrlSetData($hFillInput, $hDataSplit[7])
							GUICtrlSetData($hP1Label, "X:")
							GUICtrlSetData($hP2Label, "Y:")
							GUICtrlSetData($hP3Label, "W:")
							GUICtrlSetData($hP4Label, "H:")
							If $hDataSplit[7] = "" Then
								GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
							Else
								GUICtrlSetBkColor($hBkColorPick, "0x"&StringTrimLeft($hDataSplit[7], 2))
							EndIf
							If $hDataSplit[6] = "" Then
								GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
							Else
								GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($hDataSplit[6], 2))
							EndIf
						Case "S"
							GUICtrlSetState($hP1Label, $GUI_HIDE)
							GUICtrlSetState($hP1Display, $GUI_HIDE)
							GUICtrlSetState($hP2Label, $GUI_HIDE)
							GUICtrlSetState($hP2Display, $GUI_HIDE)
							GUICtrlSetState($hP3Label, $GUI_HIDE)
							GUICtrlSetState($hP4Label, $GUI_HIDE)
							GUICtrlSetState($hP3Display, $GUI_HIDE)
							GUICtrlSetState($hP4Display, $GUI_HIDE)
							GUICtrlSetState($hP5Label, $GUI_HIDE)
							GUICtrlSetState($hP6Label, $GUI_HIDE)
							GUICtrlSetState($hP5Display, $GUI_HIDE)
							GUICtrlSetState($hP6Display, $GUI_HIDE)
							GUICtrlSetState($hP7Label, $GUI_HIDE)
							GUICtrlSetState($hP8Label, $GUI_HIDE)
							GUICtrlSetState($hP7Display, $GUI_HIDE)
							GUICtrlSetState($hP8Display, $GUI_HIDE)
							GUICtrlSetData($hColorInput, "")
							GUICtrlSetData($hFillInput, "")
							GUICtrlSetState($hColorInput, $GUI_DISABLE)
							GUICtrlSetState($hFillInput, $GUI_DISABLE)
							GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
							GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
						Case "CC"
							GUICtrlSetState($hP1Label, $GUI_HIDE)
							GUICtrlSetState($hP1Display, $GUI_HIDE)
							GUICtrlSetState($hP2Label, $GUI_HIDE)
							GUICtrlSetState($hP2Display, $GUI_HIDE)
							GUICtrlSetState($hP3Label, $GUI_HIDE)
							GUICtrlSetState($hP4Label, $GUI_HIDE)
							GUICtrlSetState($hP3Display, $GUI_HIDE)
							GUICtrlSetState($hP4Display, $GUI_HIDE)
							GUICtrlSetState($hP5Label, $GUI_HIDE)
							GUICtrlSetState($hP6Label, $GUI_HIDE)
							GUICtrlSetState($hP5Display, $GUI_HIDE)
							GUICtrlSetState($hP6Display, $GUI_HIDE)
							GUICtrlSetState($hP7Label, $GUI_HIDE)
							GUICtrlSetState($hP8Label, $GUI_HIDE)
							GUICtrlSetState($hP7Display, $GUI_HIDE)
							GUICtrlSetState($hP8Display, $GUI_HIDE)
							GUICtrlSetState($hFillInput, $GUI_ENABLE)
							GUICtrlSetData($hP1Display, ($hDataSplit[0]/2)-4&"/20")
							GUICtrlSetData($hColorInput, $hDataSplit[$hDataSplit[0]-3])
							GUICtrlSetData($hFillInput, $hDataSplit[$hDataSplit[0]-2])
							If $hDataSplit[$hDataSplit[0]-3] = "" Then
								GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
							Else
								GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($hDataSplit[$hDataSplit[0]-3], 2))
							EndIf
							If $hDataSplit[$hDataSplit[0]-2] = "" Then
								GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
							Else
								GUICtrlSetBkColor($hBkColorPick, "0x"&StringTrimLeft($hDataSplit[$hDataSplit[0]-2], 2))
							EndIf
					EndSwitch

					Dim $SelectedX[1] = [0], $SelectedY[1] = [0]
					$hPenWidth = _GDIPlus_PenGetWidth($hGDIPen)
					$hPenRead = _GDIPlus_PenGetColor($hGDIPen)
					$hBrushRead = _GDIPlus_BrushGetSolidColor($hGDIBrush)
					_GDIPlus_PenSetColor($hGDIPen, "0xFF000000")
					_GDIPlus_PenSetWidth($hGDIPen, 1)
					_GDIPlus_BrushSetSolidColor($hGDIBrush, "0xFFFF0000")
					$hGDISplit = StringSplit($GDIPlusData[$i], ":")
					Switch $hGDISplit[1]
						Case "A"
							_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIBrush)
							_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3] -4, 9, 9, $hGDIPen)
							_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIBrush)
							_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIPen)
							_ArrayAdd($SelectedX, $hGDISplit[2])
							_ArrayAdd($SelectedY, $hGDISplit[3])
							_ArrayAdd($SelectedX, $hGDISplit[2]+$hGDISplit[4])
							_ArrayAdd($SelectedY, $hGDISplit[3]+$hGDISplit[5])
							$SelectedX[0] += 2
							$SelectedY[0] += 2
						Case "B"
							For $g = 2 to $hGDISplit[0]-3 Step 2
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIPen)
								_ArrayAdd($SelectedX, $hGDISplit[$g])
								_ArrayAdd($SelectedY, $hGDISplit[$g+1])
								$SelectedX[0] += 1
								$SelectedY[0] += 1
							Next
						Case "C"
							For $g = 2 to $hGDISplit[0]-3 Step 2
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIPen)
								_ArrayAdd($SelectedX, $hGDISplit[$g])
								_ArrayAdd($SelectedY, $hGDISplit[$g+1])
								$SelectedX[0] += 1
								$SelectedY[0] += 1
							Next
						Case "E"
							_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIBrush)
							_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIPen)
							_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIBrush)
							_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIPen)
							_ArrayAdd($SelectedX, $hGDISplit[2])
							_ArrayAdd($SelectedY, $hGDISplit[3])
							_ArrayAdd($SelectedX, $hGDISplit[2]+$hGDISplit[4])
							_ArrayAdd($SelectedY, $hGDISplit[3]+$hGDISplit[5])
							$SelectedX[0] += 2
							$SelectedY[0] += 2
						Case "I"
							_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[$hGDISplit[0]-5]-4, $hGDISplit[$hGDISplit[0]-4]-4, 9, 9, $hGDIBrush)
							_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[$hGDISplit[0]-5]-4, $hGDISplit[$hGDISplit[0]-4]-4, 9, 9, $hGDIPen)
							_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[$hGDISplit[0]-5]+$hGDISplit[$hGDISplit[0]-3]-4, $hGDISplit[$hGDISplit[0]-4]+$hGDISplit[$hGDISplit[0]-2]-4, 9, 9, $hGDIBrush)
							_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[$hGDISplit[0]-5]+$hGDISplit[$hGDISplit[0]-3]-4, $hGDISplit[$hGDISplit[0]-4]+$hGDISplit[$hGDISplit[0]-2]-4, 9, 9, $hGDIPen)
							_ArrayAdd($SelectedX, $hGDISplit[$hGDISplit[0]-5])
							_ArrayAdd($SelectedY, $hGDISplit[$hGDISplit[0]-4])
							_ArrayAdd($SelectedX, $hGDISplit[$hGDISplit[0]-5]+$hGDISplit[$hGDISplit[0]-3])
							_ArrayAdd($SelectedY, $hGDISplit[$hGDISplit[0]-4]+$hGDISplit[$hGDISplit[0]-2])
							$SelectedX[0] += 2
							$SelectedY[0] += 2
						Case "L"
							_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIBrush)
							_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIPen)
							_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[4]-4, $hGDISplit[5]-4, 9, 9, $hGDIBrush)
							_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[4]-4, $hGDISplit[5]-4, 9, 9, $hGDIPen)
							_ArrayAdd($SelectedX, $hGDISplit[2])
							_ArrayAdd($SelectedY, $hGDISplit[3])
							_ArrayAdd($SelectedX, $hGDISplit[4])
							_ArrayAdd($SelectedY, $hGDISplit[5])
							$SelectedX[0] += 2
							$SelectedY[0] += 2
						Case "P"
							_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIBrush)
							_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3] -4, 9, 9, $hGDIPen)
							_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIBrush)
							_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIPen)
							_ArrayAdd($SelectedX, $hGDISplit[2])
							_ArrayAdd($SelectedY, $hGDISplit[3])
							_ArrayAdd($SelectedX, $hGDISplit[2]+$hGDISplit[4])
							_ArrayAdd($SelectedY, $hGDISplit[3]+$hGDISplit[5])
							$SelectedX[0] += 2
							$SelectedY[0] += 2
						Case "Po"
							For $g = 2 to $hGDISplit[0]-4 Step 2
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIPen)
								_ArrayAdd($SelectedX, $hGDISplit[$g])
								_ArrayAdd($SelectedY, $hGDISplit[$g+1])
								$SelectedX[0] += 1
								$SelectedY[0] += 1
							Next
						Case "R"
							_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIBrush)
							_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIPen)
							_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIBrush)
							_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIPen)
							_ArrayAdd($SelectedX, $hGDISplit[2])
							_ArrayAdd($SelectedY, $hGDISplit[3])
							_ArrayAdd($SelectedX, $hGDISplit[2]+$hGDISplit[4])
							_ArrayAdd($SelectedY, $hGDISplit[3]+$hGDISplit[5])
							$SelectedX[0] += 2
							$SelectedY[0] += 2
						Case "S"
							_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIBrush)
							_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIPen)
							_ArrayAdd($SelectedX, $hGDISplit[2])
							_ArrayAdd($SelectedY, $hGDISplit[3])
							$SelectedX[0] += 1
							$SelectedY[0] += 1
						Case "CC"
							For $g = 2 to $hGDISplit[0]-4 Step 2
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIPen)
								_ArrayAdd($SelectedX, $hGDISplit[$g])
								_ArrayAdd($SelectedY, $hGDISplit[$g+1])
								$SelectedX[0] += 1
								$SelectedY[0] += 1
							Next
					EndSwitch
					_GDIPlus_PenSetWidth($hGDIPen, $hPenWidth)
					_GDIPlus_PenSetColor($hGDIPen, $hPenRead)
					_GDIPlus_BrushSetSolidColor($hGDIBrush, $hBrushRead)
				EndIf
			EndIf
		Next

		If $SelectedItem <> 0 Then
			$hMouse = GUIGetCursorInfo($hGDIGUI)
			Dim $hInPoint = False
			Dim $hOverPoint = True
			Dim $hPointIndex = 0
			For $i = 1 to $SelectedX[0] Step 1
				If $hMouse[0] > $SelectedX[$i]-5 and $hMouse[0] < $SelectedX[$i]+5 and $hMouse[1] > $SelectedY[$i]-5 and $hMouse[1] < $SelectedY[$i]+5 Then
					$hInPoint = True
					$hPointIndex = $i
					ExitLoop
				EndIf
			Next
			If $hInPoint = False and $hOverPoint = True Then
				$hOverPoint = False
				GUISetCursor( 2, 1, $hGDIGUI)
			EndIf
			If $hInPoint = True Then
				$hOverPoint = True
				GUISetCursor( 9, 1, $hGDIGUI)
			EndIf
			If _IsPressed("02") and $hPointIndex <> 0 Then
				$hDataSplit = StringSplit($GDIPlusData[$SelectedItem], ":")
				If $hDataSplit[1] = "S" Then
					Dim $hStringPrompt = True
					$hStringGUI = GUICreate( "String Edit", 240, 183, -1, -1)
					GUICtrlCreateLabel( "String:", 11, 8, 34, 14)
					$hStringInput = GUICtrlCreateEdit( $hDataSplit[4], 16, 27, 217, 59)
					GUICtrlCreateLabel( "Font:", 28, 97, 29, 14)
					$hFontInput = GUICtrlCreateCombo( "", 65, 94, 170, 21, 0x003)
					GUICtrlSetData( -1, $Fonts, $hDataSplit[5])
					GUICtrlCreateLabel( "Font Size:", 28, 128, 55, 16)
					$hSizeInput = GUICtrlCreateInput( $hDataSplit[6], 94, 125, 124, 21)
					$Updown8 = GUICtrlCreateUpDown( $hSizeInput )
					$hStringSave = GUICtrlCreateButton( "Save", 133, 153, 100, 24)
					$hStringCancel = GUICtrlCreateButton( "Cancel", 11, 153, 100, 24)
					GUISetState()

					While $hStringPrompt = True
						$hMsg = GUIGetMsg()
						Switch $hMsg
							Case $GUI_EVENT_CLOSE
								GUIDelete($hStringGUI)
								$hStringPrompt = False
							Case $hStringSave
								$hGDIString = StringReplace(StringReplace(GUICtrlRead($hStringInput), ";", "å"), ";", "Ñ")
								$GDIPlusData[$SelectedItem] = "S:"&$hDataSplit[2]&":"&$hDataSplit[3]&":"&$hGDIString&":"&GUICtrlRead($hFontInput)&":"&GUICtrlRead($hSizeInput)&":"
								_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
								_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
								$hPenWidth = _GDIPlus_PenGetWidth($hGDIPen)
								$hPenRead = _GDIPlus_PenGetColor($hGDIPen)
								$hBrushRead = _GDIPlus_BrushGetSolidColor($hGDIBrush)
								_GDIPlus_PenSetColor($hGDIPen, "0xFF000000")
								_GDIPlus_PenSetWidth($hGDIPen, 1)
								_GDIPlus_BrushSetSolidColor($hGDIBrush, "0xFFFF0000")
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIPen)
								_GDIPlus_PenSetWidth($hGDIPen, $hPenWidth)
								_GDIPlus_PenSetColor($hGDIPen, $hPenRead)
								_GDIPlus_BrushSetSolidColor($hGDIBrush, $hBrushRead)
								GUIDelete($hStringGUI)
								$hStringPrompt = False
							Case $hStringCancel
								GUIDelete($hStringGUI)
								$hStringPrompt = False
						EndSwitch
					WEnd
				EndIf
			EndIf
			If _IsPressed("2E") and $SelectedItem <> 0 Then
				_GUICtrlTreeView_BeginUpdate($hTree)
				_GUICtrlTreeView_Delete($hTree, $GDITrees[$SelectedItem])
				_GUICtrlTreeView_EndUpdate($hTree)
				_ArrayDelete($GDITrees, $SelectedItem)
				_ArrayDelete($GDIPlusData, $SelectedItem)
				$GDIPlusData[0] -= 1
				$GDITrees[0] -= 1
				$SelectedItem = 0
				_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
				_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
				Sleep(200)
			EndIf
			If $SelectedItem <> 0 Then
				Dim $hItemColor, $hItemBkColor
				$hDataSplit = StringSplit($GDIPlusData[$SelectedItem], ":")
				Switch $hDataSplit[1]
					Case "A"
						$hItemColor = $hDataSplit[8]
					Case "B"
						$hItemColor = $hDataSplit[10]
					Case "C"
						$hItemColor = $hDataSplit[$hDataSplit[0]-2]
					Case "E"
						$hItemColor = $hDataSplit[6]
						$hItemBkColor = $hDataSplit[7]
					Case "L"
						$hItemColor = $hDataSplit[6]
					Case "P"
						$hItemColor = $hDataSplit[8]
						$hItemBkColor = $hDataSplit[9]
					Case "Po"
						$hItemColor = $hDataSplit[$hDatasplit[0]-3]
						$hItemBkColor = $hDataSplit[$hDataSplit[0]-2]
					Case "R"
						$hItemColor = $hDataSplit[6]
						$hItemBkColor = $hDataSplit[7]
					Case "CC"
						$hItemColor = $hDataSplit[$hDataSplit[0]-3]
						$hItemBkColor = $hDataSplit[$hDataSplit[0]-2]
				EndSwitch
				$hColorRead = GUICtrlRead($hColorInput)
				If $hColorRead <> $hItemColor Then
					If StringLen($hColorRead) = 8  or StringLen($hColorRead) = 0 Then
						Dim $hasColor = False
						Switch $hDataSplit[1]
							Case "A"
								$hDataSplit[8] = $hColorRead
								$hasColor = True
							Case "B"
								$hDataSplit[10] = $hColorRead
								$hasColor = True
							Case "C"
								$hDataSplit[$hDataSplit[0]-2] = $hColorRead
								$hasColor = True
							Case "E"
								$hDataSplit[6] = $hColorRead
								$hasColor = True
							Case "L"
								$hDataSplit[6] = $hColorRead
								$hasColor = True
							Case "P"
								$hDataSplit[8] = $hColorRead
								$hasColor = True
							Case "Po"
								$hDataSplit[$hDatasplit[0]-3] = $hColorRead
								$hasColor = True
							Case "R"
								$hDataSplit[6] = $hColorRead
								$hasColor = True
							Case "CC"
								$hDataSplit[$hDataSplit[0]-3] = $hColorRead
								$hasColor = True
						EndSwitch
						If $hasColor = True Then
							If $hColorRead = "" Then
								GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
							Else
								GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($hColorRead, 2))
							EndIf
							$GDIPlusData[$SelectedItem] = _ArrayToString($hDataSplit, ":", 1, $hDataSplit[0])
							_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
							_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
							$SelectedItem = 0
						EndIf
					EndIf
				EndIf
				$hFill = GUICtrlRead($hFillInput)
				If $hFill <> $hItemBkColor Then
					If StringLen($hFill) = 8  or StringLen($hFill) = 0 Then
						Dim $hasBk = False
						Switch $hDataSplit[1]
							Case "E"
								$hDataSplit[7] = $hFill
								$hasBk = True
							Case "P"
								$hDataSplit[9] = $hFill
								$hasBk = True
							Case "Po"
								$hDataSplit[$hDataSplit[0]-2] = $hFill
								$hasBk = True
							Case "R"
								$hDataSplit[7] = $hFill
								$hasBk = True
							Case "CC"
								$hDataSplit[$hDataSplit[0]-2] = $hFill
								$hasBk = True
						EndSwitch
						If $hasBk = True Then
							If $hFill = "" Then
								GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
							Else
								GUICtrlSetBkColor($hBkColorPick, "0x"&StringTrimLeft($hFill, 2))
							EndIf
							$GDIPlusData[$SelectedItem] = _ArrayToString($hDataSplit, ":", 1, $hDataSplit[0])
							_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
							_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
							$SelectedItem = 0
						EndIf
					EndIf
				EndIf
			EndIf
			If _IsPressed("01") and $hPointIndex <> 0 Then
				$CurrentDiffX = 0
				$CurrentDiffY = 0
				$hDiffValueX = 0
				$hDiffValueY = 0
				$hDataSplit = StringSplit($GDIPlusData[$SelectedItem], ":")
				Dim $FirstX = $SelectedX[$hPointIndex]
				Dim $FirstY = $SelectedY[$hPointIndex]
				Dim $FirstW = $hDataSplit[4]
				Dim $FirstH = $hDataSplit[5]
				Dim $FirstSelX = $SelectedX[2]
				Dim $FirstSelY = $SelectedY[2]
				$hStartMouse = GUIGetCursorInfo($hGDIGUI)
				While _IsPressed("01") = True
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					Switch $hDataSplit[1]
						Case "A"
							If $hPointIndex = 1 Then
								$hDataSplit[2] = $FirstX+($hMousePos[0]-$hStartMouse[0])
								$hDataSplit[3] = $FirstY+($hMousePos[1]-$hStartMouse[1])
								$SelectedX[1] = $FirstX+($hMousePos[0]-$hStartMouse[0])
								$SelectedY[1] = $FirstY+($hMousePos[1]-$hStartMouse[1])
								$SelectedX[2] = $FirstSelX+($hMousePos[0]-$hStartMouse[0])
								$SelectedY[2] = $FirstSelY+($hMousePos[1]-$hStartMouse[1])
							ElseIf $hPointIndex = 2 Then
								$hDataSplit[4] = $FirstW+($hMousePos[0]-$hStartMouse[0])
								$hDataSplit[5] = $FirstH+($hMousePos[1]-$hStartMouse[1])
								$SelectedX[2] = $FirstX+($hMousePos[0]-$hStartMouse[0])
								$SelectedY[2] = $FirstY+($hMousePos[1]-$hStartMouse[1])
							EndIf
						Case "B"
							$hDataSplit[($hPointIndex*2)] = $FirstX+($hMousePos[0]-$hStartMouse[0])
							$hDataSplit[1+($hPointIndex*2)] = $FirstY+($hMousePos[1]-$hStartMouse[1])
							$SelectedX[$hPointIndex] = $FirstX+($hMousePos[0]-$hStartMouse[0])
							$SelectedY[$hPointIndex] = $FirstY+($hMousePos[1]-$hStartMouse[1])
						Case "C"
							$hDataSplit[($hPointIndex*2)] = $FirstX+($hMousePos[0]-$hStartMouse[0])
							$hDataSplit[1+($hPointIndex*2)] = $FirstY+($hMousePos[1]-$hStartMouse[1])
							$SelectedX[$hPointIndex] = $FirstX+($hMousePos[0]-$hStartMouse[0])
							$SelectedY[$hPointIndex] = $FirstY+($hMousePos[1]-$hStartMouse[1])
						Case "L"
							$hDataSplit[($hPointIndex*2)] = $FirstX+($hMousePos[0]-$hStartMouse[0])
							$hDataSplit[1+($hPointIndex*2)] = $FirstY+($hMousePos[1]-$hStartMouse[1])
							$SelectedX[$hPointIndex] = $FirstX+($hMousePos[0]-$hStartMouse[0])
							$SelectedY[$hPointIndex] = $FirstY+($hMousePos[1]-$hStartMouse[1])
						Case "Po"
							$hDataSplit[($hPointIndex*2)] = $FirstX+($hMousePos[0]-$hStartMouse[0])
							$hDataSplit[1+($hPointIndex*2)] = $FirstY+($hMousePos[1]-$hStartMouse[1])
							$SelectedX[$hPointIndex] = $FirstX+($hMousePos[0]-$hStartMouse[0])
							$SelectedY[$hPointIndex] = $FirstY+($hMousePos[1]-$hStartMouse[1])
						Case "CC"
							$hDataSplit[($hPointIndex*2)] = $FirstX+($hMousePos[0]-$hStartMouse[0])
							$hDataSplit[1+($hPointIndex*2)] = $FirstY+($hMousePos[1]-$hStartMouse[1])
							$SelectedX[$hPointIndex] = $FirstX+($hMousePos[0]-$hStartMouse[0])
							$SelectedY[$hPointIndex] = $FirstY+($hMousePos[1]-$hStartMouse[1])
						Case "R"
							If $hPointIndex = 1 Then
								$hDataSplit[2] = $FirstX+($hMousePos[0]-$hStartMouse[0])
								$hDataSplit[3] = $FirstY+($hMousePos[1]-$hStartMouse[1])
								$SelectedX[1] = $FirstX+($hMousePos[0]-$hStartMouse[0])
								$SelectedY[1] = $FirstY+($hMousePos[1]-$hStartMouse[1])
								$SelectedX[2] = $FirstSelX+($hMousePos[0]-$hStartMouse[0])
								$SelectedY[2] = $FirstSelY+($hMousePos[1]-$hStartMouse[1])
							ElseIf $hPointIndex = 2 Then
								$hDataSplit[4] = $FirstW+($hMousePos[0]-$hStartMouse[0])
								$hDataSplit[5] = $FirstH+($hMousePos[1]-$hStartMouse[1])
								$SelectedX[2] = $FirstX+($hMousePos[0]-$hStartMouse[0])
								$SelectedY[2] = $FirstY+($hMousePos[1]-$hStartMouse[1])
							EndIf
						Case "E"
							If $hPointIndex = 1 Then
								$hDataSplit[2] = $FirstX+($hMousePos[0]-$hStartMouse[0])
								$hDataSplit[3] = $FirstY+($hMousePos[1]-$hStartMouse[1])
								$SelectedX[1] = $FirstX+($hMousePos[0]-$hStartMouse[0])
								$SelectedY[1] = $FirstY+($hMousePos[1]-$hStartMouse[1])
								$SelectedX[2] = $FirstSelX+($hMousePos[0]-$hStartMouse[0])
								$SelectedY[2] = $FirstSelY+($hMousePos[1]-$hStartMouse[1])
							ElseIf $hPointIndex = 2 Then
								$hDataSplit[4] = $FirstW+($hMousePos[0]-$hStartMouse[0])
								$hDataSplit[5] = $FirstH+($hMousePos[1]-$hStartMouse[1])
								$SelectedX[2] = $FirstX+($hMousePos[0]-$hStartMouse[0])
								$SelectedY[2] = $FirstY+($hMousePos[1]-$hStartMouse[1])
							EndIf
						Case "I"
							If $hPointIndex = 1 Then
								$hDataSplit[3] = $FirstX+($hMousePos[0]-$hStartMouse[0])
								$hDataSplit[4] = $FirstY+($hMousePos[1]-$hStartMouse[1])
								$SelectedX[1] = $FirstX+($hMousePos[0]-$hStartMouse[0])
								$SelectedY[1] = $FirstY+($hMousePos[1]-$hStartMouse[1])
								$SelectedX[2] = $FirstSelX+($hMousePos[0]-$hStartMouse[0])
								$SelectedY[2] = $FirstSelY+($hMousePos[1]-$hStartMouse[1])
							ElseIf $hPointIndex = 2 Then
								$hDataSplit[5] = $FirstW+($hMousePos[0]-$hStartMouse[0])
								$hDataSplit[6] = $FirstH+($hMousePos[1]-$hStartMouse[1])
								$SelectedX[2] = $FirstX+($hMousePos[0]-$hStartMouse[0])
								$SelectedY[2] = $FirstY+($hMousePos[1]-$hStartMouse[1])
							EndIf
						Case "P"
							If $hPointIndex = 1 Then
								$hDataSplit[2] = $FirstX+($hMousePos[0]-$hStartMouse[0])
								$hDataSplit[3] = $FirstY+($hMousePos[1]-$hStartMouse[1])
								$SelectedX[1] = $FirstX+($hMousePos[0]-$hStartMouse[0])
								$SelectedY[1] = $FirstY+($hMousePos[1]-$hStartMouse[1])
								$SelectedX[2] = $FirstSelX+($hMousePos[0]-$hStartMouse[0])
								$SelectedY[2] = $FirstSelY+($hMousePos[1]-$hStartMouse[1])
							ElseIf $hPointIndex = 2 Then
								$hDataSplit[4] = $FirstW+($hMousePos[0]-$hStartMouse[0])
								$hDataSplit[5] = $FirstH+($hMousePos[1]-$hStartMouse[1])
								$SelectedX[2] = $FirstX+($hMousePos[0]-$hStartMouse[0])
								$SelectedY[2] = $FirstY+($hMousePos[1]-$hStartMouse[1])
							EndIf
						Case "S"
							$hDataSplit[2] = $FirstX+($hMousePos[0]-$hStartMouse[0])
							$hDataSplit[3] = $FirstY+($hMousePos[1]-$hStartMouse[1])
							$SelectedX[1] = $FirstX+($hMousePos[0]-$hStartMouse[0])
							$SelectedY[1] = $FirstY+($hMousePos[1]-$hStartMouse[1])
					EndSwitch
					$CurrentDiffX = $SelectedX[$hPointIndex]
					$CurrentDiffY = $SelectedY[$hPointIndex]
					Dim $hRedraw = False
					If $hDiffValueX <> $CurrentDiffX Then
						$hDiffValueX = $CurrentDiffX
						$hRedraw = True
					EndIf
					If $HDiffValueY <> $CurrentDiffY Then
						$hDiffValueY = $CurrentDiffY
						$hRedraw = True
					EndIF
					If $hRedraw = True Then
						$GDIPlusData[$SelectedItem] = _ArrayToString($hDataSplit, ":", 1, $hDataSplit[0])
						_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
						_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
						$hPenWidth = _GDIPlus_PenGetWidth($hGDIPen)
						$hPenRead = _GDIPlus_PenGetColor($hGDIPen)
						$hBrushRead = _GDIPlus_BrushGetSolidColor($hGDIBrush)
						_GDIPlus_PenSetColor($hGDIPen, "0xFF000000")
						_GDIPlus_PenSetWidth($hGDIPen, 1)
						_GDIPlus_BrushSetSolidColor($hGDIBrush, "0xFFFF0000")
						$hGDISplit = StringSplit($GDIPlusData[$SelectedItem], ":")
						Switch $hGDISplit[1]
							Case "A"
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIPen)
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIPen)
							Case "B"
								For $g = 2 to $hGDISplit[0]-3 Step 2
									_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIBrush)
									_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIPen)
								Next
							Case "C"
								For $g = 2 to $hGDISplit[0]-3 Step 2
									_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIBrush)
									_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIPen)
								Next
							Case "E"
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIPen)
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIPen)
							Case "I"
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[$hGDISplit[0]-5]-4, $hGDISplit[$hGDISplit[0]-4]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[$hGDISplit[0]-5]-4, $hGDISplit[$hGDISplit[0]-4]-4, 9, 9, $hGDIPen)
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[$hGDISplit[0]-5]+$hGDISplit[$hGDISplit[0]-3]-4, $hGDISplit[$hGDISplit[0]-4]+$hGDISplit[$hGDISplit[0]-2]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[$hGDISplit[0]-5]+$hGDISplit[$hGDISplit[0]-3]-4, $hGDISplit[$hGDISplit[0]-4]+$hGDISplit[$hGDISplit[0]-2]-4, 9, 9, $hGDIPen)
							Case "L"
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIPen)
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[4]-4, $hGDISplit[5]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[4]-4, $hGDISplit[5]-4, 9, 9, $hGDIPen)
							Case "P"
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIPen)
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIPen)
							Case "Po"
								For $g = 2 to $hGDISplit[0]-4 Step 2
									_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIBrush)
									_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIPen)
								Next
							Case "R"
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIPen)
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]+$hGDISplit[4]-4, $hGDISplit[3]+$hGDISplit[5]-4, 9, 9, $hGDIPen)
							Case "S"
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[2]-4, $hGDISplit[3]-4, 9, 9, $hGDIPen)
							Case "CC"
								For $g = 2 to $hGDISplit[0]-4 Step 2
									_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIBrush)
									_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hGDISplit[$g]-4, $hGDISplit[$g+1]-4, 9, 9, $hGDIPen)
								Next
						EndSwitch
						_GDIPlus_PenSetWidth($hGDIPen, $hPenWidth)
						_GDIPlus_PenSetColor($hGDIPen, $hPenRead)
						_GDIPlus_BrushSetSolidColor($hGDIBrush, $hBrushRead)
					EndIf
					Sleep(80)
				WEnd
			EndIf
		EndIf

		$hMsg = GUIGetMsg()
		Switch $hMsg
			Case $GUI_EVENT_CLOSE
				_GDIPlus_BrushDispose($hGDIBrush)
				_GDIPlus_PenDispose($hGDIPen)
				_GDIPlus_GraphicsDispose($hGDIPlus)
				_GUICtrlComboBoxEx_Destroy($hBrushType)
				_GUICtrlComboBoxEx_Destroy($hBrushSmooth)
				GUIDelete($hGDIGUI)
				For $i = 1 to $GUIElements[0] Step 1
					GUICtrlDelete($GUIElements[$i])
				Next
				If $GDITrees[0] > 0 Then
					$hParent = _GUICtrlTreeView_GetParentHandle($hTree, $GDITrees[1])
					_GUICtrlTreeView_BeginUpdate($hTree)
					_GUICtrlTreeView_DeleteChildren($hTree, $hParent)
					_GUICtrlTreeView_SetChildren($hTree, $hParent, False)
					_GUICtrlTreeView_EndUpdate($hTree)
					Dim $GDITrees[1] = [0]
				EndIf
				$GDIPlusRunning = False
				#cs
			Case $RotateButton
				If $SelectedItem <> 0 Then
					$hDataSplit = StringSplit($GDIPlusData[$SelectedItem], ":")
					If $hDataSplit[1] = "Po" or $hDataSplit[1] = "CC" or $hDataSplit[1] = "C" or $hDataSplit[1] = "B" Then
						Dim $LowX = 9999, $HighX = 0
						Dim $LowY = 9999, $HighY = 0
						ConsoleWrite($GDIPlusData[$SelectedItem]&@CRLF)
						For $i = 2 to $hDataSplit[0]-4 Step 2
							If Number($hDataSplit[$i]) < Number($LowX) Then
								$LowX = $hDataSplit[$i]
							EndIf
							If Number($hDataSplit[$i]) > Number($HighX) Then
								$HighX = $hDataSplit[$i]
							EndIf
						Next
						For $i = 3 to $hDataSplit[0]-4 Step 2
							If Number($hDataSplit[$i]) < Number($LowY) Then
								$LowY = $hDataSplit[$i]
							EndIf
							If Number($hDataSplit[$i]) > Number($HighY) Then
								$HighY = $hDataSplit[$i]
							EndIf
						Next
						$hPenWidth = _GDIPlus_PenGetWidth($hGDIPen)
						$hPenRead = _GDIPlus_PenGetColor($hGDIPen)
						$hBrushRead = _GDIPlus_BrushGetSolidColor($hGDIBrush)
						_GDIPlus_PenSetColor($hGDIPen, "0xFF000000")
						_GDIPlus_PenSetWidth($hGDIPen, 1)
						_GDIPlus_BrushSetSolidColor($hGDIBrush, "0xFF00CC00")
						_GDIPlus_GraphicsFillEllipse($hGDIPlus, $LowX+(($HighX-$LowX)/2)-4, $LowY+(($HighY-$LowY)/2)-4, 9, 9, $hGDIBrush)
						_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $LowX+(($HighX-$LowX)/2)-4, $LowY+(($HighY-$LowY)/2)-4, 9, 9, $hGDIPen)
						_GDIPlus_PenSetWidth($hGDIPen, $hPenWidth)
						_GDIPlus_PenSetColor($hGDIPen, $hPenRead)
						_GDIPlus_BrushSetSolidColor($hGDIBrush, $hBrushRead)
						Dim $XStart[1] = [0], $YStart[1] = [0]
						For $i = 2 to $hDataSplit[0]-4 Step 2
							_ArrayAdd($XStart, $hDataSplit[$i])
							_ArrayAdd($YStart, $hDataSplit[$i+1])
							$XStart[0] += 1
							$YStart[0] += 1
						Next
						Dim $hAngleVar
						Sleep(200)
						While _IsPressed("01") = False
							$hMouseNow = GUIGetCursorInfo($hGDIGUI)
							$hCenterX = $LowX+(($HighX-$LowX)/2)
							$hCenterY = $LowY+(($HighY-$LowY)/2)
							If (ATan($hCenterY-$hMouseNow[1])/($hCenterX-$hMouseNow[0]))*(180/$Pi) < 0 Then
								If $hMouseNow[1] > $hCenterY Then
									$hAngleVar = Round(Abs(180-(ATan(($hCenterY-$hMouseNow[1])/($hCenterX-$hMouseNow[0]))*(180/$Pi))))
								Else
									$hAngleVar = Round(Abs((ATan(($hCenterY-$hMouseNow[1])/($hCenterX-$hMouseNow[0]))*(180/$Pi))))
								EndIf
							Else
								If $hMouseNow[0] > $hCenterX Then
									$hAngleVar = Round(Abs(360-(ATan(($hCenterY-$hMouseNow[1])/($hCenterX-$hMouseNow[0]))*(180/$Pi))))
								Else
									$hAngleVar = Round(180-(ATan(($hCenterY-$hMouseNow[1])/($hCenterX-$hMouseNow[0]))*(180/$Pi)))
								EndIf
							EndIf
							$Theta = (360-$hAngleVar)*($Pi/180)
							For $i = 2 to $hDataSplit[0]-4 Step 2
								$hDataSplit[$i] = Round($hCenterX+(Cos($Theta)*($XStart[$i/2]-$hCenterX)-Sin($Theta)*($YStart[$i/2]-$hCenterY)))
								$hDataSplit[$i+1] = Round($hCenterY+(Sin($Theta)*($XStart[$i/2]-$hCenterX)-Cos($Theta)*($YStart[$i/2]-$hCenterY)))
							Next
							$GDIPlusData[$GDIPlusData[0]] = _ArrayToString($hDataSplit, ":", 1, $hDataSplit[0])
							_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
							_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
							$hPenWidth = _GDIPlus_PenGetWidth($hGDIPen)
							$hPenRead = _GDIPlus_PenGetColor($hGDIPen)
							$hBrushRead = _GDIPlus_BrushGetSolidColor($hGDIBrush)
							_GDIPlus_PenSetColor($hGDIPen, "0xFF000000")
							_GDIPlus_PenSetWidth($hGDIPen, 1)
							_GDIPlus_BrushSetSolidColor($hGDIBrush, "0xFF00CC00")
							_GDIPlus_GraphicsFillEllipse($hGDIPlus, $LowX+(($HighX-$LowX)/2)-4, $LowY+(($HighY-$LowY)/2)-4, 9, 9, $hGDIBrush)
							_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $LowX+(($HighX-$LowX)/2)-4, $LowY+(($HighY-$LowY)/2)-4, 9, 9, $hGDIPen)
							_GDIPlus_BrushSetSolidColor($hGDIBrush, "0xFFFF0000")
							For $g = 2 to $hDataSplit[0]-4 Step 2
								_GDIPlus_GraphicsFillEllipse($hGDIPlus, $hDataSplit[$g]-4, $hDataSplit[$g+1]-4, 9, 9, $hGDIBrush)
								_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $hDataSplit[$g]-4, $hDataSplit[$g+1]-4, 9, 9, $hGDIPen)
							Next
							_GDIPlus_PenSetWidth($hGDIPen, $hPenWidth)
							_GDIPlus_PenSetColor($hGDIPen, $hPenRead)
							_GDIPlus_BrushSetSolidColor($hGDIBrush, $hBrushRead)
							Sleep(80)
						WEnd

					EndIf
				EndIf
				#ce
			Case $SaveGDIButton
				Dim $SaveData = ''
				For $i = 1 to $GDIPlusData[0] Step 1
					If $i <> $GDIPlusData[0] Then
						$SaveData &= $GDIPlusData[$i]&";"
					Else
						$SaveData &= $GDIPlusData[$i]
					EndIf
				Next
				$Data[$hIndex] = $SaveData
				GUICtrlSetData($DataInput, $Data[$hIndex])
				_GDIPlus_BrushDispose($hGDIBrush)
				_GDIPlus_PenDispose($hGDIPen)
				_GDIPlus_GraphicsDispose($hGDIPlus)
				_GUICtrlComboBoxEx_Destroy($hBrushType)
				_GUICtrlComboBoxEx_Destroy($hBrushSmooth)
				$hGDIPlusQuality = $BrushSmooth
				GUIDelete($hGDIGUI)
				For $i = 1 to $GUIElements[0] Step 1
					GUICtrlDelete($GUIElements[$i])
				Next
				If $GDITrees[0] > 0 Then
					$hParent = _GUICtrlTreeView_GetParentHandle($hTree, $GDITrees[1])
					_GUICtrlTreeView_BeginUpdate($hTree)
					_GUICtrlTreeView_DeleteChildren($hTree, $hParent)
					_GUICtrlTreeView_SetChildren($hTree, $hParent, False)
					_GUICtrlTreeView_EndUpdate($hTree)
					Dim $GDITrees[1] = [0]
				EndIf
				$GDIPlusRunning = False
			Case $hBkColorPick
				If $SelectedItem <> 0 Then
					Dim $hItemBkColor
					$hDataSplit = StringSplit($GDIPlusData[$SelectedItem], ":")
					Switch $hDataSplit[1]
						Case "E"
							$hItemBkColor = $hDataSplit[7]
						Case "P"
							$hItemBkColor = $hDataSplit[9]
						Case "Po"
							$hItemBkColor = $hDataSplit[$hDataSplit[0]-2]
						Case "R"
							$hItemBkColor = $hDataSplit[7]
						Case "CC"
							$hItemBkColor = $hDataSplit[$hDataSplit[0]-2]
					EndSwitch
					Dim $TransVal = DEC(StringTrimRight($hItemBkColor,6))
					Dim $ChoosingColor = True
					Dim $hChooseColor = StringTrimLeft($hItemBkColor, 2)
					Dim $hSliderTransData = "0"
					$ChooseColorGUI = GUICreate( "Color Select", 195, 132, -1, -1, -1)
					$Label2 = GUICtrlCreateLabel( "Color:", 16, 12, 39, 17)
					$hBrushChooseInput = GUICtrlCreateInput( $hChooseColor, 61, 8, 83, 20)
					GUICtrlSetStyle( -1, $ES_CENTER)
					$hColorChooseBk = GUICtrlCreateLabel( "", 155, 8, 20, 20)
					GUICtrlSetState( -1, $GUI_DISABLE)
					GUICtrlSetBkColor( -1, 0x000000)
					$hColorChoose = GUICtrlCreateLabel( "", 156, 9, 18, 18)
					GUICtrlSetBkColor( -1, "0x"&$hChooseColor)
					GUICtrlCreateLabel( "Transparency:", 16, 39, 70, 15)
					$hSliderTrans = _GUICtrlSlider_Create($ChooseColorGUI, 11, 61, 176, 26)
					_GUICtrlSlider_SetRangeMax($hSliderTrans, 255)
					_GUICtrlSlider_SetRangeMin($hSliderTrans, 0)
					_GUICtrlSlider_SetTicFreq($hSliderTrans, 15)
					If $hChooseColor = "" Then
						$TransVal = 255
					EndIF
					_GUICtrlSlider_SetPos($hSliderTrans, $TransVal)
					$hSliderPercent = GUICtrlCreateLabel( Abs(255-$TransVal), 145, 39, 29, 15)
					GUICtrlSetStyle( -1, $SS_CENTER)
					$hChooseSave = GUICtrlCreateButton( "Save", 112, 102, 75, 25)
					$hChooseCancel = GUICtrlCreateButton( "Cancel", 11, 102, 75, 25)
					GUISetState()

					While $ChoosingColor = True
						$hMsg = GUIGetMsg()
						Switch $hMsg
							Case $GUI_EVENT_CLOSE
								GUIDelete($ChooseColorGUI)
								$ChoosingColor = False
							Case $hColorChoose
								$hColor = _ChooseColor(2, "0x"&GUICtrlRead($hBrushChooseInput), 2, $ChooseColorGUI)
								If $hColor <> -1 Then
									GUICtrlSetBkColor($hColorChoose, $hColor)
									GUICtrlSetData($hBrushChooseInput, Hex($hColor, 6))
								EndIf
							Case $hChooseSave
								$hSliderVal = _GUICtrlSlider_GetPos($hSliderTrans)
								$hSaveColor = String(Hex($hSliderVal,2)&GUICtrlRead($hBrushChooseInput))
								GUICtrlSetBkColor($hBkColorPick, "0x"&GUICtrlRead($hBrushChooseInput))
								Switch $hDataSplit[1]
									Case "E"
										$hDataSplit[7] = $hSaveColor
									Case "P"
										$hDataSplit[9] = $hSaveColor
									Case "Po"
										$hDataSplit[$hDataSplit[0]-2] = $hSaveColor
									Case "R"
										$hDataSplit[7] = $hSaveColor
									Case "CC"
										$hDataSplit[$hDataSplit[0]-2] = $hSaveColor
								EndSwitch
								GUICtrlSetData($hFillInput, $hSaveColor)
								$GDIPlusData[$SelectedItem] = _ArrayToString($hDataSplit, ":", 1, $hDataSplit[0])
								_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
								_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
								GUIDelete($ChooseColorGUI)
								$ChoosingColor = False
								$SelectedItem = 0
						EndSwitch
						If _GUICtrlSlider_GetPos($hSliderTrans) <> $hSliderTransData Then
							$hSliderTransData = _GUICtrlSlider_GetPos($hSliderTrans)
							GUICtrlSetData($hSliderPercent,Abs(255-_GUICtrlSlider_GetPos($hSliderTrans))&"%")
						EndIf
						If GUICtrlRead($hBrushChooseInput) <> $hChooseColor Then
							$hChooseColor = GUICtrlRead($hBrushChooseInput)
							GUICtrlSetBkColor($hColorChoose, "0x"&$hChooseColor)
						EndIf
					WEnd
				EndIf
			Case $hColorPick
				If $SelectedItem <> 0 Then
					Dim $hItemColor, $hItemBkColor
					$hDataSplit = StringSplit($GDIPlusData[$SelectedItem], ":")
					Switch $hDataSplit[1]
						Case "A"
							$hItemColor = $hDataSplit[8]
						Case "B"
							$hItemColor = $hDataSplit[10]
						Case "C"
							$hItemColor = $hDataSplit[$hDataSplit[0]-2]
						Case "E"
							$hItemColor = $hDataSplit[6]
						Case "L"
							$hItemColor = $hDataSplit[6]
						Case "P"
							$hItemColor = $hDataSplit[8]
						Case "Po"
							$hItemColor = $hDataSplit[$hDatasplit[0]-3]
						Case "R"
							$hItemColor = $hDataSplit[6]
						Case "CC"
							$hItemColor = $hDataSplit[$hDataSplit[0]-3]
					EndSwitch
					Dim $TransVal = DEC(StringTrimRight($hItemColor,6))
					Dim $ChoosingColor = True
					Dim $hChooseColor = StringTrimLeft($hItemColor, 2)
					Dim $hSliderTransData = "0"
					$ChooseColorGUI = GUICreate( "Color Select", 195, 132, -1, -1, -1)
					$Label2 = GUICtrlCreateLabel( "Color:", 16, 12, 39, 17)
					$hBrushChooseInput = GUICtrlCreateInput( $hChooseColor, 61, 8, 83, 20)
					GUICtrlSetStyle( -1, $ES_CENTER)
					$hColorChooseBk = GUICtrlCreateLabel( "", 155, 8, 20, 20)
					GUICtrlSetState( -1, $GUI_DISABLE)
					GUICtrlSetBkColor( -1, 0x000000)
					$hColorChoose = GUICtrlCreateLabel( "", 156, 9, 18, 18)
					GUICtrlSetBkColor( -1, "0x"&$hChooseColor)
					GUICtrlCreateLabel( "Transparency:", 16, 39, 70, 15)
					$hSliderTrans = _GUICtrlSlider_Create($ChooseColorGUI, 11, 61, 176, 26)
					_GUICtrlSlider_SetRangeMax($hSliderTrans, 255)
					_GUICtrlSlider_SetRangeMin($hSliderTrans, 0)
					_GUICtrlSlider_SetTicFreq($hSliderTrans, 15)
					If $hChooseColor = "" Then
						$TransVal = 255
					EndIF
					_GUICtrlSlider_SetPos($hSliderTrans, $TransVal)
					$hSliderPercent = GUICtrlCreateLabel( Abs(255-$TransVal), 145, 39, 29, 15)
					GUICtrlSetStyle( -1, $SS_CENTER)
					$hChooseSave = GUICtrlCreateButton( "Save", 112, 102, 75, 25)
					$hChooseCancel = GUICtrlCreateButton( "Cancel", 11, 102, 75, 25)
					GUISetState()

					While $ChoosingColor = True
						$hMsg = GUIGetMsg()
						Switch $hMsg
							Case $GUI_EVENT_CLOSE
								GUIDelete($ChooseColorGUI)
								$ChoosingColor = False
							Case $hColorChoose
								Dim $hEmpty = False
								$hColor = _ChooseColor(2, "0x"&GUICtrlRead($hBrushChooseInput), 2, $ChooseColorGUI)
								If $hColor <> -1 Then
									GUICtrlSetBkColor($hColorChoose, $hColor)
									GUICtrlSetData($hBrushChooseInput, Hex($hColor, 6))
								EndIf
							Case $hChooseSave
								$hSliderVal = _GUICtrlSlider_GetPos($hSliderTrans)
								$hSaveColor = String(Hex($hSliderVal,2)&GUICtrlRead($hBrushChooseInput))
								GUICtrlSetBkColor($hColorPick, "0x"&GUICtrlRead($hBrushChooseInput))
								Switch $hDataSplit[1]
									Case "A"
										$hDataSplit[8] = $hSaveColor
									Case "B"
										$hDataSplit[10] = $hSaveColor
									Case "C"
										$hDataSplit[$hDataSplit[0]-2] = $hSaveColor
									Case "E"
										$hDataSplit[6] = $hSaveColor
									Case "L"
										$hDataSplit[6] = $hSaveColor
									Case "P"
										$hDataSplit[8] = $hSaveColor
									Case "Po"
										$hDataSplit[$hDatasplit[0]-3] = $hSaveColor
									Case "R"
										$hDataSplit[6] = $hSaveColor
									Case "CC"
										$hDataSplit[$hDataSplit[0]-3] = $hSaveColor
								EndSwitch
								GUICtrlSetData($hColorInput, $hSaveColor)
								$GDIPlusData[$SelectedItem] = _ArrayToString($hDataSplit, ":", 1, $hDataSplit[0])
								_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
								_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
								GUIDelete($ChooseColorGUI)
								$ChoosingColor = False
								$SelectedItem = 0
						EndSwitch
						If _GUICtrlSlider_GetPos($hSliderTrans) <> $hSliderTransData Then
							$hSliderTransData = _GUICtrlSlider_GetPos($hSliderTrans)
							GUICtrlSetData($hSliderPercent,Abs(255-_GUICtrlSlider_GetPos($hSliderTrans))&"%")
						EndIf
						If GUICtrlRead($hBrushChooseInput) <> $hChooseColor Then
							$hChooseColor = GUICtrlRead($hBrushChooseInput)
							GUICtrlSetBkColor($hColorChoose, "0x"&$hChooseColor)
						EndIf
					WEnd
				EndIf
			Case $hBrushColor
				Dim $TransVal = DEC(StringTrimRight($BrushColor,6))
				Dim $ChoosingColor = True
				Dim $hChooseColor = StringTrimLeft($BrushColor, 2)
				Dim $hSliderTransData = "0"
				$ChooseColorGUI = GUICreate( "Color Select", 195, 132, -1, -1, -1)
				$Label2 = GUICtrlCreateLabel( "Color:", 16, 12, 39, 17)
				$hBrushChooseInput = GUICtrlCreateInput( $hChooseColor, 61, 8, 83, 20)
				GUICtrlSetStyle( -1, $ES_CENTER)
				$hColorChooseBk = GUICtrlCreateLabel( "", 155, 8, 20, 20)
				GUICtrlSetState( -1, $GUI_DISABLE)
				GUICtrlSetBkColor( -1, 0x000000)
				$hColorChoose = GUICtrlCreateLabel( "", 156, 9, 18, 18)
				GUICtrlSetBkColor( -1, "0x"&$hChooseColor)
				GUICtrlCreateLabel( "Transparency:", 16, 39, 70, 15)
				$hSliderTrans = _GUICtrlSlider_Create($ChooseColorGUI, 11, 61, 176, 26)
				_GUICtrlSlider_SetRangeMax($hSliderTrans, 255)
				_GUICtrlSlider_SetRangeMin($hSliderTrans, 0)
				_GUICtrlSlider_SetTicFreq($hSliderTrans, 15)
				If $hChooseColor = "" Then
					$TransVal = 255
				EndIF
				_GUICtrlSlider_SetPos($hSliderTrans, $TransVal)
				$hSliderPercent = GUICtrlCreateLabel( Abs(255-$TransVal), 145, 39, 29, 15)
				GUICtrlSetStyle( -1, $SS_CENTER)
				$hChooseSave = GUICtrlCreateButton( "Save", 112, 102, 75, 25)
				$hChooseCancel = GUICtrlCreateButton( "Cancel", 11, 102, 75, 25)
				GUISetState()

				While $ChoosingColor = True
					$hMsg = GUIGetMsg()
					Switch $hMsg
						Case $GUI_EVENT_CLOSE
							GUIDelete($ChooseColorGUI)
							$ChoosingColor = False
						Case $hColorChoose
							$hColor = _ChooseColor(2, "0x"&StringTrimLeft($BrushColor,2), 2, $ChooseColorGUI)
							If $hColor <> -1 Then
								GUICtrlSetBkColor($hColorChoose, $hColor)
								GUICtrlSetData($hBrushChooseInput, Hex($hColor, 6))
							EndIf
						Case $hChooseSave
							$hSliderVal = _GUICtrlSlider_GetPos($hSliderTrans)
							$BrushColor = String(Hex($hSliderVal,2)&GUICtrlRead($hBrushChooseInput))
							_GDIPlus_PenSetColor($hGDIPen, "0x"&$BrushColor)
							GUICtrlSetBkColor($hBrushColor, "0x"&StringTrimLeft($BrushColor, 2))
							GUIDelete($ChooseColorGUI)
							$ChoosingColor = False
					EndSwitch
					If _GUICtrlSlider_GetPos($hSliderTrans) <> $hSliderTransData Then
						$hSliderTransData = _GUICtrlSlider_GetPos($hSliderTrans)
						GUICtrlSetData($hSliderPercent,Abs(255-_GUICtrlSlider_GetPos($hSliderTrans))&"%")
					EndIf
					If GUICtrlRead($hBrushChooseInput) <> $hChooseColor Then
						$hChooseColor = GUICtrlRead($hBrushChooseInput)
						GUICtrlSetBkColor($hColorChoose, "0x"&$hChooseColor)
					EndIf
				WEnd
			Case $hBrushBkColor
				Dim $TransVal = DEC(StringTrimRight($BrushBkColor,6))
				Dim $ChoosingColor = True
				Dim $hChooseColor = StringTrimLeft($BrushBkColor, 2)
				Dim $hSliderTransData = "0"
				$ChooseColorGUI = GUICreate( "Color Select", 195, 132, -1, -1, -1)
				$Label2 = GUICtrlCreateLabel( "Color:", 16, 12, 39, 17)
				$hBrushChooseInput = GUICtrlCreateInput( $hChooseColor, 61, 8, 83, 20)
				GUICtrlSetStyle( -1, $ES_CENTER)
				$hColorChooseBk = GUICtrlCreateLabel( "", 155, 8, 20, 20)
				GUICtrlSetState( -1, $GUI_DISABLE)
				GUICtrlSetBkColor( -1, 0x000000)
				$hColorChoose = GUICtrlCreateLabel( "", 156, 9, 18, 18)
				GUICtrlSetBkColor( -1, "0x"&$hChooseColor)
				GUICtrlCreateLabel( "Transparency:", 16, 39, 70, 15)
				$hSliderTrans = _GUICtrlSlider_Create($ChooseColorGUI, 11, 61, 176, 26)
				_GUICtrlSlider_SetRangeMax($hSliderTrans, 255)
				_GUICtrlSlider_SetRangeMin($hSliderTrans, 0)
				_GUICtrlSlider_SetTicFreq($hSliderTrans, 15)
				If $hChooseColor = "" Then
					$TransVal = 255
				EndIF
				_GUICtrlSlider_SetPos($hSliderTrans, $TransVal)
				$hSliderPercent = GUICtrlCreateLabel( Abs(255-$TransVal), 145, 39, 29, 15)
				GUICtrlSetStyle( -1, $SS_CENTER)
				$hChooseSave = GUICtrlCreateButton( "Save", 112, 102, 75, 25)
				$hChooseCancel = GUICtrlCreateButton( "Cancel", 11, 102, 75, 25)
				GUISetState()

				While $ChoosingColor = True
					$hMsg = GUIGetMsg()
					Switch $hMsg
						Case $GUI_EVENT_CLOSE
							GUIDelete($ChooseColorGUI)
							$ChoosingColor = False
						Case $hColorChoose
							$hColor = _ChooseColor(2, "0x"&StringTrimLeft($BrushBkColor, 2), 2, $ChooseColorGUI)
							If $hColor <> -1 Then
								GUICtrlSetBkColor($hColorChoose, $hColor)
								GUICtrlSetData($hBrushChooseInput, Hex($hColor, 6))
							EndIf
						Case $hChooseSave
							$hSliderVal = _GUICtrlSlider_GetPos($hSliderTrans)
							If GUICtrlRead($hBrushChooseInput) = "" Then
								$BrushBkColor = ""
								GUICtrlSetBkColor($hBrushBkColor, "0xFFFFFF")
							Else
								$BrushBkColor = String(Hex($hSliderVal,2)&GUICtrlRead($hBrushChooseInput))
								_GDIPlus_BrushSetSolidColor($hGDIBrush, "0x"&$BrushBkColor)
								GUICtrlSetBkColor($hBrushBkColor, "0x"&StringTrimLeft($BrushBkColor, 2))
							EndIf
							GUIDelete($ChooseColorGUI)
							$ChoosingColor = False
					EndSwitch
					If _GUICtrlSlider_GetPos($hSliderTrans) <> $hSliderTransData Then
						$hSliderTransData = _GUICtrlSlider_GetPos($hSliderTrans)
						GUICtrlSetData($hSliderPercent,Abs(255-_GUICtrlSlider_GetPos($hSliderTrans))&"%")
					EndIf
					If GUICtrlRead($hBrushChooseInput) <> $hChooseColor Then
						$hChooseColor = GUICtrlRead($hBrushChooseInput)
						If $hChooseColor = "" Then
							GUICtrlSetBkColor($hColorChoose, 0xFFFFFF)
						Else
							GUICtrlSetBkColor($hColorChoose, "0x"&$hChooseColor)
						EndIf
					EndIf
				WEnd
			Case $hBtn1
				GUICtrlSetState($hP1Label, $GUI_SHOW)
				GUICtrlSetState($hP1Display, $GUI_SHOW)
				GUICtrlSetState($hP2Label, $GUI_SHOW)
				GUICtrlSetState($hP2Display, $GUI_SHOW)
				GUICtrlSetState($hP3Label, $GUI_SHOW)
				GUICtrlSetState($hP4Label, $GUI_SHOW)
				GUICtrlSetState($hP3Display, $GUI_SHOW)
				GUICtrlSetState($hP4Display, $GUI_SHOW)
				GUICtrlSetState($hP5Label, $GUI_SHOW)
				GUICtrlSetState($hP6Label, $GUI_SHOW)
				GUICtrlSetState($hP5Display, $GUI_SHOW)
				GUICtrlSetState($hP6Display, $GUI_SHOW)
				GUICtrlSetState($hP7Label, $GUI_HIDE)
				GUICtrlSetState($hP8Label, $GUI_HIDE)
				GUICtrlSetState($hP7Display, $GUI_HIDE)
				GUICtrlSetState($hP8Display, $GUI_HIDE)
				GUICtrlSetData($hP1Label, "X:")
				GUICtrlSetData($hP2Label, "Y:")
				GUICtrlSetData($hP3Label, "W:")
				GUICtrlSetData($hP4Label, "H:")
				GUICtrlSetData($hP5Label, "Sweep Angle:")
				GUICtrlSetData($hP6Label, "Rotation Angle:")
				GUICtrlSetPos($hP5Label, 194, 25, 60, 11)
				GUICtrlSetPos($hP6Label, 194, 37, 65, 11)
				GUICtrlSetPos($hP5Display, 264, 26, 20, 10)
				GUICtrlSetPos($hP6Display, 264, 38, 20, 10)
				GUICtrlSetData($hP5Display, "-")
				GUICtrlSetData($hP6Display, "-")
				GUICtrlSetData($hFillInput, "")
				GUICtrlSetState($hFillInput, $GUI_DISABLE)
				GUICtrlSetData($hColorInput, $BrushColor)
				GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($BrushColor, 2))
				GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
				_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
				_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
				Dim $bX,$bY,$bW,$bH
				GUICtrlSetData($hAsking, "Start Position?")
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP1Display, $hMousePos[0])
					GUICtrlSetData($hP2Display, $hMousePos[1])
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				_DrawGDIPoint( $hClickPos[0], $hClickPos[1])
				GUICtrlSetData($hP1Display, $hClickPos[0])
				GUICtrlSetData($hP2Display, $hClickPos[1])
				$bX = $hClickPos[0]
				$bY = $hClickPos[1]
				GUICtrlSetData($hAsking, "Width?  Height?")
				Sleep(200)
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP3Display, $hMousePos[0]-$bX)
					GUICtrlSetData($hP4Display, $hMousePos[1]-$bY)
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				_DrawGDIPoint( $hClickPos[0], $hClickPos[1])
				GUICtrlSetData($hP3Display, $hClickPos[0]-$bX)
				GUICtrlSetData($hP4Display, $hClickPos[1]-$bY)
				$bW = $hMousePos[0]-$bX
				$bH = $hMousePos[1]-$bY
				_GDIPlus_GraphicsDrawArc($hGDIPlus, $bX, $bY, $bW, $bH, 0, 30, $hGDIPen)
				GUICtrlSetData($hAsking, "Sweep Angle?")
				_GUICtrlTreeView_BeginUpdate($hTree)
				$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "Arc")
				_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 107)
				_GUICtrlTreeView_EndUpdate($hTree)
				_ArrayAdd($GDITrees, $hItem)
				_ArrayAdd($GDIPlusData, "A:"&$bX&":"&$bY&":"&$bW&":"&$bH&":"&0&":"&30&":"&$BrushColor&":"&$BrushSize&":")
				$GDITrees[0] += 1
				$GDIPlusData[0] += 1
				$hRadius = $bH/2
				Dim $hAngleVar
				Sleep(200)
				While _IsPressed("01") = False
					$hMouseNow = GUIGetCursorInfo($hGDIGUI)
					If (ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi) < 0 Then
						If $hMouseNow[1] > $bY+($bH/2) Then
							$hAngleVar = Round(Abs(180-(ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi)))
						Else
							$hAngleVar = Round(Abs((ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi)))
						EndIf
					Else
						If $hMouseNow[0] > $bX+($bW/2) Then
							$hAngleVar = Round(Abs(360-(ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi)))
						Else
							$hAngleVar = Round(180-(ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi))
						EndIf
					EndIf
					GUICtrlSetData($hP5Display, Abs(360-$hAngleVar)&"°")
					$GDIPlusData[$GDIPlusData[0]] = "A:"&$bX&":"&$bY&":"&$bW&":"&$bH&":"&0&":"&Abs(360-$hAngleVar)&":"&$BrushColor&":"&$BrushSize&":"
					_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
					_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)

					$hPenWidth = _GDIPlus_PenGetWidth($hGDIPen)
					$hPenRead = _GDIPlus_PenGetColor($hGDIPen)
					$hBrushRead = _GDIPlus_BrushGetSolidColor($hGDIBrush)
					_GDIPlus_PenSetColor($hGDIPen, "0xFF000000")
					_GDIPlus_PenSetWidth($hGDIPen, 1)
					_GDIPlus_BrushSetSolidColor($hGDIBrush, "0xFF00CC00")
					_GDIPlus_GraphicsFillEllipse($hGDIPlus, $bX+($bW/2)-4, $bY+($bH/2)-4, 9, 9, $hGDIBrush)
					_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $bX+($bW/2)-4, $bY+($bH/2)-4, 9, 9, $hGDIPen)
					_GDIPlus_PenSetWidth($hGDIPen, $hPenWidth)
					_GDIPlus_PenSetColor($hGDIPen, $hPenRead)
					_GDIPlus_BrushSetSolidColor($hGDIBrush, $hBrushRead)
					Sleep(80)
				WEnd
				GUICtrlSetData($hAsking, "Rotational Angle?")
				Sleep(200)
				Dim $hAngleVar2
				While _IsPressed("01") = False
					$hMouseNow = GUIGetCursorInfo($hGDIGUI)
					If (ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi) < 0 Then
						If $hMouseNow[1] > $bY+($bH/2) Then
							$hAngleVar2 = Round(Abs(180-(ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi)))
						Else
							$hAngleVar2 = Round(Abs((ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi)))
						EndIf
					Else
						If $hMouseNow[0] > $bX+($bW/2) Then
							$hAngleVar2 = Round(Abs(360-(ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi)))
						Else
							$hAngleVar2 = Round(180-(ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi))
						EndIf
					EndIf
					$GDIPlusData[$GDIPlusData[0]] = "A:"&$bX&":"&$bY&":"&$bW&":"&$bH&":"&Abs(360-$hAngleVar2)&":"&Abs(360-$hAngleVar)&":"&$BrushColor&":"&$BrushSize&":"
					_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
					_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
					$hPenWidth = _GDIPlus_PenGetWidth($hGDIPen)
					$hPenRead = _GDIPlus_PenGetColor($hGDIPen)
					$hBrushRead = _GDIPlus_BrushGetSolidColor($hGDIBrush)
					_GDIPlus_PenSetColor($hGDIPen, "0xFF000000")
					_GDIPlus_PenSetWidth($hGDIPen, 1)
					_GDIPlus_BrushSetSolidColor($hGDIBrush, "0xFF00CC00")
					_GDIPlus_GraphicsFillEllipse($hGDIPlus, $bX+($bW/2)-4, $bY+($bH/2)-4, 9, 9, $hGDIBrush)
					_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $bX+($bW/2)-4, $bY+($bH/2)-4, 9, 9, $hGDIPen)
					_GDIPlus_PenSetWidth($hGDIPen, $hPenWidth)
					_GDIPlus_PenSetColor($hGDIPen, $hPenRead)
					_GDIPlus_BrushSetSolidColor($hGDIBrush, $hBrushRead)
					GUICtrlSetData($hP6Display, Abs(360-$hAngleVar2)&"°")
					Sleep(80)
				WEnd
				GUICtrlSetData($hAsking, "")
				_GUICtrlTreeView_Expand($hTree, $TreeItems[$hIndex], True)
				_GUICtrlTreeView_SelectItem($hTree, $hItem)
				Sleep(100)
			Case $hBtn2
				GUICtrlSetState($hP1Label, $GUI_SHOW)
				GUICtrlSetState($hP1Display, $GUI_SHOW)
				GUICtrlSetState($hP2Label, $GUI_SHOW)
				GUICtrlSetState($hP2Display, $GUI_SHOW)
				GUICtrlSetState($hP3Label, $GUI_SHOW)
				GUICtrlSetState($hP4Label, $GUI_SHOW)
				GUICtrlSetState($hP3Display, $GUI_SHOW)
				GUICtrlSetState($hP4Display, $GUI_SHOW)
				GUICtrlSetState($hP5Label, $GUI_SHOW)
				GUICtrlSetState($hP6Label, $GUI_SHOW)
				GUICtrlSetState($hP5Display, $GUI_SHOW)
				GUICtrlSetState($hP6Display, $GUI_SHOW)
				GUICtrlSetState($hP7Label, $GUI_SHOW)
				GUICtrlSetState($hP8Label, $GUI_SHOW)
				GUICtrlSetState($hP7Display, $GUI_SHOW)
				GUICtrlSetState($hP8Display, $GUI_SHOW)
				GUICtrlSetData($hP1Label, "X¹:")
				GUICtrlSetData($hP2Label, "Y¹:")
				GUICtrlSetData($hP3Label, "X²:")
				GUICtrlSetData($hP4Label, "Y²:")
				GUICtrlSetData($hP5Label, "X³:")
				GUICtrlSetData($hP6Label, "Y³:")
				GUICtrlSetData($hP7Label, "X³:")
				GUICtrlSetData($hP8Label, "Y³:")
				GUICtrlSetPos($hP5Label, 194, 25, 20, 11)
				GUICtrlSetPos($hP6Label, 192, 37, 20, 11)
				GUICtrlSetPos($hP5Display, 214, 26, 20, 10)
				GUICtrlSetPos($hP6Display, 214, 38, 20, 10)
				GUICtrlSetPos($hP7Label, 244, 25, 20, 11)
				GUICtrlSetPos($hP8Label, 242, 37, 20, 11)
				GUICtrlSetPos($hP7Display, 264, 26, 20, 10)
				GUICtrlSetPos($hP8Display, 264, 38, 20, 10)
				GUICtrlSetData($hFillInput, "")
				GUICtrlSetState($hFillInput, $GUI_DISABLE)
				GUICtrlSetdata($hColorInput, $BrushColor)
				GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($BrushColor, 2))
				GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
				_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
				_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
				Dim $bX1,$bY1,$bX2,$bY2,$bX3,$bY3
				GUICtrlSetData($hAsking, "First Point?")
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP1Display, $hMousePos[0])
					GUICtrlSetData($hP2Display, $hMousePos[1])
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				_DrawGDIPoint( $hClickPos[0], $hClickPos[1])
				GUICtrlSetData($hP1Display, $hClickPos[0])
				GUICtrlSetData($hP2Display, $hClickPos[1])
				$bX1 = $hClickPos[0]
				$bY1 = $hClickPos[1]
				GUICtrlSetData($hAsking, "Second Point?")
				Sleep(100)
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP3Display, $hMousePos[0])
					GUICtrlSetData($hP4Display, $hMousePos[1])
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				_DrawGDIPoint( $hClickPos[0], $hClickPos[1])
				GUICtrlSetData($hP3Display, $hClickPos[0])
				GUICtrlSetData($hP4Display, $hClickPos[1])
				$bX2 = $hClickPos[0]
				$bY2 = $hClickPos[1]
				GUICtrlSetData($hAsking, "Third Point?")
				Sleep(200)
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP5Display, $hMousePos[0])
					GUICtrlSetData($hP6Display, $hMousePos[1])
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				_DrawGDIPoint( $hClickPos[0], $hClickPos[1])
				GUICtrlSetData($hP5Display, $hClickPos[0])
				GUICtrlSetData($hP6Display, $hClickPos[1])
				$bX3 = $hClickPos[0]
				$bY3 = $hClickPos[1]
				GUICtrlSetData($hAsking, "Last Point?")
				Sleep(200)
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP7Display, $hMousePos[0])
					GUICtrlSetData($hP8Display, $hMousePos[1])
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				GUICtrlSetData($hP7Display, $hClickPos[0])
				GUICtrlSetData($hP8Display, $hClickPos[1])
				_GDIPlus_GraphicsDrawBezier($hGDIPlus, $bX1, $bY1, $bX2, $bY2, $bX3, $bY3, $hClickPos[0], $hClickPos[1], $hGDIPen)
				_ArrayAdd($GDIPlusData, "B:"&$bX1&":"&$bY1&":"&$bX2&":"&$bY2&":"&$bX3&":"&$bY3&":"&$hClickPos[0]&":"&$hClickPos[1]&":"&$BrushColor&":"&$BrushSize&":")
				$GDIPlusData[0] += 1
				GUICtrlSetData($hAsking, "")
				_DrawGDIPoint( $hClickPos[0], $hClickPos[1])
				_GUICtrlTreeView_BeginUpdate($hTree)
				$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "Bezier")
				_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 98)
				_GUICtrlTreeView_EndUpdate($hTree)
				_ArrayAdd($GDITrees, $hItem)
				$GDITrees[0] += 1
				_GUICtrlTreeView_Expand($hTree, $TreeItems[$hIndex], True)
				_GUICtrlTreeView_SelectItem($hTree, $hItem)
				Sleep(100)
			Case $hBtn3
				GUICtrlSetState($hP1Label, $GUI_HIDE)
				GUICtrlSetState($hP1Display, $GUI_HIDE)
				GUICtrlSetState($hP2Label, $GUI_HIDE)
				GUICtrlSetState($hP2Display, $GUI_HIDE)
				GUICtrlSetState($hP3Label, $GUI_HIDE)
				GUICtrlSetState($hP4Label, $GUI_HIDE)
				GUICtrlSetState($hP3Display, $GUI_HIDE)
				GUICtrlSetState($hP4Display, $GUI_HIDE)
				GUICtrlSetState($hP5Label, $GUI_HIDE)
				GUICtrlSetState($hP6Label, $GUI_HIDE)
				GUICtrlSetState($hP5Display, $GUI_HIDE)
				GUICtrlSetState($hP6Display, $GUI_HIDE)
				GUICtrlSetState($hP7Label, $GUI_HIDE)
				GUICtrlSetState($hP8Label, $GUI_HIDE)
				GUICtrlSetState($hP7Display, $GUI_HIDE)
				GUICtrlSetState($hP8Display, $GUI_HIDE)
				GUICtrlSetData($hFillInput, "")
				GUICtrlSetState($hFillInput, $GUI_DISABLE)
				GUICtrlSetdata($hColorInput, $BrushColor)
				GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($BrushColor, 2))
				GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
				_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
				_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
				Dim $hDrawArray[21][2]
				Dim $hDrawCount = 0
				Dim $Drawing = True
				$hDrawArray[0][0] = 20
				$hDrawArray[1][0] = 0
				$hDrawArray[1][1] = 0
				$hDrawArray[2][0] = 0
				$hDrawArray[2][1] = 0
				$hDrawArray[3][0] = 0
				$hDrawArray[3][1] = 0
				$hDrawArray[4][0] = 0
				$hDrawArray[4][1] = 0
				$hDrawArray[5][0] = 0
				$hDrawArray[5][1] = 0
				$hDrawArray[6][0] = 0
				$hDrawArray[6][1] = 0
				$hDrawArray[7][0] = 0
				$hDrawArray[7][1] = 0
				$hDrawArray[8][0] = 0
				$hDrawArray[8][1] = 0
				$hDrawArray[9][0] = 0
				$hDrawArray[9][1] = 0
				$hDrawArray[10][0] = 0
				$hDrawArray[10][1] = 0
				$hDrawArray[11][0] = 0
				$hDrawArray[11][1] = 0
				$hDrawArray[12][0] = 0
				$hDrawArray[12][1] = 0
				$hDrawArray[13][0] = 0
				$hDrawArray[13][1] = 0
				$hDrawArray[14][0] = 0
				$hDrawArray[14][1] = 0
				$hDrawArray[15][0] = 0
				$hDrawArray[15][1] = 0
				$hDrawArray[16][0] = 0
				$hDrawArray[16][1] = 0
				$hDrawArray[17][0] = 0
				$hDrawArray[17][1] = 0
				$hDrawArray[18][0] = 0
				$hDrawArray[18][1] = 0
				$hDrawArray[19][0] = 0
				$hDrawArray[19][1] = 0
				$hDrawArray[20][0] = 0
				$hDrawArray[20][1] = 0
				GUICtrlSetData($hAsking, "Add Point?  Press Enter to Submit")
				dim $hLastX, $hLastY
				While $Drawing = True
					If _IsPressed("01") Then
						If $hDrawCount < 20 Then
							$hMousePos = GUIGetCursorInfo($hGDIGUI)
							_DrawGDIPoint( $hMousePos[0], $hMousePos[1])
							$hDrawCount += 1
							$hDrawArray[$hDrawCount][0] = $hMousePos[0]
							$hDrawArray[$hDrawCount][1] = $hMousePos[1]
							$hLastX = $hMousePos[0]
							$hLastY = $hMousePos[1]
							Sleep(200)
						Else
							Msgbox(0, "Max Points", "Maximum number of points reached.")
						EndIf
					EndIf
					If _IsPressed("0D") = True Then
						$Drawing = False
						For $i = 20 to $hDrawCount Step -1
							$hDrawArray[$i][0] = $hLastX
							$hDrawArray[$i][1] = $hLastY
						Next
						_GDIPlus_GraphicsDrawCurve($hGDIPlus, $hDrawArray, $hGDIPen)
						Dim $hGDIData = ''
						For $i = 1 to $hDrawCount Step 1
							$hGDIData &= ":"&$hDrawArray[$i][0]&":"&$hDrawArray[$i][1]
						Next
						_ArrayAdd($GDIPlusData, "C"&$hGDIData&":"&$BrushColor&":"&$BrushSize&":")
						$GDIPlusData[0] += 1
						_GUICtrlTreeView_BeginUpdate($hTree)
						$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "Curve")
						_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 108)
						_GUICtrlTreeView_EndUpdate($hTree)
						_ArrayAdd($GDITrees, $hItem)
						$GDITrees[0] += 1
						_GUICtrlTreeView_Expand($hTree, $TreeItems[$hIndex], True)
						_GUICtrlTreeView_SelectItem($hTree, $hItem)
					EndIf
					Sleep(30)
				WEnd
				GUICtrlSetData($hAsking, "")
				Sleep(100)
			Case $hBtn4
				GUICtrlSetState($hP1Label, $GUI_SHOW)
				GUICtrlSetState($hP1Display, $GUI_SHOW)
				GUICtrlSetState($hP2Label, $GUI_SHOW)
				GUICtrlSetState($hP2Display, $GUI_SHOW)
				GUICtrlSetState($hP3Label, $GUI_SHOW)
				GUICtrlSetState($hP4Label, $GUI_SHOW)
				GUICtrlSetState($hP3Display, $GUI_SHOW)
				GUICtrlSetState($hP4Display, $GUI_SHOW)
				GUICtrlSetState($hP5Label, $GUI_HIDE)
				GUICtrlSetState($hP6Label, $GUI_HIDE)
				GUICtrlSetState($hP5Display, $GUI_HIDE)
				GUICtrlSetState($hP6Display, $GUI_HIDE)
				GUICtrlSetState($hP7Label, $GUI_HIDE)
				GUICtrlSetState($hP8Label, $GUI_HIDE)
				GUICtrlSetState($hP7Display, $GUI_HIDE)
				GUICtrlSetState($hP8Display, $GUI_HIDE)
				GUICtrlSetState($hColorInput, $GUI_ENABLE)
				GUICtrlSetState($hFillInput, $GUI_ENABLE)
				GUICtrlSetData($hP1Label, "X:")
				GUICtrlSetData($hP2Label, "Y:")
				GUICtrlSetData($hP3Label, "W:")
				GUICtrlSetData($hP4Label, "H:")
				If $BrushType = "1" or $BrushType = "2" Then
					If $BrushBkColor = "" Then
						GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
						GUICtrlSetData($hFillInput, "")
					Else
						GUICtrlSetBkColor($hBkColorPick, "0x"&StringTrimLeft($BrushBkColor,2))
						GUICtrlSetData($hFillInput, $BrushBkColor)
					EndIf
				Else
					GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
					GUICtrlSetData($hFillInput, "")
				EndIf
				If $BrushType = "0" or $BrushType = "1" Then
					If $BrushColor = "" Then
						GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
						GUICtrlSetData($hColorInput, "")
					Else
						GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($BrushColor,2))
						GUICtrlSetData($hColorInput, $BrushColor)
					EndIf
				Else
					GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
					GUICtrlSetData($hColorInput, "")
				EndIf
				_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
				_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
				Dim $bX,$bY
				GUICtrlSetData($hAsking, "Start Position?")
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP1Display, $hMousePos[0])
					GUICtrlSetData($hP2Display, $hMousePos[1])
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				_DrawGDIPoint( $hClickPos[0], $hClickPos[1])
				GUICtrlSetData($hP1Display, $hClickPos[0])
				GUICtrlSetData($hP2Display, $hClickPos[1])
				$bX = $hClickPos[0]
				$bY = $hClickPos[1]
				GUICtrlSetData($hAsking, "Width?  Height?")
				Sleep(200)
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP3Display, $hMousePos[0]-$bX)
					GUICtrlSetData($hP4Display, $hMousePos[1]-$bY)
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				GUICtrlSetData($hP3Display, $hMousePos[0]-$bX)
				GUICtrlSetData($hP4Display, $hMousePos[1]-$bY)
				If $BrushType = 0 Then
					_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $bX, $bY, $hMousePos[0]-$bX, $hMousePos[1]-$bY, $hGDIPen)
					_ArrayAdd($GDIPlusData, "E:"&$bX&":"&$bY&":"&$hMousePos[0]-$bX&":"&$hMousePos[1]-$bY&":"&$BrushColor&"::"&$BrushSize&":")
					$GDIPlusData[0] += 1
				ElseIf $BrushType = 1 Then
					_GDIPlus_GraphicsFillEllipse($hGDIPlus, $bX, $bY, $hMousePos[0]-$bX, $hMousePos[1]-$bY, $hGDIBrush)
					_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $bX, $bY, $hMousePos[0]-$bX, $hMousePos[1]-$bY, $hGDIPen)
					_ArrayAdd($GDIPlusData, "E:"&$bX&":"&$bY&":"&$hMousePos[0]-$bX&":"&$hMousePos[1]-$bY&":"&$BrushColor&":"&$BrushBkColor&":"&$BrushSize&":")
					$GDIPlusData[0] += 1
				ElseIf $BrushType = 2 Then
					_GDIPlus_GraphicsFillEllipse($hGDIPlus, $bX, $bY, $hMousePos[0]-$bX, $hMousePos[1]-$bY, $hGDIBrush)
					_ArrayAdd($GDIPlusData, "E:"&$bX&":"&$bY&":"&$hMousePos[0]-$bX&":"&$hMousePos[1]-$bY&"::"&$BrushBkColor&":")
					$GDIPlusData[0] += 1
				EndIf
				_GUICtrlTreeView_BeginUpdate($hTree)
				$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "Ellipse")
				_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 100)
				_GUICtrlTreeView_EndUpdate($hTree)
				_ArrayAdd($GDITrees, $hItem)
				$GDITrees[0] += 1
				GUICtrlSetData($hAsking, "")
				_GUICtrlTreeView_Expand($hTree, $TreeItems[$hIndex], True)
				_GUICtrlTreeView_SelectItem($hTree, $hItem)
				Sleep(100)
			Case $hBtn5
				GUICtrlSetData($hP1Label, "X:")
				GUICtrlSetData($hP2Label, "Y:")
				GUICtrlSetData($hP3Label, "W:")
				GUICtrlSetData($hP4Label, "H:")
				GUICtrlSetState($hP1Label, $GUI_SHOW)
				GUICtrlSetState($hP1Display, $GUI_SHOW)
				GUICtrlSetState($hP2Label, $GUI_SHOW)
				GUICtrlSetState($hP2Display, $GUI_SHOW)
				GUICtrlSetState($hP3Label, $GUI_SHOW)
				GUICtrlSetState($hP4Label, $GUI_SHOW)
				GUICtrlSetState($hP3Display, $GUI_SHOW)
				GUICtrlSetState($hP4Display, $GUI_SHOW)
				GUICtrlSetState($hP5Label, $GUI_HIDE)
				GUICtrlSetState($hP6Label, $GUI_HIDE)
				GUICtrlSetState($hP5Display, $GUI_HIDE)
				GUICtrlSetState($hP6Display, $GUI_HIDE)
				GUICtrlSetState($hP7Label, $GUI_HIDE)
				GUICtrlSetState($hP8Label, $GUI_HIDE)
				GUICtrlSetState($hP7Display, $GUI_HIDE)
				GUICtrlSetState($hP8Display, $GUI_HIDE)
				GUICtrlSetData($hFillInput, "")
				GUICtrlSetState($hFillInput, $GUI_DISABLE)
				GUICtrlSetData($hColorInput, $BrushColor)
				GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($BrushColor, 2))
				GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
				_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
				_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
				Dim $bX,$bY
				GUICtrlSetData($hAsking, "Start Position?")
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP1Display, $hMousePos[0])
					GUICtrlSetData($hP2Display, $hMousePos[1])
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				_DrawGDIPoint( $hClickPos[0], $hClickPos[1])
				GUICtrlSetData($hP1Display, $hClickPos[0])
				GUICtrlSetData($hP2Display, $hClickPos[1])
				$bX = $hClickPos[0]
				$bY = $hClickPos[1]
				GUICtrlSetData($hAsking, "Width?  Height?")
				Sleep(200)
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP3Display, $hMousePos[0]-$bX)
					GUICtrlSetData($hP4Display, $hMousePos[1]-$bY)
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				GUICtrlSetData($hP3Display, $hMousePos[0]-$bX)
				GUICtrlSetData($hP4Display, $hMousePos[1]-$bY)
				GUICtrlSetData($hAsking, "")
				$hImageGet = FileOpenDialog("Open Image", @ScriptDir, "Images (*.jpg;*.bmp;*.png;*)",0,"", $hGDIGUI)
				If Not @Error Then
					$hBitMap = _GDIPlus_BitMapCreateFromFile($hImageGet)
					_GDIPlus_GraphicsDrawImageRect($hGDIPlus, $hBitMap, $bX, $bY, $hMousePos[0]-$bX, $hMousePos[1]-$bY)
					_ArrayAdd($GDIPlusData, "I:"&StringReplace( $hImageGet, ":", "Ñ")&":"&$bX&":"&$bY&":"&$hMousePos[0]-$bX&":"&$hMousePos[1]-$bY&":"&$BrushSize&":")
					$GDIPlusData[0] += 1
					_GUICtrlTreeView_BeginUpdate($hTree)
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "Image")
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 26)
					_GUICtrlTreeView_EndUpdate($hTree)
					_ArrayAdd($GDITrees, $hItem)
					$GDITrees[0] += 1
				EndIf
				GUICtrlSetData($hAsking, "")
				_GUICtrlTreeView_Expand($hTree, $TreeItems[$hIndex], True)
				_GUICtrlTreeView_SelectItem($hTree, $hItem)
				Sleep(100)
			Case $hBtn6
				GUICtrlSetState($hP1Label, $GUI_SHOW)
				GUICtrlSetState($hP1Display, $GUI_SHOW)
				GUICtrlSetState($hP2Label, $GUI_SHOW)
				GUICtrlSetState($hP2Display, $GUI_SHOW)
				GUICtrlSetState($hP3Label, $GUI_SHOW)
				GUICtrlSetState($hP4Label, $GUI_SHOW)
				GUICtrlSetState($hP3Display, $GUI_SHOW)
				GUICtrlSetState($hP4Display, $GUI_SHOW)
				GUICtrlSetState($hP5Label, $GUI_HIDE)
				GUICtrlSetState($hP6Label, $GUI_HIDE)
				GUICtrlSetState($hP5Display, $GUI_HIDE)
				GUICtrlSetState($hP6Display, $GUI_HIDE)
				GUICtrlSetState($hP7Label, $GUI_HIDE)
				GUICtrlSetState($hP8Label, $GUI_HIDE)
				GUICtrlSetState($hP7Display, $GUI_HIDE)
				GUICtrlSetState($hP8Display, $GUI_HIDE)
				GUICtrlSetData($hP1Label, "X¹:")
				GUICtrlSetData($hP2Label, "Y¹:")
				GUICtrlSetData($hP3Label, "X²:")
				GUICtrlSetData($hP4Label, "Y²:")
				_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
				_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
				Dim $bX,$bY
				GUICtrlSetData($hAsking, "Starting Point?")
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP1Display, $hMousePos[0])
					GUICtrlSetData($hP3Display, $hMousePos[1])
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				_DrawGDIPoint( $hClickPos[0], $hClickPos[1])
				GUICtrlSetData($hP1Display, $hClickPos[0])
				GUICtrlSetData($hP2Display, $hClickPos[1])
				$bX = $hClickPos[0]
				$bY = $hClickPos[1]
				GUICtrlSetData($hAsking, "Ending Point?")
				Sleep(200)
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP2Display, $hMousePos[0])
					GUICtrlSetData($hP4Display, $hMousePos[1])
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				_DrawGDIPoint( $hClickPos[0], $hClickPos[1])
				GUICtrlSetData($hP3Display, $hClickPos[0])
				GUICtrlSetData($hP4Display, $hClickPos[1])
				_GDIPlus_GraphicsDrawLine($hGDIPlus, $bX, $bY, $hClickPos[0], $hClickPos[1], $hGDIPen)
				_ArrayAdd($GDIPlusData, "L:"&$bX&":"&$bY&":"&$hClickPos[0]&":"&$hClickPos[1]&":"&$BrushColor&":"&$BrushSize&":")
				$GDIPlusData[0] += 1
				_GUICtrlTreeView_BeginUpdate($hTree)
				$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "Line")
				_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 97)
				_GUICtrlTreeView_EndUpdate($hTree)
				_ArrayAdd($GDITrees, $hItem)
				$GDITrees[0] += 1
				GUICtrlSetData($hAsking, "")
				_GUICtrlTreeView_Expand($hTree, $TreeItems[$hIndex], True)
				_GUICtrlTreeView_SelectItem($hTree, $hItem)
				Sleep(100)
			Case $hBtn7
				GUICtrlSetState($hP1Label, $GUI_SHOW)
				GUICtrlSetState($hP1Display, $GUI_SHOW)
				GUICtrlSetState($hP2Label, $GUI_SHOW)
				GUICtrlSetState($hP2Display, $GUI_SHOW)
				GUICtrlSetState($hP3Label, $GUI_SHOW)
				GUICtrlSetState($hP4Label, $GUI_SHOW)
				GUICtrlSetState($hP3Display, $GUI_SHOW)
				GUICtrlSetState($hP4Display, $GUI_SHOW)
				GUICtrlSetState($hP5Label, $GUI_SHOW)
				GUICtrlSetState($hP6Label, $GUI_SHOW)
				GUICtrlSetState($hP5Display, $GUI_SHOW)
				GUICtrlSetState($hP6Display, $GUI_SHOW)
				GUICtrlSetState($hP7Label, $GUI_HIDE)
				GUICtrlSetState($hP8Label, $GUI_HIDE)
				GUICtrlSetState($hP7Display, $GUI_HIDE)
				GUICtrlSetState($hP8Display, $GUI_HIDE)
				GUICtrlSetData($hP1Label, "X:")
				GUICtrlSetData($hP2Label, "Y:")
				GUICtrlSetData($hP3Label, "W:")
				GUICtrlSetData($hP4Label, "H:")
				GUICtrlSetData($hP5Label, "Sweep Angle:")
				GUICtrlSetData($hP6Label, "Rotation Angle:")
				GUICtrlSetData($hP5Display, "-")
				GUICtrlSetData($hP6Display, "-")
				GUICtrlSetPos($hP5Label, 194, 25, 60, 11)
				GUICtrlSetPos($hP6Label, 194, 37, 65, 11)
				GUICtrlSetPos($hP5Display, 264, 26, 20, 10)
				GUICtrlSetPos($hP6Display, 264, 38, 20, 10)
				GUICtrlSetState($hColorInput, $GUI_ENABLE)
				GUICtrlSetState($hFillInput, $GUI_ENABLE)

				If $BrushType = "1" or $BrushType = "2" Then
					If $BrushBkColor = "" Then
						GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
						GUICtrlSetData($hFillInput, "")
					Else
						GUICtrlSetBkColor($hBkColorPick, "0x"&StringTrimLeft($BrushBkColor,2))
						GUICtrlSetData($hFillInput, $BrushBkColor)
					EndIf
				Else
					GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
					GUICtrlSetData($hFillInput, "")
				EndIf
				If $BrushType = "0" or $BrushType = "1" Then
					If $BrushColor = "" Then
						GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
						GUICtrlSetData($hColorInput, "")
					Else
						GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($BrushColor,2))
						GUICtrlSetData($hColorInput, $BrushColor)
					EndIf
				Else
					GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
					GUICtrlSetData($hColorInput, "")
				EndIf
				_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
				_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
				Dim $bX,$bY,$bW,$bH
				GUICtrlSetData($hAsking, "Start Position?")
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP1Display, $hMousePos[0])
					GUICtrlSetData($hP2Display, $hMousePos[1])
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				_DrawGDIPoint( $hMousePos[0], $hMousePos[1])
				GUICtrlSetData($hP1Display, $hClickPos[0])
				GUICtrlSetData($hP2Display, $hClickPos[1])
				$bX = $hClickPos[0]
				$bY = $hClickPos[1]
				GUICtrlSetData($hAsking, "Width?  Height?")
				Sleep(100)
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP3Display, $hMousePos[0]-$bX)
					GUICtrlSetData($hP4Display, $hMousePos[1]-$bY)
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				_DrawGDIPoint( $hClickPos[0], $hClickPos[1])
				GUICtrlSetData($hP3Display, $hMousePos[0]-$bX)
				GUICtrlSetData($hP4Display, $hMousePos[1]-$bY)
				$bW = $hMousePos[0]-$bX
				$bH = $hMousePos[1]-$bY
				_GDIPlus_GraphicsDrawPie($hGDIPlus, $bX, $bY, $bW, $bH, 0, 30, $hGDIPen)
				GUICtrlSetData($hAsking, "Sweep Angle?")
				_GUICtrlTreeView_BeginUpdate($hTree)
				$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "Pie")
				_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 101)
				_GUICtrlTreeView_EndUpdate($hTree)
				_ArrayAdd($GDITrees, $hItem)
				_ArrayAdd($GDIPlusData, "P:"&$bX&":"&$bY&":"&$bW&":"&$bH&":0:30:"&$BrushColor&"::"&$BrushSize&":")
				$GDITrees[0] += 1
				$GDIPlusData[0] += 1
				Dim $hAngleVar
				Sleep(200)
				While _IsPressed("01") = False
					$hMouseNow = GUIGetCursorInfo($hGDIGUI)
					If (ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi) < 0 Then
						If $hMouseNow[1] > $bY+($bH/2) Then
							$hAngleVar = Round(Abs(180-(ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi)))
						Else
							$hAngleVar = Round(Abs((ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi)))
						EndIf
					Else
						If $hMouseNow[0] > $bX+($bW/2) Then
							$hAngleVar = Round(Abs(360-(ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi)))
						Else
							$hAngleVar = Round(180-(ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi))
						EndIf
					EndIf
					If $BrushType = 0 Then
						$GDIPlusData[$GDIPlusData[0]] = "P:"&$bX&":"&$bY&":"&$bW&":"&$bH&":"&0&":"&Abs(360-$hAngleVar)&":"&$BrushColor&"::"&$BrushSize&":"
					ElseIf $BrushType = 1 Then
						$GDIPlusData[$GDIPlusData[0]] = "P:"&$bX&":"&$bY&":"&$bW&":"&$bH&":"&0&":"&Abs(360-$hAngleVar)&":"&$BrushColor&":"&$BrushBkColor&":"&$BrushSize&":"
					ElseIf $BrushType = 2 Then
						$GDIPlusData[$GDIPlusData[0]] = "P:"&$bX&":"&$bY&":"&$bW&":"&$bH&":"&0&":"&Abs(360-$hAngleVar)&"::"&$BrushBkColor&":"&$BrushSize&":"
					EndIf
					GUICtrlSetData($hP5Display, Abs(360-$hAngleVar)&"°")
					_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
					_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
					$hPenWidth = _GDIPlus_PenGetWidth($hGDIPen)
					$hPenRead = _GDIPlus_PenGetColor($hGDIPen)
					$hBrushRead = _GDIPlus_BrushGetSolidColor($hGDIBrush)
					_GDIPlus_PenSetColor($hGDIPen, "0xFF000000")
					_GDIPlus_PenSetWidth($hGDIPen, 1)
					_GDIPlus_BrushSetSolidColor($hGDIBrush, "0xFF00CC00")
					_GDIPlus_GraphicsFillEllipse($hGDIPlus, $bX+($bW/2)-4, $bY+($bH/2)-4, 9, 9, $hGDIBrush)
					_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $bX+($bW/2)-4, $bY+($bH/2)-4, 9, 9, $hGDIPen)
					_GDIPlus_PenSetWidth($hGDIPen, $hPenWidth)
					_GDIPlus_PenSetColor($hGDIPen, $hPenRead)
					_GDIPlus_BrushSetSolidColor($hGDIBrush, $hBrushRead)
					Sleep(80)
				WEnd
				GUICtrlSetData($hAsking, "Rotational Angle?")
				Sleep(200)
				Dim $hAngleVar2
				While _IsPressed("01") = False
					$hMouseNow = GUIGetCursorInfo($hGDIGUI)
					If (ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi) < 0 Then
						If $hMouseNow[1] > $bY+($bH/2) Then
							$hAngleVar2 = Round(Abs(180-(ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi)))
						Else
							$hAngleVar2 = Round(Abs((ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi)))
						EndIf
					Else
						If $hMouseNow[0] > $bX+($bW/2) Then
							$hAngleVar2 = Round(Abs(360-(ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi)))
						Else
							$hAngleVar2 = Round(180-(ATan(($bY+($bH/2)-$hMouseNow[1])/(($bX+($bW/2))-$hMouseNow[0])))*(180/$Pi))
						EndIf
					EndIf
					If $BrushType = 0 Then
						$GDIPlusData[$GDIPlusData[0]] = "P:"&$bX&":"&$bY&":"&$bW&":"&$bH&":"&Abs(360-$hAngleVar2)&":"&Abs(360-$hAngleVar)&":"&$BrushColor&"::"&$BrushSize&":"
					ElseIf $BrushType = 1 Then
						$GDIPlusData[$GDIPlusData[0]] = "P:"&$bX&":"&$bY&":"&$bW&":"&$bH&":"&Abs(360-$hAngleVar2)&":"&Abs(360-$hAngleVar)&":"&$BrushColor&":"&$BrushBkColor&":"&$BrushSize&":"
					ElseIf $BrushType = 2 Then
						$GDIPlusData[$GDIPlusData[0]] = "P:"&$bX&":"&$bY&":"&$bW&":"&$bH&":"&Abs(360-$hAngleVar2)&":"&Abs(360-$hAngleVar)&"::"&$BrushBkColor&":"&$BrushSize&":"
					EndIf
					GUICtrlSetData($hP6Display, Abs(360-$hAngleVar)&"°")
					_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
					_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
					$hPenWidth = _GDIPlus_PenGetWidth($hGDIPen)
					$hPenRead = _GDIPlus_PenGetColor($hGDIPen)
					$hBrushRead = _GDIPlus_BrushGetSolidColor($hGDIBrush)
					_GDIPlus_PenSetColor($hGDIPen, "0xFF000000")
					_GDIPlus_PenSetWidth($hGDIPen, 1)
					_GDIPlus_BrushSetSolidColor($hGDIBrush, "0xFF00CC00")
					_GDIPlus_GraphicsFillEllipse($hGDIPlus, $bX+($bW/2)-4, $bY+($bH/2)-4, 9, 9, $hGDIBrush)
					_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $bX+($bW/2)-4, $bY+($bH/2)-4, 9, 9, $hGDIPen)
					_GDIPlus_PenSetWidth($hGDIPen, $hPenWidth)
					_GDIPlus_PenSetColor($hGDIPen, $hPenRead)
					_GDIPlus_BrushSetSolidColor($hGDIBrush, $hBrushRead)
					Sleep(80)
				WEnd
				GUICtrlSetData($hAsking, "")
				_GUICtrlTreeView_Expand($hTree, $TreeItems[$hIndex], True)
				_GUICtrlTreeView_SelectItem($hTree, $hItem)
				Sleep(100)
			Case $hBtn8
				GUICtrlSetState($hP1Label, $GUI_HIDE)
				GUICtrlSetState($hP1Display, $GUI_HIDE)
				GUICtrlSetState($hP2Label, $GUI_HIDE)
				GUICtrlSetState($hP2Display, $GUI_HIDE)
				GUICtrlSetState($hP3Label, $GUI_HIDE)
				GUICtrlSetState($hP4Label, $GUI_HIDE)
				GUICtrlSetState($hP3Display, $GUI_HIDE)
				GUICtrlSetState($hP4Display, $GUI_HIDE)
				GUICtrlSetState($hP5Label, $GUI_HIDE)
				GUICtrlSetState($hP6Label, $GUI_HIDE)
				GUICtrlSetState($hP5Display, $GUI_HIDE)
				GUICtrlSetState($hP6Display, $GUI_HIDE)
				GUICtrlSetState($hP7Label, $GUI_HIDE)
				GUICtrlSetState($hP8Label, $GUI_HIDE)
				GUICtrlSetState($hP7Display, $GUI_HIDE)
				GUICtrlSetState($hP8Display, $GUI_HIDE)
				GUICtrlSetState($hColorInput, $GUI_ENABLE)
				GUICtrlSetState($hFillInput, $GUI_ENABLE)
				If $BrushType = "1" or $BrushType = "2" Then
					If $BrushBkColor = "" Then
						GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
						GUICtrlSetData($hFillInput, "")
					Else
						GUICtrlSetBkColor($hBkColorPick, "0x"&StringTrimLeft($BrushBkColor,2))
						GUICtrlSetData($hFillInput, $BrushBkColor)
					EndIf
				Else
					GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
					GUICtrlSetData($hFillInput, "")
				EndIf
				If $BrushType = "0" or $BrushType = "1" Then
					If $BrushColor = "" Then
						GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
						GUICtrlSetData($hColorInput, "")
					Else
						GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($BrushColor,2))
						GUICtrlSetData($hColorInput, $BrushColor)
					EndIf
				Else
					GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
					GUICtrlSetData($hColorInput, "")
				EndIf
				_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
				_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
				Dim $hDrawArray[21][2]
				Dim $hDrawCount = 0
				Dim $Drawing = True
				$hDrawArray[0][0] = 20
				$hDrawArray[1][0] = 0
				$hDrawArray[1][1] = 0
				$hDrawArray[2][0] = 0
				$hDrawArray[2][1] = 0
				$hDrawArray[3][0] = 0
				$hDrawArray[3][1] = 0
				$hDrawArray[4][0] = 0
				$hDrawArray[4][1] = 0
				$hDrawArray[5][0] = 0
				$hDrawArray[5][1] = 0
				$hDrawArray[6][0] = 0
				$hDrawArray[6][1] = 0
				$hDrawArray[7][0] = 0
				$hDrawArray[7][1] = 0
				$hDrawArray[8][0] = 0
				$hDrawArray[8][1] = 0
				$hDrawArray[9][0] = 0
				$hDrawArray[9][1] = 0
				$hDrawArray[10][0] = 0
				$hDrawArray[10][1] = 0
				$hDrawArray[11][0] = 0
				$hDrawArray[11][1] = 0
				$hDrawArray[12][0] = 0
				$hDrawArray[12][1] = 0
				$hDrawArray[13][0] = 0
				$hDrawArray[13][1] = 0
				$hDrawArray[14][0] = 0
				$hDrawArray[14][1] = 0
				$hDrawArray[15][0] = 0
				$hDrawArray[15][1] = 0
				$hDrawArray[16][0] = 0
				$hDrawArray[16][1] = 0
				$hDrawArray[17][0] = 0
				$hDrawArray[17][1] = 0
				$hDrawArray[18][0] = 0
				$hDrawArray[18][1] = 0
				$hDrawArray[19][0] = 0
				$hDrawArray[19][1] = 0
				$hDrawArray[20][0] = 0
				$hDrawArray[20][1] = 0
				GUICtrlSetData($hAsking, "Add Point?  Press Enter to Submit")
				dim $hLastX, $hLastY
				While $Drawing = True
					If _IsPressed("01") Then
						If $hDrawCount < 20 Then
							$hMousePos = GUIGetCursorInfo($hGDIGUI)
							_DrawGDIPoint( $hMousePos[0], $hMousePos[1])
							$hDrawCount += 1
							$hDrawArray[$hDrawCount][0] = $hMousePos[0]
							$hDrawArray[$hDrawCount][1] = $hMousePos[1]
							$hLastX = $hMousePos[0]
							$hLastY = $hMousePos[1]
							Sleep(200)
						Else
							Msgbox(0, "Max Points", "Maximum number of points reached.")
						EndIf
					EndIf
					If _IsPressed("0D") = True Then
						$Drawing = False
						For $i = 20 to $hDrawCount Step -1
							$hDrawArray[$i][0] = $hLastX
							$hDrawArray[$i][1] = $hLastY
						Next
						Dim $hGDIData = ''
						For $i = 1 to $hDrawCount Step 1
							$hGDIData &= ":"&$hDrawArray[$i][0]&":"&$hDrawArray[$i][1]
						Next
						If $BrushType = 0 Then
							_GDIPlus_GraphicsDrawPolygon($hGDIPlus, $hDrawArray, $hGDIPen)
							_ArrayAdd($GDIPlusData, "Po"&$hGDIData&":"&$BrushColor&"::"&$BrushSize&":")
							$GDIPlusData[0] += 1
						ElseIf $BrushType = 1 Then
							_GDIPlus_GraphicsFillPolygon($hGDIPlus, $hDrawArray, $hGDIBrush)
							_GDIPlus_GraphicsDrawPolygon($hGDIPlus, $hDrawArray, $hGDIPen)
							_ArrayAdd($GDIPlusData, "Po"&$hGDIData&":"&$BrushColor&":"&$BrushBkColor&":"&$BrushSize&":")
							$GDIPlusData[0] += 1
						ElseIf $BrushType = 2 Then
							_GDIPlus_GraphicsFillPolygon($hGDIPlus, $hDrawArray, $hGDIBrush)
							_ArrayAdd($GDIPlusData, "Po"&$hGDIData&"::"&$BrushBkColor&":"&$BrushSize&":")
							$GDIPlusData[0] += 1
						EndIf
						_GUICtrlTreeView_BeginUpdate($hTree)
						$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "Polygon")
						_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 109)
						_GUICtrlTreeView_EndUpdate($hTree)
						_ArrayAdd($GDITrees, $hItem)
						$GDITrees[0] += 1
						_GUICtrlTreeView_Expand($hTree, $TreeItems[$hIndex], True)
						_GUICtrlTreeView_SelectItem($hTree, $hItem)
					EndIf
					Sleep(30)
				WEnd
				GUICtrlSetData($hAsking, "")
				Sleep(100)
			Case $hBtn9
				GUICtrlSetState($hP8Label, $GUI_HIDE)
				GUICtrlSetState($hP7Label, $GUI_HIDE)
				GUICtrlSetState($hP6Label, $GUI_HIDE)
				GUICtrlSetState($hP5Label, $GUI_HIDE)
				GUICtrlSetState($hP8Display, $GUI_HIDE)
				GUICtrlSetState($hP7Display, $GUI_HIDE)
				GUICtrlSetState($hP6Display, $GUI_HIDE)
				GUICtrlSetState($hP5Display, $GUI_HIDE)
				GUICtrlSetState($hP4Label, $GUI_SHOW)
				GUICtrlSetState($hP3Label, $GUI_SHOW)
				GUICtrlSetState($hP2Label, $GUI_SHOW)
				GUICtrlSetState($hP4Display, $GUI_SHOW)
				GUICtrlSetState($hP3Display, $GUI_SHOW)
				GUICtrlSetState($hP2Display, $GUI_SHOW)
				GUICtrlSetState($hP1Label, $GUI_SHOW)
				GUICtrlSetState($hP1Display, $GUI_SHOW)
				GUICtrlSetData($hP1Label, "X:")
				GUICtrlSetData($hP2Label, "Y:")
				GUICtrlSetData($hP3Label, "W:")
				GUICtrlSetData($hP4Label, "H:")
				GUICtrlSetState($hColorInput, $GUI_ENABLE)
				GUICtrlSetState($hFillInput, $GUI_ENABLE)
				If $BrushType = "1" or $BrushType = "2" Then
					If $BrushBkColor = "" Then
						GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
						GUICtrlSetData($hFillInput, "")
					Else
						GUICtrlSetBkColor($hBkColorPick, "0x"&StringTrimLeft($BrushBkColor,2))
						GUICtrlSetData($hFillInput, $BrushBkColor)
					EndIf
				Else
					GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
					GUICtrlSetData($hFillInput, "")
				EndIf
				If $BrushType = "0" or $BrushType = "1" Then
					If $BrushColor = "" Then
						GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
						GUICtrlSetData($hColorInput, "")
					Else
						GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($BrushColor,2))
						GUICtrlSetData($hColorInput, $BrushColor)
					EndIf
				Else
					GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
					GUICtrlSetData($hColorInput, "")
				EndIf
				_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
				_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
				Dim $bX,$bY
				GUICtrlSetData($hAsking, "Start Position?")
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP1Display, $hMousePos[0])
					GUICtrlSetData($hP2Display, $hMousePos[1])
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				_DrawGDIPoint( $hClickPos[0], $hClickPos[1])
				GUICtrlSetData($hP1Display, $hClickPos[0])
				GUICtrlSetData($hP2Display, $hClickPos[1])
				$bX = $hClickPos[0]
				$bY = $hClickPos[1]
				GUICtrlSetData($hAsking, "Width?  Height?")
				Sleep(200)
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP3Display, $hMousePos[0]-$bX)
					GUICtrlSetData($hP4Display, $hMousePos[1]-$bY)
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				_DrawGDIPoint( $hClickPos[0], $hClickPos[1])
				GUICtrlSetData($hP3Display, $hMousePos[0]-$bX)
				GUICtrlSetData($hP4Display, $hMousePos[1]-$bY)
				If $BrushType = 0 Then
					_GDIPlus_GraphicsDrawRect($hGDIPlus, $bX, $bY, $hClickPos[0]-$bX, $hClickPos[1]-$bY, $hGDIPen)
					_ArrayAdd($GDIPlusData, "R:"&$bX&":"&$bY&":"&$hClickPos[0]-$bX&":"&$hClickPos[1]-$bY&":"&$BrushColor&"::"&$BrushSize&":")
					$GDIPlusData[0] += 1
				ElseIf $BrushType = 1 Then
					_GDIPlus_GraphicsFillRect($hGDIPlus, $bX, $bY, $hClickPos[0]-$bX, $hClickPos[1]-$bY, $hGDIBrush)
					_GDIPlus_GraphicsDrawRect($hGDIPlus, $bX, $bY, $hClickPos[0]-$bX, $hClickPos[1]-$bY, $hGDIPen)
					_ArrayAdd($GDIPlusData, "R:"&$bX&":"&$bY&":"&$hClickPos[0]-$bX&":"&$hClickPos[1]-$bY&":"&$BrushColor&":"&$BrushBkColor&":"&$BrushSize&":")
					$GDIPlusData[0] += 1
				ElseIf $BrushType = 2 Then
					_GDIPlus_GraphicsFillRect($hGDIPlus, $bX, $bY, $hClickPos[0]-$bX, $hClickPos[1]-$bY, $hGDIBrush)
					_ArrayAdd($GDIPlusData, "R:"&$bX&":"&$bY&":"&$hClickPos[0]-$bX&":"&$hClickPos[1]-$bY&"::"&$BrushBkColor&":")
					$GDIPlusData[0] += 1
				EndIf
				_GUICtrlTreeView_BeginUpdate($hTree)
				$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "Rectangle")
				_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 99)
				_GUICtrlTreeView_EndUpdate($hTree)
				_ArrayAdd($GDITrees, $hItem)
				$GDITrees[0] += 1
				GUICtrlSetData($hAsking, "")
				_GUICtrlTreeView_Expand($hTree, $TreeItems[$hIndex], True)
				_GUICtrlTreeView_SelectItem($hTree, $hItem)
				Sleep(100)
			Case $hBtn10
				GUICtrlSetState($hP1Label, $GUI_HIDE)
				GUICtrlSetState($hP1Display, $GUI_HIDE)
				GUICtrlSetState($hP2Label, $GUI_HIDE)
				GUICtrlSetState($hP2Display, $GUI_HIDE)
				GUICtrlSetState($hP3Label, $GUI_HIDE)
				GUICtrlSetState($hP4Label, $GUI_HIDE)
				GUICtrlSetState($hP3Display, $GUI_HIDE)
				GUICtrlSetState($hP4Display, $GUI_HIDE)
				GUICtrlSetState($hP5Label, $GUI_HIDE)
				GUICtrlSetState($hP6Label, $GUI_HIDE)
				GUICtrlSetState($hP5Display, $GUI_HIDE)
				GUICtrlSetState($hP6Display, $GUI_HIDE)
				GUICtrlSetState($hP7Label, $GUI_HIDE)
				GUICtrlSetState($hP8Label, $GUI_HIDE)
				GUICtrlSetState($hP7Display, $GUI_HIDE)
				GUICtrlSetState($hP8Display, $GUI_HIDE)
				_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
				_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
				Dim $bX,$bY
				GUICtrlSetData($hAsking, "Start Position?")
				While _IsPressed("01") = False
					$hMousePos = GUIGetCursorInfo($hGDIGUI)
					GUICtrlSetData($hP1Display, $hMousePos[0])
					GUICtrlSetData($hP2Display, $hMousePos[1])
					Sleep(30)
				WEnd
				$hClickPos = GUIGetCursorInfo($hGDIGUI)
				_DrawGDIPoint( $hClickPos[0], $hClickPos[1])
				GUICtrlSetData($hP1Display, $hClickPos[0])
				GUICtrlSetData($hP2Display, $hClickPos[1])
				GUICtrlSetData($hAsking, "String?")
				$bX = $hClickPos[0]
				$bY = $hClickPos[1]
				Dim $hStringPrompt = True
				$hStringGUI = GUICreate( "String Edit", 240, 183, -1, -1)
				GUICtrlCreateLabel( "String:", 11, 8, 34, 14)
				$hStringInput = GUICtrlCreateEdit( "", 16, 27, 217, 59)
				GUICtrlCreateLabel( "Font:", 28, 97, 29, 14)
				$hFontInput = GUICtrlCreateCombo( "", 65, 94, 170, 21, 0x003)
				GUICtrlSetData( -1, $Fonts, $DefaultFont)
				GUICtrlCreateLabel( "Font Size:", 28, 128, 55, 16)
				$hSizeInput = GUICtrlCreateInput( "10", 94, 125, 124, 21)
				$Updown8 = GUICtrlCreateUpDown( $hSizeInput )
				$hStringSave = GUICtrlCreateButton( "Save", 133, 153, 100, 24)
				$hStringCancel = GUICtrlCreateButton( "Cancel", 11, 153, 100, 24)
				GUISetState()
				GUICtrlSetData($hAsking, "")

				While $hStringPrompt = True
					$hMsg = GUIGetMsg()
					Switch $hMsg
						Case $GUI_EVENT_CLOSE
							GUIDelete($hStringGUI)
							$hStringPrompt = False
						Case $hStringSave
							$hGDIString = StringReplace(StringReplace(GUICtrlRead($hStringInput), ";", "å"), ":", "Ñ")
							_GDIPlus_GraphicsDrawString($hGDIPlus, GUICtrlRead($hStringInput), $bX, $bY, GUICtrlRead($hFontInput), GUICtrlRead($hSizeInput) )
							_ArrayAdd($GDIPlusData, "S:"&$bX&":"&$bY&":"&$hGDIString&":"&GUICtrlRead($hFontInput)&":"&GUICtrlRead($hSizeInput)&":")
							$GDIPlusData[0] += 1
							_GUICtrlTreeView_BeginUpdate($hTree)
							$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "String")
							_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 21)
							_GUICtrlTreeView_EndUpdate($hTree)
							_ArrayAdd($GDITrees, $hItem)
							$GDITrees[0] += 1
							GUIDelete($hStringGUI)
							$hStringPrompt = False
							GUICtrlSetData($hAsking, "")
							_GUICtrlTreeView_Expand($hTree, $TreeItems[$hIndex], True)
							_GUICtrlTreeView_SelectItem($hTree, $hItem)
						Case $hStringCancel
							GUIDelete($hStringGUI)
							$hStringPrompt = False
					EndSwitch
				WEnd
				Sleep(100)
			Case $hBtn11
				GUICtrlSetState($hP1Label, $GUI_HIDE)
				GUICtrlSetState($hP1Display, $GUI_HIDE)
				GUICtrlSetState($hP2Label, $GUI_HIDE)
				GUICtrlSetState($hP2Display, $GUI_HIDE)
				GUICtrlSetState($hP3Label, $GUI_HIDE)
				GUICtrlSetState($hP4Label, $GUI_HIDE)
				GUICtrlSetState($hP3Display, $GUI_HIDE)
				GUICtrlSetState($hP4Display, $GUI_HIDE)
				GUICtrlSetState($hP5Label, $GUI_HIDE)
				GUICtrlSetState($hP6Label, $GUI_HIDE)
				GUICtrlSetState($hP5Display, $GUI_HIDE)
				GUICtrlSetState($hP6Display, $GUI_HIDE)
				GUICtrlSetState($hP7Label, $GUI_HIDE)
				GUICtrlSetState($hP8Label, $GUI_HIDE)
				GUICtrlSetState($hP7Display, $GUI_HIDE)
				GUICtrlSetState($hP8Display, $GUI_HIDE)
				GUICtrlSetState($hColorInput, $GUI_ENABLE)
				GUICtrlSetState($hFillInput, $GUI_ENABLE)
				If $BrushType = "1" or $BrushType = "2" Then
					If $BrushBkColor = "" Then
						GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
						GUICtrlSetData($hFillInput, "")
					Else
						GUICtrlSetBkColor($hBkColorPick, "0x"&StringTrimLeft($BrushBkColor,2))
						GUICtrlSetData($hFillInput, $BrushBkColor)
					EndIf
				Else
					GUICtrlSetBkColor($hBkColorPick, 0xFFFFFF)
					GUICtrlSetData($hFillInput, "")
				EndIf
				If $BrushType = "0" or $BrushType = "1" Then
					If $BrushColor = "" Then
						GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
						GUICtrlSetData($hColorInput, "")
					Else
						GUICtrlSetBkColor($hColorPick, "0x"&StringTrimLeft($BrushColor,2))
						GUICtrlSetData($hColorInput, $BrushColor)
					EndIf
				Else
					GUICtrlSetBkColor($hColorPick, 0xFFFFFF)
					GUICtrlSetData($hColorInput, "")
				EndIf
				_GDIPlus_GraphicsClear($hGDIPlus, 0xFFF0F0F0)
				_DrawGDIplusData( $hIndex, _ArrayToString($GDIPlusData, ";", 1, $GDIPlusData[0]), $hGDIGUI)
				Dim $hDrawArray[21][2]
				Dim $hDrawCount = 0
				Dim $Drawing = True
				$hDrawArray[0][0] = 20
				$hDrawArray[1][0] = 0
				$hDrawArray[1][1] = 0
				$hDrawArray[2][0] = 0
				$hDrawArray[2][1] = 0
				$hDrawArray[3][0] = 0
				$hDrawArray[3][1] = 0
				$hDrawArray[4][0] = 0
				$hDrawArray[4][1] = 0
				$hDrawArray[5][0] = 0
				$hDrawArray[5][1] = 0
				$hDrawArray[6][0] = 0
				$hDrawArray[6][1] = 0
				$hDrawArray[7][0] = 0
				$hDrawArray[7][1] = 0
				$hDrawArray[8][0] = 0
				$hDrawArray[8][1] = 0
				$hDrawArray[9][0] = 0
				$hDrawArray[9][1] = 0
				$hDrawArray[10][0] = 0
				$hDrawArray[10][1] = 0
				$hDrawArray[11][0] = 0
				$hDrawArray[11][1] = 0
				$hDrawArray[12][0] = 0
				$hDrawArray[12][1] = 0
				$hDrawArray[13][0] = 0
				$hDrawArray[13][1] = 0
				$hDrawArray[14][0] = 0
				$hDrawArray[14][1] = 0
				$hDrawArray[15][0] = 0
				$hDrawArray[15][1] = 0
				$hDrawArray[16][0] = 0
				$hDrawArray[16][1] = 0
				$hDrawArray[17][0] = 0
				$hDrawArray[17][1] = 0
				$hDrawArray[18][0] = 0
				$hDrawArray[18][1] = 0
				$hDrawArray[19][0] = 0
				$hDrawArray[19][1] = 0
				$hDrawArray[20][0] = 0
				$hDrawArray[20][1] = 0
				GUICtrlSetData($hAsking, "Add Point?  Press Enter to Submit")
				dim $hLastX, $hLastY
				While $Drawing = True
					If _IsPressed("01") Then
						If $hDrawCount < 20 Then
							$hMousePos = GUIGetCursorInfo($hGDIGUI)
							_DrawGDIPoint( $hMousePos[0], $hMousePos[1])
							$hDrawCount += 1
							$hDrawArray[$hDrawCount][0] = $hMousePos[0]
							$hDrawArray[$hDrawCount][1] = $hMousePos[1]
							$hLastX = $hMousePos[0]
							$hLastY = $hMousePos[1]
							Sleep(200)
						Else
							Msgbox(0, "Max Points", "Maximum number of points reached.")
						EndIf
					EndIf
					If _IsPressed("0D") = True Then
						$Drawing = False
						For $i = 20 to $hDrawCount Step -1
							$hDrawArray[$i][0] = $hLastX
							$hDrawArray[$i][1] = $hLastY
						Next
						Dim $hGDIData = ''
						For $i = 1 to $hDrawCount Step 1
							$hGDIData &= ":"&$hDrawArray[$i][0]&":"&$hDrawArray[$i][1]
						Next
						If $BrushType = 0 Then
							_GDIPlus_GraphicsDrawClosedCurve($hGDIPlus, $hDrawArray, $hGDIPen)
							_ArrayAdd($GDIPlusData, "CC"&$hGDIData&":"&$BrushColor&"::"&$BrushSize&":")
							$GDIPlusData[0] += 1
						ElseIf $BrushType = 1 Then
							_GDIPlus_GraphicsFillClosedCurve($hGDIPlus, $hDrawArray, $hGDIBrush)
							_GDIPlus_GraphicsDrawClosedCurve($hGDIPlus, $hDrawArray, $hGDIPen)
							_ArrayAdd($GDIPlusData, "CC"&$hGDIData&":"&$BrushColor&":"&$BrushBkColor&":"&$BrushSize&":")
							$GDIPlusData[0] += 1
						ElseIf $BrushType = 2 Then
							_GDIPlus_GraphicsFillClosedCurve($hGDIPlus, $hDrawArray, $hGDIBrush)
							_ArrayAdd($GDIPlusData, "CC"&$hGDIData&"::"&$BrushBkColor&":"&$BrushSize&":")
							$GDIPlusData[0] += 1
						EndIf
						_GUICtrlTreeView_BeginUpdate($hTree)
						$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$hIndex], "Closed Curve")
						_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 110)
						_GUICtrlTreeView_EndUpdate($hTree)
						_ArrayAdd($GDITrees, $hItem)
						$GDITrees[0] += 1
						GUICtrlSetData($hAsking, "")
						_GUICtrlTreeView_Expand($hTree, $TreeItems[$hIndex], True)
						_GUICtrlTreeView_SelectItem($hTree, $hItem)
					EndIf
					Sleep(30)
				WEnd
				Sleep(100)
		EndSwitch
		If $BrushType <> _GUICtrlComboBoxEx_GetCurSel($hBrushType) Then
			$BrushType = _GUICtrlComboBoxEx_GetCurSel($hBrushType)
		EndIf
		If $BrushSmooth <> _GUICtrlComboBoxEx_GetCurSel($hBrushSmooth) Then
			$BrushSmooth = _GUICtrlComboBoxEx_GetCurSel($hBrushSmooth)
			_GDIPlus_GraphicsSetSmoothingMode($hGDIPlus, $BrushSmooth)
		EndIf
		If GUICtrlRead($hBrushInput) <> $BrushSize Then
			$BrushSize = GUICtrlRead($hBrushInput)
			_GDIPlus_PenSetWidth($hGDIPen, $BrushSize)
		EndIf
	WEnd
EndFunc
Func _WinAPI_PickIconDlg($sIcon = '', $iIndex = 0, $hParent = 0)

	Local $Ret = DllCall('shell32.dll', 'int', 'PickIconDlg', 'hwnd', $hParent, 'wstr', $sIcon, 'int', 4096, 'int*', $iIndex)

	If (@error) Or (Not $Ret[0]) Then
		Return SetError(1, 0, 0)
	EndIf

	Local $Result[2]

	$Result[0] = _WinAPI_ExpandEnvironmentStrings($Ret[2])
	$Result[1] = $Ret[4]

	Return $Result
EndFunc   ;==>_WinAPI_PickIconDlg
Func _GetGDIPlusCode($hIndex)
	Local $hCode
	$hCode = $Data[$hIndex]
	Dim $CodeTemp = ''
	Dim $hLastColor = ''
	Dim $hLastBkColor = ''
	Dim $hPenSize = "1"
	$CodeTemp &= '$hPen = _GDIPlus_PenCreate()'&@CRLF
	$CodeTemp &= '$hBrush = _GDIPlus_BrushCreateSolid()'&@CRLF
	$CodeTemp &= '_GDIPlus_GraphicsSetSmoothingMode( $'&$Names[$hIndex]&', '&$hGDIPlusQuality&')'&@CRLF
	If $hCode = "" Then
		Return ""
	EndIf
	If StringinStr($hCode, ";") = False Then
		$hCode = $hCode&";"
	EndIf
	$hSplit = StringSplit($hCode, ";")
	For $i = 1 to $hSplit[0] Step 1
		$hItemSplit = StringSplit($hSplit[$i], ":")
		Switch $hItemSplit[1]
			Case "A"
				If $hItemSplit[9] <> $hPenSize Then
					If $hItemSplit[9] <> "" Then
						$hPenSize = $hItemSplit[9]
						$CodeTemp &= '_GDIPlus_PenSetWidth( $hPen, '&$hPenSize&")"&@CRLF
					EndIf
				Endif
				If $hItemSplit[8] <> $hLastColor Then
					$hLastColor = $hItemSplit[8]
					$CodeTemp &= '_GDIPlus_PenSetColor( $hPen, 0x'&$hLastColor&")"&@CRLF
				EndIf
				$CodeTemp &= '_GDIPlus_GraphicsDrawArc( $'&$Names[$hIndex]&', '&$hItemSplit[2]&', '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', '&$hItemSplit[6]&', '&$hItemSplit[7]&', $hPen)'&@CRLF
			Case "B"
				If $hItemSplit[11] <> $hPenSize Then
					$hPenSize = $hItemSplit[11]
					$CodeTemp &= '_GDIPlus_PenSetWidth( $hPen, '&$hPenSize&")"&@CRLF
				Endif
				If $hItemSplit[10] <> $hLastColor Then
					$hLastColor = $hItemSplit[10]
					$CodeTemp &= '_GDIPlus_PenSetColor( $hPen, 0x'&$hLastColor&")"&@CRLF
				EndIf
				$CodeTemp &= '_GDIPlus_GraphicsDrawBezier( $'&$Names[$hIndex]&', '&$hItemSplit[2]&', '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', '&$hItemSplit[6]&', '&$hItemSplit[7]&', '&$hItemSplit[8]&', '&$hItemSplit[9]&', $hPen)'&@CRLF
			Case "C"
				If $hItemSplit[$hItemSplit[0]-1] <> $hPenSize Then
					$hPenSize = $hItemSplit[$hItemSplit[0]-1]
					$CodeTemp &= '_GDIPlus_PenSetWidth( $hPen, '&$hPenSize&")"&@CRLF
				Endif
				If $hItemSplit[$hItemSplit[0]-2] <> $hLastColor Then
					If $hItemSplit[$hItemSplit[0]-2] <> "" Then
						$hLastColor = $hItemSplit[$hItemSplit[0]-2]
						$CodeTemp &= '_GDIPlus_PenSetColor( $hPen, 0x'&$hLastColor&")"&@CRLF
					EndIf
				EndIf

				Dim $PointNum = 1
				Dim $DeclareString = ""
				Dim $Alternate = True
				For $d = 2 to $hItemSplit[0]-3 Step 1
					If $Alternate = True Then
						$DeclareString &= '$hCurvePoints['&$PointNum&'][0] = '&$hItemSplit[$d]&@CRLF
						$Alternate = False
					Else
						$Alternate = True
						$DeclareString &= '$hCurvePoints['&$PointNum&'][1] = '&$hItemSplit[$d]&@CRLF
						$PointNum += 1
					EndIf
				Next

				$CodeTemp &= 'Dim $hCurvePoints['&$PointNum&'][2]'&@CRLF & _
							 '$hCurvePoints[0][0] = '&$PointNum-1&@CRLF&$DeclareString

				$CodeTemp &= '_GDIPlus_GraphicsDrawCurve( $'&$Names[$hIndex]&', $hCurvePoints, $hPen)'&@CRLF
			Case "E"
				If $hItemSplit[8] <> $hPenSize Then
					If $hItemSplit[8] <> "" Then
						$hPenSize = $hItemSplit[8]
						$CodeTemp &= '_GDIPlus_PenSetWidth( $hPen, '&$hPenSize&")"&@CRLF
					EndIf
				Endif
				If $hItemSplit[6] <> $hLastColor Then
					If $hItemSplit[6] <> "" Then
						$hLastColor = $hItemSplit[6]
						$CodeTemp &= '_GDIPlus_PenSetColor( $hPen, 0x'&$hLastColor&")"&@CRLF
					EndIf
				EndIf
				If $hItemSplit[7] <> $hLastBkColor Then
					If $hItemSplit[7] <> "" Then
						$hLastBkColor = $hItemSplit[7]
						$CodeTemp &= '_GDIPlus_BrushSetSolidColor( $hBrush, 0x'&$hLastBkColor&")"&@CRLF
					EndIf
				EndIf
				If $hItemSplit[6] <> "" and $hItemSplit[7] = "" Then
					$CodeTemp &= '_GDIPlus_GraphicsDrawEllipse( $'&$Names[$hIndex]&', '&$hItemSplit[2]&', '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', $hPen)'&@CRLF
				ElseIf $hItemSplit[6] = "" and $hItemSplit[7] <> "" Then
					$CodeTemp &= '_GDIPlus_GraphicsFillEllipse( $'&$Names[$hIndex]&', '&$hItemSplit[2]&', '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', $hBrush)'&@CRLF
				ElseIf $hItemSplit[6] <> "" and $hItemSplit[7] <> "" Then
					$CodeTemp &= '_GDIPlus_GraphicsFillEllipse( $'&$Names[$hIndex]&', '&$hItemSplit[2]&', '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', $hBrush)'&@CRLF
					$CodeTemp &= '_GDIPlus_GraphicsDrawEllipse( $'&$Names[$hIndex]&', '&$hItemSplit[2]&', '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', $hPen)'&@CRLF
				EndIf
			Case "I"
				If $hItemSplit[2] = "C" Then
					$CodeTemp &= '$hBitMap = _GDIPlus_BitMapCreateFromFile("'&$hItemSplit[2]&':'&$hItemSplit[3]&'")'&@CRLF
					$CodeTemp &= '_GDIPlus_GraphicsDrawImageRect( $'&$Names[$hIndex]&', $hBitMap, '&$hItemSplit[4]&', '&$hItemSplit[5]&', '&$hItemSplit[6]&', '&$hItemSplit[7]&')'&@CRLF
				Else
					$CodeTemp &= '$hBitMap = _GDIPlus_BitMapCreateFromFile('&StringReplace( $hItemSplit[2], "Ñ", ":")&')'&@CRLF
					$CodeTemp &= '_GDIPlus_GraphicsDrawImageRect( $'&$Names[$hIndex]&', $hBitMap, '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', '&$hItemSplit[6]&')'&@CRLF
				EndIf
			Case "L"
				If $hItemSplit[7] <> $hPenSize Then
					$hPenSize = $hItemSplit[7]
					$CodeTemp &= '_GDIPlus_PenSetWidth( $hPen, '&$hPenSize&")"&@CRLF
				Endif
				If $hItemSplit[6] <> $hLastColor Then
					If $hItemSplit[6] <> "" Then
						$hLastColor = $hItemSplit[6]
						$CodeTemp &= '_GDIPlus_PenSetColor( $hPen, 0x'&$hLastColor&")"&@CRLF
					EndIf
				EndIf
				$CodeTemp &= '_GDIPlus_GraphicsDrawLine( $'&$Names[$hIndex]&', '&$hItemSplit[2]&', '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', $hPen)'&@CRLF
			Case "P"
				If $hItemSplit[10] <> $hPenSize Then
					If $hItemSplit[10] <> "" Then
						$hPenSize = $hItemSplit[10]
						$CodeTemp &= '_GDIPlus_PenSetWidth( $hPen, '&$hPenSize&")"&@CRLF
					EndIf
				Endif
				If $hItemSplit[8] <> $hLastColor Then
					If $hItemSplit[8] <> "" Then
						$hLastColor = $hItemSplit[8]
						$CodeTemp &= '_GDIPlus_PenSetColor( $hPen, 0x'&$hLastColor&")"&@CRLF
					EndIf
				EndIf
				If $hItemSplit[9] <> $hLastBkColor Then
					If $hItemSplit[9] <> "" Then
						$hLastBkColor = $hItemSplit[9]
						$CodeTemp &= '_GDIPlus_BrushSetSolidColor( $hBrush, 0x'&$hLastBkColor&")"&@CRLF
					EndIf
				EndIf
				If $hItemSplit[8] <> "" and $hItemSplit[9] = "" Then
					$CodeTemp &= '_GDIPlus_GraphicsDrawPie( $'&$Names[$hIndex]&', '&$hItemSplit[2]&', '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', '&$hItemSplit[6]&', '&$hItemSplit[7]&', $hPen)'&@CRLF
				ElseIf $hItemSplit[8] = "" and $hItemSplit[9] <> "" Then
					$CodeTemp &= '_GDIPlus_GraphicsFillPie( $'&$Names[$hIndex]&', '&$hItemSplit[2]&', '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', '&$hItemSplit[6]&', '&$hItemSplit[7]&', $hBrush)'&@CRLF
				ElseIf $hItemSplit[8] <> "" and $hItemSplit[9] <> "" Then
					$CodeTemp &= '_GDIPlus_GraphicsFillPie( $'&$Names[$hIndex]&', '&$hItemSplit[2]&', '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', '&$hItemSplit[6]&', '&$hItemSplit[7]&', $hBrush)'&@CRLF
					$CodeTemp &= '_GDIPlus_GraphicsDrawPie( $'&$Names[$hIndex]&', '&$hItemSplit[2]&', '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', '&$hItemSplit[6]&', '&$hItemSplit[7]&', $hPen)'&@CRLF
				EndIf
			Case "Po"
				If $hItemSplit[$hItemSplit[0]-1] <> $hPenSize Then
					If $hItemSplit[$hItemSplit[0]-1] <> "" Then
						$hPenSize = $hItemSplit[$hItemSplit[0]-1]
						$CodeTemp &= '_GDIPlus_PenSetWidth( $hPen, '&$hPenSize&")"&@CRLF
					EndIf
				Endif
				If $hItemSplit[$hItemSplit[0]-3] <> $hLastColor Then
					If $hItemSplit[$hItemSplit[0]-3] <> "" Then
						$hLastColor = $hItemSplit[$hItemSplit[0]-3]
						$CodeTemp &= '_GDIPlus_PenSetColor( $hPen, 0x'&$hLastColor&")"&@CRLF
					EndIf
				EndIf
				If $hItemSplit[$hItemSplit[0]-2] <> $hLastBkColor Then
					If $hItemSplit[$hItemSplit[0]-2] <> "" Then
						$hLastBkColor = $hItemSplit[$hItemSplit[0]-2]
						$CodeTemp &= '_GDIPlus_BrushSetSolidColor( $hBrush, 0x'&$hLastBkColor&")"&@CRLF
					EndIf
				EndIf

				Dim $PointNum = 1
				Dim $DeclareString = ""
				Dim $Alternate = True
				For $d = 2 to $hItemSplit[0]-4 Step 1
					If $Alternate = True Then
						$DeclareString &= '$hPolygonPoints['&$PointNum&'][0] = '&$hItemSplit[$d]&@CRLF
						$Alternate = False
					Else
						$DeclareString &= '$hPolygonPoints['&$PointNum&'][1] = '&$hItemSplit[$d]&@CRLF
						$Alternate = True
						$PointNum += 1
					EndIf
				Next

				$CodeTemp &= 'Dim $hPolygonPoints['&$PointNum&'][2]'&@CRLF & _
							 '$hPolygonPoints[0][0] = '&$PointNum-1&@CRLF&$DeclareString


				Dim $hBkFill = $hItemSplit[$hItemSplit[0]-2]
				Dim $hLineColor = $hItemSplit[$hItemSplit[0]-3]
				If $hLineColor <> "" and $hBkFill = "" Then
					$CodeTemp &= '_GDIPlus_GraphicsDrawPolygon( $'&$Names[$hIndex]&', $hPolygonPoints, $hPen)'&@CRLF
				ElseIf $hLineColor = "" and $hBkFill <> "" Then
					$CodeTemp &= '_GDIPlus_GraphicsFillPolygon( $'&$Names[$hIndex]&', $hPolygonPoints, $hBrush)'&@CRLF
				ElseIf $hLineColor <> "" and $hBkFill <> "" Then
					$CodeTemp &= '_GDIPlus_GraphicsFillPolygon( $'&$Names[$hIndex]&', $hPolygonPoints, $hBrush)'&@CRLF
					$CodeTemp &= '_GDIPlus_GraphicsDrawPolygon( $'&$Names[$hIndex]&', $hPolygonPoints, $hPen)'&@CRLF
				EndIf
			Case "R"
				If $hItemSplit[8] <> $hPenSize Then
					If $hItemSplit[8] <> "" Then
						$hPenSize = $hItemSplit[8]
						$CodeTemp &= '_GDIPlus_PenSetWidth( $hPen, '&$hPenSize&")"&@CRLF
					EndIf
				Endif
				If $hItemSplit[6] <> $hLastColor Then
					If $hItemSplit[6] <> "" Then
						$hLastColor = $hItemSplit[6]
						$CodeTemp &= '_GDIPlus_PenSetColor( $hPen, 0x'&$hLastColor&")"&@CRLF
					EndIf
				EndIf
				If $hItemSplit[7] <> $hLastBkColor Then
					If $hItemSplit[7] <> "" Then
						$hLastBkColor = $hItemSplit[7]
						$CodeTemp &= '_GDIPlus_BrushSetSolidColor( $hBrush, 0x'&$hLastBkColor&")"&@CRLF
					EndIf
				EndIf
				If $hItemSplit[6] <> "" and $hItemSplit[7] = "" Then
					$CodeTemp &= '_GDIPlus_GraphicsDrawRect( $'&$Names[$hIndex]&', '&$hItemSplit[2]&', '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', $hPen)'&@CRLF
				ElseIf $hItemSplit[6] = "" and $hItemSplit[7] <> "" Then
					$CodeTemp &= '_GDIPlus_GraphicsFillRect( $'&$Names[$hIndex]&', '&$hItemSplit[2]&', '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', $hBrush)'&@CRLF
				ElseIf $hItemSplit[6] <> "" and $hItemSplit[7] <> "" Then
					$CodeTemp &= '_GDIPlus_GraphicsFillRect( $'&$Names[$hIndex]&', '&$hItemSplit[2]&', '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', $hBrush)'&@CRLF
					$CodeTemp &= '_GDIPlus_GraphicsDrawRect( $'&$Names[$hIndex]&', '&$hItemSplit[2]&', '&$hItemSplit[3]&', '&$hItemSplit[4]&', '&$hItemSplit[5]&', $hPen)'&@CRLF
				EndIf
			Case "S"
				$CodeTemp &= '_GDIPlus_GraphicsDrawString( $'&$Names[$hIndex]&', "'&StringReplace(StringReplace($hItemSplit[4], "å", ";"), "Ñ", ":")&'", '&$hItemSplit[2]&', '&$hItemSplit[3]&', "'&$hItemSplit[5]&'", '&$hItemSplit[6]&')'&@CRLF
			Case "CC"
				If $hItemSplit[$hItemSplit[0]-1] <> $hPenSize Then
					If $hItemSplit[$hItemSplit[0]-1] <> "" Then
						$hPenSize = $hItemSplit[$hItemSplit[0]-1]
						$CodeTemp &= '_GDIPlus_PenSetWidth( $hPen, '&$hPenSize&")"&@CRLF
					EndIf
				Endif
				If $hItemSplit[$hItemSplit[0]-3] <> $hLastColor Then
					If $hItemSplit[$hItemSplit[0]-3] <> "" Then
						$hLastColor = $hItemSplit[$hItemSplit[0]-3]
						$CodeTemp &= '_GDIPlus_PenSetColor( $hPen, 0x'&$hLastColor&")"&@CRLF
					EndIf
				EndIf
				If $hItemSplit[$hItemSplit[0]-2] <> $hLastBkColor Then
					If $hItemSplit[$hItemSplit[0]-2] <> "" Then
						$hLastBkColor = $hItemSplit[$hItemSplit[0]-2]
						$CodeTemp &= '_GDIPlus_BrushSetSolidColor( $hBrush, 0x'&$hLastBkColor&")"&@CRLF
					EndIf
				EndIf

				Dim $PointNum = 1
				Dim $DeclareString = ""
				Dim $Alternate = True
				For $d = 2 to $hItemSplit[0]-4 Step 1
					If $Alternate = True Then
						$DeclareString &= '$hCCurvePoints['&$PointNum&'][0] = '&$hItemSplit[$d]&@CRLF
						$Alternate = False
					Else
						$DeclareString &= '$hCCurvePoints['&$PointNum&'][1] = '&$hItemSplit[$d]&@CRLF
						$Alternate = True
						$PointNum += 1
					EndIf
				Next
				$CodeTemp &= 'Dim $hCCurvePoints['&$PointNum&'][2]'&@CRLF & _
							 '$hCCurvePoints[0][0] = '&$PointNum-1&@CRLF&$DeclareString

				If $hItemSplit[$hItemSplit[0]-3] <> "" and $hItemSplit[$hItemSplit[0]-2] = "" Then
					$CodeTemp &= '_GDIPlus_GraphicsDrawClosedCurve( $'&$Names[$hIndex]&', $hCCurvePoints, $hPen)'&@CRLF
				ElseIf $hItemSplit[$hItemSplit[0]-3] = "" and $hItemSplit[$hItemSplit[0]-2] <> "" Then
					$CodeTemp &= '_GDIPlus_GraphicsFillClosedCurve( $'&$Names[$hIndex]&', $hCCurvePoints, $hBrush)'&@CRLF
				ElseIf $hItemSplit[$hItemSplit[0]-3] <> "" and $hItemSplit[$hItemSplit[0]-2] <> "" Then
					$CodeTemp &= '_GDIPlus_GraphicsFillClosedCurve( $'&$Names[$hIndex]&', $hCCurvePoints, $hBrush)'&@CRLF
					$CodeTemp &= '_GDIPlus_GraphicsDrawClosedCurve( $'&$Names[$hIndex]&', $hCCurvePoints, $hPen)'&@CRLF
				EndIf
		EndSwitch
	Next
	Return $CodeTemp&@CRLF
EndFunc
Func _DrawGDIPlusData( $Index, $hData, $hParentGUI, $AddIcons = False)
	Dim $hWinIndex = $CurrentWindow
	Dim $hLastColor = ""
	Dim $hLastBkColor = ""
	Dim $hPenSize = "1"
	Local $hSplit, $hItemSplit, $hDrawPen, $hDrawBrush
	If $AddIcons = True Then
		Dim $GDITrees[1] = [0]
	EndIf
	For $i = 1 to $GUIHandles[0] Step 1
		If $Parents[$Index] = $GUIHandles[$i] Then
			$hWinIndex = $i
			WinSetState($GUIS[$i], "", @SW_ENABLE)
		EndIf
	Next
	If StringinStr($hData, ";") = False Then
		$hData = $hData&";"
	EndIf
	$hGDIPlusTemp = _GDIPlus_GraphicsCreateFromHWND($hParentGUI)
	$hDrawPen = _GDIPlus_PenCreate('0xFF000000', 1)
	$hDrawBrush = _GDIPlus_BrushCreateSolid(0xFF000000)
	_GDIPlus_GraphicsSetSmoothingMode($hGDIPlusTemp, 2)
	$hSplit = StringSplit($hData, ";")
	For $i = 1 to $hSplit[0] Step 1
		$hItemSplit = StringSplit($hSplit[$i], ":")
		Switch $hItemSplit[1]
			Case "A"
				If $hItemSplit[9] <> $hPenSize Then
					$hPenSize = $hItemSplit[9]
					_GDIPlus_PenSetWidth( $hDrawPen, $hPenSize)
				Endif
				If $hItemSplit[8] <> $hLastColor Then
					$hLastColor = $hItemSplit[8]
					_GDIPlus_PenSetColor( $hDrawPen, '0x'&$hLastColor)
				EndIf
				_GDIPlus_GraphicsDrawArc( $hGDIPlusTemp, $hItemSplit[2], $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hItemSplit[6], $hItemSplit[7], $hDrawPen)
				If $AddIcons = True Then
					_GUICtrlTreeView_BeginUpdate($hTree)
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$Index], "Arc")
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 107)
					_GUICtrlTreeView_EndUpdate($hTree)
					_ArrayAdd($GDITrees, $hItem)
					$GDITrees[0] += 1
				EndIf
			Case "B"
				If $hItemSplit[11] <> $hPenSize Then
					$hPenSize = $hItemSplit[11]
					_GDIPlus_PenSetWidth( $hDrawPen, $hPenSize)
				Endif
				If $hItemSplit[10] <> $hLastColor Then
					$hLastColor = $hItemSplit[10]
					_GDIPlus_PenSetColor( $hDrawPen, '0x'&$hLastColor)
				EndIf
				_GDIPlus_GraphicsDrawBezier( $hGDIPlusTemp, $hItemSplit[2], $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hItemSplit[6], $hItemSplit[7], $hItemSplit[8], $hItemSplit[9], $hDrawPen)
				If $AddIcons = True Then
					_GUICtrlTreeView_BeginUpdate($hTree)
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$Index], "Bezier")
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 98)
					_GUICtrlTreeView_EndUpdate($hTree)
					_ArrayAdd($GDITrees, $hItem)
					$GDITrees[0] += 1
				EndIf
			Case "C"
				If $hItemSplit[$hItemSplit[0]-1] <> $hPenSize Then
					$hPenSize = $hItemSplit[$hItemSplit[0]-1]
					_GDIPlus_PenSetWidth( $hDrawPen, $hPenSize)
				Endif
				If $hItemSplit[$hItemSplit[0]-2] <> $hLastColor Then
					If $hItemSplit[$hItemSplit[0]-2] <> "" Then
						$hLastColor = $hItemSplit[$hItemSplit[0]-2]
						_GDIPlus_PenSetColor( $hDrawPen, '0x'&$hLastColor)
					EndIf
				EndIf
				Dim $hPoints[21][2]
				$hPoints[0][0] = 20
				$hPoints[1][0] = 0
				$hPoints[1][1] = 0
				$hPoints[2][0] = 0
				$hPoints[2][1] = 0
				$hPoints[3][0] = 0
				$hPoints[3][1] = 0
				$hPoints[4][0] = 0
				$hPoints[4][1] = 0
				$hPoints[5][0] = 0
				$hPoints[5][1] = 0
				$hPoints[6][0] = 0
				$hPoints[6][1] = 0
				$hPoints[7][0] = 0
				$hPoints[7][1] = 0
				$hPoints[8][0] = 0
				$hPoints[8][1] = 0
				$hPoints[9][0] = 0
				$hPoints[9][1] = 0
				$hPoints[10][0] = 0
				$hPoints[10][1] = 0
				$hPoints[11][0] = 0
				$hPoints[11][1] = 0
				$hPoints[12][0] = 0
				$hPoints[12][1] = 0
				$hPoints[13][0] = 0
				$hPoints[13][1] = 0
				$hPoints[14][0] = 0
				$hPoints[14][1] = 0
				$hPoints[15][0] = 0
				$hPoints[15][1] = 0
				$hPoints[16][0] = 0
				$hPoints[16][1] = 0
				$hPoints[17][0] = 0
				$hPoints[17][1] = 0
				$hPoints[18][0] = 0
				$hPoints[18][1] = 0
				$hPoints[19][0] = 0
				$hPoints[19][1] = 0
				$hPoints[20][0] = 0
				$hPoints[20][1] = 0
				Dim $PointNum = 1
				Dim $DeclareString = ""
				Dim $Alternate = True
				For $d = 2 to $hItemSplit[0]-3 Step 1
					If $Alternate = True Then
						$hPoints[$PointNum][0] = $hItemSplit[$d]
						$LastCtrlX = $hItemSplit[$d]
						$Alternate = False
					Else
						$hPoints[$PointNum][1] = $hItemSplit[$d]
						$LastCtrlY = $hItemSplit[$d]
						$Alternate = True
						$PointNum += 1
					EndIf
				Next
				For $d = $PointNum to 20 Step 1
					$hPoints[$d][0] = $LastCtrlX
					$hPoints[$d][1] = $LastCtrlY
				Next
				_GDIPlus_GraphicsDrawCurve( $hGDIPlusTemp, $hPoints, $hDrawPen)
				If $AddIcons = True Then
					_GUICtrlTreeView_BeginUpdate($hTree)
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$Index], "Curve")
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 108)
					_GUICtrlTreeView_EndUpdate($hTree)
					_ArrayAdd($GDITrees, $hItem)
					$GDITrees[0] += 1
				EndIf
			Case "E"
				If $hItemSplit[8] <> $hPenSize Then
					If $hItemSplit[8] <> "" Then
						$hPenSize = $hItemSplit[8]
						_GDIPlus_PenSetWidth( $hDrawPen, $hPenSize)
					EndIf
				Endif
				If $hItemSplit[6] <> $hLastColor Then
					If $hItemSplit[6] <> "" Then
						$hLastColor = $hItemSplit[6]
						_GDIPlus_PenSetColor( $hDrawPen, '0x'&$hLastColor)
					EndIf
				EndIf
				If $hItemSplit[7] <> $hLastBkColor Then
					If $hItemSplit[7] <> "" Then
						$hLastBkColor = $hItemSplit[7]
						_GDIPlus_BrushSetSolidColor( $hDrawBrush, '0x'&$hLastBkColor)
					EndIf
				EndIf
				If $hItemSplit[6] <> "" and $hItemSplit[7] = "" Then
					_GDIPlus_GraphicsDrawEllipse( $hGDIPlusTemp, $hItemSplit[2], $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hDrawPen)
				ElseIf $hItemSplit[6] = "" and $hItemSplit[7] <> "" Then
					_GDIPlus_GraphicsFillEllipse( $hGDIPlusTemp, $hItemSplit[2], $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hDrawBrush)
				ElseIf $hItemSplit[6] <> "" and $hItemSplit[7] <> "" Then
					_GDIPlus_GraphicsFillEllipse( $hGDIPlusTemp, $hItemSplit[2], $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hDrawBrush)
					_GDIPlus_GraphicsDrawEllipse( $hGDIPlusTemp, $hItemSplit[2], $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hDrawPen)
				EndIf
				If $AddIcons = True Then
					_GUICtrlTreeView_BeginUpdate($hTree)
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$Index], "Ellipse")
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 100)
					_GUICtrlTreeView_EndUpdate($hTree)
					_ArrayAdd($GDITrees, $hItem)
					$GDITrees[0] += 1
				EndIf
			Case "I"
				If $hItemSplit[2] = "C" Then
					$hBitMap = _GDIPlus_BitMapCreateFromFile($hItemSplit[2]&':'&$hItemSplit[3])
					_GDIPlus_GraphicsDrawImageRect( $hGDIPlusTemp, $hBitMap, $hItemSplit[4], $hItemSplit[5], $hItemSplit[6], $hItemSplit[7])
				Else
					$hBitMap = _GDIPlus_BitMapCreateFromFile(StringReplace($hItemSplit[2], "Ñ", ":"))
					_GDIPlus_GraphicsDrawImageRect( $hGDIPlusTemp, $hBitMap, $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hItemSplit[6])
				EndIf
				_GDIPlus_BitMapDispose($hBitMap)
				If $AddIcons = True Then
					_GUICtrlTreeView_BeginUpdate($hTree)
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$Index], "Image")
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 26)
					_GUICtrlTreeView_EndUpdate($hTree)
					_ArrayAdd($GDITrees, $hItem)
					$GDITrees[0] += 1
				EndIf
			Case "L"
				If $hItemSplit[7] <> $hPenSize Then
					$hPenSize = $hItemSplit[7]
					_GDIPlus_PenSetWidth( $hDrawPen, $hPenSize)
				Endif
				If $hItemSplit[6] <> $hLastColor Then
					If $hItemSplit[6] <> "" Then
						$hLastColor = $hItemSplit[6]
						_GDIPlus_PenSetColor( $hDrawPen, '0x'&$hLastColor)
					EndIf
				EndIf
				_GDIPlus_GraphicsDrawLine( $hGDIPlusTemp, $hItemSplit[2], $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hDrawPen)
				If $AddIcons = True Then
					_GUICtrlTreeView_BeginUpdate($hTree)
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$Index], "Line")
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 97)
					_GUICtrlTreeView_EndUpdate($hTree)
					_ArrayAdd($GDITrees, $hItem)
					$GDITrees[0] += 1
				EndIf
			Case "P"
				If $hItemSplit[10] <> $hPenSize Then
					If $hItemSplit[10] <> "" Then
						$hPenSize = $hItemSplit[10]
						_GDIPlus_PenSetWidth( $hDrawPen, $hPenSize)
					EndIf
				Endif
				If $hItemSplit[8] <> $hLastColor Then
					If $hItemSplit[8] <> "" Then
						$hLastColor = $hItemSplit[8]
						_GDIPlus_PenSetColor( $hDrawPen, '0x'&$hLastColor)
					EndIf
				EndIf
				If $hItemSplit[9] <> $hLastBkColor Then
					If $hItemSplit[9] <> "" Then
						$hLastBkColor = $hItemSplit[9]
						_GDIPlus_BrushSetSolidColor( $hDrawBrush, '0x'&$hLastBkColor)
					EndIf
				EndIf
				If $hItemSplit[8] <> "" and $hItemSplit[9] = "" Then
					_GDIPlus_GraphicsDrawPie( $hGDIPlusTemp, $hItemSplit[2], $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hItemSplit[6], $hItemSplit[7], $hDrawPen)
				ElseIf $hItemSplit[8] = "" and $hItemSplit[9] <> "" Then
					_GDIPlus_GraphicsFillPie( $hGDIPlusTemp, $hItemSplit[2], $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hItemSplit[6], $hItemSplit[7], $hDrawBrush)
				ElseIf $hItemSplit[8] <> "" and $hItemSplit[9] <> "" Then
					_GDIPlus_GraphicsFillPie( $hGDIPlusTemp, $hItemSplit[2], $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hItemSplit[6], $hItemSplit[7], $hDrawBrush)
					_GDIPlus_GraphicsDrawPie( $hGDIPlusTemp, $hItemSplit[2], $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hItemSplit[6], $hItemSplit[7], $hDrawPen)
				EndIf
				If $AddIcons = True Then
					_GUICtrlTreeView_BeginUpdate($hTree)
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$Index], "Pie")
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 101)
					_GUICtrlTreeView_EndUpdate($hTree)
					_ArrayAdd($GDITrees, $hItem)
					$GDITrees[0] += 1
				EndIf
			Case "Po"
				If $hItemSplit[$hItemSplit[0]-1] <> $hPenSize Then
					If $hItemSplit[$hItemSplit[0]-1] <> "" Then
						$hPenSize = $hItemSplit[$hItemSplit[0]-1]
						_GDIPlus_PenSetWidth( $hDrawPen, $hPenSize)
					EndIf
				Endif
				If $hItemSplit[$hItemSplit[0]-3] <> $hLastColor Then
					If $hItemSplit[$hItemSplit[0]-3] <> "" Then
						$hLastColor = $hItemSplit[$hItemSplit[0]-3]
						_GDIPlus_PenSetColor( $hDrawPen, '0x'&$hLastColor)
					EndIf
				EndIf
				If $hItemSplit[$hItemSplit[0]-2] <> $hLastBkColor Then
					If $hItemSplit[$hItemSplit[0]-2] <> "" Then
						$hLastBkColor = $hItemSplit[$hItemSplit[0]-2]
						_GDIPlus_BrushSetSolidColor( $hDrawBrush, '0x'&$hLastBkColor)
					EndIf
				EndIf
				Dim $hPoints[21][2]
				$hPoints[0][0] = 20
				$hPoints[1][0] = 0
				$hPoints[1][1] = 0
				$hPoints[2][0] = 0
				$hPoints[2][1] = 0
				$hPoints[3][0] = 0
				$hPoints[3][1] = 0
				$hPoints[4][0] = 0
				$hPoints[4][1] = 0
				$hPoints[5][0] = 0
				$hPoints[5][1] = 0
				$hPoints[6][0] = 0
				$hPoints[6][1] = 0
				$hPoints[7][0] = 0
				$hPoints[7][1] = 0
				$hPoints[8][0] = 0
				$hPoints[8][1] = 0
				$hPoints[9][0] = 0
				$hPoints[9][1] = 0
				$hPoints[10][0] = 0
				$hPoints[10][1] = 0
				$hPoints[11][0] = 0
				$hPoints[11][1] = 0
				$hPoints[12][0] = 0
				$hPoints[12][1] = 0
				$hPoints[13][0] = 0
				$hPoints[13][1] = 0
				$hPoints[14][0] = 0
				$hPoints[14][1] = 0
				$hPoints[15][0] = 0
				$hPoints[15][1] = 0
				$hPoints[16][0] = 0
				$hPoints[16][1] = 0
				$hPoints[17][0] = 0
				$hPoints[17][1] = 0
				$hPoints[18][0] = 0
				$hPoints[18][1] = 0
				$hPoints[19][0] = 0
				$hPoints[19][1] = 0
				$hPoints[20][0] = 0
				$hPoints[20][1] = 0
				Dim $PointNum = 1
				Dim $DeclareString = ""
				Dim $Alternate = True
				For $d = 2 to $hItemSplit[0]-4 Step 1
					If $Alternate = True Then
						$hPoints[$PointNum][0] = $hItemSplit[$d]
						$LastCtrlX = $hItemSplit[$d]
						$Alternate = False
					Else
						$hPoints[$PointNum][1] = $hItemSplit[$d]
						$LastCtrlY = $hItemSplit[$d]
						$Alternate = True
						$PointNum += 1
					EndIf
				Next
				For $d = $PointNum to 20 Step 1
					$hPoints[$d][0] = $LastCtrlX
					$hPoints[$d][1] = $LastCtrlY
				Next
				If $hItemSplit[$hItemSplit[0]-3] <> "" and $hItemSplit[$hItemSplit[0]-2] = "" Then
					_GDIPlus_GraphicsDrawPolygon( $hGDIPlusTemp, $hPoints, $hDrawPen)
				ElseIf $hItemSplit[$hItemSplit[0]-3] = "" and $hItemSplit[$hItemSplit[0]-2] <> "" Then
					_GDIPlus_GraphicsFillPolygon( $hGDIPlusTemp, $hPoints, $hDrawBrush)
				ElseIf $hItemSplit[$hItemSplit[0]-3] <> "" and $hItemSplit[$hItemSplit[0]-2] <> "" Then
					_GDIPlus_GraphicsFillPolygon( $hGDIPlusTemp, $hPoints, $hDrawBrush)
					_GDIPlus_GraphicsDrawPolygon( $hGDIPlusTemp, $hPoints, $hDrawPen)
				EndIf
				If $AddIcons = True Then
					_GUICtrlTreeView_BeginUpdate($hTree)
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$Index], "Polygon")
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 109)
					_GUICtrlTreeView_EndUpdate($hTree)
					_ArrayAdd($GDITrees, $hItem)
					$GDITrees[0] += 1
				EndIf
			Case "R"
				If $hItemSplit[8] <> $hPenSize Then
					If $hItemSplit[8] <> "" Then
						$hPenSize = $hItemSplit[8]
						_GDIPlus_PenSetWidth( $hDrawPen, $hPenSize)
					EndIf
				Endif
				If $hItemSplit[6] <> $hLastColor Then
					If $hItemSplit[6] <> "" Then
						$hLastColor = $hItemSplit[6]
						_GDIPlus_PenSetColor( $hDrawPen, '0x'&$hLastColor)
					EndIf
				EndIf
				If $hItemSplit[7] <> $hLastBkColor Then
					If $hItemSplit[7] <> "" Then
						$hLastBkColor = $hItemSplit[7]
						_GDIPlus_BrushSetSolidColor( $hDrawBrush, '0x'&$hLastBkColor)
					EndIf
				EndIf
				If $hItemSplit[6] <> "" and $hItemSplit[7] = "" Then
					_GDIPlus_GraphicsDrawRect( $hGDIPlusTemp, $hItemSplit[2], $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hDrawPen)
				ElseIf $hItemSplit[6] = "" and $hItemSplit[7] <> "" Then
					_GDIPlus_GraphicsFillRect( $hGDIPlusTemp, $hItemSplit[2], $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hDrawBrush)
				ElseIf $hItemSplit[6] <> "" and $hItemSplit[7] <> "" Then
					_GDIPlus_GraphicsFillRect( $hGDIPlusTemp, $hItemSplit[2], $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hDrawBrush)
					_GDIPlus_GraphicsDrawRect( $hGDIPlusTemp, $hItemSplit[2], $hItemSplit[3], $hItemSplit[4], $hItemSplit[5], $hDrawPen)
				EndIf
				If $AddIcons = True Then
					_GUICtrlTreeView_BeginUpdate($hTree)
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$Index], "Rectangle")
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 99)
					_GUICtrlTreeView_EndUpdate($hTree)
					_ArrayAdd($GDITrees, $hItem)
					$GDITrees[0] += 1
				EndIf
			Case "S"
				_GDIPlus_GraphicsDrawString( $hGDIPlusTemp, StringReplace(StringReplace($hItemSplit[4], "å", ";"), "Ñ", ":"), $hItemSplit[2], $hItemSplit[3], $hItemSplit[5], $hItemSplit[6])
				If $AddIcons = True Then
					_GUICtrlTreeView_BeginUpdate($hTree)
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$Index], "String")
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 21)
					_GUICtrlTreeView_EndUpdate($hTree)
					_ArrayAdd($GDITrees, $hItem)
					$GDITrees[0] += 1
				EndIf
			Case "CC"
				If $hItemSplit[$hItemSplit[0]-1] <> $hPenSize Then
					If $hItemSplit[$hItemSplit[$hItemSplit[0]-1]] <> "" Then
						$hPenSize = $hItemSplit[$hItemSplit[0]-1]
						_GDIPlus_PenSetWidth( $hDrawPen, $hPenSize)
					EndIf
				Endif
				If $hItemSplit[$hItemSplit[0]-3] <> $hLastColor Then
					If $hItemSplit[$hItemSplit[0]-3] <> "" Then
						$hLastColor = $hItemSplit[$hItemSplit[0]-3]
						_GDIPlus_PenSetColor( $hDrawPen, '0x'&$hLastColor)
					EndIf
				EndIf
				If $hItemSplit[$hItemSplit[0]-2] <> $hLastBkColor Then
					If $hItemSplit[$hItemSplit[0]-2] <> "" Then
						$hLastBkColor = $hItemSplit[$hItemSplit[0]-2]
						_GDIPlus_BrushSetSolidColor( $hDrawBrush, '0x'&$hLastBkColor)
					EndIf
				EndIf
				Dim $hPoints[21][2]
				$hPoints[0][0] = 20
				$hPoints[1][0] = 0
				$hPoints[1][1] = 0
				$hPoints[2][0] = 0
				$hPoints[2][1] = 0
				$hPoints[3][0] = 0
				$hPoints[3][1] = 0
				$hPoints[4][0] = 0
				$hPoints[4][1] = 0
				$hPoints[5][0] = 0
				$hPoints[5][1] = 0
				$hPoints[6][0] = 0
				$hPoints[6][1] = 0
				$hPoints[7][0] = 0
				$hPoints[7][1] = 0
				$hPoints[8][0] = 0
				$hPoints[8][1] = 0
				$hPoints[9][0] = 0
				$hPoints[9][1] = 0
				$hPoints[10][0] = 0
				$hPoints[10][1] = 0
				$hPoints[11][0] = 0
				$hPoints[11][1] = 0
				$hPoints[12][0] = 0
				$hPoints[12][1] = 0
				$hPoints[13][0] = 0
				$hPoints[13][1] = 0
				$hPoints[14][0] = 0
				$hPoints[14][1] = 0
				$hPoints[15][0] = 0
				$hPoints[15][1] = 0
				$hPoints[16][0] = 0
				$hPoints[16][1] = 0
				$hPoints[17][0] = 0
				$hPoints[17][1] = 0
				$hPoints[18][0] = 0
				$hPoints[18][1] = 0
				$hPoints[19][0] = 0
				$hPoints[19][1] = 0
				$hPoints[20][0] = 0
				$hPoints[20][1] = 0
				Dim $PointNum = 1
				Dim $DeclareString = ""
				Dim $Alternate = True
				For $d = 2 to $hItemSplit[0]-4 Step 1
					If $Alternate = True Then
						$hPoints[$PointNum][0] = $hItemSplit[$d]
						$LastCtrlX = $hItemSplit[$d]
						$Alternate = False
					Else
						$hPoints[$PointNum][1] = $hItemSplit[$d]
						$LastCtrlY = $hItemSplit[$d]
						$Alternate = True
						$PointNum += 1
					EndIf
				Next
				For $d = $PointNum to 20 Step 1
					$hPoints[$d][0] = $LastCtrlX
					$hPoints[$d][1] = $LastCtrlY
				Next
				If $hItemSplit[$hItemSplit[0]-3] <> "" and $hItemSplit[$hItemSplit[0]-2] = "" Then
					_GDIPlus_GraphicsDrawClosedCurve( $hGDIPlusTemp, $hPoints, $hDrawPen)
				ElseIf $hItemSplit[$hItemSplit[0]-3] = "" and $hItemSplit[$hItemSplit[0]-2] <> "" Then
					_GDIPlus_GraphicsFillClosedCurve( $hGDIPlusTemp, $hPoints, $hDrawBrush)
				ElseIf $hItemSplit[$hItemSplit[0]-3] <> "" and $hItemSplit[$hItemSplit[0]-2] <> "" Then
					_GDIPlus_GraphicsFillClosedCurve( $hGDIPlusTemp, $hPoints, $hDrawBrush)
					_GDIPlus_GraphicsDrawClosedCurve( $hGDIPlusTemp, $hPoints, $hDrawPen)
				EndIf
				If $AddIcons = True Then
					_GUICtrlTreeView_BeginUpdate($hTree)
					$hItem = _GUICtrlTreeView_AddChild($hTree, $TreeItems[$Index], "Closed Curve")
					_GUICtrlTreeView_SetIcon($hTree, $hItem, @ScriptDir&"\Resources.dll", 110)
					_GUICtrlTreeView_EndUpdate($hTree)
					_ArrayAdd($GDITrees, $hItem)
					$GDITrees[0] += 1
				EndIf
		EndSwitch
	Next
	_GDIPlus_PenDispose($hDrawPen)
	_GDIPlus_BrushDispose($hDrawBrush)
	_GDIPlus_GraphicsDispose($hGDIPlusTemp)
EndFunc
Func _DrawGDIPoint( $pX, $pY)
	$hPenWidth = _GDIPlus_PenGetWidth($hGDIPen)
	$hPenRead = _GDIPlus_PenGetColor($hGDIPen)
	$hBrushRead = _GDIPlus_BrushGetSolidColor($hGDIBrush)
	_GDIPlus_PenSetColor($hGDIPen, "0xFF000000")
	_GDIPlus_PenSetWidth($hGDIPen, 1)
	_GDIPlus_BrushSetSolidColor($hGDIBrush, "0xFFFF0000")
	_GDIPlus_GraphicsFillEllipse($hGDIPlus, $pX-4, $pY-4, 9, 9, $hGDIBrush)
	_GDIPlus_GraphicsDrawEllipse($hGDIPlus, $pX-4, $pY-4, 9, 9, $hGDIPen)
	_GDIPlus_PenSetWidth($hGDIPen, $hPenWidth)
	_GDIPlus_PenSetColor($hGDIPen, $hPenRead)
	_GDIPlus_BrushSetSolidColor($hGDIBrush, $hBrushRead)
EndFunc
Func _KeyProc($nCode, $wParam, $lParam)
	Local $tKEYHOOKS
	$tKEYHOOKS = DllStructCreate($tagKBDLLHOOKSTRUCT, $lParam)
	If $nCode < 0 Then
		Return _WinAPI_CallNextHookEx($hHook, $nCode, $wParam, $lParam)
	EndIf
	Local $flags = DllStructGetData($tKEYHOOKS, "flags")
	Switch $flags
		Case $LLKHF_UP
			$hKeyTimer = TimerInit()
	EndSwitch
	Return _WinAPI_CallNextHookEx($hHook, $nCode, $wParam, $lParam)
EndFunc   ;==>_KeyProc

Func _SetRESHAutoItColors()
    ; These are not required but it's easier to use enum when associating the array element numbers to the color meanings.
    Local Enum $iMacros, $iStrings, $iSpecial, $iComments, $iVariables, $iOperators, $iNumbers, $iKeywords, _
            $iUDFs, $iSendKeys, $iFunctions, $iPreProc, $iComObjects

    ; Declare 13 element array.
    Local $aColorTable[13]

    ; Values can use # or 0x.
    $aColorTable[$iMacros] = '#808000'
    $aColorTable[$iStrings] = 0xFF0000
    $aColorTable[$iSpecial] = '#DC143C'
    $aColorTable[$iComments] = '#008000'
    $aColorTable[$iVariables] = '#5A5A5A'
    $aColorTable[$iOperators] = '#FF8000'
    $aColorTable[$iNumbers] = 0x0000FF
    $aColorTable[$iKeywords] = '#0000FF'
    $aColorTable[$iUDFs] = '#0080FF'
    $aColorTable[$iSendKeys] = '#808080'
    $aColorTable[$iFunctions] = '#000090'
    $aColorTable[$iPreProc] = '#808000'
    $aColorTable[$iComObjects] = 0x993399

    _RESH_SetColorTable($aColorTable)
EndFunc   ;==>_SetRESHAutoItColors

Func _SetRESHDefaultColors()
    ; These are not required but it's easier to use enum when associating the array element numbers to the color meanings.
    Local Enum $iMacros, $iStrings, $iSpecial, $iComments, $iVariables, $iOperators, $iNumbers, $iKeywords, _
            $iUDFs, $iSendKeys, $iFunctions, $iPreProc, $iComObjects

    ; Declare 13 element array.
    Local $aColorTable[13]

    ; Values can use # or 0x.
    $aColorTable[$iMacros] = 0xF000FF
    $aColorTable[$iStrings] = 0x9999CC
    $aColorTable[$iSpecial] = 0xA00FF0
    $aColorTable[$iComments] = 0x009933
    $aColorTable[$iVariables] = 0xAA0000
    $aColorTable[$iOperators] = 0xFF0000
    $aColorTable[$iNumbers] = 0xAC00A9
    $aColorTable[$iKeywords] = 0x0000FF
    $aColorTable[$iUDFs] = 0x0080FF
    $aColorTable[$iSendKeys] = 0xFF8800
    $aColorTable[$iFunctions] = 0x000090
    $aColorTable[$iPreProc] = 0xF000FF
    $aColorTable[$iComObjects] = 0x0000FF

    _RESH_SetColorTable($aColorTable)
EndFunc   ;==>_SetRESHAutoItColors