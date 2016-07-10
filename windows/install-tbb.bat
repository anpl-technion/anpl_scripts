@echo off

set PREFIX=%HOMEPATH%\prefix
set TBB_VER_NAME=tbb44_20151010oss
set FILE_NAME=%TBB_VER_NAME%_win_1.zip

REM https://www.threadingbuildingblocks.org/download
REM download the file: https://www.threadingbuildingblocks.org/sites/default/files/software_releases/windows/tbb44_20151010oss_win_1.zip

echo installing tbb

cd %HOMEPATH%\Downloads

powershell wget -outf ${env:FILE_NAME} https://www.threadingbuildingblocks.org/sites/default/files/software_releases/windows/${env:FILE_NAME}

REM extract to prefix
powershell Expand-Archive ${env:FILE_NAME} ${env:PREFIX}

title installing tbb
robocopy /move /e %PREFIX%\%TBB_VER_NAME% %PREFIX%

if not exist "%PREFIX%\lib\intel64" (
	echo Folder don't exist "%PREFIX%\lib\intel64"
	pause
	exit
)