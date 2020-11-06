@echo off

REM Visual Studio version
REM vc12 => visual 2013 
set VC_VER=12
set CODE_FOLDER=%HOMEPATH%\ANPL\Code
set BOOST_ROOT=%CODE_FOLDER:\=/%/boost_1_57_0
set PREFIX=%HOMEPATH%\prefix
set CODE_FOLDER=%HOMEPATH%\ANPL\Code
set VC_COMMAND=call "%programfiles(x86)%\Microsoft Visual Studio %VC_VER%.0\VC\vcvarsall.bat" amd64
set ANPL_WINDOWS=%CODE_FOLDER%\infrastructureproject\InstallEnvScripts\windows

set TBB=True


if not exist "%PREFIX%\lib\gtsam*" (

	cd "%ANPL_WINDOWS%"
	call install-gtsam.bat
	if not exist "%PREFIX%\lib\gtsam*" (
		echo File don't exist "%PREFIX%\lib\gtsamDebug.lib"
		pause
		exit
	)
)

if not exist "%PREFIX%\lib\ompl.lib" (
	
	cd "%ANPL_WINDOWS%"
	call install-ompl.bat
	if not exist "%PREFIX%\lib\ompl.lib" (
		echo File don't exist "%PREFIX%\lib\ompl.lib"
		pause
		exit
	)
)

title installing ompl_infrastructure

cd %CODE_FOLDER%\ompl_infrastructure
rd /s/q build-64
md build-64
cd build-64

cmake ../Win -G "Visual Studio %VC_VER% Win64" -DCMAKE_INSTALL_PREFIX=%PREFIX% -DBoost_USE_STATIC_LIBS=ON -DBoost_USE_MULTITHREADED=ON -DBOOST_ROOT=%BOOST_ROOT%
if not exist "%CODE_FOLDER%\ompl_infrastructure\build-64\RRG.vcxproj" (
	echo File don't exist "%CODE_FOLDER%\ompl_infrastructure\build-64\RRG.vcxproj"
	pause
	exit
)
if not exist "%CODE_FOLDER%\ompl_infrastructure\build-64\RRG_MR.vcxproj" (
	echo File don't exist "%CODE_FOLDER%\ompl_infrastructure\build-64\RRG_MR.vcxproj"
	pause
	exit
)

%VC_COMMAND%
msbuild RRG.vcxproj
if not exist "%CODE_FOLDER%\ompl_infrastructure\build-64\Debug\RRG.exe" (
	echo File don't exist "%CODE_FOLDER%\ompl_infrastructure\build-64\Debug\RRG.exe" 
	pause
	exit
)

msbuild RRG_MR.vcxproj
if not exist "%CODE_FOLDER%\ompl_infrastructure\build-64\Debug\RRG_MR.exe" (
	echo File don't exist "%CODE_FOLDER%\ompl_infrastructure\build-64\Debug\RRG_MR.exe" 
	pause
	exit
)

set DEBUG_FILES="gtsamDebug.dll" "msvcp%VC_VER%0d.dll" "msvcr%VC_VER%0d.dll" "intel64\vc%VC_VER%\tbb_debug.dll" "intel64\vc%VC_VER%\tbb_debug.pdb" "intel64\vc%VC_VER%\tbbmalloc_debug.dll" "intel64\vc%VC_VER%\tbbmalloc_debug.pdb"
set RELEASE_FILES="gtsam.dll" "msvcp%VC_VER%0.dll" "msvcr%VC_VER%0.dll" "intel64\vc%VC_VER%\tbb.dll" "intel64\vc%VC_VER%\tbb.pdb" "intel64\vc%VC_VER%\tbbmalloc.dll" "intel64\vc%VC_VER%\tbbmalloc.pdb"	

cd %PREFIX%\bin\

for /d %%a in (%DEBUG_FILES%) 	do xcopy /y/s "%%a" "%CODE_FOLDER%\ompl_infrastructure\build-64\Debug\"
for /d %%a in (%RELEASE_FILES%) do xcopy /y/s "%%a" "%CODE_FOLDER%\ompl_infrastructure\build-64\Release\"
