#!/bin/sh

# source .xresources
xrdb -merge ~/.Xresources
xrdb -merge ~/.scripts/colors/output/colors.Xresources

# Disable caps lock
setxkbmap -option ctrl:nocaps
setxkbmap -option caps:none


# Set up multi mon
xrandr --newmode "1920x1080" 173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync +vsync
xrandr --addmode Virtual1 1920x1080
xrandr --output Virtual1 --mode 1920x1080

# Set wallpaper
wallpaper &

# urxvt daemon
urxvtd -q -f -o &

# bar
bar &

# mpd
mpd &

# Pulseaudio
pulseaudio --start &

# Devmon
# udiskie &

#  Start openbox
exec openbox-session

