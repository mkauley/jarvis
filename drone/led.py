#!/usr/bin/env python3
# Controls ReSpeaker 2-Mic HAT LEDs for wyoming-satellite pipeline states.
# Usage: led.py <state>
#   states: listen | think | speak | off
#
# Called by wyoming-satellite event hooks — each invocation is fire-and-forget.

import sys
import time
from pixel_ring import pixel_ring

CYAN   = (0,   255, 255)
BLUE   = (0,   0,   255)
YELLOW = (255, 200, 0  )
GREEN  = (0,   255, 0  )

def set_color(r, g, b):
    pixel_ring.set_brightness(10)
    pixel_ring.change_pattern("mono")
    pixel_ring.set_color(r=r, g=g, b=b)

def spin(r, g, b, duration=0.0):
    pixel_ring.set_brightness(10)
    pixel_ring.change_pattern("spin")
    pixel_ring.set_color(r=r, g=g, b=b)
    if duration:
        time.sleep(duration)

def main():
    if len(sys.argv) < 2:
        print(f"Usage: {sys.argv[0]} <listen|think|speak|off>")
        sys.exit(1)

    state = sys.argv[1].lower()

    if state == "listen":
        set_color(*CYAN)
    elif state == "think":
        spin(*YELLOW)
    elif state == "speak":
        set_color(*GREEN)
    elif state == "off":
        pixel_ring.off()
    else:
        print(f"Unknown state: {state}")
        sys.exit(1)

if __name__ == "__main__":
    main()
