#!/usr/bin/env python3

import os
import sys
import subprocess

# Replace these with your monitor IDs
MONITORS = ["1", "2"]  # Use `ddcutil detect` to find the monitor IDs
STEP = 10  # Adjust brightness step percentage

def get_brightness(monitor):
    """Get the current brightness for a monitor."""
    try:
        output = subprocess.check_output(["ddcutil", "getvcp", "10", "-d", monitor])
        for line in output.decode().splitlines():
            if "current value" in line:
                return int(line.split()[-1])
    except Exception as e:
        print(f"Error getting brightness for monitor {monitor}: {e}")
        return None

def set_brightness(monitor, brightness):
    """Set the brightness for a monitor."""
    try:
        subprocess.run(["ddcutil", "setvcp", "10", str(brightness), "--monitor", monitor], check=True)
    except Exception as e:
        print(f"Error setting brightness for monitor {monitor}: {e}")

def adjust_brightness(action):
    """Adjust brightness based on the action."""
    for monitor in MONITORS:
        current_brightness = get_brightness(monitor)
        if current_brightness is None:
            continue
        if action == "increase":
            new_brightness = min(100, current_brightness + STEP)
        elif action == "decrease":
            new_brightness = max(0, current_brightness - STEP)
        elif action == "toggle":
            new_brightness = 0 if current_brightness > 0 else 50  # Toggle logic
        set_brightness(monitor, new_brightness)

def main():
    if len(sys.argv) != 2:
        print("Usage: brightness_control.py [get|increase|decrease|toggle]")
        sys.exit(1)
    
    action = sys.argv[1]
    if action == "get":
        # Aggregate brightness levels for all monitors
        brightness_levels = [get_brightness(monitor) for monitor in MONITORS]
        avg_brightness = sum(filter(None, brightness_levels)) // len(MONITORS)
        print(avg_brightness)
    elif action in {"increase", "decrease", "toggle"}:
        adjust_brightness(action)
    else:
        print("Invalid action. Use [get|increase|decrease|toggle].")
        sys.exit(1)

if __name__ == "__main__":
    main()

