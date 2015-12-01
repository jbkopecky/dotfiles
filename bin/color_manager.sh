# Colorscheme directories
COL=.dotfiles/shell/colors

# Settings are stored in this file to be persistent across bash instances
CSH=$HOME/$COL/colors.sh

colorscheme() { # {{{

    if [ ! -f $CSH ]; then
        echo "COLOR=$DEFAULT_COLOR" >> $CSH
        echo "BG=$DEFAULT_BG" >> $CSH
    fi

    source $CSH

    if [ ! -f $HOME/$COL/$1.$BG.sh ]; then
        echo "[Error] $1 colorscheme not found"
        return 1
    else
        sed -i "s/$COLOR/$1/g" $CSH

        source $CSH

        export COLOR=$1

        source $HOME/$COL/$1.$BG.sh

        # TODO: find a way to do this in loop
        export TERM="xterm-256color"
        xtermcontrol --bg=$bg # {{{
        xtermcontrol --fg=$fg
        xtermcontrol --color0=$color0 --color1=$color8
        xtermcontrol --color1=$color1 --color2=$color9
        xtermcontrol --color2=$color2 --color10=$color10
        xtermcontrol --color3=$color3 --color11=$color11
        xtermcontrol --color4=$color4 --color12=$color12
        xtermcontrol --color5=$color5 --color13=$color13
        xtermcontrol --color6=$color6 --color14=$color14
        xtermcontrol --color7=$color7 --color15=$color15
        export TERM="screen-256color"
        # }}}
        return 0
    fi
} # }}}

background() { # {{{

    if  [[ ! ( ("$1" == "dark") || ("$1" == "light") ) ]]; then
        echo "[ERROR] Background must be either dark or light"
        return 1
    else

        if [ ! -f $CSH ]; then
        echo "COLOR=$DEFAULT_COLOR" >> $CSH
        echo "BG=$DEFAULT_BG" >> $CSH
        fi

        source $CSH

        if [ ! -f $HOME/$COL/$COLOR.$1.sh ]; then
            echo "[Error] $COLOR.$1 colorscheme not found"
            return 1
        else

            sed -i "s/$BG/$1/g" $CSH

            source $CSH

            export BG=$1

            colorscheme $COLOR

            return 0
        fi
    fi
} # }}}

c_up() { # {{{
    if [ -f $CSH ]; then
        source $CSH
        export $COLOR
        export $BG
        colorscheme $COLOR
        background $BG
    else
        colorscheme $DEFAULT_COLOR
        background $DEFAULT_BG
    fi
} # }}}

