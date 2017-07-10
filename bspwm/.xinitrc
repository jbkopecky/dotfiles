#!/bin/sh
setx b off
xsetroot -cursor_name left_ptr
xrdb -merge ~/.Xresources
urxvtd -q -f -o &
pulseaudio --start &
mpd &
udiskie &
dunst &
sxkhd &
exec bspwm
