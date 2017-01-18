#!/bin/bash

ifconfig wlan0 down
service network-manager stop
iwconfig wlan0 essid TechPublic
dhclient wlan0

