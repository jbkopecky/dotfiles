# Variables
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

# Responsive Prompt
source ~/.vim/divers/.git-prompt.sh
export GIT_PS1_SHOWUPSTREAM="auto"

#git_showupstream() {
  #branch=`__git_ps1 "%s"`
  #branch=`echo $branch | sed s/feature//1`
  #branch=`echo $branch | sed s/hotfix//1`
  #branch=`echo $branch | sed s/release//1`
  #branch=`echo $branch | sed s/master//1`
  #branch=`echo $branch | sed s/develop//1`
  #if [[ $branch != "" ]]; then
    #if [[ $branch == "=" ]]; then
        #echo " "
    #else
        #echo "${BLUE}[${COLOREND}${RED}$branch${COLOREND}${BLUE}]${COLOREND}"
    #fi
  #fi
#}

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
