; http://www.autoitscript.com/forum/topic/95363-rsa-algorithm/page__view__findpost__p__686569
; Andreik
Global $KEY[3]
Global $P
Global $Q
Global $PHI

#Region GUI
$GUI = GUICreate("RSA Algorithm",320,320,-1,-1,0x16C80000,0x00000181)
$P_LABEL = GUICtrlCreateLabel("(P)",5,5,100,20,BitOR(0x01,0x1000))
$P_INPUT = GUICtrlCreateInput("",5,30,100,20,0x01)
$Q_LABEL = GUICtrlCreateLabel("(Q)",110,5,100,20,BitOR(0x01,0x1000))
$Q_INPUT = GUICtrlCreateInput("",110,30,100,20,0x01)
$PHI_LABEL = GUICtrlCreateLabel("(PHI)",215,5,100,20,BitOR(0x01,0x1000))
$PHI_INP = GUICtrlCreateInput("",215,30,100,20,0x01)
$E_LABEL = GUICtrlCreateLabel("(E)",5,55,100,20,BitOR(0x01,0x1000))
$E_INP = GUICtrlCreateInput("",5,80,100,20,0x01)
$N_LABEL = GUICtrlCreateLabel("(N)",110,55,100,20,BitOR(0x01,0x1000))
$N_INP = GUICtrlCreateInput("",110,80,100,20,0x01)
$D_LABEL = GUICtrlCreateLabel("(D)",215,55,100,20,BitOR(0x01,0x1000))
$D_INP = GUICtrlCreateInput("",215,80,100,20,0x01)
$TEXT_BOX = GUICtrlCreateEdit("",5,105,310,180,0x00200000)
$GEN_KEY = GUICtrlCreateButton("Genereaza Chei",5,290,100,25)
$ENC_BUTTON = GUICtrlCreateButton("ENCRYPT",110,290,100,25)
$DEC_BUTTON = GUICtrlCreateButton("DECRYPT",215,290,100,25)
GUISetState(@SW_SHOW,$GUI)
#EndRegion

#Region Main Loop
While True
    $MSG = GUIGetMsg()
    Switch $MSG
        Case $GEN_KEY
            GenerateKey()
            GUICtrlSetData($P_INPUT,$P)
            GUICtrlSetData($Q_INPUT,$Q)
            GUICtrlSetData($PHI_INP,$PHI)
            GUICtrlSetData($E_INP,$KEY[0])
            GUICtrlSetData($N_INP,$KEY[2])
            GUICtrlSetData($D_INP,$KEY[1])
        Case $ENC_BUTTON
            $TEXT = GUICtrlRead($TEXT_BOX)
            $DATA = Encrypt($TEXT,$KEY[0],$KEY[2])
            GUICtrlSetData($TEXT_BOX,$DATA)
        Case $DEC_BUTTON
            $TEXT = GUICtrlRead($TEXT_BOX)
            $DATA = Decrypt($TEXT,$KEY[1],$KEY[2])
            GUICtrlSetData($TEXT_BOX,$DATA)
        Case -3
            Exit
    EndSwitch
    Sleep(20)
WEnd
#EndRegion

Func GenerateKey()
    Local Const $UP_LIMIT = 9999
    Local Const $LW_LIMIT = 3170
    Local Const $KEY_LIMIT = 10000000
    Do
        Do
            $P = Int(($UP_LIMIT - $LW_LIMIT + 1) * Random() + $LW_LIMIT)
            $Q = Int(($UP_LIMIT - $LW_LIMIT + 1) * Random() + $LW_LIMIT)
        Until IsPrime($P) And IsPrime($Q)
        $N = $P * $Q
        $PHI = ($P - 1) * ($Q - 1)
        $E = CMMDC($PHI)
        $D = GenerateEuler($E,$PHI)
    Until $D > $KEY_LIMIT
    $KEY[0] = $E
    $KEY[1] = $D
    $KEY[2] = $N
    Return $KEY
EndFunc

Func IsPrime($NUM)
    $SQRT = Sqrt($NUM)
    If $NUM < 2 Then
        $IS_PRIME = False
        Return $IS_PRIME
    EndIf
    $COUNT = 2
    $IS_PRIME = True
    If Mod($NUM,$COUNT) = 0 Then
        $IS_PRIME = False
        Return $IS_PRIME
    EndIf
    $COUNT = 3
    For $X = $COUNT To $SQRT Step 2
        If Mod($NUM,$X) = 0 Then
            $IS_PRIME = False
            Return $IS_PRIME
        EndIf
    Next
    Return $IS_PRIME
EndFunc

Func CMMDC($PHI_NUM)
    Local Const $UP_LIMIT = 99999999
    Local Const $LW_LIMIT = 10000000
    Local $E = Int(($UP_LIMIT - $LW_LIMIT + 1) * Random() + $LW_LIMIT)
    While True
        $X = Mod($PHI_NUM,$E)
        $Y = Mod($X,$E)
        If $Y <> 0 And IsPrime($E) Then
            $CMMDC = $E
            Return $CMMDC
        Else
            $E += 1
        EndIf
    WEnd
EndFunc

Func GenerateEuler($E_NUM,$PHI_NUM)
    Local $U1 = 1
    Local $U2 = 0
    Local $U3 = $PHI_NUM
    Local $V1 = 0
    Local $V2 = 1
    Local $V3 = $E_NUM
    Do
        $QU = Int($U3/$V3)
        $T1 = $U1 - $QU * $V1
        $T2 = $U2 - $QU * $V2
        $T3 = $U3 - $QU * $V3
        $U1 = $V1
        $U2 = $V2
        $U3 = $V3
        $V1 = $T1
        $V2 = $T2
        $V3 = $T3
        $Z = 1
    Until $V3 = 0
    $UU = $U1
    $VV = $U2
    If ($VV < 0) Then
        $INVERSE = $VV + $PHI_NUM
    Else
        $INVERSE = $VV
    EndIf
    Return $INVERSE
EndFunc

Func Mult($X,$P_NUM,$M)
    Local $Y = 1
    While $P_NUM > 0
        While ($P_NUM/2) = Int(($P_NUM/2))
            $X = NMod(($X*$X),$M)
            $P_NUM = $P_NUM/2
        WEnd
        $Y = NMod(($X*$Y),$M)
        $P_NUM = $P_NUM-1
    WEnd
    Return $Y
EndFunc

Func Encrypt($TEXT,$EE,$EN)
    Local $ENC = ""
    If $TEXT = "" Then Return ""
    For $INDEX = 1 To StringLen($TEXT)
        $ENC &= Mult(Asc(StringMid($TEXT,$INDEX,1)),$EE,$EN) & "+"
    Next
    Return StringTrimRight($ENC,1)
EndFunc

Func Decrypt($TEXT,$DD,$DN)
    Local $DEC = ""
    $SPLIT = StringSplit($TEXT,"+")
    For $INDEX = 1 To $SPLIT[0]
        $TOK = Number($SPLIT[$INDEX])
        $DEC &= Chr(Mult($TOK,$DD,$DN))
    Next
    Return $DEC
EndFunc

Func NMod($X,$Y)
    $Z = $X - (Int($X/$Y)* $Y)
    Return $Z
EndFunc