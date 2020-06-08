;  @AZJIO

AutoItSetOption("TrayIconHide", 1) ;������ � ��������� ������ ��������� AutoIt

GUICreate("������ ��� ������ �� Ru.Board",440,240, -1, -1, -1, 0x00000010) ; ������ ����

GUICtrlCreateLabel ("���� �  ����������� html-����� (����������� drag-and-drop)", 20,10,400,18)
$inputhtm=GUICtrlCreateInput ("", 20,30,370,22)
GUICtrlSetState(-1,8)
$folder1 = GUICtrlCreateButton("...",394, 30, 27, 22)
GUICtrlSetFont(-1, 14)
GUICtrlSetTip(-1, "�����...")

$Label000=GUICtrlCreateLabel ('������ ���������', 5,222,430,15)

$tab=GUICtrlCreateTab (0,60, 440,160) ; ������ �������

$tab0=GUICtrlCreateTabitem ("�����")

GUICtrlCreateLabel ("����� ������", 20,85,400,18)
$inputFind=GUICtrlCreateInput ("", 20,102,400,22)

GUICtrlCreateLabel ("������ ������, �������� http://...topic=41713", 20,135,400,18)
$inputHTML=GUICtrlCreateInput ("", 20,152,300,22)
$LabelHTML=GUICtrlCreateLabel ('', 330,154,90,22)
GUICtrlSetColor (-1, 0x0000ff)

$LabelSrt=GUICtrlCreateLabel ('', 20,185,90,22)
$LabelCur=GUICtrlCreateLabel ('', 120,185,90,22)

$check=GUICtrlCreateCheckbox("��� ���������", 220,183,100,22)
GUICtrlSetState(-1, 1)

$Find=GUICtrlCreateButton ("�����", 330,180,90,28)
GUICtrlSetTip(-1, "����� ������ �� ���������")


$tab0=GUICtrlCreateTabitem ("����")

GUICtrlCreateGroup("", 20, 87, 390, 36)
GUICtrlCreateLabel ("���� �����:", 40,100,70,20)
$colorname=GUICtrlCreateCombo ("", 110,97,80,24)
GUICtrlSetData(-1,'�������|�����|������|������', '�������')

GUICtrlCreateLabel ("��� �����:", 240,100,60,20)
$colorbg=GUICtrlCreateCombo ("", 300,97,90,24)
GUICtrlSetData(-1,'��.�������|��.�����|��.������|��.�����|��.�����', '��.������')

$Readme=GUICtrlCreateButton ("Readme", 220,133,90,22)
$Replace=GUICtrlCreateButton ("���������", 330,133,90,22)

GUICtrlCreateTabitem ("")   ; ����� �������
$nVx=1
$r=0
$nStr=0

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		
		$r+=1
		If $r=500 Then ; ������ 0,7 ������ �������� �����
		$r=0
			If $nVx>1 And $inputFind0<>GUICtrlRead ($inputFind) Then
				GUICtrlSetData($Find,'�����')
				GUICtrlSetData($LabelSrt,'')
				GUICtrlSetData($LabelCur,'')
				$nVx=1
			EndIf
		EndIf
		Select
; ������� "�����" ������
			Case $msg = $LabelHTML
				$inputHTML0=GUICtrlRead ($inputHTML)
				If  $nStr<>0 And $inputHTML0<>'' Then
					ShellExecute ($inputHTML0&'&start='&$nPost&'#'&$octatok+2)
				Else
					ShellExecute ('http://azjio.ucoz.ru')
				EndIf
			Case $msg = $Find
				$inputhtm0=GUICtrlRead ($inputhtm)
				$inputFind0=GUICtrlRead ($inputFind)
				$inputHTML0=GUICtrlRead ($inputHTML)
				If Not FileExists($inputhtm0) Then
					MsgBox(0, "������ ������", '����������� ���� '&$inputhtm0)
					ContinueLoop
				EndIf
				
				$file = FileOpen($inputhtm0, 0)
				$text = FileRead($file)
				FileClose($file)
				
				If $nVx=1 Then
					$inputFind000=StringRegExpReplace($inputFind0, "[][{}()*+?.\\^$|=<>#]", "\\$0")
					$text000 = StringRegExpReplace($text, $inputFind000, "$0")
					GUICtrlSetData($LabelSrt,'�������: '&@Extended)
					$text000 = ''
				EndIf
				
				$pos = StringInStr ($text, $inputFind0, 0, $nVx)
				If $pos = 0 Then
					GUICtrlSetData($Label000,  '������ �� �������')
					ContinueLoop
				EndIf
				$text = StringMid($text, 1, $pos)
				$text = StringRegExpReplace($text, '\>�����:\<', "$0") ; ������� ������ � ����������� ������������� ������ � ������ ��������
				$kol=@Extended-1
				$octatok = mod($kol, 20)
				$nPost=$kol-$octatok
				$nStr=($nPost+20)/20
				If $nStr = 1 Then $octatok=$octatok-1
				ClipPut('&start='&$nPost&'#'&$octatok+2) ; ������ � �����
				GUICtrlSetData($LabelCur,'�������: '&$nVx)
				If $inputHTML0<> '' Then
					GUICtrlSetData($LabelHTML,'������'&$nVx)
					GUICtrlSetTip($LabelHTML, $inputHTML0&'&start='&$nPost&'#'&$octatok+2)
				Else
					GUICtrlSetTip($LabelHTML, 'http://azjio.ucoz.ru')
				EndIf
				$nVx+=1
				GUICtrlSetData($Label000,  '��������: '&$nStr&',   ������: &&start='&$nPost&'#'&$octatok+2)
				If GUICtrlRead ($check)<> 1 Then MsgBox(0, '���������', '��������: '&$nStr&@CRLF&@CRLF&'��������� ������ ���������� � �����'&@CRLF&'&start='&$nPost&'#'&$octatok+2)
				GUICtrlSetData($Find,'�����')
				
; ������� ������ �����
			Case $msg = $Replace
				$colorname0=GUICtrlRead ($colorname)
				Switch $colorname0
				Case $colorname0="�������"
				    $colorname00 = "ff0000"
				Case $colorname0="������"
				    $colorname00 = "00bb00"
				Case $colorname0="�����"
				    $colorname00 = "0000ff"
				Case $colorname0="������"
				    $colorname00 = "000000"
				Case Else
				    $colorname00 = "ff0000"
				EndSwitch
				
				
				$colorbg0=GUICtrlRead ($colorbg)
				Switch $colorbg0
				Case $colorbg0="��.�������"
				    $colorbg00 = "ffeeee"
				Case $colorbg0="��.������"
				    $colorbg00 = "eeffee"
				Case $colorbg0="��.�����"
				    $colorbg00 = "eeeeff"
				Case $colorbg0="��.�����"
				    $colorbg00 = "eeeeee"
				Case $colorbg0="��.�����"
				    $colorbg00 = "fffddb"
				Case Else
				    $colorbg00 = "eeffee"
				EndSwitch
				
				
				$inputhtm0=GUICtrlRead ($inputhtm)
				; ��������� �������������, ������ ����� � ��������� ���� ��� ������ ������
				If Not FileExists($inputhtm0) Then
					MsgBox(0, "������ ������", '����������� ���� '&$inputhtm0)
					ContinueLoop
				EndIf
				$aPathname = StringRegExp($inputhtm0, "(^.*)\\(.*)$", 3)
				  $filehtm = FileOpen($inputhtm0, 0)
				; �������� �������� ����� ��� ������ ������
				If $filehtm = -1 Then
				  MsgBox(0, "������", "�� �������� ������� ����.")
				  Exit
				EndIf
				; ������ ����������
				$filehtm0 = FileRead($filehtm)
				
				
				If StringInStr($filehtm0, "<br><b>�����:</b> ") >0 Then
						   $SR1 = StringReplace($filehtm0, '<br><b>�����:</b> ', '<br>�����:<FONT color=#'&$colorname00&'><b> ')
						   $SR1 = StringReplace($SR1, ', <b>����������:</b>', '</b></FONT>, ����������: ')
						   $SR1 = StringReplace($SR1, '<img width=100% height=1 src="1px.gif" alt="">', "")
						   $SR1 = StringReplace($SR1, '<tr bgcolor=#FFFFFF>', '<tr bgcolor=#'&$colorbg00&'>')
				Else
						   $SR1 = StringRegExpReplace ($filehtm0, '<br>�����:<FONT color=.{7}><b> ', '<br>�����:<FONT color=#'&$colorname00&'><b> ')
						   $SR1 = StringRegExpReplace ($SR1, '<tr bgcolor=.{7}>', '<tr bgcolor=#'&$colorbg00&'>')
				EndIf
				  
				  $filehtmnew = FileOpen($aPathname[0]&"\new_"&$aPathname[1], 2)
				  FileWrite($filehtmnew, $SR1)
				  FileClose($filehtm)
				  FileClose($filehtmnew)
				  GUICtrlSetData($Label000, '������...')
			Case $msg = $Readme
				  MsgBox(0, "Readme", '�� ������� ������ ��������� ��������� ��� "������ ��� ������", ���� ����� �� ������ �� ���� ����� �����������, ��� ����� �� ���������. �� ����������� ��������� ������������, ����� ������� � �� ����� ��������� � ������ ����� - ������ �� �����. ��� ����������� ���������� ��������� ��������� � ������ *.htm � ���� ���������, �������� �����, ��������� ������ � ����� ������� "���������", ��������� ��������� � �������� � ������ � ������� ����.')
				  
			Case $msg = $folder1
				$inputhtm0=GUICtrlRead ($inputhtm)
				If FileExists($inputhtm0) Then
					$WorkingDir=StringRegExpReplace($inputhtm0, '(.*)\\(?:.*)$', '\1')
				Else
					$WorkingDir=@WorkingDir
				EndIf
				$folder01 = FileOpenDialog("������� HTML-����", $WorkingDir & "", "HTML-���� (*.htm;*.html)", 1 + 4 )
				If @error Then ContinueLoop
				GUICtrlSetData($inputhtm, $folder01)
			Case $msg = -3
				ExitLoop
		EndSelect
	WEnd

