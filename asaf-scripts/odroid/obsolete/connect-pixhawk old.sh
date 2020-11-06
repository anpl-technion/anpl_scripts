#!/bin/bash

#Starting MavProxy :
mavproxy.py --master=/dev/ttyACM4
#Loading the API

module load droneapi.module.api
#api start simple_goto.py
