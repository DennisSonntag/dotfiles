import json 
import subprocess
import math
import json
import sys

# Check if any command-line arguments were provided
command = None
monitor = None
percentage = None
data = {}
if len(sys.argv) > 1:
    command = sys.argv[1]  
    monitor = int(sys.argv[2])  


if command == "get":
    value = subprocess.run(["ddcutil", "getvcp", "10", "-d", str(monitor)], stdout=subprocess.PIPE).stdout.decode('utf8')
    percentage = value.split(":")[1].split(",")[0].split("=")[1].strip(" ")
elif command == "up":
    subprocess.run(["ddcutil", "setvcp", "-d", str(monitor), "10", "+", "10"], stdout=subprocess.PIPE).stdout.decode('utf8')
elif command == "down":
    subprocess.run(["ddcutil", "setvcp", "-d", str(monitor), "10", "-", "10"], stdout=subprocess.PIPE).stdout.decode('utf8')

# else:
#     print("No command-line arguments provided.")

data = {
    "class": "playing",
    "text": "brightness: {}%".format(percentage),
    "tooltip": "nah id win"
}
print(json.dumps(data))
