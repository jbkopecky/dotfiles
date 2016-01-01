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

if ! command_exists pacman; then
  echo "This istaller is only comaptible with Arch based Linux distributrions."
  echo "Please install configuration files manually."
  exit
fi

if ! command_exists curl; then
  sudo pacman -S curl
fi

if ! command_exists git; then
  sudo pacman -S git
fi

if ! command_exists wget; then
  sudo pacman -S wget
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
    sudo pacman -S tmux
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

if [ ! -f ~/.tmux-default-colors.conf ]; then
    echo -n "[ tmux ]        "
    echo "    Creating Default Tmux status line !"
    ln -sf ~/.tmux/colors/gruvbox.dark.conf ~/.tmux-default-colors.conf
fi

if [ ! -f ~/.tmux-updated-colors.conf ]; then
    echo -n "[ tmux ]        "
    echo "    Creating Updated Tmux status line !"
    ln -sf ~/.tmux/colors/seoul256.dark.conf ~/.tmux-updated-colors.conf
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
  sudo pacman -S xterm
fi

if ! command_exists xtermcontrol; then
  sudo pacman -S xtermcontrol 
fi

if [ ! -f ~/.Xresources ]; then
    echo "   Creating Xresources!"
    ln -sf $current_path/Xresources ~/.Xresources
    if command_exists xrdb; then
        xrdb -merge  ~/.Xresources
    fi
elif $REPLACE_FILES; then
    echo "   Replacing old Xresources!"
    mv ~/.Xresources $current_path/bak/
    ln -sf $current_path/Xresources ~/.Xresources
    if command_exists xrdb; then
        xrdb -merge  ~/.Xresources
    fi
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
elif  $REPLACE_FILES; then
    echo "    Replacing old Bin!"
    (cd ~/Bin && tar c .) | (cd $current_path/bak && tar xf -)
    cd $current_path
    rm -rf ~/Bin
    mkdir ~/Bin
else
    echo "    Keeping existing Bin!"
fi

for bin in $current_path/bin/*; do
    echo -n "[ Bin ]         "
    file=${bin##*/}
    if [ ! -f ~/Bin/$file ]; then
        ln -sf $bin ~/Bin/$file
        echo "    Linking Missing $file"
    elif $REPLACE_FILES; then
        echo "    Replacing $file !"
        mv ~/Bin/$file $current_path/bak/
        ln -sf $bin ~/Bin/$file
    else
        echo "    Keeping $file"
    fi
done
# }}}

