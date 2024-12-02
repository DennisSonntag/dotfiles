import json 
import sys

# Check if any command-line arguments were provided
monitor = None
if len(sys.argv) > 1:
    monitor = sys.argv[1]  
# else:
#     print("No command-line arguments provided.")

data = {
    "class": "playing",
    "text": "brightness: 100%",
    "tooltip": "nah id win {}".format(monitor)
}
print(json.dumps(data))
