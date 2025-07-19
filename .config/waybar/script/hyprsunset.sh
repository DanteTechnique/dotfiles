#!/usr/bin/env bash

PID_FILE="/tmp/hyprsunset.pid"
WAYBAR_SIGNAL=1

toggle() {
    if [ -f "$PID_FILE" ]; then
        kill "$(cat "$PID_FILE")" 2>/dev/null
        rm "$PID_FILE"
        echo '{"text":"","tooltip":"Night Light OFF","class":"disabled"}'
    else
        hyprsunset -t 3500 &
        echo $! > "$PID_FILE"
        echo '{"text":"","tooltip":"Night Light ON","class":"enabled"}'
    fi
    pkill -RTMIN+$WAYBAR_SIGNAL waybar
}

case "$1" in
    --update)
        if [ -f "$PID_FILE" ]; then
            echo '{"text":"","tooltip":"Night Light ON","class":"enabled"}'
        else
            echo '{"text":"","tooltip":"Night Light OFF","class":"disabled"}'
        fi
        ;;
    *)
        toggle
        ;;
esac
