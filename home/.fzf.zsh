# Setup fzf
# ---------
# Uses fzf's own --zsh integration (completion + key-bindings + PATH) instead
# of hardcoding a path, so this works regardless of user/install location.
command -v fzf > /dev/null 2>&1 && source <(fzf --zsh)
