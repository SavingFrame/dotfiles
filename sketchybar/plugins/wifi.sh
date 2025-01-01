#!/bin/sh

SKETCHBAR_BIN="/opt/homebrew/bin/sketchybar"

# SPEED=$(ifstat -i en0 1 1 | awk 'NR==3 {print $1}')

INTERFACE=$(ifconfig -l | grep -o "en9" || echo "en0")

SPEED=$(ifstat -i $INTERFACE 1 1 | awk 'NR==3 {print $1}')



if (( $(echo "$SPEED > 1024*1024" | bc -l) )); then
  SPEED=$(echo "scale=0; $SPEED / (1024*1024)" | bc)
  UNIT="GB/s"
elif (( $(echo "$SPEED > 1024" | bc -l) )); then
  SPEED=$(echo "scale=0; $SPEED / 1024" | bc)
  UNIT="MB/s"
else
  SPEED=$(echo $SPEED | awk '{printf "%d", $1}')
  UNIT="KB/s"
fi

if networksetup -getairportpower en0 | grep " On" >> /dev/null; then
  COLOR=0xff9ece6a
else
  COLOR=0xfff7768e
fi

$SKETCHBAR_BIN --set $NAME icon.color=$COLOR label="${SPEED} ${UNIT}"
