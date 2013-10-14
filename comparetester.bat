@ECHO OFF
SET DoW=Wed

IF EXIST current.csv DEL current.csv
IF EXIST realcurrent.csv DEL realcurrent.csv

setlocal EnableDelayedExpansion
REM 1 (%%S)- Store Number
REM day 2 (%%T)- Fri
REM day 3 (%%U)- Sat
REM day 4 (%%V)- Sun
REM day 5 (%%W)- Mon
REM day 6 (%%X)- Tue
REM day 7 (%%Y)- Wed
REM day 8 (%%Z)- Thu
:compare
IF %DoW%==Tue (
	IF EXIST parsed_Mon.csv (
		SET tokentot=5
		FOR /F "tokens=1,2,3,4 delims=," %%S IN (parsed_Mon.csv) DO (
			SET found=0
			SET day2_prevX=%%T
			SET day2_prev=!day2_prevX: =O!
			SET day3_prevX=%%U
			SET day3_prev=!day3_prevX: =O!
			SET day4_prevX=%%V
			SET day4_prev=!day4_prevX: =O!
			FOR /F "tokens=1,2,3,4,5,6 delims=," %%s IN (parsed_Tue.csv) DO (
				SET day2_curX=%%t
				SET day2_cur=!day2_curX: =O!
				SET day3_curX=%%u
				SET day3_cur=!day3_curX: =O!
				SET day4_curX=%%v
				SET day4_cur=!day4_curX: =O!
				CALL :storecheck %%S %%s
			)
			CALL :prevoutput %%S
		)
		ECHO Step 1 Complete.
		FOR /F "tokens=1,2,3,4,5,6 delims=," %%s IN (parsed_Tue.csv) DO (
			SET found=0
			SET day2=%%t
			SET day3=%%u
			SET day4=%%v
			SET day5=%%w
			SET day6=%%x
			FOR /F "tokens=1 delims=," %%S IN (parsed_Mon.csv) DO (
				CALL :currentcheck %%s %%S
			)
			CALL :currentoutput %%s
		)
	) ELSE (
		ECHO No report for previous day. Aborting.
		PAUSE
		GOTO end)
)
IF %DoW%==Wed (
	IF EXIST parsed_Tue.csv (
		SET tokentot=5
		FOR /F "tokens=1,2,3,4,5 delims=," %%S IN (parsed_Tue.csv) DO (
			SET found=0
			SET day2_prevX=%%T
			SET day2_prev=!day2_prevX: =O!
			SET day3_prevX=%%U
			SET day3_prev=!day3_prevX: =O!
			SET day4_prevX=%%V
			SET day4_prev=!day4_prevX: =O!
			SET day5_prevX=%%W
			SET day5_prev=!day5_prevX: =O!
			FOR /F "tokens=1,2,3,4,5,6 delims=," %%s IN (parsed_Wed.csv) DO (
				SET day2_curX=%%t
				SET day2_cur=!day2_curX: =O!
				SET day3_curX=%%u
				SET day3_cur=!day3_curX: =O!
				SET day4_curX=%%v
				SET day4_cur=!day4_curX: =O!
				SET day5_curX=%%w
				SET day5_cur=!day5_curX: =O!
				CALL :storecheck %%S %%s
			)
			CALL :prevoutput %%S
		)
		ECHO Step 1 Complete.
		FOR /F "tokens=1,2,3,4,5,6 delims=," %%s IN (parsed_Wed.csv) DO (
			SET found=0
			SET day2=%%t
			SET day3=%%u
			SET day4=%%v
			SET day5=%%w
			SET day6=%%x
			FOR /F "tokens=1 delims=," %%S IN (parsed_Tue.csv) DO (
				CALL :currentcheck %%s %%S
			)
			CALL :currentoutput %%s
		)
	) ELSE (
		ECHO No report for previous day. Aborting.
		PAUSE
		GOTO end)
)
IF %DoW%==Thu (
	ECHO Today is Thursday.
	IF EXIST parsed_Wed.csv (
		SET tokentot=6
		ECHO tokens set at 6
		FOR /F "tokens=1,2,3,4,5,6 delims=," %%S IN (parsed_Wed.csv) DO (
			SET found=0
			SET day2_prevX=%%T
			SET day2_prev=!day2_prevX: =O!
			SET day3_prevX=%%U
			SET day3_prev=!day3_prevX: =O!
			SET day4_prevX=%%V
			SET day4_prev=!day4_prevX: =O!
			SET day5_prevX=%%W
			SET day5_prev=!day5_prevX: =O!
			SET day6_prevX=%%X
			SET day6_prev=!day6_prevX: =O!
			FOR /F "tokens=1,2,3,4,5,6,7 delims=," %%s IN (parsed_Thu.csv) DO (
				SET day2_curX=%%t
				SET day2_cur=!day2_curX: =O!
				SET day3_curX=%%u
				SET day3_cur=!day3_curX: =O!
				SET day4_curX=%%v
				SET day4_cur=!day4_curX: =O!
				SET day5_curX=%%w
				SET day5_cur=!day5_curX: =O!
				SET day6_curX=%%x
				SET day6_cur=!day6_curX: =O!
				CALL :storecheck %%S %%s
			)
			CALL :prevoutput %%S
		)
		ECHO Step 1 Complete.
		FOR /F "tokens=1,2,3,4,5,6,7 delims=," %%s IN (parsed_Thu.csv) DO (
			SET found=0
			SET day2=%%t
			SET day3=%%u
			SET day4=%%v
			SET day5=%%w
			SET day6=%%x
			SET day7=%%y
			FOR /F "tokens=1 delims=," %%S IN (parsed_Wed.csv) DO (
				CALL :currentcheck %%s %%S
			)
			CALL :currentoutput %%s
		)
	) ELSE (
		ECHO No report for previous day. Aborting.
		PAUSE
		GOTO end)
)
IF %DoW%==Fri (
	ECHO Today is Friday.
	IF EXIST parsed_Thu.csv (
		SET tokentot=7
		ECHO tokens set at 7
		FOR /F "tokens=1,2,3,4,5,6,7 delims=," %%S IN (parsed_Thu.csv) DO (
			SET found=0
			SET day2_prevX=%%T
			SET day2_prev=!day2_prevX: =O!
			SET day3_prevX=%%U
			SET day3_prev=!day3_prevX: =O!
			SET day4_prevX=%%V
			SET day4_prev=!day4_prevX: =O!
			SET day5_prevX=%%W
			SET day5_prev=!day5_prevX: =O!
			SET day6_prevX=%%X
			SET day6_prev=!day6_prevX: =O!
			SET day7_prevX=%%Z
			SET day7_prev=!day7_prevX: =O!
			FOR /F "tokens=1,2,3,4,5,6,7,8 delims=," %%s IN (parsed_Fri.csv) DO (
				SET day2_curX=%%t
				SET day2_cur=!day2_curX: =O!
				SET day3_curX=%%u
				SET day3_cur=!day3_curX: =O!
				SET day4_curX=%%v
				SET day4_cur=!day4_curX: =O!
				SET day5_curX=%%w
				SET day5_cur=!day5_curX: =O!
				SET day6_curX=%%x
				SET day6_cur=!day6_curX: =O!
				SET day7_curX=%%y
				SET day7_cur=!day7_curX: =O!
				CALL :storecheck %%S %%s
			)
			CALL :prevoutput %%S
		)
		ECHO Step 1 Complete.
		FOR /F "tokens=1,2,3,4,5,6,7,8 delims=," %%s IN (parsed_Fri.csv) DO (
			SET found=0
			SET day2=%%t
			SET day3=%%u
			SET day4=%%v
			SET day5=%%w
			SET day6=%%x
			SET day7=%%y
			SET day8=%%z
			FOR /F "tokens=1 delims=," %%S IN (parsed_Thu.csv) DO (
				CALL :currentcheck %%s %%S
			)
			CALL :currentoutput %%s
		)
	) ELSE (
		ECHO No report for previous day. Aborting.
		PAUSE
		GOTO end)
)
ECHO Step 2 Complete.
SORT < current.csv >> realcurrent.csv
ECHO Step 3 Complete.
GOTO :eof



REM Output valid data when store not found in current report
REM This will only output the stores from previous day to report
REM Need a separate way to output current days unique data
:prevoutput
IF %found%==0 (
	SET strNumYstrdy=%1
	REM ECHO Store Number %strNumYstrdy%:
	FOR %%E IN (2 3 4 5) DO (
		SET daynum=%%E
		CALL :comparator X !day%%E_prev!
	)
	IF %strNumYstrdy% LSS 10 (
		SET spaces=    
		ECHO.>NUL
	) ELSE (
		IF %strNumYstrdy% LSS 100 (
			SET spaces=   
			ECHO.>NUL
		) ELSE ( 
			IF %strNumYstrdy% LSS 1000 (
				SET spaces=  
				ECHO.>NUL
			) ELSE (
				SET spaces= 
				ECHO.>NUL
			)
		)
	)
	ECHO !spaces!!strNumYstrdy!,!day2!,!day3!,!day4!,!day5! >> current.csv
	SET found=1
	GOTO :eof
)
GOTO :eof
	
:storecheck
SET strNumTdy=%2
SET strNumYstrdy=%1
SET daynum=1
REM Run a loop here to compare tokens
REM If yesterday's token is blank and today is X then change to !
IF %strNumTdy%==%strNumYstrdy% (
	SET found=1
	REM ECHO Store Number %strNumTdy%:
	FOR %%D IN (2 3 4 5) DO (
		SET daynum=%%D
		CALL :comparator !day%%D_cur! !day%%D_prev!
	)
	IF %strNumTdy% LSS 10 (
		SET spaces=    
		ECHO.>NUL
	) ELSE (
		IF %strNumTdy% LSS 100 (
			SET spaces=   
			ECHO.>NUL
		) ELSE ( 
			IF %strNumTdy% LSS 1000 (
				SET spaces=  
				ECHO.>NUL
			) ELSE (
				SET spaces= 
				ECHO.>NUL
			)
		)
	)
	ECHO !spaces!!strNumTdy!,!day2!,!day3!,!day4!,!day5! >> current.csv
	GOTO :eof
)
GOTO :eof


:currentcheck
SET strNumTdy=%1
SET strNumYstrdy=%2
IF %strNumTdy%==%strNumYstrdy% (
	SET found=1
	REM ECHO Store Number %strNumTdy%:
	REM FOR %%D IN (2 3 4 5 6) DO (
	REM	ECHO day %%D is !day%%D!
	REM )
	GOTO :eof
)
GOTO :eof

:currentoutput
IF %found%==0 (
	SET strNumTdy=%1
	REM ECHO Store Number %strNumTdy%:
	REM FOR %%E IN (2 3 4 5 6) DO (
	REM	ECHO day %%E is !day%%E!
	REM )
	IF %strNumTdy% LSS 10 (
		SET spaces=    
		ECHO.>NUL
	) ELSE (
		IF %strNumTdy% LSS 100 (
			SET spaces=   
			ECHO.>NUL
		) ELSE ( 
			IF %strNumTdy% LSS 1000 (
				SET spaces=  
				ECHO.>NUL
			) ELSE (
				SET spaces= 
				ECHO.>NUL
			)
		)
	)
	ECHO !spaces!!strNumTdy!,!day2!,!day3!,!day4!,!day5!,!day6! >> current.csv
	SET found=1
	GOTO :eof
)
GOTO :eof
	


endlocal
REM	run comparison for ! substitution
REM %1 is today's polldata
REM %2 is yesterday's polldata
:comparator
REM ECHO day%daynum% current data is %1
REM ECHO day%daynum% previous data is %2
IF %2==O (
	REM Check
	IF %1==X (SET day%daynum%=#) ELSE (SET day%daynum%= )
) ELSE (
	REM Check
	IF %1==O (SET day%daynum%= ) ELSE (SET day%daynum%=%1)
)
REM ECHO day %daynum% %2 %1 = !day%daynum%!
GOTO :eof
