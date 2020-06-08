Exit
#Region AutoIt3Wrapper directives section
;** This is a list of compiler directives used by AutoIt3Wrapper.exe.
;** comment the lines you don't need or else it will override the default settings
;===============================================================================================================
;** AUTOIT3 settings
#AutoIt3Wrapper_UseX64=                         ;(Y/N) ������������ X64 ������ AutoIt3_x64 ��� AUT2EXE_x64. �� ���������=N
#AutoIt3Wrapper_Version=                        ;(B/P) ������������ ���� ��� ����� AutoIt3 � AUT2EXE. �� ��������� P
#AutoIt3Wrapper_Run_Debug_Mode=                 ;(Y/N) Run Script with console debugging. �� ���������=N
#AutoIt3Wrapper_Run_SciTE_Minimized=            ;(Y/N) Minimize SciTE while script is running. �� ���������=n
#AutoIt3Wrapper_Run_SciTE_OutputPane_Minimized= ;(Y/N) Toggle SciTE output pane at run time so its not shown. �� ���������=n
#AutoIt3Wrapper_Autoit3Dir=						;�� ������� ������� ������� ������� ��������� AutoIt3.
#AutoIt3Wrapper_Aut2exe=						;�� ������� ������� Aut2exe.exe ��� ������������� � ���� ��������
#AutoIt3Wrapper_AutoIt3=                        ;�� ������� ������� Autoit3.exe ��� ������������� � ���� ��������
;===============================================================================================================
;** AUT2EXE settings
#AutoIt3Wrapper_Icon=                           ;��� ����� ������������ ������ ��� EXE
#AutoIt3Wrapper_OutFile=                        ;��� ��������� ����� exe/a3x.
#AutoIt3Wrapper_OutFile_Type=                   ;a3x=��������� AutoIt3 ����; exe=���������� ����������� (�� ���������)
#AutoIt3Wrapper_OutFile_X64=                    ;��� ��������� ����� ��� X64.
#AutoIt3Wrapper_Compression=                    ;�������� ������ 0-4 0=������ 2=���������� 4=�������. �� ���������=2
#AutoIt3Wrapper_UseUpx=                         ;(Y/N) ������ ����������������� EXE.  �� ���������=Y
#AutoIt3Wrapper_UPX_Parameters=                 ;������� ��������� ������ ��� UPX.
#AutoIt3Wrapper_Change2CUI=                     ;(Y/N) Change output program to CUI in stead of GUI. �� ���������=N
#AutoIt3Wrapper_Compile_both=                   ;(Y/N) ������������� ��� �������� X86 � X64 �� ���. �� ���������=N
;===============================================================================================================
;** Target program Resource info
#AutoIt3Wrapper_Res_Comment=                    ;���������� � ���������
#AutoIt3Wrapper_Res_Description=                ;�������� ��������� (��������� ��� ���������)
#AutoIt3Wrapper_Res_Fileversion=                ;������ ��������� (��������� ��� ���������)
#AutoIt3Wrapper_Res_FileVersion_AutoIncrement=  ;(Y/N/P)�������������� ���������� ������ ������ ��� ������ ����������. �� ���������=N
;                                                 P=Prompt - c �������������� ���������� ����� ��� ����������, ������ �� ��������� ����� ������
#AutoIt3Wrapper_Res_ProductVersion=             ;Product Version. Default is the AutoIt3 version used.
#AutoIt3Wrapper_Res_Language=                   ;Resource Language code . �� ��������� 2057=English (United Kingdom)
#AutoIt3Wrapper_Res_LegalCopyright=             ;������� Copyright (����� ����� ������� ����� ���������)
#AutoIt3Wrapper_res_requestedExecutionLevel=    ;None, asInvoker, highestAvailable or requireAdministrator   (�� ���������=None)
#AutoIt3Wrapper_res_Compatibility=    			;Vista,Windows7        Both allowed separated by a comma     (�� ���������=None)
#AutoIt3Wrapper_Res_SaveSource=                 ;(Y/N) ��������� ����� ������� ��������� � �������� EXE. �� ���������=N
; ���� _Res_SaveSource=Y, �� ���������� ������� ��������� ������� �� _Run_Obfuscator � �������� #obfuscator_parameters :
;
;    ���� _Run_Obfuscator=Y ��
;       ���� #obfuscator_parameters=/STRIPONLY �� ������ �������� ������������ � ������� � � includes
;       ���� #obfuscator_parameters=/STRIPONLYINCLUDES �� ������ �������� �������� ������������ ������, ������������ ������ includes
;       � ������ ������� �����������, ��������� SaveSource ������������, ��� ��� ���������� ������������� ��� ������ ���������
;   ���� _Run_Obfuscator=N ��� �� �����������, �� ������ �������� �������� ������������
; Autoit3Wrapper indicates the SaveSource action taken in the SciTE console during compilation
; ����������� �������� � ������� SciTE4AutoIt3, ����� ������ ������ � ���������� �����������
;
;
; ��������� ��� ���������� ������� �������� ... �������� 15
;     �� ������ ������������  ��������� ����������:
;     %AutoItVer% ������ AutoIt3
;     %date% = ���� �� �� � ������� �������
;     %longdate% = ���� �� �� � ������ �������
;     %time% = ����� �� ��
;  ��������: #AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
#AutoIt3Wrapper_Res_Field=                      ;��������� ������ ������� �����|������� ��������

; Add extra ICO files to the resources which can be used with TraySetIcon(@ScriptFullPath, 5) etc
; list of filename of the Ico files to be added, First one will have number 5, then 6 ..etc
#AutoIt3Wrapper_Res_Icon_Add=                   ; Filename[,LanguageCode] of ICO to be added.
#AutoIt3Wrapper_Res_Icon_Add=                   ; Filename[,LanguageCode] of ICO to be added.
; Add extra files to the resources
#AutoIt3Wrapper_Res_File_Add=                   ; Filename[,Section [,ResName[,LanguageCode]]] to be added.
#AutoIt3Wrapper_Res_File_Add=                   ; Filename[,Section [,ResName[,LanguageCode]]] to be added.
;===============================================================================================================
; Tidy Settings
#AutoIt3Wrapper_Run_Tidy=                       ;(Y/N) ��������� Tidy ����� �����������. �� ���������=N
#AutoIt3Wrapper_Tidy_Stop_OnError=              ;(Y/N) Continue when only Warnings. �� ���������=Y
#Tidy_Parameters=                               ;��������� �������� � ����� ������� SciTE\Scite4AutoIt3.chm
;===============================================================================================================
; Obfuscator
#AutoIt3Wrapper_Run_Obfuscator=                 ;(Y/N) ��������� Obfuscator ����� �����������. �� ���������=N
#obfuscator_parameters=                               ;��������� �������� � ����� ������� SciTE\Scite4AutoIt3.chm
;===============================================================================================================
; AU3Check settings
#AutoIt3Wrapper_Run_AU3Check=                   ;(Y/N) ��������� au3check ����� �����������. �� ���������=Y
#AutoIt3Wrapper_AU3Check_Parameters=            ;��������� Au3Check
#AutoIt3Wrapper_AU3Check_Stop_OnWarning=        ;(Y/N) N=Continue on Warnings.(�� ���������) Y=Always stop on Warnings
#AutoIt3Wrapper_PlugIn_Funcs=                   ;Define PlugIn function names separated by a Comma to avoid AU3Check errors
;===============================================================================================================
; cvsWrapper settings
#AutoIt3Wrapper_Run_cvsWrapper=                 ;(Y/N/V) Run cvsWrapper to update the script source. �� ���������=N
;                                                 V=only when version is increased by #AutoIt3Wrapper_Res_FileVersion_AutoIncrement.
#AutoIt3Wrapper_cvsWrapper_Parameters=          ; /NoPrompt  : Will skip the cvsComments prompt
;                                                 /Comments  : Text to added in the cvsComments. It can also contain the below variables.
;===============================================================================================================
; ��������� �� ��� ����� ����������
; ��������� ��������� ����� ���������: ��� ����������
;   %in% , %out%, %outx64%, %icon% - ���������� ���������� ������ ���� ��� ��� �����.
;   %scriptdir% = ���������� @ScriptDir � %scriptfile% = ��� ����� � �����������.
;   %fileversion% ��� ���������� �� #AutoIt3Wrapper_Res_Fileversion directive
;   %scitedir% ���������� ���������� ��������� ��������� SciTE
;   %autoitdir% ���������� ���������� ���������, � ������� ��������� AutoIt3
#AutoIt3Wrapper_Run_Before=                     ;������� ����������� ����� ����������� - �� ������ ����� ��������� �������, ������� ����� ���������� �� �������
#AutoIt3Wrapper_Run_After=                      ;������� ����������� ����� ���������� - �� ������ ����� ��������� �������, ������� ����� ���������� �� �������
;===============================================================================================================
; ��������� �� ��� ����� ����������
#AutoIt3Wrapper_Add_Constants=                  ;��������� ����������� ����������� ��������� include ������. ������ ���� ���.
#EndRegion


; ������:
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
; ���������� � ��������� �����
#AutoIt3Wrapper_Res_Field=Version|0.1
#AutoIt3Wrapper_Res_Field=Build|2011.10.18
#AutoIt3Wrapper_Res_Field=Coded by|Author
#AutoIt3Wrapper_Res_Field=Compile date|%longdate% %time%
#AutoIt3Wrapper_Res_Field=AutoIt Version|%AutoItVer%
; ��������� ���������� � ��������� ���������
#AutoIt3Wrapper_Run_Obfuscator=y
; ��������� ����������. ����� ���������� ������ ���������� ��������� ���������������� � include ������� � �������������� ���������� � ��������������� �������� ��� (/om)
#Obfuscator_Parameters=/sf /sv /om /cs=0 /cn=0
; �������� ���������������� ����� ����������
#AutoIt3Wrapper_Run_After=del /f /q "%scriptdir%\%scriptfile%_Obfuscated.au3"
 
