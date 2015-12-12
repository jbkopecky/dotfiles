# Colorscheme directories
COL=.dotfiles/shell/colors
TCOL=.tmux/colors

# Settings are stored in this file to be persistent across bash instances
CSH=$HOME/$COL/colors.sh

# Utility function
command_exists() { # {{{
      type "$1" &>/dev/null
} # }}}

if command_exists xtermcontrol ; then

    update_tmux_colors() { # {{{
        local tmux_c=$1.$2.conf
        if [ -f $HOME/$TCOL/$tmux_c ]; then
            ln -sf $HOME/$TCOL/$tmux_c ~/.tmux-updated-colors.conf
        fi
        if [ -n "$TMUX" ]; then
            tmux source-file ~/.tmux-updated-colors.conf &> /dev/null
        fi
    } # }}}

    update_fzf_colors()  { # {{{
        local FZF_OPTS=$FZF_DEFAULT_OPTS
        local FZF_NEW_OPTS=""
        for opt in $FZF_OPTS; do
            if [ $opt == *"--color="* ]; then
                echo "colors"
            fi
        done

    } # }}}

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

            update_tmux_colors $1 $BG

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

    _background() { # {{{
        local cur prev opts
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        prev="${COMP_WORDS[COMP_CWORD-1]}"
        opts="dark light"
        COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
    } # }}}

    _colorscheme() { # {{{
        local cur prev opts
        COMPREPLY=()
        cur="${COMP_WORDS[COMP_CWORD]}"
        prev="${COMP_WORDS[COMP_CWORD-1]}"

        opts=$(for x in $(find $HOME/$COL/ -type f \( -name "*.dark.sh" -or -name "*.light.sh" \)); do basename $x | cut -f 1 -d. ;done | uniq)

        COMPREPLY=( $(compgen -W "${opts}" -- "${cur}") )
    } # }}}

    alias colo=colorscheme
    alias bg=background

    complete -F _colorscheme colorscheme
    complete -F _background background
    complete -F _colorscheme colo
    complete -F _background bg

    # Update Colors
    c_up

fi
