# If you come from bash you might have to change your $PATH.
export PATH=/usr/local/bin:$HOME/bin:$HOME/Library/Python/3.7/bin:$PATH
ZSH_DISABLE_COMPFIX="true"

######## MAURICE CUSTOM ######## 
# Exporting path to llvm bin so that we use homebrew's clang and not Apple's wack af clang
export PATH=$PATH:/usr/local/opt/llvm/bin

# Have to unset AWS creds because I do not know where tmux is sourcing them from.. may have something to do with my local perms being messed up
unset AWS_SECRET_ACCESS_KEY
unset AWS_ACCESS_KEY_ID

# Go
export GOPATH=~/Projects/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin

# Python
alias vrun="source bin/activate"
alias grun="source ~/bin/activate"
alias cenv="virtualenv -p python3 ."
alias cenv2="virtualenv -p python2 ."

# Terraform
alias tf="terragrunt"

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
alias gdu="git push --set-upstream origin "
alias glatest="git for-each-ref --sort=committerdate refs/heads/ | sed 's/.*heads\///'"

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
alias vertwrld="python3 ~/Projects/Personal/VertWorldOccupancy/occupancy.py"

# Iterm Colors 
export LS_COLORS="no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=1;31:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.tsx=01;35:*.js=01;35:*.go=32" # Custom .tsx, .js and .go

# neovim editor 
export EDITOR="nvim"
alias n="nvim"

# VPN
alias openvpn="sudo /usr/local/opt/openvpn/sbin/openvpn" # opt/openvpn/sbin/openvpn not in path
alias vpndev="openvpn --config ~/.openvpn/dev-us-west-2-humanoid.ovpn --cert ~/.openvpn/keys_dev/dev-us-west-2-cert-humanoid.crt --key ~/.openvpn/keys_dev/dev-us-west-2-key-humanoid.key" # gig specific 

# Solana :(
export PATH="/Users/mauricebutts/.local/share/solana/install/active_release/bin:$PATH"

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/mauricebutts/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/mauricebutts/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/mauricebutts/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/mauricebutts/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
