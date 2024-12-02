import subprocess

import math
import json

players = subprocess.getoutput("playerctl -l").splitlines()
if "spotify" in players:
    title = subprocess.getoutput(
        "playerctl -p spotify metadata xesam:title | sed 's/\"//g' "
    )
    secondsRaw = math.floor(float(subprocess.getoutput("playerctl -p spotify position")))
    minutes, seconds = divmod(secondsRaw, 60)
    time = "{}:{}".format(minutes, str(seconds).zfill(2))
    
    status = subprocess.getoutput("playerctl -p spotify status") == "Playing"
    
    
    artist = subprocess.getoutput("playerctl -p spotify metadata xesam:artist")
    album = subprocess.getoutput("playerctl -p spotify metadata xesam:album")
    
    
    if status:
        data = {
            "class": "playing",
            "text": " {} - {}".format(time, title),
            "tooltip": "album : {}\nartist : {}".format(album, artist),
        }
        print(json.dumps(data))
    
    else:
        data = {
            "class": "playing",
            "text": " {} - {}".format(time, title),
            "tooltip": "album : {}\nartist : {}".format(album, artist),
        }
        print(json.dumps(data))
