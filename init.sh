#!/bin/bash

read -p "Do you want to symlink gitconfig? It will delete your current .gitconfig (y/n) " choice

case "$choice" in
  y|Y )
    read -p "Please enter your email: " email
    read -p "Please enter your name: " name
    cp .gitconfig_template .gitconfig
    sed -i '' "s/MyEmail/$email/g" .gitconfig
    sed -i '' "s/MyName/$name/g" .gitconfig
    rm -rf ~/.gitconfig
    ln -s $PWD/.gitconfig ~/.gitconfig 
    echo "Gitconfig has been symlinked"
    ;;
  n|N ) echo "Skipped." ;;
  
  * ) echo "Invalid input." ;;
esac

read -p "Do you want to symlink .tmux.conf? It will delete your current .tmux.conf (y/n) " choice

case "$choice" in
  y|Y )
    rm -rf ~/.tmux.conf
    ln -s $PWD/.tmux.conf ~/.tmux.conf
    echo ".tmux.conf has been symlinked"
    ;;
  n|N ) echo "Skipped." ;;
  
  * ) echo "Invalid input." ;;
esac

read -p "Do you want to symlink NvChad custom config? It will delete your current custom config (y/n) " choice

case "$choice" in
  y|Y )
    rm -rf ~/.config/nvim/lua/custom
    ln -s $PWD/nvchad_custom ~/.config/nvim/lua/custom
    echo "NvChad custom config has been symlinked"
    ;;
  n|N ) echo "Skipped." ;;
  
  * ) echo "Invalid input." ;;
esac
