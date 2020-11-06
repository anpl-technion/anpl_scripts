#!/bin/bash

AG_CMAKE_LINES=('list(APPEND CMAKE_MODULE_PATH ${ANPL_PREFIX}/share/cmake)' \
	'set(OMPL_PREFIX ${ANPL_PREFIX})')
AG_CMAKE_PATH=~/ANPL/infrastructure/mrbsp_ws/src/anpl_mrbsp/action_generator/CMakeLists.txt
for line in "${AG_CMAKE_LINES[@]}"; do
	# comment lines in ag CMake 
	sed -i "s|${line}|#${line}|" $AG_CMAKE_PATH
done