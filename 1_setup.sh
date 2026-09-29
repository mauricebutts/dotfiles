# Get homebrew going
# xcode-select --install # assuming user is required to install this to use git
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Set brew path for this script. Assumes using Apple Silicon
BREW_PATH="/opt/homebrew/bin/brew"

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
$BREW_PATH install go

##### Python #####
$BREW_PATH install python3
python3 -m pip install --user virtualenv
# TODO: Figure out how to get virtualenv to work! 

##### iterm2 #####
$BREW_PATH install iterm2 --cask

##### Install zsh and oh-my-zsh #####
$BREW_PATH install zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

##### tmux #####
$BREW_PATH install tmux
go get -u github.com/arl/gitmux

##### other brew installs #####
$BREW_PATH install fzf
$BREW_PATH install ripgrep
$BREW_PATH install fd
$BREW_PATH install jq
$BREW_PATH install cmake # needed to build telescope-fzf-native.nvim plug
$BREW_PATH install tree-sitter-cli # needed by nvim-treesitter to compile parsers
$BREW_PATH tap homebrew/cask-fonts
$BREW_PATH install --cask font-hack-nerd-font
$BREW_PATH install docker
$BREW_PATH install npm
$BREW_PATH install yarn # yuck, dep needed for plug prettier
$BREW_PATH install --cask slack
$BREW_PATH install --cask claude-code


#### Keyboard Repeat ####
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
# if you're using the new arm64 chips, need to do this as well...
if [[ $(uname -m) == 'arm64' ]]; then
  echo "Running apple silicon stuff!"
  defaults write -g ApplePressAndHoldEnabled -bool false
fi


##### NeoVim #####
$BREW_PATH install neovim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
# Note: plugin installation happens in 3_nvim_plugins.sh, which must run
# after 2_home.sh has copied init.vim into place.

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
  $BREW_PATH install postgresql
  echo "postgres installed"
fi
