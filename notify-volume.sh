#!/usr/bin/env bash

# Disgracefully vibe-coded by Gemini AI

# 1. Apply volume or mute changes
if [ "$1" = "mute" ]; then
    pactl set-sink-mute @DEFAULT_SINK@ toggle
elif [ -n "$1" ]; then
    pactl set-sink-volume @DEFAULT_SINK@ $1%
    # Clamp volume to 100% if it exceeds the limit
    check_vol=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n 1)
    if [ "$check_vol" -gt 100 ]; then
        pactl set-sink-volume @DEFAULT_SINK@ 100%
    fi
fi

# 2. Get updated volume and mute status AFTER clamping
volume=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+(?=%)' | head -n 1)
is_muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -o "yes")

# 3. Send notification with progress bar hint
if [ "$is_muted" = "yes" ]; then
    dunstify -t 2000 -r 1001 -h int:value:0 "🔇 Muted"
else
    dunstify -t 2000 -r 1001 -h int:value:"$volume" "🔊 Volume: ${volume}%"
fi
