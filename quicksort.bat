@ECHO OFF
IF EXIST realcurrent.csv DEL realcurrent.csv
IF EXIST current.csv SORT < current.csv >> realcurrent.csv