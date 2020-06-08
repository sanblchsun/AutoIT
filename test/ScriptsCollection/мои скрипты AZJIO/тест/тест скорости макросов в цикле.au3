


$timer = TimerInit()
For $i = 1 to 100*48
$h='32451352834u695832y4569y324kdfjnbvk. dnfb.vkjdanf.jnadffadbgfjyhgjhglkjdfgojsderogu8475t245ytrtegjnyhgfidaslgdsfhsldofjgoidasfgadfuidhasfigusdflg'
Next
MsgBox(0,"¬рем€ выполнени€", 'ќбновление переменной 4800 раз выполнено за '&Round(TimerDiff($timer) / 1000, 2) & ' сек')

$timer = TimerInit()

For $i = 1 to 100
$h=@DesktopWidth
$h=@DesktopHeight
$h=@ScriptDir
$h=@ScriptFullPath
$h=@AutoItExe
$h=@AutoItVersion
$h=@AppDataCommonDir
$h=@DesktopCommonDir
$h=@DocumentsCommonDir
$h=@FavoritesCommonDir
$h=@StartMenuCommonDir
$h=@StartupCommonDir
$h=@AppDataDir
$h=@DesktopDir
$h=@MyDocumentsDir
$h=@FavoritesDir
$h=@ProgramsDir
$h=@StartMenuDir
$h=@StartupDir
$h=@UserProfileDir
$h=@HomeDrive
$h=@HomePath
$h=@ProgramFilesDir
$h=@CommonFilesDir
$h=@WindowsDir
$h=@SystemDir
$h=@TempDir
$h=@IPAddress1
$h=@IPAddress2
$h=@IPAddress3
$h=@IPAddress4
$h=@DesktopDepth
$h=@DesktopRefresh
$h=@UserName
$h=@ComputerName
$h=@OSServicePack
$h=@OSBuild
$h=@OSVersion
$h=@OSType
$h=@OSLang
$h=@SEC
$h=@MIN
$h=@HOUR
$h=@MDAY
$h=@MON
$h=@YEAR
$h=@WDAY
$h=@YDAY
Next

MsgBox(0,"¬рем€ выполнени€", 'ќбновление переменной макросами 48*100 раз выполнено за '&Round(TimerDiff($timer) / 1000, 2) & ' сек'&@CRLF&@CRLF&@CRLF&'»тог: макросы выпол€ютс€ в реальном времени и нигде не кэшируютс€, соответственно не рекомендуетс€ их использовать в циклах где велико количество итераций, но получить макрос в переменную и использовать переменную в цикле.')