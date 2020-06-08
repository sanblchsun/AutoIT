#NoTrayIcon
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <WinAPI.au3>
#include <Misc.au3>
#include <IE.au3>

Opt("WinTitleMatchMode", 2)

Global $Tabs[1][4]
Global $AddNewTab
Global $TotalTabs = 1


$Split = StringSplit("User32.txt|Kernel32.txt|Shell32.txt|GDIPlus.txt|GDI32.txt|WinInet.txt|WinMM.txt|AdvAPI32.txt|ComCtl32.txt","|")

Global $AllItems

for $i = 1 to $Split[0]
	
	$AllItems &= StringReplace(StringReplace(FileRead($Split[$i]),":","   "),@CRLF,"|")
	
	If $i <> $Split[0] Then $AllItems &= "|"
	
Next

#Region ### START Koda GUI section ### Form=
$Form1 = GUICreate("API Functions Lib", 1081, 836, -1, -1,$WS_MAXIMIZEBOX+$WS_MAXIMIZE+$WS_MINIMIZEBOX+$WS_SIZEBOX)

	

	$Size = WinGetClientSize($Form1)

	$Close = GUICtrlCreateButton("Close tab",$Size[0]-80,3,75,23)
	GUICtrlSetState($Close,$GUI_DISABLE)
	
	$Previous = GUICtrlCreateButton("Previous",230,3,75,23)
	$Next = GUICtrlCreateButton("Next",230+78,3,75,23)
	
	Global $Input1 = GUICtrlCreateInput("", 8, 48, 209, 21)
	Global $List1 = GUICtrlCreateList("", 8, 73, 209, $Size[1]-8-73, -1, 0)
	$Label2 = GUICtrlCreateLabel("Done!", 8, 16, 209, 17)

	$Tab = GUICtrlCreateTab(230,30,$Size[0]-238,$Size[1]-38)
	
	$Tabs[0][0] = GUICtrlCreateTabItem("Search")
	
	$Tabs[0][1] = _IECreateEmbedded()
	$Tabs[0][2] = GUICtrlCreateObj($Tabs[0][1],231,53,$Size[0]-250+8,$Size[1]-50-14)
	_IENavigate($Tabs[0][1],"http://search.msdn.microsoft.com/Default.aspx?locale=en-US&Brand=msdn",0)
	
	
	$AddNewTab = GUICtrlCreateTabItem("New tab...")

GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

Global $PreviousSearch = ""
Global $PreviousSelected = ""

State("Loading functions...")
GUICtrlSetData($List1,$AllItems)
State()

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
			
		Case $Next
			
			$ControlID = GUICtrlRead($Tab,1)
			$IE = HwndToIE($ControlID)
			
			_IEAction ($IE, "forward")
			
		Case $Previous
			
			$ControlID = GUICtrlRead($Tab,1)
			$IE = HwndToIE($ControlID)
			
			_IEAction ($IE, "back")
			
		Case $Close
			
			$TotalTabs -= 1
			
			If $TotalTabs = 1 Then
				GUICtrlSetState($Close,$GUI_DISABLE)
			EndIf
			
			$ControlID = GUICtrlRead($Tab,1)
			
			$Obj = HwndToObj($ControlID)
			
			GUICtrlDelete($Obj)
			GUICtrlDelete($ControlID)
			
			$ID = HwndToID($ControlID)
			$Tabs[$ID][0] = 0
			$Tabs[$ID][1] = 0
			$Tabs[$ID][2] = 0
			
			$nr = GUICtrlRead($Tab)
			
			$hand = AHandle()
			;MsgBox(0,"sdsd",$hand &"  "& $ControlID)
			
			If ($nr) = $TotalTabs Then GUICtrlSetState($hand,@SW_SHOW)
			
		Case $Tab
			
			$ClickedTab = GUICtrlRead($Tab,1)
			If $ClickedTab = $AddNewTab Then
				
				
				GUICtrlSetData($AddNewTab,"Search")
				
				ReDim $Tabs[UBound($Tabs)+1][4]
				
				$Tabs[UBound($Tabs)-1][0] = $AddNewTab
				$Tabs[UBound($Tabs)-1][1] = _IECreateEmbedded()
				
				GUISwitch($Form1,$AddNewTab)
				$Tabs[UBound($Tabs)-1][2] = GUICtrlCreateObj($Tabs[UBound($Tabs)-1][1],231,53,$Size[0]-250+8,$Size[1]-50-14)
				_IENavigate($Tabs[UBound($Tabs)-1][1],"http://search.msdn.microsoft.com/Default.aspx?locale=en-US&Brand=msdn",0)
				
				$AddNewTab = GUICtrlCreateTabItem("New tab...")
				
				$TotalTabs += 1
				
				If $TotalTabs > 1 Then
					GUICtrlSetState($Close,$GUI_ENABLE)
				EndIf
				
			EndIf
			
			$ActiveTab = $ClickedTab
			
			;WinSetTitle($Form1, "", "API Functions Lib - "&ControlGetText($Form1,"",$ClickedTab))
			
	EndSwitch
	
	$Read = GUICtrlRead($Input1)
	$ReadList = GUICtrlRead($List1)
	
	if $ReadList And $ReadList <> $PreviousSelected Then
		
		$URLdefault = "http://search.msdn.microsoft.com/?query=%SEARCH%&locale=en-us&ac=3"
		
			
			$Function = StringSplit($ReadList,"   ",1)
			
			$FunctionStr = $Function[$Function[0]]
			
			If StringInStr(StringRight($FunctionStr,1),"W",1) Or StringInStr(StringRight($FunctionStr,1),"A",1) Then
				$FunctionStr = StringTrimRight($FunctionStr,1)
			EndIf
			
			$URLedited = StringReplace($URLdefault,"%SEARCH%",$FunctionStr)
			
			$ControlID = GUICtrlRead($Tab,1)
			
			$IE = HwndToIE($ControlID)
			
			_IENavigate ($IE, $URLedited,0)
			
			$PreviousSelected = $ReadList
			
			GUICtrlSetData($ControlID,$FunctionStr)
			;WinSetTitle($Form1,"","API Functions Lib - "&$FunctionStr)
			
	EndIf
	
	If $Read And $Read <> $PreviousSearch Then
		
		State("Searching...")
		
		GUICtrlSetData($List1,"")
		$Split = StringSplit($AllItems,"|")
		For $i = 1 to $Split[0]
			If StringInStr($Split[$i],$Read) Then
				$Prev = GUICtrlRead($List1)
				GUICtrlSetData($List1,$Prev& $Split[$i]& "|")
			EndIf
		Next
		$PreviousSearch = $Read
		
		State()
		
	ElseIf Not $Read And $PreviousSearch Then
		
		State("Adjusting...")
		
		GUICtrlSetData($List1,$AllItems)
		$PreviousSearch = ""
		
		State()
		
	EndIf
	
WEnd

Func HwndToIE($Handle)
	For $i = 0 to UBound($Tabs)-1
		If $Tabs[$i][0] = $Handle Then Return $Tabs[$i][1]
	Next
EndFunc

Func HwndToObj($Handle)
	For $i = 0 to UBound($Tabs)-1
		If $Tabs[$i][0] = $Handle Then Return $Tabs[$i][2]
	Next
EndFunc

Func HwndToID($Handle)
	For $i = 0 to UBound($Tabs)-1
		If $Tabs[$i][0] = $Handle Then Return $i
	Next
EndFunc

Func AHandle()
	For $i = 0 to UBound($Tabs)-1
		If $Tabs[$i][0] Then Return $Tabs[$i][0]
	Next
EndFunc

Func State($Text="Done!")
	GUICtrlSetData($Label2,$Text)
EndFunc