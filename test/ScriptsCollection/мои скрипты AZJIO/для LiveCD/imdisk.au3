
;  @AZJIO  2010.09.16
#NoTrayIcon ;скрыть в системной панели индикатор AutoIt

; начало создания окна, вкладок, кнопок.
GUICreate("Управление imdisk",328,233) ; размер окна
GUISetBkColor (0xF9F9F9)
$StatusBar = GUICtrlCreateLabel('Строка состояния			AZJIO 2010.09.16', 5, 233-20, 320, 20)


GUICtrlCreateGroup('', 3, -2, 323, 156)
$Check1=GUICtrlCreateRadio("Увеличить диск на", 10,10,120,22)
GUICtrlSetTip(-1, "Увеличить диск B: на"&@CRLF&"указанный размер.")
$combo_imdram1=GUICtrlCreateCombo ("", 140,10,60,18)
GUICtrlSetData(-1,'30|100|300|600|900|1200', '300')
GUICtrlCreateLabel ("Мб", 205,14,20,22)

$bykvadicka80=GUICtrlCreateCombo ("", 260, 10,60,18)
_FindDrive()

$bykvadicka080=GUICtrlRead ($bykvadicka80)
If $bykvadicka080 <> '' Then
	GUICtrlSetData($StatusBar, 'Диск '&$bykvadicka080&' = '&Ceiling(DriveSpaceTotal($bykvadicka080&"\" ))&' Мб			AZJIO 2010.09.16')
EndIf

$free=GUICtrlCreateCombo ("", 260, 70,60,18)
_freeDrive()

$Check2=GUICtrlCreateRadio("Создать диск", 10, 40,110,22)
GUICtrlSetTip(-1, "Создать виртуальный диск в памяти"&@CRLF&"указанного размера (NTFS).")
$combo_imdram2=GUICtrlCreateCombo ("", 140,40,60,18)
GUICtrlSetData(-1,'30|100|300|600|900|1200', '300')
GUICtrlCreateLabel ("Мб", 205,44,20,22)

$Check3=GUICtrlCreateRadio("Создать диск", 10,70,110,22)
GUICtrlSetTip(-1, "Создать виртуальный диск в памяти"&@CRLF&"указанного в процентах размера"&@CRLF&"от свободной памяти, (NTFS).")
$combo_imdram3=GUICtrlCreateCombo ("", 140,70,60,18)
GUICtrlSetData(-1,'10|20|30|40|50|60|70|80|90', '30')
GUICtrlCreateLabel ("%", 205,74,20,22)

$Check4=GUICtrlCreateRadio("Создать диск (-)", 10,100,110,22)
GUICtrlSetTip(-1, "Создать виртуальный диск в памяти"&@CRLF&"оставив свободной памяти указанный размер, (NTFS).")
$combo_imdram4=GUICtrlCreateCombo ("", 140,100,60,18)
GUICtrlSetData(-1,'30|100|300|600|900|1200', '300')
GUICtrlCreateLabel ("Мб", 205,104,20,22)

$ChIMG=GUICtrlCreateRadio("Смонтировать образ IMG", 10,130,170,22)
$ChRW=GUICtrlCreateCheckbox("RW", 180,130,40,22)
GUICtrlSetTip(-1, "Смонтировать образ IMG"&@CRLF&"чтение/запись.")

$start0=GUICtrlCreateButton ("Выполнить", 227, 120, 93, 29)
GUICtrlSetTip(-1, "Выполнить отмеченные опреации")

GUICtrlCreateGroup('Диалоги', 7, 154, 208, 53)
$start12=GUICtrlCreateButton ("Монтировать", 16, 174, 93, 29)
GUICtrlSetTip(-1, "Старт диалога"&@CRLF&"монтирования образа.")
$start11=GUICtrlCreateButton ("imdisk", 115, 174, 93, 29)
GUICtrlSetTip(-1, "Старт диалога управления"&@CRLF&"смонтированными дисками.")

GUISetState ()

While 1
	$msg = GUIGetMsg()
	Select
		Case $msg = $start11
		   Run(@Comspec & ' /C '&@SystemDir&'\imdisk.cpl', '', @SW_HIDE)
		Case $msg = $start12
		   Run(@Comspec & ' /C '&@SystemDir&'\rundll32.exe imdisk.cpl,RunDLL_MountFile', '', @SW_HIDE)
		   
		Case $msg = $bykvadicka80
			$bykvadicka080=GUICtrlRead ($bykvadicka80)
			GUICtrlSetData($StatusBar, 'Диск '&$bykvadicka080&' = '&Ceiling(DriveSpaceTotal($bykvadicka080&"\" ))&' Мб')
		   
		Case $msg = $start0
			GUICtrlSetData($StatusBar, '')
			$bykvadicka080=StringMid(GUICtrlRead ($bykvadicka80), 1,1)
			$free0=GUICtrlRead ($free)
			$list=''
			If $free0 = 'auto' Then
				$free0 = '#'
				$DrivesArr = DriveGetDrive( "all" )
				For $i=1 To $DrivesArr[0]
				   $list&=$DrivesArr[$i]
				Next
			 EndIf
			If GUICtrlRead ($Check1) = 1 Then
				$Size080=DriveSpaceTotal( $bykvadicka080&":\" )
			   RunWait ( @Comspec & ' /C '&@SystemDir&'\imdisk.exe -e -s '&GUICtrlRead ($combo_imdram1)&'M -m '&$bykvadicka080&':', '', @SW_HIDE )
				$Size081=DriveSpaceTotal( $bykvadicka080&":\" )
				If $Size081>$Size080 Then GUICtrlSetData($StatusBar, 'Диск увеличился с '&Ceiling($Size080)&' до '&Ceiling($Size081))
			 EndIf
			If GUICtrlRead ($Check2) = 1 Then
			   RunWait ( @Comspec & ' /C '&@SystemDir&'\imdisk.exe -a -s '&GUICtrlRead ($combo_imdram2)&'M -m '&$free0&': -p "/fs:ntfs /y /q /v:imdisk', '', @SW_HIDE )
				_sb($free0,$list)
			 EndIf
			If GUICtrlRead ($Check3) = 1 Then
			   RunWait ( @Comspec & ' /C '&@SystemDir&'\imdisk.exe -a -s '&GUICtrlRead ($combo_imdram3)&'% -m '&$free0&': -p "/fs:ntfs /y /q /v:imdisk', '', @SW_HIDE )
				_sb($free0,$list)
			 EndIf
			If GUICtrlRead ($Check4) = 1 Then
			   RunWait ( @Comspec & ' /C '&@SystemDir&'\imdisk.exe -a -s -'&GUICtrlRead ($combo_imdram4)&'M -m '&$free0&': -p "/fs:ntfs /y /q /v:imdisk', '', @SW_HIDE )
				_sb($free0,$list)
			 EndIf
			If GUICtrlRead ($ChIMG) = 1 Then
				$TmpIMGFile = FileOpenDialog("Выбор iso-файла.", @WorkingDir & "", "Образ диска (*.img)", 1 + 4 )
				If @error Then ContinueLoop
				If GUICtrlRead ($ChRW) = 1 Then
					RunWait ( @Comspec & ' /C '&@SystemDir&'\imdisk.exe  -a -t file -m '&$free0&': -f '&$TmpIMGFile, '', @SW_HIDE )
				Else
					RunWait ( @Comspec & ' /C '&@SystemDir&'\imdisk.exe  -a -t file -o ro -m '&$free0&': -f '&$TmpIMGFile, '', @SW_HIDE )
				EndIf
				_sb($free0,$list)
			 EndIf
			 _FindDrive()
			 _freeDrive()
		Case $msg = -3
			ExitLoop
	EndSelect
WEnd

Func _sb($free0,$list)
	If $free0 = '#' Then
		$DrivesArr = DriveGetDrive( "all" )
		For $i=1 To $DrivesArr[0]
		   If Not StringInStr($list, $DrivesArr[$i]) Then $free0=StringUpper(StringTrimRight($DrivesArr[$i],1))
		Next
	EndIf
    If FileExists($free0&':\') Then GUICtrlSetData($StatusBar, 'Диск '&$free0&': , размером '&Ceiling(DriveSpaceTotal($free0&":\" ))&' Мб создан')
EndFunc

Func _FindDrive()
	$DrivesArr = DriveGetDrive( "all" )
	$list=''
	$dr=''
	For $i=1 To $DrivesArr[0]
		If DriveGetType( $DrivesArr[$i]&'\' )='Fixed' And $DrivesArr[$i]<>'X:' And DriveSpaceTotal( $DrivesArr[$i]&"\" )<4096 Then
			Assign('list', $list&'|'&StringUpper($DrivesArr[$i]))
			If $dr='' Then $dr=$i
		EndIf
	Next
	$bykvadicka080=GUICtrlRead ($bykvadicka80)
	If StringInStr($list, $bykvadicka080) Then
		$SetBykva=$bykvadicka080
	Else
		$SetBykva=StringUpper($DrivesArr[$dr])
	EndIf
	
	GUICtrlSendMsg($bykvadicka80, 0x14B, 0, 0)
	If $list='' Then
		GUICtrlSetState($bykvadicka80,  128)
		GUICtrlSetState($Check1,  128)
		GUICtrlSetState($combo_imdram1,  128)
	Else
		StringTrimLeft($list,1)
		GUICtrlSetData($bykvadicka80,$list,$SetBykva)
		GUICtrlSetState($bykvadicka80,  64)
		GUICtrlSetState($Check1,  64)
		GUICtrlSetState($combo_imdram1,  64)
	EndIf
EndFunc

Func _freeDrive()
	$DrivesArr = DriveGetDrive( "all" )
	$list=''
	For $i=1 To $DrivesArr[0]
	   $list&=$DrivesArr[$i]
	Next
	$aList=StringSplit('A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z', ',')
	$listnew='auto'
	For $i=1 To $aList[0]
		If Not StringInStr($list, $aList[$i]) Then $listnew&='|'&$aList[$i]
	Next
	GUICtrlSendMsg($free, 0x14B, 0, 0)
	GUICtrlSetData($free,$listnew,'auto')
EndFunc