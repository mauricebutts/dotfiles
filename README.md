# dotfiles

Spin-up scripts for a fresh macOS machine (Apple Silicon): installs Homebrew
and core CLI/dev tooling (git, go, python, tmux, neovim, etc.), copies
dotfiles and Neovim config into place, installs all Neovim plugins
headlessly, and installs/configures a custom iTerm2 profile with a Nerd Font.

## Before you start

1. Install developer tools
   - `xcode-select --install`
2. Cut a new GitHub SSH key for this machine
   - `ssh-keygen -t ed25519 -C "mbutts@qventus.com"`
   - `pbcopy < ~/.ssh/id_ed25519.pub`
   - Add it at https://github.com/settings/keys

## Install

Run in order:

```sh
./1_setup.sh          # Homebrew + tools, fonts, neovim/vim-plug bootstrap
./2_home.sh           # copies home/ into $HOME (backs up anything it'd overwrite)
./3_nvim_plugins.sh   # headless :PlugInstall now that init.vim is in place
./4_iterm.sh          # installs the iTerm2 profile(s) as Dynamic Profiles
```

Then restart the machine — this lets the key repeat rate change from
`1_setup.sh` take effect, and lets the terminal pick up the new `.zshrc`.
