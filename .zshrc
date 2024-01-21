export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration
#
alias ll="exa -la -g --icons"
alias ll2="exa -la -g --icons --tree --level=2"

eval "$(starship init zsh)"
eval "$(zoxide init bash)"
