SET /P sync=Sync? (y/n)
IF "%sync%"=="y" call Sync.bat
java -Xmx6G -jar paper-26.1.2-61.jar nogui
IF "%sync%"=="y" call Sync.bat
pause
