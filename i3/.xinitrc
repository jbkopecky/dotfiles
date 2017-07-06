#!/bin/sh
setx b off
compton &
xrdb -merge ~/.Xresources
urxvtd -q -f -o &
pulseaudio --start &
mpd &
udiskie &
dunst &
exec i3
