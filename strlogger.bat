@ECHO OFF
REM Scrapes MISSING.RPT
REM Stores that haven't polled all week will have blank line, must be dealt with.
SET Today=%Date: =0%
SET Year=%Today:~-4%
SET Month=%Today:~-10,2%
SET Day=%Today:~-7,2%
REM SET DoW=%Today:~0,3%
SET DoW=Fri
SET linenumber=0

IF EXIST parsedmissingtest.txt DEL parsedmissingtest.txt
IF EXIST parsedmissing.txt DEL parsedmissing.txt
IF EXIST parsedpolldata.txt DEL parsedpolldata.txt
IF EXIST parsed_%DoW%.csv DEL parsed_%DoW%.csv
IF EXIST parsed_%DoW%TEST.csv DEL parsed_%DoW%TEST.csv

setlocal EnableDelayedExpansion
FOR /F "skip=2 tokens=1 delims=&&" %%A IN (sortedmissing.txt) DO (
	SET _line=%%A
	SET _testline=!_line:~1!
	SET _pollline=!_line:~16!
	REM SET _pollline=!_apollline: =-!
	CALL :blankfix !_pollline!
	REM ECHO !_line!>>parsedmissing.txt
	REM ECHO !_testline!>>parsedmissingtest.txt
	REM ECHO !_pollline!>>parsedpolldata.txt
	FOR /F "tokens=1 delims= " %%B IN ("!_testline!") DO (
		CALL :makecsv %%B
	)

)
GOTO end
endlocal

setlocal EnableDelayedExpansion

REM Character Map
REM 1  = F
REM 4  = Sa
REM 7  = Su
REM 10 = M
REM 13 = Tu
REM 16 = W
REM 19 = Th
:makecsv
IF !linenumber!==0 (
	REM ECHO !_line!>>parsed_%DoW%.csv
	ECHO.>NUL
) ELSE (
	SET /a _strNum=%1
	IF NOT !_strNum!==0 (
			FOR %%C IN (1 4 7 10 13 16 19) DO (
				SET _char%%C=!_pollline:~%%C,1!
				CALL :dasher !_char%%C! %%C	
			)
			CALL :output
		)
		REM ECHO !spaces!!_strNum!,!_pollline!>>parsed_%DoW%TEST.csv
	)
)
SET /a linenumber+=1
GOTO :eof
endlocal

REM trying to locate and convert spaces
REM %1 = Character from poll data
REM %2 = Character #
REM one = variable used to determine if %1 is a space
REM two = variable used for evaluating if %2 is empty
:dasher
SET /a one=%1
IF %2.==. (SET two=%1) ELSE (SET two=%2)
IF %one% GTR 0 SET _char%two%= 
IF %1==_ SET _char%two%= 
IF %1.==. SET _char%two%=@
GOTO :eof

REM This output is only valid for a full report (Friday)
:output
ECHO !_strNum!,!_char1!,!_char4!,!_char7!,!_char10!,!_char13!,!_char16!>>parsed_%DoW%.csv
GOTO :eof

REM WIP
REM Will be used to compare data from previous day(s) for complete weeks report
REM Will need to add stores that don't exist on previous days and replace current X's with !'s if they were not X's on previous report.
REM Tokens:
REM 1 (%%S)- Store Number
REM 2 (%%T)- Fri
REM 3 (%%U)- Sat
REM 4 (%%V)- Sun
REM 5 (%%W)- Mon
REM 6 (%%X)- Tue
REM 7 (%%Y)- Wed
REM 8 (%%Z)- Thu
:compare
IF %DoW%==Tue (
	IF EXIST parsed_Mon.csv (
		FOR /F "tokens=1,2,3,4 delims=," %%S IN (parsed_Mon.csv) DO (
			ECHO.>NUL
		)
	) ELSE (
		ECHO No report for previous day. Aborting.
		PAUSE
		GOTO end)
)
IF %DoW%==Wed (
	IF EXIST parsed_Tue.csv (
		SET tokentot=5
		SET found=0
		FOR /F "tokens=1,2,3,4,5 delims=," %%S IN (parsed_Tue.csv) DO (
			FOR /F "tokens=1,2,3,4,5,6 delims=," %%s IN (parsed_Wed.csv) DO (
				CALL :storecheck %%S %%s
			)
			CALL :foundcheck %%S
		)
	) ELSE (
		ECHO No report for previous day. Aborting.
		PAUSE
		GOTO end)
)
IF %DoW%==Thu (
	IF EXIST parsed_Wed.csv (
		FOR /F "tokens=1,2,3,4,5,6 delims=," %%S IN (parsed_Wed.csv) DO (
			ECHO.>NUL
		)
	) ELSE (
		ECHO No report for previous day. Aborting.
		PAUSE
		GOTO end)
)
IF %DoW%==Fri (
	IF EXIST parsed_Thu.csv (
		FOR /F "tokens=1,2,3,4,5,6,7 delims=," %%S IN (parsed_Thu.csv) DO (
			ECHO.>NUL
		)
	) ELSE (
		ECHO No report for previous day. Aborting.
		PAUSE
		GOTO end)
)
GOTO :eof

REM Output valid data when store not found in current report
REM This will only output the stores from previous day to report
REM Need a separate way to output current days unique data
:foundcheck
IF %found%==0 (
	SET strNumTdy=%1
	SET found=1
	FOR %%F IN (%%T %%U %%V %%W %%X %%Y %%Z) DO (
		SET daynum+=1
		CALL :comparator X %%F
	)
	ECHO %strNumTdy%,%day2%,%day3%,%day4%,%day5%,%day6% >> current.csv
)
GOTO :eof
	
:storecheck
SET strNumTdy=%2
SET strNumYstrdy=%1
SET daynum=1
IF strNumTdy==strNumYstrdy (
	REM Run a loop here to compare tokens
	REM If yesterday's token is blank and today is X then change to !
	SET found=1
	FOR /F "tokens=1,2 delims=," %%D IN (%%t,%%T %%u,%%U %%v,%%V %%w,%%W %%x,%%X %%y,%%Y %%z,%%Z) DO (
		SET daynum+=1
		SET _polledtoday=%%E
		SET _polledyesterday=%%D
		CALL :comparator !_polledtoday! !_polledyesterday!
	)
	ECHO %strNumTdy%,%day2%,%day3%,%day4%,%day5%,%day6% >> current.csv
)
GOTO :eof

REM parses csv line for spaces and replaces with !
REM For use with previous days polling data
:spaceX



REM	run comparison for ! substitution
REM %1 is today's polldata
REM %2 is yesterday's polldata
:comparator
IF %2== (
	IF %1==X SET day%daynum%=!
) ELSE (SET day%daynum%=%1)
GOTO :eof

REM adjust for empty values
:blankfix
IF %1.==. SET _pollline=___________________
GOTO :eof

:end
