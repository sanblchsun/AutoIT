#NoTrayIcon
$QuickLaunch=@AppDataDir&'\Microsoft\Internet Explorer\Quick Launch'
$SendTo=@UserProfileDir&'\SendTo'
$disksht='X:'
$Desktop=@UserProfileDir&'\������� ����'
Global $EXE, $LNK, $WRK, $ARG, $DSC, $ICO, $NMR, $DIR

;��������� ��������� ��������������, �������� $ARG, $ICO, $NMR �� ��������� ������ ������������� ������ ������ ���������� �����. ������� �������  $WRK ���� �� ������, �� �������������� ��  �������� $EXE.
;$NME=��� ������
;$DIR=������� ��� �������� �����
;$WRK=������� �������
;$EXE=��������� ����
;$ARG=��������� ������ ���������� �����
;$DSC=��������, ����������� ������
;$ICO=������
;$NMR=����� ������ � dll, exe
;a() - ����� ������� �������� ������

; �����������������
$NME='������� ���� �������� �� ����� C (512M�)'
$DIR=@ProgramsCommonDir&'\�����������������\����������� ������'
$EXE=@SystemDir&'\setpagefile.exe'
$ARG='/f c:\pagefile.sys /i 512 /m 512'
a()
$NME='������� ���� � ������ ��� ����� ��������...'
$DIR=@ProgramsCommonDir&'\�����������������\����������� ������'
$EXE=@SystemDir&'\setpagefile.exe'
a()
$NME='������� ���� �������� �� ����� C (1024M�)'
$DIR=@ProgramsCommonDir&'\�����������������\����������� ������'
$EXE=@SystemDir&'\setpagefile.exe'
$ARG='/f c:\pagefile.sys /i 1024 /m 1024'
a()
$NME='������� ���� �������� �� ����� C (2048M�)'
$DIR=@ProgramsCommonDir&'\�����������������\����������� ������'
$EXE=@SystemDir&'\setpagefile.exe'
$ARG='/f c:\pagefile.sys /i 2048 /m 2048'
a()
$NME='������� ���� �������� �� ����� D (512M�)'
$DIR=@ProgramsCommonDir&'\�����������������\����������� ������'
$EXE=@SystemDir&'\setpagefile.exe'
$ARG='/f d:\pagefile.sys /i 512 /m 512'
a()
$NME='������� ���� �������� �� ����� D (1024M�)'
$DIR=@ProgramsCommonDir&'\�����������������\����������� ������'
$EXE=@SystemDir&'\setpagefile.exe'
$ARG='/f d:\pagefile.sys /i 1024 /m 1024'
a()
$NME='������� ���� �������� �� ����� D (2048M�)'
$DIR=@ProgramsCommonDir&'\�����������������\����������� ������'
$EXE=@SystemDir&'\setpagefile.exe'
$ARG='/f d:\pagefile.sys /i 2048 /m 2048'
a()
$NME='Regshot'
$DIR=@ProgramsCommonDir&'\�����������������'
$EXE=@SystemDir&'\regshot.exe'
$DSC='��������� ������� ������� �� � ����� ���������.'
a()
$NME='���������� ���������� ����������'
$DIR=@ProgramsCommonDir&'\�����������������\��������� ���������'
$EXE=@SystemDir&'\rundll32.exe'
$ARG='shell32.dll,Control_RunDLL hotplug.dll'
$ICO=@SystemDir&'\hotplug.dll'
a()
$NME='��������� ���������'
$DIR=@ProgramsCommonDir&'\�����������������\��������� ���������'
$EXE=@SystemDir&'\updatedevices.exe'
a()
$NME='��������� ��������� (HwPnP COM Ports)'
$DIR=@ProgramsCommonDir&'\�����������������\��������� ���������'
$EXE=@SystemDir&'\HWPNP.EXE'
$ARG='-all +ACPI\PNP0400 +ACPI\PNP0401 +ACPI\PNP0501\1 +ACPI\PNP0501\2 /u /p /log+'
$ICO=@SystemDir&'\setupapi.dll'
$NMR=16
a()
$NME='��������� ��������� (HwPnP Full Force)'
$DIR=@ProgramsCommonDir&'\�����������������\��������� ���������'
$EXE=@SystemDir&'\HWPNP.EXE'
$ARG='+all /u /a /p /d /log+'
$ICO=@SystemDir&'\hwpnp.exe'
a()
$NME='��������� ��������� (HwPnP Full)'
$DIR=@ProgramsCommonDir&'\�����������������\��������� ���������'
$EXE=@SystemDir&'\shellexecute.exe'
$ARG='/h run-hwpnp.cmd'
$ICO=@SystemDir&'\setupapi.dll'
$NMR=25
a()
$NME='��������� ��������� (HwPnP HD Audio)'
$DIR=@ProgramsCommonDir&'\�����������������\��������� ���������'
$EXE=@SystemDir&'\HWPNP.EXE'
$ARG='-all +PCI\CC_040+HDAUDIO\ /p /d /log+'
$ICO=@SystemDir&'\stobject.dll'
$NMR=2
a()
$NME='��������� ��������� (HwPnP Modem)'
$DIR=@ProgramsCommonDir&'\�����������������\��������� ���������'
$EXE=@SystemDir&'\HWPNP.EXE'
$ARG='-all +SERENUM\ /p /d /log+'
$ICO=@SystemDir&'\mdminst.dll'
a()
$NME='��������� ��������� (HwPnP USB Force)'
$DIR=@ProgramsCommonDir&'\�����������������\��������� ���������'
$EXE=@SystemDir&'\HWPNP.EXE'
$ARG='-all +STORAGE\VOLUME +USB\ +USBSTOR\ /a /u /p /d /log+'
$ICO=@SystemDir&'\setupapi.dll'
$NMR=13
a()
$NME='��������� ��������� (HwPnP USB)'
$DIR=@ProgramsCommonDir&'\�����������������\��������� ���������'
$EXE=@SystemDir&'\HWPNP.EXE'
$ARG='-all +STORAGE\VOLUME +USB\ +USBSTOR\ /p /d /log+'
$ICO=@SystemDir&'\setupapi.dll'
$NMR=13
a()
$NME='1. ��������� ��������� (Driver Import V1.3)'
$DIR=@ProgramsCommonDir&'\�����������������\��������� ���������'
$EXE='X:\PROGRAMS\Driver Import\DrvImpe.exe'
$DSC='����� � ��������� ��������� �� Windows ��� ��������� ����� ���������.'
a()
$NME='2. Mount Storage PE'
$DIR=@ProgramsCommonDir&'\�����������������\��������� ���������'
$EXE='X:\PROGRAMS\MountStorage\MountStorPe.exe'
$DSC='������������ ������ ������.'
a()
$NME='Runscanner+RegWorkshop'
$DIR=@ProgramsCommonDir&'\�����������������'
$EXE=@SystemDir&'\runscanner.exe'
$ARG='/y /t 0 X:\PROGRAMS\RegWorkshop\RegWorkshop.exe'
$DSC='��������� ������ Windows XP'
$ICO='X:\PROGRAMS\RegWorkshop\RegWorkshop.exe'
a()
$NME='�������������� �����'
$DIR=@ProgramsCommonDir&'\�����������������'
$EXE=@SystemDir&'\mmc.exe'
$ARG=@SystemDir&'\dfrg.msc'
$ICO=@SystemDir&'\DFRGRES.DLL'
a()
$NME='��������� ������'
$DIR=@ProgramsCommonDir&'\�����������������'
$EXE=@SystemDir&'\CMD.EXE'
a()
$NME='������������ ��������'
$DIR=@ProgramsCommonDir&'\�����������������'
$EXE=@SystemDir&'\NIRCMD.EXE'
$ARG='killprocess explorer.exe'
$ICO=@SystemDir&'\shell32.dll'
$NMR=94
a()
$NME='�������� ����� '
$DIR=@ProgramsCommonDir&'\�����������������'
$EXE=@SystemDir&'\CHKDSKGUI.EXE'
$ICO=@SystemDir&'\shell32.dll'
$NMR=8
a()
$NME='Runscanner+regedit'
$DIR=@ProgramsCommonDir&'\�����������������'
$EXE=@SystemDir&'\runscanner.exe'
$ARG='/y /t 0 regedit.exe'
$DSC='��������� ������ Windows XP'
$ICO=@SystemDir&'\regedit.exe'
a()
$NME='������ Windows Installer'
$DIR=@ProgramsCommonDir&'\�����������������'
$EXE=@SystemDir&'\SHELLEXECUTE.EXE'
$ARG='/h run-msi.cmd'
$ICO=@SystemDir&'\msiexec.exe'
a()
$NME='������ � ����������'
$DIR=@ProgramsCommonDir&'\�����������������'
$EXE=@SystemDir&'\pserv2.exe'
a()
$NME='������ ����������'
$DIR=@ProgramsCommonDir&'\�����������������'
$EXE=@SystemDir&'\shutdown.exe'
$ARG='/i /u /tr'
a()
$NME='���������� �������'
$DIR=@ProgramsCommonDir&'\�����������������'
$EXE=@SystemDir&'\mmc.exe'
$ARG=@SystemDir&'\diskmgmt.msc'
$ICO=@SystemDir&'\dmdskres.dll'
a()
$NME='���������� �����������'
$DIR=@ProgramsCommonDir&'\�����������������'
$EXE=@SystemDir&'\mmc.exe'
$ARG=@SystemDir&'\compmgmt.msc'
$ICO=@SystemDir&'\setupapi.dll'
a()
; �����������
$NME='FFdshow Video Decoder'
$DIR=@ProgramsDir&'\�����������'
$EXE=@SystemDir&'\RUNDLL32.EXE'
$ARG='X:\PROGRAMS\MPC\FFdshow\ffdshow.ax,configure'
$ICO=@SystemDir&'\shell32.dll'
$NMR=165
a()
$NME='Media Player Classic'
$DIR=@ProgramsDir&'\�����������'
$EXE='X:\PROGRAMS\MPC\mplayerc.exe'
a()
$NME='���������'
$DIR=@ProgramsDir&'\�����������'
$EXE=@SystemDir&'\SNDVOL32.EXE'
a()
$NME='�����������'
$DIR=@ProgramsDir&'\�����������'
$EXE=@SystemDir&'\SNDREC32.EXE'
a()
; �����������
$NME='Internet Explorer'
$DIR=@ProgramsDir&'\�����������'
$EXE=@WindowsDir&'\IEXPLORE.EXE'
$ARG='about:blank'
$DSC='������� ��� ������ � ��������, �������� ������� � HTML-���������.'
a()
$NME='Paint'
$DIR=@ProgramsDir&'\�����������'
$EXE=@SystemDir&'\mspaint.exe'
a()
$NME='WordPad'
$DIR=@ProgramsDir&'\�����������'
$EXE=@SystemDir&'\WORDPAD.EXE'
a()
$NME='�������'
$DIR=@ProgramsDir&'\�����������'
$EXE=@SystemDir&'\notepad.exe'
a()
$NME='�����������'
$DIR=@ProgramsDir&'\�����������'
$EXE=@SystemDir&'\calc.exe'
a()
$NME='������� ��������'
$DIR=@ProgramsDir&'\�����������'
$EXE=@SystemDir&'\CHARMAP.EXE'
a()
; ����
$NME='�������'
$DIR=@ProgramsDir&'\�����������\����'
$EXE=@SystemDir&'\SOL.EXE'
a()
$NME='����'
$DIR=@ProgramsDir&'\�����������\����'
$EXE=@SystemDir&'\SPIDER.EXE'
a()
$NME='�����'
$DIR=@ProgramsDir&'\�����������\����'
$EXE=@SystemDir&'\WINMINE.EXE'
a()
$NME='�������'
$DIR=@ProgramsDir&'\�����������\����'
$EXE=@SystemDir&'\FREECELL.EXE'
a()
; ������ �������� �������
$NME='���� �'
$DIR=$QuickLaunch
$EXE=@WindowsDir&'\explorer.exe'
$ARG='C:\'
$ICO=@SystemDir&'\shell33.dll'
$NMR=1
a()
$NME='���� D'
$DIR=$QuickLaunch
$EXE=@WindowsDir&'\explorer.exe'
$ARG='D:\'
$ICO=@SystemDir&'\shell33.dll'
$NMR=2
a()
$NME='���� B'
$DIR=$QuickLaunch
$EXE=@WindowsDir&'\explorer.exe'
$ARG='B:\'
$ICO=@SystemDir&'\shell33.dll'
$NMR=0
a()
$NME='���� X'
$DIR=$QuickLaunch
$EXE=@WindowsDir&'\explorer.exe'
$ARG='X:\'
$ICO=@SystemDir&'\shell33.dll'
$NMR=3
a()
$NME='��������� ��������� (HwPnP Full)'
$DIR=$QuickLaunch
$EXE=@SystemDir&'\shellexecute.exe'
$ARG='/h run-hwpnp.cmd'
$ICO='setupapi.dll'
$NMR=25
a()
$NME='��������� ���������'
$DIR=$QuickLaunch
$EXE=@SystemDir&'\updatedevices.exe'
a()
; Panel (������� ������)
$NME='10_������������ ������'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\personal\personal.au3'
$ICO='X:\PROGRAMS\Update_Utilite\personal\personal.ico'
a()
$NME='11_���������� ������ 1024�768�32'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\nircmd.exe'
$ARG='setdisplay 1024 768 32'
$DSC='���������� ���������� ������ 1024�768�32'
$ICO=@SystemDir&'\shell33.dll'
$NMR=5
a()
$NME='12_���������� ������ 1280�1024�32'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\nircmd.exe'
$ARG='setdisplay 1280 1024 32'
$DSC='���������� ���������� ������ 1280�1024�32'
$ICO=@SystemDir&'\shell33.dll'
$NMR=6
a()
$NME='13_A����������� �������� ������'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\SHELLEXECUTE.EXE'
$ARG='/h '&$disksht&'\PROGRAMS\Update_Utilite\Start_Offise.bat'
$DSC='������ ������� �������� (clcl, Socrat, AnVir Task Manager, Arum Switcher, Kleptomania, Power Mixer)'
$ICO=@SystemDir&'\shell33.dll'
$NMR=7
a()
$NME='14_Power Mixer'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Power Mixer\pwmixer.exe'
$DSC='����������� ����� ��������� Shift + ������� ����'
a()
$NME='15_clcl (B)'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\clcl\StartCL.bat'
$DSC='���������� ������� ������, ����� Alt + C'
$ICO=$disksht&'\PROGRAMS\clcl\CLCL.exe'
a()
$NME='16_Arum Switcher'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Arum Switcher\ArumSwitcher.exe'
$DSC='������ ������ ��� ����������� �������� ��������� ����������, Win + Ctrl'
$ICO=$disksht&'\PROGRAMS\Arum Switcher\Arum.dll'
a()
$NME='17_Kleptomania'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Kleptomania\k-mania.exe'
$DSC='����������� ������ � ���������� ���� � ����� ������ � ������� � ��������� ��������.'
a()
$NME='18_Socrat'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Socrat\spv.exe'
$DSC='�����-������� ���������� ������.'
a()
$NME='19_Search and Replace'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\SR\SR32.EXE'
$DSC='����� � ������ ������ � ������.'
a()
$NME='20_DupeLocater(wim)'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\DupeLocater\DupeLocater.wim'
$DSC='����� ���������� ������.'
$ICO=$disksht&'\PROGRAMS\DupeLocater\dl.ico'
a()
$NME='20_gimagex + ������������� wim'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\wimoff.au3'
$ICO='X:\PROGRAMS\gimagex\gimagex.exe'
$DSC="��������� ������������� �� wim'� � ����� gimagex"
a()
$NME='20_Regshot'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\regshot.exe'
$DSC='��������� ������� ������� �� � ����� ���������.'
a()
$NME='20_RegWorkshop'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE='X:\PROGRAMS\RegWorkshop\RegWorkshop.exe'
$DSC='������� �������� �������.'
a()
$NME='21_TextMaker (Word)'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE='X:\Programs\SoftMakerOffice2010\TextMaker.exe'
a()
$NME='22_PlanMaker (Excel)'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE='X:\Programs\SoftMakerOffice2010\PlanMaker.exe'
a()
$NME='24_Notepad++'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\notepad++\notepad++.exe'
$DSC='������ ��������, �������� ������� ������, �������, ��������� ��������� ��������� ����.'
a()
$NME='25_Foxit Reader'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\FoxitReader\foxitreader.exe'
$DSC='�������� *.pdf-������.'
a()
$NME='26_TCode(wim)'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\TCode\tcode.wim'
$DSC='������������� ������ � ����������� ���.'
$ICO=$disksht&'\PROGRAMS\TCode\tc.ico'
a()
$NME='27_AnVir Task Manager'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\AnVir Task Manager\Launch_pe.exe'
$DSC='������������, ��������� ��������, �������� ������������.'
a()
$NME='28_Internet Explorer'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@WindowsDir&'\iexplore.exe'
$ARG='about:blank'
$DSC='������� ��� ������ � ��������, �������� ������� � HTML-���������.'
a()
$NME='29_Alcohol 120%'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Alcohol\Alcohol.exe'
$DSC='����������� ������.'
a()
$NME='31_Sateira'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\SCDB\DataBurner.exe'
$DSC='������ CD,DVD-������.'
a()
$NME='34_Cdslow(wim)'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Cdslow\Cdslow.wim'
$DSC='����������� �������� CD,DVD-����� � �������.'
$ICO=$disksht&'\PROGRAMS\Cdslow\cd.ico'
a()
$NME='36_UltraISO'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\UltraISO\UltraISO.exe'
$DSC='�������� ������� CD,DVD-������, ����������� ����������� ��������.'
a()
$NME='37_WinImage'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\WinImage\winimage.exe'
$DSC='������� ����-����� ����������� ������.'
a()
$NME='38_TotalCMD'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE='X:\PROGRAMS\TotalCMD\Totalcmd.exe'
a()
$NME='44_Ghost-explorer'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Ghost32\Ghostexp.exe'
$DSC='�������� ������� ������� �����, � ������������ ���������� ������.'
a()
$NME='45_Acronis True Image 9.7'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE='X:\PROGRAMS\acronis\TRUEIMAGE\trueimage.exe'
$DSC='�������� ������� ������� �����.'
a()
$NME='49_������������ EXT2&3 ����'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\IFSDRIVES.CPL'
$DSC='������������ EXT2&3 ����, ��� ��������� ������ ������.'
$ICO=@SystemDir&'\shell32.dll'
$NMR=8
a()
$NME='52_WinHex'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\WinHex\WinHex.exe'
$DSC='��������  � �������������� �������� ������.'
a()
$NME='53_CloneSpy'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\CloneSpy\CloneSpy.exe'
$DSC='����� ���������� ������.'
a()
$NME='54_Scanner'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Scanner\SCANNER.EXE'
$DSC='�������� ������ ������ ��� ������ ������ � ����� ���������� ����� �����.'
a()
$NME='55_ResHacker'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\ResHacker\ResHacker.exe'
$DSC='�������� �������� EXE, DLL-������.'
a()
$NME='57_Media Player Classic'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\MPC\mplayerc.exe'
$DSC='����� �������������� ��� ������� ��� ������� �������.'
a()
$NME='58_Imagine'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Imagine\Imagine.exe'
$DSC='����������� �������.'
a()
$NME='59_ArtIcons Pro'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\ArtIcons Pro\ARTICONS.exe'
$DSC='�������� ������.'
a()
$NME='60_�������'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\NOTEPAD.EXE'
$DSC='�������.'
a()
$NME='61_������� ������������'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$WRK='X:\PROGRAMS\Update_Utilite\net_config'
$EXE=@SystemDir&'\SHELLEXECUTE.EXE'
$ARG='/h X:\PROGRAMS\Update_Utilite\net_config\start.bat'
$DSC='���� IP, �������, DNS ��� ����������� � ��������� ��� ������������ �����.'
$ICO=@SystemDir&'\PENetwork.exe'
a()
$NME='62_��������� LiveCD �� ����, ������'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$WRK='X:\Programs\Update_Utilite\instLiveCD'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\instLiveCD\instLiveCD.au3'
$DSC='� ������� ��������� ���� Boot.ini ��� Grub.'
$ICO='X:\PROGRAMS\Update_Utilite\instLiveCD\instLiveCD.ico'
a()
$NME='63_Environment'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$WRK='X:\Programs\Update_Utilite\Environment'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\Environment\environment.au3'
$DSC='������� ���������� Temp � ������.'
$ICO='X:\PROGRAMS\Update_Utilite\Environment\System_path.ico'
a()
$NME='63_ImDisk'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$WRK=$disksht&'\PROGRAMS\Update_Utilite'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=$disksht&'\PROGRAMS\Update_Utilite\imdisk.au3'
$DSC='���������� ������ ����� B. ��� ������������ ������� CD,DVD-������, ������, � ������������ ����������� �� � ������ ���.'
$ICO=@SystemDir&'\imdisk.cpl'
a()
$NME='63_����������'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='assotiations.au3'
$ICO=@SystemDir&'\shell33.dll'
$NMR=14
$DSC='������������� ���� ��������� � �������.'
a()
$NME='63_���������������� �����'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\user.au3'
$ICO=@SystemDir&'\shell32.dll'
$NMR=170
$DSC='������ ���������� � ������ ������������� WindowsXP � LiveCD.'
a()
$NME='64_������ ���������'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$WRK='X:\PROGRAMS\Update_Utilite\SaveFolders'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\SaveFolders\SaveFolders.au3'
$DSC='���������� ������� ���������� ��������� � ������'
$ICO=@SystemDir&'\shell32.dll'
$NMR=110
a()
$NME='66_Driver Import V1.3'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$WRK='X:\Programs\Driver Import'
$DSC='����� � ��������� ��������� �� Windows ��� ��������� ����� ���������.'
a()
$NME='66_MountStorPe + ���������� ������'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\hdd_off.au3'
$ICO='X:\PROGRAMS\MountStorage\MountStorPe.exe'
$DSC='����������� � ���������� ������ ������.'
a()
$NME='67_SmartDriverBackup'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\SmartDriverBackup\SmartDriverBackup.exe'
$DSC='��������� �������� �������� �� "�������" WindowsXP.'
a()
$NME='96_����� �������������� ����'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\WindowBlinds\wbchoice.au3'
$DSC='����� �������� ��� � ������  ������.'
$ICO='X:\PROGRAMS\WindowBlinds\wbload.exe'
a()
$NME='� �����'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE='X:\PROGRAMS\Update_Utilite\WinXPE_help\htmlautorun.exe'
a()
; ���� (!)
$NME='Alcohol 120%'
$DIR=@ProgramsDir&'\!\cd-rom'
$EXE=$disksht&'\PROGRAMS\Alcohol\Alcohol.exe'
$DSC='����������� ������.'
a()
$NME='Cdslow(wim)'
$DIR=@ProgramsDir&'\!\cd-rom'
$EXE=$disksht&'\PROGRAMS\Cdslow\Cdslow.wim'
$DSC='����������� �������� CD,DVD-����� � �������.'
$ICO=$disksht&'\PROGRAMS\Cdslow\cd.ico'
a()
$NME='ImDisk'
$DIR=@ProgramsDir&'\!\cd-rom'
$WRK=$disksht&'\PROGRAMS\Update_Utilite'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=$disksht&'\PROGRAMS\Update_Utilite\imdisk.au3'
$DSC='��� ������������ ������� CD,DVD-������, ������, � ������������ ����������� �� � ������ ���.'
$ICO=@SystemDir&'\imdisk.cpl'
a()
$NME='ScbData'
$DIR=@ProgramsDir&'\!\cd-rom'
$EXE=$disksht&'\PROGRAMS\SCDB\ScbData.exe'
$DSC='������ CD,DVD-������.'
a()
$NME='UltraISO'
$DIR=@ProgramsDir&'\!\cd-rom'
$EXE=$disksht&'\PROGRAMS\UltraISO\UltraISO.exe'
$DSC='�������� ������� CD,DVD-������, ����������� ����������� ��������.'
a()
$NME='�������� ����� �����'
$DIR=@ProgramsDir&'\!\cd-rom\SCDB'
$EXE=$disksht&'\PROGRAMS\SCDB\ImageBurner.exe'
$DSC='������ CUE/BIN/ISO-�������.'
a()
$NME='������ ���� � �������'
$DIR=@ProgramsDir&'\!\cd-rom\SCDB'
$EXE=$disksht&'\PROGRAMS\SCDB\DataBurner.exe'
$DSC='������ CD,DVD-������.'
a()
$NME='������ �����-������'
$DIR=@ProgramsDir&'\!\cd-rom\SCDB'
$EXE=$disksht&'\PROGRAMS\SCDB\AudioBurner.exe'
$DSC='������ �����-������.'
a()
$NME='����� ������'
$DIR=@ProgramsDir&'\!\cd-rom\SCDB'
$EXE=$disksht&'\PROGRAMS\SCDB\Commander.exe'
$DSC='����� ������.'
a()
$NME='AnVir Task Manager (B)'
$DIR=@ProgramsDir&'\!\Windows\����������'
$EXE=$disksht&'\PROGRAMS\AnVir Task Manager\Launch_pe.exe'
$DSC='������������, ��������� ��������, �������� ������������.'
a()
$NME='clcl (B)'
$DIR=@ProgramsDir&'\!\Windows\����������'
$EXE=$disksht&'\PROGRAMS\clcl\StartCL.bat'
$DSC='���������� ������� ������, ����� Alt + C'
$ICO=$disksht&'\PROGRAMS\clcl\CLCL.exe'
a()
$NME='Socrat'
$DIR=@ProgramsDir&'\!\Windows\����������'
$EXE=$disksht&'\PROGRAMS\Socrat\spv.exe'
$DSC='�����-������� ���������� ������.'
a()
$NME='+���������-������-PE'
$DIR=@ProgramsDir&'\!\Windows\���������'
$WRK='X:\Programs\Update_Utilite'
$EXE=@SystemDir&'\shellexecute.exe'
$ARG='/h X:\Programs\Update_Utilite\+save-reestr-PE.bat'
$ICO=@SystemDir&'\cmd.exe'
a()
$NME='���������� �����������'
$DIR=@ProgramsDir&'\!\Windows\���������'
$EXE=@SystemDir&'\mmc.exe'
$ARG=@SystemDir&'\compmgmt.msc'
$ICO=@SystemDir&'\setupapi.dll'
a()
$NME='� �����'
$DIR=@ProgramsDir&'\!\Windows\���������'
$EXE='X:\PROGRAMS\Update_Utilite\WinXPE_help\htmlautorun.exe'
a()
$NME='������������ ������'
$DIR=@ProgramsDir&'\!\Windows\���������'
$WRK='X:\Programs\Update_Utilite\personal'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\personal\personal.au3'
$ICO='X:\PROGRAMS\Update_Utilite\personal\personal.ico'
a()
$NME='���������� �����'
$DIR=@ProgramsDir&'\!\Windows\���������'
$WRK='X:\Programs\Update_Utilite\Environment'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\Environment\environment.au3'
$DSC='������� ���������� Temp � ������.'
$ICO='X:\PROGRAMS\Update_Utilite\Environment\System_path.ico'
a()
$NME='+��������� Application Data'
$DIR=@ProgramsDir&'\!\Windows\���������'
$EXE='X:\Programs\Update_Utilite\save_lnk.cmd'
$ICO=@SystemDir&'\cmd.exe'
$DSC='����������� ������ � sfx-����� ADDFILE.EXE.'
a()
$NME='+���������-������-PE'
$DIR=@ProgramsDir&'\!\Windows\���������'
$EXE='X:\Programs\Update_Utilite\save_App_Data.cmd'
$ICO=@SystemDir&'\cmd.exe'
$DSC='����������� ������� � sfx-����� ADDFILE.EXE.'
a()
$NME='�������� ����������'
$DIR=@ProgramsDir&'\!\Windows\���������'
$EXE=@SystemDir&'\SYSDM.CPL'
$ICO=@SystemDir&'\MMCNDMGR.DLL'
$NMR=11
a()
$NME='Internet Explorer'
$DIR=@ProgramsDir&'\!\Windows'
$EXE=@WindowsDir&'\IEXPLORE.EXE'
$ARG='about:blank'
$DSC='������� ��� ������ � ��������, �������� ������� � HTML-���������.'
a()
$NME='Paint'
$DIR=@ProgramsDir&'\!\Windows'
$EXE=@SystemDir&'\mspaint.exe'
a()
$NME='regedit'
$DIR=@ProgramsDir&'\!\Windows'
$EXE=@SystemDir&'\regedit.exe'
a()
$NME='�������'
$DIR=@ProgramsDir&'\!\Windows'
$EXE=@SystemDir&'\notepad.exe'
a()
$NME='�����������'
$DIR=@ProgramsDir&'\!\Windows'
$EXE=@SystemDir&'\calc.exe'
a()
$NME='WindowBlinds(au3)'
$DIR=@ProgramsDir&'\!\Windows'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\WindowBlinds\wbchoice.au3'
$DSC='����� �������� ��� � ������  ������.'
$ICO='X:\PROGRAMS\WindowBlinds\wbload.exe'
a()
$NME='WindowBlinds(cmd)'
$DIR=@ProgramsDir&'\!\Windows'
$EXE=@SystemDir&'\SHELLEXECUTE.EXE'
$ARG='/h X:\PROGRAMS\WindowBlinds\start.cmd'
$DSC='����� ����, ���������/���������� WB.'
$ICO='X:\PROGRAMS\WindowBlinds\wbload.exe'
a()
$NME='RegWorkshop'
$DIR=@ProgramsDir&'\!\Windows'
$EXE='X:\PROGRAMS\RegWorkshop\RegWorkshop.exe'
$DSC='������� �������� �������.'
a()
$NME='ArtIcons Pro'
$DIR=@ProgramsDir&'\!\�������'
$EXE=$disksht&'\PROGRAMS\ArtIcons Pro\ARTICONS.exe'
$DSC='�������� ������.'
a()
$NME='Paint'
$DIR=@ProgramsDir&'\!\�������'
$EXE=@SystemDir&'\mspaint.exe'
a()
$NME='WinDjView'
$DIR=@ProgramsDir&'\!\�������'
$EXE='X:\PROGRAMS\WinDjView\WinDjView.exe'
a()
$NME='Imagine'
$DIR=@ProgramsDir&'\!\�������'
$EXE=$disksht&'\PROGRAMS\Imagine\Imagine.exe'
$DSC='����������� �������.'
a()
$NME='Apache2.2'
$DIR=@ProgramsDir&'\!\��������'
$WRK=$disksht&'\PROGRAMS\!Only_LiveDVD'
$EXE=@SystemDir&'\shellexecute.exe'
$ARG='/h '&$disksht&'\PROGRAMS\!Only_LiveDVD\Apache.cmd'
$DSC='������ ������� Apache2.2, ��� ������� ��� �� ���������� � "C:\AppServ".'
$ICO=$disksht&'\PROGRAMS\!Only_LiveDVD\Apache.ico'
a()
$NME='Internet Explorer'
$DIR=@ProgramsDir&'\!\��������'
$EXE=@WindowsDir&'\IEXPLORE.EXE'
$ARG='about:blank'
$DSC='������� ��� ������ � ��������, �������� ������� � HTML-���������.'
a()
$NME='Outpost Firewall'
$DIR=@ProgramsDir&'\!\��������'
$EXE='X:\PROGRAMS\Outpost\outpost.exe'
$DSC='����������, ������ �� ���������������� ������ �������� � ��������, ��� ������ ���������� ��� �������� ���������������� ������.'
a()
$NME='Arum Switcher'
$DIR=@ProgramsDir&'\!\����'
$EXE=$disksht&'\PROGRAMS\Arum Switcher\ArumSwitcher.exe'
$DSC='������ ������ ��� ����������� �������� ��������� ����������, Win + Ctrl'
$ICO=$disksht&'\PROGRAMS\Arum Switcher\Arum.dll'
a()
$NME='ASCII Art Studio'
$DIR=@ProgramsDir&'\!\����'
$EXE='X:\PROGRAMS\ASCII Art Studio\AsciiArtStudio.exe'
$DSC='��� ������ nfo, diz.'
a()
$NME='clcl (B)'
$DIR=@ProgramsDir&'\!\����'
$EXE=$disksht&'\PROGRAMS\clcl\StartCL.bat'
$DSC='���������� ������� ������, ����� Alt + C'
$ICO=$disksht&'\PROGRAMS\clcl\CLCL.exe'
a()
$NME='Office PlanMaker (Excel)'
$DIR=@ProgramsDir&'\!\����'
$EXE='X:\Programs\SoftMakerOffice2010\PlanMaker.exe'
$DSC='��������� ����� MS Office 2007, OpenOffice.'
a()
$NME='Foxit Reader'
$DIR=@ProgramsDir&'\!\����'
$EXE=$disksht&'\PROGRAMS\FoxitReader\foxitreader.exe'
$DSC='�������� *.pdf-������.'
a()
$NME='Kleptomania'
$DIR=@ProgramsDir&'\!\����'
$EXE=$disksht&'\PROGRAMS\Kleptomania\k-mania.exe'
$DSC='����������� ������ � ���������� ���� � ����� ������ � ������� � ��������� ��������.'
a()
$NME='Notepad++'
$DIR=@ProgramsDir&'\!\����'
$EXE=$disksht&'\PROGRAMS\notepad++\notepad++.exe'
$DSC='������ ��������, �������� ������� ������, �������, ��������� ��������� ��������� ����.'
a()
$NME='Socrat'
$DIR=@ProgramsDir&'\!\����'
$EXE=$disksht&'\PROGRAMS\Socrat\spv.exe'
$DSC='�����-������� ���������� ������.'
a()
$NME='TCode(wim)'
$DIR=@ProgramsDir&'\!\����'
$EXE=$disksht&'\PROGRAMS\TCode\tcode.wim'
$DSC='������������� ������ � ����������� ���.'
$ICO=$disksht&'\PROGRAMS\TCode\tc.ico'
a()
$NME='Office TextMaker (Word)'
$DIR=@ProgramsDir&'\!\����'
$EXE='X:\Programs\SoftMakerOffice2010\TextMaker.exe'
$DSC='��������� ����� MS Office 2007, OpenOffice.'
a()
$NME='�������'
$DIR=@ProgramsDir&'\!\����'
$EXE=@SystemDir&'\notepad.exe'
a()
$NME='CloneSpy'
$DIR=@ProgramsDir&'\!\������\��������'
$EXE=$disksht&'\PROGRAMS\CloneSpy\CloneSpy.exe'
$DSC='����� ���������� ������.'
$NMR=7
a()
$NME='Power Mixer'
$DIR=@ProgramsDir&'\!\������\��������'
$EXE=$disksht&'\PROGRAMS\Power Mixer\pwmixer.exe'
$DSC='����������� ����� ��������� Shift + ������� ����'
a()
$NME='Scanner'
$DIR=@ProgramsDir&'\!\������\��������'
$EXE=$disksht&'\PROGRAMS\Scanner\SCANNER.EXE'
$DSC='�������� ������ ������ ��� ������ ������ � ����� ���������� ����� �����.'
a()
$NME='TeraCopy2 - ��������'
$DIR=@ProgramsDir&'\!\������\��������'
$EXE=@SystemDir&'\SHELLEXECUTE.EXE'
$ARG='/h X:\Programs\TeraCopy2\TeraCopy2start.bat'
$ICO='X:\Programs\TeraCopy2\TeraCopy.exe'
$NMR=1
a()
$NME='TeraCopy2 - ���������'
$DIR=@ProgramsDir&'\!\������\��������'
$EXE=@SystemDir&'\SHELLEXECUTE.EXE'
$ARG='/h X:\Programs\TeraCopy2\TeraCopy2Del.bat'
$ICO='X:\Programs\TeraCopy2\TeraCopy.exe'
$NMR=2
a()
$NME='7-Zip'
$DIR=@ProgramsDir&'\!\������'
$EXE='X:\PROGRAMS\7-Zip\7zFM.exe'
a()
$NME='Driver Import V1.3'
$DIR=@ProgramsDir&'\!\������'
$EXE='X:\PROGRAMS\Driver Import\DrvImpe.exe'
$DSC='����� � ��������� ��������� �� Windows ��� ��������� ����� ���������.'
a()
$NME='gimagex'
$DIR=@ProgramsDir&'\!\������'
$EXE=$disksht&'\PROGRAMS\gimagex\gimagex.exe'
$DSC='��� ������ � wim-�������.'
a()
$NME='Media Player Classic'
$DIR=@ProgramsDir&'\!\������'
$EXE=$disksht&'\PROGRAMS\MPC\mplayerc.exe'
$DSC='����� �������������� ��� ������� ��� ������� �������.'
a()
$NME='MountStorPe'
$DIR=@ProgramsDir&'\!\������'
$EXE='X:\PROGRAMS\MountStorage\MountStorPe.exe'
$DSC='������������ ������ ������.'
a()
$NME='ResHacker'
$DIR=@ProgramsDir&'\!\������'
$EXE=$disksht&'\PROGRAMS\ResHacker\ResHacker.exe'
$DSC='�������� �������� EXE, DLL-������.'
a()
$NME='Search and Replace'
$DIR=@ProgramsDir&'\!\������'
$EXE=$disksht&'\PROGRAMS\SR\SR32.EXE'
$DSC='����� � ������ ������ � ������.'
a()
$NME='SmartDriverBackup'
$DIR=@ProgramsDir&'\!\������'
$EXE=$disksht&'\PROGRAMS\SmartDriverBackup\SmartDriverBackup.exe'
$DSC='��������� �������� �������� �� "�������" WindowsXP.'
a()
$NME='TotalCMD'
$DIR=@ProgramsDir&'\!\������'
$EXE='X:\PROGRAMS\TotalCMD\Totalcmd.exe'
a()
$NME='WinHex'
$DIR=@ProgramsDir&'\!\������'
$EXE=$disksht&'\PROGRAMS\WinHex\WinHex.exe'
$DSC='��������  � �������������� �������� ������.'
a()
$NME='WinImage'
$DIR=@ProgramsDir&'\!\������'
$EXE=$disksht&'\PROGRAMS\WinImage\winimage.exe'
$DSC='������� ����-����� ����������� ������.'
a()
$NME='WinRAR'
$DIR=@ProgramsDir&'\!\������'
$EXE='X:\PROGRAMS\WinRAR\WinRAR.exe'
a()
$NME='ttfttest'
$DIR=@ProgramsDir&'\!\����'
$EXE='X:\PROGRAMS\NMT\ttfttest.exe'
$DSC='���� ��������.'
a()
$NME='Ghost-explorer'
$DIR=@ProgramsDir&'\!\������� HDD'
$EXE=$disksht&'\PROGRAMS\Ghost32\Ghostexp.exe'
$DSC='�������� ������� ������� �����, � ������������ ���������� ������.'
a()
$NME='Acronis True Image 9.7'
$DIR=@ProgramsDir&'\!\������� HDD'
$EXE='X:\PROGRAMS\acronis\TRUEIMAGE\trueimage.exe'
$DSC='�������� ������� ������� �����.'
a()
$NME='������������ EXT2&3 ����'
$DIR=@ProgramsDir&'\!\������� HDD'
$EXE=@SystemDir&'\IFSDRIVES.CPL'
$DSC='������������ EXT2&3 ����, ��� ��������� ������ ������.'
$ICO=@SystemDir&'\shell32.dll'
$NMR=8
a()
; ���� (!) �������
$NME='����������'
$DIR=@ProgramsDir&'\!\������\�������'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\assotiations.au3'
$ICO=@SystemDir&'\shell33.dll'
$NMR=14
$DSC='������������� ���� ��������� � �������.'
a()
$NME='������ � ������'
$DIR=@ProgramsDir&'\!\������\�������'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\jumpreg.au3'
$ICO=@SystemDir&'\shell33.dll'
$NMR=16
$DSC='������ � ��������� ����� �������.'
a()
$NME='�������� �������'
$DIR=@ProgramsDir&'\!\������\�������'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\create_lnk.au3'
$ICO=@SystemDir&'\shell33.dll'
$NMR=13
$DSC='�������� � ������������� �������.'
a()
$NME='������������ ����������� WIM'
$DIR=@ProgramsDir&'\!\������\�������'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\repak.au3'
$ICO=@SystemDir&'\shell33.dll'
$NMR=15
$DSC='��������� �������� ���������� WinPe.wim � ��������� �����.'
a()
$NME='���������������� �����'
$DIR=@ProgramsDir&'\!\������\�������'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\user.au3'
$ICO=@SystemDir&'\shell32.dll'
$NMR=170
$DSC='������ ���������� � ������ ������������� WindowsXP � LiveCD.'
a()
$NME='���������� ������'
$DIR=@ProgramsDir&'\!\������\�������'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\hdd_off.au3'
$ICO=@SystemDir&'\shell32.dll'
$NMR=8
$DSC='���������� ������ ��� ������ �� ������� �� ����� ����������� � ���������.'
a()
$NME='������������� wim'
$DIR=@ProgramsDir&'\!\������\�������'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\wimoff.au3'
$ICO='X:\PROGRAMS\gimagex\gimagex.exe'
$DSC="��������� ������������� �� wim'�"
a()
$NME='������ SETUPLDR'
$DIR=@ProgramsDir&'\!\������\�������'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\Patch_SETUPLDR.au3'
$ICO=@SystemDir&'\shell33.dll'
$DSC="������ SETUPLDR.BIN ��� ����� �������� i386, minint"
$NMR=8
a()
$NME='������������ reg-����'
$DIR=@ProgramsDir&'\!\������\�������'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\\reg-backup.au3'
$DSC='������������ reg-���� �� �������� �������'
$ICO=@SystemDir&'\shell33.dll'
$NMR=16
a()
$NME='������ ���������'
$DIR=@ProgramsDir&'\!\������\�������'
$WRK='X:\PROGRAMS\Update_Utilite\SaveFolders'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\SaveFolders\SaveFolders.au3'
$DSC='���������� ������� ���������� ��������� � ������'
$ICO=@SystemDir&'\shell32.dll'
$NMR=110
a()
$NME='���� (������, ����, cpu)'
$DIR=@ProgramsDir&'\!\������\�������'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\info.au3'
$ICO=@SystemDir&'\shell32.dll'
$DSC="�������������� ������ ��� ���������� � ������ Everest, SIW"
$NMR=12
a()
; ����
$NME='�1�  ��������� ������� �����������...'
$DIR=@ProgramsDir&'\����'
$EXE=@SystemDir&'\RUN-NETRUN.CMD'
$ICO=@SystemDir&'\rasphone.exe'
a()
$NME='�2�  ������ ����� �����������...'
$DIR=@ProgramsDir&'\����'
$EXE=@SystemDir&'\RUN-NETNCW.CMD'
$ICO=@SystemDir&'\netshell.dll'
$NMR=3
a()
$NME='�3�  ���������� ... ��������� ...'
$DIR=@ProgramsDir&'\����'
$EXE=@SystemDir&'\RUN-NETRAS.CMD'
$ICO=@SystemDir&'\netshell.dll'
$NMR=101
a()
$NME='�4�  H�������� ������� �����������...'
$DIR=@ProgramsDir&'\����'
$EXE=@SystemDir&'\RUN-NETCFG.CMD'
$ICO=@SystemDir&'\shell32.dll'
$NMR=18
a()
; SendTo
$NME='ArtIcons Pro'
$DIR=$SendTo&'\�������'
$EXE=$disksht&'\PROGRAMS\ArtIcons Pro\ARTICONS.exe'
$DSC='�������� ������.'
a()
$NME='Paint'
$DIR=$SendTo&'\�������'
$EXE=@SystemDir&'\mspaint.exe'
a()
$NME='WinDjView'
$DIR=$SendTo&'\�������'
$EXE='X:\PROGRAMS\WinDjView\WinDjView.exe'
a()
$NME='Imagine'
$DIR=$SendTo&'\�������'
$EXE=$disksht&'\PROGRAMS\Imagine\Imagine.exe'
$DSC='����������� �������.'
a()
$NME='Media Player Classic'
$DIR=$SendTo&'\������'
$EXE=$disksht&'\PROGRAMS\MPC\mplayerc.exe'
$DSC='����� �������������� ��� ������� ��� ������� �������.'
a()
$NME='ResHacker'
$DIR=$SendTo&'\������'
$EXE=$disksht&'\PROGRAMS\ResHacker\ResHacker.exe'
$DSC='�������� �������� EXE, DLL-������.'
a()
$NME='UltraISO'
$DIR=$SendTo&'\������'
$EXE=$disksht&'\PROGRAMS\UltraISO\UltraISO.exe'
$DSC='�������� ������� CD,DVD-������, ����������� ����������� ��������.'
a()
$NME='WinHex'
$DIR=$SendTo&'\������'
$EXE=$disksht&'\PROGRAMS\WinHex\WinHex.exe'
$DSC='��������  � �������������� �������� ������.'
a()
$NME='������������ � ImDisk'
$DIR=$SendTo&'\������'
$EXE=@SystemDir&'\shellexecute.exe'
$ARG='/h imdisk.bat'
$ICO=@SystemDir&'\imdisk.cpl'
a()
; Desktop - ������� ����
$NME='!���������'
$DIR=$Desktop
$EXE=@WindowsDir&'\explorer.exe'
$ARG='/e, X:\'
$ICO=@SystemDir&'\shell32.dll'
$NMR=170
a()
$NME='��������'
$DIR=$Desktop
$EXE=@SystemDir&'\shutdown.exe'
$ARG='/r'
$ICO=@SystemDir&'\shutdown.exe'
$NMR=2
a()
$NME='����'
$DIR=$Desktop
$EXE=@SystemDir&'\shutdown.exe'
$ARG='/s'
a()
; ���� ����
$NME='������� ���������'
$DIR=@AppDataDir
$EXE=@SystemDir&'\SHELLEXECUTE.EXE'
$ARG='/h '&$disksht&'\PROGRAMS\Update_Utilite\Start_Offise.bat'
$DSC='������ �������� ��� ������ � �������.)'
$ICO=@SystemDir&'\shell33.dll'
$NMR=7
a()
$NME='������� LiveCD'
$DIR=@AppDataDir
$EXE='X:\PROGRAMS\Update_Utilite\WinXPE_help\htmlautorun.exe'
a()
$NME='��������� LiveCD'
$DIR=@AppDataDir
$WRK='X:\Programs\Update_Utilite\instLiveCD'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\instLiveCD\instLiveCD.au3'
$DSC='� ������� ��������� ���� Boot.ini ��� Grub.'
$ICO='X:\PROGRAMS\Update_Utilite\instLiveCD\instLiveCD.ico'
a()

Exit

Func a()
If FileExists ($EXE) Then
	If $WRK='' Then $WRK=StringRegExpReplace($EXE, "(^.*)\\(?:.*)$", "\1")
	If NOT FileExists($DIR) Then DirCreate($DIR)
	FileCreateShortcut($EXE,$DIR&'\'&$NME&'.lnk',$WRK,$ARG,$DSC,$ICO,'',$NMR)
Endif
$NME=''
$DIR=''
$LNK=''
$WRK=''
$EXE=''
$ARG=''
$DSC=''
$ICO=''
$NMR=''
EndFunc