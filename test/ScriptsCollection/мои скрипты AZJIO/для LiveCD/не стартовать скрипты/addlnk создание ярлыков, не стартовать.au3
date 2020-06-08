#NoTrayIcon
$QuickLaunch=@AppDataDir&'\Microsoft\Internet Explorer\Quick Launch'
$SendTo=@UserProfileDir&'\SendTo'
$disksht='X:'
$Desktop=@UserProfileDir&'\Рабочий стол'
Global $EXE, $LNK, $WRK, $ARG, $DSC, $ICO, $NMR, $DIR

;Некоторые параметры необязательные, например $ARG, $ICO, $NMR по умолчанию иконка присваивается первая иконка стартового файла. Рабочий каталог  $WRK если не указан, то присваеивается по  каталогу $EXE.
;$NME=имя ярлыка
;$DIR=каталог где создаётся ярлык
;$WRK=рабочий каталог
;$EXE=стартовый файл
;$ARG=параметры старта стартового файла
;$DSC=Описание, комментарий ярлыка
;$ICO=иконка
;$NMR=номер иконки в dll, exe
;a() - вызов функции создания ярлыка

; Администрирование
$NME='Создать файл подкачки на диске C (512MБ)'
$DIR=@ProgramsCommonDir&'\Администрирование\Виртуальная память'
$EXE=@SystemDir&'\setpagefile.exe'
$ARG='/f c:\pagefile.sys /i 512 /m 512'
a()
$NME='Выбрать диск и размер для файла подкачки...'
$DIR=@ProgramsCommonDir&'\Администрирование\Виртуальная память'
$EXE=@SystemDir&'\setpagefile.exe'
a()
$NME='Создать файл подкачки на диске C (1024MБ)'
$DIR=@ProgramsCommonDir&'\Администрирование\Виртуальная память'
$EXE=@SystemDir&'\setpagefile.exe'
$ARG='/f c:\pagefile.sys /i 1024 /m 1024'
a()
$NME='Создать файл подкачки на диске C (2048MБ)'
$DIR=@ProgramsCommonDir&'\Администрирование\Виртуальная память'
$EXE=@SystemDir&'\setpagefile.exe'
$ARG='/f c:\pagefile.sys /i 2048 /m 2048'
a()
$NME='Создать файл подкачки на диске D (512MБ)'
$DIR=@ProgramsCommonDir&'\Администрирование\Виртуальная память'
$EXE=@SystemDir&'\setpagefile.exe'
$ARG='/f d:\pagefile.sys /i 512 /m 512'
a()
$NME='Создать файл подкачки на диске D (1024MБ)'
$DIR=@ProgramsCommonDir&'\Администрирование\Виртуальная память'
$EXE=@SystemDir&'\setpagefile.exe'
$ARG='/f d:\pagefile.sys /i 1024 /m 1024'
a()
$NME='Создать файл подкачки на диске D (2048MБ)'
$DIR=@ProgramsCommonDir&'\Администрирование\Виртуальная память'
$EXE=@SystemDir&'\setpagefile.exe'
$ARG='/f d:\pagefile.sys /i 2048 /m 2048'
a()
$NME='Regshot'
$DIR=@ProgramsCommonDir&'\Администрирование'
$EXE=@SystemDir&'\regshot.exe'
$DSC='Сравнение снимков реестра до и после изменений.'
a()
$NME='Безопасное извлечение устройства'
$DIR=@ProgramsCommonDir&'\Администрирование\Установка устройств'
$EXE=@SystemDir&'\rundll32.exe'
$ARG='shell32.dll,Control_RunDLL hotplug.dll'
$ICO=@SystemDir&'\hotplug.dll'
a()
$NME='Диспетчер устройств'
$DIR=@ProgramsCommonDir&'\Администрирование\Установка устройств'
$EXE=@SystemDir&'\updatedevices.exe'
a()
$NME='Установка устройств (HwPnP COM Ports)'
$DIR=@ProgramsCommonDir&'\Администрирование\Установка устройств'
$EXE=@SystemDir&'\HWPNP.EXE'
$ARG='-all +ACPI\PNP0400 +ACPI\PNP0401 +ACPI\PNP0501\1 +ACPI\PNP0501\2 /u /p /log+'
$ICO=@SystemDir&'\setupapi.dll'
$NMR=16
a()
$NME='Установка устройств (HwPnP Full Force)'
$DIR=@ProgramsCommonDir&'\Администрирование\Установка устройств'
$EXE=@SystemDir&'\HWPNP.EXE'
$ARG='+all /u /a /p /d /log+'
$ICO=@SystemDir&'\hwpnp.exe'
a()
$NME='Установка устройств (HwPnP Full)'
$DIR=@ProgramsCommonDir&'\Администрирование\Установка устройств'
$EXE=@SystemDir&'\shellexecute.exe'
$ARG='/h run-hwpnp.cmd'
$ICO=@SystemDir&'\setupapi.dll'
$NMR=25
a()
$NME='Установка устройств (HwPnP HD Audio)'
$DIR=@ProgramsCommonDir&'\Администрирование\Установка устройств'
$EXE=@SystemDir&'\HWPNP.EXE'
$ARG='-all +PCI\CC_040+HDAUDIO\ /p /d /log+'
$ICO=@SystemDir&'\stobject.dll'
$NMR=2
a()
$NME='Установка устройств (HwPnP Modem)'
$DIR=@ProgramsCommonDir&'\Администрирование\Установка устройств'
$EXE=@SystemDir&'\HWPNP.EXE'
$ARG='-all +SERENUM\ /p /d /log+'
$ICO=@SystemDir&'\mdminst.dll'
a()
$NME='Установка устройств (HwPnP USB Force)'
$DIR=@ProgramsCommonDir&'\Администрирование\Установка устройств'
$EXE=@SystemDir&'\HWPNP.EXE'
$ARG='-all +STORAGE\VOLUME +USB\ +USBSTOR\ /a /u /p /d /log+'
$ICO=@SystemDir&'\setupapi.dll'
$NMR=13
a()
$NME='Установка устройств (HwPnP USB)'
$DIR=@ProgramsCommonDir&'\Администрирование\Установка устройств'
$EXE=@SystemDir&'\HWPNP.EXE'
$ARG='-all +STORAGE\VOLUME +USB\ +USBSTOR\ /p /d /log+'
$ICO=@SystemDir&'\setupapi.dll'
$NMR=13
a()
$NME='1. Установка устройств (Driver Import V1.3)'
$DIR=@ProgramsCommonDir&'\Администрирование\Установка устройств'
$EXE='X:\PROGRAMS\Driver Import\DrvImpe.exe'
$DSC='Поиск и установка драйверов из Windows или указанной папки драйверов.'
a()
$NME='2. Mount Storage PE'
$DIR=@ProgramsCommonDir&'\Администрирование\Установка устройств'
$EXE='X:\PROGRAMS\MountStorage\MountStorPe.exe'
$DSC='Монтирование жёстких дисков.'
a()
$NME='Runscanner+RegWorkshop'
$DIR=@ProgramsCommonDir&'\Администрирование'
$EXE=@SystemDir&'\runscanner.exe'
$ARG='/y /t 0 X:\PROGRAMS\RegWorkshop\RegWorkshop.exe'
$DSC='Загрузить реестр Windows XP'
$ICO='X:\PROGRAMS\RegWorkshop\RegWorkshop.exe'
a()
$NME='Дефрагментация диска'
$DIR=@ProgramsCommonDir&'\Администрирование'
$EXE=@SystemDir&'\mmc.exe'
$ARG=@SystemDir&'\dfrg.msc'
$ICO=@SystemDir&'\DFRGRES.DLL'
a()
$NME='Командная строка'
$DIR=@ProgramsCommonDir&'\Администрирование'
$EXE=@SystemDir&'\CMD.EXE'
a()
$NME='Перезагрузка оболочки'
$DIR=@ProgramsCommonDir&'\Администрирование'
$EXE=@SystemDir&'\NIRCMD.EXE'
$ARG='killprocess explorer.exe'
$ICO=@SystemDir&'\shell32.dll'
$NMR=94
a()
$NME='Проверка диска '
$DIR=@ProgramsCommonDir&'\Администрирование'
$EXE=@SystemDir&'\CHKDSKGUI.EXE'
$ICO=@SystemDir&'\shell32.dll'
$NMR=8
a()
$NME='Runscanner+regedit'
$DIR=@ProgramsCommonDir&'\Администрирование'
$EXE=@SystemDir&'\runscanner.exe'
$ARG='/y /t 0 regedit.exe'
$DSC='Загрузить реестр Windows XP'
$ICO=@SystemDir&'\regedit.exe'
a()
$NME='Служба Windows Installer'
$DIR=@ProgramsCommonDir&'\Администрирование'
$EXE=@SystemDir&'\SHELLEXECUTE.EXE'
$ARG='/h run-msi.cmd'
$ICO=@SystemDir&'\msiexec.exe'
a()
$NME='Службы и устройства'
$DIR=@ProgramsCommonDir&'\Администрирование'
$EXE=@SystemDir&'\pserv2.exe'
a()
$NME='Таймер выключения'
$DIR=@ProgramsCommonDir&'\Администрирование'
$EXE=@SystemDir&'\shutdown.exe'
$ARG='/i /u /tr'
a()
$NME='Управление дисками'
$DIR=@ProgramsCommonDir&'\Администрирование'
$EXE=@SystemDir&'\mmc.exe'
$ARG=@SystemDir&'\diskmgmt.msc'
$ICO=@SystemDir&'\dmdskres.dll'
a()
$NME='Управления компьютером'
$DIR=@ProgramsCommonDir&'\Администрирование'
$EXE=@SystemDir&'\mmc.exe'
$ARG=@SystemDir&'\compmgmt.msc'
$ICO=@SystemDir&'\setupapi.dll'
a()
; Мультимедиа
$NME='FFdshow Video Decoder'
$DIR=@ProgramsDir&'\Мультимедиа'
$EXE=@SystemDir&'\RUNDLL32.EXE'
$ARG='X:\PROGRAMS\MPC\FFdshow\ffdshow.ax,configure'
$ICO=@SystemDir&'\shell32.dll'
$NMR=165
a()
$NME='Media Player Classic'
$DIR=@ProgramsDir&'\Мультимедиа'
$EXE='X:\PROGRAMS\MPC\mplayerc.exe'
a()
$NME='Громкость'
$DIR=@ProgramsDir&'\Мультимедиа'
$EXE=@SystemDir&'\SNDVOL32.EXE'
a()
$NME='Звукозапись'
$DIR=@ProgramsDir&'\Мультимедиа'
$EXE=@SystemDir&'\SNDREC32.EXE'
a()
; Стандартные
$NME='Internet Explorer'
$DIR=@ProgramsDir&'\Стандартные'
$EXE=@WindowsDir&'\IEXPLORE.EXE'
$ARG='about:blank'
$DSC='Браузер для выхода в интернет, просмотр справок в HTML-страницах.'
a()
$NME='Paint'
$DIR=@ProgramsDir&'\Стандартные'
$EXE=@SystemDir&'\mspaint.exe'
a()
$NME='WordPad'
$DIR=@ProgramsDir&'\Стандартные'
$EXE=@SystemDir&'\WORDPAD.EXE'
a()
$NME='Блокнот'
$DIR=@ProgramsDir&'\Стандартные'
$EXE=@SystemDir&'\notepad.exe'
a()
$NME='Калькулятор'
$DIR=@ProgramsDir&'\Стандартные'
$EXE=@SystemDir&'\calc.exe'
a()
$NME='Таблица символов'
$DIR=@ProgramsDir&'\Стандартные'
$EXE=@SystemDir&'\CHARMAP.EXE'
a()
; Игры
$NME='Косынка'
$DIR=@ProgramsDir&'\Стандартные\Игры'
$EXE=@SystemDir&'\SOL.EXE'
a()
$NME='Паук'
$DIR=@ProgramsDir&'\Стандартные\Игры'
$EXE=@SystemDir&'\SPIDER.EXE'
a()
$NME='Сапер'
$DIR=@ProgramsDir&'\Стандартные\Игры'
$EXE=@SystemDir&'\WINMINE.EXE'
a()
$NME='Солитер'
$DIR=@ProgramsDir&'\Стандартные\Игры'
$EXE=@SystemDir&'\FREECELL.EXE'
a()
; Панель быстрого запуска
$NME='Диск С'
$DIR=$QuickLaunch
$EXE=@WindowsDir&'\explorer.exe'
$ARG='C:\'
$ICO=@SystemDir&'\shell33.dll'
$NMR=1
a()
$NME='Диск D'
$DIR=$QuickLaunch
$EXE=@WindowsDir&'\explorer.exe'
$ARG='D:\'
$ICO=@SystemDir&'\shell33.dll'
$NMR=2
a()
$NME='Диск B'
$DIR=$QuickLaunch
$EXE=@WindowsDir&'\explorer.exe'
$ARG='B:\'
$ICO=@SystemDir&'\shell33.dll'
$NMR=0
a()
$NME='Диск X'
$DIR=$QuickLaunch
$EXE=@WindowsDir&'\explorer.exe'
$ARG='X:\'
$ICO=@SystemDir&'\shell33.dll'
$NMR=3
a()
$NME='Установка устройств (HwPnP Full)'
$DIR=$QuickLaunch
$EXE=@SystemDir&'\shellexecute.exe'
$ARG='/h run-hwpnp.cmd'
$ICO='setupapi.dll'
$NMR=25
a()
$NME='Диспетчер устройств'
$DIR=$QuickLaunch
$EXE=@SystemDir&'\updatedevices.exe'
a()
; Panel (верхняя панель)
$NME='10_персональные данные'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\personal\personal.au3'
$ICO='X:\PROGRAMS\Update_Utilite\personal\personal.ico'
a()
$NME='11_Разрешение экрана 1024х768х32'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\nircmd.exe'
$ARG='setdisplay 1024 768 32'
$DSC='Установить разрешение экрана 1024х768х32'
$ICO=@SystemDir&'\shell33.dll'
$NMR=5
a()
$NME='12_Разрешение экрана 1280х1024х32'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\nircmd.exe'
$ARG='setdisplay 1280 1024 32'
$DSC='Установить разрешение экрана 1280х1024х32'
$ICO=@SystemDir&'\shell33.dll'
$NMR=6
a()
$NME='13_Aвтозагрузка офисного набора'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\SHELLEXECUTE.EXE'
$ARG='/h '&$disksht&'\PROGRAMS\Update_Utilite\Start_Offise.bat'
$DSC='Запуск офисных программ (clcl, Socrat, AnVir Task Manager, Arum Switcher, Kleptomania, Power Mixer)'
$ICO=@SystemDir&'\shell33.dll'
$NMR=7
a()
$NME='14_Power Mixer'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Power Mixer\pwmixer.exe'
$DSC='Регулировка звука клавишами Shift + колёсико мыши'
a()
$NME='15_clcl (B)'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\clcl\StartCL.bat'
$DSC='Управление буфером обмена, вызов Alt + C'
$ICO=$disksht&'\PROGRAMS\clcl\CLCL.exe'
a()
$NME='16_Arum Switcher'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Arum Switcher\ArumSwitcher.exe'
$DSC='Замена текста при неправильно набраной раскладке клавиатуры, Win + Ctrl'
$ICO=$disksht&'\PROGRAMS\Arum Switcher\Arum.dll'
a()
$NME='17_Kleptomania'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Kleptomania\k-mania.exe'
$DSC='Копирование текста с диалоговых окон в буфер обмена и вставка в текстовый документ.'
a()
$NME='18_Socrat'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Socrat\spv.exe'
$DSC='Англо-русский переводчик текста.'
a()
$NME='19_Search and Replace'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\SR\SR32.EXE'
$DSC='Поиск и замена текста в файлах.'
a()
$NME='20_DupeLocater(wim)'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\DupeLocater\DupeLocater.wim'
$DSC='Поиск дубликатов файлов.'
$ICO=$disksht&'\PROGRAMS\DupeLocater\dl.ico'
a()
$NME='20_gimagex + Демонтировать wim'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\wimoff.au3'
$ICO='X:\PROGRAMS\gimagex\gimagex.exe'
$DSC="Позволяет демонтировать всё wim'ы и старт gimagex"
a()
$NME='20_Regshot'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\regshot.exe'
$DSC='Сравнение снимков реестра до и после изменений.'
a()
$NME='20_RegWorkshop'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE='X:\PROGRAMS\RegWorkshop\RegWorkshop.exe'
$DSC='Удобный менеджер реестра.'
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
$DSC='Замена блокноту, открытие больших файлов, вкладки, поддержка цветового выделения кода.'
a()
$NME='25_Foxit Reader'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\FoxitReader\foxitreader.exe'
$DSC='Просмотр *.pdf-файлов.'
a()
$NME='26_TCode(wim)'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\TCode\tcode.wim'
$DSC='Перекодировка текста в читабельный вид.'
$ICO=$disksht&'\PROGRAMS\TCode\tc.ico'
a()
$NME='27_AnVir Task Manager'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\AnVir Task Manager\Launch_pe.exe'
$DSC='Антивирусник, индикатор ресурсов, менеджер автозагрузки.'
a()
$NME='28_Internet Explorer'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@WindowsDir&'\iexplore.exe'
$ARG='about:blank'
$DSC='Браузер для выхода в интернет, просмотр справок в HTML-страницах.'
a()
$NME='29_Alcohol 120%'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Alcohol\Alcohol.exe'
$DSC='Виртуальный привод.'
a()
$NME='31_Sateira'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\SCDB\DataBurner.exe'
$DSC='Запись CD,DVD-дисков.'
a()
$NME='34_Cdslow(wim)'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Cdslow\Cdslow.wim'
$DSC='Регулировка скорости CD,DVD-диска в приводе.'
$ICO=$disksht&'\PROGRAMS\Cdslow\cd.ico'
a()
$NME='36_UltraISO'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\UltraISO\UltraISO.exe'
$DSC='Открытие образов CD,DVD-дисков, копирование загрузочных областей.'
a()
$NME='37_WinImage'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\WinImage\winimage.exe'
$DSC='Открыть файл-образ загрузочных дискет.'
a()
$NME='38_TotalCMD'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE='X:\PROGRAMS\TotalCMD\Totalcmd.exe'
a()
$NME='44_Ghost-explorer'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Ghost32\Ghostexp.exe'
$DSC='Просмотр образов жёсткого диска, с возможностью извлечения файлов.'
a()
$NME='45_Acronis True Image 9.7'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE='X:\PROGRAMS\acronis\TRUEIMAGE\trueimage.exe'
$DSC='Создание образов жёсткого диска.'
a()
$NME='49_Смонтировать EXT2&3 тома'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\IFSDRIVES.CPL'
$DSC='Смонтировать EXT2&3 тома, для просмотра дисков Линуха.'
$ICO=@SystemDir&'\shell32.dll'
$NMR=8
a()
$NME='52_WinHex'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\WinHex\WinHex.exe'
$DSC='Просмотр  и редактирование бинарных файлов.'
a()
$NME='53_CloneSpy'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\CloneSpy\CloneSpy.exe'
$DSC='Поиск дубликатов файлов.'
a()
$NME='54_Scanner'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Scanner\SCANNER.EXE'
$DSC='Просмотр жёстких дисков для поиска файлов и папок занимающих много места.'
a()
$NME='55_ResHacker'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\ResHacker\ResHacker.exe'
$DSC='Просмотр ресурсов EXE, DLL-файлов.'
a()
$NME='57_Media Player Classic'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\MPC\mplayerc.exe'
$DSC='Плеер поддерживающий все форматы при наличии кодеков.'
a()
$NME='58_Imagine'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\Imagine\Imagine.exe'
$DSC='Просмотрщик графики.'
a()
$NME='59_ArtIcons Pro'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\ArtIcons Pro\ARTICONS.exe'
$DSC='Редактор иконок.'
a()
$NME='60_Блокнот'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\NOTEPAD.EXE'
$DSC='Блокнот.'
a()
$NME='61_Сетевой конфигуратор'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$WRK='X:\PROGRAMS\Update_Utilite\net_config'
$EXE=@SystemDir&'\SHELLEXECUTE.EXE'
$ARG='/h X:\PROGRAMS\Update_Utilite\net_config\start.bat'
$DSC='Ввод IP, подсети, DNS для подключения к локальным или беспроводным сетям.'
$ICO=@SystemDir&'\PENetwork.exe'
a()
$NME='62_Установка LiveCD на хард, флешку'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$WRK='X:\Programs\Update_Utilite\instLiveCD'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\instLiveCD\instLiveCD.au3'
$DSC='С выбором вариантов меню Boot.ini или Grub.'
$ICO='X:\PROGRAMS\Update_Utilite\instLiveCD\instLiveCD.ico'
a()
$NME='63_Environment'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$WRK='X:\Programs\Update_Utilite\Environment'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\Environment\environment.au3'
$DSC='Сменить переменную Temp и другие.'
$ICO='X:\PROGRAMS\Update_Utilite\Environment\System_path.ico'
a()
$NME='63_ImDisk'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$WRK=$disksht&'\PROGRAMS\Update_Utilite'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=$disksht&'\PROGRAMS\Update_Utilite\imdisk.au3'
$DSC='Увеличение обьёма диска B. Для монтирования образов CD,DVD-дисков, хардов, с возможностью копирования их в память ОЗУ.'
$ICO=@SystemDir&'\imdisk.cpl'
a()
$NME='63_Ассоциатор'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='assotiations.au3'
$ICO=@SystemDir&'\shell33.dll'
$NMR=14
$DSC='Ассоциировать свою программу с файлами.'
a()
$NME='63_Пользовательские папки'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\user.au3'
$ICO=@SystemDir&'\shell32.dll'
$NMR=170
$DSC='Быстро переходить к папкам пользователей WindowsXP и LiveCD.'
a()
$NME='64_Сессии каталогов'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$WRK='X:\PROGRAMS\Update_Utilite\SaveFolders'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\SaveFolders\SaveFolders.au3'
$DSC='Сохранение рабочей обстановки каталогов в сессию'
$ICO=@SystemDir&'\shell32.dll'
$NMR=110
a()
$NME='66_Driver Import V1.3'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$WRK='X:\Programs\Driver Import'
$DSC='Поиск и установка драйверов из Windows или указанной папки драйверов.'
a()
$NME='66_MountStorPe + Отключение хардов'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\hdd_off.au3'
$ICO='X:\PROGRAMS\MountStorage\MountStorPe.exe'
$DSC='Подключение и отключение жёстких дисков.'
a()
$NME='67_SmartDriverBackup'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=$disksht&'\PROGRAMS\SmartDriverBackup\SmartDriverBackup.exe'
$DSC='Программа копирует драйвера из "лежачей" WindowsXP.'
a()
$NME='96_Выбор альтернативной темы'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\WindowBlinds\wbchoice.au3'
$DSC='Можно изменить имя и размер  шрифта.'
$ICO='X:\PROGRAMS\WindowBlinds\wbload.exe'
a()
$NME='О диске'
$DIR=@ProgramsDir&'\!\Windows\Panel'
$EXE='X:\PROGRAMS\Update_Utilite\WinXPE_help\htmlautorun.exe'
a()
; Меню (!)
$NME='Alcohol 120%'
$DIR=@ProgramsDir&'\!\cd-rom'
$EXE=$disksht&'\PROGRAMS\Alcohol\Alcohol.exe'
$DSC='Виртуальный привод.'
a()
$NME='Cdslow(wim)'
$DIR=@ProgramsDir&'\!\cd-rom'
$EXE=$disksht&'\PROGRAMS\Cdslow\Cdslow.wim'
$DSC='Регулировка скорости CD,DVD-диска в приводе.'
$ICO=$disksht&'\PROGRAMS\Cdslow\cd.ico'
a()
$NME='ImDisk'
$DIR=@ProgramsDir&'\!\cd-rom'
$WRK=$disksht&'\PROGRAMS\Update_Utilite'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=$disksht&'\PROGRAMS\Update_Utilite\imdisk.au3'
$DSC='Для монтирования образов CD,DVD-дисков, хардов, с возможностью копирования их в память ОЗУ.'
$ICO=@SystemDir&'\imdisk.cpl'
a()
$NME='ScbData'
$DIR=@ProgramsDir&'\!\cd-rom'
$EXE=$disksht&'\PROGRAMS\SCDB\ScbData.exe'
$DSC='Запись CD,DVD-дисков.'
a()
$NME='UltraISO'
$DIR=@ProgramsDir&'\!\cd-rom'
$EXE=$disksht&'\PROGRAMS\UltraISO\UltraISO.exe'
$DSC='Открытие образов CD,DVD-дисков, копирование загрузочных областей.'
a()
$NME='Записать образ диска'
$DIR=@ProgramsDir&'\!\cd-rom\SCDB'
$EXE=$disksht&'\PROGRAMS\SCDB\ImageBurner.exe'
$DSC='Запись CUE/BIN/ISO-образов.'
a()
$NME='Запись Диск с Данными'
$DIR=@ProgramsDir&'\!\cd-rom\SCDB'
$EXE=$disksht&'\PROGRAMS\SCDB\DataBurner.exe'
$DSC='Запись CD,DVD-дисков.'
a()
$NME='Запись аудио-дисков'
$DIR=@ProgramsDir&'\!\cd-rom\SCDB'
$EXE=$disksht&'\PROGRAMS\SCDB\AudioBurner.exe'
$DSC='Запись аудио-дисков.'
a()
$NME='Обзор сессий'
$DIR=@ProgramsDir&'\!\cd-rom\SCDB'
$EXE=$disksht&'\PROGRAMS\SCDB\Commander.exe'
$DSC='Обзор сессий.'
a()
$NME='AnVir Task Manager (B)'
$DIR=@ProgramsDir&'\!\Windows\автозапуск'
$EXE=$disksht&'\PROGRAMS\AnVir Task Manager\Launch_pe.exe'
$DSC='Антивирусник, индикатор ресурсов, менеджер автозагрузки.'
a()
$NME='clcl (B)'
$DIR=@ProgramsDir&'\!\Windows\автозапуск'
$EXE=$disksht&'\PROGRAMS\clcl\StartCL.bat'
$DSC='Управление буфером обмена, вызов Alt + C'
$ICO=$disksht&'\PROGRAMS\clcl\CLCL.exe'
a()
$NME='Socrat'
$DIR=@ProgramsDir&'\!\Windows\автозапуск'
$EXE=$disksht&'\PROGRAMS\Socrat\spv.exe'
$DSC='Англо-русский переводчик текста.'
a()
$NME='+Сохранить-реестр-PE'
$DIR=@ProgramsDir&'\!\Windows\Служебные'
$WRK='X:\Programs\Update_Utilite'
$EXE=@SystemDir&'\shellexecute.exe'
$ARG='/h X:\Programs\Update_Utilite\+save-reestr-PE.bat'
$ICO=@SystemDir&'\cmd.exe'
a()
$NME='Управления компьютером'
$DIR=@ProgramsDir&'\!\Windows\Служебные'
$EXE=@SystemDir&'\mmc.exe'
$ARG=@SystemDir&'\compmgmt.msc'
$ICO=@SystemDir&'\setupapi.dll'
a()
$NME='О диске'
$DIR=@ProgramsDir&'\!\Windows\Служебные'
$EXE='X:\PROGRAMS\Update_Utilite\WinXPE_help\htmlautorun.exe'
a()
$NME='Персональные данные'
$DIR=@ProgramsDir&'\!\Windows\Служебные'
$WRK='X:\Programs\Update_Utilite\personal'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\personal\personal.au3'
$ICO='X:\PROGRAMS\Update_Utilite\personal\personal.ico'
a()
$NME='Переменные среды'
$DIR=@ProgramsDir&'\!\Windows\Служебные'
$WRK='X:\Programs\Update_Utilite\Environment'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\Environment\environment.au3'
$DSC='Сменить переменную Temp и другие.'
$ICO='X:\PROGRAMS\Update_Utilite\Environment\System_path.ico'
a()
$NME='+Сохранить Application Data'
$DIR=@ProgramsDir&'\!\Windows\Служебные'
$EXE='X:\Programs\Update_Utilite\save_lnk.cmd'
$ICO=@SystemDir&'\cmd.exe'
$DSC='Копирование данных в sfx-архив ADDFILE.EXE.'
a()
$NME='+Сохранить-ярлыки-PE'
$DIR=@ProgramsDir&'\!\Windows\Служебные'
$EXE='X:\Programs\Update_Utilite\save_App_Data.cmd'
$ICO=@SystemDir&'\cmd.exe'
$DSC='Копирование ярлыков в sfx-архив ADDFILE.EXE.'
a()
$NME='Свойства компьютера'
$DIR=@ProgramsDir&'\!\Windows\Служебные'
$EXE=@SystemDir&'\SYSDM.CPL'
$ICO=@SystemDir&'\MMCNDMGR.DLL'
$NMR=11
a()
$NME='Internet Explorer'
$DIR=@ProgramsDir&'\!\Windows'
$EXE=@WindowsDir&'\IEXPLORE.EXE'
$ARG='about:blank'
$DSC='Браузер для выхода в интернет, просмотр справок в HTML-страницах.'
a()
$NME='Paint'
$DIR=@ProgramsDir&'\!\Windows'
$EXE=@SystemDir&'\mspaint.exe'
a()
$NME='regedit'
$DIR=@ProgramsDir&'\!\Windows'
$EXE=@SystemDir&'\regedit.exe'
a()
$NME='Блокнот'
$DIR=@ProgramsDir&'\!\Windows'
$EXE=@SystemDir&'\notepad.exe'
a()
$NME='Калькулятор'
$DIR=@ProgramsDir&'\!\Windows'
$EXE=@SystemDir&'\calc.exe'
a()
$NME='WindowBlinds(au3)'
$DIR=@ProgramsDir&'\!\Windows'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\WindowBlinds\wbchoice.au3'
$DSC='Можно изменить имя и размер  шрифта.'
$ICO='X:\PROGRAMS\WindowBlinds\wbload.exe'
a()
$NME='WindowBlinds(cmd)'
$DIR=@ProgramsDir&'\!\Windows'
$EXE=@SystemDir&'\SHELLEXECUTE.EXE'
$ARG='/h X:\PROGRAMS\WindowBlinds\start.cmd'
$DSC='Выбор темы, выгрузить/стартовать WB.'
$ICO='X:\PROGRAMS\WindowBlinds\wbload.exe'
a()
$NME='RegWorkshop'
$DIR=@ProgramsDir&'\!\Windows'
$EXE='X:\PROGRAMS\RegWorkshop\RegWorkshop.exe'
$DSC='Удобный менеджер реестра.'
a()
$NME='ArtIcons Pro'
$DIR=@ProgramsDir&'\!\Графика'
$EXE=$disksht&'\PROGRAMS\ArtIcons Pro\ARTICONS.exe'
$DSC='Редактор иконок.'
a()
$NME='Paint'
$DIR=@ProgramsDir&'\!\Графика'
$EXE=@SystemDir&'\mspaint.exe'
a()
$NME='WinDjView'
$DIR=@ProgramsDir&'\!\Графика'
$EXE='X:\PROGRAMS\WinDjView\WinDjView.exe'
a()
$NME='Imagine'
$DIR=@ProgramsDir&'\!\Графика'
$EXE=$disksht&'\PROGRAMS\Imagine\Imagine.exe'
$DSC='Просмотрщик графики.'
a()
$NME='Apache2.2'
$DIR=@ProgramsDir&'\!\Интернет'
$WRK=$disksht&'\PROGRAMS\!Only_LiveDVD'
$EXE=@SystemDir&'\shellexecute.exe'
$ARG='/h '&$disksht&'\PROGRAMS\!Only_LiveDVD\Apache.cmd'
$DSC='Запуск сервера Apache2.2, при условии что он установлен в "C:\AppServ".'
$ICO=$disksht&'\PROGRAMS\!Only_LiveDVD\Apache.ico'
a()
$NME='Internet Explorer'
$DIR=@ProgramsDir&'\!\Интернет'
$EXE=@WindowsDir&'\IEXPLORE.EXE'
$ARG='about:blank'
$DSC='Браузер для выхода в интернет, просмотр справок в HTML-страницах.'
a()
$NME='Outpost Firewall'
$DIR=@ProgramsDir&'\!\Интернет'
$EXE='X:\PROGRAMS\Outpost\outpost.exe'
$DSC='Брандмауэр, защита от самостоятельного выхода программ в интернет, для скачки обновлений или передачи конфеденциальных данных.'
a()
$NME='Arum Switcher'
$DIR=@ProgramsDir&'\!\Офис'
$EXE=$disksht&'\PROGRAMS\Arum Switcher\ArumSwitcher.exe'
$DSC='Замена текста при неправильно набраной раскладке клавиатуры, Win + Ctrl'
$ICO=$disksht&'\PROGRAMS\Arum Switcher\Arum.dll'
a()
$NME='ASCII Art Studio'
$DIR=@ProgramsDir&'\!\Офис'
$EXE='X:\PROGRAMS\ASCII Art Studio\AsciiArtStudio.exe'
$DSC='Для файлов nfo, diz.'
a()
$NME='clcl (B)'
$DIR=@ProgramsDir&'\!\Офис'
$EXE=$disksht&'\PROGRAMS\clcl\StartCL.bat'
$DSC='Управление буфером обмена, вызов Alt + C'
$ICO=$disksht&'\PROGRAMS\clcl\CLCL.exe'
a()
$NME='Office PlanMaker (Excel)'
$DIR=@ProgramsDir&'\!\Офис'
$EXE='X:\Programs\SoftMakerOffice2010\PlanMaker.exe'
$DSC='Открывает файлы MS Office 2007, OpenOffice.'
a()
$NME='Foxit Reader'
$DIR=@ProgramsDir&'\!\Офис'
$EXE=$disksht&'\PROGRAMS\FoxitReader\foxitreader.exe'
$DSC='Просмотр *.pdf-файлов.'
a()
$NME='Kleptomania'
$DIR=@ProgramsDir&'\!\Офис'
$EXE=$disksht&'\PROGRAMS\Kleptomania\k-mania.exe'
$DSC='Копирование текста с диалоговых окон в буфер обмена и вставка в текстовый документ.'
a()
$NME='Notepad++'
$DIR=@ProgramsDir&'\!\Офис'
$EXE=$disksht&'\PROGRAMS\notepad++\notepad++.exe'
$DSC='Замена блокноту, открытие больших файлов, вкладки, поддержка цветового выделения кода.'
a()
$NME='Socrat'
$DIR=@ProgramsDir&'\!\Офис'
$EXE=$disksht&'\PROGRAMS\Socrat\spv.exe'
$DSC='Англо-русский переводчик текста.'
a()
$NME='TCode(wim)'
$DIR=@ProgramsDir&'\!\Офис'
$EXE=$disksht&'\PROGRAMS\TCode\tcode.wim'
$DSC='Перекодировка текста в читабельный вид.'
$ICO=$disksht&'\PROGRAMS\TCode\tc.ico'
a()
$NME='Office TextMaker (Word)'
$DIR=@ProgramsDir&'\!\Офис'
$EXE='X:\Programs\SoftMakerOffice2010\TextMaker.exe'
$DSC='Открывает файлы MS Office 2007, OpenOffice.'
a()
$NME='Блокнот'
$DIR=@ProgramsDir&'\!\Офис'
$EXE=@SystemDir&'\notepad.exe'
a()
$NME='CloneSpy'
$DIR=@ProgramsDir&'\!\Разное\Утилитки'
$EXE=$disksht&'\PROGRAMS\CloneSpy\CloneSpy.exe'
$DSC='Поиск дубликатов файлов.'
$NMR=7
a()
$NME='Power Mixer'
$DIR=@ProgramsDir&'\!\Разное\Утилитки'
$EXE=$disksht&'\PROGRAMS\Power Mixer\pwmixer.exe'
$DSC='Регулировка звука клавишами Shift + колёсико мыши'
a()
$NME='Scanner'
$DIR=@ProgramsDir&'\!\Разное\Утилитки'
$EXE=$disksht&'\PROGRAMS\Scanner\SCANNER.EXE'
$DSC='Просмотр жёстких дисков для поиска файлов и папок занимающих много места.'
a()
$NME='TeraCopy2 - Включить'
$DIR=@ProgramsDir&'\!\Разное\Утилитки'
$EXE=@SystemDir&'\SHELLEXECUTE.EXE'
$ARG='/h X:\Programs\TeraCopy2\TeraCopy2start.bat'
$ICO='X:\Programs\TeraCopy2\TeraCopy.exe'
$NMR=1
a()
$NME='TeraCopy2 - Отключить'
$DIR=@ProgramsDir&'\!\Разное\Утилитки'
$EXE=@SystemDir&'\SHELLEXECUTE.EXE'
$ARG='/h X:\Programs\TeraCopy2\TeraCopy2Del.bat'
$ICO='X:\Programs\TeraCopy2\TeraCopy.exe'
$NMR=2
a()
$NME='7-Zip'
$DIR=@ProgramsDir&'\!\Разное'
$EXE='X:\PROGRAMS\7-Zip\7zFM.exe'
a()
$NME='Driver Import V1.3'
$DIR=@ProgramsDir&'\!\Разное'
$EXE='X:\PROGRAMS\Driver Import\DrvImpe.exe'
$DSC='Поиск и установка драйверов из Windows или указанной папки драйверов.'
a()
$NME='gimagex'
$DIR=@ProgramsDir&'\!\Разное'
$EXE=$disksht&'\PROGRAMS\gimagex\gimagex.exe'
$DSC='Для работы с wim-файлами.'
a()
$NME='Media Player Classic'
$DIR=@ProgramsDir&'\!\Разное'
$EXE=$disksht&'\PROGRAMS\MPC\mplayerc.exe'
$DSC='Плеер поддерживающий все форматы при наличии кодеков.'
a()
$NME='MountStorPe'
$DIR=@ProgramsDir&'\!\Разное'
$EXE='X:\PROGRAMS\MountStorage\MountStorPe.exe'
$DSC='Монтирование жёстких дисков.'
a()
$NME='ResHacker'
$DIR=@ProgramsDir&'\!\Разное'
$EXE=$disksht&'\PROGRAMS\ResHacker\ResHacker.exe'
$DSC='Просмотр ресурсов EXE, DLL-файлов.'
a()
$NME='Search and Replace'
$DIR=@ProgramsDir&'\!\Разное'
$EXE=$disksht&'\PROGRAMS\SR\SR32.EXE'
$DSC='Поиск и замена текста в файлах.'
a()
$NME='SmartDriverBackup'
$DIR=@ProgramsDir&'\!\Разное'
$EXE=$disksht&'\PROGRAMS\SmartDriverBackup\SmartDriverBackup.exe'
$DSC='Программа копирует драйвера из "лежачей" WindowsXP.'
a()
$NME='TotalCMD'
$DIR=@ProgramsDir&'\!\Разное'
$EXE='X:\PROGRAMS\TotalCMD\Totalcmd.exe'
a()
$NME='WinHex'
$DIR=@ProgramsDir&'\!\Разное'
$EXE=$disksht&'\PROGRAMS\WinHex\WinHex.exe'
$DSC='Просмотр  и редактирование бинарных файлов.'
a()
$NME='WinImage'
$DIR=@ProgramsDir&'\!\Разное'
$EXE=$disksht&'\PROGRAMS\WinImage\winimage.exe'
$DSC='Открыть файл-образ загрузочных дискет.'
a()
$NME='WinRAR'
$DIR=@ProgramsDir&'\!\Разное'
$EXE='X:\PROGRAMS\WinRAR\WinRAR.exe'
a()
$NME='ttfttest'
$DIR=@ProgramsDir&'\!\Тест'
$EXE='X:\PROGRAMS\NMT\ttfttest.exe'
$DSC='Тест монитора.'
a()
$NME='Ghost-explorer'
$DIR=@ProgramsDir&'\!\Утилиты HDD'
$EXE=$disksht&'\PROGRAMS\Ghost32\Ghostexp.exe'
$DSC='Просмотр образов жёсткого диска, с возможностью извлечения файлов.'
a()
$NME='Acronis True Image 9.7'
$DIR=@ProgramsDir&'\!\Утилиты HDD'
$EXE='X:\PROGRAMS\acronis\TRUEIMAGE\trueimage.exe'
$DSC='Создание образов жёсткого диска.'
a()
$NME='Смонтировать EXT2&3 тома'
$DIR=@ProgramsDir&'\!\Утилиты HDD'
$EXE=@SystemDir&'\IFSDRIVES.CPL'
$DSC='Смонтировать EXT2&3 тома, для просмотра дисков Линуха.'
$ICO=@SystemDir&'\shell32.dll'
$NMR=8
a()
; Меню (!) Скрипты
$NME='Ассоциатор'
$DIR=@ProgramsDir&'\!\Разное\Скрипты'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\assotiations.au3'
$ICO=@SystemDir&'\shell33.dll'
$NMR=14
$DSC='Ассоциировать свою программу с файлами.'
a()
$NME='Прыжок в реестр'
$DIR=@ProgramsDir&'\!\Разное\Скрипты'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\jumpreg.au3'
$ICO=@SystemDir&'\shell33.dll'
$NMR=16
$DSC='Прыжок в указанную ветку реестра.'
a()
$NME='Создание ярлыков'
$DIR=@ProgramsDir&'\!\Разное\Скрипты'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\create_lnk.au3'
$ICO=@SystemDir&'\shell33.dll'
$NMR=13
$DSC='Создание и бэкапирование ярлыков.'
a()
$NME='Перепаковать загрузочный WIM'
$DIR=@ProgramsDir&'\!\Разное\Скрипты'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\repak.au3'
$ICO=@SystemDir&'\shell33.dll'
$NMR=15
$DSC='Позволяет изменить содержимое WinPe.wim и применить твики.'
a()
$NME='Пользовательские папки'
$DIR=@ProgramsDir&'\!\Разное\Скрипты'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\user.au3'
$ICO=@SystemDir&'\shell32.dll'
$NMR=170
$DSC='Быстро переходить к папкам пользователей WindowsXP и LiveCD.'
a()
$NME='Отключение дисков'
$DIR=@ProgramsDir&'\!\Разное\Скрипты'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\hdd_off.au3'
$ICO=@SystemDir&'\shell32.dll'
$NMR=8
$DSC='Отключение хардов для защиты от вирусов во время подключения к интернету.'
a()
$NME='Демонтировать wim'
$DIR=@ProgramsDir&'\!\Разное\Скрипты'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\wimoff.au3'
$ICO='X:\PROGRAMS\gimagex\gimagex.exe'
$DSC="Позволяет демонтировать всё wim'ы"
a()
$NME='Правка SETUPLDR'
$DIR=@ProgramsDir&'\!\Разное\Скрипты'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\Patch_SETUPLDR.au3'
$ICO=@SystemDir&'\shell33.dll'
$DSC="Правка SETUPLDR.BIN для смены каталога i386, minint"
$NMR=8
a()
$NME='Бэкапировать reg-файл'
$DIR=@ProgramsDir&'\!\Разное\Скрипты'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\\reg-backup.au3'
$DSC='Бэкапировать reg-файл из текущего реестра'
$ICO=@SystemDir&'\shell33.dll'
$NMR=16
a()
$NME='Сессии каталогов'
$DIR=@ProgramsDir&'\!\Разное\Скрипты'
$WRK='X:\PROGRAMS\Update_Utilite\SaveFolders'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\SaveFolders\SaveFolders.au3'
$DSC='Сохранение рабочей обстановки каталогов в сессию'
$ICO=@SystemDir&'\shell32.dll'
$NMR=110
a()
$NME='Инфо (память, хард, cpu)'
$DIR=@ProgramsDir&'\!\Разное\Скрипты'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG=@SystemDir&'\info.au3'
$ICO=@SystemDir&'\shell32.dll'
$DSC="Информационный скрипт при отсутствии в сборке Everest, SIW"
$NMR=12
a()
; Сеть
$NME='«1»  Установка сетевых компонентов...'
$DIR=@ProgramsDir&'\Сеть'
$EXE=@SystemDir&'\RUN-NETRUN.CMD'
$ICO=@SystemDir&'\rasphone.exe'
a()
$NME='«2»  Мастер новых подключений...'
$DIR=@ProgramsDir&'\Сеть'
$EXE=@SystemDir&'\RUN-NETNCW.CMD'
$ICO=@SystemDir&'\netshell.dll'
$NMR=3
a()
$NME='«3»  Подключить ... Отключить ...'
$DIR=@ProgramsDir&'\Сеть'
$EXE=@SystemDir&'\RUN-NETRAS.CMD'
$ICO=@SystemDir&'\netshell.dll'
$NMR=101
a()
$NME='«4»  Hастройка сетевых подключений...'
$DIR=@ProgramsDir&'\Сеть'
$EXE=@SystemDir&'\RUN-NETCFG.CMD'
$ICO=@SystemDir&'\shell32.dll'
$NMR=18
a()
; SendTo
$NME='ArtIcons Pro'
$DIR=$SendTo&'\Графика'
$EXE=$disksht&'\PROGRAMS\ArtIcons Pro\ARTICONS.exe'
$DSC='Редактор иконок.'
a()
$NME='Paint'
$DIR=$SendTo&'\Графика'
$EXE=@SystemDir&'\mspaint.exe'
a()
$NME='WinDjView'
$DIR=$SendTo&'\Графика'
$EXE='X:\PROGRAMS\WinDjView\WinDjView.exe'
a()
$NME='Imagine'
$DIR=$SendTo&'\Графика'
$EXE=$disksht&'\PROGRAMS\Imagine\Imagine.exe'
$DSC='Просмотрщик графики.'
a()
$NME='Media Player Classic'
$DIR=$SendTo&'\Разное'
$EXE=$disksht&'\PROGRAMS\MPC\mplayerc.exe'
$DSC='Плеер поддерживающий все форматы при наличии кодеков.'
a()
$NME='ResHacker'
$DIR=$SendTo&'\Разное'
$EXE=$disksht&'\PROGRAMS\ResHacker\ResHacker.exe'
$DSC='Просмотр ресурсов EXE, DLL-файлов.'
a()
$NME='UltraISO'
$DIR=$SendTo&'\Разное'
$EXE=$disksht&'\PROGRAMS\UltraISO\UltraISO.exe'
$DSC='Открытие образов CD,DVD-дисков, копирование загрузочных областей.'
a()
$NME='WinHex'
$DIR=$SendTo&'\Разное'
$EXE=$disksht&'\PROGRAMS\WinHex\WinHex.exe'
$DSC='Просмотр  и редактирование бинарных файлов.'
a()
$NME='Смонтировать в ImDisk'
$DIR=$SendTo&'\Разное'
$EXE=@SystemDir&'\shellexecute.exe'
$ARG='/h imdisk.bat'
$ICO=@SystemDir&'\imdisk.cpl'
a()
; Desktop - Рабочий стол
$NME='!Проводник'
$DIR=$Desktop
$EXE=@WindowsDir&'\explorer.exe'
$ARG='/e, X:\'
$ICO=@SystemDir&'\shell32.dll'
$NMR=170
a()
$NME='Перезагр'
$DIR=$Desktop
$EXE=@SystemDir&'\shutdown.exe'
$ARG='/r'
$ICO=@SystemDir&'\shutdown.exe'
$NMR=2
a()
$NME='Выкл'
$DIR=$Desktop
$EXE=@SystemDir&'\shutdown.exe'
$ARG='/s'
a()
; Меню Пуск
$NME='Офисные программы'
$DIR=@AppDataDir
$EXE=@SystemDir&'\SHELLEXECUTE.EXE'
$ARG='/h '&$disksht&'\PROGRAMS\Update_Utilite\Start_Offise.bat'
$DSC='Запуск программ для работы с текстом.)'
$ICO=@SystemDir&'\shell33.dll'
$NMR=7
a()
$NME='Справка LiveCD'
$DIR=@AppDataDir
$EXE='X:\PROGRAMS\Update_Utilite\WinXPE_help\htmlautorun.exe'
a()
$NME='Установка LiveCD'
$DIR=@AppDataDir
$WRK='X:\Programs\Update_Utilite\instLiveCD'
$EXE=@SystemDir&'\AutoIt3.exe'
$ARG='X:\PROGRAMS\Update_Utilite\instLiveCD\instLiveCD.au3'
$DSC='С выбором вариантов меню Boot.ini или Grub.'
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