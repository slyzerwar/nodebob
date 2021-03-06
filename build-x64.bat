@echo off

set CUR_DIR="%CD%"
set EXE_PATH=%CUR_DIR%\release\nw.exe
set ICO_PATH=%CUR_DIR%\app\app.ico
set NWEXE_PATH=%CUR_DIR%\buildTools\nw-x64\nw.exe
set NWZIP_PATH=%CUR_DIR%\release\app.nw

SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set "DEL=%%a"
)

call :ColorText 0C "nodebob v0.1"
echo.
call :ColorText 0C "---"
echo.
echo.

if not exist release md release

echo.
call :ColorText 0a "Creating app package..."
cd buildTools\7z
7z a -r -tzip %NWZIP_PATH% ..\..\app\*
cd ..\..

echo.
call :ColorText 0a "Creating executable..."
echo.
copy /b /y %NWEXE_PATH% %EXE_PATH%
cd buildTools\ar
if exist %ICO_PATH% Resourcer -op:upd -src:%EXE_PATH% -type:14 -name:IDR_MAINFRAME -file:%ICO_PATH%
copy /b /y %EXE_PATH% + %NWZIP_PATH% %EXE_PATH%
cd ..\..

echo.
call :ColorText 0a "Copying files..."
echo.
if not exist %CUR_DIR%\release\ffmpegsumo.dll copy %CUR_DIR%\buildTools\nw-x64\ffmpegsumo.dll %CUR_DIR%\release\ffmpegsumo.dll
if not exist %CUR_DIR%\release\icudtl.datt copy %CUR_DIR%\buildTools\nw-x64\icudtl.dat %CUR_DIR%\release\icudtl.dat
if not exist %CUR_DIR%\release\libEGL.dll copy %CUR_DIR%\buildTools\nw-x64\libEGL.dll %CUR_DIR%\release\libEGL.dll
if not exist %CUR_DIR%\release\libGLESv2.dll copy %CUR_DIR%\buildTools\nw-x64\libGLESv2.dll %CUR_DIR%\release\libGLESv2.dll
if not exist %CUR_DIR%\release\nw.pak copy %CUR_DIR%\buildTools\nw-x64\nw.pak %CUR_DIR%\release\nw.pak
if not exist %CUR_DIR%\release\pdf.dll copy %CUR_DIR%\buildTools\nw-x64\pdf.dll %CUR_DIR%\release\pdf.dll
if not exist %CUR_DIR%\release\nwjc.exe copy %CUR_DIR%\buildTools\nw-x64\nwjc.exe %CUR_DIR%\release\nwjc.exe
if not exist %CUR_DIR%\release\nw.exe copy %CUR_DIR%\buildTools\nw-x64\nw.exe %CUR_DIR%\release\nw.exe
if not exist %CUR_DIR%\release\d3dcompiler_47.dll copy %CUR_DIR%\buildTools\nw-x64\d3dcompiler_47.dll %CUR_DIR%\release\d3dcompiler_47.dll



echo.
call :ColorText 0a "Deleting temporary files..."
echo.
del %NWZIP_PATH%

echo.
call :ColorText 0a "Done!"
echo.
goto :eof


:ColorText
echo off
<nul set /p ".=%DEL%" > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof
