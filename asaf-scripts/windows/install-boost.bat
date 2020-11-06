@echo off

REM Visual Studio version
REM vc12 => visual 2013 
set VC_VER=12
set BOOST_VER=1.57.0
REM http://ss64.com/nt/syntax-replace.html
set BOOST_VER_=%BOOST_VER:.=_%
set CODE_FOLDER=%HOMEPATH%\ANPL\Code
set PREFIX=%HOMEPATH%\prefix

REM http://stackoverflow.com/questions/4165387/create-folder-with-batch-but-only-if-it-doesnt-already-exist
if not exist "%CODE_FOLDER%" 	md %CODE_FOLDER%
if not exist "%PREFIX%" 		md %PREFIX%

if not exist "%CODE_FOLDER%\boost_%BOOST_VER_%" (

	REM rd /s/q "%CODE_FOLDER%\boost_%BOOST_VER_%"
	cd "%HOMEPATH%\Downloads"
	echo installing boost
	REM http://superuser.com/questions/129269/download-a-file-via-http-from-a-script-in-windows
	powershell wget -outf boost_${env:BOOST_VER_}.zip http://tenet.dl.sourceforge.net/project/boost/boost/${env:BOOST_VER}/boost_${env:BOOST_VER_}.zip

	REM http://ss64.com/ps/expand-archive.html
	powershell Expand-Archive boost_${env:BOOST_VER_}.zip ${env:HOMEPATH}\ANPL\Code
)

title installing boost
cd "%CODE_FOLDER%\boost_%BOOST_VER_%"
REM http://andres.jaimes.net/718/how-to-install-the-c-boost-libraries-on-windows/
REM http://stackoverflow.com/questions/2322255/64-bit-version-of-boost-for-64-bit-windows
REM http://stackoverflow.com/questions/13515254/how-to-set-a-timeout-for-a-process-under-windows-7
REM http://stackoverflow.com/questions/1103994/how-to-run-multiple-bat-files-within-a-bat-file
call bootstrap.bat vc%VC_VER% 
b2 install --prefix=%PREFIX% --toolset=msvc-%VC_VER%.0 address-model=64

if not exist "%PREFIX%\lib\libboost*" (
	echo Files don't exist "%PREFIX%\lib\libboost*"
	pause
	exit
)
