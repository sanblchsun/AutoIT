#include <ASM.au3>
#include <WinAPI.au3>
#include <Memory.au3>
#include <MemoryDll.au3>
#include <ScreenCapture.au3>
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <MemoryConstants.au3>
#include <StructureConstants.au3>
#include <array.au3>

Opt("GUIOnEventMode", 1)
Opt("MouseCoordMode", 2)
Opt("PixelCoordMode", 2)

Global Const $DIB_RGB_COLORS = 0


Global $winx = 800   	;größe der CLIENT-Fläche!
Global $winy = 600  	;größe der CLIENT-Fläche!

Global $height, $width, $bitmap, $ptr, $pbitmap, $pixelstruct,$zoom
Global $iwidth, $iheight, $hgui, $hdc, $adib, $hcdc
Global $cx, $cy, $clics,$count=0,$windowsizechanged=0,$minimized,$contextflag,$minimizedrender

Global $hgui = GUICreate("Apfelmaennchen by Andy (www.AutoIt.de)", $winx, $winy,-1,-1,$WS_OVERLAPPEDWINDOW ); @DesktopWidth, @DesktopHeight)

;GUIRegisterMsg($WM_SIZE, "_WM_SIZE") ;wenn Fenstergrösse verändert wird
GUISetOnEvent($GUI_EVENT_CLOSE, "_WindowEvents", $hgui)
GUISetOnEvent($GUI_EVENT_MINIMIZE, "_WindowEvents")
GUISetOnEvent($GUI_EVENT_MAXIMIZE, "_WindowEvents")
GUISetOnEvent($GUI_EVENT_RESTORE, "_WindowEvents")
GUISetOnEvent($GUI_EVENT_RESIZED, "_WindowEvents")
GUISetOnEvent($GUI_EVENT_PRIMARYDown, "_MouseEvents") ;beim UP der linken Maustaste die func aufrufen
;GUISetOnEvent($GUI_EVENT_SECONDARYUP, "_MouseEvents") ;beim UP der linken Maustaste die func aufrufen

$context = GUICtrlCreateContextMenu(-1)
$item1 = GUICtrlCreateMenuItem("Save Picture", $context)
$item2 = GUICtrlCreateMenuItem("Zoom backwards", $context)
$item3 = GUICtrlCreateMenuItem("Load Picture/File", $context)
$item4 = GUICtrlCreateMenuItem("Render Flight to this Position", $context)
$item5 = GUICtrlCreateMenuItem("Zoom x2", $context)
$item6 = GUICtrlCreateMenuItem("Zoom x3", $context)
$item7 = GUICtrlCreateMenuItem("Zoom x4", $context)
$item8 = GUICtrlCreateMenuItem("Palette1", $context)
$item9 = GUICtrlCreateMenuItem("Palette2", $context)
;$item3 = GUICtrlCreateMenuItem("Eingabeparameter in aktuelle Vorlage übertragen", $context)
;GUICtrlSetOnEvent($item3, "_Bearbeiten")
GUICtrlSetOnEvent($item1, "_SavePic")
GUICtrlSetOnEvent($item2, "_PicBack")
GUICtrlSetOnEvent($item3, "_LoadPic")
GUICtrlSetOnEvent($item4, "_Flightrender")
GUICtrlSetOnEvent($item5, "_zoom2")
GUICtrlSetOnEvent($item6, "_zoom3")
GUICtrlSetOnEvent($item7, "_zoom4")
GUICtrlSetOnEvent($item8, "_palette1")
GUICtrlSetOnEvent($item9, "_palette2")

Global $AsmObj = AsmInit() ;init assembler
global $pointer  	;pointer auf die Bitmapdaten initialisieren, byref für _createbitmap32()
global $hbitmap		;hbitmap initialisieren , byref _createbitmap32()
global $hpicDC = _CreateNewBmp32($winx, $winy, $pointer,$hbitmap) ;neue 32-Bit-Bitmap erstellen, pointer ist nun die Startadresse der Bitmapdaten, hbitmap zum einfachen speichern usw

global $pointer_palette  	;pointer auf die Bitmapdaten initialisieren, byref für _createbitmap32()
global $hbitmap_palette		;hbitmap initialisieren , byref _createbitmap32()
global $hpicDC_palette = _CreateNewBmp32($winx, $winy, $pointer_palette,$hbitmap_palette) ;neue 32-Bit-Bitmap für die mit der Farbpalette eingefärbte Bitmap erstellen, pointer ist nun die Startadresse der Bitmapdaten, hbitmap zum einfachen speichern usw

Global $hwinDC = _WinAPI_GetDC($hgui)  ;DeviceContext der GUI holen, brauchen wir zum blitten der Bitmaps

;Struct erstellen, auf diese Daten greift der Assembler zu
;ich arbeite mit Absicht hier nicht mit den Basepointern, dazu später mehr^^
;Übergabeparameter				Name Parameter 					Größe	Adresse(im asm-prog bzw Speicher)
global	$asmstack = dllstructcreate("double startx;"& _;$x0, 	8 Byte	[EBP]
								"double starty;"& _;$y0, 		8 Byte	[EBP+08]
								"double stepx;"& _;$stepx		8 Byte	[EBP+10]
								"double stepy;"& _;$stepy		8 Byte	[EBP+18]
								"int tiefe;"&	_	;$tiefe, 	4 Byte	[EBP+20]
								"int maxiter;"& _	;$maxiter, 	4 Byte	[EBP+24]
								"ptr bmpdata;"& _ 	;$bmpdata, 	4 Byte	[EBP+28]
								"int winwidth;"& _	;$winwidth, 4 Byte	[EBP+2C]
								"int winheight;"& _	;winheight)	4 Byte	[EBP+30]
								"ptr callback;"& _ ;callback	4 Byte 	[EBP+34]
								"ptr bmppalette;"& _ ;2. bitmap	4 Byte 	[EBP+38]
								"ptr palette;"& _ ;Farbpalette	4 Byte 	[EBP+3C]
								"byte [300]"); 							[EBP+40]  platz zum sichern der FPU-Register

global $data_palette=DllStructCreate("byte[2024]")   ;256 colors * 4Byte(32Bitcolor)
_palette1()  ;palettendaten in die struct schreiben

global $showpercentfunc = DllCallbackRegister("showpercent", "int", "")  ;aus dem Assemblerprogramm kann man AutoIt-Funktionen aufrufen!
$a=DllCallbackGetPtr($showpercentfunc)

global $bytecode=_build_Asmcode()  ;erstellt den bytecode aus den Assembleranweisungen
;Bytecode: 0x55DBE38BAC2408000000DD8510000000DD8518000000DD8500000000DD8508000000D9C1D9C18BBD280000008B852C0000008B9D30000000F7E3C1E00203C78BD8C7C000000000C7C1000000008B95200000008BB538000000EB34C7C0000000005253AB33D2C7C3FF000000F7F3C1E2028B853C00000003D08B820100000089065B5A81C6040000003BFB75CC5DC3DDD8DDD8D9C3DEC2C7C0000000003B8D2C0000007C2AC7C100000000DDB540000000608B8534000000FFD061DDA540000000D9C2DEC1DD8500000000D9CADDD841D9C1D9C1D9C1D8C8D9C1D8C8DEE9D8C4D9CADEC9D8C0D8C2D9C0D8C8D9C2D8C8DEC1DB9D200000003995200000000F875DFFFFFF3B85240000000F874BFFFFFF40EBC1
;folgende Zeilen sind nur nötig, wenn man direkt den Bytecode (ohne Assembler) ausführen möchte
; only nessecary if you want to run the bytecode without assembler
Global $pMemory = _MemVirtualAlloc(0, stringlen($bytecode)/2, $MEM_COMMIT, $PAGE_EXECUTE_READWRITE)  ;speicher anfordern für den assemblercode, kann auch ausgelagert werden
Global $tCode = DllStructCreate("byte["&stringlen($bytecode)/2&"]", $pMemory)  ;unser Programmcode soll in diesen Speicherbereich
DllStructSetData($tcode, 1, $bytecode)  ;Bytecode des Assemblerprogramms in den reservierten Speicherbereich schreiben

AdlibRegister("_ShowPic", 500)  ;alle 100ms das Bild darstellen

;Daten für die Berechnung, starting parameter
$cx =-0.5				;CenterX : Zentrum der Fläche in x-Richtung
$cy = 0					;Centery : Zentrum der Fläche in y-Richtung
$breite = 5				;die Ausdehnung der Fläche in x-Richtung, y wird proportional angepasst
$tiefe = 100			;Berechnungstiefe, wird je nach zoomfaktor erhöht
$maxiter = 250		;maximale Anzahl der Iterationen, wird je nach zoomfaktor erhöht
$windowsizechanged = 1	;Flag für die Veränderung der Fenstergröße
$zoom=4					;zoomfaktor bei mausclick
;$clics = 0
GUISetState()


While 1
	Sleep(10) ;OnEventmode....
	if $windowsizechanged Then  		;die Fenstergröße wurde geändert
			$windowsizechanged = 0  		;flag für neues fenster setzen
			$winsize=WinGetClientSize($hgui);fenstergröße bestimmen
			$winx=$winsize[0]				;client-width
			$winy=$winsize[1]				;client-height
			If $winy<10 then $winy=10		;falls das Fenster zu klein wird, bleibt immer noch die Bitmap erhalten
			_deletebitmap32($hpicdc,$pointer,$hbitmap);alte bitmap und DC löschen , sets pointer=0, delete hbitmap-object
			_deletebitmap32($hpicDC_palette,$pointer_palette,$hbitmap_palette)
			$hpicDC = _CreateNewBmp32($winx, $winy, $pointer, $hbitmap) ;neue 32-Bit-Bitmap erstellen mit aktueller Fenster-Client-Größe, pointer ist die Startadresse der Bitmapdaten
			$hpicDC_palette = _CreateNewBmp32($winx, $winy, $pointer_palette, $hbitmap_palette) ;neue 32-Bit-Bitmap erstellen mit aktueller Fenster-Client-Größe, pointer ist die Startadresse der Bitmapdaten
			_RenderPic()  ;Grafik erstellen
	endif
		;tooltip(hex(pixelgetcolor(MouseGetPos(0),MouseGetPos(1),$hgui)/2)&"   "&hex($maxiter)&"   "&hex($tiefe))    ;anzeige der Pixelfarbe unter dem Mauszeiger
WEnd


Func _Build_Asmcode()
	AsmReset($AsmObj)

	;hier gehts los^^
	AsmAdd($AsmObj, "	push ebp           		");Basepointer Register sichern, not really needed, there is no registerpressure^^

	AsmAdd($AsmObj, "  	finit	   				");copro init
	AsmAdd($AsmObj, "  	mov  ebp,dword[ESP+08]  ");lade den Inhalt der 2-Byte-Adresse an der position des 1. Elementes der asmstack-struct ins register EBP (pointer auf die struct)
												;EBP ist nun ganz normal zu verwenden und zeigt auf die übergebenen Parameter
	AsmAdd($AsmObj, "  	fld qword[EBP+10]      	");lade die 4 bytes(qword) an der Position Structanfang+10h Bytes in den Coprozessor-Stack  st(0)=stepx
	;Damit man nachvollziehen kann, wie die Berechnung vor sich geht, zeige ich immer den aktuellen Copro-Stack
	;st(0)   =stepx
	AsmAdd($AsmObj, "  	fld qword[EBP+18]       ");st(0)=stepy
	;st(0)   =stepy
	;st(1)   =stepx
	AsmAdd($AsmObj, "  	fld qword[EBP]       	");st(0)=startx=x0 x-position
	;st(0)   =x0
	;st(1)   =stepy
	;st(2)   =stepx
	AsmAdd($AsmObj, "  	fld qword[EBP+08]       ");st(0)=starty y0
	;st(0)   =y0
	;st(1)   =x0
	;st(2)   =stepy
	;st(3)   =stepx
	AsmAdd($AsmObj, "  	fld st(1)       		");st(0)=x
	;st(0)   =x
	;st(1)   =y0
	;st(2)   =x0
	;st(3)   =stepy
	;st(4)   =stepx
	AsmAdd($AsmObj, "  	fld st(1)       		");st(0)=y
	;st(0)   =y
	;st(1)   =x
	;st(2)   =y0
	;st(3)   =x0
	;st(4)   =stepy
	;st(5)   =stepx

	;alle für die Berechnung notwendigen Parameter in die Prozessor-Register eintragen

	AsmAdd($AsmObj, "  	mov edi,dword[EBP+28]   ");startadresse bitmapdaten
	AsmAdd($AsmObj, "  	mov eax,dword[EBP+2c]   ");eax=winwidth
	AsmAdd($AsmObj, "  	mov ebx,dword[EBP+30]   ");ebx=winheight
	AsmAdd($AsmObj, "  	mul ebx    				");eax = winheight*winwidth
	AsmAdd($AsmObj, "  	shl eax,2    			");eax = winheight*winwidth*4 jedes pixel besteht aus 4 Byte
	AsmAdd($AsmObj, "  	add eax,edi    			");eax = Adresse letztes pixel der Bitmap
	AsmAdd($AsmObj, "  	mov ebx,eax				");EBX = Adresse letztes pixel der Bitmap
	AsmAdd($AsmObj, "  	mov eax,0				");EAX = wird die Anzahl der berechneten Iterationen
	AsmAdd($AsmObj, "  	mov ecx,0      			");ECX = counter für Pixelposition in einer Zeile, wenn >width, dann wieder 0
	AsmAdd($AsmObj, "  	mov edx,dword[EBP+20]   ");EDX = tiefe
	AsmAdd($AsmObj, "  	mov esi,dword[EBP+38]	");Pointer auf die 2. Bitmap, diese enthält die durch die Palette umgewandelten Farbpixel
;~ 	AsmAdd($AsmObj, "  	mov eax,esi	")
;~ 	AsmAdd($AsmObj, "	pop ebp					");register wiederherstellen
;~ 	AsmAdd($AsmObj, "  	ret						");Rücksprung nach AutoIt

	AsmAdd($AsmObj, "  	loop:					");Einsprungpunkt für die schleife
	AsmAdd($AsmObj, "  	jmp $+3d				");springe in die Berechnung der Iteration nach @berechnung
	AsmAdd($AsmObj, "  	limit:					");Rücksprungpunkt aus der Berechnung der MAXIteration = EAX, limit erreicht
	AsmAdd($AsmObj, "  	mov eax,0				");Rücksprungpunkt aus der Berechnung der Iteration = EAX , gewissermassen die "Farbe"
	AsmAdd($AsmObj, "  	ergebnis:				");Rücksprungpunkt aus der Berechnung der Iteration = EAX , gewissermassen die "Farbe"

;Hier ist der Rücksprungpunkt der Berechnungsroutine, in EAX steht die Anzahl der Iterationen also gewissermassen die "Farbe"
;EAX (4 Byte)) wird als "Farbe (AABBGGRR auch 4 Byte)" direkt an die Speicherstelle des Pixels geschrieben
;hier könnte man auch direkt auf eine Farbpalette zugreifen oder den EAX-Wert durch Berechnungen anpassen
;allerdings müssen die Adressen der absoluten Vorwärtssprünge (der jmp nach loop: und vor ergebnis:) von Hand angepasst werden => Debugger hilft
	AsmAdd($AsmObj, "   push edx				");EDX sichern auf den Stack   ACHTUNG! Ergebnis von mul ist EDX:EAX!!!! EDX wird verändert !
	AsmAdd($AsmObj, "   push ebx				");uuuuhhhh, registerpressure^^
	AsmAdd($AsmObj, "  	mov dword[EDI],eax	 	");stosd  ^^, speichere EAX an adresse ES:EDI (EDI+4) position des pixels in der bitmap
	;nun in der zweiten Bitmap die Pixelfarbe aus der Palette holen
	AsmAdd($AsmObj, "  	xor edx,edx			 	");EDX=0
	AsmAdd($AsmObj, "  	mov ebx,0FFh	 		");EBX=255
	AsmAdd($AsmObj, "  	div ebx	 				");in EAX steht nun die integerdivision, in EDX steht der Rest! =>edx=modulo(eax,ebx)

	AsmAdd($AsmObj, "  	mov eax,dword[EBP+3C] 	");anfang der palette
	AsmAdd($AsmObj, "  	shl edx,2	 			");edx=edx*4  4 Byte pro Farbe in der palette
	AsmAdd($AsmObj, "  	add edx,eax	 			");Adresse der Farbe in der palette
	AsmAdd($AsmObj, "  	mov eax,dword[edx+01]	");Farbe in der palette
	AsmAdd($AsmObj, "  	mov dword[ESI],eax		");Farbe aus der palette in die 2. Bitmap schreiben

	AsmAdd($AsmObj, "   pop ebx					")
	AsmAdd($AsmObj, "   pop edx					");EDX vom Stack

	AsmAdd($AsmObj, "  	add EDI,4	 			");4 Byte dahinter ist die nächste Pixeladresse(Orginaldaten)
	AsmAdd($AsmObj, "  	add ESI,4	 			");4 Byte dahinter ist die nächste Pixeladresse(2.Bitmap)
	AsmAdd($AsmObj, "  	cmp edi,ebx 			");Vergleich aktuelle Pixeladresse mit der letzten Pixeladresse der Bitmap
	AsmAdd($AsmObj, "  	jne @LOOP				");springe, wenn nicht gleich (Jump if Not Equal) nach loop: , wenn gleich dann sind alle Pixel berechnet

;	AsmAdd($AsmObj, "  	finit	   				");copro init
	AsmAdd($AsmObj, "	pop ebp					");register wiederherstellen
	AsmAdd($AsmObj, "  	ret						");Rücksprung nach AutoIt


	AsmAdd($AsmObj, "  	berechnung:				")
	;stack bereinigen, aktuellex x und y auf den stack
	AsmAdd($AsmObj, "  	fstp st(0)    			");POP stack
	;st(0)   =x
	;st(1)   =y0
	;st(2)   =x0
	;st(3)   =stepy
	;st(4)   =stepx
	AsmAdd($AsmObj, "  	fstp st(0) 				");POP stack
	;st(0)   =y0
	;st(1)   =x0
	;st(2)   =stepy
	;st(3)   =stepx
	;******************x0=x0+stepx
	AsmAdd($AsmObj, "  	fld ST(3)    	        ");st(0)=stepx
	;st(0)   =stepx
	;st(1)   =y0
	;st(2)   =x0
	;st(3)   =stepy
	;st(4)   =stepx
	AsmAdd($AsmObj, "  	faddp ST(2),ST(0)		");st(2)=x0+stepx  POP
	;st(0)   =y0
	;st(1)   =x0+stepx
	;st(2)   =stepy
	;st(3)   =stepx

	AsmAdd($AsmObj, "  	mov eax,0        		");ax = 0

	AsmAdd($AsmObj, "  	cmp ecx,dword[EBP+2C] 	");vgl ecx mit fensterbreite
	AsmAdd($AsmObj, "  	jl $+2c					");wenn micht größer, dann springe zum start1   +2c    16 ohne callback
	AsmAdd($AsmObj, "  	mov ecx,0        		");zähler an den Zeilenanfang der Bitmap
	AsmAdd($AsmObj, "  	fsave [ebp+40]        	");alle Coprozessorregister und den Copro-stack sichern
	AsmAdd($AsmObj, "  	pushad        			");alle Prozessorregister sichern
	AsmAdd($AsmObj, "  	mov eax,dword[EBP+34]	");Adresse der AutoItfunktion in eax laden, evtl Parameter vorher auf den stack pushen
	AsmAdd($AsmOBj, "	call eax				");AutoIt-Funktion aufrufen, erlaubt einen Interrupt, ansonsten wäre das Fenster während der gesamten Berechnung blockiert
	AsmAdd($AsmObj, "  	popad        			");Prozessorregister alle wiederherstellen
	AsmAdd($AsmObj, "  	frstor [ebp+40]        	");coproregister und coprostack wiederherstellen
	AsmAdd($AsmObj, "  	fld ST(2) 				");y0=y0+stepy
	;st(0)   =stepy
	;st(1)   =y0
	;st(2)   =x0
	;st(3)   =stepy
	;st(4)   =stepx
	AsmAdd($AsmObj, "  	faddp ST(1),ST(0) 		");y0=y0+stepy und POP
	;st(0)   =y0+stepy
	;st(1)   =x0
	;st(2)   =stepy
	;st(3)   =stepx
	AsmAdd($AsmObj, "  	fld qword[EBP]        	");ST(0)= startx, die spaltenziffern bleiben immer gleich
	;st(0)   =startx=neues x0
	;st(1)   =y0
	;st(2)   =x0
	;st(3)   =stepy
	;st(4)   =stepx
	AsmAdd($AsmObj, "  	fxch ST(2)        		");tausche st(2) mit st(0)
	;st(0)   =x0
	;st(1)   =y0
	;st(2)   =startx=neues x0
	;st(3)   =stepy
	;st(4)   =stepx
	AsmAdd($AsmObj, "  	fstp st(0) 		     	 ");POP
	;st(0)   =y0
	;st(1)   =x0
	;st(2)   =stepy
	;st(3)   =stepx

	AsmAdd($AsmObj, "  	start1:    	        	");Stack wieder aufbauen für die Berechnung

	AsmAdd($AsmObj, "  	inc ecx        			");ecx=ecx+1 = ein pixel weiter
	AsmAdd($AsmObj, "  	fld ST(1)    	        ");x => st(0)
	;st(0)   =x
	;st(1)   =y0
	;st(2)   =x0
	;st(3)   =stepy
	;st(4)   =stepx
	AsmAdd($AsmObj, "  	fld ST(1)   		    ");y => st(0)
	;st(0)   =y
	;st(1)   =x
	;st(2)   =y0
	;st(3)   =x0
	;st(4)   =stepy
	;st(5)   =stepx

	AsmAdd($AsmObj, "	start:      			");die "innere schleife" , Berechnung von x^2-y^2+x0 und 2*x*y+y0 und vergleich
	AsmAdd($AsmObj, "  	fld ST(1)            	");x => st(0)
	;st(0)   =x
	;st(1)   =y
	;st(2)   =x
	;st(3)   =y0
	;st(4)   =x0
	AsmAdd($AsmObj, "  	fmul ST(0),ST(0)     	");st(0) = x^2
	;st(0)   =x^2
	;st(1)   =y
	;st(2)   =x
	;st(3)   =y0
	;st(4)   =x0
	AsmAdd($AsmObj, "  	fld ST(1)            	"); y=> st(0)
	;st(0)   =y
	;st(1)   =x^2
	;st(2)   =y
	;st(3)   =x
	;st(4)   =y0
	;st(5)   =x0
	AsmAdd($AsmObj, "  	fmul ST(0),ST(0)     	");st(0) = y^2
	;st(0)   =y^2
	;st(1)   =x^2
	;st(2)   =y
	;st(3)   =x
	;st(4)   =y0
	;st(5)   =x0

	AsmAdd($AsmObj, "  	fsubp ST(1),ST(0)     	");st(0) = x^2-y^2
	;st(0)   =x^2-y^2
	;st(1)   =y
	;st(2)   =x
	;st(3)   =y0
	;st(4)   =x0

	AsmAdd($AsmObj, "  	fadd ST(0),ST(4)     	");st(0) = x^2-y^2+x0

	;st(0)   =x^2-y^2+x0
	;st(1)   =y
	;st(2)   =x
	;st(3)   =y0
	;st(4)   =x0
	AsmAdd($AsmObj, "  	fxch ST(2)     			");st(0) = x

	;st(0)   =x
	;st(1)   =y
	;st(2)   =x^2-y^2+x0
	;st(3)   =y0
	;st(4)   =x0

	AsmAdd($AsmObj, "  	fmulp ST(1),ST(0)     	");st(0) = x*y
	;st(0)   =y*x
	;st(1)   =x^2-y^2+x0
	;st(2)   =y0
	;st(3)   =x0

	AsmAdd($AsmObj, "  	fadd ST(0),ST(0)     	");st(0) = x*y+x*y = 2*x*y
	;st(0)   =2*y*x
	;st(1)   =x^2-y^2+x0
	;st(2)   =y0
	;st(3)   =x0

	AsmAdd($AsmObj, "  	fadd ST(0),ST(2)     	");st(0) = x*y+x*y+y = 2*x*y+y0
	;	AsmAdd($AsmObj, "  	jmp  @exit           ");ansonsten wieder zum :start
	;st(0)   =2*y*x+y0      neues y
	;st(1)   =x^2-y^2+x0	neues x
	;st(2)   =y0
	;st(§)   =x0

	AsmAdd($AsmObj, "  	fld ST(0)     			");st(0) = y
	;st(0)   =y
	;st(1)   =2*y*x+y0     neues y
	;st(2)   =x^2-y^2+x0	neues x
	;st(3)   =y0
	;st(4)   =x0

	AsmAdd($AsmObj, "  	fmul ST(0),ST(0)     	");st(0) = y^2
	;st(0)   =y^2
	;st(1)   =2*y*x+y0     neues y
	;st(2)   =x^2-y^2+x0	neues x
	;st(3)   =y0
	;st(4)   =x0
	AsmAdd($AsmObj, "  	fld ST(2)     			");st(0) = x
	;st(0)   =x
	;st(1)   =y^2
	;st(2)   =2*y*x+y0     neues y
	;st(3)   =x^2-y^2+x0	neues x
	;st(4)   =y0
	;st(5)   =x0
	AsmAdd($AsmObj, "  	fmul ST(0),ST(0)     	");st(0) = x^2
	;st(0)   =x^2
	;st(1)   =y^2
	;st(2)   =2*y*x+y0     neues y
	;st(3)   =x^2-y^2+x0	neues x
	;st(4)   =y0
	;st(5)   =x0
	AsmAdd($AsmObj, "  	faddp ST(1),ST(0)     	");st(0) = y^2+x^2
	;AsmAdd($AsmObj, "  	jmp  @exit           ");ansonsten wieder zum :start
	;st(0)   =y^2+x^2
	;st(1)   =2*y*x+y0     neues y
	;st(2)   =x^2-y^2+x0	neues x
	;st(3)   =y0
	;st(4)   =x0

	AsmAdd($AsmObj, "  	fistp dword [EBP+20]  	");aktuellen wert speichern
	;st(1)   =2*y*x+y0      neues y
	;st(2)   =x^2-y^2+x0	neues x
	;st(3)   =y0
	;st(4)   =x0
	AsmAdd($AsmObj, "  	cmp dword[EBP+20],edx	");ist y^2+x^2>tiefe vergleich
	AsmAdd($AsmObj, "  	ja  @ergebnis         	");wenn y^2+x^2 > tiefe  dann farbe=eax ausgeben
	AsmAdd($AsmObj, "  	cmp eax,dword[EBP+24] 	");vgl maxiter mit aktueller iteration
	AsmAdd($AsmObj, "  	ja  @limit         		");wenn größer, dann farbe=0 ausgeben
	AsmAdd($AsmObj, "  	inc eax               	");ax = ax + 1
	AsmAdd($AsmObj, "  	jmp  @start           	");ansonsten wieder zum :start
;ende ASM


	$bindata = String(AsmGetBinary($AsmObj)) 	;bytecode
	$file = FileOpen("mandel_asm.bin", 18)		;in Datei zum debuggen UND um den Inlinecode für den CallWindowProcW()-call zu erhalten!!!
	FileWrite($file, $bindata)
	FileClose($file)

	ConsoleWrite("Assembler Bytecode: "&$bindata & @CRLF)
	Return $bindata    ;der binärcode wird zurückgegeben
EndFunc   ;==>Asm_mandel

Func Asm_mandel($centerx, $centery, $breite, $tiefe, $maxiter, $pointer, $winwidth, $winheight)
	$f=$winwidth/$winheight   ;verhältnis fensterbreite/fensterhöhe
	;Daten in die Struct eintragen, diese Daten werden vom Assemblerprogramm benutzt
	;man kann diese Parameter auch "normal" z.B. per MemoryFuncCall("int:cdecl", AsmGetPtr($AsmObj), "ptr", dllstructgetptr($asmstack),"double",$parameter1,"int",Parameter2.....) aufrufen
	;aber mit dieser Methode hat man den Vorteil, auch DIREKT den Bytecode verwenden zu können, ohne jedes mal den Assembler-Code zu assemblieren
	;ausserdem muss man sich beim Rücksprung nicht um das Aufräumen des Stacks kümmern...
	dllstructsetdata($asmstack,"startx",$centerx-$breite*0.5*(($f-1)*($f>1)+1))  ;abhängig vom verhältnis ist fensterinhalt immer quadratisch, rund um das Zentrum
	dllstructsetdata($asmstack,"starty",$centery-$breite*0.5*((1-$f)*($f>1)+$f)) ;
	dllstructsetdata($asmstack,"stepx",$breite/$winwidth*(($f-1)*($f>1)+1))
	dllstructsetdata($asmstack,"stepy",$breite/$winheight*((1-$f)*($f>1)+$f))
	dllstructsetdata($asmstack,"tiefe", $tiefe)
	dllstructsetdata($asmstack,"maxiter",$maxiter)
	dllstructsetdata($asmstack,"bmpdata",$pointer)  ;zeiger auf die bitmapdaten
	dllstructsetdata($asmstack,"winwidth",$winwidth);fensterbreite
	dllstructsetdata($asmstack,"winheight",$winheight);fensterhöhe
	dllstructsetdata($asmstack,"callback", DllCallbackGetPtr($showpercentfunc));Zeiger auf die Einsprungadresse der AutoIt-Func
	dllstructsetdata($asmstack,"bmppalette",$pointer_palette);fensterhöhe
	dllstructsetdata($asmstack,"palette",DllStructGetPtr($data_palette));fensterhöhe
;entweder kann man nun aus dem Assembler den....
$ret=MemoryFuncCall("int:cdecl", AsmGetPtr($AsmObj), "ptr", dllstructgetptr($asmstack))  ;Assembler aufrufen und Code starten
;_arraydisplay($ret)  ;alle rückgabeparameter ansehen
;ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $ret = ' & hex($ret[0]) & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console

return    ;wer mag, kann das return auskommentieren und den MemoryFuncCall() und dann den unteren Code laufen lassen

;....aufrufen, oder auch die folgende Variante:
;sie hat den Vorteil, daß man den fertigen Bytecode aufrufen kann OHNE den Assembler vorher aufzurufen!
	dllstructsetdata($asmstack,"startx",$centerx-$breite*0.5*(($f-1)*($f>1)+1))  ;abhängig vom verhältnis ist fensterinhalt immer quadratisch, rund um das Zentrum
	dllstructsetdata($asmstack,"starty",$centery-$breite*0.5*((1-$f)*($f>1)+$f)) ;
	dllstructsetdata($asmstack,"stepx",$breite/$winwidth*(($f-1)*($f>1)+1))
	dllstructsetdata($asmstack,"stepy",$breite/$winheight*((1-$f)*($f>1)+$f))
	dllstructsetdata($asmstack,"tiefe", $tiefe)
	dllstructsetdata($asmstack,"maxiter",$maxiter)
	dllstructsetdata($asmstack,"bmpdata",$pointer)  ;zeiger auf die bitmapdaten
	dllstructsetdata($asmstack,"winwidth",$winwidth);fensterbreite
	dllstructsetdata($asmstack,"winheight",$winheight);fensterhöhe
	dllstructsetdata($asmstack,"callback", DllCallbackGetPtr($showpercentfunc))
;da die user32.dll in jedem windows vorhanden ist, benötigt man für das Starten des Bytecodes keine weiteren Dateien
 $ret= DllCall("user32.dll", "int", "CallWindowProcW", "ptr", $pmemory, "ptr", dllstructgetptr($asmstack) , "int", 0, "int", 0, "int", 0); unsere assemblerfunktion wird aufgerufen
 ;_arraydisplay($ret)  alle Übergabeparameter bzw Rückgabeparameter anschauen
endfunc

Func _CreateNewBmp32($iwidth, $iheight, ByRef $ptr, byref $hbmp) ;erstellt leere 32-bit-Bitmap; Rückgabe $HDC und $ptr und handle auf die Bitmapdaten
	$hcdc = _WinAPI_CreateCompatibleDC(0) ;Desktop-Kompatiblen DeviceContext erstellen lassen
	$tBMI = DllStructCreate($tagBITMAPINFO) ;Struktur der Bitmapinfo erstellen und Daten eintragen
	DllStructSetData($tBMI, "Size", DllStructGetSize($tBMI) - 4);Structgröße abzüglich der Daten für die Palette
	DllStructSetData($tBMI, "Width", $iwidth)
	DllStructSetData($tBMI, "Height", -$iheight) ;minus =standard = bottomup
	DllStructSetData($tBMI, "Planes", 1)
	DllStructSetData($tBMI, "BitCount", 32) ;32 Bit = 4 Bytes => AABBGGRR
	$adib = DllCall('gdi32.dll', 'ptr', 'CreateDIBSection', 'hwnd', 0, 'ptr', DllStructGetPtr($tBMI), 'uint', $DIB_RGB_COLORS, 'ptr*', 0, 'ptr', 0, 'uint', 0)
	$hbmp= $adib[0]    ;hbitmap handle auf die Bitmap, auch per GDI+ zu verwenden
	$ptr = $adib[4]    ;pointer auf den Anfang der Bitmapdaten, vom Assembler verwendet
	;_arraydisplay($adib)
	_WinAPI_SelectObject($hcdc, $hbmp) ;objekt hbitmap in DC
	Return $hcdc ;DC der Bitmap zurückgeben
EndFunc   ;==>_CreateNewBmp32

Func _DeleteBitmap32($DC,$ptr,$hbmp)
	_WinAPI_DeleteDC($DC)
	_WinAPI_DeleteObject($hbmp)
	$ptr=0
endfunc


Func _MouseEvents()
	$mouse=GUIGetCursorInfo ($hgui)
	If $mouse[2]  Then ;linke maustaste im Fenster
				$f=$winx/$winy   ;verhältnis fensterbreite/fensterhöhe
				$cx = $cx - $breite * (($f-1)*($f>1)+1)*(0.5 - $mouse[0] / $winx) ;neuer Anfang der Berechnung an der Mausposition für x...
				$cy = $cy - $breite * ((1-$f)*($f>1)+$f)*(0.5 - $mouse[1] / $winy) ;...und y- Koordinate
				$breite = $breite / $zoom ;neue Fenstergröße willkürlich auf 1/$zoom des ursprünglichen Bildes
				$tiefe =int($tiefe* 1.3)
				$maxiter = int($maxiter*1.4)
				$clics += 1
				$count=0
				_RenderPic()
	endif
EndFunc   ;==>_mousepressed

func _RenderPic()
		Opt("GUIOnEventMode", 0) ;oneventmode ausschalten, es soll verhindert werden, daß während des bildaufbaus die gui verändert wird
		if $breite<1e-17 then msgbox(0,"Apfelmaennchen","Eine weitere Vergrößerung könnte infolge der Bereichunterschreitung für 64-Bit-Fließkommazahlen zu unvorhersehbaren Ergebnissen führen :o) ")
		$t=timerinit()

		$g = Asm_mandel($cx, $cy, $breite, $tiefe, $maxiter, $pointer, $winx, $winy)  ;Assemblercode aufrufen, Bitmap wird im Speicher erstellt
		$m=timerdiff($t)
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $m = ' & $m & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console
		_showpic()
		Opt("GUIOnEventMode", 1)
		WinSetTitle($hgui, "","Apfelmaennchen by Andy (www.AutoIt.de)")
		;WinSetTitle($hgui, "", $cx & "   " & $cy & "   " & $breite & "  " & $tiefe & "   " & $maxiter & "   " & $clics &"  "&$winx&"  "&$winy& " Apfelmännchen :" & Int(TimerDiff($t) & " milli-Sekunden  ")) ;Zeit in der Titelleiste anzeigen
endfunc


Func _ShowPic()
	_WinAPI_BitBlt($hwinDC, 0, 0, $winx, $winy, $hpicDC_palette, 0, 0, $srccopy) ;Bitmap in GUI kopieren
EndFunc   ;==>show

func showpercent()  ;Wird aus dem Assemblerprogramm aufgerufen, erlaubt Interrupt, ansonsten ist das Fenster für den Zeitraum der Berechnung blockiert!
	$count+=1  ;zähler für den Fortschritt der Berechnung
	;nur jeden 10. Aufruf ans Fenster weitergeben, sonst wird zu sehr gebremst^^
 	if $count/10=int($count/10) then _WinAPI_SetWindowText($hgui,"Berechnung läuft, bitte warten...."&int($count*100/$winy)&"%")

;~ 	if _WinAPI_GetForegroundWindow()<>$hgui then
;~ 		$minimized=1
;~ 		$minimizedrender=1  ;falls während der Berechnung minimiert wurde, funktioniert nicht! Windows minimiert das Fenster, in jeder liste wird es aber als aktiv geführt!
;~ 	endif
	;eventuelle Returnwerte können natürlich vom Assembler ausgewertet werden
endfunc


Func _WindowEvents()  ;Fenstergröße geändert usw
;	MsgBox(262144,'Debug line ~' & @ScriptLineNumber,'Selection:' & @lf & '$isrendering' & @lf & @lf & 'Return:' & @lf & $isrendering) ;### Debug MSGBOX
    Switch @GUI_CtrlId    ;je nach event
        Case $GUI_EVENT_CLOSE   ;GUI geschlossen
			AsmExit($AsmObj)
			_MemVirtualFree($pMemory, 512, $MEM_RELEASE) ;speicher für assemblerdaten freigeben
			_WinAPI_Deleteobject($hbitmap)   	;bitmap löschen
			_WinAPI_DeleteDC($hpicDC)			;DC der Bitmap  freigeben
			_WinAPI_ReleaseDC(0, $hdc)			;
			Exit

        Case $GUI_EVENT_MINIMIZE  ;GUI minimiert
			$minimized=1

		Case $GUI_EVENT_MAXIMIZE  ;GUI maximiert
			$count=0
			$windowsizechanged=1

        Case $GUI_EVENT_RESTORE	;GUI wiederhergestellt
			$count=0
			if $minimized then
				$minimized=0
				$windowsizechanged=0
			Else
				$windowsizechanged=1
			endif

		 Case $GUI_EVENT_RESIZED	;GUI Größe verändert
			 ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $GUI_EVENT_RESIZED = ' & $GUI_EVENT_RESIZED & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console
			ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $contextflag = ' & $contextflag & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console
			if $contextflag=1 then  ;manchmal bekommt das GUI vom Contextmenü ein RESIZED-Event.....
				$windowsizechanged=0
				$contextflag=0
			 	$count=0
			else
;~ 				if $minimized and $minimizedrender then  ;wenn während der Berechnung minimiert wurde, Funktioniert nicht!
;~ 					$minimized=0
;~ 					$windowsizechanged=0
;~ 					$minimizedrender=0
;~ 				Else
					$count=0
					$windowsizechanged=1
;~ 				endif
			endif
    EndSwitch
EndFunc   ;==>SpecialEvents

func _SavePic()  ;speichert Bild und die aktuellen Koordinaten in einer Datei
	$contextflag=1
	$path=FileSaveDialog("Datei speichern", @ScriptDir, "(*.jpg;*.bmp;*.png)", 16)
	If @error Then Return
	if Stringmid($path,stringlen($path)-3,1)<>"." then $path&=".JPG"
	_ScreenCapture_SaveImage($path,$hbitmap_palette)
	$path=stringleft($path,stringinstr($path,"\",1,-1))&"fractalsave.dat"
	$file=Fileopen($Path,9)
	if @error then return Msgbox(0,"Apfelmaennchen-ERROR","Can not open datafile "&$path&"\fractalsave.dat")
	FileWriteLine($file,$path)
	FileWriteLine($file,"cx="&$cx)
	FileWriteLine($file,"cy="&$cy)
	FileWriteLine($file,"breite="&$breite)
	FileWriteLine($file,"tiefe="&$tiefe)
	FileWriteLine($file,"maxiter="&$maxiter)
	FileWriteLine($file,";*****************************")
	fileclose($file)
	$contextflag=0
endfunc


func _PicBack()  ;contextmenu Bild zurück
$contextflag=1
	_showpic()
		$breite = $breite * $zoom ;neue Fenstergröße willkürlich auf 1/$zoom des ursprünglichen Bildes
		$tiefe =int($tiefe/ 1.3)
		$maxiter = int($maxiter/1.4)
		$windowsizechanged=1
$contextflag=0
endfunc


func _FlightRender()  ;Contextmenu Flug rendern
	$contextflag=1
	_showpic()
	tooltip("Coming soon :o)")
	sleep(1000)
	tooltip("")
	$contextflag=0
endfunc

func _Loadpic()  ;contextmenu Bild laden, bzw Koordinaten aus  Datei
	$contextflag=1
	_showpic()
	tooltip("Coming soon :o)")
	sleep(1000)
	tooltip("")
	$contextflag=0
endfunc

func _zoom2()  ;zoomen 2x
	$contextflag=1
	$zoom=2
	$contextflag=0
endfunc

func _zoom3() ;zoomen 3x
	$contextflag=1
	$zoom=3
	$contextflag=0
endfunc

func _zoom4() ;zoomen 4x
	$contextflag=1
	$zoom=4
	$contextflag=0
endfunc

func _Palette1()
	$palette="0x0000000000000003000000070000000B0000000F00000013000000170000001B0000001F00000023000000270000002B0000002F00000033000000370000003B0000003F00000043000000470000004B0000004F00000053000000570000005B0000005F00000063000000670000006B0000006F00000073000000770000007B0000007F00000083000000870000008B0000008F00000093000000970000009B0000009F000000A3000000A7000000AB000000AF000000B3000000B7000000BB000000BF000000C3000000C7000000CB000000CF000000D3000000D7000000DB000000DF000000E3000000E7000000EB000000EF000000F3000000F7000000FB000000FF000003FF000007FF00000BFF00000FFF000013FF000017FF00001BFF00001FFF000023FF000027FF00002BFF00002FFF000033FF000037FF00003BFF00003FFF000043FF000047FF00004BFF00004FFF000053FF000057FF00005BFF00005FFF000063FF000067FF00006BFF00006FFF000073FF000077FF00007BFF00007FFF000083FF000087FF00008BFF00008FFF000093FF000097FF00009BFF00009FFF0000A3FF0000A7FF0000ABFF0000AFFF0000B3FF0000B7FF0000BBFF0000BFFF0000C3FF0000C7FF0000CBFF0000CFFF0000D3FF0000D7FF0000DBFF0000DFFF0000E3FF0000E7FF0000EBFF0000EFFF0000F3FF0000F7FF0000FBFF0000FFFF0003FFFF0007FFFF000BFFFF000FFFFF0013FFFF0017FFFF001BFFFF001FFFFF0023FFFF0027FFFF002BFFFF002FFFFF0033FFFF0037FFFF003BFFFF003FFFFF0043FFFF0047FFFF004BFFFF004FFFFF0053FFFF0057FFFF005BFFFF005FFFFF0063FFFF0067FFFF006BFFFF006FFFFF0073FFFF0077FFFF007BFFFF007FFFFF0083FFFF0087FFFF008BFFFF008FFFFF0093FFFF0097FFFF009BFFFF009FFFFF00A3FFFF00A7FFFF00ABFFFF00AFFFFF00B3FFFF00B7FFFF00BBFFFF00BFFFFF00C3FFFF00C7FFFF00CBFFFF00CFFFFF00D3FFFF00D7FFFF00DBFFFF00DFFFFF00E3FFFF00E7FFFF00EBFFFF00EFFFFF00F3FFFF00F7FFFF00FBFFFF00FFFFFF00FBFBFB00F7F7F700F3F3F300EFEFEF00EBEBEB00E7E7E700E3E3E300DFDFDF00DBDBDB00D7D7D700D3D3D300CFCFCF00CBCBCB00C7C7C700C3C3C300BFBFBF00BBBBBB00B7B7B700B3B3B300AFAFAF00ABABAB00A7A7A700A3A3A3009F9F9F009B9B9B0097979700939393008F8F8F008B8B8B0087878700838383007F7F7F007B7B7B0077777700737373006F6F6F006B6B6B0067676700636363005F5F5F005B5B5B0057575700535353004F4F4F004B4B4B0047474700434343003F3F3F003B3B3B0037373700333333002F2F2F002B2B2B0027272700232323001F1F1F001B1B1B0017171700131313000F0F0F000B0B0B0007070700030303"
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $palette = ' & stringlen($palette) & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console
;$palette="0x0000000000000003000000070000000B0000000F00000013000000170000001B0000001F00000023000000270000002B0000002F00000033000000370000003B0000003F00000043000000470000004B0000004F00000053000000570000005B0000005F00000063000000670000006B0000006F00000073000000770000007B0000007F00000083000000870000008B0000008F00000093000000970000009B0000009F000000A3000000A7000000AB000000AF000000B3000000B7000000BB000000BF000000C3000000C7000000CB000000CF000000D3000000D7000000DB000000DF000000E3000000E7000000EB000000EF000000F3000000F7000000FB000000FF000003FF000007FF00000BFF00000FFF000013FF000017FF00001BFF00001FFF000023FF000027FF00002BFF00002FFF000033FF000037FF00003BFF00003FFF000043FF000047FF00004BFF00004FFF000053FF000057FF00005BFF00005FFF000063FF000067FF00006BFF00006FFF000073FF000077FF00007BFF00007FFF000083FF000087FF00008BFF00008FFF000093FF000097FF00009BFF00009FFF0000A3FF0000A7FF0000ABFF0000AFFF0000B3FF0000B7FF0000BBFF0000BFFF0000C3FF0000C7FF0000CBFF0000CFFF0000D3FF0000D7FF0000DBFF0000DFFF0000E3FF0000E7FF0000EBFF0000EFFF0000F3FF0000F7FF0000FBFF0000FFFF0003FFFF0007FFFF000BFFFF000FFFFF0013FFFF0017FFFF001BFFFF001FFFFF0023FFFF0027FFFF002BFFFF002FFFFF0033FFFF0037FFFF003BFFFF003FFFFF0043FFFF0047FFFF004BFFFF004FFFFF0053FFFF0057FFFF005BFFFF005FFFFF0063FFFF0067FFFF006BFFFF006FFFFF0073FFFF0077FFFF007BFFFF007FFFFF0083FFFF0087FFFF008BFFFF008FFFFF0093FFFF0097FFFF009BFFFF009FFFFF00A3FFFF00A7FFFF00ABFFFF00AFFFFF00B3FFFF00B7FFFF00BBFFFF00BFFFFF00C3FFFF00C7FFFF00CBFFFF00CFFFFF00D3FFFF00D7FFFF00DBFFFF00DFFFFF00E3FFFF00E7FFFF00EBFFFF00EFFFFF00F3FFFF00F7FFFF00FBFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF"
	DllStructSetData($data_palette,1,$palette)
	$contextflag=0
endfunc

func _Palette2()
	$palette="0x00000000000003000000070000000B0000000F00000013000000170000001B0000001F00000023000000270000002B0000002F00000033000000370000003B0000003F00000043000000470000004B0000004F00000053000000570000005B0000005F00000063000000670000006B0000006F00000073000000770000007B0000007F00000083000000870000008B0000008F00000093000000970000009B0000009F000000A3000000A7000000AB000000AF000000B3000000B7000000BB000000BF000000C3000000C7000000CB000000CF000000D3000000D7000000DB000000DF000000E3000000E7000000EB000000EF000000F3000000F7000000FB000000FF000003FF000007FF00000BFF00000FFF000013FF000017FF00001BFF00001FFF000023FF000027FF00002BFF00002FFF000033FF000037FF00003BFF00003FFF000043FF000047FF00004BFF00004FFF000053FF000057FF00005BFF00005FFF000063FF000067FF00006BFF00006FFF000073FF000077FF00007BFF00007FFF000083FF000087FF00008BFF00008FFF000093FF000097FF00009BFF00009FFF0000A3FF0000A7FF0000ABFF0000AFFF0000B3FF0000B7FF0000BBFF0000BFFF0000C3FF0000C7FF0000CBFF0000CFFF0000D3FF0000D7FF0000DBFF0000DFFF0000E3FF0000E7FF0000EBFF0000EFFF0000F3FF0000F7FF0000FBFF0000FFFF0003FFFF0007FFFF000BFFFF000FFFFF0013FFFF0017FFFF001BFFFF001FFFFF0023FFFF0027FFFF002BFFFF002FFFFF0033FFFF0037FFFF003BFFFF003FFFFF0043FFFF0047FFFF004BFFFF004FFFFF0053FFFF0057FFFF005BFFFF005FFFFF0063FFFF0067FFFF006BFFFF006FFFFF0073FFFF0077FFFF007BFFFF007FFFFF0083FFFF0087FFFF008BFFFF008FFFFF0093FFFF0097FFFF009BFFFF009FFFFF00A3FFFF00A7FFFF00ABFFFF00AFFFFF00B3FFFF00B7FFFF00BBFFFF00BFFFFF00C3FFFF00C7FFFF00CBFFFF00CFFFFF00D3FFFF00D7FFFF00DBFFFF00DFFFFF00E3FFFF00E7FFFF00EBFFFF00EFFFFF00F3FFFF00F7FFFF00FBFFFF00FFFFFF00FBFBFB00F7F7F700F3F3F300EFEFEF00EBEBEB00E7E7E700E3E3E300DFDFDF00DBDBDB00D7D7D700D3D3D300CFCFCF00CBCBCB00C7C7C700C3C3C300BFBFBF00BBBBBB00B7B7B700B3B3B300AFAFAF00ABABAB00A7A7A700A3A3A3009F9F9F009B9B9B0097979700939393008F8F8F008B8B8B0087878700838383007F7F7F007B7B7B0077777700737373006F6F6F006B6B6B0067676700636363005F5F5F005B5B5B0057575700535353004F4F4F004B4B4B0047474700434343003F3F3F003B3B3B0037373700333333002F2F2F002B2B2B0027272700232323001F1F1F001B1B1B0017171700131313000F0F0F000B0B0B000707070003030300"
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $palette = ' & stringlen($palette) & @crlf & '>Error code: ' & @error & @crlf) ;### Debug Console
;$palette="0x0000000000000003000000070000000B0000000F00000013000000170000001B0000001F00000023000000270000002B0000002F00000033000000370000003B0000003F00000043000000470000004B0000004F00000053000000570000005B0000005F00000063000000670000006B0000006F00000073000000770000007B0000007F00000083000000870000008B0000008F00000093000000970000009B0000009F000000A3000000A7000000AB000000AF000000B3000000B7000000BB000000BF000000C3000000C7000000CB000000CF000000D3000000D7000000DB000000DF000000E3000000E7000000EB000000EF000000F3000000F7000000FB000000FF000003FF000007FF00000BFF00000FFF000013FF000017FF00001BFF00001FFF000023FF000027FF00002BFF00002FFF000033FF000037FF00003BFF00003FFF000043FF000047FF00004BFF00004FFF000053FF000057FF00005BFF00005FFF000063FF000067FF00006BFF00006FFF000073FF000077FF00007BFF00007FFF000083FF000087FF00008BFF00008FFF000093FF000097FF00009BFF00009FFF0000A3FF0000A7FF0000ABFF0000AFFF0000B3FF0000B7FF0000BBFF0000BFFF0000C3FF0000C7FF0000CBFF0000CFFF0000D3FF0000D7FF0000DBFF0000DFFF0000E3FF0000E7FF0000EBFF0000EFFF0000F3FF0000F7FF0000FBFF0000FFFF0003FFFF0007FFFF000BFFFF000FFFFF0013FFFF0017FFFF001BFFFF001FFFFF0023FFFF0027FFFF002BFFFF002FFFFF0033FFFF0037FFFF003BFFFF003FFFFF0043FFFF0047FFFF004BFFFF004FFFFF0053FFFF0057FFFF005BFFFF005FFFFF0063FFFF0067FFFF006BFFFF006FFFFF0073FFFF0077FFFF007BFFFF007FFFFF0083FFFF0087FFFF008BFFFF008FFFFF0093FFFF0097FFFF009BFFFF009FFFFF00A3FFFF00A7FFFF00ABFFFF00AFFFFF00B3FFFF00B7FFFF00BBFFFF00BFFFFF00C3FFFF00C7FFFF00CBFFFF00CFFFFF00D3FFFF00D7FFFF00DBFFFF00DFFFFF00E3FFFF00E7FFFF00EBFFFF00EFFFFF00F3FFFF00F7FFFF00FBFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF"
	DllStructSetData($data_palette,1,$palette)
	$contextflag=0
endfunc
