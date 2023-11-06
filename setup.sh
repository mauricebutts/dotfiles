# Get homebrew going
xcode-select --install
sudo /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

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

##### Golang #####
brew install go

##### Python #####
brew install python3
python3 -m pip install --user virtualenv
# TODO: Figure out how to get virtualenv to work! 

##### iterm2 #####
brew install iterm2 --cask

##### Install zsh and oh-my-zsh #####
brew install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

##### tmux #####
brew install tmux
go get -u github.com/arl/gitmux

##### other brew installs #####
brew install fzf
brew install ripgrep
brew install fd
brew install jq
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
brew install docker
brew install npm
brew install --cask slack

#### Keyboard Repeat ####
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
# if you're using the new arm64 chips, need to do this as well...
if [[ $(uname -m) == 'arm64' ]]; then
  echo "Running M1 chip stuff!"
  defaults write -g ApplePressAndHoldEnabled -bool false
fi


##### NeoVim #####
brew install neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +UpdateremotePlugins +GoInstallBinaries +qall

# For Golang LangServer
go install golang.org/x/tools/gopls@latest

# typescript LangServer
npm install -g typescript typescript-language-server

# goimports tool
go get golang.org/x/tools/cmd/goimports


# fonts 
cp -R fonts/. /Library/Fonts

#TODO Add args for scripts to point to other language configurations. For example Java configuration. Needed installs, .zshrc changes, and nvim/init.vim file changes
#TODO: Script move .files over
#TODO: Move iterm json profile over
#TODO: Set iterm profile to default
#TODO: Install fonts and set iterm font to hacker mono regular 18 size

echo "install postgres client? y/n"
read INSTALL_PSQL

if [[ "$INSTALL_PSQL" == "y" ]]
then
  echo "Installing postgres..."
  brew install postgresql
  echo "postgres installed"
fi
