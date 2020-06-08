#NoTrayIcon ;скрыть в системной панели индикатор AutoIt

; начало создани€ окна, вкладок, кнопок.
GUICreate("»нфа о дисках",230,192) ; размер окна
;GUICtrlCreateTab (0,0, 230,192) ; размер вкладки
;GUICtrlCreateTabitem ("") ; им€ вкладки

$bykvadicka80=GUICtrlCreateCombo ("", 10,8,90,18)
$DrivesArr = DriveGetDrive( "all" )
$list=''
For $i=1 To $DrivesArr[0]
   $DrTp = DriveGetType( $DrivesArr[$i]&'\' )
	If $DrTp='Removable' Then $DrTp='Rem'
	If $DrivesArr[$i]<>'A:' Then Assign('list', $list&'|'&StringUpper($DrivesArr[$i])&' ('&$DrTp&')')
	If $DrivesArr[$i]='c:' Then $dr=$i
Next
GUICtrlSetData($bykvadicka80,$list,StringUpper($DrivesArr[$dr])&' ('&DriveGetType( $DrivesArr[$dr]&'\' )&')')

GUICtrlCreateLabel (" FS:", 10,40,100,18)
GUICtrlCreateLabel (" метка тома:", 10,60,100,18)
GUICtrlCreateLabel (" серийный номер:", 10,80,100,18)
GUICtrlCreateLabel (" тип:", 10,100,100,18)
GUICtrlCreateLabel (" размер:", 10,120,100,18)
GUICtrlCreateLabel (" свободно:", 10,140,100,18)
GUICtrlCreateLabel (" статус:", 10,160,100,18)


$Label1=GUICtrlCreateLabel ("", 115,40,100,18)
$Label2=GUICtrlCreateLabel ("", 115,60,100,18)
$Label3=GUICtrlCreateLabel ("", 115,80,100,18)
$Label4=GUICtrlCreateLabel ("", 115,100,100,18)
$Label5=GUICtrlCreateLabel ("", 115,120,100,18)
$Label6=GUICtrlCreateLabel ("", 115,140,100,18)
$Label7=GUICtrlCreateLabel ("", 115,160,100,18)

_info() 

GUISetState ()

While 1
	$msg = GUIGetMsg()
	Select
        Case $msg = $bykvadicka80
		   _info() 
		Case $msg = -3
			ExitLoop
	EndSelect
WEnd


; функци€ чтени€ информации о выбранном диске
Func _info() 
$bykvadicka081=StringMid(GUICtrlRead ($bykvadicka80), 1,1)
GUICtrlSetData($Label1,DriveGetFileSystem( $bykvadicka081&":\" ))
GUICtrlSetData($Label2,DriveGetLabel( $bykvadicka081&":\" ))
GUICtrlSetData($Label3,DriveGetSerial( $bykvadicka081&":\" ))
GUICtrlSetData($Label4,DriveGetType( $bykvadicka081&":\" ))
GUICtrlSetData($Label5,Round(DriveSpaceTotal( $bykvadicka081&":\" )/1024,1)&' √б')
GUICtrlSetData($Label6,Round(DriveSpaceFree( $bykvadicka081&":\" )/1024,1)&' √б')
GUICtrlSetData($Label7,DriveStatus( $bykvadicka081&":\" ))
EndFunc   ;==>_info