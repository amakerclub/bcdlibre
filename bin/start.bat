@ECHO OFF
CD %~dp0..
REM TODO DELETE (debug)
set DEBUG=bibliopuce:*
REM Start express module and restart it after 1 sec if it crashes
%COMSPEC% /C node_modules\.bin\forever.cmd --minUptime 1000 --spinSleepTime 1000 start bin\www || GOTO ERROR

node --eval "console.log('Please wait...'); setTimeout(function* () { console.log('Go!'); process.exit(0);}, 5000);" && START EXPLORER http://localhost:3000

:END
EXIT /B 0

:ERROR
ECHO [%DATE% %TIME%] %~dp0: ERROR! >&2
PAUSE
EXIT /b 1
