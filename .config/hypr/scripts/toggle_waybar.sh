#!/bin/bash

PROCESS_NAME="waybar"

if pgrep -x "$PROCESS_NAME" >/dev/null; then

  killall -q "$PROCESS_NAME"

  sleep 0.1
fi

"$PROCESS_NAME" &
