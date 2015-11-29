# Variables ****************************************************************{{{
export EDITOR=vim
export LANG=en_US.UTF-8
DEFAULT_BG="dark"
DEFAULT_COLOR="gruvbox"
# }}}

# Aliases ******************************************************************{{{
# TMUX aliases
alias tmux="tmux -2"
alias tml="tmux list-sessions"
alias tma="tmux attach-session"
alias tmc="clear && tmux clear-history"
alias tmk="tmux kill-session"
alias tm="tmux new-session"

# Vim aliases
alias vim="vim --servername VIM"
alias vi="vim"
alias v="vim"

# Aliases
alias cd.='cd ..'
alias cd..='cd ..'
alias l='ls -CF'
alias ll='ls -alF'
alias la='ls -a'

# Colored ls
if [ -x /usr/bin/dircolors ]; then
  eval "`dircolors -b`"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
fi

# Howdoi
alias how="howdoi -c"

# Useful .. func
..() {
    for i in $(seq $1); do cd ..; done;
}

# The Fuck
alias fuck='eval $(thefuck $(fc -ln -1)); history -r'

# Remove all *.pyc recursively
alias clean='find . -name "*.pyc" -exec rm -rf {} \;'

#}}}

# Misc *********************************************************************{{{
# Colors
GREEN="\[\e[0;32m\]"
BLUE="\[\e[0;34m\]"
RED="\[\e[0;31m\]"
BRED="\e[1;31m\]"
WHITE="\e[0;37m\]"
BWHITE="\e[1;37m\]"
COLOREND="\[\e[00m\]"

# Misc
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize

# Utility function
command_exists() {
      type "$1" &>/dev/null
}

# colors
function colours() {
    for i in {0..255}; do
        printf "\x1b[38;5;${i}m colour${i}"
        if (( $i % 5 == 0 )); then
            printf "\n"
        else
            printf "\t"
        fi
    done
}

# Colored GCC
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# friendly less
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
#}}}

# Color Management *********************************************************{{{

# Must be in XTerm and have installed xtermcontrol to use this hack
if command_exists xtermcontrol ; then

    # Settings are stored in this file to be persistent across bash instances
    CSH=~/.dotfiles/shell/colors/colors.sh
    CXT=~/.dotfiles/shell/colors/colors.xrdb

    # Colorscheme directories
    COL=~/.dotfiles/shell/colors

    colorscheme() { # {{{

        if [ ! -f $CSH ]; then
           echo "COLOR=$DEFAULT_COLOR" >> $CSH
           echo "BG=$DEFAULT_BG" >> $CSH
        fi

        if [ ! -f $CXT ]; then
           echo "#define colors \"/home/jb/.dotfiles/shell/colors/$DEFAULT_COLOR.$DEFAULT_BG.xrdb\"" >> $CXT
        fi

        source $CSH

        if [ ! -f $COL/$1.$BG.sh ]; then
            echo "[Error] $1 colorscheme not found"
            return 1
        else
            sed -i "s/$COLOR/$1/g" $CSH
            sed -i "s/$COLOR/$1/g" $CXT
            xrdb merge  ~/.Xresources
            source $CSH

            export COLOR=$1

            source $COL/$1.$BG.sh

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
        fi
    } # }}}

    background() { # {{{
        source $CSH
        sed -i "s/$BG/$1/g" $CSH
        sed -i "s/$BG/$1/g" $CXT
        xrdb merge  ~/.Xresources
        source $CSH
        export BG=$1
        colorscheme $COLOR
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
            background $BG
        fi
    } # }}}

    alias colo=colorscheme
    alias bg=background

    c_up

fi
# }}}

# Responsive Prompt ********************************************************{{{
# ․ ‣ · ∘ ∙ • ⁕ ↓ → ∆ ∇〈〉《》

source ~/.git-prompt.sh
export GIT_PS1_SHOWUPSTREAM="auto"

parse_git_branch() { # {{{
  git_branch=`__git_ps1 "%s"`

  if [[ $git_branch != "" ]]; then
    branch=`echo $git_branch | sed s/\<//1`
    branch=`echo $branch | sed s/\>//1`
    branch=`echo $branch | sed s/\=//1`
    upstream=`echo $git_branch | sed s/$branch//1`

    if [[ `tput cols` -lt 110 ]]; then
        branch=`echo $branch | sed s/feature/f/1`
        branch=`echo $branch | sed s/hotfix/h/1`
        branch=`echo $branch | sed s/release/\r/1`
        branch=`echo $branch | sed s/master/mstr/1`
        branch=`echo $branch | sed s/develop/dev/1`
    fi

    if [[ $(git status 2> /dev/null | tail -n1) == "nothing to commit, working directory clean" ]]; then
      branch="${GREEN}$branch${COLOREND}"
    else
      branch="${RED}$branch${COLOREND}"
    fi

    if [[ $upstream != "=" ]]; then
      branch="$branch${BLUE}[${COLOREND}${RED}$upstream${COLOREND}${BLUE}]${COLOREND}"
    fi
    echo "$branch "
  fi
} # }}}

working_directory() { # {{{
  dir=`pwd`
  in_home=0

  if [[ `pwd` =~ ^"$HOME"(/|$) ]]; then
    dir="~${dir#$HOME}"
    in_home=1
  fi

  workingdir=""

  if [[ `tput cols` -lt 110 ]]; then

    first="/`echo $dir | cut -d / -f 2`"
    letter=${first:0:2}

    if [[ $in_home == 1 ]]; then
      letter="~$letter"
    fi

    proj=`echo $dir | cut -d / -f 3`
    beginning="$letter/$proj"
    end=`echo "$dir" | rev | cut -d / -f1 | rev`

    if [[ $proj == "" ]]; then
      workingdir="$dir"
    elif [[ $proj == "~" ]]; then
      workingdir="$dir"
    elif [[ $dir =~ "$first/$proj"$ ]]; then
      workingdir="$beginning"
    elif [[ $dir =~ "$first/$proj/$end"$ ]]; then
      workingdir="$beginning/$end"
    else
      workingdir="$beginning/…/$end"
    fi
  else
    workingdir="$dir"
  fi

  echo -e "${GREEN}[${COLOREND}${BLUE}$workingdir${COLOREND}${GREEN}]${COLOREND} "
} # }}}

GREEN="\[\e[0;32m\]"
BLUE="\[\e[0;34m\]"
RED="\[\e[0;31m\]"
BRED="\e[1;31m\]"
WHITE="\e[0;37m\]"
BWHITE="\e[1;37m\]"
COLOREND="\[\e[00m\]"

prompt() {
  if [[ $? -eq 0 ]]; then
    exit_status="${BLUE}〉${COLOREND} "
  else
    exit_status="${RED}〉${COLOREND} "
  fi

  PS1="$(working_directory)$(parse_git_branch)$exit_status"
}

PROMPT_COMMAND=prompt

# }}}

# Source *******************************************************************{{{
# Plug into Bashrc-Extra
EXTRA=~/.local.bashrc
[ -f "$EXTRA" ] && source "$EXTRA"

source ~/Bin/hyperjump
# }}}
