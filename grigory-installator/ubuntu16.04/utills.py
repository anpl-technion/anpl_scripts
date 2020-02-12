#!/usr/bin/env python3
import subprocess
import sys

class bcolors:
    OKBLUE = '\033[0;44m'
    OKGREEN = '\033[0;42m'
    WARNING = '\033[0;43m'
    OKPURP = '\033[0;45m'
    FAIL = '\033[0;41m'
    ENDC = '\033[0m'
    BOLD = '\033[1m'


def request_to_user(msg: str, legal_values) -> str:
	while True:
		print(msg, end="", flush=True)
		# print(msg, end="", flush=True)
		ans = sys.stdin.readline()[:-1].lower()
		if len(legal_values) == 0 or len(ans) ==0 or ans in legal_values :
			break
		else:
			print
			print("Option is not listed, please enter again.")
	return ans

def user_decision(msg: str) -> bool:
	res = request_to_user(msg, ["y", "n"])
	return res == "y"

def print_and_exit(msg: str):
	print(msg)
	sys.exit()

def install(name: str):
	p = subprocess.Popen("./src/install-"+name+".sh", shell=True)
	p_status = p.wait()
