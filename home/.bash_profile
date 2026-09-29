export PATH=$PATH:$(go env GOPATH)/bin
# Python
alias vrun="source bin/activate"
alias cenv="virtualenv -p python3 ."

# Util
alias cdate="python3 ~/Util/iso_date_range_to_epoch.py"
alias bsource="source ~/.bash_profile"
alias tsource="tmux source ~/.tmux.conf"
alias devtime="~/Util/devtime.sh"
alias devout="~/Util/devout.sh"
alias refresh="~/Util/refresh.sh"

# Iterm Colors 
export LSCOLORS="Bxfacadagaegedabagacad" 
alias ls='ls -lGH'

# neovim editor 
export EDITOR="nvim"
alias n="nvim"

export PATH="/Users/mauricebutts/.local/share/solana/install/active_release/bin:$PATH"
