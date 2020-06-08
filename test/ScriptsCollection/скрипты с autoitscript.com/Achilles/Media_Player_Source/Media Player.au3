#Region *** INCLUDES and GLOBAL VARIABLES ***
#AutoIt3Wrapper_Version=beta
#AutoIt3Wrapper_icon=Knight.ico
#NoTrayIcon
#Include <Array.au3>
#include <ComboConstants.au3>
#include <Constants.au3>
#include <EditConstants.au3>
#Include <File.au3>
#include <GUIConstantsEx.au3>
#Include <GuiListBox.au3>
#include <GuiListView.au3>
#include <Helper Functions.au3>
#include <Inet.au3>
#include <Misc.au3>
#include <ProgressConstants.au3>
#Include <SendMessage.au3>
#include <SliderConstants.au3>
#include <Sound.au3>
#include <GuiSlider.au3>
#include <StaticConstants.au3>
#include <String.au3>
#include <Timers.au3>
#include <UpdownConstants.au3>
#Include <WinAPI.au3>
#include <WindowsConstants.au3>

Global Const $NAME = 'KMP'
If _Singleton($NAME, 1) = 0 then 
	WinActivate('KMP')
	Exit 
EndIf

Global Const $VERSION = 0.6
Global Const $PROGRAM_MANGAGER = 'Program Manager'
Global Const $NUM_COLUMNS = 12

Global Const $TRACK_NAME = 0, $TRACK_SIZE = 1, $TRACK_TYPE = 2, $TRACK_ARTIST = 3, $TRACK_ALBUM = 4, $TRACK_YEAR = 5, _
	$TRACK_GENRE = 6, $TRACK_TITLE = 7, $TRACK_NUMBER = 8, $TRACK_LENGTH = 9, $TRACK_PATH = 10, $TRACK_PLAYING = 11
Global Const $COLUMN_NAMES[12] = ['File Name', 'Size', 'Type', 'Artist', 'Album', 'Year', 'Genre', 'Title', 'Track #', 'Length', 'Full Path', 'Playing']

Global Const $HOTKEYPLAYPAUSE = 0, $HOTKEYNEXT = 1, $HOTKEYBACK = 2, $HOTKEYSTOP = 3, _
	$HOTKEYRANDOM = 4, $HOTKEYOPTIONS = 5, $HOTKEYVOLUMEUP = 6, $HOTKEYVOLUMEDOWN = 7, _
	$HOTKEYMUTE = 8, $HOTKEYREMOVEDUPS = 9

Global Const $DEFAULT_COLUMN = '0.Playing.55|1.Track #.55|2.Length.60|3.Title.180|4.Album.180|5.Artist.180'



Opt('GUIOnEventMode', 1)

;~ HotKeySet('`', '_DisplayHotkeys')

HotKeySet('{DEL}', '_ClearHotkey')
HotKeySet('^a', '_SelectAllHotkey')

Global $nowPlaying[1][$NUM_COLUMNS]

Global $hotkeys[10][5] = [['Play/Pause', '', '', '', ''], ['Next', '', '', '', ''], ['Back', '', '', '', ''], _
	['Stop', '', '', '', ''], ['Random', '', '', '', ''], ['Options', '', '', '', ''], ['Volume Up', '', '', '', ''], _
	['Volume Down', '', '', '', ''], ['Mute', '', '', '', ''], ['Remove Duplicates', '', '', '', '']]

Global $shuffle = False ; False = no shuffle, True = shuffle
Global $upDisabled = False, $backDisabled = True ; The button on top of the folders list, the back button
Global $seeking = False ; The user is adjusting the seek position
Global $previewPath = '' ; The path to the files that are being displayed in the "Available" list
Global $labels[12]; Used for settings the text colors of labels
Global $notiGUI, $notiLabels[6], $notiShowing, $notiTimer;
Global $importDisplayList[1] = [0]

Global $lstNowplaying, $lstNowPlayingHwnd, $lstNowPlayerHeading
Global $rejGUI ; The GUI for the items that couldn't be added

Global $currentTrackID, $currentSongLength, $currentSongDuration, $currentSongPath, $currentData[3], $currentTimer
Global $currentID ; Used by _GUICtrlListView_MapIdToIndex and the reverse
Global $currentlyPlaying = 0 ; 0 = Stop, 1 = Play, 2 = Pause
Global $playedItems[1] = [0]; an array of all items that have been played

Global $columnWidths[$NUM_COLUMNS] = [180, 70, 150, 50, 150, 50, 100, 180, 55, 50, 200, 55]
Global $colorChoices = 'Black|Blue|Dark Blue|Gray and Blue|Gray and Orange|Purple|Red|Turquoise'


; Data read from the Registry
Global $settingsHistory = RegRead('HKEY_CURRENT_USER\Software\KMP', 'Settings')
If $settingsHistory = '' then $settingsHistory = @TempDir ; The directory where the settings are stored
$settingsPosition = $settingsHistory & '\' & $NAME

; Settings read from the Ini file
$tempOrder = IniRead($settingsPosition & '\Settings.ini', 'Column', 'Order', $DEFAULT_COLUMN)

Global $columnStatus[$NUM_COLUMNS][3] = [[$TRACK_NAME, 0, 'File Name'], [$TRACK_SIZE, 0, 'Size'], _
	[$TRACK_TYPE, 0, 'Type'], [$TRACK_ARTIST, 0, 'Artist'], [$TRACK_ALBUM, 0, 'Album'], [$TRACK_YEAR, 0, 'Year'], _
	[$TRACK_GENRE, 0, 'Genre'], [$TRACK_TITLE, 0, 'Title'], [$TRACK_NUMBER, 0, 'Track #'], _
	[$TRACK_LENGTH, 0, 'Length'], [$TRACK_PATH, 0, 'Path'], [$TRACK_PLAYING, 0, 'Playing']]
GLobal $columnInitOrder = ''	

Global $playingShowing = False ; The column that will have a > next to the song that is playing

ConsoleWrite('+> $tempOrder = ' & $tempOrder & @CRLF)

;~ $tempOrder = $DEFAULT_COLUMN
$split = StringSplit($tempOrder, '|')
$numColsShowing = 0
;~ _ArrayDisplay($split)
For $i = 1 to $split[0]
	$tempSplit = StringSplit($split[$i], '.') ;7.0.File Name
;~ 	$tempIndex = _GetIndexFromName($tempSplit[0])
	$index = _GetIndexFromName($tempSplit[2])
;~ 	Msgbox(0, $index, $tempSplit[1] & @CRLF & $tempSplit[2])
;~ 	Msgbox(0, '', $tempSplit[1])
	

	If $tempSplit[2] <> '' then 
;~ 		Msgbox(0, '', $tempSplit[1])
		If $tempSplit[2] = 'Playing' then $playingShowing = True 
		
		$columnInitOrder &= $tempSplit[1] & '|'
		
		$columnWidths[$index] = $tempSplit[3]
		$columnStatus[$index][1] = 1
;~ 		$columnsShowing[$numColsShowing] = $tempIndex
		$numColsShowing += 1				
	EndIf
Next

;~ _ArrayDisplay($columnsAddOrder)
$columnInitOrder = StringTrimRight($columnInitOrder, 1)
;~ Msgbox(0, '', $columnInitOrder)

Global $colorsBK = IniRead($settingsPosition & '\Settings.ini', 'Colors', 'Background', 0x282828)
Global $colorsText = IniRead($settingsPosition & '\Settings.ini', 'Colors', 'Text', 0xBFBFFF)
Global $colorsAlt = IniRead($settingsPosition & '\Settings.ini', 'Colors', 'Alt', 0xE1E1FF)
Global $colorsString = IniRead($settingsPosition & '\Settings.ini', 'Colors', 'String', 'Gray and Blue')
Global $colorsAltEnabled = _StrToBool(IniRead($settingsPosition & '\Settings.ini', 'Colors', 'AltEnabled', True))
Global $importDisplay = _StrToBool(IniRead($settingsPosition & '\Settings.ini', 'Import', 'Display', False))
Global $importDup = _StrToBool(IniRead($settingsPosition & '\Settings.ini', 'Import', 'Duplicates', False))
Global $notificationEnabled = _StrToBool(IniRead($settingsPosition & '\Settings.ini', 'Notification', 'Enabled', False))
Global $notificationFullScreen = _StrToBool(IniRead($settingsPosition & '\Settings.ini', 'Notification', 'FullScreen', False))
Global $notificationAbove = _StrToBool(IniRead($settingsPosition & '\Settings.ini', 'Notification', 'Above', True))
Global $notificationTime = IniRead($settingsPosition & '\Settings.ini', 'Notification', 'Time', 4)
Global $notificationX = IniRead($settingsPosition & '\Settings.ini', 'Notification', 'X', -1)
Global $notificationY = IniRead($settingsPosition & '\Settings.ini', 'Notification', 'Y', -1)
Global $settingsMusicInit = IniRead($settingsPosition & '\Settings.ini', 'Settings', 'Music', _GetMusicDir())
Global $settingsMusic = $settingsMusicInit
;~ Global $settingsMSN = _StrToBool(IniRead($settingsPosition & '\Settings.ini', 'Settings', 'MSN', False))
Global $startupPickup = _StrToBool(IniRead($settingsPosition & '\Settings.ini', 'Startup', 'Pickup', False))
Global $startupWindows = _StrToBool(IniRead($settingsPosition & '\Settings.ini', 'Startup', 'Windows', False))
Global $startupUpdates = _StrToBool(IniRead($settingsPosition & '\Settings.ini', 'Startup', 'Updates', True))
Global $windowTransEnabled = _StrToBool(IniRead($settingsPosition & '\Settings.ini', 'Window', 'Pickup', False))
Global $windowTrans = IniRead($settingsPosition & '\Settings.ini', 'Window', 'Trans', 30)

Global $mainX = IniRead($settingsPosition & '\Settings.ini', 'Window', 'MainX', 10)
Global $mainY = IniRead($settingsPosition & '\Settings.ini', 'Window', 'MainY', 10)
Global $addX = IniRead($settingsPosition & '\Settings.ini', 'Window', 'AddX', 50)
Global $addY = IniRead($settingsPosition & '\Settings.ini', 'Window', 'AddY', 50)
Global $nowPlayingX = IniRead($settingsPosition & '\Settings.ini', 'Window', 'NowPlayingX', 90)
Global $nowPlayingY = IniRead($settingsPosition & '\Settings.ini', 'Window', 'NowPlayingY', 90)	
GLobal $windowWidth = IniRead($settingsPosition & '\Settings.ini', 'Window', 'Width', 700)
Global $windowHeight = IniRead($settingsPosition & '\Settings.ini', 'Window', 'Height', 300)
Global $startAdd = _StrToBool(IniRead($settingsPosition & '\Settings.ini', 'Window', 'AddShow', True))
Global $startNP = _StrToBool(IniRead($settingsPosition & '\Settings.ini', 'Window', 'NPShow', True))
Global $startBig = _StrToBool(IniRead($settingsPosition & '\Settings.ini', 'Window', 'MainBig', True))

;Temporary Settings for the GUI (all changes are applied when the user exits
Global $tempColorsBK , $tempColorsText, $tempColorsAlt, $tempColorsAltEnabled, $tempColorsString
Global $tempColumnsToAdd[1], $tempColumnsToRemove[1], $tempColumnsNumShowing
Global $tempImportDisplay, $tempImportDup
Global $tempNotificationEnabled, $tempNotificationFullScreen, $tempNotificationAbove
Global $tempNotificationTime, $tempNotificationX, $tempNotificationY 
Global $tempSettingsMusicInit, $tempSettingsHistory ;, $tempSettingsMSN
Global $tempStartupPickup, $tempStartupWindows, $tempStartupUpdates
Global $tempWindowTransEnabled, $tempWindowTrans;, $tempWindowHeight

; Global Varibales for Options
Global $optionsGUI, $notificationGUI, $lstMenu, $lstMenuHwnd, $lblCurrent
Global $tempHwnd, $tempHwndHeader, $tempShowingHwnd, $tempHidingHwnd
Global $lastSelected = '' ; Used for hotkeys
Global $currentItem = 'About', $optionsIndex = 0
Global $names[10] = ['About', 'Colors', 'Columns', 'Hotkeys', 'Importing', _
	'Notification', 'Settings', 'Startup', 'Window']
Global $ABOUT = 0, $COLORS = 1, $COLUMNS = 2, $HOTKEYSOPT = 3, $IMPORTING = 4, _
	$NOTIFICATION = 5, $SETTINGS = 6, $STARTUP = 7, $WINDOW = 8
Global $optionsCtrls[10][20]

; Global variables for updates
Global $upGUI, $btnYes, $btnNo, $prgUpdate, $lblProgress, $lblVersion, $newVersion
#EndRegion
#region *** GUI
$mainGUI = GUICreate($NAME, 275, 250, $mainX, $mainY, _
		BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_SYSMENU));, $WS_EX_ACCEPTFILES)
	GUISetOnEvent($GUI_EVENT_CLOSE, '_Exit', $mainGUI)
	
	$btnStop = GUICtrlCreateButton('X', 5, 5, 40, 25, 0)
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetTip(-1, 'Stop')
		GUICtrlSetOnEvent(-1, '_StopFull')
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$btnPause = GUICtrlCreateButton('| |', 50, 5, 40, 25, 0)
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetTip(-1, 'Pause')
		GUICtrlSetOnEvent(-1, '_Pause')
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$btnPlay = GUICtrlCreateButton('>', 95, 5, 40, 25, 0)
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetTip(-1, 'Play')
		GUICtrlSetOnEvent(-1, '_PlaySelected')
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$btnBack = GUICtrlCreateButton('<<', 140, 5, 40, 25, 0)
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetTip(-1, 'Back')
		GUICtrlSetOnEvent(-1, '_Back')
		GUICtrlSetState(-1, $GUI_DISABLE)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$btnNext = GUICtrlCreateButton('>>', 185, 5, 40, 25, 0)
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetTip(-1, 'Next')
		GUICtrlSetOnEvent(-1, '_Next')
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$btnRandom = GUICtrlCreateButton('?', 230, 5, 40, 25, 0)
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetTip(-1, 'Random')
		GUICtrlSetOnEvent(-1, '_PlayRandom')
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$labels[4] = GUICtrlCreateLabel('Volume:', 5, 39, 50, 15, BitOR($SS_RIGHT, $SS_CENTERIMAGE))
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$sldVolume = GUICtrlCreateSlider(60, 35, 205, 26, BitOR($TBS_TOOLTIPS, $TBS_NOTICKS))
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$labels[5] = GUICtrlCreateLabel('Progress:', 5, 75, 50, 15, BitOR($SS_RIGHT, $SS_CENTERIMAGE))
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$sldProgress = GUICtrlCreateSlider(60, 71, 205, 26, $TBS_NOTICKS);BitOR($TBS_TOOLTIPS, $TBS_NOTICKS))
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
		
	$btnMode = GUICtrlCreateButton('Audio', 5, 105, 85, 25, 0)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$btnShuffle = GUICtrlCreateButton('Shuffle Off', 95, 105, 85, 25, 0)
		GUICtrlSetOnEvent(-1, '_Shuffle')
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$btnOptions = GUICtrlCreateButton('Options', 185, 105, 85, 25, 0)
		GUICtrlSetOnEvent(-1, '_Options')
		GUICtrlSetResizing(-1, $GUI_DOCKALL)

	$labels[6] = GUICtrlCreateLabel('Current track', 17, 138, 86, 15)
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	$labels[7] = GUICtrlCreateLabel('Title:', 13, 155, 50, 15, $SS_RIGHT)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	$labels[8] = GUICtrlCreateLabel('Artist:', 13, 170, 50, 15, $SS_RIGHT)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	$labels[9] = GUICtrlCreateLabel('Album:', 13, 185, 50, 15, $SS_RIGHT)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	$labels[10] = GUICtrlCreateLabel('Duration:', 13, 200, 50, 15, $SS_RIGHT)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	$lblTitle = GUICtrlCreateLabel('', 69, 155, 200, 15)	
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	$lblArtist = GUICtrlCreateLabel('', 69, 170, 200, 15)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	$lblAlbum = GUICtrlCreateLabel('', 69, 185, 200, 15)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	$lblDuration = GUICtrlCreateLabel('', 69, 200, 200, 15)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

	$tempText = '' 
	If $startAdd then 
		$tempText = 'Hide Add' 
	Else 
		$tempText = 'Show Add' 
	EndIf 
	$btnToggleAdd = GUICtrlCreateButton($tempText, 5, 220, 85, 25, 0)
		GUICtrlSetOnEvent(-1, '_ShowAdd')
		GUICtrlSetResizing(-1, $GUI_DOCKSIZE + $GUI_DOCKBOTTOM)
	$tempText = '' 
	If $startNP then 
		$tempText = 'Hide List' 
	Else 
		$tempText = 'Show List' 
	EndIf 
	$btnToggleNP = GUICtrlCreateButton($tempText, 95, 220, 85, 25, 0)
		GUICtrlSetOnEvent(-1, '_ShowList')
		GUICtrlSetResizing(-1, $GUI_DOCKSIZE + $GUI_DOCKBOTTOM)
	$btnToggleInfo = GUICtrlCreateButton('Hide Info', 185, 220, 85, 25, 0)
		GUICtrlSetOnEvent(-1, '_ShowInfo')
		GUICtrlSetResizing(-1, $GUI_DOCKSIZE + $GUI_DOCKBOTTOM)

$addGUI = GUICreate($NAME, 460, 250, $addX, $addY, _
		BitOR($WS_CAPTION, $WS_SYSMENU), -1, $mainGUI)
	GUISetOnEvent($GUI_EVENT_CLOSE, '_ShowAdd', $addGUI)
	GUISwitch($addGUI)

	$labels[0] = GUICtrlCreateLabel(_GetFileName($settingsMusic), 5, 5, 176, 15) ;'Browse your folders'
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
;~ 		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$lstFolders = GUICtrlCreateListView('', 5, 24, 220, 216, BitOR($LVS_REPORT, $LVS_NOCOLUMNHEADER, $LVS_SINGLESEL));, $WS_EX_STATICEDGE)
;~ 		GUICtrlSetResizing(-1, $GUI_DOCKALL)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_LV_ALTERNATE)
		_GUICtrlListView_AddColumn($lstFolders, '', 0)
		$lstFoldersHwnd = GUICtrlGetHandle($lstFolders)
	$labels[1] = GUICtrlCreateLabel('', 235, 5, 220, 15) ;Available songs
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
;~ 		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$btnUp = GUICtrlCreateButton('^', 186, 4, 40, 18, 0)
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')	
		GUICtrlSetTip(-1, 'Up one folder')
		GUICtrlSetOnEvent(-1, '_Up')
;~ 		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$lstAvailable = GUICtrlCreateListView('', 232, 24, 220, 191, BitOR($LVS_REPORT, $LVS_NOCOLUMNHEADER));, $WS_EX_STATICEDGE)
;~ 		GUICtrlSetResizing(-1, $GUI_DOCKALL)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_LV_ALTERNATE)
		_GUICtrlListView_AddColumn($lstAvailable, '', 0)
		_GUICtrlListView_AddColumn($lstAvailable, '', 0)
		$lstAvailableHwnd = GUICtrlGetHandle($lstAvailable)
	$btnClearSelected = GUICtrlCreateButton('X', 231, 219, 51, 22, 0)
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetTip(-1, 'Clear selected')
		GUICtrlSetOnEvent(-1, '_ClearSelectedAV')
;~ 		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$btnClearAll = GUICtrlCreateButton('X+', 288, 219, 51, 22, 0)
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetTip(-1, 'Clear all')
		GUICtrlSetOnEvent(-1, '_ClearAllAV')
;~ 		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$btnAddSelected = GUICtrlCreateButton('>', 345, 219, 51, 22, 0)
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetTip(-1, 'Add selected to "Now playing"')
		GUICtrlSetOnEvent(-1, '_AddSelected')
;~ 		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$btnAddAll = GUICtrlCreateButton('>>', 402, 219, 51, 22, 0)
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetTip(-1, 'Add all to "Now Playing"')
		GUICtrlSetOnEvent(-1, '_AddAll')
;~ 		GUICtrlSetResizing(-1, $GUI_DOCKALL)


$nowPlayingGUI = GUICreate($NAME, $windowWidth, $windowHeight, $nowPlayingX, $nowPlayingY, _
		BitOR($WS_CAPTION, $WS_MAXIMIZEBOX, $WS_SYSMENU, $WS_SIZEBOX), -1, $mainGUI)
	GUISetOnEvent($GUI_EVENT_CLOSE, '_ShowList', $nowPlayingGUI)
	GUISwitch($nowPlayingGUI)

	$labels[2] = GUICtrlCreateLabel('Now playing', 5, 5, 100, 15)
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetResizing(-1, $GUI_DOCKALL)
	$lstNowPlaying = GUICtrlCreateListView('', 5, 29, $windowWidth - 10, $windowHeight - 37, $LVS_REPORT, _
			BitOR($LVS_EX_FULLROWSELECT, $LVS_EX_HEADERDRAGDROP))
		GUICtrlSetOnEvent(-1, '_Sort')
		GUICtrlSetResizing(-1, $GUI_DOCKBORDERS)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_LV_ALTERNATE)
;~ 		GUICtrlSetState(-1, $GUI_DROPACCEPTED)
		$lstNowPlayingHwnd = GUICtrlGetHandle($lstNowPlaying)
		$lstNowPlayingHeader = _GUICtrlListView_GetHeader($lstNowPlayingHwnd)
		_GUICtrlListView_AddColumn($lstNowPlayingHwnd, 'Index', 50)
		For $i = 0 to $NUM_COLUMNS - 1
			If $columnStatus[$i][1] = 1 then 
				If $columnStatus[$i][2] = 'Playing' then 
					_GUICtrlListView_AddColumn($lstNowPlayingHwnd, $columnStatus[$i][2], $columnWidths[$columnStatus[$i][0]], 2)
				Else 
					_GUICtrlListView_AddColumn($lstNowPlayingHwnd, $columnStatus[$i][2], $columnWidths[$columnStatus[$i][0]])
				EndIf 
			EndIf
		Next
		
		$temp = _GUICtrlListView_GetColumnOrder($lstNowPlayingHwnd)
		_GUICtrlListView_SetColumnOrder($lstNowPlayingHwnd, '0|' & $columnInitOrder)
		_GUICtrlListView_HideColumn($lstNowplayinghwnd, 0)

	$btnNPClearSelected = GUICtrlCreateButton('X', $windowWidth - 108, 3, 50, 22, 0)
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetTip(-1, 'Clear selected')
		GUICtrlSetOnEvent(-1, '_ClearSelectedNP')
		GUICtrlSetResizing(-1, BitOR($GUI_DOCKTOP, $GUI_DOCKSIZE,$GUI_DOCKRIGHT))	
	$btnNPClearAll = GUICtrlCreateButton('X+', $windowWidth - 53, 3, 50, 22, 0)
		GUICtrlSetFont(-1, 8, 800, 0, 'MS Sans Serif')
		GUICtrlSetTip(-1, 'Clear all')
		GUICtrlSetOnEvent(-1, '_ClearAll')
		GUICtrlSetResizing(-1, BitOR($GUI_DOCKTOP, $GUI_DOCKSIZE,$GUI_DOCKRIGHT))	
	
	_SetDirs($settingsMusic)
	_SetAButtons(False)
	
	_SetPlaylist()
	_SetPastSettings()
	
	_SetBKColor()
	_SetLabelTextColor()
	
	_LoadHotkeys()
	_ActivateHotkeys()
	
	GUIRegisterMsg($WM_COMMAND, 'WM_COMMAND')
	GUIRegisterMsg($WM_NOTIFY, 'WM_NOTIFY')
	GUIRegisterMsg($WM_ACTIVATE, 'WM_ACTIVATE')
	GUIRegisterMsg($WM_GETMINMAXINFO, 'WM_GETMINMAXINFO')

	_GUICtrlListView_RegisterSortCallBack($lstNowPlayingHwnd)
	
	If $startupPickup then 
		_PlayResumeFromLast()
	Else 
		_SetButtons(False)
	EndIf
	
	If Not $startBig then 
		_ShowInfo()
	EndIf

If $startAdd then GUISetState(@SW_SHOW, $addGUI)
If $startNP then GUISetState(@SW_SHOW, $nowPlayingGUI)
GUISetState(@SW_SHOW, $mainGUI)
GUISwitch($mainGUI)

If $startupUpdates then 
	_CheckForUpdates(False)
EndIf

While 1
	Sleep(200)
WEnd
#EndRegion
#region *** MUSIC FUNCTIONS ***
Func _Back() 
	ConsoleWrite('+> _Back()' & @TAB & '_SoundPos() = ' & _SoundPos($currentTrackID, 2) & @CRLF)
	If _SoundPos($currentTrackID, 2) > 3000 then
		_SoundSeek($currentTrackID, 0, 0, 0) 
		_SetProgress()
		If $currentlyPlaying < 2 then _SoundPlay($currentTrackID)
	Else 
		$tempIndex = _GetValidBack()
;~ 		ConsoleWrite('> $tempIndex = ' & $tempIndex & @CRLF)
		If $tempIndex = -1 then ;There's no valid song to go back to
			_SoundSeek($currentTrackID, 0, 0, 0) 
			_SetProgress()
			If $currentlyPlaying = 2 then 
				If Not $backDisabled then 
					GUICtrlSetState($btnBack, $GUI_DISABLE)
					$backDisabled = True
				EndIf
			Else
				_SoundPlay($currentTrackID)	
			EndIf
			Return
		EndIf
;~ 		ConsoleWrite('> _Back() --> $tempIndex = ' & $tempIndex & @CRLF)
		$tempStatus = $currentlyPLaying
		_Stop()
		_LoadSong($tempIndex, False)
		If $tempStatus = 1 then
			_Play() 
		Else 
			_SetSongData()
		EndIf
	EndIf

EndFunc 

Func _Next()
	If $backDisabled then 
		GUICtrlSetState($btnBack, $GUI_ENABLE)
		$backDisabled = False 
	EndIf
		
	If $shuffle then 
		_PlayRandom()
	Else 
		$tempIndex = _GUICtrlListView_MapIDToIndex($lstNowPlayingHwnd, $currentID) + 1
		If $tempIndex = _GUICtrlListView_GetItemCount($lstNowplayingHwnd) then 
			$tempIndex = 0 
		EndIf
		_Stop()

		_SetPlayingState()
		
		$text = _GUICtrlListView_GetItemText($lstNowplayingHwnd, $tempIndex)
		_LoadSong($text)

		_Play()		
	EndIf
	
EndFunc 

Func _Pause() 
	ConsoleWrite('+> _Pause() --> Kiklls timer, sets song to Pause' & @CRLF)
	_SoundPause($currentTrackID)
	$currentlyPlaying = 2
	GUICtrlSetState($btnPause, $GUI_DISABLE)
	If $playingShowing then _SetPlayingState()
	_Timer_KillTimer($mainGUI, $currentTimer)
EndFunc

Func _PlayRandom()
	If $currentlyPlaying = 1 then _Stop()
	_SetPlayingState()

;~ 	_ArrayDisplayEx($playedItems)
	Local $search[1] = [0]
	$inList = -1
	$max = _GUICtrlListView_GetItemCount($lstNowPlayingHwnd)
	Do 
		$tempIndex = Random(0, $max - 1, 1) 
		
		$search[0] += 1
		ReDim $search[$search[0] + 1] 
		$search[$search[0]] = $tempIndex
		
		$itemIndex = _GUICtrlListView_GetItemText($lstNowPlayingHwnd, $tempIndex)
		$string = $nowPlaying[$itemIndex][$TRACK_PATH]
		ConsoleWrite('+> Potential next random song: ' & $string & @CRLF) 

		$size = $playedItems[0]
		$half = Floor($size / 2)
		
		If $half > Floor($max / 2) then $half = $size - ($max / 2)
		If $playedItems[0] = 0 then 
			$inList = -1 
		Else 
			$inList = _ArraySearch($playedItems, $string, $half)			
		EndIf
		ConsoleWrite('> $inList = ' & $inlist & @TAB & '$search[0] = ' & $search[0] & @CRLF)
		
		If $search[0] = $max then 
			_StopFull()
			Return 
		EndIf
	Until $inList = -1

	_LoadSong($tempIndex) 
	_Play()
EndFunc

Func _PlaySelected() ;Called by the Play button or hotkey
	ConsoleWrite('--> _PlaySelected() --> Stops then loads and plays the selected song' & @CRLF)
	If $currentlyPlaying = 2 then 
		If $backDisabled then 
			GUICtrlSetState($btnBack, $GUI_ENABLE) 
			$backDisabled = False 
		EndIf
		_PlayResume()
		Return 
	EndIf
	
	If $currentlyPlaying = 1 then _Stop()
	
	$selected = _GUICtrlListView_GetItemTextArray($lstNowPlayingHwnd)
	If $selected[2] = '' then
		$selected = _GUICtrlListView_GetItemTextArray($lstNowPlayingHwnd, 0) 
		$tempIndex = 0
		
	Else 	
		$temp = _GUICtrlListView_GetSelectedIndices($lstNowPlayingHwnd, True)
		$tempIndex = $temp[1]
	EndIf 

	_LoadSong($tempIndex) 	
	_Play()
EndFunc

Func _PlayResumeFromLast() ; From last time the program was running, only called on startup
	$settingsPosition = $settingsHistory & '\' & $NAME
	$tempFile = IniRead($settingsPosition & '\Settings.ini', 'Playing', 'Name', '')
	If Not FileExists($tempFile) then Return
	$tempStatus = IniRead($settingsPosition & '\Settings.ini', 'Playing', 'Status', 0)
	ConsoleWrite('> _PlayResumeFromLast() $tempstatus = ' & $tempStatus & @CRLF)
	If $tempStatus = 1 or $tempStatus = 2 then
		$tempPos = IniRead($settingsPosition & '\Settings.ini', 'Playing', 'Position', '00:00:00')	
		$index = IniRead($settingsPosition & '\Settings.ini', 'Playing', 'Index', -1)
		If $index = -1 or $index > _GUICtrlListView_GetItemCount($lstNowplayingHwnd) - 1 then Return 
	
		_LoadSong($index)
		$pos = StringSplit($tempPos, ':')
		_SoundSeek($currentTrackID, $pos[1], $pos[2], $pos[3])
		_SetProgress()
		If $tempStatus = 1 then 
			_Play()
		Else
			$currentlyPlaying = 2
			_SetSongData()
			GUICtrlSetState($btnPause, $GUI_DISABLE)
		EndIf
		If $playingShowing then _SetPlayingState()
	Else 
		_SetButtons(False)
	EndIf
EndFunc

Func _LoadSong($index, $forward = True) ;$forward is false only when going back
	$currentID = _GUICtrlListView_MapIndexToID($lstNowplayingHwnd, $index)
	
	$itemIndex = _GUICtrlListView_GetItemText($lstNowplayingHwnd, $index, 0)
	
	$tempPath = $nowPlaying[$itemIndex][$TRACK_PATH]
	
	ConsoleWrite('--> $itemIndex ' & $itemIndex & @TAB & '$tempPath = ' & $tempPath & @CRLF)

	$tempLen = $nowPlaying[$itemIndex][$TRACK_LENGTH]
	$tempTitle = $nowPlaying[$itemIndex][$TRACK_TITLE]
	$tempArtist = $nowPlaying[$itemIndex][$TRACK_ARTIST]
	$tempAlbum = $nowPlaying[$itemIndex][$TRACK_ALBUM]

	$currentTrackID = _SoundOpen($tempPath)
	
	$currentSongLength = _GetSongLength($tempLen)
	$currentSongDuration = $tempLen
	$currentSongPath = $tempPath
	_SetProgress()
	
	$currentData[0] = $tempTitle
	$currentData[1] = $tempAlbum
	$currentData[2] = $tempArtist
	
	If $forward then 
		$playedItems[0] += 1
		_ArrayAdd($playedItems, $tempPath)
	Else 
		If UBound($playedItems) > 1 then 
			ReDim $playedItems[UBound($playedItems) - 1] 
			$playedItems[0] -= 1
		EndIf
	EndIf		
EndFunc

Func _PlayResume()
	ConsoleWrite('> _PlayResume() --> Starts a new timer' & @CRLF)
	$currentlyPlaying = 1
	GUICtrlSetState($btnPause, $GUI_ENABLE) 
	_SoundPlay($currentTrackID)

	$currentTimer = _Timer_SetTimer($mainGUI, 200, '_SetProgressTimer')
	_SetPlayingState()
EndFunc

Func _Play()
	ConsoleWrite('--> Playing the loaded song... Creates a new timer' & @CRLF)
	If $currentlyPlaying = 0 then
		_SetButtons(True)
	EndIf

	If $notificationEnabled then 
		_DisplayNotification()
	EndIf 

	_SetSongData()
	_SetProgress()

	_SoundPlay($currentTrackID)
	$currentlyPlaying = 1

	$currentTimer = _Timer_SetTimer($mainGUI, 200, '_SetProgressTimer')
	If $backDisabled then 
		GUICtrlSetState($btnBack, $GUI_ENABLE) 
		$backDisabled = False
	EndIf
	
	If $playingShowing then _SetPlayingState()
	
	_ReduceMemory(@AutoItPID)
EndFunc

Func _Stop()
	ConsoleWrite('! _Stop() --> Kills timers, sets data blank, closes sound...' & @CRLF)
	_Timer_KillTimer($mainGUI, $currentTimer)
	_SetSongDataBlank()
	_SoundStop($currentTrackID)
	_SoundClose($currentTrackID)
	$currentTrackID = '' 
	$currentlyPlaying = 0
	If $playingShowing then _SetPlayingState()
EndFunc 

Func _StopFull()
	ConsoleWrite('! _StopFull() --> Same as stop except it disables button' & @CRLF)
	_Stop()
	_SetButtons(False)
	GUICtrlSetState($btnBack, $GUI_DISABLE) 
	$backDisabled = True
EndFunc
#EndRegion
#region *** NON MUSIC FUNCTIONS ***
Func _AddAll() 
	$count = _GUICtrlListView_GetItemCount($lstAvailableHwnd) 
	
	Local $tempArray[$count + 1]
	$tempArray[0] = $count
	For $i = 1 to $count
		$tempArray[$i] = $i 
	Next 
	_AddArray($tempArray)
	
	_ClearAllAv()
EndFunc 

Func _AddSelected()
	$selected = _GUICtrlListView_GetSelectedIndices($lstAvailableHwnd, True) 

	_AddArray($selected)
	
	_ClearSelectedAV()	
EndFunc

Func _AddArray($array)
	$max = _GUICtrlListView_GetItemCount($lstNowPlayingHwnd)
	$temptempImportDups = $importDup
	If $max = 0 then $importDup = False
	If $importDup then 
		Local $currentList[$max]
	EndIf 
	
	$advanced = False
	$windowTransEnabledA = $windowTransEnabled
	
	If $array[0] > 50 then 
		$advanced = True
		If $windowTransEnabled then $windowTransEnabled = False
		GUISetState(@SW_DISABLE, $mainGUI)
		$pos = WinGetPos($mainGUI)
		$tempGUI = GuiCreate('Adding files...', 300, 55, $pos[0] + 2, $pos[1] + 22, BitOR($WS_CAPTION, $WS_POPUP), $WS_EX_TOOLWINDOW) ;BitOR($WS_CAPTION, $WS_POPUP, $WS_SYSMENU)
		$label = GUICtrlCreateLabel('Compiling list of songs to add...', 5, 5, 290, 15) 
		$progress = GUICtrlCreateProgress(5, 25, 290, 25)  
		GuiSetState(@SW_SHOW, $tempGUI) 
	EndIf 		
	
	If $importDup then 
		$max = _GUICtrlListView_GetItemCount($lstNowPlayingHwnd)
		If $max > 0 then 
			ReDim $currentList[$max]
			For $i = 0 to $max  - 1
				$currentList[$i] = $nowPlaying[_GUICtrlListView_GetItemText($lstNowplayingHwnd, $i)][$TRACK_PATH]
			Next 
		EndIf
	EndIf

	$toAddIndices = _GetBlankArray() ;if you delete item they will be blank in the array, not deleted
	$toAddIndex = 1
	
	$currentSize = UBound($nowPlaying)
	If $nowPlaying[0][1] = '' then $currentSize = 0
	ConsoleWrite('+> $currentSize = ' & $currentSize & @TAB & '$array[0] = ' & $array[0] & @CRLF)
	
	If $toAddIndices[0] <= $array[0] then 
		ReDim $nowPlaying[$currentSize + $array[0] - $toAddIndices[0] + 1][$NUM_COLUMNS]
		$currentSize = $nowPlaying[0][0] + $array[0] - $toAddIndices
	EndIf

	_GUICtrlListView_BeginUpdate($lstNowPlayingHwnd)
	IF $advanced then 
		$div = 100 / $array[0]
		GUICtrlSetData($label, 'Processing songs...')
		For $i = 1 to $array[0] 
			If $importDup then 
				$toAdd = _GUICtrlListView_GetItemText($lstAvailable, $array[$i], 1)
				If _ArraySearch($currentList, $toAdd) = -1 then 
					If $toAddIndices[0] >= $toAddIndex then 
						_AddSong($toAdd, $toAddIndices[$toAddIndex])
						$toAddIndex += 1
					Else 
						_AddSong($toAdd, -1)
					EndIf
				Else 
					$importDisplayList[0] += 1 
					ReDim $importDisplayList[$importDisplayList[0] + 1]
					$importDisplayList[$importDisplayList[0]] = $toAdd
				EndIf
			Else 
				If $toAddIndices[0] >= $toAddIndex then 
					_AddSong(_GUICtrlListView_GetItemText($lstAvailable, $array[$i], 1), $toAddIndices[$toAddIndex])
					$toAddIndex += 1
				Else 
					_AddSong(_GUICtrlListView_GetItemText($lstAvailable, $array[$i], 1), -1)
				EndIf
			EndIf
			GUICtrlSetData($progress, $div * ($i + 1))
		Next 
		GUISetState(@SW_ENABLE, $mainGUI)
		GUIDelete($tempGUI) 
		$windowTransEnabled = $windowTransEnabledA
	Else 
		For $i = 1 to $array[0] 
			If $importDup then 
				$toAdd = _GUICtrlListView_GetItemText($lstAvailable, $array[$i], 1)
				If _ArraySearch($currentList, $toAdd) = -1 then 
					If $toAddIndices[0] >= $toAddIndex then 
						_AddSong($toAdd, $toAddIndices[$toAddIndex])
						$toAddIndex += 1
					Else 
						_AddSong($toAdd, -1)
					EndIf
				Else 
					$importDisplayList[0] += 1 
					ReDim $importDisplayList[$importDisplayList[0] + 1]
					$importDisplayList[$importDisplayList[0]] = $toAdd
				EndIf
			Else 
				If $toAddIndices[0] >= $toAddIndex then 
					_AddSong(_GUICtrlListView_GetItemText($lstAvailable, $array[$i], 1), $toAddIndices[$toAddIndex])
					$toAddIndex += 1
				Else 
					_AddSong(_GUICtrlListView_GetItemText($lstAvailable, $array[$i], 1), -1)
				EndIf
			EndIf
		Next 
	EndIf
	_GUICtrlListView_HideColumn($lstNowplayinghwnd, 0)
	_GUICtrlListView_EndUpdate($lstNowPlayingHwnd)	
	
	_SetNPButtons(True)
	
	$importDup = $temptempImportDups
	
	If $importDisplay then 
		If $importDisplayList[0] >  0 then 
			_DisplayRejected()
		EndIf 
	EndIf
		
	_ReduceMemory(@AutoItPID)	
EndFunc 

Func _AddSong($path, $cIndex = -1)
;~ 	ConsoleWrite('-> _AddSong(' & $path & ')' & @CRLF)
	
	If Not FileExists($path) then Return
	
	$data = _GetExtProperty($path)
	
	If $data[7] = '' then ;the song title is blank
		If $importDisplay then 
			$importDisplayList[0] += 1 
			ReDim $importDisplayList[$importDisplayList[0] + 1]
			$importDisplayList[$importDisplayList[0]] = $path
		EndIf
		Return
	EndIf 

	$toListText = ''
	For $i = 0 to 9
		If $columnStatus[$i][1] then 
			$toListText &= $data[$i] & '|' 
		EndIf 
	Next
	If $columnStatus[10][1] then $toListText &= $path 
	

	
	$tempIndex = _AddStringToNowPlaying(StringTrimRight($toListText, 1), $cIndex) ;returns ID
;~ 	ConsoleWrite('> $index = ' & $index & @TAB & 'UBound($nowPlaying) = ' & UBound($nowPlaying) & @CRLF)
	For $i = 0 to 9
		$nowPlaying[$tempIndex][$i] = $data[$i]
	Next 
	$nowPlaying[$tempIndex][$TRACK_PATH] = $path 
EndFunc

Func _GetBlankArray()
	Local $retArray[1] = [0]
	For $i = 0 to UBound($nowPlaying) - 1
		If $nowPlaying[$i][0] = '' then 
			_ArrayAdd($retArray, $i)
			$retArray[0] += 1
		EndIf 
	Next 
	Return $retArray
EndFunc

Func _AddStringToNowPlaying($string, $indexToAddAt) ;Has to be the full string with '|' seperators
;~ 	$indexToAddAt = _GetNextBlank()
	
	If $indexToAddAt = -1 then 
		$indexToAddAt = _GUICtrlListVIew_GetItemCount($lstNowplayingHwnd)
	EndIf
	
	GUICtrlCreateListViewItem($indexToAddAt & '|' & $string, $lstNowplaying) 
		If $colorsAltEnabled then GUICtrlSetBkColor(-1, $colorsAlt)	

	Return $indexToAddAt
EndFunc

Func _AddString($hwnd, $string)
	GUICtrlCreateListViewItem($string, $hwnd) 
		If $colorsAltEnabled then GUICtrlSetBkColor(-1, $colorsAlt)	
EndFunc 
	
Func _ClearAll() 
	_GUICtrlListView_DeleteAllItems($lstNowPlayingHwnd)
	ReDim $nowPLaying[1][3]
	$nowPlaying[0][0] = ''
	$nowPlaying[0][1] = ''
	$nowPlaying[0][2] = ''
	_SetNPButtons(False)
	_StopFull()
EndFunc

Func _ClearAllAV()
	_GUICtrlListView_BeginUpdate($lstAvailableHwnd)
	_GUICtrlListView_DeleteAllItems($lstAvailableHwnd)
	_GUICtrlListView_EndUpdate($lstAvailableHwnd)
	If _GUICtrlListView_GetItemCount($lstAvailableHwnd) = 0 then 
		_SetAButtons(False)
		GUICtrlSetData($labels[1], '')
	EndIf
EndFunc

Func _ClearItem($index) 
	For $i = 0 to $NUM_COLUMNS - 1
		$nowPlaying[$index][$i] = ''
	Next 
EndFunc

Func _ClearSelectedNP()
	_GUICtrlListView_BeginUpdate($lstNowplayingHwnd)
	$tempArray = _GUICtrlListView_GetSelectedIndices($lstNowplayingHwnd, True) 

	If _ArraySearch($tempArray, _GUICtrlListView_MapIDToIndex($lstNowPlayingHwnd, $currentID)) > -1 then _StopFull()
	
	For $i = 1 to $tempArray[0] 
		$tempIndex = _GUICtrlListView_GetItemText($lstNowplayingHwnd, $tempArray[$i]) 
		_ClearItem($tempIndex)
	Next
	
	
	_GUICtrlListView_DeleteItemsSelected($lstNowPlayingHwnd)
	_GUICtrlListView_EndUpdate($lstNowplayingHwnd)
	If _GUICtrlListView_GetItemCount($lstNowPlayingHwnd) = 0 then 
		_SetNPButtons(False)
	EndIf
EndFunc 

Func _ClearSelectedAV()
	_GUICtrlListView_BeginUpdate($lstAvailableHwnd)
	_GUICtrlListView_DeleteItemsSelected($lstAvailableHwnd)
	_GUICtrlListView_EndUpdate($lstAvailableHwnd)
	If _GUICtrlListView_GetItemCount($lstAvailableHwnd) = 0 then 
		_SetAButtons(False)
		GUICtrlSetData($labels[1], '')
	EndIf
EndFunc 

Func _DisplayNotification()	
	If $notificationFullScreen then 
		$temp = WinGetTitle('') 
		If $temp <> $PROGRAM_MANGAGER then
			$tempPos = WinGetPos($temp)
			If $tempPos[2] >= @DesktopWidth and $tempPos[3] >= @Desktopheight then 
				Return ; A full screen application is running so don't display
			EndIf 
		EndIf
	EndIf 
	
	If $notiShowing then 
		GUICtrlSetData($notiLabels[3], StringReplace($currentData[0], '&', '&&'))
		GUICtrlSetData($notiLabels[4], StringReplace($currentData[2], '&', '&&'))
		GUICtrlSetData($notiLabels[5], StringReplace($currentData[1], '&', '&&'))
		_Timer_KillTimer($notiGUI, $notiTimer)
	Else
		$notiGUI = GUICreate('KMP Notification', 260, 60, $notificationX, $notificationY, BitOR($WS_POPUPWINDOW,$WS_CAPTION), -1, $mainGUI)
			GUISetBkColor($colorsBK, $notiGUI)
			GUISetOnEvent($GUI_EVENT_CLOSE, '_DisplayNotificationExit', $notiGUI)
			If $notificationAbove then WinSetOnTop($notiGUI, '', 1)
		
		$notiLabels[0] = GUICtrlCreateLabel('Title:', 5, 3, 50, 15, $SS_RIGHT)
			GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		$notiLabels[1] = GUICtrlCreateLabel('Artist:', 5, 23, 50, 15, $SS_RIGHT)
			GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		$notiLabels[2] = GUICtrlCreateLabel('Album:', 5, 43, 50, 15, $SS_RIGHT)
			GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

		$notiLabels[3] = GUICtrlCreateLabel(StringReplace($currentData[0], '&', '&&'), 60, 3, 195, 15)	
			GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		$notiLabels[4] = GUICtrlCreateLabel(StringReplace($currentData[2], '&', '&&'), 60, 23, 195, 15)
			GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		$notiLabels[5] = GUICtrlCreateLabel(StringReplace($currentData[1], '&', '&&'), 60, 43, 195, 15)
			GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)

		For $i = 0 to 5 
			GUICtrlSetColor($notiLabels[$i], $colorsText)
		Next
		
		GUISetState(@SW_SHOWNOACTIVATE, $notiGUI)
	EndIf
	$notiShowing = True 
	
	$notiTimer = _Timer_SetTimer($notiGUI, $notificationTime * 1000, '_DisplayNotificationExitTimer')
	GUISwitch($mainGUI)
EndFunc

Func _DisplayNotificationExitTimer($hWnd, $Msg, $iIDTimer, $dwTime)
	#forceref $hWnd, $Msg, $iIDTimer, $dwTime
	_DisplayNotificationExit()
EndFunc

Func _DisplayNotificationExit()
	_Timer_KillTimer($notiGUI, $notiTimer)
	GUIDelete($notiGUI)
		
	$notiShowing = False
	
	_SetWindowTrans()
	GUISwitch($mainGUI)
EndFunc

Func _DisplayRejected()
	WinSetState($mainGUI, '', @SW_DISABLE)
	$rejGUI = GUICreate('KMP', 400, 397, -1, -1, BitOR($WS_CAPTION, $WS_POPUP, $WS_SYSMENU), -1, $mainGUI) 
		GUISetBkColor($colorsBK, $rejGUI)
		GUISetOnEvent($GUI_EVENT_CLOSE, '_DisplayRejectedClose', $rejGUI)
		WinSetOnTop($rejGUI, '', 1)
	GUICtrlCreateLabel('The following songs could not be added to your "Now Playing" list...', 5, 5, 393, 20, $SS_CENTERIMAGE) 
		GUICtrlSetBKCOlor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $colorsText)
	
	$list = GUICtrlCreateListView('', 5, 30, 390, 360, BitOR($LVS_REPORT, $LVS_NOCOLUMNHEADER)) 
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_LV_ALTERNATE)
		$hwndList = GUICtrlGetHandle($list)
		_GUICtrlListView_AddColumn($hwndList, '', 395)
	
	_GUICtrlListView_BeginUpdate($hwndList)
	For $i = 1 to $importDisplayList[0] 
		_AddString($list, $importDisplayList[$i])
	Next 
	_GUICtrlListView_EndUpdate($hwndList)
	_GUICtrlListView_SetColumnWidth($hwndList, 0, $LVSCW_AUTOSIZE)
	GUISetState()
	GUISwitch($mainGUI)
	ReDim $importDisplayList[1] 
	$importDisplayList[0] = 0
	
EndFunc 

Func _DisplayRejectedClose()
	WinSetState($mainGUI, '', @SW_ENABLE)
	GUIDelete($rejGUI)
	GUISwitch($mainGUI)
EndFunc

Func _Redraw($hwnd)
	If $hwnd = $lstNowplaying then $mappedIndex = _GUICtrlListView_MapIDToIndex($lstNowPlayingHwnd, $currentID)
	$max = _GUICtrlListView_GetItemCount($hwnd) 
	If $max = 0 then Return
		
	Local $array[$max]
	For $i = 0 to $max - 1
		$array[$i] = _GUICtrlListView_GetItemTextString($hwnd, $i)
	Next 

	_GUICtrlListView_BeginUpdate($hwnd)
	_GUICtrlListView_DeleteAllItems($hwnd)
	For $i = 0 to $max - 1
		_AddString($hwnd, $array[$i])
	Next
	If $hwnd = $lstAvailable then _GUICtrlListView_HideColumn($hwnd, 1)
	If $hwnd = $lstNowPlaying then 
		$currentID = _GUICtrlListView_MapIndexToID($lstNowPlayingHwnd, $mappedIndex)
	EndIf 
	
	_GUICtrlListView_EndUpdate($hwnd)
EndFunc

Func _RemoveDups()
	$tempIndex = _GUICtrlListView_MapIDToIndex($lstNowplayingHwnd, $currentID)
	$pathIndex = _GetItemIndex('Path')
	$size = _GUICtrlListView_GetItemCount($lstNowPlayingHwnd) 
	Local $array[$size] 
	For $i = 0 to $size - 1
		$array[$i] = _GUICtrlListView_GetItemText($lstNowplayingHwnd, $i, $pathIndex) 
	Next 
	
	For $i = 0 to $size - 1
		$poss = _ArraySearch($array, $array[$i], $i + 1)
		If $poss > -1 then 
			If $tempIndex = $i then 
				$array[$poss] = ''
			Else 
				$array[$i] = ''
			EndIf
		EndIf 
	Next 
	
	_GUICtrlListView_BeginUpdate($lstNowplayingHwnd)
	For $i = $size - 1 to 0 Step -1
		If $array[$i] = '' then 
			_GUICtrlListView_deleteItem($lstNowplayingHwnd, $i) 
		EndIf 
	NExt 
	_GUICtrlListView_EndUpdate($lstNowplayingHwnd)
	
EndFunc 

Func _ShowAdd()
	If BitAnd(WinGetState($addGUI), 2) = 2 then 
		GUICtrlSetData($btnToggleAdd, 'Show Add')
		GUISetState(@SW_HIDE, $addGUI)
	Else 
		GUICtrlSetData($btnToggleAdd, 'Hide Add')
		GUISetState(@SW_SHOWNOACTIVATE, $addGUI)
	EndIf 
	GUISwitch($mainGUI)
EndFunc 

Func _ShowList()
	If BitAnd(WinGetState($nowPlayingGUI), 2) = 2 then 
		GUICtrlSetData($btnToggleNP, 'Show List')
		GUISetState(@SW_HIDE, $nowPlayingGUI)
	Else 
		GUICtrlSetData($btnToggleNP, 'Hide List')
		GUISetState(@SW_SHOWNOACTIVATE, $nowPlayingGUI)
	EndIf 	
	GUISwitch($mainGUI)
EndFunc 

Func _ShowInfo()
	$winPos = WinGetPos($mainGUI)
	If GUICtrlRead($btnToggleInfo) = 'Show Info' then 
		GUICtrlSetData($btnToggleInfo, 'Hide Info')

		WinMove($mainGUI, '', $winPos[0], $winPos[1], $winPos[2], $winPos[3] + 85)
		
		For $i = 6 to 10 
			GUICtrlSetState($labels[$i], $GUI_SHOW) 
		Next
		GUICtrlSetState($lblTitle, $GUI_SHOW) 
		GUICtrlSetState($lblAlbum, $GUI_SHOW) 
		GUICtrlSetState($lblArtist, $GUI_SHOW) 
		GUICtrlSetState($lblDuration, $GUI_SHOW) 
	Else 
		GUICtrlSetData($btnToggleInfo, 'Show Info')
		For $i = 6 to 10 
			GUICtrlSetState($labels[$i], $GUI_HIDE) 
		Next
		GUICtrlSetState($lblTitle, $GUI_HIDE) 
		GUICtrlSetState($lblAlbum, $GUI_HIDE) 
		GUICtrlSetState($lblArtist, $GUI_HIDE) 
		GUICtrlSetState($lblDuration, $GUI_HIDE) 
			
		WinMove($mainGUI, '', $winPos[0], $winPos[1], $winPos[2], $winPos[3] - 85)
	EndIf 
	GUISwitch($mainGUI)
EndFunc

Func _Shuffle() 
	$shuffle = Not $shuffle
	If $shuffle then 
		GuiCtrlSetData($btnShuffle, 'Shuffle On') 
	Else 
		GuiCtrlSetData($btnShuffle, 'Shuffle Off') 
	EndIf
EndFunc

Func _Sort()
	_GUICtrlListView_SortItems($lstNowPlaying, GUICtrlGetState($lstNowPlaying))
EndFunc 

Func _Up() 
	_GUICtrlListView_DeleteAllItems($lstAvailableHwnd)
	_SetAButtons(False)
	
	$splitPath = StringSplit($settingsMusic, '\') 
	If $splitPath[0] = 2 then 
		GuiCtrlSetState($btnUp, $GUI_DISABLE) 
		$upDisabled = True
	EndIf 
	
	$settingsMusic = ''
	For $i = 1 to $splitPath[0] - 1 
		$settingsMusic &= $splitPath[$i] & '\'
	Next 
	$settingsMusic = StringTrimRight($settingsMusic, 1) 
	
	_SetDirs($settingsMusic)
	GUICtrlSetData($labels[1], '')
EndFunc

Func _UpdateColumns()
;~ 	_ArrayDisplay($tempColumnsToAdd)
;~ 	_ArrayDisplay($tempColumnsToRemove) 
	
	$columnsText = _GetColumnTextArray()
;~ 	_ArrayDisplay($columnsText)
	
	_GUICtrlListView_BeginUpdate($lstNowplayingHWnd)
	For $i = 1 to $tempColumnsToAdd[0]
		If _ArraySearch($columnsText, $tempColumnsToAdd[$i]) = -1 then 
;~ 			_GUICtrlListView_BeginUpdate($lstNowplayingHWnd)
			ConsoleWrite('--> Adding column: ' & $tempColumnsToAdd[$i] & @CRLF)
			
			$smallIndex = _GetIndexFromName($tempColumnsToAdd[$i])
			$columnStatus[$smallIndex][1] = 1
			
			$index = _GetIndexFromName($tempColumnsToAdd[$i])
			If $tempColumnsToAdd[$i] = 'Playing' then 
				$newIndex = _GUICtrlListView_AddColumn($lstNowPlayingHwnd, $tempColumnsToAdd[$i], $columnWidths[$index], 2)
			Else
				$newIndex = _GUICtrlListView_AddColumn($lstNowPlayingHwnd, $tempColumnsToAdd[$i], $columnWidths[$index])
			EndIf

			If $tempColumnsToAdd[$i] = 'Playing' then 
				$playingShowing = True 
				_SetPlayingState()
			EndIf
			
			_UpdateList($newIndex, $tempColumnsToAdd[$i])
			$columnsText = _GetColumnTextArray()
		EndIf 
	Next 
	
	
	For $i = 1 to $tempColumnsToRemove[0]
		$colIndex = _ArraySearch($columnsText, $tempColumnsToRemove[$i])
		If $colIndex > -1 then 
			ConsoleWrite('! Removing column: ' & $tempColumnsToRemove[$i] & @TAB & '$colIndex = ' & $colIndex & @CRLF)
			$smallIndex = _GetIndexFromName($tempColumnsToRemove[$i])
			$columnStatus[$smallIndex][1] = 0
;~ 			$numColsShowing -= 1

			_GUICtrlListView_DeleteColumn($lstNowPlayingHwnd, $colIndex)
			$columnsText = _GetColumnTextArray()
		EndIf 
	Next 	
	_GUICtrlListView_EndUpdate($lstNowplayingHWnd)
	
EndFunc

Func _UpdateList($index, $name)
	$max = _GUICtrlListView_GetItemCount($lstNowPlayingHwnd)  
	
	For $i = 0 to $max - 1
		If $name <> 'Path' then 
			$tempIndex = _GetIndexFromName($name)
			If $tempIndex <= $split[0] then
				_GUICtrlLIstView_AddSubItem($lstNowplayingHwnd, $i, $nowPlaying[$i][$tempIndex], $index)
			EndIf
		Else 
			_GUICtrlListView_AddSubItem($lstNowplayingHwnd, $i, $nowPlaying[$i][$TRACK_PATH], $index)
		EndIf
	Next 

EndFunc 

Func _Exit() 
	If WinExists('KMP Options') then 
		_ExitOptionsQuick() 
	EndIf
	
	GUISetState(@SW_HIDE)
	$savePosition = $settingsHistory & '\' & $NAME
	
	RegWrite('HKEY_CURRENT_USER\Software\KMP','Settings', 'REG_SZ', $settingsHistory)
	
	If Not FileExists($savePosition) then DirCreate($savePosition)

	$count = _GUICtrlListView_GetItemCount($lstNowPlayingHwnd) 
	
	IniDelete($savePosition & '\NowPlaying.ini', 'NowPlaying')
	For $i = 0 to $count - 1
		$tempID = _GUICtrlListView_GetItemText($lstNowplayingHwnd, $i)
;~ 		ConsoleWrite('+> Writing to NowPlaying.ini (' & $i & '): ' & $nowPlaying[$tempID][$TRACK_PATH] & @CRLF)
		IniWrite($savePosition & '\NowPlaying.ini', 'NowPlaying', $i, $nowPlaying[$tempID][$TRACK_PATH])
		;It might be a good idea to actually save the data not just the file position
	Next 
	
	IniWrite($savePosition & '\Settings.ini', 'Volume', 'Set', GUICtrlRead($sldVolume))
	IniWrite($savePosition & '\Settings.ini', 'Shuffle', 'Background', $shuffle)
		
	IniWrite($savePosition & '\Settings.ini', 'Colors', 'Background', $colorsBK)
	IniWrite($savePosition & '\Settings.ini', 'Colors', 'Text', $colorsText)
	IniWrite($savePosition & '\Settings.ini', 'Colors', 'Alt', $colorsAlt)
	IniWrite($savePosition & '\Settings.ini', 'Colors', 'AltEnabled', $colorsAltEnabled)
	IniWrite($savePosition & '\Settings.ini', 'Colors', 'String', $colorsString)
	IniWrite($savePosition & '\Settings.ini', 'Import', 'Display', $importDisplay)
	IniWrite($savePosition & '\Settings.ini', 'Import', 'Duplicates', $importDup)
	IniWrite($savePosition & '\Settings.ini', 'Notification', 'Enabled', $notificationEnabled)
	IniWrite($savePosition & '\Settings.ini', 'Notification', 'FullScreen', $notificationFullScreen)
	IniWrite($savePosition & '\Settings.ini', 'Notification', 'Above', $notificationAbove)
	IniWrite($savePosition & '\Settings.ini', 'Notification', 'Time', $notificationTime)
	IniWrite($savePosition & '\Settings.ini', 'Notification', 'X', $notificationX)
	IniWrite($savePosition & '\Settings.ini', 'Notification', 'Y', $notificationY)
	IniWrite($savePosition & '\Settings.ini', 'Settings', 'Music', $settingsMusicInit)
;~ 	IniWrite($savePosition & '\Settings.ini', 'Settings', 'MSN', $settingsMSN)
	IniWrite($savePosition & '\Settings.ini', 'Startup', 'Pickup', $startupPickup)
	IniWrite($savePosition & '\Settings.ini', 'Startup', 'Windows', $startupWindows)
	IniWrite($savePosition & '\Settings.ini', 'Startup', 'Updates', $startupUpdates)
	IniWrite($savePosition & '\Settings.ini', 'Window', 'Pickup', $windowTransEnabled)
	IniWrite($savePosition & '\Settings.ini', 'Window', 'Trans', $windowTrans)
	$temp = WinGetPos($mainGUI)
	If IsArray($temp) then 
		IniWrite($savePosition & '\Settings.ini', 'Window', 'MainX', $temp[0])
		IniWrite($savePosition & '\Settings.ini', 'Window', 'MainY', $temp[1])
		If $temp[3] > 250 then 
			IniWrite($savePosition & '\Settings.ini', 'Window', 'MainBig', True)
		Else 
			IniWrite($savePosition & '\Settings.ini', 'Window', 'MainBig', False)
		EndIf
	EndIf
	$temp = WinGetPos($addGUI)
	If IsArray($temp) then 
		IniWrite($savePosition & '\Settings.ini', 'Window', 'AddX', $temp[0])
		IniWrite($savePosition & '\Settings.ini', 'Window', 'AddY', $temp[1])
	EndIf
	$temp = WinGetPos($nowplayingGUI)
	If IsArray($temp) then 
		IniWrite($savePosition & '\Settings.ini', 'Window', 'NowPlayingX', $temp[0])
		IniWrite($savePosition & '\Settings.ini', 'Window', 'NowPlayingY', $temp[1])		
		IniWrite($savePosition & '\Settings.ini', 'Window', 'Width', $temp[2] - 16)
		IniWrite($savePosition & '\Settings.ini', 'Window', 'Height', $temp[3] - 36)
	EndIf
;~ 	ConsoleWrite('!GUICtrlRead($btnToggleAdd) = ' & GUICtrlRead($btnToggleAdd) & @CRLF)
	IniWrite($savePosition & '\Settings.ini', 'Window', 'AddShow', GUICtrlRead($btnToggleAdd) = 'Hide Add')

;~ 	ConsoleWrite('!GUICtrlRead($btnToggleAdd) = ' & GUICtrlRead($btnToggleNP) & @CRLF)
	IniWrite($savePosition & '\Settings.ini', 'Window', 'NPShow', GUICtrlRead($btnToggleNP) = 'Hide List')

	
	IniWrite($savePosition & '\Settings.ini', 'Playing', 'Name', $currentSongPath)
	IniWrite($savePosition & '\Settings.ini', 'Playing', 'Status', $currentlyPlaying)
	IniWrite($savePosition & '\Settings.ini', 'Playing', 'Position', _SoundPos($currentTrackID, 1))
	IniWrite($savePosition & '\Settings.ini', 'Playing', 'Index', _GUICtrlListView_MapIDToIndex($lstNowplayinghwnd, $currentID))
	
;~ 	IniWrite($savePosition & '\Settings.ini', 'Column', 'NumShowing', $numColsShowing)
;~ 	IniWrite($savePosition & '\Settings.ini', 'Column', 'NumHiding', $numColsHiding)
	
	$tempString = ''
	$tempArray = _GUICtrlLIstView_GetColumnOrderArray($lstNowplayingHwnd)
;~ 	_ArrayDisplayEx($tempArray)
	For $i = 2 to $tempArray[0] ; TWO to skip Index
		$temp = _GUICtrlListView_GetColumn($lstNowPLayingHwnd, $tempArray[$i]) 
		If $temp[4] > 0 then $tempString &= $tempArray[$i] & '.' & $temp[5] & '.' & $temp[4] & '|'
	Next 
	IniWrite($savePosition & '\Settings.ini', 'Column', 'Order', StringTrimRight($tempString, 1))
	
	ConsoleWrite('--> Exit got past writing header names' & @CRLF)
	
	If $startupWindows then 
		If Not FileExists(@StartupDir & '\KMP.lnk') then 
			FileCreateShortCut(@ScriptFullPath, @StartupDir & '\KMP.lnk')
		Else 
			$temp = FileGetShortCut(@StartupDir & '\KMP.lnk')
			If $temp[0] <> @ScriptFullPath then 
				FileDelete(@StartupDir & '\KMP.lnk')
				FileCreateShortCut(@ScriptFullPath, @StartupDir & '\KMP.lnk')
			EndIf 
		EndIf
	Else 
		If FileExists(@StartupDir & '\KMP.lnk') then 
			FileDelete(@StartupDir & '\KMP.lnk')
		EndIf 
	EndIf
	
	ConsoleWrite('--> Exit got past creating startup shortcuts' & @CRLF)
	
;~ 	_ArrayDisplay($hotkeys)
	For $i = 0 to UBound($hotkeys) - 1
		If $hotkeys[$i][1] <> 'None' then ;Hotkey String | Code | Global 
			IniWrite($savePosition & '\Settings.ini', 'HotkeysHist', $hotkeys[$i][0], $hotkeys[$i][1] & '-' & $hotkeys[$i][3] & '-' & $hotkeys[$i][2])
		Else 
			IniDelete($savePosition & '\Settings.ini', 'HotkeysHist', $hotkeys[$i][0])
		EndIf
	Next 
	
;~ 	_StopFull()
	ConsoleWrite('+> _SoundStop() = ' & _SoundStop($currentTrackID) & @CRLF)
	ConsoleWrite('+> _SoundClose() = ' & _SoundClose($currentTrackID) & @CRLF)
	If $notiShowing then ConsoleWrite('!Killing timer: ' & _Timer_KillTImer($notiGUI, $notiTimer) & @CRLF)
	If $currentlyPlaying > 0 then ConsoleWrite('!Killing timer: ' & _Timer_KillTimer($mainGUI, $currentTimer) & @CRLF)
;~ 	_Timer_KillAllTimers($mainGUI)
	ConsoleWrite('--> Exit got past stoping and closing the current sound' & @CRLF)
	
	
	_GUICtrlListView_UnRegisterSortCallBack($lstNowPlayingHwnd)
	ConsoleWrite('--> Exit got past unregistering the sort callback' & @CRLF)
	
	GUIDelete($mainGUI)
	
	ConsoleWrite('! _WinAPI_LastError() = ' & _WinAPI_GetLastError() & @CRLF)
	
	Exit 
EndFunc
#EndRegion 
#region *** GET FUNCTIONS ***
Func _ArrayDisplayEx($array) 
	$tempString = ''
	For $j = 0 to UBound($array) - 1
		$tempString &= $array[$j] & @CRLF 
	Next 
	$tempString = StringTrimRight($tempString, 1)
	Msgbox(0, '$array', $tempString) 
EndFunc

Func _GetColumnTextArray()
	$columnsText = _GUICtrlLIstView_GetColumnOrderArray($lstNowPlayingHWnd)
	$current = $columnsText
	For $i = 0 to $columnsText[0] 
		$temp = _GUICtrlListView_GetColumn($lstNowPlayingHwnd, $i) 
		$columnsText[$i] = $temp[5]
	Next 	
	Return $columnsText 
EndFunc

Func _GetDuration($s) 
	$ret = '00:00:00'
	$ret = StringTrimLeft($ret, 8 - StringLen($s))
	Return $ret & ' / ' & $s 
EndFunc

Func _GetFileName($path) 
	Return StringTrimLeft($path, StringInStr($path, "\", 1, -1))
EndFunc

Func _GetItemIndex($name) 
	$columnsText = _GetColumnTextArray()
	Return _ArraySearch($columnsText, $name)
EndFunc

Func _GetLatestVersion()
	$source = _InetGetSource('http://knightmediaplayer.110mb.com/')
	$sourceSplit = StringSplit($source, @CRLF)

	For $i = 1 to $sourceSplit[0] 
		$index = StringInStr($sourceSplit[$i], 'kmpversion=')
		If $index > 0 then 
			$latestVersion = _StringBetween($sourceSplit[$i], 'kmpversion=', '</p>')
			Return Number($latestVersion[0])
		EndIf 
	Next

	Return -1
EndFunc

Func _GetIndexFromName($s)
	For $i = 0 to $NUM_COLUMNS - 1
		If $columnStatus[$i][2] = $s then 
			Return $i
		EndIf 
	Next
EndFunc

Func _GetMusicDir() 
	Return RegRead('HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders', 'My Music')
EndFunc

Func _GetSongLength($s)
	$temp = StringSplit($s, ':') 

	Return $temp[1] * 60 + $temp[2]
EndFunc

Func _GetValidBack() 
	$offset = 2
	If $offset - 1 = UBound($playedItems) then Return -1
	
	Do  
		ConsoleWrite('> _GetValidBack()' & @TAB & 'Searching for: ' & $playedItems[UBound($playedItems) - $offset] & @CRLF)
		$index = _GetValidIndex($playedItems[UBound($playedItems) - $offset])
		$offSet += 1 
	Until $index > -1 or $offset - 1 = UBound($playedItems) 
	
	If $offset - 1 = UBound($playedItems) then 
		Return -1
	Else 
		Return $index 
	EndIf
		
EndFunc
	
Func _GetValidIndex($path)
	For $i = 0 to _GUICtrlListView_GetITemCount($lstNowplayingHwnd) - 1
		If $path = $nowPlaying[$i][$TRACK_PATH] then 
			Return $i 
		EndIf 
	Next 
	Return -1
EndFunc 

Func _CheckForUpdates($display) 
	$newVersion = _GetLatestVersion()
	If $newVersion <= $VERSION then
		If Not $display then Return
		$updateAvailable = False 
	Else 
		$updateAvailable = True 
	EndIf 
	If $display then GUICtrlSetState($optionsCtrls[$STARTUP][3], $GUI_DISABLE)
	
	$upGUI = GUICreate('KMP Update', 320, 80) 
		GUISetOnEvent($GUI_EVENT_CLOSE, '_No')
		GUISetBkColor($colorsBk, $upGUI)

		If $updateAvailable then 
			$lblVersion = GUICtrlCreateLabel('Version ' & $newVersion & ' is available.' & @CRLF & 'Would you like to download it?', 10, 10, 200, 35)
				GUICtrlSetBKColor(-1, $GUI_BKCOLOR_TRANSPARENT) 
				GUICtrlSetColor(-1, $colorsText)
				GUICtrlSetResizing(-1, $GUI_DOCKALL)

			$btnYes = GUICtrlCreateButton('Yes', 10, 45, 150, 25) 
				GUICtrlSetOnEvent(-1, '_Yes')
				GUICtrlSetResizing(-1, $GUI_DOCKALL)
			$btnNo = GUICtrlCreateButton('No', 160, 45, 150, 25) 
				GUICtrlSetOnEvent(-1, '_No')
				GUICtrlSetResizing(-1, $GUI_DOCKALL)
		Else 
			$lblVersion = GUICtrlCreateLabel('No new updates are available...', 10, 10, 200, 35)
				GUICtrlSetBKColor(-1, $GUI_BKCOLOR_TRANSPARENT) 
				GUICtrlSetColor(-1, $colorsText)
				GUICtrlSetResizing(-1, $GUI_DOCKALL)
			$btnNo = GUICtrlCreateButton('Ok', 160, 45, 150, 25) 
				GUICtrlSetOnEvent(-1, '_No')
				GUICtrlSetResizing(-1, $GUI_DOCKALL)				
		EndIf
				
	GUISetState() 
	GUISwitch($mainGUI)
EndFunc 

Func _Yes()
	GUICtrlDelete($btnYes)
	GUICtrlDelete($btnNo)
	GUICtrlDelete($lblVersion)
	
	$prevPos = WinGetPos($upGUI)
	WinMove($upGUI, '', $prevPos[0], $prevPos[1], $prevPos[2], 130) 
	
	GUISwitch($upGUI)
	GUICtrlCreateLabel('Downloading KMP version ' & $newVersion & '...', 10, 10, 200, 20) 
		GUICtrlSetBKColor(-1, $GUI_BKCOLOR_TRANSPARENT) 
		GUICtrlSetColor(-1, $colorsText) 
			
	$prgUpdate = GUICtrlCreateProgress(10, 33, 300, 25) 

	$lblProgress = GUICtrlCreateLabel('Progress: 0%', 10, 70, 200, 25, $SS_CENTERIMAGE) 
			GUICtrlSetBKColor(-1, $GUI_BKCOLOR_TRANSPARENT) 
			GUICtrlSetColor(-1, $colorsText) 

;~ 	$btnCancel = GUICtrlCreateButton('Cancel', 165, 70, 145, 25) 
;~ 		GUICtrlSetOnEvent(-1, '_Cancel')
	GUISwitch($mainGUI)
	
	$size = InetGetSize('http://knightmediaplayer.110mb.com/Media%20Player.zip')
	InetGet('http://knightmediaplayer.110mb.com/Media%20Player.zip', @DesktopDir & '\KMP.zip', 0, 1)

	$tempPercent = 0

	Do
		$percent = Int(@InetGetBytesRead / $size  * 100)

		If $percent <> $tempPercent Then
			GUICtrlSetData($lblProgress, 'Progress: ' & $percent & '%')
			GUICtrlSetData($prgUpdate, $percent)
		EndIf

		$tempPercent = $percent
	Until Not @InetGetActive
	
	GUICtrlDelete($lblProgress)
;~ 	GUICtrlDelete($btnCancel)
	GUISwitch($upGUI)
	GuiCtrlCreateLabel('Your download is complete. Please extract KMP.zip and run the file from there to use the new version...', 10, 65, 300, 30)
		GUICtrlSetBKColor(-1, $GUI_BKCOLOR_TRANSPARENT) 
		GUICtrlSetColor(-1, $colorsText) 
	GUISwitch($mainGUI)
EndFunc 

Func _Cancel()
	FileDelete(@DesktopDir & '\KMP.zip')
	_No()
EndFunc

Func _No()
	GUICtrlSetState($optionsCtrls[$STARTUP][3], $GUI_ENABLE)
	GUIDelete($upGUI) 
EndFunc 	
	
#EndRegion 
#region *** SET FUNCTIONS ***
Func _SetAButtons($state)
	If $state then 
		GUICtrlSetState($btnClearSelected, $GUI_ENABLE) 
		GUICtrlSetState($btnClearAll, $GUI_ENABLE) 
		GUICtrlSetState($btnAddAll, $GUI_ENABLE) 
		GUICtrlSetState($btnAddSelected, $GUI_ENABLE) 
	Else
		GUICtrlSetState($btnClearSelected, $GUI_DISABLE) 
		GUICtrlSetState($btnClearAll, $GUI_DISABLE) 
		GUICtrlSetState($btnAddAll, $GUI_DISABLE) 
		GUICtrlSetState($btnAddSelected, $GUI_DISABLE) 
	EndIf
EndFunc 

Func _SetBKColor()
	GUISetBkColor($colorsBK, $mainGUI)
	GUISetBkColor($colorsBK, $addGUI)
	GUISetBkColor($colorsBK, $nowPlayingGUI)
	
	GUICtrlSetBkColor($sldVolume, $colorsBK)
	If $currentlyPlaying = 0 then 
		GUICtrlSetState($sldProgress, $GUI_ENABLE)
		GUICtrlSetBkColor($sldProgress, $colorsBK)	
		GUICtrlSetState($sldProgress, $GUI_DISABLE)
	Else 
		GUICtrlSetBkColor($sldProgress, $colorsBK)	
	EndIf
	
	If $notiShowing then 
		GUISetBkColor($colorsBK, $notiGUI)
	EndIf
EndFunc

Func _SetButtons($state) 
	If $state then 
		GUICtrlSetState($btnStop, $GUI_ENABLE)
		If $currentlyPlaying < 2 then GUICtrlSetState($btnPause, $GUI_ENABLE)
		GUICtrlSetState($btnNext, $GUI_ENABLE)
		GUICtrlSetState($sldProgress, $GUI_ENABLE)
	Else 
		GUICtrlSetState($btnStop, $GUI_DISABLE)
		GUICtrlSetState($btnPause, $GUI_DISABLE)
		GUICtrlSetState($btnNext, $GUI_DISABLE)
		GUICtrlSetData($sldProgress, 0)
		GUICtrlSetState($sldProgress, $GUI_DISABLE)
	EndIf
EndFunc	

Func _SetColumnWidthMinimum($hwnd)
	Local $min = 215
	_GUICtrlListView_BeginUpdate($hwnd) 
	
	_GUICtrlListView_SetColumnWidth($hwnd, 0, $LVSCW_AUTOSIZE)
	
	If _GUICtrlListView_GetColumnWidth($hwnd, 0) < $min then 
		_GUIctrlListView_SetColumnWidth($hwnd, 0, $min)
	EndIf
	
	_GUICtrlListView_EndUpdate($hwnd) 
EndFunc 

Func _SetDirs($path) 
	$folderArray = _FileListToArray($path, '**', 2) 
	If @error = 4 then Return
	If Not IsArray($folderArray) then Return
	If $folderArray[0] = '' then Return

	
	_GUICtrlListView_BeginUpdate($lstFoldersHwnd)
	_GUICtrlListView_DeleteAllItems($lstFoldersHwnd)

	For $i = 1 to $folderArray[0] 
		_AddString($lstFolders, $folderArray[$i])
	Next 
	_SetColumnWidthMinimum($lstFoldersHwnd)
	
	_GUICtrlListView_EndUpdate($lstFoldersHwnd)
	$settingsMusic = $path
	$toSet = StringReplace(_GetFileName($settingsMusic), '&', '&&')
	GUICtrlSetData($labels[0], $toSet)
	_ReduceMemory(@AutoItPID)
EndFunc

Func _SetLabelTextColor()
	For $i = 0 to 11 
		GUICtrlSetColor($labels[$i], $colorsText)
	Next
	GUICtrlSetColor($lblTitle, $colorsText)
	GUICtrlSetColor($lblAlbum, $colorsText)
	GUICtrlSetColor($lblArtist, $colorsText)
	GUICtrlSetColor($lblDuration, $colorsText)
	
	If $notiShowing then 
		For $i = 0 to 5
			GUICtrlSetColor($notiLabels[$i], $colorsText)
		Next
	EndIf
EndFunc

Func _SetNPButtons($enable)
	If $enable then 
		GUICtrlSetState($btnNPClearSelected, $GUI_ENABLE)
		GUICtrlSetState($btnNPClearAll, $GUI_ENABLE)
		GUICtrlSetState($btnPlay, $GUI_ENABLE)
		GUICtrlSetState($btnRandom, $GUI_ENABLE)
	Else 
		GUICtrlSetState($btnNPClearSelected, $GUI_DISABLE)
		GUICtrlSetState($btnNPClearAll, $GUI_DISABLE)
		GUICtrlSetState($btnPlay, $GUI_DISABLE)
		GUICtrlSetState($btnRandom, $GUI_DISABLE)		
	EndIf
EndFunc 

Func _SetPlayingState($state = $currentlyPlaying) ; Must be called after $currenID and $currentlyPlaying are set
	$colIndex = _GetItemIndex('Playing')
	If $colIndex = -1 then Return 
		
	$itemIndex = _GUICtrlListView_MapIDToIndex($lstNowPlayingHwnd, $currentID)
	
;~ 	ConsoleWrite('--> $itemIndex = ' & $itemIndex & @TAB & ' $colIndex = ' & $colIndex & @TAB & '$state = ' & $state & @CRLF)
	
	If $state = 1 then 
		_GUICtrlListView_SetItemText($lstNowplayingHwnd, $itemIndex, '>', $colIndex) 
	ElseIf $state = 2 then 
		_GUICtrlListView_SetItemText($lstNowplayingHwnd, $itemIndex, '||', $colIndex) 
	Else 
		_GUICtrlListView_SetItemText($lstNowplayingHwnd, $itemIndex, '', $colIndex) 
	EndIf 
EndFunc 	

Func _SetPlaylist()
	$settingsPosition = $settingsHistory & '\' & $NAME
	$data = IniReadSection($settingsPosition & '\' & 'NowPlaying.ini', 'NowPlaying')
	$uBound = UBound($data) - 1

	If $uBound = -1 then 
		_SetNPButtons(False)
		Return 
	EndIf 
	
	_GUICtrlListView_BeginUpdate($lstNowPlayingHwnd)
	ReDim $nowPlaying[$uBound + 1][$NUM_COLUMNS]
	
	For $i = 1 to $uBound
		If FileExists($data[$i][1]) then 
			_AddSong($data[$i][1])
		EndIf 
	Next

	_GUICtrlListView_EndUpdate($lstNowPlayingHwnd)
	
	_ReduceMemory(@AutoItPID)
EndFunc

Func _SetProgress();$killTimer = True)
	$currentProgress = GUICtrlRead($sldProgress) 
	$currentPlayed = _SoundPos($currentTrackID, 2) / 1000
;~ 	ConsoleWrite('> $currentProgress = ' & $currentProgress & @TAB & '$currentPlayed = ' & $currentPlayed & @CRLF)

	$temp = Round(($currentPlayed / $currentSongLength) * 100)

	If $currentProgress <> $temp and Not $seeking then 
		GUICtrlSetData($sldProgress, $temp) 
	EndIf
	
	$currentDur = _Trim(_SoundPos($currentTrackID, 1))
	If $currentDur & ' / ' & $currentSongDuration <> GUICtrlRead($lblDuration) then 
		GUICtrlSetData($lblDuration, $currentDur & ' / ' & $currentSongDuration)
	EndIf 

	If $currentDur = $currentSongDuration then 

		If $currentlyPLaying = 1 then 
			_Timer_KillTimer($mainGUI, $currentTimer)
			ConsoleWrite('! _SetProgress() --> Killing a timer' & @CRLF)
			AdLibEnable('_SetProgressNextSong', 1000)
		EndIf 
		Return False
	EndIf
	
	Return True
EndFunc

Func _SetProgressNextSong();$hWnd, $Msg, $iIDTimer, $dwTime)
	AdLibDisable()
	_Next()
EndFunc

Func _SetProgressTimer($hWnd, $Msg, $iIDTimer, $dwTime)
    #forceref $hWnd, $Msg, $iIDTimer, $dwTime
	_SetProgress()
EndFunc

Func _SetSeek() 
	ConsoleWrite('+> ' & GUICtrlRead($sldProgress) & @TAB & '$seeking = ' & $seeking & @CRLF)
	$newLocation = (GUICtrlRead($sldProgress) / 100) * $currentSongLength
	
	$remainderH = Mod($newLocation, 3600)
	$hours = ($newLocation - $remainderH) / 3600

	$remainderM = Mod($remainderH, 60)
	$minutes = ($remainderH - $remainderM) / 60 
	
	$seconds = $newLocation - $hours * 3600 - $minutes * 60
	
	_SoundSeek($currentTrackID, $hours, $minutes, $seconds)
		
	If $currentlyPlaying = 1 then 
		If _SetProgress() then ;False 
			ConsoleWrite('+> Continuing song...' & @CRLF)
			_SoundPlay($currentTrackID)
		EndIf
	Else 
		_SetProgress();False
	EndIf
	$seeking = False 
EndFunc

Func _SetPastSettings()
	$settingsPosition = $settingsHistory & '\' & $NAME
		GUICtrlSetData($sldVolume, IniRead($settingsPosition & '\Settings.ini', 'Volume', 'Set', 100))

	$shuffle = _StrToBool(IniRead($settingsPosition & '\Settings.ini', 'Shuffle', 'Background', False))
	
	$shuffle = Not $shuffle 
	_Shuffle()
EndFunc

Func _SetSongData()
	GuiCtrlSetData($lblTitle, StringReplace($currentData[0], '&', '&&'))
	GUICtrlSetData($lblAlbum, StringReplace($currentData[1], '&', '&&'))
	GUICtrlSetData($lblArtist, StringReplace($currentData[2], '&', '&&'))
EndFunc

Func _SetSongDataBlank()
	GuiCtrlSetData($lblTitle, '')
	GUICtrlSetData($lblAlbum, '')
	GUICtrlSetData($lblArtist, '')
	GUICtrlSetData($lblDuration, '')
EndFunc

Func _SetSel() 
	$cursor = False
	$text = _GUICtrlListView_GetItemTextArray($lstFoldersHwnd)
	$tempPreviewPath = $settingsMusic & '\' & $text[1]
	If $tempPreviewPath = $previewPath and _GUICtrlListView_GetItemCount($lstAvailableHwnd) > 0 then Return 
	$previewPath = $tempPreviewPath
	
	If DirGetSize($previewPath) > 600000000 then ;about 400mg
		GUISetCursor(1, 1)
		$cursor = True 
	EndIf 
	
	_GUICtrlListView_DeleteAllItems($lstAvailableHwnd)
	_GUICtrlListView_BeginUpdate($lstAvailableHwnd)
	
	
	$files = _FileListToArrayEx($previewPath, '*.mp3', 1, '', True) 
	If @error or Not IsArray($files) then 
		_GUICtrlListView_EndUpdate($lstAvailableHwnd)
		If $cursor then GUISetCursor(2)
		Return 
	EndIf
	
	For $i = 1 to $files[0] 
		_AddString($lstAvailable, StringTrimRight(_GetFileName($files[$i]), 4) & '|' & $files[$i])
	Next 
	
	_SetColumnWidthMinimum($lstAvailableHwnd)
	_GUICtrlListView_HideColumn($lstAvailableHwnd, 1)
	_GUICtrlListView_EndUpdate($lstAvailableHwnd)
	If $cursor then GUISetCursor(2)
	GUICtrlSetData($labels[1], StringReplace($text[1], '&', '&&'))
	_SetAButtons(True)
	_ReduceMemory(@AutoItPID)
EndFunc

Func _SetVolume() 
	SoundSetWaveVolume(GUICtrlRead($sldVolume))
EndFunc

Func _SetWindowTrans()
	If $windowTransEnabled then 
		If BitAnd(WinGetState($mainGUI), 8) = 8 or BitAnd(WinGetState($addGUI), 8) = 8 or BitAnd(WinGetState($nowPlayingGUI), 8) = 8 then 
			WinSetTrans($mainGUI, '', 255) 
			WinSetTrans($addGUI, '', 255) 
			WinSetTrans($nowPlayingGUI, '', 255) 
		Else 
			WinSetTrans($mainGUI, '', 255 - ($windowTrans * 2.55))
			WinSetTrans($addGUI, '', 255 - ($windowTrans * 2.55))
			WinSetTrans($nowPlayingGUI, '', 255 - ($windowTrans * 2.55))
		EndIf
	EndIf 
	If BitAnd(WinGetState($mainGUI), 8) = 8 then 
		GUISwitch($mainGUI)
	EndIf	
EndFunc
#EndRegion	
#Region *** OPTIONS ***
Func _Options()
;~ 	Msgbox(0, '', '')
	If WinExists($optionsGUI) and $optionsGUI <> '' then
		WinActivate($optionsGUI) 
		Return
	EndIf

	$tempColumnsNumShowing = $numColsShowing 
	Redim $tempColumnsToAdd[1]
	ReDim $tempColumnsToRemove[1]
	$tempColumnsToAdd[0] = 0
	$tempColumnsToRemove[0] = 0

	$tempColorsBK = $colorsBK
	$tempColorsText = $colorsText
	$tempColorsAlt = $colorsAlt
	$tempColorsAltEnabled = $colorsAltEnabled
	$tempColorsString = $colorsString
	$tempImportDisplay=  $importDisplay
	$tempImportDup = $importDup
	$tempNotificationEnabled = $notificationEnabled
	$tempNotificationFullScreen = $notificationFullScreen
	$tempNotificationAbove= $notificationAbove
	$tempNotificationTime = $notificationTime
	$tempNotificationX = $notificationX
	$tempNotificationY = $notificationY 
	$tempSettingsMusicInit = $settingsMusicInit
	$tempSettingsHistory = $settingsHistory
;~ 	$tempSettingsMSN = $settingsMSN
	$tempStartupPickup = $startupPickup
	$tempStartupWindows = $startupWindows
	$tempStartupUpdates = $startupUpdates
	$tempWindowTransEnabled = $windowTransEnabled
	$tempWindowTrans = $windowTrans
;~ 	$tempWindowHeight = $windowHeight
;~ 	Msgbox(0, '', '')
	$optionsGUI = GUICreate('KMP Options', 625, 344, 236, 175)
		GUISetOnEvent($GUI_EVENT_CLOSE, '_ExitOptions')
		GUISetBkColor($tempColorsBK, $optionsGUI)
;~ 		Msgbox(0, '', '')
		GUISwitch($optionsGUI)
	
	$lstMenu = GUICtrlCreateListView('', 5, 5, 145, 335, BitOR($LVS_REPORT, $LVS_NOCOLUMNHEADER, $LVS_SINGLESEL))
		GUICtrlSetFont(-1, 13)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_LV_ALTERNATE)
	$lstMenuHwnd = GUICtrlGetHandle($lstMenu)
		_GUICtrlListView_BeginUpdate($lstMenuHwnd)
		_GUICtrlListView_AddColumn($lstMenuHwnd, '')
		For $i = 0 to 8
			GUICtrlCreateListViewItem($names[$i], $lstMenu) 
				If $tempColorsAltEnabled then GUICtrlSetBkColor(-1, $tempColorsAlt)
		Next
		_GUICtrlListView_SetColumnWidth($lstMenuHwnd, 0, 141)
		_GUICtrlListView_ClickItem($lstMenuHwnd, 0)
		_GUICtrlListView_SetItemSelected($lstMenuHwnd, 0)
		_GUICtrlListView_EndUpdate($lstMenuHwnd)
	GUISwitch($optionsGUI)
;~ 	Msgbox(0, '', '')
	$lblCurrent = GUICtrlCreateLabel('About', 165, 10, 90, 23)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetFont(-1, 14)

	For $i = 0 to 8 
		Call('_Set' & $names[$i])
	Next
;~ 	Msgbox(0, '', '')
	$optionsIndex = 0
	$currentItem = ''
	_SetState(True)
;~ 	Msgbox(0, '', '')
	_DeactivateHotkeys()
;~ 	Msgbox(0, '', '')
	GUISwitch($mainGUI)
	GUISetState(@SW_SHOW, $optionsGUI)
;~ 	Msgbox(0, '', '')
EndFunc

Func _ExitOptions()
	_SetMenu(False)
	Local $reDraw = False ; Will be set to true if the lists need redrawn
	
	$colorsString = $tempColorsString
	If $colorsBK <> $tempColorsBK then 
		$colorsBK = $tempColorsBK 
		_SetBKColor()
	Else 
		$colorsBK = $tempColorsBK 
	EndIf 
		
	If $colorsText <> $tempColorsText then 
		$colorsText = $tempColorsText 
		_SetLabelTextColor()
	Else
		$colorsText = $tempColorsText 
	EndIf 
	
	If $colorsAlt <> $tempColorsAlt then $reDraw = True
	$colorsAlt = $tempColorsAlt 
	If $colorsAltEnabled <> $tempColorsAltEnabled then $reDraw = True
	$colorsAltEnabled = $tempColorsAltEnabled 
	
	_UpdateColumns()
	
	$numColsShowing = $tempColumnsNumShowing 
	
	$importDisplay = $tempImportDisplay
	$importDup = $tempImportDup 
	$notificationEnabled = $tempNotificationEnabled 
	$notificationFullScreen = $tempNotificationFullScreen 
	$notificationAbove = $tempNotificationAbove
	$notificationTime = $tempNotificationTime 
	$notificationX = $tempNotificationX 
	$notificationY  = $tempNotificationY 
	$settingsMusicInit = $tempSettingsMusicInit
	If $settingsHistory <> $tempSettingsHistory then 
		DirRemove($settingsHistory & '\KMP', 1)
		DirCreate($tempSettingsHistory & '\KMP')
	EndIf
	$settingsHistory = $tempSettingsHistory 
	$startupPickup = $tempStartupPickup 
	$startupWindows = $tempStartupWindows 
	$startupUpdates = $tempStartupUpdates 
	If $windowTransEnabled <> $tempWindowTransEnabled and $windowTransEnabled then 
		WinSetTrans($mainGUI, '', 255)
		WinSetTrans($nowPlayingGUI, '', 255)
		WinSetTrans($addGUI, '', 255)
	EndIf
		
	$windowTransEnabled = $tempWindowTransEnabled 
	$windowTrans = $tempWindowTrans

	
	If $reDraw then 
		_Redraw($lstNowPlaying)
		_Redraw($lstFolders)
		_Redraw($lstAvailable)
	EndIf
	
	_ActivateHotkeys()
	GUIDelete($optionsGUI)
	_ReduceMemory(@AutoItPID)
EndFunc 

Func _ExitOptionsQuick()
	_SetMenu(False)
	
	$colorsBK = $tempColorsBK 
	$colorsText = $tempColorsText 
	$colorsAlt = $tempColorsAlt 
	$colorsAltEnabled = $tempColorsAltEnabled 
	$colorsString = $tempColorsString
	$importDisplay = $tempImportDisplay
	$importDup = $tempImportDup 
	$notificationEnabled = $tempNotificationEnabled 
	$notificationFullScreen = $tempNotificationFullScreen 
	$notificationAbove = $tempNotificationAbove
	$notificationTime = $tempNotificationTime 
	$notificationX = $tempNotificationX 
	$notificationY  = $tempNotificationY 
	$settingsMusicInit = $tempSettingsMusicInit		
	$settingsHistory = $tempSettingsHistory 
;~ 	$settingsMSN = $tempSettingsMSN 
	$startupPickup = $tempStartupPickup 
	$startupWindows = $tempStartupWindows 
	$startupUpdates = $tempStartupUpdates 
	$windowTransEnabled = $tempWindowTransEnabled 
	$windowTrans = $tempWindowTrans
	GUIDelete($optionsGUI)
EndFunc

Func _SetState($bool) 
	If $bool then 
		$state = $GUI_SHOW 
	Else 
		$state = $GUI_HIDE
	EndIf
	
	For $i = 0 to UBound($optionsCtrls) - 1
		If $optionsCtrls[$optionsIndex][$i] = '' then Return
		GUICtrlSetState($optionsCtrls[$optionsIndex][$i], $state)
	Next
	
EndFunc 

Func _SetMenu($full = True)
	$tempSelIndex = _GUICtrlListView_GetSelectedIndices($lstMenuHwnd)
;~ 	ConsoleWrite('+ _SetMenu()' & @TAB & '$temp = ' & $tempSelIndex & @TAB & '$optionsIndex = ' & $optionsIndex & @CRLF)
	If $full then 
		If $tempSelIndex = -1 or $tempSelIndex = $optionsIndex then Return
	EndIf

;~ 	ConsoleWrite('+> _Save' & $currentItem & @CRLF)
	Call('_Save' & $currentItem)
	
	If Not $full then Return 
	
	_SetState(False) ;Hides all the controls with the $optionsIndex
	
	$currentItem = _GUICtrlListView_GetItemText($lstMenuHwnd, $tempSelIndex)
	$optionsIndex = $tempSelIndex
;~ 	If $currentItem = 'Hotkeys' then $optionsIndex = $HOTKEYSOPT
	
;~ 	ConsoleWrite('-> $currentItem = ' & $currentItem & @TAB & '$optionsIndex = ' & $optionsIndex & @CRLF)
	
	GUICtrlSetData($lblCurrent, $currentItem)
	
	_SetState(True);Shows all the controls with the new $optionsIndex
	If $currentItem = 'Hotkeys' then _WinAPI_ShowWindow($optionsCtrls[$HOTKEYSOPT][5], @SW_SHOW)
		
EndFunc
#Region *** SAVES ***
Func _SaveAbout()
	Return
EndFunc 

Func _SaveColors()
	$tempColorsAltEnabled = (GUICtrlRead($optionsCtrls[$optionsIndex][3]) = $GUI_CHECKED)
EndFunc 

Func _SaveColumns()
	
EndFunc 

Func _SaveHotkeys()	
	_SetHotkeysChange()

	
	$lastSelected = ''
	For $i = 0 to _GUICtrlListView_GetItemCount($tempHwnd) - 1
		$temp = _GUICtrlListView_GetItemTextArray($tempHwnd, $i) 
		If $temp[2] <> 'None' then 
			$lastSplit = StringSplit($temp[4], '-') 
			$hotkeys[$i][1] = $lastSplit[1]
			$hotkeys[$i][2] = $temp[3]
			$hotkeys[$i][3] = $lastSplit[2]
		Else 
			$hotkeys[$i][1] = 'None'
			$hotkeys[$i][2] = 'None'
			$hotkeys[$i][3] = 'None'
		EndIf
	Next
	
	_WinAPI_ShowWindow($optionsCtrls[$HOTKEYSOPT][5], @SW_HIDE)
	
EndFunc 

Func _SaveImporting()
	$tempImportDisplay = (GUICtrlRead($optionsCtrls[$optionsIndex][1]) = $GUI_CHECKED)
	$tempImportDup = (GUICtrlRead($optionsCtrls[$optionsIndex][2]) = $GUI_CHECKED)
EndFunc 

Func _SaveNotification()
	$tempNotificationEnabled = (GUICtrlRead($optionsCtrls[$optionsIndex][0]) = $GUI_CHECKED)
	$tempNotificationFullScreen = (GUICtrlRead($optionsCtrls[$optionsIndex][1]) = $GUI_CHECKED)
	$tempNotificationAbove = (GUICtrlRead($optionsCtrls[$optionsIndex][2]) = $GUI_CHECKED)
	$tempNotificationTime = GUICtrlRead($optionsCtrls[$optionsIndex][4])
	If $tempNotificationTime < 2 then $tempNotificationTime = 2
	If $tempNotificationtime > 10 then $tempNotificationTime = 10
EndFunc 

Func _SaveSettings()
	$tempSettingsMusicInit = GUICtrlRead($optionsCtrls[$optionsIndex][1])
	$tempSettingsHistory = GUICtrlRead($optionsCtrls[$optionsIndex][5])
;~ 	$tempSettingsMSN = (GUICtrlRead($optionsCtrls[$optionsIndex][9]) = $GUI_CHECKED)	

	If Not FileExists($tempSettingsMusicInit) then 
		$tempSettingsMusicInit = _GetMusicDir()
	EndIf
	If Not FileExists($tempSettingsHistory) then 
		$tempSettingsHistory = _GetMusicDir()
	EndIf
EndFunc 

Func _SaveStartup()
	$tempStartupPickup = (GUICtrlRead($optionsCtrls[$optionsIndex][0]) = $GUI_CHECKED)
	$tempStartupWindows = (GUICtrlRead($optionsCtrls[$optionsIndex][1]) = $GUI_CHECKED)
	$tempStartupUpdates = (GUICtrlRead($optionsCtrls[$optionsIndex][2]) = $GUI_CHECKED)	
EndFunc 

Func _SaveWindow()
	$tempWindowTransEnabled = (GUICtrlRead($optionsCtrls[$optionsIndex][0]) = $GUI_CHECKED)
	$tempWindowTrans = GUICtrlRead($optionsCtrls[$optionsIndex][2])
EndFunc 
#EndRegion
#Region *** SETS ***
Func _SetAbout()
	$optionsCtrls[$ABOUT][0] = GUICtrlCreateLabel('Welcome to Knight Media Player beta v' & $VERSION & '!', 175, 40, 300, 20)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)	
	$optionsCtrls[$ABOUT][1] = GUICtrlCreateLabel('Any settings you change here will be updated when you exit the options window', 175, 70, 520, 20)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)	
	$optionsCtrls[$ABOUT][2] = GUICtrlCreateLabel('KMP was created by Michael McFarland using AutoIt', 175, 100, 520, 20)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)	
EndFunc 

Func _SetColors()
	$optionsCtrls[$COLORS][0] = GUICtrlCreateLabel('Select a default color option or change the individual settings...', 175, 40, 500, 20)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$COLORS][5] = GUICtrlCreateCombo('', 195, 70, 155, 25, $CBS_DROPDOWNLIST)
		GUICtrlSetData(-1, $colorChoices, $tempColorsString)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$COLORS][6] = GUICtrlCreateButton('Set preview', 355, 68, 80, 25)
		GUICtrlSetOnEvent(-1, '_SetColorsPreview')
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$COLORS][1] = GUICtrlCreateButton('Change background color', 195, 105, 240, 25) 
		GUICtrlSetOnEvent(-1, '_SetColorsChangeBK')
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$COLORS][2] = GUICtrlCreateButton('Change text color', 195, 140, 240, 25) 
		GUICtrlSetOnEvent(-1, '_SetColorsChangeTXT')
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$COLORS][3] = _GUICtrlCreateCheckBoxEx('Use alternating colors in lists', 195, 205, 300, 20)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
		If $tempColorsAltEnabled then GUICtrlSetState(-1, $GUI_CHECKED) 
	$optionsCtrls[$COLORS][4] = GUICtrlCreateButton('Change alternative color', 195, 235, 240, 25) 
		GUICtrlSetOnEvent(-1, '_SetColorsChangeALT')
		GUICtrlSetState(-1, $GUI_HIDE)
EndFunc 

Func _SetColumns()
	$optionsCtrls[$COLUMNS][0] = GUICtrlCreateLabel('The list on the left contains the columns that appear in your "Now Playing" list...', 175, 40, 500, 20)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)	
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$COLUMNS][1] = GUICtrlCreateLabel('Showing...', 195, 70, 150, 20) 
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$COLUMNS][2] = GUICtrlCreateLabel('Not showing...', 400, 70, 150, 20)	
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$COLUMNS][3] = GUICtrlCreateListView('', 195, 90, 150, 200, BitOR($LVS_REPORT, $LVS_NOCOLUMNHEADER, $LVS_SINGLESEL)) 
			GUICtrlSetBkColor(-1, $GUI_BKCOLOR_LV_ALTERNATE)
		$tempShowingHwnd = GUICtrlGetHandle($optionsCtrls[$COLUMNS][3])
		_GUICtrlListView_AddColumn($tempShowingHwnd, '', 145)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$COLUMNS][4] = GUICtrlCreateListView('', 400, 90, 150, 200, BitOR($LVS_REPORT, $LVS_NOCOLUMNHEADER, $LVS_SINGLESEL))
			GUICtrlSetBkColor(-1, $GUI_BKCOLOR_LV_ALTERNATE)
		$tempHidingHwnd = GUICtrlGetHandle($optionsCtrls[$COLUMNS][4])
		_GUICtrlListView_AddColumn($tempHidingHwnd, '', 145)
		GUICtrlSetState(-1, $GUI_HIDE)
	
	$optionsCtrls[$COLUMNS][5] = GUICtrlCreateButton('>>', 350, 150, 45, 25)
		GUICtrlSetTip(-1, 'Move selected item off your "Now Playing" list')
		GUICtrlSetOnEvent(-1, '_SetColumnsRight')
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$COLUMNS][6] = GUICtrlCreateButton('<<', 350, 180, 45, 25) 
		GUICtrlSetTip(-1, 'Move selected item to your "Now Playing" list')
		GUICtrlSetOnEvent(-1, '_SetColumnsLeft')
		GUICtrlSetState(-1, $GUI_HIDE)
		
	For $i = 0 to $NUM_COLUMNS - 1 
		If $columnStatus[$i][1] then 
			GUICtrlCreateListViewItem($columnStatus[$i][2], $optionsCtrls[$COLUMNS][3])
		Else
			GUICtrlCreateListViewItem($columnStatus[$i][2], $optionsCtrls[$COLUMNS][4])
		EndIf 
		If $tempColorsAltEnabled then GUICtrlSetBkColor(-1, $tempColorsAlt)
	Next
EndFunc 

Func _SetHotkeys()
	$optionsCtrls[$HOTKEYSOPT][0] = GUICtrlCreateLabel('Click on an item to set or modify its keyboard shortcut...', 175, 40, 300, 20) 
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)	
	$optionsCtrls[$HOTKEYSOPT][1] = GUICtrlCreateListView('', 175, 65, 420, 162, BitOR($LVS_NOSORTHEADER, $LVS_SHOWSELALWAYS, $LVS_REPORT), BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT)) 
		GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_LV_ALTERNATE)
	$tempHwnd = GUICtrlGetHandle($optionsCtrls[$HOTKEYSOPT][1])
		_GUICtrlListView_AddColumn($tempHwnd, 'Action', 150)
		_GUICtrlListView_AddColumn($tempHwnd, 'Hotkey', 140)
		_GUICtrlListView_AddColumn($tempHwnd, 'Global', 109)
		_GUICtrlListView_AddColumn($tempHwnd, 'Code', 0)
		_GUICtrlListView_SetItemSelected($tempHwnd, 0)
		_SetHotkeysLoad($tempHwnd)
		$tempHwndHeader = _GUICtrlListView_GetHeader($tempHwnd)
		
	$optionsCtrls[$HOTKEYSOPT][2] = GUICtrlCreateLabel('Selected action: ', 175, 240, 200, 20, $SS_CENTERIMAGE) 
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$HOTKEYSOPT][3] = GUICtrlCreateLabel('', 275, 240, 100, 20, $SS_CENTERIMAGE)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)	
	$optionsCtrls[$HOTKEYSOPT][4] = GUICtrlCreateLabel('Current hotkey: ', 175, 270, 90, 20, $SS_CENTERIMAGE) 
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$HOTKEYSOPT][5] = _CreateHotkey($optionsGUI, 275, 270, 120, 20)
		_WinAPI_ShowWindow($optionsCtrls[$HOTKEYSOPT][5], @SW_HIDE)
		
	
	$optionsCtrls[$HOTKEYSOPT][6] = _GUICtrlCreateCheckBoxEx('Global', 175, 300, 70, 20) 
		GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)	
	_GUICtrlListView_SetItemSelected($tempHwnd, 0)
	_SetHotkeysChange()
EndFunc 

Func _SetImporting()
	$optionsCtrls[$IMPORTING][0] = GUICtrlCreateLabel('These options are for when you add songs to your "Now Playing" list...', 175, 40, 340, 20) 
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$IMPORTING][1] = _GUICtrlCreateCheckBoxEx('Display a list of songs that could not be added', 195, 70, 250, 20)
		If $tempImportDisplay then GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$IMPORTING][2] = _GUICtrlCreateCheckBoxEx("Don't add a song if it is already in the " & '"Now Playing" list', 195, 100, 290, 20)
		If $tempImportDup then GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$IMPORTING][3] = GUICtrlCreateButton('Remove duplicates now', 195, 130, 200, 25)
		GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlSetOnEvent(-1, '_RemoveDups')
EndFunc 

Func _SetNotification()
	$optionsCtrls[$NOTIFICATION][0] = _GUICtrlCreateCheckBoxEx('Display a window with the new song name and artist when the current track changes', 175, 40, 430, 20) 
		If $tempNotificationEnabled then GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$NOTIFICATION][1] = _GUICtrlCreateCheckBoxEx("Disable notification when a full screen application is running", 195, 70, 300, 20)
		If $tempNotificationFullScreen then GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$NOTIFICATION][2] = _GUICtrlCreateCheckBoxEx('Keep the notification window above other windows', 195, 100, 280, 20)
		If $tempNotificationAbove then GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$NOTIFICATION][3] = GUICtrlCreateLabel('Display the notification for', 195, 130, 130, 20, $SS_CENTERIMAGE)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$NOTIFICATION][4] = GUICtrlCreateInput($tempNotificationTime, 325, 130, 40, 20, $ES_NUMBER) 
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$NOTIFICATION][5] = GUICtrlCreateUpdown($optionsCtrls[$NOTIFICATION][4], $UDS_ARROWKEYS)
		GUICtrlSetLimit($optionsCtrls[$NOTIFICATION][5], 1, 10)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$NOTIFICATION][6] = GUICtrlCreateLabel('seconds', 370, 130, 60, 20, $SS_CENTERIMAGE)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$NOTIFICATION][7] = GUICtrlCreateButton('Set the noficiation area', 195, 160, 200, 25)
		GUICtrlSetOnEvent(-1, '_SetNotificationArea')
		GUICtrlSetState(-1, $GUI_HIDE)
EndFunc 

Func _SetSettings()
	$optionsCtrls[$SETTINGS][0] = GUICtrlCreateLabel('This path specifies which folder is originally open for you to browse:', 175, 50, 320, 20) 
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$SETTINGS][1] = GUICtrlCreateInput($tempSettingsMusicInit, 195, 75, 300, 20)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$SETTINGS][2] = GUICtrlCreateButton('Restore default path', 194, 100, 147, 23)
		GUICtrlSetOnEvent(-1, '_SetSettingsRestore')
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$SETTINGS][3] = GUICtrlCreateButton('Browse for a new path...', 350, 100, 147, 23)
		GUICtrlSetOnEvent(-1, '_SetSettingsBrowse')
		GUICtrlSetState(-1, $GUI_HIDE)

	$optionsCtrls[$SETTINGS][4] = GUICtrlCreateLabel('This path specifies where your settings and history are saved:', 175, 150, 320, 20) 
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$SETTINGS][5] = GUICtrlCreateInput($tempSettingsHistory, 195, 175, 300, 20)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$SETTINGS][6] = GUICtrlCreateButton('Restore default path', 194, 200, 147, 23)
		GUICtrlSetOnEvent(-1, '_SetSettingsRestore')
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$SETTINGS][7] = GUICtrlCreateButton('Browse for a new path...', 350, 200, 147, 23)
		GUICtrlSetOnEvent(-1, '_SetSettingsBrowse')
		GUICtrlSetState(-1, $GUI_HIDE)
	
;~ 	$optionsCtrls[$SETTINGS][8] = GUICtrlCreateLabel($NAME & ' can change your Windows Live Messenger personal message to display the current song.', 175, 250, 280, 30) 
;~ 		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
;~ 		GUICtrlSetColor(-1, $tempColorsText)
;~ 		GUICtrlSetState(-1, $GUI_HIDE)
;~ 	$optionsCtrls[$SETTINGS][9] = _GUICtrlCreateCheckBoxEx('Enable this feature', 195, 285, 110, 20)
;~ 		If $tempSettingsMSN then GUICtrlSetState(-1, $GUI_CHECKED)
;~ 		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
;~ 		GUICtrlSetColor(-1, $tempColorsText)
;~ 		GUICtrlSetState(-1, $GUI_HIDE)
EndFunc 

Func _SetStartup()
	$optionsCtrls[$STARTUP][0] = _GUICtrlCreateCheckBoxEx('Automatically resume playback when program starts', 175, 50, 270, 20) 
		If $tempStartupPickup then GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$STARTUP][1] = _GUICtrlCreateCheckBoxEx('Run program when Windows starts', 175, 100, 190, 20) 
		If $tempStartupWindows then GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$STARTUP][2] = _GUICtrlCreateCheckBoxEx('Check for updates when program starts', 175, 150, 210, 20) 
		If $tempStartupUpdates then GUICtrlSetState(-1, $GUI_CHECKED)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$STARTUP][3] = GUICtrlCreateButton('Check for updates now', 175, 200, 200, 25) 
		GUICtrlSetState(-1, $GUI_HIDE)
		GUICtrlSetOnEvent(-1, '_SetStartupUpdates')
EndFunc 

Func _SetWindow()
	$optionsCtrls[$WINDOW][0] = _GUICtrlCreateCheckBoxEx('Enable transparency when the main window looses focus', 175, 50, 300, 20) 
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)	
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$WINDOW][1] = GUICtrlCreateLabel('Transparency:', 195, 80, 75, 20, $SS_CENTERIMAGE)
		GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
		GUICtrlSetColor(-1, $tempColorsText)
		GUICtrlSetState(-1, $GUI_HIDE)
	$optionsCtrls[$WINDOW][2] = GUICtrlCreateSlider(270, 77, 200, 26, BitOR($TBS_TOOLTIPS, $TBS_NOTICKS))
		GUICtrlSetBkColor(-1, $tempColorsBK)
		GUICtrlSetState(-1, $GUI_HIDE)
		If $tempWindowTransEnabled then GUICtrlSetState($optionsCtrls[$WINDOW][0], $GUI_CHECKED)
		GUICtrlSetData($optionsCtrls[$WINDOW][2], $tempWindowTrans)
EndFunc 
#EndRegion

#Region *** Helper Functions ***
Func _SetColorsChangeBK()
	$tempColor = _ChooseColor(2, $tempColorsBK, 2, $optionsGUI)
	If @error then Return 
	$tempColorsBK = $tempColor 
	
	_SetColorsChangeBKRealize()
EndFunc

Func _SetColorsChangeBKRealize()
	GUISetBkColor($tempColorsBK, $optionsGUI)
	GUICtrlSetBkColor($optionsCtrls[$WINDOW][2], $tempColorsBk)
EndFunc

Func _SetColorsChangeTXT()
	$tempColor = _ChooseColor(2, $tempColorsText, 2, $optionsGUI)
	If @error then Return 
	$tempColorsText = $tempColor 
	
	_SetColorsChangeTXTRealize()
EndFunc

Func _SetColorsChangeTXTRealize()
	GUICtrlSetColor($lblCurrent, $tempColorsText)

	For $i = 0 to 2 
		GUICtrlSetColor($optionsCtrls[$ABOUT][$i], $tempColorsText)
		GUICtrlSetColor($optionsCtrls[$COLUMNS][$i], $tempColorsText)
		GUICtrlSetColor($optionsCtrls[$IMPORTING][$i], $tempColorsText)
		GUICtrlSetColor($optionsCtrls[$NOTIFICATION][$i], $tempColorsText)
		GUICtrlSetColor($optionsCtrls[$STARTUP][$i], $tempColorsText)
		GUICtrlSetColor($optionsCtrls[$WINDOW][$i], $tempColorsText)
	Next
	GUICtrlSetColor($optionsCtrls[$COLORS][0], $tempColorsText)
	GUICtrlSetColor($optionsCtrls[$COLORS][3], $tempColorsText)
	
	GUICtrlSetColor($optionsCtrls[$HOTKEYSOPT][0], $tempColorsText)
	GUICtrlSetColor($optionsCtrls[$HOTKEYSOPT][6], $tempColorsText)
	For $i = 2 to 4
		GUICtrlSetColor($optionsCtrls[$HOTKEYSOPT][$i], $tempColorsText)
	Next
	
	GUICtrlSetColor($optionsCtrls[$NOTIFICATION][3], $tempColorsText)
	GUICtrlSetColor($optionsCtrls[$NOTIFICATION][6], $tempColorsText)
	
	GUICtrlSetColor($optionsCtrls[$SETTINGS][0], $tempColorsText)
	GUICtrlSetColor($optionsCtrls[$SETTINGS][4], $tempColorsText)
EndFunc

Func _SetColorsChangeALT()
	$tempColor = _ChooseColor(2, $tempColorsAlt, 2, $optionsGUI)
	If @error then Return 
	$tempColorsAlt = $tempColor 
	_SetColorsRedrawLists()
EndFunc

Func _SetColorsRedrawLists()
	_SetColorsRedrawSingle($lstMenu)
	_SetColorsRedrawSingle($optionsCtrls[$HOTKEYSOPT][1])
	_SetColorsRedrawSingle($optionsCtrls[$COLUMNS][3])
	_SetColorsRedrawSingle($optionsCtrls[$COLUMNS][4])
EndFunc

Func _SetColorsRedrawSingle($hwnd) 
	$max = _GUICtrlListView_GetItemCount($hwnd) 
	If $max = 0 then Return
		
	Local $array[$max]
	For $i = 0 to $max - 1
		$array[$i] = _GUICtrlListView_GetItemTextString($hwnd, $i)
	Next 

	_GUICtrlListView_BeginUpdate($hwnd)
	_GUICtrlListView_DeleteAllItems($hwnd)
	For $i = 0 to $max - 1
		GUICtrlCreateListViewItem($array[$i], $hwnd) 
			If $tempColorsAltEnabled then GUICtrlSetBkColor(-1, $tempColorsAlt)
	Next
	
	If $hwnd = $optionsCtrls[$HOTKEYSOPT][1] then 
		_GUICtrlListView_HideColumn($tempHwnd, 3) 
	EndIf
	
	_GUICtrlListView_EndUpdate($hwnd)	
EndFunc 

Func _SetColorsPreview()
	$tempColorsString = GUICtrlRead($optionsCtrls[$COLORS][5])
	Switch $tempColorsString
		Case 'Black'
			$tempColorsBK = '0x000000'
			$tempColorsText = '0xFFFFFF'
			$tempColorsAlt = '0xEBEBEB'
		Case 'Blue'
			$tempColorsBK = '0x8CC8F4'
			$tempColorsText = '0x070D41'
			$tempColorsAlt = '0xE3EFFD'	
		Case 'Dark Blue'
			$tempColorsBK = '0x000040'
			$tempColorsText = '0xE3D7FF'
			$tempColorsAlt = '0xF2F2FF'		
		Case 'Gray and Blue'
			$tempColorsBK = '0x282828'
			$tempColorsText = '0xBFBFFF'
			$tempColorsAlt = '0xE1E1FF'	
		Case 'Gray and Orange'
			$tempColorsBK = '0x282828'
			$tempColorsText = '0xFF8000'
			$tempColorsAlt = '0xFEEDCB'
		Case 'Purple'
			$tempColorsBK = '0x4E0343'
			$tempColorsText = '0xF59EE9'
			$tempColorsAlt = '0xFADAF4'	
		Case 'Red'
			$tempColorsBK = '0x510000'
			$tempColorsText = '0xFFDDDD'
			$tempColorsAlt = '0xFFECEC'		
		Case 'Turquoise'
			$tempColorsBK = '0x006258'
			$tempColorsText = '0xDAFBFE'
			$tempColorsAlt = '0xE2FDFE'			
	EndSwitch
	
	_SetColorsChangeBKRealize()
	_SetColorsChangeTXTRealize()
	_SetColorsRedrawLists()	
EndFunc

Func _SetColumnsLeft()
	_GUICtrlListView_BeginUpdate($tempHidinghwnd)
	_GUICtrlListView_BeginUpdate($tempShowingHwnd)
	$selected = _GUICtrlListView_GetSelectedIndices($tempHidinghwnd) 
	If $selected = -1 then Return
	$tempText = _GUICtrlListView_getItemText($tempHidinghwnd, $selected)
	
;~ 	ConsoleWrite('> Searching $tempColumnsToAdd for ' & $tempText & ' = ' &  _ArraySearch($tempColumnsToAdd, $tempText, 1) & @CRLF)
	If _ArraySearch($tempColumnsToAdd, $tempText, 1) = -1 then
		$tempIndex = _ArraySearch($tempColumnsToRemove, $tempText, 1)
		If $tempIndex > -1 then 
			_ArrayDelete($tempColumnsToRemove, $tempIndex) 
			$tempColumnsToRemove[0] -= 1
		EndIf
		
		$tempColumnsNumShowing += 1
		$tempColumnsToAdd[0] += 1
		ReDim $tempColumnsToAdd[$tempColumnsToAdd[0] + 1] 
		$tempColumnsToAdd[$tempColumnsToAdd[0]] = $tempText
	EndIf 

	GUICtrlCreateListViewItem($tempText, $optionsCtrls[$COLUMNS][3])
		If $tempColorsAltEnabled then GUICtrlSetBkColor(-1, $tempColorsAlt)
	_GUICtrlListView_DeleteItem($tempHidingHwnd, $selected)
	_GUICtrlListView_EndUpdate($tempHidinghwnd)
	_GUICtrlListView_EndUpdate($tempShowingHwnd)
EndFunc 

Func _SetColumnsRight()
	_GUICtrlListView_BeginUpdate($tempHidinghwnd)
	_GUICtrlListView_BeginUpdate($tempShowingHwnd)
	$selected = _GUICtrlListView_GetSelectedIndices($tempShowingHwnd) 
	If $selected = -1 then Return
	
;~ 	If $tempColumnsNumShowing = 1 then 
;~ 		Msgbox(46, 'Warning', 'You can not remove all columns.')
;~ 		Return 
;~ 	EndIf
	
	$tempText = _GUICtrlListView_getItemText($tempShowingHwnd, $selected)
	
;~ 	ConsoleWrite('> Searching $tempColumnsToRemove for ' & $tempText & ' = ' & _ArraySearch($tempColumnsToRemove, $tempText, 1) & @CRLF)
	If _ArraySearch($tempColumnsToRemove, $tempText, 1) = -1 then 
		$tempIndex = _ArraySearch($tempColumnsToAdd, $tempText, 1)
		If $tempIndex > -1 then 
			_ArrayDelete($tempColumnsToAdd, $tempIndex) 
			$tempColumnsToAdd[0] -= 1
		EndIf
		
		$tempColumnsNumShowing -= 1
		$tempColumnsToRemove[0] += 1
		ReDim $tempColumnsToRemove[$tempColumnsToRemove[0] + 1] 
		$tempColumnsToRemove[$tempColumnsToRemove[0]] = $tempText		
	EndIf 
	
	GUICtrlCreateListViewItem($tempText, $optionsCtrls[$COLUMNS][4])
		If $tempColorsAltEnabled then GUICtrlSetBkColor(-1, $tempColorsAlt)
	_GUICtrlListView_DeleteItem($tempShowingHwnd, $selected)
	_GUICtrlListView_EndUpdate($tempHidinghwnd)
	_GUICtrlListView_EndUpdate($tempShowingHwnd)
EndFunc

Func _SetHotkeysChange()
	If $lastSelected <> '' then 
		$index = _GUICtrlListView_FindInText($tempHwnd, $lastSelected) 
		
		$code = _GetCode($optionsCtrls[$HOTKEYSOPT][5])
		If $code[0] = '' then 
			_GUICtrlListView_SetItemText($tempHwnd, $index,  'None', 1)
			_GUICtrlListView_SetItemText($tempHwnd, $index,  '', 2) 
			_GUICtrlListView_SetItemText($tempHwnd, $index,  'None', 3) 
		Else 
			_GUICtrlListView_SetItemText($tempHwnd, $index,  _ConvertToHotkey($code[0]), 1)
			_GUICtrlListView_SetItemText($tempHwnd, $index,  $code[0] & '-' & $code[1], 3) 

			If GUICtrlRead($optionsCtrls[$HOTKEYSOPT][6]) = $GUI_CHECKED then 
				_GUICtrlListView_SetItemText($tempHwnd, $index,  True, 2) 
			Else 
				_GUICtrlListView_SetItemText($tempHwnd, $index,  False, 2) 
			EndIf
		EndIf 
	EndIf 
	
;~ 	If Not $full then Return
	
	$selected = _GUICtrlListView_GetItemTextArray($tempHwnd) 
	If $lastSelected = $selected[1] then Return
	GUICtrlSetData($optionsCtrls[$HOTKEYSOPT][3], $selected[1])

	$temp = StringSplit($selected[4], '-')
	If Not @error then 
		_SendMessage($optionsCtrls[$HOTKEYSOPT][5], $HKM_SETHOTKEY, $temp[2], 0)
	Else 
		_SendMessage($optionsCtrls[$HOTKEYSOPT][5], $HKM_SETHOTKEY, '', 0)
	EndIf
	
	If $selected[3] = 'True' then 
		GUICtrlSetState($optionsCtrls[$HOTKEYSOPT][6], $GUI_CHECKED)
	Else 
		GUICtrlSetState($optionsCtrls[$HOTKEYSOPT][6], $GUI_UNCHECKED)
	EndIf
	
	$lastSelected = $selected[1]
EndFunc

Func _SetHotkeysLoad($hWnd)
	$file = $tempSettingsHistory & '\Settings.ini'
	
	_GUICtrlListView_BeginUpdate($hWnd)
	For $i = 0 to UBound($hotkeys) - 1
		;Hotkey String | Code | Global 
;~ 		$index = ($hWnd, ) 
		$textToAdd = $hotkeys[$i][0] & '|'
		
		If $hotkeys[$i][1] = 'None' then 
			$textToAdd &= 'None||None'
		Else 
			$textToAdd &= _ConvertToHotkey($hotkeys[$i][1]) & '|' & $hotkeys[$i][2] & '|' & $hotkeys[$i][1] & '-' & $hotkeys[$i][3]
		EndIf
;~ 		Msgbox(0, '', $textToAdd)
		_AddString($optionsCtrls[$HOTKEYSOPT][1], $textToAdd)
	Next 
	_GUICtrlListView_HideColumn($hWnd, 3)
	_GUICtrlListView_EndUpdate($hWnd)
EndFunc

Func _SetNotificationArea()
	WinSetState($optionsGUI, '', @SW_DISABLE)
	$notificationGUI = GUICreate('Preview', 260, 60, $tempNotificationX, $tempNotificationY, -1, -1, $optionsGUI)
		GUISetBkColor($tempColorsBK, $notificationGUI)
		WinSetOnTop($notificationGUI, '', 1)
		GUISetOnEvent($GUI_EVENT_CLOSE, '_SetNotificationClose', $notificationGUI)
		GUICtrlCreateLabel('Close this window to set the current position as the notification position...', 5, 15, 190, 30, $SS_CENTER)
			GUICtrlSetColor(-1, $tempColorsText)
	GUISetState(@SW_SHOW, $notificationGUI)
;~ 	GUISwitch($mainGUI)
EndFunc 

Func _SetNotificationClose()
	$temp = WinGetPos('Preview') 
	$tempNotificationX = $temp[0] 
	$tempNotificationY = $temp[1]
	WinSetState($optionsGUI, '', @SW_ENABLE)
	GUIDelete($notificationGUI)
EndFunc

Func _SetSettingsBrowse() 
	$temp = FileSelectFolder('Select a new folder path...', @HomePath)
	If @error then 
		Return 
	Else 
		GUICtrlSetData(@GUI_CtrlId - 2, $temp) 
	EndIf 
EndFunc 

Func _SetSettingsRestore()
	If @GUI_CtrlId = $optionsCtrls[$SETTINGS][2] then 
		GUICtrlSetData($optionsCtrls[$SETTINGS][1], _GetMusicDir())
	Else 
		GUICtrlSetData($optionsCtrls[$SETTINGS][5], @TempDir)
	EndIf
EndFunc

Func _SetStartupUpdates()
	GUICtrlSetState(@GUI_CtrlId, $GUI_DISABLE)
	_CheckForUpdates(True)
EndFunc 
#EndRegion
#EndRegion
#region *** Hot Keys ***
Func _ActivateHotkeys() 
;~ 	_ArrayDisplay($hotkeys)
	
	For $i = 0 to UBound($hotkeys) - 1
		If $hotkeys[$i][1] <> 'None' and $hotkeys[$i][1] <> '' then 
;~ 			ConsoleWrite('!Activating hotkey ' & $hotkeys[$i][1] & ' to the function ' & $hotkeys[$i][4] & @CRLF)
			HotKeySet($hotkeys[$i][1], $hotkeys[$i][4] & 'Hotkey')
		EndIf
	Next 	
EndFunc 

Func _DeactivateHotkeys()
	For $i = 0 to UBound($hotkeys) - 1
		HotKeySet($hotkeys[$i][1])
	Next 	
EndFunc

Func _LoadHotkeys()
;~ 	_ArrayDisplay($hotkeys)
	If UBound($hotkeys) = 0 then Return
	Local $array[UBound($hotkeys)] = ['_PlayPause', '_Next', '_Back', '_Stop', '_Random', '_Options', _
		'_VolumeUp', '_VolumeDown', '_VolumeMute', '_RemoveDuplicates']
	$settingsPosition = $settingsHistory & '\' & $NAME
	
	For $i = 0 to UBound($hotkeys) - 1
		$temp = IniRead($settingsPosition & '\Settings.ini', 'HotkeysHist', $hotkeys[$i][0], 'None-None-None')
		$temp = StringSplit($temp, '-')
		$hotkeys[$i][1] = $temp[1] ; Actual String of the Hotkey (e.g. ^a)
		If $temp[2] <> 'None' then 
			$hotkeys[$i][2] = _StrToBool($temp[3]) ; Boolean: Global or Local
		Else 
			$hotkeys[$i][2] = 'None'
		EndIf
		$hotkeys[$i][3] = $temp[2] ; Code for the hotkey
		$hotkeys[$i][4] = $array[$i] ; The function that it calls
	Next 
	
;~ 	_ArrayDisplay($hotkeys)
EndFunc 

Func _ClearHotkey()
	If WinActive($mainGUI) then	
		$data = GUIGetCursorInfo()
		If Not IsArray($data) then Return
		If $data[4] = $lstNowPlaying then 
			_ClearSelectedNP() 
		ElseIf $data[4] = $lstAvailable then 
			_ClearSelectedAV()
		EndIf 	
	Else 
		HotKeySet('{DEL}') 
		Send('{DEL}')
		HotKeySet('{DEL}', '_ClearHotkey')
	EndIf
EndFunc 

Func _SelectAllHotkey()
	If WinActive($mainGUI) then 
		$data = GUIGetCursorInfo()
		If Not IsArray($data) then Return
		If $data[4] = $lstNowPlaying then 
			_GUICtrlListView_SetItemSelected($lstNowPlayingHwnd, -1)
		ElseIf $data[4] = $lstAvailable then 
			_GUICtrlListView_SetItemSelected($lstAvailableHwnd, -1)
		EndIf
	Else 
		HotKeySet('^a') 
		Send('^a')
		HotKeySet('^a', '_SelectAllHotkey')
	EndIf
EndFunc

Func _PlayPauseHotkey()
	If Not $hotkeys[$HOTKEYPLAYPAUSE][2] then 
		If Not WinActive($mainGUI) then 
			HotKeySet($hotkeys[$HOTKEYPLAYPAUSE][1]) 
			Send($hotkeys[$HOTKEYPLAYPAUSE][1])
			HotKeySet($hotkeys[$HOTKEYPLAYPAUSE][1], $hotkeys[$HOTKEYPLAYPAUSE][4] & 'Hotkey') 
			Return 
		EndIf 
	EndIf 
		
	If $currentlyPlaying <> 1 then 
		_PlaySelected() 
	Else 
		_Pause()
	EndIf
EndFunc 

Func _NextHotkey()
	If Not $hotkeys[$HOTKEYNEXT][2] then 
		If Not WinActive($mainGUI) then	
			HotKeySet($hotkeys[$HOTKEYNEXT][1]) 
			Send($hotkeys[$HOTKEYNEXT][1])
			HotKeySet($hotkeys[$HOTKEYNEXT][1], $hotkeys[$HOTKEYNEXT][4] & 'Hotkey') 
			Return 
		EndIf 
	EndIf 
	
	_Next()		
EndFunc 

Func _BackHotkey()
	If Not $hotkeys[$HOTKEYBACK][2] then 
		If Not WinActive($mainGUI) then 
			HotKeySet($hotkeys[$HOTKEYBACK][1]) 
			Send($hotkeys[$HOTKEYBACK][1])
			HotKeySet($hotkeys[$HOTKEYBACK][1], $hotkeys[$HOTKEYBACK][4] & 'Hotkey') 
			Return 
		EndIf 
	EndIf	
	
	_Back()	
EndFunc

Func _StopHotkey()
	If Not $hotkeys[$HOTKEYSTOP][2] then 
		If Not WinActive($mainGUI) then 
			HotKeySet($hotkeys[$HOTKEYSTOP][1]) 
			Send($hotkeys[$HOTKEYSTOP][1])
			HotKeySet($hotkeys[$HOTKEYSTOP][1], $hotkeys[$HOTKEYSTOP][4] & 'Hotkey') 
			Return 
		EndIf 
	EndIf		
	
	_StopFull()	
EndFunc 

Func _RandomHotkey()
	If Not $hotkeys[$HOTKEYRANDOM][2] then 
		If Not WinActive($mainGUI) then 
			HotKeySet($hotkeys[$HOTKEYRANDOM][1]) 
			Send($hotkeys[$HOTKEYRANDOM][1])
			HotKeySet($hotkeys[$HOTKEYRANDOM][1], $hotkeys[$HOTKEYRANDOM][4] & 'Hotkey') 
			Return 
		EndIf 
	EndIf		
	
	_PlayRandom()		
EndFunc 

Func _OptionsHotkey()
	If Not $hotkeys[$HOTKEYOPTIONS][2] then 
		If Not WinActive($mainGUI) then 
			HotKeySet($hotkeys[$HOTKEYOPTIONS][1]) 
			Send($hotkeys[$HOTKEYOPTIONS][1])
			HotKeySet($hotkeys[$HOTKEYOPTIONS][1], $hotkeys[$HOTKEYOPTIONS][4] & 'Hotkey') 
			Return 
		EndIf 
	EndIf
	
	_Options()	
EndFunc

Func _VolumeUpHotkey()
;~ 	ConsoleWri
	If Not $hotkeys[$HOTKEYVOLUMEUP][2] then 
		If Not WinActive($mainGUI) then 
			HotKeySet($hotkeys[$HOTKEYVOLUMEUP][1]) 
			Send($hotkeys[$HOTKEYVOLUMEUP][1])
			HotKeySet($hotkeys[$HOTKEYVOLUMEUP][1], $hotkeys[$HOTKEYVOLUMEUP][4] & 'Hotkey') 
			Return 
		EndIf 
	EndIf
	
	$current = GUICtrlRead($sldVolume) 
	GUICtrlSetData($sldVolume, $current + 5)
	_SetVolume()
EndFunc 

Func _VolumeDownHotkey()
	If Not $hotkeys[$HOTKEYVOLUMEDOWN][2] then 
		If Not WinActive($mainGUI) then 
			HotKeySet($hotkeys[$HOTKEYVOLUMEDOWN][1]) 
			Send($hotkeys[$HOTKEYVOLUMEDOWN][1])
			Return 
		EndIf 
	EndIf
	
	$current = GUICtrlRead($sldVolume) 
	GUICtrlSetData($sldVolume, $current - 5)
	_SetVolume()
EndFunc

Func _VolumeMuteHotkey()
	If Not $hotkeys[$HOTKEYMUTE][2] then 
		If Not WinActive($mainGUI) then 
			HotKeySet($hotkeys[$HOTKEYMUTE][1]) 
			Send($hotkeys[$HOTKEYMUTE][1])
			HotKeySet($hotkeys[$HOTKEYMUTE][1], $hotkeys[$HOTKEYMUTE][4] & 'Hotkey') 
			Return 
		EndIf 
	EndIf
	
	$current = GUICtrlRead($sldVolume) 
	GUICtrlSetData($sldVolume, 0)
	_SetVolume()	
EndFunc

Func _RemoveDuplicatesHotkey()
	If Not $hotkeys[$HOTKEYREMOVEDUPS][2] then 
		If Not WinActive($mainGUI) then 
			HotKeySet($hotkeys[$HOTKEYREMOVEDUPS][1]) 
			Send($hotkeys[$HOTKEYREMOVEDUPS][1])
			HotKeySet($hotkeys[$HOTKEYREMOVEDUPS][1], $hotkeys[$HOTKEYREMOVEDUPS][4] & 'Hotkey') 
			Return 
		EndIf 
	EndIf
	 
	_RemoveDups()
EndFunc
#EndRegion 
#region *** Registers ***
Func WM_ACTIVATE($hWnd, $Msg, $wParam, $lParam)   
;~ 	ConsoleWrite('+> WM_ACTIVATE' & @TAB & '$windowTransEnabled = ' & $windowTransEnabled & @TAB & 'BitAnd(WinGetState($mainGUI), 8) = ' & BitAnd(WinGetState($mainGUI), 8) & @CRLF)
	_SetWindowTrans()
;~ 	ConsoleWrite('! GUISwitch($mainGUI)' & @CRLF)
;~ 	GUISwitch($mainGUI)
    Return $GUI_RUNDEFMSG
EndFunc

Func WM_COMMAND($hWnd, $iMsg, $iwParam, $ilParam)
	Local $hWndFrom, $iIDFrom, $iCode, $hWndListBox

	$hWndFrom = $ilParam
	$iIDFrom = BitAND($iwParam, 0xFFFF) ; Low Word
	$iCode = BitShift($iwParam, 16) ; Hi Word
		
	If $hWndFrom = GUICtrlGetHandle($optionsCtrls[$COLORS][3]) then 
		If $iCode = $NM_FIRST then ; Sent when the selection in a list box has changed
			$tempColorsAltEnabled = Not $tempColorsAltEnabled 
			_SetColorsRedrawLists()
		EndIf
    EndIf

    Return $GUI_RUNDEFMSG
EndFunc

Func WM_GETMINMAXINFO($hWnd, $MsgID, $wParam, $lParam)
    #forceref $MsgID, $wParam
    If $hWnd = $nowPlayingGUI Then; the main GUI-limited  
        Local $minmaxinfo = DllStructCreate("int;int;int;int;int;int;int;int;int;int", $lParam)
        DllStructSetData($minmaxinfo, 7, 300); min width
        DllStructSetData($minmaxinfo, 8, 200); min height
    EndIf
	
	Return 0
EndFunc

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView, $tInfo

    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
		
    Switch $hWndFrom
		Case $lstNowPlayingHeader
			Switch $iCode
				Case $HDN_BEGINTRACK, $HDN_BEGINTRACKW ; Notifies a header control's parent window that the user has begun dragging a divider in the control
					$tNMHEADER = DllStructCreate($tagNMHEADER, $ilParam)
					$tempArray = _GUICtrlListView_GetColumnOrderArray($lstNowPLayingHwnd)
					If DllStructGetData($tNMHEADER, "Item") = 0 then Return True ; Stops user from changing column
					Return False ; To allow tracking of the divider
;~ 				Case $HDN_ENDDRAG ; Sent by a header control when a drag operation has ended on one of its items
;~ 					$tNMHEADER = DllStructCreate($tagNMHEADER, $ilParam)
;~ 					_DebugPrint("$HDN_ENDDRAG" & @LF & "--> hWndFrom:" & @TAB & DllStructGetData($tNMHEADER, "hWndFrom") & @LF & _
;~ 							"-->IDFrom:" & @TAB & DllStructGetData($tNMHEADER, "IDFrom") & @LF & _
;~ 							"-->Code:" & @TAB & DllStructGetData($tNMHEADER, "Code") & @LF & _
;~ 							"-->Item:" & @TAB & DllStructGetData($tNMHEADER, "Item") & @LF & _
;~ 							"-->Button:" & @TAB & DllStructGetData($tNMHEADER, "Button"))
;~ 					Return False ; To allow the control to automatically place and reorder the item
;~ 						Return True  ; To prevent the item from being placed
			EndSwitch
		Case $lstNowPlayingHwnd
			Switch $iCode 
				Case $NM_DBLCLK
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					$index = DllStructGetData($tInfo, 'Index')

					If $index < 0 then Return

					If $currentlyPlaying > 0 then 
						_Stop()
					EndIf

					_LoadSong($index) 

					_Play()
			EndSwitch
		Case $lstAvailableHwnd
			If $iCode = $NM_DBLCLK then 
				$tempArray = _GUICtrlListView_GetItemTextArray($lstAvailableHwnd)
				If $tempArray[2] = '' then Return $GUI_RUNDEFMSG
				_AddSelected()
			EndIf
        Case $lstFoldersHwnd
            Switch $iCode
;~ 				Case $LVN_ITEMACTIVATE
;~ 					ConsoleWrite('The user activated an item: ' & _GUICtrlListView_GetSelectedIndices($lstMenuHwnd) & @CRLF)
				Case $NM_DBLCLK ; Sent when the user double-clicks a string in a list box
					$text = _GUICtrlListView_GetItemTextArray($lstFoldersHwnd)
					If Not IsArray($text) then Return 
					If $text[1] = '' then Return
					$tempPreviewPath = $settingsMusic & '\' & $text[1]

					If $upDisabled then 
						GuiCtrlSetState($btnUp, $GUI_ENABLE) 
						$upDisabled = False 
					EndIf 
					
					_SetDirs($settingsMusic & '\' & $text[1])
                Case $NM_CLICK ; Sent when the selection in a list box has changed
					$text = _GUICtrlListView_GetItemTextArray($lstFoldersHwnd)
					If IsArray($text) then 
						If $text[1] <> '' then _SetSel()
					EndIf
                Case $LVN_KEYDOWN  ; Sent by a list-view control when the user double-clicks an item with the left mouse button
					Return True
;~ 					$tInfo = DllStructCreate($tagNMLVKEYDOWN, $ilParam)
;~ 					$key = DllStructGetData($tInfo, "VKey") 
;~ 					If $key = 21495846 or $key = 22020136 then 
;~ 						_SetSel()
;~ 						Return True
;~ 					EndIf
				EndSwitch
		Case GUICtrlGetHandle($sldVolume)
			_SetVolume()
		Case GUICtrlGetHandle($sldProgress) 
			If $iCode = $NM_RELEASEDCAPTURE then 
				_SetSeek()
			ElseIf $iCode = $NM_CUSTOMDRAW then 
				
;~ 				ConsoleWrite('> WM_NOTIFY: $NM_CUSTOMDRAW' & @TAB & '$seeking = ' & $seeking & @CRLF)
				$temp = GUIGetCursorInfo() 
				If @error then Return $GUI_RUNDEFMSG
				If Not IsArray($temp) then Return $GUI_RUNDEFMSG
				
				If ($temp[2] and $temp[4] = $sldProgress) then 
					If Not $seeking then 
						ConsoleWrite('! --> $seeking = ' & $seeking & @CRLF)
						$seeking = True
					EndIf
				EndIf
			EndIf
        Case $tempHwnd ; The ListView in the Hotkeys Options GUI
            Switch $iCode
				Case $NM_CLICK ; Sent by a list-view control when the user clicks an item with the left mouse button
					$tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
					If DllStructGetData($tInfo, "Index") > -1 then _SetHotkeysChange()
				Case $LVN_KEYDOWN  ; Sent by a list-view control when the user double-clicks an item with the left mouse button
					Return True
;~ 					$tInfo = DllStructCreate($tagNMLVKEYDOWN, $ilParam)
;~ 					$key = DllStructGetData($tInfo, "VKey") 
;~ 					If $key = 21495846 or $key = 22020136 then 
;~ 						_SetHotkeysChange()
;~ 					EndIf
			EndSwitch
		Case $lstMenuHwnd 
			Switch $iCode 
				Case $NM_CLICK ; Sent when the selection in a list box has changed
					$text = _GUICtrlListView_GetItemTextArray($lstMenuHwnd)
					If IsArray($text) then 
						If $text[1] <> '' then _SetMenu()
					EndIf
				Case $LVN_KEYDOWN  ; Sent by a list-view control when the user double-clicks an item with the left mouse button
					Return True
;~ 					$tInfo = DllStructCreate($tagNMLVKEYDOWN, $ilParam)
;~ 					$key = DllStructGetData($tInfo, "VKey") 
;~ 					If $key = 21495846 or $key = 22020136 then 
;~ 						_SetMenu()
;~ 					EndIf
				EndSwitch
		Case $tempHwndHeader
			Switch $iCode
				Case $HDN_BEGINTRACK, $HDN_BEGINTRACKW ; Notifies a header control's parent window that the user has begun dragging a divider in the control
;~ 					$tNMHEADER = DllStructCreate($tagNMHEADER, $ilParam)
;~ 					If DllStructGetData($tNMHEADER, "Item") = 3 then Return True 
					Return True ; False allows change
			EndSwitch
		Case $tempHidingHwnd 
			If $iCode = $NM_DBLCLK then 
				$sel = _GUICtrlListView_GetSelectedIndices($tempHidingHwnd)
				If $sel < 0 then Return $GUI_RUNDEFMSG
				_SetColumnsLeft()
			EndIf			
			
		Case $tempShowingHwnd 
			If $iCode = $NM_DBLCLK then 
				$sel = _GUICtrlListView_GetSelectedIndices($tempShowingHwnd)
				If $sel < 0 then Return $GUI_RUNDEFMSG
				_SetColumnsRight()
			EndIf			
    EndSwitch
    Return $GUI_RUNDEFMSG
EndFunc 
#EndRegion



Func _DisplayHotkeys() 
	ConsoleWrite('--> $colorsBK = ' & $colorsBK & @CRLF)
	ConsoleWrite('--> $colorsText = ' & $colorsText & @CRLF)
	ConsoleWrite('--> $colorsAlt = ' & $colorsAlt & @CRLF)
EndFunc







