#!/usr/bin/env python

import json
import subprocess

def run_command(cmd):
    result = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
    return result.stdout.decode().strip()

output = run_command('pacman -Qu linux')
data = {}
if output: 
    data['text'] = output
    data['class'] = "update"
else:
    data['text'] = "No updates"
    data['class'] = "noupdate"




print(json.dumps(data))
