# Get homebrew going
xcode-select --install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

##### Create Dirs #####
mkdir -p ~/Scripts
mkdir -p ~/Notes
mkdir -p ~/Projects
mkdir -p ~/Projects/Personal
mkdir -p ~/Projects/go
mkdir -p ~/Projects/go/src
mkdir -p ~/Projects/go/pkg
mkdir -p ~/Projects/go/bin

##### Run Installs #####

# Golang
curl -o golang.pkg https://dl.google.com/go/go1.14.2.darwin-amd64.pkg
sudo open golang.pkg

# Python
brew install python3
python3 -m pip install --user virtualenv
# TODO: Figure out how to get virtualenv to work! 

brew cask install iterm2
# Install zsh and oh-my-zsh
brew install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# tmux
brew install tmux
go get -u github.com/arl/gitmux

brew install fzf
brew install ripgrep
brew install jq

# NeoVim
brew install neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +UpdateremotePlugins +GoInstallBinaries +qall

defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

#TODO: Script move .files over
