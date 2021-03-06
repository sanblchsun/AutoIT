#include <GUIConstants.au3>
#Include <GuiEdit.au3>
;
#Region ### START Koda GUI section ###
$Form2 = GUICreate("2x2 & 3x3 Matrix  Multiplier, Inverse Finder, and Determinant Finder", 764, 691, 259, 141)
$Mult_A_11 = GUICtrlCreateInput("1,1", 32, 88, 33, 24)
$Mult_A_12 = GUICtrlCreateInput("1,2", 88, 88, 33, 24)
$Mult_A_13 = GUICtrlCreateInput("1,3", 144, 88, 33, 24)
$Mult_A_21 = GUICtrlCreateInput("2,1", 32, 128, 33, 24)
$Mult_A_22 = GUICtrlCreateInput("2,2", 88, 128, 33, 24)
$Mult_A_23 = GUICtrlCreateInput("2,3", 144, 128, 33, 24)
$Mult_A_31 = GUICtrlCreateInput("3,1", 32, 168, 33, 24)
$Mult_A_32 = GUICtrlCreateInput("3,2", 88, 168, 33, 24)
$Mult_A_33 = GUICtrlCreateInput("3,3", 144, 168, 33, 24)
$Label1 = GUICtrlCreateLabel("Matrix A", 64, 56, 51, 20)
$Label2 = GUICtrlCreateLabel("*", 216, 128, 16, 41)
GUICtrlSetFont(-1, 20, 400, 0, "MS Sans Serif")
$Mult_B_11 = GUICtrlCreateInput("1,1", 272, 88, 33, 24)
$Mult_B_12 = GUICtrlCreateInput("1,2", 328, 88, 33, 24)
$Mult_B_13 = GUICtrlCreateInput("1,3", 384, 88, 33, 24)
$Mult_B_21 = GUICtrlCreateInput("2,1", 272, 128, 33, 24)
$Mult_B_22 = GUICtrlCreateInput("2,2", 328, 128, 33, 24)
$Mult_B_23 = GUICtrlCreateInput("2,3", 384, 128, 33, 24)
$Mult_B_31 = GUICtrlCreateInput("3,1", 272, 168, 33, 24)
$Mult_B_32 = GUICtrlCreateInput("3,2", 328, 168, 33, 24)
$Mult_B_33 = GUICtrlCreateInput("3,3", 384, 168, 33, 24)
$MultSolve = GUICtrlCreateButton("=", 448, 120, 41, 41)
$Label5 = GUICtrlCreateLabel("Matrix B", 304, 56, 51, 20)
$det11 = GUICtrlCreateInput("1,1", 32, 256, 33, 24)
$det12 = GUICtrlCreateInput("1,2", 88, 256, 33, 24)
$det13 = GUICtrlCreateInput("1,3", 144, 256, 33, 24)
$det21 = GUICtrlCreateInput("2,1", 32, 296, 33, 24)
$det22 = GUICtrlCreateInput("2,2", 88, 296, 33, 24)
$det23 = GUICtrlCreateInput("2,3", 144, 296, 33, 24)
$det31 = GUICtrlCreateInput("3,1", 32, 336, 33, 24)
$det32 = GUICtrlCreateInput("3,2", 88, 336, 33, 24)
$det33 = GUICtrlCreateInput("3,3", 144, 336, 33, 24)
$DetSolve = GUICtrlCreateButton("Solve", 208, 280, 49, 49)
$DetAnswer = GUICtrlCreateInput("?", 272, 288, 49, 24)
$Mult_Ans_11 = GUICtrlCreateInput("?", 520, 88, 33, 24)
$Mult_Ans_12 = GUICtrlCreateInput("?", 576, 88, 33, 24)
$Mult_Ans_13 = GUICtrlCreateInput("?", 632, 88, 33, 24)
$Mult_Ans_21 = GUICtrlCreateInput("?", 520, 128, 33, 24)
$Mult_Ans_22 = GUICtrlCreateInput("?", 576, 128, 33, 24)
$Mult_Ans_23 = GUICtrlCreateInput("?", 632, 128, 33, 24)
$Mult_Ans_31 = GUICtrlCreateInput("?", 520, 168, 33, 24)
$Mult_Ans_32 = GUICtrlCreateInput("?", 576, 168, 33, 24)
$Mult_Ans_33 = GUICtrlCreateInput("?", 632, 168, 33, 24)
$Inverse11 = GUICtrlCreateInput("1,1", 352, 256, 33, 24)
$Inverse12 = GUICtrlCreateInput("1,2", 408, 256, 33, 24)
$Inverse13 = GUICtrlCreateInput("1,3", 464, 256, 33, 24)
$Inverse21 = GUICtrlCreateInput("2,1", 352, 296, 33, 24)
$Inverse22 = GUICtrlCreateInput("2,2", 408, 296, 33, 24)
$Inverse23 = GUICtrlCreateInput("2,3", 464, 296, 33, 24)
$Inverse31 = GUICtrlCreateInput("3,1", 352, 336, 33, 24)
$Inverse32 = GUICtrlCreateInput("3,2", 408, 336, 33, 24)
$Inverse33 = GUICtrlCreateInput("3,3", 464, 336, 33, 24)
$Inverse = GUICtrlCreateButton("Inverse", 512, 296, 57, 33)
$InverseAns11 = GUICtrlCreateInput("?", 584, 256, 33, 24)
$InverseAns12 = GUICtrlCreateInput("?", 640, 256, 33, 24)
$InverseAns13 = GUICtrlCreateInput("?", 696, 256, 33, 24)
$InverseAns21 = GUICtrlCreateInput("?", 584, 296, 33, 24)
$InverseAns22 = GUICtrlCreateInput("?", 640, 296, 33, 24)
$InverseAns23 = GUICtrlCreateInput("?", 696, 296, 33, 24)
$InverseAns31 = GUICtrlCreateInput("?", 584, 336, 33, 24)
$InverseAns32 = GUICtrlCreateInput("?", 640, 336, 33, 24)
$InverseAns33 = GUICtrlCreateInput("?", 696, 336, 33, 24)
$Group1 = GUICtrlCreateGroup("Matrix Multiplication", 24, 24, 649, 177)
$MultClear = GUICtrlCreateButton("Clear", 160, 24, 49, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group2 = GUICtrlCreateGroup("Matrix Determinant", 24, 224, 305, 145)
$DetClear = GUICtrlCreateButton("Clear", 160, 224, 41, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group3 = GUICtrlCreateGroup("Matrix Inverse", 344, 224, 393, 145)
$InvClear = GUICtrlCreateButton("Clear", 448, 224, 41, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("3x3 Matrix", 8, 8, 745, 377)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Mult_22_11 = GUICtrlCreateInput("1,1", 32, 464, 33, 24)
$Mult_22_12 = GUICtrlCreateInput("1,2", 88, 464, 33, 24)
$Mult_22_21 = GUICtrlCreateInput("2,1", 32, 504, 33, 24)
$Mult_22_22 = GUICtrlCreateInput("2,2", 88, 504, 33, 24)
$Label3 = GUICtrlCreateLabel("*", 160, 480, 16, 41)
GUICtrlSetFont(-1, 20, 400, 0, "MS Sans Serif")
$Mult_22_B_11 = GUICtrlCreateInput("1,1", 208, 464, 33, 24)
$Mult_22_B_12 = GUICtrlCreateInput("1,2", 264, 464, 33, 24)
$Mult_22_B_21 = GUICtrlCreateInput("2,1", 208, 504, 33, 24)
$Mult_22_B_22 = GUICtrlCreateInput("2,2", 264, 504, 33, 24)
$Mult_22_SOLVE = GUICtrlCreateButton("=", 336, 480, 41, 41, 0)
$Mult_22_Ans_11 = GUICtrlCreateInput("?", 416, 464, 33, 24)
$Mult_22_Ans_12 = GUICtrlCreateInput("?", 472, 464, 33, 24)
$Mult_22_Ans_21 = GUICtrlCreateInput("?", 416, 504, 33, 24)
$Mult_22_Ans_22 = GUICtrlCreateInput("?", 472, 504, 33, 24)
$Label4 = GUICtrlCreateLabel("Matrix A", 48, 432, 51, 20)
$Label6 = GUICtrlCreateLabel("Matrix B", 224, 432, 51, 20)
$Group5 = GUICtrlCreateGroup("Matrix Multiplication", 24, 400, 489, 137)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Det_22_B_11 = GUICtrlCreateInput("1,1", 32, 592, 33, 24)
$Det_22_B_12 = GUICtrlCreateInput("1,2", 88, 592, 33, 24)
$Det_22_B_21 = GUICtrlCreateInput("2,1", 32, 632, 33, 24)
$Det_22_B_22 = GUICtrlCreateInput("2,2", 88, 632, 33, 24)
$Det_22_SOLVE = GUICtrlCreateButton("Solve", 160, 600, 49, 49, 0)
$DetAnswer_22 = GUICtrlCreateInput("?", 224, 608, 49, 24)
$Box = GUICtrlCreateGroup("Matrix Determinant", 24, 560, 257, 105)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Inv_B_11 = GUICtrlCreateInput("1,1", 304, 592, 33, 24)
$Inv_B_12 = GUICtrlCreateInput("1,2", 360, 592, 33, 24)
$Inv_B_21 = GUICtrlCreateInput("2,1", 304, 632, 33, 24)
$Inv_B_22 = GUICtrlCreateInput("2,2", 360, 632, 33, 24)
$Inverse_22 = GUICtrlCreateButton("Inverse", 408, 608, 57, 33, 0)
$Inv_Ans_11 = GUICtrlCreateInput("1,1", 480, 592, 33, 24)
$Inv_Ans_12 = GUICtrlCreateInput("1,2", 536, 592, 33, 24)
$Inv_Ans_21 = GUICtrlCreateInput("2,1", 480, 632, 33, 24)
$Inv_Ans_22 = GUICtrlCreateInput("2,2", 536, 632, 33, 24)
$Group6 = GUICtrlCreateGroup("Matrix Inverse", 296, 560, 281, 105)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group7 = GUICtrlCreateGroup("2x2 Matrix", 8, 384, 745, 297)
$MultClear_B = GUICtrlCreateButton("Clear", 160, 400, 41, 17, 0)
$DetClear_B = GUICtrlCreateButton("Clear", 160, 560, 41, 17, 0)
$InvClear_B = GUICtrlCreateButton("Clear", 400, 560, 41, 17, 0)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
;

While 1
$nMsg = GUIGetMsg()
Switch $nMsg
Case $GUI_EVENT_CLOSE
	Exit
;;;;;;;;;;;;;;;;;;;;;;3x3 Determinant Solver;
Case $DetSolve
$D11 = GUICtrlRead($det11)
$D12 = GUICtrlRead($det12)
$D13 = GUICtrlRead($det13)
$D21 = GUICtrlRead($det21)
$D22 = GUICtrlRead($det22)
$D23 = GUICtrlRead($det23)
$D31 = GUICtrlRead($det31)
$D32 = GUICtrlRead($det32)
$D33 = GUICtrlRead($det33)
Sleep(500)
GUICtrlSetData($DetAnswer, (($D11*$D22*$D33)+($D12*$D23*$D31)+($D13*$D21*$D32))-(($D11*$D23*$D32)+($D12*$D21*$D33)+($D13*$D22*$D31)))
;;;;;;;;;;;;;;;;;;;;;;3x3 Matrix Multiplier;
Case $MultSolve
$MA11 = GUICtrlRead($Mult_A_11)
$MA12 = GUICtrlRead($Mult_A_12)
$MA13 = GUICtrlRead($Mult_A_13)
$MA21 = GUICtrlRead($Mult_A_21)
$MA22 = GUICtrlRead($Mult_A_22)
$MA23 = GUICtrlRead($Mult_A_23)
$MA31 = GUICtrlRead($Mult_A_31)
$MA32 = GUICtrlRead($Mult_A_32)
$MA33 = GUICtrlRead($Mult_A_33)

$MB11 = GUICtrlRead($Mult_B_11)
$MB12 = GUICtrlRead($Mult_B_12)
$MB13 = GUICtrlRead($Mult_B_13)
$MB21 = GUICtrlRead($Mult_B_21)
$MB22 = GUICtrlRead($Mult_B_22)
$MB23 = GUICtrlRead($Mult_B_23)
$MB31 = GUICtrlRead($Mult_B_31)
$MB32 = GUICtrlRead($Mult_B_32)
$MB33 = GUICtrlRead($Mult_B_33)

GUICtrlSetData($Mult_Ans_11, ($MA11*$MB11)+($MA12*$MB21)+($MA13*$MB31))
GUICtrlSetData($Mult_Ans_12, ($MA11*$MB12)+($MA12*$MB22)+($MA13*$MB32))
GUICtrlSetData($Mult_Ans_13, ($MA11*$MB13)+($MA12*$MB23)+($MA13*$MB33))
GUICtrlSetData($Mult_Ans_21, ($MA21*$MB11)+($MA22*$MB21)+($MA23*$MB31))
GUICtrlSetData($Mult_Ans_22, ($MA21*$MB12)+($MA22*$MB22)+($MA23*$MB32))
GUICtrlSetData($Mult_Ans_23, ($MA21*$MB13)+($MA22*$MB23)+($MA23*$MB33))
GUICtrlSetData($Mult_Ans_31, ($MA31*$MB11)+($MA32*$MB21)+($MA33*$MB31))
GUICtrlSetData($Mult_Ans_32, ($MA31*$MB12)+($MA32*$MB22)+($MA33*$MB32))
GUICtrlSetData($Mult_Ans_33, ($MA31*$MB13)+($MA32*$MB23)+($MA33*$MB33))
;;;;;;;;;;;;;;;;;;;;;;2x2 Matrix Multiplier;
Case $Mult_22_SOLVE
$2x2_A_11 = GUICtrlRead($Mult_22_11)
$2x2_A_12 = GUICtrlRead($Mult_22_12)
$2x2_A_21 = GUICtrlRead($Mult_22_21)
$2x2_A_22 = GUICtrlRead($Mult_22_22)

$2x2_B_11 = GUICtrlRead($Mult_22_B_11)
$2x2_B_12 = GUICtrlRead($Mult_22_B_12)
$2x2_B_21 = GUICtrlRead($Mult_22_B_21)
$2x2_B_22 = GUICtrlRead($Mult_22_B_22)

GUICtrlSetData($Mult_22_Ans_11, ($2x2_A_11*$2x2_B_11)+($2x2_A_12*$2x2_B_21))
GUICtrlSetData($Mult_22_Ans_12, ($2x2_A_11*$2x2_B_12)+($2x2_A_12*$2x2_B_22))
GUICtrlSetData($Mult_22_Ans_21, ($2x2_A_21*$2x2_B_11)+($2x2_A_22*$2x2_B_21))
GUICtrlSetData($Mult_22_Ans_22, ($2x2_A_21*$2x2_B_12)+($2x2_A_22*$2x2_B_22))
;;;;;;;;;;;;;;;;;;;;;;2x2 Determinant;
Case $Det_22_SOLVE
$DetB11 = GUICtrlRead($Det_22_B_11)
$DetB12 = GUICtrlRead($Det_22_B_12)
$DetB21 = GUICtrlRead($Det_22_B_21)
$DetB22 = GUICtrlRead($Det_22_B_22)

GUICtrlSetData($DetAnswer_22, ($DetB11*$DetB22)-($DetB12*$DetB21))
;;;;;;;;;;;;;;;;;;;;;;2x2 Inverse:
Case $Inverse_22
$InvB11 = GUICtrlRead($Inv_B_11)
$InvB12 = GUICtrlRead($Inv_B_12)
$InvB21 = GUICtrlRead($Inv_B_21)
$InvB22 = GUICtrlRead($Inv_B_22)

$Inv_B_Det = ($InvB11*$InvB22)-($InvB12*$InvB21)

$InvAns11 = (1/$Inv_B_Det)*$InvB11
$InvAns12 = (1/$Inv_B_Det)*$InvB12
$InvAns21 = (1/$Inv_B_Det)*$InvB21
$InvAns22 = (1/$Inv_B_Det)*$InvB22

GUICtrlSetData($Inv_Ans_11, ($InvAns11))
GUICtrlSetData($Inv_Ans_12, ($InvAns12))
GUICtrlSetData($Inv_Ans_21, ($InvAns21))
GUICtrlSetData($Inv_Ans_22, ($InvAns22))
;;;;;;;;;;;;;;;;;;;;;;3x3 Clear Buttons;
Case $MultClear
GUICtrlSetData($Mult_A_11, "")
GUICtrlSetData($Mult_A_12, "")
GUICtrlSetData($Mult_A_13, "")
GUICtrlSetData($Mult_A_21, "")
GUICtrlSetData($Mult_A_22, "")
GUICtrlSetData($Mult_A_23, "")
GUICtrlSetData($Mult_A_31, "")
GUICtrlSetData($Mult_A_32, "")
GUICtrlSetData($Mult_A_33, "")

GUICtrlSetData($Mult_B_11, "")
GUICtrlSetData($Mult_B_12, "")
GUICtrlSetData($Mult_B_13, "")
GUICtrlSetData($Mult_B_21, "")
GUICtrlSetData($Mult_B_22, "")
GUICtrlSetData($Mult_B_23, "")
GUICtrlSetData($Mult_B_31, "")
GUICtrlSetData($Mult_B_32, "")
GUICtrlSetData($Mult_B_33, "")

GUICtrlSetData($Mult_Ans_11, "")
GUICtrlSetData($Mult_Ans_12, "")
GUICtrlSetData($Mult_Ans_13, "")
GUICtrlSetData($Mult_Ans_21, "")
GUICtrlSetData($Mult_Ans_22, "")
GUICtrlSetData($Mult_Ans_23, "")
GUICtrlSetData($Mult_Ans_31, "")
GUICtrlSetData($Mult_Ans_32, "")
GUICtrlSetData($Mult_Ans_33, "")

Case $DetClear
GUICtrlSetData($Det11, "")
GUICtrlSetData($Det12, "")
GUICtrlSetData($Det13, "")
GUICtrlSetData($Det21, "")
GUICtrlSetData($Det22, "")
GUICtrlSetData($Det23, "")
GUICtrlSetData($Det31, "")
GUICtrlSetData($Det32, "")
GUICtrlSetData($Det33, "")

GUICtrlSetdata($DetAnswer, "")

Case $InvClear
GUICtrlSetData($Inverse11, "")
GUICtrlSetData($Inverse12, "")
GUICtrlSetData($Inverse13, "")
GUICtrlSetData($Inverse21, "")
GUICtrlSetData($Inverse22, "")
GUICtrlSetData($Inverse23, "")
GUICtrlSetData($Inverse31, "")
GUICtrlSetData($Inverse32, "")
GUICtrlSetData($Inverse33, "")

GUICtrlSetdata($InverseAns11, "")
GUICtrlSetdata($InverseAns12, "")
GUICtrlSetdata($InverseAns13, "")
GUICtrlSetdata($InverseAns21, "")
GUICtrlSetdata($InverseAns22, "")
GUICtrlSetdata($InverseAns23, "")
GUICtrlSetdata($InverseAns31, "")
GUICtrlSetdata($InverseAns32, "")
GUICtrlSetdata($InverseAns33, "")
;;;;;;;;;;;;;;;;;;;;;;2x2 Clear Buttons;
Case $MultClear_B
GUICtrlSetData ($Mult_22_11, "")
GUICtrlSetData ($Mult_22_12, "")
GUICtrlSetData ($Mult_22_21, "")
GUICtrlSetData ($Mult_22_22, "")

GUICtrlSetData ($Mult_22_B_11, "")
GUICtrlSetData ($Mult_22_B_12, "")
GUICtrlSetData ($Mult_22_B_21, "")
GUICtrlSetData ($Mult_22_B_22, "")

GUICtrlSetData ($Mult_22_Ans_11, "")
GUICtrlSetData ($Mult_22_Ans_12, "")
GUICtrlSetData ($Mult_22_Ans_21, "")
GUICtrlSetData ($Mult_22_Ans_22, "")

Case $DetClear_B
GUICtrlSetData ($Det_22_B_11, "")
GUICtrlSetData ($Det_22_B_12, "")
GUICtrlSetData ($Det_22_B_21, "")
GUICtrlSetData ($Det_22_B_22, "")

GUICtrlSetData ($DetAnswer_22, "")
Case $InvClear_B
GUICtrlSetData ($Inv_B_11, "")
GUICtrlSetData ($Inv_B_12, "")
GUICtrlSetData ($Inv_B_21, "")
GUICtrlSetData ($Inv_B_22, "")

GUICtrlSetData ($Inv_Ans_11, "")
GUICtrlSetData ($Inv_Ans_12, "")
GUICtrlSetData ($Inv_Ans_21, "")
GUICtrlSetData ($Inv_Ans_22, "")

EndSwitch
WEnd