; http://support.microsoft.com/default.aspx?scid=kb;EN-US;135068

; Some Control Panel Applet Files 
; -------------------------------
; access.cpl    Accessibility controls      Keyboard(1), Sound(2), Display(3), Mouse(4), General(5)
; appwiz.cpl    Add/Remove Programs 
; desk.cpl      Display properties          Themes(5), Desktop(0), Screen Saver(1), Appearance (2), Settings(3)
; hdwwiz.cpl    Add hardware    
; inetcpl.cpl   Configure Internet Explorer and 
;               Internet properties         General(0), Security(1), Privacy(2), Content(3), Connections(4), Programs(5), Advanced(6)
; intl.cpl      Regional settings           Regional Options(1), Languages(2), Advanced(3)
; joy.cpl       Game controllers    
; main.cpl      Mouse properties and settings   Buttons(0), Pointers(1), Pointer Options(2), Wheel(3), Hardware(4)
; main.cpl,@1   Keyboard properties         Speed(0), Hardware (1)
; mmsys.cpl     Sounds and Audio            Volume(0), Sounds(1), Audio(2), Voice(3), Hardware(4)
; ncpa.cpl      Network properties  
; nusrmgr.cpl   User accounts   
; powercfg.cpl  Power configuration Power Schemes, Advanced, Hibernate, UPS (Tabs not indexed)
; sysdm.cpl     System properties           General(0), Computer Name(1), Hardware(2), Advanced(3), System Restore(4), 
;                                           Automatic Updates(5), Remote (6)
; telephon.cpl  Phone and modem options     Dialing Rules(0), Modems(1), Advanced(2)
; timedate.cpl  Date and time properties    Date & Time(0), Time Zone(1), Internet Time (no index)
; date/time.cpl Launches the Date and Time Properties window 
; desktop.cpl   Launches the Display Properties window  
; color.cpl     Launches the Display Properties window with the Appearance tab preselected  
;
; Note that some CPL files are multi-functional and require additional parameters to invoke the various functions. 
; Parameters use the "@" sign and a zero-based integer.
; Syntax : control somefile.cpl,<optional arguments> 



Run("control.exe sysdm.cpl,,4")