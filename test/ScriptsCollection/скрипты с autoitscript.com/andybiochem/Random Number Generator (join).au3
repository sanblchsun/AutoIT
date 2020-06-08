$one = 1
$ten = 3000
 
$RandomPick1 = Random($one,$ten,1)
$RandomPick2 = Random($one,$ten,1)
$RandomPick3 = Random($one,$ten,1)
$RandomPick4 = Random($one,$ten,1)
$RandomPick5 = Random($one,$ten,1)
 
MsgBox(0,"test generator",$RandomPick1 & "-" & $RandomPick2 & "-" & $RandomPick3 & "-" & $RandomPick4 & "-" & $RandomPick5)
GuiCreate("generator",466,191,339,224)
$button1=GuiCtrlCreateButton("generate",135,63,127,32)
GuiSetState()

While 1
$msg=GuiGetMsg()
If $msg=-3 Then Exit
If $msg=$button1 Then button1()
Wend




Func button1()
$one = 1000
$ten = 9999
 
$RandomPick1 = Random($one,$ten,1)
$RandomPick2 = Random($one,$ten,1)
$RandomPick3 = Random($one,$ten,1)
$RandomPick4 = Random($one,$ten,1)
$RandomPick5 = Random($one,$ten,1)
 
MsgBox(0,"code",$RandomPick1 & "-" & $RandomPick2 & "-" & $RandomPick3 & "-" & $RandomPick4 & "-" & $RandomPick5)
EndFunc
