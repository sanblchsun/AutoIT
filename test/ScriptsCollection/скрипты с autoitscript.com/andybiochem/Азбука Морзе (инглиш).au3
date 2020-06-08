#include <Misc.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Array.au3>

Opt("GUIOnEventMode", 1)

HotKeySet("{SPACE}", "_Null")

;******************************************
; Vars
;******************************************

Global $bFirst = True;prevents leading /

Global $nTD = "";dot/dah timer
Global $nTLW = "";timer LW (looks for letter/word spaces)

Global $iSn = 150;sensitivity of dot/dahs (i.e. length of 1 dot)
Global $sSt = "";loading string
Global $sString = ""

Global $dll = DllOpen("user32.dll")

;----- Cipher -----
Global $aCipher[91]

$aCipher[39] = ".----.";'
$aCipher[44] = "--..--";,
$aCipher[45] = "-....-";-
$aCipher[46] = ".-.-.-";.
$aCipher[48] = "-----";0
$aCipher[49] = ".----";1
$aCipher[50] = "..---";2
$aCipher[51] = "...--";3
$aCipher[52] = "....-";4
$aCipher[53] = ".....";5
$aCipher[54] = "-....";6
$aCipher[55] = "--...";7
$aCipher[56] = "---..";8
$aCipher[57] = "----.";9
$aCipher[58] = "---...";;
$aCipher[63] = "..--..";?
$aCipher[65] = ".-";a
$aCipher[66] = "-...";b
$aCipher[67] = "-.-.";c
$aCipher[68] = "-..";d
$aCipher[69] = ".";e
$aCipher[70] = "..-.";f
$aCipher[71] = "--.";g
$aCipher[72] = "....";h
$aCipher[73] = "..";i
$aCipher[74] = ".---";j
$aCipher[75] = "-.-";k
$aCipher[76] = ".-..";l
$aCipher[77] = "--";m
$aCipher[78] = "-.";n
$aCipher[79] = "---";o
$aCipher[80] = ".--.";p
$aCipher[81] = "--.-";q
$aCipher[82] = ".-.";r
$aCipher[83] = "...";s
$aCipher[84] = "-";t
$aCipher[85] = "..-";u
$aCipher[86] = "...-";v
$aCipher[87] = ".--";w
$aCipher[88] = "-..-";x
$aCipher[89] = "-.--";y
$aCipher[90] = "--..";z


;******************************************
; GUI
;******************************************
GUICreate("", 405, 660)
GUISetOnEvent($GUI_EVENT_CLOSE, "_Exit")

;----- Edits / Labels -----
$Label1 = GUICtrlCreateLabel("Morse Code Translator", 24, 8, 353, 41)
GUICtrlSetFont(-1, 24, 800)
$Label2 = GUICtrlCreateLabel("Tap the SPACEBAR to generate the morse code!!", 80, 56, 240, 17)

$iShunt = 70
GUICtrlCreateLabel("MORSE CODE", 8, 25 + $iShunt, 385, 15)
GUICtrlSetFont(-1, 10, 800)
$Input1 = GUICtrlCreateInput("", 8, 40 + $iShunt, 385, 200, $ES_MULTILINE + $ES_READONLY)
GUICtrlSetFont(-1, 12, 400)

GUICtrlCreateLabel("TRANSLATION", 8, 265 + $iShunt, 385, 15)
GUICtrlSetFont(-1, 10, 800)
$Input2 = GUICtrlCreateInput("", 8, 280 + $iShunt, 385, 200, $ES_MULTILINE)

GUICtrlCreateButton("Clear", 8, 560, 385, 40)
GUICtrlSetOnEvent(-1, "_Clear")
GUICtrlSetFont(-1, 16, 800)

$ButtonSensitivity = GUICtrlCreateButton("Sensitivity (Dot length) = 150 ms", 8, 610, 385, 40)
GUICtrlSetOnEvent(-1, "_Sensitivity")
GUICtrlSetFont(-1, 16, 400)


GUISetState()
;####################################################
; LOOP
;####################################################
While 1
    Sleep(10)

    If _IsPressed("20", $dll) = 1 Then

;----- look for letter/word pause -----
        If $bFirst = False Then
            Switch TimerDiff($nTLW)
                Case ($iSn * 3) To ($iSn * 7)
                    $sSt &= " "
                Case ($iSn * 7) + 1 To ($iSn * 99999)
                    $sSt &= "/"
            EndSwitch
        EndIf

        $bFirst = False

;----- prep dot/dah timer -----
        $nTD = TimerInit()

;----- detect dah from loop -----
        Do
        Until _IsPressed("20", $dll) = 0

;----- select dot/dah -----
        Switch TimerDiff($nTD)
            Case 0 To $iSn
                $sSt &= "."
            Case Else
                $sSt &= "-"
        EndSwitch

;----- update input box -----
        GUICtrlSetData($Input1, $sSt)

;----- translate current code -----
        _Translate()

;----- set timer -----
        $nTLW = TimerInit()

    EndIf
WEnd
;####################################################
; END LOOP
;####################################################


Func _Null()
;******************************************
; Used only to hook the spacebar from apps
;******************************************
EndFunc ;==>_Null



Func _Translate()
;******************************************
; Translate code
;******************************************

    $aSt = StringSplit($sSt, "/")

;----- decipher all but last word -----
    $sString = ""
    For $i = 1 To $aSt[0] - 1
        $aaSt = StringSplit($aSt[$i], " ")
        For $j = 1 To $aaSt[0]
            $iIndex = _ArraySearch($aCipher, $aaSt[$j])
            Switch $iIndex
                Case - 1
                    $sString &= "?"
                Case Else
                    $sString &= Chr($iIndex)
            EndSwitch
        Next
        $sString &= " "
    Next

;----- decipher last word (allow rolling edit) -----
    $sStringTemp = ""
    $aaStTemp = StringSplit($aSt[$aSt[0]], " ")
    For $i = 1 To $aaStTemp[0]
        $iIndex = _ArraySearch($aCipher, $aaStTemp[$i])
        Switch $iIndex
            Case - 1
                $sStringTemp &= "?"
            Case Else
                $sStringTemp &= Chr($iIndex)
        EndSwitch
    Next

;----- update screen -----
    GUICtrlSetData($Input2, $sString & $sStringTemp)

EndFunc ;==>_Translate


Func _Clear()
;******************************************
; Clear current text / code
;******************************************

    GUICtrlSetData($Input1, "")
    GUICtrlSetData($Input2, "")

    $sString = ""
    $sSt = ""

    $bFirst = True

EndFunc ;==>_Clear


Func _Sensitivity()
;******************************************
; Set new sensitivity
;******************************************

    $iSn = InputBox("","Set new sensitivity (dot length) in ms...",$iSn)

    GUICtrlSetData($ButtonSensitivity,"Sensitivity (Dot length) = " & $iSn & " ms")

EndFunc


Func _Exit()
;******************************************
; Clean up and exit
;******************************************
    DllClose($dll)
    Exit
EndFunc ;==>_Exit
