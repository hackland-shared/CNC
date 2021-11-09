+================================================
+ Original code from: https://jtechphotonics.com/?p=3851                                                                                                
+ Mach2/3 - Vectric machine output configuration file   
+    C:\ProgramData\Vectric\Aspire\V8.0\My_Post                                              
+================================================
+                                                
+ History                                        
+                                                
+ Who      When       What                         
+ ======== ========== ===========================
+ Tony     15/11/2005 Written for metric
+ Tony     06/01/2006 Added ATC option      
+ Tony     14/05/2006 Fixed G21 mm in header   
+ Tony     24/07/2006 Added G2 & G3 Arc support + removed (( )) 
+ Tony     18/06/2007 Replaced the Tool comment     
+ Mark     14/08/2008 Added G1 to Feed moves,
+ Mark     28/08/2009 Added G91.1 to force use of incremental arcs
+ Mark     30/11/2009 Added TOOLPATHS_OUTPUT.
+ Brian    15/12/2009 Remove M05 from NEW_SEGMENT
+ Mark     18/01/2014 Added Dwell
+ Cameron  07/01/2017 Added M311/M312 codes - turn on/off pumps
+================================================

POST_NAME = "Mach2/3 Arcs (mm) - MechMate #74 (*.txt)"

FILE_EXTENSION = "txt"

UNITS = "MM"

DIRECT_OUTPUT = "Mach|Mach4.Document"

SUBSTITUTE = "({)}"

+------------------------------------------------
+    Line terminating characters                 
+------------------------------------------------

LINE_ENDING = "[13][10]"

+------------------------------------------------
+    Block numbering                             
+------------------------------------------------

LINE_NUMBER_START     = 0
LINE_NUMBER_INCREMENT = 10
LINE_NUMBER_MAXIMUM = 999999

+================================================
+                                                
+    Formating for variables                     
+                                                
+================================================

VAR LINE_NUMBER = [N|A|N|1.0]
VAR SPINDLE_SPEED = [S|A|S|1.0]
VAR FEED_RATE = [F|C|F|1.1]
VAR X_POSITION = [X|C|X|1.3]
VAR Y_POSITION = [Y|C|Y|1.3]
VAR Z_POSITION = [Z|C|Z|1.3]
VAR ARC_CENTRE_I_INC_POSITION = [I|A|I|1.3]
VAR ARC_CENTRE_J_INC_POSITION = [J|A|J|1.3]
VAR X_HOME_POSITION = [XH|A|X|1.3]
VAR Y_HOME_POSITION = [YH|A|Y|1.3]
VAR Z_HOME_POSITION = [ZH|A|Z|1.3]
VAR SAFE_Z_HEIGHT = [SAFEZ|A|Z|1.3]
VAR DWELL_TIME = [DWELL|A|P|1.2]
+================================================
+                                                
+    Block definitions for toolpath output       
+                                                
+================================================

+---------------------------------------------------
+  Commands output at the start of the file
+---------------------------------------------------

begin HEADER

"( [TP_FILENAME] )"
"( File created: [DATE] - [TIME])"
"( for Mach2/3 from Vectric - Modified C. Stewart 7/1/2017 )"
"( Material Size)"
"( X= [XLENGTH], Y= [YLENGTH], Z= [ZLENGTH])"
"([FILE_NOTES])"
"(Toolpaths used in this file:)"
"([TOOLPATHS_OUTPUT])"
"(Tools used in this file: )"
"([TOOLS_USED])"
"(G00 = Rapid straigh mvmt. G21 = Co-ords in 'mm'. G17 = Select X-Y plane.)"
"(G90 = Abs co-ords. G40 = Tool rad compensation off. G49 = Tool len compensation off.)"
"(G80 = Cancel canned cycle. -CS)"
"[N]G00G21G17G90G40G49G80"
"(G71 = Roughing canned cycles??? G91.1 = Incremental programming of IJK)"
"[N]G71G91.1"
"(Turning on pumps -CS)"
"[N]M311"
"[N]T[T]M06"
"[N] ([TOOLNAME])"
"(G43 = Apply tool len compensation)"
"[N]G00G43[ZH]H[T]"
"[N][S]M03"
"[N](Toolpath:- [TOOLPATH_NAME])"
"[N]([TOOLPATH_NOTES])"
"(Units per minute feed mode - with G21, mm/minute)"
"[N]G94"
"[N][XH][YH][F]"


+---------------------------------------------------
+  Commands output for rapid moves 
+---------------------------------------------------

begin RAPID_MOVE

"[N]G00[X][Y][Z]"


+---------------------------------------------------
+  Commands output for the first feed rate move
+---------------------------------------------------

begin FIRST_FEED_MOVE

"[N]G1[X][Y][Z][F]"


+---------------------------------------------------
+  Commands output for feed rate moves
+---------------------------------------------------

begin FEED_MOVE

"[N]G1[X][Y][Z]"

+---------------------------------------------------
+  Commands output for the first clockwise arc move
+---------------------------------------------------

begin FIRST_CW_ARC_MOVE

"[N]G2[X][Y][I][J][F]"

+---------------------------------------------------
+  Commands output for clockwise arc  move
+---------------------------------------------------

begin CW_ARC_MOVE

"[N]G2[X][Y][I][J]"

+---------------------------------------------------
+  Commands output for the first counterclockwise arc move
+---------------------------------------------------

begin FIRST_CCW_ARC_MOVE

"[N]G3[X][Y][I][J][F]"

+---------------------------------------------------
+  Commands output for counterclockwise arc  move
+---------------------------------------------------

begin CCW_ARC_MOVE

"[N]G3[X][Y][I][J]"

+---------------------------------------------------
+  Commands output for a new segment - toolpath
+  with same toolnumber but maybe different feedrates
+---------------------------------------------------

begin NEW_SEGMENT

"[N][S]M03"
"([TOOLPATH_NAME])"
"([TOOLPATH_NOTES])"

+---------------------------------------------
+  Commands output for a dwell move
+---------------------------------------------

begin DWELL_MOVE

"G04 [DWELL]"

+---------------------------------------------------
+  Commands output at the end of the file
+---------------------------------------------------

begin FOOTER

"(Move to ZHome)"
"[N]G00[ZH]"
"(Move to XHome and YHome)"
"[N]G00[XH][YH]"
"(M09 = Coolant off)"
"[N]M09"
"(Turn off pumps)"
"[N]M312"
"[N]M30"
%


