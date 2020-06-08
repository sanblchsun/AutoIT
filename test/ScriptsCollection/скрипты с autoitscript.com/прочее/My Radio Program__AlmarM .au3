;http://www.autoitscript.com/forum/index.php?showtopic=95637
#include <IE.au3>

Global $Status, $oIE, $Playing = False
Global Const $GUI_ENABLE = 64
Global Const $GUI_DISABLE = 128
Global $___Data = "Radio Decibel|Laaste Radio 1 Journaal|Wild FM|Radio 538|QMusic|TMF Radio|" & _
                    "Sky Radio|Radio Veronica|100% NL|Caz!|Slam! FM|Radio 1|538 Juize|Candle Light|" & _
                    "Classic FM|Radio 10 Gold|Radio NL|Laser Radio|Fresh FM|Sky Radio|KX Radio|" & _
                    "90's Top 590|Arrow Jazz FM|Kinder Radio|80's Top 880|Class X|Kink The Alternative|" & _
                    "Radio 2|3 FM|Radio 4|Radio 5|Radio 6|BNR Nieuws Radio|Concert Zender|FunX|BNN FM|" & _
                    "Gigant FM|Arrow Classic Rock|Top 1000|OZ Radio|Traffic Radio|Kink Aardschok|" & _
                    "538 Dance Department|538 Nonstop 40|Disco Classics|538 Hitzone|90's Hits|" & _
                    "Top 4000|Radio@Work|80's Hits|538 Party"

$GUI = GUICreate("Radio", 230, 90)
$List = GUICtrlCreateCombo("53L8 Klein", 10, 10, 210, 20)
$Connect = GUICtrlCreateButton("Connect", 10, 40, 100)
$Disconnect = GUICtrlCreateButton("Disconnect", 120, 40, 100)
$Status = GUICtrlCreateLabel("Status: Ready...", 75, 70, 100)

GUISetState()
GUICtrlSetState($Disconnect, $GUI_DISABLE)
GUICtrlSetData($List, $___Data, "53L8 Klein")
While 1
    $nMsg = GUIGetMsg()
    Select
    Case $nMsg = -3
        Exit
        
    Case $nMsg = $Connect
        $Link = _GetLink(GUICtrlRead($List))
        GUICtrlSetState($Disconnect, $GUI_ENABLE)
        GUICtrlSetState($Connect, $GUI_DISABLE)
        GUICtrlSetState($List, $GUI_DISABLE)
        _Connect($Link)
        $Playing = True
        
    Case $nMsg = $Disconnect
        GUICtrlSetState($Disconnect, $GUI_DISABLE)
        GUICtrlSetState($Connect, $GUI_ENABLE)
        GUICtrlSetState($List, $GUI_ENABLE)
        _Disconnect()
        $Playing = False
        
    EndSelect
WEnd

Func _GetLink($Param)
    If $Param = "53L8 Klein" Then $_Link = "http://nederland.fm/i/l/53L8klein.gif"
    If $Param = "Radio Decibel" Then $_Link = "http://nederland.fm/i/l/decibel.gif"
    If $Param = "Laaste Radio 1 Journaal" Then $_Link = "http://nederland.fm/i/l/laatsteradio1journaal.gif"
    If $Param = "Wild FM" Then $_Link = "http://nederland.fm/i/l/wildfm.gif"
    If $Param = "Radio 538" Then $_Link = "http://nederland.fm/i/l/radio538.gif"
    If $Param = "QMusic" Then $_Link = "http://nederland.fm/i/l/q-music.gif"
    If $Param = "TMF Radio" Then $_Link = "http://nederland.fm/i/l/tmfradio.gif"
    If $Param = "Sky Radio" Then $_Link = "http://nederland.fm/i/l/skyradio.gif"
    If $Param = "Radio Veronica" Then $_Link = "http://nederland.fm/i/l/veronicafm.gif"
    If $Param = "100% NL" Then $_Link = "http://nederland.fm/i/l/100pnl.gif"
    If $Param = "Caz!" Then $_Link = "http://nederland.fm/i/l/caz.gif"
    If $Param = "Slam! FM" Then $_Link = "http://nederland.fm/i/l/slamfm.gif"
    If $Param = "Radio 1" Then $_Link = "http://nederland.fm/i/l/radio1.gif"
    If $Param = "538 Juize" Then $_Link = "http://nederland.fm/i/l/juizefm.gif"
    If $Param = "Candle Light" Then $_Link = "http://nederland.fm/i/l/candlelight.gif"
    If $Param = "Classic FM" Then $_Link = "http://nederland.fm/i/l/classicfm.gif"
    If $Param = "Radio 10 Gold" Then $_Link = "http://nederland.fm/i/l/radio10gold.gif"
    If $Param = "Radio NL" Then $_Link = "http://nederland.fm/i/l/radionl.gif"
    If $Param = "Laser Radio" Then $_Link = "http://nederland.fm/i/l/laserradio.gif"
    If $Param = "Fresh FM" Then $_Link = "http://nederland.fm/i/l/freshfm.gif"
    If $Param = "Sky Radio" Then $_Link = "http://nederland.fm/i/l/skylove.gif"
    If $Param = "KX Radio" Then $_Link = "http://nederland.fm/i/l/kxradio.gif"
    If $Param = "90's Top 590" Then $_Link = "http://nederland.fm/i/l/top590.gif"
    If $Param = "Arrow Jazz FM" Then $_Link = "http://nederland.fm/i/l/arrowjazz.gif"
    If $Param = "Kinder Radio" Then $_Link = "http://nederland.fm/i/l/kinderradio.gif"
    If $Param = "80's Top 880" Then $_Link = "http://nederland.fm/i/l/veronica80hits.gif"
    If $Param = "Class X" Then $_Link = "http://nederland.fm/i/l/classx.gif"
    If $Param = "Kink The Alternative" Then $_Link = "http://nederland.fm/i/l/kinkfm.gif"
    If $Param = "Radio 2" Then $_Link = "http://nederland.fm/i/l/radio2.gif"
    If $Param = "3 FM" Then $_Link = "http://nederland.fm/i/l/3fm.gif"
    If $Param = "Radio 4" Then $_Link = "http://nederland.fm/i/l/radio4.gif"
    If $Param = "Radio 5" Then $_Link = "http://nederland.fm/i/l/radio5.gif"
    If $Param = "Radio 6" Then $_Link = "http://nederland.fm/i/l/radio6.gif"
    If $Param = "BNR Nieuws Radio" Then $_Link = "http://nederland.fm/i/l/bnr.gif"
    If $Param = "Concert Zender" Then $_Link = "http://nederland.fm/i/l/concertzender.gif"
    If $Param = "FunX" Then $_Link = "http://nederland.fm/i/l/funx.gif"
    If $Param = "BNN FM" Then $_Link = "http://nederland.fm/i/l/bnnfm.gif"
    If $Param = "Gigant FM" Then $_Link = "http://nederland.fm/i/l/gigantfm.gif"
    If $Param = "Arrow Classic Rock" Then $_Link = "http://nederland.fm/i/l/arrow.gif"
    If $Param = "Top 1000" Then $_Link = "http://nederland.fm/i/l/top1000.gif"
    If $Param = "OZ Radio" Then $_Link = "http://nederland.fm/i/l/ozradio.gif"
    If $Param = "Traffic Radio" Then $_Link = "http://nederland.fm/i/trafficradiobanner.gif"
    If $Param = "Kink Aardschok" Then $_Link = "http://nederland.fm/i/l/kinkaardschok.gif"
    If $Param = "538 Dance Department" Then $_Link = "http://nederland.fm/i/l/538dancedept.gif"
    If $Param = "538 Nonstop 40" Then $_Link = "http://nederland.fm/i/l/538nonstop40.gif"
    If $Param = "Disco Classics" Then $_Link = "http://nederland.fm/i/l/disco.gif"
    If $Param = "538 Hitzone" Then $_Link = "http://nederland.fm/i/l/538hitzone.gif"
    If $Param = "90's Hits" Then $_Link = "http://nederland.fm/i/l/90hits.gif"
    If $Param = "Top 4000" Then $_Link = "http://nederland.fm/i/l/top4000.gif"
    If $Param = "Radio@Work" Then $_Link = "http://nederland.fm/i/l/radioatwork.gif"
    If $Param = "80's Hits" Then $_Link = "http://nederland.fm/i/l/80shits.gif"
    If $Param = "538 Party" Then $_Link = "http://nederland.fm/i/l/538party.gif"
    
    Return $_Link
EndFunc

Func _Connect($Param)
    _Notify("Connecting...")
    $oIE = _IECreate("http://nederland.fm/", "", 0)
    _Notify("Getting Info...")
    $oImgs = _IEImgGetCollection($oIE)
    
    For $oImg In $oImgs
        _Notify("Searcing...")
        If $oImg.src = $Param Then _IEAction($oImg, "click")
    Next
        
    _Notify("Playing...")
EndFunc

Func _Disconnect()
    _Notify("Disconnecting...")
    
    _IEQuit($oIE)
    
    _Notify("Ready...")
EndFunc

Func _Notify($Text)
    GUICtrlSetData($Status, "Status: " & $Text)
EndFunc

Func OnAutoItExit()
    If $Playing = True Then _IEQuit($oIE)
EndFunc
