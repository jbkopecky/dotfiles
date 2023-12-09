#!/bin/sh
# xsetroot -cursor_name left_ptr
# setxkbmap -option ctrl:nocaps

xrdb -merge ~/.Xresources

# pulseaudio --start &
urxvtd -q -f &

exec openbox
