#!/bin/sh
xrdb -merge ~/.Xresources
setx b off
urxvtd -q -f -o &
pulseaudio --start &
compton &
udiskie &
dunst &
mopidy &
exec i3
