@echo off

REM Visual Studio version
REM vc12 => visual 2013 
set VC_VER=12
set CODE_FOLDER=%HOMEPATH%\ANPL\Code
set PREFIX=%HOMEPATH%\prefix
set OMPL_VER=1.1.0
set OMPL_NAME=ompl-%OMPL_VER%
set BOOST_ROOT=%CODE_FOLDER:\=/%/boost_1_57_0
set ANPL_WINDOWS=%CODE_FOLDER%\infrastructureproject\InstallEnvScripts\windows
REM open visual studio tool: 
REM https://social.msdn.microsoft.com/forums/windowsapps/en-us/23a7dc5d-c337-4eed-8af4-c016def5516e/location-of-msbuildexe
REM http://stackoverflow.com/questions/1103994/how-to-run-multiple-bat-files-within-a-bat-file
set VC_COMMAND=call "%programfiles(x86)%\Microsoft Visual Studio %VC_VER%.0\VC\vcvarsall.bat" amd64


if not exist "%PREFIX%\lib\libboost*" (

	cd "%ANPL_WINDOWS%"
	call install-boost.bat
	if not exist "%PREFIX%\lib\libboost*" (
		echo Files don't exist "%PREFIX%\lib\libboost*" 
		pause
		exit
	)
)


if not exist "%CODE_FOLDER%\%OMPL_NAME%" (
	
	echo installing ompl
	cd %HOMEPATH%\Downloads
	powershell wget -outf ompl-${env:OMPL_VER}.zip https://bitbucket.org/ompl/ompl/downloads/ompl-${env:OMPL_VER}-Source.zip
	powershell Expand-Archive ompl-${env:OMPL_VER}.zip ${env:CODE_FOLDER}
	cd "%CODE_FOLDER%"
	move %OMPL_NAME%-Source %OMPL_NAME%
)

title installing ompl

REM Issue 192: https://bitbucket.org/ompl/ompl/issues/192/
REM http://www.robvanderwoude.com/escapechars.php
cd  "%CODE_FOLDER%\%OMPL_NAME%\tests"

(
echo # configure location of resources
echo file(TO_NATIVE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/resources" TEST_RESOURCES_DIR^)
echo set(TEST_FILES^)
echo if(WIN32^)
echo     # Correct directory separator for Windows
echo     string(REPLACE "\\" "\\\\" TEST_RESOURCES_DIR "${TEST_RESOURCES_DIR}"^)
echo     set(BOOST_TEST_SRC_DIR libs/test/src^)
echo     set(TEST_FILES ${BOOST_ROOT}/${BOOST_TEST_SRC_DIR}/test_tools.cpp  ${BOOST_ROOT}/${BOOST_TEST_SRC_DIR}/unit_test_main.cpp  ${BOOST_ROOT}/${BOOST_TEST_SRC_DIR}/framework.cpp^)
echo endif(WIN32^)
echo configure_file("${TEST_RESOURCES_DIR}/config.h.in" "${TEST_RESOURCES_DIR}/config.h"^)
echo on
echo # Disable teamcity reporting for tests by default
echo option(OMPL_TESTS_TEAMCITY "Enable unit test reporting to TeamCity" OFF^)
echo file(TO_NATIVE_PATH "${CMAKE_CURRENT_SOURCE_DIR}" CURRENT_DIR^)
echo configure_file("${CURRENT_DIR}/BoostTestTeamCityReporter.h.in" "${CURRENT_DIR}/BoostTestTeamCityReporter.h"^)
echo on
echo on
echo on
echo # Test datastructures implementation
echo add_ompl_test(test_heap datastructures/heap.cpp ${TEST_FILES}^)
echo add_ompl_test(test_grid datastructures/grid.cpp ${TEST_FILES}^)
echo add_ompl_test(test_gridb datastructures/gridb.cpp ${TEST_FILES}^)
echo add_ompl_test(test_nearestneighbors datastructures/nearestneighbors.cpp ${TEST_FILES}^)
echo add_ompl_test(test_pdf datastructures/pdf.cpp ${TEST_FILES}^)
echo on
echo # Test utilities
echo add_ompl_test(test_random util/random/random.cpp ${TEST_FILES}^)
echo add_ompl_test(test_machine_specs benchmark/machine_specs.cpp ${TEST_FILES}^)
echo on
echo # Test base code
echo add_ompl_test(test_state_operations base/state_operations.cpp ${TEST_FILES}^)
echo add_ompl_test(test_state_spaces base/state_spaces.cpp ${TEST_FILES}^)
echo add_ompl_test(test_state_storage base/state_storage.cpp ${TEST_FILES}^)
echo add_ompl_test(test_ptc base/ptc.cpp ${TEST_FILES}^)
echo add_ompl_test(test_planner_data base/planner_data.cpp ${TEST_FILES}^)
echo on
echo # Test kinematic motion planners in 2D environments
echo add_ompl_test(test_2denvs_geometric geometric/2d/2denvs.cpp ${TEST_FILES}^)
echo add_ompl_test(test_2dmap_geometric_simple geometric/2d/2dmap_simple.cpp ${TEST_FILES}^)
echo add_ompl_test(test_2dmap_ik geometric/2d/2dmap_ik.cpp ${TEST_FILES}^)
echo add_ompl_test(test_2dcircles_opt_geometric geometric/2d/2dcircles_optimize.cpp ${TEST_FILES}^)
echo on
echo # Test planning with controls on a 2D map
echo add_ompl_test(test_2dmap_control control/2dmap/2dmap.cpp ${TEST_FILES}^)
echo add_ompl_test(test_planner_data_control control/planner_data.cpp ${TEST_FILES}^)
echo on
echo # Test planning via MORSE extension
echo if(OMPL_EXTENSION_MORSE^)
echo     add_ompl_test(test_morse_extension extensions/morse/morse_plan.cpp ${TEST_FILES}^)
echo endif(OMPL_EXTENSION_MORSE^)
echo on
echo # Python unit tests
echo if(PYTHON_FOUND AND OMPL_BUILD_PYTESTS AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/../py-bindings/bindings"^)
echo     add_ompl_python_test(util/test_util.py^)
echo     add_ompl_python_test(base/test_base.py^)
echo     add_ompl_python_test(geometric/test_geometric.py^)
echo     add_ompl_python_test(geometric/test_geometric_compoundstate.py^)
echo     add_ompl_python_test(control/test_control.py^)
echo on 	
echo     # test the python function to boost::function conversion utility functions
echo     include_directories(${PYTHON_INCLUDE_DIRS}^)
echo     add_library(py_boost_function MODULE util/test_py_boost_function.cpp^)
echo     target_link_libraries(py_boost_function ompl ${Boost_PYTHON_LIBRARY} ${PYTHON_LIBRARIES}^)
echo     if(WIN32^)
echo         set_target_properties(py_boost_function PROPERTIES OUTPUT_NAME py_boost_function SUFFIX .pyd^)
echo     endif(WIN32^)
echo     add_custom_command(TARGET py_boost_function POST_BUILD
echo         COMMAND "${CMAKE_COMMAND}" -E copy "$<TARGET_FILE:py_boost_function>"
echo         "${CMAKE_CURRENT_SOURCE_DIR}/util"
echo         WORKING_DIRECTORY "${LIBRARY_OUTPUT_PATH}"^)
echo     add_ompl_python_test(util/test_py_boost_function.py^)
echo endif(^)
echo on
echo add_subdirectory(regression_tests^)
) > CMakeLists.txt
@echo off


cd  "%CODE_FOLDER%\%OMPL_NAME%"
REM http://ompl.kavrakilab.org/installation.html#install_windows
rd /s/q build-64
md build-64
cd build-64

cmake .. -G "Visual Studio %VC_VER% Win64" -DCMAKE_CXX_FLAGS_DEBUG="-D_ITERATOR_DEBUG_LEVEL=2 -D_DEBUG" -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX="%PREFIX%" -DBoost_USE_STATIC_LIBS=ON -DBoost_USE_MULTITHREADED=ON -DOMPL_BUILD_DEMOS=OFF -DOMPL_BUILD_PYBINDINGS=OFF -DOMPL_BUILD_PYTESTS=OFF -DOMPL_REGISTRATION=OFF -DBOOST_ROOT=%BOOST_ROOT%

if not exist "%CODE_FOLDER%\%OMPL_NAME%\build-64\INSTALL.vcxproj" (
	echo File don't exist "%CODE_FOLDER%\%OMPL_NAME%\build-64\INSTALL.vcxproj"
	pause
	exit
)

%VC_COMMAND%
msbuild INSTALL.vcxproj
if not exist "%PREFIX%\lib\ompl.lib" (
	echo File don't exist "%PREFIX%\lib\ompl.lib"
	pause
	exit
)

REM Issue 193: https://bitbucket.org/ompl/ompl/issues/193/
copy /y "%CODE_FOLDER%\%OMPL_NAME%\doc\markdown\FindOMPL.cmake" "%PREFIX%\share\ompl\ompl-config.cmake"
if not exist "%PREFIX%\share\ompl\ompl-config.cmake" (
	echo File don't exist "%PREFIX%\share\ompl\ompl-config.cmake"
	pause
	exit
)


