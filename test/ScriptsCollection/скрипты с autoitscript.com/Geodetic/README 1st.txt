HTMLHELP UDF (v1.1, April/11)


Thanks for downloading the HtmlHelp UDF!  I hope it is useful in creating your own help system for AutoIt applications.


ZIP contents
============
README.txt		- this file
HtmlHelp.au3		- the UDF, fully 'documented' internally; I'm hoping it might
			  (oneday) be accepted as a full-fledged UDF.
HtmlHelp_demo.au3	- a simple demo file
HtmlHelp UDF.chm	- a compiled HTML file which:
				o  further documents the UDF functions, demo, etc.
				o  is necessary for the demo program!
			  Make sure that the CHM file is in the same folder as the
			  demo and UDF file.
Example files.zip	- these are the example files which should be included with a
			  submission to AutoIt for inclusion as a UDF.

About the UDF
=============
The AutoIt forums contain some efforts by others to implement popup help, etc., but this UDF is a 'proper' implementation of the hhctrl.ocx ActiveX help control, which would be used to implement the help system in a non-scripting compiler (eg. C++, Visual Basic).  By 'proper', I mean
	o  it doesn't crash! (if everything is done right).  I read a few cries for
	   help on the forums, such as "help window opens, but immediately causes
	   a GPF and crashes - why?"
	o  it provides access to all of the HTML Help system commands (some may not be
	   implemented because they will be rarely used).

While the UDF may not be the 'full' implementation, and some functions may not be possible due the restraints of scripting, it DOES provide functionality to implement:
	- opening help using 'topicIDs' (an integer linked to a topic),
	- opening help using 'topicURLs' (a 'path' to a page in the help file),
	- 3 different kinds of pop-up windows (explicit text, resources, topicIDs),
	- tab control in the navigation panel (if it exists in your help file), and
	- enough support functions to make your application WHIZ-BANG!
Of course, the creation of the actual help file (CHM) is up to you, but Microsoft provides the tools (the HTML Help Workshop - free!) to do so.  The demo/documentation help file enclosed in this package will shed a little light (I hope!) on this subject.


Source code for the CHM
=======================
The UDF package (zip file) does not 'appear' to include a copy of the source, BUT, I have embedded all source files (normally missing from the CHM) which can be used to recompile the help file.  The help file IS the source!  The 7-Zip archiver (see "About This File" in the CHM) can extract ALL files necessary to recompile.  You can inspect the methods used for creation (eg. inclusion of topicIDs, some variations on Index entries) and implement them in your own help file.  Note that extracting all files also yields some 'extraneous' files (created by the compilation process), notably:
	- $WWAssociativeLinks folder (and contents)
	- $WWKeywordLinks folder (and contents)
	- any file starting with "#" or "$"
These folders/files may be safely deleted after extraction.

Have fun creating help!

- Allen Titley (aka Geodetic)
