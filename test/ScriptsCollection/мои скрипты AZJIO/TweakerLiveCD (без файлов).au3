;  @AZJIO
#include <GUIConstants.au3>
AutoItSetOption("TrayIconHide", 1) ;������ � ��������� ������ ��������� AutoIt
Global $Ini = @ScriptDir&'\TwLiveCD.ini' ; ���� � TwLiveCD.ini
;�������� ������������� TwLiveCD.ini � ����������� ��� �����������
$answerini = ""
If Not FileExists($Ini) Then $answerini = MsgBox(4, "�������� �����������", "������ ������� ����������� TwLiveCD.ini"&@CRLF&"��� ���������� �������� ����������?")
If $answerini = "6" Then
	IniWriteSection($Ini, "general", 'url1="http://google.ru"'&@LF&'url2="http://forum.ru-board.com/topic.cgi?forum=62&topic=15384&glp#lt"'&@LF&'url3="http://clubrus.kulichki.ru"'&@LF&'url4="http://xage.ru"'&@LF&'url5="http://topdownloads.ru/search.php"'&@LF&'Place0="C:\"'&@LF&'Place1="D:\"'&@LF&'Place2="E:\"'&@LF&'Place3="X:\"'&@LF&'Place4="B:\"'&@LF&'execute0="ping 192.168. -t\1"'&@LF&'execute1="nircmd regedit "HKCU\Software"\1"'&@LF&'execute2="shellexecute.exe /h qres.exe /x 1280 /y 1024 /c:32\1"'&@LF&'execute3="regedit\1"')
	IniWriteSection($Ini, "boot", 'namekon="7sh3"'&@LF&'disk_z=Z:'&@LF&'disk_y=Y:'&@LF&'cab='&@LF&'pathreestr=')
	IniWriteSection($Ini, "size", 'size1="222"'&@LF&'size2="230"'&@LF&'size3="362"'&@LF&'size4="480"')
	IniWriteSection($Ini, "ldr", 'ntldr=PELDR'&@LF&'bootfile=peldr.bin'&@LF&'winnt=winn1.sif'&@LF&'i386=a386'&@LF&'txtsetup=TXTSETAM.SIF')
	IniWriteSection($Ini, "set", 'font=')
	IniWriteSection($Ini, "ISO", 'isonfile="pebuilder.iso"'&@LF&'nLabel="LiveCD"')
	IniWriteSection($Ini, "wim", 'Labelwim=remark')
EndIf


;��������� TwLiveCD.ini

$Inigurl1 = IniRead ($Ini, "general", "url1", "http://google.ru")
$Inigurl2 = IniRead ($Ini, "general", "url2", "http://clubrus.kulichki.ru")
$Inigurl3 = IniRead ($Ini, "general", "url3", "http://forum.ru-board.com")
$Inigurl4 = IniRead ($Ini, "general", "url4", "http://xage.ru")
$Inigurl5 = IniRead ($Ini, "general", "url5", "http://topdownloads.ru/search.php")

$Inigpl0 = IniRead ($Ini, "general", "Place0", "C:\")
$Inigpl1 = IniRead ($Ini, "general", "Place1", "D:\")
$Inigpl2 = IniRead ($Ini, "general", "Place2", "E:\")
$Inigpl3 = IniRead ($Ini, "general", "Place3", "X:\")
$Inigpl4 = IniRead ($Ini, "general", "Place4", "B:\")

$Inistl0 = IniRead ($Ini, "general", "execute0", "nircmd regedit ""HKCU\Software""\1")
$Inistl1 = IniRead ($Ini, "general", "execute1", "ping 192.168. -t\1")
$Inistl2 = IniRead ($Ini, "general", "execute2", "shellexecute.exe /h qres.exe /x 1280 /y 1024 /c:32\1")
$Inistl3 = IniRead ($Ini, "general", "execute3", "indicdll\1")

$size1= IniRead ($Ini, "size", "size1", "200")
$size2= IniRead ($Ini, "size", "size2", "230")
$size3= IniRead ($Ini, "size", "size3", "362")
$size4= IniRead ($Ini, "size", "size4", "480")

$namekon = IniRead ($Ini, "boot", "namekon", "7sh3")
$PathBartPE = IniRead ($Ini, "boot", "PathBartPE", "C:\pebuilder_xpe\BartPE")
$disk_z = IniRead ($Ini, "boot", "disk_z", "Z:")
$disk_y = IniRead ($Ini, "boot", "disk_y", "Y:")
$cab = IniRead ($Ini, "boot", "cab", "-1")
$pathreestr = IniRead ($Ini, "boot", "pathreestr", "regedit.exe")

$ntldr = IniRead ($Ini, "ldr", "ntldr", "PELDR")
$bootfile = IniRead ($Ini, "ldr", "bootfile", "peldr.bin")
$winnt = IniRead ($Ini, "ldr", "winnt", "winn1.sif")
$i386 = IniRead ($Ini, "ldr", "i386", "a386")
$txtsetup = IniRead ($Ini, "ldr", "txtsetup", "TXTSETAM.SIF")
$font = IniRead ($Ini, "set", "font", "")

$isonfile = IniRead ($Ini, "iso", "isonfile", "pebuilder.iso")
$nLabel = IniRead ($Ini, "iso", "nLabel", "LiveCD")
$Labelwim = IniRead ($Ini, "wim", "Labelwim", "remark")

; ������ �������� ����, �������, ������.
GUICreate("Tweaker LiveCD v1.6.1",500,420) ; ������ ����

If $font<>"" Then GUISetFont($font)
$restart=GUICtrlCreateButton ("R", 468,13,20,17)
GUICtrlSetTip(-1, "������� �������")

$tab=GUICtrlCreateTab (10,10, 480,400) ; ������ �������
; ���������
$strsost="���������� ��������� ��������"&@CRLF&"� ���������� ������."
$tipreestr="��� ��������� ������ �������."&@CRLF&"� ����� TwLiveCD.ini �������"&@CRLF&"�������������� ���� � pathreestr="

$tab95=GUICtrlCreateTabitem ("WIM") ; ��� �������

$Radiocombo91= GUICtrlCreateRadio("������ ��������� � ����� BartPE ������� (�������������)", 20, 51, 400, 20)
GUICtrlSetState($Radiocombo91, $GUI_CHECKED)
$Radioinput91 = GUICtrlCreateRadio("", 20, 81, 20, 20)
GUICtrlSetTip(-1, "������������ ����� �����"&@CRLF&"��� ����� ����� ���������")

$tab2input91=GUICtrlCreateInput ($disk_y, 40,80,400,22)
GUICtrlSetState($tab2input91, $GUI_DISABLE)
$Path91=GUICtrlCreateButton ("...", 445,79,35,24)
GUICtrlSetTip(-1, "������� ����� ��� ���� ������"&@CRLF&"��� ���������� �����.")

$imgtowim91=GUICtrlCreateButton ('����������� IMG � '&$disk_y, 40,110,137,22)
GUICtrlSetTip(-1, "����������� ��������� Boot.img ��� ����� � �������� � WIM."&@CRLF&"�� ����� ������ ���� �������� 9 ��, ����� ���� �� ���������."&@CRLF&"������������ Boot.img ����������, ������������� ������������"&@CRLF&"��� �����.")
GUICtrlCreateLabel ('��� ����� ��������������� ����� ����������� ���������� 9 �� ���������� ����� �� �����!', 190,110,290,32)
GUICtrlCreateLabel ('��������� �� ����� ����������� � Boot.img.', 190,140,290,32)

$disimg91=GUICtrlCreateButton ('������������� '&$disk_y, 40,140,137,22)
GUICtrlSetTip(-1, "������������� ����")



$Label96=GUICtrlCreateLabel ('����� WIM:', 190,170,80,20)
GUICtrlSetTip(-1, "���� ����� ������� �������"&@CRLF&"WIM-����� �� ���������������")
$tabcomboLabel=GUICtrlCreateCombo ("", 260,166,79,18)
GUICtrlSetData(-1,$Labelwim&'|remark|WinPe|1', $Labelwim)

GUICtrlCreateGroup("", 16, 190, 158, 180)
GUICtrlCreateLabel ('� ������ �������', 20,200,150,20)
$reestr91=GUICtrlCreateButton ("����� Regedit", 20,280,141,22)
GUICtrlSetTip(-1, $tipreestr)
$start92=GUICtrlCreateButton ("����������� WIM", 20,340,141,22)
GUICtrlSetTip(-1, "����������� WinPe.wim � ����� BartPE"&@CRLF&"� ��������� � �����������")
$start93=GUICtrlCreateButton ("��������� ������", 20,220,141,22)
GUICtrlSetTip(-1, "��������� ����� ������� LiveCD �������")

GUICtrlCreateGroup("", 16, 370, 468, 30)
$Label95=GUICtrlCreateLabel ('������ ���������', 20,380,450,20)
GUICtrlSetTip(-1, $strsost)

$start90=GUICtrlCreateButton ("1 �����", 340,320,137,22)
GUICtrlSetTip(-1, "������ ����������� ������"&@CRLF&"� ���������� ������")
$start91=GUICtrlCreateButton ("2 ��������� � WIM", 340,350,137,22)
GUICtrlSetTip(-1, "��������� ����� �������"&@CRLF&"� ��������� � wim-�����")







$tab55=GUICtrlCreateTabitem ("IMG") ; ��� �������

$Label00=GUICtrlCreateLabel ('����������� ������:', 20,50,120,20)
GUICtrlSetTip(-1, "������ �� ���-�� 7sh3 - AZJIO, Alkid")
$tabcomboname=GUICtrlCreateCombo ("", 150,47,125,18)
GUICtrlSetData(-1,$namekon&'|7sh3|RusLive-NTFS|RusLive-FAT32', $namekon)

$check00=GUICtrlCreateCheckbox ("���������� (CAB)", 290,50,180,20)
GuiCtrlSetState($cab, $GUI_CHECKED)
GUICtrlSetTip($check00, "������� ����� � cab-�����."&@CRLF&"�� ������������ ������� ��������� ��� ��������.")

$Label00=GUICtrlCreateLabel ('������� ������ img-�����, ��', 20,80,180,20)
GUICtrlSetTip(-1, "� �������� 40-480")
$tab0combo0=GUICtrlCreateCombo ("", 210,77,65,18)
GUICtrlSetData(-1,$size1&'|'&$size2&'|'&$size3&'|'&$size4, $size1)

$Label3=DriveSpaceFree (@ScriptDir)
$Label4=GUICtrlCreateLabel ('�������� �� �����: '&Ceiling($Label3)&' ��', 290,110,200,20)

GUICtrlCreateGroup("", 16, 130, 468, 43)
$Label5=GUICtrlCreateLabel ('������ ���������', 20,140,450,20)
GUICtrlSetTip(-1, $strsost)
$Label6=GUICtrlCreateLabel ('', 20,155,450,20)

$showsize=GUICtrlCreateButton ("������� ������", 290,77,110,22)
GUICtrlSetTip(-1, "������� ������ Boot.img,"&@CRLF&"���� � CAB-������, �� � �����������.")

GUICtrlCreateGroup("", 16, 190, 158, 180)
GUICtrlCreateLabel ('� ������ �������', 20,200,150,20)
$unload1=GUICtrlCreateButton ("��������� ������", 20,220,141,22)
GUICtrlSetTip(-1, "��������� ����� ������� LiveCD �������")
$unload2=GUICtrlCreateButton ("������������� �����", 20,250,141,22)
GUICtrlSetTip(-1, "������������� ����������� ����� �������")
GUICtrlSetState($unload2, $GUI_DISABLE)
If FileExists($disk_z&'\') Then GUICtrlSetState($unload2, $GUI_ENABLE)
$reestr=GUICtrlCreateButton ("����� Regedit", 20,280,141,22)
GUICtrlSetTip(-1, $tipreestr)
$cabpac=GUICtrlCreateButton ("��������� � im_", 20,310,141,22)
GUICtrlSetTip(-1, "��������� ����� Boot.img, BootSDI.img"&@CRLF&"� �������� �������")
$cabizv=GUICtrlCreateButton ("����������� im_", 20,340,141,22)
GUICtrlSetTip(-1, "����������� ����� Boot.im_, BootSDI.im_"&@CRLF&"� �������� �������")

$continue=GUICtrlCreateButton ("����������", 390,350,87,22)
GUICtrlSetTip(-1, "���������� ����������")
GUICtrlSetState($continue, $GUI_DISABLE)

$start=GUICtrlCreateButton ("�����", 390,380,87,22)
GUICtrlSetTip(-1, "������ ���������� ��� ������ ������������ Boot.img"&@CRLF&"������������� ���������� ��� ���������� �����������.")






$tab55=GUICtrlCreateTabitem ("minint") ; ��� �������

$Radioinput00 = GUICtrlCreateRadio("������ �� �����, ������", 20, 40, 180, 20)
GUICtrlSetTip(-1, "LiveCD �� ����� ������������� ��� minint")
GUICtrlSetState($Radioinput00, $GUI_CHECKED)

$Radioinput01 = GUICtrlCreateRadio("������ � ����� BartPE", 20, 60, 180, 20)
GUICtrlSetTip(-1, "LiveCD � ������� ����� BartPE")

$Label61=GUICtrlCreateLabel ("����� �����:", 212,42,80,20)
$bykvadicka=GUICtrlCreateCombo ("", 290,38,43,18)
GUICtrlSetData(-1,'C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z', 'C')

GUICtrlCreateGroup("", 16, 130, 468, 30)
$Label65=GUICtrlCreateLabel ('������ ���������', 20,140,450,20)
GUICtrlSetTip(-1, $strsost)

GUICtrlCreateGroup("", 16, 190, 158, 180)
GUICtrlCreateLabel ('� ������ �������', 20,200,150,20)
$unload67=GUICtrlCreateButton ("��������� ������", 20,220,141,22)
GUICtrlSetTip(-1, "��������� ����� ������� LiveCD �������")
$unload68=GUICtrlCreateButton ("������������� �����", 20,250,141,22)
GUICtrlSetTip(-1, "������������� ����������� ����� �������")
GUICtrlSetState($unload68, $GUI_DISABLE)
If FileExists($disk_z&'\') Then GUICtrlSetState($unload68, $GUI_ENABLE)
$reestr61=GUICtrlCreateButton ("����� Regedit", 20,280,141,22)
GUICtrlSetTip(-1, $tipreestr)
$backup=GUICtrlCreateButton ("����� �������", 20,310,141,22)
GUICtrlSetTip(-1, "���������� ����� ������ ������� � ����� �������")
GUICtrlSetState($backup, $GUI_DISABLE)
$restore=GUICtrlCreateButton ("������������ ������", 20,340,141,22)
GUICtrlSetTip(-1, "������������ ����� ������� �� ������")
GUICtrlSetState($restore, $GUI_DISABLE)

GUICtrlCreateGroup("", 180, 190, 158, 180)
GUICtrlCreateLabel ('�������������', 184,200,150,20)
$load67=GUICtrlCreateButton ("��������� ������", 184,220,141,22)
GUICtrlSetTip(-1, "��������� ����� ������� �������,"&@CRLF&"������ ������� system32 (������ ������)")

$startmini=GUICtrlCreateButton ("1  �����", 390,320,87,22)
GUICtrlSetTip(-1, "������ ����������")

$contmini=GUICtrlCreateButton ("2 ����������", 390,350,87,22)
GUICtrlSetTip(-1, "���������� ����������")
GUICtrlSetState($contmini, $GUI_DISABLE)

$finish=GUICtrlCreateButton ("3 ���������", 390,380,87,22)
GUICtrlSetTip(-1, "��������� ����������")
GUICtrlSetState($finish, $GUI_DISABLE)




$tab0=GUICtrlCreateTabitem ("�����") ; ��� �������
GUICtrlCreateLabel ("����� ��������� ��� ���� ������. ������������ � TwLiveCD.ini.", 30,40,450,20)

$checkCN01=GUICtrlCreateCheckbox ("����������: ����, ���������, NumLock *", 20,60,450,20)
GUICtrlSetTip(-1, "�������� ���������� �� ������� WinXP")
$checkCN02=GUICtrlCreateCheckbox ("��������� ���������� *", 20,80,450,20)
GUICtrlSetTip(-1, "������ ������������, ���, ����������"&@CRLF&"�������� ���������� �� ������� WinXP")
$checkCN03=GUICtrlCreateCheckbox ("����� � ����������� ���� - ""������� � ����� ����""", 20,100,370,20)
GUICtrlSetTip(-1, "���� ����� ��� �������� ����� � ����� ����")
$tabBut03=GUICtrlCreateButton ("< �������.", 400,100,80,20)
GUICtrlSetTip(-1, "������� ���� ����� �� ������������ ����")
$checkCN04=GUICtrlCreateCheckbox ("��������� ���� ���� *", 20,120,370,20)
GUICtrlSetTip(-1, "�������� ���������� �� ������� WinXP")
$checkCN05=GUICtrlCreateCheckbox ("���� ���� �� ������������, � XP-�����", 20,140,450,20)
$checkCN06=GUICtrlCreateCheckbox ("������� ����� ""������"" �� ��������. ����", 20,160,450,20)
GUICtrlSetTip(-1, "������ � LiveCD �� ��������"&@CRLF&" ������� �������.")
$checkCN08=GUICtrlCreateCheckbox ("������� � ���� ��� ������������� ������������ ���� ���������� *", 20,180,450,20)
GUICtrlSetTip(-1, "���� � ������ ������ ������� ����"&@CRLF&"�������� ���������� �� ������� WinXP")
$checkCN09=GUICtrlCreateCheckbox ("�������� � �������������� ������ ������ ""���� > ���������""", 20,200,467,20)
GUICtrlSetTip(-1, "�������� TwLiveCD.ini\execute<n>=")
$checkCN013=GUICtrlCreateCheckbox ("���������� ������ � �������������� ������ �������� IE", 20,220,450,20)
GUICtrlSetTip(-1, "�������� TwLiveCD.ini\url<n>="&@CRLF&"������ ���� ���������")
$checkCN07=GUICtrlCreateCheckbox ("��������� ����������", 20,240,370,20)
GUICtrlSetTip(-1, "������������� txt, log, cfg, lst, diz, nfo � ���������"&@CRLF&"�������� assot.cmd, ���� �����������"&@CRLF&"������� ���� � ������ ��������")
$checkCN012=GUICtrlCreateCheckbox ("���������� ������", 20,260,140,20)
GUICtrlSetTip(-1, "��� ���������� ������������� 800x600"&@CRLF&"�������������� ������ � ����������� ����������� ������ - 1024x768"&@CRLF&"������������� ��� ���� ���� ����� ������� ����� �� ������")
$tab012combo=GUICtrlCreateCombo ("", 160,260,95,18)
GUICtrlSetData(-1,"800x600|1024x768|1280x1024|1600x1200", "1024x768")
$checkCN011=GUICtrlCreateCheckbox ("���������� ���� ""��������� ���..."" - ��������� ����� ������", 20,283,380,20)
GUICtrlSetTip(-1, "��������� ���� ������� ����� � ����������� ��������"&@CRLF&"�������� � TwLiveCD.ini\Place<n>=")
$tabBut011=GUICtrlCreateButton ("< �������.", 400,283,80,20)
GUICtrlSetTip(-1, "������������ ���� ������� �� ���������")
$checkCN010=GUICtrlCreateCheckbox ("�������� ���� ������������������ WindowsXP (����������� ������ readme)", 20,303,467,20)
GUICtrlSetTip(-1, "����������� �������������."&@CRLF&"��� RAM-������ ������������� �� ����")
$checkCN081=GUICtrlCreateCheckbox ("�������� ������ ��� ������� ������������������� ���� ����� (314 ��)", 20,323,450,20)
GUICtrlSetTip(-1, "�������� assot_icons.cmd")
$checkCN019=GUICtrlCreateCheckbox ("������ ������ �� Vista Transformation Pack", 20,343,370,20)
GUICtrlSetTip(-1, "��� ���� ��� dll, exe, cpl,"&@CRLF&"������ � ����� resources")
$tabBut01=GUICtrlCreateButton ("�������� ��", 390,350,87,22)
GUICtrlSetTip(-1, "���������� ������� �� ��� ������")
$vkladka01=GUICtrlCreateButton ("���������", 390,380,87,22)
GUICtrlSetTip(-1, "��������� ���������� �����."&@CRLF&"��� ���� ������ ����� ��� ���������"&@CRLF&"���������� ����������� �������.")
GUICtrlCreateLabel ("* ��������� ���������� �� ������� WindowsXP", 30,380,450,20)



$tab1=GUICtrlCreateTabitem ( "*.*") ; ��� �������
GUICtrlCreateLabel ("������� ������ � ����������� ���� ""�������"" ��� ��������� ����� ������.", 30,40,450,20)
GUICtrlSetTip(-1, "���� ����� ����� ���� ""��������� ��������"","&@CRLF&"�� ����� ��� ������ �� ������ � �������� ������")

$tabBut0101=GUICtrlCreateCheckbox ("3dg", 20,60,70,20)
$tabBut0102=GUICtrlCreateCheckbox ("ais", 20,80,70,20)
$tabBut0103=GUICtrlCreateCheckbox ("au3", 20,100,70,20)
$tabBut0104=GUICtrlCreateCheckbox ("bmp", 20,120,70,20)
$tabBut0105=GUICtrlCreateCheckbox ("doc", 20,140,70,20)
$tabBut0106=GUICtrlCreateCheckbox ("docx", 20,160,70,20)
$tabBut0107=GUICtrlCreateCheckbox ("dst", 20,180,70,20)
$tabBut0108=GUICtrlCreateCheckbox ("egc", 20,200,70,20)
$tabBut0109=GUICtrlCreateCheckbox ("fxp", 20,220,70,20)
$tabBut0110=GUICtrlCreateCheckbox ("ppt", 20,240,70,20)

$tabBut0111=GUICtrlCreateCheckbox ("pptx", 100,60,70,20)
$tabBut0112=GUICtrlCreateCheckbox ("psd", 100,80,70,20)
$tabBut0113=GUICtrlCreateCheckbox ("rar", 100,100,70,20)
$tabBut0114=GUICtrlCreateCheckbox ("rsnp", 100,120,70,20)
$tabBut0115=GUICtrlCreateCheckbox ("rtf", 100,140,70,20)
$tabBut0116=GUICtrlCreateCheckbox ("slg", 100,160,70,20)
$tabBut0117=GUICtrlCreateCheckbox ("tpp", 100,180,70,20)
$tabBut0118=GUICtrlCreateCheckbox ("wav", 100,200,70,20)
$tabBut0119=GUICtrlCreateCheckbox ("xls", 100,220,70,20)
$tabBut0120=GUICtrlCreateCheckbox ("xlsx", 100,240,70,20)

$tabBut0121=GUICtrlCreateCheckbox ("zip", 180,60,70,20)

$tabBut11=GUICtrlCreateButton ("�������� ��", 390,350,87,22)
GUICtrlSetTip(-1, "���������� ������� �� ��� ������")
$vkladka02=GUICtrlCreateButton ("�������", 390,380,87,22)
GUICtrlSetTip(-1, "������� ����������")



$tab2=GUICtrlCreateTabitem ("7sh3") ; ��� �������
GUICtrlCreateLabel ("����� ��� ������ �� ����������� 7sh3 �� 26.03.2008", 30,40,450,20)
$checkCN20=GUICtrlCreateCheckbox ("���������� ������ (qres.exe)", 20,60,200,20)
$tab20combo=GUICtrlCreateCombo ("", 220,60,95,18)
GUICtrlSetData(-1,"800x600|1024x768|1280x1024|1600x1200|Delete", "1024x768")
$checkCN21=GUICtrlCreateCheckbox ("������� ����� WindowBlinds", 20,80,200,20)
GUICtrlSetTip(-1, "��������� ������ ������ � �������")
$checkCN22=GUICtrlCreateCheckbox ("���� �������� ����� (*.jpg)", 20,100,450,20)
GUICtrlSetTip(-1, "�� ��� ������ ������������ *.jpg")
$checkCN23=GUICtrlCreateCheckbox ("������� ������ � �������� �� ������� �����", 20,120,450,20)
GUICtrlSetTip(-1, '�������� menu_Toolbars.cmd. ������ �� ����� "panel"'&@CRLF&'����� ��������� � sfx-����� ADDFILE.EXE.')
$checkCN24=GUICtrlCreateCheckbox ("����� ���������� ��� ��������� WIM-RW", 20,140,450,20)
GUICtrlSetTip(-1, "ProfilesDir, USERPROFILE, ALLUSERSPROFILE,"&@CRLF&"����� %ramdrv% ������ %temp%")
$vkladka03=GUICtrlCreateButton ("���������", 390,380,87,22)

$tab3=GUICtrlCreateTabitem ("RusLive") ; ��� �������
GUICtrlCreateLabel ("����� ��� ������ RusLive", 30,40,450,20)
$checkCN31=GUICtrlCreateCheckbox ("���� �������� ����� (*.bmp - 150 ��)", 20,80,450,20)
GUICtrlSetTip(-1, "*.bmp - ������������ ����� ������")
$checkCN32=GUICtrlCreateCheckbox ("������� ������ � �������� �� ������� �����", 20,100,450,20)
GUICtrlSetTip(-1, '�������� panel_link.cmd. ������ �� ����� "panelRL"'&@CRLF&'����� ��������� � ������.')
$vkladka04=GUICtrlCreateButton ("���������", 390,380,87,22)



$tab3=GUICtrlCreateTabitem ("LDR") ; ��� �������

GUICtrlCreateGroup("", 16, 31, 468, 101)
$Label80=GUICtrlCreateLabel ("����� �����:", 20,47,80,20)
$bykvadicka80=GUICtrlCreateCombo ("", 98,43,43,18)
GUICtrlSetData(-1,'C|D|E|F|G|H|I|J|K|L|M|N|O|P|Q|R|S|T|U|V|W|X|Y|Z', 'C')
$Label81=GUICtrlCreateLabel ("��� NTLDR:", 152,47,80,20)
GUICtrlSetTip(-1, "��� ������������� � ���� ������������ �������")
$filename81=GUICtrlCreateCombo ("", 230,43,93,18)
GUICtrlSetData(-1,$ntldr&'|PELDR|b1ldr|b2ldr|b3ldr', $ntldr)
$Label82=GUICtrlCreateLabel ("��� �����:", 152,77,80,20)
GUICtrlSetTip(-1, "��� ������������ ����� ������������ �������")
$filename82=GUICtrlCreateCombo ("", 230,73,93,18)
GUICtrlSetData(-1,$bootfile&'|peldr.bin|b1.bin|b2.bin|b3.bin', $bootfile)

$tab8input=GUICtrlCreateInput ("WinPE", 152,105,175,22)

$Boot80=GUICtrlCreateButton ("������� �����������", 340,45,137,22)
GUICtrlSetTip(-1, "������� ����������� �������� WinXP,"&@CRLF&"������� ����������� ������ �� ��������� ����."&@CRLF&"������� ������  �������"&@CRLF&"����������� ��� ��������������")
$Boot81=GUICtrlCreateButton ("������ � ����", 340,75,137,22)
GUICtrlSetTip(-1, "���������� ����������� ������"&@CRLF&"� ���������� ����� � ����")
$Boot82=GUICtrlCreateButton ("����� � �������e", 340,105,137,22)
GUICtrlSetTip(-1, "�������� ������ � ���� �������� boot.ini"&@CRLF&"��� ������ �������� ��� ������ OS")

GUICtrlCreateGroup("���� SETUPLDR.BIN", 16, 152, 468, 118)

$CheckChange80=GUICtrlCreateCheckbox ("������� ����� winnt.sif ��", 20,176,200,22)
GUICtrlSetTip(-1, "���� ����������� ������������"&@CRLF&"��������� RAM, WIM-������"&@CRLF&"�� ����� �����/������")
$nameChange80=GUICtrlCreateCombo ("", 235,174,123,18)
GUICtrlSetData(-1,$winnt&'|winn1.sif|Boot1.sif|Boot1.txt', $winnt)

$CheckChange81=GUICtrlCreateCheckbox ("������� ����� i386 ��", 20,206,200,22)
GUICtrlSetTip(-1, "�������� i386 ��� RAM")
$nameChange81=GUICtrlCreateCombo ("", 235,204,123,18)
GUICtrlSetData(-1,$i386&'|a386|b386|r386|x386|RULV', $i386)

$CheckChange82=GUICtrlCreateCheckbox ("������� ����� TXTSETUP.SIF ��", 20,236,200,22)
GUICtrlSetTip(-1, "���� ����������� ������������"&@CRLF&"��������� ������������ ��������,"&@CRLF&"�������� ��������������")
$nameChange82=GUICtrlCreateCombo ("", 235,234,123,18)
GUICtrlSetData(-1,$txtsetup&'|TXTSETAM.SIF|TXTSETNS.SIF|TXTSET01.SIF', $txtsetup)

$unsetldr=GUICtrlCreateButton ("�����", 390,205,87,22)
GUICtrlSetTip(-1, "�������� ��������� �� ���������, � ��������."&@CRLF&"TXTSETUP.SIF, WINNT.SIF, i386"&@CRLF&"������������� ��� �������� ���������� �����.")

$Changestart=GUICtrlCreateButton ("���������", 390,235,87,22)
GUICtrlSetTip(-1, "��������� ����"&@CRLF&"������ ��� ���������.")

GUICtrlCreateGroup("", 16, 370, 468, 30)
$Label89=GUICtrlCreateLabel ('������ ���������', 20,380,450,20)
GUICtrlSetTip(-1, $strsost)


$tab95=GUICtrlCreateTabitem ("ISO") ; ��� �������
GUICtrlCreateLabel ('������ ������ ��������� � ����� BartPE �������', 20,40,400,20)
GUICtrlCreateGroup("����� ����������", 21, 60, 140, 106)

$Radioinput330 = GUICtrlCreateRadio("BCDW-2", 30, 80, 110, 20)
GUICtrlSetTip(-1, "���� � ������� ������� ��������")
GUICtrlSetState($Radioinput330, $GUI_CHECKED)

$Radioinput331 = GUICtrlCreateRadio("BCDW-1.5", 30, 100, 110, 20)
GUICtrlSetTip(-1, "���� � ������� ������� ��������")

$Radioinput332 = GUICtrlCreateRadio("Grub", 30, 120, 110, 20)
GUICtrlSetTip(-1, "���� � ������� ������� ��������"&@CRLF&"������������ mkisofs.exe")

$Radioinput333 = GUICtrlCreateRadio("BOOTSECT.BIN", 30, 140, 110, 20)
GUICtrlSetTip(-1, "��������� �������� WinNT-������ (WinXP, WinPE)")


$Label334=GUICtrlCreateLabel ("����� �����:", 172,82,80,20)
GUICtrlSetTip(-1, "����� - ������ ���, �����")
$nameLabel335=GUICtrlCreateCombo ("", 250,78,113,18)
GUICtrlSetData(-1,$nLabel&'|WinXPE|LiveCD|LiveDVD|BootCD', $nLabel)
$Label336=GUICtrlCreateLabel ("��� �����:", 172,112,80,20)
GUICtrlSetTip(-1, "��� ������������ ISO-�����.")
$filenameiso337=GUICtrlCreateCombo ("", 250,108,113,18)
GUICtrlSetData(-1,$isonfile&'|pebuilder.iso|liv.iso|boot.iso|cd.iso', $isonfile)

GUICtrlCreateLabel ('��� ������ ������������ cdimage.exe � ����������� -l -g -h -c -j1 -m -o -b', 20,180,460,20)
GUICtrlCreateLabel ('-m ��� ����������� �� ������, �� ���� ���� DVD-�����', 20,200,460,20)
GUICtrlCreateLabel ('-o �������������� ����� ����������� ���������� ������������� ������', 20,220,460,20)
GUICtrlCreateLabel ('��������� ����� ����������� �� ������������', 20,240,460,20)
GUICtrlCreateLabel ('��� Grub ������������ mkisofs.exe', 20,260,460,20)


GUICtrlCreateGroup("", 16, 340, 468, 30)
$Label339=GUICtrlCreateLabel ('������ ���������', 20,350,450,20)
GUICtrlSetTip(-1, $strsost)

$startiso=GUICtrlCreateButton ("������� ISO", 390,380,87,22)
GUICtrlSetTip(-1, "�������� ����������� ISO")


$tab4=GUICtrlCreateTabitem ("?") ; ��� �������
GUICtrlCreateLabel ("��������� ����� ���������� �� ������� ������� WindowsXP.", 30,60,450,20)
GUICtrlCreateLabel ("� TwLiveCD.ini ����� ������� ��������� (url, ���������, ��������� ���...)", 30,80,450,20)
GUICtrlCreateLabel ("����� ������� IMG � LDR ��������� � ����� �������.", 30,100,450,20)
GUICtrlCreateLabel ("������ ��������� ���������� ��� ��������.", 30,120,450,20)

GUICtrlCreateLabel ("�����: AZJIO 12.8.2009", 340,380,137,22)

GUICtrlCreateTabitem ("")   ; ����� �������

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
; ������ ������� ISO
            Case $msg = $startiso
					GUICtrlSetData($Label339, '������� ������ �������.')
					$nLabel335=GUICtrlRead ($nameLabel335)
					$fniso337=GUICtrlRead ($filenameiso337)
					$answeriso = ""
					If FileExists(@ScriptDir&'\'&$fniso337) Then $answeriso = MsgBox(4, "�������� �����������", '������� ������������ ���� '&$fniso337&' � ������� ����� ������� ����� ������������?')
					If $answeriso = "6" Then FileDelete ( @ScriptDir&'\'&$fniso337 )
					If FileExists(@ScriptDir&'\'&$fniso337) Then
					   $answerini = MsgBox(0, "������ ������", '������� ���� '&$fniso337&' � ������� ����� �������?')
					ContinueLoop
					EndIf
					If GUICtrlRead ($Radioinput330) = $GUI_CHECKED Then $bootcdldr=@ScriptDir&'\isoldr\LOADER.BIN'
					If GUICtrlRead ($Radioinput331) = $GUI_CHECKED Then $bootcdldr=@ScriptDir&'\isoldr\bcdwboot.bin'
					If GUICtrlRead ($Radioinput332) = $GUI_CHECKED Then $bootcdldr=@ScriptDir&'\isoldr\GRLDR.BIN'
					If GUICtrlRead ($Radioinput333) = $GUI_CHECKED Then $bootcdldr=@ScriptDir&'\isoldr\BOOTSECT.BIN'
					If Not FileExists($bootcdldr) Then
					MsgBox(0, "������ ������", '����������� ��������� '&$bootcdldr)
					ContinueLoop
					EndIf
					GUICtrlSetState($startiso, $GUI_DISABLE)
					If GUICtrlRead ($Radioinput332) = $GUI_CHECKED Then
					FileCopy(@ScriptDir&'\isoldr\GRLDR.BIN', @ScriptDir & '\BartPE', 1)
					ShellExecute ( @ScriptDir&'\mkisofs.exe','-duplicates-once -iso-level 4 -volid "'&$nLabel335&'" -b GRLDR.BIN -no-emul-boot -boot-load-size 4 -hide GRLDR.BIN -hide boot.catalog -o "'&@ScriptDir&'\'&$fniso337&'" "'&@ScriptDir&'\BartPE"','','', @SW_HIDE )
					Else
					ShellExecute ( @ScriptDir&'\cdimage.exe','-l'&$nLabel335&' -g -h -c -j1 -m -o -b'&$bootcdldr&' BartPE "'&$fniso337&'"','','', @SW_HIDE )
					EndIf
					GUICtrlSetData($Label339, 'ISO-���� ������.')
					IniWrite($Ini, "ISO", "isonfile", $fniso337)
					IniWrite($Ini, "ISO", "nLabel", $nLabel335)
					GUICtrlSetData($Label339, 'ISO-���� ������. ��������� ���������. ������.')
					GUICtrlSetState($startiso, $GUI_ENABLE)
; ����� ������� ISO
; ������ ������� WIM
            Case $msg = $disimg91
					If FileExists($disk_y&'\') Then
					; �������������� ����� Y � ��������� ����. �������
					RunWait ( @Comspec & ' /C vdk.exe close 0 | find /v "http:" | find /v "version"', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C vdk.exe stop | find /v "http:" | find /v "version"', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C vdk.exe remove | find /v "http:" | find /v "version"', '', @SW_HIDE )
					EndIf
					If Not FileExists($disk_y&'\') Then GUICtrlSetData($Label95, '���� '&$disk_y&' ������������')
            Case $msg = $imgtowim91
					If Not FileExists($disk_y&'\') Then $Tmpimgtowim411 = FileOpenDialog("����� Boot.img.", @WorkingDir & "", "����� ����� (*.img)", 1 + 4, 'Boot.img' )
					If @error Then
					GUICtrlSetData($Label95, '�� ������ ���� Boot.img')
					ContinueLoop
					EndIf
					If Not FileExists($disk_y&'\') Then
					; ��������� � ������ ������������ �������
					RunWait ( @Comspec & ' /C vdk.exe install | find /v "http:" | find /v "version"', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C vdk.exe start | find /v "http:" | find /v "version"', '', @SW_HIDE )
					GUICtrlSetData($Label95, "����������� ������ ����������")
					; ������������ ����� Boot.img ��� ���� Y
					RunWait ( @Comspec & ' /C vdk.exe open 0 "'&$Tmpimgtowim411&'" /rw /p:0 /l:'&$disk_y&' | find /v "http:" | find /v "version" | find /v "Failed"', '', @SW_HIDE )
					   GUICtrlSetData($Label95, '���� '&$disk_y&' �����������.')
					Else
					   GUICtrlSetData($Label95, '������������ ���� '&$disk_y)
					   MsgBox(0, "������ ������", '������������ ���� '&$disk_y)
					EndIf
            Case $msg = $Path91
					GUICtrlSetState($tab2input91, $GUI_ENABLE)
					GUICtrlSetState($Radioinput91, $GUI_CHECKED)
					$TmpPath91 = FileSelectFolder ( "������� ���� ��� ����� ������",'','3',@WorkingDir & '\BartPE')
					GUICtrlSetData($tab2input91, $TmpPath91)
            Case $msg = $Radioinput91
					GUICtrlSetState($tab2input91, $GUI_ENABLE)
            Case $msg = $Radiocombo91
					GUICtrlSetState($tab2input91, $GUI_DISABLE)
            Case $msg = $start90
					$answerwim = ""
					If GUICtrlRead ($Radiocombo91) = $GUI_CHECKED Then $PathBartPE91=@ScriptDir&'\BartPE'
					If GUICtrlRead ($Radioinput91) = $GUI_CHECKED Then $PathBartPE91=GUICtrlRead ($tab2input91)
					If Not FileExists($PathBartPE91&'\i386\txtsetup.sif') Then $answerwim = MsgBox(4, "������ ������", '�������� ������ ����������� ��� ��� txtsetup.sif �� ������, �� ��������� ������ ���������� ����������� ������ � ��������������� txtsetup.sif. ������ "��������� ������" ������ ������.')
					If $answerwim = "7" Then
					ContinueLoop
					EndIf
					GUICtrlSetState($start90, $GUI_DISABLE)
					GUICtrlSetState($start91, $GUI_DISABLE)
					GUICtrlSetData($Label95, '���� 1. ����������� ����������� ������.')
					DirCopy(@ScriptDir&'\WIM-IMAGE\WinPeWim', $PathBartPE91, 1)
					GUICtrlSetData($Label95, '���� 2. ���������� ������ � txtsetup.sif.')
					IniWrite($PathBartPE91&'\i386\txtsetup.sif', "files.fbwf", "fbwflib.dll,2 ;", "")
					IniWrite($PathBartPE91&'\i386\txtsetup.sif', "files.fbwf", "fbwf.sys,4 ;", "")
					IniWrite($PathBartPE91&'\i386\txtsetup.sif', "files.fltmgr", "fltlib.dll,2 ;", "")
					IniWrite($PathBartPE91&'\i386\txtsetup.sif', "files.fltmgr", "fltmgr.sys,4 ;", "")
					IniWrite($PathBartPE91&'\i386\txtsetup.sif', "files.wimfsf", "wimfsf.sys,4 ;", "")
					IniWrite($PathBartPE91&'\i386\txtsetup.sif', "BusExtenders.Load", "fltmgr", "fltmgr.sys")
					IniWrite($PathBartPE91&'\i386\txtsetup.sif', "BusExtenders.Load", "fbwf", "fbwf.sys")
					IniWrite($PathBartPE91&'\i386\txtsetup.sif', "BusExtenders.Load", "wimfsf", "wimfsf.sys")
					
					IniWriteSection($PathBartPE91&'\i386\txtsetup.sif', "hal", 'acpipic_up    =halacpi.dll ,2,hal.dll'&@LF&'e_isa_up      =hal.dll     ,2,hal.dll'&@LF&'mps_up        =halapic.dll ,2,hal.dll'&@LF&'mps_mp        =halmps.dll  ,2,hal.dll'&@LF&'acpiapic_up   =halaacpi.dll,2,hal.dll'&@LF&'acpiapic_mp   =halmacpi.dll,2,hal.dll')
					IniWriteSection($PathBartPE91&'\i386\txtsetup.sif', "Hal.Load", 'acpipic_up    =halacpi.dll'&@LF&'e_isa_up      =hal.dll'&@LF&'mps_up        =halapic.dll'&@LF&'mps_mp        =halmps.dll'&@LF&'acpiapic_mp   =halmacpi.dll'&@LF&'acpiapic_up   =halaacpi.dll')
					IniWriteSection($PathBartPE91&'\i386\txtsetup.sif', "ntdetect", 'acpipic_up    =NTDETECT.COM,"\"'&@LF&'e_isa_up      =NTDETECT.COM,"\"'&@LF&'mps_up        =NTDETECT.COM,"\"'&@LF&'mps_mp        =NTDETECT.COM,"\"'&@LF&'standard      =NTDETECT.COM,"\"'&@LF&'acpiapic_mp   =NTDETECT.COM,"\"'&@LF&'acpiapic_up   =NTDETECT.COM,"\"')
					
					GUICtrlSetData($Label95, '���� 3. ���������� ����� �������.')
					; ����� ������� software, default � system ������������
					RunWait ( @Comspec & ' /C REG LOAD HKLM\PE_LM_SW '&$PathBartPE91&'\i386\system32\config\software', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG LOAD HKLM\PE_CU_DF '&$PathBartPE91&'\i386\system32\config\default', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG LOAD HKLM\PE_SY_HI '&$PathBartPE91&'\i386\system32\setupreg.hiv', '', @SW_HIDE )
					GUICtrlSetData($Label95, '���� 4. �������� ������� ������� � ������ �������.')
					; ������ ������ � ������������ ������
					RunWait ( @Comspec & ' /C subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE\PE_LM_SW /grant=���=F', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE\PE_CU_DF /grant=���=F', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE\PE_SY_HI /grant=���=F', '', @SW_HIDE )
					GUICtrlSetData($Label95, '���� 4. ���������� ������ � ������ LiveCD.')
					RunWait ( @Comspec & ' /C regedit /s '&@ScriptDir&'\WIM-IMAGE\1_FBWF.reg', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C regedit /s '&@ScriptDir&'\WIM-IMAGE\2_WIM.reg', '', @SW_HIDE )
					GUICtrlSetData($Label95, '���� 5. ����� ��� ������ � �������� ����� ���������')
					MsgBox(0, "�������� �����������", "����� ��� ������ ������� � �������� ����� ���������")
					GUICtrlSetState($start91, $GUI_ENABLE)
            Case $msg = $start91
					$tabcomboLabel0=GUICtrlRead ($tabcomboLabel)
					If GUICtrlRead ($Radiocombo91) = $GUI_CHECKED Then $PathBartPE91=@ScriptDir&'\BartPE'
					If GUICtrlRead ($Radioinput91) = $GUI_CHECKED Then $PathBartPE91=GUICtrlRead ($tab2input91)
					If FileExists(@ScriptDir&'\WinPe.wim') Then
					MsgBox(0, "������ ������", '���� '&@ScriptDir&'\WinPe.wim ����������,'&@CRLF&'������� ��� ����� ������������.')
					ContinueLoop
					EndIf
					GUICtrlSetState($start91, $GUI_DISABLE)
					GUICtrlSetData($Label95, '���� 6. ��������� ����� �������')
					; ���������� ������ �������
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_LM_SW', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_CU_DF', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_SY_HI', '', @SW_HIDE )
					GUICtrlSetData($Label95, '���� 7. ������� ������ � WinPe.wim')
					RunWait ( @Comspec & ' /C '&@ScriptDir&'\WIM-IMAGE\WinPeWim\i386\system32\imagex.exe /capture /boot "'&$PathBartPE91&'" "'&@ScriptDir&'\WinPe.wim" "'&$tabcomboLabel0&'" /compress maximum', '', @SW_HIDE )
					GUICtrlSetData($Label95, '���� 8. ������')
					GUICtrlSetState($start90, $GUI_ENABLE)
					GUICtrlSetState($start91, $GUI_ENABLE)
					$Labelwim = IniRead ($Ini, "wim", "Labelwim", "remark")
					IniWrite($Ini, "wim", "Labelwim", $tabcomboLabel0)
            Case $msg = $start92
					$tabcomboLabel0=GUICtrlRead ($tabcomboLabel)
					GUICtrlSetData($Label95, '����� ���������� WinPe.wim')
					DirRemove(@ScriptDir&'\BartPE',1)
					DirCreate(@ScriptDir&'\BartPE')
					Sleep(500)
					$Tmperror='0'
					$TmpPath401 = FileOpenDialog("����� WinPe.wim.", @WorkingDir & "", "����� ����� (*.wim)", 1 + 4, 'WinPe.wim' )
					If @error Then
					$Tmperror='1'
					EndIf
					RunWait ( @Comspec & ' /C "'&@ScriptDir&'\WIM-IMAGE\WinPeWim\i386\system32\imagex.exe" /apply "'&$TmpPath401&'" "'&$tabcomboLabel0&'" "'&@ScriptDir&'\BartPE\"', '', @SW_HIDE )
					$IsEmpty = _DirIsEmpty(@ScriptDir&'\BartPE')
					Func _DirIsEmpty($sPath)
					    If Not StringInStr(FileGetAttrib($sPath), "D") Then Return SetError(1, 0, 0)
					    Local $hSearch = FileFindFirstFile($sPath & "\*")
					    Local $iRet = @error
					    FileClose($hSearch)
					    Return $iRet 
					 EndFunc 
					If $IsEmpty='1' Then
					   GUICtrlSetData($Label95, '����� BartPE �����.')
					   MsgBox(64, "������ ������", "�������� ��������� ������������� ���������� �������" & @LF & "����������� imagex.exe /apply") 
					 Else
					   GUICtrlSetData($Label95, 'WinPe.wim ��������')
					EndIf
					If $Tmperror=1 Then GUICtrlSetData($Label95, '�� ������ ���� ��� ����������')
					IniWrite($Ini, "wim", "Labelwim", $tabcomboLabel0)
            Case $msg = $start93
					; ���������� ������ �������
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_LM_SW', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_CU_DF', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_SY_HI', '', @SW_HIDE )
					GUICtrlSetData($Label95, '����� ������� ���������')
			Case $msg = $reestr91
					If $pathreestr = "" Then $pathreestr="regedit.exe"
					Run($pathreestr)
					
; ����� ������� WIM
; ������ ������� LDR
; ������ ������ SETUPLDR.BIN
            Case $msg = $Changestart
					$filename081=GUICtrlRead ($filename81)
					$bykvadicka080=GUICtrlRead ($bykvadicka80)
					$bykvadicka081=$bykvadicka080&':'
					FileCopy(@ScriptDir & '\SETUPLDR.BIN', @ScriptDir & '\SETUPLDR_original.BIN', 1)
					$nameChange080=GUICtrlRead ($nameChange80)
					$nameChange081=GUICtrlRead ($nameChange81)
					$nameChange082=GUICtrlRead ($nameChange82)
				If GUICtrlRead ($CheckChange80)=1 Then
					$nameChhex080 = StringToBinary($nameChange080)
					$nameChhex0080 = StringMid($nameChhex080, 3)
					If FileExists(@ScriptDir&'\list.txt') Then FileDelete ( @ScriptDir&'\list.txt' )
					RunWait ( @Comspec & ' /C echo FILE = SETUPLDR.BIN>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo TTL = Replace>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo SEARCH = 57494E4E542E534946>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo CHANGE = '&$nameChhex0080&'>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo SEARCH = 77696E6E742E736966>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo CHANGE = '&$nameChhex0080&'>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C '&@ScriptDir&'\Replace.exe /p list.txt', '', @SW_HIDE )
					FileDelete ( @ScriptDir&'\list.txt' )
					Else
					EndIf
				If GUICtrlRead ($CheckChange81)=1 Then
					$nameChhex081 = StringToBinary($nameChange081)
					$nameChhex0081 = StringMid($nameChhex081, 3)
					If FileExists(@ScriptDir&'\list.txt') Then FileDelete ( @ScriptDir&'\list.txt' ) 
					RunWait ( @Comspec & ' /C echo FILE = SETUPLDR.BIN>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo TTL = Replace>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo SEARCH = 693338365C53455455504C4452>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo CHANGE = '&$nameChhex0081&'5C53455455504C4452>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo SEARCH = 693338365C6E746465746563742E636F6D>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo CHANGE = '&$nameChhex0081&'5C6E746465746563742E636F6D>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo SEARCH = 693338365C73657475706C64722E706462>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo CHANGE = '&$nameChhex0081&'5C73657475706C64722E706462>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C '&@ScriptDir&'\Replace.exe /p list.txt', '', @SW_HIDE )
					FileDelete ( @ScriptDir&'\list.txt' )
					Else
					EndIf
				If GUICtrlRead ($CheckChange82)=1 Then
					$nameChhex082 = StringToBinary($nameChange082)
					$nameChhex0082 = StringMid($nameChhex082, 3)
					If FileExists(@ScriptDir&'\list.txt') Then FileDelete ( @ScriptDir&'\list.txt' ) 
					RunWait ( @Comspec & ' /C echo FILE = SETUPLDR.BIN>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo TTL = Replace>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo SEARCH = 54585453455455502E534946>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo CHANGE = '&$nameChhex0082&'>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo SEARCH = 74787473657475702E736966>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo CHANGE = '&$nameChhex0082&'>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C '&@ScriptDir&'\Replace.exe /p list.txt', '', @SW_HIDE )
					FileDelete ( @ScriptDir&'\list.txt' )
					Else
					EndIf
					$answerldr = ""
					$answerldr = MsgBox(4, "�������� �����������", "������ ����������� SETUPLDR.BIN �� ���������"&@CRLF&"���� ���� � ��������� ���� ������?")
					If $answerldr = "6" Then FileCopy(@ScriptDir & '\SETUPLDR.BIN', $bykvadicka081&'\'&$filename081, 1)
					IniWrite($Ini, "ldr", "winnt", $nameChange080)
					IniWrite($Ini, "ldr", "i386", $nameChange081)
					IniWrite($Ini, "ldr", "txtsetup", $nameChange082)
					IniWrite($Ini, "ldr", "ntldr", $filename081)
					GUICtrlSetData($Label89, '���������.')
            Case $msg = $unsetldr
					$showsizeldr00=FileGetSize ( 'SETUPLDR.BIN' )
					If FileExists(@ScriptDir&'\list.txt') Then FileDelete ( @ScriptDir&'\list.txt' )
					; 291, 295, 307, 311
					If $showsizeldr00>=298096 Then
					FileWriteLine (@ScriptDir&'\list.txt', 'FILE = SETUPLDR.BIN' )
					FileWriteLine (@ScriptDir&'\list.txt', 'TTL = Replace' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 173314' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 173342' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 173358' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 207684' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 207724' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 207744' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 207760' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 267784' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 172886' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 172898' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 173106' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 173230' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 173678' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 173690' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 267803' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 267839' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 267874' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 191849' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "i386"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 277870' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "i386"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 254397' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "i386"' )
					RunWait ( @Comspec & ' /C '&@ScriptDir&'\Replace.exe /p list.txt', '', @SW_HIDE )
					EndIf
					; 255
					If $showsizeldr00=261376 Then
					FileWriteLine (@ScriptDir&'\list.txt', 'FILE = SETUPLDR.BIN' )
					FileWriteLine (@ScriptDir&'\list.txt', 'TTL = Replace' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 140902' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 140930' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 140946' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 172360' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 172400' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 172420' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 172436' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 240896' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 140642' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 140654' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 140870' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 141162' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 141174' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 240915' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 240950' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 241003' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 157019' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "i386"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 246374' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "i386"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 226873' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "i386"' )
					RunWait ( @Comspec & ' /C '&@ScriptDir&'\Replace.exe /p list.txt', '', @SW_HIDE )
					EndIf
					; 241
					If $showsizeldr00=247024 Then
					FileWriteLine (@ScriptDir&'\list.txt', 'FILE = SETUPLDR.BIN' )
					FileWriteLine (@ScriptDir&'\list.txt', 'TTL = Replace' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 132790' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 132818' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 132834' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 161662' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 161702' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 161722' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 161738' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 226544' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "TXTSETUP.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 132530' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 132542' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 132758' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 133050' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 133062' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 226563' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 226598' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 226651' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "WINNT.SIF"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 123235' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "i386"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 231848' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "i386"' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 212521' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = "i386"' )
					RunWait ( @Comspec & ' /C '&@ScriptDir&'\Replace.exe /p list.txt', '', @SW_HIDE )
					EndIf
					If $showsizeldr00=314480 Then GUICtrlSetData($Label89, 'SETUPLDR.BIN, 307��, WIM-�����������. �����.')
					If $showsizeldr00=318576 Then
					FileWriteLine (@ScriptDir&'\list.txt', 'FILE = SETUPLDR.BIN' )
					FileWriteLine (@ScriptDir&'\list.txt', 'TTL = Replace' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Offset  = 8288' )
					FileWriteLine (@ScriptDir&'\list.txt', 'Change  = EB1A' )
					RunWait ( @Comspec & ' /C '&@ScriptDir&'\Replace.exe /p list.txt', '', @SW_HIDE )
					GUICtrlSetData($Label89, 'SETUPLDR.BIN, 311��, WIM-������������. �����.')
					EndIf
					If $showsizeldr00=298096 Then GUICtrlSetData($Label89, 'SETUPLDR.BIN, 291��, RAM-�����������. �����.')
					If $showsizeldr00=302192 Then GUICtrlSetData($Label89, 'SETUPLDR.BIN, 295��, RAM-������������. �����.')
					If $showsizeldr00=261376 Then GUICtrlSetData($Label89, 'SETUPLDR.BIN, 255��, CD,minint. �����.')
					If $showsizeldr00=247024 Then GUICtrlSetData($Label89, 'SETUPLDR.BIN, 241��, CD,minint(sp1). �����.')
; ����� ������ SETUPLDR.BIN
            Case $msg = $Boot80
					$bykvadicka080=GUICtrlRead ($bykvadicka80)
					$bykvadicka081=$bykvadicka080&':'
					RunWait ( @Comspec & ' /C '&@ScriptDir&'\bootsect.exe /nt52 '&$bykvadicka081&' /force', '', @SW_HIDE )
					GUICtrlSetData($Label89, '����������� ������ �������'&@CRLF&'�� ���� '&$bykvadicka081&'.')
				
            Case $msg = $Boot81
					$nameldr=GUICtrlRead ($filename81)
					$filename082=GUICtrlRead ($filename82)
					$bykvadicka080=GUICtrlRead ($bykvadicka80)
					$bykvadicka081=$bykvadicka080&':'
					RunWait ( @Comspec & ' /C '&@ScriptDir&'\MKBT.EXE -x -c '&$bykvadicka081&' '&@ScriptDir&'\'&$filename082, '', @SW_HIDE )
					
					$nameldrhex = StringToBinary($nameldr)
					$nameldrhex00 = StringMid($nameldrhex, 3)
					$11=StringMid($nameldrhex00, 1,2)
					$22=StringMid($nameldrhex00, 3,2)
					$33=StringMid($nameldrhex00, 5,2)
					$44=StringMid($nameldrhex00, 7,2)
					$55=StringMid($nameldrhex00, 9,2)
					$nameldrhex01=$11&'00'&$22&'00'&$33&'00'&$44&'00'&$55
					
					If FileExists(@ScriptDir&'\list.txt') Then FileDelete ( @ScriptDir&'\list.txt' ) 
					RunWait ( @Comspec & ' /C echo FILE = '&$filename082&'>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo TTL = Replace>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo SEARCH = 4E0054004C00440052>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo CHANGE = '&$nameldrhex01&'>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo SEARCH = 4E544C4452>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C echo CHANGE = '&$nameldrhex00&'>>list.txt', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C '&@ScriptDir&'\Replace.exe /p list.txt', '', @SW_HIDE )
					FileDelete ( @ScriptDir&'\list.txt' )
					FileMove(@ScriptDir & '\'&$filename082, $bykvadicka081&'\'&$filename082, 1)
					IniWrite($Ini, "ldr", "ntldr", $nameldr)
					IniWrite($Ini, "ldr", "bootfile", $filename082)
					GUICtrlSetData($Label89, '���� ������������ ������� '&$bykvadicka081&'\'&$filename082&' ������.')
				 Case $msg = $Boot82
					$bykvadicka080=GUICtrlRead ($bykvadicka80)
					$bykvadicka081=$bykvadicka080&':'
					$filename082=GUICtrlRead ($filename82)
					$bootctroka=GUICtrlRead ($tab8input)
					$bootini = MsgBox(4, "�������� �����������", "������ ������� ����� boot.ini � ���������� ���,"&@CRLF&"���������� ��� ��������?"&@CRLF&"�������� �������� ��������� ��� ������.")
					If $bootini = "6" Then FileCopy($bykvadicka081&'\boot.ini', $bykvadicka081&'\boot.ini.BAK', 1)
					FileSetAttrib($bykvadicka081&'\boot.ini', "-SHR")
					IniWrite($bykvadicka081&'\boot.ini', "operating systems", 'C:\'&$filename082, '"'&$bootctroka&'"')
					If $bootini = "6" Then RunWait('Notepad.exe '&$bykvadicka081&'\boot.ini')
					FileSetAttrib($bykvadicka081&'\boot.ini', "+SHR")
					GUICtrlSetData($Label89, '������ �������� � '&$bykvadicka081&'boot.ini ���������')
					
; ����� ������� LDR
; ������ ������� minint
            Case $msg = $startmini
					GUICtrlSetData($Label65, '���� 1. ���������� ����������, ����.')
					If FileExists($disk_z) Then
					MsgBox(0, "������ ������", '������������ ���� '&$disk_z&' ����� ������������.')
					ContinueLoop
					EndIf
					$bykvadicka0=GUICtrlRead ($bykvadicka)
					$bykvadicka00=$bykvadicka0&':\'
					$rn00="0"
					If GUICtrlRead ($Radioinput01) = $GUI_CHECKED Then $bykvadicka00=@ScriptDir&'\BartPE'
					If GUICtrlRead ($Radioinput00) = $GUI_CHECKED Then
					RunWait ( @Comspec & ' /C ren '&$bykvadicka00&'i386 i386-1f8w4o', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C ren '&$bykvadicka00&'minint i386', '', @SW_HIDE )
					$rn00="1"
					EndIf
					GUICtrlSetState($unload68, $GUI_ENABLE)
					RunWait ( @Comspec & ' /C subst '&$disk_z&' '&$bykvadicka00, '', @SW_HIDE )
					If not FileExists($disk_z&'\i386\System32\config') Then
					MsgBox(0, "������ ������", '����������� ����� '&$disk_z&'\i386')
					ContinueLoop
					EndIf
					GUICtrlSetState($startmini, $GUI_DISABLE)
					GUICtrlSetState($backup, $GUI_ENABLE)
					GUICtrlSetState($restore, $GUI_ENABLE)
					GUICtrlSetState($contmini, $GUI_ENABLE)
					GUICtrlSetData($Label65, '���� 2. ����� ��� ������.')
					MsgBox(0, "�������� �����������", '����� ������� ����� ��� �������������� ������� LiveCD.'&@CRLF&'����� ������ "2 ����������"')
            Case $msg = $contmini
					GUICtrlSetState($contmini, $GUI_DISABLE)
					GUICtrlSetState($backup, $GUI_DISABLE)
					GUICtrlSetState($restore, $GUI_DISABLE)
					GUICtrlSetData($Label65, '���� 3. ���������� ����� �������.')
					; ����� ������� software, default � system ������������
					RunWait ( @Comspec & ' /C REG LOAD HKLM\PE_LM_SW '&$disk_z&'\i386\system32\config\software', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG LOAD HKLM\PE_CU_DF '&$disk_z&'\i386\system32\config\default', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG LOAD HKLM\PE_SY_HI '&$disk_z&'\i386\system32\setupreg.hiv', '', @SW_HIDE )
					GUICtrlSetData($Label65, '���� 4. �������� ������� ������� � ������ �������.')
					; ������ ������ � ������������ ������
					RunWait ( @Comspec & ' /C subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE\PE_LM_SW /grant=���=F', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE\PE_CU_DF /grant=���=F', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE\PE_SY_HI /grant=���=F', '', @SW_HIDE )
					GUICtrlSetData($Label65, '���� 5. ����� ��� ������ �������.')
					MsgBox(0, '���������', '����� ��� ������ �������.'&@CRLF&'����� ��� ������ "3 ���������"')
					GUICtrlSetState($finish, $GUI_ENABLE)
            Case $msg = $finish
					GUICtrlSetState($finish, $GUI_DISABLE)
					GUICtrlSetData($Label65, '���� 6. ��������� ����� �������')
					; ���������� ������ �������
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_LM_SW', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_CU_DF', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_SY_HI', '', @SW_HIDE )
					GUICtrlSetData($Label65, '���� 7. ��������� ���� '&$disk_z)
					RunWait ( @Comspec & ' /C subst '&$disk_z&' /d', '', @SW_HIDE )
					If $rn00="1" Then
						GUICtrlSetData($Label65, '���� 8. ��������������� ����� minint ������� � i386')
						RunWait ( @Comspec & ' /C ren '&$bykvadicka00&'i386 minint', '', @SW_HIDE )
						RunWait ( @Comspec & ' /C ren '&$bykvadicka00&'i386-1f8w4o i386', '', @SW_HIDE )
					EndIf
					GUICtrlSetData($Label65, '���� 9. ������.')
					If not FileExists($disk_z) Then GUICtrlSetState($unload68, $GUI_DISABLE)
					GUICtrlSetState($startmini, $GUI_ENABLE)
            Case $msg = $Radioinput00
					GUICtrlSetState($Label61, $GUI_ENABLE)
					GUICtrlSetState($bykvadicka, $GUI_ENABLE)
			Case $msg = $Radioinput01
					GUICtrlSetState($Label61, $GUI_DISABLE)
					GUICtrlSetState($bykvadicka, $GUI_DISABLE)
			Case $msg = $reestr61
					If $pathreestr = "" Then $pathreestr="regedit.exe"
					Run($pathreestr)
			Case $msg = $load67
					$tmpreg67 = FileSelectFolder ( "������� ����� system32",'','3',@WorkingDir & '\BartPE\i386\system32')
					If @error Then
					GUICtrlSetData($Label65, '����� �� �������')
					ContinueLoop
					EndIf
					; ����� ������� software, default � system ������������
					RunWait ( @Comspec & ' /C REG LOAD HKLM\PE_LM_SW '&$tmpreg67&'\config\software', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG LOAD HKLM\PE_CU_DF '&$tmpreg67&'\config\default', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG LOAD HKLM\PE_SY_HI '&$tmpreg67&'\setupreg.hiv', '', @SW_HIDE )
					GUICtrlSetData($Label65, '�������� ������� ������� � ������ �������.')
					; ������ ������ � ������������ ������
					RunWait ( @Comspec & ' /C subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE\PE_LM_SW /grant=���=F', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE\PE_CU_DF /grant=���=F', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE\PE_SY_HI /grant=���=F', '', @SW_HIDE )
					GUICtrlSetData($Label65, '����� ������� ���������� � ������ ��������.')
			Case $msg = $unload67
					; ���������� ������ �������
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_LM_SW', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_CU_DF', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_SY_HI', '', @SW_HIDE )
					GUICtrlSetData($Label65, '����� ������� ���������')
			Case $msg = $unload68
					RunWait ( @Comspec & ' /C subst '&$disk_z&' /d', '', @SW_HIDE )
					GUICtrlSetData($Label65, '���� '&$disk_z&' ��������')
					If not FileExists($disk_z) Then GUICtrlSetState($unload68, $GUI_DISABLE)
			Case $msg = $backup
					If FileExists($disk_z&'\minint\system32\config') Then DirCopy ( $disk_z&'\minint\system32\config', @ScriptDir&'\backup',1)
					GUICtrlSetData($Label65, '����� ������ ������� ��������.')
			Case $msg = $restore
					If FileExists(@ScriptDir&'\backup') Then DirCopy (@ScriptDir&'\backup', $disk_z&'\minint\system32\config',1)
					GUICtrlSetData($Label65, '�������������� ������� �� ������ ���������.')
; ����� ������� minint
; ������ ������� Boot.img
			Case $msg = $cabizv
					If FileExists(@ScriptDir&'\BootSDI.im_') Then RunWait ( @Comspec & ' /C cabarc.exe -o -p X BootSDI.im_ &echo �ᯠ�����', '', @SW_HIDE )
					If FileExists(@ScriptDir&'\Boot.im_') Then RunWait ( @Comspec & ' /C cabarc.exe -o -p X Boot.im_ &echo �ᯠ�����', '', @SW_HIDE )
					GUICtrlSetData($Label5, '�����������.')
					GUICtrlSetData($Label6, '')
			Case $msg = $cabpac
					If FileExists(@ScriptDir&'\BootSDI.img') Then RunWait ( @Comspec & ' /C makecab.exe /D Compress=ON  /D CompressionMemory=21 /D CompressionType=LZX /D CompressionLevel=7 BootSDI.img', '', @SW_HIDE )
					If FileExists(@ScriptDir&'\Boot.img') Then RunWait ( @Comspec & ' /C makecab.exe /D Compress=ON  /D CompressionMemory=21 /D CompressionType=LZX /D CompressionLevel=7 Boot.img', '', @SW_HIDE )
					GUICtrlSetData($Label5, '���������.')
					GUICtrlSetData($Label6, '')
			Case $msg = $showsize
					$tabcomboname00=GUICtrlRead ($tabcomboname)
					If $tabcomboname00 = "7sh3" Then $Bootimg='Boot'
					If $tabcomboname00 = "RusLive-NTFS" Then $Bootimg='BootSDI'
					If $tabcomboname00 = "RusLive-FAT32" Then $Bootimg='BootSDI'
					If FileExists(@ScriptDir&'\'&$Bootimg&'.im_') Then RunWait ( @Comspec & ' /C cabarc.exe -o -p X '&$Bootimg&'.im_ &echo �ᯠ�����', '', @SW_HIDE )
					If not FileExists(@ScriptDir&'\'&$Bootimg&'.img') Then
					MsgBox(0, "������ ������", @ScriptDir&'\'&$Bootimg&'.img �� ����������.'&@CRLF&'��� ��������� ��������� ����������� ������')
					ContinueLoop
					EndIf
					$showsize00=FileGetSize ( $Bootimg&'.img' )
					$showsize00 /= 1048576
					GUICtrlSetData($tab0combo0,$showsize00)
					MsgBox(0, "������", '������ '&$Bootimg&'.img ����� '&$showsize00&' ��')
					GUICtrlSetData($Label5, '������ '&$Bootimg&'.img ����� '&$showsize00&' ��.')
					GUICtrlSetData($Label6, '')
			Case $msg = $unload1
					; ���������� ������ �������
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_LM_SW', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_CU_DF', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_SY_HI', '', @SW_HIDE )
					GUICtrlSetData($Label5, '����� ������� ���������')
					GUICtrlSetData($Label6, '')
			Case $msg = $unload2
					; �������������� ����� Z,Y � ��������� ����. �������
					RunWait ( @Comspec & ' /C vdk.exe close 0 | find /v "http:" | find /v "version"', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C vdk.exe close 1 | find /v "http:" | find /v "version"', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C vdk.exe stop | find /v "http:" | find /v "version"', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C vdk.exe remove | find /v "http:" | find /v "version"', '', @SW_HIDE )
					If Not FileExists($disk_z&'\') Then GUICtrlSetState($unload2, $GUI_DISABLE)
					If Not FileExists($disk_z&'\') Then GUICtrlSetState($start, $GUI_ENABLE)
					If Not FileExists($disk_z&'\') Then GUICtrlSetState($continue, $GUI_DISABLE)
					GUICtrlSetData($Label5, '����� '&$disk_z&' � '&$disk_y&' �������������, ��������� �������. ������ �����')
					GUICtrlSetData($Label6, '')
			Case $msg = $reestr
					If $pathreestr = "" Then $pathreestr="regedit.exe"
					Run($pathreestr)
			Case $msg = $start
					GUICtrlSetData($Label5, '���� 1. ����������� ����������, �������� ����������.')
					; ����������� ����������, � �������� ��������� ����������.
					$size01=GUICtrlRead ($tab0combo0)
					$size00=GUICtrlRead ($tab0combo0)
					$size00 *= 1048576
					$tabcomboname00=GUICtrlRead ($tabcomboname)
					If $tabcomboname00 = "" Then
					MsgBox(0, "������ ������", '������� �������� ������������ ������.')
					ContinueLoop
					EndIf
					If $size01>480 Then
					MsgBox(0, "������ ������", '������ img-����� ���������.')
					ContinueLoop
					EndIf
					If $size01<=40 Then
					MsgBox(0, "������ ������", '������ img-����� ������� ���.')
					ContinueLoop
					EndIf
					If $Label3 < $size01 Then
					MsgBox(0, "������ ������", '������������ ���������� ����� �� �����.')
					ContinueLoop
					EndIf
					If FileExists(@ScriptDir&'\BootNew.img') Then
					MsgBox(0, "������ ������", '������� ���� BootNew.img ����� ������������.')
					ContinueLoop
					EndIf
					If FileExists($disk_z) Then
					MsgBox(0, "������ ������", '������������ ����� '&$disk_z&'\ � '&$disk_y&'\ ����� ������������.')
					ContinueLoop
					EndIf
					If FileExists($disk_y) Then
					MsgBox(0, "������ ������", '������������ ����� '&$disk_z&'\ � '&$disk_y&'\ ����� ������������.')
					ContinueLoop
					EndIf
					If $tabcomboname00 = "7sh3" Then
						$formatcfg=' /FS:NTFS /v:System /c /X /force'
						$Bootimg='Boot'
					EndIf
					If $tabcomboname00 = "RusLive-NTFS" Then
						$formatcfg='/FS:NTFS /v:BootSDI /c /X /force'
						$Bootimg='BootSDI'
					EndIf
					If $tabcomboname00 = "RusLive-FAT32" Then
						$formatcfg='/FS:FAT32 /v:BootSDI /X /force'
						$Bootimg='BootSDI'
					EndIf
					GUICtrlSetState($start, $GUI_DISABLE)
					If FileExists(@ScriptDir&'\'&$Bootimg&'.im_') Then RunWait ( @Comspec & ' /C cabarc.exe -o -p X '&$Bootimg&'.im_ &echo �ᯠ�����', '', @SW_HIDE )
					If not FileExists(@ScriptDir&'\'&$Bootimg&'.img') Then
					MsgBox(0, "������ ������", @ScriptDir&'\'&$Bootimg&'.img �� ����������')
					ContinueLoop
					EndIf
					GUICtrlSetData($Label5, '���� 1. ���������� �������, ��������� ���������. ���������.')
					GUICtrlSetData($Label6, '���� 2. ��������� ������������ �������.')
					; ��������� � ������ ������������ �������
					RunWait ( @Comspec & ' /C vdk.exe install | find /v "http:" | find /v "version"', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C vdk.exe start | find /v "http:" | find /v "version"', '', @SW_HIDE )
					GUICtrlSetData($Label5, '���� 2. ����������� ������ ����������. ���������.')
					GUICtrlSetData($Label6, '���� 3. ������������ �����'&$Bootimg&'.img.')
					GUICtrlSetState($unload2, $GUI_ENABLE)
					; ������������ ����� Boot.img ��� ���� Z
					RunWait ( @Comspec & ' /C vdk.exe open 0 '&@ScriptDir&'\'&$Bootimg&'.img /rw /p:0 /l:'&$disk_z&' | find /v "http:" | find /v "version" | find /v "Failed"', '', @SW_HIDE )
					GUICtrlSetData($Label5, '���� 3. ���� '&$Bootimg&'.img �����������. ���������.')
					GUICtrlSetData($Label6, '���� 4. ����� ����� ������������ ������ �������.')
					$answerrstr = ""
					$answerrstr = MsgBox(4, '��� ������', '���������� ����� �������? ���� ���, �� ���������� ��� ������, ����� ������ ���������� ��������������� �����')
					If $answerrstr = "6" Then
					; ����� ������� software, default � system ������������
					RunWait ( @Comspec & ' /C REG LOAD HKLM\PE_LM_SW '&$disk_z&'\i386\system32\config\software', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG LOAD HKLM\PE_CU_DF '&$disk_z&'\i386\system32\config\default', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG LOAD HKLM\PE_SY_HI '&$disk_z&'\i386\system32\setupreg.hiv', '', @SW_HIDE )
					GUICtrlSetData($Label5, '���� 4. ����� ������� ����������. ���������.')
					GUICtrlSetData($Label6, '���� 5. �������� ������� ������� � ������ �������.')
					; ������ ������ � ������������ ������
					RunWait ( @Comspec & ' /C subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE\PE_LM_SW /grant=���=F', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE\PE_CU_DF /grant=���=F', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C subinacl.exe /subkeyreg HKEY_LOCAL_MACHINE\PE_SY_HI /grant=���=F', '', @SW_HIDE )
					GUICtrlSetData($Label5, '���� 5. ������ ������ � ������� ������. ���������.')
					GUICtrlSetData($Label6, '���� 6. ����� ��� ������ � ��������� ����������� ����� '&$disk_z&'.')
					EndIf
					MsgBox(0, '���������', '����� ��� ������ �������'&@CRLF&'� ��������� ����������� ����� '&$disk_z&'.'&@CRLF&'����� ��������� ��� ������ "����������",'&@CRLF&'����� �������� ����� BootNew.img')
					GUICtrlSetState($continue, $GUI_ENABLE)
					
			Case $msg = $continue
					GUICtrlSetState($continue, $GUI_DISABLE)
					GUICtrlSetData($Label5, '���� 7. ��������� ����� �������')
					GUICtrlSetData($Label6, '')
					; ���������� ������ �������
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_LM_SW', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_CU_DF', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C REG UNLOAD HKLM\PE_SY_HI', '', @SW_HIDE )
					GUICtrlSetData($Label5, '���� 7. ����� ������� ���������. ���������.')
					GUICtrlSetData($Label6, '���� 8. �������� ������ ���� BootNew.img')
					; �������� ������� ����� ���������� �������
					RunWait ( @Comspec & ' /C Fsutil file createnew '&@ScriptDir&'\BootNew.img '&$size00, '', @SW_HIDE )
					GUICtrlSetData($Label5, '���� 8. ������ ���� BootNew.img ������. ���������.')
					GUICtrlSetData($Label6, '���� 9. ��������� ���� BootNew.img')
					; ������������ ������� ����� BootNew.img ��� ���� Y
					RunWait ( @Comspec & ' /C vdk.exe open 1 '&@ScriptDir&'\BootNew.img /rw /p:0 /l:'&$disk_y&' | find /v "http:" | find /v "version" | find /v "Failed"', '', @SW_HIDE )
					GUICtrlSetData($Label5, '���� 9. ���� BootNew.img �����������. ���������.')
					GUICtrlSetData($Label6, '���� 10. ����������� ����������� ���� '&$disk_y&'.')
					; �������������� ������������ ����� Y
					RunWait ( @Comspec & ' /C format.com '&$disk_y&$formatcfg, '', @SW_HIDE )
					GUICtrlSetData($Label5, '���� 10. ����������� ���� '&$disk_y&' ��������������. ���������.')
					GUICtrlSetData($Label6, '���� 11. �������� ����� � ����� '&$disk_z&' �� ���� '&$disk_y&'.')
					; ����������� ������ � ����� Z �� ���� Y
					RunWait ( @Comspec & ' /C zCopy.exe '&$disk_z&' '&$disk_y&'  "size.ini" size size', '', @SW_HIDE )
					GUICtrlSetData($Label5, '���� 11. ����� � ����� '&$disk_z&' �� ���� '&$disk_y&' �����������. ���������.')
					GUICtrlSetData($Label6, '���� 12. ����������� �����, ��������� ����������� ������.')
					; �������������� ����� Z,Y � ��������� ����. �������
					RunWait ( @Comspec & ' /C vdk.exe close 0 | find /v "http:" | find /v "version"', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C vdk.exe close 1 | find /v "http:" | find /v "version"', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C vdk.exe stop | find /v "http:" | find /v "version"', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C vdk.exe remove | find /v "http:" | find /v "version"', '', @SW_HIDE )
					GUICtrlSetData($Label5, '���� 12. ����� '&$disk_z&' � '&$disk_y&' �������������, ��������� �������. ������ �����')
					GUICtrlSetData($Label6, '')
					; ���������� � cab-����
					If GUICtrlRead ($check00)=1 Then GUICtrlSetData($Label5, "���� 13. ������ ����� � CAB-�����")
					RunWait ( @Comspec & ' /C ren '&$Bootimg&'.img '&$Bootimg&'.img.BAK', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C ren '&$Bootimg&'.im_ '&$Bootimg&'.im_.BAK', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C ren BootNew.img '&$Bootimg&'.img', '', @SW_HIDE )
					If GUICtrlRead ($check00)=1 Then RunWait ( @Comspec & ' /C makecab.exe /D Compress=ON  /D CompressionMemory=21 /D CompressionType=LZX /D CompressionLevel=7 '&$Bootimg&'.img', '', @SW_HIDE )
					IniWrite($Ini, "size", "size1", $size01)
					IniWrite($Ini, "boot", "namekon", $tabcomboname00)
					GUICtrlSetData($Label5, "���� 14. ��������� ���������. ������.")
					GUICtrlSetState($start, $GUI_ENABLE)
			Case $msg = $check00
					If GUICtrlRead ($check00)=1 Then
						IniWrite($Ini, "boot", "cab", "-1")
					Else
						IniWrite($Ini, "boot", "cab", "")
					EndIf
; ����� ������� Boot.img
            Case $msg = $vkladka01
;�������� ���������
				If GUICtrlRead ($checkCN01)=1 Then
					; ������� ������������ ��������� ����������
					RunWait ( @Comspec & ' /C reg copy "HKCU\Keyboard Layout\Toggle" "HKLM\PE_CU_DF\Keyboard Layout\Toggle" /s /f', '', @SW_HIDE )
					; ��������� NumLock
					RunWait ( @Comspec & ' /C reg copy "HKCU\Control Panel\Keyboard" "HKLM\PE_CU_DF\Control Panel\Keyboard" /s /f', '', @SW_HIDE )
					; ���� ��������� ���������� ��� ��������
					RunWait ( @Comspec & ' /C reg copy "HKCU\Keyboard Layout\Preload" "HKLM\PE_CU_DF\Keyboard Layout\Preload" /s /f', '', @SW_HIDE )
				Else
				EndIf
				If GUICtrlRead ($checkCN02)=1 Then
					; ��������� ������ ������������
					RunWait ( @Comspec & ' /C reg copy "HKCU\Software\Microsoft\Internet Explorer\Toolbar" "HKLM\PE_CU_DF\Software\Microsoft\Internet Explorer\Toolbar" /f', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C reg copy "HKCU\Software\Microsoft\Internet Explorer\Toolbar\Explorer" "HKLM\PE_CU_DF\Software\Microsoft\Internet Explorer\Toolbar\Explorer" /f', '', @SW_HIDE )
					; ������ ������ �� ������ ������������
					RunWait ( @Comspec & ' /C reg copy "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\SmallIcons" "HKLM\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Explorer\SmallIcons" /f', '', @SW_HIDE )
					; ��������� (���: �������, ������, ������)
					RunWait ( @Comspec & ' /C reg copy "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Streams" "HKLM\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Explorer\Streams" /f', '', @SW_HIDE )
					; rem ��������� (����������� ����� �� ...)
					RunWait ( @Comspec & ' /C reg copy "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Streams\Defaults" "HKLM\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Explorer\Streams\Defaults" /s /f', '', @SW_HIDE )
					; �o��ep���a�� no�n�c� ��a��o� np� �a�e�e���
					RegWrite("HKLM\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Explorer","IconUnderline","REG_BINARY",'02000000')
				Else
				EndIf
				If GUICtrlRead ($checkCN03)=1 Then
					RegWrite("HKLM\PE_LM_SW\Classes\Folder\shell\opennew","","REG_SZ",'������� � ����� ����')
					RegWrite("HKLM\PE_LM_SW\Classes\Folder\shell\opennew","BrowserFlags","REG_DWORD",'10')
					RegWrite("HKLM\PE_LM_SW\Classes\Folder\shell\opennew","ExplorerFlags","REG_DWORD",'33')
					RegWrite("HKLM\PE_LM_SW\Classes\Folder\shell\opennew\command","","REG_EXPAND_SZ",'%SystemRoot%\Explorer.exe /idlist,%I,%L" & @lf & "')
					RegWrite("HKLM\PE_LM_SW\Classes\Folder\shell\opennew\ddeexec","","REG_SZ",'[ViewFolder("%l", %I, %S)]')
					RegWrite("HKLM\PE_LM_SW\Classes\Folder\shell\opennew\ddeexec","NoActivateHandler","REG_SZ",'')
					RegWrite("HKLM\PE_LM_SW\Classes\Folder\shell\opennew\ddeexec\application","","REG_SZ",'Folders')
					RegWrite("HKLM\PE_LM_SW\Classes\Folder\shell\opennew\ddeexec\ifexec","","REG_SZ",'[]')
					RegWrite("HKLM\PE_LM_SW\Classes\Folder\shell\opennew\ddeexec\topic","","REG_SZ",'AppProperties')
				Else
				EndIf
				If GUICtrlRead ($checkCN04)=1 Then
					RunWait ( @Comspec & ' /C reg copy "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" "HKLM\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /s /f', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C reg copy "HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" "HKLM\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /s /f', '', @SW_HIDE )
					RegWrite("HKLM\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer","StartMenuLogoff","REG_DWORD",'1')
				Else
				EndIf
				If GUICtrlRead ($checkCN05)=1 Then
					RegWrite("HKLM\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Explorer","ShellState","REG_BINARY",'2400000013880000000000000000000000000000010000000d0000000000000002000000')
				Else
				EndIf
				If GUICtrlRead ($checkCN06)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\regfile\shell\print")
					RegDelete("HKLM\PE_LM_SW\Classes\txtfile\shell\print")
					RegDelete("HKLM\PE_LM_SW\Classes\logfile\shell\print")
					RegDelete("HKLM\PE_LM_SW\Classes\cmdfile\shell\print")
					RegDelete("HKLM\PE_LM_SW\Classes\batfile\shell\print")
					RegDelete("HKLM\PE_LM_SW\Classes\fonfile\shell\print")
					RegDelete("HKLM\PE_LM_SW\Classes\inffile\shell\print")
					RegDelete("HKLM\PE_LM_SW\Classes\inifile\shell\print")
				Else
				EndIf
				If GUICtrlRead ($checkCN07)=1 Then
					Run('shellexecute.exe /h assot.cmd')
				Else
				EndIf
				If GUICtrlRead ($checkCN08)=1 Then
					RunWait ( @Comspec & ' /C reg copy "HKCU\Control Panel\Desktop\WindowMetrics" "HKLM\PE_CU_DF\Control Panel\Desktop\WindowMetrics" /s /f', '', @SW_HIDE )
					RunWait ( @Comspec & ' /C reg copy "HKCU\Control Panel\Colors" "HKLM\PE_CU_DF\Control Panel\Colors" /s /f', '', @SW_HIDE )
				Else
				EndIf
				If GUICtrlRead ($checkCN081)=1 Then
					Run('shellexecute.exe /h assot_icons.cmd')
				Else
				EndIf
				If GUICtrlRead ($checkCN09)=1 Then
					RegWrite("HKEY_LOCAL_MACHINE\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU","a","REG_SZ",$Inistl0)
					RegWrite("HKEY_LOCAL_MACHINE\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU","b","REG_SZ",$Inistl1)
					RegWrite("HKEY_LOCAL_MACHINE\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU","c","REG_SZ",$Inistl2)
					RegWrite("HKEY_LOCAL_MACHINE\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU","d","REG_SZ",$Inistl3)
					RegWrite("HKEY_LOCAL_MACHINE\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Explorer\RunMRU","MRUList","REG_SZ",'abcd')
				Else
				EndIf
				If GUICtrlRead ($checkCN010)=1 Then
					; ���������� � ������������ ������� ������������������.
					FileCopy(@ScriptDir & '\Ghost32_autorestore\*.*', $disk_z&'\Programs\Ghost32\', 9)
					RegWrite("HKLM\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Run","autorestore","REG_SZ",'X:\Programs\Ghost32\shellexecute.exe /h X:\Programs\Ghost32\start_ar.bat')
				Else
				EndIf
				If GUICtrlRead ($checkCN011)=1 Then
					; ������ "������� ���", "��������� ���"
					RegWrite("HKLM\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Policies\comdlg32\PlacesBar","Place0","REG_SZ",$Inigpl0)
					RegWrite("HKLM\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Policies\comdlg32\PlacesBar","Place1","REG_SZ",$Inigpl1)
					RegWrite("HKLM\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Policies\comdlg32\PlacesBar","Place2","REG_SZ",$Inigpl2)
					RegWrite("HKLM\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Policies\comdlg32\PlacesBar","Place3","REG_SZ",$Inigpl3)
					RegWrite("HKLM\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Policies\comdlg32\PlacesBar","Place4","REG_SZ",$Inigpl4)
				Else
				EndIf
				; ��������� ���������� ������
				If GUICtrlRead ($checkCN012)=1 Then
					If GUICtrlRead ($tab012combo)="800x600" Then
						RegWrite("HKLM\PE_SY_HI\ControlSet001\Services\VgaSave\Device0","DefaultSettings.XResolution","REG_DWORD",'800')
						RegWrite("HKLM\PE_SY_HI\ControlSet001\Services\VgaSave\Device0","DefaultSettings.YResolution","REG_DWORD",'600')
					Else
					EndIf
					If GUICtrlRead ($tab012combo)="1024x768" Then
						RegWrite("HKLM\PE_SY_HI\ControlSet001\Services\VgaSave\Device0","DefaultSettings.XResolution","REG_DWORD",'1024')
						RegWrite("HKLM\PE_SY_HI\ControlSet001\Services\VgaSave\Device0","DefaultSettings.YResolution","REG_DWORD",'768')
					Else
					EndIf
					If GUICtrlRead ($tab012combo)="1280x1024" Then
						RegWrite("HKLM\PE_SY_HI\ControlSet001\Services\VgaSave\Device0","DefaultSettings.XResolution","REG_DWORD",'1280')
						RegWrite("HKLM\PE_SY_HI\ControlSet001\Services\VgaSave\Device0","DefaultSettings.YResolution","REG_DWORD",'1024')
					Else
					EndIf
					If GUICtrlRead ($tab012combo)="1600x1200" Then
						RegWrite("HKLM\PE_SY_HI\ControlSet001\Services\VgaSave\Device0","DefaultSettings.XResolution","REG_DWORD",'1600')
						RegWrite("HKLM\PE_SY_HI\ControlSet001\Services\VgaSave\Device0","DefaultSettings.YResolution","REG_DWORD",'1200')
					Else
					EndIf
				Else
				EndIf
				; ���������� ������ � �������������� ������ ��������
				If GUICtrlRead ($checkCN013)=1 Then
					RegWrite("HKLM\PE_CU_DF\Software\Microsoft\Internet Explorer\TypedURLs","url1","REG_SZ",$Inigurl1)
					RegWrite("HKLM\PE_CU_DF\Software\Microsoft\Internet Explorer\TypedURLs","url2","REG_SZ",$Inigurl2)
					RegWrite("HKLM\PE_CU_DF\Software\Microsoft\Internet Explorer\TypedURLs","url3","REG_SZ",$Inigurl3)
					RegWrite("HKLM\PE_CU_DF\Software\Microsoft\Internet Explorer\TypedURLs","url4","REG_SZ",$Inigurl4)
					RegWrite("HKLM\PE_CU_DF\Software\Microsoft\Internet Explorer\TypedURLs","url5","REG_SZ",$Inigurl5)
				Else
				EndIf
				If GUICtrlRead ($checkCN019)=1 Then
					Run('resources\icons.exe')
				Else
				EndIf
; ������ "�������� ��"
            Case $msg = $tabBut01
				GuiCtrlSetState($checkCN01, 1)
				GuiCtrlSetState($checkCN02, 1)
				GuiCtrlSetState($checkCN03, 1)
				GuiCtrlSetState($checkCN04, 1)
				GuiCtrlSetState($checkCN05, 1)
				GuiCtrlSetState($checkCN06, 1)
				GuiCtrlSetState($checkCN07, 1)
				GuiCtrlSetState($checkCN08, 1)
				GuiCtrlSetState($checkCN081, 1)
				GuiCtrlSetState($checkCN09, 1)
				GuiCtrlSetState($checkCN010, 1)
				GuiCtrlSetState($checkCN011, 1)
				GuiCtrlSetState($checkCN012, 1)
				GuiCtrlSetState($checkCN013, 1)
				GuiCtrlSetState($checkCN019, 1)
            Case $msg = $tabBut03
				RegDelete("HKLM\PE_LM_SW\Classes\Folder\shell\opennew") ; ������������ ������ "������� � ����� ����"
            Case $msg = $tabBut011
				RegDelete("HKLM\PE_CU_DF\Software\Microsoft\Windows\CurrentVersion\Policies\comdlg32\PlacesBar") ; ������������ ������ "��������� ���"
            Case $msg = $vkladka02
; ������ ������� �������� ����������
				If GUICtrlRead ($tabBut0101)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.3dg\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0102)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.ais\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0103)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.au3\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0104)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.bmp\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0105)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.doc\Word.Document.6\ShellNew")
					RegDelete("HKLM\PE_LM_SW\Classes\.doc\Word.Document.8\ShellNew")
					RegDelete("HKLM\PE_LM_SW\Classes\.doc\WordDocument\ShellNew")
					RegDelete("HKLM\PE_LM_SW\Classes\.doc\Word.Document.1\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0106)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.docx\Word.Document.12\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0107)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.dst\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0108)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.egc\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0109)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.fxp\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0110)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.ppt\PowerPoint.Show.4\ShellNew")
					RegDelete("HKLM\PE_LM_SW\Classes\.ppt\PowerPoint.Show.8\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0111)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.pptx\PowerPoint.Show.12\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0112)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.psd\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0113)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.rar\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0114)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.rsnp\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0115)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.rtf\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0116)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.slg\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0117)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.tpp\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0118)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.wav\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0119)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.xls\Excel.Sheet.5\ShellNew")
					RegDelete("HKLM\PE_LM_SW\Classes\.xls\Excel.Sheet.8\ShellNew")
					RegDelete("HKLM\PE_LM_SW\Classes\.xls\ExcelWorksheet\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0120)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.xlsx\Excel.Sheet.12\ShellNew")
				Else
				EndIf
				If GUICtrlRead ($tabBut0121)=1 Then
					RegDelete("HKLM\PE_LM_SW\Classes\.zip\ShellNew")
				Else
				EndIf
; ������ "�������� ��"
            Case $msg = $tabBut11
				GuiCtrlSetState($tabBut0101, 1)
				GuiCtrlSetState($tabBut0102, 1)
				GuiCtrlSetState($tabBut0103, 1)
				GuiCtrlSetState($tabBut0104, 1)
				GuiCtrlSetState($tabBut0105, 1)
				GuiCtrlSetState($tabBut0106, 1)
				GuiCtrlSetState($tabBut0107, 1)
				GuiCtrlSetState($tabBut0108, 1)
				GuiCtrlSetState($tabBut0109, 1)
				GuiCtrlSetState($tabBut0110, 1)
				GuiCtrlSetState($tabBut0111, 1)
				GuiCtrlSetState($tabBut0112, 1)
				GuiCtrlSetState($tabBut0113, 1)
				GuiCtrlSetState($tabBut0114, 1)
				GuiCtrlSetState($tabBut0115, 1)
				GuiCtrlSetState($tabBut0116, 1)
				GuiCtrlSetState($tabBut0117, 1)
				GuiCtrlSetState($tabBut0118, 1)
				GuiCtrlSetState($tabBut0119, 1)
				GuiCtrlSetState($tabBut0120, 1)
				GuiCtrlSetState($tabBut0121, 1)
; ����� ������� �������� ����������
            Case $msg = $vkladka03
; ������ ������� ������ ������������ 7sh3
				If GUICtrlRead ($checkCN20)=1 Then
					If GUICtrlRead ($tab20combo)="800x600" Then
						RegWrite("HKLM\PE_LM_SW\Microsoft\Windows\CurrentVersion\RunOnceEx\800","100","REG_SZ",'||shellexecute.exe /h qres.exe /x 800 /y 600 /c:32 /r:60')
					Else
					EndIf
					If GUICtrlRead ($tab20combo)="1024x768" Then
						RegWrite("HKLM\PE_LM_SW\Microsoft\Windows\CurrentVersion\RunOnceEx\800","100","REG_SZ",'||shellexecute.exe /h qres.exe /x 1024 /y 768 /c:32 /r:60')
					Else
					EndIf
					If GUICtrlRead ($tab20combo)="1280x1024" Then
						RegWrite("HKLM\PE_LM_SW\Microsoft\Windows\CurrentVersion\RunOnceEx\800","100","REG_SZ",'||shellexecute.exe /h qres.exe /x 1280 /y 1024 /c:32 /r:60')
					Else
					EndIf
					If GUICtrlRead ($tab20combo)="1600x1200" Then
						RegWrite("HKLM\PE_LM_SW\Microsoft\Windows\CurrentVersion\RunOnceEx\800","100","REG_SZ",'||shellexecute.exe /h qres.exe /x 1600 /y 1200 /c:32 /r:60')
					Else
					EndIf
					If GUICtrlRead ($tab20combo)="Delete" Then
						RegDelete("HKLM\PE_LM_SW\Microsoft\Windows\CurrentVersion\RunOnceEx\800","100")
					Else
					EndIf
				Else
				EndIf
				If GUICtrlRead ($checkCN21)=1 Then
					RegDelete("HKLM\PE_LM_SW\Microsoft\Windows\CurrentVersion\RunOnceEx\900","900wb")
					RegDelete("HKLM\PE_LM_SW\Microsoft\Windows\CurrentVersion\RunOnceEx\998","998")
				Else
				EndIf
				If GUICtrlRead ($checkCN22)=1 Then
					; ������ �� ������������ �� 7sh3 ������������ jpg
					FileCopy(@ScriptDir & '\Wallpaper.jpg', $disk_z&'\I386\system32\Wallpaper.jpg', 1)
					RegWrite("HKLM\PE_CU_DF\Control Panel\Desktop","Wallpaper","REG_SZ",'%SystemRoot%\System32\Wallpaper.jpg')
				Else
				EndIf
				If GUICtrlRead ($checkCN23)=1 Then
					Run('shellexecute.exe /h menu_Toolbars.cmd')
				Else
				EndIf
				If GUICtrlRead ($checkCN24)=1 Then
					RegWrite("HKLM\PE_SY_HI\ControlSet001\Control\Session Manager\Environment","ProfilesDir","REG_EXPAND_SZ",'%ramdrv%\Documents and Settings')
					RegWrite("HKLM\PE_SY_HI\ControlSet001\Control\Session Manager\Environment","USERPROFILE","REG_EXPAND_SZ",'%ramdrv%\Documents and Settings\Default User')
					RegWrite("HKLM\PE_SY_HI\ControlSet001\Control\Session Manager\Environment","ALLUSERSPROFILE","REG_EXPAND_SZ",'%ramdrv%\Documents and Settings\All Users')
				Else
				EndIf
; ����� ������� ������ ������������ 7sh3
            Case $msg = $vkladka04
; ������ ������� ������ ������ RusLive
				If GUICtrlRead ($checkCN31)=1 Then
					; ���� ������ �� ������������ jpg, �� ����� ������������ bmp, �� ��� ���������� ������ � ������� ������ ������������ ���� � ��������������� �����, ��� ���� ������ ����� �� 150 ��.
					FileCopy(@ScriptDir & '\Wallpaper.bmp', $disk_z&'\I386\system32\Wallpaper.bmp', 1)
					RegWrite("HKLM\PE_CU_DF\Control Panel\Desktop","Wallpaper","REG_SZ",'%SystemRoot%\System32\Wallpaper.bmp')
				Else
				EndIf
				If GUICtrlRead ($checkCN32)=1 Then
					Run('shellexecute.exe /h panel_link.cmd')
				Else
				EndIf
; ����� ������� ������ ������ RusLive
; ���������� ��������� � ������������� �������
			Case $msg = $restart
				If not FileExists(@ScriptDir&'\restart.cmd') Then
				   FileWriteLine (@ScriptDir&'\restart.cmd', 'taskkill.exe /F /IM TweakerLiveCD.exe' )
				   FileWriteLine (@ScriptDir&'\restart.cmd', 'start %~dp0TweakerLiveCD.exe' )
				EndIf
				If FileExists(@ScriptDir&'\restart.cmd') Then Run(@ScriptDir&'\restart.cmd', "", @SW_HIDE)
			Case $msg = $GUI_EVENT_CLOSE
				ExitLoop
		EndSelect
	WEnd