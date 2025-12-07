#!/bin/bash
# Hook for auto-cpufreq - changes brightness when changing power
[ "$1" = "charger" ] && brightnessctl set 80%
[ "$1" = "battery" ] && brightnessctl set 40%
