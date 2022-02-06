#!/usr/bin/env bash

SOCKET=$(ls /run/user/1000/sway-ipc.* | head -n 1)
FILE=$(find "$HOME/.wallpapers" -type f | sort -R | tail -$N | grep -m1 "") 
swaymsg -s $SOCKET "output * bg ${FILE} fill"
