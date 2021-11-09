+================================================
+ Original code from: https://jtechphotonics.com/?p=3851                                                
+ Vectric machine output configuration file   
+  C:\ProgramData\Vectric\Aspire\V8.0\My_Post                                          
+================================================
+                                                
+ History                                        
+                                                  
+ Who      When       What                         
+ ======== ========== ===========================
+ PaulW    01/20/2016 turn Spindle off during rapids
+ EdwardP  11/02/2015 Written from Grbl_mm.pp but
+                     set G20
+ EdwardP  11/02/2015 Commented out arcs as these
+                     slow GRBL performance appear 
+                     interpolated anyway
+ Jay	   16/6/2016  Laser support and remove Z
+ C. Stew  07/01/2018 Added comments - Added G55 work offset to the header, Updated laser on/off M301/M302
+================================================
+ LASER WIRING AND CONFIGURATION NOTES: 
+ M301/M302 are custom 'M' Codes for turing a relay on/off supplying a laser module with power
+ M303/M304 are custom 'M' Codes activating/deactivating an ouput pin on the CNC driver board and signaling the laser module PWM. 
+ In mach3 you must configure the outputs to match the output names called in the 'M' scripts

POST_NAME = "Mach3 Laser / Modified No Z / M301 M302 M303 M304  - MechMate #74  (mm) (*.txt)"
 
FILE_EXTENSION = ".txt"
 
UNITS = "MM"
 
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
VAR X_POSITION = [X|C|X|1.4]
VAR Y_POSITION = [Y|C|Y|1.4]
+VAR Z_POSITION = [Z|C|Z|1.4]
VAR ARC_CENTRE_I_INC_POSITION = [I|A|I|1.4]
VAR ARC_CENTRE_J_INC_POSITION = [J|A|J|1.4]
VAR X_HOME_POSITION = [XH|A|X|1.4]
VAR Y_HOME_POSITION = [YH|A|Y|1.4]
+VAR Z_HOME_POSITION = [ZH|A|Z|1.4]
 
+================================================
+                                                
+    Block definitions for toolpath output       
+                                                
+================================================
 
+---------------------------------------------------
+  Commands output at the start of the file
+---------------------------------------------------
 
begin HEADER

("Turn on laser relay")
"M301"
"T1"
"G17"
"G21"
"(Best Path Speed)"
"G64"
"(G55 = Co-ordinate offset for the laser on the table)"
"(X - distance from homed head to corner of table PLUS x offset )"
+"G0[ZH]"
"G0[XH][YH]"
"(clear old G92 offset)"
"G92.1"
"(set G92 offset - LASER)"
"G92 X252 Y-83.5"

 
 
+---------------------------------------------------
+  Commands output for rapid moves 
+---------------------------------------------------
 
begin RAPID_MOVE
 
"G0[X][Y]"
 
 
+---------------------------------------------------
+  Commands output for the first feed rate move
+---------------------------------------------------
 
begin FIRST_FEED_MOVE
 
"G1[X][Y][F]M303"
 
 
+---------------------------------------------------
+  Commands output for feed rate moves
+---------------------------------------------------
 
begin FEED_MOVE
 
"G1[X][Y]M303"
 
 
+---------------------------------------------------
+  Commands output for the first clockwise arc move
+---------------------------------------------------

+begin FIRST_CW_ARC_MOVE

+"G2[X][Y][I][J][F]M303"
 
 
+---------------------------------------------------
+  Commands output for clockwise arc  move
+---------------------------------------------------
 
+begin CW_ARC_MOVE
 
+"G2[X][Y][I][J]M303"
 
 
+---------------------------------------------------
+  Commands output for the first counterclockwise arc move
+---------------------------------------------------
 
+begin FIRST_CCW_ARC_MOVE
 
+"G3[X][Y][I][J][F]M303"
 
 
+---------------------------------------------------
+  Commands output for counterclockwise arc  move
+---------------------------------------------------
 
+begin CCW_ARC_MOVE
 
+"G3[X][Y][I][J]M303"
 
 
+ ---------------------------------------------------
+  Commands output for Retract Moves
+ ---------------------------------------------------
begin RETRACT_MOVE

"M304"
"G4 P0"


+---------------------------------------------------
+  Commands output at the end of the file
+---------------------------------------------------
 
begin FOOTER


"M304"
"(Reset offset co-ordinates)"
"G92.1"
+"G0[ZH]"
"G0[XH][YH]"
"(Turn off Laser relay)" 
"M302"
"M30"
