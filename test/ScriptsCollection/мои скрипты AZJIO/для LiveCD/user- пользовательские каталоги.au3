;  @AZJIO
#NoTrayIcon ;скрыть в системной панели индикатор AutoIt

#include <File.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>


Global $aFolderDAS, $bykvadicka081, $Personal00, $Desktop00, $Favorites00, $AppData00, $Cache00, $Cookies00, $temp00, $locapl00, $Winds00, $Sys3200, $Driv00, $inf00, $Res00, $Wall100, $Wall200, $DAS00
$cveusf='HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders'
; начало создания окна, вкладок, кнопок.
GUICreate("Пользовательские каталоги",370,360) ; размер окна
If Not @compiled Then GUISetIcon('shell32.dll', -171)

$tab=GUICtrlCreateTab (0,2, 370,346) ; размер вкладки
$tab3=GUICtrlCreateTabitem ("User") ; имя вкладки

$Label80=GUICtrlCreateLabel ("Диск:", 10,43,80,20)
$bykvadicka80=GUICtrlCreateCombo ("", 40,40,93,18)
$DrivesArr = DriveGetDrive( "all" )
$list=''
$sch=''
For $i=1 To $DrivesArr[0]
   $DrTp = DriveGetType( $DrivesArr[$i]&'\' )
	If $DrTp='Removable' Then $DrTp='Rem'
	If $DrivesArr[$i]<>'A:' And $DrTp<>'CDROM' And FileExists($DrivesArr[$i]&'\Documents and Settings') Then
	Assign('list', $list&'|'&StringUpper($DrivesArr[$i])&' ('&$DrTp&')')
		If  $sch<>'1' Then
			$dr=$i
			$sch='1'
		Endif
	Endif
Next
;$dr=2
GUICtrlSetData($bykvadicka80,$list,StringUpper($DrivesArr[$dr])&' ('&DriveGetType( $DrivesArr[$dr]&'\' )&')')

$Label81u=GUICtrlCreateLabel ("Пользователь:", 150,43,80,20)
$Label8u=GUICtrlCreateLabel ("Текущий", 140,68,140,30)
GUICtrlSetColor(-1,0xff0000)    ; Red
GUICtrlSetFont ($Label8u,15)

$note=GUICtrlCreateButton ("пути", 20,71,40,22)
GUICtrlSetTip(-1, "Показать пользовательские пути,"&@CRLF&"в случае если дискам присвоены"&@CRLF&"не соответствующие той системе буквы"&@CRLF&"и пути не существуют")

$copyfav=GUICtrlCreateButton ("копир", 310,71,40,22)
GUICtrlSetTip(-1, 'Копировать "Избранное" выбранного пользователя'&@CRLF&'к себе в текущий (для LiveCD)')


$username=GUICtrlCreateCombo ("", 230,40,120,18)
GUICtrlSetTip($username, "Применить каталоги"&@CRLF&"выбранного пользователя")
bykvadicka()

$Personal=GUICtrlCreateButton ("Мои документы", 20,100,150,24)
$Desktop=GUICtrlCreateButton ("Рабочий стол", 20,130,150,24)
$Favorites=GUICtrlCreateButton ("Избранное", 20,160,150,24)
$AppData=GUICtrlCreateButton ("Application Data", 20,190,150,24)
$locapl=GUICtrlCreateButton ("Loc. Application Data", 20,220,150,24)
$temp=GUICtrlCreateButton ("Temp", 20,250,150,24)
$Cookies=GUICtrlCreateButton ("Cookies", 20,280,150,24)
$Cache=GUICtrlCreateButton ("Temporary Internet Files", 20,310,150,24)
;$=GUICtrlCreateButton ("", 20,100,150,24)

$Winds=GUICtrlCreateButton ("Windows", 200,100,150,24)
$Sys32=GUICtrlCreateButton ("System32", 200,130,150,24)
$Driv=GUICtrlCreateButton ("Drivers", 200,160,150,24)
$inf=GUICtrlCreateButton ("INF", 200,190,150,24)
$Res=GUICtrlCreateButton ("Resources", 200,220,150,24)
$Wall1=GUICtrlCreateButton ("Wallpaper1", 200,250,150,24)
$Wall2=GUICtrlCreateButton ("Wallpaper2", 200,280,150,24)
$DAS=GUICtrlCreateButton ("UserProfile", 200,310,150,24)
;$ee=GUICtrlCreateButton ("DAS", 200,100,150,24)
;$=GUICtrlCreateButton ("", 280,100,120,24)



$Label000=GUICtrlCreateLabel ('Строка состояния. Установлены каталоги текущего пользователя.', 10,345,488,20)


$tab4=GUICtrlCreateTabitem ("?") ; имя вкладки
GUICtrlCreateLabel (' Применяется в LiveCD, для перехода в папки пользователей лежачей WindowsXP. А также скопировать "Избранное" интернет-эксплорера.', 15,40,350,60)

GUICtrlCreateLabel ("Автор: AZJIO 5.02.2010", 240,320,137,22)

GUICtrlCreateTabitem ("")   ; конец вкладок

GUISetState ()

	While 1
		$msg = GUIGetMsg()
		Select
            Case $msg = $bykvadicka80
			   bykvadicka()
            Case $msg = $username
			   $username0 = GUICtrlRead ($username)
			   If $username0 = 'текущий' Then
				  RunWait ( @Comspec & ' /C REG UNLOAD HKLM\NTUSER', '', @SW_HIDE )
				  $cveusf='HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders'
				  $Personal00 = @MyDocumentsDir
				  $Desktop00 = @DesktopDir
				  $Favorites00 = @FavoritesDir
				  $AppData00 = @AppDataDir
				  $Cache00 = RegRead($cveusf, "Cache")
				  If StringRegExp($Cache00, "%USERPROFILE%", 0)<>0 Then $Cache00 = @UserProfileDir&'\Temporary Internet Files'
				  $Cookies00 = RegRead($cveusf, "Cookies")
				  If StringRegExp($Cookies00, "%USERPROFILE%", 0)<>0 Then $Cookies00 = @UserProfileDir&'\Cookies'
				  $temp00 = @TempDir
				  $locapl00= @UserProfileDir&'\Local Settings\Application Data'
				  $Winds00=@WindowsDir
				  $Sys3200=@SystemDir
				  $Driv00=@SystemDir&'\drivers'
				  $inf00=@WindowsDir&'\inf'
				  $Res00=@WindowsDir&'\Resources'
				  $Wall100=@WindowsDir&'\Web\Wallpaper'
				  $Wall200=@UserProfileDir&'\Local Settings\Application Data\Microsoft'
				  $DAS00=@UserProfileDir
				  GUICtrlSetData($Label000, 'Установлены каталоги текущего пользователя')
				  GUICtrlSetData($Label8u, $username0)
			   Else
				  If FileExists($bykvadicka081 & '\Documents and Settings\'&$username0&'\NTUSER.DAT') Then
				  RunWait ( @Comspec & ' /C REG UNLOAD HKLM\NTUSER', '', @SW_HIDE )
				  RunWait ( @Comspec&' /C REG LOAD HKLM\NTUSER "'&$bykvadicka081&'\Documents and Settings\'&$username0&'\NTUSER.DAT"', '', @SW_HIDE )
				  $cveusf='HKEY_LOCAL_MACHINE\NTUSER\Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders'
				  $Personal00 = RegRead($cveusf, "Personal")
				  $Personal00 = StringRegExpReplace($Personal00, "%USERPROFILE%", $bykvadicka081 & '\\Documents and Settings\\'&$username0)
				  $Desktop00 = RegRead($cveusf, "Desktop")
				  $Desktop00 = StringRegExpReplace($Desktop00, "%USERPROFILE%", $bykvadicka081 & '\\Documents and Settings\\'&$username0)
				  $Favorites00 = RegRead($cveusf, "Favorites")
				  $Favorites00 = StringRegExpReplace($Favorites00, "%USERPROFILE%", $bykvadicka081 & '\\Documents and Settings\\'&$username0)
				  $AppData00 = RegRead($cveusf, "AppData")
				  $AppData00 = StringRegExpReplace($AppData00, "%USERPROFILE%", $bykvadicka081 & '\\Documents and Settings\\'&$username0)
				  $Cache00 = RegRead($cveusf, "Cache")
				  $Cache00 = StringRegExpReplace($Cache00, "%USERPROFILE%", $bykvadicka081 & '\\Documents and Settings\\'&$username0)
				  $Cookies00 = RegRead($cveusf, "Cookies")
				  $Cookies00 = StringRegExpReplace($Cookies00, "%USERPROFILE%", $bykvadicka081 & '\\Documents and Settings\\'&$username0)
				  $temp00 = RegRead('HKEY_LOCAL_MACHINE\NTUSER\Environment', "TEMP")
				  $temp00 = StringRegExpReplace($temp00, "%USERPROFILE%", $bykvadicka081 & '\\Documents and Settings\\'&$username0)
				  $locapl00= RegRead($cveusf, "Local AppData")
				  $locapl00 = StringRegExpReplace($locapl00, "%USERPROFILE%", $bykvadicka081 & '\\Documents and Settings\\'&$username0)
				  $Winds00=$bykvadicka081 & '\WINDOWS'
				  $Sys3200=$bykvadicka081 & '\WINDOWS\system32'
				  $Driv00=$bykvadicka081 & '\WINDOWS\system32\drivers'
				  $inf00=$bykvadicka081 & '\WINDOWS\inf'
				  $Res00=$bykvadicka081 & '\WINDOWS\Resources'
				  $Wall100=$bykvadicka081 & '\WINDOWS\Web\Wallpaper'
				  $Wall200=$bykvadicka081 & '\Documents and Settings\'&$username0&'\Local Settings\Application Data\Microsoft'
				  $DAS00=$bykvadicka081 & '\Documents and Settings\'&$username0
				  GUICtrlSetData($Label000, 'Установлены каталоги пользователя '&$username0)
				  GUICtrlSetData($Label8u, $username0)
				  Else
				  MsgBox(0, "Мелкая ошибка", 'Такого пользователя не существует')
				  EndIf
			   EndIf
				  RunWait ( @Comspec & ' /C REG UNLOAD HKLM\NTUSER', '', @SW_HIDE )
				  
            Case $msg = $copyfav
				If FileExists($Favorites00) Then DirCopy($Favorites00, @FavoritesDir,1)
            Case $msg = $note
			   $filePath = FileOpen(@TempDir&'\user_path.txt', 2)
			   FileWrite($filePath, $Personal00&@CRLF&$Desktop00&@CRLF&$Favorites00&@CRLF&$AppData00&@CRLF&$Cache00&@CRLF&$Cookies00&@CRLF&$temp00&@CRLF&$locapl00&@CRLF&$Winds00&@CRLF&$Sys3200&@CRLF&$Driv00&@CRLF&$inf00&@CRLF&$Res00&@CRLF&$Wall100&@CRLF&$Wall200&@CRLF&$DAS00)
			   FileClose($filePath)
			   Run('Notepad.exe '&@TempDir&'\user_path.txt')
            Case $msg = $Personal
			   Run('Explorer.exe '&$Personal00)
            Case $msg = $Desktop
			   Run('Explorer.exe '&$Desktop00)
            Case $msg = $Favorites
			   Run('Explorer.exe '&$Favorites00)
            Case $msg = $AppData
			   Run('Explorer.exe '&$AppData00)
            Case $msg = $Cache
			   Run('Explorer.exe '&$Cache00)
            Case $msg = $Cookies
			   Run('Explorer.exe '&$Cookies00)
            Case $msg = $temp
			   Run('Explorer.exe '&$temp00)
            Case $msg = $locapl
			   Run('Explorer.exe '&$locapl00)
            Case $msg = $Winds
			   Run('Explorer.exe '&$Winds00)
            Case $msg = $Sys32
			   Run('Explorer.exe '&$Sys3200)
            Case $msg = $Driv
			   Run('Explorer.exe '&$Driv00)
            Case $msg = $inf
			   Run('Explorer.exe '&$inf00)
            Case $msg = $Res
			   Run('Explorer.exe '&$Res00)
            Case $msg = $Wall1
			   Run('Explorer.exe '&$Wall100)
            Case $msg = $Wall2
			   Run('Explorer.exe '&$Wall200)
            Case $msg = $DAS
			   Run('Explorer.exe '&$DAS00)
			Case $msg = -3
				ExitLoop
		EndSelect
	WEnd




;$iMode <= 0 -> Folders + files
;$iMode = 1 -> Files only
;$iMode = 2 -> Folders only
Func _FileListToArrayEx($sPath, $sMask="*", $iMode=0, $iLevel=2)
	If Not StringInStr(FileGetAttrib($sPath), "D") Then Return SetError(1, 0, 0)
	
	$sPath = StringRegExpReplace($sPath, "\\+$", "")
	$sMask = "(?i)" & StringReplace(StringReplace($sMask, ".", "\."), "*", ".*")
	
	StringReplace($sPath, "\", "")
	Local $iLevel_Slashes = @extended + 1
	
	Local $aPathesArr[2] = [1, $sPath]
	Local $hSearch, $sFindNext, $i, $iIsDir
	
	While $i < $aPathesArr[0]
		$i += 1
		
		$hSearch = FileFindFirstFile($aPathesArr[$i] & "\*")
		If $hSearch = -1 Then ContinueLoop
		
		While 1
			$sFindNext = FileFindNextFile($hSearch)
			If @error Then ExitLoop
			
			$iIsDir = StringInStr(FileGetAttrib($aPathesArr[$i] & "\" & $sFindNext), "D")
			
			If $iMode < 2 Or ($iMode = 2 And $iIsDir) Then
				If Not $iIsDir And Not StringRegExp($sFindNext, $sMask) Then ContinueLoop
				
				$aPathesArr[0] += 1
				ReDim $aPathesArr[$aPathesArr[0]+1]
				
				$aPathesArr[$aPathesArr[0]] = $aPathesArr[$i] & "\" & $sFindNext
			EndIf
		WEnd
		
		FileClose($hSearch)
		
		StringReplace($aPathesArr[$aPathesArr[0]], "\", "")
		If @extended - $iLevel_Slashes = $iLevel Then ExitLoop
	Wend
	
	If $iMode = 1 Then
		Local $aTmp_Arr = $aPathesArr
		Local $iTmp_Count = 0
		
		For $i = 1 To $aPathesArr[0]
			If StringInStr(FileGetAttrib($aPathesArr[$i]), "D") Then ContinueLoop
			
			$iTmp_Count += 1
			$aTmp_Arr[$iTmp_Count] = $aPathesArr[$i]
		Next
		
		$aTmp_Arr[0] = $iTmp_Count
		ReDim $aTmp_Arr[$iTmp_Count+1]
		
		$aPathesArr = $aTmp_Arr
	EndIf
	
	Return $aPathesArr
EndFunc


Func bykvadicka()
$bykvadicka081=StringMid(GUICtrlRead ($bykvadicka80), 1,2)
$aFolderDAS = _FileListToArrayEx($bykvadicka081 & '\Documents and Settings', "", 2, 0)

$x1='-'
$x2='-'
$x3='-'
$x4='-'
$x5='-'

$z=1
For $i=2 To $aFolderDAS[0]
	$x=$i-$z
   $aNameUser=StringRegExp($aFolderDAS[$i], "(^.*)\\(.*)$", 3)
	If StringRegExp($aNameUser[1], "All Users|Default User|LocalService|NetworkService", 0)=0 and FileExists($bykvadicka081 & '\Documents and Settings\'&$aNameUser[1]&'\NTUSER.DAT') Then
	   Assign('x' & $x, $aNameUser[1])
	else
	   $z+=1
	EndIf
Next
GUICtrlSendMsg($username, 0x14B, 0, 0)
GUICtrlSetData($username,'текущий|'&$x1&'|'&$x2&'|'&$x3&'|'&$x4&'|'&$x5, 'текущий')

$Personal00 = @MyDocumentsDir
$Desktop00 = @DesktopDir
$Favorites00 = @FavoritesDir
$AppData00 = @AppDataDir
$Cache00 = RegRead($cveusf, "Cache")
If StringRegExp($Cache00, "%USERPROFILE%", 0)<>0 Then $Cache00 = @UserProfileDir&'\Temporary Internet Files'
$Cookies00 = RegRead($cveusf, "Cookies")
If StringRegExp($Cookies00, "%USERPROFILE%", 0)<>0 Then $Cookies00 = @UserProfileDir&'\Cookies'
$temp00 = @TempDir
$locapl00= @UserProfileDir&'\Local Settings\Application Data'
$Winds00=@WindowsDir
$Sys3200=@SystemDir
$Driv00=@SystemDir&'\drivers'
$inf00=@WindowsDir&'\inf'
$Res00=@WindowsDir&'\Resources'
$Wall100=@WindowsDir&'\Web\Wallpaper'
$Wall200=@UserProfileDir&'\Local Settings\Application Data\Microsoft'
$DAS00=@UserProfileDir
GUICtrlSetData($Label8u, 'текущий')
EndFunc