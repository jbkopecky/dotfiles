#!/bin/bash

# RC files
cd $(dirname $BASH_SOURCE)
BASE=$(pwd)
touch bashrc-extra
for rc in *rc *profile tmux.conf; do
  mkdir -pv bak
  [ -e ~/.$rc ] && mv -v ~/.$rc bak/.$rc
  ln -sfv $BASE/$rc ~/.$rc
done

tmux source-file ~/.tmux.conf
ln -sfv $BASE/tmuxinator .tmuxinator
ln -sfv $BASE/vim .vim

# git-prompt
if [ ! -e ~/.git-prompt.sh ]; then
  curl https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh \
    -o ~/.git-prompt.sh
fi
git config --global user.email "jb.kopecky@gmail.com"
git config --global user.name "jbkopecky"

vim +PlugInstall +qall