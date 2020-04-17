#!/bin/bash
# Auto rotate screen based on device orientation
# Receives input from monitor-sensor (part of iio-sensor-proxy package)
# Screen orientation and launcher location is set based upon accelerometer position
# Launcher will be on the left in a landscape orientation and on the bottom in a portrait orientation
# This script should be added to startup applications for the user

SENSOR_LOG=/tmp/sensor.log
SCREEN=DSI1

# Clear sensor.log so it doesn't get too long over time
> $SENSOR_LOG

# Launch monitor-sensor and store the output in a variable that can be parsed by the rest of the script
monitor-sensor >> $SENSOR_LOG 2>&1 &

# Parse output or monitor sensor to get the new orientation whenever the log file is updated
# Possibles are: normal, bottom-up, right-up, left-up
# Light data will be ignored
while inotifywait -e modify ${SENSOR_LOG}; do
# Read the last line that was added to the file and get the orientation
ORIENTATION=$(tail -n 1 ${SENSOR_LOG} | grep 'orientation' | grep -oE '[^ ]+$')

# Set the actions to be taken for each possible orientation
case "$ORIENTATION" in
normal)
xrandr --output ${SCREEN} --rotate normal && xinput set-prop "silead_ts touch" 'Coordinate Transformation Matrix' 0 -3.55 1 -2.37 0 1 0 0 1 ;;
bottom-up)
xrandr --output ${SCREEN} --rotate inverted && xinput set-prop "silead_ts touch" 'Coordinate Transformation Matrix' 0 3.55 0 2.37 0 0 0 0 1 ;;
right-up)
xrandr --output ${SCREEN} --rotate left && xinput set-prop "silead_ts touch" 'Coordinate Transformation Matrix' 2.37 0 0 0 -3.55 1 0 0 1 ;;
left-up)
xrandr --output ${SCREEN} --rotate right && xinput set-prop "silead_ts touch" 'Coordinate Transformation Matrix' -2.37 0 1 0 3.55 0 0 0 1 ;;
esac
done
