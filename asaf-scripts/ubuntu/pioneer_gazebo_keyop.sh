#!/bin/bash

if [ -z $1 ]; then
	rosrun pioneer_keyop pioneer_gazebo_keyop _robotName:=pioneer1
else
	rosrun pioneer_keyop pioneer_gazebo_keyop _robotName:=$1
fi
