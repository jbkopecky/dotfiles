# Variables
#export TERM=xterm-256color
export EDITOR=vim
export PYTHONPATH="/home/jb/Python/lib"

# TMUX aliases
alias tmux="tmux -2"
alias tml="tmux list-sessions"
alias tma="tmux attach-session"
alias tmc="clear && tmux clear-history"
alias tmk="tmux kill-session"
alias tm="tmux new-session"
alias gc="git commit -m"

# Vim aliases
alias vim="vim --servername VIM"
alias vi="vim"

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

# Notes
alias note="cd ~/Dropbox/Notes && vim +Note"

# Colors
GREEN="\[\e[0;32m\]"
BLUE="\[\e[0;34m\]"
RED="\[\e[0;31m\]"
BRED="\e[1;31m\]"
WHITE="\e[0;37m\]"
BWHITE="\e[1;37m\]"
COLOREND="\[\e[00m\]"

# Useful .. func
..() {
    for i in $(seq $1); do cd ..; done;
}

# Misc
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize

# Colored GCC
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# friendly less
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# FzF

# fd - cd to selected dir
fd() {
    DIR=`find ${1:-.} -type d 2> /dev/null | fzf-tmux` && cd "$DIR"
}

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  local file
  file=$(fzf-tmux --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && ${EDITOR:-vim} "$file"
}

# Equivalent to above, but opens it with `open` command
fo() {
  local file
  file=$(fzf-tmux --query="$1" --select-1 --exit-0)
  [ -n "$file" ] && open "$file"
}

# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf-tmux -m | awk '{print $2}')

  if [ "x$pid" != "x" ]
  then
    kill -${1:-9} $pid
  fi
}




# Responsive Prompt
source ~/.git-prompt.sh
export GIT_PS1_SHOWUPSTREAM="auto"

parse_git_branch() {
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
      branch="${RED}$branch${COLROEND}"
    fi

    if [[ $upstream != "=" ]]; then
      branch="$branch${BLUE}[${COLOREND}${RED}$upstream${COLOREND}${BLUE}]${COLOREND}"
    fi
    echo "$branch "
  fi
}

working_directory() {
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
}

prompt() {
  if [[ $? -eq 0 ]]; then
    exit_status="${BLUE}▸${COLOREND} "
  else
    exit_status="${RED}▸${COLOREND} "
  fi

  PS1="$(working_directory)$(parse_git_branch)$exit_status"
}

PROMPT_COMMAND=prompt

# Plug into Bashrc-Extra
BASE=$(dirname $(readlink $BASH_SOURCE))
EXTRA=$BASE/bashrc-extra
[ -f "$EXTRA" ] && source "$EXTRA"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
