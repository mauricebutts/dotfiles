HOMEDIR=$1
# Get homebrew going
xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Run Installs
brew cask install iterm2
brew install zsh
# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
brew install tmux
brew install fzf
brew install ripgrep
brew install jq

# Python
brew install python3
python3 -m pip install --user virtualenv

# FIGURE OUT HOW TO GET VIRTUALENV TO WORK! 

# NeoVim
brew install neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +UpdateremotePlugins +GoInstallBinaries +qall

defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)


# Move files over
