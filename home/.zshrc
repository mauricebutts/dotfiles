# If you come from bash you might have to change your $PATH.
export PATH=/usr/local/bin:$HOME/bin:$HOME/Library/Python/3.7/bin:$PATH
ZSH_DISABLE_COMPFIX="true"

######## MAURICE CUSTOM ######## 
# VAULT
alias vrefresh="vault login -method=github token=$VAULT_AUTH_GITHUB_TOKEN"

# Have to unset AWS creds because I do not know where tmux is sourcing them from.. may have something to do with my local perms being messed up
unset AWS_SECRET_ACCESS_KEY
unset AWS_ACCESS_KEY_ID

# Go
export GO111MODULE=on;
export GOPATH=~/Projects/go
export PATH=$PATH:$GOPATH/bin

# Python
alias vrun="source bin/activate"
alias grun="source ~/bin/activate"
alias cenv="virtualenv -p python3 ."
alias cenv2="virtualenv -p python2 ."

# Util - general
alias cdate="python3 ~/Util/iso_date_range_to_epoch.py"
alias bsource="source ~/.bash_profile"
alias tsource="tmux source ~/.tmux.conf"
alias zsource="source ~/.zshrc"
alias refresh="~/Util/refresh.sh"
alias qg="~/Util/quick_grep.sh"
alias svt="source ~/Util/set_vault_token_bro.sh"
alias ts="python3 ~/Util/ts_to_date.py"

# git 
alias gignore="~/Util/git_ignore.sh"
alias gs="printf \"\n\" && rg --column --line-number --hidden --ignore-case --no-heading --color=always TODO && printf \"\n\" && git status"
alias gd="git diff"

# Util - editor 
alias devtime="~/Util/devtime.sh"
alias devout="~/Util/devout.sh"
alias gotime="~/Util/gotime.sh"
alias qatime="~/Util/qatime.sh"
alias gotux="~/Util/gotux.sh"
alias goqa="~/Util/goqa.sh"
alias ctxt="~/Util/context.sh"
alias devsave="~/Util/devsave.sh"
alias devload="~/Util/devload.sh"

# Iterm Colors 
export LS_COLORS="Bxfacadagaegedabagacad" 

# neovim editor 
export EDITOR="nvim"
alias n="nvim"

##############################

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# Bira, s'pretty good
# ZSH_THEME="bira"

# blinks
ZSH_THEME="blinks"


# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  bundler
  dotenv
  osx
  golang
)

source $ZSH/oh-my-zsh.sh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
