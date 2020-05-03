# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/maurice/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/maurice/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/maurice/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/maurice/.fzf/shell/key-bindings.bash"
