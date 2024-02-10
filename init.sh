#!/bin/bash

read -p "Do you want to symlink gitconfig? It will delete your current .gitconfig (y/n) " choice

case "$choice" in
  y|Y )
    read -p "Please enter your email: " email
    read -p "Please enter your name: " name
    cp .gitconfig_template .gitconfig
    sed "s/MyEmail/$email/g" .gitconfig > .gitconfig_temp
    sed "s/MyName/$name/g" .gitconfig_temp > .gitconfig
    rm .gitconfig_temp
    rm ~/.gitconfig
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

read -p "Do you want to symlink .zshrc config? It will delete your current .zshrc (y/n) " choice

case "$choice" in
  y|Y )
    rm ~/.zshrc
    ln -s $PWD/.zshrc ~/.zshrc
    echo ".zshrc has been symlinked"
    ;;
  n|N ) echo "Skipped." ;;
  
  * ) echo "Invalid input." ;;
esac

read -p "Do you want to symlink ranger config? It will delete your current ranger config (y/n) " choice

case "$choice" in
  y|Y )
    rm -rf ~/.config/ranger
    ln -s $PWD/ranger ~/.config/ranger
    echo "Ranger config has been symlinked"
    ;;
  n|N ) echo "Skipped." ;;
  
  * ) echo "Invalid input." ;;
esac

read -p "Do you want to symlink kitty config? It will delete your current kitty config (y/n) " choice

case "$choice" in
  y|Y )
    rm -rf ~/.config/kitty
    ln -s $PWD/kitty ~/.config/kitty
    echo "Kitty config has been symlinked"
    ;;
  n|N ) echo "Skipped." ;;
  
  * ) echo "Invalid input." ;;
esac
