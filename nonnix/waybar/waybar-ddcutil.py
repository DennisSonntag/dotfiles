import subprocess
import math
import json

data = {}
monitor = 1
value1 = subprocess.run(["sudo", "ddcutil", "getvcp", "10", "-d", str(monitor)], stdout=subprocess.PIPE).stdout.decode('utf8')
percentage1 = value1.split(":")[1].split(",")[0].split("=")[1].strip(" ")

# value2 = subprocess.run(["ddcutil", "getvcp", "10", "-d", "2"], stdout=subprocess.PIPE).stdout.decode('utf8')
# percentage2 = value2.split(":")[1].split(",")[0].split("=")[1].strip(" ")
# data['mon-1-percentage'] = int(percentage1)
data['percentage'] = int(percentage1)
print(json.dumps(data))



