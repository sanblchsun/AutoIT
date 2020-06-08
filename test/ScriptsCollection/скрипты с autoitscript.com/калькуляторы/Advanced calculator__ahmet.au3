#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <EditConstants.au3>
#include <Math.au3>

#NoTrayIcon

Dim $a,$b,$operation
$h=0
GUICreate("Calculator")
$edit=GUICtrlCreateEdit("",10,10,380,20,$ES_READONLY)

$sin=GUICtrlCreateButton("sin",10,50,30,30)
$cos=GUICtrlCreateButton("cos",10,90,30,30)
$tan=GUICtrlCreateButton("tan",10,130,30,30)
$ctg=GUICtrlCreateButton("ctg",10,170,30,30)
$asin=GUICtrlCreateButton("asin",60,50,30,30)
$acos=GUICtrlCreateButton("acos",60,90,30,30)
$atan=GUICtrlCreateButton("atan",60,130,30,30)
$1=GUICtrlCreateButton("1",100,50,30,20)
$2=GUICtrlCreateButton("2",130,50,30,20)
$3=GUICtrlCreateButton("3",160,50,30,20)
$4=GUICtrlCreateButton("4",100,70,30,20)
$5=GUICtrlCreateButton("5",130,70,30,20)
$6=GUICtrlCreateButton("6",160,70,30,20)
$7=GUICtrlCreateButton("7",100,90,30,20)
$8=GUICtrlCreateButton("8",130,90,30,20)
$9=GUICtrlCreateButton("9",160,90,30,20)
$0=GUICtrlCreateButton("0",130,110,30,20)
$plus=GUICtrlCreateButton("+",100,110,30,20)
$minus=GUICtrlCreateButton("-",160,110,30,20)
$equal=GUICtrlCreateButton("=",190,50,30,20)
$times=GUICtrlCreateButton("x",220,50,30,20)
$division=GUICtrlCreateButton("/",250,50,30,20)
$store=GUICtrlCreateButton("store",280,50,30,20)
$power=GUICtrlCreateButton("^",190,70,30,20)
$point=GUICtrlCreateButton(".",220,70,30,20)
$log=GUICtrlCreateButton("log",250,70,30,20)

$first_n=GUICtrlCreateButton("n!",280,70,30,20)
$ln=GUICtrlCreateButton("ln",190,90,30,20)
$exp=GUICtrlCreateButton("exp",220,90,30,20)
$pi=GUICtrlCreateButton("pi",250,90,30,20)
$nthroot=GUICtrlCreateButton("n-th root",280,90,50,20)
$e=GUICtrlCreateButton("e",190,110,30,20)
$sqrt=GUICtrlCreateButton("sqrt",220,110,30,20)
$logn=GUICtrlCreateButton("logn(a)",250,110,40,20)
$degtorad=GUICtrlCreateButton("DegToRad",100,130,70,20)

$clear=GUICtrlCreateButton("Clear input",10,350,70,30)
$a1=GUICtrlCreateButton("A",10,200,30,20)
$b1=GUICtrlCreateButton("B",10,220,30,20)
$c1=GUICtrlCreateButton("C",10,240,30,20)
$d1=GUICtrlCreateButton("D",40,200,30,20)
$e1=GUICtrlCreateButton("E",40,220,30,20)
$f1=GUICtrlCreateButton("F",40,240,30,20)
$a0=0
$b0=0
$c0=0
$d0=0
$e0=0
$f0=0
GUISetState()
While 1
    $msg=GUIGetMsg()
    Select
    Case $msg=$sin
        $sin2=Sin(_Radian (GUICtrlRead($edit)))
        $setdata=GUICtrlSetData($edit,"" &$sin2)
    Case $msg=$GUI_EVENT_CLOSE
        ExitLoop
    case $msg=$cos
        $cos2=Cos(_Radian (GUICtrlRead($edit)))
        $setdata=GUICtrlSetData($edit,"" &$cos2)
    Case $msg=$tan
        $tan2=Tan(_Radian (GUICtrlRead($edit)))
        $setdata=GUICtrlSetData($edit,"" &$tan2)
    Case $msg=$ctg
        $ctg2=Cos(_Radian (GUICtrlRead($edit)))/Sin(_Radian (GUICtrlRead($edit)))
        $setdata=GUICtrlSetData($edit,"" &$ctg2)
    Case $msg=$asin
        $asin2=ASin(GUICtrlRead($edit))
        $setdata=GUICtrlSetData($edit,"" & _Degree($asin2))
    Case $msg=$acos
        $acos2=ACos(GUICtrlRead($edit))
        $setdata=GUICtrlSetData($edit,"" & _Degree($acos2))
    Case $msg=$atan
        $atan2=ATan(GUICtrlRead($edit))
        $setdata=GUICtrlSetData($edit,"" & _Degree($atan2))
    Case $msg=$1
        GUICtrlSetData($edit,GUICtrlRead($edit) & "1")
    Case $msg=$2
        GUICtrlSetData($edit,GUICtrlRead($edit) & "2")
    Case $msg=$3
        GUICtrlSetData($edit,GUICtrlRead($edit) & "3")
    Case $msg=$4
        GUICtrlSetData($edit,GUICtrlRead($edit) & "4")
    Case $msg=$5
        GUICtrlSetData($edit,GUICtrlRead($edit) & "5")
    Case $msg=$6
        GUICtrlSetData($edit,GUICtrlRead($edit) & "6")
    Case $msg=$7
        GUICtrlSetData($edit,GUICtrlRead($edit) & "7")
    Case $msg=$8
        GUICtrlSetData($edit,GUICtrlRead($edit) & "8")
    Case $msg=$9
        GUICtrlSetData($edit,GUICtrlRead($edit) & "9")
    Case $msg=$0
        GUICtrlSetData($edit,GUICtrlRead($edit) & "0")
    Case $msg=$plus
        $a=GUICtrlRead($edit)
        GUICtrlSetData($edit,"")
        $operation="+"
    Case $msg=$equal
        Select
        Case $operation="+"
            GUICtrlSetData($edit,$a+GUICtrlRead($edit))
        Case $operation="-"
            GUICtrlSetData($edit,$a-GUICtrlRead($edit))
        Case $operation="*"
            GUICtrlSetData($edit,$a*GUICtrlRead($edit))
        Case $operation="/"
            GUICtrlSetData($edit,$a/GUICtrlRead($edit))
        Case $operation="^"
            GUICtrlSetData($edit,$a^GUICtrlRead($edit))
        Case $operation="logarithm"
            GUICtrlSetData($edit,logn(GUICtrlRead($edit)))
        Case $operation="nthroot"
            GUICtrlSetData($edit,GUICtrlRead($edit)^(1/$a))         
        EndSelect   
    Case $msg=$minus
        $a=GUICtrlRead($edit)
        GUICtrlSetData($edit,"")
        $operation="-"      
    Case $msg=$times
        $a=GUICtrlRead($edit)
        GUICtrlSetData($edit,"")
        $operation="*"  
    Case $msg=$division
        $a=GUICtrlRead($edit)
        GUICtrlSetData($edit,"")
        $operation="/"
    Case $msg=$power
        $a=GUICtrlRead($edit)
        GUICtrlSetData($edit,"")
        $operation="^"      
    Case $msg=$clear
        GUICtrlSetData($edit,"")
    Case $msg=$point
        GUICtrlSetData($edit,GUICtrlRead($edit) & ".")
    Case $msg=$DegToRad
        GUICtrlSetData($edit,_Radian(GUICtrlRead($edit)))
    Case $msg=$log
        GUICtrlSetData($edit,Log10(GUICtrlRead($edit)))
    Case $msg=$ln
        GUICtrlSetData($edit,Log(GUICtrlRead($edit)))
    Case $msg=$exp
        GUICtrlSetData($edit,Exp(GUICtrlRead($edit)))
    Case $msg=$pi
        GUICtrlSetData($edit,"3.14159265358979")
    Case $msg=$e
        GUICtrlSetData($edit,"2.718281828")
    Case $msg=$sqrt
        GUICtrlSetData($edit,Sqrt(GUICtrlRead($edit)))
    Case $msg=$logn
        $a=GUICtrlRead($edit)
        GUICtrlSetData($edit,"")
        $operation="logarithm"
    Case $msg=$store
        Select
        Case $a0=0
            $a0=Guictrlread($edit)
        Case $a0<>0 And $b0=0
            $b0=Guictrlread($edit)
        Case $a0<>0 And $b0<>0 And $c0=0
            $c0=Guictrlread($edit)
        Case $a0<>0 And $b0<>0 And $c0=0
            $c0=Guictrlread($edit)
        Case $a0<>0 And $b0<>0 And $c0<>0 And $d0=0
            $d0=Guictrlread($edit)
        Case $a0<>0 And $b0<>0 And $c0<>0 And $d0<>0 And $e0=0
            $e0=Guictrlread($edit)
        Case $a0<>0 And $b0<>0 And $c0<>0 And $d0<>0 And $e0<>0 And $f0=0
            $f0=Guictrlread($edit)
        EndSelect
    Case $msg=$a1
        GUICtrlSetData($edit,$a0)
    Case $msg=$b1
        GUICtrlSetData($edit,$b0)
    Case $msg=$c1
        GUICtrlSetData($edit,$c0)
    Case $msg=$d1
        GUICtrlSetData($edit,$d0)
    Case $msg=$e1
        GUICtrlSetData($edit,$e0)
    Case $msg=$f1
        GUICtrlSetData($edit,$f0)       
    Case $msg=$first_n
        $proizvod=1
        $n2=GUICtrlRead($edit)
        If $n2<0 Then
            $n2=-$n2
           For $j=1 To $n2 Step 1
              $proizvod=$j*1*$proizvod
          Next
        GUICtrlSetData($edit,-$proizvod)
        ElseIf $n2>0 Or $n2=0 Then 
           For $j=1 To $n2 Step 1
              $proizvod=$j*1*$proizvod
          Next
          GUICtrlSetData($edit,$proizvod)
      EndIf
  Case $msg=$nthroot
      $a=GUICtrlRead($edit)
      GUICtrlSetData($edit,"")
      $operation="nthroot"
    EndSelect   
WEnd
; user-defined function for common log
Func Log10($x)
    Return Log($x) / Log(10)  ;10 is the base
EndFunc

Func Logn($x)
    Return Log($a) / Log(GUICtrlRead($edit)) 
EndFunc