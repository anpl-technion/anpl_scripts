@echo off

REM Visual Studio version
REM vc12 => visual 2013 
set VC_VER=12
set CODE_FOLDER=%HOMEPATH%\ANPL\Code
set PREFIX=%HOMEPATH%\prefix
set GTSAM_VER=3.2.1
set GTSAM_NAME=gtsam-%GTSAM_VER%
set ANPL_WINDOWS=%CODE_FOLDER%\infrastructureproject\InstallEnvScripts\windows
REM open visual studio tool: 
REM https://social.msdn.microsoft.com/forums/windowsapps/en-us/23a7dc5d-c337-4eed-8af4-c016def5516e/location-of-msbuildexe
REM http://stackoverflow.com/questions/1103994/how-to-run-multiple-bat-files-within-a-bat-file
set VC_COMMAND=call "%programfiles(x86)%\Microsoft Visual Studio %VC_VER%.0\VC\vcvarsall.bat" amd64

set TBB=True

if not exist "%PREFIX%\lib\libboost*" (

	cd "%ANPL_WINDOWS%"
	call install-boost.bat
	if not exist "%PREFIX%\lib\libboost*" (
		echo Files don't exist "%PREFIX%\lib\libboost*"
		pause
		exit
	)
)

if exist "%programfiles%\MATLAB" (

	set MATLAB=True
	set MATLAB_VER=R2015a
	REM matlab -nodesktop -nosplash -r "version=ver('matlab');version=version.Release;version=version(2:end-1);setenv('MATLAB_VER',version);exit"
) else (

	set MATLAB=False
)

if %TBB% == True (

	set TBB_FLAGS=-DTBB_INCLUDE_DIR=%PREFIX%/include -DTBB_LIBRARY=%PREFIX%/lib/intel64/vc%VC_VER%/tbb.lib -DTBB_LIBRARY_DEBUG=%PREFIX%/lib/intel64/vc%VC_VER%/tbb_debug.lib -DTBB_MALLOC_LIBRARY=%PREFIX%/lib/intel64/vc%VC_VER%/tbbmalloc.lib -DTBB_MALLOC_LIBRARY_DEBUG=%PREFIX%/lib/intel64/vc%VC_VER%/tbbmalloc_debug.lib	
	if not exist "%PREFIX%\lib\intel64\vc%VC_VER%\tbb*" (

		cd "%ANPL_WINDOWS%"
		call install-tbb.bat
		if not exist "%PREFIX%\lib\intel64\vc%VC_VER%\tbb*" (
			echo Files don't exist "%PREFIX%\lib\intel64\vc%VC_VER%\tbb*"
			pause
			exit
		)		
	)	
) else (

	set TBB_FLAGS= 
)

if %Matlab% == True (

	set MATLAB_FLAGS=-DGTSAM_INSTALL_MATLAB_TOOLBOX=ON -DMEX_COMMAND="%programfiles%/MATLAB/%MATLAB_VER%/bin/mex.bat"
) else (

	set MATLAB_FLAGS= 
)

if not exist "%CODE_FOLDER%\%GTSAM_NAME%" (
	
	echo installing gtsam
	cd %HOMEPATH%\Downloads
	powershell wget -outf gtsam-${env:GTSAM_VER}.zip https://research.cc.gatech.edu/borg/sites/edu.borg/files/downloads/gtsam-${env:GTSAM_VER}.zip
	powershell Expand-Archive gtsam-${env:GTSAM_VER}.zip ${env:CODE_FOLDER}
)

title installing gtsam

cd  %CODE_FOLDER%\%GTSAM_NAME%
rd /s/q build-64
md build-64
cd build-64
REM https://collab.cc.gatech.edu/borg/gtsam/#quickstart
REM https://stackoverflow.com/questions/19303430/cmake-cannot-find-boost-libraries/19318463#19318463

cmake .. -G "Visual Studio %VC_VER% Win64" -DCMAKE_INSTALL_PREFIX=%PREFIX% -DGTSAM_DISABLE_EXAMPLES_ON_INSTALL=ON -DBoost_USE_STATIC_LIBS=ON -DBoost_USE_MULTITHREADED=ON  %TBB_FLAGS% %MATLAB_FLAGS%

if not exist "%CODE_FOLDER%\%GTSAM_NAME%\build-64\INSTALL.vcxproj" (
	echo File don't exist "%CODE_FOLDER%\%GTSAM_NAME%\build-64\INSTALL.vcxproj
	pause
	exit
)

if %Matlab% == True (

	if not exist "%CODE_FOLDER%\%GTSAM_NAME%\build-64\wrap\wrap.vcxproj" (
		echo File don't exist "%CODE_FOLDER%\%GTSAM_NAME%\build-64\wrap\wrap.vcxproj"
		pause
		exit
	)
)
 
REM compile gtsam.sln
%VC_COMMAND%
if %Matlab% == True (

	msbuild wrap\wrap.vcxproj
	if not exist "%CODE_FOLDER%\%GTSAM_NAME%\build-64\bin\Debug\wrap.exe" (
		echo File don't exist "%CODE_FOLDER%\%GTSAM_NAME%\build-64\bin\Debug\wrap.exe"
		pause
		exit
	)
)
msbuild INSTALL.vcxproj
if not exist "%PREFIX%\lib\gtsamDebug.lib" (
	echo File don't exist "%PREFIX%\lib\gtsamDebug.lib"
	pause
	exit
)
if %Matlab% == True (
	if not exist "%PREFIX%\gtsam_toolboxDebug\gtsam_wrapper*" (
		echo File don't exist "%PREFIX%\gtsam_toolboxDebug\gtsam_wrapper*"
		pause
		exit
	)
)


msbuild INSTALL.vcxproj /p:Configuration=Release
if not exist "%PREFIX%\lib\gtsam.lib" (
	echo File don't exist "%PREFIX%\lib\gtsam.lib"
	pause
	exit
)
if %Matlab% == True (
	if not exist "%PREFIX%\gtsam_toolbox\gtsam_wrapper*" (
		echo File don't exist "%PREFIX%\gtsam_toolbox\gtsam_wrapper*"
		pause
		exit
	)
)

REM copy manually the correct gtsam dll. for Debug or not Debug
xcopy /y/c/q %PREFIX%\bin\gtsam.dll 		%PREFIX%\gtsam_toolbox\
xcopy /y/c/q %PREFIX%\bin\gtsamDebug.dll 	%PREFIX%\gtsam_toolboxDebug\
