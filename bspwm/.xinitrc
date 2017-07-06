#!/bin/sh
setx b off
xrdb -merge ~/.Xresources
urxvtd -q -f -o &
pulseaudio --start &
mpd &
udiskie &
dunst &
sxkhd &
exec bspwm
