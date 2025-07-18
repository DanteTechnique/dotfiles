#!/usr/bin/env bash

PID_FILE="/tmp/hyprsunset.pid"

if [ -f "$PID_FILE" ]; then
    kill "$(cat "$PID_FILE")" 2>/dev/null
    rm "$PID_FILE"
else
    hyprsunset -t 3500 &
    echo $! > "$PID_FILE"
fi
