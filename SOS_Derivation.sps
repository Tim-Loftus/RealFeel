* Encoding: windows-1252.
COMMENT Use METAR_20YRNORMS.sav.
GET FILE ='W:\D3_Express\ArcMap\RealFeel_Season\Tables\METAR_20YRNORMS.sav'.
EXECUTE.
COMMENT Translate into Numeric.
COMPUTE MONTH = 0.
IF MON = "JAN" MONTH =1.
IF MON = "FEB" MONTH =2.
IF MON = "MAR" MONTH =3. 
IF MON = "APR" MONTH =4. 
IF MON = "MAY" MONTH =5.
IF MON = "JUN" MONTH =6.
IF MON = "JUL" MONTH =7.
IF MON = "AUG" MONTH =8. 
IF MON = "SEP" MONTH =9. 
IF MON = "OCT" MONTH =10.
IF MON = "NOV" MONTH =11. 
IF MON = "DEC" MONTH =12.
EXECUTE.
COMMENT Create Season Variables.
COMPUTE SEASON = 0.
IF MONTH= 11 OR MONTH = 12 OR MONTH= 1 SEASON =1.
IF MONTH = 3 OR MONTH = 2 OR MONTH= 4 SEASON =2.
IF MONTH = 6 OR MONTH = 7 OR MONTH= 5 SEASON =3. 
IF MONTH = 9 OR MONTH = 10 OR MONTH = 8 SEASON =4.
EXECUTE.
COMMENT Aggregate data by Season and METAR.
DATASET ACTIVATE DataSet2.
DATASET DECLARE agg_sos.
AGGREGATE
  /OUTFILE='agg_sos'
  /BREAK=METAR SEASON LON LAT
  /NORM_HIGH_median=MEDIAN(NORM_HIGH).
COMMENT Rename Variable. 
DATASET ACTIVATE agg_sos.
RENAME VARIABLES (NORM_HIGH_median = TEMP_THRESHOLD).
EXECUTE.
COMMENT Save File.
SAVE OUTFILE='W:\D3_Express\ArcMap\RealFeel_Season\Tables\METAR_SOS_THRESHOLDS.sav'
  /COMPRESSED.
COMMENT Convert to DBF File.
SAVE TRANSLATE OUTFILE='W:\D3_Express\ArcMap\RealFeel_Season\Tables\METAR_SOS_THRESHOLDS.dbf'
  /TYPE=DBF
  /VERSION=4
  /MAP
  /REPLACE.
