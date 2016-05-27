#!/bin/sh

graphics() {
	if [[ -f ~/.Xresources ]]; then
	    xrdb -merge ~/.Xresources
	fi

	if [[ $(hostname) = "archie" ]]; then
		xset fp+ /usr/share/fonts/envypn
		xset -b
		xrandr --newmode "1920x1080" 173.00 1920 2048 2248 2576 1080 1083 1088 1120 -hsync +vsync
		xrandr --addmode Virtual1 1920x1080
		xrandr --output Virtual1 --mode 1920x1080
	else
		xrdb -merge ~/.Xresources
	    # xrandr --output DVI-I-1 --mode 1920x1080 --rate 144
	fi
	xsetroot -cursor_name left_ptr
    wall.sh
}

env() {
	# extra ctrl key
	setxkbmap -option ctrl:nocaps
	sxhkd &
}
run() {
	exec bspwm
}
graphics
env
run
