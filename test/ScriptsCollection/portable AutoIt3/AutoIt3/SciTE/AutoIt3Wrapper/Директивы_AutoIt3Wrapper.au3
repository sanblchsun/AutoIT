Exit
#Region AutoIt3Wrapper directives section
;** This is a list of compiler directives used by AutoIt3Wrapper.exe.
;** comment the lines you don't need or else it will override the default settings
;===============================================================================================================
;** AUTOIT3 settings
#AutoIt3Wrapper_UseX64=                         ;(Y/N) Использовать X64 версию AutoIt3_x64 или AUT2EXE_x64. По умолчанию=N
#AutoIt3Wrapper_Version=                        ;(B/P) Использовать Бэта или Релиз AutoIt3 и AUT2EXE. По умолчанию P
#AutoIt3Wrapper_Run_Debug_Mode=                 ;(Y/N) Run Script with console debugging. По умолчанию=N
#AutoIt3Wrapper_Run_SciTE_Minimized=            ;(Y/N) Minimize SciTE while script is running. По умолчанию=n
#AutoIt3Wrapper_Run_SciTE_OutputPane_Minimized= ;(Y/N) Toggle SciTE output pane at run time so its not shown. По умолчанию=n
#AutoIt3Wrapper_Autoit3Dir=						;По желанию указать базовый каталог установки AutoIt3.
#AutoIt3Wrapper_Aut2exe=						;По желанию указать Aut2exe.exe для использования с этим скриптом
#AutoIt3Wrapper_AutoIt3=                        ;По желанию указать Autoit3.exe для использования с этим скриптом
;===============================================================================================================
;** AUT2EXE settings
#AutoIt3Wrapper_Icon=                           ;Имя файла используемой иконки для EXE
#AutoIt3Wrapper_OutFile=                        ;Имя выходного файла exe/a3x.
#AutoIt3Wrapper_OutFile_Type=                   ;a3x=небольшой AutoIt3 файл; exe=Автономные исполняемые (По умолчанию)
#AutoIt3Wrapper_OutFile_X64=                    ;Имя выходного файла для X64.
#AutoIt3Wrapper_Compression=                    ;Параметр сжатия 0-4 0=низкий 2=нормальный 4=высокий. По умолчанию=2
#AutoIt3Wrapper_UseUpx=                         ;(Y/N) Сжатие скомпилированного EXE.  По умолчанию=Y
#AutoIt3Wrapper_UPX_Parameters=                 ;Указать параметры сжатия для UPX.
#AutoIt3Wrapper_Change2CUI=                     ;(Y/N) Change output program to CUI in stead of GUI. По умолчанию=N
#AutoIt3Wrapper_Compile_both=                   ;(Y/N) Компилировать оба варианта X86 и X64 за раз. По умолчанию=N
;===============================================================================================================
;** Target program Resource info
#AutoIt3Wrapper_Res_Comment=                    ;Коментарии к программе
#AutoIt3Wrapper_Res_Description=                ;Описание программы (всплывает при наведении)
#AutoIt3Wrapper_Res_Fileversion=                ;Версия программы (всплывает при наведении)
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=  ;(Y/N/P)Автоматическое увеличение номера версии при каждой компиляции. По умолчанию=N
;                                                 P=Prompt - c вопросительным диалоговым окном при компиляции, хотите ли увеличить номер версии
#AutoIt3Wrapper_Res_ProductVersion=             ;Product Version. Default is the AutoIt3 version used.
#AutoIt3Wrapper_Res_Language=                   ;Resource Language code . По умолчанию 2057=English (United Kingdom)
#AutoIt3Wrapper_Res_LegalCopyright=             ;Указать Copyright (здесь можно указать атора программы)
#AutoIt3Wrapper_res_requestedExecutionLevel=    ;None, asInvoker, highestAvailable or requireAdministrator   (По умолчанию=None)
#AutoIt3Wrapper_res_Compatibility=    			;Vista,Windows7        Both allowed separated by a comma     (По умолчанию=None)
#AutoIt3Wrapper_Res_SaveSource=                 ;(Y/N) Сохранить копию скрипта исходника в ресурсах EXE. По умолчанию=N
; Если _Res_SaveSource=Y, то содержание скрипта исходника зависит от _Run_Obfuscator и директив #obfuscator_parameters :
;
;    Если _Run_Obfuscator=Y то
;       Если #obfuscator_parameters=/STRIPONLY то скрипт исходник обработается в скрипте и в includes
;       Если #obfuscator_parameters=/STRIPONLYINCLUDES то скрипт исходник содержит оригинальный скрипт, обработается только includes
;       С любыми другими параметрами, директива SaveSource игнорируется, так как обфускация предназначена для защиты исходника
;   Если _Run_Obfuscator=N или не установлени, то скрипт исходник является оригинальным
; Autoit3Wrapper indicates the SaveSource action taken in the SciTE console during compilation
; Подробности смотрите в справке SciTE4AutoIt3, чтобы узнать больше о параметрах обфускатора
;
;
; Свободные для заполнения области ресурсов ... максимум 15
;     Вы можете использовать  следующие переменные:
;     %AutoItVer% версия AutoIt3
;     %date% = дата на ПК в кратком формате
;     %longdate% = дата на ПК в полном формате
;     %time% = время на ПК
;  например: #AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Res_Field=                      ;Свободный формат область имени|область значения

; Add extra ICO files to the resources which can be used with TraySetIcon(@ScriptFullPath, 5) etc
; list of filename of the Ico files to be added, First one will have number 5, then 6 ..etc
#AutoIt3Wrapper_Res_Icon_Add=                   ; Filename[,LanguageCode] of ICO to be added.
#AutoIt3Wrapper_Res_Icon_Add=                   ; Filename[,LanguageCode] of ICO to be added.
; Add extra files to the resources
#AutoIt3Wrapper_Res_File_Add=                   ; Filename[,Section [,ResName[,LanguageCode]]] to be added.
#AutoIt3Wrapper_Res_File_Add=                   ; Filename[,Section [,ResName[,LanguageCode]]] to be added.
;===============================================================================================================
; Tidy Settings
#AutoIt3Wrapper_Run_Tidy=                       ;(Y/N) Запускать Tidy перед компиляцией. По умолчанию=N
#AutoIt3Wrapper_Tidy_Stop_OnError=              ;(Y/N) Continue when only Warnings. По умолчанию=Y
#Tidy_Parameters=                               ;Параметры смотрите в файле справки SciTE\Scite4AutoIt3.chm
;===============================================================================================================
; Obfuscator
#AutoIt3Wrapper_Run_Obfuscator=                 ;(Y/N) Запускать Obfuscator перед компиляцией. По умолчанию=N
#obfuscator_parameters=                               ;Параметры смотрите в файле справки SciTE\Scite4AutoIt3.chm
;===============================================================================================================
; AU3Check settings
#AutoIt3Wrapper_Run_AU3Check=                   ;(Y/N) Запускать au3check перед компиляцией. По умолчанию=Y
#AutoIt3Wrapper_AU3Check_Parameters=            ;Параметры Au3Check
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=        ;(Y/N) N=Continue on Warnings.(По умолчанию) Y=Always stop on Warnings
#AutoIt3Wrapper_PlugIn_Funcs=                   ;Define PlugIn function names separated by a Comma to avoid AU3Check errors
;===============================================================================================================
; cvsWrapper settings
#AutoIt3Wrapper_Run_cvsWrapper=                 ;(Y/N/V) Run cvsWrapper to update the script source. По умолчанию=N
;                                                 V=only when version is increased by #AutoIt3Wrapper_Res_FileVersion_AutoIncrement.
#AutoIt3Wrapper_cvsWrapper_Parameters=          ; /NoPrompt  : Will skip the cvsComments prompt
;                                                 /Comments  : Text to added in the cvsComments. It can also contain the below variables.
;===============================================================================================================
; Выполнить до или после компиляции
; Следующие директивы может содержать: эти переменные
;   %in% , %out%, %outx64%, %icon% - переменные заменяются полным путём или имя файла.
;   %scriptdir% = аналогично @ScriptDir и %scriptfile% = имя файла с расширением.
;   %fileversion% эта информация из #AutoIt3Wrapper_Res_Fileversion directive
;   %scitedir% переменная заменяется каталогом программы SciTE
;   %autoitdir% переменная заменяется каталогом, в котором находится AutoIt3
#AutoIt3Wrapper_Run_Before=                     ;процесс выполняется перед компиляцией - вы можете иметь несколько записей, которые будут выполнятся по очереди
#AutoIt3Wrapper_Run_After=                      ;процесс выполняется после компиляции - вы можете иметь несколько записей, которые будут выполнятся по очереди
;===============================================================================================================
; Выполнить до или после компиляции
#AutoIt3Wrapper_Add_Constants=                  ;Добавляет необходимые стандартные константы include файлов. Только один раз.
#EndRegion


; Пример:
#AutoIt3Wrapper_OutFile=Program.exe
#AutoIt3Wrapper_icon=Program.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_UseAnsi=y
#AutoIt3Wrapper_Res_Comment=-
#AutoIt3Wrapper_Res_Description=Program.exe
#AutoIt3Wrapper_Res_Fileversion=0.1.0.0
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=n
#AutoIt3Wrapper_Res_LegalCopyright=Author
#AutoIt3Wrapper_Res_Language=1033
#AutoIt3Wrapper_Run_AU3Check=n
; информация в свойствах файла
#AutoIt3Wrapper_Res_Field=Version|0.1
#AutoIt3Wrapper_Res_Field=Build|2011.10.18
#AutoIt3Wrapper_Res_Field=Coded by|Author
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
; Разрешаем обфускацию и указываем параметры
#AutoIt3Wrapper_Run_Obfuscator=y
; Параметры обфускации. Самый компактный скрипт получается удалением неиспользованных в include функций и переименование переменных в сгенерированное короткое имя (/om)
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
; удаление сгенерированного файла обфускации
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
 
