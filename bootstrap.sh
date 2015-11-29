#!/bin/bash
#==============================================================================
#
#                           My Dotfiles Installer
#                           =====================
#
#                        github.com/jbkopecky/dotfiles
#
#==============================================================================

# Replace Existing Files
REPLACE_FILES=false

# Functions and variables ************************************************* {{{
#==============================================================================

# Stop on error
set -e

current_path=$(pwd)

command_exists() {
      type "$1" &>/dev/null
}

# }}}

# Basic requirements check ************************************************ {{{
#==============================================================================

if ! command_exists apt-get; then
  echo "This istaller is only comaptible with debian/ubuntu based Linux distributrions."
  echo "Please install configuration files manually."
  exit
fi

if ! command_exists curl; then
  sudo apt-get install -y curl
fi

if ! command_exists git; then
  sudo apt-get install -y git
fi

if ! command_exists wget; then
  sudo apt-get install -y wget
fi

# }}}

# Backup Folder *********************************************************** {{{
#==============================================================================

if [ ! -d $current_path/bak ]; then
    mkdir $current_path/bak
fi

# }}}

# Git ********************************************************************* {{{
#==============================================================================

echo -n "[ gitconfig ]   "

if [ ! -f ~/.gitconfig ]; then
  echo "    Creating gitconfig!"
  ln -sf $current_path/gitconfig ~/.gitconfig
elif $REPLACE_FILES; then
  echo "    Replacing old gitconfig!"
  mv  ~/.gitconfig $current_path/bak/
  ln -sf $current_path/gitconfig ~/.gitconfig
else
  echo "    Keeping existing gitconfig!"
fi

# git-prompt
if [ ! -e ~/.git-prompt.sh ]; then
  echo -n "[ gitconfig ]   "
  echo "    Installing git-prompt..."
  wget https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh \
      -O ~/.git-prompt.sh
fi

# }}}

# Bashrc ****************************************************************** {{{
#==============================================================================

echo -n "[ bashrc ]      "

if [ ! -f ~/.bashrc ]; then
  echo "    Creating bashrc!"
  ln -sf $current_path/bashrc ~/.bashrc
elif $REPLACE_FILES; then
  echo "    Replacing old bashrc!"
  mv  ~/.bashrc $current_path/bak/
  ln -sf $current_path/bashrc ~/.bashrc
else
  echo "    Keeping existing bashrc!"
fi

echo -n "[ bash_profile ]"

if [ ! -f ~/.bash_profile ]; then
  echo "    Creating bash_profile!"
  ln -sf $current_path/bash_profile ~/.bash_profile
elif $REPLACE_FILES; then
  echo "    Replacing old bash_profile!"
  mv  ~/.bash_profile $current_path/bak/
  ln -sf $current_path/bash_profile ~/.bash_profile
else
  echo "    Keeping existing bash_profile!"
fi

# }}}

# Tmux ******************************************************************** {{{
#==============================================================================

echo -n "[ tmux.conf ]   "

if ! command_exists tmux; then
    sudo apt-get install tmux -y
fi

if [ ! -f ~/.tmux.conf ]; then
    echo "    Creating tmux.conf!"
    ln -sf $current_path/tmux.conf ~/.tmux.conf
elif $REPLACE_FILES; then
    echo "    Replacing old tmux.conf!"
    mv  ~/.tmux.conf $current_path/bak/
    ln -sf $current_path/tmux.conf ~/.tmux.conf
else
    echo "    Keeping existing tmux.conf!"
fi

echo -n "[ tmux ]        "

if [ ! -d ~/.tmux ]; then
    echo "    Creating tmux folder"
    ln -sf $current_path/tmux ~/.tmux
elif $REPLACE_FILES; then
    echo "    Replacing old tmux folder"
    mv  ~/.tmux $current_path/bak/
    ln -sf $current_path/tmux ~/.tmux
else
    echo "    Keeping existing tmux folder!"
fi

# tpm
if [ ! -e ~/.tmux/plugins/tpm ]; then
    echo -n "[ tmux ]        "
    echo "    Installing Tmux Plugin Manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# }}}

# Vim ********************************************************************* {{{
#==============================================================================

echo -n "[ vimrc ]       "

if [ ! -f ~/.vimrc ]; then
    echo "    Creating vimrc!"
    ln -sf $current_path/vimrc ~/.vimrc
elif $REPLACE_FILES; then
    echo "    Replacing old vimrc!"
    mv  ~/.vimrc $current_path/bak/
    ln -sf $current_path/vimrc ~/.vimrc
else
    echo "    Keeping existing vimrc!"
fi

echo -n "[ gvimrc ]      "

if [ ! -f ~/.gvimrc ]; then
    echo "    Creating gvimrc!"
    ln -sf $current_path/gvimrc ~/.gvimrc
elif $REPLACE_FILES; then
    echo "    Replacing old gvimrc!"
    mv  ~/.gvimrc $current_path/bak/
    ln -sf $current_path/gvimrc ~/.gvimrc
else
    echo "    Keeping existing gvimrc!"
fi

echo -n "[ vim ]         "

if [ ! -d ~/.vim ]; then
    echo "    Creating vim folder!"
    ln -sf $current_path/vim ~/.vim
elif $REPLACE_FILES; then
    echo "    Replacing old vim folder!"
    mv  ~/.vim $current_path/bak/
    ln -sf $current_path/vim ~/.vim
else
    echo "    Keeping existing vimrc!"
fi

if [ ! -d ~/.vim/backups ]; then
    mkdir ~/.vim/backups
fi

if [ ! -d ~/.vim/undo ]; then
    mkdir ~/.vim/undo
fi

if [ ! -d ~/.vim/swaps ]; then
    mkdir ~/.vim/swaps
fi

if [ ! -d ~/.vim/info ]; then
    mkdir ~/.vim/info
fi

# }}}

# Xresources ************************************************************** {{{
#==============================================================================

echo -n "[ Xresources ]   "

if ! command_exists xterm; then
  sudo apt-get install xterm -y
fi

if ! command_exists xtermcontrol; then
  sudo apt-get install xtermcontrol -y
fi

if [ ! -f ~/.Xresources ]; then
    echo "   Creating Xresources!"
    ln -sf $current_path/Xresources ~/.Xresources
    xrdb -merge  ~/.Xresources
elif $REPLACE_FILES; then
    echo "   Replacing old Xresources!"
    mv ~/.Xresources $current_path/bak/
    ln -sf $current_path/Xresources ~/.Xresources
    xrdb -merge  ~/.Xresources
else
    echo "   Keeping existing Xresources!"
fi

# }}}

# Misc ******************************************************************** {{{
#==============================================================================
echo -n "[ Bin ]         "
if [ ! -d ~/Bin ]; then
    echo "    Creating Bin!"
    mkdir ~/Bin
    for bin in $current_path/bin/*; do
        ln -sf $bin ~/Bin
    done
elif  $REPLACE_FILES; then
    echo "    Replacing old Bin!"
    (cd ~/Bin && tar c .) | (cd $current_path/bak && tar xf -)
    cd $current_path
    rm -rf ~/Bin
    mkdir ~/Bin
    for bin in $current_path/bin/*; do
        ln -sf $bin ~/Bin
    done
else
    echo "    Keeping existing Bin!"
fi
# }}}

