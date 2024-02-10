# Clone antidote if necessary.
[[ -e ${ZDOTDIR:-~}/.antidote ]] ||
  git clone https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
#TYPO CORRECTION
unsetopt correct_all

# Source antidote.
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

# Initialize antidote's dynamic mode, which changes `antidote bundle`
# from static mode.
source <(antidote init)

antidote bundle zsh-users/zsh-autosuggestions
antidote bundle zsh-users/zsh-syntax-highlighting

#HISTORY
HISTFILE=~/.zsh_history
SAVEHIST=10000
setopt inc_append_history
setopt share_history

alias v="nvim"
alias vi="nvim"
alias vim="nvim"

alias ls="exa -la -g --icons"
alias ls2="exa -la -g --icons --tree --level=2"

alias zshconfig="vim ~/.zshrc"
alias nvimconfig="vim ~/.config/nvim"
alias tmuxconfig="vim ~/.tmux.conf"
alias kconfig="vim ~/.config/kitty/kitty.conf"

alias gs="git status"
alias gf="git fetch"
alias gcm="git commit"
alias ga="git add ."
alias gl="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"
alias gb="git branch"
alias gc="git checkout"
alias gp="git push"
alias gpl="git pull"

eval "$(starship init zsh)"
eval "$(zoxide init bash)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

if [[ "$(uname)" == "Linux" ]]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi
