# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/$(whoami)/.oh-my-zsh"
export UPDATE_ZSH_DAYS=13

ZSH_THEME="agnoster"
COMPLETION_WAITING_DOTS="true"
CASE_SENSITIVE="true"
DISABLE_AUTO_TITLE="false"
ENABLE_CORRECTION="false"

plugins=(
  adb alias-finder aws command-not-found common-aliases compleat cp docker docker-compose emoji gatsby gitignore history kubectl minikube npm python yarn colored-man-pages colorize dircycle dirhistory git screen sudo wd zsh-navigation-tools node nvm ubuntu virtualenv vscode
)

source $ZSH/oh-my-zsh.sh

export LANG=en_US.UTF-8

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nano'
else
  export EDITOR='code'
fi

export SSH_KEY_PATH='~/.ssh/rsa_id';
export ARCHFLAGS="-arch x86_64";

alias zshconfig="code ~/.zshrc";
alias ..="cd ..";

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
